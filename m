Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A231F70315D
	for <lists+linux-wireless@lfdr.de>; Mon, 15 May 2023 17:19:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242299AbjEOPT1 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 15 May 2023 11:19:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjEOPTZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 15 May 2023 11:19:25 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272C619B1
        for <linux-wireless@vger.kernel.org>; Mon, 15 May 2023 08:19:21 -0700 (PDT)
X-UUID: da108d3af33311edb20a276fd37b9834-20230515
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=Qx15U+hd8QpD5rotC7V7Dk7K0wTKid64awhhfoNqR0w=;
        b=l5CunfaYsZwDqRynBE8MW8ggTKpxWklyxtRSQPN/RIGGt9mSznvhmPRWqYMPidD9p8bFfIYU9xkzy+mM8+xjMxwaT26t46bfgPVDy8WXVc/Q1kWijk+BtxMZJo4Dm7+LCiTu+No8mKZSaBOvOqsFNaSKs4hkV/9vEcR7hxqOgJE=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.24,REQID:a88950d6-94ed-43b9-a7d8-3c2ad39d9a54,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:178d4d4,CLOUDID:16b8e7c0-e32c-4c97-918d-fbb3fc224d4e,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0,NGT
X-CID-BAS: 0,NGT,0,_
X-UUID: da108d3af33311edb20a276fd37b9834-20230515
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw02.mediatek.com
        (envelope-from <deren.wu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 10367979; Mon, 15 May 2023 23:19:14 +0800
Received: from mtkmbs13n2.mediatek.inc (172.21.101.194) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Mon, 15 May 2023 23:19:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs13n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Mon, 15 May 2023 23:19:13 +0800
From:   Deren Wu <deren.wu@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, Lorenzo Bianconi <lorenzo@kernel.org>
CC:     Sean Wang <sean.wang@mediatek.com>,
        Soul Huang <Soul.Huang@mediatek.com>,
        Ming Yen Hsieh <mingyen.hsieh@mediatek.com>,
        Leon Yen <Leon.Yen@mediatek.com>,
        Eric-SY Chang <Eric-SY.Chang@mediatek.com>,
        KM Lin <km.lin@mediatek.com>,
        Robin Chiu <robin.chiu@mediatek.com>,
        CH Yeh <ch.yeh@mediatek.com>, Posh Sun <posh.sun@mediatek.com>,
        Stella Chang <Stella.Chang@mediatek.com>,
        Quan Zhou <quan.zhou@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Deren Wu <deren.wu@mediatek.com>
Subject: [PATCH] wifi: mt76: mt7921e: report tx retries/failed counts in tx free event
Date:   Mon, 15 May 2023 23:18:50 +0800
Message-ID: <a22524899498365b0d136f399438306568e77064.1684163657.git.deren.wu@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get missing tx retries/failed counts from txfree done events and report
them via mt7921_sta_statistics().

Signed-off-by: Deren Wu <deren.wu@mediatek.com>
---
v1: based on "[v3,1/6] wifi: mt76: mt7915: report tx retries/failed counts for non-WED path"
https://patchwork.kernel.org/project/linux-wireless/patch/e3cddf1cff5f060478c2de9e4e4021541549e750.1683670255.git.ryder.lee@mediatek.com/
---
 drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c       | 8 +++++++-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c      | 6 ++++++
 3 files changed, 14 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
index a5ec0f631385..cb612d7c7616 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac2_mac.h
@@ -34,7 +34,7 @@ enum {
 
 #define MT_TX_FREE_MSDU_CNT		GENMASK(9, 0)
 #define MT_TX_FREE_WLAN_ID		GENMASK(23, 14)
-#define MT_TX_FREE_LATENCY		GENMASK(12, 0)
+#define MT_TX_FREE_COUNT		GENMASK(12, 0)
 /* 0: success, others: dropped */
 #define MT_TX_FREE_STATUS		GENMASK(14, 13)
 #define MT_TX_FREE_MSDU_ID		GENMASK(30, 16)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index 1675bf520481..a3d31b69217b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -614,6 +614,7 @@ static void mt7921_mac_tx_free(struct mt7921_dev *dev, void *data, int len)
 	struct mt76_dev *mdev = &dev->mt76;
 	struct mt76_txwi_cache *txwi;
 	struct ieee80211_sta *sta = NULL;
+	struct mt76_wcid *wcid = NULL;
 	struct sk_buff *skb, *tmp;
 	void *end = data + len;
 	LIST_HEAD(free_list);
@@ -637,7 +638,6 @@ static void mt7921_mac_tx_free(struct mt7921_dev *dev, void *data, int len)
 		 */
 		if (info & MT_TX_FREE_PAIR) {
 			struct mt7921_sta *msta;
-			struct mt76_wcid *wcid;
 			u16 idx;
 
 			count++;
@@ -658,6 +658,12 @@ static void mt7921_mac_tx_free(struct mt7921_dev *dev, void *data, int len)
 		msdu = FIELD_GET(MT_TX_FREE_MSDU_ID, info);
 		stat = FIELD_GET(MT_TX_FREE_STATUS, info);
 
+		if (wcid) {
+			wcid->stats.tx_retries +=
+				FIELD_GET(MT_TX_FREE_COUNT, info) - 1;
+			wcid->stats.tx_failed += !!stat;
+		}
+
 		txwi = mt76_token_release(mdev, msdu, &wake);
 		if (!txwi)
 			continue;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 0c9a472bc81a..418a1fa67477 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1400,6 +1400,12 @@ static void mt7921_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->txrate.he_dcm = txrate->he_dcm;
 		sinfo->txrate.he_ru_alloc = txrate->he_ru_alloc;
 	}
+	sinfo->tx_failed = msta->wcid.stats.tx_failed;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
+
+	sinfo->tx_retries = msta->wcid.stats.tx_retries;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
+
 	sinfo->txrate.flags = txrate->flags;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_BITRATE);
 
-- 
2.18.0

