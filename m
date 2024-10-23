Return-Path: <linux-wireless+bounces-14399-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E42669ACBF4
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 16:11:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 67FDB1F21D89
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 14:11:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651F11A2C27;
	Wed, 23 Oct 2024 14:11:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Mq1bczlN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAAD41A0B1A
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 14:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729692660; cv=none; b=ZYYcoo9aBkZfcylP1sUEteTtCjPKJx0gUPDNJ9tmzPgIfQ583xaGrqPNYYI9i+p4a6A+l8ab5VuZAnI3Cy5FeYs3h82WWp+j474KaxjvTgLK+p7cACheUcp5Rk2YCbuTHVy/AsDefrRqUS3xH7PgoCTxLd21YUG6BiAksypO1l0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729692660; c=relaxed/simple;
	bh=QwmMA2JYZQGnOrOocIxxvUGFHcIIirHXf8eZPUXtvQ0=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=ZfM0slm1YceL3Q8cl4QEA34/yr7SOtHQ9N9s9dpHg7WCKcj+yQIBTDja2TU9QfdwJhzVHPBeOhmjYxJlRYFZBMBx/jF7wVAXagUzkMkEW19uCf1fyiBxgT3HDP8JBVQUid2d/+L7+sy0Px31LRKPxNRMGhOYn8MHU/Hvzdc/kpQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Mq1bczlN; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-539f72c913aso8122904e87.1
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 07:10:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729692657; x=1730297457; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=UmLdqTkkUYDTRJHZBq6UckcbdzV4/sQyhAzzg5Ja6O8=;
        b=Mq1bczlNbGqOdgx2IHO5gYAnsTOSE021AJhJRgmYjKFZPP2qTW0fhcv8Cm4cAs6miL
         0Qn6u/8nAvqD3hSrQAOmsbrgJIcndQrrBMlN+ySQRCiKNEr7LRSje9QEh+C5WZF5JYN9
         n73C+9oWg4EADg5TXS5gZARqRnLiPZeiOSC7vkQidtGMfisTpdL6gsJ3YMGrtSicclSc
         mlxGrNq4FZ/Qz+ojaNzI4/QotZjM/peF0GCjRHew+/BpqlS7y0Zot3BEncszjDBNX/mE
         stMvhFjwfy2qQLJ2uwA4QvUQAHfyrChxSPTzS90NAeXOH/o8XDyOes5tHEx8ZsVaGgrt
         Pg9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729692657; x=1730297457;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmLdqTkkUYDTRJHZBq6UckcbdzV4/sQyhAzzg5Ja6O8=;
        b=ekWsBk+ju1oE2mt4WxHJXhfDR+mjU1EkV1ujM1G/oHyjjG8Y+gSSihVkedOe/jdjCR
         ZsU9ChR13Tn7wJ1sZgz+Dih8+O3NYdBgfl5S09/BdraqWcXswAAFTgNaOvpn2KB1ALE6
         BxDnHqD349sGS8xq7TnXEOF1hT4hQOsNyWNpRvxCSlNXnGAjMX4XgT1BzXEPzw1uAZuA
         MlHY6u+KOYOkwALnuxhoaJ/SwCNN+um9xy1y0NQj3woaG83DjeTQmIwyO6Gku6Sv5T5M
         65RDeFHuNtYgJkjc7h6+HC6w2XZhhMnXFEqKEB8gK9Fn3kXKl12wAQqVpdTfwd1D6u+B
         ByqA==
X-Gm-Message-State: AOJu0YzG8x+gbxcdLwb3KpAXmM6EpbwjQ0UiTCmcQ1S7ju/se/qsjO1h
	RO7mT/bTzvh2uvW5a87dXSjxGFWnmcUSRijMuYt1OBlPqQgzyeQlML7ftw==
X-Google-Smtp-Source: AGHT+IHK3tH4f5/8y9m3bYJ57kcLjhEkyjVfDUtcbbStq13/VmIxdl7jsAFyZy8XcmpfEW74lMKn1A==
X-Received: by 2002:a05:6512:3d27:b0:539:ebe5:298e with SMTP id 2adb3069b0e04-53b1a36fdf3mr1735569e87.59.1729692656663;
        Wed, 23 Oct 2024 07:10:56 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb66a65424sm4511677a12.30.2024.10.23.07.10.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 07:10:56 -0700 (PDT)
Message-ID: <68571ba9-e504-4b2d-bfa1-62f468753649@gmail.com>
Date: Wed, 23 Oct 2024 17:10:54 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v3 08/22] wifi: rtw88: Make txagc_remnant_ofdm an array
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
Content-Language: en-US
In-Reply-To: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
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

v3:
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
index 739c619460ca..215e4af64da3 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -2171,8 +2171,8 @@ void rtw_get_tx_power_params(struct rtw_dev *rtwdev, u8 path, u8 rate, u8 bw,
 
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


