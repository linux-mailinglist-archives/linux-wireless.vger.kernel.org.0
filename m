Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD578706F87
	for <lists+linux-wireless@lfdr.de>; Wed, 17 May 2023 19:35:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjEQRfD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 17 May 2023 13:35:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbjEQRe7 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 17 May 2023 13:34:59 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECC4D26A3
        for <linux-wireless@vger.kernel.org>; Wed, 17 May 2023 10:34:51 -0700 (PDT)
X-UUID: 1e1fe042f4d911ed9cb5633481061a41-20230518
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=mTVM1Iv6lrP+o0UbclLwEhF8i+LhIcip7dA/UGfzKpI=;
        b=C7ZuHYoNi6Vh7V4qK/mUEExZKjHWxD7JiRUzdXOrymhVpLoLp9gjsGVaYa2AQU5IoS+t69iWmX7f8EUwXcJJUkNGb9B4fJ7P/KXfnCdN1s/LlOrtmpW8bEPdAfjiRH6CkDDdip8PZEYfPScwbzfFh5cu4fuSCV1Ej1FPjnDBt2w=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:6248f7ff-586f-4e0f-a4fd-d447d77023a4,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:5f21246c-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 1e1fe042f4d911ed9cb5633481061a41-20230518
Received: from mtkmbs11n1.mediatek.inc [(172.21.101.185)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1978017015; Thu, 18 May 2023 01:34:46 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Thu, 18 May 2023 01:34:45 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Thu, 18 May 2023 01:34:45 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "Ben Greear" <greearb@candelatech.com>
Subject: [PATCH v2 1/2] wifi: mt76: add tx_nss histogram to ethtool stats
Date:   Thu, 18 May 2023 01:34:42 +0800
Message-ID: <78ae2336a119f416eb970ee403f85db35af2ef09.1684344625.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

mt76_connac2_mac_fill_txs() counts tx_nss but ethtool doesn't show
stats. Add missing histogram accordingly.

Signed-off-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c    | 3 +++
 drivers/net/wireless/mediatek/mt76/mt7915/main.c | 4 ++++
 drivers/net/wireless/mediatek/mt76/mt7921/main.c | 4 ++++
 drivers/net/wireless/mediatek/mt76/mt7996/main.c | 4 ++++
 4 files changed, 15 insertions(+)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 467afef98ba2..9d3b38c2af7e 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1743,6 +1743,9 @@ void mt76_ethtool_worker(struct mt76_ethtool_worker_info *wi,
 	for (i = 0; i < (eht ? 14 : 12); i++)
 		data[ei++] += stats->tx_mcs[i];
 
+	for (i = 0; i < 4; i++)
+		data[ei++] += stats->tx_nss[i];
+
 	wi->worker_stat_count = ei - wi->initial_stat_idx;
 }
 EXPORT_SYMBOL_GPL(mt76_ethtool_worker);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index d899bc2d0a84..bf87aa4cc630 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1281,6 +1281,10 @@ static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"v_tx_mcs_9",
 	"v_tx_mcs_10",
 	"v_tx_mcs_11",
+	"v_tx_nss_1",
+	"v_tx_nss_2",
+	"v_tx_nss_3",
+	"v_tx_nss_4",
 };
 
 #define MT7915_SSTATS_LEN ARRAY_SIZE(mt7915_gstrings_stats)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 0c9a472bc81a..ad267afb493c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1078,6 +1078,10 @@ static const char mt7921_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"v_tx_mcs_9",
 	"v_tx_mcs_10",
 	"v_tx_mcs_11",
+	"v_tx_nss_1",
+	"v_tx_nss_2",
+	"v_tx_nss_3",
+	"v_tx_nss_4",
 };
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 8e1b7cc48146..56818c7ac08e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -1155,6 +1155,10 @@ static const char mt7996_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"v_tx_mcs_11",
 	"v_tx_mcs_12",
 	"v_tx_mcs_13",
+	"v_tx_nss_1",
+	"v_tx_nss_2",
+	"v_tx_nss_3",
+	"v_tx_nss_4",
 };
 
 #define MT7996_SSTATS_LEN ARRAY_SIZE(mt7996_gstrings_stats)
-- 
2.18.0

