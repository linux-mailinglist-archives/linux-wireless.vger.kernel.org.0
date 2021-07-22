Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7473D2D9E
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Jul 2021 22:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231131AbhGVTok (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 22 Jul 2021 15:44:40 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:56428 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230455AbhGVToh (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 22 Jul 2021 15:44:37 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.123])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id BC18420066
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jul 2021 20:25:10 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 905684C0069
        for <linux-wireless@vger.kernel.org>; Thu, 22 Jul 2021 20:25:10 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 3CD0413C2B5;
        Thu, 22 Jul 2021 13:25:10 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 3CD0413C2B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1626985510;
        bh=tKCATEbClBwtjCzXp6ytqzGphdlBfwy1DZGDqDCqmPA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=h3Xsy8uXD/060WhAwC6didWqBNnDgPxKUostR5U8i4S46qzpzrZQk+JxvpXeVUmuI
         jKA73fH7/sZV0dKnVg6NCjfigrpT9BZ+oQMSOgj/7yztt2VIidOeYh7BXfhTmBF9mg
         miXUyCV+Q8Z7BqxmTAdIbLto93UjfHUhGkcAFHO0=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v3 4/8] mt76 - mt7915: Add tx mu/su counters to mib
Date:   Thu, 22 Jul 2021 13:25:00 -0700
Message-Id: <20210722202504.6180-4-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210722202504.6180-1-greearb@candelatech.com>
References: <20210722202504.6180-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1626985511-bztV0viMAiwS
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

These counters are clear-on-read, so we need to accumulate
them in the update_stats poll logic, and read the accumulated
values instead of directly doing register reads when reporting
to debugfs and ethtool stats.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 33 ++++++++-----------
 .../net/wireless/mediatek/mt76/mt7915/mac.c   | 13 +++++++-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  4 +++
 3 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index ad400ddf36c3..759899c44583 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -152,6 +152,7 @@ mt7915_txbf_stat_read_phy(struct mt7915_phy *phy, struct seq_file *s)
 		"BW20", "BW40", "BW80", "BW160"
 	};
 	int cnt;
+	struct mib_stats *mib = &phy->mib;
 
 	if (!phy)
 		return;
@@ -187,15 +188,13 @@ mt7915_txbf_stat_read_phy(struct mt7915_phy *phy, struct seq_file *s)
 		   FIELD_GET(MT_ETBF_TX_FB_TRI, cnt));
 
 	/* Tx SU & MU counters */
-	cnt = mt76_rr(dev, MT_MIB_SDR34(ext_phy));
-	seq_printf(s, "Tx multi-user Beamforming counts: %ld\n",
-		   FIELD_GET(MT_MIB_MU_BF_TX_CNT, cnt));
-	cnt = mt76_rr(dev, MT_MIB_DR8(ext_phy));
-	seq_printf(s, "Tx multi-user MPDU counts: %d\n", cnt);
-	cnt = mt76_rr(dev, MT_MIB_DR9(ext_phy));
-	seq_printf(s, "Tx multi-user successful MPDU counts: %d\n", cnt);
-	cnt = mt76_rr(dev, MT_MIB_DR11(ext_phy));
-	seq_printf(s, "Tx single-user successful MPDU counts: %d\n", cnt);
+	seq_printf(s, "Tx multi-user Beamforming counts: %d\n",
+		   mib->tx_bf_cnt);
+	seq_printf(s, "Tx multi-user MPDU counts: %d\n", mib->tx_mu_mpdu_cnt);
+	seq_printf(s, "Tx multi-user successful MPDU counts: %d\n",
+		   mib->tx_mu_successful_mpdu_cnt);
+	seq_printf(s, "Tx single-user successful MPDU counts: %d\n",
+		   mib->tx_su_successful_mpdu_cnt);
 
 	seq_puts(s, "\n");
 }
@@ -488,6 +487,7 @@ void mt7915_debug_get_et_stats(struct ieee80211_hw *hw,
 	struct mt7915_sta *msta;
 	struct mt7915_sta_stats *mstats;
 	bool found_sta = false;
+	struct mib_stats *mib = &phy->mib;
 
 	/* See mt7915_ampdu_stat_read_phy, etc */
 	bool ext_phy = phy != &dev->phy;
@@ -527,17 +527,10 @@ void mt7915_debug_get_et_stats(struct ieee80211_hw *hw,
 	data[ei++] = FIELD_GET(MT_ETBF_TX_FB_TRI, cnt);
 
 	/* Tx SU & MU counters */
-	cnt = mt76_rr(dev, MT_MIB_SDR34(ext_phy));
-	data[ei++] = FIELD_GET(MT_MIB_MU_BF_TX_CNT, cnt);
-
-	cnt = mt76_rr(dev, MT_MIB_DR8(ext_phy));
-	data[ei++] = cnt;
-
-	cnt = mt76_rr(dev, MT_MIB_DR9(ext_phy));
-	data[ei++] = cnt; /* MU MPDU SUccessful */
-
-	cnt = mt76_rr(dev, MT_MIB_DR11(ext_phy));
-	data[ei++] = cnt; /* SU MPDU successful */
+	data[ei++] = mib->tx_bf_cnt;
+	data[ei++] = mib->tx_mu_mpdu_cnt;
+	data[ei++] = mib->tx_mu_successful_mpdu_cnt;
+	data[ei++] = mib->tx_su_successful_mpdu_cnt;
 
 	/* TODO:  External phy too?? */
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 3a10e14fbd50..23540ba5da97 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1880,10 +1880,21 @@ mt7915_mac_update_stats(struct mt7915_phy *phy)
 	struct mt7915_dev *dev = phy->dev;
 	struct mib_stats *mib = &phy->mib;
 	bool ext_phy = phy != &dev->phy;
-	int i, aggr0, aggr1;
+	int i, aggr0, aggr1, cnt;
 
 	mib->fcs_err_cnt += mt76_get_field(dev, MT_MIB_SDR3(ext_phy),
 					   MT_MIB_SDR3_FCS_ERR_MASK);
+	cnt = mt76_rr(dev, MT_MIB_SDR34(ext_phy));
+	mib->tx_bf_cnt += FIELD_GET(MT_MIB_MU_BF_TX_CNT, cnt);
+
+	cnt = mt76_rr(dev, MT_MIB_DR8(ext_phy));
+	mib->tx_mu_mpdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_DR9(ext_phy));
+	mib->tx_mu_successful_mpdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_DR11(ext_phy));
+	mib->tx_su_successful_mpdu_cnt += cnt;
 
 	aggr0 = ext_phy ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
 	for (i = 0, aggr1 = aggr0 + 4; i < 4; i++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index ff944d1cf527..c5d0f2331b6f 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -116,6 +116,10 @@ struct mib_stats {
 	u32 rts_cnt;
 	u32 rts_retries_cnt;
 	u32 ba_miss_cnt;
+	u32 tx_bf_cnt;
+	u32 tx_mu_mpdu_cnt;
+	u32 tx_mu_successful_mpdu_cnt;
+	u32 tx_su_successful_mpdu_cnt;
 	/* Add more stats here, updated from mac_update_stats */
 };
 
-- 
2.20.1

