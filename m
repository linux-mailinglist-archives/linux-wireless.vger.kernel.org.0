Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6279F3E9A7F
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Aug 2021 23:45:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232298AbhHKVph (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Aug 2021 17:45:37 -0400
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.164]:58414 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232198AbhHKVpR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Aug 2021 17:45:17 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.174])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id E18E11A006C
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:50 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A6B387C0071
        for <linux-wireless@vger.kernel.org>; Wed, 11 Aug 2021 21:44:50 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 304D013C2B7;
        Wed, 11 Aug 2021 14:44:50 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 304D013C2B7
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1628718290;
        bh=hQoAJt8ukwmro8h0mK6xwESY2xETZQMtloctEDxd3oQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=qumFKy49wP10xg9NoLaKOfzfDN44Cj/whddmUA+zEwuf4h4fkfKhLd7N6QpBOF3F+
         q/4LGsaf9iugqciGtGMBn3hfxaoHHJhk+pDeAgJxHawI+N+kJNjSb8ozH31B3r+a3E
         zmwGv0W4BJLNOtukfe2ZG3JpPK2Sxh0/c2IUaOqk=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 04/15] mt76: mt7915:  support enabling rx group-5 status
Date:   Wed, 11 Aug 2021 14:44:28 -0700
Message-Id: <20210811214439.17458-5-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20210811214439.17458-1-greearb@candelatech.com>
References: <20210811214439.17458-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1628718291-cqzrf_WaolHF
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Ben Greear <greearb@candelatech.com>

When enabled, this allows per-skb rx rate reporting.
Enabling this may degrade RX performance, so it remains
disabled by default.

Signed-off-by: Ben Greear <greearb@candelatech.com>
---
 .../wireless/mediatek/mt76/mt7915/debugfs.c   | 33 +++++++++++++++++++
 .../net/wireless/mediatek/mt76/mt7915/init.c  |  3 +-
 .../net/wireless/mediatek/mt76/mt7915/mac.c   |  3 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |  3 +-
 .../wireless/mediatek/mt76/mt7915/mt7915.h    |  5 +++
 5 files changed, 44 insertions(+), 3 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
index b48fda497ab6..885c60ea2a71 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -354,6 +354,38 @@ mt7915_txs_for_no_skb_get(void *data, u64 *val)
 DEFINE_DEBUGFS_ATTRIBUTE(fops_txs_for_no_skb, mt7915_txs_for_no_skb_get,
 			 mt7915_txs_for_no_skb_set, "%lld\n");
 
+static int
+mt7915_rx_group_5_enable_set(void *data, u64 val)
+{
+	struct mt7915_dev *dev = data;
+
+	mutex_lock(&dev->mt76.mutex);
+
+	dev->rx_group_5_enable = !!val;
+
+	/* Enabled if we requested enabled OR if monitor mode is enabled. */
+	mt76_rmw_field(dev, MT_DMA_DCR0(0), MT_DMA_DCR0_RXD_G5_EN,
+		       dev->phy.is_monitor_mode || dev->rx_group_5_enable);
+	mt76_testmode_reset(dev->phy.mt76, true);
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	return 0;
+}
+
+static int
+mt7915_rx_group_5_enable_get(void *data, u64 *val)
+{
+	struct mt7915_dev *dev = data;
+
+	*val = dev->rx_group_5_enable;
+
+	return 0;
+}
+
+DEFINE_DEBUGFS_ATTRIBUTE(fops_rx_group_5_enable, mt7915_rx_group_5_enable_get,
+			 mt7915_rx_group_5_enable_set, "%lld\n");
+
 static void
 mt7915_ampdu_stat_read_phy(struct mt7915_phy *phy,
 			   struct seq_file *file)
@@ -592,6 +624,7 @@ int mt7915_init_debugfs(struct mt7915_dev *dev)
 	debugfs_create_file("tx_stats", 0400, dir, dev, &mt7915_tx_stats_fops);
 	debugfs_create_file("fw_debug", 0600, dir, dev, &fops_fw_debug);
 	debugfs_create_file("txs_for_no_skb", 0600, dir, dev, &fops_txs_for_no_skb);
+	debugfs_create_file("rx_group_5_enable", 0600, dir, dev, &fops_rx_group_5_enable);
 	debugfs_create_file("implicit_txbf", 0600, dir, dev,
 			    &fops_implicit_txbf);
 	debugfs_create_u32("dfs_hw_pattern", 0400, dir, &dev->hw_pattern);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 6a00c072ee56..e741c4f73d19 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -302,7 +302,8 @@ mt7915_mac_init_band(struct mt7915_dev *dev, u8 band)
 
 	mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_MAX_RX_LEN, 1536);
 	/* disable rx rate report by default due to hw issues */
-	mt76_clear(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN);
+	mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN,
+		       dev->phy.is_monitor_mode || dev->rx_group_5_enable);
 }
 
 static void mt7915_mac_init(struct mt7915_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index d836c665ddaf..7d5156a9e48d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -715,7 +715,8 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb)
 		status->flag |= RX_FLAG_8023;
 	}
 
-	if (rxv && status->flag & RX_FLAG_RADIOTAP_HE) {
+	if (phy->is_monitor_mode &&
+	    rxv && status->flag & RX_FLAG_RADIOTAP_HE) {
 		mt7915_mac_decode_he_radiotap(skb, status, rxv, mode);
 		if (status->flag & RX_FLAG_RADIOTAP_HE_MU)
 			mt7915_mac_decode_he_mu_radiotap(skb, status, rxv);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 37c484d32d0b..b3f3b53da843 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -450,13 +450,14 @@ static int mt7915_config(struct ieee80211_hw *hw, u32 changed)
 	if (changed & IEEE80211_CONF_CHANGE_MONITOR) {
 		bool enabled = !!(hw->conf.flags & IEEE80211_CONF_MONITOR);
 
+		phy->is_monitor_mode = enabled;
 		if (!enabled)
 			phy->rxfilter |= MT_WF_RFCR_DROP_OTHER_UC;
 		else
 			phy->rxfilter &= ~MT_WF_RFCR_DROP_OTHER_UC;
 
 		mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN,
-			       enabled);
+			       phy->is_monitor_mode || dev->rx_group_5_enable);
 		mt76_testmode_reset(phy->mt76, true);
 		mt76_wr(dev, MT_WF_RFCR(band), phy->rxfilter);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
index d5e331064682..8086233d6e2b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -184,6 +184,7 @@ struct mt7915_phy {
 
 	struct thermal_cooling_device *cdev;
 	u8 throttle_state;
+	u8 is_monitor_mode; /* are we in monitor mode or not ? */
 
 	u32 rxfilter;
 	u64 omac_mask;
@@ -236,6 +237,10 @@ struct mt7915_dev {
 	 * creation by firmware, so may be a performance drag.
 	 */
 	bool txs_for_no_skb_enabled;
+	/* Should we enable group-5 rx descriptor logic?  This may decrease RX
+	 * throughput, but will give per skb rx rate information..
+	 */
+	bool rx_group_5_enable;
 
 	struct work_struct init_work;
 	struct work_struct rc_work;
-- 
2.20.1

