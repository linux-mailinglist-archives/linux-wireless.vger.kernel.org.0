Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12BA75FBE9E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Oct 2022 02:16:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229613AbiJLAQn (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Oct 2022 20:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbiJLAQi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Oct 2022 20:16:38 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B68997EFE9
        for <linux-wireless@vger.kernel.org>; Tue, 11 Oct 2022 17:16:35 -0700 (PDT)
X-UUID: 1d7f9493fb9e4fe381c44382d849de62-20221012
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=gotXpdlU/PAS/RGYbhW5477ksHxMEs91rAGu5DbfOWo=;
        b=psXHsSvzm1PlzzjLbGVgkFPa8E8bs2wF3fSNh8VX0a08HXhinWejRr0bsvh2GOqsND+zbUdnhazK64la0CgD2HdR5/rBcXViqZlsOdNNgXchwNNgSR1eCApSbmYVWYe+v7qjfGEL+IHM7KkcVQkbAk0L14UcFc/3/W/aKGNB+W4=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.11,REQID:d681727d-6ecc-477f-b83c-f7b3e49e3620,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:39a5ff1,CLOUDID:da12f3fe-ee8c-4ff7-afe9-644435e96625,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 1d7f9493fb9e4fe381c44382d849de62-20221012
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1757983026; Wed, 12 Oct 2022 08:16:29 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Wed, 12 Oct 2022 08:16:28 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 12 Oct 2022 08:16:28 +0800
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
Subject: [PATCH v2 4/7] wifi: mt76: mt7921: drop ieee80211_[start, stop]_queues in driver
Date:   Wed, 12 Oct 2022 08:16:18 +0800
Message-ID: <37425af2d0f923c9230154f303f1e0a040bce0ba.1665533390.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <8d784dba38cfb2183af2e4d9fc822a27ef34dcd2.1665533390.git.objelf@gmail.com>
References: <8d784dba38cfb2183af2e4d9fc822a27ef34dcd2.1665533390.git.objelf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,UNPARSEABLE_RELAY,URIBL_CSS autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Sean Wang <sean.wang@mediatek.com>

The firmware would be in charge of braking and continuing the traffic while
the channel contexts are switching between different BSS and HW SCAN in the
background.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
---
v2: drop mt7921_mcu_bss_event that is unused any more
---
 .../net/wireless/mediatek/mt76/mt7921/mcu.c    | 18 ------------------
 1 file changed, 18 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
index 2b36c5f6eb40..7a74abecb269 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mcu.c
@@ -199,20 +199,6 @@ mt7921_mcu_connection_loss_event(struct mt7921_dev *dev, struct sk_buff *skb)
 					mt7921_mcu_connection_loss_iter, event);
 }
 
-static void
-mt7921_mcu_bss_event(struct mt7921_dev *dev, struct sk_buff *skb)
-{
-	struct mt76_phy *mphy = &dev->mt76.phy;
-	struct mt76_connac_mcu_bss_event *event;
-
-	skb_pull(skb, sizeof(struct mt76_connac2_mcu_rxd));
-	event = (struct mt76_connac_mcu_bss_event *)skb->data;
-	if (event->is_absent)
-		ieee80211_stop_queues(mphy->hw);
-	else
-		ieee80211_wake_queues(mphy->hw);
-}
-
 static void
 mt7921_mcu_debug_msg_event(struct mt7921_dev *dev, struct sk_buff *skb)
 {
@@ -279,9 +265,6 @@ mt7921_mcu_rx_unsolicited_event(struct mt7921_dev *dev, struct sk_buff *skb)
 	case MCU_EVENT_SCAN_DONE:
 		mt7921_mcu_scan_event(dev, skb);
 		return;
-	case MCU_EVENT_BSS_ABSENCE:
-		mt7921_mcu_bss_event(dev, skb);
-		break;
 	case MCU_EVENT_DBG_MSG:
 		mt7921_mcu_debug_msg_event(dev, skb);
 		break;
@@ -341,7 +324,6 @@ void mt7921_mcu_rx_event(struct mt7921_dev *dev, struct sk_buff *skb)
 	if (rxd->ext_eid == MCU_EXT_EVENT_RATE_REPORT ||
 	    rxd->eid == MCU_EVENT_BSS_BEACON_LOSS ||
 	    rxd->eid == MCU_EVENT_SCHED_SCAN_DONE ||
-	    rxd->eid == MCU_EVENT_BSS_ABSENCE ||
 	    rxd->eid == MCU_EVENT_SCAN_DONE ||
 	    rxd->eid == MCU_EVENT_TX_DONE ||
 	    rxd->eid == MCU_EVENT_DBG_MSG ||
-- 
2.25.1

