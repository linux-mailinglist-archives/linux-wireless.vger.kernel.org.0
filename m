Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94E081C07F0
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Apr 2020 22:31:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726930AbgD3UbL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 30 Apr 2020 16:31:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:48744 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgD3UbL (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 30 Apr 2020 16:31:11 -0400
Received: from localhost.localdomain.com (unknown [151.48.155.206])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 71ABE20731;
        Thu, 30 Apr 2020 20:31:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588278670;
        bh=dodLZODMKGnV6dizLxKLvCaa2y0mojKga6d+qKIU/EU=;
        h=From:To:Cc:Subject:Date:From;
        b=GUvL0JcyRrqBEAyyQRUhuiGTBER6lt1uhJ0diovIg1MMijcv6rnPKikZUvB/0Ua2u
         krOdL+SO+sO4BVBBltmKhr9VbIPKu/Qp3j94sHRFByorotKjlrkuPbS5r4H61oU6hO
         dBiLs7vWShNxk6LRTR5D9XiPZP2ULXPPrd0cF4Kk=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
        sean.wang@mediatek.com, linux-mediatek@lists.infradead.org,
        soul.huang@mediatek.com
Subject: [PATCH] mt76: mt7615: free pci_vector if mt7615_pci_probe fails
Date:   Thu, 30 Apr 2020 22:31:03 +0200
Message-Id: <c82cae35e7f0a27644fec166049484edf73209a0.1588278305.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.25.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Always free pci irq vector if mt7615_pci_probe routine fails
Moreover free irq in mt7615_pci_remove routine

Co-developed-by: Soul Huang <sean.wang@mediatek.com>
Signed-off-by: Soul Huang <sean.wang@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index c53760a40cbb..05011b481885 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -39,13 +39,21 @@ static int mt7615_pci_probe(struct pci_dev *pdev,
 
 	ret = pci_set_dma_mask(pdev, DMA_BIT_MASK(32));
 	if (ret)
-		return ret;
+		goto error;
 
 	mt76_pci_disable_aspm(pdev);
 
 	map = id->device == 0x7663 ? mt7663e_reg_map : mt7615e_reg_map;
-	return mt7615_mmio_probe(&pdev->dev, pcim_iomap_table(pdev)[0],
-				 pdev->irq, map);
+	ret = mt7615_mmio_probe(&pdev->dev, pcim_iomap_table(pdev)[0],
+				pdev->irq, map);
+	if (ret)
+		goto error;
+
+	return 0;
+error:
+	pci_free_irq_vectors(pdev);
+
+	return ret;
 }
 
 static void mt7615_pci_remove(struct pci_dev *pdev)
@@ -54,6 +62,7 @@ static void mt7615_pci_remove(struct pci_dev *pdev)
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 
 	mt7615_unregister_device(dev);
+	devm_free_irq(&pdev->dev, pdev->irq, dev);
 	pci_free_irq_vectors(pdev);
 }
 
-- 
2.25.4

