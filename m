Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED465926F4
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Aug 2022 01:38:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229590AbiHNXhb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 14 Aug 2022 19:37:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiHNXha (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 14 Aug 2022 19:37:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 548EC63E6
        for <linux-wireless@vger.kernel.org>; Sun, 14 Aug 2022 16:37:24 -0700 (PDT)
X-UUID: 148538d08d3a4f8398125ab81465287c-20220815
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=bQilvMFKBxazIlswRqWv91yqQ/yCqwwKRxMlrAjTfZU=;
        b=GL90L7P6nK13GFdisTvzHnlzkVUl0lhiFTa0I/FPzbgGvFfUNPMHjiuRgunMrHPMG8TPH2NW5p8NNwtOAfVVaj/JBcDom+gD/m+QVzfLIEmbHI5rDDdOaJChKFv5sWLEYflwoOwybUygEviIirNLbbNM5z/BDR0KSXpQTRGKrgY=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.9,REQID:d12fe960-88ff-4c33-b300-159f3b3ee92c,OB:0,LO
        B:0,IP:0,URL:5,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_H
        am,ACTION:release,TS:5
X-CID-META: VersionHash:3d8acc9,CLOUDID:e49d9f9c-da39-4e3b-a854-56c7d2111b46,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:
        nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 148538d08d3a4f8398125ab81465287c-20220815
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1793945494; Mon, 15 Aug 2022 07:37:17 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 15 Aug 2022 07:37:15 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 15 Aug 2022 07:37:15 +0800
From:   <sean.wang@mediatek.com>
To:     <nbd@nbd.name>, <lorenzo.bianconi@redhat.com>
CC:     <sean.wang@mediatek.com>, <Soul.Huang@mediatek.com>,
        <YN.Chen@mediatek.com>, <Leon.Yen@mediatek.com>,
        <Eric-SY.Chang@mediatek.com>, <Deren.Wu@mediatek.com>,
        <km.lin@mediatek.com>, <jenhao.yang@mediatek.com>,
        <robin.chiu@mediatek.com>, <Eddie.Chen@mediatek.com>,
        <ch.yeh@mediatek.com>, <posh.sun@mediatek.com>,
        <ted.huang@mediatek.com>, <Stella.Chang@mediatek.com>,
        <Tom.Chou@mediatek.com>, <steve.lee@mediatek.com>,
        <jsiuda@google.com>, <frankgor@google.com>, <kuabhs@google.com>,
        <druth@google.com>, <abhishekpandit@google.com>,
        <shawnku@google.com>, <linux-wireless@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>
Subject: [PATCH] mt76: mt7921: get rid of the false positive reset
Date:   Mon, 15 Aug 2022 07:37:14 +0800
Message-ID: <95b03bb77ce93cb2cade98d947309cd669721939.1660519674.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

False positive reset would be possibly triggered by those commands we
applied in suspend with HZ MCU timeout, especially it happened when we
enabled kernel log in pm core to diagnose how much time we spend in each
driver during suspend procedure. So we enlarge the value and align the MCU
timeout as other commands we did to reduce the false positive reset.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c  | 7 +------
 drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c | 7 +------
 drivers/net/wireless/mediatek/mt76/mt7921/usb.c      | 7 +------
 3 files changed, 3 insertions(+), 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
index 5efda694fb9d..64568536c1e9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci_mcu.c
@@ -30,12 +30,7 @@ mt7921_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	if (ret)
 		return ret;
 
-	if (cmd == MCU_UNI_CMD(HIF_CTRL) ||
-	    cmd == MCU_UNI_CMD(SUSPEND) ||
-	    cmd == MCU_UNI_CMD(OFFLOAD))
-		mdev->mcu.timeout = HZ;
-	else
-		mdev->mcu.timeout = 3 * HZ;
+	mdev->mcu.timeout = 3 * HZ;
 
 	if (cmd == MCU_CMD(FW_SCATTER))
 		txq = MT_MCUQ_FWDL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
index e038d7404323..5c1489766d9f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio_mcu.c
@@ -33,12 +33,7 @@ mt7921s_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	if (ret)
 		return ret;
 
-	if (cmd == MCU_UNI_CMD(HIF_CTRL) ||
-	    cmd == MCU_UNI_CMD(SUSPEND) ||
-	    cmd == MCU_UNI_CMD(OFFLOAD))
-		mdev->mcu.timeout = HZ;
-	else
-		mdev->mcu.timeout = 3 * HZ;
+	mdev->mcu.timeout = 3 * HZ;
 
 	if (cmd == MCU_CMD(FW_SCATTER))
 		type = MT7921_SDIO_FWDL;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index dd3b8884e162..d06cee386acd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -106,12 +106,7 @@ mt7921u_mcu_send_message(struct mt76_dev *mdev, struct sk_buff *skb,
 	if (ret)
 		return ret;
 
-	if (cmd == MCU_UNI_CMD(HIF_CTRL) ||
-	    cmd == MCU_UNI_CMD(SUSPEND) ||
-	    cmd == MCU_UNI_CMD(OFFLOAD))
-		mdev->mcu.timeout = HZ;
-	else
-		mdev->mcu.timeout = 3 * HZ;
+	mdev->mcu.timeout = 3 * HZ;
 
 	if (cmd != MCU_CMD(FW_SCATTER))
 		ep = MT_EP_OUT_INBAND_CMD;
-- 
2.25.1

