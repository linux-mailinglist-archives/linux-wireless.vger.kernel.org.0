Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4DA863E9A83
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 23:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232280AbhHKVps (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 17:45:48 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.48]:52200 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232209AbhHKVpS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 17:45:18 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.133])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 3BBFB1C0078
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:51 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 05327B00077
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:50 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 8E20013C2BB;
        Wed, 11 Aug 2021 14:44:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 8E20013C2BB
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628718290;
        bh=FYpMgNZRlt2UK3/srkfuBUP1LDdB2QWKkLq/QbOdSXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VyBG0NL5VVkCCG/FKXWee/hTWHxpmCOkeb8rf6dgq3x7maxw0ALamsf/Vp/qrlM51
         I5NOYCZtUkKgLxlKlVlz3dylsTKPMKpBQOziHjiYafyCDmoJlAftRMhymEE/o//Cla
         wbT8WZ/1ZRuWlPsamH6XDD9xZ4Pud5V2ImaTN3ZA=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 06/15] mt76: mt7915:  rename amsdu_pack_stats to tx_amsdu_pack_stats
Date:   Wed, 11 Aug 2021 14:44:30 -0700
Message-Id: <20210811214439.17458-7-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210811214439.17458-1-greearb@candelatech.com>
References: <20210811214439.17458-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1628718291-PJT7RLvtLNbP
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

Make it more clear that this is a tx-stat, and move it to
the tx section of the mib stats struct.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c | 8 ++++----
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c     | 4 ++--
 drivers/net/wireless/mediatek/mt76/mt7915/main.c    | 2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h  | 3 +--
 4 files changed, 8 insertions(+), 9 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 885c60ea2a71..688641ea4bb5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -488,11 +488,11 @@ mt7915_tx_stats_show(struct seq_file *file, void *data)
 
 	/* Tx amsdu info */
 	seq_puts(file, "Tx MSDU statistics:\n");
-	for (i = 0, n = 0; i < ARRAY_SIZE(mib->amsdu_pack_stats); i++)
-		n += mib->amsdu_pack_stats[i];
+	for (i = 0, n = 0; i < ARRAY_SIZE(mib->tx_amsdu_pack_stats); i++)
+		n += mib->tx_amsdu_pack_stats[i];
 
-	for (i = 0; i < ARRAY_SIZE(mib->amsdu_pack_stats); i++) {
-		long si = mib->amsdu_pack_stats[i];
+	for (i = 0; i < ARRAY_SIZE(mib->tx_amsdu_pack_stats); i++) {
+		long si = mib->tx_amsdu_pack_stats[i];
 
 		seq_printf(file, "AMSDU pack count of %d MSDU in TXD: %ld ",
 			   i + 1, si);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index b44ca71e7d06..f1cff26cbc36 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -2204,8 +2204,8 @@ mt7915_mac_update_stats(struct mt7915_phy *phy)
 	}
 
 	/* Tx amsdu info (pack-count histogram) */
-	for (i = 0; i < ARRAY_SIZE(mib->amsdu_pack_stats); i++)
-		mib->amsdu_pack_stats[i] += mt76_rr(dev,  MT_PLE_AMSDU_PACK_MSDU_CNT(i));
+	for (i = 0; i < ARRAY_SIZE(mib->tx_amsdu_pack_stats); i++)
+		mib->tx_amsdu_pack_stats[i] += mt76_rr(dev,  MT_PLE_AMSDU_PACK_MSDU_CNT(i));
 
 }
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index b3f3b53da843..427b275f123a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1255,7 +1255,7 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 
 	/* Tx amsdu info (pack-count histogram) */
 	for (i = 0; i < 8; i++)
-		data[ei++] = mib->amsdu_pack_stats[i];
+		data[ei++] = mib->tx_amsdu_pack_stats[i];
 
 	/* rx counters */
 	data[ei++] = mib->rx_fifo_full_cnt;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index 8086233d6e2b..b446a5c73aa5 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -147,6 +147,7 @@ struct mib_stats {
 
 	u32 tx_rwp_fail_cnt;
 	u32 tx_rwp_need_cnt;
+	u32 tx_amsdu_pack_stats[8]; /* histogram of how many sub-frames in amsdu */
 
 	/* rx stats */
 	u32 rx_fifo_full_cnt;
@@ -162,8 +163,6 @@ struct mib_stats {
 	u32 rx_pfdrop_cnt;
 	u32 rx_vec_queue_overflow_drop_cnt;
 	u32 rx_ba_cnt;
-
-	u32 amsdu_pack_stats[8]; /* histogram of how many sub-frames in amsdu */
 };
 
 struct mt7915_hif {
-- 
2.20.1

