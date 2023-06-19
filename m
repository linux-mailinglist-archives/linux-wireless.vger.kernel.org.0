Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 13E27734C79
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jun 2023 09:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbjFSHlZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 19 Jun 2023 03:41:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229731AbjFSHlY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 19 Jun 2023 03:41:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E80C1AA
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jun 2023 00:41:17 -0700 (PDT)
X-UUID: a63e53a00e7411eeb20a276fd37b9834-20230619
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=XpPAXdZWGQIrqNBHqD+QC0XMfQbFfP8Uk2wqiCW0ibs=;
        b=ESsP6/0MK2ekcpXDttg5/m01CQbBqtmByRQLQiisuYaKxtVjjLItsj87beNAju/KRk1M4LeORGOc2APXl/Ue3Cz7GQ8oG/5TldRPHpqWnbtbB09jtRKo9wkMUJW93EWfVdlECv2ZuiuAPYEo/Fh6a9U8tWslwGrkxFEdQ392rCY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.26,REQID:f06227d9-96e9-40bd-b6c7-f838b10fbe6f,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:cb9a4e1,CLOUDID:4891e03e-de1e-4348-bc35-c96f92f1dcbb,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: a63e53a00e7411eeb20a276fd37b9834-20230619
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 485197378; Mon, 19 Jun 2023 15:41:06 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.186) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 19 Jun 2023 15:41:06 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 19 Jun 2023 15:41:06 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Leon Yen <leon.yen@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921e: fix init command fail with enabled device
Date:   Mon, 19 Jun 2023 15:40:15 +0800
Message-ID: <19f1aae1ab9ea867eb42742fc5b72ed4d7307b0a.1687159671.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Quan Zhou <quan.zhou@mediatek.com>

For some cases as below, we may encounter the unpreditable chip stats
in driver probe()
* The system reboot flow do not work properly, such as kernel oops while
  rebooting, and then the driver do not go back to default status at
  this moment.
* Similar to the flow above. If the device was enabled in BIOS or UEFI,
  the system may switch to Linux without driver fully shutdown.

To avoid the problem, force push the device back to default in probe()
* mt7921e_mcu_fw_pmctrl() : return control privilege to chip side.
* mt7921_wfsys_reset()    : cleanup chip config before resource init.

Error log
[59007.600714] mt7921e 0000:02:00.0: ASIC revision: 79220010
[59010.889773] mt7921e 0000:02:00.0: Message 00000010 (seq 1) timeout
[59010.889786] mt7921e 0000:02:00.0: Failed to get patch semaphore
[59014.217839] mt7921e 0000:02:00.0: Message 00000010 (seq 2) timeout
[59014.217852] mt7921e 0000:02:00.0: Failed to get patch semaphore
[59017.545880] mt7921e 0000:02:00.0: Message 00000010 (seq 3) timeout
[59017.545893] mt7921e 0000:02:00.0: Failed to get patch semaphore
[59020.874086] mt7921e 0000:02:00.0: Message 00000010 (seq 4) timeout
[59020.874099] mt7921e 0000:02:00.0: Failed to get patch semaphore
[59024.202019] mt7921e 0000:02:00.0: Message 00000010 (seq 5) timeout
[59024.202033] mt7921e 0000:02:00.0: Failed to get patch semaphore
[59027.530082] mt7921e 0000:02:00.0: Message 00000010 (seq 6) timeout
[59027.530096] mt7921e 0000:02:00.0: Failed to get patch semaphore
[59030.857888] mt7921e 0000:02:00.0: Message 00000010 (seq 7) timeout
[59030.857904] mt7921e 0000:02:00.0: Failed to get patch semaphore
[59034.185946] mt7921e 0000:02:00.0: Message 00000010 (seq 8) timeout
[59034.185961] mt7921e 0000:02:00.0: Failed to get patch semaphore
[59037.514249] mt7921e 0000:02:00.0: Message 00000010 (seq 9) timeout
[59037.514262] mt7921e 0000:02:00.0: Failed to get patch semaphore
[59040.842362] mt7921e 0000:02:00.0: Message 00000010 (seq 10) timeout
[59040.842375] mt7921e 0000:02:00.0: Failed to get patch semaphore
[59040.923845] mt7921e 0000:02:00.0: hardware init failed

Fixes: 5c14a5f944b9 ("mt76: mt7921: introduce mt7921e support")
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Co-developed-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/dma.c | 4 ----
 drivers/net/wireless/mediatek/mt76/mt7921/mcu.c | 8 --------
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c | 8 ++++++++
 3 files changed, 8 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
index f0a80c2b476a..4153cd6c2a01 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/dma.c
@@ -231,10 +231,6 @@ int mt7921_dma_init(struct mt7921_dev *dev)
 	if (ret)
 		return ret;
 
-	ret = mt7921_wfsys_reset(dev);
-	if (ret)
-		return ret;
-
 	/* init tx queue */
 	ret = mt76_connac_init_tx_queues(dev->phy.mt76, MT7921_TXQ_BAND0,
 					 MT7921_TX_RING_SIZE,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index c69ce6df4956..f55caa00ac69 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -476,12 +476,6 @@ static int mt7921_load_firmware(struct mt7921_dev *dev)
 {
 	int ret;
 
-	ret = mt76_get_field(dev, MT_CONN_ON_MISC, MT_TOP_MISC2_FW_N9_RDY);
-	if (ret && mt76_is_mmio(&dev->mt76)) {
-		dev_dbg(dev->mt76.dev, "Firmware is already download\n");
-		goto fw_loaded;
-	}
-
 	ret = mt76_connac2_load_patch(&dev->mt76, mt7921_patch_name(dev));
 	if (ret)
 		return ret;
@@ -504,8 +498,6 @@ static int mt7921_load_firmware(struct mt7921_dev *dev)
 		return -EIO;
 	}
 
-fw_loaded:
-
 #ifdef CONFIG_PM
 	dev->mt76.hw->wiphy->wowlan = &mt76_connac_wowlan_support;
 #endif /* CONFIG_PM */
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 1c727870bbdb..6c512bc75685 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -325,6 +325,10 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 	bus_ops->rmw = mt7921_rmw;
 	dev->mt76.bus = bus_ops;
 
+	ret = mt7921e_mcu_fw_pmctrl(dev);
+	if (ret)
+		goto err_free_dev;
+
 	ret = __mt7921e_mcu_drv_pmctrl(dev);
 	if (ret)
 		goto err_free_dev;
@@ -333,6 +337,10 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 		    (mt7921_l1_rr(dev, MT_HW_REV) & 0xff);
 	dev_info(mdev->dev, "ASIC revision: %04x\n", mdev->rev);
 
+	ret = mt7921_wfsys_reset(dev);
+	if (ret)
+		goto err_free_dev;
+
 	mt76_wr(dev, MT_WFDMA0_HOST_INT_ENA, 0);
 
 	mt76_wr(dev, MT_PCIE_MAC_INT_ENABLE, 0xff);
-- 
2.18.0

