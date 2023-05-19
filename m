Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3264D708E30
	for <lists+linux-wireless@lfdr.de>; Fri, 19 May 2023 05:15:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjESDPZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 May 2023 23:15:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230016AbjESDPX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 May 2023 23:15:23 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDB9FB1
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 20:15:21 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 34J3F5iJ4004276, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 34J3F5iJ4004276
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 19 May 2023 11:15:05 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 19 May 2023 11:15:14 +0800
Received: from [127.0.1.1] (172.21.69.188) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 19 May
 2023 11:15:13 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <timlee@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/7] wifi: rtw89: 8851b: add MAC configurations to chip_info
Date:   Fri, 19 May 2023 11:14:56 +0800
Message-ID: <20230519031500.21087-4-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230519031500.21087-1-pkshih@realtek.com>
References: <20230519031500.21087-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

These configurations include path control, TX grant, TX scheduler,
register-based H2C/C2H and so on.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 89 +++++++++++++++++++
 1 file changed, 89 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
index 11282f604f714..148cf00744120 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8851b.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -95,16 +95,92 @@ static const struct rtw89_reg3_def rtw8851b_btc_preagc_dis_defs[] = {
 
 static DECLARE_PHY_REG3_TBL(rtw8851b_btc_preagc_dis_defs);
 
+static const u32 rtw8851b_h2c_regs[RTW89_H2CREG_MAX] = {
+	R_AX_H2CREG_DATA0, R_AX_H2CREG_DATA1,  R_AX_H2CREG_DATA2,
+	R_AX_H2CREG_DATA3
+};
+
+static const u32 rtw8851b_c2h_regs[RTW89_C2HREG_MAX] = {
+	R_AX_C2HREG_DATA0, R_AX_C2HREG_DATA1, R_AX_C2HREG_DATA2,
+	R_AX_C2HREG_DATA3
+};
+
+static const struct rtw89_page_regs rtw8851b_page_regs = {
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
 static const struct rtw89_reg_def rtw8851b_dcfo_comp = {
 	R_DCFO_COMP_S0_V2, B_DCFO_COMP_S0_MSK_V2
 };
 
+static const struct rtw89_imr_info rtw8851b_imr_info = {
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
 static const struct rtw89_xtal_info rtw8851b_xtal_info = {
 	.xcap_reg		= R_AX_XTAL_ON_CTRL3,
 	.sc_xo_mask		= B_AX_XTAL_SC_XO_A_BLOCK_MASK,
 	.sc_xi_mask		= B_AX_XTAL_SC_XI_A_BLOCK_MASK,
 };
 
+static const struct rtw89_rrsr_cfgs rtw8851b_rrsr_cfgs = {
+	.ref_rate = {R_AX_TRXPTCL_RRSR_CTL_0, B_AX_WMAC_RESP_REF_RATE_SEL, 0},
+	.rsc = {R_AX_TRXPTCL_RRSR_CTL_0, B_AX_WMAC_RESP_RSC_MASK, 2},
+};
+
 static const struct rtw89_dig_regs rtw8851b_dig_regs = {
 	.seg0_pd_reg = R_SEG0R_PD_V1,
 	.pd_lower_bound_mask = B_SEG0R_PD_LOWER_BOUND_MSK,
@@ -2163,6 +2239,10 @@ static const struct rtw89_chip_ops rtw8851b_chip_ops = {
 	.pwr_off_func		= rtw8851b_pwr_off_func,
 	.fill_txdesc		= rtw89_core_fill_txdesc,
 	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc,
+	.cfg_ctrl_path		= rtw89_mac_cfg_ctrl_path,
+	.mac_cfg_gnt		= rtw89_mac_cfg_gnt,
+	.stop_sch_tx		= rtw89_mac_stop_sch_tx,
+	.resume_sch_tx		= rtw89_mac_resume_sch_tx,
 	.h2c_dctl_sec_cam	= NULL,
 
 	.btc_set_rfe		= rtw8851b_btc_set_rfe,
@@ -2264,10 +2344,19 @@ const struct rtw89_chip_info rtw8851b_chip_info = {
 	.hci_func_en_addr	= R_AX_HCI_FUNC_EN,
 	.h2c_desc_size		= sizeof(struct rtw89_txwd_body),
 	.txwd_body_size		= sizeof(struct rtw89_txwd_body),
+	.h2c_ctrl_reg		= R_AX_H2CREG_CTRL,
+	.h2c_counter_reg	= {R_AX_UDM1 + 1, B_AX_UDM1_HALMAC_H2C_DEQ_CNT_MASK >> 8},
+	.h2c_regs		= rtw8851b_h2c_regs,
+	.c2h_ctrl_reg		= R_AX_C2HREG_CTRL,
+	.c2h_counter_reg	= {R_AX_UDM1 + 1, B_AX_UDM1_HALMAC_C2H_ENQ_CNT_MASK >> 8},
+	.c2h_regs		= rtw8851b_c2h_regs,
+	.page_regs		= &rtw8851b_page_regs,
 	.cfo_src_fd		= true,
 	.cfo_hw_comp		= true,
 	.dcfo_comp		= &rtw8851b_dcfo_comp,
 	.dcfo_comp_sft		= 12,
+	.imr_info		= &rtw8851b_imr_info,
+	.rrsr_cfgs		= &rtw8851b_rrsr_cfgs,
 	.bss_clr_map_reg	= R_BSS_CLR_MAP_V1,
 	.dma_ch_mask		= BIT(RTW89_DMA_ACH4) | BIT(RTW89_DMA_ACH5) |
 				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
-- 
2.25.1

