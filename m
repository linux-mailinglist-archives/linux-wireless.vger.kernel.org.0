Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FD377EEB27
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Nov 2023 03:41:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229887AbjKQCld (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 16 Nov 2023 21:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjKQClc (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 16 Nov 2023 21:41:32 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3928F1A8
        for <linux-wireless@vger.kernel.org>; Thu, 16 Nov 2023 18:41:28 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AH2fK0B12818712, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AH2fK0B12818712
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 17 Nov 2023 10:41:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 17 Nov 2023 10:41:20 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 17 Nov
 2023 10:41:20 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/6] wifi: rtw89: 8922a: add 8922A basic chip info
Date:   Fri, 17 Nov 2023 10:40:24 +0800
Message-ID: <20231117024029.113845-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231117024029.113845-1-pkshih@realtek.com>
References: <20231117024029.113845-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

8922A is a 802.11be chip that can support 2/5/6 GHz bands 160MHz bandwidth.
Introduce the basic info such as firmware file name, some hardware address
and size, supported spatial stream, TX descriptor and so on, and then
we can add more attributes by later patches.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/reg.h      |   9 ++
 drivers/net/wireless/realtek/rtw89/rtw8922a.c | 113 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8922a.h |  15 +++
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |   2 +
 4 files changed, 139 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922a.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8922a.h

diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 080db70b87d2..7698fd3922f3 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -4045,6 +4045,12 @@
 #define R_BE_LTR_LATENCY_IDX2_V1 0x361C
 #define R_BE_LTR_LATENCY_IDX3_V1 0x3620
 
+#define R_BE_HCI_FUNC_EN 0x7880
+#define B_BE_HCI_CR_PROTECT BIT(31)
+#define B_BE_HCI_TRXBUF_EN BIT(2)
+#define B_BE_HCI_RXDMA_EN BIT(1)
+#define B_BE_HCI_TXDMA_EN BIT(0)
+
 #define R_BE_LTR_CTRL_0 0x8410
 #define B_BE_LTR_REQ_FW BIT(18)
 #define B_BE_LTR_IDX_FW_MASK GENMASK(17, 16)
@@ -4975,6 +4981,7 @@
 #define B_SEG0CSI_EN BIT(23)
 #define R_BSS_CLR_MAP 0x43ac
 #define R_BSS_CLR_MAP_V1 0x43B0
+#define R_BSS_CLR_MAP_V2 0x4EB0
 #define B_BSS_CLR_MAP_VLD0 BIT(28)
 #define B_BSS_CLR_MAP_TGT GENMASK(27, 22)
 #define B_BSS_CLR_MAP_STAID GENMASK(21, 11)
@@ -5268,6 +5275,8 @@
 #define R_BMODE_PDTH_EN_V1 0x4B74
 #define R_BMODE_PDTH_EN_V2 0x6718
 #define B_BMODE_PDTH_LIMIT_EN_MSK_V1 BIT(30)
+#define R_BSS_CLR_VLD_V2 0x4EBC
+#define B_BSS_CLR_VLD0_V2 BIT(2)
 #define R_CFO_COMP_SEG1_L 0x5384
 #define R_CFO_COMP_SEG1_H 0x5388
 #define R_CFO_COMP_SEG1_CTRL 0x538C
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.c b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
new file mode 100644
index 000000000000..e6f804b4907e
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.c
@@ -0,0 +1,113 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2023  Realtek Corporation
+ */
+
+#include "debug.h"
+#include "fw.h"
+#include "mac.h"
+#include "phy.h"
+#include "reg.h"
+#include "rtw8922a.h"
+
+#define RTW8922A_FW_FORMAT_MAX 0
+#define RTW8922A_FW_BASENAME "rtw89/rtw8922a_fw"
+#define RTW8922A_MODULE_FIRMWARE \
+	RTW8922A_FW_BASENAME ".bin"
+
+#ifdef CONFIG_PM
+static const struct wiphy_wowlan_support rtw_wowlan_stub_8922a = {
+	.flags = WIPHY_WOWLAN_MAGIC_PKT | WIPHY_WOWLAN_DISCONNECT,
+	.n_patterns = RTW89_MAX_PATTERN_NUM,
+	.pattern_max_len = RTW89_MAX_PATTERN_SIZE,
+	.pattern_min_len = 1,
+};
+#endif
+
+static const struct rtw89_chip_ops rtw8922a_chip_ops = {
+};
+
+const struct rtw89_chip_info rtw8922a_chip_info = {
+	.chip_id		= RTL8922A,
+	.chip_gen		= RTW89_CHIP_BE,
+	.ops			= &rtw8922a_chip_ops,
+	.mac_def		= &rtw89_mac_gen_be,
+	.phy_def		= &rtw89_phy_gen_be,
+	.fw_basename		= RTW8922A_FW_BASENAME,
+	.fw_format_max		= RTW8922A_FW_FORMAT_MAX,
+	.try_ce_fw		= false,
+	.bbmcu_nr		= 1,
+	.needed_fw_elms		= RTW89_BE_GEN_DEF_NEEDED_FW_ELEMENTS,
+	.fifo_size		= 589824,
+	.small_fifo_size	= false,
+	.dle_scc_rsvd_size	= 0,
+	.max_amsdu_limit	= 8000,
+	.dis_2g_40m_ul_ofdma	= false,
+	.rsvd_ple_ofst		= 0x8f800,
+	.rf_base_addr		= {0xe000, 0xf000},
+	.pwr_on_seq		= NULL,
+	.pwr_off_seq		= NULL,
+	.bb_table		= NULL,
+	.bb_gain_table		= NULL,
+	.rf_table		= {},
+	.nctl_table		= NULL,
+	.nctl_post_table	= NULL,
+	.dflt_parms		= NULL, /* load parm from fw */
+	.rfe_parms_conf		= NULL, /* load parm from fw */
+	.txpwr_factor_rf	= 2,
+	.txpwr_factor_mac	= 1,
+	.dig_table		= NULL,
+	.tssi_dbw_table		= NULL,
+	.support_chanctx_num	= 1,
+	.support_bands		= BIT(NL80211_BAND_2GHZ) |
+				  BIT(NL80211_BAND_5GHZ) |
+				  BIT(NL80211_BAND_6GHZ),
+	.support_unii4		= true,
+	.ul_tb_waveform_ctrl	= false,
+	.ul_tb_pwr_diff		= false,
+	.hw_sec_hdr		= true,
+	.rf_path_num		= 2,
+	.tx_nss			= 2,
+	.rx_nss			= 2,
+	.acam_num		= 128,
+	.bcam_num		= 20,
+	.scam_num		= 32,
+	.bacam_num		= 8,
+	.bacam_dynamic_num	= 8,
+	.bacam_ver		= RTW89_BACAM_V1,
+	.ppdu_max_usr		= 16,
+	.sec_ctrl_efuse_size	= 4,
+	.physical_efuse_size	= 0x1300,
+	.logical_efuse_size	= 0x70000,
+	.limit_efuse_size	= 0x40000,
+	.dav_phy_efuse_size	= 0,
+	.dav_log_efuse_size	= 0,
+	.phycap_addr		= 0x1700,
+	.phycap_size		= 0x38,
+
+	.ps_mode_supported	= BIT(RTW89_PS_MODE_RFOFF) |
+				  BIT(RTW89_PS_MODE_CLK_GATED) |
+				  BIT(RTW89_PS_MODE_PWR_GATED),
+	.low_power_hci_modes	= 0,
+	.hci_func_en_addr	= R_BE_HCI_FUNC_EN,
+	.h2c_desc_size		= sizeof(struct rtw89_rxdesc_short_v2),
+	.txwd_body_size		= sizeof(struct rtw89_txwd_body_v2),
+	.txwd_info_size		= sizeof(struct rtw89_txwd_info_v2),
+	.cfo_src_fd		= true,
+	.cfo_hw_comp            = true,
+	.dcfo_comp		= NULL,
+	.dcfo_comp_sft		= 0,
+	.imr_info		= NULL,
+	.bss_clr_vld		= {R_BSS_CLR_VLD_V2, B_BSS_CLR_VLD0_V2},
+	.bss_clr_map_reg	= R_BSS_CLR_MAP_V2,
+	.dma_ch_mask		= 0,
+#ifdef CONFIG_PM
+	.wowlan_stub		= &rtw_wowlan_stub_8922a,
+#endif
+	.xtal_info		= NULL,
+};
+EXPORT_SYMBOL(rtw8922a_chip_info);
+
+MODULE_FIRMWARE(RTW8922A_MODULE_FIRMWARE);
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11be wireless 8922A driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922a.h b/drivers/net/wireless/realtek/rtw89/rtw8922a.h
new file mode 100644
index 000000000000..eae70b1f8d01
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922a.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2023  Realtek Corporation
+ */
+
+#ifndef __RTW89_8922A_H__
+#define __RTW89_8922A_H__
+
+#include "core.h"
+
+#define RF_PATH_NUM_8922A 2
+#define BB_PATH_NUM_8922A 2
+
+extern const struct rtw89_chip_info rtw8922a_chip_info;
+
+#endif
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index 414635d301aa..7b3d98d2c402 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -7,6 +7,7 @@
 
 #include "pci.h"
 #include "reg.h"
+#include "rtw8922a.h"
 
 static const struct rtw89_pci_info rtw8922a_pci_info = {
 	.gen_def		= &rtw89_pci_gen_be,
@@ -58,6 +59,7 @@ static const struct rtw89_pci_info rtw8922a_pci_info = {
 };
 
 static const struct rtw89_driver_info rtw89_8922ae_info = {
+	.chip = &rtw8922a_chip_info,
 	.bus = {
 		.pci = &rtw8922a_pci_info,
 	},
-- 
2.25.1

