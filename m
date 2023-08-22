Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07E8B784168
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Aug 2023 14:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbjHVM71 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 22 Aug 2023 08:59:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235925AbjHVM70 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 22 Aug 2023 08:59:26 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E63EACE3
        for <linux-wireless@vger.kernel.org>; Tue, 22 Aug 2023 05:59:23 -0700 (PDT)
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.77 with qID 37MCwrTxB022573, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.81/5.90) with ESMTPS id 37MCwrTxB022573
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 22 Aug 2023 20:58:53 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Tue, 22 Aug 2023 20:59:15 +0800
Received: from [127.0.1.1] (172.16.23.216) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Tue, 22 Aug
 2023 20:59:15 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <cj.hsieh@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 3/6] wifi: rtw89: mac: define internal memory address for WiFi 7 chip
Date:   Tue, 22 Aug 2023 20:58:19 +0800
Message-ID: <20230822125822.23817-4-pkshih@realtek.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Define base address of WiFi 7 internal memory according to design to
provide the same functions as existing WiFi 6 chips.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/mac.h    | 27 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/mac_be.c | 27 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h    |  2 ++
 3 files changed, 56 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/mac.h b/drivers/net/wireless/realtek/rtw89/mac.h
index b31c78ca27da..7c7940093480 100644
--- a/drivers/net/wireless/realtek/rtw89/mac.h
+++ b/drivers/net/wireless/realtek/rtw89/mac.h
@@ -275,6 +275,7 @@ enum rtw89_mac_dbg_port_sel {
 
 /* SRAM mem dump */
 #define R_AX_INDIR_ACCESS_ENTRY 0x40000
+#define R_BE_INDIR_ACCESS_ENTRY 0x80000
 
 #define	AXIDMA_BASE_ADDR		0x18006000
 #define	STA_SCHED_BASE_ADDR		0x18808000
@@ -298,6 +299,31 @@ enum rtw89_mac_dbg_port_sel {
 #define	TXDATA_FIFO_1_BASE_ADDR		0x188A1000
 #define	CPU_LOCAL_BASE_ADDR		0x18003000
 
+#define WD_PAGE_BASE_ADDR_BE		0x0
+#define CPU_LOCAL_BASE_ADDR_BE		0x18003000
+#define AXIDMA_BASE_ADDR_BE		0x18006000
+#define SHARED_BUF_BASE_ADDR_BE		0x18700000
+#define DMAC_TBL_BASE_ADDR_BE		0x18800000
+#define SHCUT_MACHDR_BASE_ADDR_BE	0x18800800
+#define STA_SCHED_BASE_ADDR_BE		0x18818000
+#define NAT25_CAM_BASE_ADDR_BE		0x18820000
+#define RXPLD_FLTR_CAM_BASE_ADDR_BE	0x18823000
+#define SEC_CAM_BASE_ADDR_BE		0x18824000
+#define WOW_CAM_BASE_ADDR_BE		0x18828000
+#define MLD_TBL_BASE_ADDR_BE		0x18829000
+#define RX_CLSF_CAM_BASE_ADDR_BE	0x1882A000
+#define CMAC_TBL_BASE_ADDR_BE		0x18840000
+#define ADDR_CAM_BASE_ADDR_BE		0x18850000
+#define BSSID_CAM_BASE_ADDR_BE		0x18858000
+#define BA_CAM_BASE_ADDR_BE		0x18859000
+#define BCN_IE_CAM0_BASE_ADDR_BE	0x18860000
+#define TXDATA_FIFO_0_BASE_ADDR_BE	0x18861000
+#define TXD_FIFO_0_BASE_ADDR_BE		0x18862000
+#define BCN_IE_CAM1_BASE_ADDR_BE	0x18880000
+#define TXDATA_FIFO_1_BASE_ADDR_BE	0x18881000
+#define TXD_FIFO_1_BASE_ADDR_BE		0x18881800
+#define DCPU_LOCAL_BASE_ADDR_BE		0x19C02000
+
 #define CCTL_INFO_SIZE		32
 
 enum rtw89_mac_mem_sel {
@@ -322,6 +348,7 @@ enum rtw89_mac_mem_sel {
 	RTW89_MAC_MEM_BSSID_CAM,
 	RTW89_MAC_MEM_TXD_FIFO_0_V1,
 	RTW89_MAC_MEM_TXD_FIFO_1_V1,
+	RTW89_MAC_MEM_WD_PAGE,
 
 	/* keep last */
 	RTW89_MAC_MEM_NUM,
diff --git a/drivers/net/wireless/realtek/rtw89/mac_be.c b/drivers/net/wireless/realtek/rtw89/mac_be.c
index 05bb8efaad23..ec920978195e 100644
--- a/drivers/net/wireless/realtek/rtw89/mac_be.c
+++ b/drivers/net/wireless/realtek/rtw89/mac_be.c
@@ -3,8 +3,35 @@
  */
 
 #include "mac.h"
+#include "reg.h"
+
+static const u32 rtw89_mac_mem_base_addrs_be[RTW89_MAC_MEM_NUM] = {
+	[RTW89_MAC_MEM_AXIDMA]	        = AXIDMA_BASE_ADDR_BE,
+	[RTW89_MAC_MEM_SHARED_BUF]	= SHARED_BUF_BASE_ADDR_BE,
+	[RTW89_MAC_MEM_DMAC_TBL]	= DMAC_TBL_BASE_ADDR_BE,
+	[RTW89_MAC_MEM_SHCUT_MACHDR]	= SHCUT_MACHDR_BASE_ADDR_BE,
+	[RTW89_MAC_MEM_STA_SCHED]	= STA_SCHED_BASE_ADDR_BE,
+	[RTW89_MAC_MEM_RXPLD_FLTR_CAM]	= RXPLD_FLTR_CAM_BASE_ADDR_BE,
+	[RTW89_MAC_MEM_SECURITY_CAM]	= SEC_CAM_BASE_ADDR_BE,
+	[RTW89_MAC_MEM_WOW_CAM]		= WOW_CAM_BASE_ADDR_BE,
+	[RTW89_MAC_MEM_CMAC_TBL]	= CMAC_TBL_BASE_ADDR_BE,
+	[RTW89_MAC_MEM_ADDR_CAM]	= ADDR_CAM_BASE_ADDR_BE,
+	[RTW89_MAC_MEM_BA_CAM]		= BA_CAM_BASE_ADDR_BE,
+	[RTW89_MAC_MEM_BCN_IE_CAM0]	= BCN_IE_CAM0_BASE_ADDR_BE,
+	[RTW89_MAC_MEM_BCN_IE_CAM1]	= BCN_IE_CAM1_BASE_ADDR_BE,
+	[RTW89_MAC_MEM_TXD_FIFO_0]	= TXD_FIFO_0_BASE_ADDR_BE,
+	[RTW89_MAC_MEM_TXD_FIFO_1]	= TXD_FIFO_1_BASE_ADDR_BE,
+	[RTW89_MAC_MEM_TXDATA_FIFO_0]	= TXDATA_FIFO_0_BASE_ADDR_BE,
+	[RTW89_MAC_MEM_TXDATA_FIFO_1]	= TXDATA_FIFO_1_BASE_ADDR_BE,
+	[RTW89_MAC_MEM_CPU_LOCAL]	= CPU_LOCAL_BASE_ADDR_BE,
+	[RTW89_MAC_MEM_BSSID_CAM]	= BSSID_CAM_BASE_ADDR_BE,
+	[RTW89_MAC_MEM_WD_PAGE]		= WD_PAGE_BASE_ADDR_BE,
+};
 
 const struct rtw89_mac_gen_def rtw89_mac_gen_be = {
 	.band1_offset = RTW89_MAC_BE_BAND_REG_OFFSET,
+	.filter_model_addr = R_BE_FILTER_MODEL_ADDR,
+	.indir_access_addr = R_BE_INDIR_ACCESS_ENTRY,
+	.mem_base_addrs = rtw89_mac_mem_base_addrs_be,
 };
 EXPORT_SYMBOL(rtw89_mac_gen_be);
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 2d34b43cda3a..cab07cc993f0 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3625,6 +3625,8 @@
 #define B_AX_GNT_BT_TX_SW_VAL BIT(1)
 #define B_AX_GNT_BT_TX_SW_CTRL BIT(0)
 
+#define R_BE_FILTER_MODEL_ADDR 0x0C04
+
 #define RR_MOD 0x00
 #define RR_MOD_V1 0x10000
 #define RR_MOD_IQK GENMASK(19, 4)
-- 
2.25.1

