Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CED2E3A4C51
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jun 2021 05:05:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229976AbhFLDBf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 11 Jun 2021 23:01:35 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57186 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229584AbhFLDBf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 11 Jun 2021 23:01:35 -0400
X-UUID: 854ef98a33a24aa5983fb67f7505aa44-20210612
X-UUID: 854ef98a33a24aa5983fb67f7505aa44-20210612
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 280069896; Sat, 12 Jun 2021 10:59:32 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs01n1.mediatek.inc (172.21.101.68) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 12 Jun 2021 10:59:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 12 Jun 2021 10:59:29 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo.bianconi@redhat.com>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Eric Liang <Eric.Liang@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>, <jemele@google.com>,
        <yenlinlai@google.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] mt76: mt7921: introduce PCIe ASPM support (L0s/L1/L1ss)
Date:   Sat, 12 Jun 2021 10:59:26 +0800
Message-ID: <eb6e8c6b45f3a8a71e9cff95108aff64d560cdc0.1623465371.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

for better power consumption, default enable PCIe ASPM

Tested-by: Leon Yen <Leon.Yen@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/pci.c   | 68 ++++++++++++++++++-
 1 file changed, 67 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 13263f50dc00..5358836bb00e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -88,6 +88,72 @@ static void mt7921_irq_tasklet(unsigned long data)
 		napi_schedule(&dev->mt76.napi[MT_RXQ_MAIN]);
 }
 
+static void mt7921_pci_config_L1(struct pci_dev *pdev, u8 enable)
+{
+	u32 reg32;
+	int pos;
+
+	if (!pdev)
+		return;
+
+	/* capability check */
+	pos = pdev->pcie_cap;
+	pci_read_config_dword(pdev, pos + PCI_EXP_LNKCAP, &reg32);
+	if (!(reg32 & PCI_EXP_LNKCAP_ASPMS)) {
+		dev_info(&pdev->dev, "ASPM L1: Invalid cap 0x%X\n", reg32);
+		return;
+	}
+
+	/* set config */
+	pci_read_config_dword(pdev, pos + PCI_EXP_LNKCTL, &reg32);
+	if (enable)
+		reg32 |= (PCI_EXP_LNKCTL_ASPMC);
+	else
+		reg32 &= ~(PCI_EXP_LNKCTL_ASPMC);
+	dev_dbg(&pdev->dev, "%s ASPM L1\n", (enable) ? "enable" : "disable");
+
+	pci_write_config_dword(pdev, pos + PCI_EXP_LNKCTL, reg32);
+}
+
+static void mt7921_pci_config_L1ss(struct pci_dev *pdev, u8 enable)
+{
+#define  PCIE_L1SS_CAP_CHK \
+		(PCI_L1SS_CAP_ASPM_L1_1 | PCI_L1SS_CAP_ASPM_L1_2)
+#define  PCIE_L1SS_CTL_CHK \
+		(PCI_L1SS_CTL1_ASPM_L1_1 | PCI_L1SS_CTL1_ASPM_L1_2)
+
+	int pos;
+	u32 reg32;
+
+	if (!pdev)
+		return;
+
+	/* capability check */
+	pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_L1SS);
+	pci_read_config_dword(pdev, pos + PCI_L1SS_CAP, &reg32);
+	if (!(reg32 & (PCIE_L1SS_CAP_CHK))) {
+		dev_info(&pdev->dev, "ASPM L1SS: Invalid cap 0x%X\n", reg32);
+		return;
+	}
+
+	/* set config */
+	pci_read_config_dword(pdev, pos + PCI_L1SS_CTL1, &reg32);
+	if (enable)
+		reg32 |= (PCIE_L1SS_CTL_CHK);
+	else
+		reg32 &= ~(PCIE_L1SS_CTL_CHK);
+
+	dev_dbg(&pdev->dev, "%s ASPM L1SS\n", (enable) ? "enable" : "disable");
+
+	pci_write_config_dword(pdev, pos + PCI_L1SS_CTL1, reg32);
+}
+
+void mt7921_pci_enable_aspm(struct pci_dev *pdev)
+{
+	mt7921_pci_config_L1ss(pdev, true);
+	mt7921_pci_config_L1(pdev, true);
+}
+
 static int mt7921_pci_probe(struct pci_dev *pdev,
 			    const struct pci_device_id *id)
 {
@@ -131,7 +197,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	if (ret)
 		goto err_free_pci_vec;
 
-	mt76_pci_disable_aspm(pdev);
+	mt7921_pci_enable_aspm(pdev);
 
 	mdev = mt76_alloc_device(&pdev->dev, sizeof(*dev), &mt7921_ops,
 				 &drv_ops);
-- 
2.18.0

