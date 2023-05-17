Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7B6705DFD
	for <lists+linux-wireless@lfdr.de>; Wed, 17 May 2023 05:23:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231284AbjEQDXe (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 16 May 2023 23:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231313AbjEQDXY (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 16 May 2023 23:23:24 -0400
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC7B81BC3
        for <linux-wireless@vger.kernel.org>; Tue, 16 May 2023 20:23:13 -0700 (PDT)
X-UUID: 24c27382f46211edb20a276fd37b9834-20230517
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=Our77EvHjNgB+PJKbjT1bS4HI9+h74UYwQqUwFlMvWM=;
        b=P4im/x0mAwrz0fpKoW+ppisP0HOCaWK8M/uC7qhbMoOnCVrC8ydYrGjlaKxKSbwPxDofnzTgDygUx7gVKBHPTC6bG1E3VILILsfYZrrKuQjgp2VnoIVTWiFFY6rhR2QXa6RKoGlgADyQY8SwG4fjikap3xM0cZpr2GkTQgUtMoQ=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.25,REQID:04ae1f0f-77b5-444e-aef0-cdf73cf75485,IP:0,U
        RL:0,TC:0,Content:0,EDM:0,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION:
        release,TS:0
X-CID-META: VersionHash:d5b0ae3,CLOUDID:2be50e6c-2f20-4998-991c-3b78627e4938,B
        ulkID:nil,BulkQuantity:0,Recheck:0,SF:102,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:0,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,OSA:0,AV:0
X-CID-BVR: 0
X-CID-BAS: 0,_,0,_
X-UUID: 24c27382f46211edb20a276fd37b9834-20230517
Received: from mtkmbs13n2.mediatek.inc [(172.21.101.108)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 193660650; Wed, 17 May 2023 11:23:07 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.26; Wed, 17 May 2023 11:23:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.1118.26 via Frontend Transport; Wed, 17 May 2023 11:23:02 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Felix Fietkau <nbd@nbd.name>, <linux-wireless@vger.kernel.org>
CC:     Lorenzo Bianconi <lorenzo.bianconi@redhat.com>,
        Shayne Chen <shayne.chen@mediatek.com>,
        Evelyn Tsai <evelyn.tsai@mediatek.com>,
        <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Ben Greear <greearb@candelatech.com>
Subject: [PATCH 2/2] wifi: mt76: mt7915: accumulate mu-mimo ofdma muru stats
Date:   Wed, 17 May 2023 11:22:59 +0800
Message-ID: <52ff6b0b789578c7873c1c349234063a8a2a9665.1684280458.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <78ae2336a119f416eb970ee403f85db35af2ef09.1684280458.git.ryder.lee@mediatek.com>
References: <78ae2336a119f416eb970ee403f85db35af2ef09.1684280458.git.ryder.lee@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The stats are clear-on-read, which makes it very difficult for tools
to adequately deal with wrapped stats and with keeping good totals.

So, accumulate these values when they are read from the firmware/radio
and present totals to user-space.

Signed-off-by: Ben Greear <greearb@candelatech.com>
Signed-off-by: Ryder Lee <ryder.lee@mediatek.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  7 +--
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  3 +
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 63 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 41 ++++++++++--
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 34 +++++++++-
 5 files changed, 139 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 879884ead660..971213393da9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -251,7 +251,6 @@ static int mt7915_muru_stats_show(struct seq_file *file, void *data)
 {
 	struct mt7915_phy *phy = file->private;
 	struct mt7915_dev *dev = phy->dev;
-	struct mt7915_mcu_muru_stats mu_stats = {};
 	static const char * const dl_non_he_type[] = {
 		"CCK", "OFDM", "HT MIX", "HT GF",
 		"VHT SU", "VHT 2MU", "VHT 3MU", "VHT 4MU"
@@ -275,7 +274,7 @@ static int mt7915_muru_stats_show(struct seq_file *file, void *data)
 
 	mutex_lock(&dev->mt76.mutex);
 
-	ret = mt7915_mcu_muru_debug_get(phy, &mu_stats);
+	ret = mt7915_mcu_muru_debug_get(phy);
 	if (ret)
 		goto exit;
 
@@ -285,7 +284,7 @@ static int mt7915_muru_stats_show(struct seq_file *file, void *data)
 	for (i = 0; i < 5; i++)
 		seq_printf(file, "%8s | ", dl_non_he_type[i]);
 
-#define __dl_u32(s)     le32_to_cpu(mu_stats.dl.s)
+#define __dl_u32(s)     phy->mib.dl_##s
 	seq_puts(file, "\nTotal Count:");
 	seq_printf(file, "%8u | %8u | %8u | %8u | %8u | ",
 		   __dl_u32(cck_cnt),
@@ -389,7 +388,7 @@ static int mt7915_muru_stats_show(struct seq_file *file, void *data)
 	for (i = 0; i < 3; i++)
 		seq_printf(file, "%8s | ", ul_he_type[i]);
 
-#define __ul_u32(s)     le32_to_cpu(mu_stats.ul.s)
+#define __ul_u32(s)     phy->mib.ul_##s
 	seq_puts(file, "\nTotal Count:");
 	seq_printf(file, "%8u | %8u | %8u | ",
 		   __ul_u32(hetrig_2mu_cnt),
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index dfe42af6dc97..e06bfa4288b7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2075,6 +2075,9 @@ void mt7915_mac_work(struct work_struct *work)
 
 		mt7915_mac_update_stats(phy);
 		mt7915_mac_severe_check(phy);
+
+		if (phy->dev->muru_debug)
+			mt7915_mcu_muru_debug_get(phy);
 	}
 
 	mutex_unlock(&mphy->dev->mutex);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index bf87aa4cc630..226ec3755efd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1255,6 +1255,38 @@ static const char mt7915_gstrings_stats[][ETH_GSTRING_LEN] = {
 	"rx_vec_queue_overflow_drop_cnt",
 	"rx_ba_cnt",
 
+	/* muru mu-mimo and ofdma related stats */
+	"dl_cck_cnt",
+	"dl_ofdm_cnt",
+	"dl_htmix_cnt",
+	"dl_htgf_cnt",
+	"dl_vht_su_cnt",
+	"dl_vht_2mu_cnt",
+	"dl_vht_3mu_cnt",
+	"dl_vht_4mu_cnt",
+	"dl_he_su_cnt",
+	"dl_he_ext_su_cnt",
+	"dl_he_2ru_cnt",
+	"dl_he_2mu_cnt",
+	"dl_he_3ru_cnt",
+	"dl_he_3mu_cnt",
+	"dl_he_4ru_cnt",
+	"dl_he_4mu_cnt",
+	"dl_he_5to8ru_cnt",
+	"dl_he_9to16ru_cnt",
+	"dl_he_gtr16ru_cnt",
+
+	"ul_hetrig_su_cnt",
+	"ul_hetrig_2ru_cnt",
+	"ul_hetrig_3ru_cnt",
+	"ul_hetrig_4ru_cnt",
+	"ul_hetrig_5to8ru_cnt",
+	"ul_hetrig_9to16ru_cnt",
+	"ul_hetrig_gtr16ru_cnt",
+	"ul_hetrig_2mu_cnt",
+	"ul_hetrig_3mu_cnt",
+	"ul_hetrig_4mu_cnt",
+
 	/* per vif counters */
 	"v_tx_mode_cck",
 	"v_tx_mode_ofdm",
@@ -1409,6 +1441,37 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	data[ei++] = mib->rx_vec_queue_overflow_drop_cnt;
 	data[ei++] = mib->rx_ba_cnt;
 
+	data[ei++] = mib->dl_cck_cnt;
+	data[ei++] = mib->dl_ofdm_cnt;
+	data[ei++] = mib->dl_htmix_cnt;
+	data[ei++] = mib->dl_htgf_cnt;
+	data[ei++] = mib->dl_vht_su_cnt;
+	data[ei++] = mib->dl_vht_2mu_cnt;
+	data[ei++] = mib->dl_vht_3mu_cnt;
+	data[ei++] = mib->dl_vht_4mu_cnt;
+	data[ei++] = mib->dl_he_su_cnt;
+	data[ei++] = mib->dl_he_ext_su_cnt;
+	data[ei++] = mib->dl_he_2ru_cnt;
+	data[ei++] = mib->dl_he_2mu_cnt;
+	data[ei++] = mib->dl_he_3ru_cnt;
+	data[ei++] = mib->dl_he_3mu_cnt;
+	data[ei++] = mib->dl_he_4ru_cnt;
+	data[ei++] = mib->dl_he_4mu_cnt;
+	data[ei++] = mib->dl_he_5to8ru_cnt;
+	data[ei++] = mib->dl_he_9to16ru_cnt;
+	data[ei++] = mib->dl_he_gtr16ru_cnt;
+
+	data[ei++] = mib->ul_hetrig_su_cnt;
+	data[ei++] = mib->ul_hetrig_2ru_cnt;
+	data[ei++] = mib->ul_hetrig_3ru_cnt;
+	data[ei++] = mib->ul_hetrig_4ru_cnt;
+	data[ei++] = mib->ul_hetrig_5to8ru_cnt;
+	data[ei++] = mib->ul_hetrig_9to16ru_cnt;
+	data[ei++] = mib->ul_hetrig_gtr16ru_cnt;
+	data[ei++] = mib->ul_hetrig_2mu_cnt;
+	data[ei++] = mib->ul_hetrig_3mu_cnt;
+	data[ei++] = mib->ul_hetrig_4mu_cnt;
+
 	/* Add values for all stations owned by this vif */
 	wi.initial_stat_idx = ei;
 	ieee80211_iterate_stations_atomic(hw, mt7915_ethtool_worker, &wi);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 5916dcaa8c7e..1a48f2b35b03 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2116,12 +2116,11 @@ int mt7915_mcu_muru_debug_set(struct mt7915_dev *dev, bool enabled)
 				sizeof(data), false);
 }
 
-int mt7915_mcu_muru_debug_get(struct mt7915_phy *phy, void *ms)
+int mt7915_mcu_muru_debug_get(struct mt7915_phy *phy)
 {
 	struct mt7915_dev *dev = phy->dev;
 	struct sk_buff *skb;
-	struct mt7915_mcu_muru_stats *mu_stats =
-				(struct mt7915_mcu_muru_stats *)ms;
+	struct mt7915_mcu_muru_stats *mu_stats;
 	int ret;
 
 	struct {
@@ -2137,7 +2136,41 @@ int mt7915_mcu_muru_debug_get(struct mt7915_phy *phy, void *ms)
 	if (ret)
 		return ret;
 
-	memcpy(mu_stats, skb->data, sizeof(struct mt7915_mcu_muru_stats));
+	mu_stats = (struct mt7915_mcu_muru_stats *)(skb->data);
+
+	/* accumulate stats, these are clear-on-read */
+	phy->mib.dl_cck_cnt += le32_to_cpu(mu_stats->dl.cck_cnt);
+	phy->mib.dl_ofdm_cnt += le32_to_cpu(mu_stats->dl.ofdm_cnt);
+	phy->mib.dl_htmix_cnt += le32_to_cpu(mu_stats->dl.htmix_cnt);
+	phy->mib.dl_htgf_cnt += le32_to_cpu(mu_stats->dl.htgf_cnt);
+	phy->mib.dl_vht_su_cnt += le32_to_cpu(mu_stats->dl.vht_su_cnt);
+	phy->mib.dl_vht_2mu_cnt += le32_to_cpu(mu_stats->dl.vht_2mu_cnt);
+	phy->mib.dl_vht_3mu_cnt += le32_to_cpu(mu_stats->dl.vht_3mu_cnt);
+	phy->mib.dl_vht_4mu_cnt += le32_to_cpu(mu_stats->dl.vht_4mu_cnt);
+	phy->mib.dl_he_su_cnt += le32_to_cpu(mu_stats->dl.he_su_cnt);
+	phy->mib.dl_he_2ru_cnt += le32_to_cpu(mu_stats->dl.he_2ru_cnt);
+	phy->mib.dl_he_2mu_cnt += le32_to_cpu(mu_stats->dl.he_2mu_cnt);
+	phy->mib.dl_he_3ru_cnt += le32_to_cpu(mu_stats->dl.he_3ru_cnt);
+	phy->mib.dl_he_3mu_cnt += le32_to_cpu(mu_stats->dl.he_3mu_cnt);
+	phy->mib.dl_he_4ru_cnt += le32_to_cpu(mu_stats->dl.he_4ru_cnt);
+	phy->mib.dl_he_4mu_cnt += le32_to_cpu(mu_stats->dl.he_4mu_cnt);
+	phy->mib.dl_he_5to8ru_cnt += le32_to_cpu(mu_stats->dl.he_5to8ru_cnt);
+	phy->mib.dl_he_9to16ru_cnt += le32_to_cpu(mu_stats->dl.he_9to16ru_cnt);
+	phy->mib.dl_he_gtr16ru_cnt += le32_to_cpu(mu_stats->dl.he_gtr16ru_cnt);
+
+	phy->mib.ul_hetrig_su_cnt += le32_to_cpu(mu_stats->ul.hetrig_su_cnt);
+	phy->mib.ul_hetrig_2ru_cnt += le32_to_cpu(mu_stats->ul.hetrig_2ru_cnt);
+	phy->mib.ul_hetrig_3ru_cnt += le32_to_cpu(mu_stats->ul.hetrig_3ru_cnt);
+	phy->mib.ul_hetrig_4ru_cnt += le32_to_cpu(mu_stats->ul.hetrig_4ru_cnt);
+	phy->mib.ul_hetrig_5to8ru_cnt +=
+		le32_to_cpu(mu_stats->ul.hetrig_5to8ru_cnt);
+	phy->mib.ul_hetrig_9to16ru_cnt +=
+		le32_to_cpu(mu_stats->ul.hetrig_9to16ru_cnt);
+	phy->mib.ul_hetrig_gtr16ru_cnt +=
+		le32_to_cpu(mu_stats->ul.hetrig_gtr16ru_cnt);
+	phy->mib.ul_hetrig_2mu_cnt += le32_to_cpu(mu_stats->ul.hetrig_2mu_cnt);
+	phy->mib.ul_hetrig_3mu_cnt += le32_to_cpu(mu_stats->ul.hetrig_3mu_cnt);
+	phy->mib.ul_hetrig_4mu_cnt += le32_to_cpu(mu_stats->ul.hetrig_4mu_cnt);
 	dev_kfree_skb(skb);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 145f89a19443..929d49792a01 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -216,6 +216,38 @@ struct mib_stats {
 
 	u32 tx_amsdu[8];
 	u32 tx_amsdu_cnt;
+
+	/* mcu_muru_stats */
+	u32 dl_cck_cnt;
+	u32 dl_ofdm_cnt;
+	u32 dl_htmix_cnt;
+	u32 dl_htgf_cnt;
+	u32 dl_vht_su_cnt;
+	u32 dl_vht_2mu_cnt;
+	u32 dl_vht_3mu_cnt;
+	u32 dl_vht_4mu_cnt;
+	u32 dl_he_su_cnt;
+	u32 dl_he_ext_su_cnt;
+	u32 dl_he_2ru_cnt;
+	u32 dl_he_2mu_cnt;
+	u32 dl_he_3ru_cnt;
+	u32 dl_he_3mu_cnt;
+	u32 dl_he_4ru_cnt;
+	u32 dl_he_4mu_cnt;
+	u32 dl_he_5to8ru_cnt;
+	u32 dl_he_9to16ru_cnt;
+	u32 dl_he_gtr16ru_cnt;
+
+	u32 ul_hetrig_su_cnt;
+	u32 ul_hetrig_2ru_cnt;
+	u32 ul_hetrig_3ru_cnt;
+	u32 ul_hetrig_4ru_cnt;
+	u32 ul_hetrig_5to8ru_cnt;
+	u32 ul_hetrig_9to16ru_cnt;
+	u32 ul_hetrig_gtr16ru_cnt;
+	u32 ul_hetrig_2mu_cnt;
+	u32 ul_hetrig_3mu_cnt;
+	u32 ul_hetrig_4mu_cnt;
 };
 
 /* crash-dump */
@@ -625,7 +657,7 @@ void mt7915_set_stream_he_caps(struct mt7915_phy *phy);
 void mt7915_set_stream_vht_txbf_caps(struct mt7915_phy *phy);
 void mt7915_update_channel(struct mt76_phy *mphy);
 int mt7915_mcu_muru_debug_set(struct mt7915_dev *dev, bool enable);
-int mt7915_mcu_muru_debug_get(struct mt7915_phy *phy, void *ms);
+int mt7915_mcu_muru_debug_get(struct mt7915_phy *phy);
 int mt7915_mcu_wed_enable_rx_stats(struct mt7915_dev *dev);
 int mt7915_init_debugfs(struct mt7915_phy *phy);
 void mt7915_debugfs_rx_fw_monitor(struct mt7915_dev *dev, const void *data, int len);
-- 
2.18.0

