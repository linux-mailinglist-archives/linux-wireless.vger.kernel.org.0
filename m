Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 487D74560C1
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Nov 2021 17:41:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233605AbhKRQo3 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 Nov 2021 11:44:29 -0500
Received: from dispatch1-us1.ppe-hosted.com ([67.231.154.183]:39626 "EHLO
        dispatch1-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233592AbhKRQo2 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 Nov 2021 11:44:28 -0500
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.28])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 94BAB20061
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 16:41:26 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 5B09638008A
        for <linux-wireless@vger.kernel.org>; Thu, 18 Nov 2021 16:41:26 +0000 (UTC)
Received: from ben-dt4.candelatech.com (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        by mail3.candelatech.com (Postfix) with ESMTP id 0C3AB13C2B3;
        Thu, 18 Nov 2021 08:41:06 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 0C3AB13C2B3
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1637253666;
        bh=Bk85ZRwhN1Wk7WZRZhaTAmqpkI7QYxhQXJfm7P3py1c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gVx5rMPneiSJbwyvW6cMjrMDhkDv81/GCSvmPzSvh0yrnjw7SVQyjrDEaI6V0qZUt
         58WPDO4mJkKlt89WlYQVvNaWdBMJUX0XuZumdlq5KekFk74eGkXKV1kgMbg8shm1ot
         dSzwPvkEZO299WKeIuRZE/6icqs/kirriwo/wtxs=
From:   greearb@candelatech.com
To:     linux-wireless@vger.kernel.org
Cc:     Ben Greear <greearb@candelatech.com>
Subject: [PATCH 03/11] mt76: mt7915: support enabling rx group-5 status
Date:   Thu, 18 Nov 2021 08:40:48 -0800
Message-Id: <20211118164056.2965-3-greearb@candelatech.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20211118164056.2965-1-greearb@candelatech.com>
References: <20211118164056.2965-1-greearb@candelatech.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-MDID: 1637253687-ka1US6O_1Wt2
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
index e3f6cd18e30a..32e219a20721 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c
@@ -435,6 +435,38 @@ mt7915_txs_for_no_skb_get(void *data, u64 *val)
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
@@ -786,6 +818,7 @@ int mt7915_init_debugfs(struct mt7915_phy *phy)
 	debugfs_create_file("fw_util_wa", 0400, dir, dev,
 			    &mt7915_fw_util_wa_fops);
 	debugfs_create_file("force_txs", 0600, dir, dev, &fops_txs_for_no_skb);
+	debugfs_create_file("rx_group_5_enable", 0600, dir, dev, &fops_rx_group_5_enable);
 	debugfs_create_file("implicit_txbf", 0600, dir, dev,
 			    &fops_implicit_txbf);
 	debugfs_create_file("txpower_sku", 0400, dir, phy,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/init.c b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
index 90aa62c64f3e..58a0ce72b714 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/init.c
@@ -391,7 +391,8 @@ mt7915_mac_init_band(struct mt7915_dev *dev, u8 band)
 
 	mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_MAX_RX_LEN, 0x680);
 	/* disable rx rate report by default due to hw issues */
-	mt76_clear(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN);
+	mt76_rmw_field(dev, MT_DMA_DCR0(band), MT_DMA_DCR0_RXD_G5_EN,
+		       dev->phy.is_monitor_mode || dev->rx_group_5_enable);
 }
 
 static void mt7915_mac_init(struct mt7915_dev *dev)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index 6fbd58ae9c88..a6bcc76dcb03 100644
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
index 3d702dc899ba..e973b2527b34 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -458,13 +458,14 @@ static int mt7915_config(struct ieee80211_hw *hw, u32 changed)
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
index 86cd0fc8e9de..84fff60ada92 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mt7915.h
@@ -209,6 +209,7 @@ struct mt7915_phy {
 	struct thermal_cooling_device *cdev;
 	u8 throttle_state;
 	u32 throttle_temp[2]; /* 0: critical high, 1: maximum */
+	u8 is_monitor_mode; /* are we in monitor mode or not ? */
 
 	u32 rxfilter;
 	u64 omac_mask;
@@ -261,6 +262,10 @@ struct mt7915_dev {
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

