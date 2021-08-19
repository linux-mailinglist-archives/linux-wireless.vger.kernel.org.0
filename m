Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D73633F21DC
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Aug 2021 22:50:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235519AbhHSUul (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 19 Aug 2021 16:50:41 -0400
Received: from dispatch1-us1.ppe-hosted.com ([148.163.129.49]:52760 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235563AbhHSUuk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 19 Aug 2021 16:50:40 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.64.218])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 3056B2007B
        for <linux-wireless@vger.kernel.org>; Thu, 19 Aug 2021 20:50:01 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 03C3D840081
        for <linux-wireless@vger.kernel.org>; Thu, 19 Aug 2021 20:50:00 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 0964713C2B7;
        Thu, 19 Aug 2021 13:49:56 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0964713C2B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1629406196;
        bh=YrgFfZcW1ojgO28V6RfxOrnq4jxixsnrt8Xi/DcixjQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=JBvt9S5+bz2WhhDm6puD05aYqO5j0pIKT1cazK40T3Jwah8sX+5eziMj8Mw6hKuAd
         oMTtW503LNdiXL+ogpA5x/wPjJDcMIscz3LGsyMsUw34nrqcV/7BDuxuQhpDOWKLcn
         uoo/QUqVB112VilD6gGicZ0QZdKvLFonPMjcF3Mc=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH v8 5/9] mt76: mt7915:  debugfs hook to enable TXS for NO_SKB pkt-ids
Date:   Thu, 19 Aug 2021 13:49:46 -0700
Message-Id: <20210819204950.12150-5-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210819204950.12150-1-greearb@candelatech.com>
References: <20210819204950.12150-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1629406201-3bhV85xKob7H
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

This lets user turn on/off this feature.  Enabling gives better
tx-rate related stats, but will cause extra driver and (maybe)
firmware work.  Not sure if it actually affects performance or
not.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 24 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  3 ++-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  5 ++++
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index 91664ac63a8d..b2df42802868 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -109,6 +109,29 @@ mt7915_fw_debug_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_fw_debug, mt7915_fw_debug_get,
 			 mt7915_fw_debug_set, "%lld\n");
 
+static int
+mt7915_txs_for_no_skb_set(void *data, u64 val)
+{
+	struct mt7915_dev *dev = data;
+
+	dev->txs_for_no_skb_enabled = !!val;
+
+	return 0;
+}
+
+static int
+mt7915_txs_for_no_skb_get(void *data, u64 *val)
+{
+	struct mt7915_dev *dev = data;
+
+	*val = dev->txs_for_no_skb_enabled;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_txs_for_no_skb, mt7915_txs_for_no_skb_get,
+			 mt7915_txs_for_no_skb_set, "%lld\n");
+
 static void
 mt7915_ampdu_stat_read_phy(struct mt7915_phy *phy,
 			   struct seq_file *file)
@@ -344,6 +367,7 @@ int mt7915_init_debugfs(struct mt7915_dev *dev)
 				    mt7915_queues_acq);
 	debugfs_create_file("tx_stats", 0400, dir, dev, &mt7915_tx_stats_fops);
 	debugfs_create_file("fw_debug", 0600, dir, dev, &fops_fw_debug);
+	debugfs_create_file("force_txs", 0600, dir, dev, &fops_txs_for_no_skb);
 	debugfs_create_file("implicit_txbf", 0600, dir, dev,
 			    &fops_implicit_txbf);
 	debugfs_create_u32("dfs_hw_pattern", 0400, dir, &dev->hw_pattern);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index f6ed5d5febb7..39d2175862bd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -1047,7 +1047,8 @@ void mt7915_mac_write_txwi(struct mt7915_dev *dev, __le32 *txwi,
 	txwi[4] = 0;
 
 	val = FIELD_PREP(MT_TXD5_PID, pid);
-	if (pid >= MT_PACKET_ID_FIRST)
+	if (pid >= MT_PACKET_ID_FIRST ||
+	    (pid == MT_PACKET_ID_NO_SKB && dev->txs_for_no_skb_enabled))
 		val |= MT_TXD5_TX_STATUS_HOST;
 	txwi[5] = cpu_to_le32(val);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index ea6da6b4e92d..1c0a1bf91c1c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -223,6 +223,11 @@ struct mt7915_dev {
 
 	u16 chainmask;
 	u32 hif_idx;
+	/* Should we request TXS for MT_PACKET_ID_NO_SKB?  Doing so gives better
+	 * costs but causes a great deal more TXS packet processing by driver and
+	 * creation by firmware, so may be a performance drag.
+	 */
+	bool txs_for_no_skb_enabled;
 
 	struct work_struct init_work;
 	struct work_struct rc_work;
-- 
2.20.1

