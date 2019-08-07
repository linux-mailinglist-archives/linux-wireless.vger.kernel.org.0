Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 873EB8475A
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2019 10:28:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387677AbfHGI2W (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 7 Aug 2019 04:28:22 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:49720 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387414AbfHGI2V (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 7 Aug 2019 04:28:21 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x778SA2N001994, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x778SA2N001994
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Wed, 7 Aug 2019 16:28:10 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.439.0; Wed, 7 Aug 2019 16:28:10 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <briannorris@chromium.org>,
        <jano.vesely@gmail.com>, <gojun077@gmail.com>
Subject: [PATCH v2] rtw88: pci: enable MSI interrupt
Date:   Wed, 7 Aug 2019 16:28:07 +0800
Message-ID: <1565166487-22048-1-git-send-email-yhchuang@realtek.com>
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

One could rebind the PCI device, probe() will pick up the
new value of the module parameter. Such as:

    echo '0000:01:00.0' > /sys/bus/pci/drivers/rtw_pci/unbind
    echo '0000:01:00.0' > /sys/bus/pci/drivers/rtw_pci/bind

Tested-by: Ján Veselý <jano.vesely@gmail.com>
Reviewed-by: Brian Norris <briannorris@chromium.org>
Signed-off-by: Yu-Yen Ting <steventing@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---

v1 -> v2
    * Module parameter file mode change from 0444 to 0644
      This allows to change interrupt mode at run-time,
      as user rebind the PCI device
    * Print out returned value for pci_enable_msi(), as the
      value is not going to be returned to upper stacks
    * Print out request_irq() return value if it failed

 drivers/net/wireless/realtek/rtw88/pci.c | 52 ++++++++++++++++++++++++++++++--
 drivers/net/wireless/realtek/rtw88/pci.h |  1 +
 2 files changed, 50 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 00ef229..c8c7951 100644
--- a/drivers/net/wireless/realtek/rtw88/pci.c
+++ b/drivers/net/wireless/realtek/rtw88/pci.c
@@ -11,6 +11,10 @@
 #include "fw.h"
 #include "debug.h"
 
+static bool rtw_disable_msi;
+module_param_named(disable_msi, rtw_disable_msi, bool, 0644);
+MODULE_PARM_DESC(disable_msi, "Set Y to disable MSI interrupt support");
+
 static u32 rtw_pci_tx_queue_idx_addr[] = {
 	[RTW_TX_QUEUE_BK]	= RTK_PCI_TXBD_IDX_BKQ,
 	[RTW_TX_QUEUE_BE]	= RTK_PCI_TXBD_IDX_BEQ,
@@ -872,6 +876,7 @@ static irqreturn_t rtw_pci_interrupt_handler(int irq, void *dev)
 	if (!rtwpci->irq_enabled)
 		goto out;
 
+	rtw_pci_disable_interrupt(rtwdev, rtwpci);
 	rtw_pci_irq_recognized(rtwdev, rtwpci, irq_status);
 
 	if (irq_status[0] & IMR_MGNTDOK)
@@ -891,6 +896,8 @@ static irqreturn_t rtw_pci_interrupt_handler(int irq, void *dev)
 	if (irq_status[0] & IMR_ROK)
 		rtw_pci_rx_isr(rtwdev, rtwpci, RTW_RX_QUEUE_MPDU);
 
+	rtw_pci_enable_interrupt(rtwdev, rtwpci);
+
 out:
 	spin_unlock(&rtwpci->irq_lock);
 
@@ -1098,6 +1105,46 @@ static struct rtw_hci_ops rtw_pci_ops = {
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
+			rtw_warn(rtwdev, "failed to enable msi %d, using legacy irq\n",
+				 ret);
+		} else {
+			rtw_warn(rtwdev, "pci msi enabled\n");
+			rtwpci->msi_enabled = true;
+		}
+	}
+
+	ret = request_irq(pdev->irq, &rtw_pci_interrupt_handler, IRQF_SHARED,
+			  KBUILD_MODNAME, rtwdev);
+	if (ret) {
+		rtw_err(rtwdev, "failed to request irq %d\n", ret);
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
@@ -1152,8 +1199,7 @@ static int rtw_pci_probe(struct pci_dev *pdev,
 		goto err_destroy_pci;
 	}
 
-	ret = request_irq(pdev->irq, &rtw_pci_interrupt_handler,
-			  IRQF_SHARED, KBUILD_MODNAME, rtwdev);
+	ret = rtw_pci_request_irq(rtwdev, pdev);
 	if (ret) {
 		ieee80211_unregister_hw(hw);
 		goto err_destroy_pci;
@@ -1192,7 +1238,7 @@ static void rtw_pci_remove(struct pci_dev *pdev)
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

