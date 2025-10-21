Return-Path: <linux-wireless+bounces-28144-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B65B3BF6CD6
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 15:35:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C1A519A5FC6
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Oct 2025 13:35:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6B0713385A3;
	Tue, 21 Oct 2025 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="R0y/vBQY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C795F280CC1
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 13:34:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761053667; cv=none; b=j4hL6jcaApmgZRl5kHEEq7uQTm0gNKve1yEHMeINsfDDzcbvd/jO6unLwiV6IseJnBjr2/anzOk21Occ1beA0/Rf2KQtsmx6URvteBXOi3o+6rPIKg3nNo+s0WBUTaVs5CYFydwqd/MgHTg2nrRoTt2OIElN3aIIGbjxjjZuDoY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761053667; c=relaxed/simple;
	bh=UE3TM9ZEPFMOS/eOr6U2b3n4LIQftAmJmpmdzHrnrkM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OQDkAkTzkHu8SxenLVDk1YcjNj8uGJnmh369YKySvm8Kwp3V9SdDhWBZUX3/84EDegNJPEgpq1BnVwerkZT0489y9hF+IWBxNEOHxKCMVVXSKBYyRWPfbDG4/P0lYwRBuvXZXBjCdMR9qGOkHGgds9iSIj7oDewRIsVAvffclf0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=R0y/vBQY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59LDYLkY43088099, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1761053661; bh=lBnwTYaS1nEaUpLhvQMVKriQi8/0/BYuRQWZPuXIVYY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=R0y/vBQYF/n+18t2m6bNHqOf08okfV5qBQ94WGnDLrB384AZkS6GZ7HZBlwu2IIQg
	 8LZ1ZpMZo1hwoPdJwd3u4lW4Hx+JY7xSHehxxEuQNtxqlIGVTJ84AjhtVHKKJbqq1Y
	 xSqhkMT4+lRGCgfI+CFojYpDq6fncRu7/EgR8loeI7lFvJwoAMrY7Gkj6Nw5ui0jXo
	 L7xMM7wPeR+/VwXbsheApJVMhe8LFBK6in4wMQJ4Jf3n8xMo8GOSWb+H1ewS2QYj8I
	 +MtRfZHlWU3wmKWsPViLCYMrbydu8DGzbq/KbB2f8siNXMj3s3p8P77z6pYW+39aSk
	 3b42+Wx+cFpLQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59LDYLkY43088099
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Tue, 21 Oct 2025 21:34:21 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 21:34:21 +0800
Received: from RTKEXHMBS04.realtek.com.tw (10.21.1.54) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 21 Oct 2025 21:34:20 +0800
Received: from [127.0.1.1] (10.22.225.127) by RTKEXHMBS04.realtek.com.tw
 (10.21.1.54) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.27 via Frontend
 Transport; Tue, 21 Oct 2025 21:34:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <timlee@realtek.com>, <emma_tsai@realtek.com>, <damon.chen@realtek.com>,
        <kevin_yang@realtek.com>
Subject: [rtw-next 4/8] wifi: rtw89: support EHT rate pattern via bitrate mask
Date: Tue, 21 Oct 2025 21:33:58 +0800
Message-ID: <20251021133402.15467-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20251021133402.15467-1-pkshih@realtek.com>
References: <20251021133402.15467-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain

From: Zong-Zhe Yang <kevin_yang@realtek.com>

When setting bitrate mask, e.g. using iw set bitrates, there are some
designated patterns to be recognized, called rate pattern. When a rate
pattern is matched, treat the setting as asking a fixed rate. Now, add
support to recognize EHT rates.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/phy.c | 39 +++++++++++++++++++++++-
 1 file changed, 38 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index ba7feadd7582..23892c1359a5 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -231,7 +231,12 @@ static u64 rtw89_phy_ra_mask_cfg(struct rtw89_dev *rtwdev,
 		return -1;
 	}
 
-	if (link_sta->he_cap.has_he) {
+	if (link_sta->eht_cap.has_eht) {
+		cfg_mask |= u64_encode_bits(mask->control[band].eht_mcs[0],
+					    RA_MASK_EHT_1SS_RATES);
+		cfg_mask |= u64_encode_bits(mask->control[band].eht_mcs[1],
+					    RA_MASK_EHT_2SS_RATES);
+	} else if (link_sta->he_cap.has_he) {
 		cfg_mask |= u64_encode_bits(mask->control[band].he_mcs[0],
 					    RA_MASK_HE_1SS_RATES);
 		cfg_mask |= u64_encode_bits(mask->control[band].he_mcs[1],
@@ -557,6 +562,14 @@ static bool __check_rate_pattern(struct rtw89_phy_rate_pattern *next,
 	return true;
 }
 
+enum __rtw89_hw_rate_invalid_bases {
+	/* no EHT rate for ax chip */
+	RTW89_HW_RATE_EHT_NSS1_MCS0 = RTW89_HW_RATE_INVAL,
+	RTW89_HW_RATE_EHT_NSS2_MCS0 = RTW89_HW_RATE_INVAL,
+	RTW89_HW_RATE_EHT_NSS3_MCS0 = RTW89_HW_RATE_INVAL,
+	RTW89_HW_RATE_EHT_NSS4_MCS0 = RTW89_HW_RATE_INVAL,
+};
+
 #define RTW89_HW_RATE_BY_CHIP_GEN(rate) \
 	{ \
 		[RTW89_CHIP_AX] = RTW89_HW_RATE_ ## rate, \
@@ -572,6 +585,12 @@ void __rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 	struct rtw89_phy_rate_pattern next_pattern = {0};
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev,
 						       rtwvif_link->chanctx_idx);
+	static const u16 hw_rate_eht[][RTW89_CHIP_GEN_NUM] = {
+		RTW89_HW_RATE_BY_CHIP_GEN(EHT_NSS1_MCS0),
+		RTW89_HW_RATE_BY_CHIP_GEN(EHT_NSS2_MCS0),
+		RTW89_HW_RATE_BY_CHIP_GEN(EHT_NSS3_MCS0),
+		RTW89_HW_RATE_BY_CHIP_GEN(EHT_NSS4_MCS0),
+	};
 	static const u16 hw_rate_he[][RTW89_CHIP_GEN_NUM] = {
 		RTW89_HW_RATE_BY_CHIP_GEN(HE_NSS1_MCS0),
 		RTW89_HW_RATE_BY_CHIP_GEN(HE_NSS2_MCS0),
@@ -596,6 +615,17 @@ void __rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 	u8 tx_nss = rtwdev->hal.tx_nss;
 	u8 i;
 
+	if (chip_gen == RTW89_CHIP_AX)
+		goto rs_11ax;
+
+	for (i = 0; i < tx_nss; i++)
+		if (!__check_rate_pattern(&next_pattern, hw_rate_eht[i][chip_gen],
+					  RA_MASK_EHT_RATES, RTW89_RA_MODE_EHT,
+					  mask->control[nl_band].eht_mcs[i],
+					  0, true))
+			goto out;
+
+rs_11ax:
 	for (i = 0; i < tx_nss; i++)
 		if (!__check_rate_pattern(&next_pattern, hw_rate_he[i][chip_gen],
 					  RA_MASK_HE_RATES, RTW89_RA_MODE_HE,
@@ -640,6 +670,13 @@ void __rtw89_phy_rate_pattern_vif(struct rtw89_dev *rtwdev,
 	if (!next_pattern.enable)
 		goto out;
 
+	if (unlikely(next_pattern.rate >= RTW89_HW_RATE_INVAL)) {
+		rtw89_debug(rtwdev, RTW89_DBG_RA,
+			    "pattern invalid target: chip_gen %d, mode 0x%x\n",
+			    chip_gen, next_pattern.ra_mode);
+		goto out;
+	}
+
 	rtwvif_link->rate_pattern = next_pattern;
 	rtw89_debug(rtwdev, RTW89_DBG_RA,
 		    "configure pattern: rate 0x%x, mask 0x%llx, mode 0x%x\n",
-- 
2.25.1


