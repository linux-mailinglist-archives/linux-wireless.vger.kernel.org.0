Return-Path: <linux-wireless+bounces-13908-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B85399ADB7
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 22:50:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F8D61C22627
	for <lists+linux-wireless@lfdr.de>; Fri, 11 Oct 2024 20:50:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C07E2199231;
	Fri, 11 Oct 2024 20:50:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lIGjJEZw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9F4E1CFECE
	for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 20:50:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728679809; cv=none; b=u8HU0Hy99Z0Yk0u2h4Ph7vMcdOrfUZFjy7hFtOVjvAW1r4Bq71Zul7kFSDLTo8+yCeAXbIE01nLhUYgAaaDAj0irvTdvWRc43rHCFPS4F5qsRUBVPy2QwgBDJxbyn0dxdAupwgLGe6Mm2UEnpqUVUwUEnbxMKRluQm5EvtIzZs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728679809; c=relaxed/simple;
	bh=zAhYgTa37cJvLLXlV12fDr0sO+eXXdiIVez7Neb0Hu8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=eP97K4nRT4zknF6YrfTVgzLVwiIfm1jHNQx+5h15U7vaPnj9QlG/SJSPUEeqT6fmtkcEGMir2eaFcTdj57rGbouUJmhom/SUAvJoM5aVrdlGSS4MpdqspU42xKYzx5XKV4gEcCkgpnD4Wul9phfXooMRj49i8IPuOUP3YsdvILQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lIGjJEZw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43058268d91so21402495e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 11 Oct 2024 13:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728679806; x=1729284606; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=HRjyqKwSN/TcZYSbXj0ckwT6zaigwXZxioktj5K45Ws=;
        b=lIGjJEZwtAwz2xHTGAirNDLIYv/zw1fcXmBhmXMv5k1azIMxonjYhX6yhJMOh0nC4a
         SV/e+xABc5QyyOqqzsnu9qHfwB0juInpzg1SIcTziweo/lmYjhsCuyIctDPztMUnBz4t
         SJ3K208zRN+5do2DdKGNNPlicTez84H+gu3JqX5pY+dHEaYT8Xa8v/0hUPmesROMMPYx
         eyHsKxWzQ/S6G7eai8PEQ9gwusLWt7ja8oLAQ6JotipUGGpM9DbeBVJKCdGkVE0Ud6UF
         61UtcwLL4AK0/sMhskJeXbFszD+vaA+Jc2eBAosZ2VhPZwS36hEE04NQVEhhyC7lAUGx
         iWyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728679806; x=1729284606;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HRjyqKwSN/TcZYSbXj0ckwT6zaigwXZxioktj5K45Ws=;
        b=jYBGaxRo5x2U/KWHYV108nKNr2z6UQUTiJ56rj86IeJDF2ECjbyAcdBs4WBkpNnubw
         +6y76spGE/+y4Lw0HHghj76UkLzw9kSQVoR/Niua/ctI6SbTZvGEadfQ628GMVoCw1jk
         GBfCjt2puTgiayW12TYDurfStzkoX/QneEc/Y9/hdw5tejpT/5ibuNbMYGUq08a//KYc
         xiSTn5RuBrfEWp683a2rdeO2FWcnxLXeWuEuyPVYoyogm9Ssxw0V9MUE4HSSnjjjek79
         x9msH3ZO0LbYhly7fY+ghXXRZfVyThc4ZqgOQl9YdTMaRYQ5KRrtN4Pk+r0HrLYHCfPz
         mUqw==
X-Gm-Message-State: AOJu0YzjTmJ8oeDVmnymeUZgqvHQ0GrvTV3FpbzH6QtUZtreG0YL6Gte
	t3Mxr6YaWsDC5qRpNVcBQsabJuVjl4jkn6KJ9Bsl98sA9TSM5jaAgN9S7A==
X-Google-Smtp-Source: AGHT+IFUwz19wTYZPP0tAGGpIOgva5CS5V7MzZCvSomR+xk5n16Gs4ma1XJzSxz5JNswB0p3Lhqf/g==
X-Received: by 2002:a05:600c:470e:b0:42c:acb0:dda5 with SMTP id 5b1f17b1804b1-4311dea3c39mr34916965e9.1.1728679806205;
        Fri, 11 Oct 2024 13:50:06 -0700 (PDT)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4311835d78fsm50237785e9.43.2024.10.11.13.50.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Oct 2024 13:50:05 -0700 (PDT)
Message-ID: <371b587a-b7ee-4a1d-9a45-4a3f583b3bde@gmail.com>
Date: Fri, 11 Oct 2024 23:50:05 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 08/22] wifi: rtw88: Make txagc_remnant_ofdm an array
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Language: en-US
In-Reply-To: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

txagc_remnant_ofdm member of struct rtw_dm_info should be different for
each RF path, so make it an array of size RTW_RF_PATH_MAX (4).

Until now all the chips using this had only one RF path, but RTL8812AU
has two, and RTL8814AU has four.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - No change.
---
 drivers/net/wireless/realtek/rtw88/main.h     | 2 +-
 drivers/net/wireless/realtek/rtw88/phy.c      | 4 ++--
 drivers/net/wireless/realtek/rtw88/rtw8703b.c | 4 ++--
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 64bc43cdd209..45f0e8fff453 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1715,7 +1715,7 @@ struct rtw_dm_info {
 	bool pwr_trk_init_trigger;
 	struct ewma_thermal avg_thermal[RTW_RF_PATH_MAX];
 	s8 txagc_remnant_cck;
-	s8 txagc_remnant_ofdm;
+	s8 txagc_remnant_ofdm[RTW_RF_PATH_MAX];
 	u8 rx_cck_agc_report_type;
 
 	/* backup dack results for each path and I/Q */
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index dda212a721ca..5fbacb7ce499 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -2170,8 +2170,8 @@ void rtw_get_tx_power_params(struct rtw_dev *rtwdev, u8 path, u8 rate, u8 bw,
 
 	*limit = rtw_phy_get_tx_power_limit(rtwdev, band, bw, path,
 					    rate, ch, regd);
-	*remnant = (rate <= DESC_RATE11M ? dm_info->txagc_remnant_cck :
-		    dm_info->txagc_remnant_ofdm);
+	*remnant = rate <= DESC_RATE11M ? dm_info->txagc_remnant_cck :
+					  dm_info->txagc_remnant_ofdm[path];
 	*sar = rtw_phy_get_tx_power_sar(rtwdev, hal->sar_band, path, rate);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
index f6f6635b46e1..dec0cec4ca22 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -637,7 +637,7 @@ static void rtw8703b_pwrtrack_init(struct rtw_dev *rtwdev)
 	dm_info->pwr_trk_init_trigger = true;
 	dm_info->thermal_meter_k = rtwdev->efuse.thermal_meter_k;
 	dm_info->txagc_remnant_cck = 0;
-	dm_info->txagc_remnant_ofdm = 0;
+	dm_info->txagc_remnant_ofdm[RF_PATH_A] = 0;
 }
 
 static void rtw8703b_phy_set_param(struct rtw_dev *rtwdev)
@@ -1589,7 +1589,7 @@ static void rtw8703b_pwrtrack_set_ofdm_pwr(struct rtw_dev *rtwdev, s8 swing_idx,
 {
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 
-	dm_info->txagc_remnant_ofdm = txagc_idx;
+	dm_info->txagc_remnant_ofdm[RF_PATH_A] = txagc_idx;
 
 	/* Only path A is calibrated for rtl8703b */
 	rtw8703b_set_iqk_matrix(rtwdev, swing_idx, RF_PATH_A);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index a0bf37a58632..1d99bb89ef1d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -79,7 +79,7 @@ static void rtw8723d_pwrtrack_init(struct rtw_dev *rtwdev)
 	dm_info->pwr_trk_init_trigger = true;
 	dm_info->thermal_meter_k = rtwdev->efuse.thermal_meter_k;
 	dm_info->txagc_remnant_cck = 0;
-	dm_info->txagc_remnant_ofdm = 0;
+	dm_info->txagc_remnant_ofdm[RF_PATH_A] = 0;
 }
 
 static void rtw8723d_phy_set_param(struct rtw_dev *rtwdev)
@@ -1265,7 +1265,7 @@ static void rtw8723d_pwrtrack_set_ofdm_pwr(struct rtw_dev *rtwdev, s8 swing_idx,
 {
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 
-	dm_info->txagc_remnant_ofdm = txagc_idx;
+	dm_info->txagc_remnant_ofdm[RF_PATH_A] = txagc_idx;
 
 	rtw8723d_set_iqk_matrix(rtwdev, swing_idx, RF_PATH_A);
 	rtw8723d_set_iqk_matrix(rtwdev, swing_idx, RF_PATH_B);
-- 
2.46.0


