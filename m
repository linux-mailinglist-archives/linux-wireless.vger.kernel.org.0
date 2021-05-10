Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 42CCE377CF4
	for <lists+linux-wireless@lfdr.de>; Mon, 10 May 2021 09:13:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230076AbhEJHOO (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 10 May 2021 03:14:14 -0400
Received: from mail.kernel.org ([198.145.29.99]:49526 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230002AbhEJHON (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 10 May 2021 03:14:13 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 9CF74613CF;
        Mon, 10 May 2021 07:13:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1620630789;
        bh=r9/cmkeR3EIP1X6TWC0Kc0k8moKXXtVvBLHLccZAkfA=;
        h=From:To:Cc:Subject:Date:From;
        b=HnyXRBC/DqkS9q6I7ux50QspbPmpidlWGr+1I4glFYYkjhTmspNTummnz0+P8oZq7
         8bWPTSgJuO8R0xggk2L7g04QsgsWkyunyrjVa5GArgz0ekh8wE1uvqahxdG/kBNaVA
         BHrCjou9IEP4Mj4MfGkf9xZtfkHjzbb//yCpbl/Nj2os6GjFqXawYTxuKqV7vyYc/M
         OcqmUrGi8PBaukLo7le2JtXr/CZ7wSAsrNMPHTFKCGLHYAbhbSJp0i0wVejjDdTmxn
         MTC4VdUBqIjU3rDzfmfePzQVghyhKvvnmKsGYOFLW/RSU0ze3c8rreSUDs6gIbw79U
         v+JVC7EnId43w==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt7615: free irq if mt7615_mmio_probe fails
Date:   Mon, 10 May 2021 09:13:03 +0200
Message-Id: <559b31b35db0e85646b79bc4e40047a00548e3ac.1620630693.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

As already done for mt7915 and mt7921, free registered irq line if
mt7615_mmio_probe routine fails

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mmio.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
index 202ea235415e..71719c787511 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mmio.c
@@ -229,7 +229,7 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 			       GFP_KERNEL);
 	if (!bus_ops) {
 		ret = -ENOMEM;
-		goto error;
+		goto err_free_dev;
 	}
 
 	bus_ops->rr = mt7615_rr;
@@ -242,17 +242,20 @@ int mt7615_mmio_probe(struct device *pdev, void __iomem *mem_base,
 	ret = devm_request_irq(mdev->dev, irq, mt7615_irq_handler,
 			       IRQF_SHARED, KBUILD_MODNAME, dev);
 	if (ret)
-		goto error;
+		goto err_free_dev;
 
 	if (is_mt7663(mdev))
 		mt76_wr(dev, MT_PCIE_IRQ_ENABLE, 1);
 
 	ret = mt7615_register_device(dev);
 	if (ret)
-		goto error;
+		goto err_free_irq;
 
 	return 0;
-error:
+
+err_free_irq:
+	devm_free_irq(pdev, irq, dev);
+err_free_dev:
 	mt76_free_device(&dev->mt76);
 
 	return ret;
-- 
2.31.1

