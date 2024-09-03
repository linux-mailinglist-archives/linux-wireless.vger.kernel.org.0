Return-Path: <linux-wireless+bounces-12410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B1E7B96A850
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 22:27:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B37991C21129
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 20:27:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C4BC61CF7CF;
	Tue,  3 Sep 2024 20:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JrTuAkRx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DAB241C65
	for <linux-wireless@vger.kernel.org>; Tue,  3 Sep 2024 20:27:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725395237; cv=none; b=Q/9KBxaRVQP8g04ggQjomlE+ToDoWRdByyTcMrssHwIQqV1cTlyArQtnMhwbgvmRh6iClgXRIw3m58AD56od33VDeUgvlUk/r2jVRYT+tcDrsbPJx8YLEQrupEk0y9s5wFQgolk7HOXAp+kW6af7EgB0S0pb/1tu7AB7egCczDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725395237; c=relaxed/simple;
	bh=IntUSORYdsad1n4eEyCzlF1UH+64YcC9YhQ1sTRApYc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=R+sdyckvr8Rh6/fk0B0L5AV28+rkP/X8XwgV49yZGsegP7EselnQCGehhWsvAgpi2HRkqsg8mEG/IcPm0sWTvqS1yGKYRn4ob6Bl3StIJvYuwJ4WUsFO9H75K8K74tRmAdv71o11OT8ooCOIFydcwznHJWy67bq7J6WarNQmcvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JrTuAkRx; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-715cdc7a153so28273b3a.0
        for <linux-wireless@vger.kernel.org>; Tue, 03 Sep 2024 13:27:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725395235; x=1726000035; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WWt/uMkRVjidqBos2BaPzO9K2R5OamwRrlnhafN6VFA=;
        b=JrTuAkRxBu4US71xbGOsLtBnjTMeFWndkj35AEDAQ3KP/q6w8vR8irtz9CsnVg2H56
         QnKxagF7LGnHhAIHekR+lHRmn3gi2Ax4iqxAaBQuvM+snIEg8BhChhkdVczdnBsixZhO
         5EBgaK1Oir14o/hWpFLXNwCLr4pE/pAk73TeXn/IsEfm+qeCM5aHWcAGJhH0YjbxMW9h
         ZBMk223s+5ljiYfg4d0Fkdw++jUulpkVWmtrKsIN/V6Ukq/4Ia8jHuAfCjxnCzzxu0Oy
         OzLHmwCyVMGQnTqyHBudrsAgYf4At2KyyoXNIuTNZkB42COZ58vHvS6M9yfnVYi3yZbP
         VdIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725395235; x=1726000035;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WWt/uMkRVjidqBos2BaPzO9K2R5OamwRrlnhafN6VFA=;
        b=mxjucY5TS+XgolewD6fmVOEPNa7Ubx90FlrafU644NDRSp1GSBBMjxe6CHMVRGLbjM
         24+dINd2i36wF0hDb29tTVJsrcSzWeAvgP12+2ijsjU6hNXWjjNjY3Z99ILrPbSsVWfV
         avAqOFitMhjMRroDk9EXLthYas3shCuwRxoMPCaFz+iBSv/Q4o8P/94hA43WX0zRyzg+
         j3yvzbi9E4teOCibYzGJFtgXDMgY2QWm7pn1jgnn/0wUC39sis3ROG18Ysdu9WxZ0KIu
         smoDoc1QTiOFy/yy6XTIAZY/wmOISnkBwUUkilmZEfvSy43OaDxHF8Q+FF4fT7ucBbMS
         CnjQ==
X-Gm-Message-State: AOJu0Yx5xQV2jH+baUpNdfjkjYnwWiwFf+R7DfYCOGpWknwBWsURnYE/
	vW27i398h3nREgx4p9CxAza6X4wOxus0DFSxUD/CUnVRwZw8KNGzKzJi4w==
X-Google-Smtp-Source: AGHT+IEPBXLAIlP7CIDC6PC9euYyPMJX0/CC1AvEEgWnWwIkRqiaiT4A+2HS8ewChr+eMTlUg7jbjg==
X-Received: by 2002:a05:6a00:6f28:b0:714:21cd:a4e3 with SMTP id d2e1a72fcca58-715e103b2d2mr28943446b3a.13.1725395235392;
        Tue, 03 Sep 2024 13:27:15 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-71778587f5csm270004b3a.121.2024.09.03.13.27.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Sep 2024 13:27:15 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org,
	toke@toke.dk,
	nbd@nbd.name
Subject: [PATCH] wireless: ath9k: eeprom: remove platform data
Date: Tue,  3 Sep 2024 13:27:13 -0700
Message-ID: <20240903202713.471489-1-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

There are no more board files defining platform data for this driver and
eeprom support through NVMEM has already been implemented. No need to
keep this old functionality around.

Signed-off-by: Rosen Penev <rosenp@gmail.com>
---
 As an aside, the last user of this functionality downstream in OpenWrt
 has been removed: https://github.com/openwrt/openwrt/commit/7ac8279bd

 drivers/net/wireless/ath/ath9k/eeprom.c | 12 ------------
 1 file changed, 12 deletions(-)

diff --git a/drivers/net/wireless/ath/ath9k/eeprom.c b/drivers/net/wireless/ath/ath9k/eeprom.c
index efb7889142d4..df58dc02e104 100644
--- a/drivers/net/wireless/ath/ath9k/eeprom.c
+++ b/drivers/net/wireless/ath/ath9k/eeprom.c
@@ -15,7 +15,6 @@
  */
 
 #include "hw.h"
-#include <linux/ath9k_platform.h>
 
 void ath9k_hw_analog_shift_regwrite(struct ath_hw *ah, u32 reg, u32 val)
 {
@@ -119,14 +118,6 @@ static bool ath9k_hw_nvram_read_array(u16 *blob, size_t blob_size,
 	return true;
 }
 
-static bool ath9k_hw_nvram_read_pdata(struct ath9k_platform_data *pdata,
-				      off_t offset, u16 *data)
-{
-	return ath9k_hw_nvram_read_array(pdata->eeprom_data,
-					 ARRAY_SIZE(pdata->eeprom_data),
-					 offset, data);
-}
-
 static bool ath9k_hw_nvram_read_firmware(const struct firmware *eeprom_blob,
 					 off_t offset, u16 *data)
 {
@@ -146,15 +137,12 @@ static bool ath9k_hw_nvram_read_nvmem(struct ath_hw *ah, off_t offset,
 bool ath9k_hw_nvram_read(struct ath_hw *ah, u32 off, u16 *data)
 {
 	struct ath_common *common = ath9k_hw_common(ah);
-	struct ath9k_platform_data *pdata = ah->dev->platform_data;
 	bool ret;
 
 	if (ah->nvmem_blob)
 		ret = ath9k_hw_nvram_read_nvmem(ah, off, data);
 	else if (ah->eeprom_blob)
 		ret = ath9k_hw_nvram_read_firmware(ah->eeprom_blob, off, data);
-	else if (pdata && !pdata->use_eeprom)
-		ret = ath9k_hw_nvram_read_pdata(pdata, off, data);
 	else
 		ret = common->bus_ops->eeprom_read(common, off, data);
 
-- 
2.46.0


