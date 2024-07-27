Return-Path: <linux-wireless+bounces-10562-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 99B1993DDCA
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 10:07:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC7961C209F2
	for <lists+linux-wireless@lfdr.de>; Sat, 27 Jul 2024 08:07:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A882825745;
	Sat, 27 Jul 2024 08:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="n6OGnb+x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BB5318641
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jul 2024 08:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722067666; cv=none; b=thAO2or+H7c4tv3nZGm0EX/RCsSAJ7cwu8Mxg6xpItExr6nMLUsDH8svMJSG7GivwX97cAnl8uo1/SAV26FST+48UsT3mV4w8ldLY7wk1wmKBI/gu8CqUqyco4WmnvWsdb0Jn/I0g0qpGzhKeSOnNXR3sJanOa8TAZ/S0NPJLH4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722067666; c=relaxed/simple;
	bh=elYKeLVHdcUfK2wimkKHiX+f815evsbG7XSKEBoVioY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=aQXmrQgoOrLnbH//lneuuuxY/Li3Wgikg8VgfciQHbAx5mXWAEKYQCMzFRNIgtC7Lj80TEJrOXumGHNdSK5UKLLqh5o98cCf9E5UnwRU6NGZF7oWYO7peyaK3q1nm7E5J+UXzatOjVRnxxlX12MRknxbpSedo2PsE1Oev96W4l0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=n6OGnb+x; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46R87g2L21417826, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722067663; bh=elYKeLVHdcUfK2wimkKHiX+f815evsbG7XSKEBoVioY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=n6OGnb+xGRUQu1lThv/P57Iv6HGLzPxm8qMucUuF0lLf1A/sgX9P/1tD70YBNSHVX
	 wWVXXf8aCa8yy8hOxJjD0OsTB6kiyLWjEZqey2Y3RRb1KdVDg/za0y5voLDTi/fjyT
	 YaBg71CsDix2bGe8kRe+vuvnY1MwPdy5mUV040SOfYRMS/Ct2DpAzMfmTFb0thQ/u+
	 6tc1CsOoZcNQAVFXqZtfq67FYKLsT8f3zmw4FX64H2cb42teL0Q8FziG/5Ul5T44od
	 98DaAYcXCbBcfcgbp/CbQ9XMqEp2JvKTVws5ChWXLM8KC48hFA3Ayv5KvBSV1Dyvha
	 lzcKFg47GKIJg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46R87g2L21417826
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Sat, 27 Jul 2024 16:07:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 27 Jul 2024 16:07:42 +0800
Received: from [127.0.1.1] (172.16.17.30) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Sat, 27 Jul
 2024 16:07:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 7/7] wifi: rtw89: pass chanctx_idx to rtw89_btc_{path_}phymap()
Date: Sat, 27 Jul 2024 16:06:50 +0800
Message-ID: <20240727080650.12195-8-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240727080650.12195-1-pkshih@realtek.com>
References: <20240727080650.12195-1-pkshih@realtek.com>
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

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Originally, rtw89_btc_phymap() and rtw89_btc_path_phymap() access chan
with hard-code RTW89_CHANCTX_0. But, they are problematic when the chip
supports multiple channels.

So, change their prototype and pass chanctx_idx ahead. Let callers still
pass RTW89_CHANCTX_0 for now, but we will refine callers in the following.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/coex.h     | 10 ++++++----
 .../net/wireless/realtek/rtw89/rtw8851b_rfk.c | 10 +++++-----
 .../net/wireless/realtek/rtw89/rtw8852a_rfk.c | 20 +++++++++----------
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c | 12 +++++------
 .../wireless/realtek/rtw89/rtw8852bt_rfk.c    | 10 +++++-----
 .../net/wireless/realtek/rtw89/rtw8852c_rfk.c | 12 +++++------
 drivers/net/wireless/realtek/rtw89/rtw8922a.c |  2 +-
 7 files changed, 39 insertions(+), 37 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/coex.h b/drivers/net/wireless/realtek/rtw89/coex.h
index 72e3c77d2a3a..de53b56632f7 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.h
+++ b/drivers/net/wireless/realtek/rtw89/coex.h
@@ -291,9 +291,10 @@ void rtw89_coex_recognize_ver(struct rtw89_dev *rtwdev);
 
 static inline u8 rtw89_btc_phymap(struct rtw89_dev *rtwdev,
 				  enum rtw89_phy_idx phy_idx,
-				  enum rtw89_rf_path_bit paths)
+				  enum rtw89_rf_path_bit paths,
+				  enum rtw89_chanctx_idx chanctx_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	u8 phy_map;
 
 	phy_map = FIELD_PREP(BTC_RFK_PATH_MAP, paths) |
@@ -305,9 +306,10 @@ static inline u8 rtw89_btc_phymap(struct rtw89_dev *rtwdev,
 
 static inline u8 rtw89_btc_path_phymap(struct rtw89_dev *rtwdev,
 				       enum rtw89_phy_idx phy_idx,
-				       enum rtw89_rf_path path)
+				       enum rtw89_rf_path path,
+				       enum rtw89_chanctx_idx chanctx_idx)
 {
-	return rtw89_btc_phymap(rtwdev, phy_idx, BIT(path));
+	return rtw89_btc_phymap(rtwdev, phy_idx, BIT(path), chanctx_idx);
 }
 
 /* return bt req len in TU */
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
index 1312e299e1aa..7942f334066c 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b_rfk.c
@@ -1589,7 +1589,7 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
 		   enum rtw89_phy_idx phy_idx, u8 path)
 {
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB, RTW89_CHANCTX_0);
 	u32 backup_rf_val[RTW8851B_IQK_SS][BACKUP_RF_REGS_NR];
 	u32 backup_bb_val[BACKUP_BB_REGS_NR];
 
@@ -3257,7 +3257,7 @@ void rtw8851b_dack(struct rtw89_dev *rtwdev)
 
 void rtw8851b_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
 	u32 tx_en;
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_START);
@@ -3273,7 +3273,7 @@ void rtw8851b_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 
 void rtw8851b_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
 	u32 tx_en;
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_START);
@@ -3288,7 +3288,7 @@ void rtw8851b_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 
 void rtw8851b_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
 	u32 tx_en;
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DPK, BTC_WRFK_START);
@@ -3310,7 +3310,7 @@ void rtw8851b_dpk_track(struct rtw89_dev *rtwdev)
 
 void rtw8851b_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_en)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy, RF_A);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy, RF_A, RTW89_CHANCTX_0);
 	u8 i;
 
 	rtw89_debug(rtwdev, RTW89_DBG_TSSI, "[TSSI] %s: phy=%d\n", __func__, phy);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
index b059f6ff6e8f..6bae8bc07e93 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a_rfk.c
@@ -497,7 +497,7 @@ static void _dac_cal(struct rtw89_dev *rtwdev, bool force)
 {
 	struct rtw89_dack_info *dack = &rtwdev->dack;
 	u32 rf0_0, rf1_0;
-	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, RF_AB);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, RF_AB, RTW89_CHANCTX_0);
 
 	dack->dack_done = false;
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DACK b\n");
@@ -804,7 +804,7 @@ static bool _iqk_one_shot(struct rtw89_dev *rtwdev,
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	bool fail = false;
 	u32 iqk_cmd = 0x0;
-	u8 phy_map = rtw89_btc_path_phymap(rtwdev, phy_idx, path);
+	u8 phy_map = rtw89_btc_path_phymap(rtwdev, phy_idx, path, RTW89_CHANCTX_0);
 	u32 addr_rfc_ctl = 0x0;
 
 	if (path == RF_PATH_A)
@@ -1612,7 +1612,7 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	u32 backup_bb_val[BACKUP_BB_REGS_NR];
 	u32 backup_rf_val[RTW8852A_IQK_SS][BACKUP_RF_REGS_NR];
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB, RTW89_CHANCTX_0);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_START);
 
@@ -1658,7 +1658,7 @@ static void _iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool forc
 static void _set_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			enum rtw89_rf_path path, bool is_afe)
 {
-	u8 phy_map = rtw89_btc_path_phymap(rtwdev, phy, path);
+	u8 phy_map = rtw89_btc_path_phymap(rtwdev, phy, path, RTW89_CHANCTX_0);
 	u32 ori_val;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
@@ -1802,7 +1802,7 @@ static void _dpk_reload_kip(struct rtw89_dev *rtwdev, u32 *reg,
 static u8 _dpk_one_shot(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			enum rtw89_rf_path path, enum rtw8852a_dpk_id id)
 {
-	u8 phy_map  = rtw89_btc_path_phymap(rtwdev, phy, path);
+	u8 phy_map  = rtw89_btc_path_phymap(rtwdev, phy, path, RTW89_CHANCTX_0);
 	u16 dpk_cmd = 0x0;
 	u32 val;
 	int ret;
@@ -3514,7 +3514,7 @@ static void _tssi_pre_tx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 	u8 bw = chan->band_width;
 	u8 band = chan->band_type;
 	u32 tx_en;
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy, 0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy, 0, RTW89_CHANCTX_0);
 	s8 power;
 	s16 xdbm;
 	u32 i, tx_counter = 0;
@@ -3602,7 +3602,7 @@ void rtw8852a_rck(struct rtw89_dev *rtwdev)
 
 void rtw8852a_dack(struct rtw89_dev *rtwdev)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, 0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, 0, RTW89_CHANCTX_0);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DACK, BTC_WRFK_START);
 	_dac_cal(rtwdev, false);
@@ -3612,7 +3612,7 @@ void rtw8852a_dack(struct rtw89_dev *rtwdev)
 void rtw8852a_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	u32 tx_en;
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_START);
 	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
@@ -3632,7 +3632,7 @@ void rtw8852a_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 		     bool is_afe)
 {
 	u32 tx_en;
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_START);
 	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
@@ -3647,7 +3647,7 @@ void rtw8852a_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
 void rtw8852a_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	u32 tx_en;
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DPK, BTC_WRFK_START);
 	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index 72072042aca6..776a45d1fe33 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -1613,7 +1613,7 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	u32 backup_bb_val[BACKUP_BB_REGS_NR];
 	u32 backup_rf_val[RTW8852B_IQK_SS][BACKUP_RF_REGS_NR];
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB, RTW89_CHANCTX_0);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_START);
 
@@ -3757,7 +3757,7 @@ void rtw8852b_rck(struct rtw89_dev *rtwdev)
 
 void rtw8852b_dack(struct rtw89_dev *rtwdev)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, 0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, 0, RTW89_CHANCTX_0);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DACK, BTC_WRFK_START);
 	_dac_cal(rtwdev, false);
@@ -3766,7 +3766,7 @@ void rtw8852b_dack(struct rtw89_dev *rtwdev)
 
 void rtw8852b_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
 	u32 tx_en;
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_START);
@@ -3782,7 +3782,7 @@ void rtw8852b_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 
 void rtw8852b_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
 	u32 tx_en;
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_START);
@@ -3797,7 +3797,7 @@ void rtw8852b_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 
 void rtw8852b_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
 	u32 tx_en;
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DPK, BTC_WRFK_START);
@@ -3819,7 +3819,7 @@ void rtw8852b_dpk_track(struct rtw89_dev *rtwdev)
 
 void rtw8852b_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_en)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy, RF_AB);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy, RF_AB, RTW89_CHANCTX_0);
 	u32 tx_en;
 	u8 i;
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
index 56ca3fea8459..278f907fd895 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
@@ -1760,7 +1760,7 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	u32 backup_bb_val[BACKUP_BB_REGS_NR];
 	u32 backup_rf_val[RTW8852BT_SS][BACKUP_RF_REGS_NR];
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB, RTW89_CHANCTX_0);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_START);
 
@@ -3835,7 +3835,7 @@ void rtw8852bt_rck(struct rtw89_dev *rtwdev)
 
 void rtw8852bt_dack(struct rtw89_dev *rtwdev)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, 0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, 0, RTW89_CHANCTX_0);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DACK, BTC_WRFK_START);
 	_dac_cal(rtwdev, false);
@@ -3844,7 +3844,7 @@ void rtw8852bt_dack(struct rtw89_dev *rtwdev)
 
 void rtw8852bt_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
 	u32 tx_en;
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_START);
@@ -3860,7 +3860,7 @@ void rtw8852bt_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 
 void rtw8852bt_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
 	u32 tx_en;
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_START);
@@ -3892,7 +3892,7 @@ void rtw8852bt_dpk_track(struct rtw89_dev *rtwdev)
 void rtw8852bt_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_en)
 {
 	static const u32 reg[2] = {R_DPD_CH0A, R_DPD_CH0B};
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy, RF_AB);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy, RF_AB, RTW89_CHANCTX_0);
 	u32 reg_backup[2] = {};
 	u32 tx_en;
 	u8 i;
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
index 7c529304c5b8..6e199e82690b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c_rfk.c
@@ -588,7 +588,7 @@ static void _dac_cal(struct rtw89_dev *rtwdev, bool force)
 {
 	struct rtw89_dack_info *dack = &rtwdev->dack;
 	u32 rf0_0, rf1_0;
-	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, RF_AB);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, RF_AB, RTW89_CHANCTX_0);
 
 	dack->dack_done = false;
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DACK]DACK b\n");
@@ -1521,7 +1521,7 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	u32 backup_bb_val[BACKUP_BB_REGS_NR];
 	u32 backup_rf_val[RTW8852C_IQK_SS][BACKUP_RF_REGS_NR];
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB, RTW89_CHANCTX_0);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_START);
 
@@ -4114,7 +4114,7 @@ void rtw8852c_rck(struct rtw89_dev *rtwdev)
 
 void rtw8852c_dack(struct rtw89_dev *rtwdev)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, 0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, 0, RTW89_CHANCTX_0);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DACK, BTC_WRFK_START);
 	_dac_cal(rtwdev, false);
@@ -4124,7 +4124,7 @@ void rtw8852c_dack(struct rtw89_dev *rtwdev)
 void rtw8852c_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	u32 tx_en;
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_START);
 	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
@@ -4205,7 +4205,7 @@ void rtw8852c_rx_dck_track(struct rtw89_dev *rtwdev)
 	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_rx_dck_info *rx_dck = &rtwdev->rx_dck;
 	enum rtw89_phy_idx phy_idx = RTW89_PHY_0;
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
 	u8 dck_channel;
 	u8 cur_thermal;
 	u32 tx_en;
@@ -4262,7 +4262,7 @@ void rtw8852c_dpk_init(struct rtw89_dev *rtwdev)
 void rtw8852c_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 {
 	u32 tx_en;
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DPK, BTC_WRFK_START);
 	rtw89_chip_stop_sch_tx(rtwdev, phy_idx, &tx_en, RTW89_SCH_TX_SEL_ALL);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index 4e77ea55767b..e611534eeae1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -1956,7 +1956,7 @@ static void _wait_rx_mode(struct rtw89_dev *rtwdev, u8 kpath)
 static void rtw8922a_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
 	enum rtw89_phy_idx phy_idx = rtwvif->phy_idx;
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB, RTW89_CHANCTX_0);
 	u32 tx_en;
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_CHLK, BTC_WRFK_START);
-- 
2.25.1


