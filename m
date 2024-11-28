Return-Path: <linux-wireless+bounces-15773-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 859E89DB2A3
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 06:55:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 45E92282703
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Nov 2024 05:55:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 359E813D61B;
	Thu, 28 Nov 2024 05:55:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="nHIrm5u7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 610BD1442F6
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 05:54:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732773303; cv=none; b=oF5VYnea5fKIrcpeLZzWOf6G2JwF3XgXisxJ10AoJv7PaFHWjbzC3F9aaPtA89wHe65WpGMLKCXOT658tub2wxv2NLjYHqYjjvPdKMujnHuo5urMPvE3lLVLt+7wOsY8EG6tdmxNL1g7yUbmTvYqgfWITukNV8RYWy/zBB9AP+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732773303; c=relaxed/simple;
	bh=akc1aR429Sagh4HX0CxEW5o4hBTIsDQc+19Mh19DJao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3Es6UKCvInq02hpe2nYzAizbK4i8p0YhO+3Xq0m5BQqowE8H9VS9NZaF1SbYIqt2bmtTuCKJUfwc2VKr9A+RywPobx3D36HTohZlV14Nk8efCsYRA0aDSRrM9O4FlWLMmA0JCx844nlko3S8yr4cjUlrU33WlTYFEKz8oxtvtI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=nHIrm5u7; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AS5sv7I33960106, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1732773297; bh=akc1aR429Sagh4HX0CxEW5o4hBTIsDQc+19Mh19DJao=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type;
	b=nHIrm5u7LOwiHoHp6yZc3OLyJ5daYZxetUebvq3Cd5jutFvMPt6pyqVkNxusjFXxS
	 ym2MUVHDXf1FvEYqmLHqyW/4gVSfxn6AnjKu7AjLwFB4SWUzX0tNYBRWMkbPhGkeXe
	 o+HJWK4hrLCLhjrXPYdSNjMHEw74L+KCjpCBxVt4N1hCdVSAOXpKMEkpnz82QBLTXt
	 rAiDriL20AaMatk06i4X0xlrFft8hkn0XbQaPpsDU5QgvzVmqAmmuKtfUNxDL/68R7
	 j0u7ILgdW27+b3ymbrwfgwLBRE1HxsHRQXVCAtH1/Osp5pHIQ/WIdKxIxnDHdq+GmX
	 l8gjaDywj03Kw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AS5sv7I33960106
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Thu, 28 Nov 2024 13:54:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 28 Nov 2024 13:54:58 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Thu, 28 Nov
 2024 13:54:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
CC: <gary.chang@realtek.com>, <phhuang@realtek.com>, <kevin_yang@realtek.com>
Subject: [PATCH 4/6] wifi: rtw89: 8922a: use RSSI from PHY report in RX descriptor
Date: Thu, 28 Nov 2024 13:54:31 +0800
Message-ID: <20241128055433.11851-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241128055433.11851-1-pkshih@realtek.com>
References: <20241128055433.11851-1-pkshih@realtek.com>
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

From: Chih-Kang Chang <gary.chang@realtek.com>

The PPDU status of probe response will fail to parse the IE due to being
filtered by the to_self check. Therefore, we parse RSSI from PHY report in
RX descriptor.

Signed-off-by: Chih-Kang Chang <gary.chang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     | 17 +++++++++
 drivers/net/wireless/realtek/rtw89/core.h     | 19 ++++++++++
 drivers/net/wireless/realtek/rtw89/mac.c      |  1 +
 drivers/net/wireless/realtek/rtw89/mac.h      | 36 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac_be.c   | 15 ++++++++
 drivers/net/wireless/realtek/rtw89/reg.h      |  4 +++
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  4 ++-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  5 ++-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  1 +
 .../wireless/realtek/rtw89/rtw8852b_common.c  |  4 ++-
 .../net/wireless/realtek/rtw89/rtw8852bt.c    |  1 +
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  6 +++-
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 17 +++++++--
 drivers/net/wireless/realtek/rtw89/txrx.h     |  3 ++
 14 files changed, 127 insertions(+), 6 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 6f9b4f0b2748..29d0ac502bab 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2366,6 +2366,12 @@ static void rtw89_core_update_radiotap(struct rtw89_dev *rtwdev,
 	}
 }
 
+static void rtw89_core_validate_rx_signal(struct ieee80211_rx_status *rx_status)
+{
+	if (!rx_status->signal)
+		rx_status->flag |= RX_FLAG_NO_SIGNAL_VAL;
+}
+
 static void rtw89_core_rx_to_mac80211(struct rtw89_dev *rtwdev,
 				      struct rtw89_rx_phy_ppdu *phy_ppdu,
 				      struct rtw89_rx_desc_info *desc_info,
@@ -2382,6 +2388,8 @@ static void rtw89_core_rx_to_mac80211(struct rtw89_dev *rtwdev,
 	rtw89_core_rx_stats(rtwdev, phy_ppdu, desc_info, skb_ppdu);
 	rtw89_core_update_rx_status_by_ppdu(rtwdev, rx_status, phy_ppdu);
 	rtw89_core_update_radiotap(rtwdev, skb_ppdu, rx_status);
+	rtw89_core_validate_rx_signal(rx_status);
+
 	/* In low power mode, it does RX in thread context. */
 	local_bh_disable();
 	ieee80211_rx_napi(rtwdev->hw, NULL, skb_ppdu, napi);
@@ -2517,6 +2525,7 @@ void rtw89_core_query_rxdesc_v2(struct rtw89_dev *rtwdev,
 				struct rtw89_rx_desc_info *desc_info,
 				u8 *data, u32 data_offset)
 {
+	struct rtw89_rxdesc_phy_rpt_v2 *rxd_rpt;
 	struct rtw89_rxdesc_short_v2 *rxd_s;
 	struct rtw89_rxdesc_long_v2 *rxd_l;
 	u16 shift_len, drv_info_len, phy_rtp_len, hdr_cnv_len;
@@ -2564,6 +2573,12 @@ void rtw89_core_query_rxdesc_v2(struct rtw89_dev *rtwdev,
 		desc_info->rxd_len = sizeof(struct rtw89_rxdesc_short_v2);
 	desc_info->ready = true;
 
+	if (phy_rtp_len == sizeof(*rxd_rpt)) {
+		rxd_rpt = (struct rtw89_rxdesc_phy_rpt_v2 *)(data + data_offset +
+							     desc_info->rxd_len);
+		desc_info->rssi = le32_get_bits(rxd_rpt->dword0, BE_RXD_PHY_RSSI);
+	}
+
 	if (!desc_info->long_rxdesc)
 		return;
 
@@ -2706,6 +2721,7 @@ static void rtw89_core_update_rx_status(struct rtw89_dev *rtwdev,
 	rx_status->flag |= RX_FLAG_MACTIME_START;
 	rx_status->mactime = desc_info->free_run_cnt;
 
+	rtw89_chip_phy_rpt_to_rssi(rtwdev, desc_info, rx_status);
 	rtw89_core_stats_sta_rx_status(rtwdev, desc_info, rx_status);
 }
 
@@ -4522,6 +4538,7 @@ int rtw89_core_start(struct rtw89_dev *rtwdev)
 	rtw89_phy_dm_init(rtwdev);
 
 	rtw89_mac_cfg_ppdu_status_bands(rtwdev, true);
+	rtw89_mac_cfg_phy_rpt_bands(rtwdev, true);
 	rtw89_mac_update_rts_threshold(rtwdev);
 
 	rtw89_tas_reset(rtwdev);
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 8c7e8b1c954f..82844e470d1b 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -1084,6 +1084,7 @@ struct rtw89_rx_desc_info {
 	u16 offset;
 	u16 rxd_len;
 	bool ready;
+	u16 rssi;
 };
 
 struct rtw89_rxdesc_short {
@@ -1126,6 +1127,11 @@ struct rtw89_rxdesc_long_v2 {
 	__le32 dword9;
 } __packed;
 
+struct rtw89_rxdesc_phy_rpt_v2 {
+	__le32 dword0;
+	__le32 dword1;
+} __packed;
+
 struct rtw89_tx_desc_info {
 	u16 pkt_size;
 	u8 wp_offset;
@@ -3624,6 +3630,9 @@ struct rtw89_chip_ops {
 			   struct ieee80211_rx_status *status);
 	void (*convert_rpl_to_rssi)(struct rtw89_dev *rtwdev,
 				    struct rtw89_rx_phy_ppdu *phy_ppdu);
+	void (*phy_rpt_to_rssi)(struct rtw89_dev *rtwdev,
+				struct rtw89_rx_desc_info *desc_info,
+				struct ieee80211_rx_status *rx_status);
 	void (*ctrl_nbtg_bt_tx)(struct rtw89_dev *rtwdev, bool en,
 				enum rtw89_phy_idx phy_idx);
 	void (*cfg_txrx_path)(struct rtw89_dev *rtwdev);
@@ -6706,6 +6715,16 @@ static inline void rtw89_chip_convert_rpl_to_rssi(struct rtw89_dev *rtwdev,
 		chip->ops->convert_rpl_to_rssi(rtwdev, phy_ppdu);
 }
 
+static inline void rtw89_chip_phy_rpt_to_rssi(struct rtw89_dev *rtwdev,
+					      struct rtw89_rx_desc_info *desc_info,
+					      struct ieee80211_rx_status *rx_status)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+
+	if (chip->ops->phy_rpt_to_rssi)
+		chip->ops->phy_rpt_to_rssi(rtwdev, desc_info, rx_status);
+}
+
 static inline void rtw89_ctrl_nbtg_bt_tx(struct rtw89_dev *rtwdev, bool en,
 					 enum rtw89_phy_idx phy_idx)
 {
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 95f2beb89fe6..bb4f58118e05 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -6736,6 +6736,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
 
 	.typ_fltr_opt = rtw89_mac_typ_fltr_opt_ax,
 	.cfg_ppdu_status = rtw89_mac_cfg_ppdu_status_ax,
+	.cfg_phy_rpt = NULL,
 
 	.dle_mix_cfg = dle_mix_cfg_ax,
 	.chk_dle_rdy = chk_dle_rdy_ax,
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 81507274a97e..8edea96d037f 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -169,6 +169,20 @@ enum rtw89_mac_ax_l0_to_l1_event {
 	MAC_AX_L0_TO_L1_EVENT_MAX = 15,
 };
 
+enum rtw89_mac_phy_rpt_size {
+	MAC_AX_PHY_RPT_SIZE_0 = 0,
+	MAC_AX_PHY_RPT_SIZE_8 = 1,
+	MAC_AX_PHY_RPT_SIZE_16 = 2,
+	MAC_AX_PHY_RPT_SIZE_24 = 3,
+};
+
+enum rtw89_mac_hdr_cnv_size {
+	MAC_AX_HDR_CNV_SIZE_0 = 0,
+	MAC_AX_HDR_CNV_SIZE_32 = 1,
+	MAC_AX_HDR_CNV_SIZE_64 = 2,
+	MAC_AX_HDR_CNV_SIZE_96 = 3,
+};
+
 enum rtw89_mac_wow_fw_status {
 	WOWLAN_NOT_READY = 0x00,
 	WOWLAN_SLEEP_READY = 0x01,
@@ -968,6 +982,7 @@ struct rtw89_mac_gen_def {
 			    enum rtw89_mac_fwd_target fwd_target,
 			    u8 mac_idx);
 	int (*cfg_ppdu_status)(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable);
+	void (*cfg_phy_rpt)(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable);
 
 	int (*dle_mix_cfg)(struct rtw89_dev *rtwdev, const struct rtw89_dle_mem *cfg);
 	int (*chk_dle_rdy)(struct rtw89_dev *rtwdev, bool wde_or_ple);
@@ -1223,6 +1238,27 @@ int rtw89_mac_stop_sch_tx_v2(struct rtw89_dev *rtwdev, u8 mac_idx,
 int rtw89_mac_resume_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en);
 int rtw89_mac_resume_sch_tx_v1(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en);
 int rtw89_mac_resume_sch_tx_v2(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en);
+void rtw89_mac_cfg_phy_rpt_be(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable);
+
+static inline
+void rtw89_mac_cfg_phy_rpt(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable)
+{
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+
+	if (mac->cfg_phy_rpt)
+		mac->cfg_phy_rpt(rtwdev, mac_idx, enable);
+}
+
+static inline
+void rtw89_mac_cfg_phy_rpt_bands(struct rtw89_dev *rtwdev, bool enable)
+{
+	rtw89_mac_cfg_phy_rpt(rtwdev, RTW89_MAC_0, enable);
+
+	if (!rtwdev->dbcc_en)
+		return;
+
+	rtw89_mac_cfg_phy_rpt(rtwdev, RTW89_MAC_1, enable);
+}
 
 static inline
 int rtw89_mac_cfg_ppdu_status(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable)
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index f7a396c8a3cd..2dbdeae904ad 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -1988,6 +1988,20 @@ int rtw89_mac_resume_sch_tx_v2(struct rtw89_dev *rtwdev, u8 mac_idx, u32 tx_en)
 }
 EXPORT_SYMBOL(rtw89_mac_resume_sch_tx_v2);
 
+void rtw89_mac_cfg_phy_rpt_be(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable)
+{
+	u32 reg, val;
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_RCR, mac_idx);
+	val = enable ? MAC_AX_PHY_RPT_SIZE_8 : MAC_AX_PHY_RPT_SIZE_0;
+	rtw89_write32_mask(rtwdev, reg, B_BE_PHY_RPT_SZ_MASK, val);
+	rtw89_write32_mask(rtwdev, reg, B_BE_HDR_CNV_SZ_MASK, MAC_AX_HDR_CNV_SIZE_0);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_DRV_INFO_OPTION, mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_BE_DRV_INFO_PHYRPT_EN, enable);
+}
+EXPORT_SYMBOL(rtw89_mac_cfg_phy_rpt_be);
+
 static
 int rtw89_mac_cfg_ppdu_status_be(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable)
 {
@@ -2583,6 +2597,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 
 	.typ_fltr_opt = rtw89_mac_typ_fltr_opt_be,
 	.cfg_ppdu_status = rtw89_mac_cfg_ppdu_status_be,
+	.cfg_phy_rpt = rtw89_mac_cfg_phy_rpt_be,
 
 	.dle_mix_cfg = dle_mix_cfg_be,
 	.chk_dle_rdy = chk_dle_rdy_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 18ec7c0252fb..10d0efa7a58e 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -7447,6 +7447,10 @@
 #define B_BE_CSIPRT_HESU_AID_EN BIT(25)
 #define B_BE_CSIPRT_VHTSU_AID_EN BIT(24)
 
+#define R_BE_DRV_INFO_OPTION 0x11470
+#define R_BE_DRV_INFO_OPTION_C1 0x15470
+#define B_BE_DRV_INFO_PHYRPT_EN BIT(0)
+
 #define R_BE_RX_ERR_ISR 0x114F4
 #define R_BE_RX_ERR_ISR_C1 0x154F4
 #define B_BE_RX_ERR_TRIG_ACT_TO BIT(9)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 1ed4e64cbd2c..c56f70267882 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -2298,7 +2298,8 @@ static void rtw8851b_query_ppdu(struct rtw89_dev *rtwdev,
 	u8 path;
 	u8 *rx_power = phy_ppdu->rssi;
 
-	status->signal = RTW89_RSSI_RAW_TO_DBM(rx_power[RF_PATH_A]);
+	if (!status->signal)
+		status->signal = RTW89_RSSI_RAW_TO_DBM(rx_power[RF_PATH_A]);
 
 	for (path = 0; path < rtwdev->chip->rf_path_num; path++) {
 		status->chains |= BIT(path);
@@ -2391,6 +2392,7 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.ctrl_btg_bt_rx		= rtw8851b_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8851b_query_ppdu,
 	.convert_rpl_to_rssi	= NULL,
+	.phy_rpt_to_rssi	= NULL,
 	.ctrl_nbtg_bt_tx	= rtw8851b_ctrl_nbtg_bt_tx,
 	.cfg_txrx_path		= rtw8851b_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= rtw8851b_set_txpwr_ul_tb_offset,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index a7105a288bc4..9bd2842c27d5 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -2068,7 +2068,9 @@ static void rtw8852a_query_ppdu(struct rtw89_dev *rtwdev,
 	u8 path;
 	u8 *rx_power = phy_ppdu->rssi;
 
-	status->signal = RTW89_RSSI_RAW_TO_DBM(max(rx_power[RF_PATH_A], rx_power[RF_PATH_B]));
+	if (!status->signal)
+		status->signal = RTW89_RSSI_RAW_TO_DBM(max(rx_power[RF_PATH_A],
+							   rx_power[RF_PATH_B]));
 	for (path = 0; path < rtwdev->chip->rf_path_num; path++) {
 		status->chains |= BIT(path);
 		status->chain_signal[path] = RTW89_RSSI_RAW_TO_DBM(rx_power[path]);
@@ -2116,6 +2118,7 @@ static const struct rtw89_chip_ops rtw8852a_chip_ops = {
 	.ctrl_btg_bt_rx		= rtw8852a_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8852a_query_ppdu,
 	.convert_rpl_to_rssi	= NULL,
+	.phy_rpt_to_rssi	= NULL,
 	.ctrl_nbtg_bt_tx	= rtw8852a_ctrl_nbtg_bt_tx,
 	.cfg_txrx_path		= NULL,
 	.set_txpwr_ul_tb_offset	= rtw8852a_set_txpwr_ul_tb_offset,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index ebc853a905dd..dfb2bf61b0b8 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -745,6 +745,7 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.ctrl_btg_bt_rx		= rtw8852bx_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8852bx_query_ppdu,
 	.convert_rpl_to_rssi	= rtw8852bx_convert_rpl_to_rssi,
+	.phy_rpt_to_rssi	= NULL,
 	.ctrl_nbtg_bt_tx	= rtw8852bx_ctrl_nbtg_bt_tx,
 	.cfg_txrx_path		= rtw8852bx_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= rtw8852bx_set_txpwr_ul_tb_offset,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
index 012739d97f71..0e094ce9c9b0 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b_common.c
@@ -1950,7 +1950,9 @@ static void __rtw8852bx_query_ppdu(struct rtw89_dev *rtwdev,
 	u8 path;
 	u8 *rx_power = phy_ppdu->rssi;
 
-	status->signal = RTW89_RSSI_RAW_TO_DBM(max(rx_power[RF_PATH_A], rx_power[RF_PATH_B]));
+	if (!status->signal)
+		status->signal = RTW89_RSSI_RAW_TO_DBM(max(rx_power[RF_PATH_A],
+							   rx_power[RF_PATH_B]));
 	for (path = 0; path < rtwdev->chip->rf_path_num; path++) {
 		status->chains |= BIT(path);
 		status->chain_signal[path] = RTW89_RSSI_RAW_TO_DBM(rx_power[path]);
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
index cd1385ff8003..bde3e1fb7ca6 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852bt.c
@@ -679,6 +679,7 @@ static const struct rtw89_chip_ops rtw8852bt_chip_ops = {
 	.ctrl_btg_bt_rx		= rtw8852bx_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8852bx_query_ppdu,
 	.convert_rpl_to_rssi	= rtw8852bx_convert_rpl_to_rssi,
+	.phy_rpt_to_rssi	= NULL,
 	.ctrl_nbtg_bt_tx	= rtw8852bx_ctrl_nbtg_bt_tx,
 	.cfg_txrx_path		= rtw8852bx_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= rtw8852bx_set_txpwr_ul_tb_offset,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index c7d39499ca75..bc84b15e7826 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -2807,7 +2807,10 @@ static void rtw8852c_query_ppdu(struct rtw89_dev *rtwdev,
 	u8 path;
 	u8 *rx_power = phy_ppdu->rssi;
 
-	status->signal = RTW89_RSSI_RAW_TO_DBM(max(rx_power[RF_PATH_A], rx_power[RF_PATH_B]));
+	if (!status->signal)
+		status->signal = RTW89_RSSI_RAW_TO_DBM(max(rx_power[RF_PATH_A],
+							   rx_power[RF_PATH_B]));
+
 	for (path = 0; path < rtwdev->chip->rf_path_num; path++) {
 		status->chains |= BIT(path);
 		status->chain_signal[path] = RTW89_RSSI_RAW_TO_DBM(rx_power[path]);
@@ -2907,6 +2910,7 @@ static const struct rtw89_chip_ops rtw8852c_chip_ops = {
 	.ctrl_btg_bt_rx		= rtw8852c_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8852c_query_ppdu,
 	.convert_rpl_to_rssi	= NULL,
+	.phy_rpt_to_rssi	= NULL,
 	.ctrl_nbtg_bt_tx	= rtw8852c_ctrl_nbtg_bt_tx,
 	.cfg_txrx_path		= rtw8852c_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= rtw8852c_set_txpwr_ul_tb_offset,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
index a96b58ce6592..f04cb3b11372 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -2565,8 +2565,10 @@ static void rtw8922a_query_ppdu(struct rtw89_dev *rtwdev,
 	u8 path;
 	u8 *rx_power = phy_ppdu->rssi;
 
-	status->signal =
-		RTW89_RSSI_RAW_TO_DBM(max(rx_power[RF_PATH_A], rx_power[RF_PATH_B]));
+	if (!status->signal)
+		status->signal = RTW89_RSSI_RAW_TO_DBM(max(rx_power[RF_PATH_A],
+							   rx_power[RF_PATH_B]));
+
 	for (path = 0; path < rtwdev->chip->rf_path_num; path++) {
 		status->chains |= BIT(path);
 		status->chain_signal[path] = RTW89_RSSI_RAW_TO_DBM(rx_power[path]);
@@ -2607,6 +2609,16 @@ static void rtw8922a_convert_rpl_to_rssi(struct rtw89_dev *rtwdev,
 	phy_ppdu->rssi_avg = phy_ppdu->rpl_avg;
 }
 
+static void rtw8922a_phy_rpt_to_rssi(struct rtw89_dev *rtwdev,
+				     struct rtw89_rx_desc_info *desc_info,
+				     struct ieee80211_rx_status *rx_status)
+{
+	if (desc_info->rssi <= 0x1 || (desc_info->rssi >> 2) > MAX_RSSI)
+		return;
+
+	rx_status->signal = (desc_info->rssi >> 2) - MAX_RSSI;
+}
+
 static int rtw8922a_mac_enable_bb_rf(struct rtw89_dev *rtwdev)
 {
 	rtw89_write8_set(rtwdev, R_BE_FEN_RST_ENABLE,
@@ -2665,6 +2677,7 @@ static const struct rtw89_chip_ops rtw8922a_chip_ops = {
 	.ctrl_btg_bt_rx		= rtw8922a_ctrl_btg_bt_rx,
 	.query_ppdu		= rtw8922a_query_ppdu,
 	.convert_rpl_to_rssi	= rtw8922a_convert_rpl_to_rssi,
+	.phy_rpt_to_rssi	= rtw8922a_phy_rpt_to_rssi,
 	.ctrl_nbtg_bt_tx	= rtw8922a_ctrl_nbtg_bt_tx,
 	.cfg_txrx_path		= rtw8922a_bb_cfg_txrx_path,
 	.set_txpwr_ul_tb_offset	= NULL,
diff --git a/drivers/net/wireless/realtek/rtw89/txrx.h b/drivers/net/wireless/realtek/rtw89/txrx.h
index b2e47829983f..70fe7cebc9d5 100644
--- a/drivers/net/wireless/realtek/rtw89/txrx.h
+++ b/drivers/net/wireless/realtek/rtw89/txrx.h
@@ -560,6 +560,9 @@ struct rtw89_phy_sts_iehdr {
 #define BE_RXD_HDR_OFFSET_MASK GENMASK(20, 16)
 #define BE_RXD_WL_HD_IV_LEN_MASK GENMASK(26, 21)
 
+/* BE RXD - PHY RPT dword0 */
+#define BE_RXD_PHY_RSSI GENMASK(11, 0)
+
 struct rtw89_phy_sts_ie00 {
 	__le32 w0;
 	__le32 w1;
-- 
2.25.1


