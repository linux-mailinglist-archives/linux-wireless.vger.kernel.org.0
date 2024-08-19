Return-Path: <linux-wireless+bounces-11608-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC70E9566B4
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 11:19:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0F63FB22CD1
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 09:19:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D9DA15F301;
	Mon, 19 Aug 2024 09:17:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="KeT6E8sk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFCF915DBA5
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 09:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724059076; cv=none; b=fvwwAPFqMrNNVNudfcyeUR9F6YgLX8md/+nbFdA7oKylA1SYuXw0ItscyKZ2nkJXKsRpCFEL2iTTmNRLt0ZTq3ASQ5Fbh87ZWItPdMPTjg2RHbCqX/Z+kAt5/I7W/NEiMqDAX7Zn9haMikJaWj5/RmcrFXJQFQh7O43i0knVTyg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724059076; c=relaxed/simple;
	bh=XWLT0dWSmvmeJmf2poLB3ouwQZ+zHVzGdzmx4pH5oHI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGppZcXmfnjj5W714Iv5cVdXlURpBQ1yhMijn+b1Lga/5Utw22ggIbi/mSsv6bCpYTkhbMIHqrZ3duQ0EEl4hrtkyMcaRx9sYb8WewfrqaYLqvaPXyjTdg1JnvAnVy/xd+WHDzjeoPAWF6at7CNPys77fF9dOK4EknQlSzILwWc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=KeT6E8sk; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47J9HnG224126017, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724059070; bh=XWLT0dWSmvmeJmf2poLB3ouwQZ+zHVzGdzmx4pH5oHI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=KeT6E8sk/thzguUj5MbqtYWhIyci17jW9CS1v5eF6b4a5EbSuefT2eHGs1GeJOh+8
	 r7a2orR1eeX1u+R5it6qI7Ws/cr0QDTbyNMU04FXpAUHbqsq0DCsFOVqx5Ct8SrNki
	 oGWeEYOgBf64AFtyln5ghyYtWK5mRG6LkHkfFHZIeGeIdrO76XFXxRDsDPjHimT0De
	 X0gpX3M+fjnQf0dHrRtOAs2aTEo9OzTVsXNuCX8Zehf+JMX2F5elI6sbROUxzXBcr5
	 H1fyO0cegvurdcU1Do5QK1L3ePJFV/yFUZq2f+UPPxYTa3KBGDTOdgfA5u6ph8DJ/s
	 Dq8wFJWKKKNBA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47J9HnG224126017
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 17:17:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 17:17:50 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Mon, 19 Aug
 2024 17:17:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <kevin_yang@realtek.com>
Subject: [PATCH 4/8] wifi: rtw89: 8852bx: use right chanctx whenever possible in RFK flow
Date: Mon, 19 Aug 2024 17:17:20 +0800
Message-ID: <20240819091724.33730-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240819091724.33730-1-pkshih@realtek.com>
References: <20240819091724.33730-1-pkshih@realtek.com>
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

No longer access chan with hard-code RTW89_CHANCTX_X whenever possible.
Instead, obtain the right chanctx from somewhere and use it in RTL8852BX
RFK (RF calibration) related code.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  17 +-
 .../wireless/realtek/rtw89/rtw8852b_common.c  |  15 +-
 .../wireless/realtek/rtw89/rtw8852b_common.h  |  15 +-
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.c | 211 +++++++++---------
 .../net/wireless/realtek/rtw89/rtw8852b_rfk.h |  20 +-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  25 ++-
 .../wireless/realtek/rtw89/rtw8852bt_rfk.c    | 188 ++++++++--------
 .../wireless/realtek/rtw89/rtw8852bt_rfk.h    |  20 +-
 8 files changed, 273 insertions(+), 238 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index d055847d2de4..4a4e825302ea 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -558,31 +558,32 @@ static void rtw8852b_rfk_init(struct rtw89_dev *rtwdev)
 
 	rtw8852b_dpk_init(rtwdev);
 	rtw8852b_rck(rtwdev);
-	rtw8852b_dack(rtwdev);
-	rtw8852b_rx_dck(rtwdev, RTW89_PHY_0);
+	rtw8852b_dack(rtwdev, RTW89_CHANCTX_0);
+	rtw8852b_rx_dck(rtwdev, RTW89_PHY_0, RTW89_CHANCTX_0);
 }
 
 static void rtw8852b_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
+	enum rtw89_chanctx_idx chanctx_idx = rtwvif->chanctx_idx;
 	enum rtw89_phy_idx phy_idx = rtwvif->phy_idx;
 
-	rtw8852b_rx_dck(rtwdev, phy_idx);
-	rtw8852b_iqk(rtwdev, phy_idx);
-	rtw8852b_tssi(rtwdev, phy_idx, true);
-	rtw8852b_dpk(rtwdev, phy_idx);
+	rtw8852b_rx_dck(rtwdev, phy_idx, chanctx_idx);
+	rtw8852b_iqk(rtwdev, phy_idx, chanctx_idx);
+	rtw8852b_tssi(rtwdev, phy_idx, true, chanctx_idx);
+	rtw8852b_dpk(rtwdev, phy_idx, chanctx_idx);
 }
 
 static void rtw8852b_rfk_band_changed(struct rtw89_dev *rtwdev,
 				      enum rtw89_phy_idx phy_idx,
 				      const struct rtw89_chan *chan)
 {
-	rtw8852b_tssi_scan(rtwdev, phy_idx);
+	rtw8852b_tssi_scan(rtwdev, phy_idx, chan);
 }
 
 static void rtw8852b_rfk_scan(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			      bool start)
 {
-	rtw8852b_wifi_scan_notify(rtwdev, start, rtwvif->phy_idx);
+	rtw8852b_wifi_scan_notify(rtwdev, start, rtwvif->phy_idx, rtwvif->chanctx_idx);
 }
 
 static void rtw8852b_rfk_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
index f364e76e2b34..bd05880cfe8f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
@@ -1445,10 +1445,8 @@ static void rtw8852bx_start_pmac_tx(struct rtw89_dev *rtwdev,
 static
 void rtw8852bx_bb_set_pmac_tx(struct rtw89_dev *rtwdev,
 			      struct rtw8852bx_bb_pmac_info *tx_info,
-			      enum rtw89_phy_idx idx)
+			      enum rtw89_phy_idx idx, const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
-
 	if (!tx_info->en_pmac_tx) {
 		rtw8852bx_stop_pmac_tx(rtwdev, tx_info, idx);
 		rtw89_phy_write32_idx(rtwdev, R_PD_CTRL, B_PD_HIT_DIS, 0, idx);
@@ -1473,7 +1471,7 @@ void rtw8852bx_bb_set_pmac_tx(struct rtw89_dev *rtwdev,
 static
 void __rtw8852bx_bb_set_pmac_pkt_tx(struct rtw89_dev *rtwdev, u8 enable,
 				    u16 tx_cnt, u16 period, u16 tx_time,
-				    enum rtw89_phy_idx idx)
+				    enum rtw89_phy_idx idx, const struct rtw89_chan *chan)
 {
 	struct rtw8852bx_bb_pmac_info tx_info = {0};
 
@@ -1484,7 +1482,7 @@ void __rtw8852bx_bb_set_pmac_pkt_tx(struct rtw89_dev *rtwdev, u8 enable,
 	tx_info.period = period;
 	tx_info.tx_time = tx_time;
 
-	rtw8852bx_bb_set_pmac_tx(rtwdev, &tx_info, idx);
+	rtw8852bx_bb_set_pmac_tx(rtwdev, &tx_info, idx, chan);
 }
 
 static
@@ -1623,9 +1621,9 @@ static void __rtw8852bx_ctrl_btg_bt_rx(struct rtw89_dev *rtwdev, bool en,
 
 static
 void __rtw8852bx_bb_ctrl_rx_path(struct rtw89_dev *rtwdev,
-				 enum rtw89_rf_path_bit rx_path)
+				 enum rtw89_rf_path_bit rx_path,
+				 const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u32 rst_mask0;
 	u32 rst_mask1;
 
@@ -1713,9 +1711,10 @@ static void rtw8852bx_bb_ctrl_rf_mode_rx_path(struct rtw89_dev *rtwdev,
 static void __rtw8852bx_bb_cfg_txrx_path(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hal *hal = &rtwdev->hal;
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_rf_path_bit rx_path = hal->antenna_rx ? hal->antenna_rx : RF_AB;
 
-	rtw8852bx_bb_ctrl_rx_path(rtwdev, rx_path);
+	rtw8852bx_bb_ctrl_rx_path(rtwdev, rx_path, chan);
 	rtw8852bx_bb_ctrl_rf_mode_rx_path(rtwdev, rx_path);
 
 	if (rtwdev->hal.rx_nss == 1) {
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.h b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.h
index 801e7ab9f4fa..a916e38c76c1 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.h
@@ -121,13 +121,14 @@ struct rtw8852bx_info {
 	void (*bb_cfg_txrx_path)(struct rtw89_dev *rtwdev);
 	void (*bb_cfg_tx_path)(struct rtw89_dev *rtwdev, u8 tx_path);
 	void (*bb_ctrl_rx_path)(struct rtw89_dev *rtwdev,
-				enum rtw89_rf_path_bit rx_path);
+				enum rtw89_rf_path_bit rx_path,
+				const struct rtw89_chan *chan);
 	void (*bb_set_plcp_tx)(struct rtw89_dev *rtwdev);
 	void (*bb_set_power)(struct rtw89_dev *rtwdev, s16 pwr_dbm,
 			     enum rtw89_phy_idx idx);
 	void (*bb_set_pmac_pkt_tx)(struct rtw89_dev *rtwdev, u8 enable,
 				   u16 tx_cnt, u16 period, u16 tx_time,
-				   enum rtw89_phy_idx idx);
+				   enum rtw89_phy_idx idx, const struct rtw89_chan *chan);
 	void (*bb_backup_tssi)(struct rtw89_dev *rtwdev, enum rtw89_phy_idx idx,
 			       struct rtw8852bx_bb_tssi_bak *bak);
 	void (*bb_restore_tssi)(struct rtw89_dev *rtwdev, enum rtw89_phy_idx idx,
@@ -207,9 +208,10 @@ void rtw8852bx_bb_cfg_tx_path(struct rtw89_dev *rtwdev, u8 tx_path)
 
 static inline
 void rtw8852bx_bb_ctrl_rx_path(struct rtw89_dev *rtwdev,
-			       enum rtw89_rf_path_bit rx_path)
+			       enum rtw89_rf_path_bit rx_path,
+			       const struct rtw89_chan *chan)
 {
-	rtw8852bx_info.bb_ctrl_rx_path(rtwdev, rx_path);
+	rtw8852bx_info.bb_ctrl_rx_path(rtwdev, rx_path, chan);
 }
 
 static inline
@@ -228,9 +230,10 @@ void rtw8852bx_bb_set_power(struct rtw89_dev *rtwdev, s16 pwr_dbm,
 static inline
 void rtw8852bx_bb_set_pmac_pkt_tx(struct rtw89_dev *rtwdev, u8 enable,
 				  u16 tx_cnt, u16 period, u16 tx_time,
-				  enum rtw89_phy_idx idx)
+				  enum rtw89_phy_idx idx, const struct rtw89_chan *chan)
 {
-	rtw8852bx_info.bb_set_pmac_pkt_tx(rtwdev, enable, tx_cnt, period, tx_time, idx);
+	rtw8852bx_info.bb_set_pmac_pkt_tx(rtwdev, enable, tx_cnt, period, tx_time, idx,
+					  chan);
 }
 
 static inline
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
index 776a45d1fe33..ef47a5facc83 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.c
@@ -1382,9 +1382,10 @@ static void _iqk_by_path(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u
 	_iqk_info_iqk(rtwdev, phy_idx, path);
 }
 
-static void _iqk_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, u8 path)
+static void _iqk_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, u8 path,
+			     enum rtw89_chanctx_idx chanctx_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	u32 reg_rf18;
 	u32 reg_35c;
@@ -1608,12 +1609,13 @@ static void _tmac_tx_pause(struct rtw89_dev *rtwdev, enum rtw89_phy_idx band_idx
 }
 
 static void _doiqk(struct rtw89_dev *rtwdev, bool force,
-		   enum rtw89_phy_idx phy_idx, u8 path)
+		   enum rtw89_phy_idx phy_idx, u8 path,
+		   enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	u32 backup_bb_val[BACKUP_BB_REGS_NR];
 	u32 backup_rf_val[RTW8852B_IQK_SS][BACKUP_RF_REGS_NR];
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB, chanctx_idx);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_START);
 
@@ -1623,7 +1625,7 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
 	iqk_info->version = RTW8852B_IQK_VER;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]Test Ver 0x%x\n", iqk_info->version);
-	_iqk_get_ch_info(rtwdev, phy_idx, path);
+	_iqk_get_ch_info(rtwdev, phy_idx, path, chanctx_idx);
 
 	_rfk_backup_bb_reg(rtwdev, &backup_bb_val[0]);
 	_rfk_backup_rf_reg(rtwdev, &backup_rf_val[path][0], path);
@@ -1638,20 +1640,21 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_STOP);
 }
 
-static void _iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool force)
+static void _iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool force,
+		 enum rtw89_chanctx_idx chanctx_idx)
 {
 	u8 kpath = _kpath(rtwdev, phy_idx);
 
 	switch (kpath) {
 	case RF_A:
-		_doiqk(rtwdev, force, phy_idx, RF_PATH_A);
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_A, chanctx_idx);
 		break;
 	case RF_B:
-		_doiqk(rtwdev, force, phy_idx, RF_PATH_B);
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_B, chanctx_idx);
 		break;
 	case RF_AB:
-		_doiqk(rtwdev, force, phy_idx, RF_PATH_A);
-		_doiqk(rtwdev, force, phy_idx, RF_PATH_B);
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_A, chanctx_idx);
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_B, chanctx_idx);
 		break;
 	default:
 		break;
@@ -1761,9 +1764,9 @@ static void _dpk_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 }
 
 static void _dpk_information(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			     enum rtw89_rf_path path)
+			     enum rtw89_rf_path path, enum rtw89_chanctx_idx chanctx_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 
 	u8 kidx = dpk->cur_idx[path];
@@ -1786,9 +1789,10 @@ static void _dpk_information(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 
 static void _dpk_bb_afe_setting(struct rtw89_dev *rtwdev,
 				enum rtw89_phy_idx phy,
-				enum rtw89_rf_path path, u8 kpath)
+				enum rtw89_rf_path path, u8 kpath,
+				enum rtw89_chanctx_idx chanctx_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 
 	rtw89_rfk_parser(rtwdev, &rtw8852b_dpk_afe_defs_tbl);
 
@@ -1803,9 +1807,10 @@ static void _dpk_bb_afe_setting(struct rtw89_dev *rtwdev,
 
 static void _dpk_bb_afe_restore(struct rtw89_dev *rtwdev,
 				enum rtw89_phy_idx phy,
-				enum rtw89_rf_path path, u8 kpath)
+				enum rtw89_rf_path path, u8 kpath,
+				enum rtw89_chanctx_idx chanctx_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 
 	rtw89_rfk_parser(rtwdev, &rtw8852b_dpk_afe_restore_defs_tbl);
 
@@ -2217,9 +2222,9 @@ static bool _dpk_pas_read(struct rtw89_dev *rtwdev, bool is_check)
 
 static u8 _dpk_agc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 		   enum rtw89_rf_path path, u8 kidx, u8 init_txagc,
-		   bool loss_only)
+		   bool loss_only, enum rtw89_chanctx_idx chanctx_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	u8 step = DPK_AGC_STEP_SYNC_DGAIN;
 	u8 tmp_txagc, tmp_rxbb = 0, tmp_gl_idx = 0;
 	u8 goout = 0, agc_cnt = 0, limited_rxbb = 0;
@@ -2416,9 +2421,9 @@ static void _dpk_fill_result(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 }
 
 static bool _dpk_reload_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			      enum rtw89_rf_path path)
+			      enum rtw89_rf_path path, enum rtw89_chanctx_idx chanctx_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 	bool is_reload = false;
 	u8 idx, cur_band, cur_ch;
@@ -2443,7 +2448,8 @@ static bool _dpk_reload_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 }
 
 static bool _dpk_main(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-		      enum rtw89_rf_path path, u8 gain)
+		      enum rtw89_rf_path path, u8 gain,
+		      enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 	u8 txagc = 0x38, kidx = dpk->cur_idx[path];
@@ -2464,7 +2470,7 @@ static bool _dpk_main(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	_dpk_kip_set_rxagc(rtwdev, phy, path);
 	_dpk_table_select(rtwdev, path, kidx, gain);
 
-	txagc = _dpk_agc(rtwdev, phy, path, kidx, txagc, false);
+	txagc = _dpk_agc(rtwdev, phy, path, kidx, txagc, false, chanctx_idx);
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[DPK] Adjust txagc = 0x%x\n", txagc);
 
 	if (txagc == 0xff) {
@@ -2491,7 +2497,8 @@ static bool _dpk_main(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 }
 
 static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
-			    enum rtw89_phy_idx phy, u8 kpath)
+			    enum rtw89_phy_idx phy, u8 kpath,
+			    enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 	static const u32 kip_reg[] = {0x813c, 0x8124, 0x8120};
@@ -2503,7 +2510,8 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
 
 	if (dpk->is_dpk_reload_en) {
 		for (path = 0; path < RTW8852B_DPK_RF_PATH; path++) {
-			reloaded[path] = _dpk_reload_check(rtwdev, phy, path);
+			reloaded[path] = _dpk_reload_check(rtwdev, phy, path,
+							   chanctx_idx);
 			if (!reloaded[path] && dpk->bp[path][0].ch)
 				dpk->cur_idx[path] = !dpk->cur_idx[path];
 			else
@@ -2519,19 +2527,19 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
 	for (path = 0; path < RTW8852B_DPK_RF_PATH; path++) {
 		_dpk_bkup_kip(rtwdev, kip_reg, kip_bkup, path);
 		_rfk_backup_rf_reg(rtwdev, &backup_rf_val[path][0], path);
-		_dpk_information(rtwdev, phy, path);
+		_dpk_information(rtwdev, phy, path, chanctx_idx);
 		if (rtwdev->is_tssi_mode[path])
 			_dpk_tssi_pause(rtwdev, path, true);
 	}
 
-	_dpk_bb_afe_setting(rtwdev, phy, path, kpath);
+	_dpk_bb_afe_setting(rtwdev, phy, path, kpath, chanctx_idx);
 
 	for (path = 0; path < RTW8852B_DPK_RF_PATH; path++) {
-		is_fail = _dpk_main(rtwdev, phy, path, 1);
+		is_fail = _dpk_main(rtwdev, phy, path, 1, chanctx_idx);
 		_dpk_onoff(rtwdev, path, is_fail);
 	}
 
-	_dpk_bb_afe_restore(rtwdev, phy, path, kpath);
+	_dpk_bb_afe_restore(rtwdev, phy, path, kpath, chanctx_idx);
 	_rfk_restore_bb_reg(rtwdev, &backup_bb_val[0]);
 
 	for (path = 0; path < RTW8852B_DPK_RF_PATH; path++) {
@@ -2543,9 +2551,10 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev, bool force,
 	}
 }
 
-static bool _dpk_bypass_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+static bool _dpk_bypass_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			      enum rtw89_chanctx_idx chanctx_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	struct rtw89_fem_info *fem = &rtwdev->fem;
 
 	if (fem->epa_2g && chan->band_type == RTW89_BAND_2G) {
@@ -2577,17 +2586,18 @@ static void _dpk_force_bypass(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 	}
 }
 
-static void _dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool force)
+static void _dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool force,
+		 enum rtw89_chanctx_idx chanctx_idx)
 {
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[DPK] ****** DPK Start (Ver: 0x%x, Cv: %d, RF_para: %d) ******\n",
 		    RTW8852B_DPK_VER, rtwdev->hal.cv,
 		    RTW8852B_RF_REL_VERSION);
 
-	if (_dpk_bypass_check(rtwdev, phy))
+	if (_dpk_bypass_check(rtwdev, phy, chanctx_idx))
 		_dpk_force_bypass(rtwdev, phy);
 	else
-		_dpk_cal_select(rtwdev, force, phy, RF_AB);
+		_dpk_cal_select(rtwdev, force, phy, RF_AB, chanctx_idx);
 }
 
 static void _dpk_track(struct rtw89_dev *rtwdev)
@@ -2722,9 +2732,8 @@ static void _set_dpd_backoff(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 }
 
 static void _tssi_rf_setting(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			     enum rtw89_rf_path path)
+			     enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	if (band == RTW89_BAND_2G)
@@ -2734,9 +2743,8 @@ static void _tssi_rf_setting(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 }
 
 static void _tssi_set_sys(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			  enum rtw89_rf_path path)
+			  enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	rtw89_rfk_parser(rtwdev, &rtw8852b_tssi_sys_defs_tbl);
@@ -2778,7 +2786,7 @@ static void _tssi_set_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 }
 
 static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-				 enum rtw89_rf_path path)
+				 enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
 #define RTW8852B_TSSI_GET_VAL(ptr, idx)			\
 ({							\
@@ -2792,7 +2800,6 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	__val;						\
 })
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u8 subband = chan->subband_type;
 	const s8 *thm_up_a = NULL;
@@ -2944,9 +2951,8 @@ static void _tssi_set_dac_gain_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx
 }
 
 static void _tssi_slope_cal_org(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-				enum rtw89_rf_path path)
+				enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	if (path == RF_PATH_A)
@@ -2960,9 +2966,9 @@ static void _tssi_slope_cal_org(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy
 }
 
 static void _tssi_alignment_default(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-				    enum rtw89_rf_path path, bool all)
+				    enum rtw89_rf_path path, bool all,
+				    const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 	const struct rtw89_rfk_tbl *tbl = NULL;
 	u8 ch = chan->channel;
@@ -3231,10 +3237,9 @@ static u32 _tssi_get_trim_group(struct rtw89_dev *rtwdev, u8 ch)
 }
 
 static s8 _tssi_get_ofdm_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			    enum rtw89_rf_path path)
+			    enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u32 gidx, gidx_1st, gidx_2nd;
 	s8 de_1st;
@@ -3267,10 +3272,9 @@ static s8 _tssi_get_ofdm_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 }
 
 static s8 _tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-				 enum rtw89_rf_path path)
+				 enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u32 tgidx, tgidx_1st, tgidx_2nd;
 	s8 tde_1st;
@@ -3304,10 +3308,10 @@ static s8 _tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	return val;
 }
 
-static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				  const struct rtw89_chan *chan)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u8 gidx;
 	s8 ofdm_de;
@@ -3320,7 +3324,7 @@ static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx p
 
 	for (i = RF_PATH_A; i < RF_PATH_NUM_8852B; i++) {
 		gidx = _tssi_get_cck_group(rtwdev, ch);
-		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i);
+		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i, chan);
 		val = tssi_info->tssi_cck[i][gidx] + trim_de;
 
 		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
@@ -3336,8 +3340,8 @@ static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx p
 			    rtw89_phy_read32_mask(rtwdev, _tssi_de_cck_long[i],
 						  _TSSI_DE_MASK));
 
-		ofdm_de = _tssi_get_ofdm_de(rtwdev, phy, i);
-		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i);
+		ofdm_de = _tssi_get_ofdm_de(rtwdev, phy, i, chan);
+		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i, chan);
 		val = ofdm_de + trim_de;
 
 		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
@@ -3383,10 +3387,10 @@ static void _tssi_alimentk_dump_result(struct rtw89_dev *rtwdev, enum rtw89_rf_p
 }
 
 static void _tssi_alimentk_done(struct rtw89_dev *rtwdev,
-				enum rtw89_phy_idx phy, enum rtw89_rf_path path)
+				enum rtw89_phy_idx phy, enum rtw89_rf_path path,
+				const struct rtw89_chan *chan)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 channel = chan->channel;
 	u8 band;
 
@@ -3420,7 +3424,7 @@ static void _tssi_alimentk_done(struct rtw89_dev *rtwdev,
 
 static void _tssi_hw_tx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			enum rtw89_rf_path path, u16 cnt, u16 period, s16 pwr_dbm,
-			u8 enable)
+			u8 enable, const struct rtw89_chan *chan)
 {
 	enum rtw89_rf_path_bit rx_path;
 
@@ -3436,11 +3440,11 @@ static void _tssi_hw_tx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	if (enable) {
 		rtw8852bx_bb_set_plcp_tx(rtwdev);
 		rtw8852bx_bb_cfg_tx_path(rtwdev, path);
-		rtw8852bx_bb_ctrl_rx_path(rtwdev, rx_path);
+		rtw8852bx_bb_ctrl_rx_path(rtwdev, rx_path, chan);
 		rtw8852bx_bb_set_power(rtwdev, pwr_dbm, phy);
 	}
 
-	rtw8852bx_bb_set_pmac_pkt_tx(rtwdev, enable, cnt, period, 20, phy);
+	rtw8852bx_bb_set_pmac_pkt_tx(rtwdev, enable, cnt, period, 20, phy, chan);
 }
 
 static void _tssi_backup_bb_registers(struct rtw89_dev *rtwdev,
@@ -3494,7 +3498,7 @@ static u8 _tssi_ch_to_idx(struct rtw89_dev *rtwdev, u8 channel)
 
 static bool _tssi_get_cw_report(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 				enum rtw89_rf_path path, const s16 *power,
-				u32 *tssi_cw_rpt)
+				u32 *tssi_cw_rpt, const struct rtw89_chan *chan)
 {
 	u32 tx_counter, tx_counter_tmp;
 	const int retry = 100;
@@ -3513,9 +3517,10 @@ static bool _tssi_get_cw_report(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy
 			    _tssi_trigger[path], tmp, path);
 
 		if (j == 0)
-			_tssi_hw_tx(rtwdev, phy, path, 100, 5000, power[j], true);
+			_tssi_hw_tx(rtwdev, phy, path, 100, 5000, power[j], true, chan);
 		else
-			_tssi_hw_tx(rtwdev, phy, RF_PATH_ABCD, 100, 5000, power[j], true);
+			_tssi_hw_tx(rtwdev, phy, RF_PATH_ABCD, 100, 5000, power[j], true,
+				    chan);
 
 		tx_counter_tmp = rtw89_phy_read32_mask(rtwdev, R_TX_COUNTER, MASKLWORD);
 		tx_counter_tmp -= tx_counter;
@@ -3546,14 +3551,14 @@ static bool _tssi_get_cw_report(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy
 				    "[TSSI PA K] TSSI finish bit k > %d mp:100ms normal:30us path=%d\n",
 				    k, path);
 
-			_tssi_hw_tx(rtwdev, phy, path, 100, 5000, power[j], false);
+			_tssi_hw_tx(rtwdev, phy, path, 100, 5000, power[j], false, chan);
 			return false;
 		}
 
 		tssi_cw_rpt[j] =
 			rtw89_phy_read32_mask(rtwdev, _tssi_cw_rpt_addr[path], B_TSSI_CWRPT);
 
-		_tssi_hw_tx(rtwdev, phy, path, 100, 5000, power[j], false);
+		_tssi_hw_tx(rtwdev, phy, path, 100, 5000, power[j], false, chan);
 
 		tx_counter_tmp = rtw89_phy_read32_mask(rtwdev, R_TX_COUNTER, MASKLWORD);
 		tx_counter_tmp -= tx_counter;
@@ -3567,14 +3572,13 @@ static bool _tssi_get_cw_report(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy
 }
 
 static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			   enum rtw89_rf_path path)
+			   enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
 	static const u32 bb_reg[8] = {0x5820, 0x7820, 0x4978, 0x58e4,
 				      0x78e4, 0x49c0, 0x0d18, 0x0d80};
 	static const s16 power_2g[4] = {48, 20, 4, 4};
 	static const s16 power_5g[4] = {48, 20, 4, 4};
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	s32 tssi_alim_offset_1, tssi_alim_offset_2, tssi_alim_offset_3;
 	u32 tssi_cw_rpt[RTW8852B_TSSI_PATH_NR] = {0};
 	u8 channel = chan->channel;
@@ -3635,7 +3639,7 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_MV_AVG, B_P0_TSSI_MV_AVG, 0x2);
 	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_MV_AVG, B_P1_TSSI_MV_AVG, 0x2);
 
-	ok = _tssi_get_cw_report(rtwdev, phy, path, power, tssi_cw_rpt);
+	ok = _tssi_get_cw_report(rtwdev, phy, path, power, tssi_cw_rpt, chan);
 	if (!ok)
 		goto out;
 
@@ -3755,18 +3759,19 @@ void rtw8852b_rck(struct rtw89_dev *rtwdev)
 		_rck(rtwdev, path);
 }
 
-void rtw8852b_dack(struct rtw89_dev *rtwdev)
+void rtw8852b_dack(struct rtw89_dev *rtwdev, enum rtw89_chanctx_idx chanctx_idx)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, 0, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, 0, chanctx_idx);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DACK, BTC_WRFK_START);
 	_dac_cal(rtwdev, false);
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DACK, BTC_WRFK_STOP);
 }
 
-void rtw8852b_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+void rtw8852b_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		  enum rtw89_chanctx_idx chanctx_idx)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, chanctx_idx);
 	u32 tx_en;
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_START);
@@ -3774,15 +3779,16 @@ void rtw8852b_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	_wait_rx_mode(rtwdev, _kpath(rtwdev, phy_idx));
 
 	_iqk_init(rtwdev);
-	_iqk(rtwdev, phy_idx, false);
+	_iqk(rtwdev, phy_idx, false, chanctx_idx);
 
 	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_STOP);
 }
 
-void rtw8852b_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+void rtw8852b_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		     enum rtw89_chanctx_idx chanctx_idx)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, chanctx_idx);
 	u32 tx_en;
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_START);
@@ -3795,9 +3801,10 @@ void rtw8852b_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_STOP);
 }
 
-void rtw8852b_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+void rtw8852b_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		  enum rtw89_chanctx_idx chanctx_idx)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, chanctx_idx);
 	u32 tx_en;
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DPK, BTC_WRFK_START);
@@ -3806,7 +3813,7 @@ void rtw8852b_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 
 	rtwdev->dpk.is_dpk_enable = true;
 	rtwdev->dpk.is_dpk_reload_en = false;
-	_dpk(rtwdev, phy_idx, false);
+	_dpk(rtwdev, phy_idx, false, chanctx_idx);
 
 	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DPK, BTC_WRFK_STOP);
@@ -3817,9 +3824,11 @@ void rtw8852b_dpk_track(struct rtw89_dev *rtwdev)
 	_dpk_track(rtwdev);
 }
 
-void rtw8852b_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_en)
+void rtw8852b_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		   bool hwtx_en, enum rtw89_chanctx_idx chanctx_idx)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy, RF_AB, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy, RF_AB, chanctx_idx);
 	u32 tx_en;
 	u8 i;
 
@@ -3829,34 +3838,34 @@ void rtw8852b_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_e
 	_tssi_disable(rtwdev, phy);
 
 	for (i = RF_PATH_A; i < RF_PATH_NUM_8852B; i++) {
-		_tssi_rf_setting(rtwdev, phy, i);
-		_tssi_set_sys(rtwdev, phy, i);
+		_tssi_rf_setting(rtwdev, phy, i, chan);
+		_tssi_set_sys(rtwdev, phy, i, chan);
 		_tssi_ini_txpwr_ctrl_bb(rtwdev, phy, i);
 		_tssi_ini_txpwr_ctrl_bb_he_tb(rtwdev, phy, i);
 		_tssi_set_dck(rtwdev, phy, i);
-		_tssi_set_tmeter_tbl(rtwdev, phy, i);
+		_tssi_set_tmeter_tbl(rtwdev, phy, i, chan);
 		_tssi_set_dac_gain_tbl(rtwdev, phy, i);
-		_tssi_slope_cal_org(rtwdev, phy, i);
-		_tssi_alignment_default(rtwdev, phy, i, true);
+		_tssi_slope_cal_org(rtwdev, phy, i, chan);
+		_tssi_alignment_default(rtwdev, phy, i, true, chan);
 		_tssi_set_tssi_slope(rtwdev, phy, i);
 
 		rtw89_chip_stop_sch_tx(rtwdev, phy, &tx_en, RTW89_SCH_TX_SEL_ALL);
 		_tmac_tx_pause(rtwdev, phy, true);
 		if (hwtx_en)
-			_tssi_alimentk(rtwdev, phy, i);
+			_tssi_alimentk(rtwdev, phy, i, chan);
 		_tmac_tx_pause(rtwdev, phy, false);
 		rtw89_chip_resume_sch_tx(rtwdev, phy, tx_en);
 	}
 
 	_tssi_enable(rtwdev, phy);
-	_tssi_set_efuse_to_de(rtwdev, phy);
+	_tssi_set_efuse_to_de(rtwdev, phy, chan);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_STOP);
 }
 
-void rtw8852b_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+void rtw8852b_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
 	u8 channel = chan->channel;
 	u8 band;
@@ -3879,24 +3888,25 @@ void rtw8852b_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 	_tssi_disable(rtwdev, phy);
 
 	for (i = RF_PATH_A; i < RTW8852B_TSSI_PATH_NR; i++) {
-		_tssi_rf_setting(rtwdev, phy, i);
-		_tssi_set_sys(rtwdev, phy, i);
-		_tssi_set_tmeter_tbl(rtwdev, phy, i);
+		_tssi_rf_setting(rtwdev, phy, i, chan);
+		_tssi_set_sys(rtwdev, phy, i, chan);
+		_tssi_set_tmeter_tbl(rtwdev, phy, i, chan);
 
 		if (tssi_info->alignment_done[i][band])
-			_tssi_alimentk_done(rtwdev, phy, i);
+			_tssi_alimentk_done(rtwdev, phy, i, chan);
 		else
-			_tssi_alignment_default(rtwdev, phy, i, true);
+			_tssi_alignment_default(rtwdev, phy, i, true, chan);
 	}
 
 	_tssi_enable(rtwdev, phy);
-	_tssi_set_efuse_to_de(rtwdev, phy);
+	_tssi_set_efuse_to_de(rtwdev, phy, chan);
 }
 
 static void rtw8852b_tssi_default_txagc(struct rtw89_dev *rtwdev,
-					enum rtw89_phy_idx phy, bool enable)
+					enum rtw89_phy_idx phy, bool enable,
+					enum rtw89_chanctx_idx chanctx_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	u8 channel = chan->channel;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "======> %s   ch=%d\n",
@@ -3904,7 +3914,7 @@ static void rtw8852b_tssi_default_txagc(struct rtw89_dev *rtwdev,
 
 	if (enable) {
 		if (!rtwdev->is_tssi_mode[RF_PATH_A] && !rtwdev->is_tssi_mode[RF_PATH_B])
-			rtw8852b_tssi(rtwdev, phy, true);
+			rtw8852b_tssi(rtwdev, phy, true, chanctx_idx);
 		return;
 	}
 
@@ -3921,8 +3931,8 @@ static void rtw8852b_tssi_default_txagc(struct rtw89_dev *rtwdev,
 	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_OFT_EN, 0x0);
 	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_OFT_EN, 0x1);
 
-	_tssi_alimentk_done(rtwdev, phy, RF_PATH_A);
-	_tssi_alimentk_done(rtwdev, phy, RF_PATH_B);
+	_tssi_alimentk_done(rtwdev, phy, RF_PATH_A, chan);
+	_tssi_alimentk_done(rtwdev, phy, RF_PATH_B, chan);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "======>%s 2 SCAN_END Set 0x5818[7:0]=0x%x 0x7818[7:0]=0x%x\n",
@@ -3935,12 +3945,13 @@ static void rtw8852b_tssi_default_txagc(struct rtw89_dev *rtwdev,
 }
 
 void rtw8852b_wifi_scan_notify(struct rtw89_dev *rtwdev, bool scan_start,
-			       enum rtw89_phy_idx phy_idx)
+			       enum rtw89_phy_idx phy_idx,
+			       enum rtw89_chanctx_idx chanctx_idx)
 {
 	if (scan_start)
-		rtw8852b_tssi_default_txagc(rtwdev, phy_idx, true);
+		rtw8852b_tssi_default_txagc(rtwdev, phy_idx, true, chanctx_idx);
 	else
-		rtw8852b_tssi_default_txagc(rtwdev, phy_idx, false);
+		rtw8852b_tssi_default_txagc(rtwdev, phy_idx, false, chanctx_idx);
 }
 
 static void _bw_setting(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
index f52832065600..c31ba446e6e0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_rfk.h
@@ -8,16 +8,22 @@
 #include "core.h"
 
 void rtw8852b_rck(struct rtw89_dev *rtwdev);
-void rtw8852b_dack(struct rtw89_dev *rtwdev);
-void rtw8852b_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
-void rtw8852b_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
+void rtw8852b_dack(struct rtw89_dev *rtwdev, enum rtw89_chanctx_idx chanctx_idx);
+void rtw8852b_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		  enum rtw89_chanctx_idx chanctx_idx);
+void rtw8852b_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		     enum rtw89_chanctx_idx chanctx_idx);
 void rtw8852b_dpk_init(struct rtw89_dev *rtwdev);
-void rtw8852b_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
+void rtw8852b_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		  enum rtw89_chanctx_idx chanctx_idx);
 void rtw8852b_dpk_track(struct rtw89_dev *rtwdev);
-void rtw8852b_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_en);
-void rtw8852b_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
+void rtw8852b_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		   bool hwtx_en, enum rtw89_chanctx_idx chanctx_idx);
+void rtw8852b_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			const struct rtw89_chan *chan);
 void rtw8852b_wifi_scan_notify(struct rtw89_dev *rtwdev, bool scan_start,
-			       enum rtw89_phy_idx phy_idx);
+			       enum rtw89_phy_idx phy_idx,
+			       enum rtw89_chanctx_idx chanctx_idx);
 void rtw8852b_set_channel_rf(struct rtw89_dev *rtwdev,
 			     const struct rtw89_chan *chan,
 			     enum rtw89_phy_idx phy_idx);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index 5eb38370aba4..f7d133ac34de 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -480,12 +480,12 @@ static void rtw8852bt_tssi_cont_en(struct rtw89_dev *rtwdev, bool en,
 }
 
 static void rtw8852bt_tssi_cont_en_phyidx(struct rtw89_dev *rtwdev, bool en,
-					  u8 phy_idx)
+					  u8 phy_idx, const struct rtw89_chan *chan)
 {
 	if (!rtwdev->dbcc_en) {
 		rtw8852bt_tssi_cont_en(rtwdev, en, RF_PATH_A);
 		rtw8852bt_tssi_cont_en(rtwdev, en, RF_PATH_B);
-		rtw8852bt_tssi_scan(rtwdev, phy_idx);
+		rtw8852bt_tssi_scan(rtwdev, phy_idx, chan);
 	} else {
 		if (phy_idx == RTW89_PHY_0)
 			rtw8852bt_tssi_cont_en(rtwdev, en, RF_PATH_A);
@@ -511,14 +511,14 @@ static void rtw8852bt_set_channel_help(struct rtw89_dev *rtwdev, bool enter,
 	if (enter) {
 		rtw89_chip_stop_sch_tx(rtwdev, RTW89_MAC_0, &p->tx_en, RTW89_SCH_TX_SEL_ALL);
 		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, false);
-		rtw8852bt_tssi_cont_en_phyidx(rtwdev, false, RTW89_PHY_0);
+		rtw8852bt_tssi_cont_en_phyidx(rtwdev, false, RTW89_PHY_0, chan);
 		rtw8852bt_adc_en(rtwdev, false);
 		fsleep(40);
 		rtw8852bt_bb_reset_en(rtwdev, chan->band_type, phy_idx, false);
 	} else {
 		rtw89_mac_cfg_ppdu_status(rtwdev, RTW89_MAC_0, true);
 		rtw8852bt_adc_en(rtwdev, true);
-		rtw8852bt_tssi_cont_en_phyidx(rtwdev, true, RTW89_PHY_0);
+		rtw8852bt_tssi_cont_en_phyidx(rtwdev, true, RTW89_PHY_0, chan);
 		rtw8852bt_bb_reset_en(rtwdev, chan->band_type, phy_idx, true);
 		rtw89_chip_resume_sch_tx(rtwdev, RTW89_MAC_0, p->tx_en);
 	}
@@ -531,31 +531,32 @@ static void rtw8852bt_rfk_init(struct rtw89_dev *rtwdev)
 
 	rtw8852bt_dpk_init(rtwdev);
 	rtw8852bt_rck(rtwdev);
-	rtw8852bt_dack(rtwdev);
-	rtw8852bt_rx_dck(rtwdev, RTW89_PHY_0);
+	rtw8852bt_dack(rtwdev, RTW89_CHANCTX_0);
+	rtw8852bt_rx_dck(rtwdev, RTW89_PHY_0, RTW89_CHANCTX_0);
 }
 
 static void rtw8852bt_rfk_channel(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 {
+	enum rtw89_chanctx_idx chanctx_idx = rtwvif->chanctx_idx;
 	enum rtw89_phy_idx phy_idx = rtwvif->phy_idx;
 
-	rtw8852bt_rx_dck(rtwdev, phy_idx);
-	rtw8852bt_iqk(rtwdev, phy_idx);
-	rtw8852bt_tssi(rtwdev, phy_idx, true);
-	rtw8852bt_dpk(rtwdev, phy_idx);
+	rtw8852bt_rx_dck(rtwdev, phy_idx, chanctx_idx);
+	rtw8852bt_iqk(rtwdev, phy_idx, chanctx_idx);
+	rtw8852bt_tssi(rtwdev, phy_idx, true, chanctx_idx);
+	rtw8852bt_dpk(rtwdev, phy_idx, chanctx_idx);
 }
 
 static void rtw8852bt_rfk_band_changed(struct rtw89_dev *rtwdev,
 				       enum rtw89_phy_idx phy_idx,
 				       const struct rtw89_chan *chan)
 {
-	rtw8852bt_tssi_scan(rtwdev, phy_idx);
+	rtw8852bt_tssi_scan(rtwdev, phy_idx, chan);
 }
 
 static void rtw8852bt_rfk_scan(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 			       bool start)
 {
-	rtw8852bt_wifi_scan_notify(rtwdev, start, rtwvif->phy_idx);
+	rtw8852bt_wifi_scan_notify(rtwdev, start, rtwvif->phy_idx, rtwvif->chanctx_idx);
 }
 
 static void rtw8852bt_rfk_track(struct rtw89_dev *rtwdev)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
index 278f907fd895..336a83e1d46b 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.c
@@ -1525,9 +1525,10 @@ static void _iqk_by_path(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, u
 		    lok_result, txk_result, rxk_result);
 }
 
-static void _iqk_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, u8 path)
+static void _iqk_get_ch_info(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, u8 path,
+			     enum rtw89_chanctx_idx chanctx_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	u8 get_empty_table = false;
 	u32 reg_rf18;
@@ -1755,12 +1756,13 @@ static void _tmac_tx_pause(struct rtw89_dev *rtwdev, enum rtw89_phy_idx band_idx
 }
 
 static void _doiqk(struct rtw89_dev *rtwdev, bool force,
-		   enum rtw89_phy_idx phy_idx, u8 path)
+		   enum rtw89_phy_idx phy_idx, u8 path,
+		   enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_iqk_info *iqk_info = &rtwdev->iqk;
 	u32 backup_bb_val[BACKUP_BB_REGS_NR];
 	u32 backup_rf_val[RTW8852BT_SS][BACKUP_RF_REGS_NR];
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, RF_AB, chanctx_idx);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_START);
 
@@ -1770,7 +1772,7 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
 	iqk_info->version = RTW8852BT_IQK_VER;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "[IQK]Test Ver 0x%x\n", iqk_info->version);
-	_iqk_get_ch_info(rtwdev, phy_idx, path);
+	_iqk_get_ch_info(rtwdev, phy_idx, path, chanctx_idx);
 
 	_rfk_backup_bb_reg(rtwdev, backup_bb_val);
 	_rfk_backup_rf_reg(rtwdev, backup_rf_val[path], path);
@@ -1785,20 +1787,21 @@ static void _doiqk(struct rtw89_dev *rtwdev, bool force,
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_STOP);
 }
 
-static void _iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool force)
+static void _iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx, bool force,
+		 enum rtw89_chanctx_idx chanctx_idx)
 {
 	u8 kpath = _kpath(rtwdev, phy_idx);
 
 	switch (kpath) {
 	case RF_A:
-		_doiqk(rtwdev, force, phy_idx, RF_PATH_A);
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_A, chanctx_idx);
 		break;
 	case RF_B:
-		_doiqk(rtwdev, force, phy_idx, RF_PATH_B);
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_B, chanctx_idx);
 		break;
 	case RF_AB:
-		_doiqk(rtwdev, force, phy_idx, RF_PATH_A);
-		_doiqk(rtwdev, force, phy_idx, RF_PATH_B);
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_A, chanctx_idx);
+		_doiqk(rtwdev, force, phy_idx, RF_PATH_B, chanctx_idx);
 		break;
 	default:
 		break;
@@ -1879,9 +1882,9 @@ static void _dpk_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 }
 
 static void _dpk_information(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			     enum rtw89_rf_path path)
+			     enum rtw89_rf_path path, enum rtw89_chanctx_idx chanctx_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 
 	u8 kidx = dpk->cur_idx[path];
@@ -2277,9 +2280,9 @@ static bool _dpk_pas_read(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
 
 static u8 _dpk_agc(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 		   enum rtw89_rf_path path, u8 kidx, u8 init_txagc,
-		   bool loss_only)
+		   bool loss_only, enum rtw89_chanctx_idx chanctx_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 	u8 goout = 0, agc_cnt = 0, limited_rxbb = 0, gl_cnt = 0;
 	u8 tmp_txagc, tmp_rxbb, tmp_gl_idx = 0;
@@ -2504,9 +2507,9 @@ static void _dpk_fill_result(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 }
 
 static bool _dpk_reload_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			      enum rtw89_rf_path path)
+			      enum rtw89_rf_path path, enum rtw89_chanctx_idx chanctx_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 	u8 idx, cur_band, cur_ch;
 	bool is_reload = false;
@@ -2549,7 +2552,8 @@ void _drf_direct_cntrl(struct rtw89_dev *rtwdev, enum rtw89_rf_path path, bool i
 }
 
 static bool _dpk_main(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-		      enum rtw89_rf_path path, u8 gain)
+		      enum rtw89_rf_path path, u8 gain,
+		      enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 	u8 txagc = 0x38, kidx = dpk->cur_idx[path];
@@ -2569,7 +2573,7 @@ static bool _dpk_main(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	_dpk_kip_set_rxagc(rtwdev, phy, path);
 	_dpk_table_select(rtwdev, path, kidx, gain);
 
-	txagc = _dpk_agc(rtwdev, phy, path, kidx, txagc, false);
+	txagc = _dpk_agc(rtwdev, phy, path, kidx, txagc, false, chanctx_idx);
 
 	_rfk_get_thermal(rtwdev, kidx, path);
 
@@ -2601,7 +2605,8 @@ static bool _dpk_main(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 }
 
 static void _dpk_cal_select(struct rtw89_dev *rtwdev,
-			    enum rtw89_phy_idx phy, u8 kpath)
+			    enum rtw89_phy_idx phy, u8 kpath,
+			    enum rtw89_chanctx_idx chanctx_idx)
 {
 	struct rtw89_dpk_info *dpk = &rtwdev->dpk;
 	u32 backup_kip_val[BACKUP_KIP_REGS_NR];
@@ -2611,7 +2616,7 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev,
 	u8 path;
 
 	for (path = 0; path < DPK_RF_PATH_MAX_8852BT; path++) {
-		reloaded[path] = _dpk_reload_check(rtwdev, phy, path);
+		reloaded[path] = _dpk_reload_check(rtwdev, phy, path, chanctx_idx);
 		if (!reloaded[path] && dpk->bp[path][0].ch != 0)
 			dpk->cur_idx[path] = !dpk->cur_idx[path];
 		else
@@ -2623,7 +2628,7 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev,
 
 	for (path = 0; path < DPK_RF_PATH_MAX_8852BT; path++) {
 		_rfk_backup_rf_reg(rtwdev, backup_rf_val[path], path);
-		_dpk_information(rtwdev, phy, path);
+		_dpk_information(rtwdev, phy, path, chanctx_idx);
 		if (rtwdev->is_tssi_mode[path])
 			_dpk_tssi_pause(rtwdev, path, true);
 	}
@@ -2631,7 +2636,7 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev,
 	_rfk_bb_afe_setting(rtwdev, phy, path, kpath);
 
 	for (path = 0; path < DPK_RF_PATH_MAX_8852BT; path++)
-		_dpk_main(rtwdev, phy, path, 1);
+		_dpk_main(rtwdev, phy, path, 1, chanctx_idx);
 
 	_rfk_bb_afe_restore(rtwdev, phy, path, kpath);
 
@@ -2646,9 +2651,10 @@ static void _dpk_cal_select(struct rtw89_dev *rtwdev,
 	}
 }
 
-static bool _dpk_bypass_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+static bool _dpk_bypass_check(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			      enum rtw89_chanctx_idx chanctx_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	struct rtw89_fem_info *fem = &rtwdev->fem;
 
 	if (fem->epa_2g && chan->band_type == RTW89_BAND_2G) {
@@ -2817,9 +2823,8 @@ static void _tssi_dpk_off(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 }
 
 static void _tssi_rf_setting(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			     enum rtw89_rf_path path)
+			     enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	if (band == RTW89_BAND_2G)
@@ -2829,9 +2834,8 @@ static void _tssi_rf_setting(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 }
 
 static void _tssi_set_sys(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			  enum rtw89_rf_path path)
+			  enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	rtw89_rfk_parser(rtwdev, &rtw8852bt_tssi_sys_defs_tbl);
@@ -2878,7 +2882,7 @@ static void _tssi_set_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 }
 
 static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-				 enum rtw89_rf_path path)
+				 enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
 #define RTW8852BT_TSSI_GET_VAL(ptr, idx)			\
 ({							\
@@ -2893,7 +2897,6 @@ static void _tssi_set_tmeter_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 })
 	struct rtw89_fw_txpwr_track_cfg *trk = rtwdev->fw.elm_info.txpwr_trk;
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u8 subband = chan->subband_type;
 	const s8 *thm_up_a = NULL;
@@ -3047,9 +3050,8 @@ static void _tssi_set_dac_gain_tbl(struct rtw89_dev *rtwdev, enum rtw89_phy_idx
 }
 
 static void _tssi_slope_cal_org(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-				enum rtw89_rf_path path)
+				enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 
 	if (path == RF_PATH_A)
@@ -3063,9 +3065,9 @@ static void _tssi_slope_cal_org(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy
 }
 
 static void _tssi_alignment_default(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-				    enum rtw89_rf_path path, bool all)
+				    enum rtw89_rf_path path, bool all,
+				    const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	enum rtw89_band band = chan->band_type;
 	const struct rtw89_rfk_tbl *tbl = NULL;
 	u8 ch = chan->channel;
@@ -3310,10 +3312,9 @@ static u32 _tssi_get_trim_group(struct rtw89_dev *rtwdev, u8 ch)
 }
 
 static s8 _tssi_get_ofdm_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			    enum rtw89_rf_path path)
+			    enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u32 gidx, gidx_1st, gidx_2nd;
 	s8 de_1st;
@@ -3346,10 +3347,9 @@ static s8 _tssi_get_ofdm_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 }
 
 static s8 _tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-				 enum rtw89_rf_path path)
+				 enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u32 tgidx, tgidx_1st, tgidx_2nd;
 	s8 tde_1st;
@@ -3383,10 +3383,10 @@ static s8 _tssi_get_ofdm_trim_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx ph
 	return val;
 }
 
-static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+				  const struct rtw89_chan *chan)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 ch = chan->channel;
 	u8 gidx;
 	s8 ofdm_de;
@@ -3399,7 +3399,7 @@ static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx p
 
 	for (i = RF_PATH_A; i < RF_PATH_NUM_8852BT; i++) {
 		gidx = _tssi_get_cck_group(rtwdev, ch);
-		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i);
+		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i, chan);
 		val = tssi_info->tssi_cck[i][gidx] + trim_de;
 
 		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
@@ -3415,8 +3415,8 @@ static void _tssi_set_efuse_to_de(struct rtw89_dev *rtwdev, enum rtw89_phy_idx p
 			    rtw89_phy_read32_mask(rtwdev, _tssi_de_cck_long[i],
 						  _TSSI_DE_MASK));
 
-		ofdm_de = _tssi_get_ofdm_de(rtwdev, phy, i);
-		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i);
+		ofdm_de = _tssi_get_ofdm_de(rtwdev, phy, i, chan);
+		trim_de = _tssi_get_ofdm_trim_de(rtwdev, phy, i, chan);
 		val = ofdm_de + trim_de;
 
 		rtw89_debug(rtwdev, RTW89_DBG_TSSI,
@@ -3463,10 +3463,10 @@ static void _tssi_alimentk_dump_result(struct rtw89_dev *rtwdev, enum rtw89_rf_p
 }
 
 static void _tssi_alimentk_done(struct rtw89_dev *rtwdev,
-				enum rtw89_phy_idx phy, enum rtw89_rf_path path)
+				enum rtw89_phy_idx phy, enum rtw89_rf_path path,
+				const struct rtw89_chan *chan)
 {
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	u8 channel = chan->channel;
 	u8 band;
 
@@ -3500,7 +3500,7 @@ static void _tssi_alimentk_done(struct rtw89_dev *rtwdev,
 
 static void _tssi_hw_tx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 			enum rtw89_rf_path path, u16 cnt, u16 period, s16 pwr_dbm,
-			u8 enable)
+			u8 enable, const struct rtw89_chan *chan)
 {
 	enum rtw89_rf_path_bit rx_path;
 
@@ -3516,11 +3516,11 @@ static void _tssi_hw_tx(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	if (enable) {
 		rtw8852bx_bb_set_plcp_tx(rtwdev);
 		rtw8852bx_bb_cfg_tx_path(rtwdev, path);
-		rtw8852bx_bb_ctrl_rx_path(rtwdev, rx_path);
+		rtw8852bx_bb_ctrl_rx_path(rtwdev, rx_path, chan);
 		rtw8852bx_bb_set_power(rtwdev, pwr_dbm, phy);
 	}
 
-	rtw8852bx_bb_set_pmac_pkt_tx(rtwdev, enable, cnt, period, 20, phy);
+	rtw8852bx_bb_set_pmac_pkt_tx(rtwdev, enable, cnt, period, 20, phy, chan);
 }
 
 static void _tssi_backup_bb_registers(struct rtw89_dev *rtwdev,
@@ -3574,7 +3574,7 @@ static u8 _tssi_ch_to_idx(struct rtw89_dev *rtwdev, u8 channel)
 
 static bool _tssi_get_cw_report(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 				enum rtw89_rf_path path, const s16 *power,
-				u32 *tssi_cw_rpt)
+				u32 *tssi_cw_rpt, const struct rtw89_chan *chan)
 {
 	u32 tx_counter, tx_counter_tmp;
 	const int retry = 100;
@@ -3593,9 +3593,11 @@ static bool _tssi_get_cw_report(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy
 			    _tssi_trigger[path], tmp, path);
 
 		if (j == 0)
-			_tssi_hw_tx(rtwdev, phy, path, 100, 5000, power[j], true);
+			_tssi_hw_tx(rtwdev, phy, path, 100, 5000, power[j], true,
+				    chan);
 		else
-			_tssi_hw_tx(rtwdev, phy, RF_PATH_ABCD, 100, 5000, power[j], true);
+			_tssi_hw_tx(rtwdev, phy, RF_PATH_ABCD, 100, 5000, power[j], true,
+				    chan);
 
 		tx_counter_tmp = rtw89_phy_read32_mask(rtwdev, R_TX_COUNTER, MASKLWORD);
 		tx_counter_tmp -= tx_counter;
@@ -3626,7 +3628,7 @@ static bool _tssi_get_cw_report(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy
 				    "[TSSI PA K] TSSI finish bit k > %d mp:100ms normal:30us path=%d\n",
 				    k, path);
 
-			_tssi_hw_tx(rtwdev, phy, path, 100, 5000, power[j], false);
+			_tssi_hw_tx(rtwdev, phy, path, 100, 5000, power[j], false, chan);
 			return false;
 		}
 
@@ -3634,7 +3636,7 @@ static bool _tssi_get_cw_report(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy
 			rtw89_phy_read32_mask(rtwdev, _tssi_cw_rpt_addr[path],
 					      B_TSSI_CWRPT);
 
-		_tssi_hw_tx(rtwdev, phy, path, 100, 5000, power[j], false);
+		_tssi_hw_tx(rtwdev, phy, path, 100, 5000, power[j], false, chan);
 
 		tx_counter_tmp = rtw89_phy_read32_mask(rtwdev, R_TX_COUNTER, MASKLWORD);
 		tx_counter_tmp -= tx_counter;
@@ -3648,14 +3650,13 @@ static bool _tssi_get_cw_report(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy
 }
 
 static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
-			   enum rtw89_rf_path path)
+			   enum rtw89_rf_path path, const struct rtw89_chan *chan)
 {
 	static const u32 bb_reg[8] = {0x5820, 0x7820, 0x4978, 0x58e4,
 				      0x78e4, 0x49c0, 0x0d18, 0x0d80};
 	static const s16 power_2g[4] = {48, 20, 4, -8};
 	static const s16 power_5g[4] = {48, 20, 4, 4};
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	s32 tssi_alim_offset_1, tssi_alim_offset_2, tssi_alim_offset_3;
 	u32 tssi_cw_rpt[RTW8852BT_TSSI_PATH_NR] = {};
 	u8 channel = chan->channel;
@@ -3701,7 +3702,7 @@ static void _tssi_alimentk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
 	rtw89_phy_write32_mask(rtwdev, R_P0_TSSI_MV_AVG, B_P0_TSSI_MV_AVG, 0x2);
 	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_MV_AVG, B_P1_TSSI_MV_AVG, 0x2);
 
-	ok = _tssi_get_cw_report(rtwdev, phy, path, power, tssi_cw_rpt);
+	ok = _tssi_get_cw_report(rtwdev, phy, path, power, tssi_cw_rpt, chan);
 	if (!ok)
 		goto out;
 
@@ -3833,18 +3834,19 @@ void rtw8852bt_rck(struct rtw89_dev *rtwdev)
 		_rck(rtwdev, path);
 }
 
-void rtw8852bt_dack(struct rtw89_dev *rtwdev)
+void rtw8852bt_dack(struct rtw89_dev *rtwdev, enum rtw89_chanctx_idx chanctx_idx)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, 0, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, RTW89_PHY_0, 0, chanctx_idx);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DACK, BTC_WRFK_START);
 	_dac_cal(rtwdev, false);
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_DACK, BTC_WRFK_STOP);
 }
 
-void rtw8852bt_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+void rtw8852bt_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		   enum rtw89_chanctx_idx chanctx_idx)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, chanctx_idx);
 	u32 tx_en;
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_START);
@@ -3852,15 +3854,16 @@ void rtw8852bt_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	_wait_rx_mode(rtwdev, _kpath(rtwdev, phy_idx));
 
 	_iqk_init(rtwdev);
-	_iqk(rtwdev, phy_idx, false);
+	_iqk(rtwdev, phy_idx, false, chanctx_idx);
 
 	rtw89_chip_resume_sch_tx(rtwdev, phy_idx, tx_en);
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_STOP);
 }
 
-void rtw8852bt_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+void rtw8852bt_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		      enum rtw89_chanctx_idx chanctx_idx)
 {
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy_idx, 0, chanctx_idx);
 	u32 tx_en;
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_START);
@@ -3873,15 +3876,16 @@ void rtw8852bt_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_RXDCK, BTC_WRFK_STOP);
 }
 
-void rtw8852bt_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx)
+void rtw8852bt_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		   enum rtw89_chanctx_idx chanctx_idx)
 {
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "[DPK] ****** DPK Start (Ver: 0x%x) ******\n", RTW8852BT_DPK_VER);
 
-	if (_dpk_bypass_check(rtwdev, phy_idx))
+	if (_dpk_bypass_check(rtwdev, phy_idx, chanctx_idx))
 		_dpk_force_bypass(rtwdev, phy_idx);
 	else
-		_dpk_cal_select(rtwdev, phy_idx, RF_AB);
+		_dpk_cal_select(rtwdev, phy_idx, RF_AB, chanctx_idx);
 }
 
 void rtw8852bt_dpk_track(struct rtw89_dev *rtwdev)
@@ -3889,10 +3893,12 @@ void rtw8852bt_dpk_track(struct rtw89_dev *rtwdev)
 	_dpk_track(rtwdev);
 }
 
-void rtw8852bt_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_en)
+void rtw8852bt_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		    bool hwtx_en, enum rtw89_chanctx_idx chanctx_idx)
 {
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	static const u32 reg[2] = {R_DPD_CH0A, R_DPD_CH0B};
-	u8 phy_map = rtw89_btc_phymap(rtwdev, phy, RF_AB, RTW89_CHANCTX_0);
+	u8 phy_map = rtw89_btc_phymap(rtwdev, phy, RF_AB, chanctx_idx);
 	u32 reg_backup[2] = {};
 	u32 tx_en;
 	u8 i;
@@ -3905,36 +3911,36 @@ void rtw8852bt_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_
 	_tssi_disable(rtwdev, phy);
 
 	for (i = RF_PATH_A; i < RF_PATH_NUM_8852BT; i++) {
-		_tssi_rf_setting(rtwdev, phy, i);
-		_tssi_set_sys(rtwdev, phy, i);
+		_tssi_rf_setting(rtwdev, phy, i, chan);
+		_tssi_set_sys(rtwdev, phy, i, chan);
 		_tssi_ini_txpwr_ctrl_bb(rtwdev, phy, i);
 		_tssi_ini_txpwr_ctrl_bb_he_tb(rtwdev, phy, i);
 		_tssi_set_dck(rtwdev, phy, i);
-		_tssi_set_tmeter_tbl(rtwdev, phy, i);
+		_tssi_set_tmeter_tbl(rtwdev, phy, i, chan);
 		_tssi_set_dac_gain_tbl(rtwdev, phy, i);
-		_tssi_slope_cal_org(rtwdev, phy, i);
-		_tssi_alignment_default(rtwdev, phy, i, true);
+		_tssi_slope_cal_org(rtwdev, phy, i, chan);
+		_tssi_alignment_default(rtwdev, phy, i, true, chan);
 		_tssi_set_tssi_slope(rtwdev, phy, i);
 
 		rtw89_chip_stop_sch_tx(rtwdev, phy, &tx_en, RTW89_SCH_TX_SEL_ALL);
 		_tmac_tx_pause(rtwdev, phy, true);
 		if (hwtx_en)
-			_tssi_alimentk(rtwdev, phy, i);
+			_tssi_alimentk(rtwdev, phy, i, chan);
 		_tmac_tx_pause(rtwdev, phy, false);
 		rtw89_chip_resume_sch_tx(rtwdev, phy, tx_en);
 	}
 
 	_tssi_enable(rtwdev, phy);
-	_tssi_set_efuse_to_de(rtwdev, phy);
+	_tssi_set_efuse_to_de(rtwdev, phy, chan);
 
 	_tssi_reload_bb_registers(rtwdev, phy, reg, reg_backup, 2);
 
 	rtw89_btc_ntfy_wl_rfk(rtwdev, phy_map, BTC_WRFKT_IQK, BTC_WRFK_ONESHOT_STOP);
 }
 
-void rtw8852bt_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
+void rtw8852bt_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			 const struct rtw89_chan *chan)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
 	struct rtw89_tssi_info *tssi_info = &rtwdev->tssi;
 	u8 channel = chan->channel;
 	u8 band;
@@ -3957,24 +3963,25 @@ void rtw8852bt_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy)
 	_tssi_disable(rtwdev, phy);
 
 	for (i = RF_PATH_A; i < RTW8852BT_TSSI_PATH_NR; i++) {
-		_tssi_rf_setting(rtwdev, phy, i);
-		_tssi_set_sys(rtwdev, phy, i);
-		_tssi_set_tmeter_tbl(rtwdev, phy, i);
+		_tssi_rf_setting(rtwdev, phy, i, chan);
+		_tssi_set_sys(rtwdev, phy, i, chan);
+		_tssi_set_tmeter_tbl(rtwdev, phy, i, chan);
 
 		if (tssi_info->alignment_done[i][band])
-			_tssi_alimentk_done(rtwdev, phy, i);
+			_tssi_alimentk_done(rtwdev, phy, i, chan);
 		else
-			_tssi_alignment_default(rtwdev, phy, i, true);
+			_tssi_alignment_default(rtwdev, phy, i, true, chan);
 	}
 
 	_tssi_enable(rtwdev, phy);
-	_tssi_set_efuse_to_de(rtwdev, phy);
+	_tssi_set_efuse_to_de(rtwdev, phy, chan);
 }
 
 static void rtw8852bt_tssi_default_txagc(struct rtw89_dev *rtwdev,
-					 enum rtw89_phy_idx phy, bool enable)
+					 enum rtw89_phy_idx phy, bool enable,
+					 enum rtw89_chanctx_idx chanctx_idx)
 {
-	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, RTW89_CHANCTX_0);
+	const struct rtw89_chan *chan = rtw89_chan_get(rtwdev, chanctx_idx);
 	u8 channel = chan->channel;
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK, "======> %s   ch=%d\n",
@@ -3996,8 +4003,8 @@ static void rtw8852bt_tssi_default_txagc(struct rtw89_dev *rtwdev,
 	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_OFT_EN, 0x0);
 	rtw89_phy_write32_mask(rtwdev, R_P1_TSSI_TRK, B_P1_TSSI_OFT_EN, 0x1);
 
-	_tssi_alimentk_done(rtwdev, phy, RF_PATH_A);
-	_tssi_alimentk_done(rtwdev, phy, RF_PATH_B);
+	_tssi_alimentk_done(rtwdev, phy, RF_PATH_A, chan);
+	_tssi_alimentk_done(rtwdev, phy, RF_PATH_B, chan);
 
 	rtw89_debug(rtwdev, RTW89_DBG_RFK,
 		    "======>%s 2 SCAN_END Set 0x5818[7:0]=0x%x 0x7818[7:0]=0x%x\n",
@@ -4010,12 +4017,13 @@ static void rtw8852bt_tssi_default_txagc(struct rtw89_dev *rtwdev,
 }
 
 void rtw8852bt_wifi_scan_notify(struct rtw89_dev *rtwdev, bool scan_start,
-				enum rtw89_phy_idx phy_idx)
+				enum rtw89_phy_idx phy_idx,
+				enum rtw89_chanctx_idx chanctx_idx)
 {
 	if (scan_start)
-		rtw8852bt_tssi_default_txagc(rtwdev, phy_idx, true);
+		rtw8852bt_tssi_default_txagc(rtwdev, phy_idx, true, chanctx_idx);
 	else
-		rtw8852bt_tssi_default_txagc(rtwdev, phy_idx, false);
+		rtw8852bt_tssi_default_txagc(rtwdev, phy_idx, false, chanctx_idx);
 }
 
 static void _bw_setting(struct rtw89_dev *rtwdev, enum rtw89_rf_path path,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
index ef3d98f80400..e34560b4905f 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt_rfk.h
@@ -8,16 +8,22 @@
 #include "core.h"
 
 void rtw8852bt_rck(struct rtw89_dev *rtwdev);
-void rtw8852bt_dack(struct rtw89_dev *rtwdev);
-void rtw8852bt_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
-void rtw8852bt_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx);
+void rtw8852bt_dack(struct rtw89_dev *rtwdev, enum rtw89_chanctx_idx chanctx_idx);
+void rtw8852bt_iqk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		   enum rtw89_chanctx_idx chanctx_idx);
+void rtw8852bt_rx_dck(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		      enum rtw89_chanctx_idx chanctx_idx);
 void rtw8852bt_dpk_init(struct rtw89_dev *rtwdev);
-void rtw8852bt_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
+void rtw8852bt_dpk(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy_idx,
+		   enum rtw89_chanctx_idx chanctx_idx);
 void rtw8852bt_dpk_track(struct rtw89_dev *rtwdev);
-void rtw8852bt_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy, bool hwtx_en);
-void rtw8852bt_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy);
+void rtw8852bt_tssi(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+		    bool hwtx_en, enum rtw89_chanctx_idx chanctx_idx);
+void rtw8852bt_tssi_scan(struct rtw89_dev *rtwdev, enum rtw89_phy_idx phy,
+			 const struct rtw89_chan *chan);
 void rtw8852bt_wifi_scan_notify(struct rtw89_dev *rtwdev, bool scan_start,
-				enum rtw89_phy_idx phy_idx);
+				enum rtw89_phy_idx phy_idx,
+				enum rtw89_chanctx_idx chanctx_idx);
 void rtw8852bt_set_channel_rf(struct rtw89_dev *rtwdev,
 			      const struct rtw89_chan *chan,
 			      enum rtw89_phy_idx phy_idx);
-- 
2.25.1


