Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C43E748810
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jul 2023 17:29:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232643AbjGEP33 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 5 Jul 2023 11:29:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231540AbjGEP31 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 5 Jul 2023 11:29:27 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73AB01709;
        Wed,  5 Jul 2023 08:29:24 -0700 (PDT)
X-UUID: b5539c481b4811eeb20a276fd37b9834-20230705
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=NLesLJe4A/A3qoSeOMLVznOKBUY2rYk/Ty+1pFly89M=;
        b=jS2hUJMQwDrlb5AMtfhwcmycoY0OzxrdJ7td8dw7KQIl7tO8BUB4jGlhrFBtaMWxx+vS1T4/Lk3GlISJ0oXoSBUSgR3OyPJayB5dmliIbve2K+EKEkEpboL6CEHPPUWFIpBV1Ipg7l62UG+S9BKvaazcGRQUO2MttsfTcsDkd+s=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.27,REQID:e0c576f1-77ac-400d-91a2-cefd688693e4,IP:0,U
        RL:0,TC:0,Content:-25,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:-25
X-CID-META: VersionHash:01c9525,CLOUDID:3e0fa9da-b4fa-43c8-9c3e-0d3fabd03ec0,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR,TF_CID_SPAM_ULN
X-UUID: b5539c481b4811eeb20a276fd37b9834-20230705
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 2106716047; Wed, 05 Jul 2023 23:29:18 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 5 Jul 2023 23:29:17 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 5 Jul 2023 23:29:17 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Kalle Valo <kvalo@kernel.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        <netdev@vger.kernel.org>, Quan Zhou <quan.zhou@mediatek.com>,
        <stable@vger.kernel.org>, Leon Yen <leon.yen@mediatek.com>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH v2] wifi: mt76: mt7921e: fix init command fail with enabled device
Date:   Wed, 5 Jul 2023 23:26:38 +0800
Message-ID: <39fcb7cee08d4ab940d38d82f21897483212483f.1688569385.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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

Cc: stable@vger.kernel.org
Fixes: 5c14a5f944b9 ("mt76: mt7921: introduce mt7921e support")
Tested-by: Kai-Heng Feng <kai.heng.feng@canonical.com>
Tested-by: Juan Martinez <juan.martinez@amd.com>
Co-developed-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Leon Yen <leon.yen@mediatek.com>
Signed-off-by: Quan Zhou <quan.zhou@mediatek.com>
Signed-off-by: Deren Wu <deren.wu@mediatek.com>

---
v2: The v1 patch has been accpeted in wireless patchwork. However,
    this patch is very important for existing system, we need to add
    cc stable tag and hope this patch can be pulled to stable branch earlier.
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

