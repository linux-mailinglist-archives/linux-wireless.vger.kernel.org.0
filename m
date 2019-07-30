Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0176C7A74F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2019 13:50:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730949AbfG3Lu0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 30 Jul 2019 07:50:26 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:54832 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729095AbfG3LuZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 30 Jul 2019 07:50:25 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x6UBoHDL017248, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x6UBoHDL017248
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 30 Jul 2019 19:50:17 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.439.0; Tue, 30 Jul 2019 19:50:16 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <jano.vesely@gmail.com>,
        <briannorris@chromium.org>
Subject: [PATCH] rtw88: pci: enable MSI interrupt
Date:   Tue, 30 Jul 2019 19:50:14 +0800
Message-ID: <1564487414-9615-1-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [172.21.68.126]
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Yu-Yen Ting <steventing@realtek.com>

MSI interrupt should be enabled on certain platform.

Add a module parameter disable_msi to disable MSI interrupt,
driver will then use legacy interrupt instead.
And the interrupt mode is not able to change at run-time, so
the module parameter is read only.

Tested-by: Ján Veselý <jano.vesely@gmail.com>
Signed-off-by: Yu-Yen Ting <steventing@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 51 ++++++++++++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw88/pci.h |  1 +
 2 files changed, 49 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 23dd06a..25410f6 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -10,6 +10,10 @@
 #include "rx.h"
 #include "debug.h"
 
+static bool rtw_disable_msi;
+module_param_named(disable_msi, rtw_disable_msi, bool, 0444);
+MODULE_PARM_DESC(disable_msi, "Set Y to disable MSI interrupt support");
+
 static u32 rtw_pci_tx_queue_idx_addr[] = {
 	[RTW_TX_QUEUE_BK]	= RTK_PCI_TXBD_IDX_BKQ,
 	[RTW_TX_QUEUE_BE]	= RTK_PCI_TXBD_IDX_BEQ,
@@ -874,6 +878,7 @@ static irqreturn_t rtw_pci_interrupt_handler(int irq, void *dev)
 	if (!rtwpci->irq_enabled)
 		goto out;
 
+	rtw_pci_disable_interrupt(rtwdev, rtwpci);
 	rtw_pci_irq_recognized(rtwdev, rtwpci, irq_status);
 
 	if (irq_status[0] & IMR_MGNTDOK)
@@ -893,6 +898,8 @@ static irqreturn_t rtw_pci_interrupt_handler(int irq, void *dev)
 	if (irq_status[0] & IMR_ROK)
 		rtw_pci_rx_isr(rtwdev, rtwpci, RTW_RX_QUEUE_MPDU);
 
+	rtw_pci_enable_interrupt(rtwdev, rtwpci);
+
 out:
 	spin_unlock(&rtwpci->irq_lock);
 
@@ -1103,6 +1110,45 @@ static struct rtw_hci_ops rtw_pci_ops = {
 	.write_data_h2c = rtw_pci_write_data_h2c,
 };
 
+static int rtw_pci_request_irq(struct rtw_dev *rtwdev, struct pci_dev *pdev)
+{
+	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
+	int ret;
+
+	if (!rtw_disable_msi) {
+		ret = pci_enable_msi(pdev);
+		if (ret) {
+			rtw_warn(rtwdev, "failed to enable msi, using legacy irq\n");
+		} else {
+			rtw_warn(rtwdev, "pci msi enabled\n");
+			rtwpci->msi_enabled = true;
+		}
+	}
+
+	ret = request_irq(pdev->irq, &rtw_pci_interrupt_handler, IRQF_SHARED,
+			  KBUILD_MODNAME, rtwdev);
+	if (ret) {
+		rtw_err(rtwdev, "failed to request irq\n");
+		if (rtwpci->msi_enabled) {
+			pci_disable_msi(pdev);
+			rtwpci->msi_enabled = false;
+		}
+	}
+
+	return ret;
+}
+
+static void rtw_pci_free_irq(struct rtw_dev *rtwdev, struct pci_dev *pdev)
+{
+	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
+
+	free_irq(pdev->irq, rtwdev);
+	if (rtwpci->msi_enabled) {
+		pci_disable_msi(pdev);
+		rtwpci->msi_enabled = false;
+	}
+}
+
 static int rtw_pci_probe(struct pci_dev *pdev,
 			 const struct pci_device_id *id)
 {
@@ -1157,8 +1203,7 @@ static int rtw_pci_probe(struct pci_dev *pdev,
 		goto err_destroy_pci;
 	}
 
-	ret = request_irq(pdev->irq, &rtw_pci_interrupt_handler,
-			  IRQF_SHARED, KBUILD_MODNAME, rtwdev);
+	ret = rtw_pci_request_irq(rtwdev, pdev);
 	if (ret) {
 		ieee80211_unregister_hw(hw);
 		goto err_destroy_pci;
@@ -1197,7 +1242,7 @@ static void rtw_pci_remove(struct pci_dev *pdev)
 	rtw_pci_disable_interrupt(rtwdev, rtwpci);
 	rtw_pci_destroy(rtwdev, pdev);
 	rtw_pci_declaim(rtwdev, pdev);
-	free_irq(rtwpci->pdev->irq, rtwdev);
+	rtw_pci_free_irq(rtwdev, pdev);
 	rtw_core_deinit(rtwdev);
 	ieee80211_free_hw(hw);
 }
diff --git a/drivers/net/wireless/realtek/rtw88/pci.h b/drivers/net/wireless/realtek/rtw88/pci.h
index 87824a4..a8e369c 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.h
+++ b/drivers/net/wireless/realtek/rtw88/pci.h
@@ -186,6 +186,7 @@ struct rtw_pci {
 	spinlock_t irq_lock;
 	u32 irq_mask[4];
 	bool irq_enabled;
+	bool msi_enabled;
 
 	u16 rx_tag;
 	struct rtw_pci_tx_ring tx_rings[RTK_MAX_TX_QUEUE_NUM];
-- 
2.7.4

