Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BE916E72CE
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Apr 2023 07:58:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231590AbjDSF6z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 19 Apr 2023 01:58:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231516AbjDSF6y (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 19 Apr 2023 01:58:54 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745603592
        for <linux-wireless@vger.kernel.org>; Tue, 18 Apr 2023 22:58:49 -0700 (PDT)
X-UUID: 3d81f6c8de7711eda9a90f0bb45854f4-20230419
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=8If3OHblNkpEWCKRVPetaaHJ1wakSJYUSHI1OWQ7MlA=;
        b=ldiOOUiQsJxOwYEb2H/SmYy3bo3gWlewY19AmOenVbPoDb5emI3wB5g5LcFnCtSdZsme1QA7gkT40ZYCDaABbbDo7ronwUUdVE677GhE2YZpPKPGQAyEowjPMeniVMqArl2k/2j/1d9BkdNZak35iv+J227+9o+/tz9Mup1pQIs=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:afbf47c1-29bc-499f-9ceb-e5b52cfa023e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:120426c,CLOUDID:6327d1a1-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 3d81f6c8de7711eda9a90f0bb45854f4-20230419
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1404167950; Wed, 19 Apr 2023 13:58:43 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs13n1.mediatek.inc (172.21.101.193) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Wed, 19 Apr 2023 13:58:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Wed, 19 Apr 2023 13:58:42 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7996: fill txd by host driver
Date:   Wed, 19 Apr 2023 13:58:40 +0800
Message-ID: <d292aca5cdf0f52bd4132b73214ebd4f8d271a65.1681864336.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The hardware SDO has issue to fill txd for the moment, so fallback to
driver filling method.

Fixes: 98686cd21624 (wifi: mt76: mt7996: add driver for MediaTek Wi-Fi 7 (802.11be) devices)
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 13 ++++---------
 1 file changed, 4 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 6ce75243e40d..ff8464fe0528 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1117,11 +1117,8 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 		return id;
 
 	pid = mt76_tx_status_skb_add(mdev, wcid, tx_info->skb);
-	memset(txwi_ptr, 0, MT_TXD_SIZE);
-	/* Transmit non qos data by 802.11 header and need to fill txd by host*/
-	if (!is_8023 || pid >= MT_PACKET_ID_FIRST)
-		mt7996_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, key,
-				      pid, qid, 0);
+	mt7996_mac_write_txwi(dev, txwi_ptr, tx_info->skb, wcid, key,
+			      pid, qid, 0);
 
 	txp = (struct mt76_connac_txp_common *)(txwi + MT_TXD_SIZE);
 	for (i = 0; i < nbuf; i++) {
@@ -1130,10 +1127,8 @@ int mt7996_tx_prepare_skb(struct mt76_dev *mdev, void *txwi_ptr,
 	}
 	txp->fw.nbuf = nbuf;
 
-	txp->fw.flags = cpu_to_le16(MT_CT_INFO_FROM_HOST);
-
-	if (!is_8023 || pid >= MT_PACKET_ID_FIRST)
-		txp->fw.flags |= cpu_to_le16(MT_CT_INFO_APPLY_TXD);
+	txp->fw.flags =
+		cpu_to_le16(MT_CT_INFO_FROM_HOST | MT_CT_INFO_APPLY_TXD);
 
 	if (!key)
 		txp->fw.flags |= cpu_to_le16(MT_CT_INFO_NONE_CIPHER_FRAME);
-- 
2.18.0

