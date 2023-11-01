Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE0B7DDD1B
	for <lists+linux-wireless@lfdr.de>; Wed,  1 Nov 2023 08:22:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230271AbjKAHWt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 1 Nov 2023 03:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230028AbjKAHWs (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 1 Nov 2023 03:22:48 -0400
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64166F1
        for <linux-wireless@vger.kernel.org>; Wed,  1 Nov 2023 00:22:44 -0700 (PDT)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3A17MZjsC1220515, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
        by rtits2.realtek.com.tw (8.15.2/2.93/5.92) with ESMTPS id 3A17MZjsC1220515
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Wed, 1 Nov 2023 15:22:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Wed, 1 Nov 2023 15:22:35 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Wed, 1 Nov 2023
 15:22:35 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <linux-wireless@vger.kernel.org>
Subject: [PATCH 4/5] wifi: rtw89: pci: add LTR v2 for WiFi 7 chip
Date:   Wed, 1 Nov 2023 15:21:48 +0800
Message-ID: <20231101072149.21997-5-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231101072149.21997-1-pkshih@realtek.com>
References: <20231101072149.21997-1-pkshih@realtek.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [172.21.69.94]
X-ClientProxiedBy: RTEXMBS02.realtek.com.tw (172.21.6.95) To
 RTEXMBS04.realtek.com.tw (172.21.6.97)
X-KSE-ServerInfo: RTEXMBS04.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: license violation
X-KSE-Antivirus-Attachment-Filter-Interceptor-Info: license violation
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

PCI LTR (Latency Tolerance Reporting) is a capability to yield expected
power consumption, and we configure the parameters according to design.

Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.h      |  1 +
 drivers/net/wireless/realtek/rtw89/pci_be.c   | 57 +++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/reg.h      | 43 ++++++++++++++
 .../net/wireless/realtek/rtw89/rtw8922ae.c    |  1 +
 4 files changed, 102 insertions(+)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index d9fe9a013a56..9b39ca4bbb66 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1317,6 +1317,7 @@ void rtw89_pci_remove(struct pci_dev *pdev);
 void rtw89_pci_ops_reset(struct rtw89_dev *rtwdev);
 int rtw89_pci_ltr_set(struct rtw89_dev *rtwdev, bool en);
 int rtw89_pci_ltr_set_v1(struct rtw89_dev *rtwdev, bool en);
+int rtw89_pci_ltr_set_v2(struct rtw89_dev *rtwdev, bool en);
 u32 rtw89_pci_fill_txaddr_info(struct rtw89_dev *rtwdev,
 			       void *txaddr_info_addr, u32 total_len,
 			       dma_addr_t dma, u8 *add_info_nr);
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index 0510fe9f7146..33c841613c3d 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -328,6 +328,63 @@ static int rtw89_pci_ops_mac_pre_init_be(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+int rtw89_pci_ltr_set_v2(struct rtw89_dev *rtwdev, bool en)
+{
+	u32 ctrl0, cfg0, cfg1, dec_ctrl, idle_ltcy, act_ltcy, dis_ltcy;
+
+	ctrl0 = rtw89_read32(rtwdev, R_BE_LTR_CTRL_0);
+	if (rtw89_pci_ltr_is_err_reg_val(ctrl0))
+		return -EINVAL;
+	cfg0 = rtw89_read32(rtwdev, R_BE_LTR_CFG_0);
+	if (rtw89_pci_ltr_is_err_reg_val(cfg0))
+		return -EINVAL;
+	cfg1 = rtw89_read32(rtwdev, R_BE_LTR_CFG_1);
+	if (rtw89_pci_ltr_is_err_reg_val(cfg1))
+		return -EINVAL;
+	dec_ctrl = rtw89_read32(rtwdev, R_BE_LTR_DECISION_CTRL_V1);
+	if (rtw89_pci_ltr_is_err_reg_val(dec_ctrl))
+		return -EINVAL;
+	idle_ltcy = rtw89_read32(rtwdev, R_BE_LTR_LATENCY_IDX3_V1);
+	if (rtw89_pci_ltr_is_err_reg_val(idle_ltcy))
+		return -EINVAL;
+	act_ltcy = rtw89_read32(rtwdev, R_BE_LTR_LATENCY_IDX1_V1);
+	if (rtw89_pci_ltr_is_err_reg_val(act_ltcy))
+		return -EINVAL;
+	dis_ltcy = rtw89_read32(rtwdev, R_BE_LTR_LATENCY_IDX0_V1);
+	if (rtw89_pci_ltr_is_err_reg_val(dis_ltcy))
+		return -EINVAL;
+
+	if (en) {
+		dec_ctrl |= B_BE_ENABLE_LTR_CTL_DECISION | B_BE_LTR_HW_DEC_EN_V1;
+		ctrl0 |= B_BE_LTR_HW_EN;
+	} else {
+		dec_ctrl &= ~(B_BE_ENABLE_LTR_CTL_DECISION | B_BE_LTR_HW_DEC_EN_V1 |
+			      B_BE_LTR_EN_PORT_V1_MASK);
+		ctrl0 &= ~B_BE_LTR_HW_EN;
+	}
+
+	dec_ctrl = u32_replace_bits(dec_ctrl, PCI_LTR_SPC_500US,
+				    B_BE_LTR_SPACE_IDX_MASK);
+	cfg0 = u32_replace_bits(cfg0, PCI_LTR_IDLE_TIMER_3_2MS,
+				B_BE_LTR_IDLE_TIMER_IDX_MASK);
+	cfg1 = u32_replace_bits(cfg1, 0xC0, B_BE_LTR_CMAC0_RX_USE_PG_TH_MASK);
+	cfg1 = u32_replace_bits(cfg1, 0xC0, B_BE_LTR_CMAC1_RX_USE_PG_TH_MASK);
+	cfg0 = u32_replace_bits(cfg0, 1, B_BE_LTR_IDX_ACTIVE_MASK);
+	cfg0 = u32_replace_bits(cfg0, 3, B_BE_LTR_IDX_IDLE_MASK);
+	dec_ctrl = u32_replace_bits(dec_ctrl, 0, B_BE_LTR_IDX_DISABLE_V1_MASK);
+
+	rtw89_write32(rtwdev, R_BE_LTR_LATENCY_IDX3_V1, 0x90039003);
+	rtw89_write32(rtwdev, R_BE_LTR_LATENCY_IDX1_V1, 0x880b880b);
+	rtw89_write32(rtwdev, R_BE_LTR_LATENCY_IDX0_V1, 0);
+	rtw89_write32(rtwdev, R_BE_LTR_DECISION_CTRL_V1, dec_ctrl);
+	rtw89_write32(rtwdev, R_BE_LTR_CFG_0, cfg0);
+	rtw89_write32(rtwdev, R_BE_LTR_CFG_1, cfg1);
+	rtw89_write32(rtwdev, R_BE_LTR_CTRL_0, ctrl0);
+
+	return 0;
+}
+EXPORT_SYMBOL(rtw89_pci_ltr_set_v2);
+
 const struct rtw89_pci_gen_def rtw89_pci_gen_be = {
 	.mac_pre_init = rtw89_pci_ops_mac_pre_init_be,
 
diff --git a/drivers/net/wireless/realtek/rtw89/reg.h b/drivers/net/wireless/realtek/rtw89/reg.h
index 58b0e09b07aa..68a5d8ff6a70 100644
--- a/drivers/net/wireless/realtek/rtw89/reg.h
+++ b/drivers/net/wireless/realtek/rtw89/reg.h
@@ -3960,6 +3960,49 @@
 #define B_BE_WDT_R_BYPASS BIT(1)
 #define B_BE_WDT_R_ENABLE BIT(0)
 
+#define R_BE_LTR_DECISION_CTRL_V1 0x3610
+#define B_BE_ENABLE_LTR_CTL_DECISION BIT(31)
+#define B_BE_LAT_LTR_IDX_DRV_VLD_V1 BIT(24)
+#define B_BE_LAT_LTR_IDX_DRV_V1_MASK GENMASK(23, 22)
+#define B_BE_LAT_LTR_IDX_FW_VLD_V1 BIT(21)
+#define B_BE_LAT_LTR_IDX_FW_V1_MASK GENMASK(20, 19)
+#define B_BE_LAT_LTR_IDX_HW_VLD_V1 BIT(18)
+#define B_BE_LAT_LTR_IDX_HW_V1_MASK GENMASK(17, 16)
+#define B_BE_LTR_IDX_DRV_V1_MASK GENMASK(15, 14)
+#define B_BE_LTR_REQ_DRV_V1 BIT(13)
+#define B_BE_LTR_IDX_DISABLE_V1_MASK GENMASK(9, 8)
+#define B_BE_LTR_EN_PORT_V1_MASK GENMASK(6, 4)
+#define B_BE_LTR_DRV_DEC_EN_V1 BIT(6)
+#define B_BE_LTR_FW_DEC_EN_V1 BIT(5)
+#define B_BE_LTR_HW_DEC_EN_V1 BIT(4)
+#define B_BE_LTR_SPACE_IDX_MASK GENMASK(1, 0)
+
+#define R_BE_LTR_LATENCY_IDX0_V1 0x3614
+#define R_BE_LTR_LATENCY_IDX1_V1 0x3618
+#define R_BE_LTR_LATENCY_IDX2_V1 0x361C
+#define R_BE_LTR_LATENCY_IDX3_V1 0x3620
+
+#define R_BE_LTR_CTRL_0 0x8410
+#define B_BE_LTR_REQ_FW BIT(18)
+#define B_BE_LTR_IDX_FW_MASK GENMASK(17, 16)
+#define B_BE_LTR_IDLE_TIMER_IDX_MASK GENMASK(10, 8)
+#define B_BE_LTR_WD_NOEMP_CHK BIT(1)
+#define B_BE_LTR_HW_EN BIT(0)
+
+#define R_BE_LTR_CFG_0 0x8414
+#define B_BE_LTR_IDX_DISABLE_MASK GENMASK(17, 16)
+#define B_BE_LTR_IDX_IDLE_MASK GENMASK(15, 14)
+#define B_BE_LTR_IDX_ACTIVE_MASK GENMASK(13, 12)
+#define B_BE_LTR_IDLE_TIMER_IDX_MASK GENMASK(10, 8)
+#define B_BE_EN_LTR_CMAC_RX_USE_PG_CHK BIT(3)
+#define B_BE_EN_LTR_WD_NON_EMPTY_CHK BIT(2)
+#define B_BE_EN_LTR_HAXIDMA_TX_IDLE_CHK BIT(1)
+#define B_BE_EN_LTR_HAXIDMA_RX_IDLE_CHK BIT(0)
+
+#define R_BE_LTR_CFG_1 0x8418
+#define B_BE_LTR_CMAC1_RX_USE_PG_TH_MASK GENMASK(27, 16)
+#define B_BE_LTR_CMAC0_RX_USE_PG_TH_MASK GENMASK(11, 0)
+
 #define R_BE_PLE_DBG_FUN_INTF_CTL 0x9110
 #define B_BE_PLE_DFI_ACTIVE BIT(31)
 #define B_BE_PLE_DFI_TRGSEL_MASK GENMASK(19, 16)
diff --git a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
index 8ea5261b9ee4..944337c60191 100644
--- a/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
+++ b/drivers/net/wireless/realtek/rtw89/rtw8922ae.c
@@ -48,6 +48,7 @@ static const struct rtw89_pci_info rtw8922a_pci_info = {
 	.dma_addr_set		= &rtw89_pci_ch_dma_addr_set_be,
 	.bd_ram_table		= NULL,
 
+	.ltr_set		= rtw89_pci_ltr_set_v2,
 	.fill_txaddr_info	= rtw89_pci_fill_txaddr_info_v1,
 };
 
-- 
2.25.1

