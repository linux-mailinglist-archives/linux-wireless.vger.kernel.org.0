Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E22E1FF9D1
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jun 2020 19:00:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728704AbgFRRAa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Jun 2020 13:00:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:33486 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728080AbgFRRA3 (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Jun 2020 13:00:29 -0400
Received: from localhost.localdomain.com (unknown [151.48.140.182])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 07BB7206D7;
        Thu, 18 Jun 2020 17:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592499628;
        bh=tMRO/RFU6HHXBePe/w4U5Y1kSJGQ6ZqEuU+sCC6EYAQ=;
        h=From:To:Cc:Subject:Date:From;
        b=Xbxa7l/C83v+C/OMw1s0JN4+HbksOKz2ydRzK0tJj+x8wqt9huRyZuRa4ZzwbCNwQ
         oz+eKWjdWlh/jixbq5exyVQhBReeO2wV9O474D9xzG4cC6U79DeHoH4ss/+6GKWQbn
         tnUGeP6MNhVmhAaPXo1VyjLgjko+C9Mh8Qh7jvBo=
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH] mt76: mt76x2e: rename routines in pci.c
Date:   Thu, 18 Jun 2020 19:00:23 +0200
Message-Id: <bd34279723e2e22f8d06a54a9e8e09c29a56c494.1592499508.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.26.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rely on mt76x2e prefix in mt76x2/pci.c and align to the rest of
mt76 code

Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
index 53ca0cedf026..f36c71c1bc58 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
@@ -9,7 +9,7 @@
 
 #include "mt76x2.h"
 
-static const struct pci_device_id mt76pci_device_table[] = {
+static const struct pci_device_id mt76x2e_device_table[] = {
 	{ PCI_DEVICE(0x14c3, 0x7662) },
 	{ PCI_DEVICE(0x14c3, 0x7612) },
 	{ PCI_DEVICE(0x14c3, 0x7602) },
@@ -17,7 +17,7 @@ static const struct pci_device_id mt76pci_device_table[] = {
 };
 
 static int
-mt76pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+mt76x2e_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 {
 	static const struct mt76_driver_ops drv_ops = {
 		.txwi_size = sizeof(struct mt76x02_txwi),
@@ -93,7 +93,7 @@ mt76pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 }
 
 static void
-mt76pci_remove(struct pci_dev *pdev)
+mt76x2e_remove(struct pci_dev *pdev)
 {
 	struct mt76_dev *mdev = pci_get_drvdata(pdev);
 	struct mt76x02_dev *dev = container_of(mdev, struct mt76x02_dev, mt76);
@@ -103,16 +103,16 @@ mt76pci_remove(struct pci_dev *pdev)
 	mt76_free_device(mdev);
 }
 
-MODULE_DEVICE_TABLE(pci, mt76pci_device_table);
+MODULE_DEVICE_TABLE(pci, mt76x2e_device_table);
 MODULE_FIRMWARE(MT7662_FIRMWARE);
 MODULE_FIRMWARE(MT7662_ROM_PATCH);
 MODULE_LICENSE("Dual BSD/GPL");
 
 static struct pci_driver mt76pci_driver = {
 	.name		= KBUILD_MODNAME,
-	.id_table	= mt76pci_device_table,
-	.probe		= mt76pci_probe,
-	.remove		= mt76pci_remove,
+	.id_table	= mt76x2e_device_table,
+	.probe		= mt76x2e_probe,
+	.remove		= mt76x2e_remove,
 };
 
 module_pci_driver(mt76pci_driver);
-- 
2.26.2

