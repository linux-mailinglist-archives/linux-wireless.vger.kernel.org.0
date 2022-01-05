Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA322485B8C
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jan 2022 23:20:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244830AbiAEWUU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Jan 2022 17:20:20 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:37246 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244842AbiAEWUT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Jan 2022 17:20:19 -0500
X-UUID: 007680299d324c6a9313b373f37e236d-20220106
X-UUID: 007680299d324c6a9313b373f37e236d-20220106
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 249399498; Thu, 06 Jan 2022 06:20:16 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 6 Jan 2022 06:20:15 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 6 Jan
 2022 06:20:14 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 6 Jan 2022 06:20:14 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Mark-YW.Chen@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <jenhao.yang@mediatek.com>, <robin.chiu@mediatek.com>,
        <Eddie.Chen@mediatek.com>, <ch.yeh@mediatek.com>,
        <posh.sun@mediatek.com>, <ted.huang@mediatek.com>,
        <Eric.Liang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <jemele@google.com>,
        <abhishekpandit@google.com>, <shawnku@google.com>,
        <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>,
        "Deren Wu" <deren.wu@mediatek.com>
Subject: [PATCH] mt76: mt7921e: fix reset failure in mt7921_pci_probe
Date:   Thu, 6 Jan 2022 06:20:13 +0800
Message-ID: <77cd7840525c8c967ced523bcc954471930e17c5.1641420635.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

Ensure that the device returns to the driver's own state to switch ASPM
into the active state before we start resetting the device to fix
the following kernel panic.

[   17.164952]  dump_stack_lvl+0x48/0x5e
[   17.164955]  bad_page.cold+0x63/0x94
[   17.164957]  free_pcppages_bulk+0x1f2/0x360
[   17.164961]  free_unref_page+0xb4/0x120
[   17.164963]  mt76_dma_rx_cleanup+0x94/0x110 [mt76]
[   17.164969]  mt7921_wpdma_reset+0xbc/0x1c0 [mt7921e]
[   17.164972]  mt7921_register_device+0x32b/0x5d0 [mt7921_common]
[   17.164976]  mt7921_pci_probe+0x1d5/0x210 [mt7921e]
[   17.164977]  ? __pm_runtime_resume+0x58/0x80
[   17.164979]  local_pci_probe+0x45/0x80
[   17.164981]  ? pci_match_device+0xac/0x130
[   17.164983]  pci_device_probe+0xd2/0x1c0
[   17.164984]  really_probe+0x1f5/0x3f0
[   17.164987]  __driver_probe_device+0xfe/0x180
[   17.164988]  driver_probe_device+0x1e/0x90
[   17.164990]  __driver_attach+0xc0/0x1c0
[   17.164991]  ? __device_attach_driver+0xe0/0xe0
[   17.164992]  ? __device_attach_driver+0xe0/0xe0
[   17.164994]  bus_for_each_dev+0x78/0xc0
[   17.164995]  new_id_store+0xfc/0x1d0
[   17.164996]  kernfs_fop_write_iter+0x11c/0x1b0
[   17.164998]  new_sync_write+0x11f/0x1b0
[   17.165001]  vfs_write+0x209/0x2a0
[   17.165003]  ksys_write+0x5f/0xe0
[   17.165004]  do_syscall_64+0x3b/0xc0
[   17.165006]

Fixes: bf3747ae2e25 ("mt76: mt7921: enable aspm by default")
Reported-by: Kai-Chuan Hsieh <kaichuan.hsieh@canonical.com>
Co-developed-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Sean Wang <sean.wang@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7921/dma.c    |  4 ++++
 .../net/wireless/mediatek/mt76/mt7921/mt7921.h |  1 +
 .../wireless/mediatek/mt76/mt7921/pci_mcu.c    | 18 ++++++++++++++----
 3 files changed, 19 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index cdff1fd52d93..0c4b0e0e634a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -364,6 +364,10 @@ int mt7921_dma_init(struct mt7921_dev *dev)
 	if (ret)
 		return ret;
 
+	ret = __mt7921e_mcu_drv_pmctrl(dev);
+	if (ret)
+		return ret;
+
 	ret = mt7921_wfsys_reset(dev);
 	if (ret)
 		return ret;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 8b674e042568..63e3c7ef5e89 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -443,6 +443,7 @@ int mt7921e_mcu_init(struct mt7921_dev *dev);
 int mt7921s_wfsys_reset(struct mt7921_dev *dev);
 int mt7921s_mac_reset(struct mt7921_dev *dev);
 int mt7921s_init_reset(struct mt7921_dev *dev);
+int __mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev);
 int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev);
 int mt7921e_mcu_fw_pmctrl(struct mt7921_dev *dev);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
index f9e350b67fdc..36669e5aeef3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
@@ -59,10 +59,8 @@ int mt7921e_mcu_init(struct mt7921_dev *dev)
 	return err;
 }
 
-int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev)
+int __mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev)
 {
-	struct mt76_phy *mphy = &dev->mt76.phy;
-	struct mt76_connac_pm *pm = &dev->pm;
 	int i, err = 0;
 
 	for (i = 0; i < MT7921_DRV_OWN_RETRY_COUNT; i++) {
@@ -75,9 +73,21 @@ int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev)
 	if (i == MT7921_DRV_OWN_RETRY_COUNT) {
 		dev_err(dev->mt76.dev, "driver own failed\n");
 		err = -EIO;
-		goto out;
 	}
 
+	return err;
+}
+
+int mt7921e_mcu_drv_pmctrl(struct mt7921_dev *dev)
+{
+	struct mt76_phy *mphy = &dev->mt76.phy;
+	struct mt76_connac_pm *pm = &dev->pm;
+	int err;
+
+	err = __mt7921e_mcu_drv_pmctrl(dev);
+	if (err < 0)
+		goto out;
+
 	mt7921_wpdma_reinit_cond(dev);
 	clear_bit(MT76_STATE_PM, &mphy->state);
 
-- 
2.25.1

