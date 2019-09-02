Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 53476A4F71
	for <lists+linux-wireless@lfdr.de>; Mon,  2 Sep 2019 09:02:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729476AbfIBHCv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 2 Sep 2019 03:02:51 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:38285 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729328AbfIBHCv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 2 Sep 2019 03:02:51 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x8272fLK019664, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x8272fLK019664
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Mon, 2 Sep 2019 15:02:41 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Mon, 2 Sep 2019 15:02:40 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <jano.vesely@gmail.com>,
        <drake@endlessm.com>, <linux@endlessm.com>,
        <briannorris@chromium.org>, <gojun077@gmail.com>
Subject: [PATCH v3] rtw88: pci: enable MSI interrupt
Date:   Mon, 2 Sep 2019 15:02:37 +0800
Message-ID: <1567407757-26951-1-git-send-email-yhchuang@realtek.com>
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

v2 -> v3
    * pci_enable_msi() is deprecated, use pci_alloc_irq_vectors()
    * Add a comment to describe why it is required to disable HIMR


 drivers/net/wireless/realtek/rtw88/pci.c | 50 ++++++++++++++++++++++++++++++--
 1 file changed, 47 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 00ef229..f13a325 100644
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
@@ -872,6 +876,12 @@ static irqreturn_t rtw_pci_interrupt_handler(int irq, void *dev)
 	if (!rtwpci->irq_enabled)
 		goto out;
 
+	/* Disable HIMR here to avoid new HISR flag being raised before
+	 * the HISRs have been Write-1-cleared. If not all of the HISRs
+	 * are cleared, interrupt will not be generated when a new HISR
+	 * flag is set.
+	 */
+	rtw_pci_disable_interrupt(rtwdev, rtwpci);
 	rtw_pci_irq_recognized(rtwdev, rtwpci, irq_status);
 
 	if (irq_status[0] & IMR_MGNTDOK)
@@ -891,6 +901,8 @@ static irqreturn_t rtw_pci_interrupt_handler(int irq, void *dev)
 	if (irq_status[0] & IMR_ROK)
 		rtw_pci_rx_isr(rtwdev, rtwpci, RTW_RX_QUEUE_MPDU);
 
+	rtw_pci_enable_interrupt(rtwdev, rtwpci);
+
 out:
 	spin_unlock(&rtwpci->irq_lock);
 
@@ -1098,6 +1110,39 @@ static struct rtw_hci_ops rtw_pci_ops = {
 	.write_data_h2c = rtw_pci_write_data_h2c,
 };
 
+static int rtw_pci_request_irq(struct rtw_dev *rtwdev, struct pci_dev *pdev)
+{
+	struct rtw_pci *rtwpci = (struct rtw_pci *)rtwdev->priv;
+	unsigned int flags = PCI_IRQ_LEGACY;
+	int ret;
+
+	if (!rtw_disable_msi)
+		flags |= PCI_IRQ_MSI;
+
+	ret = pci_alloc_irq_vectors(pdev, 1, 1, flags);
+	if (ret < 0) {
+		rtw_err(rtwdev, "failed to alloc PCI irq vectors\n");
+		return ret;
+	}
+
+	ret = request_irq(pdev->irq, &rtw_pci_interrupt_handler, IRQF_SHARED,
+			  KBUILD_MODNAME, rtwdev);
+	if (ret) {
+		rtw_err(rtwdev, "failed to request irq %d\n", ret);
+		pci_free_irq_vectors(pdev);
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
+	pci_free_irq_vectors(pdev);
+}
+
 static int rtw_pci_probe(struct pci_dev *pdev,
 			 const struct pci_device_id *id)
 {
@@ -1152,8 +1197,7 @@ static int rtw_pci_probe(struct pci_dev *pdev,
 		goto err_destroy_pci;
 	}
 
-	ret = request_irq(pdev->irq, &rtw_pci_interrupt_handler,
-			  IRQF_SHARED, KBUILD_MODNAME, rtwdev);
+	ret = rtw_pci_request_irq(rtwdev, pdev);
 	if (ret) {
 		ieee80211_unregister_hw(hw);
 		goto err_destroy_pci;
@@ -1192,7 +1236,7 @@ static void rtw_pci_remove(struct pci_dev *pdev)
 	rtw_pci_disable_interrupt(rtwdev, rtwpci);
 	rtw_pci_destroy(rtwdev, pdev);
 	rtw_pci_declaim(rtwdev, pdev);
-	free_irq(rtwpci->pdev->irq, rtwdev);
+	rtw_pci_free_irq(rtwdev, pdev);
 	rtw_core_deinit(rtwdev);
 	ieee80211_free_hw(hw);
 }
-- 
2.7.4

