Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBD07F391E
	for <lists+linux-wireless@lfdr.de>; Tue, 21 Nov 2023 23:27:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229704AbjKUW1o (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 21 Nov 2023 17:27:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjKUW1n (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 21 Nov 2023 17:27:43 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C64EA113
        for <linux-wireless@vger.kernel.org>; Tue, 21 Nov 2023 14:27:32 -0800 (PST)
X-UUID: 25910f5488bd11eea33bb35ae8d461a2-20231122
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=L6PMXu10MLRu+/xj7efDZZLFc5lRarqbArV5DfgMobU=;
        b=UL5th2HCo8wPRuhabcdQxMkwXQYHnsuQgqA3B/bsr+7KG8pJ1SQ7N8qi8s6CbRCFArxcCSev/6EHH7ToRfPtjYCdIbWJIbtCWAY/UDyJDs6Z4/vVIH2d4Lqe9mImX0BdB61NTRW/AKiRCcMg++jHD9FhUnAzFmVPAqw0ERniYg8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.33,REQID:ad24fa00-4d2c-4bae-86c3-c57807b48860,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:364b77b,CLOUDID:7928a895-10ce-4e4b-85c2-c9b5229ff92b,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0,LES:1,SPR:
        NO,DKR:0,DKP:0,BRR:0,BRE:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-CID-FACTOR: TF_CID_SPAM_ULN,TF_CID_SPAM_SNR
X-UUID: 25910f5488bd11eea33bb35ae8d461a2-20231122
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1222772833; Wed, 22 Nov 2023 06:27:25 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 22 Nov 2023 06:27:24 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 22 Nov 2023 06:27:24 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <Leon.Yen@mediatek.com>, <Eric-SY.Chang@mediatek.com>,
        <Deren.Wu@mediatek.com>, <km.lin@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <kuabhs@google.com>,
        <druth@google.com>, <abhishekpandit@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] wifi: mt76: mt7921: reduce the size of MCU firmware download Rx queue
Date:   Wed, 22 Nov 2023 06:27:22 +0800
Message-ID: <e68bcca1cd1132e1d0f10436a5fbc2eb4910ef46.1700605083.git.sean.wang@mediatek.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_PASS,T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

We actually don't need the reserve the 512 entries for the MCU firmware
download Rx queue because the queue was only used in the firmware download
phase to save the most of space and the reduction can significantly help
with reducing latency we spent by ~20% further in resetting the Rx queue
as the device was waking up from deep sleep mode.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 3 ++-
 drivers/net/wireless/mediatek/mt76/mt7921/pci.c    | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index f28621121927..fcca93b3e14c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -12,7 +12,8 @@
 #define MT7921_TX_FWDL_RING_SIZE	128
 
 #define MT7921_RX_RING_SIZE		1536
-#define MT7921_RX_MCU_RING_SIZE		512
+#define MT7921_RX_MCU_RING_SIZE		8
+#define MT7921_RX_MCU_WA_RING_SIZE	512
 
 #define MT7921_EEPROM_SIZE		3584
 #define MT7921_TOKEN_SIZE		8192
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index 6f83c4c5fce2..9bdaddd310be 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -200,7 +200,7 @@ static int mt7921_dma_init(struct mt792x_dev *dev)
 	/* Change mcu queue after firmware download */
 	ret = mt76_queue_alloc(dev, &dev->mt76.q_rx[MT_RXQ_MCU_WA],
 			       MT7921_RXQ_MCU_WM,
-			       MT7921_RX_MCU_RING_SIZE,
+			       MT7921_RX_MCU_WA_RING_SIZE,
 			       MT_RX_BUF_SIZE, MT_WFDMA0(0x540));
 	if (ret)
 		return ret;
-- 
2.25.1

