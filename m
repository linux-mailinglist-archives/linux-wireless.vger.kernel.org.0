Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E5764193E
	for <lists+linux-wireless@lfdr.de>; Sat,  3 Dec 2022 22:33:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiLCVdc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 3 Dec 2022 16:33:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiLCVdb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 3 Dec 2022 16:33:31 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2910610051
        for <linux-wireless@vger.kernel.org>; Sat,  3 Dec 2022 13:33:26 -0800 (PST)
X-UUID: ec91222c7b6f40199193fa746be8c330-20221204
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=By8Hs0ILcc6/2bwMt7Sag9YleAroulw6Wer7whCyctY=;
        b=hGhJ2Ue7VCRoeuApY7eXc0E2yqXQtqjLfmMNgIlb9XkgWqgoc/YKkGFToSYlxZ+XFI9hB2TuGaknL067uPcS3OI2ignrxcweAbSeHPXqlUzX1d/cKGADLApJbmdW81fN+AyJISjQE8BDZqr6BpCaiKOhjxCRXSoRjf7uFQKjTmE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.14,REQID:31045957-f857-4920-9133-aa2e768653b2,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.14,REQID:31045957-f857-4920-9133-aa2e768653b2,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:dcaaed0,CLOUDID:c3620f1f-5e1d-4ab5-ab8e-3e04efc02b30,B
        ulkID:221204053324BUU9RUCX,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: ec91222c7b6f40199193fa746be8c330-20221204
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 477027229; Sun, 04 Dec 2022 05:33:22 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Sun, 4 Dec 2022 05:33:21 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Sun, 4 Dec 2022 05:33:21 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2 3/3] wifi: mt76: mt7915: check the correctness of event data
Date:   Sun, 4 Dec 2022 05:33:19 +0800
Message-ID: <4872e6fb6ca30b62a45d45a46c623a413acfaae2.1670102099.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <3fec8b8c618a78d1197f4060f89fa8bdd836b425.1670102099.git.ryder.lee@mediatek.com>
References: <3fec8b8c618a78d1197f4060f89fa8bdd836b425.1670102099.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SPF_TEMPERROR,UNPARSEABLE_RELAY autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The mcu event might not be reliable, so check the correctness of data
before handling it.

Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 21 +++++++++++++++----
 1 file changed, 17 insertions(+), 4 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 86ec767266cc..37a3c1f082d9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -232,8 +232,11 @@ mt7915_mcu_rx_csa_notify(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	c = (struct mt7915_mcu_csa_notify *)skb->data;
 
+	if (c->band_idx > MT_BAND1)
+		return;
+
 	if ((c->band_idx && !dev->phy.mt76->band_idx) &&
-	     dev->mt76.phys[MT_BAND1])
+	    dev->mt76.phys[MT_BAND1])
 		mphy = dev->mt76.phys[MT_BAND1];
 
 	ieee80211_iterate_active_interfaces_atomic(mphy->hw,
@@ -252,8 +255,11 @@ mt7915_mcu_rx_thermal_notify(struct mt7915_dev *dev, struct sk_buff *skb)
 	if (t->ctrl.ctrl_id != THERMAL_PROTECT_ENABLE)
 		return;
 
+	if (t->ctrl.band_idx > MT_BAND1)
+		return;
+
 	if ((t->ctrl.band_idx && !dev->phy.mt76->band_idx) &&
-	     dev->mt76.phys[MT_BAND1])
+	    dev->mt76.phys[MT_BAND1])
 		mphy = dev->mt76.phys[MT_BAND1];
 
 	phy = (struct mt7915_phy *)mphy->priv;
@@ -268,8 +274,11 @@ mt7915_mcu_rx_radar_detected(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	r = (struct mt7915_mcu_rdd_report *)skb->data;
 
+	if (r->band_idx > MT_BAND1)
+		return;
+
 	if ((r->band_idx && !dev->phy.mt76->band_idx) &&
-	     dev->mt76.phys[MT_BAND1])
+	    dev->mt76.phys[MT_BAND1])
 		mphy = dev->mt76.phys[MT_BAND1];
 
 	if (r->band_idx == MT_RX_SEL2)
@@ -326,7 +335,11 @@ mt7915_mcu_rx_bcc_notify(struct mt7915_dev *dev, struct sk_buff *skb)
 
 	b = (struct mt7915_mcu_bcc_notify *)skb->data;
 
-	if ((b->band_idx && !dev->phy.mt76->band_idx) && dev->mt76.phys[MT_BAND1])
+	if (b->band_idx > MT_BAND1)
+		return;
+
+	if ((b->band_idx && !dev->phy.mt76->band_idx) &&
+	    dev->mt76.phys[MT_BAND1])
 		mphy = dev->mt76.phys[MT_BAND1];
 
 	ieee80211_iterate_active_interfaces_atomic(mphy->hw,
-- 
2.18.0

