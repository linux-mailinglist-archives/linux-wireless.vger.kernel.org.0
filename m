Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 994C1A64DD
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2019 11:14:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727078AbfICJO1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 3 Sep 2019 05:14:27 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:42348 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726946AbfICJO1 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 3 Sep 2019 05:14:27 -0400
Authenticated-By: 
X-SpamFilter-By: BOX Solutions SpamTrap 5.62 with qID x839EFgE027807, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (RTITCASV01.realtek.com.tw[172.21.6.18])
        by rtits2.realtek.com.tw (8.15.2/2.57/5.78) with ESMTPS id x839EFgE027807
        (version=TLSv1 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
        Tue, 3 Sep 2019 17:14:15 +0800
Received: from localhost.localdomain (172.21.68.126) by
 RTITCASV01.realtek.com.tw (172.21.6.18) with Microsoft SMTP Server id
 14.3.468.0; Tue, 3 Sep 2019 17:14:14 +0800
From:   <yhchuang@realtek.com>
To:     <kvalo@codeaurora.org>
CC:     <linux-wireless@vger.kernel.org>, <jano.vesely@gmail.com>,
        <linux@endlessm.com>, <briannorris@chromium.org>,
        <gojun077@gmail.com>, <drake@endlessm.com>, <davem@davemloft.net>,
        <jian-hong@endlessm.com>
Subject: [PATCH rebased 2/2] rtw88: pci: enable MSI interrupt
Date:   Tue, 3 Sep 2019 17:14:07 +0800
Message-ID: <1567502047-24102-3-git-send-email-yhchuang@realtek.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1567502047-24102-1-git-send-email-yhchuang@realtek.com>
References: <1567502047-24102-1-git-send-email-yhchuang@realtek.com>
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
Reviewed-by: Daniel Drake <drake@endlessm.com>
Signed-off-by: Yu-Yen Ting <steventing@realtek.com>
Signed-off-by: Yan-Hsuan Chuang <yhchuang@realtek.com>
---
 drivers/net/wireless/realtek/rtw88/pci.c | 48 ++++++++++++++++++++++++++++----
 1 file changed, 43 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw88/pci.c b/drivers/net/wireless/realtek/rtw88/pci.c
index 955dd6c..3fdb52a 100644
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
@@ -873,6 +877,11 @@ static irqreturn_t rtw_pci_interrupt_handler(int irq, void *dev)
 
 	/* disable RTW PCI interrupt to avoid more interrupts before the end of
 	 * thread function
+	 *
+	 * disable HIMR here to also avoid new HISR flag being raised before
+	 * the HISRs have been Write-1-cleared for MSI. If not all of the HISRs
+	 * are cleared, the edge-triggered interrupt will not be generated when
+	 * a new HISR flag is set.
 	 */
 	rtw_pci_disable_interrupt(rtwdev, rtwpci);
 out:
@@ -1116,6 +1125,38 @@ static struct rtw_hci_ops rtw_pci_ops = {
 	.write_data_h2c = rtw_pci_write_data_h2c,
 };
 
+static int rtw_pci_request_irq(struct rtw_dev *rtwdev, struct pci_dev *pdev)
+{
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
+	ret = devm_request_threaded_irq(rtwdev->dev, pdev->irq,
+					rtw_pci_interrupt_handler,
+					rtw_pci_interrupt_threadfn,
+					IRQF_SHARED, KBUILD_MODNAME, rtwdev);
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
+	devm_free_irq(rtwdev->dev, pdev->irq, rtwdev);
+	pci_free_irq_vectors(pdev);
+}
+
 static int rtw_pci_probe(struct pci_dev *pdev,
 			 const struct pci_device_id *id)
 {
@@ -1170,10 +1211,7 @@ static int rtw_pci_probe(struct pci_dev *pdev,
 		goto err_destroy_pci;
 	}
 
-	ret = devm_request_threaded_irq(rtwdev->dev, pdev->irq,
-					rtw_pci_interrupt_handler,
-					rtw_pci_interrupt_threadfn,
-					IRQF_SHARED, KBUILD_MODNAME, rtwdev);
+	ret = rtw_pci_request_irq(rtwdev, pdev);
 	if (ret) {
 		ieee80211_unregister_hw(hw);
 		goto err_destroy_pci;
@@ -1212,7 +1250,7 @@ static void rtw_pci_remove(struct pci_dev *pdev)
 	rtw_pci_disable_interrupt(rtwdev, rtwpci);
 	rtw_pci_destroy(rtwdev, pdev);
 	rtw_pci_declaim(rtwdev, pdev);
-	devm_free_irq(rtwdev->dev, rtwpci->pdev->irq, rtwdev);
+	rtw_pci_free_irq(rtwdev, pdev);
 	rtw_core_deinit(rtwdev);
 	ieee80211_free_hw(hw);
 }
-- 
2.7.4

