Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030925F8B63
	for <lists+linux-wireless@lfdr.de>; Sun,  9 Oct 2022 14:54:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229935AbiJIMy4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 9 Oct 2022 08:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230143AbiJIMyp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 9 Oct 2022 08:54:45 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 434BAC49
        for <linux-wireless@vger.kernel.org>; Sun,  9 Oct 2022 05:54:38 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 299Cs3Q91029540, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 299Cs3Q91029540
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=FAIL);
        Sun, 9 Oct 2022 20:54:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Sun, 9 Oct 2022 20:54:31 +0800
Received: from localhost (172.16.16.215) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Sun, 9 Oct 2022
 20:54:31 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 9/9] wifi: rtw89: 8852b: add basic attributes of chip_info
Date:   Sun, 9 Oct 2022 20:54:03 +0800
Message-ID: <20221009125403.19662-10-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221009125403.19662-1-pkshih@realtek.com>
References: <20221009125403.19662-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.16.215]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: trusted connection
X-KSE-Antiphishing-Info: Clean
X-KSE-Antiphishing-ScanningType: Deterministic
X-KSE-Antiphishing-Method: None
X-KSE-Antiphishing-Bases: 10/09/2022 12:37:00
X-KSE-AttachmentFiltering-Interceptor-Info: no applicable attachment filtering
 rules found
X-KSE-Antivirus-Interceptor-Info: scan successful
X-KSE-Antivirus-Info: =?big5?B?Q2xlYW4sIGJhc2VzOiAyMDIyLzEwLzkgpFekyCAwOTowNzowMA==?=
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-Attachment-Filter-Triggered-Rules: Clean
X-KSE-Attachment-Filter-Triggered-Filters: Clean
X-KSE-BulkMessagesFiltering-Scan-Result: protection disabled
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Add  8852b specific constant tables and basic attributes containing
common chip_ops, firmware name, supported TX/RX NSS, number of CAM,
coexistence version, control register set, and so on.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8852b.c | 235 ++++++++++++++++++
 1 file changed, 235 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8852b.c b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
index 290d83cb83d5a..0918b75ab1d94 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8852b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8852b.c
@@ -217,6 +217,150 @@ static const struct rtw89_reg3_def rtw8852b_btc_preagc_dis_defs[] = {
 
 static DECLARE_PHY_REG3_TBL(rtw8852b_btc_preagc_dis_defs);
 
+static const u32 rtw8852b_h2c_regs[RTW89_H2CREG_MAX] = {
+	R_AX_H2CREG_DATA0, R_AX_H2CREG_DATA1,  R_AX_H2CREG_DATA2,
+	R_AX_H2CREG_DATA3
+};
+
+static const u32 rtw8852b_c2h_regs[RTW89_C2HREG_MAX] = {
+	R_AX_C2HREG_DATA0, R_AX_C2HREG_DATA1, R_AX_C2HREG_DATA2,
+	R_AX_C2HREG_DATA3
+};
+
+static const struct rtw89_page_regs rtw8852b_page_regs = {
+	.hci_fc_ctrl	= R_AX_HCI_FC_CTRL,
+	.ch_page_ctrl	= R_AX_CH_PAGE_CTRL,
+	.ach_page_ctrl	= R_AX_ACH0_PAGE_CTRL,
+	.ach_page_info	= R_AX_ACH0_PAGE_INFO,
+	.pub_page_info3	= R_AX_PUB_PAGE_INFO3,
+	.pub_page_ctrl1	= R_AX_PUB_PAGE_CTRL1,
+	.pub_page_ctrl2	= R_AX_PUB_PAGE_CTRL2,
+	.pub_page_info1	= R_AX_PUB_PAGE_INFO1,
+	.pub_page_info2 = R_AX_PUB_PAGE_INFO2,
+	.wp_page_ctrl1	= R_AX_WP_PAGE_CTRL1,
+	.wp_page_ctrl2	= R_AX_WP_PAGE_CTRL2,
+	.wp_page_info1	= R_AX_WP_PAGE_INFO1,
+};
+
+static const struct rtw89_reg_def rtw8852b_dcfo_comp = {
+	R_DCFO_COMP_S0, B_DCFO_COMP_S0_MSK
+};
+
+static const struct rtw89_imr_info rtw8852b_imr_info = {
+	.wdrls_imr_set		= B_AX_WDRLS_IMR_SET,
+	.wsec_imr_reg		= R_AX_SEC_DEBUG,
+	.wsec_imr_set		= B_AX_IMR_ERROR,
+	.mpdu_tx_imr_set	= 0,
+	.mpdu_rx_imr_set	= 0,
+	.sta_sch_imr_set	= B_AX_STA_SCHEDULER_IMR_SET,
+	.txpktctl_imr_b0_reg	= R_AX_TXPKTCTL_ERR_IMR_ISR,
+	.txpktctl_imr_b0_clr	= B_AX_TXPKTCTL_IMR_B0_CLR,
+	.txpktctl_imr_b0_set	= B_AX_TXPKTCTL_IMR_B0_SET,
+	.txpktctl_imr_b1_reg	= R_AX_TXPKTCTL_ERR_IMR_ISR_B1,
+	.txpktctl_imr_b1_clr	= B_AX_TXPKTCTL_IMR_B1_CLR,
+	.txpktctl_imr_b1_set	= B_AX_TXPKTCTL_IMR_B1_SET,
+	.wde_imr_clr		= B_AX_WDE_IMR_CLR,
+	.wde_imr_set		= B_AX_WDE_IMR_SET,
+	.ple_imr_clr		= B_AX_PLE_IMR_CLR,
+	.ple_imr_set		= B_AX_PLE_IMR_SET,
+	.host_disp_imr_clr	= B_AX_HOST_DISP_IMR_CLR,
+	.host_disp_imr_set	= B_AX_HOST_DISP_IMR_SET,
+	.cpu_disp_imr_clr	= B_AX_CPU_DISP_IMR_CLR,
+	.cpu_disp_imr_set	= B_AX_CPU_DISP_IMR_SET,
+	.other_disp_imr_clr	= B_AX_OTHER_DISP_IMR_CLR,
+	.other_disp_imr_set	= 0,
+	.bbrpt_com_err_imr_reg	= R_AX_BBRPT_COM_ERR_IMR_ISR,
+	.bbrpt_chinfo_err_imr_reg = R_AX_BBRPT_CHINFO_ERR_IMR_ISR,
+	.bbrpt_err_imr_set	= 0,
+	.bbrpt_dfs_err_imr_reg	= R_AX_BBRPT_DFS_ERR_IMR_ISR,
+	.ptcl_imr_clr		= B_AX_PTCL_IMR_CLR_ALL,
+	.ptcl_imr_set		= B_AX_PTCL_IMR_SET,
+	.cdma_imr_0_reg		= R_AX_DLE_CTRL,
+	.cdma_imr_0_clr		= B_AX_DLE_IMR_CLR,
+	.cdma_imr_0_set		= B_AX_DLE_IMR_SET,
+	.cdma_imr_1_reg		= 0,
+	.cdma_imr_1_clr		= 0,
+	.cdma_imr_1_set		= 0,
+	.phy_intf_imr_reg	= R_AX_PHYINFO_ERR_IMR,
+	.phy_intf_imr_clr	= 0,
+	.phy_intf_imr_set	= 0,
+	.rmac_imr_reg		= R_AX_RMAC_ERR_ISR,
+	.rmac_imr_clr		= B_AX_RMAC_IMR_CLR,
+	.rmac_imr_set		= B_AX_RMAC_IMR_SET,
+	.tmac_imr_reg		= R_AX_TMAC_ERR_IMR_ISR,
+	.tmac_imr_clr		= B_AX_TMAC_IMR_CLR,
+	.tmac_imr_set		= B_AX_TMAC_IMR_SET,
+};
+
+static const struct rtw89_rrsr_cfgs rtw8852b_rrsr_cfgs = {
+	.ref_rate = {R_AX_TRXPTCL_RRSR_CTL_0, B_AX_WMAC_RESP_REF_RATE_SEL, 0},
+	.rsc = {R_AX_TRXPTCL_RRSR_CTL_0, B_AX_WMAC_RESP_RSC_MASK, 2},
+};
+
+static const struct rtw89_dig_regs rtw8852b_dig_regs = {
+	.seg0_pd_reg = R_SEG0R_PD_V1,
+	.pd_lower_bound_mask = B_SEG0R_PD_LOWER_BOUND_MSK,
+	.pd_spatial_reuse_en = B_SEG0R_PD_SPATIAL_REUSE_EN_MSK_V1,
+	.p0_lna_init = {R_PATH0_LNA_INIT_V1, B_PATH0_LNA_INIT_IDX_MSK},
+	.p1_lna_init = {R_PATH1_LNA_INIT_V1, B_PATH1_LNA_INIT_IDX_MSK},
+	.p0_tia_init = {R_PATH0_TIA_INIT_V1, B_PATH0_TIA_INIT_IDX_MSK_V1},
+	.p1_tia_init = {R_PATH1_TIA_INIT_V1, B_PATH1_TIA_INIT_IDX_MSK_V1},
+	.p0_rxb_init = {R_PATH0_RXB_INIT_V1, B_PATH0_RXB_INIT_IDX_MSK_V1},
+	.p1_rxb_init = {R_PATH1_RXB_INIT_V1, B_PATH1_RXB_INIT_IDX_MSK_V1},
+	.p0_p20_pagcugc_en = {R_PATH0_P20_FOLLOW_BY_PAGCUGC_V2,
+			      B_PATH0_P20_FOLLOW_BY_PAGCUGC_EN_MSK},
+	.p0_s20_pagcugc_en = {R_PATH0_S20_FOLLOW_BY_PAGCUGC_V2,
+			      B_PATH0_S20_FOLLOW_BY_PAGCUGC_EN_MSK},
+	.p1_p20_pagcugc_en = {R_PATH1_P20_FOLLOW_BY_PAGCUGC_V2,
+			      B_PATH1_P20_FOLLOW_BY_PAGCUGC_EN_MSK},
+	.p1_s20_pagcugc_en = {R_PATH1_S20_FOLLOW_BY_PAGCUGC_V2,
+			      B_PATH1_S20_FOLLOW_BY_PAGCUGC_EN_MSK},
+};
+
+static const struct rtw89_btc_rf_trx_para rtw89_btc_8852b_rf_ul[] = {
+	{15, 0, 0, 7}, /* 0 -> original */
+	{15, 2, 0, 7}, /* 1 -> for BT-connected ACI issue && BTG co-rx */
+	{15, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
+	{15, 0, 0, 7}, /* 3- >reserved for shared-antenna */
+	{15, 0, 0, 7}, /* 4 ->reserved for shared-antenna */
+	{15, 0, 0, 7}, /* the below id is for non-shared-antenna free-run */
+	{6, 1, 0, 7},
+	{13, 1, 0, 7},
+	{13, 1, 0, 7}
+};
+
+static const struct rtw89_btc_rf_trx_para rtw89_btc_8852b_rf_dl[] = {
+	{15, 0, 0, 7}, /* 0 -> original */
+	{15, 2, 0, 7}, /* 1 -> reserved for shared-antenna */
+	{15, 0, 0, 7}, /* 2 ->reserved for shared-antenna */
+	{15, 0, 0, 7}, /* 3- >reserved for shared-antenna */
+	{15, 0, 0, 7}, /* 4 ->reserved for shared-antenna */
+	{15, 0, 0, 7}, /* the below id is for non-shared-antenna free-run */
+	{15, 1, 0, 7},
+	{15, 1, 0, 7},
+	{15, 1, 0, 7}
+};
+
+static const struct rtw89_btc_fbtc_mreg rtw89_btc_8852b_mon_reg[] = {
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda24),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda28),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda2c),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda30),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda4c),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda10),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda20),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xda34),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xcef4),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0x8424),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xd200),
+	RTW89_DEF_FBTC_MREG(REG_MAC, 4, 0xd220),
+	RTW89_DEF_FBTC_MREG(REG_BB, 4, 0x980),
+	RTW89_DEF_FBTC_MREG(REG_BT_MODEM, 4, 0x178),
+};
+
+static const u8 rtw89_btc_8852b_wl_rssi_thres[BTC_WL_RSSI_THMAX] = {70, 60, 50, 40};
+static const u8 rtw89_btc_8852b_bt_rssi_thres[BTC_BT_RSSI_THMAX] = {50, 40, 30, 20};
+
 static int rtw8852b_pwr_on_func(struct rtw89_dev *rtwdev)
 {
 	u32 val32;
@@ -2195,10 +2339,13 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.disable_bb_rf		= rtw8852b_mac_disable_bb_rf,
 	.bb_reset		= rtw8852b_bb_reset,
 	.bb_sethw		= rtw8852b_bb_sethw,
+	.read_rf		= rtw89_phy_read_rf_v1,
+	.write_rf		= rtw89_phy_write_rf_v1,
 	.set_channel		= rtw8852b_set_channel,
 	.set_channel_help	= rtw8852b_set_channel_help,
 	.read_efuse		= rtw8852b_read_efuse,
 	.read_phycap		= rtw8852b_read_phycap,
+	.fem_setup		= NULL,
 	.power_trim		= rtw8852b_power_trim,
 	.set_txpwr		= rtw8852b_set_txpwr,
 	.set_txpwr_ctrl		= rtw8852b_set_txpwr_ctrl,
@@ -2208,8 +2355,16 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 	.query_ppdu		= rtw8852b_query_ppdu,
 	.bb_ctrl_btc_preagc	= rtw8852b_bb_ctrl_btc_preagc,
 	.cfg_txrx_path		= rtw8852b_bb_cfg_txrx_path,
+	.set_txpwr_ul_tb_offset	= rtw8852b_set_txpwr_ul_tb_offset,
 	.pwr_on_func		= rtw8852b_pwr_on_func,
 	.pwr_off_func		= rtw8852b_pwr_off_func,
+	.fill_txdesc		= rtw89_core_fill_txdesc,
+	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc,
+	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path,
+	.mac_cfg_gnt		= rtw89_mac_cfg_gnt,
+	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
+	.resume_sch_tx		= rtw89_mac_resume_sch_tx,
+	.h2c_dctl_sec_cam	= NULL,
 
 	.btc_set_rfe		= rtw8852b_btc_set_rfe,
 	.btc_init_cfg		= rtw8852b_btc_init_cfg,
@@ -2225,12 +2380,46 @@ static const struct rtw89_chip_ops rtw8852b_chip_ops = {
 const struct rtw89_chip_info rtw8852b_chip_info = {
 	.chip_id		= RTL8852B,
 	.ops			= &rtw8852b_chip_ops,
+	.fw_name		= "rtw89/rtw8852b_fw.bin",
 	.fifo_size		= 196608,
 	.dle_scc_rsvd_size	= 98304,
+	.max_amsdu_limit	= 3500,
+	.dis_2g_40m_ul_ofdma	= true,
+	.rsvd_ple_ofst		= 0x2f800,
 	.hfc_param_ini		= rtw8852b_hfc_param_ini_pcie,
 	.dle_mem		= rtw8852b_dle_mem_pcie,
+	.rf_base_addr		= {0xe000, 0xf000},
 	.pwr_on_seq		= NULL,
 	.pwr_off_seq		= NULL,
+	.bb_table		= &rtw89_8852b_phy_bb_table,
+	.bb_gain_table		= &rtw89_8852b_phy_bb_gain_table,
+	.rf_table		= {&rtw89_8852b_phy_radioa_table,
+				   &rtw89_8852b_phy_radiob_table,},
+	.nctl_table		= &rtw89_8852b_phy_nctl_table,
+	.byr_table		= &rtw89_8852b_byr_table,
+	.txpwr_lmt_2g		= &rtw89_8852b_txpwr_lmt_2g,
+	.txpwr_lmt_5g		= &rtw89_8852b_txpwr_lmt_5g,
+	.txpwr_lmt_ru_2g	= &rtw89_8852b_txpwr_lmt_ru_2g,
+	.txpwr_lmt_ru_5g	= &rtw89_8852b_txpwr_lmt_ru_5g,
+	.txpwr_factor_rf	= 2,
+	.txpwr_factor_mac	= 1,
+	.dig_table		= NULL,
+	.dig_regs		= &rtw8852b_dig_regs,
+	.tssi_dbw_table		= NULL,
+	.support_chanctx_num	= 0,
+	.support_bands		= BIT(NL80211_BAND_2GHZ) |
+				  BIT(NL80211_BAND_5GHZ),
+	.support_bw160		= false,
+	.hw_sec_hdr		= false,
+	.rf_path_num		= 2,
+	.tx_nss			= 2,
+	.rx_nss			= 2,
+	.acam_num		= 128,
+	.bcam_num		= 10,
+	.scam_num		= 128,
+	.bacam_num		= 2,
+	.bacam_dynamic_num	= 4,
+	.bacam_v1		= false,
 	.sec_ctrl_efuse_size	= 4,
 	.physical_efuse_size	= 1216,
 	.logical_efuse_size	= 2048,
@@ -2239,6 +2428,52 @@ const struct rtw89_chip_info rtw8852b_chip_info = {
 	.dav_log_efuse_size	= 16,
 	.phycap_addr		= 0x580,
 	.phycap_size		= 128,
+	.para_ver		= 0,
+	.wlcx_desired		= 0x05050000,
+	.btcx_desired		= 0x5,
+	.scbd			= 0x1,
+	.mailbox		= 0x1,
+	.btc_fwinfo_buf		= 1024,
+
+	.fcxbtcrpt_ver		= 1,
+	.fcxtdma_ver		= 1,
+	.fcxslots_ver		= 1,
+	.fcxcysta_ver		= 2,
+	.fcxstep_ver		= 2,
+	.fcxnullsta_ver		= 1,
+	.fcxmreg_ver		= 1,
+	.fcxgpiodbg_ver		= 1,
+	.fcxbtver_ver		= 1,
+	.fcxbtscan_ver		= 1,
+	.fcxbtafh_ver		= 1,
+	.fcxbtdevinfo_ver	= 1,
+	.afh_guard_ch		= 6,
+	.wl_rssi_thres		= rtw89_btc_8852b_wl_rssi_thres,
+	.bt_rssi_thres		= rtw89_btc_8852b_bt_rssi_thres,
+	.rssi_tol		= 2,
+	.mon_reg_num		= ARRAY_SIZE(rtw89_btc_8852b_mon_reg),
+	.mon_reg		= rtw89_btc_8852b_mon_reg,
+	.rf_para_ulink_num	= ARRAY_SIZE(rtw89_btc_8852b_rf_ul),
+	.rf_para_ulink		= rtw89_btc_8852b_rf_ul,
+	.rf_para_dlink_num	= ARRAY_SIZE(rtw89_btc_8852b_rf_dl),
+	.rf_para_dlink		= rtw89_btc_8852b_rf_dl,
+	.ps_mode_supported	= BIT(RTW89_PS_MODE_RFOFF) |
+				  BIT(RTW89_PS_MODE_CLK_GATED) |
+				  BIT(RTW89_PS_MODE_PWR_GATED),
+	.low_power_hci_modes	= 0,
+	.h2c_cctl_func_id	= H2C_FUNC_MAC_CCTLINFO_UD,
+	.hci_func_en_addr	= R_AX_HCI_FUNC_EN,
+	.h2c_desc_size		= sizeof(struct rtw89_txwd_body),
+	.txwd_body_size		= sizeof(struct rtw89_txwd_body),
+	.h2c_ctrl_reg		= R_AX_H2CREG_CTRL,
+	.h2c_regs		= rtw8852b_h2c_regs,
+	.c2h_ctrl_reg		= R_AX_C2HREG_CTRL,
+	.c2h_regs		= rtw8852b_c2h_regs,
+	.page_regs		= &rtw8852b_page_regs,
+	.dcfo_comp		= &rtw8852b_dcfo_comp,
+	.dcfo_comp_sft		= 3,
+	.imr_info		= &rtw8852b_imr_info,
+	.rrsr_cfgs		= &rtw8852b_rrsr_cfgs,
 	.dma_ch_mask		= BIT(RTW89_DMA_ACH4) | BIT(RTW89_DMA_ACH5) |
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
 				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
-- 
2.25.1

