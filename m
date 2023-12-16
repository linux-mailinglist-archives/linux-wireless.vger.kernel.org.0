Return-Path: <linux-wireless+bounces-848-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id EF84A81579C
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Dec 2023 05:59:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD9621C216D2
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Dec 2023 04:59:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A4FE18EA0;
	Sat, 16 Dec 2023 04:59:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB21615EA6
	for <linux-wireless@vger.kernel.org>; Sat, 16 Dec 2023 04:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3BG4x1fdD2055326, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3BG4x1fdD2055326
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Dec 2023 12:59:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Sat, 16 Dec 2023 12:59:01 +0800
Received: from [127.0.1.1] (172.16.17.49) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sat, 16 Dec
 2023 12:59:00 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/2] wifi: rtw89: mac: implement to configure TX/RX engines for WiFi 7 chips
Date: Sat, 16 Dec 2023 12:57:39 +0800
Message-ID: <20231216045739.10432-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231216045739.10432-1-pkshih@realtek.com>
References: <20231216045739.10432-1-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

After enabling DMAC and CMAC, configure detail registers one by one.
DMAC includes DLE (data link engine), packet preload engine, HFC (HCI
flow control) for DMA channels, security egine and etc. CMAC includes
scheduler, address CAM, RX filter, CCA control and etc.

The SER IMR is to configure to help SER. When hardware TX/RX get
abnormal, it raises an interrupt to firmware to determine if send C2H
events to notify driver to reset PCI bus or call ieee80211_restart_hw().

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac_be.c | 961 ++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    | 527 +++++++++++
 2 files changed, 1488 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 762a4e2f9c28..be30c9346293 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -73,6 +73,11 @@ static int rtw89_mac_check_mac_en_be(struct rtw89_dev *rtwdev, u8 mac_idx,
 	return -EFAULT;
 }
 
+static bool is_qta_poh(struct rtw89_dev *rtwdev)
+{
+	return rtwdev->hci.type == RTW89_HCI_TYPE_PCIE;
+}
+
 static void hfc_get_mix_info_be(struct rtw89_dev *rtwdev)
 {
 	struct rtw89_hfc_param *param = &rtwdev->mac.hfc_param;
@@ -634,6 +639,256 @@ static int sys_init_be(struct rtw89_dev *rtwdev)
 	return ret;
 }
 
+static int sta_sch_init_be(struct rtw89_dev *rtwdev)
+{
+	u32 p_val;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
+	if (ret)
+		return ret;
+
+	rtw89_write8_set(rtwdev, R_BE_SS_CTRL, B_BE_SS_EN);
+
+	ret = read_poll_timeout(rtw89_read32, p_val, p_val & B_BE_SS_INIT_DONE,
+				1, TRXCFG_WAIT_CNT, false, rtwdev, R_BE_SS_CTRL);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]STA scheduler init\n");
+		return ret;
+	}
+
+	rtw89_write32_set(rtwdev, R_BE_SS_CTRL, B_BE_WARM_INIT);
+	rtw89_write32_clr(rtwdev, R_BE_SS_CTRL, B_BE_BAND_TRIG_EN | B_BE_BAND1_TRIG_EN);
+
+	return 0;
+}
+
+static int mpdu_proc_init_be(struct rtw89_dev *rtwdev)
+{
+	u32 val32;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
+	if (ret)
+		return ret;
+
+	rtw89_write32_set(rtwdev, R_BE_MPDU_PROC, B_BE_APPEND_FCS);
+	rtw89_write32(rtwdev, R_BE_CUT_AMSDU_CTRL, TRXCFG_MPDU_PROC_CUT_CTRL);
+
+	val32 = rtw89_read32(rtwdev, R_BE_HDR_SHCUT_SETTING);
+	val32 |= (B_BE_TX_HW_SEQ_EN | B_BE_TX_HW_ACK_POLICY_EN | B_BE_TX_MAC_MPDU_PROC_EN);
+	val32 &= ~B_BE_TX_ADDR_MLD_TO_LIK;
+	rtw89_write32_set(rtwdev, R_BE_HDR_SHCUT_SETTING, val32);
+
+	rtw89_write32(rtwdev, R_BE_RX_HDRTRNS, TRXCFG_MPDU_PROC_RX_HDR_CONV);
+
+	val32 = rtw89_read32(rtwdev, R_BE_DISP_FWD_WLAN_0);
+	val32 = u32_replace_bits(val32, 1, B_BE_FWD_WLAN_CPU_TYPE_0_DATA_MASK);
+	val32 = u32_replace_bits(val32, 1, B_BE_FWD_WLAN_CPU_TYPE_0_MNG_MASK);
+	val32 = u32_replace_bits(val32, 1, B_BE_FWD_WLAN_CPU_TYPE_0_CTL_MASK);
+	val32 = u32_replace_bits(val32, 1, B_BE_FWD_WLAN_CPU_TYPE_1_MASK);
+	rtw89_write32(rtwdev, R_BE_DISP_FWD_WLAN_0, val32);
+
+	return 0;
+}
+
+static int sec_eng_init_be(struct rtw89_dev *rtwdev)
+{
+	u32 val32;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
+	if (ret)
+		return ret;
+
+	val32 = rtw89_read32(rtwdev, R_BE_SEC_ENG_CTRL);
+	val32 |= B_BE_CLK_EN_CGCMP | B_BE_CLK_EN_WAPI | B_BE_CLK_EN_WEP_TKIP |
+		 B_BE_SEC_TX_ENC | B_BE_SEC_RX_DEC |
+		 B_BE_MC_DEC | B_BE_BC_DEC |
+		 B_BE_BMC_MGNT_DEC | B_BE_UC_MGNT_DEC;
+	val32 &= ~B_BE_SEC_PRE_ENQUE_TX;
+	rtw89_write32(rtwdev, R_BE_SEC_ENG_CTRL, val32);
+
+	rtw89_write32_set(rtwdev, R_BE_SEC_MPDU_PROC, B_BE_APPEND_ICV | B_BE_APPEND_MIC);
+
+	return 0;
+}
+
+static int txpktctrl_init_be(struct rtw89_dev *rtwdev)
+{
+	struct rtw89_mac_dle_rsvd_qt_cfg qt_cfg;
+	u32 val32;
+	int ret;
+
+	ret = rtw89_mac_get_dle_rsvd_qt_cfg(rtwdev, DLE_RSVD_QT_MPDU_INFO, &qt_cfg);
+	if (ret) {
+		rtw89_err(rtwdev, "get dle rsvd qt %d cfg fail %d\n",
+			  DLE_RSVD_QT_MPDU_INFO, ret);
+		return ret;
+	}
+
+	val32 = rtw89_read32(rtwdev, R_BE_TXPKTCTL_MPDUINFO_CFG);
+	val32 = u32_replace_bits(val32, qt_cfg.pktid, B_BE_MPDUINFO_PKTID_MASK);
+	val32 = u32_replace_bits(val32, MPDU_INFO_B1_OFST, B_BE_MPDUINFO_B1_BADDR_MASK);
+	val32 |= B_BE_MPDUINFO_FEN;
+	rtw89_write32(rtwdev, R_BE_TXPKTCTL_MPDUINFO_CFG, val32);
+
+	return 0;
+}
+
+static int mlo_init_be(struct rtw89_dev *rtwdev)
+{
+	u32 val32;
+	int ret;
+
+	val32 = rtw89_read32(rtwdev, R_BE_MLO_INIT_CTL);
+
+	val32 |= B_BE_MLO_TABLE_REINIT;
+	rtw89_write32(rtwdev, R_BE_MLO_INIT_CTL, val32);
+	val32 &= ~B_BE_MLO_TABLE_REINIT;
+	rtw89_write32(rtwdev, R_BE_MLO_INIT_CTL, val32);
+
+	ret = read_poll_timeout_atomic(rtw89_read32, val32,
+				       val32 & B_BE_MLO_TABLE_INIT_DONE,
+				       1, 1000, false, rtwdev, R_BE_MLO_INIT_CTL);
+	if (ret)
+		rtw89_err(rtwdev, "[MLO]%s: MLO init polling timeout\n", __func__);
+
+	rtw89_write32_set(rtwdev, R_BE_SS_CTRL, B_BE_MLO_HW_CHGLINK_EN);
+	rtw89_write32_set(rtwdev, R_BE_CMAC_SHARE_ACQCHK_CFG_0, B_BE_R_MACID_ACQ_CHK_EN);
+
+	return ret;
+}
+
+static int dmac_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	int ret;
+
+	ret = rtw89_mac_dle_init(rtwdev, rtwdev->mac.qta_mode, RTW89_QTA_INVALID);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]DLE init %d\n", ret);
+		return ret;
+	}
+
+	ret = rtw89_mac_preload_init(rtwdev, RTW89_MAC_0, rtwdev->mac.qta_mode);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]preload init %d\n", ret);
+		return ret;
+	}
+
+	ret = rtw89_mac_hfc_init(rtwdev, true, true, true);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]HCI FC init %d\n", ret);
+		return ret;
+	}
+
+	ret = sta_sch_init_be(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]STA SCH init %d\n", ret);
+		return ret;
+	}
+
+	ret = mpdu_proc_init_be(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]MPDU Proc init %d\n", ret);
+		return ret;
+	}
+
+	ret = sec_eng_init_be(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]Security Engine init %d\n", ret);
+		return ret;
+	}
+
+	ret = txpktctrl_init_be(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]TX pkt ctrl init %d\n", ret);
+		return ret;
+	}
+
+	ret = mlo_init_be(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]MLO init %d\n", ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int scheduler_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	u32 val32;
+	u32 reg;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
+	if (ret)
+		return ret;
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_HE_CTN_CHK_CCA_NAV, mac_idx);
+	val32 = B_BE_HE_CTN_CHK_CCA_P20 | B_BE_HE_CTN_CHK_EDCCA_P20 |
+		B_BE_HE_CTN_CHK_CCA_BITMAP | B_BE_HE_CTN_CHK_EDCCA_BITMAP |
+		B_BE_HE_CTN_CHK_NO_GNT_WL | B_BE_HE_CTN_CHK_BASIC_NAV |
+		B_BE_HE_CTN_CHK_INTRA_NAV | B_BE_HE_CTN_CHK_TX_NAV;
+	rtw89_write32(rtwdev, reg, val32);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_HE_SIFS_CHK_CCA_NAV, mac_idx);
+	val32 = B_BE_HE_SIFS_CHK_EDCCA_P20 | B_BE_HE_SIFS_CHK_EDCCA_BITMAP |
+		B_BE_HE_SIFS_CHK_NO_GNT_WL;
+	rtw89_write32(rtwdev, reg, val32);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_TB_CHK_CCA_NAV, mac_idx);
+	val32 = B_BE_TB_CHK_EDCCA_BITMAP | B_BE_TB_CHK_NO_GNT_WL | B_BE_TB_CHK_BASIC_NAV;
+	rtw89_write32(rtwdev, reg, val32);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_CCA_CFG_0, mac_idx);
+	rtw89_write32_clr(rtwdev, reg, B_BE_NO_GNT_WL_EN);
+
+	if (is_qta_poh(rtwdev)) {
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_PREBKF_CFG_0, mac_idx);
+		rtw89_write32_mask(rtwdev, reg, B_BE_PREBKF_TIME_MASK,
+				   SCH_PREBKF_24US);
+
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_CTN_CFG_0, mac_idx);
+		rtw89_write32_mask(rtwdev, reg, B_BE_PREBKF_TIME_NONAC_MASK,
+				   SCH_PREBKF_24US);
+	}
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_EDCA_BCNQ_PARAM, mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_BE_BCNQ_CW_MASK, 0x32);
+	rtw89_write32_mask(rtwdev, reg, B_BE_BCNQ_AIFS_MASK, BCN_IFS_25US);
+
+	return 0;
+}
+
+static int addr_cam_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	u32 val32;
+	u16 val16;
+	u32 reg;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
+	if (ret)
+		return ret;
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_ADDR_CAM_CTRL, mac_idx);
+	val32 = rtw89_read32(rtwdev, reg);
+	val32 = u32_replace_bits(val32, ADDR_CAM_SERCH_RANGE, B_BE_ADDR_CAM_RANGE_MASK);
+	val32 |= B_BE_ADDR_CAM_EN;
+	if (mac_idx == RTW89_MAC_0)
+		val32 |= B_BE_ADDR_CAM_CLR;
+	rtw89_write32(rtwdev, reg, val32);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_ADDR_CAM_CTRL, mac_idx);
+	ret = read_poll_timeout_atomic(rtw89_read16, val16, !(val16 & B_BE_ADDR_CAM_CLR),
+				       1, TRXCFG_WAIT_CNT, false, rtwdev, reg);
+	if (ret)
+		rtw89_err(rtwdev, "[ERR]ADDR_CAM reset\n");
+
+	return ret;
+}
+
 static int rtw89_mac_typ_fltr_opt_be(struct rtw89_dev *rtwdev,
 				     enum rtw89_machdr_frame_type type,
 				     enum rtw89_mac_fwd_target fwd_target,
@@ -674,6 +929,442 @@ static int rtw89_mac_typ_fltr_opt_be(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static int rx_fltr_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	u32 reg;
+	u32 val;
+
+	rtw89_mac_typ_fltr_opt_be(rtwdev, RTW89_MGNT, RTW89_FWD_TO_HOST, mac_idx);
+	rtw89_mac_typ_fltr_opt_be(rtwdev, RTW89_CTRL, RTW89_FWD_TO_HOST, mac_idx);
+	rtw89_mac_typ_fltr_opt_be(rtwdev, RTW89_DATA, RTW89_FWD_TO_HOST, mac_idx);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_RX_FLTR_OPT, mac_idx);
+	val = B_BE_A_BC_CAM_MATCH | B_BE_A_UC_CAM_MATCH | B_BE_A_MC |
+	      B_BE_A_BC | B_BE_A_A1_MATCH | B_BE_SNIFFER_MODE |
+	      u32_encode_bits(15, B_BE_UID_FILTER_MASK);
+	rtw89_write32(rtwdev, reg, val);
+	u32p_replace_bits(&rtwdev->hal.rx_fltr, 15, B_BE_UID_FILTER_MASK);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_PLCP_HDR_FLTR, mac_idx);
+	val = B_BE_HE_SIGB_CRC_CHK | B_BE_VHT_MU_SIGB_CRC_CHK |
+	      B_BE_VHT_SU_SIGB_CRC_CHK | B_BE_SIGA_CRC_CHK |
+	      B_BE_LSIG_PARITY_CHK_EN | B_BE_CCK_SIG_CHK | B_BE_CCK_CRC_CHK;
+	rtw89_write16(rtwdev, reg, val);
+
+	return 0;
+}
+
+static int cca_ctrl_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	return 0;
+}
+
+static int nav_ctrl_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	u32 val32;
+	u32 reg;
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_WMAC_NAV_CTL, mac_idx);
+
+	val32 = rtw89_read32(rtwdev, reg);
+	val32 &= ~B_BE_WMAC_PLCP_UP_NAV_EN;
+	val32 |= B_BE_WMAC_TF_UP_NAV_EN | B_BE_WMAC_NAV_UPPER_EN;
+	val32 = u32_replace_bits(val32, NAV_25MS, B_BE_WMAC_NAV_UPPER_MASK);
+
+	rtw89_write32(rtwdev, reg, val32);
+
+	return 0;
+}
+
+static int spatial_reuse_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	u32 reg;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
+	if (ret)
+		return ret;
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_RX_SR_CTRL, mac_idx);
+	rtw89_write8_clr(rtwdev, reg, B_BE_SR_EN | B_BE_SR_CTRL_PLCP_EN);
+
+	return 0;
+}
+
+static int tmac_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	u32 reg;
+
+	rtw89_write32_clr(rtwdev, R_BE_TB_PPDU_CTRL, B_BE_QOSNULL_UPD_MUEDCA_EN);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_WMTX_TCR_BE_4, mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_BE_EHT_HE_PPDU_4XLTF_ZLD_USTIMER_MASK, 0x12);
+	rtw89_write32_mask(rtwdev, reg, B_BE_EHT_HE_PPDU_2XLTF_ZLD_USTIMER_MASK, 0xe);
+
+	return 0;
+}
+
+static int trxptcl_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_rrsr_cfgs *rrsr = chip->rrsr_cfgs;
+	struct rtw89_hal *hal = &rtwdev->hal;
+	u32 val32;
+	u32 reg;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
+	if (ret)
+		return ret;
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_MAC_LOOPBACK, mac_idx);
+	val32 = rtw89_read32(rtwdev, reg);
+	val32 = u32_replace_bits(val32, S_BE_MACLBK_PLCP_DLY_DEF,
+				 B_BE_MACLBK_PLCP_DLY_MASK);
+	val32 &= ~B_BE_MACLBK_EN;
+	rtw89_write32(rtwdev, reg, val32);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_TRXPTCL_RESP_0, mac_idx);
+	val32 = rtw89_read32(rtwdev, reg);
+	val32 = u32_replace_bits(val32, WMAC_SPEC_SIFS_CCK,
+				 B_BE_WMAC_SPEC_SIFS_CCK_MASK);
+	val32 = u32_replace_bits(val32, WMAC_SPEC_SIFS_OFDM_1115E,
+				 B_BE_WMAC_SPEC_SIFS_OFDM_MASK);
+	rtw89_write32(rtwdev, reg, val32);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_WMAC_ACK_BA_RESP_LEGACY, mac_idx);
+	rtw89_write32_clr(rtwdev, reg, B_BE_ACK_BA_RESP_LEGACY_CHK_EDCCA);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_WMAC_ACK_BA_RESP_HE, mac_idx);
+	rtw89_write32_clr(rtwdev, reg, B_BE_ACK_BA_RESP_HE_CHK_EDCCA);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_WMAC_ACK_BA_RESP_EHT_LEG_PUNC, mac_idx);
+	rtw89_write32_clr(rtwdev, reg, B_BE_ACK_BA_EHT_LEG_PUNC_CHK_EDCCA);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_RXTRIG_TEST_USER_2, mac_idx);
+	rtw89_write32_set(rtwdev, reg, B_BE_RXTRIG_FCSCHK_EN);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_TRXPTCL_RESP_1, mac_idx);
+	val32 = rtw89_read32(rtwdev, reg);
+	val32 &= B_BE_FTM_RRSR_RATE_EN_MASK | B_BE_WMAC_RESP_DOPPLEB_BE_EN |
+		 B_BE_WMAC_RESP_DCM_EN | B_BE_WMAC_RESP_REF_RATE_MASK;
+	rtw89_write32(rtwdev, reg, val32);
+	rtw89_write32_mask(rtwdev, reg, rrsr->ref_rate.mask, rrsr->ref_rate.data);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_PTCL_RRSR1, mac_idx);
+	val32 = rtw89_read32(rtwdev, reg);
+	val32 &= B_BE_RRSR_RATE_EN_MASK | B_BE_RRSR_CCK_MASK | B_BE_RSC_MASK;
+	rtw89_write32(rtwdev, reg, val32);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_PTCL_RRSR0, mac_idx);
+	val32 = rtw89_read32(rtwdev, reg);
+	val32 &= B_BE_RRSR_OFDM_MASK | B_BE_RRSR_HT_MASK | B_BE_RRSR_VHT_MASK |
+		 B_BE_RRSR_HE_MASK;
+	rtw89_write32(rtwdev, reg, val32);
+
+	if (chip->chip_id == RTL8922A && hal->cv == CHIP_CAV) {
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_PTCL_RRSR1, mac_idx);
+		rtw89_write32_mask(rtwdev, reg, B_BE_RSC_MASK, 1);
+	}
+
+	return 0;
+}
+
+static int rst_bacam_be(struct rtw89_dev *rtwdev)
+{
+	u32 val;
+	int ret;
+
+	rtw89_write32_mask(rtwdev, R_BE_RESPBA_CAM_CTRL, B_BE_BACAM_RST_MASK,
+			   S_BE_BACAM_RST_ALL);
+
+	ret = read_poll_timeout_atomic(rtw89_read32_mask, val, val == S_BE_BACAM_RST_DONE,
+				       1, 1000, false,
+				       rtwdev, R_BE_RESPBA_CAM_CTRL, B_BE_BACAM_RST_MASK);
+	if (ret)
+		rtw89_err(rtwdev, "[ERR]bacam rst timeout\n");
+
+	return ret;
+}
+
+#define PLD_RLS_MAX_PG 127
+#define RX_MAX_LEN_UNIT 512
+#define RX_SPEC_MAX_LEN (11454 + RX_MAX_LEN_UNIT)
+
+static int rmac_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	u32 rx_min_qta, rx_max_len, rx_max_pg;
+	u16 val16;
+	u32 reg;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
+	if (ret)
+		return ret;
+
+	if (mac_idx == RTW89_MAC_0) {
+		ret = rst_bacam_be(rtwdev);
+		if (ret)
+			return ret;
+	}
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_DLK_PROTECT_CTL, mac_idx);
+	val16 = rtw89_read16(rtwdev, reg);
+	val16 = u16_replace_bits(val16, TRXCFG_RMAC_DATA_TO, B_BE_RX_DLK_DATA_TIME_MASK);
+	val16 = u16_replace_bits(val16, TRXCFG_RMAC_CCA_TO, B_BE_RX_DLK_CCA_TIME_MASK);
+	val16 |= B_BE_RX_DLK_RST_EN;
+	rtw89_write16(rtwdev, reg, val16);
+
+	if (mac_idx == RTW89_MAC_0)
+		rx_min_qta = rtwdev->mac.dle_info.c0_rx_qta;
+	else
+		rx_min_qta = rtwdev->mac.dle_info.c1_rx_qta;
+	rx_max_pg = min_t(u32, rx_min_qta, PLD_RLS_MAX_PG);
+	rx_max_len = rx_max_pg * rtwdev->mac.dle_info.ple_pg_size;
+	rx_max_len = min_t(u32, rx_max_len, RX_SPEC_MAX_LEN);
+	rx_max_len /= RX_MAX_LEN_UNIT;
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_RX_FLTR_OPT, mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_BE_RX_MPDU_MAX_LEN_MASK, rx_max_len);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_PLCP_HDR_FLTR, mac_idx);
+	rtw89_write8_clr(rtwdev, reg, B_BE_VHT_SU_SIGB_CRC_CHK);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_RCR, mac_idx);
+	rtw89_write16_set(rtwdev, reg, B_BE_BUSY_CHKSN);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_RX_PLCP_EXT_OPTION_1, mac_idx);
+	rtw89_write16_set(rtwdev, reg, B_BE_PLCP_SU_PSDU_LEN_SRC);
+
+	return 0;
+}
+
+static int resp_pktctl_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	struct rtw89_mac_dle_rsvd_qt_cfg qt_cfg;
+	enum rtw89_mac_dle_rsvd_qt_type type;
+	u32 reg;
+	int ret;
+
+	if (mac_idx == RTW89_MAC_1)
+		type = DLE_RSVD_QT_B1_CSI;
+	else
+		type = DLE_RSVD_QT_B0_CSI;
+
+	ret = rtw89_mac_get_dle_rsvd_qt_cfg(rtwdev, type, &qt_cfg);
+	if (ret) {
+		rtw89_err(rtwdev, "get dle rsvd qt %d cfg fail %d\n", type, ret);
+		return ret;
+	}
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_RESP_CSI_RESERVED_PAGE, mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_BE_CSI_RESERVED_START_PAGE_MASK, qt_cfg.pktid);
+	rtw89_write32_mask(rtwdev, reg, B_BE_CSI_RESERVED_PAGE_NUM_MASK, qt_cfg.pg_num);
+
+	return 0;
+}
+
+static int cmac_com_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	u32 val32;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
+	if (ret)
+		return ret;
+
+	if (mac_idx == RTW89_MAC_0) {
+		val32 = rtw89_read32(rtwdev, R_BE_TX_SUB_BAND_VALUE);
+		val32 = u32_replace_bits(val32, S_BE_TXSB_20M_8, B_BE_TXSB_20M_MASK);
+		val32 = u32_replace_bits(val32, S_BE_TXSB_40M_4, B_BE_TXSB_40M_MASK);
+		val32 = u32_replace_bits(val32, S_BE_TXSB_80M_2, B_BE_TXSB_80M_MASK);
+		val32 = u32_replace_bits(val32, S_BE_TXSB_160M_1, B_BE_TXSB_160M_MASK);
+		rtw89_write32(rtwdev, R_BE_TX_SUB_BAND_VALUE, val32);
+	} else {
+		val32 = rtw89_read32(rtwdev, R_BE_TX_SUB_BAND_VALUE_C1);
+		val32 = u32_replace_bits(val32, S_BE_TXSB_20M_2, B_BE_TXSB_20M_MASK);
+		val32 = u32_replace_bits(val32, S_BE_TXSB_40M_1, B_BE_TXSB_40M_MASK);
+		val32 = u32_replace_bits(val32, S_BE_TXSB_80M_0, B_BE_TXSB_80M_MASK);
+		val32 = u32_replace_bits(val32, S_BE_TXSB_160M_0, B_BE_TXSB_160M_MASK);
+		rtw89_write32(rtwdev, R_BE_TX_SUB_BAND_VALUE_C1, val32);
+	}
+
+	return 0;
+}
+
+static int ptcl_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	u32 val32;
+	u8 val8;
+	u32 reg;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
+	if (ret)
+		return ret;
+
+	if (is_qta_poh(rtwdev)) {
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_SIFS_SETTING, mac_idx);
+		val32 = rtw89_read32(rtwdev, reg);
+		val32 = u32_replace_bits(val32, S_AX_CTS2S_TH_1K,
+					 B_BE_HW_CTS2SELF_PKT_LEN_TH_MASK);
+		val32 = u32_replace_bits(val32, S_AX_CTS2S_TH_SEC_256B,
+					 B_BE_HW_CTS2SELF_PKT_LEN_TH_TWW_MASK);
+		val32 |= B_BE_HW_CTS2SELF_EN;
+		rtw89_write32(rtwdev, reg, val32);
+
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_PTCL_FSM_MON, mac_idx);
+		val32 = rtw89_read32(rtwdev, reg);
+		val32 = u32_replace_bits(val32, S_AX_PTCL_TO_2MS,
+					 B_BE_PTCL_TX_ARB_TO_THR_MASK);
+		val32 &= ~B_BE_PTCL_TX_ARB_TO_MODE;
+		rtw89_write32(rtwdev, reg, val32);
+	}
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_PTCL_COMMON_SETTING_0, mac_idx);
+	val8 = rtw89_read8(rtwdev, reg);
+	val8 |= B_BE_CMAC_TX_MODE_0 | B_BE_CMAC_TX_MODE_1;
+	val8 &= ~(B_BE_PTCL_TRIGGER_SS_EN_0 |
+		  B_BE_PTCL_TRIGGER_SS_EN_1 |
+		  B_BE_PTCL_TRIGGER_SS_EN_UL);
+	rtw89_write8(rtwdev, reg, val8);
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_AMPDU_AGG_LIMIT, mac_idx);
+	rtw89_write32_mask(rtwdev, reg, B_BE_AMPDU_MAX_TIME_MASK, AMPDU_MAX_TIME);
+
+	return 0;
+}
+
+static int cmac_dma_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	u32 val32;
+	u32 reg;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
+	if (ret)
+		return ret;
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_RX_CTRL_1, mac_idx);
+
+	val32 = rtw89_read32(rtwdev, reg);
+	val32 = u32_replace_bits(val32, WLCPU_RXCH2_QID,
+				 B_BE_RXDMA_TXRPT_QUEUE_ID_SW_MASK);
+	val32 = u32_replace_bits(val32, WLCPU_RXCH2_QID,
+				 B_BE_RXDMA_F2PCMDRPT_QUEUE_ID_SW_MASK);
+	rtw89_write32(rtwdev, reg, val32);
+
+	return 0;
+}
+
+static int cmac_init_be(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	int ret;
+
+	ret = scheduler_init_be(rtwdev, mac_idx);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]CMAC%d SCH init %d\n", mac_idx, ret);
+		return ret;
+	}
+
+	ret = addr_cam_init_be(rtwdev, mac_idx);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]CMAC%d ADDR_CAM reset %d\n", mac_idx,
+			  ret);
+		return ret;
+	}
+
+	ret = rx_fltr_init_be(rtwdev, mac_idx);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]CMAC%d RX filter init %d\n", mac_idx,
+			  ret);
+		return ret;
+	}
+
+	ret = cca_ctrl_init_be(rtwdev, mac_idx);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]CMAC%d CCA CTRL init %d\n", mac_idx,
+			  ret);
+		return ret;
+	}
+
+	ret = nav_ctrl_init_be(rtwdev, mac_idx);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]CMAC%d NAV CTRL init %d\n", mac_idx,
+			  ret);
+		return ret;
+	}
+
+	ret = spatial_reuse_init_be(rtwdev, mac_idx);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]CMAC%d Spatial Reuse init %d\n",
+			  mac_idx, ret);
+		return ret;
+	}
+
+	ret = tmac_init_be(rtwdev, mac_idx);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]CMAC%d TMAC init %d\n", mac_idx, ret);
+		return ret;
+	}
+
+	ret = trxptcl_init_be(rtwdev, mac_idx);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]CMAC%d TRXPTCL init %d\n", mac_idx, ret);
+		return ret;
+	}
+
+	ret = rmac_init_be(rtwdev, mac_idx);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]CMAC%d RMAC init %d\n", mac_idx, ret);
+		return ret;
+	}
+
+	ret = resp_pktctl_init_be(rtwdev, mac_idx);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]CMAC%d resp pktctl init %d\n", mac_idx, ret);
+		return ret;
+	}
+
+	ret = cmac_com_init_be(rtwdev, mac_idx);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]CMAC%d Com init %d\n", mac_idx, ret);
+		return ret;
+	}
+
+	ret = ptcl_init_be(rtwdev, mac_idx);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]CMAC%d PTCL init %d\n", mac_idx, ret);
+		return ret;
+	}
+
+	ret = cmac_dma_init_be(rtwdev, mac_idx);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]CMAC%d DMA init %d\n", mac_idx, ret);
+		return ret;
+	}
+
+	return ret;
+}
+
+static int tx_idle_poll_band_be(struct rtw89_dev *rtwdev, u8 mac_idx)
+{
+	u32 reg;
+	u8 val8;
+	int ret;
+
+	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
+	if (ret)
+		return ret;
+
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_BE_PTCL_TX_CTN_SEL, mac_idx);
+
+	ret = read_poll_timeout_atomic(rtw89_read8, val8, !(val8 & B_BE_PTCL_BUSY),
+				       30, 66000, false, rtwdev, reg);
+
+	return ret;
+}
+
 static int dle_buf_req_be(struct rtw89_dev *rtwdev, u16 buf_len, bool wd, u16 *pkt_id)
 {
 	u32 val, reg;
@@ -758,6 +1449,275 @@ static int set_cpuio_be(struct rtw89_dev *rtwdev,
 	return 0;
 }
 
+static int preload_init_be(struct rtw89_dev *rtwdev, u8 mac_idx,
+			   enum rtw89_qta_mode mode)
+{
+	u32 max_preld_size, min_rsvd_size;
+	u32 val32;
+	u32 reg;
+
+	max_preld_size = mac_idx == RTW89_MAC_0 ?
+			 PRELD_B0_ENT_NUM : PRELD_B1_ENT_NUM;
+	max_preld_size *= PRELD_AMSDU_SIZE;
+
+	reg = mac_idx == RTW89_MAC_0 ? R_BE_TXPKTCTL_B0_PRELD_CFG0 :
+				       R_BE_TXPKTCTL_B1_PRELD_CFG0;
+	val32 = rtw89_read32(rtwdev, reg);
+	val32 = u32_replace_bits(val32, max_preld_size, B_BE_B0_PRELD_USEMAXSZ_MASK);
+	val32 |= B_BE_B0_PRELD_FEN;
+	rtw89_write32(rtwdev, reg, val32);
+
+	min_rsvd_size = PRELD_AMSDU_SIZE;
+	reg = mac_idx == RTW89_MAC_0 ? R_BE_TXPKTCTL_B0_PRELD_CFG1 :
+				       R_BE_TXPKTCTL_B1_PRELD_CFG1;
+	val32 = rtw89_read32(rtwdev, reg);
+	val32 = u32_replace_bits(val32, PRELD_NEXT_WND, B_BE_B0_PRELD_NXT_TXENDWIN_MASK);
+	val32 = u32_replace_bits(val32, min_rsvd_size, B_BE_B0_PRELD_NXT_RSVMINSZ_MASK);
+	rtw89_write32(rtwdev, reg, val32);
+
+	return 0;
+}
+
+static int dbcc_bb_ctrl_be(struct rtw89_dev *rtwdev, bool bb1_en)
+{
+	return 0;
+}
+
+static int enable_imr_be(struct rtw89_dev *rtwdev, u8 mac_idx,
+			 enum rtw89_mac_hwmod_sel sel)
+{
+	const struct rtw89_chip_info *chip = rtwdev->chip;
+	const struct rtw89_imr_table *table;
+	const struct rtw89_reg_imr *reg;
+	u32 addr;
+	u32 val;
+	int i;
+
+	if (sel == RTW89_DMAC_SEL)
+		table = chip->imr_dmac_table;
+	else if (sel == RTW89_CMAC_SEL)
+		table = chip->imr_cmac_table;
+	else
+		return -EINVAL;
+
+	for (i = 0; i < table->n_regs; i++) {
+		reg = &table->regs[i];
+		addr = rtw89_mac_reg_by_idx(rtwdev, reg->addr, mac_idx);
+
+		val = rtw89_read32(rtwdev, addr);
+		val &= ~reg->clr;
+		val |= reg->set;
+		rtw89_write32(rtwdev, addr, val);
+	}
+
+	return 0;
+}
+
+static void err_imr_ctrl_be(struct rtw89_dev *rtwdev, bool en)
+{
+	u32 v32_dmac = en ? DMAC_ERR_IMR_EN : DMAC_ERR_IMR_DIS;
+	u32 v32_cmac0 = en ? CMAC0_ERR_IMR_EN : CMAC0_ERR_IMR_DIS;
+	u32 v32_cmac1 = en ? CMAC1_ERR_IMR_EN : CMAC1_ERR_IMR_DIS;
+
+	v32_dmac &= ~B_BE_DMAC_NOTX_ERR_INT_EN;
+
+	rtw89_write32(rtwdev, R_BE_DMAC_ERR_IMR, v32_dmac);
+	rtw89_write32(rtwdev, R_BE_CMAC_ERR_IMR, v32_cmac0);
+
+	if (rtwdev->dbcc_en)
+		rtw89_write32(rtwdev, R_BE_CMAC_ERR_IMR_C1, v32_cmac1);
+}
+
+static int band1_enable_be(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	ret = tx_idle_poll_band_be(rtwdev, RTW89_MAC_0);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]tx idle poll %d\n", ret);
+		return ret;
+	}
+
+	ret = rtw89_mac_dle_quota_change(rtwdev, rtwdev->mac.qta_mode);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]DLE quota change %d\n", ret);
+		return ret;
+	}
+
+	ret = preload_init_be(rtwdev, RTW89_MAC_1, rtwdev->mac.qta_mode);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]preload init B1 %d\n", ret);
+		return ret;
+	}
+
+	ret = cmac_func_en_be(rtwdev, RTW89_MAC_1, true);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]CMAC%d func en %d\n", RTW89_MAC_1, ret);
+		return ret;
+	}
+
+	ret = cmac_init_be(rtwdev, RTW89_MAC_1);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]CMAC%d init %d\n", RTW89_MAC_1, ret);
+		return ret;
+	}
+
+	ret = dbcc_bb_ctrl_be(rtwdev, true);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]enable bb 1 %d\n", ret);
+		return ret;
+	}
+
+	ret = enable_imr_be(rtwdev, RTW89_MAC_1, RTW89_CMAC_SEL);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR] enable CMAC1 IMR %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int band1_disable_be(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	ret = dbcc_bb_ctrl_be(rtwdev, false);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]disable bb 1 %d\n", ret);
+		return ret;
+	}
+
+	ret = cmac_func_en_be(rtwdev, RTW89_MAC_1, false);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]CMAC%d func dis %d\n", RTW89_MAC_1, ret);
+		return ret;
+	}
+
+	ret = rtw89_mac_dle_quota_change(rtwdev, rtwdev->mac.qta_mode);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]DLE quota change %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int dbcc_enable_be(struct rtw89_dev *rtwdev, bool enable)
+{
+	int ret;
+
+	if (enable) {
+		ret = band1_enable_be(rtwdev);
+		if (ret) {
+			rtw89_err(rtwdev, "[ERR] band1_enable %d\n", ret);
+			return ret;
+		}
+
+		if (test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags)) {
+			ret = rtw89_fw_h2c_notify_dbcc(rtwdev, true);
+			if (ret) {
+				rtw89_err(rtwdev, "%s:[ERR]notfify dbcc1 fail %d\n",
+					  __func__, ret);
+				return ret;
+			}
+		}
+	} else {
+		if (test_bit(RTW89_FLAG_FW_RDY, rtwdev->flags)) {
+			ret = rtw89_fw_h2c_notify_dbcc(rtwdev, false);
+			if (ret) {
+				rtw89_err(rtwdev, "%s:[ERR]notfify dbcc1 fail %d\n",
+					  __func__, ret);
+				return ret;
+			}
+		}
+
+		ret = band1_disable_be(rtwdev);
+		if (ret) {
+			rtw89_err(rtwdev, "[ERR] band1_disable %d\n", ret);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int set_host_rpr_be(struct rtw89_dev *rtwdev)
+{
+	u32 val32;
+	u32 mode;
+	u32 fltr;
+	bool poh;
+
+	poh = is_qta_poh(rtwdev);
+
+	if (poh) {
+		mode = RTW89_RPR_MODE_POH;
+		fltr = S_BE_WDRLS_FLTR_TXOK | S_BE_WDRLS_FLTR_RTYLMT |
+		       S_BE_WDRLS_FLTR_LIFTIM | S_BE_WDRLS_FLTR_MACID;
+	} else {
+		mode = RTW89_RPR_MODE_STF;
+		fltr = 0;
+	}
+
+	rtw89_write32_mask(rtwdev, R_BE_WDRLS_CFG, B_BE_WDRLS_MODE_MASK, mode);
+
+	val32 = rtw89_read32(rtwdev, R_BE_RLSRPT0_CFG1);
+	val32 = u32_replace_bits(val32, fltr, B_BE_RLSRPT0_FLTR_MAP_MASK);
+	val32 = u32_replace_bits(val32, 30, B_BE_RLSRPT0_AGGNUM_MASK);
+	val32 = u32_replace_bits(val32, 255, B_BE_RLSRPT0_TO_MASK);
+	rtw89_write32(rtwdev, R_BE_RLSRPT0_CFG1, val32);
+
+	return 0;
+}
+
+static int trx_init_be(struct rtw89_dev *rtwdev)
+{
+	enum rtw89_qta_mode qta_mode = rtwdev->mac.qta_mode;
+	int ret;
+
+	ret = dmac_init_be(rtwdev, 0);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]DMAC init %d\n", ret);
+		return ret;
+	}
+
+	ret = cmac_init_be(rtwdev, 0);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR]CMAC%d init %d\n", 0, ret);
+		return ret;
+	}
+
+	if (rtw89_mac_is_qta_dbcc(rtwdev, qta_mode)) {
+		ret = dbcc_enable_be(rtwdev, true);
+		if (ret) {
+			rtw89_err(rtwdev, "[ERR]dbcc_enable init %d\n", ret);
+			return ret;
+		}
+	}
+
+	ret = enable_imr_be(rtwdev, RTW89_MAC_0, RTW89_DMAC_SEL);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR] enable DMAC IMR %d\n", ret);
+		return ret;
+	}
+
+	ret = enable_imr_be(rtwdev, RTW89_MAC_0, RTW89_CMAC_SEL);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR] to enable CMAC0 IMR %d\n", ret);
+		return ret;
+	}
+
+	err_imr_ctrl_be(rtwdev, true);
+
+	ret = set_host_rpr_be(rtwdev);
+	if (ret) {
+		rtw89_err(rtwdev, "[ERR] set host rpr %d\n", ret);
+		return ret;
+	}
+
+	return 0;
+}
+
 static bool rtw89_mac_get_txpwr_cr_be(struct rtw89_dev *rtwdev,
 				      enum rtw89_phy_idx phy_idx,
 				      u32 reg_base, u32 *cr)
@@ -1271,6 +2231,7 @@ const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 
 	.check_mac_en = rtw89_mac_check_mac_en_be,
 	.sys_init = sys_init_be,
+	.trx_init = trx_init_be,
 	.hci_func_en = rtw89_mac_hci_func_en_be,
 	.dmac_func_pre_en = rtw89_mac_dmac_func_pre_en_be,
 	.dle_func_en = dle_func_en_be,
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 5c27af7d77fa..8456e2b0c14f 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4924,6 +4924,24 @@
 			       B_BE_CR_WRFF_OVERFLOW_ERR_INT_EN | \
 			       B_BE_CR_WRFF_UNDERFLOW_ERR_INT_EN)
 
+#define R_BE_DISP_FWD_WLAN_0 0x8938
+#define B_BE_FWD_WLAN_CPU_TYPE_13_MASK GENMASK(31, 30)
+#define B_BE_FWD_WLAN_CPU_TYPE_12_MASK GENMASK(29, 28)
+#define B_BE_FWD_WLAN_CPU_TYPE_11_MASK GENMASK(27, 26)
+#define B_BE_FWD_WLAN_CPU_TYPE_10_MASK GENMASK(25, 24)
+#define B_BE_FWD_WLAN_CPU_TYPE_9_MASK GENMASK(23, 22)
+#define B_BE_FWD_WLAN_CPU_TYPE_8_MASK GENMASK(21, 20)
+#define B_BE_FWD_WLAN_CPU_TYPE_7_MASK GENMASK(19, 18)
+#define B_BE_FWD_WLAN_CPU_TYPE_6_MASK GENMASK(17, 16)
+#define B_BE_FWD_WLAN_CPU_TYPE_5_MASK GENMASK(15, 14)
+#define B_BE_FWD_WLAN_CPU_TYPE_4_MASK GENMASK(13, 12)
+#define B_BE_FWD_WLAN_CPU_TYPE_3_MASK GENMASK(11, 10)
+#define B_BE_FWD_WLAN_CPU_TYPE_2_MASK GENMASK(9, 8)
+#define B_BE_FWD_WLAN_CPU_TYPE_1_MASK GENMASK(7, 6)
+#define B_BE_FWD_WLAN_CPU_TYPE_0_CTL_MASK GENMASK(5, 4)
+#define B_BE_FWD_WLAN_CPU_TYPE_0_MNG_MASK GENMASK(3, 2)
+#define B_BE_FWD_WLAN_CPU_TYPE_0_DATA_MASK GENMASK(1, 0)
+
 #define R_BE_WDE_PKTBUF_CFG 0x8C08
 #define B_BE_WDE_FREE_PAGE_NUM_MASK GENMASK(28, 16)
 #define B_BE_WDE_START_BOUND_MASK GENMASK(14, 8)
@@ -5387,11 +5405,47 @@
 #define B_BE_PKTIN_ERR_IMR_SET (B_BE_SW_MERGE_ERR_INT_EN | \
 				B_BE_GET_NULL_PKTID_ERR_INT_EN)
 
+#define R_BE_HDR_SHCUT_SETTING 0x9B00
+#define B_BE_TX_ADDR_MLD_TO_LIK BIT(4)
+#define B_BE_TX_HW_SEC_HDR_EN BIT(3)
+#define B_BE_TX_MAC_MPDU_PROC_EN BIT(2)
+#define B_BE_TX_HW_ACK_POLICY_EN BIT(1)
+#define B_BE_TX_HW_SEQ_EN BIT(0)
+
 #define R_BE_MPDU_TX_ERR_IMR 0x9BF4
 #define B_BE_TX_TIMEOUT_ERR_EN BIT(0)
 #define B_BE_MPDU_TX_ERR_IMR_CLR B_BE_TX_TIMEOUT_ERR_EN
 #define B_BE_MPDU_TX_ERR_IMR_SET 0
 
+#define R_BE_MPDU_PROC 0x9C00
+#define B_BE_PORT_SEL BIT(29)
+#define B_BE_WPKT_WLANCPU_QSEL_MASK GENMASK(28, 27)
+#define B_BE_WPKT_DATACPU_QSEL_MASK GENMASK(26, 25)
+#define B_BE_WPKT_FW_RLS BIT(24)
+#define B_BE_FWD_RPKT_MASK GENMASK(23, 16)
+#define B_BE_FWD_WPKT_MASK GENMASK(15, 8)
+#define B_BE_RXFWD_PRIO_MASK GENMASK(5, 4)
+#define B_BE_RXFWD_EN BIT(3)
+#define B_BE_DROP_NONDMA_PPDU BIT(2)
+#define B_BE_APPEND_FCS BIT(0)
+
+#define R_BE_CUT_AMSDU_CTRL 0x9C94
+#define B_BE_EN_CUT_AMSDU BIT(31)
+#define B_BE_CUT_AMSDU_CHKLEN_EN BIT(30)
+#define B_BE_CA_CHK_ADDRCAM_EN BIT(29)
+#define B_BE_MPDU_CUT_CTRL_EN BIT(24)
+#define B_BE_CUT_AMSDU_CHKLEN_L_TH_MASK GENMASK(23, 16)
+#define B_BE_CUT_AMSDU_CHKLEN_H_TH_MASK GENMASK(15, 0)
+
+#define R_BE_RX_HDRTRNS 0x9CC0
+#define B_BE_RX_MGN_MLD_ADDR_EN BIT(6)
+#define B_BE_HDR_INFO_MASK GENMASK(5, 4)
+#define B_BE_HC_ADDR_HIT_EN BIT(3)
+#define B_BE_RX_ADDR_LINK_TO_MLO BIT(2)
+#define B_BE_HDR_CNV BIT(1)
+#define B_BE_RX_HDR_CNV_EN BIT(0)
+#define TRXCFG_MPDU_PROC_RX_HDR_CONV	0x00000000
+
 #define R_BE_MPDU_RX_ERR_IMR 0x9CF4
 #define B_BE_LEN_ERR_IMR BIT(3)
 #define B_BE_TIMEOUT_ERR_IMR BIT(1)
@@ -5472,6 +5526,22 @@
 #define B_BE_RX_HANG_ERROR BIT(1)
 #define B_BE_TX_HANG_ERROR BIT(0)
 
+#define R_BE_TXPKTCTL_MPDUINFO_CFG 0x9F10
+#define B_BE_MPDUINFO_FEN BIT(31)
+#define B_BE_MPDUINFO_PKTID_MASK GENMASK(27, 16)
+#define B_BE_MPDUINFO_B1_BADDR_MASK GENMASK(5, 0)
+#define MPDU_INFO_B1_OFST 18
+
+#define R_BE_TXPKTCTL_B0_PRELD_CFG0 0x9F48
+#define B_BE_B0_PRELD_FEN BIT(31)
+#define B_BE_B0_PRELD_USEMAXSZ_MASK GENMASK(25, 16)
+#define B_BE_B0_PRELD_CAM_G1ENTNUM_MASK GENMASK(12, 8)
+#define B_BE_B0_PRELD_CAM_G0ENTNUM_MASK GENMASK(4, 0)
+
+#define R_BE_TXPKTCTL_B0_PRELD_CFG1 0x9F4C
+#define B_BE_B0_PRELD_NXT_TXENDWIN_MASK GENMASK(11, 8)
+#define B_BE_B0_PRELD_NXT_RSVMINSZ_MASK GENMASK(7, 0)
+
 #define R_BE_TXPKTCTL_B0_ERRFLAG_IMR 0x9F78
 #define B_BE_B0_IMR_DBG_USRCTL_RLSBMPLEN BIT(25)
 #define B_BE_B0_IMR_DBG_USRCTL_RDNRLSCMD BIT(24)
@@ -5502,6 +5572,16 @@
 					  B_BE_B0_IMR_ERR_PRELD_RLSPKTSZERR | \
 					  B_BE_B0_IMR_ERR_PRELD_ENTNUMCFG)
 
+#define R_BE_TXPKTCTL_B1_PRELD_CFG0 0x9F88
+#define B_BE_B1_PRELD_FEN BIT(31)
+#define B_BE_B1_PRELD_USEMAXSZ_MASK GENMASK(25, 16)
+#define B_BE_B1_PRELD_CAM_G1ENTNUM_MASK GENMASK(12, 8)
+#define B_BE_B1_PRELD_CAM_G0ENTNUM_MASK GENMASK(4, 0)
+
+#define R_BE_TXPKTCTL_B1_PRELD_CFG1 0x9F8C
+#define B_BE_B1_PRELD_NXT_TXENDWIN_MASK GENMASK(11, 8)
+#define B_BE_B1_PRELD_NXT_RSVMINSZ_MASK GENMASK(7, 0)
+
 #define R_BE_TXPKTCTL_B1_ERRFLAG_IMR 0x9FB8
 #define B_BE_B1_IMR_DBG_USRCTL_RLSBMPLEN BIT(25)
 #define B_BE_B1_IMR_DBG_USRCTL_RDNRLSCMD BIT(24)
@@ -5532,6 +5612,12 @@
 					  B_BE_B1_IMR_ERR_PRELD_RLSPKTSZERR | \
 					  B_BE_B1_IMR_ERR_PRELD_ENTNUMCFG)
 
+#define R_BE_MLO_INIT_CTL 0xA114
+#define B_BE_MLO_TABLE_INIT_DONE BIT(31)
+#define B_BE_MLO_TABLE_CLR_DONE BIT(30)
+#define B_BE_MLO_TABLE_REINIT BIT(23)
+#define B_BE_MLO_TABLE_HW_FLAG_CLR BIT(22)
+
 #define R_BE_MLO_ERR_IDCT_IMR 0xA128
 #define B_BE_MLO_ERR_IDCT_IMR_0 BIT(31)
 #define B_BE_MLO_ERR_IDCT_IMR_1 BIT(30)
@@ -5561,6 +5647,30 @@
 #define B_BE_PLRLS_CTL_EVT01_ISR BIT(1)
 #define B_BE_PLRLS_CTL_FRZTO_ISR BIT(0)
 
+#define R_BE_SS_CTRL 0xA310
+#define B_BE_SS_INIT_DONE BIT(31)
+#define B_BE_WDE_STA_DIS BIT(30)
+#define B_BE_WARM_INIT BIT(29)
+#define B_BE_BAND_TRIG_EN BIT(28)
+#define B_BE_RMAC_REQ_DIS BIT(27)
+#define B_BE_DLYTX_SEL_MASK GENMASK(25, 24)
+#define B_BE_WMM3_SWITCH_MASK GENMASK(23, 22)
+#define B_BE_WMM2_SWITCH_MASK GENMASK(21, 20)
+#define B_BE_WMM1_SWITCH_MASK GENMASK(19, 18)
+#define B_BE_WMM0_SWITCH_MASK GENMASK(17, 16)
+#define B_BE_STA_OPTION_CR BIT(15)
+#define B_BE_EMLSR_STA_EMPTY_EN BIT(11)
+#define B_BE_MLO_HW_CHGLINK_EN BIT(10)
+#define B_BE_BAND1_TRIG_EN BIT(9)
+#define B_BE_RMAC1_REQ_DIS BIT(8)
+#define B_BE_MRT_SRAM_EN BIT(7)
+#define B_BE_MRT_INIT_EN BIT(6)
+#define B_BE_AVG_LENG_EN BIT(5)
+#define B_BE_AVG_INIT_EN BIT(4)
+#define B_BE_LENG_INIT_EN BIT(2)
+#define B_BE_PMPA_INIT_EN BIT(1)
+#define B_BE_SS_EN BIT(0)
+
 #define R_BE_INTERRUPT_MASK_REG 0xA3F0
 #define B_BE_PLE_B_PKTID_ERR_IMR BIT(2)
 #define B_BE_RPT_TIMEOUT_IMR BIT(1)
@@ -5705,6 +5815,13 @@
 #define B_BE_ADDRSRCH_EN BIT(1)
 #define B_BE_BTCOEX_EN BIT(0)
 
+#define R_BE_CMAC_SHARE_ACQCHK_CFG_0 0x0E010
+#define B_BE_ACQCHK_ERR_FLAG_MASK GENMASK(31, 24)
+#define B_BE_R_ACQCHK_ENTRY_IDX_SEL_MASK GENMASK(7, 4)
+#define B_BE_MACID_ACQ_GRP1_CLR_P BIT(3)
+#define B_BE_MACID_ACQ_GRP0_CLR_P BIT(2)
+#define B_BE_R_MACID_ACQ_CHK_EN BIT(0)
+
 #define R_BE_CMAC_FUNC_EN 0x10000
 #define R_BE_CMAC_FUNC_EN_C1 0x14000
 #define B_BE_CMAC_CRPRT BIT(31)
@@ -5756,6 +5873,40 @@
 			B_BE_RMAC_CKEN | B_BE_TXTIME_CKEN | B_BE_RESP_PKTCTL_CKEN | \
 			B_BE_SIGB_CKEN)
 
+#define R_BE_TX_SUB_BAND_VALUE 0x10088
+#define R_BE_TX_SUB_BAND_VALUE_C1 0x14088
+#define B_BE_PRI20_BITMAP_MASK GENMASK(31, 16)
+#define BE_PRI20_BITMAP_MAX 15
+#define B_BE_TXSB_160M_MASK GENMASK(15, 12)
+#define S_BE_TXSB_160M_0 0
+#define S_BE_TXSB_160M_1 1
+#define B_BE_TXSB_80M_MASK GENMASK(11, 8)
+#define S_BE_TXSB_80M_0 0
+#define S_BE_TXSB_80M_2 2
+#define S_BE_TXSB_80M_4 4
+#define B_BE_TXSB_40M_MASK GENMASK(7, 4)
+#define S_BE_TXSB_40M_0 0
+#define S_BE_TXSB_40M_1 1
+#define S_BE_TXSB_40M_4 4
+#define B_BE_TXSB_20M_MASK GENMASK(3, 0)
+#define S_BE_TXSB_20M_8 8
+#define S_BE_TXSB_20M_4 4
+#define S_BE_TXSB_20M_2 2
+
+#define R_BE_PTCL_RRSR0 0x1008C
+#define R_BE_PTCL_RRSR0_C1 0x1408C
+#define B_BE_RRSR_HE_MASK GENMASK(31, 24)
+#define B_BE_RRSR_VHT_MASK GENMASK(23, 16)
+#define B_BE_RRSR_HT_MASK GENMASK(15, 8)
+#define B_BE_RRSR_OFDM_MASK GENMASK(7, 0)
+
+#define R_BE_PTCL_RRSR1 0x10090
+#define R_BE_PTCL_RRSR1_C1 0x14090
+#define B_BE_RRSR_EHT_MASK GENMASK(23, 16)
+#define B_BE_RRSR_RATE_EN_MASK GENMASK(12, 8)
+#define B_BE_RSC_MASK GENMASK(7, 6)
+#define B_BE_RRSR_CCK_MASK GENMASK(3, 0)
+
 #define R_BE_CMAC_ERR_IMR 0x10160
 #define R_BE_CMAC_ERR_IMR_C1 0x14160
 #define B_BE_CMAC_FW_ERR_IDCT_EN BIT(16)
@@ -5843,6 +5994,55 @@
 #define B_BE_P0_SYNC_PORT_SRC_SEL_MASK GENMASK(26, 24)
 #define B_BE_P0_TSFTR_SYNC_OFFSET_MASK GENMASK(18, 0)
 
+#define R_BE_EDCA_BCNQ_PARAM 0x10324
+#define R_BE_EDCA_BCNQ_PARAM_C1 0x14324
+#define B_BE_BCNQ_CW_MASK GENMASK(31, 24)
+#define B_BE_BCNQ_AIFS_MASK GENMASK(23, 16)
+#define BCN_IFS_25US 0x19
+#define B_BE_PIFS_MASK GENMASK(15, 8)
+#define B_BE_FORCE_BCN_IFS_MASK GENMASK(7, 0)
+
+#define R_BE_PREBKF_CFG_0 0x10338
+#define R_BE_PREBKF_CFG_0_C1 0x14338
+#define B_BE_100NS_TIME_MASK GENMASK(28, 24)
+#define B_BE_RX_AIR_END_TIME_MASK GENMASK(22, 16)
+#define B_BE_MACTX_LATENCY_MASK GENMASK(10, 8)
+#define B_BE_PREBKF_TIME_MASK GENMASK(4, 0)
+
+#define R_BE_CCA_CFG_0 0x10340
+#define R_BE_CCA_CFG_0_C1 0x14340
+#define B_BE_R_SIFS_AGGR_TIME_V1_MASK GENMASK(31, 24)
+#define B_BE_EDCCA_SEC160_EN BIT(23)
+#define B_BE_EDCCA_SEC80_EN BIT(22)
+#define B_BE_EDCCA_SEC40_EN BIT(21)
+#define B_BE_EDCCA_SEC20_EN BIT(20)
+#define B_BE_SEC160_EN BIT(19)
+#define B_BE_CCA_BITMAP_EN BIT(18)
+#define B_BE_TXPKTCTL_RST_EDCA_EN BIT(17)
+#define B_BE_WMAC_RST_EDCA_EN BIT(16)
+#define B_BE_TXFAIL_BRK_TXOP_EN BIT(11)
+#define B_BE_EDCCA_PER20_BITMAP_SIFS_EN BIT(10)
+#define B_BE_NO_GNT_WL_BRK_TXOP_EN BIT(9)
+#define B_BE_NAV_BRK_TXOP_EN BIT(8)
+#define B_BE_TX_NAV_EN BIT(7)
+#define B_BE_BCN_IGNORE_EDCCA BIT(6)
+#define B_BE_NO_GNT_WL_EN BIT(5)
+#define B_BE_EDCCA_EN BIT(4)
+#define B_BE_SEC80_EN BIT(3)
+#define B_BE_SEC40_EN BIT(2)
+#define B_BE_SEC20_EN BIT(1)
+#define B_BE_CCA_EN BIT(0)
+
+#define R_BE_CTN_CFG_0 0x1034C
+#define R_BE_CTN_CFG_0_C1 0x1434C
+#define B_BE_OTHER_LINK_BKF_BLK_TX_THD_MASK GENMASK(30, 24)
+#define B_BE_CCK_SIFS_COMP_MASK GENMASK(22, 16)
+#define B_BE_PIFS_TIMEUNIT_MASK GENMASK(15, 14)
+#define B_BE_PREBKF_TIME_NONAC_MASK GENMASK(12, 8)
+#define B_BE_SR_TX_EN BIT(2)
+#define B_BE_NAV_BLK_MGQ BIT(1)
+#define B_BE_NAV_BLK_HGQ BIT(0)
+
 #define R_BE_MUEDCA_BE_PARAM_0 0x10350
 #define R_BE_MUEDCA_BK_PARAM_0 0x10354
 #define R_BE_MUEDCA_VI_PARAM_0 0x10358
@@ -5855,6 +6055,63 @@
 #define B_BE_SET_MUEDCATIMER_TF_0 BIT(4)
 #define B_BE_MUEDCA_EN_0 BIT(0)
 
+#define R_BE_TB_CHK_CCA_NAV 0x103AC
+#define R_BE_TB_CHK_CCA_NAV_C1 0x143AC
+#define B_BE_TB_CHK_TX_NAV BIT(15)
+#define B_BE_TB_CHK_INTRA_NAV BIT(14)
+#define B_BE_TB_CHK_BASIC_NAV BIT(13)
+#define B_BE_TB_CHK_NO_GNT_WL BIT(12)
+#define B_BE_TB_CHK_EDCCA_S160 BIT(11)
+#define B_BE_TB_CHK_EDCCA_S80 BIT(10)
+#define B_BE_TB_CHK_EDCCA_S40 BIT(9)
+#define B_BE_TB_CHK_EDCCA_S20 BIT(8)
+#define B_BE_TB_CHK_CCA_S160 BIT(7)
+#define B_BE_TB_CHK_CCA_S80 BIT(6)
+#define B_BE_TB_CHK_CCA_S40 BIT(5)
+#define B_BE_TB_CHK_CCA_S20 BIT(4)
+#define B_BE_TB_CHK_EDCCA_BITMAP BIT(3)
+#define B_BE_TB_CHK_CCA_BITMAP BIT(2)
+#define B_BE_TB_CHK_EDCCA_P20 BIT(1)
+#define B_BE_TB_CHK_CCA_P20 BIT(0)
+
+#define R_BE_HE_SIFS_CHK_CCA_NAV 0x103B4
+#define R_BE_HE_SIFS_CHK_CCA_NAV_C1 0x143B4
+#define B_BE_HE_SIFS_CHK_TX_NAV BIT(15)
+#define B_BE_HE_SIFS_CHK_INTRA_NAV BIT(14)
+#define B_BE_HE_SIFS_CHK_BASIC_NAV BIT(13)
+#define B_BE_HE_SIFS_CHK_NO_GNT_WL BIT(12)
+#define B_BE_HE_SIFS_CHK_EDCCA_S160 BIT(11)
+#define B_BE_HE_SIFS_CHK_EDCCA_S80 BIT(10)
+#define B_BE_HE_SIFS_CHK_EDCCA_S40 BIT(9)
+#define B_BE_HE_SIFS_CHK_EDCCA_S20 BIT(8)
+#define B_BE_HE_SIFS_CHK_CCA_S160 BIT(7)
+#define B_BE_HE_SIFS_CHK_CCA_S80 BIT(6)
+#define B_BE_HE_SIFS_CHK_CCA_S40 BIT(5)
+#define B_BE_HE_SIFS_CHK_CCA_S20 BIT(4)
+#define B_BE_HE_SIFS_CHK_EDCCA_BITMAP BIT(3)
+#define B_BE_HE_SIFS_CHK_CCA_BITMAP BIT(2)
+#define B_BE_HE_SIFS_CHK_EDCCA_P20 BIT(1)
+#define B_BE_HE_SIFS_CHK_CCA_P20 BIT(0)
+
+#define R_BE_HE_CTN_CHK_CCA_NAV 0x103C4
+#define R_BE_HE_CTN_CHK_CCA_NAV_C1 0x143C4
+#define B_BE_HE_CTN_CHK_TX_NAV BIT(15)
+#define B_BE_HE_CTN_CHK_INTRA_NAV BIT(14)
+#define B_BE_HE_CTN_CHK_BASIC_NAV BIT(13)
+#define B_BE_HE_CTN_CHK_NO_GNT_WL BIT(12)
+#define B_BE_HE_CTN_CHK_EDCCA_S160 BIT(11)
+#define B_BE_HE_CTN_CHK_EDCCA_S80 BIT(10)
+#define B_BE_HE_CTN_CHK_EDCCA_S40 BIT(9)
+#define B_BE_HE_CTN_CHK_EDCCA_S20 BIT(8)
+#define B_BE_HE_CTN_CHK_CCA_S160 BIT(7)
+#define B_BE_HE_CTN_CHK_CCA_S80 BIT(6)
+#define B_BE_HE_CTN_CHK_CCA_S40 BIT(5)
+#define B_BE_HE_CTN_CHK_CCA_S20 BIT(4)
+#define B_BE_HE_CTN_CHK_EDCCA_BITMAP BIT(3)
+#define B_BE_HE_CTN_CHK_CCA_BITMAP BIT(2)
+#define B_BE_HE_CTN_CHK_EDCCA_P20 BIT(1)
+#define B_BE_HE_CTN_CHK_CCA_P20 BIT(0)
+
 #define R_BE_SCHEDULE_ERR_IMR 0x103E8
 #define R_BE_SCHEDULE_ERR_IMR_C1 0x143E8
 #define B_BE_FSM_TIMEOUT_ERR_INT_EN BIT(0)
@@ -5980,12 +6237,51 @@
 #define R_BE_PORT_HGQ_WINDOW_CFG 0x105A0
 #define R_BE_PORT_HGQ_WINDOW_CFG_C1 0x145A0
 
+#define R_BE_PTCL_COMMON_SETTING_0 0x10800
+#define R_BE_PTCL_COMMON_SETTING_0_C1 0x14800
+#define B_BE_PCIE_MODE_MASK GENMASK(15, 14)
+#define B_BE_CPUMGQ_LIFETIME_EN BIT(8)
+#define B_BE_MGQ_LIFETIME_EN BIT(7)
+#define B_BE_LIFETIME_EN BIT(6)
+#define B_BE_DIS_PTCL_CLK_GATING BIT(5)
+#define B_BE_PTCL_TRIGGER_SS_EN_UL BIT(4)
+#define B_BE_PTCL_TRIGGER_SS_EN_1 BIT(3)
+#define B_BE_PTCL_TRIGGER_SS_EN_0 BIT(2)
+#define B_BE_CMAC_TX_MODE_1 BIT(1)
+#define B_BE_CMAC_TX_MODE_0 BIT(0)
+
+#define R_BE_TB_PPDU_CTRL 0x1080C
+#define R_BE_TB_PPDU_CTRL_C1 0x1480C
+#define B_BE_TB_PPDU_BK_DIS BIT(15)
+#define B_BE_TB_PPDU_BE_DIS BIT(14)
+#define B_BE_TB_PPDU_VI_DIS BIT(13)
+#define B_BE_TB_PPDU_VO_DIS BIT(12)
+#define B_BE_QOSNULL_UPD_MUEDCA_EN BIT(3)
+#define B_BE_TB_BYPASS_TXPWR BIT(2)
+#define B_BE_SW_PREFER_AC_MASK GENMASK(1, 0)
+
+#define R_BE_AMPDU_AGG_LIMIT 0x10810
+#define R_BE_AMPDU_AGG_LIMIT_C1 0x14810
+#define B_BE_AMPDU_MAX_TIME_MASK GENMASK(31, 24)
+#define AMPDU_MAX_TIME 0x9E
+#define B_BE_RA_TRY_RATE_AGG_LMT_MASK GENMASK(23, 16)
+#define B_BE_RTS_MAX_AGG_NUM_MASK GENMASK(15, 8)
+#define B_BE_MAX_AGG_NUM_MASK GENMASK(7, 0)
+
 #define R_BE_AGG_LEN_HT_0 0x10814
 #define R_BE_AGG_LEN_HT_0_C1 0x14814
 #define B_BE_AMPDU_MAX_LEN_HT_MASK GENMASK(31, 16)
 #define B_BE_RTS_TXTIME_TH_MASK GENMASK(15, 8)
 #define B_BE_RTS_LEN_TH_MASK GENMASK(7, 0)
 
+#define R_BE_SIFS_SETTING 0x10824
+#define R_BE_SIFS_SETTING_C1 0x14824
+#define B_BE_HW_CTS2SELF_PKT_LEN_TH_MASK GENMASK(31, 24)
+#define B_BE_HW_CTS2SELF_PKT_LEN_TH_TWW_MASK GENMASK(23, 18)
+#define B_BE_HW_CTS2SELF_EN BIT(16)
+#define B_BE_SPEC_SIFS_OFDM_PTCL_MASK GENMASK(15, 8)
+#define B_BE_SPEC_SIFS_CCK_PTCL_MASK GENMASK(7, 0)
+
 #define R_BE_MBSSID_DROP_0 0x1083C
 #define R_BE_MBSSID_DROP_0_C1 0x1483C
 #define B_BE_GI_LTF_FB_SEL BIT(30)
@@ -6084,6 +6380,24 @@
 #define B_BE_TXPRT_FULL_DROP_ERR BIT(9)
 #define B_BE_F2PCMDRPT_FULL_DROP_ERR BIT(8)
 
+#define R_BE_PTCL_FSM_MON 0x108E8
+#define R_BE_PTCL_FSM_MON_C1 0x148E8
+#define B_BE_PTCL_FSM2_TO_MODE BIT(30)
+#define B_BE_PTCL_FSM2_TO_THR_MASK GENMASK(29, 24)
+#define B_BE_PTCL_FSM1_TO_MODE BIT(22)
+#define B_BE_PTCL_FSM1_TO_THR_MASK GENMASK(21, 16)
+#define B_BE_PTCL_FSM0_TO_MODE BIT(14)
+#define B_BE_PTCL_FSM0_TO_THR_MASK GENMASK(13, 8)
+#define B_BE_PTCL_TX_ARB_TO_MODE BIT(6)
+#define B_BE_PTCL_TX_ARB_TO_THR_MASK GENMASK(5, 0)
+
+#define R_BE_PTCL_TX_CTN_SEL 0x108EC
+#define R_BE_PTCL_TX_CTN_SEL_C1 0x148EC
+#define B_BE_PTCL_TXOP_STAT BIT(8)
+#define B_BE_PTCL_BUSY BIT(7)
+#define B_BE_PTCL_DROP BIT(5)
+#define B_BE_PTCL_TX_QUEUE_IDX_MASK GENMASK(4, 0)
+
 #define R_BE_RX_ERROR_FLAG 0x10C00
 #define R_BE_RX_ERROR_FLAG_C1 0x14C00
 #define B_BE_RX_CSI_NOT_RELEASE_ERROR BIT(31)
@@ -6198,6 +6512,15 @@
 				    B_BE_RX_RU0_FSM_HANG_ERROR_IMR | \
 				    B_BE_RX_GET_NULL_PKT_ERROR_IMR)
 
+#define R_BE_RX_CTRL_1 0x10C0C
+#define R_BE_RX_CTRL_1_C1 0x14C0C
+#define B_BE_RXDMA_TXRPT_QUEUE_ID_SW_MASK GENMASK(30, 25)
+#define B_BE_RXDMA_F2PCMDRPT_QUEUE_ID_SW_MASK GENMASK(23, 18)
+#define B_BE_RXDMA_TXRPT_PORT_ID_SW_MASK GENMASK(17, 14)
+#define B_BE_RXDMA_F2PCMDRPT_PORT_ID_SW_MASK GENMASK(13, 10)
+#define B_BE_DBG_SEL_MASK GENMASK(1, 0)
+#define WLCPU_RXCH2_QID 0xA
+
 #define R_BE_TX_ERROR_FLAG 0x10C6C
 #define R_BE_TX_ERROR_FLAG_C1 0x14C6C
 #define B_BE_TX_RU0_FSM_HANG_ERROR BIT(31)
@@ -6353,6 +6676,15 @@
 #define B_BE_UPD_HGQMD BIT(1)
 #define B_BE_UPD_TIMIE BIT(0)
 
+#define R_BE_WMTX_TCR_BE_4 0x10E2C
+#define R_BE_WMTX_TCR_BE_4_C1 0x14E2C
+#define B_BE_UL_EHT_MUMIMO_LTF_MODE BIT(30)
+#define B_BE_UL_HE_MUMIMO_LTF_MODE BIT(29)
+#define B_BE_EHT_HE_PPDU_4XLTF_ZLD_USTIMER_MASK GENMASK(28, 24)
+#define B_BE_EHT_HE_PPDU_2XLTF_ZLD_USTIMER_MASK GENMASK(20, 16)
+#define B_BE_NON_LEGACY_PPDU_ZLD_USTIMER_MASK GENMASK(12, 8)
+#define B_BE_LEGACY_PPDU_ZLD_USTIMER_MASK GENMASK(4, 0)
+
 #define R_BE_RSP_CHK_SIG 0x11000
 #define R_BE_RSP_CHK_SIG_C1 0x15000
 #define B_BE_RSP_STATIC_RTS_CHK_SERV_BW_EN BIT(30)
@@ -6385,6 +6717,46 @@
 #define WMAC_SPEC_SIFS_OFDM_1115E 0x11
 #define B_BE_WMAC_SPEC_SIFS_CCK_MASK GENMASK(7, 0)
 
+#define R_BE_TRXPTCL_RESP_1 0x11008
+#define R_BE_TRXPTCL_RESP_1_C1 0x15008
+#define B_BE_WMAC_RESP_SR_MODE_EN BIT(31)
+#define B_BE_FTM_RRSR_RATE_EN_MASK GENMASK(28, 24)
+#define B_BE_NESS_MASK GENMASK(23, 22)
+#define B_BE_WMAC_RESP_DOPPLEB_BE_EN BIT(21)
+#define B_BE_WMAC_RESP_DCM_EN BIT(20)
+#define B_BE_WMAC_CLR_ABORT_RESP_TX_CNT BIT(15)
+#define B_BE_WMAC_RESP_REF_RATE_SEL BIT(12)
+#define B_BE_WMAC_RESP_REF_RATE_MASK GENMASK(11, 0)
+
+#define R_BE_MAC_LOOPBACK 0x11020
+#define R_BE_MAC_LOOPBACK_C1 0x15020
+#define B_BE_MACLBK_DIS_GCLK BIT(30)
+#define B_BE_MACLBK_STS_EN BIT(29)
+#define B_BE_MACLBK_RDY_PERIOD_MASK GENMASK(28, 17)
+#define B_BE_MACLBK_PLCP_DLY_MASK GENMASK(16, 8)
+#define S_BE_MACLBK_PLCP_DLY_DEF 0x28
+#define B_BE_MACLBK_RDY_NUM_MASK GENMASK(7, 3)
+#define B_BE_MACLBK_EN BIT(0)
+
+#define R_BE_WMAC_NAV_CTL 0x11080
+#define R_BE_WMAC_NAV_CTL_C1 0x15080
+#define B_BE_WMAC_NAV_UPPER_EN BIT(26)
+#define B_BE_WMAC_0P125US_TIMER_MASK GENMASK(25, 18)
+#define B_BE_WMAC_PLCP_UP_NAV_EN BIT(17)
+#define B_BE_WMAC_TF_UP_NAV_EN BIT(16)
+#define B_BE_WMAC_NAV_UPPER_MASK GENMASK(15, 8)
+#define NAV_25MS 0xC4
+#define B_BE_WMAC_RTS_RST_DUR_MASK GENMASK(7, 0)
+
+#define R_BE_RXTRIG_TEST_USER_2 0x110B0
+#define R_BE_RXTRIG_TEST_USER_2_C1 0x150B0
+#define B_BE_RXTRIG_MACID_MASK GENMASK(31, 24)
+#define B_BE_RXTRIG_RU26_DIS BIT(21)
+#define B_BE_RXTRIG_FCSCHK_EN BIT(20)
+#define B_BE_RXTRIG_PORT_SEL_MASK GENMASK(19, 17)
+#define B_BE_RXTRIG_EN BIT(16)
+#define B_BE_RXTRIG_USERINFO_2_MASK GENMASK(15, 0)
+
 #define R_BE_TRXPTCL_ERROR_INDICA_MASK 0x110BC
 #define R_BE_TRXPTCL_ERROR_INDICA_MASK_C1 0x150BC
 #define B_BE_WMAC_FTM_TIMEOUT_MODE BIT(30)
@@ -6526,6 +6898,103 @@
 #define B_BE_BFMEE_HT_CSI_RATE_MASK GENMASK(7, 0)
 #define CSI_INIT_RATE_EHT 0x3
 
+#define R_BE_WMAC_ACK_BA_RESP_LEGACY 0x11200
+#define R_BE_WMAC_ACK_BA_RESP_LEGACY_C1 0x15200
+#define B_BE_ACK_BA_RESP_LEGACY_CHK_NSTR BIT(16)
+#define B_BE_ACK_BA_RESP_LEGACY_CHK_TX_NAV BIT(15)
+#define B_BE_ACK_BA_RESP_LEGACY_CHK_INTRA_NAV BIT(14)
+#define B_BE_ACK_BA_RESP_LEGACY_CHK_BASIC_NAV BIT(13)
+#define B_BE_ACK_BA_RESP_LEGACY_CHK_BTCCA BIT(12)
+#define B_BE_ACK_BA_RESP_LEGACY_CHK_SEC_EDCCA160 BIT(11)
+#define B_BE_ACK_BA_RESP_LEGACY_CHK_SEC_EDCCA80 BIT(10)
+#define B_BE_ACK_BA_RESP_LEGACY_CHK_SEC_EDCCA40 BIT(9)
+#define B_BE_ACK_BA_RESP_LEGACY_CHK_SEC_EDCCA20 BIT(8)
+#define B_BE_ACK_BA_RESP_LEGACY_CHK_EDCCA_PER20_BMP BIT(7)
+#define B_BE_ACK_BA_RESP_LEGACY_CHK_CCA_PER20_BMP BIT(6)
+#define B_BE_ACK_BA_RESP_LEGACY_CHK_SEC_CCA160 BIT(5)
+#define B_BE_ACK_BA_RESP_LEGACY_CHK_SEC_CCA80 BIT(4)
+#define B_BE_ACK_BA_RESP_LEGACY_CHK_SEC_CCA40 BIT(3)
+#define B_BE_ACK_BA_RESP_LEGACY_CHK_SEC_CCA20 BIT(2)
+#define B_BE_ACK_BA_RESP_LEGACY_CHK_EDCCA BIT(1)
+#define B_BE_ACK_BA_RESP_LEGACY_CHK_CCA BIT(0)
+
+#define R_BE_WMAC_ACK_BA_RESP_HE 0x11204
+#define R_BE_WMAC_ACK_BA_RESP_HE_C1 0x15204
+#define B_BE_ACK_BA_RESP_HE_CHK_NSTR BIT(16)
+#define B_BE_ACK_BA_RESP_HE_CHK_TX_NAV BIT(15)
+#define B_BE_ACK_BA_RESP_HE_CHK_INTRA_NAV BIT(14)
+#define B_BE_ACK_BA_RESP_HE_CHK_BASIC_NAV BIT(13)
+#define B_BE_ACK_BA_RESP_HE_CHK_BTCCA BIT(12)
+#define B_BE_ACK_BA_RESP_HE_CHK_SEC_EDCCA160 BIT(11)
+#define B_BE_ACK_BA_RESP_HE_CHK_SEC_EDCCA80 BIT(10)
+#define B_BE_ACK_BA_RESP_HE_CHK_SEC_EDCCA40 BIT(9)
+#define B_BE_ACK_BA_RESP_HE_CHK_SEC_EDCCA20 BIT(8)
+#define B_BE_ACK_BA_RESP_HE_CHK_EDCCA_PER20_BMP BIT(7)
+#define B_BE_ACK_BA_RESP_HE_CHK_CCA_PER20_BMP BIT(6)
+#define B_BE_ACK_BA_RESP_HE_CHK_SEC_CCA160 BIT(5)
+#define B_BE_ACK_BA_RESP_HE_CHK_SEC_CCA80 BIT(4)
+#define B_BE_ACK_BA_RESP_HE_CHK_SEC_CCA40 BIT(3)
+#define B_BE_ACK_BA_RESP_HE_CHK_SEC_CCA20 BIT(2)
+#define B_BE_ACK_BA_RESP_HE_CHK_EDCCA BIT(1)
+#define B_BE_ACK_BA_RESP_HE_CHK_CCA BIT(0)
+
+#define R_BE_WMAC_ACK_BA_RESP_EHT_LEG_PUNC 0x11208
+#define R_BE_WMAC_ACK_BA_RESP_EHT_LEG_PUNC_C1 0x15208
+#define B_BE_ACK_BA_EHT_LEG_PUNC_CHK_NSTR BIT(16)
+#define B_BE_ACK_BA_EHT_LEG_PUNC_CHK_TX_NAV BIT(15)
+#define B_BE_ACK_BA_EHT_LEG_PUNC_CHK_INTRA_NAV BIT(14)
+#define B_BE_ACK_BA_EHT_LEG_PUNC_CHK_BASIC_NAV BIT(13)
+#define B_BE_ACK_BA_EHT_LEG_PUNC_CHK_BTCCA BIT(12)
+#define B_BE_ACK_BA_EHT_LEG_PUNC_CHK_SEC_EDCCA160 BIT(11)
+#define B_BE_ACK_BA_EHT_LEG_PUNC_CHK_SEC_EDCCA80 BIT(10)
+#define B_BE_ACK_BA_EHT_LEG_PUNC_CHK_SEC_EDCCA40 BIT(9)
+#define B_BE_ACK_BA_EHT_LEG_PUNC_CHK_SEC_EDCCA20 BIT(8)
+#define B_BE_ACK_BA_EHT_LEG_PUNC_CHK_EDCCA_PER20_BMP BIT(7)
+#define B_BE_ACK_BA_EHT_LEG_PUNC_CHK_CCA_PER20_BMP BIT(6)
+#define B_BE_ACK_BA_EHT_LEG_PUNC_CHK_SEC_CCA160 BIT(5)
+#define B_BE_ACK_BA_EHT_LEG_PUNC_CHK_SEC_CCA80 BIT(4)
+#define B_BE_ACK_BA_EHT_LEG_PUNC_CHK_SEC_CCA40 BIT(3)
+#define B_BE_ACK_BA_EHT_LEG_PUNC_CHK_SEC_CCA20 BIT(2)
+#define B_BE_ACK_BA_EHT_LEG_PUNC_CHK_EDCCA BIT(1)
+#define B_BE_ACK_BA_EHT_LEG_PUNC_CHK_CCA BIT(0)
+
+#define R_BE_RCR 0x11400
+#define R_BE_RCR_C1 0x15400
+#define B_BE_BUSY_CHKSN BIT(15)
+#define B_BE_DYN_CHEN BIT(14)
+#define B_BE_AUTO_RST BIT(13)
+#define B_BE_TIMER_SEL BIT(12)
+#define B_BE_STOP_RX_IN BIT(11)
+#define B_BE_PSR_RDY_CHKDIS BIT(10)
+#define B_BE_DRV_INFO_SZ_MASK GENMASK(9, 8)
+#define B_BE_HDR_CNV_SZ_MASK GENMASK(7, 6)
+#define B_BE_PHY_RPT_SZ_MASK GENMASK(5, 4)
+#define B_BE_CH_EN BIT(0)
+
+#define R_BE_DLK_PROTECT_CTL 0x11402
+#define R_BE_DLK_PROTECT_CTL_C1 0x15402
+#define B_BE_RX_DLK_CCA_TIME_MASK GENMASK(15, 8)
+#define TRXCFG_RMAC_CCA_TO 32
+#define B_BE_RX_DLK_DATA_TIME_MASK GENMASK(7, 4)
+#define TRXCFG_RMAC_DATA_TO 15
+#define B_BE_RX_DLK_RST_FSM BIT(3)
+#define B_BE_RX_DLK_RST_SKIPDMA BIT(2)
+#define B_BE_RX_DLK_RST_EN BIT(1)
+#define B_BE_RX_DLK_INT_EN BIT(0)
+
+#define R_BE_PLCP_HDR_FLTR 0x11404
+#define R_BE_PLCP_HDR_FLTR_C1 0x15404
+#define B_BE_PLCP_RXFA_RESET_TYPE_MASK GENMASK(15, 12)
+#define B_BE_PLCP_RXFA_RESET_EN BIT(11)
+#define B_BE_DIS_CHK_MIN_LEN BIT(8)
+#define B_BE_HE_SIGB_CRC_CHK BIT(6)
+#define B_BE_VHT_MU_SIGB_CRC_CHK BIT(5)
+#define B_BE_VHT_SU_SIGB_CRC_CHK BIT(4)
+#define B_BE_SIGA_CRC_CHK BIT(3)
+#define B_BE_LSIG_PARITY_CHK_EN BIT(2)
+#define B_BE_CCK_SIG_CHK BIT(1)
+#define B_BE_CCK_CRC_CHK BIT(0)
+
 #define R_BE_RX_FLTR_OPT 0x11420
 #define R_BE_RX_FLTR_OPT_C1 0x15420
 #define B_BE_UID_FILTER_MASK GENMASK(31, 24)
@@ -6559,6 +7028,41 @@
 #define R_BE_DATA_FLTR_C1 0x1542C
 #define B_BE_DATA_STYPE_MASK GENMASK(15, 0)
 
+#define R_BE_ADDR_CAM_CTRL 0x11434
+#define R_BE_ADDR_CAM_CTRL_C1 0x15434
+#define B_BE_ADDR_CAM_RANGE_MASK GENMASK(23, 16)
+#define ADDR_CAM_SERCH_RANGE  0x7f
+#define B_BE_ADDR_CAM_CMPLIMT_MASK GENMASK(15, 12)
+#define B_BE_ADDR_CAM_IORST BIT(10)
+#define B_BE_DIS_ADDR_CLK_GATED BIT(9)
+#define B_BE_ADDR_CAM_CLR BIT(8)
+#define B_BE_ADDR_CAM_A2_B0_CHK BIT(2)
+#define B_BE_ADDR_CAM_SRCH_PERPKT BIT(1)
+#define B_BE_ADDR_CAM_EN BIT(0)
+
+#define R_BE_RESPBA_CAM_CTRL 0x1143C
+#define R_BE_RESPBA_CAM_CTRL_C1 0x1543C
+#define B_BE_BACAM_SKIP_ALL_QOSNULL BIT(24)
+#define B_BE_BACAM_STD_SSN_SEL BIT(20)
+#define B_BE_BACAM_TEMP_SZ_MASK GENMASK(17, 16)
+#define B_BE_BACAM_RST_IDX_MASK GENMASK(15, 8)
+#define B_BE_BACAM_SHIFT_POLL BIT(7)
+#define B_BE_BACAM_IORST BIT(6)
+#define B_BE_BACAM_GCK_DIS BIT(5)
+#define B_BE_COMPL_VAL BIT(3)
+#define B_BE_SSN_SEL BIT(2)
+#define B_BE_BACAM_RST_MASK GENMASK(1, 0)
+#define S_BE_BACAM_RST_DONE 0
+#define S_BE_BACAM_RST_ENT 1
+#define S_BE_BACAM_RST_ALL 2
+
+#define R_BE_RX_SR_CTRL 0x1144A
+#define R_BE_RX_SR_CTRL_C1 0x1544A
+#define B_BE_SR_OP_MODE_MASK GENMASK(5, 4)
+#define B_BE_SRG_CHK_EN BIT(2)
+#define B_BE_SR_CTRL_PLCP_EN BIT(1)
+#define B_BE_SR_EN BIT(0)
+
 #define R_BE_CSIRPT_OPTION 0x11464
 #define R_BE_CSIRPT_OPTION_C1 0x15464
 #define B_BE_CSIPRT_EHTSU_AID_EN BIT(26)
@@ -6604,6 +7108,29 @@
 			     B_BE_RX_ERR_STS_ACT_TO_MSK | \
 			     B_BE_RX_ERR_TRIG_ACT_TO_MSK)
 
+#define R_BE_RX_PLCP_EXT_OPTION_1 0x11514
+#define R_BE_RX_PLCP_EXT_OPTION_1_C1 0x15514
+#define B_BE_PLCP_CLOSE_RX_UNSPUUORT BIT(19)
+#define B_BE_PLCP_CLOSE_RX_BB_BRK BIT(18)
+#define B_BE_PLCP_CLOSE_RX_PSDU_PRES BIT(17)
+#define B_BE_PLCP_CLOSE_RX_NDP BIT(16)
+#define B_BE_PLCP_NSS_SRC BIT(11)
+#define B_BE_PLCP_DOPPLEB_BE_SRC BIT(10)
+#define B_BE_PLCP_STBC_SRC BIT(9)
+#define B_BE_PLCP_SU_PSDU_LEN_SRC BIT(8)
+#define B_BE_PLCP_RXSB_SRC BIT(7)
+#define B_BE_PLCP_BW_SRC_MASK GENMASK(6, 5)
+#define B_BE_PLCP_GILTF_SRC BIT(4)
+#define B_BE_PLCP_NSTS_SRC BIT(3)
+#define B_BE_PLCP_MCS_SRC BIT(2)
+#define B_BE_PLCP_CH20_WIDATA_SRC BIT(1)
+#define B_BE_PLCP_PPDU_TYPE_SRC BIT(0)
+
+#define R_BE_RESP_CSI_RESERVED_PAGE 0x11810
+#define R_BE_RESP_CSI_RESERVED_PAGE_C1 0x15810
+#define B_BE_CSI_RESERVED_PAGE_NUM_MASK GENMASK(27, 16)
+#define B_BE_CSI_RESERVED_START_PAGE_MASK GENMASK(11, 0)
+
 #define R_BE_RESP_IMR 0x11884
 #define R_BE_RESP_IMR_C1 0x15884
 #define B_BE_RESP_TBL_FLAG_ERR_ISR_EN BIT(17)
-- 
2.25.1


