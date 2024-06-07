Return-Path: <linux-wireless+bounces-8666-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C3D318FFCCB
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 09:11:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B6F2B1C28028
	for <lists+linux-wireless@lfdr.de>; Fri,  7 Jun 2024 07:11:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D90153578;
	Fri,  7 Jun 2024 07:07:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A547155CAB
	for <linux-wireless@vger.kernel.org>; Fri,  7 Jun 2024 07:07:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717744056; cv=none; b=Hy702cCotN11Y1xCnvSAjYdgPOsp2RPAKwBazCdg8HpQnBT4YkoiSTw1Ue1Ldrj97nbK+rJrSZ14nG8DVkaXZOhw8wnwPM63S/3ePxjX6JWZAd0NlrkYf+hGoYn8/f8p699wirtyhDgROUdXu/cjRSv+QKtQmK8zKK7resqTxek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717744056; c=relaxed/simple;
	bh=+KLTz+DGS0qwOarfZ5oRLug8diVlmMq/kKlrHJDJa88=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rXyEToWlqMF0qVn62qS3Q/CbaTGMFiFJwDlez9NurTfnE0GPxmULnZd8eHbtReQzmuZMlX4nlV/N7rnXfp+oJDNwZmpckso6yKqiU4X6EJheELGpzy1Mxj9OzS2J0UVL3itvnf2+kWnTNGjrNr+nlyr+3GJkLBNYzUj6mFWQJzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45777VPE03728595, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45777VPE03728595
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK)
	for <linux-wireless@vger.kernel.org>; Fri, 7 Jun 2024 15:07:31 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 7 Jun 2024 15:07:32 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.1.2507.35; Fri, 7 Jun
 2024 15:07:31 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/3] wifi: rtw89: 885xbx: apply common settings to 8851B, 8852B and 8852BT
Date: Fri, 7 Jun 2024 15:06:59 +0800
Message-ID: <20240607070659.80263-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240607070659.80263-1-pkshih@realtek.com>
References: <20240607070659.80263-1-pkshih@realtek.com>
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

Many common settings can share to 8851B, 8852B and 8852BT, so add an inline
function rtw89_is_rtl885xb() to be concise. Meanwhile review and align
settings for existing chips.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/cam.c   |  1 +
 drivers/net/wireless/realtek/rtw89/coex.c  |  3 +-
 drivers/net/wireless/realtek/rtw89/core.c  |  2 +-
 drivers/net/wireless/realtek/rtw89/core.h  | 10 +++++
 drivers/net/wireless/realtek/rtw89/debug.c |  2 +-
 drivers/net/wireless/realtek/rtw89/mac.c   | 43 +++++++++++-----------
 drivers/net/wireless/realtek/rtw89/pci.c   | 38 +++++++++----------
 drivers/net/wireless/realtek/rtw89/phy.c   |  2 +-
 drivers/net/wireless/realtek/rtw89/reg.h   |  2 +
 9 files changed, 57 insertions(+), 46 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/cam.c b/drivers/net/wireless/realtek/rtw89/cam.c
index 35291efbbae9..4557c6e035a9 100644
--- a/drivers/net/wireless/realtek/rtw89/cam.c
+++ b/drivers/net/wireless/realtek/rtw89/cam.c
@@ -523,6 +523,7 @@ static u8 rtw89_get_addr_cam_entry_size(struct rtw89_dev *rtwdev)
 	case RTL8852A:
 	case RTL8852B:
 	case RTL8851B:
+	case RTL8852BT:
 		return ADDR_CAM_ENT_SIZE;
 	default:
 		return ADDR_CAM_ENT_SHORT_SIZE;
diff --git a/drivers/net/wireless/realtek/rtw89/coex.c b/drivers/net/wireless/realtek/rtw89/coex.c
index c443b39ab3c6..d8fc93318a51 100644
--- a/drivers/net/wireless/realtek/rtw89/coex.c
+++ b/drivers/net/wireless/realtek/rtw89/coex.c
@@ -228,6 +228,7 @@ static u32 chip_id_to_bt_rom_code_id(u32 id)
 	case RTL8852A:
 	case RTL8852B:
 	case RTL8852C:
+	case RTL8852BT:
 		return 0x8852;
 	case RTL8851B:
 		return 0x8851;
@@ -9514,7 +9515,7 @@ static void _get_gnt(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_coex_gnt *gnt
 	u32 val, status;
 
 	if (chip->chip_id == RTL8852A || chip->chip_id == RTL8852B ||
-	    chip->chip_id == RTL8851B) {
+	    chip->chip_id == RTL8851B || chip->chip_id == RTL8852BT) {
 		rtw89_mac_read_lte(rtwdev, R_AX_LTE_SW_CFG_1, &val);
 		rtw89_mac_read_lte(rtwdev, R_AX_GNT_VAL, &status);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 3e99b63a7995..febc715f1183 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -4382,7 +4382,7 @@ static void rtw89_read_chip_ver(struct rtw89_dev *rtwdev)
 
 	rtwdev->hal.cv = cv;
 
-	if (chip->chip_id == RTL8852B || chip->chip_id == RTL8851B) {
+	if (rtw89_is_rtl885xb(rtwdev)) {
 		ret = rtw89_mac_read_xtal_si(rtwdev, XTAL_SI_CV, &val);
 		if (ret)
 			return;
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index 874119b5007d..e8ec0246bccd 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -6421,6 +6421,16 @@ static inline bool rtw89_is_mlo_1_1(struct rtw89_dev *rtwdev)
 	}
 }
 
+static inline bool rtw89_is_rtl885xb(struct rtw89_dev *rtwdev)
+{
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
+
+	if (chip_id == RTL8852B || chip_id == RTL8851B || chip_id == RTL8852BT)
+		return true;
+
+	return false;
+}
+
 int rtw89_core_tx_write(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 			struct ieee80211_sta *sta, struct sk_buff *skb, int *qsel);
 int rtw89_h2c_tx(struct rtw89_dev *rtwdev,
diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 210f192ac9ec..49bbbd049316 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -2996,7 +2996,7 @@ static bool is_dbg_port_valid(struct rtw89_dev *rtwdev, u32 sel)
 	    sel >= RTW89_DBG_PORT_SEL_PCIE_TXDMA &&
 	    sel <= RTW89_DBG_PORT_SEL_PCIE_MISC2)
 		return false;
-	if (rtwdev->chip->chip_id == RTL8852B &&
+	if (rtw89_is_rtl885xb(rtwdev) &&
 	    sel >= RTW89_DBG_PORT_SEL_PTCL_C1 &&
 	    sel <= RTW89_DBG_PORT_SEL_TXTF_INFOH_C1)
 		return false;
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index 824ece03d92d..b759fa8fbca9 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -1568,6 +1568,8 @@ static int dmac_func_en_ax(struct rtw89_dev *rtwdev)
 		 B_AX_DLE_CPUIO_CLK_EN | B_AX_PKT_IN_CLK_EN |
 		 B_AX_STA_SCH_CLK_EN | B_AX_TXPKT_CTRL_CLK_EN |
 		 B_AX_WD_RLS_CLK_EN | B_AX_BBRPT_CLK_EN);
+	if (chip_id == RTL8852BT)
+		val32 |= B_AX_AXIDMA_CLK_EN;
 	rtw89_write32(rtwdev, R_AX_DMAC_CLK_EN, val32);
 
 	return 0;
@@ -1577,7 +1579,7 @@ static int chip_func_en_ax(struct rtw89_dev *rtwdev)
 {
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 
-	if (chip_id == RTL8852A || chip_id == RTL8852B)
+	if (chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev))
 		rtw89_write32_set(rtwdev, R_AX_SPS_DIG_ON_CTRL0,
 				  B_AX_OCP_L1_MASK);
 
@@ -2146,8 +2148,8 @@ int rtw89_mac_preload_init(struct rtw89_dev *rtwdev, enum rtw89_mac_idx mac_idx,
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
-	if (chip->chip_id == RTL8852A || chip->chip_id == RTL8852B ||
-	    chip->chip_id == RTL8851B || !is_qta_poh(rtwdev))
+	if (chip->chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev) ||
+	    !is_qta_poh(rtwdev))
 		return 0;
 
 	return preload_init_set(rtwdev, mac_idx, mode);
@@ -2183,8 +2185,7 @@ static void _patch_ss2f_path(struct rtw89_dev *rtwdev)
 {
 	const struct rtw89_chip_info *chip = rtwdev->chip;
 
-	if (chip->chip_id == RTL8852A || chip->chip_id == RTL8852B ||
-	    chip->chip_id == RTL8851B)
+	if (chip->chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev))
 		return;
 
 	rtw89_write32_mask(rtwdev, R_AX_SS2FINFO_PATH, B_AX_SS_DEST_QUEUE_MASK,
@@ -2360,7 +2361,7 @@ static int scheduler_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 		rtw89_write32_mask(rtwdev, reg, B_AX_SIFS_MACTXEN_T1_MASK,
 				   SIFS_MACTXEN_T1);
 
-	if (rtwdev->chip->chip_id == RTL8852B || rtwdev->chip->chip_id == RTL8851B) {
+	if (rtw89_is_rtl885xb(rtwdev)) {
 		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_SCH_EXT_CTRL, mac_idx);
 		rtw89_write32_set(rtwdev, reg, B_AX_PORT_RST_TSF_ADV);
 	}
@@ -2588,7 +2589,9 @@ static int trxptcl_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 	case RTL8852A:
 		sifs = WMAC_SPEC_SIFS_OFDM_52A;
 		break;
+	case RTL8851B:
 	case RTL8852B:
+	case RTL8852BT:
 		sifs = WMAC_SPEC_SIFS_OFDM_52B;
 		break;
 	default:
@@ -2632,6 +2635,7 @@ static int rmac_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 #define RX_MAX_LEN_UNIT 512
 #define PLD_RLS_MAX_PG 127
 #define RX_SPEC_MAX_LEN (11454 + RX_MAX_LEN_UNIT)
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	int ret;
 	u32 reg, rx_max_len, rx_qta;
 	u16 val;
@@ -2652,6 +2656,8 @@ static int rmac_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 			       B_AX_RX_DLK_DATA_TIME_MASK);
 	val = u16_replace_bits(val, TRXCFG_RMAC_CCA_TO,
 			       B_AX_RX_DLK_CCA_TIME_MASK);
+	if (chip_id == RTL8852BT)
+		val |= B_AX_RX_DLK_RST_EN;
 	rtw89_write16(rtwdev, reg, val);
 
 	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_RCR, mac_idx);
@@ -2668,8 +2674,7 @@ static int rmac_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 	rx_max_len /= RX_MAX_LEN_UNIT;
 	rtw89_write32_mask(rtwdev, reg, B_AX_RX_MPDU_MAX_LEN_MASK, rx_max_len);
 
-	if (rtwdev->chip->chip_id == RTL8852A &&
-	    rtwdev->hal.cv == CHIP_CBV) {
+	if (chip_id == RTL8852A && rtwdev->hal.cv == CHIP_CBV) {
 		rtw89_write16_mask(rtwdev,
 				   rtw89_mac_reg_by_idx(rtwdev, R_AX_DLK_PROTECT_CTL, mac_idx),
 				   B_AX_RX_DLK_CCA_TIME_MASK, 0);
@@ -2700,7 +2705,7 @@ static int cmac_com_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 	val = u32_replace_bits(val, 0, B_AX_TXSC_80M_MASK);
 	rtw89_write32(rtwdev, reg, val);
 
-	if (chip_id == RTL8852A || chip_id == RTL8852B) {
+	if (chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev)) {
 		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PTCL_RRSR1, mac_idx);
 		rtw89_write32_mask(rtwdev, reg, B_AX_RRSR_RATE_EN_MASK, RRSR_OFDM_CCK_EN);
 	}
@@ -2766,11 +2771,10 @@ static int ptcl_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 
 static int cmac_dma_init_ax(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
-	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	u32 reg;
 	int ret;
 
-	if (chip_id != RTL8852B)
+	if (!rtw89_is_rtl885xb(rtwdev))
 		return 0;
 
 	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
@@ -3587,13 +3591,11 @@ static int enable_imr_ax(struct rtw89_dev *rtwdev, u8 mac_idx,
 
 static void err_imr_ctrl_ax(struct rtw89_dev *rtwdev, bool en)
 {
-	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
-
 	rtw89_write32(rtwdev, R_AX_DMAC_ERR_IMR,
 		      en ? DMAC_ERR_IMR_EN : DMAC_ERR_IMR_DIS);
 	rtw89_write32(rtwdev, R_AX_CMAC_ERR_IMR,
 		      en ? CMAC0_ERR_IMR_EN : CMAC0_ERR_IMR_DIS);
-	if (chip_id != RTL8852B && rtwdev->mac.dle_info.c1_rx_qta)
+	if (!rtw89_is_rtl885xb(rtwdev) && rtwdev->mac.dle_info.c1_rx_qta)
 		rtw89_write32(rtwdev, R_AX_CMAC_ERR_IMR_C1,
 			      en ? CMAC1_ERR_IMR_EN : CMAC1_ERR_IMR_DIS);
 }
@@ -3719,10 +3721,9 @@ static int rtw89_mac_feat_init(struct rtw89_dev *rtwdev)
 
 static void rtw89_disable_fw_watchdog(struct rtw89_dev *rtwdev)
 {
-	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	u32 val32;
 
-	if (chip_id == RTL8852B || chip_id == RTL8851B) {
+	if (rtw89_is_rtl885xb(rtwdev)) {
 		rtw89_write32_clr(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_APB_WRAP_EN);
 		rtw89_write32_set(rtwdev, R_AX_PLATFORM_ENABLE, B_AX_APB_WRAP_EN);
 		return;
@@ -3818,7 +3819,7 @@ static void rtw89_mac_dmac_func_pre_en_ax(struct rtw89_dev *rtwdev)
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	u32 val;
 
-	if (chip_id == RTL8851B)
+	if (chip_id == RTL8851B || chip_id == RTL8852BT)
 		val = B_AX_DISPATCHER_CLK_EN | B_AX_AXIDMA_CLK_EN;
 	else
 		val = B_AX_DISPATCHER_CLK_EN;
@@ -5463,18 +5464,19 @@ void rtw89_mac_flush_txq(struct rtw89_dev *rtwdev, u32 queues, bool drop)
 
 int rtw89_mac_coex_init(struct rtw89_dev *rtwdev, const struct rtw89_mac_ax_coex *coex)
 {
+	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	u8 val;
 	u16 val16;
 	u32 val32;
 	int ret;
 
 	rtw89_write8_set(rtwdev, R_AX_GPIO_MUXCFG, B_AX_ENBT);
-	if (rtwdev->chip->chip_id != RTL8851B)
+	if (chip_id != RTL8851B && chip_id != RTL8852BT)
 		rtw89_write8_set(rtwdev, R_AX_BTC_FUNC_EN, B_AX_PTA_WL_TX_EN);
 	rtw89_write8_set(rtwdev, R_AX_BT_COEX_CFG_2 + 1, B_AX_GNT_BT_POLARITY >> 8);
 	rtw89_write8_set(rtwdev, R_AX_CSR_MODE, B_AX_STATIS_BT_EN | B_AX_WL_ACT_MSK);
 	rtw89_write8_set(rtwdev, R_AX_CSR_MODE + 2, B_AX_BT_CNT_RST >> 16);
-	if (rtwdev->chip->chip_id != RTL8851B)
+	if (chip_id != RTL8851B && chip_id != RTL8852BT)
 		rtw89_write8_clr(rtwdev, R_AX_TRXPTCL_RESP_0 + 3, B_AX_RSP_CHK_BTCCA >> 24);
 
 	val16 = rtw89_read16(rtwdev, R_AX_CCA_CFG_0);
@@ -5757,8 +5759,7 @@ bool rtw89_mac_get_ctrl_path(struct rtw89_dev *rtwdev)
 
 	if (chip->chip_id == RTL8852C || chip->chip_id == RTL8922A)
 		return false;
-	else if (chip->chip_id == RTL8852A || chip->chip_id == RTL8852B ||
-		 chip->chip_id == RTL8851B)
+	else if (chip->chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev))
 		val = rtw89_read8_mask(rtwdev, R_AX_SYS_SDIO_CTRL + 3,
 				       B_AX_LTE_MUX_CTRL_PATH >> 24);
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index dbbb2f6500e2..d22d9676ab5a 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -2039,7 +2039,7 @@ static int rtw89_pci_write_config_byte(struct rtw89_dev *rtwdev, u16 addr,
 	if (!ret)
 		return 0;
 
-	if (chip_id == RTL8852A || chip_id == RTL8852B || chip_id == RTL8851B)
+	if (chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev))
 		ret = rtw89_dbi_write8(rtwdev, addr, data);
 
 	return ret;
@@ -2057,7 +2057,7 @@ static int rtw89_pci_read_config_byte(struct rtw89_dev *rtwdev, u16 addr,
 	if (!ret)
 		return 0;
 
-	if (chip_id == RTL8852A || chip_id == RTL8852B || chip_id == RTL8851B)
+	if (chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev))
 		ret = rtw89_dbi_read8(rtwdev, addr, value);
 
 	return ret;
@@ -2137,10 +2137,9 @@ __get_target(struct rtw89_dev *rtwdev, u16 *target, enum rtw89_pcie_phy phy_rate
 
 static int rtw89_pci_autok_x(struct rtw89_dev *rtwdev)
 {
-	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	int ret;
 
-	if (chip_id != RTL8852B && chip_id != RTL8851B)
+	if (!rtw89_is_rtl885xb(rtwdev))
 		return 0;
 
 	ret = rtw89_write16_mdio_mask(rtwdev, RAC_REG_FLD_0, BAC_AUTOK_N_MASK,
@@ -2150,14 +2149,13 @@ static int rtw89_pci_autok_x(struct rtw89_dev *rtwdev)
 
 static int rtw89_pci_auto_refclk_cal(struct rtw89_dev *rtwdev, bool autook_en)
 {
-	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	enum rtw89_pcie_phy phy_rate;
 	u16 val16, mgn_set, div_set, tar;
 	u8 val8, bdr_ori;
 	bool l1_flag = false;
 	int ret = 0;
 
-	if (chip_id != RTL8852B && chip_id != RTL8851B)
+	if (!rtw89_is_rtl885xb(rtwdev))
 		return 0;
 
 	ret = rtw89_pci_read_config_byte(rtwdev, RTW89_PCIE_PHY_RATE, &val8);
@@ -2398,7 +2396,7 @@ static void rtw89_pci_l1off_pwroff(struct rtw89_dev *rtwdev)
 {
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 
-	if (chip_id != RTL8852A && chip_id != RTL8852B && chip_id != RTL8851B)
+	if (chip_id != RTL8852A && !rtw89_is_rtl885xb(rtwdev))
 		return;
 
 	rtw89_write32_clr(rtwdev, R_AX_PCIE_PS_CTRL, B_AX_L1OFF_PWR_OFF_EN);
@@ -2428,7 +2426,7 @@ static void rtw89_pci_aphy_pwrcut(struct rtw89_dev *rtwdev)
 {
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 
-	if (chip_id != RTL8852A && chip_id != RTL8852B && chip_id != RTL8851B)
+	if (chip_id != RTL8852A && !rtw89_is_rtl885xb(rtwdev))
 		return;
 
 	rtw89_write32_clr(rtwdev, R_AX_SYS_PW_CTRL, B_AX_PSUS_OFF_CAPC_EN);
@@ -2438,7 +2436,7 @@ static void rtw89_pci_hci_ldo(struct rtw89_dev *rtwdev)
 {
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 
-	if (chip_id == RTL8852A || chip_id == RTL8852B || chip_id == RTL8851B) {
+	if (chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev)) {
 		rtw89_write32_set(rtwdev, R_AX_SYS_SDIO_CTRL,
 				  B_AX_PCIE_DIS_L2_CTRL_LDO_HCI);
 		rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL,
@@ -2451,9 +2449,7 @@ static void rtw89_pci_hci_ldo(struct rtw89_dev *rtwdev)
 
 static int rtw89_pci_dphy_delay(struct rtw89_dev *rtwdev)
 {
-	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
-
-	if (chip_id != RTL8852B && chip_id != RTL8851B)
+	if (!rtw89_is_rtl885xb(rtwdev))
 		return 0;
 
 	return rtw89_write16_mdio_mask(rtwdev, RAC_REG_REV2, BAC_CMU_EN_DLY_MASK,
@@ -2715,7 +2711,7 @@ static int rtw89_pci_mode_op(struct rtw89_dev *rtwdev)
 					   B_AX_PCIE_RX_APPLEN_MASK, 0);
 	}
 
-	if (chip_id == RTL8852A || chip_id == RTL8852B) {
+	if (chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev)) {
 		rtw89_write32_mask(rtwdev, R_AX_PCIE_INIT_CFG1, B_AX_PCIE_MAX_TXDMA_MASK, tx_burst);
 		rtw89_write32_mask(rtwdev, R_AX_PCIE_INIT_CFG1, B_AX_PCIE_MAX_RXDMA_MASK, rx_burst);
 	} else if (chip_id == RTL8852C) {
@@ -2723,7 +2719,7 @@ static int rtw89_pci_mode_op(struct rtw89_dev *rtwdev)
 		rtw89_write32_mask(rtwdev, R_AX_HAXI_INIT_CFG1, B_AX_HAXI_MAX_RXDMA_MASK, rx_burst);
 	}
 
-	if (chip_id == RTL8852A || chip_id == RTL8852B) {
+	if (chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev)) {
 		if (tag_mode == MAC_AX_TAG_SGL) {
 			val32 = rtw89_read32(rtwdev, R_AX_PCIE_INIT_CFG1) &
 					    ~B_AX_LATENCY_CONTROL;
@@ -2738,7 +2734,7 @@ static int rtw89_pci_mode_op(struct rtw89_dev *rtwdev)
 	rtw89_write32_mask(rtwdev, info->exp_ctrl_reg, info->max_tag_num_mask,
 			   info->multi_tag_num);
 
-	if (chip_id == RTL8852A || chip_id == RTL8852B) {
+	if (chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev)) {
 		rtw89_write32_mask(rtwdev, R_AX_PCIE_INIT_CFG2, B_AX_WD_ITVL_IDLE,
 				   wd_dma_idle_intvl);
 		rtw89_write32_mask(rtwdev, R_AX_PCIE_INIT_CFG2, B_AX_WD_ITVL_ACT,
@@ -2951,7 +2947,7 @@ static int rtw89_pci_ops_mac_post_init_ax(struct rtw89_dev *rtwdev)
 		/* ltr sw trigger */
 		rtw89_write32_set(rtwdev, R_AX_LTR_CTRL_0, B_AX_APP_LTR_ACT);
 	}
-	if (chip_id == RTL8852A || chip_id == RTL8852B) {
+	if (chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev)) {
 		/* ADDR info 8-byte mode */
 		rtw89_write32_set(rtwdev, R_AX_TX_ADDRESS_INFO_MODE_SETTING,
 				  B_AX_HOST_ADDR_INFO_8B_SEL);
@@ -3760,7 +3756,7 @@ static void rtw89_pci_clkreq_set_ax(struct rtw89_dev *rtwdev, bool enable)
 	if (ret)
 		rtw89_err(rtwdev, "failed to set CLKREQ Delay\n");
 
-	if (chip_id == RTL8852A || chip_id == RTL8852B || chip_id == RTL8851B) {
+	if (chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev)) {
 		if (enable)
 			ret = rtw89_pci_config_byte_set(rtwdev,
 							RTW89_PCIE_L1_CTRL,
@@ -3812,7 +3808,7 @@ static void rtw89_pci_aspm_set_ax(struct rtw89_dev *rtwdev, bool enable)
 	if (ret)
 		rtw89_warn(rtwdev, "failed to read ASPM Delay\n");
 
-	if (chip_id == RTL8852A || chip_id == RTL8852B || chip_id == RTL8851B) {
+	if (chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev)) {
 		if (enable)
 			ret = rtw89_pci_config_byte_set(rtwdev,
 							RTW89_PCIE_L1_CTRL,
@@ -3911,7 +3907,7 @@ static void rtw89_pci_l1ss_set_ax(struct rtw89_dev *rtwdev, bool enable)
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	int ret;
 
-	if (chip_id == RTL8852A || chip_id == RTL8852B || chip_id == RTL8851B) {
+	if (chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev)) {
 		if (enable)
 			ret = rtw89_pci_config_byte_set(rtwdev,
 							RTW89_PCIE_TIMER_CTRL,
@@ -4108,7 +4104,7 @@ static int __maybe_unused rtw89_pci_suspend(struct device *dev)
 	rtw89_write32_set(rtwdev, R_AX_RSV_CTRL, B_AX_WLOCK_1C_BIT6);
 	rtw89_write32_set(rtwdev, R_AX_RSV_CTRL, B_AX_R_DIS_PRST);
 	rtw89_write32_clr(rtwdev, R_AX_RSV_CTRL, B_AX_WLOCK_1C_BIT6);
-	if (chip_id == RTL8852A || chip_id == RTL8852B || chip_id == RTL8851B) {
+	if (chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev)) {
 		rtw89_write32_clr(rtwdev, R_AX_SYS_SDIO_CTRL,
 				  B_AX_PCIE_DIS_L2_CTRL_LDO_HCI);
 		rtw89_write32_set(rtwdev, R_AX_PCIE_INIT_CFG1,
@@ -4142,7 +4138,7 @@ static int __maybe_unused rtw89_pci_resume(struct device *dev)
 	rtw89_write32_set(rtwdev, R_AX_RSV_CTRL, B_AX_WLOCK_1C_BIT6);
 	rtw89_write32_clr(rtwdev, R_AX_RSV_CTRL, B_AX_R_DIS_PRST);
 	rtw89_write32_clr(rtwdev, R_AX_RSV_CTRL, B_AX_WLOCK_1C_BIT6);
-	if (chip_id == RTL8852A || chip_id == RTL8852B || chip_id == RTL8851B) {
+	if (chip_id == RTL8852A || rtw89_is_rtl885xb(rtwdev)) {
 		rtw89_write32_set(rtwdev, R_AX_SYS_SDIO_CTRL,
 				  B_AX_PCIE_DIS_L2_CTRL_LDO_HCI);
 		rtw89_write32_clr(rtwdev, R_AX_PCIE_INIT_CFG1,
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index a82b4c56a6f4..60f20e596321 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -1676,7 +1676,7 @@ static void rtw89_phy_preinit_rf_nctl_ax(struct rtw89_dev *rtwdev)
 	rtw89_phy_write32_set(rtwdev, R_P0_PATH_RST, 0x8000000);
 	if (chip->chip_id != RTL8851B)
 		rtw89_phy_write32_set(rtwdev, R_P1_PATH_RST, 0x8000000);
-	if (chip->chip_id == RTL8852B)
+	if (chip->chip_id == RTL8852B || chip->chip_id == RTL8852BT)
 		rtw89_phy_write32_set(rtwdev, R_IOQ_IQK_DPK, 0x2);
 
 	/* check 0x8080 */
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index dc78ffc39ae7..5a59234301ca 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3169,6 +3169,8 @@
 #define R_AX_DLK_PROTECT_CTL_C1 0xEE02
 #define B_AX_RX_DLK_CCA_TIME_MASK GENMASK(15, 8)
 #define B_AX_RX_DLK_DATA_TIME_MASK GENMASK(7, 4)
+#define B_AX_RX_DLK_RST_EN BIT(1)
+#define B_AX_RX_DLK_INT_EN BIT(0)
 
 #define R_AX_PLCP_HDR_FLTR 0xCE04
 #define R_AX_PLCP_HDR_FLTR_C1 0xEE04
-- 
2.25.1


