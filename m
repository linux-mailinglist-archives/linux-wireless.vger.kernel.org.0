Return-Path: <linux-wireless+bounces-11274-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AE8D694E321
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 22:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66648280EEE
	for <lists+linux-wireless@lfdr.de>; Sun, 11 Aug 2024 20:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FC6B1537A7;
	Sun, 11 Aug 2024 20:55:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JBOV1SYz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0B20136352
	for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 20:55:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723409718; cv=none; b=uo7wukacfr90j5R1ERvabX7qK7P7CzqoEKU2ZWQjU3dZAtjRcB/po9QC4XqSKZKTXhNXdgXclJJ6RpWv7buCKPeDMx0vqH8qHuPd+FLxJBuCznGEQJHUX+iboc00HXUUKNLTVevGkf7eMjRTGicM/5F+Xn4r0/U2WQbEGvZOdvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723409718; c=relaxed/simple;
	bh=LRuNs8PD9COpEaTQi/V1VMu0SaMj377JxjI3Qu7PrIY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=FFIj0XAxZIiNCoUzStw/MxF/UOCL2OQIAIJB9MA/aY+FcfuNh5SsOL5UX6SsC7f0j5yj2lv2BIoZns+FfA0kQzO1qDlIKzcU01T+roqGeD227eF7Corw2IzIfp73Hu1+O1TqaJnQzM9GK0tg/bsOKh9f1FYldZY4CxaX0DkNvmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JBOV1SYz; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-2ef27bfd15bso40508951fa.2
        for <linux-wireless@vger.kernel.org>; Sun, 11 Aug 2024 13:55:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723409715; x=1724014515; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+cvHHuqIx73QwmNxtDrbD4S/PoaQ1mCGy26kpJabAXg=;
        b=JBOV1SYzPBLjwZLLCEY5lPYZaqfYBJgY8i0ndfTrJSEK+93sJFlpDvawMldIDpESHl
         fdtdRejn5fRarjK1AjIjPKU8o2p7Z4oyhlEEn48Sx0RajpXF2BUnqIrSBDqn3gk7KXAi
         CGt7LU2oJY7T9NzjzEG2S2oiu3AQDRqBm+x7XgkCbTjiRqz/OUYaGLSUgR5aKDMmpmGe
         X4i+pkHVyJrZHgjiRaKyI5zx/Gg9aJbpm+hCrlPgyptv/vstHvxVq3+fa9jGkE9RbzjZ
         LHPRIbHEpt7jBTZyEVOt4NE95jCsfan9DD1LvZTfi7c9wHPBY0WP8MDteJCAKUce/dFJ
         VQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723409715; x=1724014515;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+cvHHuqIx73QwmNxtDrbD4S/PoaQ1mCGy26kpJabAXg=;
        b=lIHvi+cYt9ZYWXtp+hNpv9nd3vbY4xVp1SUXodpIVUzJenDkkp6MqNfm/6tsL9ilps
         WwTtEyaFUL4AWEnYRejxWqNHt3wBYQtbMLxa6/dnXPY7p09VAgAK1sQJPw83iFStI9GP
         Ci1XkBPDAGgMhtgKV8e42Icw2mZuItQNpdiup+Wq0nzICwJVuQnxXyvmck3gGf3HHAc2
         zUsaRAtLswyoL6lqX5Z4LvSrytmWviC81o1YoXl9DpdLMmAmqcTlN9B6m6mz0ThjISoE
         geYfRyIgtGyceG8BHCN32smTFQjR039DXshfLJqgr+97uU4sKtKBMs3uJENFwamLuDSW
         wqJQ==
X-Gm-Message-State: AOJu0Yyro0DD3DV23+aSB5P5IxY9YVrT+EI6SsoUvMjcf9WXVq2lN5mB
	6jZXPljyPsAhu2RpNOVAzDnRnyrGAx0fYoF6CKtXBBqNMBpB9fUvYMiXaw==
X-Google-Smtp-Source: AGHT+IFjiLNM9yBeH5zr4HbNvYw12w8s4vRQm3PksQfrELZtqsLLcXtQP42xwgtrNyrGfavSynz6jQ==
X-Received: by 2002:a2e:9655:0:b0:2f1:9120:c920 with SMTP id 38308e7fff4ca-2f1a6d662d6mr49732541fa.45.1723409714512;
        Sun, 11 Aug 2024 13:55:14 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bd187f4fedsm1595289a12.6.2024.08.11.13.55.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Aug 2024 13:55:14 -0700 (PDT)
Message-ID: <e0de25fc-8742-4899-854e-7cbd93aaa582@gmail.com>
Date: Sun, 11 Aug 2024 23:55:12 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 03/20] wifi: rtw88: Allow different C2H RA report sizes
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Language: en-US
In-Reply-To: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

The RTL8821AU and RTL8812AU have smaller RA report size, only 4 bytes.
Avoid the "invalid ra report c2h length" error.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
 drivers/net/wireless/realtek/rtw88/fw.c       | 8 ++++++--
 drivers/net/wireless/realtek/rtw88/main.h     | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8703b.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8723d.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8822b.c | 1 +
 drivers/net/wireless/realtek/rtw88/rtw8822c.c | 1 +
 7 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
index 782f3776e0a0..ac53e3e30af0 100644
--- a/drivers/net/wireless/realtek/rtw88/fw.c
+++ b/drivers/net/wireless/realtek/rtw88/fw.c
@@ -157,7 +157,10 @@ static void rtw_fw_ra_report_iter(void *data, struct ieee80211_sta *sta)
 
 	rate = GET_RA_REPORT_RATE(ra_data->payload);
 	sgi = GET_RA_REPORT_SGI(ra_data->payload);
-	bw = GET_RA_REPORT_BW(ra_data->payload);
+	if (si->rtwdev->chip->c2h_ra_report_size < 7)
+		bw = si->bw_mode;
+	else
+		bw = GET_RA_REPORT_BW(ra_data->payload);
 
 	if (rate < DESC_RATEMCS0) {
 		si->ra_report.txrate.legacy = rtw_desc_to_bitrate(rate);
@@ -199,7 +202,8 @@ static void rtw_fw_ra_report_handle(struct rtw_dev *rtwdev, u8 *payload,
 {
 	struct rtw_fw_iter_ra_data ra_data;
 
-	if (WARN(length < 7, "invalid ra report c2h length\n"))
+	if (WARN(length < rtwdev->chip->c2h_ra_report_size,
+		 "invalid ra report c2h length %d\n", length))
 		return;
 
 	rtwdev->dm_info.tx_rate = GET_RA_REPORT_RATE(payload);
diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 16619432f450..baf3098e93ba 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -1203,6 +1203,7 @@ struct rtw_chip_info {
 
 	u8 usb_tx_agg_desc_num;
 	bool hw_feature_report;
+	u8 c2h_ra_report_size;
 
 	u8 default_1ss_tx_path;
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8703b.c b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
index c9bb779812b6..8f90320e1c51 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8703b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8703b.c
@@ -2015,6 +2015,7 @@ const struct rtw_chip_info rtw8703b_hw_spec = {
 	.ampdu_density = IEEE80211_HT_MPDU_DENSITY_16,
 	.usb_tx_agg_desc_num = 1, /* Not sure if this chip has USB interface */
 	.hw_feature_report = true,
+	.c2h_ra_report_size = 7,
 
 	.path_div_supported = false,
 	.ht_supported = true,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8723d.c b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
index fea327e5a474..85f3abee32fc 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8723d.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8723d.c
@@ -2173,6 +2173,7 @@ const struct rtw_chip_info rtw8723d_hw_spec = {
 	.dig_min = 0x20,
 	.usb_tx_agg_desc_num = 1,
 	.hw_feature_report = true,
+	.c2h_ra_report_size = 7,
 	.ht_supported = true,
 	.vht_supported = false,
 	.lps_deep_mode_supported = 0,
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index a95bca79ce02..76726632c048 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -2010,6 +2010,7 @@ const struct rtw_chip_info rtw8821c_hw_spec = {
 	.dig_min = 0x1c,
 	.usb_tx_agg_desc_num = 3,
 	.hw_feature_report = true,
+	.c2h_ra_report_size = 7,
 	.ht_supported = true,
 	.vht_supported = true,
 	.lps_deep_mode_supported = BIT(LPS_DEEP_MODE_LCLK),
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 42f055eec16b..9dde02dbbb62 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -2551,6 +2551,7 @@ const struct rtw_chip_info rtw8822b_hw_spec = {
 	.dig_min = 0x1c,
 	.usb_tx_agg_desc_num = 3,
 	.hw_feature_report = true,
+	.c2h_ra_report_size = 7,
 	.ht_supported = true,
 	.vht_supported = true,
 	.lps_deep_mode_supported = BIT(LPS_DEEP_MODE_LCLK),
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index c646bd4ec5e2..5dabcd0efb1d 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -5372,6 +5372,7 @@ const struct rtw_chip_info rtw8822c_hw_spec = {
 	.dig_min = 0x20,
 	.usb_tx_agg_desc_num = 3,
 	.hw_feature_report = true,
+	.c2h_ra_report_size = 7,
 	.default_1ss_tx_path = BB_PATH_A,
 	.path_div_supported = true,
 	.ht_supported = true,
-- 
2.46.0


