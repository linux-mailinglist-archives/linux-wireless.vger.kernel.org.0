Return-Path: <linux-wireless+bounces-15166-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 082369C38AE
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 07:53:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2CA051C21819
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Nov 2024 06:53:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE31156230;
	Mon, 11 Nov 2024 06:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="fNR3YsnI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3310A14F10E
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 06:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731307955; cv=none; b=mZNnT0b+8YZCAat+KLErLa3WA4oWJqdoectGILt/EIFAQBLcA9qQS0ewKR3zktoR1LmaXdeuwZlU8ZltoiH9SHAJmmNXLTA3sXd4pUv7zWIDsqIeq0+aG5ixuVuDnj0pOjyHli+AKvXySLAuqboHeH3ZLUkvjx8e18BtnMzEsOY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731307955; c=relaxed/simple;
	bh=4HSuUuhBJJeTc5AZIhrULg22v1mAlCTZqZyLA/eOero=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=KrGl/4HLiob12YWdva8AlNcHxgbcZXHs7ahPDzEZxpaDhVaYIjef0+1OaBMBtwFlqygX1jSSoYjropc817CB9bW6bjy0IbB0Vo22aMOGNagB7PphYJYBlBV9VTIL5WE4GPOku6VM+tjRQdHUJMlWC0Xu8kDeRQnhZ5r8MLXhKIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=fNR3YsnI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AB6qU0h91780273, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731307950; bh=4HSuUuhBJJeTc5AZIhrULg22v1mAlCTZqZyLA/eOero=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=fNR3YsnIALWJ8e5mErsSseQezxEuYXqq+FGctosEkX8fKtgI9dNx5EpgB9GYZwnJD
	 Hs+BsT197Jc4CD6hI6myvw/Ihliwg/TfmTKq/EeBouhOdeSQ8gzEqd+x8jio0n/CCA
	 uBL60ZPAjHsCuMgpO4stElCU1gH+vnenoggasiG4HyXSISDlq5SWUg+dXwA16QN98n
	 TuDHyBcuk5XB/Zr1+ax6J92qhPmwe/JaCbHUrZs5o/Ufxu05k7WqBh52Ym3vzNBX1C
	 zHwjrSMmJX7eO9Y5YzASg66YzULuxAPeP5sEkwNntniVKQ8gYjNS+qqFuAqIKjmgKV
	 W6P6Ox1kVOqkg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AB6qU0h91780273
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 11 Nov 2024 14:52:30 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 11 Nov 2024 14:52:31 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 11 Nov
 2024 14:52:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <damon.chen@realtek.com>
Subject: [PATCH 3/3] wifi: rtw89: handle different TX power between RF path
Date: Mon, 11 Nov 2024 14:51:32 +0800
Message-ID: <20241111065132.19587-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241111065132.19587-1-pkshih@realtek.com>
References: <20241111065132.19587-1-pkshih@realtek.com>
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

The dynamic antenna gain (DAG) may independently apply different TX
powers for each RF path. This can be accomplished by using the larger
TX power as the reference path and adjusting the TX power of the
other path based on the difference. Currently only 8852BE/8852BTE/
8852CE are supported.

Signed-off-by: Kuan-Chung Chen <damon.chen@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.h     |  1 +
 drivers/net/wireless/realtek/rtw89/phy.c      | 31 ++++++------
 drivers/net/wireless/realtek/rtw89/phy.h      | 23 +++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../wireless/realtek/rtw89/rtw8852b_common.c  | 46 +++++++++++-------
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c | 47 ++++++++++++-------
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  1 +
 10 files changed, 107 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index bf7aff426896..ecccb51184be 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -4297,6 +4297,7 @@ struct rtw89_chip_info {
 	const struct rtw89_rfe_parms *dflt_parms;
 	const struct rtw89_chanctx_listener *chanctx_listener;
 
+	u8 txpwr_factor_bb;
 	u8 txpwr_factor_rf;
 	u8 txpwr_factor_mac;
 
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index e9a635c43a81..be2f5338c3a0 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -2040,6 +2040,23 @@ static s8 rtw89_phy_ant_gain_offset(struct rtw89_dev *rtwdev, u8 band, u32 cente
 	return max(offset_patha, offset_pathb);
 }
 
+s16 rtw89_phy_ant_gain_pwr_offset(struct rtw89_dev *rtwdev,
+				  const struct rtw89_chan *chan)
+{
+	struct rtw89_ant_gain_info *ant_gain = &rtwdev->ant_gain;
+	u8 regd = rtw89_regd_get(rtwdev, chan->band_type);
+	s8 offset_patha, offset_pathb;
+
+	if (!(ant_gain->regd_enabled & BIT(regd)))
+		return 0;
+
+	offset_patha = rtw89_phy_ant_gain_query(rtwdev, RF_PATH_A, chan->freq);
+	offset_pathb = rtw89_phy_ant_gain_query(rtwdev, RF_PATH_B, chan->freq);
+
+	return rtw89_phy_txpwr_rf_to_bb(rtwdev, offset_patha - offset_pathb);
+}
+EXPORT_SYMBOL(rtw89_phy_ant_gain_pwr_offset);
+
 void rtw89_print_ant_gain(struct seq_file *m, struct rtw89_dev *rtwdev,
 			  const struct rtw89_chan *chan)
 {
@@ -2123,20 +2140,6 @@ void rtw89_phy_load_txpwr_byrate(struct rtw89_dev *rtwdev,
 }
 EXPORT_SYMBOL(rtw89_phy_load_txpwr_byrate);
 
-static s8 rtw89_phy_txpwr_rf_to_mac(struct rtw89_dev *rtwdev, s8 txpwr_rf)
-{
-	const struct rtw89_chip_info *chip = rtwdev->chip;
-
-	return txpwr_rf >> (chip->txpwr_factor_rf - chip->txpwr_factor_mac);
-}
-
-static s8 rtw89_phy_txpwr_dbm_to_mac(struct rtw89_dev *rtwdev, s8 dbm)
-{
-	const struct rtw89_chip_info *chip = rtwdev->chip;
-
-	return clamp_t(s16, dbm << chip->txpwr_factor_mac, -64, 63);
-}
-
 static s8 rtw89_phy_txpwr_dbm_without_tolerance(s8 dbm)
 {
 	const u8 tssi_deviation_point = 0;
diff --git a/drivers/net/wireless/realtek/rtw89/phy.h b/drivers/net/wireless/realtek/rtw89/phy.h
index 2720cabfafe4..f4ef7f5fb081 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.h
+++ b/drivers/net/wireless/realtek/rtw89/phy.h
@@ -827,6 +827,8 @@ s8 *rtw89_phy_raw_byr_seek(struct rtw89_dev *rtwdev,
 s8 rtw89_phy_read_txpwr_byrate(struct rtw89_dev *rtwdev, u8 band, u8 bw,
 			       const struct rtw89_rate_desc *rate_desc);
 void rtw89_phy_ant_gain_init(struct rtw89_dev *rtwdev);
+s16 rtw89_phy_ant_gain_pwr_offset(struct rtw89_dev *rtwdev,
+				  const struct rtw89_chan *chan);
 void rtw89_print_ant_gain(struct seq_file *m, struct rtw89_dev *rtwdev,
 			  const struct rtw89_chan *chan);
 void rtw89_phy_load_txpwr_byrate(struct rtw89_dev *rtwdev,
@@ -899,6 +901,27 @@ void rtw89_phy_set_txpwr_limit_ru(struct rtw89_dev *rtwdev,
 	phy->set_txpwr_limit_ru(rtwdev, chan, phy_idx);
 }
 
+static inline s8 rtw89_phy_txpwr_rf_to_bb(struct rtw89_dev *rtwdev, s8 txpwr_rf)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	return txpwr_rf << (chip->txpwr_factor_bb - chip->txpwr_factor_rf);
+}
+
+static inline s8 rtw89_phy_txpwr_rf_to_mac(struct rtw89_dev *rtwdev, s8 txpwr_rf)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	return txpwr_rf >> (chip->txpwr_factor_rf - chip->txpwr_factor_mac);
+}
+
+static inline s8 rtw89_phy_txpwr_dbm_to_mac(struct rtw89_dev *rtwdev, s8 dbm)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	return clamp_t(s16, dbm << chip->txpwr_factor_mac, -64, 63);
+}
+
 void rtw89_phy_ra_assoc(struct rtw89_dev *rtwdev, struct rtw89_sta_link *rtwsta_link);
 void rtw89_phy_ra_update(struct rtw89_dev *rtwdev);
 void rtw89_phy_ra_update_sta(struct rtw89_dev *rtwdev, struct ieee80211_sta *sta,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 29c697a251d3..1ed4e64cbd2c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2464,6 +2464,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.nctl_post_table	= &rtw8851b_nctl_post_defs_tbl,
 	.dflt_parms		= &rtw89_8851b_dflt_parms,
 	.rfe_parms_conf		= rtw89_8851b_rfe_parms_conf,
+	.txpwr_factor_bb	= 3,
 	.txpwr_factor_rf	= 2,
 	.txpwr_factor_mac	= 1,
 	.dig_table		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index fd59ee9f3626..a7105a288bc4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2181,6 +2181,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.nctl_post_table	= NULL,
 	.dflt_parms		= &rtw89_8852a_dflt_parms,
 	.rfe_parms_conf		= NULL,
+	.txpwr_factor_bb	= 3,
 	.txpwr_factor_rf	= 2,
 	.txpwr_factor_mac	= 1,
 	.dig_table		= &rtw89_8852a_phy_dig_table,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 76667d4f3631..ebc853a905dd 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -819,6 +819,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.nctl_post_table	= NULL,
 	.dflt_parms		= &rtw89_8852b_dflt_parms,
 	.rfe_parms_conf		= NULL,
+	.txpwr_factor_bb	= 3,
 	.txpwr_factor_rf	= 2,
 	.txpwr_factor_mac	= 1,
 	.dig_table		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
index f4aa4437fb75..012739d97f71 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
@@ -1206,24 +1206,25 @@ void __rtw8852bx_set_channel_bb(struct rtw89_dev *rtwdev, const struct rtw89_cha
 }
 
 static u32 rtw8852bx_bb_cal_txpwr_ref(struct rtw89_dev *rtwdev,
-				      enum rtw89_phy_idx phy_idx, s16 ref)
+				      enum rtw89_phy_idx phy_idx,
+				      s16 ref, u16 pwr_ofst_decrease)
 {
 	const u16 tssi_16dbm_cw = 0x12c;
 	const u8 base_cw_0db = 0x27;
-	const s8 ofst_int = 0;
 	s16 pwr_s10_3;
 	s16 rf_pwr_cw;
 	u16 bb_pwr_cw;
 	u32 pwr_cw;
 	u32 tssi_ofst_cw;
 
-	pwr_s10_3 = (ref << 1) + (s16)(ofst_int) + (s16)(base_cw_0db << 3);
+	pwr_s10_3 = (ref << 1) + (s16)(base_cw_0db << 3) - pwr_ofst_decrease;
 	bb_pwr_cw = u16_get_bits(pwr_s10_3, GENMASK(2, 0));
 	rf_pwr_cw = u16_get_bits(pwr_s10_3, GENMASK(8, 3));
 	rf_pwr_cw = clamp_t(s16, rf_pwr_cw, 15, 63);
 	pwr_cw = (rf_pwr_cw << 3) | bb_pwr_cw;
 
-	tssi_ofst_cw = (u32)((s16)tssi_16dbm_cw + (ref << 1) - (16 << 3));
+	tssi_ofst_cw = (u32)((s16)tssi_16dbm_cw + (ref << 1) - (16 << 3)) -
+		       pwr_ofst_decrease;
 	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
 		    "[TXPWR] tssi_ofst_cw=%d rf_cw=0x%x bb_cw=0x%x\n",
 		    tssi_ofst_cw, rf_pwr_cw, bb_pwr_cw);
@@ -1234,10 +1235,11 @@ static u32 rtw8852bx_bb_cal_txpwr_ref(struct rtw89_dev *rtwdev,
 }
 
 static void rtw8852bx_set_txpwr_ref(struct rtw89_dev *rtwdev,
-				    enum rtw89_phy_idx phy_idx)
+				    enum rtw89_phy_idx phy_idx, s16 pwr_ofst)
 {
 	static const u32 addr[RF_PATH_NUM_8852BX] = {0x5800, 0x7800};
 	const u32 mask = B_DPD_TSSI_CW | B_DPD_PWR_CW | B_DPD_REF;
+	u16 ofst_dec[RF_PATH_NUM_8852BX];
 	const u8 ofst_ofdm = 0x4;
 	const u8 ofst_cck = 0x8;
 	const s16 ref_ofdm = 0;
@@ -1250,19 +1252,20 @@ static void rtw8852bx_set_txpwr_ref(struct rtw89_dev *rtwdev,
 	rtw89_mac_txpwr_write32_mask(rtwdev, phy_idx, R_AX_PWR_RATE_CTRL,
 				     B_AX_PWR_REF, 0x0);
 
-	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set bb ofdm txpwr ref\n");
-	val = rtw8852bx_bb_cal_txpwr_ref(rtwdev, phy_idx, ref_ofdm);
+	ofst_dec[RF_PATH_A] = pwr_ofst > 0 ? 0 : abs(pwr_ofst);
+	ofst_dec[RF_PATH_B] = pwr_ofst > 0 ? pwr_ofst : 0;
 
-	for (i = 0; i < RF_PATH_NUM_8852BX; i++)
-		rtw89_phy_write32_idx(rtwdev, addr[i] + ofst_ofdm, mask, val,
-				      phy_idx);
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set bb ofdm txpwr ref\n");
+	for (i = 0; i < RF_PATH_NUM_8852BX; i++) {
+		val = rtw8852bx_bb_cal_txpwr_ref(rtwdev, phy_idx, ref_ofdm, ofst_dec[i]);
+		rtw89_phy_write32_idx(rtwdev, addr[i] + ofst_ofdm, mask, val, phy_idx);
+	}
 
 	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set bb cck txpwr ref\n");
-	val = rtw8852bx_bb_cal_txpwr_ref(rtwdev, phy_idx, ref_cck);
-
-	for (i = 0; i < RF_PATH_NUM_8852BX; i++)
-		rtw89_phy_write32_idx(rtwdev, addr[i] + ofst_cck, mask, val,
-				      phy_idx);
+	for (i = 0; i < RF_PATH_NUM_8852BX; i++) {
+		val = rtw8852bx_bb_cal_txpwr_ref(rtwdev, phy_idx, ref_cck, ofst_dec[i]);
+		rtw89_phy_write32_idx(rtwdev, addr[i] + ofst_cck, mask, val, phy_idx);
+	}
 }
 
 static void rtw8852bx_bb_set_tx_shape_dfir(struct rtw89_dev *rtwdev,
@@ -1333,6 +1336,16 @@ static void rtw8852bx_set_tx_shape(struct rtw89_dev *rtwdev,
 			       tx_shape_ofdm);
 }
 
+static void rtw8852bx_set_txpwr_diff(struct rtw89_dev *rtwdev,
+				     const struct rtw89_chan *chan,
+				     enum rtw89_phy_idx phy_idx)
+{
+	s16 pwr_ofst;
+
+	pwr_ofst = rtw89_phy_ant_gain_pwr_offset(rtwdev, chan);
+	rtw8852bx_set_txpwr_ref(rtwdev, phy_idx, pwr_ofst);
+}
+
 static void __rtw8852bx_set_txpwr(struct rtw89_dev *rtwdev,
 				  const struct rtw89_chan *chan,
 				  enum rtw89_phy_idx phy_idx)
@@ -1342,12 +1355,13 @@ static void __rtw8852bx_set_txpwr(struct rtw89_dev *rtwdev,
 	rtw8852bx_set_tx_shape(rtwdev, chan, phy_idx);
 	rtw89_phy_set_txpwr_limit(rtwdev, chan, phy_idx);
 	rtw89_phy_set_txpwr_limit_ru(rtwdev, chan, phy_idx);
+	rtw8852bx_set_txpwr_diff(rtwdev, chan, phy_idx);
 }
 
 static void __rtw8852bx_set_txpwr_ctrl(struct rtw89_dev *rtwdev,
 				       enum rtw89_phy_idx phy_idx)
 {
-	rtw8852bx_set_txpwr_ref(rtwdev, phy_idx);
+	rtw8852bx_set_txpwr_ref(rtwdev, phy_idx, 0);
 }
 
 static
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index d8c0fb87b625..cd1385ff8003 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -752,6 +752,7 @@ const struct rtw89_chip_info rtw8852bt_chip_info = {
 	.nctl_post_table	= NULL,
 	.dflt_parms		= NULL,
 	.rfe_parms_conf		= NULL,
+	.txpwr_factor_bb	= 3,
 	.txpwr_factor_rf	= 2,
 	.txpwr_factor_mac	= 1,
 	.dig_table		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index b63971010751..c7d39499ca75 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -1882,9 +1882,9 @@ static void rtw8852c_rfk_track(struct rtw89_dev *rtwdev)
 }
 
 static u32 rtw8852c_bb_cal_txpwr_ref(struct rtw89_dev *rtwdev,
-				     enum rtw89_phy_idx phy_idx, s16 ref)
+				     enum rtw89_phy_idx phy_idx,
+				     s16 ref, u16 pwr_ofst_decrease)
 {
-	s8 ofst_int = 0;
 	u8 base_cw_0db = 0x27;
 	u16 tssi_16dbm_cw = 0x12c;
 	s16 pwr_s10_3 = 0;
@@ -1893,13 +1893,14 @@ static u32 rtw8852c_bb_cal_txpwr_ref(struct rtw89_dev *rtwdev,
 	u32 pwr_cw = 0;
 	u32 tssi_ofst_cw = 0;
 
-	pwr_s10_3 = (ref << 1) + (s16)(ofst_int) + (s16)(base_cw_0db << 3);
+	pwr_s10_3 = (ref << 1) + (s16)(base_cw_0db << 3) - pwr_ofst_decrease;
 	bb_pwr_cw = FIELD_GET(GENMASK(2, 0), pwr_s10_3);
 	rf_pwr_cw = FIELD_GET(GENMASK(8, 3), pwr_s10_3);
 	rf_pwr_cw = clamp_t(s16, rf_pwr_cw, 15, 63);
 	pwr_cw = (rf_pwr_cw << 3) | bb_pwr_cw;
 
-	tssi_ofst_cw = (u32)((s16)tssi_16dbm_cw + (ref << 1) - (16 << 3));
+	tssi_ofst_cw = (u32)((s16)tssi_16dbm_cw + (ref << 1) - (16 << 3)) -
+		       pwr_ofst_decrease;
 	rtw89_debug(rtwdev, RTW89_DBG_TXPWR,
 		    "[TXPWR] tssi_ofst_cw=%d rf_cw=0x%x bb_cw=0x%x\n",
 		    tssi_ofst_cw, rf_pwr_cw, bb_pwr_cw);
@@ -1943,9 +1944,10 @@ void rtw8852c_set_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
 }
 
 static void rtw8852c_set_txpwr_ref(struct rtw89_dev *rtwdev,
-				   enum rtw89_phy_idx phy_idx)
+				   enum rtw89_phy_idx phy_idx, s16 pwr_ofst)
 {
 	static const u32 addr[RF_PATH_NUM_8852C] = {0x5800, 0x7800};
+	u16 ofst_dec[RF_PATH_NUM_8852C];
 	const u32 mask = 0x7FFFFFF;
 	const u8 ofst_ofdm = 0x4;
 	const u8 ofst_cck = 0x8;
@@ -1959,19 +1961,20 @@ static void rtw8852c_set_txpwr_ref(struct rtw89_dev *rtwdev,
 	rtw89_mac_txpwr_write32_mask(rtwdev, phy_idx, R_AX_PWR_RATE_CTRL,
 				     GENMASK(27, 10), 0x0);
 
-	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set bb ofdm txpwr ref\n");
-	val = rtw8852c_bb_cal_txpwr_ref(rtwdev, phy_idx, ref_ofdm);
+	ofst_dec[RF_PATH_A] = pwr_ofst > 0 ? 0 : abs(pwr_ofst);
+	ofst_dec[RF_PATH_B] = pwr_ofst > 0 ? pwr_ofst : 0;
 
-	for (i = 0; i < RF_PATH_NUM_8852C; i++)
-		rtw89_phy_write32_idx(rtwdev, addr[i] + ofst_ofdm, mask, val,
-				      phy_idx);
+	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set bb ofdm txpwr ref\n");
+	for (i = 0; i < RF_PATH_NUM_8852C; i++) {
+		val = rtw8852c_bb_cal_txpwr_ref(rtwdev, phy_idx, ref_ofdm, ofst_dec[i]);
+		rtw89_phy_write32_idx(rtwdev, addr[i] + ofst_ofdm, mask, val, phy_idx);
+	}
 
 	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[TXPWR] set bb cck txpwr ref\n");
-	val = rtw8852c_bb_cal_txpwr_ref(rtwdev, phy_idx, ref_cck);
-
-	for (i = 0; i < RF_PATH_NUM_8852C; i++)
-		rtw89_phy_write32_idx(rtwdev, addr[i] + ofst_cck, mask, val,
-				      phy_idx);
+	for (i = 0; i < RF_PATH_NUM_8852C; i++) {
+		val = rtw8852c_bb_cal_txpwr_ref(rtwdev, phy_idx, ref_cck, ofst_dec[i]);
+		rtw89_phy_write32_idx(rtwdev, addr[i] + ofst_cck, mask, val, phy_idx);
+	}
 }
 
 static void rtw8852c_bb_set_tx_shape_dfir(struct rtw89_dev *rtwdev,
@@ -2052,6 +2055,16 @@ static void rtw8852c_set_tx_shape(struct rtw89_dev *rtwdev,
 			      B_P1_DAC_COMP_POST_DPD_EN);
 }
 
+static void rtw8852c_set_txpwr_diff(struct rtw89_dev *rtwdev,
+				    const struct rtw89_chan *chan,
+				    enum rtw89_phy_idx phy_idx)
+{
+	s16 pwr_ofst;
+
+	pwr_ofst = rtw89_phy_ant_gain_pwr_offset(rtwdev, chan);
+	rtw8852c_set_txpwr_ref(rtwdev, phy_idx, pwr_ofst);
+}
+
 static void rtw8852c_set_txpwr(struct rtw89_dev *rtwdev,
 			       const struct rtw89_chan *chan,
 			       enum rtw89_phy_idx phy_idx)
@@ -2061,12 +2074,13 @@ static void rtw8852c_set_txpwr(struct rtw89_dev *rtwdev,
 	rtw8852c_set_tx_shape(rtwdev, chan, phy_idx);
 	rtw89_phy_set_txpwr_limit(rtwdev, chan, phy_idx);
 	rtw89_phy_set_txpwr_limit_ru(rtwdev, chan, phy_idx);
+	rtw8852c_set_txpwr_diff(rtwdev, chan, phy_idx);
 }
 
 static void rtw8852c_set_txpwr_ctrl(struct rtw89_dev *rtwdev,
 				    enum rtw89_phy_idx phy_idx)
 {
-	rtw8852c_set_txpwr_ref(rtwdev, phy_idx);
+	rtw8852c_set_txpwr_ref(rtwdev, phy_idx, 0);
 }
 
 static void
@@ -2959,6 +2973,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.dflt_parms		= &rtw89_8852c_dflt_parms,
 	.rfe_parms_conf		= NULL,
 	.chanctx_listener	= &rtw8852c_chanctx_listener,
+	.txpwr_factor_bb	= 3,
 	.txpwr_factor_rf	= 2,
 	.txpwr_factor_mac	= 1,
 	.dig_table		= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index b3879b485918..a5333099668a 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2729,6 +2729,7 @@ const struct rtw89_chip_info rtw8922a_chip_info = {
 	.nctl_post_table	= NULL,
 	.dflt_parms		= NULL, /* load parm from fw */
 	.rfe_parms_conf		= NULL, /* load parm from fw */
+	.txpwr_factor_bb	= 3,
 	.txpwr_factor_rf	= 2,
 	.txpwr_factor_mac	= 1,
 	.dig_table		= NULL,
-- 
2.25.1


