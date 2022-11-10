Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B8BA624CEF
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Nov 2022 22:25:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232391AbiKJVZL (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 10 Nov 2022 16:25:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232779AbiKJVYi (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 10 Nov 2022 16:24:38 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74B9EAE6E
        for <linux-wireless@vger.kernel.org>; Thu, 10 Nov 2022 13:24:09 -0800 (PST)
X-UUID: 20a5cb08c68b460d8bc1a12a6f2c136c-20221111
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=kKoIbOtVLpwqIH2K8ZAQOun0Vttiphneode8vwm3dDA=;
        b=L0W+MskNcGmO8oUmUas1aAfX45wL5sSaVDY9YORW8QyV4iyOyWhuZCbm8E1U0L+4trV9Z2IOs69FjNWpPZ7T7TH5BPCNjH5l7JS92O+8mtpBQ3GxElzuIHXjoeSW4jFvBtCLFa4bqd+KYXTCyqxe4nMxRf/5U/KG4zKUxWn8TV8=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.12,REQID:f2e1edce-1c42-4408-ba07-fb7968be64ab,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.12,REQID:f2e1edce-1c42-4408-ba07-fb7968be64ab,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:62cd327,CLOUDID:a745375d-100c-4555-952b-a62c895efded,B
        ulkID:221111052407O5YO6APQ,BulkQuantity:0,Recheck:0,SF:38|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 20a5cb08c68b460d8bc1a12a6f2c136c-20221111
Received: from mtkmbs13n1.mediatek.inc [(172.21.101.193)] by mailgw02.mediatek.com
        (envelope-from <sean.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 537070104; Fri, 11 Nov 2022 05:24:06 +0800
Received: from mtkmbs13n1.mediatek.inc (172.21.101.193) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Fri, 11 Nov 2022 05:24:04 +0800
Received: from mtkswgap22.mediatek.inc (172.21.77.33) by
 mtkmbs13n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Fri, 11 Nov 2022 05:24:04 +0800
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
Subject: [PATCH v3 4/7] wifi: mt76: mt7921: drop ieee80211_[start, stop]_queues in driver
Date:   Fri, 11 Nov 2022 05:23:46 +0800
Message-ID: <362619b8c32d24f0e9cb4855f2a7618e8bd94483.1668068326.git.objelf@gmail.com>
X-Mailer: git-send-email 1.7.9.5
In-Reply-To: <cover.1668068326.git.objelf@gmail.com>
References: <cover.1668068326.git.objelf@gmail.com>
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

From: Sean Wang <sean.wang@mediatek.com>

The firmware would be in charge of braking and continuing the traffic while
the channel contexts are switching between different BSS and HW SCAN in the
background.

Signed-off-by: Sean Wang <sean.wang@mediatek.com>
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

