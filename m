Return-Path: <linux-wireless+bounces-17031-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3B68FA0055F
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 08:51:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0930F1628B8
	for <lists+linux-wireless@lfdr.de>; Fri,  3 Jan 2025 07:51:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E0511C4A34;
	Fri,  3 Jan 2025 07:51:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kefQmGUJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B0BC1B21B2;
	Fri,  3 Jan 2025 07:51:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735890699; cv=none; b=FCiJz1FUwZOhChQRRhf0emsIZS9ZsJVlZCsIwFBhERWa+2sMuaN/FvK4QmcCN9FqdGg8KTYWsYrhvkqD8dSyGOpyVzUBYcE4bzol8s1c3hoK7P19ngVAOLDrpkDfvcDRxCd+7nXjys4Y7+ttNQsqhHHAE9bUUO0oOCmVOibU0QI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735890699; c=relaxed/simple;
	bh=n2GjOR/7chbnuLYqm/dg8k4ovBMU6K9WqEzyltW+Y04=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=RleEnTBdtialFWY+yO05MEDSYM8ojZKjpExrNT1IHTiZcWAXAWLVsgLSmxxZ5wU5WY4YSoqLeDtLQW5ZpoEi1Cq5wQl5+MyGl7kYyj2WsTlbMPQXEjFccTOpW396ZG+/vKNiDOQoiFDMQmtUpgeaAEr356E11z9hMaN2TCdnoBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kefQmGUJ; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-21661be2c2dso151542975ad.1;
        Thu, 02 Jan 2025 23:51:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735890697; x=1736495497; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=0ivF9EkL0Rz65+IH+vfWR7QI6Gk6ONwax6hJC9wnFvY=;
        b=kefQmGUJbToDs8N9uOLs1nYWHsTJJ3uhv7nZxr/Y96b0bIy3sOTqnodH3fGdK/IVAE
         5h7z14QWMgHTrJ6Lm9ZWPchv4He/7H11vUg8LgXoAszLeNpthm09P8ez8ZTvmLgnhIpo
         cVDQkloGpOHHk+LsCWoKcHvVLIIC3pmg7fFr4VQeJc5dlxoaZe6++JKDNpayWkTUba+4
         gHsj38Qftk//cK7+IpjaemHAqurgnLuRc4m61QGCt7LebdkiHKx+jROiAB3a3sicCeMj
         rZ29PF4cQcY/G46zTYW50315T7CG1dTg6HzKjeql1V6TDpG145n5ZUwr/ksyPb0ZRzJN
         cwtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735890697; x=1736495497;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0ivF9EkL0Rz65+IH+vfWR7QI6Gk6ONwax6hJC9wnFvY=;
        b=MdimvhhszYoLmfyaLGEc7dFyjESQs6HfqIb16M0gPC4ou5c3O/5Bn+0r40NPhq5F7L
         RVVReWScPc46uiuv9hWY9+0AdslC3EsAzCodCjNHC3RkaDgTRb80Je1cqaLs6JseafqW
         WCAwgX/uCsUUWzS4vXzRPy26/xXAJ/uEvxoqTDFrkTxAUxuf1rqtT2zZ28VTPWXGv+1H
         hQzgsBmoa5XryAuUuz6OuyVHecOelDgsdU3rayEhPRsh0RIuFgwsr2EAMEstHPws1D4R
         RaNR/+HKYgbyM/YpEvoFb/yH0pr5cgBa05pLWDjf2GYjtdi2HXO2yTWcPEixngpzsdY8
         D96Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIFizBT/+GG67v/+ZTIxwmklqGjoWsKqugdiuF9YC6pPhf37JbT01QGhfgo6+xXnNBPdwoy6AYvk7ILQLjiPk=@vger.kernel.org, AJvYcCVsg/hkpEj9lsFJRGjvsLLOKlM5XWkn9n6rY6HDpEiQa0DNKg+n8Hwq4QEeFAwtvMSCkO9RS+bH@vger.kernel.org, AJvYcCXWuHoikKUdArsDtgn50BRxuqg2kx8mX1DE46nW0+NmWCymuAxNgh6DhYnbH7KcI/L7xkTxNI7oQWqF/d0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMeW0K5Avy5U+M/xRQGSz0sX0b40C9REEHeLw6LpK+QPNdmvCz
	AI7gvzWC8Fz0T7BGL/hbbBMYCh/7SKbbkHIFFALYzppitaqiZ6Ur
X-Gm-Gg: ASbGncuYMY57+LttM2KLHXD4t2OgmBede9rXbt6fYjDCIiGby64d+2SFptheim5QTL2
	6lv6mPafMcHbeydL//IXVEXxwEFuQfo//3uco8mCGrJtazVFKloeQDlZC5VeaGqx1kGJus5sjVL
	5l8YXWNWu9RSBAsSlVPwyjlpw4B214CmzYtNWutupIV5vScACy2RVVc8ftnPDnRT+/c46UWDqHm
	eji7iorw5CfSDtz7TCDzcrE/vrupUGnR1ICreZNk8LNV10q4w==
X-Google-Smtp-Source: AGHT+IFELh5oZZKaHHmgPTNDldXeTPO48beD4h7k0zdIiMthWxdDka/Cc6gvgdYt78okgNjzxhNh+w==
X-Received: by 2002:a17:902:f705:b0:216:6fbc:3904 with SMTP id d9443c01a7336-219e6e9d91emr755493495ad.13.1735890697199;
        Thu, 02 Jan 2025 23:51:37 -0800 (PST)
Received: from anarsoul-xps15.lan ([2604:3d08:7780:1ca9::398])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-219dc964a73sm238932935ad.45.2025.01.02.23.51.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Jan 2025 23:51:36 -0800 (PST)
From: Vasily Khoruzhick <anarsoul@gmail.com>
To: Ping-Ke Shih <pkshih@realtek.com>,
	Kalle Valo <kvalo@kernel.org>,
	Fiona Klute <fiona.klute@gmx.de>,
	Bitterblue Smith <rtl8821cerfe2@gmail.com>,
	linux-wireless@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Vasily Khoruzhick <anarsoul@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] wifi: rtw88: 8703b: Fix RX/TX issues
Date: Thu,  2 Jan 2025 23:50:53 -0800
Message-ID: <20250103075107.1337533-1-anarsoul@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix 3 typos in 8703b driver. 2 typos in calibration routines are not
fatal and do not seem to have any impact, just fix them to match vendor
driver.

However the last one in rtw8703b_set_channel_bb() clears too many bits
in REG_OFDM0_TX_PSD_NOISE, causing TX and RX issues (neither rate goes
above MCS0-MCS1). Vendor driver clears only 2 most significant bits.

With the last typo fixed, the driver is able to reach MCS7 on Pinebook

Cc: stable@vger.kernel.org
Fixes: 9bb762b3a957 ("wifi: rtw88: Add definitions for 8703b chip")
Signed-off-by: Vasily Khoruzhick <anarsoul@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/rtw8703b.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
index a19b94d022ee..1d232adbdd7e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -903,7 +903,7 @@ static void rtw8703b_set_channel_bb(struct rtw_dev *rtwdev, u8 channel, u8 bw,
 		rtw_write32_mask(rtwdev, REG_FPGA0_RFMOD, BIT_MASK_RFMOD, 0x0);
 		rtw_write32_mask(rtwdev, REG_FPGA1_RFMOD, BIT_MASK_RFMOD, 0x0);
 		rtw_write32_mask(rtwdev, REG_OFDM0_TX_PSD_NOISE,
-				 GENMASK(31, 20), 0x0);
+				 GENMASK(31, 30), 0x0);
 		rtw_write32(rtwdev, REG_BBRX_DFIR, 0x4A880000);
 		rtw_write32(rtwdev, REG_OFDM0_A_TX_AFE, 0x19F60000);
 		break;
@@ -1198,9 +1198,9 @@ static u8 rtw8703b_iqk_rx_path(struct rtw_dev *rtwdev,
 	rtw_write32(rtwdev, REG_RXIQK_TONE_A_11N, 0x38008c1c);
 	rtw_write32(rtwdev, REG_TX_IQK_TONE_B, 0x38008c1c);
 	rtw_write32(rtwdev, REG_RX_IQK_TONE_B, 0x38008c1c);
-	rtw_write32(rtwdev, REG_TXIQK_PI_A_11N, 0x8216000f);
+	rtw_write32(rtwdev, REG_TXIQK_PI_A_11N, 0x8214030f);
 	rtw_write32(rtwdev, REG_RXIQK_PI_A_11N, 0x28110000);
-	rtw_write32(rtwdev, REG_TXIQK_PI_B, 0x28110000);
+	rtw_write32(rtwdev, REG_TXIQK_PI_B, 0x82110000);
 	rtw_write32(rtwdev, REG_RXIQK_PI_B, 0x28110000);
 
 	/* LOK setting */
@@ -1372,7 +1372,7 @@ void rtw8703b_iqk_fill_a_matrix(struct rtw_dev *rtwdev, const s32 result[])
 		return;
 
 	tmp_rx_iqi |= FIELD_PREP(BIT_MASK_RXIQ_S1_X, result[IQK_S1_RX_X]);
-	tmp_rx_iqi |= FIELD_PREP(BIT_MASK_RXIQ_S1_Y1, result[IQK_S1_RX_X]);
+	tmp_rx_iqi |= FIELD_PREP(BIT_MASK_RXIQ_S1_Y1, result[IQK_S1_RX_Y]);
 	rtw_write32(rtwdev, REG_A_RXIQI, tmp_rx_iqi);
 	rtw_write32_mask(rtwdev, REG_RXIQK_MATRIX_LSB_11N, BIT_MASK_RXIQ_S1_Y2,
 			 BIT_SET_RXIQ_S1_Y2(result[IQK_S1_RX_Y]));
-- 
2.47.1


