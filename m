Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9731F3D3CB8
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Jul 2021 17:46:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbhGWPGH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 23 Jul 2021 11:06:07 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:42008 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235582AbhGWPGF (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 23 Jul 2021 11:06:05 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.64.218])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 82E061A006A
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 15:46:37 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5842B840083
        for <linux-wireless@vger.kernel.org>; Fri, 23 Jul 2021 15:46:37 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id F339E13C2B5;
        Fri, 23 Jul 2021 08:46:36 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com F339E13C2B5
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1627055197;
        bh=LjwVnKV+7qlYZAHY2DQFT8Cr98t+OCD1suqBgIkCYiw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=XDlh2jCQc0dgzwutI00/Xf645lxsEPBKlasugb24CCKWKnOzP9j9zKhWSdEShyQcR
         axYY2P22zmUpOZRk/sA/wW9TvOw74aGPG8tMpxtessmlCfqna5N0oPK2wGVeU1Y8iQ
         5fgHRkq3jcShEQagcUl+GJ5puOafRiSQkeqGwJZE=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v4 4/8] mt76 - mt7915: Add tx mu/su counters to mib
Date:   Fri, 23 Jul 2021 08:46:23 -0700
Message-Id: <20210723154627.10078-4-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210723154627.10078-1-greearb@candelatech.com>
References: <20210723154627.10078-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1627055198-Ik2KlgskBg2L
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
 .../net/wireless/mediatek/mt76/mt7915/debugfs.c | 17 ++++++++---------
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 13 ++++++++++++-
 .../net/wireless/mediatek/mt76/mt7915/main.c    | 16 +++++-----------
 .../net/wireless/mediatek/mt76/mt7915/mt7915.h  |  4 ++++
 4 files changed, 29 insertions(+), 21 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 1a48b09d0cb7..35248d182728 100644
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
+		   mib->tx_mu_acked_mpdu_cnt);
+	seq_printf(s, "Tx single-user successful MPDU counts: %d\n",
+		   mib->tx_su_acked_mpdu_cnt);
 
 	seq_puts(s, "\n");
 }
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 6f445999e516..064d754e0565 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1890,10 +1890,21 @@ mt7915_mac_update_stats(struct mt7915_phy *phy)
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
+	mib->tx_mu_acked_mpdu_cnt += cnt;
+
+	cnt = mt76_rr(dev, MT_MIB_DR11(ext_phy));
+	mib->tx_su_acked_mpdu_cnt += cnt;
 
 	aggr0 = ext_phy ? ARRAY_SIZE(dev->mt76.aggr_stats) / 2 : 0;
 	for (i = 0, aggr1 = aggr0 + 4; i < 4; i++) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index de083008663e..be6444650afe 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1131,6 +1131,7 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	struct mt7915_sta *msta;
 	struct mt7915_sta_stats *mstats;
 	bool found_sta = false;
+	struct mib_stats *mib = &phy->mib;
 
 	/* See mt7915_ampdu_stat_read_phy, etc */
 	bool ext_phy = phy != &dev->phy;
@@ -1170,17 +1171,10 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
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
+	data[ei++] = mib->tx_mu_acked_mpdu_cnt;
+	data[ei++] = mib->tx_su_acked_mpdu_cnt;
 
 	/* TODO:  External phy too?? */
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index a8617ba69a21..26f2befc46dd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -116,6 +116,10 @@ struct mib_stats {
 	u32 rts_cnt;
 	u32 rts_retries_cnt;
 	u32 ba_miss_cnt;
+	u32 tx_bf_cnt;
+	u32 tx_mu_mpdu_cnt;
+	u32 tx_mu_acked_mpdu_cnt;
+	u32 tx_su_acked_mpdu_cnt;
 	/* Add more stats here, updated from mac_update_stats */
 };
 
-- 
2.20.1

