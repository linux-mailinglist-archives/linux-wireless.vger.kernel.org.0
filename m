Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E50784169
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 14:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235933AbjHVM72 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 08:59:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235929AbjHVM71 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 08:59:27 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 779C5CD4
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 05:59:22 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37MCwotZ7022538, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37MCwotZ7022538
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Aug 2023 20:58:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Tue, 22 Aug 2023 20:59:12 +0800
Received: from [127.0.1.1] (172.16.23.216) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 22 Aug
 2023 20:59:11 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <cj.hsieh@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/6] wifi: rtw89: mac: add mac_gen_def::band1_offset to map MAC band1 register address
Date:   Tue, 22 Aug 2023 20:58:17 +0800
Message-ID: <20230822125822.23817-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230822125822.23817-1-pkshih@realtek.com>
References: <20230822125822.23817-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.23.216]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

There are two copies of MAC hardware called band0 and band1. Basically,
the only difference between them is base address, so we can share functions
with a 'band' (or 'mac_idx') argument.

The offset of base address of WiFi 6 and 7 are 0x2000 and 0x4000
respectively, so add band1_offset field to new introduced struct
mac_gen_def to possibly reuse functions.

Using below spatch script to convert callers:

  @@
  expression reg, band;
  @@
  - rtw89_mac_reg_by_idx(reg, band)
  + rtw89_mac_reg_by_idx(rtwdev, reg, band)

  @@
  expression reg, port, band;
  @@
  - rtw89_mac_reg_by_port(reg, port, band)
  + rtw89_mac_reg_by_port(rtwdev, reg, port, band)

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/core.c     |   4 +-
 drivers/net/wireless/realtek/rtw89/core.h     |   2 +
 drivers/net/wireless/realtek/rtw89/fw.c       |   4 +-
 drivers/net/wireless/realtek/rtw89/mac.c      | 171 +++++++++---------
 drivers/net/wireless/realtek/rtw89/mac.h      |  36 ++--
 drivers/net/wireless/realtek/rtw89/mac80211.c |   6 +-
 drivers/net/wireless/realtek/rtw89/mac_be.c   |  10 +
 drivers/net/wireless/realtek/rtw89/phy.c      |   6 +-
 drivers/net/wireless/realtek/rtw89/rtw8851b.c |  13 +-
 drivers/net/wireless/realtek/rtw89/rtw8852a.c |  14 +-
 drivers/net/wireless/realtek/rtw89/rtw8852b.c |  13 +-
 drivers/net/wireless/realtek/rtw89/rtw8852c.c |  19 +-
 12 files changed, 165 insertions(+), 133 deletions(-)
 create mode 100644 drivers/net/wireless/realtek/rtw89/mac_be.c

diff --git a/drivers/net/wireless/realtek/rtw89/core.c b/drivers/net/wireless/realtek/rtw89/core.c
index 71eb9cfd4896..2f6db0658a73 100644
--- a/drivers/net/wireless/realtek/rtw89/core.c
+++ b/drivers/net/wireless/realtek/rtw89/core.c
@@ -2478,7 +2478,7 @@ void rtw89_roc_start(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_config_roc_chandef(rtwdev, rtwvif->sub_entity_idx, &roc_chan);
 	rtw89_set_channel(rtwdev);
 	rtw89_write32_clr(rtwdev,
-			  rtw89_mac_reg_by_idx(R_AX_RX_FLTR_OPT, RTW89_MAC_0),
+			  rtw89_mac_reg_by_idx(rtwdev, R_AX_RX_FLTR_OPT, RTW89_MAC_0),
 			  B_AX_A_UC_CAM_MATCH | B_AX_A_BC_CAM_MATCH);
 
 	ieee80211_ready_on_channel(hw);
@@ -2499,7 +2499,7 @@ void rtw89_roc_end(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif)
 	rtw89_leave_lps(rtwdev);
 
 	rtw89_write32_mask(rtwdev,
-			   rtw89_mac_reg_by_idx(R_AX_RX_FLTR_OPT, RTW89_MAC_0),
+			   rtw89_mac_reg_by_idx(rtwdev, R_AX_RX_FLTR_OPT, RTW89_MAC_0),
 			   B_AX_RX_FLTR_CFG_MASK,
 			   rtwdev->hal.rx_fltr);
 
diff --git a/drivers/net/wireless/realtek/rtw89/core.h b/drivers/net/wireless/realtek/rtw89/core.h
index b5a08f90f5bd..98e6d6ade6c0 100644
--- a/drivers/net/wireless/realtek/rtw89/core.h
+++ b/drivers/net/wireless/realtek/rtw89/core.h
@@ -14,6 +14,7 @@
 
 struct rtw89_dev;
 struct rtw89_pci_info;
+struct rtw89_mac_gen_def;
 
 extern const struct ieee80211_ops rtw89_ops;
 
@@ -3379,6 +3380,7 @@ struct rtw89_chip_info {
 	enum rtw89_core_chip_id chip_id;
 	enum rtw89_chip_gen chip_gen;
 	const struct rtw89_chip_ops *ops;
+	const struct rtw89_mac_gen_def *mac_def;
 	const char *fw_basename;
 	u8 fw_format_max;
 	bool try_ce_fw;
diff --git a/drivers/net/wireless/realtek/rtw89/fw.c b/drivers/net/wireless/realtek/rtw89/fw.c
index bcd9050f989f..c8b47b6fbafa 100644
--- a/drivers/net/wireless/realtek/rtw89/fw.c
+++ b/drivers/net/wireless/realtek/rtw89/fw.c
@@ -3873,7 +3873,7 @@ void rtw89_hw_scan_start(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 	rx_fltr &= ~B_AX_A_BC;
 	rx_fltr &= ~B_AX_A_A1_MATCH;
 	rtw89_write32_mask(rtwdev,
-			   rtw89_mac_reg_by_idx(R_AX_RX_FLTR_OPT, RTW89_MAC_0),
+			   rtw89_mac_reg_by_idx(rtwdev, R_AX_RX_FLTR_OPT, RTW89_MAC_0),
 			   B_AX_RX_FLTR_CFG_MASK,
 			   rx_fltr);
 }
@@ -3891,7 +3891,7 @@ void rtw89_hw_scan_complete(struct rtw89_dev *rtwdev, struct ieee80211_vif *vif,
 		return;
 
 	rtw89_write32_mask(rtwdev,
-			   rtw89_mac_reg_by_idx(R_AX_RX_FLTR_OPT, RTW89_MAC_0),
+			   rtw89_mac_reg_by_idx(rtwdev, R_AX_RX_FLTR_OPT, RTW89_MAC_0),
 			   B_AX_RX_FLTR_CFG_MASK,
 			   rtwdev->hal.rx_fltr);
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
index cebefa3b1db3..edfa1a2e677a 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.c
+++ b/drivers/net/wireless/realtek/rtw89/mac.c
@@ -2082,7 +2082,7 @@ static int addr_cam_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (ret)
 		return ret;
 
-	reg = rtw89_mac_reg_by_idx(R_AX_ADDR_CAM_CTRL, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_ADDR_CAM_CTRL, mac_idx);
 
 	val = rtw89_read32(rtwdev, reg);
 	val |= u32_encode_bits(0x7f, B_AX_ADDR_CAM_RANGE_MASK) |
@@ -2109,7 +2109,7 @@ static int scheduler_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (ret)
 		return ret;
 
-	reg = rtw89_mac_reg_by_idx(R_AX_PREBKF_CFG_1, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PREBKF_CFG_1, mac_idx);
 	if (rtwdev->chip->chip_id == RTL8852C)
 		rtw89_write32_mask(rtwdev, reg, B_AX_SIFS_MACTXEN_T1_MASK,
 				   SIFS_MACTXEN_T1_V1);
@@ -2118,14 +2118,14 @@ static int scheduler_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 				   SIFS_MACTXEN_T1);
 
 	if (rtwdev->chip->chip_id == RTL8852B || rtwdev->chip->chip_id == RTL8851B) {
-		reg = rtw89_mac_reg_by_idx(R_AX_SCH_EXT_CTRL, mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_SCH_EXT_CTRL, mac_idx);
 		rtw89_write32_set(rtwdev, reg, B_AX_PORT_RST_TSF_ADV);
 	}
 
-	reg = rtw89_mac_reg_by_idx(R_AX_CCA_CFG_0, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_CCA_CFG_0, mac_idx);
 	rtw89_write32_clr(rtwdev, reg, B_AX_BTCCA_EN);
 
-	reg = rtw89_mac_reg_by_idx(R_AX_PREBKF_CFG_0, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PREBKF_CFG_0, mac_idx);
 	if (rtwdev->chip->chip_id == RTL8852C) {
 		val = rtw89_read32_mask(rtwdev, R_AX_SEC_ENG_CTRL,
 					B_AX_TX_PARTIAL_MODE);
@@ -2165,13 +2165,13 @@ int rtw89_mac_typ_fltr_opt(struct rtw89_dev *rtwdev,
 
 	switch (type) {
 	case RTW89_MGNT:
-		reg = rtw89_mac_reg_by_idx(R_AX_MGNT_FLTR, mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_MGNT_FLTR, mac_idx);
 		break;
 	case RTW89_CTRL:
-		reg = rtw89_mac_reg_by_idx(R_AX_CTRL_FLTR, mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_CTRL_FLTR, mac_idx);
 		break;
 	case RTW89_DATA:
-		reg = rtw89_mac_reg_by_idx(R_AX_DATA_FLTR, mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_DATA_FLTR, mac_idx);
 		break;
 	default:
 		rtw89_err(rtwdev, "[ERR]set rx filter type err\n");
@@ -2202,9 +2202,9 @@ static int rx_fltr_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 		    B_AX_LSIG_PARITY_CHK_EN | B_AX_SIGA_CRC_CHK |
 		    B_AX_VHT_SU_SIGB_CRC_CHK | B_AX_VHT_MU_SIGB_CRC_CHK |
 		    B_AX_HE_SIGB_CRC_CHK;
-	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(R_AX_RX_FLTR_OPT, mac_idx),
+	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(rtwdev, R_AX_RX_FLTR_OPT, mac_idx),
 		      mac_ftlr);
-	rtw89_write16(rtwdev, rtw89_mac_reg_by_idx(R_AX_PLCP_HDR_FLTR, mac_idx),
+	rtw89_write16(rtwdev, rtw89_mac_reg_by_idx(rtwdev, R_AX_PLCP_HDR_FLTR, mac_idx),
 		      plcp_ftlr);
 
 	return 0;
@@ -2224,20 +2224,20 @@ static void _patch_dis_resp_chk(struct rtw89_dev *rtwdev, u8 mac_idx)
 	switch (rtwdev->chip->chip_id) {
 	case RTL8852A:
 	case RTL8852B:
-		reg = rtw89_mac_reg_by_idx(R_AX_RSP_CHK_SIG, mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_RSP_CHK_SIG, mac_idx);
 		val32 = rtw89_read32(rtwdev, reg) & ~b_rsp_chk_nav;
 		rtw89_write32(rtwdev, reg, val32);
 
-		reg = rtw89_mac_reg_by_idx(R_AX_TRXPTCL_RESP_0, mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_TRXPTCL_RESP_0, mac_idx);
 		val32 = rtw89_read32(rtwdev, reg) & ~b_rsp_chk_cca;
 		rtw89_write32(rtwdev, reg, val32);
 		break;
 	default:
-		reg = rtw89_mac_reg_by_idx(R_AX_RSP_CHK_SIG, mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_RSP_CHK_SIG, mac_idx);
 		val32 = rtw89_read32(rtwdev, reg) | b_rsp_chk_nav;
 		rtw89_write32(rtwdev, reg, val32);
 
-		reg = rtw89_mac_reg_by_idx(R_AX_TRXPTCL_RESP_0, mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_TRXPTCL_RESP_0, mac_idx);
 		val32 = rtw89_read32(rtwdev, reg) | b_rsp_chk_cca;
 		rtw89_write32(rtwdev, reg, val32);
 		break;
@@ -2253,7 +2253,7 @@ static int cca_ctrl_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (ret)
 		return ret;
 
-	reg = rtw89_mac_reg_by_idx(R_AX_CCA_CONTROL, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_CCA_CONTROL, mac_idx);
 	val = rtw89_read32(rtwdev, reg);
 	val |= (B_AX_TB_CHK_BASIC_NAV | B_AX_TB_CHK_BTCCA |
 		B_AX_TB_CHK_EDCCA | B_AX_TB_CHK_CCA_P20 |
@@ -2294,7 +2294,7 @@ static int spatial_reuse_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
 	if (ret)
 		return ret;
-	reg = rtw89_mac_reg_by_idx(R_AX_RX_SR_CTRL, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_RX_SR_CTRL, mac_idx);
 	rtw89_write8_clr(rtwdev, reg, B_AX_SR_EN);
 
 	return 0;
@@ -2309,13 +2309,13 @@ static int tmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (ret)
 		return ret;
 
-	reg = rtw89_mac_reg_by_idx(R_AX_MAC_LOOPBACK, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_MAC_LOOPBACK, mac_idx);
 	rtw89_write32_clr(rtwdev, reg, B_AX_MACLBK_EN);
 
-	reg = rtw89_mac_reg_by_idx(R_AX_TCR0, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_TCR0, mac_idx);
 	rtw89_write32_mask(rtwdev, reg, B_AX_TCR_UDF_THSD_MASK, TCR_UDF_THSD);
 
-	reg = rtw89_mac_reg_by_idx(R_AX_TXD_FIFO_CTRL, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_TXD_FIFO_CTRL, mac_idx);
 	rtw89_write32_mask(rtwdev, reg, B_AX_TXDFIFO_HIGH_MCS_THRE_MASK, TXDFIFO_HIGH_MCS_THRE);
 	rtw89_write32_mask(rtwdev, reg, B_AX_TXDFIFO_LOW_MCS_THRE_MASK, TXDFIFO_LOW_MCS_THRE);
 
@@ -2333,7 +2333,7 @@ static int trxptcl_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (ret)
 		return ret;
 
-	reg = rtw89_mac_reg_by_idx(R_AX_TRXPTCL_RESP_0, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_TRXPTCL_RESP_0, mac_idx);
 	val = rtw89_read32(rtwdev, reg);
 	val &= ~B_AX_WMAC_SPEC_SIFS_CCK_MASK;
 	val |= FIELD_PREP(B_AX_WMAC_SPEC_SIFS_CCK_MASK, WMAC_SPEC_SIFS_CCK);
@@ -2353,12 +2353,12 @@ static int trxptcl_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	val |= FIELD_PREP(B_AX_WMAC_SPEC_SIFS_OFDM_MASK, sifs);
 	rtw89_write32(rtwdev, reg, val);
 
-	reg = rtw89_mac_reg_by_idx(R_AX_RXTRIG_TEST_USER_2, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_RXTRIG_TEST_USER_2, mac_idx);
 	rtw89_write32_set(rtwdev, reg, B_AX_RXTRIG_FCSCHK_EN);
 
-	reg = rtw89_mac_reg_by_idx(rrsr->ref_rate.addr, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, rrsr->ref_rate.addr, mac_idx);
 	rtw89_write32_mask(rtwdev, reg, rrsr->ref_rate.mask, rrsr->ref_rate.data);
-	reg = rtw89_mac_reg_by_idx(rrsr->rsc.addr, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, rrsr->rsc.addr, mac_idx);
 	rtw89_write32_mask(rtwdev, reg, rrsr->rsc.mask, rrsr->rsc.data);
 
 	return 0;
@@ -2397,10 +2397,10 @@ static int rmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (mac_idx == RTW89_MAC_0)
 		rst_bacam(rtwdev);
 
-	reg = rtw89_mac_reg_by_idx(R_AX_RESPBA_CAM_CTRL, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_RESPBA_CAM_CTRL, mac_idx);
 	rtw89_write8_set(rtwdev, reg, B_AX_SSN_SEL);
 
-	reg = rtw89_mac_reg_by_idx(R_AX_DLK_PROTECT_CTL, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_DLK_PROTECT_CTL, mac_idx);
 	val = rtw89_read16(rtwdev, reg);
 	val = u16_replace_bits(val, TRXCFG_RMAC_DATA_TO,
 			       B_AX_RX_DLK_DATA_TIME_MASK);
@@ -2408,10 +2408,10 @@ static int rmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 			       B_AX_RX_DLK_CCA_TIME_MASK);
 	rtw89_write16(rtwdev, reg, val);
 
-	reg = rtw89_mac_reg_by_idx(R_AX_RCR, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_RCR, mac_idx);
 	rtw89_write8_mask(rtwdev, reg, B_AX_CH_EN_MASK, 0x1);
 
-	reg = rtw89_mac_reg_by_idx(R_AX_RX_FLTR_OPT, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_RX_FLTR_OPT, mac_idx);
 	if (mac_idx == RTW89_MAC_0)
 		rx_qta = rtwdev->mac.dle_info.c0_rx_qta;
 	else
@@ -2425,13 +2425,13 @@ static int rmac_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (rtwdev->chip->chip_id == RTL8852A &&
 	    rtwdev->hal.cv == CHIP_CBV) {
 		rtw89_write16_mask(rtwdev,
-				   rtw89_mac_reg_by_idx(R_AX_DLK_PROTECT_CTL, mac_idx),
+				   rtw89_mac_reg_by_idx(rtwdev, R_AX_DLK_PROTECT_CTL, mac_idx),
 				   B_AX_RX_DLK_CCA_TIME_MASK, 0);
-		rtw89_write16_set(rtwdev, rtw89_mac_reg_by_idx(R_AX_RCR, mac_idx),
+		rtw89_write16_set(rtwdev, rtw89_mac_reg_by_idx(rtwdev, R_AX_RCR, mac_idx),
 				  BIT(12));
 	}
 
-	reg = rtw89_mac_reg_by_idx(R_AX_PLCP_HDR_FLTR, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PLCP_HDR_FLTR, mac_idx);
 	rtw89_write8_clr(rtwdev, reg, B_AX_VHT_SU_SIGB_CRC_CHK);
 
 	return ret;
@@ -2447,7 +2447,7 @@ static int cmac_com_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (ret)
 		return ret;
 
-	reg = rtw89_mac_reg_by_idx(R_AX_TX_SUB_CARRIER_VALUE, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_TX_SUB_CARRIER_VALUE, mac_idx);
 	val = rtw89_read32(rtwdev, reg);
 	val = u32_replace_bits(val, 0, B_AX_TXSC_20M_MASK);
 	val = u32_replace_bits(val, 0, B_AX_TXSC_40M_MASK);
@@ -2455,7 +2455,7 @@ static int cmac_com_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	rtw89_write32(rtwdev, reg, val);
 
 	if (chip_id == RTL8852A || chip_id == RTL8852B) {
-		reg = rtw89_mac_reg_by_idx(R_AX_PTCL_RRSR1, mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PTCL_RRSR1, mac_idx);
 		rtw89_write32_mask(rtwdev, reg, B_AX_RRSR_RATE_EN_MASK, RRSR_OFDM_CCK_EN);
 	}
 
@@ -2485,7 +2485,7 @@ static int ptcl_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 		return ret;
 
 	if (rtwdev->hci.type == RTW89_HCI_TYPE_PCIE) {
-		reg = rtw89_mac_reg_by_idx(R_AX_SIFS_SETTING, mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_SIFS_SETTING, mac_idx);
 		val = rtw89_read32(rtwdev, reg);
 		val = u32_replace_bits(val, S_AX_CTS2S_TH_1K,
 				       B_AX_HW_CTS2SELF_PKT_LEN_TH_MASK);
@@ -2494,7 +2494,7 @@ static int ptcl_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 		val |= B_AX_HW_CTS2SELF_EN;
 		rtw89_write32(rtwdev, reg, val);
 
-		reg = rtw89_mac_reg_by_idx(R_AX_PTCL_FSM_MON, mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PTCL_FSM_MON, mac_idx);
 		val = rtw89_read32(rtwdev, reg);
 		val = u32_replace_bits(val, S_AX_PTCL_TO_2MS, B_AX_PTCL_TX_ARB_TO_THR_MASK);
 		val &= ~B_AX_PTCL_TX_ARB_TO_MODE;
@@ -2531,7 +2531,7 @@ static int cmac_dma_init(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (ret)
 		return ret;
 
-	reg = rtw89_mac_reg_by_idx(R_AX_RXDMA_CTRL_0, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_RXDMA_CTRL_0, mac_idx);
 	rtw89_write8_clr(rtwdev, reg, RX_FULL_MODE);
 
 	return 0;
@@ -2725,7 +2725,7 @@ static int rtw89_hw_sch_tx_en_h2c(struct rtw89_dev *rtwdev, u8 band,
 static int rtw89_set_hw_sch_tx_en(struct rtw89_dev *rtwdev, u8 mac_idx,
 				  u16 tx_en, u16 tx_en_mask)
 {
-	u32 reg = rtw89_mac_reg_by_idx(R_AX_CTN_TXEN, mac_idx);
+	u32 reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_CTN_TXEN, mac_idx);
 	u16 val;
 	int ret;
 
@@ -2747,7 +2747,7 @@ static int rtw89_set_hw_sch_tx_en(struct rtw89_dev *rtwdev, u8 mac_idx,
 static int rtw89_set_hw_sch_tx_en_v1(struct rtw89_dev *rtwdev, u8 mac_idx,
 				     u32 tx_en, u32 tx_en_mask)
 {
-	u32 reg = rtw89_mac_reg_by_idx(R_AX_CTN_DRV_TXEN, mac_idx);
+	u32 reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_CTN_DRV_TXEN, mac_idx);
 	u32 val;
 	int ret;
 
@@ -2768,7 +2768,7 @@ int rtw89_mac_stop_sch_tx(struct rtw89_dev *rtwdev, u8 mac_idx,
 	int ret;
 
 	*tx_en = rtw89_read16(rtwdev,
-			      rtw89_mac_reg_by_idx(R_AX_CTN_TXEN, mac_idx));
+			      rtw89_mac_reg_by_idx(rtwdev, R_AX_CTN_TXEN, mac_idx));
 
 	switch (sel) {
 	case RTW89_SCH_TX_SEL_ALL:
@@ -2809,7 +2809,7 @@ int rtw89_mac_stop_sch_tx_v1(struct rtw89_dev *rtwdev, u8 mac_idx,
 	int ret;
 
 	*tx_en = rtw89_read32(rtwdev,
-			      rtw89_mac_reg_by_idx(R_AX_CTN_DRV_TXEN, mac_idx));
+			      rtw89_mac_reg_by_idx(rtwdev, R_AX_CTN_DRV_TXEN, mac_idx));
 
 	switch (sel) {
 	case RTW89_SCH_TX_SEL_ALL:
@@ -3016,7 +3016,7 @@ static int band_idle_ck_b(struct rtw89_dev *rtwdev, u8 mac_idx)
 	if (ret)
 		return ret;
 
-	reg = rtw89_mac_reg_by_idx(R_AX_PTCL_TX_CTN_SEL, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PTCL_TX_CTN_SEL, mac_idx);
 
 	ret = read_poll_timeout(rtw89_read8, val,
 				(val & B_AX_PTCL_TX_ON_STAT) == 0,
@@ -3224,7 +3224,7 @@ static void rtw89_scheduler_imr_enable(struct rtw89_dev *rtwdev, u8 mac_idx)
 {
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_idx(R_AX_SCHEDULE_ERR_IMR, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_SCHEDULE_ERR_IMR, mac_idx);
 	rtw89_write32_clr(rtwdev, reg, B_AX_SORT_NON_IDLE_ERR_INT_EN |
 				       B_AX_FSM_TIMEOUT_ERR_INT_EN);
 	rtw89_write32_set(rtwdev, reg, B_AX_FSM_TIMEOUT_ERR_INT_EN);
@@ -3235,7 +3235,7 @@ static void rtw89_ptcl_imr_enable(struct rtw89_dev *rtwdev, u8 mac_idx)
 	const struct rtw89_imr_info *imr = rtwdev->chip->imr_info;
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_idx(R_AX_PTCL_IMR0, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PTCL_IMR0, mac_idx);
 	rtw89_write32_clr(rtwdev, reg, imr->ptcl_imr_clr);
 	rtw89_write32_set(rtwdev, reg, imr->ptcl_imr_set);
 }
@@ -3246,12 +3246,12 @@ static void rtw89_cdma_imr_enable(struct rtw89_dev *rtwdev, u8 mac_idx)
 	enum rtw89_core_chip_id chip_id = rtwdev->chip->chip_id;
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_idx(imr->cdma_imr_0_reg, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, imr->cdma_imr_0_reg, mac_idx);
 	rtw89_write32_clr(rtwdev, reg, imr->cdma_imr_0_clr);
 	rtw89_write32_set(rtwdev, reg, imr->cdma_imr_0_set);
 
 	if (chip_id == RTL8852C) {
-		reg = rtw89_mac_reg_by_idx(imr->cdma_imr_1_reg, mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, imr->cdma_imr_1_reg, mac_idx);
 		rtw89_write32_clr(rtwdev, reg, imr->cdma_imr_1_clr);
 		rtw89_write32_set(rtwdev, reg, imr->cdma_imr_1_set);
 	}
@@ -3262,7 +3262,7 @@ static void rtw89_phy_intf_imr_enable(struct rtw89_dev *rtwdev, u8 mac_idx)
 	const struct rtw89_imr_info *imr = rtwdev->chip->imr_info;
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_idx(imr->phy_intf_imr_reg, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, imr->phy_intf_imr_reg, mac_idx);
 	rtw89_write32_clr(rtwdev, reg, imr->phy_intf_imr_clr);
 	rtw89_write32_set(rtwdev, reg, imr->phy_intf_imr_set);
 }
@@ -3272,7 +3272,7 @@ static void rtw89_rmac_imr_enable(struct rtw89_dev *rtwdev, u8 mac_idx)
 	const struct rtw89_imr_info *imr = rtwdev->chip->imr_info;
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_idx(imr->rmac_imr_reg, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, imr->rmac_imr_reg, mac_idx);
 	rtw89_write32_clr(rtwdev, reg, imr->rmac_imr_clr);
 	rtw89_write32_set(rtwdev, reg, imr->rmac_imr_set);
 }
@@ -3282,7 +3282,7 @@ static void rtw89_tmac_imr_enable(struct rtw89_dev *rtwdev, u8 mac_idx)
 	const struct rtw89_imr_info *imr = rtwdev->chip->imr_info;
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_idx(imr->tmac_imr_reg, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, imr->tmac_imr_reg, mac_idx);
 	rtw89_write32_clr(rtwdev, reg, imr->tmac_imr_clr);
 	rtw89_write32_set(rtwdev, reg, imr->tmac_imr_set);
 }
@@ -3860,7 +3860,7 @@ static void rtw89_mac_port_cfg_hiq_win(struct rtw89_dev *rtwdev,
 	u8 port = rtwvif->port;
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_idx(hiq_win_addr[port], rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, hiq_win_addr[port], rtwvif->mac_idx);
 	rtw89_write8(rtwdev, reg, win);
 }
 
@@ -3871,7 +3871,7 @@ static void rtw89_mac_port_cfg_hiq_dtim(struct rtw89_dev *rtwdev,
 	const struct rtw89_port_reg *p = &rtw_port_base;
 	u32 addr;
 
-	addr = rtw89_mac_reg_by_idx(R_AX_MD_TSFT_STMP_CTL, rtwvif->mac_idx);
+	addr = rtw89_mac_reg_by_idx(rtwdev, R_AX_MD_TSFT_STMP_CTL, rtwvif->mac_idx);
 	rtw89_write8_set(rtwdev, addr, B_AX_UPD_HGQMD | B_AX_UPD_TIMIE);
 
 	rtw89_write16_port_mask(rtwdev, rtwvif, p->dtim_ctrl, B_AX_DTIM_NUM_MASK,
@@ -3930,7 +3930,7 @@ static void rtw89_mac_port_cfg_bss_color(struct rtw89_dev *rtwdev,
 
 	bss_color = vif->bss_conf.he_bss_color.color;
 	reg_base = port >= 4 ? R_AX_PTCL_BSS_COLOR_1 : R_AX_PTCL_BSS_COLOR_0;
-	reg = rtw89_mac_reg_by_idx(reg_base, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, reg_base, rtwvif->mac_idx);
 	rtw89_write32_mask(rtwdev, reg, masks[port], bss_color);
 }
 
@@ -3944,7 +3944,7 @@ static void rtw89_mac_port_cfg_mbssid(struct rtw89_dev *rtwdev,
 		return;
 
 	if (port == 0) {
-		reg = rtw89_mac_reg_by_idx(R_AX_MBSSID_CTRL, rtwvif->mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_MBSSID_CTRL, rtwvif->mac_idx);
 		rtw89_write32_clr(rtwdev, reg, B_AX_P0MB_ALL_MASK);
 	}
 }
@@ -3956,7 +3956,7 @@ static void rtw89_mac_port_cfg_hiq_drop(struct rtw89_dev *rtwdev,
 	u32 reg;
 	u32 val;
 
-	reg = rtw89_mac_reg_by_idx(R_AX_MBSSID_DROP_0, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_MBSSID_DROP_0, rtwvif->mac_idx);
 	val = rtw89_read32(rtwdev, reg);
 	val &= ~FIELD_PREP(B_AX_PORT_DROP_4_0_MASK, BIT(port));
 	if (port == 0)
@@ -4014,7 +4014,7 @@ void rtw89_mac_port_tsf_sync(struct rtw89_dev *rtwdev,
 	u32 val, reg;
 
 	val = RTW89_PORT_OFFSET_TU_TO_32US(offset_tu);
-	reg = rtw89_mac_reg_by_idx(R_AX_PORT0_TSF_SYNC + rtwvif->port * 4,
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PORT0_TSF_SYNC + rtwvif->port * 4,
 				   rtwvif->mac_idx);
 
 	rtw89_write32_mask(rtwdev, reg, B_AX_SYNC_PORT_SRC, rtwvif_src->port);
@@ -4204,7 +4204,7 @@ void rtw89_mac_set_he_obss_narrow_bw_ru(struct rtw89_dev *rtwdev,
 			  rtw89_mac_check_he_obss_narrow_bw_ru_iter,
 			  &tolerated);
 
-	reg = rtw89_mac_reg_by_idx(R_AX_RXTRIG_TEST_USER_2, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_RXTRIG_TEST_USER_2, rtwvif->mac_idx);
 	if (tolerated)
 		rtw89_write32_clr(rtwdev, reg, B_AX_RXTRIG_RU26_DIS);
 	else
@@ -4731,7 +4731,7 @@ bool rtw89_mac_get_txpwr_cr(struct rtw89_dev *rtwdev,
 {
 	const struct rtw89_dle_mem *dle_mem = rtwdev->chip->dle_mem;
 	enum rtw89_qta_mode mode = dle_mem->mode;
-	u32 addr = rtw89_mac_reg_by_idx(reg_base, phy_idx);
+	u32 addr = rtw89_mac_reg_by_idx(rtwdev, reg_base, phy_idx);
 
 	if (addr < R_AX_PWR_RATE_CTRL || addr > CMAC1_END_ADDR) {
 		rtw89_err(rtwdev, "[TXPWR] addr=0x%x exceed txpwr cr\n",
@@ -4760,7 +4760,7 @@ EXPORT_SYMBOL(rtw89_mac_get_txpwr_cr);
 
 int rtw89_mac_cfg_ppdu_status(struct rtw89_dev *rtwdev, u8 mac_idx, bool enable)
 {
-	u32 reg = rtw89_mac_reg_by_idx(R_AX_PPDU_STAT, mac_idx);
+	u32 reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PPDU_STAT, mac_idx);
 	int ret;
 
 	ret = rtw89_mac_check_mac_en(rtwdev, mac_idx, RTW89_CMAC_SEL);
@@ -4807,7 +4807,7 @@ void rtw89_mac_update_rts_threshold(struct rtw89_dev *rtwdev, u8 mac_idx)
 	time_th = min_t(u32, time_th >> MAC_AX_TIME_TH_SH, MAC_AX_TIME_TH_MAX);
 	len_th = min_t(u32, len_th >> MAC_AX_LEN_TH_SH, MAC_AX_LEN_TH_MAX);
 
-	reg = rtw89_mac_reg_by_idx(R_AX_AGG_LEN_HT_0, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_AGG_LEN_HT_0, mac_idx);
 	rtw89_write16_mask(rtwdev, reg, B_AX_RTS_TXTIME_TH_MASK, time_th);
 	rtw89_write16_mask(rtwdev, reg, B_AX_RTS_LEN_TH_MASK, len_th);
 }
@@ -5043,7 +5043,7 @@ int rtw89_mac_cfg_plt(struct rtw89_dev *rtwdev, struct rtw89_mac_ax_plt *plt)
 	if (ret)
 		return ret;
 
-	reg = rtw89_mac_reg_by_idx(R_AX_BT_PLT, plt->band);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_BT_PLT, plt->band);
 	val = (plt->tx & RTW89_MAC_AX_PLT_LTE_RX ? B_AX_TX_PLT_GNT_LTE_RX : 0) |
 	      (plt->tx & RTW89_MAC_AX_PLT_GNT_BT_TX ? B_AX_TX_PLT_GNT_BT_TX : 0) |
 	      (plt->tx & RTW89_MAC_AX_PLT_GNT_BT_RX ? B_AX_TX_PLT_GNT_BT_RX : 0) |
@@ -5133,7 +5133,7 @@ u16 rtw89_mac_get_plt_cnt(struct rtw89_dev *rtwdev, u8 band)
 	u32 reg;
 	u16 cnt;
 
-	reg = rtw89_mac_reg_by_idx(R_AX_BT_PLT, band);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_BT_PLT, band);
 	cnt = rtw89_read32_mask(rtwdev, reg, B_AX_BT_PLT_PKT_CNT_MASK);
 	rtw89_write16_set(rtwdev, reg, B_AX_BT_PLT_RST);
 
@@ -5146,7 +5146,7 @@ static void rtw89_mac_bfee_standby_timer(struct rtw89_dev *rtwdev, u8 mac_idx,
 	u32 reg;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BF, "set bfee standby_timer to %d\n", keep);
-	reg = rtw89_mac_reg_by_idx(R_AX_BFMEE_RESP_OPTION, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_BFMEE_RESP_OPTION, mac_idx);
 	if (keep) {
 		set_bit(RTW89_FLAG_BFEE_TIMER_KEEP, rtwdev->flags);
 		rtw89_write32_mask(rtwdev, reg, B_AX_BFMEE_BFRP_RX_STANDBY_TIMER_MASK,
@@ -5165,7 +5165,7 @@ static void rtw89_mac_bfee_ctrl(struct rtw89_dev *rtwdev, u8 mac_idx, bool en)
 		   B_AX_BFMEE_HE_NDPA_EN;
 
 	rtw89_debug(rtwdev, RTW89_DBG_BF, "set bfee ndpa_en to %d\n", en);
-	reg = rtw89_mac_reg_by_idx(R_AX_BFMEE_RESP_OPTION, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_BFMEE_RESP_OPTION, mac_idx);
 	if (en) {
 		set_bit(RTW89_FLAG_BFEE_EN, rtwdev->flags);
 		rtw89_write32_set(rtwdev, reg, mask);
@@ -5187,30 +5187,30 @@ static int rtw89_mac_init_bfee(struct rtw89_dev *rtwdev, u8 mac_idx)
 
 	/* AP mode set tx gid to 63 */
 	/* STA mode set tx gid to 0(default) */
-	reg = rtw89_mac_reg_by_idx(R_AX_BFMER_CTRL_0, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_BFMER_CTRL_0, mac_idx);
 	rtw89_write32_set(rtwdev, reg, B_AX_BFMER_NDP_BFEN);
 
-	reg = rtw89_mac_reg_by_idx(R_AX_TRXPTCL_RESP_CSI_RRSC, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_TRXPTCL_RESP_CSI_RRSC, mac_idx);
 	rtw89_write32(rtwdev, reg, CSI_RRSC_BMAP);
 
-	reg = rtw89_mac_reg_by_idx(R_AX_BFMEE_RESP_OPTION, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_BFMEE_RESP_OPTION, mac_idx);
 	val32 = FIELD_PREP(B_AX_BFMEE_NDP_RX_STANDBY_TIMER_MASK, NDP_RX_STANDBY_TIMER);
 	rtw89_write32(rtwdev, reg, val32);
 	rtw89_mac_bfee_standby_timer(rtwdev, mac_idx, true);
 	rtw89_mac_bfee_ctrl(rtwdev, mac_idx, true);
 
-	reg = rtw89_mac_reg_by_idx(R_AX_TRXPTCL_RESP_CSI_CTRL_0, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_TRXPTCL_RESP_CSI_CTRL_0, mac_idx);
 	rtw89_write32_set(rtwdev, reg, B_AX_BFMEE_BFPARAM_SEL |
 				       B_AX_BFMEE_USE_NSTS |
 				       B_AX_BFMEE_CSI_GID_SEL |
 				       B_AX_BFMEE_CSI_FORCE_RETE_EN);
-	reg = rtw89_mac_reg_by_idx(R_AX_TRXPTCL_RESP_CSI_RATE, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_TRXPTCL_RESP_CSI_RATE, mac_idx);
 	rtw89_write32(rtwdev, reg,
 		      u32_encode_bits(CSI_INIT_RATE_HT, B_AX_BFMEE_HT_CSI_RATE_MASK) |
 		      u32_encode_bits(CSI_INIT_RATE_VHT, B_AX_BFMEE_VHT_CSI_RATE_MASK) |
 		      u32_encode_bits(CSI_INIT_RATE_HE, B_AX_BFMEE_HE_CSI_RATE_MASK));
 
-	reg = rtw89_mac_reg_by_idx(R_AX_CSIRPT_OPTION, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_CSIRPT_OPTION, mac_idx);
 	rtw89_write32_set(rtwdev, reg,
 			  B_AX_CSIPRT_VHTSU_AID_EN | B_AX_CSIPRT_HESU_AID_EN);
 
@@ -5254,7 +5254,7 @@ static int rtw89_mac_set_csi_para_reg(struct rtw89_dev *rtwdev,
 	nc = min(nc, sound_dim);
 	nr = min(nr, sound_dim);
 
-	reg = rtw89_mac_reg_by_idx(R_AX_TRXPTCL_RESP_CSI_CTRL_0, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_TRXPTCL_RESP_CSI_CTRL_0, mac_idx);
 	rtw89_write32_set(rtwdev, reg, B_AX_BFMEE_BFPARAM_SEL);
 
 	val = FIELD_PREP(B_AX_BFMEE_CSIINFO0_NC_MASK, nc) |
@@ -5266,9 +5266,9 @@ static int rtw89_mac_set_csi_para_reg(struct rtw89_dev *rtwdev,
 	      FIELD_PREP(B_AX_BFMEE_CSIINFO0_STBC_EN, stbc_en);
 
 	if (port_sel == 0)
-		reg = rtw89_mac_reg_by_idx(R_AX_TRXPTCL_RESP_CSI_CTRL_0, mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_TRXPTCL_RESP_CSI_CTRL_0, mac_idx);
 	else
-		reg = rtw89_mac_reg_by_idx(R_AX_TRXPTCL_RESP_CSI_CTRL_1, mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_TRXPTCL_RESP_CSI_CTRL_1, mac_idx);
 
 	rtw89_write16(rtwdev, reg, val);
 
@@ -5304,11 +5304,11 @@ static int rtw89_mac_csi_rrsc(struct rtw89_dev *rtwdev,
 			 BIT(RTW89_MAC_BF_RRSC_HT_MSC3) |
 			 BIT(RTW89_MAC_BF_RRSC_HT_MSC5));
 	}
-	reg = rtw89_mac_reg_by_idx(R_AX_TRXPTCL_RESP_CSI_CTRL_0, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_TRXPTCL_RESP_CSI_CTRL_0, mac_idx);
 	rtw89_write32_set(rtwdev, reg, B_AX_BFMEE_BFPARAM_SEL);
 	rtw89_write32_clr(rtwdev, reg, B_AX_BFMEE_CSI_FORCE_RETE_EN);
 	rtw89_write32(rtwdev,
-		      rtw89_mac_reg_by_idx(R_AX_TRXPTCL_RESP_CSI_RRSC, mac_idx),
+		      rtw89_mac_reg_by_idx(rtwdev, R_AX_TRXPTCL_RESP_CSI_RRSC, mac_idx),
 		      rrsc);
 
 	return 0;
@@ -5346,19 +5346,21 @@ void rtw89_mac_bf_set_gid_table(struct rtw89_dev *rtwdev, struct ieee80211_vif *
 	rtw89_debug(rtwdev, RTW89_DBG_BF, "update bf GID table\n");
 
 	p = (__le32 *)conf->mu_group.membership;
-	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(R_AX_GID_POSITION_EN0, mac_idx),
+	rtw89_write32(rtwdev,
+		      rtw89_mac_reg_by_idx(rtwdev, R_AX_GID_POSITION_EN0, mac_idx),
 		      le32_to_cpu(p[0]));
-	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(R_AX_GID_POSITION_EN1, mac_idx),
+	rtw89_write32(rtwdev,
+		      rtw89_mac_reg_by_idx(rtwdev, R_AX_GID_POSITION_EN1, mac_idx),
 		      le32_to_cpu(p[1]));
 
 	p = (__le32 *)conf->mu_group.position;
-	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(R_AX_GID_POSITION0, mac_idx),
+	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(rtwdev, R_AX_GID_POSITION0, mac_idx),
 		      le32_to_cpu(p[0]));
-	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(R_AX_GID_POSITION1, mac_idx),
+	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(rtwdev, R_AX_GID_POSITION1, mac_idx),
 		      le32_to_cpu(p[1]));
-	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(R_AX_GID_POSITION2, mac_idx),
+	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(rtwdev, R_AX_GID_POSITION2, mac_idx),
 		      le32_to_cpu(p[2]));
-	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(R_AX_GID_POSITION3, mac_idx),
+	rtw89_write32(rtwdev, rtw89_mac_reg_by_idx(rtwdev, R_AX_GID_POSITION3, mac_idx),
 		      le32_to_cpu(p[3]));
 }
 
@@ -5449,7 +5451,7 @@ __rtw89_mac_set_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			return ret;
 		}
 
-		reg = rtw89_mac_reg_by_idx(R_AX_AMPDU_AGG_LIMIT, mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_AMPDU_AGG_LIMIT, mac_idx);
 		rtw89_write32_mask(rtwdev, reg, B_AX_AMPDU_MAX_TIME_MASK,
 				   max_tx_time >> 5);
 	}
@@ -5489,7 +5491,7 @@ int rtw89_mac_get_tx_time(struct rtw89_dev *rtwdev, struct rtw89_sta *rtwsta,
 			return ret;
 		}
 
-		reg = rtw89_mac_reg_by_idx(R_AX_AMPDU_AGG_LIMIT, mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_AMPDU_AGG_LIMIT, mac_idx);
 		*tx_time = rtw89_read32_mask(rtwdev, reg, B_AX_AMPDU_MAX_TIME_MASK) << 5;
 	}
 
@@ -5531,7 +5533,7 @@ int rtw89_mac_get_tx_retry_limit(struct rtw89_dev *rtwdev,
 			return ret;
 		}
 
-		reg = rtw89_mac_reg_by_idx(R_AX_TXCNT, mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_TXCNT, mac_idx);
 		*tx_retry = rtw89_read32_mask(rtwdev, reg, B_AX_L_TXCNT_LMT_MASK);
 	}
 
@@ -5550,7 +5552,7 @@ int rtw89_mac_set_hw_muedca_ctrl(struct rtw89_dev *rtwdev,
 	if (ret)
 		return ret;
 
-	reg = rtw89_mac_reg_by_idx(R_AX_MUEDCA_EN, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_MUEDCA_EN, mac_idx);
 	if (en)
 		rtw89_write16_set(rtwdev, reg, set);
 	else
@@ -5673,3 +5675,8 @@ int rtw89_mac_ptk_drop_by_band_and_wait(struct rtw89_dev *rtwdev,
 	}
 	return ret;
 }
+
+const struct rtw89_mac_gen_def rtw89_mac_gen_ax = {
+	.band1_offset = RTW89_MAC_AX_BAND_REG_OFFSET,
+};
+EXPORT_SYMBOL(rtw89_mac_gen_ax);
diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index 0e1570451c2c..26a89130fa48 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -478,6 +478,7 @@ enum rtw89_mac_bf_rrsc_rate {
 	({typeof(_addr) __addr = (_addr); \
 	  __addr >= R_AX_CMAC_REG_START && __addr <= R_AX_CMAC_REG_END; })
 #define RTW89_MAC_AX_BAND_REG_OFFSET 0x2000
+#define RTW89_MAC_BE_BAND_REG_OFFSET 0x4000
 
 #define PTCL_IDLE_POLL_CNT	10000
 #define SW_CVR_DUR_US	8
@@ -826,14 +827,25 @@ struct rtw89_mac_size_set {
 
 extern const struct rtw89_mac_size_set rtw89_mac_size;
 
-static inline u32 rtw89_mac_reg_by_idx(u32 reg_base, u8 band)
+struct rtw89_mac_gen_def {
+	u32 band1_offset;
+};
+
+extern const struct rtw89_mac_gen_def rtw89_mac_gen_ax;
+extern const struct rtw89_mac_gen_def rtw89_mac_gen_be;
+
+static inline
+u32 rtw89_mac_reg_by_idx(struct rtw89_dev *rtwdev, u32 reg_base, u8 band)
 {
-	return band == 0 ? reg_base : (reg_base + 0x2000);
+	const struct rtw89_mac_gen_def *mac = rtwdev->chip->mac_def;
+
+	return band == 0 ? reg_base : (reg_base + mac->band1_offset);
 }
 
-static inline u32 rtw89_mac_reg_by_port(u32 base, u8 port, u8 mac_idx)
+static inline
+u32 rtw89_mac_reg_by_port(struct rtw89_dev *rtwdev, u32 base, u8 port, u8 mac_idx)
 {
-	return rtw89_mac_reg_by_idx(base + port * 0x40, mac_idx);
+	return rtw89_mac_reg_by_idx(rtwdev, base + port * 0x40, mac_idx);
 }
 
 static inline u32
@@ -841,7 +853,7 @@ rtw89_read32_port(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif, u32 base)
 {
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_port(base, rtwvif->port, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif->port, rtwvif->mac_idx);
 	return rtw89_read32(rtwdev, reg);
 }
 
@@ -851,7 +863,7 @@ rtw89_read32_port_mask(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 {
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_port(base, rtwvif->port, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif->port, rtwvif->mac_idx);
 	return rtw89_read32_mask(rtwdev, reg, mask);
 }
 
@@ -861,7 +873,7 @@ rtw89_write32_port(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif, u32 base,
 {
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_port(base, rtwvif->port, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif->port, rtwvif->mac_idx);
 	rtw89_write32(rtwdev, reg, data);
 }
 
@@ -871,7 +883,7 @@ rtw89_write32_port_mask(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 {
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_port(base, rtwvif->port, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif->port, rtwvif->mac_idx);
 	rtw89_write32_mask(rtwdev, reg, mask, data);
 }
 
@@ -881,7 +893,7 @@ rtw89_write16_port_mask(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 {
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_port(base, rtwvif->port, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif->port, rtwvif->mac_idx);
 	rtw89_write16_mask(rtwdev, reg, mask, data);
 }
 
@@ -891,7 +903,7 @@ rtw89_write32_port_clr(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 {
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_port(base, rtwvif->port, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif->port, rtwvif->mac_idx);
 	rtw89_write32_clr(rtwdev, reg, bit);
 }
 
@@ -901,7 +913,7 @@ rtw89_write16_port_clr(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 {
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_port(base, rtwvif->port, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif->port, rtwvif->mac_idx);
 	rtw89_write16_clr(rtwdev, reg, bit);
 }
 
@@ -911,7 +923,7 @@ rtw89_write32_port_set(struct rtw89_dev *rtwdev, struct rtw89_vif *rtwvif,
 {
 	u32 reg;
 
-	reg = rtw89_mac_reg_by_port(base, rtwvif->port, rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_port(rtwdev, base, rtwvif->port, rtwvif->mac_idx);
 	rtw89_write32_set(rtwdev, reg, bit);
 }
 
diff --git a/drivers/net/wireless/realtek/rtw89/mac80211.c b/drivers/net/wireless/realtek/rtw89/mac80211.c
index a66503eb35b8..c5c714a3de44 100644
--- a/drivers/net/wireless/realtek/rtw89/mac80211.c
+++ b/drivers/net/wireless/realtek/rtw89/mac80211.c
@@ -271,13 +271,13 @@ static void rtw89_ops_configure_filter(struct ieee80211_hw *hw,
 	}
 
 	rtw89_write32_mask(rtwdev,
-			   rtw89_mac_reg_by_idx(R_AX_RX_FLTR_OPT, RTW89_MAC_0),
+			   rtw89_mac_reg_by_idx(rtwdev, R_AX_RX_FLTR_OPT, RTW89_MAC_0),
 			   B_AX_RX_FLTR_CFG_MASK,
 			   rtwdev->hal.rx_fltr);
 	if (!rtwdev->dbcc_en)
 		goto out;
 	rtw89_write32_mask(rtwdev,
-			   rtw89_mac_reg_by_idx(R_AX_RX_FLTR_OPT, RTW89_MAC_1),
+			   rtw89_mac_reg_by_idx(rtwdev, R_AX_RX_FLTR_OPT, RTW89_MAC_1),
 			   B_AX_RX_FLTR_CFG_MASK,
 			   rtwdev->hal.rx_fltr);
 
@@ -353,7 +353,7 @@ static void ____rtw89_conf_tx_mu_edca(struct rtw89_dev *rtwdev,
 	val = FIELD_PREP(B_AX_MUEDCA_BE_PARAM_0_TIMER_MASK, timer_32us) |
 	      FIELD_PREP(B_AX_MUEDCA_BE_PARAM_0_CW_MASK, mu_edca->ecw_min_max) |
 	      FIELD_PREP(B_AX_MUEDCA_BE_PARAM_0_AIFS_MASK, aifs);
-	reg = rtw89_mac_reg_by_idx(ac_to_mu_edca_param[ac], rtwvif->mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, ac_to_mu_edca_param[ac], rtwvif->mac_idx);
 	rtw89_write32(rtwdev, reg, val);
 
 	rtw89_mac_set_hw_muedca_ctrl(rtwdev, rtwvif, true);
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
new file mode 100644
index 000000000000..05bb8efaad23
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -0,0 +1,10 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2019-2020  Realtek Corporation
+ */
+
+#include "mac.h"
+
+const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
+	.band1_offset = RTW89_MAC_BE_BAND_REG_OFFSET,
+};
+EXPORT_SYMBOL(rtw89_mac_gen_be);
diff --git a/drivers/net/wireless/realtek/rtw89/phy.c b/drivers/net/wireless/realtek/rtw89/phy.c
index c40c4f8c1271..fa37d7d06093 100644
--- a/drivers/net/wireless/realtek/rtw89/phy.c
+++ b/drivers/net/wireless/realtek/rtw89/phy.c
@@ -4561,7 +4561,7 @@ void rtw89_phy_tssi_ctrl_set_fast_mode_cfg(struct rtw89_dev *rtwdev,
 		regs = rtw89_tssi_fastmode_regs_level;
 
 	for (i = 0; i < RTW89_TSSI_FAST_MODE_NUM; i++) {
-		reg = rtw89_mac_reg_by_idx(regs[i].addr, mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, regs[i].addr, mac_idx);
 		rtw89_write32_mask(rtwdev, reg, regs[i].mask, val);
 	}
 }
@@ -4623,11 +4623,11 @@ void rtw89_phy_tssi_ctrl_set_bandedge_cfg(struct rtw89_dev *rtwdev,
 	data = chip->tssi_dbw_table->data[bandedge_cfg];
 
 	for (i = 0; i < RTW89_TSSI_SBW_NUM; i++) {
-		reg = rtw89_mac_reg_by_idx(regs[i].addr, mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, regs[i].addr, mac_idx);
 		rtw89_write32_mask(rtwdev, reg, regs[i].mask, data[i]);
 	}
 
-	reg = rtw89_mac_reg_by_idx(R_AX_BANDEDGE_CFG, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_BANDEDGE_CFG, mac_idx);
 	rtw89_write32_mask(rtwdev, reg, B_AX_BANDEDGE_CFG_IDX_MASK, bandedge_cfg);
 
 	rtw89_phy_tssi_ctrl_set_fast_mode_cfg(rtwdev, mac_idx, bandedge_cfg,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index b5740639e267..ccf96c963bb4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -756,9 +756,9 @@ static void rtw8851b_set_channel_mac(struct rtw89_dev *rtwdev,
 				     const struct rtw89_chan *chan,
 				     u8 mac_idx)
 {
-	u32 sub_carr = rtw89_mac_reg_by_idx(R_AX_TX_SUB_CARRIER_VALUE, mac_idx);
-	u32 chk_rate = rtw89_mac_reg_by_idx(R_AX_TXRATE_CHK, mac_idx);
-	u32 rf_mod = rtw89_mac_reg_by_idx(R_AX_WMAC_RFMOD, mac_idx);
+	u32 sub_carr = rtw89_mac_reg_by_idx(rtwdev, R_AX_TX_SUB_CARRIER_VALUE, mac_idx);
+	u32 chk_rate = rtw89_mac_reg_by_idx(rtwdev, R_AX_TXRATE_CHK, mac_idx);
+	u32 rf_mod = rtw89_mac_reg_by_idx(rtwdev, R_AX_WMAC_RFMOD, mac_idx);
 	u8 txsc20 = 0, txsc40 = 0;
 
 	switch (chan->band_width) {
@@ -1740,14 +1740,14 @@ void rtw8851b_set_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
 		return;
 	}
 
-	reg = rtw89_mac_reg_by_idx(R_AX_PWR_UL_TB_CTRL, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PWR_UL_TB_CTRL, mac_idx);
 	rtw89_write32_set(rtwdev, reg, B_AX_PWR_UL_TB_CTRL_EN);
 
-	reg = rtw89_mac_reg_by_idx(R_AX_PWR_UL_TB_1T, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PWR_UL_TB_1T, mac_idx);
 	rtw89_write32_mask(rtwdev, reg, B_AX_PWR_UL_TB_1T_MASK, pw_ofst);
 
 	pw_ofst = max_t(s8, pw_ofst - 3, -16);
-	reg = rtw89_mac_reg_by_idx(R_AX_PWR_UL_TB_2T, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PWR_UL_TB_2T, mac_idx);
 	rtw89_write32_mask(rtwdev, reg, B_AX_PWR_UL_TB_2T_MASK, pw_ofst);
 }
 
@@ -2336,6 +2336,7 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.chip_id		= RTL8851B,
 	.chip_gen		= RTW89_CHIP_AX,
 	.ops			= &rtw8851b_chip_ops,
+	.mac_def		= &rtw89_mac_gen_ax,
 	.fw_basename		= RTW8851B_FW_BASENAME,
 	.fw_format_max		= RTW8851B_FW_FORMAT_MAX,
 	.try_ce_fw		= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852a.c b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
index 41f05276406d..aefc72f24cf2 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852a.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852a.c
@@ -704,10 +704,9 @@ static void rtw8852a_set_channel_mac(struct rtw89_dev *rtwdev,
 				     const struct rtw89_chan *chan,
 				     u8 mac_idx)
 {
-	u32 rf_mod = rtw89_mac_reg_by_idx(R_AX_WMAC_RFMOD, mac_idx);
-	u32 sub_carr = rtw89_mac_reg_by_idx(R_AX_TX_SUB_CARRIER_VALUE,
-					     mac_idx);
-	u32 chk_rate = rtw89_mac_reg_by_idx(R_AX_TXRATE_CHK, mac_idx);
+	u32 rf_mod = rtw89_mac_reg_by_idx(rtwdev, R_AX_WMAC_RFMOD, mac_idx);
+	u32 sub_carr = rtw89_mac_reg_by_idx(rtwdev, R_AX_TX_SUB_CARRIER_VALUE, mac_idx);
+	u32 chk_rate = rtw89_mac_reg_by_idx(rtwdev, R_AX_TXRATE_CHK, mac_idx);
 	u8 txsc20 = 0, txsc40 = 0;
 
 	switch (chan->band_width) {
@@ -1380,13 +1379,13 @@ void rtw8852a_set_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
 			    pw_ofst);
 		return;
 	}
-	reg = rtw89_mac_reg_by_idx(R_AX_PWR_UL_TB_CTRL, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PWR_UL_TB_CTRL, mac_idx);
 	rtw89_write32_set(rtwdev, reg, B_AX_PWR_UL_TB_CTRL_EN);
 	val_1t = pw_ofst;
-	reg = rtw89_mac_reg_by_idx(R_AX_PWR_UL_TB_1T, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PWR_UL_TB_1T, mac_idx);
 	rtw89_write32_mask(rtwdev, reg, B_AX_PWR_UL_TB_1T_MASK, val_1t);
 	val_2t = max(val_1t - 3, -16);
-	reg = rtw89_mac_reg_by_idx(R_AX_PWR_UL_TB_2T, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PWR_UL_TB_2T, mac_idx);
 	rtw89_write32_mask(rtwdev, reg, B_AX_PWR_UL_TB_2T_MASK, val_2t);
 	rtw89_debug(rtwdev, RTW89_DBG_TXPWR, "[ULTB] Set TB pwr_offset=(%d, %d)\n",
 		    val_1t, val_2t);
@@ -2073,6 +2072,7 @@ const struct rtw89_chip_info rtw8852a_chip_info = {
 	.chip_id		= RTL8852A,
 	.chip_gen		= RTW89_CHIP_AX,
 	.ops			= &rtw8852a_chip_ops,
+	.mac_def		= &rtw89_mac_gen_ax,
 	.fw_basename		= RTW8852A_FW_BASENAME,
 	.fw_format_max		= RTW8852A_FW_FORMAT_MAX,
 	.try_ce_fw		= false,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index eb2210cb7e09..cd1863e7e6d4 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -843,9 +843,9 @@ static void rtw8852b_set_channel_mac(struct rtw89_dev *rtwdev,
 				     const struct rtw89_chan *chan,
 				     u8 mac_idx)
 {
-	u32 rf_mod = rtw89_mac_reg_by_idx(R_AX_WMAC_RFMOD, mac_idx);
-	u32 sub_carr = rtw89_mac_reg_by_idx(R_AX_TX_SUB_CARRIER_VALUE, mac_idx);
-	u32 chk_rate = rtw89_mac_reg_by_idx(R_AX_TXRATE_CHK, mac_idx);
+	u32 rf_mod = rtw89_mac_reg_by_idx(rtwdev, R_AX_WMAC_RFMOD, mac_idx);
+	u32 sub_carr = rtw89_mac_reg_by_idx(rtwdev, R_AX_TX_SUB_CARRIER_VALUE, mac_idx);
+	u32 chk_rate = rtw89_mac_reg_by_idx(rtwdev, R_AX_TXRATE_CHK, mac_idx);
 	u8 txsc20 = 0, txsc40 = 0;
 
 	switch (chan->band_width) {
@@ -1725,14 +1725,14 @@ void rtw8852b_set_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
 		return;
 	}
 
-	reg = rtw89_mac_reg_by_idx(R_AX_PWR_UL_TB_CTRL, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PWR_UL_TB_CTRL, mac_idx);
 	rtw89_write32_set(rtwdev, reg, B_AX_PWR_UL_TB_CTRL_EN);
 
-	reg = rtw89_mac_reg_by_idx(R_AX_PWR_UL_TB_1T, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PWR_UL_TB_1T, mac_idx);
 	rtw89_write32_mask(rtwdev, reg, B_AX_PWR_UL_TB_1T_MASK, pw_ofst);
 
 	pw_ofst = max_t(s8, pw_ofst - 3, -16);
-	reg = rtw89_mac_reg_by_idx(R_AX_PWR_UL_TB_2T, mac_idx);
+	reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PWR_UL_TB_2T, mac_idx);
 	rtw89_write32_mask(rtwdev, reg, B_AX_PWR_UL_TB_2T_MASK, pw_ofst);
 }
 
@@ -2505,6 +2505,7 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.chip_id		= RTL8852B,
 	.chip_gen		= RTW89_CHIP_AX,
 	.ops			= &rtw8852b_chip_ops,
+	.mac_def		= &rtw89_mac_gen_ax,
 	.fw_basename		= RTW8852B_FW_BASENAME,
 	.fw_format_max		= RTW8852B_FW_FORMAT_MAX,
 	.try_ce_fw		= true,
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852c.c b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
index b1af72fbf085..4e936e0ba407 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852c.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852c.c
@@ -606,10 +606,9 @@ static void rtw8852c_set_channel_mac(struct rtw89_dev *rtwdev,
 				     const struct rtw89_chan *chan,
 				     u8 mac_idx)
 {
-	u32 rf_mod = rtw89_mac_reg_by_idx(R_AX_WMAC_RFMOD, mac_idx);
-	u32 sub_carr = rtw89_mac_reg_by_idx(R_AX_TX_SUB_CARRIER_VALUE,
-					     mac_idx);
-	u32 chk_rate = rtw89_mac_reg_by_idx(R_AX_TXRATE_CHK, mac_idx);
+	u32 rf_mod = rtw89_mac_reg_by_idx(rtwdev, R_AX_WMAC_RFMOD, mac_idx);
+	u32 sub_carr = rtw89_mac_reg_by_idx(rtwdev, R_AX_TX_SUB_CARRIER_VALUE, mac_idx);
+	u32 chk_rate = rtw89_mac_reg_by_idx(rtwdev, R_AX_TXRATE_CHK, mac_idx);
 	u8 txsc20 = 0, txsc40 = 0, txsc80 = 0;
 	u8 rf_mod_val = 0, chk_rate_mask = 0;
 	u32 txsc;
@@ -1654,8 +1653,7 @@ static void rtw8852c_set_channel_bb(struct rtw89_dev *rtwdev,
 	    rtwdev->hal.cv != CHIP_CAV) {
 		rtw89_phy_write32_idx(rtwdev, R_P80_AT_HIGH_FREQ,
 				      B_P80_AT_HIGH_FREQ, 0x0, phy_idx);
-		reg = rtw89_mac_reg_by_idx(R_P80_AT_HIGH_FREQ_BB_WRP,
-					   phy_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_P80_AT_HIGH_FREQ_BB_WRP, phy_idx);
 		if (chan->primary_channel > chan->channel) {
 			rtw89_phy_write32_mask(rtwdev,
 					       R_P80_AT_HIGH_FREQ_RU_ALLOC,
@@ -1859,12 +1857,12 @@ void rtw8852c_set_txpwr_ul_tb_offset(struct rtw89_dev *rtwdev,
 
 	for (i = 0; i < 4; i++) {
 		/* 1TX */
-		reg = rtw89_mac_reg_by_idx(R_AX_PWR_UL_TB_1T, mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PWR_UL_TB_1T, mac_idx);
 		rtw89_write32_mask(rtwdev, reg,
 				   B_AX_PWR_UL_TB_1T_V1_MASK << (8 * i),
 				   val_1t);
 		/* 2TX */
-		reg = rtw89_mac_reg_by_idx(R_AX_PWR_UL_TB_2T, mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, R_AX_PWR_UL_TB_2T, mac_idx);
 		rtw89_write32_mask(rtwdev, reg,
 				   B_AX_PWR_UL_TB_2T_V1_MASK << (8 * i),
 				   val_2t);
@@ -2181,7 +2179,7 @@ static void rtw8852c_ctrl_tx_path_tmac(struct rtw89_dev *rtwdev, u8 tx_path,
 
 	for (addr = R_AX_MACID_ANT_TABLE;
 	     addr <= R_AX_MACID_ANT_TABLE_LAST; addr += 4) {
-		reg = rtw89_mac_reg_by_idx(addr, mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, addr, mac_idx);
 		rtw89_write32(rtwdev, reg, 0);
 	}
 
@@ -2211,7 +2209,7 @@ static void rtw8852c_ctrl_tx_path_tmac(struct rtw89_dev *rtwdev, u8 tx_path,
 	for (i = 0; i < cr_size; i++) {
 		rtw89_debug(rtwdev, RTW89_DBG_TSSI, "0x%x = 0x%x\n",
 			    path_com[i].addr, path_com[i].data);
-		reg = rtw89_mac_reg_by_idx(path_com[i].addr, mac_idx);
+		reg = rtw89_mac_reg_by_idx(rtwdev, path_com[i].addr, mac_idx);
 		rtw89_write32(rtwdev, reg, path_com[i].data);
 	}
 }
@@ -2804,6 +2802,7 @@ const struct rtw89_chip_info rtw8852c_chip_info = {
 	.chip_id		= RTL8852C,
 	.chip_gen		= RTW89_CHIP_AX,
 	.ops			= &rtw8852c_chip_ops,
+	.mac_def		= &rtw89_mac_gen_ax,
 	.fw_basename		= RTW8852C_FW_BASENAME,
 	.fw_format_max		= RTW8852C_FW_FORMAT_MAX,
 	.try_ce_fw		= false,
-- 
2.25.1

