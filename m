Return-Path: <linux-wireless+bounces-30023-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id DCDC2CD2F69
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 13:58:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 174CF3005A8B
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Dec 2025 12:58:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 333151B81CA;
	Sat, 20 Dec 2025 12:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dYn8Wvzh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com [209.85.221.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6287D1F1534
	for <linux-wireless@vger.kernel.org>; Sat, 20 Dec 2025 12:58:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766235495; cv=none; b=efHTcuWJ4mfgdjdTH4DxP0cFC/f1lD9XtjIimsDkXWWLf7eVT6LLNAOVSIuRaFIL/zsUjzCWDXWh3kh2CyVN4FTzZg7P8tY0UwZd4c86WHK9lKy86hs7qZj7LSEm7pN1MdFDZD7ZObIN99qbFE5rK+j+hKNbEb5INn4vm4Mn5sc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766235495; c=relaxed/simple;
	bh=CoSwDue9y1H/F/vUts+yj+gxAmOEHWrSz90fwPrEs5U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=qM9wNibgb+IY2Gz60Vl5lV5INgKG8FLOlQYx6VNUJYoIvsvusRDVbT7l4wnqjbvO0NQhYwlcH0mSnx9cuhqD5rPULo8EwwX23RI7bBePKtP+xvGC931mCiBOGPOB0bxqock/o5TJkI3cGttYCmzO8PMWZTZUCfJqXPvJhK+JBx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dYn8Wvzh; arc=none smtp.client-ip=209.85.221.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f47.google.com with SMTP id ffacd0b85a97d-42e2d02a3c9so1686164f8f.3
        for <linux-wireless@vger.kernel.org>; Sat, 20 Dec 2025 04:58:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766235490; x=1766840290; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QxyGw0P2QuelYRORTGFdIi9GvCTSJIG1aR1GB4FdJRU=;
        b=dYn8WvzhqokTK3nmPiGTlULBZhV7q4dOPUMHVJE6XdqaSy5IKULyP+7QZEQfF2gPJF
         zZPFqo7+oOxrSvUKr86tOlxKbtw/eAthuluATrCr6wbnNdZn2scmud6y+tkH2TadN0wU
         EE1YVBRpXkV/d1l/oSg6JTMjHg/fUD3ApMe3I63Q/ZrvjU7ldX6f2oa4/1b0mGy9o0ON
         UT3vAUbJzll9fhQFHehmCxY5/omvjnrWiN599SEgX9HlzRMu0Ke2cT14NsPabWEl6Upg
         Riu0dLocFYzBPoR+xuiZ4kIRvXLg+OaveLTOPz5lgYE7TypKDTPrTv7GSKiOiYUii3mf
         068A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766235490; x=1766840290;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QxyGw0P2QuelYRORTGFdIi9GvCTSJIG1aR1GB4FdJRU=;
        b=v9ZfNNBE41wPbUiVgNfyd526CQLlol4dQ1eBBIJiNt70sbpbI+T9KRY6KOZTkE5yBo
         0ivhpIkuGd7ucoAatgsAjtFZqK5ZL18MZj+uXRw/Ehzz7QyCPLBfNI2YiIXDkn80Yttg
         6kZL1XxqryjpUtHfgbG+BGwWj/NFMSAY+7MFSorrGXfzFvO0GMMbMk5OQekCuRaAE+0d
         n8uiIITIksz309WWdnOdlHrokm79h/74Pir9n7YluD/PXbbcsOziQPuOA9X/5ESHOJ7k
         Dt99QWtwoiFYIMF2cKkwfaGStccOmYEZarHF8VCkHq+V6wCVSCmTyfucZbd0p+YEvgsh
         zoSg==
X-Gm-Message-State: AOJu0Yw4ssphQO+hKTyVIvB7gTmr62jJ2KFpSbuOXra1czFtgSOUCzKP
	wNkdwaEWgJgXx1Cbgx47RCjofp/XH1YEtCM7Kqm5JkQa4QVMS9DaHfFL/5ml4Oxq
X-Gm-Gg: AY/fxX5fxyviDdcGNgKg59wVIYBh8B/smBYDfIZfra9wGmGJMJ9sHgyZwg/Fi/x10Yo
	4z2iWd932/ScO9AOpmZeMJT/aFhbp1CWcH59y0DGgdcZPNSq2c5JCxnvDBoTnwmwf989PXYf11v
	AOvdv2ICVGhg22wQqlZR8xjkRWby3ztO2vDJdSeXI53AgiiziI2fZvG2JQCE9nVERMWLQgRPbey
	tdCiVusPHIXfk0mtYGl4Y4icypbeqFyldMcH0XfvR2Rkj6nvt7IoeaH+A8cgN4i2dlxzhY8Psjw
	WGMJe6+zP/OOHgmEQIktVCXqoVr+NCvWXI5f0yQKTC9Dw+8FL7nCSh+c6CUQiEYDcvPA9BWgilu
	e6K2ziZtRrHAkmlK+EmjvlwGvvGjSiLyr52ogEZa9Q8KYzEdIExoH83XUrYnFe1KGGXyduXrH71
	4VLBqQ3oD9KlZtMiJqic/nKJ6gttlPxyYBGB3IExrMpbA+RnvKukP7OID7rnFn71xRWrTns46P
X-Google-Smtp-Source: AGHT+IF/Ml1lNB3fH8/HbCNIZb4ASinWXjpBUi4AdrQVUET/dle/odD9OsdmeKmNHTZryReeit9ZOw==
X-Received: by 2002:a05:6000:2889:b0:430:fb00:108f with SMTP id ffacd0b85a97d-4324e4c9eefmr6368977f8f.18.1766235490122;
        Sat, 20 Dec 2025 04:58:10 -0800 (PST)
Received: from cachyos-x8664 ([2a0c:5a80:3b12:c900:31e4:8778:bf5:9080])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4324ea82c5csm10417688f8f.21.2025.12.20.04.58.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 20 Dec 2025 04:58:09 -0800 (PST)
From: l33tm4st3r <fransm@gmail.com>
To: linux-wireless@vger.kernel.org
Cc: Fix mt7925e Buffer Overflow <bugfix@example.com>
Subject: [PATCH] mt76: fix buffer overflow in mt76_connac2_load_patch()
Date: Sat, 20 Dec 2025 13:57:56 +0100
Message-ID: <20251220125756.254355-1-fransm@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Fix mt7925e Buffer Overflow <bugfix@example.com>

Fix strnlen buffer overflow detected in the mt76_connac2_load_patch() function
when loading firmware for MediaTek MT7925 WiFi chipset on kernel 6.19.0-rc1.

The issue is in line 3128 where dev_info() uses format specifier %.16s on a
16-byte buffer (mt76_connac2_patch_hdr.build_date[16]), which can cause the
fortified strnlen to read beyond buffer bounds if the string is not properly
null-terminated within the buffer.

The fix changes the format specifier from %.16s to %.15s, consistent with the
similar mt76_connac2_fw_trailer structure which has a 15-byte build_date field
and uses %.15s format in mt76_connac2_load_ram().

Error message fixed:
  strnlen: detected buffer overflow: 17 byte read of buffer size 16
  kernel BUG at lib/string_helpers.c:1043!

Kernel: 6.19.0-rc1-1-cachyos-rc
Device: MediaTek MT7925 (mt7925e driver)

Fixes: regression in 6.19.0-rc1 (works in 6.18.2)
Reported-by: CachyOS Bug Report

---
 mt76_connac_mcu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/mt76_connac_mcu.c b/mt76_connac_mcu.c
index fba7025f..c284ad7f 100644
--- a/mt76_connac_mcu.c
+++ b/mt76_connac_mcu.c
@@ -3124,7 +3124,7 @@ int mt76_connac2_load_patch(struct mt76_dev *dev, const char *fw_name)
 	}
 
 	hdr = (const void *)fw->data;
-	dev_info(dev->dev, "HW/SW Version: 0x%x, Build Time: %.16s\n",
+	dev_info(dev->dev, "HW/SW Version: 0x%x, Build Time: %.15s\n",
 		 be32_to_cpu(hdr->hw_sw_ver), hdr->build_date);
 
 	for (i = 0; i < be32_to_cpu(hdr->desc.n_region); i++) {
--
2.40.0

