Return-Path: <linux-wireless+bounces-17985-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7AF53A1CF22
	for <lists+linux-wireless@lfdr.de>; Mon, 27 Jan 2025 00:01:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C11761666FD
	for <lists+linux-wireless@lfdr.de>; Sun, 26 Jan 2025 23:01:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9265C1CD3F;
	Sun, 26 Jan 2025 23:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NeZO6rkg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f47.google.com (mail-wm1-f47.google.com [209.85.128.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57DFA25A641
	for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 23:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737932467; cv=none; b=Iq1n+3IMIZKK1OpF8A8eqUNWPlaC4cdVcus42oVfx+9TRILDGwK/a4g7TfjoHzE0coH4T9Nyd9BAO/itnGr/XzVpGT8/zhOmxo3nqIxXDU1vt3Ubx2pDybeBsc+svQidIt4TjZTYASyMEERkNi5poy1qojS3/MFfjmYqHnzwi7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737932467; c=relaxed/simple;
	bh=LZYpsk3HKopAbKmcYBK0cFyW1OmjljKfv8zYpvhEjJg=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cehaCU4RAEHf0bYiA3KxjGYK/+IkOTuFsNCQjcRV5cr0oplKRRxS54dhMoLdwb/Y9gpYqVXjnCl/LjqsXu/B/hgZVmsDuryYZIArETiAxny8b6EZUie8s+31MZfFIuBCv7dHZFKTifdt6p7WXGMSLTyrnH1YNgxkrBJYYAlCUmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NeZO6rkg; arc=none smtp.client-ip=209.85.128.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f47.google.com with SMTP id 5b1f17b1804b1-43621d27adeso25079275e9.2
        for <linux-wireless@vger.kernel.org>; Sun, 26 Jan 2025 15:01:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1737932463; x=1738537263; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Chdyhy4X+Nhz8WiLvFQTte8qdLKysMf9IM8MhkwfZyY=;
        b=NeZO6rkg9Dy+vmP2QZJ2PAZJ0m+pvjtqbHMrYV1PIcw2URLGYha5v8nftYWpcg0E5g
         fdZLZ7oVaQcfiIed0X9sOATIJFcwX4Nzx/2o7TJ7s9z/A0T19n1RR8OX3fKQQU8ufY/k
         0qwLH8fLq2bZhKBd07ILN79EF6/+XHyykOipYbqtZpqFYsrHOcudlRC2RA7aIL3yNoVQ
         KnuPYF+Q77To7QibCtMp7FaOn1ztGLwgrizA+iAQzclGbzooX8xRJfJHdgYKqiEqPq4O
         wHtaQiqPgRlLuE7Twum9HmH8WnzC2rL5JQPK9K1w4GMPugrnf8K07X/O/X3KPBEC/UGN
         hRVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737932463; x=1738537263;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Chdyhy4X+Nhz8WiLvFQTte8qdLKysMf9IM8MhkwfZyY=;
        b=eLiFHKgbiRm2JsJeJX0pf1jxh/nxKzXQqp4W52dAffZAcuHIhp3VT84qPxlNELn7pd
         Ap72R99Hpp11kpEfI4KodfgJGva/nBK/OAKNzU3F8FITn/lgZb1ul1s34wgGecvRxXrP
         eVKV1l82iV1M1tXdfXy3VJn+KxtMYwpvYmMxFVDTSnkefHp8C3dE7eiWJBCmwj8nq5qR
         IS/2ExrP4ujbUPRJGRwzq1BJCsf8eWNcmfw9L77BFF1irgNBVDAFL+5qaPN9o++nbBlH
         AdyG7V9aiX1NTvQtJREoJfModJCQhjYI9t9RR9ntRgc3x5Yf0V4oTGEBiWhj+3az2Cv2
         /jxw==
X-Gm-Message-State: AOJu0YxuZ3xv2z7S9XrigOkGNnDF9TTDEv8cJMc75vXXZffy7ScPxjWB
	AScWP64yuAM1ewLuwSio6zBgetw5PO+dmxA5NgtQJU98cDBiO2HNvoiI0w==
X-Gm-Gg: ASbGncsHixqEc87ptvCB2HMGJ3v3XwxWVhZ+CnEZiX0x/q50k6YAx1J6wBlxw4EAagt
	qlr9D+eP4NF+YxrTKXIjNL+CNfAKgHYy78ZlNGQpedUmTr3fXs1CZO/Nr+OOpHfZCY+C0yejb/H
	8TSoGEm0zKLfzlMQIW5eXae4pVfs8m8Z30drBO3cxEJFMYduNgTlTOc7StkiIG9dL1wtth5ZOuv
	Og8KscNKiJIRXl+QPk5O0aTQ2ONRJvk/vvm9wB3HRALha6VQP8ljPt00UNrzazf0wH4Yyq1Tj0W
	0JcNcZFztiy7
X-Google-Smtp-Source: AGHT+IFSPp9yLFHZZWpC4xPIOSBESJujT2TEYemPTR2exp4cjNOEBxrNVH9hIjzG5rgxO7FiHR6H6g==
X-Received: by 2002:a5d:6d8d:0:b0:38a:88bc:ace1 with SMTP id ffacd0b85a97d-38bf57a9608mr31829871f8f.34.1737932463379;
        Sun, 26 Jan 2025 15:01:03 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38c2a1ca723sm9166051f8f.101.2025.01.26.15.01.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Jan 2025 15:01:02 -0800 (PST)
Message-ID: <b5b39106-406c-40fb-a3db-6f755467d6a7@gmail.com>
Date: Mon, 27 Jan 2025 01:01:00 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH 6/7] wifi: rtw88: Extend TX power stuff for 3-4 spatial
 streams
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>
Content-Language: en-US
In-Reply-To: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Although the RTL8814AU only has 3 spatial streams, maybe some other chip
has 4.

Correct the TX power index and TX power limit calculations for 3SS and
4SS HT/VHT rates.

With this the RTL8814AU can set the TX power correctly.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
I just realised this patch depends on another pending patch:
https://lore.kernel.org/linux-wireless/8a60f581-0ab5-4d98-a97d-dd83b605008f@gmail.com/

Originally this patch was going to be in part 2, but then I rearranged
them. Too late to turn back now...
---
 drivers/net/wireless/realtek/rtw88/main.h     |   4 +
 drivers/net/wireless/realtek/rtw88/phy.c      | 149 ++++++++++++------
 drivers/net/wireless/realtek/rtw88/phy.h      |   4 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |   2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |   2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |   2 +-
 drivers/net/wireless/realtek/rtw88/rtw88xxa.c |   2 +-
 7 files changed, 114 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index ba64d269521a..bbae6d7c1aa9 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -166,6 +166,10 @@ enum rtw_rate_section {
 	RTW_RATE_SECTION_HT_2S,
 	RTW_RATE_SECTION_VHT_1S,
 	RTW_RATE_SECTION_VHT_2S,
+	RTW_RATE_SECTION_HT_3S,
+	RTW_RATE_SECTION_HT_4S,
+	RTW_RATE_SECTION_VHT_3S,
+	RTW_RATE_SECTION_VHT_4S,
 
 	/* keep last */
 	RTW_RATE_SECTION_MAX,
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index 8ed20c89d216..5ddc9d4988b8 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -53,21 +53,25 @@ static const u32 db_invert_table[12][8] = {
 };
 
 u8 rtw_cck_rates[] = { DESC_RATE1M, DESC_RATE2M, DESC_RATE5_5M, DESC_RATE11M };
+
 u8 rtw_ofdm_rates[] = {
 	DESC_RATE6M,  DESC_RATE9M,  DESC_RATE12M,
 	DESC_RATE18M, DESC_RATE24M, DESC_RATE36M,
 	DESC_RATE48M, DESC_RATE54M
 };
+
 u8 rtw_ht_1s_rates[] = {
 	DESC_RATEMCS0, DESC_RATEMCS1, DESC_RATEMCS2,
 	DESC_RATEMCS3, DESC_RATEMCS4, DESC_RATEMCS5,
 	DESC_RATEMCS6, DESC_RATEMCS7
 };
+
 u8 rtw_ht_2s_rates[] = {
 	DESC_RATEMCS8,  DESC_RATEMCS9,  DESC_RATEMCS10,
 	DESC_RATEMCS11, DESC_RATEMCS12, DESC_RATEMCS13,
 	DESC_RATEMCS14, DESC_RATEMCS15
 };
+
 u8 rtw_vht_1s_rates[] = {
 	DESC_RATEVHT1SS_MCS0, DESC_RATEVHT1SS_MCS1,
 	DESC_RATEVHT1SS_MCS2, DESC_RATEVHT1SS_MCS3,
@@ -75,6 +79,7 @@ u8 rtw_vht_1s_rates[] = {
 	DESC_RATEVHT1SS_MCS6, DESC_RATEVHT1SS_MCS7,
 	DESC_RATEVHT1SS_MCS8, DESC_RATEVHT1SS_MCS9
 };
+
 u8 rtw_vht_2s_rates[] = {
 	DESC_RATEVHT2SS_MCS0, DESC_RATEVHT2SS_MCS1,
 	DESC_RATEVHT2SS_MCS2, DESC_RATEVHT2SS_MCS3,
@@ -82,10 +87,41 @@ u8 rtw_vht_2s_rates[] = {
 	DESC_RATEVHT2SS_MCS6, DESC_RATEVHT2SS_MCS7,
 	DESC_RATEVHT2SS_MCS8, DESC_RATEVHT2SS_MCS9
 };
+
+u8 rtw_ht_3s_rates[] = {
+	DESC_RATEMCS16, DESC_RATEMCS17, DESC_RATEMCS18,
+	DESC_RATEMCS19, DESC_RATEMCS20, DESC_RATEMCS21,
+	DESC_RATEMCS22, DESC_RATEMCS23
+};
+
+u8 rtw_ht_4s_rates[] = {
+	DESC_RATEMCS24, DESC_RATEMCS25, DESC_RATEMCS26,
+	DESC_RATEMCS27, DESC_RATEMCS28, DESC_RATEMCS29,
+	DESC_RATEMCS30, DESC_RATEMCS31
+};
+
+u8 rtw_vht_3s_rates[] = {
+	DESC_RATEVHT3SS_MCS0, DESC_RATEVHT3SS_MCS1,
+	DESC_RATEVHT3SS_MCS2, DESC_RATEVHT3SS_MCS3,
+	DESC_RATEVHT3SS_MCS4, DESC_RATEVHT3SS_MCS5,
+	DESC_RATEVHT3SS_MCS6, DESC_RATEVHT3SS_MCS7,
+	DESC_RATEVHT3SS_MCS8, DESC_RATEVHT3SS_MCS9
+};
+
+u8 rtw_vht_4s_rates[] = {
+	DESC_RATEVHT4SS_MCS0, DESC_RATEVHT4SS_MCS1,
+	DESC_RATEVHT4SS_MCS2, DESC_RATEVHT4SS_MCS3,
+	DESC_RATEVHT4SS_MCS4, DESC_RATEVHT4SS_MCS5,
+	DESC_RATEVHT4SS_MCS6, DESC_RATEVHT4SS_MCS7,
+	DESC_RATEVHT4SS_MCS8, DESC_RATEVHT4SS_MCS9
+};
+
 u8 *rtw_rate_section[RTW_RATE_SECTION_MAX] = {
 	rtw_cck_rates, rtw_ofdm_rates,
 	rtw_ht_1s_rates, rtw_ht_2s_rates,
-	rtw_vht_1s_rates, rtw_vht_2s_rates
+	rtw_vht_1s_rates, rtw_vht_2s_rates,
+	rtw_ht_3s_rates, rtw_ht_4s_rates,
+	rtw_vht_3s_rates, rtw_vht_4s_rates
 };
 EXPORT_SYMBOL(rtw_rate_section);
 
@@ -95,17 +131,14 @@ u8 rtw_rate_size[RTW_RATE_SECTION_MAX] = {
 	ARRAY_SIZE(rtw_ht_1s_rates),
 	ARRAY_SIZE(rtw_ht_2s_rates),
 	ARRAY_SIZE(rtw_vht_1s_rates),
-	ARRAY_SIZE(rtw_vht_2s_rates)
+	ARRAY_SIZE(rtw_vht_2s_rates),
+	ARRAY_SIZE(rtw_ht_3s_rates),
+	ARRAY_SIZE(rtw_ht_4s_rates),
+	ARRAY_SIZE(rtw_vht_3s_rates),
+	ARRAY_SIZE(rtw_vht_4s_rates)
 };
 EXPORT_SYMBOL(rtw_rate_size);
 
-static const u8 rtw_cck_size = ARRAY_SIZE(rtw_cck_rates);
-static const u8 rtw_ofdm_size = ARRAY_SIZE(rtw_ofdm_rates);
-static const u8 rtw_ht_1s_size = ARRAY_SIZE(rtw_ht_1s_rates);
-static const u8 rtw_ht_2s_size = ARRAY_SIZE(rtw_ht_2s_rates);
-static const u8 rtw_vht_1s_size = ARRAY_SIZE(rtw_vht_1s_rates);
-static const u8 rtw_vht_2s_size = ARRAY_SIZE(rtw_vht_2s_rates);
-
 enum rtw_phy_band_type {
 	PHY_BAND_2G	= 0,
 	PHY_BAND_5G	= 1,
@@ -1635,10 +1668,12 @@ static void
 rtw_xref_txpwr_lmt_by_rs(struct rtw_dev *rtwdev, u8 regd, u8 bw, u8 ch_idx)
 {
 	u8 rs_idx, rs_ht, rs_vht;
-	u8 rs_cmp[2][2] = {{RTW_RATE_SECTION_HT_1S, RTW_RATE_SECTION_VHT_1S},
-			   {RTW_RATE_SECTION_HT_2S, RTW_RATE_SECTION_VHT_2S} };
+	u8 rs_cmp[4][2] = {{RTW_RATE_SECTION_HT_1S, RTW_RATE_SECTION_VHT_1S},
+			   {RTW_RATE_SECTION_HT_2S, RTW_RATE_SECTION_VHT_2S},
+			   {RTW_RATE_SECTION_HT_3S, RTW_RATE_SECTION_VHT_3S},
+			   {RTW_RATE_SECTION_HT_4S, RTW_RATE_SECTION_VHT_4S} };
 
-	for (rs_idx = 0; rs_idx < 2; rs_idx++) {
+	for (rs_idx = 0; rs_idx < 4; rs_idx++) {
 		rs_ht = rs_cmp[rs_idx][0];
 		rs_vht = rs_cmp[rs_idx][1];
 
@@ -1959,10 +1994,10 @@ static u8 rtw_phy_get_2g_tx_power_index(struct rtw_dev *rtwdev,
 					u8 rate, u8 group)
 {
 	const struct rtw_chip_info *chip = rtwdev->chip;
-	u8 tx_power;
-	bool mcs_rate;
-	bool above_2ss;
+	bool above_2ss, above_3ss, above_4ss;
 	u8 factor = chip->txgi_factor;
+	bool mcs_rate;
+	u8 tx_power;
 
 	if (rate <= DESC_RATE11M)
 		tx_power = pwr_idx_2g->cck_base[group];
@@ -1972,11 +2007,15 @@ static u8 rtw_phy_get_2g_tx_power_index(struct rtw_dev *rtwdev,
 	if (rate >= DESC_RATE6M && rate <= DESC_RATE54M)
 		tx_power += pwr_idx_2g->ht_1s_diff.ofdm * factor;
 
-	mcs_rate = (rate >= DESC_RATEMCS0 && rate <= DESC_RATEMCS15) ||
+	mcs_rate = (rate >= DESC_RATEMCS0 && rate <= DESC_RATEMCS31) ||
 		   (rate >= DESC_RATEVHT1SS_MCS0 &&
-		    rate <= DESC_RATEVHT2SS_MCS9);
-	above_2ss = (rate >= DESC_RATEMCS8 && rate <= DESC_RATEMCS15) ||
+		    rate <= DESC_RATEVHT4SS_MCS9);
+	above_2ss = (rate >= DESC_RATEMCS8 && rate <= DESC_RATEMCS31) ||
 		    (rate >= DESC_RATEVHT2SS_MCS0);
+	above_3ss = (rate >= DESC_RATEMCS16 && rate <= DESC_RATEMCS31) ||
+		    (rate >= DESC_RATEVHT3SS_MCS0);
+	above_4ss = (rate >= DESC_RATEMCS24 && rate <= DESC_RATEMCS31) ||
+		    (rate >= DESC_RATEVHT4SS_MCS0);
 
 	if (!mcs_rate)
 		return tx_power;
@@ -1989,11 +2028,19 @@ static u8 rtw_phy_get_2g_tx_power_index(struct rtw_dev *rtwdev,
 		tx_power += pwr_idx_2g->ht_1s_diff.bw20 * factor;
 		if (above_2ss)
 			tx_power += pwr_idx_2g->ht_2s_diff.bw20 * factor;
+		if (above_3ss)
+			tx_power += pwr_idx_2g->ht_3s_diff.bw20 * factor;
+		if (above_4ss)
+			tx_power += pwr_idx_2g->ht_4s_diff.bw20 * factor;
 		break;
 	case RTW_CHANNEL_WIDTH_40:
 		/* bw40 is the base power */
 		if (above_2ss)
 			tx_power += pwr_idx_2g->ht_2s_diff.bw40 * factor;
+		if (above_3ss)
+			tx_power += pwr_idx_2g->ht_3s_diff.bw40 * factor;
+		if (above_4ss)
+			tx_power += pwr_idx_2g->ht_4s_diff.bw40 * factor;
 		break;
 	}
 
@@ -2006,19 +2053,23 @@ static u8 rtw_phy_get_5g_tx_power_index(struct rtw_dev *rtwdev,
 					u8 rate, u8 group)
 {
 	const struct rtw_chip_info *chip = rtwdev->chip;
-	u8 tx_power;
+	bool above_2ss, above_3ss, above_4ss;
+	u8 factor = chip->txgi_factor;
 	u8 upper, lower;
 	bool mcs_rate;
-	bool above_2ss;
-	u8 factor = chip->txgi_factor;
+	u8 tx_power;
 
 	tx_power = pwr_idx_5g->bw40_base[group];
 
-	mcs_rate = (rate >= DESC_RATEMCS0 && rate <= DESC_RATEMCS15) ||
+	mcs_rate = (rate >= DESC_RATEMCS0 && rate <= DESC_RATEMCS31) ||
 		   (rate >= DESC_RATEVHT1SS_MCS0 &&
-		    rate <= DESC_RATEVHT2SS_MCS9);
-	above_2ss = (rate >= DESC_RATEMCS8 && rate <= DESC_RATEMCS15) ||
+		    rate <= DESC_RATEVHT4SS_MCS9);
+	above_2ss = (rate >= DESC_RATEMCS8 && rate <= DESC_RATEMCS31) ||
 		    (rate >= DESC_RATEVHT2SS_MCS0);
+	above_3ss = (rate >= DESC_RATEMCS16 && rate <= DESC_RATEMCS31) ||
+		    (rate >= DESC_RATEVHT3SS_MCS0);
+	above_4ss = (rate >= DESC_RATEMCS24 && rate <= DESC_RATEMCS31) ||
+		    (rate >= DESC_RATEVHT4SS_MCS0);
 
 	if (!mcs_rate) {
 		tx_power += pwr_idx_5g->ht_1s_diff.ofdm * factor;
@@ -2033,11 +2084,19 @@ static u8 rtw_phy_get_5g_tx_power_index(struct rtw_dev *rtwdev,
 		tx_power += pwr_idx_5g->ht_1s_diff.bw20 * factor;
 		if (above_2ss)
 			tx_power += pwr_idx_5g->ht_2s_diff.bw20 * factor;
+		if (above_3ss)
+			tx_power += pwr_idx_5g->ht_3s_diff.bw20 * factor;
+		if (above_4ss)
+			tx_power += pwr_idx_5g->ht_4s_diff.bw20 * factor;
 		break;
 	case RTW_CHANNEL_WIDTH_40:
 		/* bw40 is the base power */
 		if (above_2ss)
 			tx_power += pwr_idx_5g->ht_2s_diff.bw40 * factor;
+		if (above_3ss)
+			tx_power += pwr_idx_5g->ht_3s_diff.bw40 * factor;
+		if (above_4ss)
+			tx_power += pwr_idx_5g->ht_4s_diff.bw40 * factor;
 		break;
 	case RTW_CHANNEL_WIDTH_80:
 		/* the base idx of bw80 is the average of bw40+/bw40- */
@@ -2048,6 +2107,10 @@ static u8 rtw_phy_get_5g_tx_power_index(struct rtw_dev *rtwdev,
 		tx_power += pwr_idx_5g->vht_1s_diff.bw80 * factor;
 		if (above_2ss)
 			tx_power += pwr_idx_5g->vht_2s_diff.bw80 * factor;
+		if (above_3ss)
+			tx_power += pwr_idx_5g->vht_3s_diff.bw80 * factor;
+		if (above_4ss)
+			tx_power += pwr_idx_5g->vht_4s_diff.bw80 * factor;
 		break;
 	}
 
@@ -2065,10 +2128,18 @@ static u8 rtw_phy_rate_to_rate_section(u8 rate)
 		return RTW_RATE_SECTION_HT_1S;
 	else if (rate >= DESC_RATEMCS8 && rate <= DESC_RATEMCS15)
 		return RTW_RATE_SECTION_HT_2S;
+	else if (rate >= DESC_RATEMCS16 && rate <= DESC_RATEMCS23)
+		return RTW_RATE_SECTION_HT_3S;
+	else if (rate >= DESC_RATEMCS24 && rate <= DESC_RATEMCS31)
+		return RTW_RATE_SECTION_HT_4S;
 	else if (rate >= DESC_RATEVHT1SS_MCS0 && rate <= DESC_RATEVHT1SS_MCS9)
 		return RTW_RATE_SECTION_VHT_1S;
 	else if (rate >= DESC_RATEVHT2SS_MCS0 && rate <= DESC_RATEVHT2SS_MCS9)
 		return RTW_RATE_SECTION_VHT_2S;
+	else if (rate >= DESC_RATEVHT3SS_MCS0 && rate <= DESC_RATEVHT3SS_MCS9)
+		return RTW_RATE_SECTION_VHT_3S;
+	else if (rate >= DESC_RATEVHT4SS_MCS0 && rate <= DESC_RATEVHT4SS_MCS9)
+		return RTW_RATE_SECTION_VHT_4S;
 	else
 		return RTW_RATE_SECTION_MAX;
 }
@@ -2096,7 +2167,7 @@ static s8 rtw_phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
 		bw = RTW_CHANNEL_WIDTH_20;
 
 	/* only 20/40M BW with ht */
-	if (rs == RTW_RATE_SECTION_HT_1S || rs == RTW_RATE_SECTION_HT_2S)
+	if (rate >= DESC_RATEMCS0 && rate <= DESC_RATEMCS31)
 		bw = min_t(u8, bw, RTW_CHANNEL_WIDTH_40);
 
 	/* select min power limit among [20M BW ~ current BW] */
@@ -2280,7 +2351,7 @@ rtw_phy_tx_power_by_rate_config_by_path(struct rtw_hal *hal, u8 path,
 	u8 base_idx, rate_idx;
 	s8 base_2g, base_5g;
 
-	if (rs >= RTW_RATE_SECTION_VHT_1S)
+	if (size == 10) /* VHT rates */
 		base_idx = rates[size - 3];
 	else
 		base_idx = rates[size - 1];
@@ -2297,28 +2368,12 @@ rtw_phy_tx_power_by_rate_config_by_path(struct rtw_hal *hal, u8 path,
 
 void rtw_phy_tx_power_by_rate_config(struct rtw_hal *hal)
 {
-	u8 path;
+	u8 path, rs;
 
-	for (path = 0; path < RTW_RF_PATH_MAX; path++) {
-		rtw_phy_tx_power_by_rate_config_by_path(hal, path,
-				RTW_RATE_SECTION_CCK,
-				rtw_cck_size, rtw_cck_rates);
-		rtw_phy_tx_power_by_rate_config_by_path(hal, path,
-				RTW_RATE_SECTION_OFDM,
-				rtw_ofdm_size, rtw_ofdm_rates);
-		rtw_phy_tx_power_by_rate_config_by_path(hal, path,
-				RTW_RATE_SECTION_HT_1S,
-				rtw_ht_1s_size, rtw_ht_1s_rates);
-		rtw_phy_tx_power_by_rate_config_by_path(hal, path,
-				RTW_RATE_SECTION_HT_2S,
-				rtw_ht_2s_size, rtw_ht_2s_rates);
-		rtw_phy_tx_power_by_rate_config_by_path(hal, path,
-				RTW_RATE_SECTION_VHT_1S,
-				rtw_vht_1s_size, rtw_vht_1s_rates);
-		rtw_phy_tx_power_by_rate_config_by_path(hal, path,
-				RTW_RATE_SECTION_VHT_2S,
-				rtw_vht_2s_size, rtw_vht_2s_rates);
-	}
+	for (path = 0; path < RTW_RF_PATH_MAX; path++)
+		for (rs = 0; rs < RTW_RATE_SECTION_MAX; rs++)
+			rtw_phy_tx_power_by_rate_config_by_path(hal, path, rs,
+				rtw_rate_size[rs], rtw_rate_section[rs]);
 }
 
 static void
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index ccfcbd3ced03..707576d04262 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -13,6 +13,10 @@ extern u8 rtw_ht_1s_rates[];
 extern u8 rtw_ht_2s_rates[];
 extern u8 rtw_vht_1s_rates[];
 extern u8 rtw_vht_2s_rates[];
+extern u8 rtw_ht_3s_rates[];
+extern u8 rtw_ht_4s_rates[];
+extern u8 rtw_vht_3s_rates[];
+extern u8 rtw_vht_4s_rates[];
 extern u8 *rtw_rate_section[];
 extern u8 rtw_rate_size[];
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index cc152248407c..106a9e38e428 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -709,7 +709,7 @@ static void rtw8821c_set_tx_power_index(struct rtw_dev *rtwdev)
 	int rs, path;
 
 	for (path = 0; path < hal->rf_path_num; path++) {
-		for (rs = 0; rs < RTW_RATE_SECTION_MAX; rs++) {
+		for (rs = 0; rs < RTW_RATE_SECTION_HT_3S; rs++) {
 			if (rs == RTW_RATE_SECTION_HT_2S ||
 			    rs == RTW_RATE_SECTION_VHT_2S)
 				continue;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 23a29019752d..5472fbf2b498 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -964,7 +964,7 @@ static void rtw8822b_set_tx_power_index(struct rtw_dev *rtwdev)
 	int rs, path;
 
 	for (path = 0; path < hal->rf_path_num; path++) {
-		for (rs = 0; rs < RTW_RATE_SECTION_MAX; rs++)
+		for (rs = 0; rs < RTW_RATE_SECTION_HT_3S; rs++)
 			rtw8822b_set_tx_power_index_by_rate(rtwdev, path, rs,
 							    &phy_pwr_idx);
 	}
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index ec362a817f5f..aea9a20eab59 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2746,7 +2746,7 @@ static void rtw8822c_set_tx_power_index(struct rtw_dev *rtwdev)
 	s8 diff_idx[4];
 
 	rtw8822c_set_write_tx_power_ref(rtwdev, pwr_ref_cck, pwr_ref_ofdm);
-	for (rs = 0; rs < RTW_RATE_SECTION_MAX; rs++) {
+	for (rs = 0; rs < RTW_RATE_SECTION_HT_3S; rs++) {
 		for (j = 0; j < rtw_rate_size[rs]; j++) {
 			rate = rtw_rate_section[rs][j];
 			pwr_a = hal->tx_pwr_tbl[RF_PATH_A][rate];
diff --git a/drivers/net/wireless/realtek/rtw88/rtw88xxa.c b/drivers/net/wireless/realtek/rtw88/rtw88xxa.c
index 71e61b9c0bec..08bbd84733d1 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw88xxa.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw88xxa.c
@@ -1637,7 +1637,7 @@ void rtw88xxa_set_tx_power_index(struct rtw_dev *rtwdev)
 	int rs, path;
 
 	for (path = 0; path < hal->rf_path_num; path++) {
-		for (rs = 0; rs < RTW_RATE_SECTION_MAX; rs++) {
+		for (rs = 0; rs < RTW_RATE_SECTION_HT_3S; rs++) {
 			if (hal->rf_path_num == 1 &&
 			    (rs == RTW_RATE_SECTION_HT_2S ||
 			     rs == RTW_RATE_SECTION_VHT_2S))
-- 
2.48.1


