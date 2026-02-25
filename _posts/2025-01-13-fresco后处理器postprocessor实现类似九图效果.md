---
title: "Fresco后处理器Postprocessor实现类似九图效果"
date: 2025-01-13 00:58:00 +0800
excerpt: "这里主要记录后处理器实现"
categories: [Android]
tags: [Fresco, 图片处理, Android开发]
---
这里主要记录后处理器实现
```
package com.cmvideo.foundation.display.util;

import android.graphics.Bitmap;
import android.graphics.Canvas;
import android.graphics.Rect;
import android.text.TextUtils;

import com.facebook.cache.common.CacheKey;
import com.facebook.cache.common.SimpleCacheKey;
import com.facebook.common.references.CloseableReference;
import com.facebook.imagepipeline.bitmaps.PlatformBitmapFactory;
import com.facebook.imagepipeline.request.BasePostprocessor;

import androidx.annotation.NonNull;
import androidx.annotation.Nullable;

/**
 * Created by zky on 2025/1/10.
 * Des: 通过后处理实现九图功能
 */
public class StretchProcessor extends BasePostprocessor {
    String cacheUrlKey;
    int targetWidth;
    int targetHeight;

    public StretchProcessor(String cacheUrlKey, int targetWidth, int targetHeight) {
        this.cacheUrlKey = cacheUrlKey + DeviceUtil.isLandFoldScreenOpen() + DeviceUtil.isLandscape();
        this.targetWidth = targetWidth;
        this.targetHeight = targetHeight;
    }

    @NonNull
    @Override
    public CloseableReference<Bitmap> process(@NonNull Bitmap sourceBitmap, @NonNull PlatformBitmapFactory bitmapFactory) {
        int sourceWidth = sourceBitmap.getWidth();
        int sourceHeight = sourceBitmap.getHeight();

        if (sourceBitmap == null || targetWidth == 0 || targetHeight == 0 || sourceWidth == 0 || sourceHeight == 0) {
            return super.process(sourceBitmap, bitmapFactory);
        }

        // 等高后源Bitmap的宽度和高度，此时高度其实等于targetHeight
        int originalWidth = (int) (sourceWidth * (targetHeight * 1f / sourceHeight));

        //将源bitmap按照计算的等高
        Bitmap source;
        if (targetHeight != sourceHeight) {
            source = Bitmap.createScaledBitmap(sourceBitmap, originalWidth, targetHeight, false);
        } else {
            source = sourceBitmap;
        }

        // 创建新的Bitmap
        CloseableReference<Bitmap> bitmapRef = bitmapFactory.createBitmap(targetWidth, targetHeight, source.getConfig());
        try {
            Bitmap result = bitmapRef.get();
            Canvas canvas = new Canvas(result);
            if (originalWidth >= targetWidth) {
                //左宽度（不变部分）
                int leftKeepEdge = (int) (targetWidth * 0.2f);
                //右宽度（不变部分）
//                int rightKeepEdge = (int) (targetWidth * 0.8f);
                int rightKeepEdge = targetWidth - leftKeepEdge;

                // 绘制左边缘
                canvas.drawBitmap(source, new Rect(0, 0, leftKeepEdge, targetHeight), new Rect(0, 0, leftKeepEdge, targetHeight), null);
                // 绘制右边缘
                canvas.drawBitmap(source, new Rect(originalWidth - rightKeepEdge, 0, originalWidth, targetHeight), new Rect(targetWidth - rightKeepEdge, 0, targetWidth, targetHeight), null);

            } else {
                //左宽度（不变部分）
                int leftKeepEdge = (int) (originalWidth * 0.2f);
                //右宽度（不变部分）
                int rightKeepEdge = (int) (originalWidth * 0.6f);

                // 中间区域的宽度
                int middleWidth = originalWidth - leftKeepEdge - rightKeepEdge;

                // 裁剪出中间区域
                Bitmap middlePart = Bitmap.createBitmap(source, leftKeepEdge, 0, middleWidth, targetHeight);

                // 计算拉伸后的中间区域的宽度
                int stretchedMiddleWidth = targetWidth - leftKeepEdge - rightKeepEdge;

                // 拉伸中间区域
                Bitmap stretchedMiddleBitmap = Bitmap.createScaledBitmap(middlePart, stretchedMiddleWidth, targetHeight, false);

                // 绘制左边缘
                canvas.drawBitmap(source, new Rect(0, 0, leftKeepEdge, targetHeight), new Rect(0, 0, leftKeepEdge, targetHeight), null);

                // 绘制拉伸后的中间区域
                canvas.drawBitmap(stretchedMiddleBitmap, new Rect(0, 0, stretchedMiddleBitmap.getWidth(), targetHeight), new Rect(leftKeepEdge, 0, leftKeepEdge + stretchedMiddleWidth, targetHeight), null);

                // 绘制右边缘
                canvas.drawBitmap(source, new Rect(originalWidth - rightKeepEdge, 0, originalWidth, targetHeight), new Rect(targetWidth - rightKeepEdge, 0, targetWidth, targetHeight), null);

            }
            return CloseableReference.cloneOrNull(bitmapRef);
        } catch (Exception e) {
            e.printStackTrace();
            return super.process(sourceBitmap, bitmapFactory);
        } finally {
            CloseableReference.closeSafely(bitmapRef);
        }
    }

    @Nullable
    @Override
    public CacheKey getPostprocessorCacheKey() {
        if (!TextUtils.isEmpty(cacheUrlKey)) {
            return new SimpleCacheKey(cacheUrlKey);
        }
        return super.getPostprocessorCacheKey();
    }

}
```
