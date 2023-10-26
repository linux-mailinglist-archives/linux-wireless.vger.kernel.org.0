Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 360CA7D8225
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Oct 2023 14:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbjJZMBm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 26 Oct 2023 08:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjJZMBl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 26 Oct 2023 08:01:41 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C43AF
        for <linux-wireless@vger.kernel.org>; Thu, 26 Oct 2023 05:01:36 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 39QC1KcM42779278, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 39QC1KcM42779278
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Thu, 26 Oct 2023 20:01:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 26 Oct 2023 20:01:21 +0800
Received: from [127.0.1.1] (172.16.17.48) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Thu, 26 Oct
 2023 20:01:20 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/4] wifi: rtw89: pci: define PCI ring address for WiFi 7 chips
Date:   Thu, 26 Oct 2023 20:00:47 +0800
Message-ID: <20231026120049.9187-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231026120049.9187-1-pkshih@realtek.com>
References: <20231026120049.9187-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.16.17.48]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PCI rings are used to DMA TX/RX packets. The address of WiFi 7 chips are
different from previous ones, so add them according to hardware design.
Another difference is that driver doesn't need to configure BD (buffer
descriptor) RAM table, which is used by hardware to fetch BD ahead before
fetching whole TX data.

A TX ring contains numbers of TX BD (e.g. 512):

   TX BD (buffer descriptor; continual memory)
    +---+---+---+---+     +---+
    |   |   |   |   | ... |   |
    +-|-+---+---+---+     +---+
      |
      | point to TX WD (WiFi descriptor; metadata of a skb data)
      v
    +------+
    |      |
    |      |
    +-|----+
      |
      | point to a skb data
      v
    +------+
    |      |
    |      |
    +------+

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c      | 66 ++++++++++++----
 drivers/net/wireless/realtek/rtw89/pci.h      | 75 +++++++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |  1 +
 3 files changed, 126 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index 14ddb0d39e63..910f30a209be 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -817,6 +817,15 @@ static irqreturn_t rtw89_pci_interrupt_handler(int irq, void *dev)
 	return irqret;
 }
 
+#define DEF_TXCHADDRS_TYPE2(gen, ch_idx, txch, v...) \
+	[RTW89_TXCH_##ch_idx] = { \
+		.num = R_##gen##_##txch##_TXBD_NUM ##v, \
+		.idx = R_##gen##_##txch##_TXBD_IDX ##v, \
+		.bdram = 0, \
+		.desa_l = R_##gen##_##txch##_TXBD_DESA_L ##v, \
+		.desa_h = R_##gen##_##txch##_TXBD_DESA_H ##v, \
+	}
+
 #define DEF_TXCHADDRS_TYPE1(info, txch, v...) \
 	[RTW89_TXCH_##txch] = { \
 		.num = R_AX_##txch##_TXBD_NUM ##v, \
@@ -835,12 +844,12 @@ static irqreturn_t rtw89_pci_interrupt_handler(int irq, void *dev)
 		.desa_h = R_AX_##txch##_TXBD_DESA_H ##v, \
 	}
 
-#define DEF_RXCHADDRS(info, rxch, v...) \
-	[RTW89_RXCH_##rxch] = { \
-		.num = R_AX_##rxch##_RXBD_NUM ##v, \
-		.idx = R_AX_##rxch##_RXBD_IDX ##v, \
-		.desa_l = R_AX_##rxch##_RXBD_DESA_L ##v, \
-		.desa_h = R_AX_##rxch##_RXBD_DESA_H ##v, \
+#define DEF_RXCHADDRS(gen, ch_idx, rxch, v...) \
+	[RTW89_RXCH_##ch_idx] = { \
+		.num = R_##gen##_##rxch##_RXBD_NUM ##v, \
+		.idx = R_##gen##_##rxch##_RXBD_IDX ##v, \
+		.desa_l = R_##gen##_##rxch##_RXBD_DESA_L ##v, \
+		.desa_h = R_##gen##_##rxch##_RXBD_DESA_H ##v, \
 	}
 
 const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set = {
@@ -860,8 +869,8 @@ const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set = {
 		DEF_TXCHADDRS(info, CH12),
 	},
 	.rx = {
-		DEF_RXCHADDRS(info, RXQ),
-		DEF_RXCHADDRS(info, RPQ),
+		DEF_RXCHADDRS(AX, RXQ, RXQ),
+		DEF_RXCHADDRS(AX, RPQ, RPQ),
 	},
 };
 EXPORT_SYMBOL(rtw89_pci_ch_dma_addr_set);
@@ -883,12 +892,35 @@ const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set_v1 = {
 		DEF_TXCHADDRS(info, CH12, _V1),
 	},
 	.rx = {
-		DEF_RXCHADDRS(info, RXQ, _V1),
-		DEF_RXCHADDRS(info, RPQ, _V1),
+		DEF_RXCHADDRS(AX, RXQ, RXQ, _V1),
+		DEF_RXCHADDRS(AX, RPQ, RPQ, _V1),
 	},
 };
 EXPORT_SYMBOL(rtw89_pci_ch_dma_addr_set_v1);
 
+const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set_be = {
+	.tx = {
+		DEF_TXCHADDRS_TYPE2(BE, ACH0, CH0, _V1),
+		DEF_TXCHADDRS_TYPE2(BE, ACH1, CH1, _V1),
+		DEF_TXCHADDRS_TYPE2(BE, ACH2, CH2, _V1),
+		DEF_TXCHADDRS_TYPE2(BE, ACH3, CH3, _V1),
+		DEF_TXCHADDRS_TYPE2(BE, ACH4, CH4, _V1),
+		DEF_TXCHADDRS_TYPE2(BE, ACH5, CH5, _V1),
+		DEF_TXCHADDRS_TYPE2(BE, ACH6, CH6, _V1),
+		DEF_TXCHADDRS_TYPE2(BE, ACH7, CH7, _V1),
+		DEF_TXCHADDRS_TYPE2(BE, CH8, CH8, _V1),
+		DEF_TXCHADDRS_TYPE2(BE, CH9, CH9, _V1),
+		DEF_TXCHADDRS_TYPE2(BE, CH10, CH10, _V1),
+		DEF_TXCHADDRS_TYPE2(BE, CH11, CH11, _V1),
+		DEF_TXCHADDRS_TYPE2(BE, CH12, CH12, _V1),
+	},
+	.rx = {
+		DEF_RXCHADDRS(BE, RXQ, RXQ0, _V1),
+		DEF_RXCHADDRS(BE, RPQ, RPQ0, _V1),
+	},
+};
+EXPORT_SYMBOL(rtw89_pci_ch_dma_addr_set_be);
+
 #undef DEF_TXCHADDRS_TYPE1
 #undef DEF_TXCHADDRS
 #undef DEF_RXCHADDRS
@@ -1433,19 +1465,21 @@ static void rtw89_pci_reset_trx_rings(struct rtw89_dev *rtwdev)
 
 		tx_ring = &rtwpci->tx_rings[i];
 		bd_ring = &tx_ring->bd_ring;
-		bd_ram = &bd_ram_table[i];
+		bd_ram = bd_ram_table ? &bd_ram_table[i] : NULL;
 		addr_num = bd_ring->addr.num;
 		addr_bdram = bd_ring->addr.bdram;
 		addr_desa_l = bd_ring->addr.desa_l;
 		bd_ring->wp = 0;
 		bd_ring->rp = 0;
 
-		val32 = FIELD_PREP(BDRAM_SIDX_MASK, bd_ram->start_idx) |
-			FIELD_PREP(BDRAM_MAX_MASK, bd_ram->max_num) |
-			FIELD_PREP(BDRAM_MIN_MASK, bd_ram->min_num);
-
 		rtw89_write16(rtwdev, addr_num, bd_ring->len);
-		rtw89_write32(rtwdev, addr_bdram, val32);
+		if (addr_bdram && bd_ram) {
+			val32 = FIELD_PREP(BDRAM_SIDX_MASK, bd_ram->start_idx) |
+				FIELD_PREP(BDRAM_MAX_MASK, bd_ram->max_num) |
+				FIELD_PREP(BDRAM_MIN_MASK, bd_ram->min_num);
+
+			rtw89_write32(rtwdev, addr_bdram, val32);
+		}
 		rtw89_write32(rtwdev, addr_desa_l, bd_ring->dma);
 	}
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index 907478db83ef..56e1980c9882 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -521,6 +521,80 @@
 			    B_BE_STOP_CH10 | B_BE_STOP_CH11 | \
 			    B_BE_STOP_CH12)
 
+#define R_BE_CH0_TXBD_NUM_V1 0xB030
+#define R_BE_CH1_TXBD_NUM_V1 0xB032
+#define R_BE_CH2_TXBD_NUM_V1 0xB034
+#define R_BE_CH3_TXBD_NUM_V1 0xB036
+#define R_BE_CH4_TXBD_NUM_V1 0xB038
+#define R_BE_CH5_TXBD_NUM_V1 0xB03A
+#define R_BE_CH6_TXBD_NUM_V1 0xB03C
+#define R_BE_CH7_TXBD_NUM_V1 0xB03E
+#define R_BE_CH8_TXBD_NUM_V1 0xB040
+#define R_BE_CH9_TXBD_NUM_V1 0xB042
+#define R_BE_CH10_TXBD_NUM_V1 0xB044
+#define R_BE_CH11_TXBD_NUM_V1 0xB046
+#define R_BE_CH12_TXBD_NUM_V1 0xB048
+#define R_BE_CH13_TXBD_NUM_V1 0xB04C
+#define R_BE_CH14_TXBD_NUM_V1 0xB04E
+
+#define R_BE_RXQ0_RXBD_NUM_V1 0xB050
+#define R_BE_RPQ0_RXBD_NUM_V1 0xB052
+
+#define R_BE_CH0_TXBD_IDX_V1 0xB100
+#define R_BE_CH1_TXBD_IDX_V1 0xB104
+#define R_BE_CH2_TXBD_IDX_V1 0xB108
+#define R_BE_CH3_TXBD_IDX_V1 0xB10C
+#define R_BE_CH4_TXBD_IDX_V1 0xB110
+#define R_BE_CH5_TXBD_IDX_V1 0xB114
+#define R_BE_CH6_TXBD_IDX_V1 0xB118
+#define R_BE_CH7_TXBD_IDX_V1 0xB11C
+#define R_BE_CH8_TXBD_IDX_V1 0xB120
+#define R_BE_CH9_TXBD_IDX_V1 0xB124
+#define R_BE_CH10_TXBD_IDX_V1 0xB128
+#define R_BE_CH11_TXBD_IDX_V1 0xB12C
+#define R_BE_CH12_TXBD_IDX_V1 0xB130
+#define R_BE_CH13_TXBD_IDX_V1 0xB134
+#define R_BE_CH14_TXBD_IDX_V1 0xB138
+
+#define R_BE_RXQ0_RXBD_IDX_V1 0xB160
+#define R_BE_RPQ0_RXBD_IDX_V1 0xB164
+
+#define R_BE_CH0_TXBD_DESA_L_V1 0xB200
+#define R_BE_CH0_TXBD_DESA_H_V1 0xB204
+#define R_BE_CH1_TXBD_DESA_L_V1 0xB208
+#define R_BE_CH1_TXBD_DESA_H_V1 0xB20C
+#define R_BE_CH2_TXBD_DESA_L_V1 0xB210
+#define R_BE_CH2_TXBD_DESA_H_V1 0xB214
+#define R_BE_CH3_TXBD_DESA_L_V1 0xB218
+#define R_BE_CH3_TXBD_DESA_H_V1 0xB21C
+#define R_BE_CH4_TXBD_DESA_L_V1 0xB220
+#define R_BE_CH4_TXBD_DESA_H_V1 0xB224
+#define R_BE_CH5_TXBD_DESA_L_V1 0xB228
+#define R_BE_CH5_TXBD_DESA_H_V1 0xB22C
+#define R_BE_CH6_TXBD_DESA_L_V1 0xB230
+#define R_BE_CH6_TXBD_DESA_H_V1 0xB234
+#define R_BE_CH7_TXBD_DESA_L_V1 0xB238
+#define R_BE_CH7_TXBD_DESA_H_V1 0xB23C
+#define R_BE_CH8_TXBD_DESA_L_V1 0xB240
+#define R_BE_CH8_TXBD_DESA_H_V1 0xB244
+#define R_BE_CH9_TXBD_DESA_L_V1 0xB248
+#define R_BE_CH9_TXBD_DESA_H_V1 0xB24C
+#define R_BE_CH10_TXBD_DESA_L_V1 0xB250
+#define R_BE_CH10_TXBD_DESA_H_V1 0xB254
+#define R_BE_CH11_TXBD_DESA_L_V1 0xB258
+#define R_BE_CH11_TXBD_DESA_H_V1 0xB25C
+#define R_BE_CH12_TXBD_DESA_L_V1 0xB260
+#define R_BE_CH12_TXBD_DESA_H_V1 0xB264
+#define R_BE_CH13_TXBD_DESA_L_V1 0xB268
+#define R_BE_CH13_TXBD_DESA_H_V1 0xB26C
+#define R_BE_CH14_TXBD_DESA_L_V1 0xB270
+#define R_BE_CH14_TXBD_DESA_H_V1 0xB274
+
+#define R_BE_RXQ0_RXBD_DESA_L_V1 0xB300
+#define R_BE_RXQ0_RXBD_DESA_H_V1 0xB304
+#define R_BE_RPQ0_RXBD_DESA_L_V1 0xB308
+#define R_BE_RPQ0_RXBD_DESA_H_V1 0xB30C
+
 /* Configure */
 #define R_AX_PCIE_INIT_CFG2		0x1004
 #define B_AX_WD_ITVL_IDLE		GENMASK(27, 24)
@@ -1150,6 +1224,7 @@ static inline bool rtw89_pci_ltr_is_err_reg_val(u32 val)
 extern const struct dev_pm_ops rtw89_pm_ops;
 extern const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set;
 extern const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set_v1;
+extern const struct rtw89_pci_ch_dma_addr_set rtw89_pci_ch_dma_addr_set_be;
 extern const struct rtw89_pci_bd_ram rtw89_bd_ram_table_dual[RTW89_TXCH_NUM];
 extern const struct rtw89_pci_bd_ram rtw89_bd_ram_table_single[RTW89_TXCH_NUM];
 
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index 948015a36a80..ffb31784d8ca 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -42,6 +42,7 @@ static const struct rtw89_pci_info rtw8922a_pci_info = {
 	.cpwm_addr		= R_BE_PCIE_CRPWM,
 	.tx_dma_ch_mask		= 0,
 	.bd_idx_addr_low_power	= NULL,
+	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set_be,
 	.bd_ram_table		= NULL,
 
 	.fill_txaddr_info	= rtw89_pci_fill_txaddr_info_v1,
-- 
2.25.1

