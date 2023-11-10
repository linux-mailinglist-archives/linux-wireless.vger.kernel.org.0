Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F0497E767F
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Nov 2023 02:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345535AbjKJBYa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 9 Nov 2023 20:24:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345556AbjKJBY2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 9 Nov 2023 20:24:28 -0500
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5A6344A4
        for <linux-wireless@vger.kernel.org>; Thu,  9 Nov 2023 17:24:25 -0800 (PST)
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 3AA1OB1o81890521, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
        by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 3AA1OB1o81890521
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Fri, 10 Nov 2023 09:24:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.32; Fri, 10 Nov 2023 09:24:12 +0800
Received: from [127.0.1.1] (172.21.69.94) by RTEXMBS04.realtek.com.tw
 (172.21.6.97) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.7; Fri, 10 Nov
 2023 09:24:12 +0800
From:   Ping-Ke Shih <pkshih@realtek.com>
To:     <kvalo@kernel.org>
CC:     <kevin_yang@realtek.com>, <linux-wireless@vger.kernel.org>
Subject: [PATCH 2/7] wifi: rtw89: pci: stop/start DMA for level 1 recovery according to chip gen
Date:   Fri, 10 Nov 2023 09:23:14 +0800
Message-ID: <20231110012319.12727-3-pkshih@realtek.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231110012319.12727-1-pkshih@realtek.com>
References: <20231110012319.12727-1-pkshih@realtek.com>
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
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Zong-Zhe Yang <kevin_yang@realtek.com>

Level 1 recovery is to recover TX/RX rings, so it needs PCI to stop/start
DMA. But, different chip gen have different implementations, either
register address/mask or function flow. So, configure callback of
stop/start DMA by chip gen.

Signed-off-by: Zong-Zhe Yang <kevin_yang@realtek.com>
Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
---
 drivers/net/wireless/realtek/rtw89/pci.c    | 21 +++++---
 drivers/net/wireless/realtek/rtw89/pci.h    |  4 ++
 drivers/net/wireless/realtek/rtw89/pci_be.c | 55 +++++++++++++++++++++
 drivers/net/wireless/realtek/rtw89/ser.c    |  6 +++
 4 files changed, 78 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/pci.c b/drivers/net/wireless/realtek/rtw89/pci.c
index bac9ec2236da..822b914cf935 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.c
+++ b/drivers/net/wireless/realtek/rtw89/pci.c
@@ -1755,7 +1755,7 @@ static void rtw89_pci_ctrl_dma_io(struct rtw89_dev *rtwdev, bool enable)
 		rtw89_write32_set(rtwdev, reg->addr, reg->mask);
 }
 
-static void rtw89_pci_ctrl_dma_all(struct rtw89_dev *rtwdev, bool enable)
+void rtw89_pci_ctrl_dma_all(struct rtw89_dev *rtwdev, bool enable)
 {
 	rtw89_pci_ctrl_dma_io(rtwdev, enable);
 	rtw89_pci_ctrl_dma_trx(rtwdev, enable);
@@ -3640,7 +3640,7 @@ static void rtw89_pci_l1ss_cfg(struct rtw89_dev *rtwdev)
 		rtw89_pci_l1ss_set(rtwdev, true);
 }
 
-static int rtw89_pci_poll_io_idle(struct rtw89_dev *rtwdev)
+static int rtw89_pci_poll_io_idle_ax(struct rtw89_dev *rtwdev)
 {
 	int ret = 0;
 	u32 sts;
@@ -3657,7 +3657,7 @@ static int rtw89_pci_poll_io_idle(struct rtw89_dev *rtwdev)
 	return ret;
 }
 
-static int rtw89_pci_lv1rst_stop_dma(struct rtw89_dev *rtwdev)
+static int rtw89_pci_lv1rst_stop_dma_ax(struct rtw89_dev *rtwdev)
 {
 	u32 val;
 	int ret;
@@ -3666,7 +3666,7 @@ static int rtw89_pci_lv1rst_stop_dma(struct rtw89_dev *rtwdev)
 		return 0;
 
 	rtw89_pci_ctrl_dma_all(rtwdev, false);
-	ret = rtw89_pci_poll_io_idle(rtwdev);
+	ret = rtw89_pci_poll_io_idle_ax(rtwdev);
 	if (ret) {
 		val = rtw89_read32(rtwdev, R_AX_DBG_ERR_FLAG);
 		rtw89_debug(rtwdev, RTW89_DBG_HCI,
@@ -3677,7 +3677,7 @@ static int rtw89_pci_lv1rst_stop_dma(struct rtw89_dev *rtwdev)
 		if (val & B_AX_RX_STUCK)
 			rtw89_mac_ctrl_hci_dma_rx(rtwdev, false);
 		rtw89_mac_ctrl_hci_dma_trx(rtwdev, true);
-		ret = rtw89_pci_poll_io_idle(rtwdev);
+		ret = rtw89_pci_poll_io_idle_ax(rtwdev);
 		val = rtw89_read32(rtwdev, R_AX_DBG_ERR_FLAG);
 		rtw89_debug(rtwdev, RTW89_DBG_HCI,
 			    "[PCIe] poll_io_idle fail, after 0x%08x: 0x%08x\n",
@@ -3687,7 +3687,7 @@ static int rtw89_pci_lv1rst_stop_dma(struct rtw89_dev *rtwdev)
 	return ret;
 }
 
-static int rtw89_pci_lv1rst_start_dma(struct rtw89_dev *rtwdev)
+static int rtw89_pci_lv1rst_start_dma_ax(struct rtw89_dev *rtwdev)
 {
 	u32 ret;
 
@@ -3709,18 +3709,20 @@ static int rtw89_pci_lv1rst_start_dma(struct rtw89_dev *rtwdev)
 static int rtw89_pci_ops_mac_lv1_recovery(struct rtw89_dev *rtwdev,
 					  enum rtw89_lv1_rcvy_step step)
 {
+	const struct rtw89_pci_info *info = rtwdev->pci_info;
+	const struct rtw89_pci_gen_def *gen_def = info->gen_def;
 	int ret;
 
 	switch (step) {
 	case RTW89_LV1_RCVY_STEP_1:
-		ret = rtw89_pci_lv1rst_stop_dma(rtwdev);
+		ret = gen_def->lv1rst_stop_dma(rtwdev);
 		if (ret)
 			rtw89_err(rtwdev, "lv1 rcvy pci stop dma fail\n");
 
 		break;
 
 	case RTW89_LV1_RCVY_STEP_2:
-		ret = rtw89_pci_lv1rst_start_dma(rtwdev);
+		ret = gen_def->lv1rst_start_dma(rtwdev);
 		if (ret)
 			rtw89_err(rtwdev, "lv1 rcvy pci start dma fail\n");
 		break;
@@ -3839,6 +3841,9 @@ const struct rtw89_pci_gen_def rtw89_pci_gen_ax = {
 
 	.clr_idx_all = rtw89_pci_clr_idx_all_ax,
 	.rst_bdram = rtw89_pci_rst_bdram_ax,
+
+	.lv1rst_stop_dma = rtw89_pci_lv1rst_stop_dma_ax,
+	.lv1rst_start_dma = rtw89_pci_lv1rst_start_dma_ax,
 };
 EXPORT_SYMBOL(rtw89_pci_gen_ax);
 
diff --git a/drivers/net/wireless/realtek/rtw89/pci.h b/drivers/net/wireless/realtek/rtw89/pci.h
index e3a4a6119660..30ab9d41e0ee 100644
--- a/drivers/net/wireless/realtek/rtw89/pci.h
+++ b/drivers/net/wireless/realtek/rtw89/pci.h
@@ -1042,6 +1042,9 @@ struct rtw89_pci_gen_def {
 
 	void (*clr_idx_all)(struct rtw89_dev *rtwdev);
 	int (*rst_bdram)(struct rtw89_dev *rtwdev);
+
+	int (*lv1rst_stop_dma)(struct rtw89_dev *rtwdev);
+	int (*lv1rst_start_dma)(struct rtw89_dev *rtwdev);
 };
 
 struct rtw89_pci_info {
@@ -1369,6 +1372,7 @@ u32 rtw89_pci_fill_txaddr_info(struct rtw89_dev *rtwdev,
 u32 rtw89_pci_fill_txaddr_info_v1(struct rtw89_dev *rtwdev,
 				  void *txaddr_info_addr, u32 total_len,
 				  dma_addr_t dma, u8 *add_info_nr);
+void rtw89_pci_ctrl_dma_all(struct rtw89_dev *rtwdev, bool enable);
 void rtw89_pci_config_intr_mask(struct rtw89_dev *rtwdev);
 void rtw89_pci_config_intr_mask_v1(struct rtw89_dev *rtwdev);
 void rtw89_pci_enable_intr(struct rtw89_dev *rtwdev, struct rtw89_pci *rtwpci);
diff --git a/drivers/net/wireless/realtek/rtw89/pci_be.c b/drivers/net/wireless/realtek/rtw89/pci_be.c
index 7d552b1a2d5e..01d72cde48a3 100644
--- a/drivers/net/wireless/realtek/rtw89/pci_be.c
+++ b/drivers/net/wireless/realtek/rtw89/pci_be.c
@@ -4,6 +4,7 @@
 
 #include <linux/pci.h>
 
+#include "mac.h"
 #include "pci.h"
 #include "reg.h"
 
@@ -420,11 +421,65 @@ static int rtw89_pci_ops_mac_post_init_be(struct rtw89_dev *rtwdev)
 	return 0;
 }
 
+static int rtw89_pci_poll_io_idle_be(struct rtw89_dev *rtwdev)
+{
+	u32 sts;
+	int ret;
+
+	ret = read_poll_timeout_atomic(rtw89_read32, sts,
+				       !(sts & B_BE_HAXI_MST_BUSY),
+				       10, 1000, false, rtwdev,
+				       R_BE_HAXI_DMA_BUSY1);
+	if (ret) {
+		rtw89_err(rtwdev, "pci dmach busy1 0x%X\n", sts);
+		return ret;
+	}
+
+	return 0;
+}
+
+static int rtw89_pci_lv1rst_stop_dma_be(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	rtw89_pci_ctrl_dma_all(rtwdev, false);
+	ret = rtw89_pci_poll_io_idle_be(rtwdev);
+	if (!ret)
+		return 0;
+
+	rtw89_debug(rtwdev, RTW89_DBG_HCI,
+		    "[PCIe] poll_io_idle fail; reset hci dma trx\n");
+
+	rtw89_mac_ctrl_hci_dma_trx(rtwdev, false);
+	rtw89_mac_ctrl_hci_dma_trx(rtwdev, true);
+
+	return rtw89_pci_poll_io_idle_be(rtwdev);
+}
+
+static int rtw89_pci_lv1rst_start_dma_be(struct rtw89_dev *rtwdev)
+{
+	int ret;
+
+	rtw89_mac_ctrl_hci_dma_trx(rtwdev, false);
+	rtw89_mac_ctrl_hci_dma_trx(rtwdev, true);
+	rtw89_pci_clr_idx_all(rtwdev);
+
+	ret = rtw89_pci_rst_bdram_be(rtwdev);
+	if (ret)
+		return ret;
+
+	rtw89_pci_ctrl_dma_all(rtwdev, true);
+	return 0;
+}
+
 const struct rtw89_pci_gen_def rtw89_pci_gen_be = {
 	.mac_pre_init = rtw89_pci_ops_mac_pre_init_be,
 	.mac_post_init = rtw89_pci_ops_mac_post_init_be,
 
 	.clr_idx_all = rtw89_pci_clr_idx_all_be,
 	.rst_bdram = rtw89_pci_rst_bdram_be,
+
+	.lv1rst_stop_dma = rtw89_pci_lv1rst_stop_dma_be,
+	.lv1rst_start_dma = rtw89_pci_lv1rst_start_dma_be,
 };
 EXPORT_SYMBOL(rtw89_pci_gen_be);
diff --git a/drivers/net/wireless/realtek/rtw89/ser.c b/drivers/net/wireless/realtek/rtw89/ser.c
index c1644353053f..1e4a79a3b814 100644
--- a/drivers/net/wireless/realtek/rtw89/ser.c
+++ b/drivers/net/wireless/realtek/rtw89/ser.c
@@ -361,6 +361,9 @@ static int hal_enable_dma(struct rtw89_ser *ser)
 	ret = rtwdev->hci.ops->mac_lv1_rcvy(rtwdev, RTW89_LV1_RCVY_STEP_2);
 	if (!ret)
 		clear_bit(RTW89_SER_HAL_STOP_DMA, ser->flags);
+	else
+		rtw89_debug(rtwdev, RTW89_DBG_SER,
+			    "lv1 rcvy fail to start dma: %d\n", ret);
 
 	return ret;
 }
@@ -376,6 +379,9 @@ static int hal_stop_dma(struct rtw89_ser *ser)
 	ret = rtwdev->hci.ops->mac_lv1_rcvy(rtwdev, RTW89_LV1_RCVY_STEP_1);
 	if (!ret)
 		set_bit(RTW89_SER_HAL_STOP_DMA, ser->flags);
+	else
+		rtw89_debug(rtwdev, RTW89_DBG_SER,
+			    "lv1 rcvy fail to stop dma: %d\n", ret);
 
 	return ret;
 }
-- 
2.25.1

