Return-Path: <linux-wireless+bounces-12546-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 42FEE96E199
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 20:09:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 451BB1C23AA4
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 18:09:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C2C617ADFC;
	Thu,  5 Sep 2024 18:09:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZHa1M8e4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192B715ADB4
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 18:09:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725559775; cv=none; b=DB0Fc2bZvg7uqXNmZ8TzEPfU+1G5T58SC9nIMreS/Puljw0w43fWigghr/ItES47ys+nrAdqdjN7LUDzcu3S4XbgD9MOa3ccNr8ZQ8yJsUQWxdq3hFNJdapTp4upfOecyErl7a05MfzvWk0pBisY9hhFkny9KJCdgzLqTM3EkmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725559775; c=relaxed/simple;
	bh=WnvyFFK3cuKEwdYAd9S+ApvA6FKMM6oYN4T0bScrlTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EvArzPejWZLpcKSqot7ne7L0Ou4KlOZnmctNgRsJlwEGzK8sarEEC2G/Tfj7vKHQR1duaGm+SknnE6LT2Ti6DAd4oetditpkRdkg1sdVPKSX6jfYyAmxgTqVt5z6t3h1c8rqq2E/L4hKv4p8cYIpYx1Z8eFbDcInAUmziscWbcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZHa1M8e4; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-71798661a52so364952b3a.0
        for <linux-wireless@vger.kernel.org>; Thu, 05 Sep 2024 11:09:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725559773; x=1726164573; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+tOAE5lYXIqswc9ysrQaHFWZw9vsI1EIllIjuF/U03w=;
        b=ZHa1M8e4HeXbNj8KBhp/enTNDpUx6Bj4wLiAJY8DYo4XuGwlWBPlihms2r4PUYIKNt
         ODAhaApJph6jWNgiegDVYCz+fIxZF2XA+nIpkys157H0ZiuVNerlCJIxoOjcvNxF/MBK
         k6eNyX/r3pejip5e5cCwrRpa6nip3/JFUL0P17zqxHh+7LK+zJDsu3bc3P5U8baWV1mw
         qX8i0NnGfqd+0caoL1j2fb3/BAy9Yp/VM2TG7QCfImLcr3tGf9jU8KWNiyVHS8GJHUzf
         xTvzOayUQsIwx1CgchpXUwi0rsmMz2jq/i4C+7rnWWBPsx8eQoYtOQy6n3DTPLrL0SeC
         0knw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725559773; x=1726164573;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+tOAE5lYXIqswc9ysrQaHFWZw9vsI1EIllIjuF/U03w=;
        b=VtoDxl2g5/2JurF6Jf9mQTBfiHQy16SEXGaOO9VEvb3m0Y2Mw1A2SulyBazV0/f+nS
         nwyU+x20Yk9fLOM+1fXDSQeeU9w1tfnvW4G7igqFz4lCH1U7qeTTdICLKRU9K7w8CdyV
         ZsYXTLj3GNP/kWcpt7lF3Zi/BIlaFp12l2BMB9pOFDVTm90a05LnZvvU62xhXL0U2NrV
         GxS13RfYOgnoKJ8mguL9EAl3yZE4TeZvjBxLymH13HbVuPMFiVMHsoV8CgJfDY9dcBIz
         cgx0xnCV7XMEcCheInczGAPdLLFHfe/mEqQIXNJQyUNgZ64hwd9jb3pj28BYilkGZ27f
         ODgQ==
X-Gm-Message-State: AOJu0YzmbYWSSrQj1lUq2IToCVTY9TjhmIbl1qHXa8zkRKmTM2xZGDGh
	VJ3ldznzo8i5V2ZchXjZe5T7Wyh3jobSrTkjkoBw3YGl8H3BBCmEyeSNNyq4
X-Google-Smtp-Source: AGHT+IH3IzLhKfsPjAk+qOnTf1LbneGTEZ+vsBONanMaJIpnbrF4Em6dptWCHd7HIfWnc7Z2WJGz1w==
X-Received: by 2002:a05:6a00:cca:b0:704:151d:dcce with SMTP id d2e1a72fcca58-718d5341f04mr234236b3a.5.1725559773086;
        Thu, 05 Sep 2024 11:09:33 -0700 (PDT)
Received: from ryzen.lan ([2601:644:8200:dab8::a86])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7177858bfd5sm3485199b3a.133.2024.09.05.11.09.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Sep 2024 11:09:32 -0700 (PDT)
From: Rosen Penev <rosenp@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: kvalo@kernel.org,
	toke@toke.dk,
	nbd@nbd.name,
	yangshiji66@outlook.com
Subject: [PATCH 1/5] wifi: ath9k: eeprom: remove platform data
Date: Thu,  5 Sep 2024 11:09:24 -0700
Message-ID: <20240905180928.382090-2-rosenp@gmail.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240905180928.382090-1-rosenp@gmail.com>
References: <20240905180928.382090-1-rosenp@gmail.com>
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


