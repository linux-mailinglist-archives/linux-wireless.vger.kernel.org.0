Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C18F6F0A1E
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Apr 2023 18:43:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244220AbjD0Qnz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 27 Apr 2023 12:43:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243577AbjD0Qny (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 27 Apr 2023 12:43:54 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2096A40DA
        for <linux-wireless@vger.kernel.org>; Thu, 27 Apr 2023 09:43:44 -0700 (PDT)
X-UUID: a8c24452e51a11eda687dfa7a9ab556f-20230428
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=eX0d5MnDIx5piR+VxcyO07pAYaKUIeZr/3Oco6tsuCI=;
        b=L+aoMTFDDJlekMWnStzoemubFEqnpGJ+Am8d6s0aun0bVjU4j2k5UGM0J3IeGDMPk/4GqDRxlhwvQlpvYAMzN6OCnJxZgr5ED0yZcQoAHFgL6knNN1VrLJb1JoihZil0Z4OL5OGazoweHZ4qHtnaaciuP+18PdODQisqGB+aK4I=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.22,REQID:a53ae64b-f75b-4179-a949-c9da9792fe3e,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.22,REQID:a53ae64b-f75b-4179-a949-c9da9792fe3e,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:120426c,CLOUDID:4e761930-6935-4eab-a959-f84f8da15543,B
        ulkID:230428004339Z7I6GVMZ,BulkQuantity:0,Recheck:0,SF:28|17|19|48|38|29,T
        C:nil,Content:0,EDM:-3,IP:nil,URL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,CO
        L:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: a8c24452e51a11eda687dfa7a9ab556f-20230428
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1730676029; Fri, 28 Apr 2023 00:43:38 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs13n2.mediatek.inc (172.21.101.108) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Fri, 28 Apr 2023 00:43:36 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.25 via Frontend Transport; Fri, 28 Apr 2023 00:43:36 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Peter Chiu <chui-hao.chiu@mediatek.com>
Subject: [PATCH v2] wifi: mt76: mt7915: report tx retries/failed counts for non-WED path
Date:   Fri, 28 Apr 2023 00:43:35 +0800
Message-ID: <ddee913411aa77046ec6a42181833f31ce043f38.1682613710.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Get missing tx retries/failed counts from txfree done events and report
them via mt7915_sta_statistics().

Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
v2 - add a missing check for non-v3 format
---
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 22 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7915/mac.h   |  7 +++++-
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 12 +++++-----
 3 files changed, 32 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 7df8d95fc3fb..9b2ccd99854e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -951,6 +951,7 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 	struct mt76_dev *mdev = &dev->mt76;
 	struct mt76_txwi_cache *txwi;
 	struct ieee80211_sta *sta = NULL;
+	struct mt76_wcid *wcid = NULL;
 	LIST_HEAD(free_list);
 	void *end = data + len;
 	bool v3, wake = false;
@@ -977,7 +978,6 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 		info = le32_to_cpu(*cur_info);
 		if (info & MT_TX_FREE_PAIR) {
 			struct mt7915_sta *msta;
-			struct mt76_wcid *wcid;
 			u16 idx;
 
 			idx = FIELD_GET(MT_TX_FREE_WLAN_ID, info);
@@ -994,7 +994,25 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 			continue;
 		}
 
-		if (v3 && (info & MT_TX_FREE_MPDU_HEADER))
+		if (!mtk_wed_device_active(&mdev->mmio.wed) && wcid) {
+			u32 tx_retries = 0, tx_failed = 0;
+
+			if (v3 && (info & MT_TX_FREE_MPDU_HEADER_V3)) {
+				tx_retries =
+					FIELD_GET(MT_TX_FREE_COUNT_V3, info) - 1;
+				tx_failed = tx_retries +
+					!!FIELD_GET(MT_TX_FREE_STAT_V3, info);
+			} else if (!v3 && (info & MT_TX_FREE_MPDU_HEADER)) {
+				tx_retries =
+					FIELD_GET(MT_TX_FREE_COUNT, info) - 1;
+				tx_failed = tx_retries +
+					!!FIELD_GET(MT_TX_FREE_STAT, info);
+			}
+			wcid->stats.tx_retries += tx_retries;
+			wcid->stats.tx_failed += tx_failed;
+		}
+
+		if (v3 && (info & MT_TX_FREE_MPDU_HEADER_V3))
 			continue;
 
 		for (i = 0; i < 1 + v3; i++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
index ce94f87e2042..448b1b380190 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.h
@@ -9,7 +9,12 @@
 #define MT_TX_FREE_VER			GENMASK(18, 16)
 #define MT_TX_FREE_MSDU_CNT_V0		GENMASK(6, 0)
 /* 0: success, others: dropped */
-#define MT_TX_FREE_MPDU_HEADER		BIT(30)
+#define MT_TX_FREE_COUNT		GENMASK(12, 0)
+#define MT_TX_FREE_COUNT_V3		GENMASK(27, 24)
+#define MT_TX_FREE_STAT			GENMASK(14, 13)
+#define MT_TX_FREE_STAT_V3		GENMASK(29, 28)
+#define MT_TX_FREE_MPDU_HEADER		BIT(15)
+#define MT_TX_FREE_MPDU_HEADER_V3	BIT(30)
 #define MT_TX_FREE_MSDU_ID_V3		GENMASK(14, 0)
 
 #define MT_TXS5_F0_FINAL_MPDU		BIT(31)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 2ada2806de66..61157248d742 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1046,12 +1046,6 @@ static void mt7915_sta_statistics(struct ieee80211_hw *hw,
 		sinfo->tx_packets = msta->wcid.stats.tx_packets;
 		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_PACKETS);
 
-		sinfo->tx_failed = msta->wcid.stats.tx_failed;
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
-
-		sinfo->tx_retries = msta->wcid.stats.tx_retries;
-		sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
-
 		if (mtk_wed_get_rx_capa(&phy->dev->mt76.mmio.wed)) {
 			sinfo->rx_bytes = msta->wcid.stats.rx_bytes;
 			sinfo->filled |= BIT_ULL(NL80211_STA_INFO_RX_BYTES64);
@@ -1061,6 +1055,12 @@ static void mt7915_sta_statistics(struct ieee80211_hw *hw,
 		}
 	}
 
+	sinfo->tx_failed = msta->wcid.stats.tx_failed;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_FAILED);
+
+	sinfo->tx_retries = msta->wcid.stats.tx_retries;
+	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_TX_RETRIES);
+
 	sinfo->ack_signal = (s8)msta->ack_signal;
 	sinfo->filled |= BIT_ULL(NL80211_STA_INFO_ACK_SIGNAL);
 
-- 
2.18.0

