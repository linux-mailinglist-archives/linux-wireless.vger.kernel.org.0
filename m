Return-Path: <linux-wireless+bounces-18469-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E81E9A27A3D
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 19:41:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 71367165C37
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:41:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 008DD217707;
	Tue,  4 Feb 2025 18:41:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RR9mG/xK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9542212FA5
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 18:41:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738694509; cv=none; b=JdNWECYl38uUM3BSQ7fFSrPnmjmAJzQl3MZQ7Tgbe1xUb4xKCCpov0KUGvoh6BfVma+3SHlrYJV7z05ZGqLrHQUcYtXqkm3D7MrvK/n466b8UmHr7yNSZR8kBVkcsnLk5uaYpc+YEGILkLtDEt2LPK/vN+sOBOo3RKpq9cL4hVI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738694509; c=relaxed/simple;
	bh=Y4hCgk7oHIpGayPx/69n9voq2LG3ZM/MuxfCme7C6Bw=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=JbH1ONTID/oWhumo6dbIJx07m/DorC8kN+6GlW1lLnVP/HiQZYthXnaks9miCJ2TeNDLFxxBGPhW8rTsKMV9/Ms3dw4pRXLXu/12/0tCZEp4Y7sI9QmVzJb65LQy5hcKlULu2PXDfmoChmpyg3bpxIQd7P7LgPqsB2MdVns50Zc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RR9mG/xK; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5dcca17340fso1631614a12.2
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 10:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738694506; x=1739299306; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=r3pp+q63a7sQf0LCKZr8ksKYVF3o87wD/ONEpTh5Wp0=;
        b=RR9mG/xKf007Hqm+Z2Mv2+iWUnIqQ72HrtqB5LTMjW27YiMffdgtGLYlu3TgRaV0+d
         8A80iDZqbX4f3kUdepzAZA4rOlKybwuYeoLGSSTBkaZngaYWsJk05mMA3P83pZUbQ2Js
         6Tf866cNsLspvGero8QUMKjb7wDBU/3xX6oPoGDkYeQsFsH7hRghVRpBmxV4D0XPJsw9
         u1byafi4rZi3WeuHJqhYz+0oBMJOTs96Elz8sRp1TByvjh1F4ch/Y81mo0mZ2aHgKWR4
         sxDn9D2Eh5MhSCtZuuF54M3VygIjoqmWLCkHwIKREy0LTM0CiLb2peo+RLDpvDV9Vpo3
         rt4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738694506; x=1739299306;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=r3pp+q63a7sQf0LCKZr8ksKYVF3o87wD/ONEpTh5Wp0=;
        b=kKS3PxFjqo0b+mph6yib2NQAWNPWg+EAdP/BVQoYdU1Dk8b+K07vH3pPWn8j7SEfIm
         TLxPjbaevR8CPFf4Cy4IQAuUC2t2EhiVEpl+M/XQvb6NJfVOWYfz9GaDXkb/lDDpELLK
         UyAtRMz2111skBSk1AI4p204PmbMdQyX5V1P5ftlW6l8FObqmbV4UKO0GXB5W+vlEFlw
         sxQ9QpeLUstO72BS1nZCKqr5TcIQml1YlMPcFD3yiyy1fndxOGZrp620SBdQuTmBKpkO
         hkiHnBgnJ48JVaNBgTXb2aAFrYU1kh/uX2GTaOEg6qy0+FUOgoZjRT9qGhgAQ6dd8V7P
         9eOA==
X-Gm-Message-State: AOJu0YxMMOzL+uDE1ZoOzUnL8P5N/xthFKA1sZNAP67UlA9M7bU9ABNY
	JgH0Vkl73TyUFWBOl9X6uVgNcrEkAvFG4r+dVUOTUXJhPIXB6k5B4z39kA==
X-Gm-Gg: ASbGncsazaB8EfPsTCjvNGx3+xDNWb+LQAcQnya3FFtoCOCyBAZyDDZRwAwg6NPP5fy
	/R4IUBMjOB/w2iGmAhYlvNgYs4otDaovL/fiI99PmOgQifWGN2Y3kJ0wPaSeNOKTswRlvJSDz59
	nVjmPHjt8CW5MMebPohb9c7LsXEJjxCTEwZiMe87br54TDUBMIt0lsnCl5c8iyBmAbusrizGS/0
	Vfe6CQwb4Lirm1d2fu6FQ6u6unNUqXmAWUcUyqMXmC8z3vDO6vgrZMQI1lFRN+Lc5bTVYhgj9HE
	vieYK1YlZyCOyYfiMoZegIX+
X-Google-Smtp-Source: AGHT+IFfbiU44x4XqYGpJAI+WEPpJ9DtZEwvhmpzyG2ESM9msu5jIjBmLm9/Adwu/0GAh6t8I8jblg==
X-Received: by 2002:a05:6402:360e:b0:5dc:5860:6881 with SMTP id 4fb4d7f45d1cf-5dcdb732ffemr105524a12.19.1738694505680;
        Tue, 04 Feb 2025 10:41:45 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dc724055e5sm10155677a12.45.2025.02.04.10.41.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 10:41:44 -0800 (PST)
Message-ID: <d0c0e126-0794-4c4e-9203-ea39a707b673@gmail.com>
Date: Tue, 4 Feb 2025 20:41:43 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 8/9] wifi: rtw88: Extend TX power stuff for 3-4 spatial
 streams
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
Content-Language: en-US
In-Reply-To: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Although the RTL8814AU only has 3 spatial streams, maybe some other chip
has 4.

Correct the TX power index and TX power limit calculations for 3SS and
4SS HT/VHT rates.

With this the RTL8814AU can set the TX power correctly.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Constify the new arrays rtw_ht_3s_rates, rtw_ht_4s_rates,
   rtw_vht_3s_rates, rtw_vht_4s_rates.
 - Make rs_cmp static const.
 - Introduce __RTW_RATE_SECTION_2SS_MAX instead of using
   RTW_RATE_SECTION_HT_3S in for loops.
---
 drivers/net/wireless/realtek/rtw88/main.h     |   5 +
 drivers/net/wireless/realtek/rtw88/phy.c      | 145 ++++++++++++------
 drivers/net/wireless/realtek/rtw88/phy.h      |   4 +
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |   2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |   2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |   2 +-
 drivers/net/wireless/realtek/rtw88/rtw88xxa.c |   2 +-
 7 files changed, 111 insertions(+), 51 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index 057141e196e6..24ac749271cc 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -166,6 +166,11 @@ enum rtw_rate_section {
 	RTW_RATE_SECTION_HT_2S,
 	RTW_RATE_SECTION_VHT_1S,
 	RTW_RATE_SECTION_VHT_2S,
+	__RTW_RATE_SECTION_2SS_MAX = RTW_RATE_SECTION_VHT_2S,
+	RTW_RATE_SECTION_HT_3S,
+	RTW_RATE_SECTION_HT_4S,
+	RTW_RATE_SECTION_VHT_3S,
+	RTW_RATE_SECTION_VHT_4S,
 
 	/* keep last */
 	RTW_RATE_SECTION_NUM,
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index e3a5f8e1e30a..b487457d2215 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -88,10 +88,40 @@ const u8 rtw_vht_2s_rates[] = {
 	DESC_RATEVHT2SS_MCS8, DESC_RATEVHT2SS_MCS9
 };
 
+const u8 rtw_ht_3s_rates[] = {
+	DESC_RATEMCS16, DESC_RATEMCS17, DESC_RATEMCS18,
+	DESC_RATEMCS19, DESC_RATEMCS20, DESC_RATEMCS21,
+	DESC_RATEMCS22, DESC_RATEMCS23
+};
+
+const u8 rtw_ht_4s_rates[] = {
+	DESC_RATEMCS24, DESC_RATEMCS25, DESC_RATEMCS26,
+	DESC_RATEMCS27, DESC_RATEMCS28, DESC_RATEMCS29,
+	DESC_RATEMCS30, DESC_RATEMCS31
+};
+
+const u8 rtw_vht_3s_rates[] = {
+	DESC_RATEVHT3SS_MCS0, DESC_RATEVHT3SS_MCS1,
+	DESC_RATEVHT3SS_MCS2, DESC_RATEVHT3SS_MCS3,
+	DESC_RATEVHT3SS_MCS4, DESC_RATEVHT3SS_MCS5,
+	DESC_RATEVHT3SS_MCS6, DESC_RATEVHT3SS_MCS7,
+	DESC_RATEVHT3SS_MCS8, DESC_RATEVHT3SS_MCS9
+};
+
+const u8 rtw_vht_4s_rates[] = {
+	DESC_RATEVHT4SS_MCS0, DESC_RATEVHT4SS_MCS1,
+	DESC_RATEVHT4SS_MCS2, DESC_RATEVHT4SS_MCS3,
+	DESC_RATEVHT4SS_MCS4, DESC_RATEVHT4SS_MCS5,
+	DESC_RATEVHT4SS_MCS6, DESC_RATEVHT4SS_MCS7,
+	DESC_RATEVHT4SS_MCS8, DESC_RATEVHT4SS_MCS9
+};
+
 const u8 * const rtw_rate_section[RTW_RATE_SECTION_NUM] = {
 	rtw_cck_rates, rtw_ofdm_rates,
 	rtw_ht_1s_rates, rtw_ht_2s_rates,
-	rtw_vht_1s_rates, rtw_vht_2s_rates
+	rtw_vht_1s_rates, rtw_vht_2s_rates,
+	rtw_ht_3s_rates, rtw_ht_4s_rates,
+	rtw_vht_3s_rates, rtw_vht_4s_rates
 };
 EXPORT_SYMBOL(rtw_rate_section);
 
@@ -101,17 +131,14 @@ const u8 rtw_rate_size[RTW_RATE_SECTION_NUM] = {
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
@@ -1640,11 +1667,15 @@ rtw_xref_5g_txpwr_lmt(struct rtw_dev *rtwdev, u8 regd,
 static void
 rtw_xref_txpwr_lmt_by_rs(struct rtw_dev *rtwdev, u8 regd, u8 bw, u8 ch_idx)
 {
+	static const u8 rs_cmp[4][2] = {
+		{RTW_RATE_SECTION_HT_1S, RTW_RATE_SECTION_VHT_1S},
+		{RTW_RATE_SECTION_HT_2S, RTW_RATE_SECTION_VHT_2S},
+		{RTW_RATE_SECTION_HT_3S, RTW_RATE_SECTION_VHT_3S},
+		{RTW_RATE_SECTION_HT_4S, RTW_RATE_SECTION_VHT_4S}
+	};
 	u8 rs_idx, rs_ht, rs_vht;
-	u8 rs_cmp[2][2] = {{RTW_RATE_SECTION_HT_1S, RTW_RATE_SECTION_VHT_1S},
-			   {RTW_RATE_SECTION_HT_2S, RTW_RATE_SECTION_VHT_2S} };
 
-	for (rs_idx = 0; rs_idx < 2; rs_idx++) {
+	for (rs_idx = 0; rs_idx < 4; rs_idx++) {
 		rs_ht = rs_cmp[rs_idx][0];
 		rs_vht = rs_cmp[rs_idx][1];
 
@@ -1965,10 +1996,10 @@ static u8 rtw_phy_get_2g_tx_power_index(struct rtw_dev *rtwdev,
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
@@ -1978,11 +2009,15 @@ static u8 rtw_phy_get_2g_tx_power_index(struct rtw_dev *rtwdev,
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
@@ -1995,11 +2030,19 @@ static u8 rtw_phy_get_2g_tx_power_index(struct rtw_dev *rtwdev,
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
 
@@ -2012,19 +2055,23 @@ static u8 rtw_phy_get_5g_tx_power_index(struct rtw_dev *rtwdev,
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
@@ -2039,11 +2086,19 @@ static u8 rtw_phy_get_5g_tx_power_index(struct rtw_dev *rtwdev,
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
@@ -2054,6 +2109,10 @@ static u8 rtw_phy_get_5g_tx_power_index(struct rtw_dev *rtwdev,
 		tx_power += pwr_idx_5g->vht_1s_diff.bw80 * factor;
 		if (above_2ss)
 			tx_power += pwr_idx_5g->vht_2s_diff.bw80 * factor;
+		if (above_3ss)
+			tx_power += pwr_idx_5g->vht_3s_diff.bw80 * factor;
+		if (above_4ss)
+			tx_power += pwr_idx_5g->vht_4s_diff.bw80 * factor;
 		break;
 	}
 
@@ -2071,10 +2130,18 @@ static u8 rtw_phy_rate_to_rate_section(u8 rate)
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
 		return RTW_RATE_SECTION_NUM;
 }
@@ -2102,7 +2169,7 @@ static s8 rtw_phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
 		bw = RTW_CHANNEL_WIDTH_20;
 
 	/* only 20/40M BW with ht */
-	if (rs == RTW_RATE_SECTION_HT_1S || rs == RTW_RATE_SECTION_HT_2S)
+	if (rate >= DESC_RATEMCS0 && rate <= DESC_RATEMCS31)
 		bw = min_t(u8, bw, RTW_CHANNEL_WIDTH_40);
 
 	/* select min power limit among [20M BW ~ current BW] */
@@ -2286,7 +2353,7 @@ rtw_phy_tx_power_by_rate_config_by_path(struct rtw_hal *hal, u8 path,
 	u8 base_idx, rate_idx;
 	s8 base_2g, base_5g;
 
-	if (rs >= RTW_RATE_SECTION_VHT_1S)
+	if (size == 10) /* VHT rates */
 		base_idx = rates[size - 3];
 	else
 		base_idx = rates[size - 1];
@@ -2303,28 +2370,12 @@ rtw_phy_tx_power_by_rate_config_by_path(struct rtw_hal *hal, u8 path,
 
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
+		for (rs = 0; rs < RTW_RATE_SECTION_NUM; rs++)
+			rtw_phy_tx_power_by_rate_config_by_path(hal, path, rs,
+				rtw_rate_size[rs], rtw_rate_section[rs]);
 }
 
 static void
diff --git a/drivers/net/wireless/realtek/rtw88/phy.h b/drivers/net/wireless/realtek/rtw88/phy.h
index ce6ee16a77dc..c9e6b869661d 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.h
+++ b/drivers/net/wireless/realtek/rtw88/phy.h
@@ -13,6 +13,10 @@ extern const u8 rtw_ht_1s_rates[];
 extern const u8 rtw_ht_2s_rates[];
 extern const u8 rtw_vht_1s_rates[];
 extern const u8 rtw_vht_2s_rates[];
+extern const u8 rtw_ht_3s_rates[];
+extern const u8 rtw_ht_4s_rates[];
+extern const u8 rtw_vht_3s_rates[];
+extern const u8 rtw_vht_4s_rates[];
 extern const u8 * const rtw_rate_section[];
 extern const u8 rtw_rate_size[];
 
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index 6abb21067aed..0ade7f11cbd2 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -709,7 +709,7 @@ static void rtw8821c_set_tx_power_index(struct rtw_dev *rtwdev)
 	int rs, path;
 
 	for (path = 0; path < hal->rf_path_num; path++) {
-		for (rs = 0; rs < RTW_RATE_SECTION_NUM; rs++) {
+		for (rs = 0; rs <= __RTW_RATE_SECTION_2SS_MAX; rs++) {
 			if (rs == RTW_RATE_SECTION_HT_2S ||
 			    rs == RTW_RATE_SECTION_VHT_2S)
 				continue;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 742a2a05632e..b4934da88e33 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -964,7 +964,7 @@ static void rtw8822b_set_tx_power_index(struct rtw_dev *rtwdev)
 	int rs, path;
 
 	for (path = 0; path < hal->rf_path_num; path++) {
-		for (rs = 0; rs < RTW_RATE_SECTION_NUM; rs++)
+		for (rs = 0; rs <= __RTW_RATE_SECTION_2SS_MAX; rs++)
 			rtw8822b_set_tx_power_index_by_rate(rtwdev, path, rs,
 							    &phy_pwr_idx);
 	}
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index 2314d160292a..5e53e0db177e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2746,7 +2746,7 @@ static void rtw8822c_set_tx_power_index(struct rtw_dev *rtwdev)
 	s8 diff_idx[4];
 
 	rtw8822c_set_write_tx_power_ref(rtwdev, pwr_ref_cck, pwr_ref_ofdm);
-	for (rs = 0; rs < RTW_RATE_SECTION_NUM; rs++) {
+	for (rs = 0; rs <= __RTW_RATE_SECTION_2SS_MAX; rs++) {
 		for (j = 0; j < rtw_rate_size[rs]; j++) {
 			rate = rtw_rate_section[rs][j];
 			pwr_a = hal->tx_pwr_tbl[RF_PATH_A][rate];
diff --git a/drivers/net/wireless/realtek/rtw88/rtw88xxa.c b/drivers/net/wireless/realtek/rtw88/rtw88xxa.c
index 109ff42eda82..0fa943271fb6 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw88xxa.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw88xxa.c
@@ -1637,7 +1637,7 @@ void rtw88xxa_set_tx_power_index(struct rtw_dev *rtwdev)
 	int rs, path;
 
 	for (path = 0; path < hal->rf_path_num; path++) {
-		for (rs = 0; rs < RTW_RATE_SECTION_NUM; rs++) {
+		for (rs = 0; rs <= __RTW_RATE_SECTION_2SS_MAX; rs++) {
 			if (hal->rf_path_num == 1 &&
 			    (rs == RTW_RATE_SECTION_HT_2S ||
 			     rs == RTW_RATE_SECTION_VHT_2S))
-- 
2.48.1


