Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A38A66EC283
	for <lists+linux-wireless@lfdr.de>; Sun, 23 Apr 2023 23:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjDWVjY (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 23 Apr 2023 17:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjDWVjX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 23 Apr 2023 17:39:23 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0B3132
        for <linux-wireless@vger.kernel.org>; Sun, 23 Apr 2023 14:39:15 -0700 (PDT)
X-UUID: 4768652ce21f11edb6b9f13eb10bd0fe-20230424
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=5T+tJrhn9ve0XncNfuPQGEr1uEgIxV6IQkTMikrCMcY=;
        b=A2zM2qKx2U4pMU0gDV41P+h4ZS00phm83QPREW/DWqRT9ba8OVc0ciVPmRvdq29wOqkgNtuSL/aA2IDl2aW8ai5JROke0+LpHy0SbKAFDabNyEfFj/X3bnC0OBHcds8DxooXVzN0IspGRAVxQFTIRb45N1+BAI+mUNfMcOB0W5I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:0ca3eaf8-97f5-45b1-b7ac-20314af2b60f,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.22,REQID:0ca3eaf8-97f5-45b1-b7ac-20314af2b60f,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:120426c,CLOUDID:d6b13ba2-8fcb-430b-954a-ba3f00fa94a5,B
        ulkID:230424053909UZ9649SD,BulkQuantity:0,Recheck:0,SF:17|19|48|38|29|28,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
        ,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: 4768652ce21f11edb6b9f13eb10bd0fe-20230424
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 379728038; Mon, 24 Apr 2023 05:39:08 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 24 Apr 2023 05:39:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Mon, 24 Apr 2023 05:39:07 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH 1/2] wifi: mt76: mt7996: fix endianness of MT_TXD6_TX_RATE
Date:   Mon, 24 Apr 2023 05:39:05 +0800
Message-ID: <16fa938373e3b145cb07a2c98d2428fea2abadba.1682285873.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,RDNS_NONE,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

To avoid sparse warning:
sparse: warning: invalid assignment: |=
sparse:    left side has type restricted __le32
sparse:    right side has type unsigned lon

Fixes: 15ee62e73705 ("wifi: mt76: mt7996: enable BSS_CHANGED_BASIC_RATES support")
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 130eb7b4fd91..39a4a73ef8e6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -1088,7 +1088,7 @@ void mt7996_mac_write_txwi(struct mt7996_dev *dev, __le32 *txwi,
 		else if (beacon && mvif->beacon_rates_idx)
 			idx = mvif->beacon_rates_idx;
 
-		txwi[6] |= FIELD_PREP(MT_TXD6_TX_RATE, idx);
+		txwi[6] |= cpu_to_le32(FIELD_PREP(MT_TXD6_TX_RATE, idx));
 		txwi[3] |= cpu_to_le32(MT_TXD3_BA_DISABLE);
 	}
 }
-- 
2.18.0

