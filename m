Return-Path: <linux-wireless+bounces-22229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CBD8CAA42B1
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 07:53:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3C8751BC825A
	for <lists+linux-wireless@lfdr.de>; Wed, 30 Apr 2025 05:53:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B1B47FBA2;
	Wed, 30 Apr 2025 05:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="fhvECBff"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18C921C8605
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 05:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745992372; cv=none; b=hIRPDg6b4ek/Yw0autELf6Rf8KB2R1jVAAvcsPZSwOispd8OXrC5b1D5fMVg5EhBJp9umMFBrY5zd46EUKpjUK3KNUhA/oIN+oMUq5KKaycV7t14TODe36X5hK5uPvySp4I2Ka87kwdKNmt9DnFNYCsF48h6l2noy4JdqpiuFKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745992372; c=relaxed/simple;
	bh=OKidEiRQrkQyc3WrTB9/43FuU1/G3PACecTNW1vWOA0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JgbWgZfJmIRX1iX/g3qb+v7Vzid+Ucewczz54ly3EDncorrFqHrzP6bPrdCYjXD0b99ijg/hOibkzM8f0yPT2RtztADmpTL+/UiducweKytZubUCyDShFf564o5883t+pXukNndLQIA7K7UYUPARaqvSdkGuueDnsDI4Y6RcqXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=fhvECBff; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 53U5qlb172508526, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1745992367; bh=OKidEiRQrkQyc3WrTB9/43FuU1/G3PACecTNW1vWOA0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=fhvECBffIb4a4l6QuAGNBu3gIlk7BN3Rc4xmz2c546hEGMYztksK/Rupahur9QtA9
	 BXMPn3K6q4qdgPcrhzfZRiag25Ls4GbwPb4Srg0nvDwafmi06CIU20yvjatvoSNHpL
	 7xmDSNOfIYqOsC8jjUgQB3ClP1V7IZa5ceKSdNa97VH0aHFaHxq/4gLy+4tgcZgXOr
	 z4Q/RcOyop3ITCE/pVG7v2VzhumXIgHxcExfCLxHOwJth2FmMiR9oJ6RiW8ULlvZXI
	 JMdv34LDCiDVGXKCtE79dZH2VdXReU3Ysx02wYoANMBfVUGoIxboksGxaehvl30sTD
	 Cad3R4lN0lKAg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 53U5qlb172508526
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Wed, 30 Apr 2025 13:52:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 30 Apr 2025 13:52:47 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Wed, 30 Apr
 2025 13:52:46 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH rtw-next 2/2] wifi: rtw89: constrain TX power according to dynamic antenna power table
Date: Wed, 30 Apr 2025 13:51:57 +0800
Message-ID: <20250430055157.13623-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20250430055157.13623-1-pkshih@realtek.com>
References: <20250430055157.13623-1-pkshih@realtek.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)

From: Kuan-Chung Chen <damon.chen@realtek.com>

Dynamic Antenna Gain (DAG) adjusts TX power based on antenna gain. To
prevent signal distortion from excessive power increases, a dynamic
antenna power table limits the maximum adjustable TX power.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h | 10 +++
 drivers/net/wireless/realtek/rtw89/fw.c   | 76 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/fw.h   |  6 ++
 drivers/net/wireless/realtek/rtw89/phy.c  | 84 ++++++++++++++++-------
 4 files changed, 150 insertions(+), 26 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index be1259cfa712..7d3b81ab9f97 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -3987,7 +3987,11 @@ struct rtw89_rfe_parms {
 	struct rtw89_txpwr_rule_2ghz rule_2ghz;
 	struct rtw89_txpwr_rule_5ghz rule_5ghz;
 	struct rtw89_txpwr_rule_6ghz rule_6ghz;
+	struct rtw89_txpwr_rule_2ghz rule_da_2ghz;
+	struct rtw89_txpwr_rule_5ghz rule_da_5ghz;
+	struct rtw89_txpwr_rule_6ghz rule_da_6ghz;
 	struct rtw89_tx_shape tx_shape;
+	bool has_da;
 };
 
 struct rtw89_rfe_parms_conf {
@@ -4082,9 +4086,15 @@ struct rtw89_rfe_data {
 	struct rtw89_txpwr_lmt_2ghz_data lmt_2ghz;
 	struct rtw89_txpwr_lmt_5ghz_data lmt_5ghz;
 	struct rtw89_txpwr_lmt_6ghz_data lmt_6ghz;
+	struct rtw89_txpwr_lmt_2ghz_data da_lmt_2ghz;
+	struct rtw89_txpwr_lmt_5ghz_data da_lmt_5ghz;
+	struct rtw89_txpwr_lmt_6ghz_data da_lmt_6ghz;
 	struct rtw89_txpwr_lmt_ru_2ghz_data lmt_ru_2ghz;
 	struct rtw89_txpwr_lmt_ru_5ghz_data lmt_ru_5ghz;
 	struct rtw89_txpwr_lmt_ru_6ghz_data lmt_ru_6ghz;
+	struct rtw89_txpwr_lmt_ru_2ghz_data da_lmt_ru_2ghz;
+	struct rtw89_txpwr_lmt_ru_5ghz_data da_lmt_ru_5ghz;
+	struct rtw89_txpwr_lmt_ru_6ghz_data da_lmt_ru_6ghz;
 	struct rtw89_tx_shape_lmt_data tx_shape_lmt;
 	struct rtw89_tx_shape_lmt_ru_data tx_shape_lmt_ru;
 	struct rtw89_rfe_parms rfe_parms;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index 4173794e3892..57ea946b172c 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -1301,6 +1301,18 @@ static const struct rtw89_fw_element_handler __fw_element_handlers[] = {
 		rtw89_fw_recognize_txpwr_from_elm,
 		{ .offset = offsetof(struct rtw89_rfe_data, lmt_6ghz.conf) }, NULL,
 	},
+	[RTW89_FW_ELEMENT_ID_TXPWR_DA_LMT_2GHZ] = {
+		rtw89_fw_recognize_txpwr_from_elm,
+		{ .offset = offsetof(struct rtw89_rfe_data, da_lmt_2ghz.conf) }, NULL,
+	},
+	[RTW89_FW_ELEMENT_ID_TXPWR_DA_LMT_5GHZ] = {
+		rtw89_fw_recognize_txpwr_from_elm,
+		{ .offset = offsetof(struct rtw89_rfe_data, da_lmt_5ghz.conf) }, NULL,
+	},
+	[RTW89_FW_ELEMENT_ID_TXPWR_DA_LMT_6GHZ] = {
+		rtw89_fw_recognize_txpwr_from_elm,
+		{ .offset = offsetof(struct rtw89_rfe_data, da_lmt_6ghz.conf) }, NULL,
+	},
 	[RTW89_FW_ELEMENT_ID_TXPWR_LMT_RU_2GHZ] = {
 		rtw89_fw_recognize_txpwr_from_elm,
 		{ .offset = offsetof(struct rtw89_rfe_data, lmt_ru_2ghz.conf) }, NULL,
@@ -1313,6 +1325,18 @@ static const struct rtw89_fw_element_handler __fw_element_handlers[] = {
 		rtw89_fw_recognize_txpwr_from_elm,
 		{ .offset = offsetof(struct rtw89_rfe_data, lmt_ru_6ghz.conf) }, NULL,
 	},
+	[RTW89_FW_ELEMENT_ID_TXPWR_DA_LMT_RU_2GHZ] = {
+		rtw89_fw_recognize_txpwr_from_elm,
+		{ .offset = offsetof(struct rtw89_rfe_data, da_lmt_ru_2ghz.conf) }, NULL,
+	},
+	[RTW89_FW_ELEMENT_ID_TXPWR_DA_LMT_RU_5GHZ] = {
+		rtw89_fw_recognize_txpwr_from_elm,
+		{ .offset = offsetof(struct rtw89_rfe_data, da_lmt_ru_5ghz.conf) }, NULL,
+	},
+	[RTW89_FW_ELEMENT_ID_TXPWR_DA_LMT_RU_6GHZ] = {
+		rtw89_fw_recognize_txpwr_from_elm,
+		{ .offset = offsetof(struct rtw89_rfe_data, da_lmt_ru_6ghz.conf) }, NULL,
+	},
 	[RTW89_FW_ELEMENT_ID_TX_SHAPE_LMT] = {
 		rtw89_fw_recognize_txpwr_from_elm,
 		{ .offset = offsetof(struct rtw89_rfe_data, tx_shape_lmt.conf) }, NULL,
@@ -9297,6 +9321,26 @@ void rtw89_fw_load_tx_shape_lmt_ru(struct rtw89_tx_shape_lmt_ru_data *data)
 	}
 }
 
+static bool rtw89_fw_has_da_txpwr_table(struct rtw89_dev *rtwdev,
+					const struct rtw89_rfe_parms *parms)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->support_bands & BIT(NL80211_BAND_2GHZ) &&
+	    !(parms->rule_da_2ghz.lmt && parms->rule_da_2ghz.lmt_ru))
+		return false;
+
+	if (chip->support_bands & BIT(NL80211_BAND_5GHZ) &&
+	    !(parms->rule_da_5ghz.lmt && parms->rule_da_5ghz.lmt_ru))
+		return false;
+
+	if (chip->support_bands & BIT(NL80211_BAND_6GHZ) &&
+	    !(parms->rule_da_6ghz.lmt && parms->rule_da_6ghz.lmt_ru))
+		return false;
+
+	return true;
+}
+
 const struct rtw89_rfe_parms *
 rtw89_load_rfe_data_from_fw(struct rtw89_dev *rtwdev,
 			    const struct rtw89_rfe_parms *init)
@@ -9333,6 +9377,21 @@ rtw89_load_rfe_data_from_fw(struct rtw89_dev *rtwdev,
 		parms->rule_6ghz.lmt = &rfe_data->lmt_6ghz.v;
 	}
 
+	if (rtw89_txpwr_conf_valid(&rfe_data->da_lmt_2ghz.conf)) {
+		rtw89_fw_load_txpwr_lmt_2ghz(&rfe_data->da_lmt_2ghz);
+		parms->rule_da_2ghz.lmt = &rfe_data->da_lmt_2ghz.v;
+	}
+
+	if (rtw89_txpwr_conf_valid(&rfe_data->da_lmt_5ghz.conf)) {
+		rtw89_fw_load_txpwr_lmt_5ghz(&rfe_data->da_lmt_5ghz);
+		parms->rule_da_5ghz.lmt = &rfe_data->da_lmt_5ghz.v;
+	}
+
+	if (rtw89_txpwr_conf_valid(&rfe_data->da_lmt_6ghz.conf)) {
+		rtw89_fw_load_txpwr_lmt_6ghz(&rfe_data->da_lmt_6ghz);
+		parms->rule_da_6ghz.lmt = &rfe_data->da_lmt_6ghz.v;
+	}
+
 	if (rtw89_txpwr_conf_valid(&rfe_data->lmt_ru_2ghz.conf)) {
 		rtw89_fw_load_txpwr_lmt_ru_2ghz(&rfe_data->lmt_ru_2ghz);
 		parms->rule_2ghz.lmt_ru = &rfe_data->lmt_ru_2ghz.v;
@@ -9348,6 +9407,21 @@ rtw89_load_rfe_data_from_fw(struct rtw89_dev *rtwdev,
 		parms->rule_6ghz.lmt_ru = &rfe_data->lmt_ru_6ghz.v;
 	}
 
+	if (rtw89_txpwr_conf_valid(&rfe_data->da_lmt_ru_2ghz.conf)) {
+		rtw89_fw_load_txpwr_lmt_ru_2ghz(&rfe_data->da_lmt_ru_2ghz);
+		parms->rule_da_2ghz.lmt_ru = &rfe_data->da_lmt_ru_2ghz.v;
+	}
+
+	if (rtw89_txpwr_conf_valid(&rfe_data->da_lmt_ru_5ghz.conf)) {
+		rtw89_fw_load_txpwr_lmt_ru_5ghz(&rfe_data->da_lmt_ru_5ghz);
+		parms->rule_da_5ghz.lmt_ru = &rfe_data->da_lmt_ru_5ghz.v;
+	}
+
+	if (rtw89_txpwr_conf_valid(&rfe_data->da_lmt_ru_6ghz.conf)) {
+		rtw89_fw_load_txpwr_lmt_ru_6ghz(&rfe_data->da_lmt_ru_6ghz);
+		parms->rule_da_6ghz.lmt_ru = &rfe_data->da_lmt_ru_6ghz.v;
+	}
+
 	if (rtw89_txpwr_conf_valid(&rfe_data->tx_shape_lmt.conf)) {
 		rtw89_fw_load_tx_shape_lmt(&rfe_data->tx_shape_lmt);
 		parms->tx_shape.lmt = &rfe_data->tx_shape_lmt.v;
@@ -9358,5 +9432,7 @@ rtw89_load_rfe_data_from_fw(struct rtw89_dev *rtwdev,
 		parms->tx_shape.lmt_ru = &rfe_data->tx_shape_lmt_ru.v;
 	}
 
+	parms->has_da = rtw89_fw_has_da_txpwr_table(rtwdev, parms);
+
 	return parms;
 }
diff --git a/drivers/net/wireless/realtek/rtw89/fw.h b/drivers/net/wireless/realtek/rtw89/fw.h
index 8e6e71971a7e..f544831c4599 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.h
+++ b/drivers/net/wireless/realtek/rtw89/fw.h
@@ -3905,6 +3905,12 @@ enum rtw89_fw_element_id {
 	RTW89_FW_ELEMENT_ID_TXPWR_TRK = 18,
 	RTW89_FW_ELEMENT_ID_RFKLOG_FMT = 19,
 	RTW89_FW_ELEMENT_ID_REGD = 20,
+	RTW89_FW_ELEMENT_ID_TXPWR_DA_LMT_2GHZ = 21,
+	RTW89_FW_ELEMENT_ID_TXPWR_DA_LMT_5GHZ = 22,
+	RTW89_FW_ELEMENT_ID_TXPWR_DA_LMT_6GHZ = 23,
+	RTW89_FW_ELEMENT_ID_TXPWR_DA_LMT_RU_2GHZ = 24,
+	RTW89_FW_ELEMENT_ID_TXPWR_DA_LMT_RU_5GHZ = 25,
+	RTW89_FW_ELEMENT_ID_TXPWR_DA_LMT_RU_6GHZ = 26,
 
 	RTW89_FW_ELEMENT_ID_NUM,
 };
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index e358cb83dae8..76a2e26d4a10 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2034,19 +2034,10 @@ static s8 rtw89_phy_ant_gain_query(struct rtw89_dev *rtwdev,
 		   ant_gain->offset[path][subband_h]);
 }
 
-static s8 rtw89_phy_ant_gain_offset(struct rtw89_dev *rtwdev, u8 band, u32 center_freq)
+static s8 rtw89_phy_ant_gain_offset(struct rtw89_dev *rtwdev, u32 center_freq)
 {
-	struct rtw89_ant_gain_info *ant_gain = &rtwdev->ant_gain;
-	const struct rtw89_chip_info *chip = rtwdev->chip;
-	u8 regd = rtw89_regd_get(rtwdev, band);
 	s8 offset_patha, offset_pathb;
 
-	if (!chip->support_ant_gain)
-		return 0;
-
-	if (ant_gain->block_country || !(ant_gain->regd_enabled & BIT(regd)))
-		return 0;
-
 	offset_patha = rtw89_phy_ant_gain_query(rtwdev, RF_PATH_A, center_freq);
 	offset_pathb = rtw89_phy_ant_gain_query(rtwdev, RF_PATH_B, center_freq);
 
@@ -2056,18 +2047,31 @@ static s8 rtw89_phy_ant_gain_offset(struct rtw89_dev *rtwdev, u8 band, u32 cente
 	return max(offset_patha, offset_pathb);
 }
 
-s16 rtw89_phy_ant_gain_pwr_offset(struct rtw89_dev *rtwdev,
-				  const struct rtw89_chan *chan)
+static bool rtw89_can_apply_ant_gain(struct rtw89_dev *rtwdev, u8 band)
 {
+	const struct rtw89_rfe_parms *rfe_parms = rtwdev->rfe_parms;
 	struct rtw89_ant_gain_info *ant_gain = &rtwdev->ant_gain;
 	const struct rtw89_chip_info *chip = rtwdev->chip;
-	u8 regd = rtw89_regd_get(rtwdev, chan->band_type);
-	s8 offset_patha, offset_pathb;
+	u8 regd = rtw89_regd_get(rtwdev, band);
 
 	if (!chip->support_ant_gain)
-		return 0;
+		return false;
 
 	if (ant_gain->block_country || !(ant_gain->regd_enabled & BIT(regd)))
+		return false;
+
+	if (!rfe_parms->has_da)
+		return false;
+
+	return true;
+}
+
+s16 rtw89_phy_ant_gain_pwr_offset(struct rtw89_dev *rtwdev,
+				  const struct rtw89_chan *chan)
+{
+	s8 offset_patha, offset_pathb;
+
+	if (!rtw89_can_apply_ant_gain(rtwdev, chan->band_type))
 		return 0;
 
 	if (RTW89_CHK_FW_FEATURE(NO_POWER_DIFFERENCE, &rtwdev->fw))
@@ -2083,14 +2087,10 @@ EXPORT_SYMBOL(rtw89_phy_ant_gain_pwr_offset);
 int rtw89_print_ant_gain(struct rtw89_dev *rtwdev, char *buf, size_t bufsz,
 			 const struct rtw89_chan *chan)
 {
-	struct rtw89_ant_gain_info *ant_gain = &rtwdev->ant_gain;
-	const struct rtw89_chip_info *chip = rtwdev->chip;
-	u8 regd = rtw89_regd_get(rtwdev, chan->band_type);
 	char *p = buf, *end = buf + bufsz;
 	s8 offset_patha, offset_pathb;
 
-	if (!(chip->support_ant_gain && (ant_gain->regd_enabled & BIT(regd))) ||
-	    ant_gain->block_country) {
+	if (!rtw89_can_apply_ant_gain(rtwdev, chan->band_type)) {
 		p += scnprintf(p, end - p, "no DAG is applied\n");
 		goto out;
 	}
@@ -2255,24 +2255,31 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 			      u8 bw, u8 ntx, u8 rs, u8 bf, u8 ch)
 {
 	const struct rtw89_rfe_parms *rfe_parms = rtwdev->rfe_parms;
+	const struct rtw89_txpwr_rule_2ghz *rule_da_2ghz = &rfe_parms->rule_da_2ghz;
+	const struct rtw89_txpwr_rule_5ghz *rule_da_5ghz = &rfe_parms->rule_da_5ghz;
+	const struct rtw89_txpwr_rule_6ghz *rule_da_6ghz = &rfe_parms->rule_da_6ghz;
 	const struct rtw89_txpwr_rule_2ghz *rule_2ghz = &rfe_parms->rule_2ghz;
 	const struct rtw89_txpwr_rule_5ghz *rule_5ghz = &rfe_parms->rule_5ghz;
 	const struct rtw89_txpwr_rule_6ghz *rule_6ghz = &rfe_parms->rule_6ghz;
 	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
 	enum nl80211_band nl_band = rtw89_hw_to_nl80211_band(band);
+	bool has_ant_gain = rtw89_can_apply_ant_gain(rtwdev, band);
 	u32 freq = ieee80211_channel_to_frequency(ch, nl_band);
 	u8 ch_idx = rtw89_channel_to_idx(rtwdev, band, ch);
+	s8 lmt = 0, da_lmt = S8_MAX, sar, offset = 0;
 	u8 regd = rtw89_regd_get(rtwdev, band);
 	u8 reg6 = regulatory->reg_6ghz_power;
 	struct rtw89_sar_parm sar_parm = {
 		.center_freq = freq,
 		.ntx = ntx,
 	};
-	s8 lmt = 0, sar, offset;
 	s8 cstr;
 
 	switch (band) {
 	case RTW89_BAND_2G:
+		if (has_ant_gain)
+			da_lmt = (*rule_da_2ghz->lmt)[bw][ntx][rs][bf][regd][ch_idx];
+
 		lmt = (*rule_2ghz->lmt)[bw][ntx][rs][bf][regd][ch_idx];
 		if (lmt)
 			break;
@@ -2280,6 +2287,9 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 		lmt = (*rule_2ghz->lmt)[bw][ntx][rs][bf][RTW89_WW][ch_idx];
 		break;
 	case RTW89_BAND_5G:
+		if (has_ant_gain)
+			da_lmt = (*rule_da_5ghz->lmt)[bw][ntx][rs][bf][regd][ch_idx];
+
 		lmt = (*rule_5ghz->lmt)[bw][ntx][rs][bf][regd][ch_idx];
 		if (lmt)
 			break;
@@ -2287,6 +2297,9 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 		lmt = (*rule_5ghz->lmt)[bw][ntx][rs][bf][RTW89_WW][ch_idx];
 		break;
 	case RTW89_BAND_6G:
+		if (has_ant_gain)
+			da_lmt = (*rule_da_6ghz->lmt)[bw][ntx][rs][bf][regd][reg6][ch_idx];
+
 		lmt = (*rule_6ghz->lmt)[bw][ntx][rs][bf][regd][reg6][ch_idx];
 		if (lmt)
 			break;
@@ -2300,8 +2313,11 @@ s8 rtw89_phy_read_txpwr_limit(struct rtw89_dev *rtwdev, u8 band,
 		return 0;
 	}
 
-	offset = rtw89_phy_ant_gain_offset(rtwdev, band, freq);
-	lmt = rtw89_phy_txpwr_rf_to_mac(rtwdev, lmt + offset);
+	da_lmt = da_lmt ?: S8_MAX;
+	if (da_lmt != S8_MAX)
+		offset = rtw89_phy_ant_gain_offset(rtwdev, freq);
+
+	lmt = rtw89_phy_txpwr_rf_to_mac(rtwdev, min(lmt + offset, da_lmt));
 	sar = rtw89_query_sar(rtwdev, &sar_parm);
 	cstr = rtw89_phy_get_tpe_constraint(rtwdev, band);
 
@@ -2519,24 +2535,31 @@ s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev, u8 band,
 				 u8 ru, u8 ntx, u8 ch)
 {
 	const struct rtw89_rfe_parms *rfe_parms = rtwdev->rfe_parms;
+	const struct rtw89_txpwr_rule_2ghz *rule_da_2ghz = &rfe_parms->rule_da_2ghz;
+	const struct rtw89_txpwr_rule_5ghz *rule_da_5ghz = &rfe_parms->rule_da_5ghz;
+	const struct rtw89_txpwr_rule_6ghz *rule_da_6ghz = &rfe_parms->rule_da_6ghz;
 	const struct rtw89_txpwr_rule_2ghz *rule_2ghz = &rfe_parms->rule_2ghz;
 	const struct rtw89_txpwr_rule_5ghz *rule_5ghz = &rfe_parms->rule_5ghz;
 	const struct rtw89_txpwr_rule_6ghz *rule_6ghz = &rfe_parms->rule_6ghz;
 	struct rtw89_regulatory_info *regulatory = &rtwdev->regulatory;
 	enum nl80211_band nl_band = rtw89_hw_to_nl80211_band(band);
+	bool has_ant_gain = rtw89_can_apply_ant_gain(rtwdev, band);
 	u32 freq = ieee80211_channel_to_frequency(ch, nl_band);
 	u8 ch_idx = rtw89_channel_to_idx(rtwdev, band, ch);
+	s8 lmt_ru = 0, da_lmt_ru = S8_MAX, sar, offset = 0;
 	u8 regd = rtw89_regd_get(rtwdev, band);
 	u8 reg6 = regulatory->reg_6ghz_power;
 	struct rtw89_sar_parm sar_parm = {
 		.center_freq = freq,
 		.ntx = ntx,
 	};
-	s8 lmt_ru = 0, sar, offset;
 	s8 cstr;
 
 	switch (band) {
 	case RTW89_BAND_2G:
+		if (has_ant_gain)
+			da_lmt_ru = (*rule_da_2ghz->lmt_ru)[ru][ntx][regd][ch_idx];
+
 		lmt_ru = (*rule_2ghz->lmt_ru)[ru][ntx][regd][ch_idx];
 		if (lmt_ru)
 			break;
@@ -2544,6 +2567,9 @@ s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev, u8 band,
 		lmt_ru = (*rule_2ghz->lmt_ru)[ru][ntx][RTW89_WW][ch_idx];
 		break;
 	case RTW89_BAND_5G:
+		if (has_ant_gain)
+			da_lmt_ru = (*rule_da_5ghz->lmt_ru)[ru][ntx][regd][ch_idx];
+
 		lmt_ru = (*rule_5ghz->lmt_ru)[ru][ntx][regd][ch_idx];
 		if (lmt_ru)
 			break;
@@ -2551,6 +2577,9 @@ s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev, u8 band,
 		lmt_ru = (*rule_5ghz->lmt_ru)[ru][ntx][RTW89_WW][ch_idx];
 		break;
 	case RTW89_BAND_6G:
+		if (has_ant_gain)
+			da_lmt_ru = (*rule_da_6ghz->lmt_ru)[ru][ntx][regd][reg6][ch_idx];
+
 		lmt_ru = (*rule_6ghz->lmt_ru)[ru][ntx][regd][reg6][ch_idx];
 		if (lmt_ru)
 			break;
@@ -2564,8 +2593,11 @@ s8 rtw89_phy_read_txpwr_limit_ru(struct rtw89_dev *rtwdev, u8 band,
 		return 0;
 	}
 
-	offset = rtw89_phy_ant_gain_offset(rtwdev, band, freq);
-	lmt_ru = rtw89_phy_txpwr_rf_to_mac(rtwdev, lmt_ru + offset);
+	da_lmt_ru = da_lmt_ru ?: S8_MAX;
+	if (da_lmt_ru != S8_MAX)
+		offset = rtw89_phy_ant_gain_offset(rtwdev, freq);
+
+	lmt_ru = rtw89_phy_txpwr_rf_to_mac(rtwdev, min(lmt_ru + offset, da_lmt_ru));
 	sar = rtw89_query_sar(rtwdev, &sar_parm);
 	cstr = rtw89_phy_get_tpe_constraint(rtwdev, band);
 
-- 
2.25.1


