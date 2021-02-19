Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0C7F531FDDF
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Feb 2021 18:30:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229612AbhBSR3t (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 19 Feb 2021 12:29:49 -0500
Received: from mail.kernel.org ([198.145.29.99]:35634 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229527AbhBSR3s (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 19 Feb 2021 12:29:48 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7787D64E67;
        Fri, 19 Feb 2021 17:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1613755747;
        bh=1t6UTvx50xvqCkdpT4bFv7MmuhSZd3CsIoPC0skkdpE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=lmX8DLHKFquhJxhJ5dQMD/WCg4q+PDlmTrKIbU7R45UUpezF6B1x3/xVI4++vnd+J
         fmE9tFP3X3UUoQDXdbEu3K6FGhjddroRTaoRLliAVZRSubSILUZQXQn1p1wUfuC8E+
         hwIKO+p9Tnn/YZbEyjN3ktLFA8uOGsVn3xpFsldXzoVk0zHDwebR5yuoIm36rSqZXB
         VSTXmglG9Ja4VvCXuJ7h3wIgi6CkqzuBiZvNhLvSNpGNw8DqLYOaNHrxfR5pbPZjEh
         DVqhqbwMi/VjfAAUmUubWnV+LhgZ5de6/gBCYm8tKRBuvHbIkFz97MKptK8naAWm6n
         RJmnCuwFxu1mw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com
Subject: [PATCH v2 1/8] mt76: mt7921: fix suspend/resume sequence
Date:   Fri, 19 Feb 2021 18:28:44 +0100
Message-Id: <a16519dbd5b325376f473bde943e19bf2ade1b16.1613755428.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.29.2
In-Reply-To: <cover.1613755428.git.lorenzo@kernel.org>
References: <cover.1613755428.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Any pcie access should happen in pci D0 state and we should give ownership
back to the device at the end of the suspend procedure.

Fixes: 1d8efc741df80 ("mt76: mt7921: introduce Runtime PM support")
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 33ed952d7f4c..3e430c04c97e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -209,12 +209,12 @@ static int mt7921_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 	/* disable interrupt */
 	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
 
-	pci_save_state(pdev);
-	err = pci_set_power_state(pdev, pci_choose_state(pdev, state));
+	err = mt7921_mcu_fw_pmctrl(dev);
 	if (err)
 		goto restore;
 
-	err = mt7921_mcu_drv_pmctrl(dev);
+	pci_save_state(pdev);
+	err = pci_set_power_state(pdev, pci_choose_state(pdev, state));
 	if (err)
 		goto restore;
 
@@ -237,16 +237,16 @@ static int mt7921_pci_resume(struct pci_dev *pdev)
 	struct mt7921_dev *dev = container_of(mdev, struct mt7921_dev, mt76);
 	int i, err;
 
-	err = mt7921_mcu_fw_pmctrl(dev);
-	if (err < 0)
-		return err;
-
 	err = pci_set_power_state(pdev, PCI_D0);
 	if (err)
 		return err;
 
 	pci_restore_state(pdev);
 
+	err = mt7921_mcu_drv_pmctrl(dev);
+	if (err < 0)
+		return 0;
+
 	/* enable interrupt */
 	mt7921_l1_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
 	mt7921_irq_enable(dev, MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
-- 
2.29.2

