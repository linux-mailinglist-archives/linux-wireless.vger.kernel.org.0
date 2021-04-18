Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5CD9A3636AC
	for <lists+linux-wireless@lfdr.de>; Sun, 18 Apr 2021 18:36:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbhDRQgv (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 18 Apr 2021 12:36:51 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:37103 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S232054AbhDRQgt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 18 Apr 2021 12:36:49 -0400
X-UUID: 3802aad607c84ac68da2ed5c0ee97734-20210419
X-UUID: 3802aad607c84ac68da2ed5c0ee97734-20210419
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1883573582; Mon, 19 Apr 2021 00:36:17 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 19 Apr 2021 00:36:09 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 19 Apr 2021 00:36:09 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <Eric.Liang@mediatek.com>,
        <Stella.Chang@mediatek.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH 6/6] mt76: mt7921: enable deep sleep when the device suspends
Date:   Mon, 19 Apr 2021 00:36:07 +0800
Message-ID: <1618763767-1292-7-git-send-email-sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <1618763767-1292-1-git-send-email-sean.wang@mediatek.com>
References: <1618763767-1292-1-git-send-email-sean.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

Enable the deep sleep mode in suspend handler to reduce the power
consumption further.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 40e2086d075c..277960b680bc 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -189,6 +189,9 @@ static int mt7921_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 			return err;
 	}
 
+	if (!dev->pm.enable)
+		mt76_connac_mcu_set_deep_sleep(&dev->mt76, true);
+
 	napi_disable(&mdev->tx_napi);
 	mt76_worker_disable(&mdev->tx_worker);
 
@@ -227,6 +230,10 @@ static int mt7921_pci_suspend(struct pci_dev *pdev, pm_message_t state)
 		napi_enable(&mdev->napi[i]);
 	}
 	napi_enable(&mdev->tx_napi);
+
+	if (!dev->pm.enable)
+		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
+
 	if (hif_suspend)
 		mt76_connac_mcu_set_hif_suspend(mdev, false);
 
@@ -249,6 +256,8 @@ static int mt7921_pci_resume(struct pci_dev *pdev)
 	if (err < 0)
 		return err;
 
+	mt7921_wpdma_reinit_cond(dev);
+
 	/* enable interrupt */
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
 	mt7921_irq_enable(dev, MT_INT_RX_DONE_ALL | MT_INT_TX_DONE_ALL |
@@ -266,6 +275,9 @@ static int mt7921_pci_resume(struct pci_dev *pdev)
 	napi_enable(&mdev->tx_napi);
 	napi_schedule(&mdev->tx_napi);
 
+	if (!dev->pm.enable)
+		mt76_connac_mcu_set_deep_sleep(&dev->mt76, false);
+
 	if (!test_bit(MT76_STATE_SUSPEND, &dev->mphy.state))
 		err = mt76_connac_mcu_set_hif_suspend(mdev, false);
 
-- 
2.25.1

