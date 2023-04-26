Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 471B26EFDCC
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 01:05:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232197AbjDZXFo (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Apr 2023 19:05:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229582AbjDZXFo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Apr 2023 19:05:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E4E22694
        for <linux-wireless@vger.kernel.org>; Wed, 26 Apr 2023 16:05:42 -0700 (PDT)
X-UUID: db88da34e48611eda9a90f0bb45854f4-20230427
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Tryf26oI7NZspdhQrPCelEOu5SNun7TuTLvbo5UwH9k=;
        b=R8d/oKOWoMyjgRsz7JQiAyPz4DEfD65Wd1PoQTl5Z3bsLRFEcjIgvCWkr4A4487Yh2aXzEelb01tjYw34JrZIxkkSd0Rxn31sHB4Xv5PtwSd1cRUPXfjsGA4bnzwGYW3vL7ay1hjCiZPNO7GF7QbJAevM3NdOnWlvAsGXGS0Dpg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:04546929-f7a9-4ef3-9fa6-83ce12d1ccde,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.22,REQID:04546929-f7a9-4ef3-9fa6-83ce12d1ccde,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:120426c,CLOUDID:cd37a0a2-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:230427070537R7KUTHM6,BulkQuantity:0,Recheck:0,SF:38|29|28|17|19|48,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: db88da34e48611eda9a90f0bb45854f4-20230427
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 153252989; Thu, 27 Apr 2023 07:05:37 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.108) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 27 Apr 2023 07:05:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 27 Apr 2023 07:05:36 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7996: fix header translation logic
Date:   Thu, 27 Apr 2023 07:05:15 +0800
Message-ID: <1ba50091a50574ff9700723a4485bccb3d93322f.1682549983.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

When header translation failure is indicated, the hardware will insert
an extra 2-byte field containing the data length after the protocol
type field. This happens either when the LLC-SNAP pattern did not match,
or if a VLAN header was detected.

The previous commit accidentally breaks the logic, so reverts back.

Fixes: 27db47ab1f47 (wifi: mt76: mt7996: enable mesh HW amsdu/de-amsdu support)
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 39a4a73ef8e6..4c03d5a3bcea 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -836,14 +836,19 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, struct sk_buff *skb)
 		skb_pull(skb, hdr_gap);
 		if (!hdr_trans && status->amsdu && !(ieee80211_has_a4(fc) && is_mesh)) {
 			pad_start = ieee80211_get_hdrlen_from_skb(skb);
-		} else if (hdr_trans && (rxd2 & MT_RXD2_NORMAL_HDR_TRANS_ERROR) &&
-			   get_unaligned_be16(skb->data + pad_start) == ETH_P_8021Q) {
+		} else if (hdr_trans && (rxd2 & MT_RXD2_NORMAL_HDR_TRANS_ERROR)) {
 			/* When header translation failure is indicated,
 			 * the hardware will insert an extra 2-byte field
 			 * containing the data length after the protocol
-			 * type field.
+			 * type field. This happens either when the LLC-SNAP
+			 * pattern did not match, or if a VLAN header was
+			 * detected.
 			 */
-			pad_start = 16;
+			pad_start = 12;
+			if (get_unaligned_be16(skb->data + pad_start) == ETH_P_8021Q)
+				pad_start += 4;
+			else
+				pad_start = 0;
 		}
 
 		if (pad_start) {
-- 
2.18.0

