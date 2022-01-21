Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91D234967BC
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jan 2022 23:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbiAUWRC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 21 Jan 2022 17:17:02 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:51744 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229657AbiAUWRB (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 21 Jan 2022 17:17:01 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.24])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 880BFA0068
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jan 2022 22:17:00 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 4DBD63C0069
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jan 2022 22:17:00 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id CC4E513C2B0;
        Fri, 21 Jan 2022 14:16:59 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com CC4E513C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1642803419;
        bh=MNsD6RC8h4QVv7CeZ6WO8ebA8EG8Gfhog/qYCYhRq8A=;
        h=From:To:Cc:Subject:Date:From;
        b=fENKsjtzE7T8xxgs25Ah8v2tqcZ64n53lNOnMNDbeoZxbSjOm9R+g/AeXjwSBpKg/
         mqcxD1Sx0R5EP8u13m/SFhA9zu8KBEO91C41dadsbcs84kTZcDmSKlrK2zOWDDeBiP
         8wS5axR+UJAufdec9Ff1nthLlHY9g9e2TyeBM98s=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH] mt76: mt7915: accumulate mu-mimo ofdma muru stats.
Date:   Fri, 21 Jan 2022 14:16:54 -0800
Message-Id: <20220121221654.8499-1-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1642803421-W9U7nV7b2tOL
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

The stats are clear-on-read, which makes it very difficult for tools
to adequately deal with wrapped stats and with keeping good totals.

So, accumulate these values when they are read from the firmware/radio
and present totals to user-space.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   |  7 ++--
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 11 ++++--
 .../net/wireless/mediatek/mt76/mt7915/mcu.c   | 39 +++++++++++++++++--
 .../wireless/mediatek/mt76/mt7915/mt7915.h    | 34 +++++++++++++++-
 4 files changed, 79 insertions(+), 12 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 2938a34b0cbe..7ac700cff61e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -109,7 +109,6 @@ static int mt7915_muru_stats_show(struct seq_file *file, void *data)
 {
 	struct mt7915_phy *phy = file->private;
 	struct mt7915_dev *dev = phy->dev;
-	struct mt7915_mcu_muru_stats mu_stats = {};
 	static const char * const dl_non_he_type[] = {
 		"CCK", "OFDM", "HT MIX", "HT GF",
 		"VHT SU", "VHT 2MU", "VHT 3MU", "VHT 4MU"
@@ -133,7 +132,7 @@ static int mt7915_muru_stats_show(struct seq_file *file, void *data)
 
 	mutex_lock(&dev->mt76.mutex);
 
-	ret = mt7915_mcu_muru_debug_get(phy, &mu_stats);
+	ret = mt7915_mcu_muru_debug_get(phy);
 	if (ret)
 		goto exit;
 
@@ -143,7 +142,7 @@ static int mt7915_muru_stats_show(struct seq_file *file, void *data)
 	for (i = 0; i < 5; i++)
 		seq_printf(file, "%8s | ", dl_non_he_type[i]);
 
-#define __dl_u32(s)     le32_to_cpu(mu_stats.dl.s)
+#define __dl_u32(s)     phy->mib.rx_##s
 	seq_puts(file, "\nTotal Count:");
 	seq_printf(file, "%8u | %8u | %8u | %8u | %8u | ",
 		   __dl_u32(cck_cnt),
@@ -247,7 +246,7 @@ static int mt7915_muru_stats_show(struct seq_file *file, void *data)
 	for (i = 0; i < 3; i++)
 		seq_printf(file, "%8s | ", ul_he_type[i]);
 
-#define __ul_u32(s)     le32_to_cpu(mu_stats.ul.s)
+#define __ul_u32(s)     phy->mib.tx_##s
 	seq_puts(file, "\nTotal Count:");
 	seq_printf(file, "%8u | %8u | %8u | ",
 		   __ul_u32(hetrig_2mu_cnt),
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 4aae5aea7ce7..1db9b3d27c6d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2627,12 +2627,17 @@ void mt7915_mac_work(struct work_struct *work)
 	/* this method is called about every 100ms.  Some pkt counters are 16-bit,
 	 * so poll every 200ms to keep overflows at a minimum.
 	 */
-	if (++mphy->mac_work_count == 2) {
-		mphy->mac_work_count = 0;
-
+	if ((++mphy->mac_work_count & 0x1) == 0) {
 		mt7915_mac_update_stats(phy);
 	}
 
+	/* MURU stats are 32-bit, poll them more rarely */
+	if (phy->dev->muru_debug) {
+		/* query these every 4 'ticks' */
+		if ((mphy->mac_work_count & 0x3) == 0)
+			mt7915_mcu_muru_debug_get(phy);
+	}
+
 	mutex_unlock(&mphy->dev->mutex);
 
 	mt76_tx_status_check(mphy->dev, false);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 5f93fb9b9287..91f3a60329e5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -2354,12 +2354,11 @@ int mt7915_mcu_muru_debug_set(struct mt7915_dev *dev, bool enabled)
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
@@ -2375,7 +2374,39 @@ int mt7915_mcu_muru_debug_get(struct mt7915_phy *phy, void *ms)
 	if (ret)
 		return ret;
 
-	memcpy(mu_stats, skb->data, sizeof(struct mt7915_mcu_muru_stats));
+	mu_stats = (struct mt7915_mcu_muru_stats *)(skb->data);
+
+	/* accumulate stats, these are clear-on-read */
+	phy->mib.rx_cck_cnt += le32_to_cpu(mu_stats->dl.cck_cnt);
+	phy->mib.rx_ofdm_cnt += le32_to_cpu(mu_stats->dl.ofdm_cnt);
+	phy->mib.rx_htmix_cnt += le32_to_cpu(mu_stats->dl.htmix_cnt);
+	phy->mib.rx_htgf_cnt += le32_to_cpu(mu_stats->dl.htgf_cnt);
+	phy->mib.rx_vht_su_cnt += le32_to_cpu(mu_stats->dl.vht_su_cnt);
+	phy->mib.rx_vht_2mu_cnt += le32_to_cpu(mu_stats->dl.vht_2mu_cnt);
+	phy->mib.rx_vht_3mu_cnt += le32_to_cpu(mu_stats->dl.vht_3mu_cnt);
+	phy->mib.rx_vht_4mu_cnt += le32_to_cpu(mu_stats->dl.vht_4mu_cnt);
+	phy->mib.rx_he_su_cnt += le32_to_cpu(mu_stats->dl.he_su_cnt);
+	phy->mib.rx_he_2ru_cnt += le32_to_cpu(mu_stats->dl.he_2ru_cnt);
+	phy->mib.rx_he_2mu_cnt += le32_to_cpu(mu_stats->dl.he_2mu_cnt);
+	phy->mib.rx_he_3ru_cnt += le32_to_cpu(mu_stats->dl.he_3ru_cnt);
+	phy->mib.rx_he_3mu_cnt += le32_to_cpu(mu_stats->dl.he_3mu_cnt);
+	phy->mib.rx_he_4ru_cnt += le32_to_cpu(mu_stats->dl.he_4ru_cnt);
+	phy->mib.rx_he_4mu_cnt += le32_to_cpu(mu_stats->dl.he_4mu_cnt);
+	phy->mib.rx_he_5to8ru_cnt += le32_to_cpu(mu_stats->dl.he_5to8ru_cnt);
+	phy->mib.rx_he_9to16ru_cnt += le32_to_cpu(mu_stats->dl.he_9to16ru_cnt);
+	phy->mib.rx_he_gtr16ru_cnt += le32_to_cpu(mu_stats->dl.he_gtr16ru_cnt);
+
+	phy->mib.tx_hetrig_su_cnt += le32_to_cpu(mu_stats->ul.hetrig_su_cnt);
+	phy->mib.tx_hetrig_2ru_cnt += le32_to_cpu(mu_stats->ul.hetrig_2ru_cnt);
+	phy->mib.tx_hetrig_3ru_cnt += le32_to_cpu(mu_stats->ul.hetrig_3ru_cnt);
+	phy->mib.tx_hetrig_4ru_cnt += le32_to_cpu(mu_stats->ul.hetrig_4ru_cnt);
+	phy->mib.tx_hetrig_5to8ru_cnt += le32_to_cpu(mu_stats->ul.hetrig_5to8ru_cnt);
+	phy->mib.tx_hetrig_9to16ru_cnt += le32_to_cpu(mu_stats->ul.hetrig_9to16ru_cnt);
+	phy->mib.tx_hetrig_gtr16ru_cnt += le32_to_cpu(mu_stats->ul.hetrig_gtr16ru_cnt);
+	phy->mib.tx_hetrig_2mu_cnt += le32_to_cpu(mu_stats->ul.hetrig_2mu_cnt);
+	phy->mib.tx_hetrig_3mu_cnt += le32_to_cpu(mu_stats->ul.hetrig_3mu_cnt);
+	phy->mib.tx_hetrig_4mu_cnt += le32_to_cpu(mu_stats->ul.hetrig_4mu_cnt);
+
 	dev_kfree_skb(skb);
 
 	return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 956da21350c5..2e6e8dd8a097 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -262,6 +262,38 @@ struct mib_stats {
 	u32 rx_d_bad_vht_rix;
 	u32 rx_d_bad_mode;
 	u32 rx_d_bad_bw;
+
+	/* mcu_muru_stats */
+	u32 rx_cck_cnt;
+	u32 rx_ofdm_cnt;
+	u32 rx_htmix_cnt;
+	u32 rx_htgf_cnt;
+	u32 rx_vht_su_cnt;
+	u32 rx_vht_2mu_cnt;
+	u32 rx_vht_3mu_cnt;
+	u32 rx_vht_4mu_cnt;
+	u32 rx_he_su_cnt;
+	u32 rx_he_ext_su_cnt;
+	u32 rx_he_2ru_cnt;
+	u32 rx_he_2mu_cnt;
+	u32 rx_he_3ru_cnt;
+	u32 rx_he_3mu_cnt;
+	u32 rx_he_4ru_cnt;
+	u32 rx_he_4mu_cnt;
+	u32 rx_he_5to8ru_cnt;
+	u32 rx_he_9to16ru_cnt;
+	u32 rx_he_gtr16ru_cnt;
+
+	u32 tx_hetrig_su_cnt;
+	u32 tx_hetrig_2ru_cnt;
+	u32 tx_hetrig_3ru_cnt;
+	u32 tx_hetrig_4ru_cnt;
+	u32 tx_hetrig_5to8ru_cnt;
+	u32 tx_hetrig_9to16ru_cnt;
+	u32 tx_hetrig_gtr16ru_cnt;
+	u32 tx_hetrig_2mu_cnt;
+	u32 tx_hetrig_3mu_cnt;
+	u32 tx_hetrig_4mu_cnt;
 };
 
 struct mt7915_hif {
@@ -603,7 +635,7 @@ void mt7915_set_stream_he_caps(struct mt7915_phy *phy);
 void mt7915_set_stream_vht_txbf_caps(struct mt7915_phy *phy);
 void mt7915_update_channel(struct mt76_phy *mphy);
 int mt7915_mcu_muru_debug_set(struct mt7915_dev *dev, bool enable);
-int mt7915_mcu_muru_debug_get(struct mt7915_phy *phy, void *ms);
+int mt7915_mcu_muru_debug_get(struct mt7915_phy *phy);
 int mt7915_init_debugfs(struct mt7915_phy *phy);
 #ifdef CONFIG_MAC80211_DEBUGFS
 void mt7915_sta_add_debugfs(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
-- 
2.20.1

