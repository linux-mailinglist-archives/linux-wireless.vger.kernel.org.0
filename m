Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8D6163A1C0
	for <lists+linux-wireless@lfdr.de>; Mon, 28 Nov 2022 08:05:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229713AbiK1HFQ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 28 Nov 2022 02:05:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229759AbiK1HFP (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 28 Nov 2022 02:05:15 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03A4412D07
        for <linux-wireless@vger.kernel.org>; Sun, 27 Nov 2022 23:05:14 -0800 (PST)
X-UUID: 5466bb1b63b944b79998794eb1b0d102-20221128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Sy0Jic1K5VgHl1u0yikgnqy04/Pvcv8bFLTccHuhyQM=;
        b=dK4hf0JClqiDV9cp/y2bn5ws3Igx9pYHo8pWMJli3DBVhgDPcMySwEUtNn5NNi0BLDbHmWomDBISMmjya5h8SBtt/veUotffpn8a2EE0tG4yzWF4YKeYoSnEgsIozyzBWtzjZgKI5HuLqmV7xKonHYMBjYbZ05xi6xNFuSiL8ig=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:8baa3e28-7993-4404-878f-8578343fb8ce,IP:0,U
        RL:0,TC:0,Content:100,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
        N:release,TS:100
X-CID-META: VersionHash:dcaaed0,CLOUDID:b79e7b1e-5e1d-4ab5-ab8e-3e04efc02b30,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:801|102,TC:nil,Content:3,EDM:-3,IP:n
        il,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 5466bb1b63b944b79998794eb1b0d102-20221128
Received: from mtkmbs11n2.mediatek.inc [(172.21.101.187)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 277305565; Mon, 28 Nov 2022 15:05:08 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 28 Nov 2022 15:05:07 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Mon, 28 Nov 2022 15:05:07 +0800
From:   Deren Wu <Deren.Wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        YN Chen <YN.Chen@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        "Eric-SY Chang" <Eric-SY.Chang@mediatek.com>,
        Deren Wu <Deren.Wu@mediatek.com>, KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        "Ryder Lee" <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921: Add missing __packed annotation of struct mt7921_clc
Date:   Mon, 28 Nov 2022 15:04:21 +0800
Message-ID: <f69bcbaa2eb9c848964c8187495031ee4539d337.1669618694.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Deren Wu <deren.wu@mediatek.com>

Add __packed annotation to avoid potential CLC parsing error

Fixes: 23bdc5d8cadf ("wifi: mt76: mt7921: introduce Country Location Control support")
Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 6fc04ed34ec3..15d6b7fe1c6c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -224,7 +224,7 @@ struct mt7921_clc {
 	u8 type;
 	u8 rsv[8];
 	u8 data[];
-};
+} __packed;
 
 struct mt7921_phy {
 	struct mt76_phy *mt76;
-- 
2.18.0

