Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E6CC730C08C
	for <lists+linux-wireless@lfdr.de>; Tue,  2 Feb 2021 15:02:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233400AbhBBOBC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Feb 2021 09:01:02 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:46601 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233517AbhBBN6x (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Feb 2021 08:58:53 -0500
X-UUID: 1bd7727d9a9847e2bf0c0024e7f98203-20210202
X-UUID: 1bd7727d9a9847e2bf0c0024e7f98203-20210202
Received: from mtkmrs01.mediatek.inc [(172.21.131.159)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 250054803; Tue, 02 Feb 2021 21:58:02 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 2 Feb 2021 21:58:00 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 2 Feb 2021 21:58:00 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Shayne Chen <shayne.chen@mediatek.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] mt76: use PCI_VENDOR_ID_MEDIATEK to avoid open coded
Date:   Tue, 2 Feb 2021 21:57:59 +0800
Message-ID: <404c3c6be07d4c8b2a9a7297c387509b801e62a5.1612274129.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 4055448C08ED3A018B512A6FAED4963B84FC36D2EC8700AC96D435956B21B2082000:8
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Use PCI standard defines.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7603/pci.c | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7615/pci.c | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt76x0/pci.c | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt76x2/pci.c | 6 +++---
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 2 +-
 5 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/pci.c b/drivers/net/wireless/mediatek/mt76/mt7603/pci.c
index 06fa28f645f2..aa6cb668b012 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/pci.c
@@ -7,7 +7,7 @@
 #include "mt7603.h"
 
 static const struct pci_device_id mt76pci_device_table[] = {
-	{ PCI_DEVICE(0x14c3, 0x7603) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7603) },
 	{ },
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index 71487f532f36..11f169cdd603 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -13,9 +13,9 @@
 #include "mcu.h"
 
 static const struct pci_device_id mt7615_pci_device_table[] = {
-	{ PCI_DEVICE(0x14c3, 0x7615) },
-	{ PCI_DEVICE(0x14c3, 0x7663) },
-	{ PCI_DEVICE(0x14c3, 0x7611) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7615) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7663) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7611) },
 	{ },
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
index 02d0aa0b815e..5847f943e8da 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/pci.c
@@ -221,9 +221,9 @@ mt76x0e_remove(struct pci_dev *pdev)
 }
 
 static const struct pci_device_id mt76x0e_device_table[] = {
-	{ PCI_DEVICE(0x14c3, 0x7610) },
-	{ PCI_DEVICE(0x14c3, 0x7630) },
-	{ PCI_DEVICE(0x14c3, 0x7650) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7610) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7630) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7650) },
 	{ },
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
index ecaf85b483ac..adf288e50e21 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/pci.c
@@ -10,9 +10,9 @@
 #include "mt76x2.h"
 
 static const struct pci_device_id mt76x2e_device_table[] = {
-	{ PCI_DEVICE(0x14c3, 0x7662) },
-	{ PCI_DEVICE(0x14c3, 0x7612) },
-	{ PCI_DEVICE(0x14c3, 0x7602) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7662) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7612) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7602) },
 	{ },
 };
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 5570b4a50531..33ed952d7f4c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -13,7 +13,7 @@
 #include "../trace.h"
 
 static const struct pci_device_id mt7921_pci_device_table[] = {
-	{ PCI_DEVICE(0x14c3, 0x7961) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_MEDIATEK, 0x7961) },
 	{ },
 };
 
-- 
2.18.0

