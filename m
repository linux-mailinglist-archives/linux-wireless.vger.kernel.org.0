Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B11DA5081C3
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Apr 2022 09:12:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359614AbiDTHOp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 20 Apr 2022 03:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359612AbiDTHOo (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 20 Apr 2022 03:14:44 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7442393ED
        for <linux-wireless@vger.kernel.org>; Wed, 20 Apr 2022 00:11:54 -0700 (PDT)
X-UUID: 51bc0cc0b2024eda9fb2da84ce18e506-20220420
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.4,REQID:44dec461-2125-43ea-ad2d-b612a28943ad,OB:0,LO
        B:0,IP:0,URL:0,TC:0,Content:-20,EDM:0,RT:0,SF:0,FILE:0,RULE:Release_Ham,AC
        TION:release,TS:-20
X-CID-META: VersionHash:faefae9,CLOUDID:069152f0-da02-41b4-b6df-58f4ccd36682,C
        OID:IGNORED,Recheck:0,SF:nil,TC:nil,Content:0,EDM:-3,File:nil,QS:0,BEC:nil
X-UUID: 51bc0cc0b2024eda9fb2da84ce18e506-20220420
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <bo.jiao@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1602109401; Wed, 20 Apr 2022 15:11:49 +0800
Received: from MTKMBS34N1.mediatek.inc (172.27.4.172) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 20 Apr 2022 15:11:48 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS34N1.mediatek.inc
 (172.27.4.172) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Wed, 20 Apr
 2022 15:11:47 +0800
Received: from mcddlt001.gcn.mediatek.inc (10.19.240.15) by
 MTKCAS36.mediatek.inc (172.27.4.170) with Microsoft SMTP Server id
 15.0.1497.2 via Frontend Transport; Wed, 20 Apr 2022 15:11:46 +0800
From:   Bo Jiao <bo.jiao@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Sujuan Chen <sujuan.chen@mediatek.com>,
        "lian . chen" <lian.chen@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Bo Jiao <Bo.Jiao@mediatek.com>
Subject: [PATCH] mt76: mt7915: disable RX_HDR_TRANS_SHORT
Date:   Wed, 20 Apr 2022 15:11:44 +0800
Message-ID: <20220420071144.14573-1-bo.jiao@mediatek.com>
X-Mailer: git-send-email 2.17.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Bo Jiao <Bo.Jiao@mediatek.com>

This patch disables RX_TRANS_SHORT to make MDP to do header translation
when payload less than 8 bytes, hence the (QoS) null data can be encapsulated
to 802.3 format. However, WDS requires (QoS) null data in 802.11 format
to created vlan AP interfaces.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
Signed-off-by: lian.chen <lian.chen@mediatek.com>
Signed-off-by: Sujuan Chen <sujuan.chen@mediatek.com>
Signed-off-by: Bo Jiao <Bo.Jiao@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/agg-rx.c      | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7915/init.c | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c  | 4 ----
 drivers/net/wireless/mediatek/mt76/mt7915/regs.h | 3 +++
 4 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/agg-rx.c b/drivers/net/wireless/mediatek/mt76/agg-rx.c
index 7262222..efd1a85 100644
--- a/drivers/net/wireless/mediatek/mt76/agg-rx.c
+++ b/drivers/net/wireless/mediatek/mt76/agg-rx.c
@@ -167,6 +167,9 @@ void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames)
 		return;
 	}
 
+	if (!status->aggr)
+		return;
+
 	/* not part of a BA session */
 	ackp = status->qos_ctl & IEEE80211_QOS_CTL_ACK_POLICY_MASK;
 	if (ackp != IEEE80211_QOS_CTL_ACK_POLICY_BLOCKACK &&
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index facd604..12f8757 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -453,6 +453,9 @@ static void mt7915_mac_init(struct mt7915_dev *dev)
 
 	mt76_rmw_field(dev, MT_MDP_DCR1, MT_MDP_DCR1_MAX_RX_LEN, rx_len);
 
+	if (!is_mt7915(&dev->mt76))
+		mt76_clear(dev, MT_MDP_DCR2, MT_MDP_DCR2_RX_TRANS_SHORT);
+
 	/* enable hardware de-agg */
 	mt76_set(dev, MT_MDP_DCR0, MT_MDP_DCR0_DAMSDU_EN);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 5080280..bc2fb00 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -842,10 +842,6 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 	if (!status->wcid || !ieee80211_is_data_qos(fc))
 		return 0;
 
-	/* drop no data frame */
-	if (fc & cpu_to_le16(IEEE80211_STYPE_NULLFUNC))
-		return -EINVAL;
-
 	status->aggr = unicast &&
 		       !ieee80211_is_qos_nullfunc(fc);
 	status->qos_ctl = qos_ctl;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
index e4dbf99..bb0dec8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/regs.h
@@ -158,6 +158,9 @@ enum offs_rev {
 #define MT_MDP_DCR1			MT_MDP(0x004)
 #define MT_MDP_DCR1_MAX_RX_LEN		GENMASK(15, 3)
 
+#define MT_MDP_DCR2			MT_MDP(0x0e8)
+#define MT_MDP_DCR2_RX_TRANS_SHORT	BIT(2)
+
 #define MT_MDP_BNRCFR0(_band)		MT_MDP(__OFFS(MDP_BNRCFR0) + \
 					       ((_band) << 8))
 #define MT_MDP_RCFR0_MCU_RX_MGMT	GENMASK(5, 4)
-- 
2.18.0

