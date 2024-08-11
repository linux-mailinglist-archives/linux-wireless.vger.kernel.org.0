Return-Path: <linux-wireless+bounces-11279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA7394E32E
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 23:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CEC6CB21635
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 21:00:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 018FF2595;
	Sun, 11 Aug 2024 21:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i5ITV+6s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 457611537C7
	for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 21:00:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723410015; cv=none; b=ura43Xb4QihQhTxIX1X+o98JgNeSYH1pXde7L0fyStnPOWvX/J66kmYqxTmEjkmyAAO1xu0gS3+W/sC8D5r63nQyfHUO9/eMNpLQsO9h02o6X9yfwZ2V2owlE2JePAwB2+KOQoqi4bs7a0Msx9TL6z+O27wWImBWueZIP3UMoDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723410015; c=relaxed/simple;
	bh=kE8EoAmAQbvb42zIif1zwWIp0Dr0Vlyk4wHM5uhJdOY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=mZJgvaGrM93mKTuUJiIAzoG0ohDzb0qG/ecZMGiJmSgVyu4bC6t3nsUxKJ9/RrLHCxN4gEtSYqE00R3ymG4xD/6P9jGjHOCKKYXRskhM7RhRSFhBKvTUvztYHOCalaqWsRQ6OG1M2BEUzU4FXwfED9NmjoxmS+/vL5c24v1Wy0g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i5ITV+6s; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-a7a975fb47eso421558366b.3
        for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 14:00:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723410012; x=1724014812; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=6/spF096oYj0tY6XOpU/GGebnmI0PoFh3kZhntTVc6A=;
        b=i5ITV+6sHguMuW4r8iGwqDR12Atyl7mY13LvNKgVMlKyaS9A1UrkZvCfRLFxvedb3R
         KGN8sJCNODMqmgkdIYdmpq0eC69fvRDvnWCSYqUTqDgUklZDle9ckaEaR92YlGfNe00M
         Y7IcX384i9Ii5d2XEOFpqLsLfLvVu23jOjPVo3n6VUnsJ1HKSNIYuKyQK608hlxx7urA
         mC+3iTknnZe1dSvr7WlXWXsxx4mZsNtJXqD9jEFoVikU2sH9VyBgKG11PlkG9QBWHi3R
         ysTgGoqYo0jiR2xrv7pwu/jc9u9qWNcRHANqNowqiRlO7XsOXSy1vvihjva16rb9zdik
         0Jzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723410012; x=1724014812;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6/spF096oYj0tY6XOpU/GGebnmI0PoFh3kZhntTVc6A=;
        b=ferhWONBsqLsX+jeBpFh6XJ7GLwDvWr35lszHiL1075FyrPApkzS1u1TYPiPKw77i0
         OnJBIYSuoMsbz+8mykjNnDufe8KQEU1WuCas6RlTbdgUpwtEU2LyPCIoh4P1EHxsPLmM
         Up260Hc2/a2OdOGcPx1qCSPEjd3m4qFslDPUM6booi4EQMd4zltF7Hpizl7QV+ljkBcn
         uK4dV+G8QQFliIKPX54GOwdhTaxJK8jNHLSlhaJlrqKLhc+7iahx2zW8vkic9c5FB0hl
         a/ZPlbV7fKGWEMngTqhnwECtnwTi2MGEFgWSPqlk1jMTpAqULTEXYwQSfn7SF+Od6mAR
         8xiA==
X-Gm-Message-State: AOJu0YywZr+rcDwwSSTFVVRMl8iIzkHqCCDISbfqM6P1dvbMuzfMhHsa
	VqFSce1YvkzZQF0r6IIwqOOSRVe1vKdqsRJSPtUu/aG1gFp/1am34wwe5w==
X-Google-Smtp-Source: AGHT+IH10qo2IPzy0XMrapybSHZqu2p4sqZyOZ4qJzeCdsBXqCnbSdH3Tzpa7SoLoooAUa6Mt09h3w==
X-Received: by 2002:a17:907:f741:b0:a7a:b18a:66 with SMTP id a640c23a62f3a-a80aa598502mr586040066b.16.1723410012397;
        Sun, 11 Aug 2024 14:00:12 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a80bb08fe90sm172831466b.27.2024.08.11.14.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 14:00:12 -0700 (PDT)
Message-ID: <6bdb5f3a-7d7b-488b-b795-68e66279f9e9@gmail.com>
Date: Mon, 12 Aug 2024 00:00:10 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 08/20] wifi: rtw88: Make txagc_remnant_ofdm an array
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Language: en-US
In-Reply-To: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

txagc_remnant_ofdm member of struct rtw_dm_info should be different for
each RF path, so make it an array of size RTW_RF_PATH_MAX (4).

Until now all the chips using this had only one RF path, but RTL8812AU
has two, and RTL8814AU has four.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/main.h     | 2 +-
 drivers/net/wireless/realtek/rtw88/phy.c      | 4 ++--
 drivers/net/wireless/realtek/rtw88/rtw8703b.c | 4 ++--
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 4 ++--
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 0cd37c3da3c3..e737cff2e1cc 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1717,7 +1717,7 @@ struct rtw_dm_info {
 	bool pwr_trk_init_trigger;
 	struct ewma_thermal avg_thermal[RTW_RF_PATH_MAX];
 	s8 txagc_remnant_cck;
-	s8 txagc_remnant_ofdm;
+	s8 txagc_remnant_ofdm[RTW_RF_PATH_MAX];
 	u8 rx_cck_agc_report_type;
 
 	/* backup dack results for each path and I/Q */
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 70f3cf06323b..a72aeafe5865 100644
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
index ffd9857348a3..52e1d3a43868 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -640,7 +640,7 @@ static void rtw8703b_pwrtrack_init(struct rtw_dev *rtwdev)
 	dm_info->pwr_trk_init_trigger = true;
 	dm_info->thermal_meter_k = rtwdev->efuse.thermal_meter_k;
 	dm_info->txagc_remnant_cck = 0;
-	dm_info->txagc_remnant_ofdm = 0;
+	dm_info->txagc_remnant_ofdm[RF_PATH_A] = 0;
 }
 
 static void rtw8703b_phy_set_param(struct rtw_dev *rtwdev)
@@ -1643,7 +1643,7 @@ static void rtw8703b_pwrtrack_set_ofdm_pwr(struct rtw_dev *rtwdev, s8 swing_idx,
 {
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 
-	dm_info->txagc_remnant_ofdm = txagc_idx;
+	dm_info->txagc_remnant_ofdm[RF_PATH_A] = txagc_idx;
 
 	/* Only path A is calibrated for rtl8703b */
 	rtw8703b_set_iqk_matrix(rtwdev, swing_idx, RF_PATH_A);
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index e31570c7b01c..f0f4423810da 100644
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
@@ -1306,7 +1306,7 @@ static void rtw8723d_pwrtrack_set_ofdm_pwr(struct rtw_dev *rtwdev, s8 swing_idx,
 {
 	struct rtw_dm_info *dm_info = &rtwdev->dm_info;
 
-	dm_info->txagc_remnant_ofdm = txagc_idx;
+	dm_info->txagc_remnant_ofdm[RF_PATH_A] = txagc_idx;
 
 	rtw8723d_set_iqk_matrix(rtwdev, swing_idx, RF_PATH_A);
 	rtw8723d_set_iqk_matrix(rtwdev, swing_idx, RF_PATH_B);
-- 
2.46.0


