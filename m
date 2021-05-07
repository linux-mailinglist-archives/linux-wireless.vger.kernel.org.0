Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 83E5B37690E
	for <lists+linux-wireless@lfdr.de>; Fri,  7 May 2021 18:50:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238418AbhEGQv3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 7 May 2021 12:51:29 -0400
Received: from mail.kernel.org ([198.145.29.99]:46264 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233797AbhEGQv2 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 7 May 2021 12:51:28 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8BF8E61008;
        Fri,  7 May 2021 16:50:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620406228;
        bh=h0NjiP6huaR2fcV3rn43tyHR6+TzHz9fGQ6UL5P0nbU=;
        h=From:To:Cc:Subject:Date:From;
        b=KClsT50XtT9AAjyi3PmB3wTbD61MU20Q9H0oMZgggzxh8ST3plKdPDEIoDndntBoz
         USsMYTS8G3oqR4Cu2yqt5kXaIokDRneMF0e9w7iNmFhNJQxDV/ed7gA3Tmy6nm628x
         Liwbo2Y+RYNqsGKHWBrJTZ0kmpTha64lFrkaKrwzWJAT4HjGhaUijE0Vlb8h+9LYof
         8LxK1zrQH49ZlgYT4XvIdwInZxIgjFfZ2pMLdvUgcd0RFgRwjbCVTkQBQpqMBHDTwW
         +MtiJj3TA7EW83WsWixUiXxRb4+rQ6CGMOHrmmdT+QsphuJU/X3KI3RArGtTJx+c2C
         9YHIk6+UV1SpA==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        luca.trombin@gmail.com, stf_xl@wp.pl
Subject: [PATCH 5.13] mt76: mt76x0e: fix device hang during suspend/resume
Date:   Fri,  7 May 2021 18:50:19 +0200
Message-Id: <4812f9611624b34053c1592fd9c175b67d4ffcb4.1620406022.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Similar to usb device, re-initialize mt76x0e device after resume in order
to fix mt7630e hang during suspend/resume

Reported-by: Luca Trombin <luca.trombin@gmail.com>
Fixes: c2a4d9fbabfb9 ("mt76x0: inital split between pci and usb")
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 .../net/wireless/mediatek/mt76/mt76x0/pci.c   | 81 ++++++++++++++++++-
 1 file changed, 77 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index 5847f943e8da..b795e7245c07 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -87,7 +87,7 @@ static const struct ieee80211_ops mt76x0e_ops = {
 	.reconfig_complete = mt76x02_reconfig_complete,
 };
 
-static int mt76x0e_register_device(struct mt76x02_dev *dev)
+static int mt76x0e_init_hardware(struct mt76x02_dev *dev, bool resume)
 {
 	int err;
 
@@ -100,9 +100,11 @@ static int mt76x0e_register_device(struct mt76x02_dev *dev)
 	if (err < 0)
 		return err;
 
-	err = mt76x02_dma_init(dev);
-	if (err < 0)
-		return err;
+	if (!resume) {
+		err = mt76x02_dma_init(dev);
+		if (err < 0)
+			return err;
+	}
 
 	err = mt76x0_init_hardware(dev);
 	if (err < 0)
@@ -123,6 +125,17 @@ static int mt76x0e_register_device(struct mt76x02_dev *dev)
 	mt76_clear(dev, 0x110, BIT(9));
 	mt76_set(dev, MT_MAX_LEN_CFG, BIT(13));
 
+	return 0;
+}
+
+static int mt76x0e_register_device(struct mt76x02_dev *dev)
+{
+	int err;
+
+	err = mt76x0e_init_hardware(dev, false);
+	if (err < 0)
+		return err;
+
 	err = mt76x0_register_device(dev);
 	if (err < 0)
 		return err;
@@ -167,6 +180,8 @@ mt76x0e_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (ret)
 		return ret;
 
+	mt76_pci_disable_aspm(pdev);
+
 	mdev = mt76_alloc_device(&pdev->dev, sizeof(*dev), &mt76x0e_ops,
 				 &drv_ops);
 	if (!mdev)
@@ -220,6 +235,60 @@ mt76x0e_remove(struct pci_dev *pdev)
 	mt76_free_device(mdev);
 }
 
+#ifdef CONFIG_PM
+static int mt76x0e_suspend(struct pci_dev *pdev, pm_message_t state)
+{
+	struct mt76_dev *mdev = pci_get_drvdata(pdev);
+	struct mt76x02_dev *dev = container_of(mdev, struct mt76x02_dev, mt76);
+	int i;
+
+	mt76_worker_disable(&mdev->tx_worker);
+	for (i = 0; i < ARRAY_SIZE(mdev->phy.q_tx); i++)
+		mt76_queue_tx_cleanup(dev, mdev->phy.q_tx[i], true);
+	for (i = 0; i < ARRAY_SIZE(mdev->q_mcu); i++)
+		mt76_queue_tx_cleanup(dev, mdev->q_mcu[i], true);
+	napi_disable(&mdev->tx_napi);
+
+	mt76_for_each_q_rx(mdev, i)
+		napi_disable(&mdev->napi[i]);
+
+	mt76x02_dma_disable(dev);
+	mt76x02_mcu_cleanup(dev);
+	mt76x0_chip_onoff(dev, false, false);
+
+	pci_enable_wake(pdev, pci_choose_state(pdev, state), true);
+	pci_save_state(pdev);
+
+	return pci_set_power_state(pdev, pci_choose_state(pdev, state));
+}
+
+static int mt76x0e_resume(struct pci_dev *pdev)
+{
+	struct mt76_dev *mdev = pci_get_drvdata(pdev);
+	struct mt76x02_dev *dev = container_of(mdev, struct mt76x02_dev, mt76);
+	int err, i;
+
+	err = pci_set_power_state(pdev, PCI_D0);
+	if (err)
+		return err;
+
+	pci_restore_state(pdev);
+
+	mt76_worker_enable(&mdev->tx_worker);
+
+	mt76_for_each_q_rx(mdev, i) {
+		mt76_queue_rx_reset(dev, i);
+		napi_enable(&mdev->napi[i]);
+		napi_schedule(&mdev->napi[i]);
+	}
+
+	napi_enable(&mdev->tx_napi);
+	napi_schedule(&mdev->tx_napi);
+
+	return mt76x0e_init_hardware(dev, true);
+}
+#endif /* CONFIG_PM */
+
 static const struct pci_device_id mt76x0e_device_table[] = {
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7610) },
 	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7630) },
@@ -237,6 +306,10 @@ static struct pci_driver mt76x0e_driver = {
 	.id_table	= mt76x0e_device_table,
 	.probe		= mt76x0e_probe,
 	.remove		= mt76x0e_remove,
+#ifdef CONFIG_PM
+	.suspend	= mt76x0e_suspend,
+	.resume		= mt76x0e_resume,
+#endif /* CONFIG_PM */
 };
 
 module_pci_driver(mt76x0e_driver);
-- 
2.30.2

