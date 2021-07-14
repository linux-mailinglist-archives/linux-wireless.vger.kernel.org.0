Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4EB03C9346
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jul 2021 23:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235344AbhGNVrh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 14 Jul 2021 17:47:37 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.52]:54606 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235751AbhGNVrf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 14 Jul 2021 17:47:35 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.132])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 9EA4E1C0063
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jul 2021 21:44:41 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 74AA350006F
        for <linux-wireless@vger.kernel.org>; Wed, 14 Jul 2021 21:44:41 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 1ECC413C2B4;
        Wed, 14 Jul 2021 14:44:41 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1ECC413C2B4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1626299081;
        bh=F30BImeR7ukAL+oTq6u9X/tYKI7TYptYVx6Izz71yMo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FY4jOAmo3CnPMcNSxFz1FUcaQzsWQVLS4z3v3xZyHT3mr4T5V0oYLUKMNAFA7cLhE
         h0wI6OzN/nYaPLBmVi2bArquEvj1h6MeNnL45qsbvF4h+s4imeco7B8CyFmVfKzqqg
         aYINQ8q+e80+opdyDebbIEr6TXlyoGr4YjvdegSY=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v2 4/8] mt76 - mt7915: Add tx mu/su counters to mib
Date:   Wed, 14 Jul 2021 14:44:28 -0700
Message-Id: <20210714214432.15162-4-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210714214432.15162-1-greearb@candelatech.com>
References: <20210714214432.15162-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1626299082-0eMNTSyycaVk
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
index 61a57c86cbdb..9dce4a0e7a5c 100644
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
index 585f67daec8e..53e8347ef75b 100644
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

