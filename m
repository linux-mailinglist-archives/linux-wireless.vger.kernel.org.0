Return-Path: <linux-wireless+bounces-18468-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BF20BA27A39
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 19:41:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 957073A3EE3
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 18:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A77A217F50;
	Tue,  4 Feb 2025 18:41:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FcafSBA4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF742185BB
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 18:41:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738694465; cv=none; b=PHX7v8xVa5WObxeaW27af7MA7ylV6Sl1d8OOLY4B72kWvhhV7R0KxRid++DqVTEBBaew101MKAlsJIq7+aRG1bTdd4QOvXDAwpZkGfjnbaxfeSx77kBwJtbUCBxctbI4xeEhHBKPku1mpgj9YO7jhwNAPI5mlovdGqpIonXx5m4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738694465; c=relaxed/simple;
	bh=24LKBN5DV5VCd98f1n2/HWgbek8zHRlXR4HpYMY4OnI=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=Y9pkRRnsmwGWNvP+nohx1KV2m0JdHK4EyxgkBGiB4X9av8dhURgYPfFAcOl/p0MKcWzWYAqM1OtQfvXUVQ4AZ2prOHubvsz3MLHUavQloO6fDf2meVq0RHOhcE2f9UARrvLusDVcGpTYvGsTpCxFzAlbZuwUukBGSQKK7MvGijU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FcafSBA4; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5da12292b67so9718433a12.3
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 10:41:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738694461; x=1739299261; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=QTpOiXdIa6atYdsGoHk/XwVWizf68gFzsv9hdAUZUE4=;
        b=FcafSBA4KNP4PCU1eMHa8RdW9695rJE7Vwz659Rf1u8D4+pHiL01Dfdem//4Eznmy6
         VSXwfq+Qx7/jcFcCGBBZEa8Rn/UujN1HNufUvDszFRFTiH3k+qDt8uVojIShInYzOiGX
         3PwFF4TVY4AJIXhtEniipCg/FZyBb6TorwmGPmDihy+bOJF48WKX9jbGpCnK7df+ivbX
         Y7FsNsAOjlKjw20+J4NyVcZClbBpg2tvcYcsFrB2SAGHjSEJZUvacMX0nyR9IHhYauNN
         vrfofyFjSAI1UTSgybeYLjHcKPMy1bnD02jGg9iqgY8XI/IBxjOqr9YD/Oe5Swzq8GOT
         hg9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738694461; x=1739299261;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QTpOiXdIa6atYdsGoHk/XwVWizf68gFzsv9hdAUZUE4=;
        b=BK1+x5NU3n7OVyC0exGJUa9PZO+wfA5PTPfty9kaF/5ltcAlWDxTvKAmhoDk5fMO9m
         Ah363eN9b03FAs5yeDVhLkjE+kAFXxODUde3FAybg64WuyTPoF8ExRY0zGc9cyPt/iX6
         mtoIgh2dixwjz3emsIR2A+NksBZ2/aGMQV5lmhCyyKzp+WwYqxXygLnuIernE1tq1NFC
         wFFZKF3X7G2Oup/9MleRRatKhjPBouk55I5sUzGgAZdTVrnYpfPz513YzyqsLjhs04NV
         COgK2WO3P8oWYKJD5xVQpG7lceS0QEp730BdpvklrsyrcYHNiBoX1LUOwwSKl55fz0p9
         T7RQ==
X-Gm-Message-State: AOJu0YyllkZu6+ODpz/Q7DpIAyoXNnP4vHKG4iNnv8wHDboOoEoxlqWL
	kTWGihkKJAT5BpgZq7GgJc28WSuHNXQoyoPNASP/Ejt/n4aepCG9BNdnOQ==
X-Gm-Gg: ASbGncvKCS/UhIwVW3nB4RDQWZ/SEuXHE1xID4kDrbFvjx1rP86yenrO3tCAO3jbdcA
	5ZRIncVoKccN4BgUrItmuWY4CYiv8M8MApUwlQ8uk2s52J80nlsXqspKNdAPBszoVoyEOAqS7k3
	shMfqM0k9rRcmcRApdMSdBYCj6fox2p7OSPwKYOflb6p8u0/r5iH0yMLkVJCmlsYhp4aYUZD6HV
	0SVNlanvOP585fiDg1DCn6E6hhUQyIo48T7dMM9TBwQOBGJ7f+jj9K8hp6xbKyac87dt1Lrp9y/
	370cWwP2VMDlWpmjaimywKAF
X-Google-Smtp-Source: AGHT+IGC71gPVuBMm5lsFR+wJiNL6ZMuTYiT1hWWxfGfGiBU0y8cNzpn33oY0x2jVLjuQk2ZWdxJaQ==
X-Received: by 2002:a05:6402:40d2:b0:5dc:740b:3cdb with SMTP id 4fb4d7f45d1cf-5dcdb7758e5mr165939a12.29.1738694460886;
        Tue, 04 Feb 2025 10:41:00 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ab7106178ccsm611483166b.9.2025.02.04.10.40.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 10:41:00 -0800 (PST)
Message-ID: <5a1c5a46-8ebb-43b0-9ab1-b78e2a22b3d2@gmail.com>
Date: Tue, 4 Feb 2025 20:40:58 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: [PATCH v2 7/9] wifi: rtw88: Rename RTW_RATE_SECTION_MAX to
 RTW_RATE_SECTION_NUM
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
Content-Language: en-US
In-Reply-To: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

It fits the meaning of the enum better.

Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
---
v2:
 - Patch is new in v2.
---
 drivers/net/wireless/realtek/rtw88/main.h     | 12 +++++-----
 drivers/net/wireless/realtek/rtw88/phy.c      | 24 +++++++++----------
 drivers/net/wireless/realtek/rtw88/rtw8821c.c |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822b.c |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw8822c.c |  2 +-
 drivers/net/wireless/realtek/rtw88/rtw88xxa.c |  2 +-
 drivers/net/wireless/realtek/rtw88/sar.c      |  2 +-
 7 files changed, 23 insertions(+), 23 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/main.h b/drivers/net/wireless/realtek/rtw88/main.h
index c982d9d3c5d7..057141e196e6 100644
--- a/drivers/net/wireless/realtek/rtw88/main.h
+++ b/drivers/net/wireless/realtek/rtw88/main.h
@@ -168,7 +168,7 @@ enum rtw_rate_section {
 	RTW_RATE_SECTION_VHT_2S,
 
 	/* keep last */
-	RTW_RATE_SECTION_MAX,
+	RTW_RATE_SECTION_NUM,
 };
 
 enum rtw_wireless_set {
@@ -1937,7 +1937,7 @@ union rtw_sar_cfg {
 
 struct rtw_sar {
 	enum rtw_sar_sources src;
-	union rtw_sar_cfg cfg[RTW_RF_PATH_MAX][RTW_RATE_SECTION_MAX];
+	union rtw_sar_cfg cfg[RTW_RF_PATH_MAX][RTW_RATE_SECTION_NUM];
 };
 
 struct rtw_hal {
@@ -1981,16 +1981,16 @@ struct rtw_hal {
 	s8 tx_pwr_by_rate_offset_5g[RTW_RF_PATH_MAX]
 				   [DESC_RATE_MAX];
 	s8 tx_pwr_by_rate_base_2g[RTW_RF_PATH_MAX]
-				 [RTW_RATE_SECTION_MAX];
+				 [RTW_RATE_SECTION_NUM];
 	s8 tx_pwr_by_rate_base_5g[RTW_RF_PATH_MAX]
-				 [RTW_RATE_SECTION_MAX];
+				 [RTW_RATE_SECTION_NUM];
 	s8 tx_pwr_limit_2g[RTW_REGD_MAX]
 			  [RTW_CHANNEL_WIDTH_MAX]
-			  [RTW_RATE_SECTION_MAX]
+			  [RTW_RATE_SECTION_NUM]
 			  [RTW_MAX_CHANNEL_NUM_2G];
 	s8 tx_pwr_limit_5g[RTW_REGD_MAX]
 			  [RTW_CHANNEL_WIDTH_MAX]
-			  [RTW_RATE_SECTION_MAX]
+			  [RTW_RATE_SECTION_NUM]
 			  [RTW_MAX_CHANNEL_NUM_5G];
 	s8 tx_pwr_tbl[RTW_RF_PATH_MAX]
 		     [DESC_RATE_MAX];
diff --git a/drivers/net/wireless/realtek/rtw88/phy.c b/drivers/net/wireless/realtek/rtw88/phy.c
index f6528016973d..e3a5f8e1e30a 100644
--- a/drivers/net/wireless/realtek/rtw88/phy.c
+++ b/drivers/net/wireless/realtek/rtw88/phy.c
@@ -88,14 +88,14 @@ const u8 rtw_vht_2s_rates[] = {
 	DESC_RATEVHT2SS_MCS8, DESC_RATEVHT2SS_MCS9
 };
 
-const u8 * const rtw_rate_section[RTW_RATE_SECTION_MAX] = {
+const u8 * const rtw_rate_section[RTW_RATE_SECTION_NUM] = {
 	rtw_cck_rates, rtw_ofdm_rates,
 	rtw_ht_1s_rates, rtw_ht_2s_rates,
 	rtw_vht_1s_rates, rtw_vht_2s_rates
 };
 EXPORT_SYMBOL(rtw_rate_section);
 
-const u8 rtw_rate_size[RTW_RATE_SECTION_MAX] = {
+const u8 rtw_rate_size[RTW_RATE_SECTION_NUM] = {
 	ARRAY_SIZE(rtw_cck_rates),
 	ARRAY_SIZE(rtw_ofdm_rates),
 	ARRAY_SIZE(rtw_ht_1s_rates),
@@ -1596,7 +1596,7 @@ static void rtw_phy_set_tx_power_limit(struct rtw_dev *rtwdev, u8 regd, u8 band,
 	ch_idx = rtw_channel_to_idx(band, ch);
 
 	if (regd >= RTW_REGD_MAX || bw >= RTW_CHANNEL_WIDTH_MAX ||
-	    rs >= RTW_RATE_SECTION_MAX || ch_idx < 0) {
+	    rs >= RTW_RATE_SECTION_NUM || ch_idx < 0) {
 		WARN(1,
 		     "wrong txpwr_lmt regd=%u, band=%u bw=%u, rs=%u, ch_idx=%u, pwr_limit=%d\n",
 		     regd, band, bw, rs, ch_idx, pwr_limit);
@@ -1701,7 +1701,7 @@ rtw_cfg_txpwr_lmt_by_alt(struct rtw_dev *rtwdev, u8 regd, u8 regd_alt)
 	u8 bw, rs;
 
 	for (bw = 0; bw < RTW_CHANNEL_WIDTH_MAX; bw++)
-		for (rs = 0; rs < RTW_RATE_SECTION_MAX; rs++)
+		for (rs = 0; rs < RTW_RATE_SECTION_NUM; rs++)
 			__cfg_txpwr_lmt_by_alt(&rtwdev->hal, regd, regd_alt,
 					       bw, rs);
 }
@@ -2060,7 +2060,7 @@ static u8 rtw_phy_get_5g_tx_power_index(struct rtw_dev *rtwdev,
 	return tx_power;
 }
 
-/* return RTW_RATE_SECTION_MAX to indicate rate is invalid */
+/* return RTW_RATE_SECTION_NUM to indicate rate is invalid */
 static u8 rtw_phy_rate_to_rate_section(u8 rate)
 {
 	if (rate >= DESC_RATE1M && rate <= DESC_RATE11M)
@@ -2076,7 +2076,7 @@ static u8 rtw_phy_rate_to_rate_section(u8 rate)
 	else if (rate >= DESC_RATEVHT2SS_MCS0 && rate <= DESC_RATEVHT2SS_MCS9)
 		return RTW_RATE_SECTION_VHT_2S;
 	else
-		return RTW_RATE_SECTION_MAX;
+		return RTW_RATE_SECTION_NUM;
 }
 
 static s8 rtw_phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
@@ -2094,7 +2094,7 @@ static s8 rtw_phy_get_tx_power_limit(struct rtw_dev *rtwdev, u8 band,
 	if (regd > RTW_REGD_WW)
 		return power_limit;
 
-	if (rs == RTW_RATE_SECTION_MAX)
+	if (rs == RTW_RATE_SECTION_NUM)
 		goto err;
 
 	/* only 20M BW with cck and ofdm */
@@ -2138,7 +2138,7 @@ static s8 rtw_phy_get_tx_power_sar(struct rtw_dev *rtwdev, u8 sar_band,
 		.rs = rs,
 	};
 
-	if (rs == RTW_RATE_SECTION_MAX)
+	if (rs == RTW_RATE_SECTION_NUM)
 		goto err;
 
 	return rtw_query_sar(rtwdev, &arg);
@@ -2227,7 +2227,7 @@ static void rtw_phy_set_tx_power_index_by_rs(struct rtw_dev *rtwdev,
 	u8 bw;
 	int i;
 
-	if (rs >= RTW_RATE_SECTION_MAX)
+	if (rs >= RTW_RATE_SECTION_NUM)
 		return;
 
 	rates = rtw_rate_section[rs];
@@ -2258,7 +2258,7 @@ static void rtw_phy_set_tx_power_level_by_path(struct rtw_dev *rtwdev,
 	else
 		rs = RTW_RATE_SECTION_OFDM;
 
-	for (; rs < RTW_RATE_SECTION_MAX; rs++)
+	for (; rs < RTW_RATE_SECTION_NUM; rs++)
 		rtw_phy_set_tx_power_index_by_rs(rtwdev, ch, path, rs);
 }
 
@@ -2353,7 +2353,7 @@ void rtw_phy_tx_power_limit_config(struct rtw_hal *hal)
 
 	for (regd = 0; regd < RTW_REGD_MAX; regd++)
 		for (bw = 0; bw < RTW_CHANNEL_WIDTH_MAX; bw++)
-			for (rs = 0; rs < RTW_RATE_SECTION_MAX; rs++)
+			for (rs = 0; rs < RTW_RATE_SECTION_NUM; rs++)
 				__rtw_phy_tx_power_limit_config(hal, regd, bw, rs);
 }
 
@@ -2389,7 +2389,7 @@ void rtw_phy_init_tx_power(struct rtw_dev *rtwdev)
 	/* init tx power limit */
 	for (regd = 0; regd < RTW_REGD_MAX; regd++)
 		for (bw = 0; bw < RTW_CHANNEL_WIDTH_MAX; bw++)
-			for (rs = 0; rs < RTW_RATE_SECTION_MAX; rs++)
+			for (rs = 0; rs < RTW_RATE_SECTION_NUM; rs++)
 				rtw_phy_init_tx_power_limit(rtwdev, regd, bw,
 							    rs);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8821c.c b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
index cc152248407c..6abb21067aed 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8821c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8821c.c
@@ -709,7 +709,7 @@ static void rtw8821c_set_tx_power_index(struct rtw_dev *rtwdev)
 	int rs, path;
 
 	for (path = 0; path < hal->rf_path_num; path++) {
-		for (rs = 0; rs < RTW_RATE_SECTION_MAX; rs++) {
+		for (rs = 0; rs < RTW_RATE_SECTION_NUM; rs++) {
 			if (rs == RTW_RATE_SECTION_HT_2S ||
 			    rs == RTW_RATE_SECTION_VHT_2S)
 				continue;
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822b.c b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
index 23a29019752d..742a2a05632e 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822b.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822b.c
@@ -964,7 +964,7 @@ static void rtw8822b_set_tx_power_index(struct rtw_dev *rtwdev)
 	int rs, path;
 
 	for (path = 0; path < hal->rf_path_num; path++) {
-		for (rs = 0; rs < RTW_RATE_SECTION_MAX; rs++)
+		for (rs = 0; rs < RTW_RATE_SECTION_NUM; rs++)
 			rtw8822b_set_tx_power_index_by_rate(rtwdev, path, rs,
 							    &phy_pwr_idx);
 	}
diff --git a/drivers/net/wireless/realtek/rtw88/rtw8822c.c b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
index ec362a817f5f..2314d160292a 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw8822c.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw8822c.c
@@ -2746,7 +2746,7 @@ static void rtw8822c_set_tx_power_index(struct rtw_dev *rtwdev)
 	s8 diff_idx[4];
 
 	rtw8822c_set_write_tx_power_ref(rtwdev, pwr_ref_cck, pwr_ref_ofdm);
-	for (rs = 0; rs < RTW_RATE_SECTION_MAX; rs++) {
+	for (rs = 0; rs < RTW_RATE_SECTION_NUM; rs++) {
 		for (j = 0; j < rtw_rate_size[rs]; j++) {
 			rate = rtw_rate_section[rs][j];
 			pwr_a = hal->tx_pwr_tbl[RF_PATH_A][rate];
diff --git a/drivers/net/wireless/realtek/rtw88/rtw88xxa.c b/drivers/net/wireless/realtek/rtw88/rtw88xxa.c
index 71e61b9c0bec..109ff42eda82 100644
--- a/drivers/net/wireless/realtek/rtw88/rtw88xxa.c
+++ b/drivers/net/wireless/realtek/rtw88/rtw88xxa.c
@@ -1637,7 +1637,7 @@ void rtw88xxa_set_tx_power_index(struct rtw_dev *rtwdev)
 	int rs, path;
 
 	for (path = 0; path < hal->rf_path_num; path++) {
-		for (rs = 0; rs < RTW_RATE_SECTION_MAX; rs++) {
+		for (rs = 0; rs < RTW_RATE_SECTION_NUM; rs++) {
 			if (hal->rf_path_num == 1 &&
 			    (rs == RTW_RATE_SECTION_HT_2S ||
 			     rs == RTW_RATE_SECTION_VHT_2S))
diff --git a/drivers/net/wireless/realtek/rtw88/sar.c b/drivers/net/wireless/realtek/rtw88/sar.c
index c472f1502b82..50b9c2412bb1 100644
--- a/drivers/net/wireless/realtek/rtw88/sar.c
+++ b/drivers/net/wireless/realtek/rtw88/sar.c
@@ -97,7 +97,7 @@ int rtw_set_sar_specs(struct rtw_dev *rtwdev,
 			power, BIT(RTW_COMMON_SAR_FCT));
 
 		for (j = 0; j < RTW_RF_PATH_MAX; j++) {
-			for (k = 0; k < RTW_RATE_SECTION_MAX; k++) {
+			for (k = 0; k < RTW_RATE_SECTION_NUM; k++) {
 				arg = (struct rtw_sar_arg){
 					.sar_band = idx,
 					.path = j,
-- 
2.48.1


