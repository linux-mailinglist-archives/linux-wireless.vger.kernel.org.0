Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8159C6828FB
	for <lists+linux-wireless@lfdr.de>; Tue, 31 Jan 2023 10:36:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbjAaJgt (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 31 Jan 2023 04:36:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231896AbjAaJgp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 31 Jan 2023 04:36:45 -0500
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A51F32CC42
        for <linux-wireless@vger.kernel.org>; Tue, 31 Jan 2023 01:36:40 -0800 (PST)
X-UUID: bda73fd0a14a11eda06fc9ecc4dadd91-20230131
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=ym/iv7BqnrAAqvjKBLvLksYj7vv1N9AT8u6v3Sv1Zmk=;
        b=deeHXZsL0sskKXmqmBGLSU+e99z6GGHLF2iIW/kwctnNSytdXqt+7EVEROkH7eDzBlfn2V7l1VkAjsGJgbswj9V52lLwthy+j5JJDonOwGnu7IezTfbGoQ635aVBSGsZi2LmdAWEl61T+6c681vgmDmV7JtLdeS8TeLIUMBj0DM=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.18,REQID:76450abe-62d8-42b6-a515-d5ae1b02a478,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:95
X-CID-INFO: VERSION:1.1.18,REQID:76450abe-62d8-42b6-a515-d5ae1b02a478,IP:0,URL
        :0,TC:0,Content:0,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_GS981B3D,ACTION
        :quarantine,TS:95
X-CID-META: VersionHash:3ca2d6b,CLOUDID:172c04f7-ff42-4fb0-b929-626456a83c14,B
        ulkID:230131173631VYF46X1B,BulkQuantity:0,Recheck:0,SF:29|28|17|19|48,TC:n
        il,Content:0,EDM:-3,IP:nil,URL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OS
        I:0,OSA:0
X-CID-BVR: 0
X-UUID: bda73fd0a14a11eda06fc9ecc4dadd91-20230131
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <shayne.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 813190597; Tue, 31 Jan 2023 17:36:29 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Tue, 31 Jan 2023 17:36:29 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Tue, 31 Jan 2023 17:36:29 +0800
From:   Shayne Chen <shayne.chen@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>
CC:     linux-wireless <linux-wireless@vger.kernel.org>,
        Lorenzo Bianconi <lorenzo@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        Bo Jiao <Bo.Jiao@mediatek.com>,
        linux-mediatek <linux-mediatek@lists.infradead.org>,
        Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH v2 06/13] wifi: mt76: add EHT rate stats for ethtool
Date:   Tue, 31 Jan 2023 17:36:04 +0800
Message-ID: <20230131093611.30914-7-shayne.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20230131093611.30914-1-shayne.chen@mediatek.com>
References: <20230131093611.30914-1-shayne.chen@mediatek.com>
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

Add support to get EHT rate stats from ethtool.
This is the preliminary patch to add EHT support for mt7996.

Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c    | 11 ++++++++---
 drivers/net/wireless/mediatek/mt76/mt76.h        |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/main.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7921/main.c |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7996/main.c |  8 +++++++-
 5 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 80c1280eb402..b117e4467c87 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1700,7 +1700,7 @@ u16 mt76_calculate_default_rate(struct mt76_phy *phy, int rateidx)
 EXPORT_SYMBOL_GPL(mt76_calculate_default_rate);
 
 void mt76_ethtool_worker(struct mt76_ethtool_worker_info *wi,
-			 struct mt76_sta_stats *stats)
+			 struct mt76_sta_stats *stats, bool eht)
 {
 	int i, ei = wi->initial_stat_idx;
 	u64 *data = wi->data;
@@ -1716,11 +1716,16 @@ void mt76_ethtool_worker(struct mt76_ethtool_worker_info *wi,
 	data[ei++] += stats->tx_mode[MT_PHY_TYPE_HE_EXT_SU];
 	data[ei++] += stats->tx_mode[MT_PHY_TYPE_HE_TB];
 	data[ei++] += stats->tx_mode[MT_PHY_TYPE_HE_MU];
+	if (eht) {
+		data[ei++] += stats->tx_mode[MT_PHY_TYPE_EHT_SU];
+		data[ei++] += stats->tx_mode[MT_PHY_TYPE_EHT_TRIG];
+		data[ei++] += stats->tx_mode[MT_PHY_TYPE_EHT_MU];
+	}
 
-	for (i = 0; i < ARRAY_SIZE(stats->tx_bw); i++)
+	for (i = 0; i < (ARRAY_SIZE(stats->tx_bw) - !eht); i++)
 		data[ei++] += stats->tx_bw[i];
 
-	for (i = 0; i < 12; i++)
+	for (i = 0; i < (eht ? 14 : 12); i++)
 		data[ei++] += stats->tx_mcs[i];
 
 	wi->worker_stat_count = ei - wi->initial_stat_idx;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 3aa3f6c0ecf6..da4902322a80 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -272,7 +272,7 @@ enum mt76_phy_type {
 
 struct mt76_sta_stats {
 	u64 tx_mode[__MT_PHY_TYPE_MAX];
-	u64 tx_bw[4];		/* 20, 40, 80, 160 */
+	u64 tx_bw[5];		/* 20, 40, 80, 160, 320 */
 	u64 tx_nss[4];		/* 1, 2, 3, 4 */
 	u64 tx_mcs[16];		/* mcs idx */
 	u64 tx_bytes;
@@ -1318,7 +1318,7 @@ mt76u_bulk_msg(struct mt76_dev *dev, void *data, int len, int *actual_len,
 
 void mt76_ethtool_page_pool_stats(struct mt76_dev *dev, u64 *data, int *index);
 void mt76_ethtool_worker(struct mt76_ethtool_worker_info *wi,
-			 struct mt76_sta_stats *stats);
+			 struct mt76_sta_stats *stats, bool eht);
 int mt76_skb_adjust_pad(struct sk_buff *skb, int pad);
 int __mt76u_vendor_request(struct mt76_dev *dev, u8 req, u8 req_type,
 			   u16 val, u16 offset, void *buf, size_t len);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index a54921fc73ab..3bbccbdfc5eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1317,7 +1317,7 @@ static void mt7915_ethtool_worker(void *wi_data, struct ieee80211_sta *sta)
 	if (msta->vif->mt76.idx != wi->idx)
 		return;
 
-	mt76_ethtool_worker(wi, &msta->wcid.stats);
+	mt76_ethtool_worker(wi, &msta->wcid.stats, false);
 }
 
 static
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 1ae90b9d99df..75eaf86c6a78 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1129,7 +1129,7 @@ mt7921_ethtool_worker(void *wi_data, struct ieee80211_sta *sta)
 	if (msta->vif->mt76.idx != wi->idx)
 		return;
 
-	mt76_ethtool_worker(wi, &msta->wcid.stats);
+	mt76_ethtool_worker(wi, &msta->wcid.stats, false);
 }
 
 static
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index c423b052e4f4..2031fffe6f4e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1084,10 +1084,14 @@ static const char mt7996_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"v_tx_mode_he_ext_su",
 	"v_tx_mode_he_tb",
 	"v_tx_mode_he_mu",
+	"v_tx_mode_eht_su",
+	"v_tx_mode_eht_trig",
+	"v_tx_mode_eht_mu",
 	"v_tx_bw_20",
 	"v_tx_bw_40",
 	"v_tx_bw_80",
 	"v_tx_bw_160",
+	"v_tx_bw_320",
 	"v_tx_mcs_0",
 	"v_tx_mcs_1",
 	"v_tx_mcs_2",
@@ -1100,6 +1104,8 @@ static const char mt7996_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"v_tx_mcs_9",
 	"v_tx_mcs_10",
 	"v_tx_mcs_11",
+	"v_tx_mcs_12",
+	"v_tx_mcs_13",
 };
 
 #define MT7996_SSTATS_LEN ARRAY_SIZE(mt7996_gstrings_stats)
@@ -1133,7 +1139,7 @@ static void mt7996_ethtool_worker(void *wi_data, struct ieee80211_sta *sta)
 	if (msta->vif->mt76.idx != wi->idx)
 		return;
 
-	mt76_ethtool_worker(wi, &msta->stats);
+	mt76_ethtool_worker(wi, &msta->stats, true);
 }
 
 static
-- 
2.25.1

