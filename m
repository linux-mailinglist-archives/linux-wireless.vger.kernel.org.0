Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEEB6EA1C4
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Apr 2023 04:46:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233609AbjDUCqL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 Apr 2023 22:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232790AbjDUCqK (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 Apr 2023 22:46:10 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2A63AB9
        for <linux-wireless@vger.kernel.org>; Thu, 20 Apr 2023 19:46:08 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 33L2k1oB5015999, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 33L2k1oB5015999
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=OK);
        Fri, 21 Apr 2023 10:46:01 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Fri, 21 Apr 2023 10:46:02 +0800
Received: from localhost.localdomain (172.21.69.188) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Fri, 21 Apr 2023 10:46:01 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <leo.li@realtek.com>, <gary.chang@realtek.com>,
        <linux-wireless@vger.kernel.org>
Subject: [PATCH 1/8] wifi: rtw89: 8851b: add 8851B basic chip_info
Date:   Fri, 21 Apr 2023 10:45:44 +0800
Message-ID: <20230421024551.29994-2-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20230421024551.29994-1-pkshih@realtek.com>
References: <20230421024551.29994-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.188]
X-ClientProxiedBy: RTEXH36505.realtek.com.tw (172.21.6.25) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
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

8851B is a 1x1 80 MHz bandwidth chip working on 2/5 GHz. Add these basic
information, and more settings will be added by functions.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/rtw8851b.c | 101 ++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/rtw8851b.h |  15 +++
 2 files changed, 116 insertions(+)
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851b.c
 create mode 100644 drivers/net/wireless/realtek/rtw89/rtw8851b.h

diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.c b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
new file mode 100644
index 0000000000000..a0aaac74b0ec8
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.c
@@ -0,0 +1,101 @@
+// SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause
+/* Copyright(c) 2022-2023  Realtek Corporation
+ */
+
+#include "coex.h"
+#include "fw.h"
+#include "mac.h"
+#include "phy.h"
+#include "reg.h"
+#include "rtw8851b.h"
+#include "rtw8851b_table.h"
+#include "txrx.h"
+#include "util.h"
+
+#define RTW8851B_FW_FORMAT_MAX 0
+#define RTW8851B_FW_BASENAME "rtw89/rtw8851b_fw"
+#define RTW8851B_MODULE_FIRMWARE \
+	RTW8851B_FW_BASENAME ".bin"
+
+static const struct rtw89_chip_ops rtw8851b_chip_ops = {
+	.fem_setup		= NULL,
+	.fill_txdesc		= rtw89_core_fill_txdesc,
+	.fill_txdesc_fwcmd	= rtw89_core_fill_txdesc,
+	.h2c_dctl_sec_cam	= NULL,
+};
+
+const struct rtw89_chip_info rtw8851b_chip_info = {
+	.chip_id		= RTL8851B,
+	.ops			= &rtw8851b_chip_ops,
+	.fw_basename		= RTW8851B_FW_BASENAME,
+	.fw_format_max		= RTW8851B_FW_FORMAT_MAX,
+	.try_ce_fw		= true,
+	.fifo_size		= 196608,
+	.dle_scc_rsvd_size	= 98304,
+	.max_amsdu_limit	= 3500,
+	.dis_2g_40m_ul_ofdma	= true,
+	.rsvd_ple_ofst		= 0x2f800,
+	.wde_qempty_acq_num     = 4,
+	.wde_qempty_mgq_sel     = 4,
+	.rf_base_addr		= {0xe000},
+	.pwr_on_seq		= NULL,
+	.pwr_off_seq		= NULL,
+	.bb_table		= &rtw89_8851b_phy_bb_table,
+	.bb_gain_table		= &rtw89_8851b_phy_bb_gain_table,
+	.rf_table		= {&rtw89_8851b_phy_radioa_table,},
+	.nctl_table		= &rtw89_8851b_phy_nctl_table,
+	.byr_table		= &rtw89_8851b_byr_table,
+	.dflt_parms		= &rtw89_8851b_dflt_parms,
+	.rfe_parms_conf		= rtw89_8851b_rfe_parms_conf,
+	.txpwr_factor_rf	= 2,
+	.txpwr_factor_mac	= 1,
+	.dig_table		= NULL,
+	.tssi_dbw_table		= NULL,
+	.support_chanctx_num	= 0,
+	.support_bands		= BIT(NL80211_BAND_2GHZ) |
+				  BIT(NL80211_BAND_5GHZ),
+	.support_bw160		= false,
+	.support_ul_tb_ctrl	= true,
+	.hw_sec_hdr		= false,
+	.rf_path_num		= 1,
+	.tx_nss			= 1,
+	.rx_nss			= 1,
+	.acam_num		= 32,
+	.bcam_num		= 20,
+	.scam_num		= 128,
+	.bacam_num		= 2,
+	.bacam_dynamic_num	= 4,
+	.bacam_v1		= false,
+	.sec_ctrl_efuse_size	= 4,
+	.physical_efuse_size	= 1216,
+	.logical_efuse_size	= 2048,
+	.limit_efuse_size	= 1280,
+	.dav_phy_efuse_size	= 0,
+	.dav_log_efuse_size	= 0,
+	.phycap_addr		= 0x580,
+	.phycap_size		= 128,
+	.para_ver		= 0,
+	.wlcx_desired		= 0x06000000,
+	.btcx_desired		= 0x7,
+	.scbd			= 0x1,
+	.mailbox		= 0x1,
+
+	.ps_mode_supported	= BIT(RTW89_PS_MODE_RFOFF) |
+				  BIT(RTW89_PS_MODE_CLK_GATED),
+	.low_power_hci_modes	= 0,
+	.h2c_cctl_func_id	= H2C_FUNC_MAC_CCTLINFO_UD,
+	.hci_func_en_addr	= R_AX_HCI_FUNC_EN,
+	.h2c_desc_size		= sizeof(struct rtw89_txwd_body),
+	.txwd_body_size		= sizeof(struct rtw89_txwd_body),
+	.bss_clr_map_reg	= R_BSS_CLR_MAP_V1,
+	.dma_ch_mask		= BIT(RTW89_DMA_ACH4) | BIT(RTW89_DMA_ACH5) |
+				  BIT(RTW89_DMA_ACH6) | BIT(RTW89_DMA_ACH7) |
+				  BIT(RTW89_DMA_B1MG) | BIT(RTW89_DMA_B1HI),
+	.edcca_lvl_reg		= R_SEG0R_EDCCA_LVL_V1,
+};
+EXPORT_SYMBOL(rtw8851b_chip_info);
+
+MODULE_FIRMWARE(RTW8851B_MODULE_FIRMWARE);
+MODULE_AUTHOR("Realtek Corporation");
+MODULE_DESCRIPTION("Realtek 802.11ax wireless 8851B driver");
+MODULE_LICENSE("Dual BSD/GPL");
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8851b.h b/drivers/net/wireless/realtek/rtw89/rtw8851b.h
new file mode 100644
index 0000000000000..e34b7d09ad6df
--- /dev/null
+++ b/drivers/net/wireless/realtek/rtw89/rtw8851b.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 OR BSD-3-Clause */
+/* Copyright(c) 2022-2023  Realtek Corporation
+ */
+
+#ifndef __RTW89_8851B_H__
+#define __RTW89_8851B_H__
+
+#include "core.h"
+
+#define RF_PATH_NUM_8851B 1
+#define BB_PATH_NUM_8851B 1
+
+extern const struct rtw89_chip_info rtw8851b_chip_info;
+
+#endif
-- 
2.25.1

