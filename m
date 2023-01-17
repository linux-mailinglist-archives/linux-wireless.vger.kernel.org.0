Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9A466DF87
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jan 2023 14:54:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229502AbjAQNyC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 17 Jan 2023 08:54:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229888AbjAQNxt (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 17 Jan 2023 08:53:49 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD144125B1
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 05:53:48 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 64C4061457
        for <linux-wireless@vger.kernel.org>; Tue, 17 Jan 2023 13:53:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 77105C433EF;
        Tue, 17 Jan 2023 13:53:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673963627;
        bh=OwhjfaJDJFfPveP54ZhJTXttaD1CkKhPjvzkL9JwFbg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=H6TnpnYcQmtZzboJ0OSMYG+YR4R4Oy6L8JylfaIay7GIFLh8jyxngF3Icv3eubQAW
         PE1EVocO/zdmDY1Md7BSnh+dns7Z7eVVYbFjJIjmKvrWLnKK2mJxfxiVjp1K+akmHN
         XgkcI2x3siD9RjKZFXvdLOt4VEpJdiHBVhA9ErFtPLYcAymsWsMqP45aT7rpbDDYSI
         po0niM5n088sad1dIphEf5DCTPAcOCaFVmKsiJLKAmUuxfZh30bpa7CWSHhOXTSQAS
         7SJXWk9OY837fShXUqLKRj0swWb9jjypOqT+DgROmJgMzSoplTXJ1em80PwyPjNPNB
         P20yLxJ+5Fhtw==
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     nbd@nbd.name
Cc:     linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com
Subject: [PATCH v2 4/4] wifi: mt76: enable page_pool stats
Date:   Tue, 17 Jan 2023 14:53:17 +0100
Message-Id: <67e548ad9f420f396e308dd9b9657b7ebc20ff69.1673963374.git.lorenzo@kernel.org>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <cover.1673963374.git.lorenzo@kernel.org>
References: <cover.1673963374.git.lorenzo@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Enable page_pool ethtool statistics for mt7915 and mt7921 chipsets.

Tested-by: Felix Fietkau <nbd@nbd.name>
Tested-by: Deren Wu <deren.wu@mediatek.com>
Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
---
 drivers/net/wireless/mediatek/mt76/Kconfig    |  1 +
 drivers/net/wireless/mediatek/mt76/mac80211.c | 13 ++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h     |  1 +
 .../net/wireless/mediatek/mt76/mt7915/main.c  | 26 ++++++++++------
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 31 ++++++++++++++++---
 5 files changed, 58 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/Kconfig b/drivers/net/wireless/mediatek/mt76/Kconfig
index 18152c16c36f..90e958e608aa 100644
--- a/drivers/net/wireless/mediatek/mt76/Kconfig
+++ b/drivers/net/wireless/mediatek/mt76/Kconfig
@@ -2,6 +2,7 @@
 config MT76_CORE
 	tristate
 	select PAGE_POOL
+	select PAGE_POOL_STATS
 
 config MT76_LEDS
 	bool
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 3d6b6f12ffde..21fa1077c5b5 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1729,6 +1729,19 @@ void mt76_ethtool_worker(struct mt76_ethtool_worker_info *wi,
 }
 EXPORT_SYMBOL_GPL(mt76_ethtool_worker);
 
+void mt76_ethtool_page_pool_stats(struct mt76_dev *dev, u64 *data, int *index)
+{
+	struct page_pool_stats stats = {};
+	int i;
+
+	mt76_for_each_q_rx(dev, i)
+		page_pool_get_stats(dev->q_rx[i].page_pool, &stats);
+
+	page_pool_ethtool_stats_get(data, &stats);
+	*index += page_pool_ethtool_stats_get_count();
+}
+EXPORT_SYMBOL_GPL(mt76_ethtool_page_pool_stats);
+
 enum mt76_dfs_state mt76_phy_dfs_state(struct mt76_phy *phy)
 {
 	struct ieee80211_hw *hw = phy->hw;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index b195bb98f7ca..9037780f9e88 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1311,6 +1311,7 @@ mt76u_bulk_msg(struct mt76_dev *dev, void *data, int len, int *actual_len,
 	return usb_bulk_msg(udev, pipe, data, len, actual_len, timeout);
 }
 
+void mt76_ethtool_page_pool_stats(struct mt76_dev *dev, u64 *data, int *index);
 void mt76_ethtool_worker(struct mt76_ethtool_worker_info *wi,
 			 struct mt76_sta_stats *stats);
 int mt76_skb_adjust_pad(struct sk_buff *skb, int pad);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index 0511d6a505b0..9ae10e780d74 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -1280,19 +1280,22 @@ void mt7915_get_et_strings(struct ieee80211_hw *hw,
 			   struct ieee80211_vif *vif,
 			   u32 sset, u8 *data)
 {
-	if (sset == ETH_SS_STATS)
-		memcpy(data, *mt7915_gstrings_stats,
-		       sizeof(mt7915_gstrings_stats));
+	if (sset != ETH_SS_STATS)
+		return;
+
+	memcpy(data, *mt7915_gstrings_stats, sizeof(mt7915_gstrings_stats));
+	data += sizeof(mt7915_gstrings_stats);
+	page_pool_ethtool_stats_get_strings(data);
 }
 
 static
 int mt7915_get_et_sset_count(struct ieee80211_hw *hw,
 			     struct ieee80211_vif *vif, int sset)
 {
-	if (sset == ETH_SS_STATS)
-		return MT7915_SSTATS_LEN;
+	if (sset != ETH_SS_STATS)
+		return 0;
 
-	return 0;
+	return MT7915_SSTATS_LEN + page_pool_ethtool_stats_get_count();
 }
 
 static void mt7915_ethtool_worker(void *wi_data, struct ieee80211_sta *sta)
@@ -1320,7 +1323,7 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 	};
 	struct mib_stats *mib = &phy->mib;
 	/* See mt7915_ampdu_stat_read_phy, etc */
-	int i, ei = 0;
+	int i, ei = 0, stats_size;
 
 	mutex_lock(&dev->mt76.mutex);
 
@@ -1401,9 +1404,12 @@ void mt7915_get_et_stats(struct ieee80211_hw *hw,
 		return;
 
 	ei += wi.worker_stat_count;
-	if (ei != MT7915_SSTATS_LEN)
-		dev_err(dev->mt76.dev, "ei: %d  MT7915_SSTATS_LEN: %d",
-			ei, (int)MT7915_SSTATS_LEN);
+
+	mt76_ethtool_page_pool_stats(&dev->mt76, &data[ei], &ei);
+
+	stats_size = MT7915_SSTATS_LEN + page_pool_ethtool_stats_get_count();
+	if (ei != stats_size)
+		dev_err(dev->mt76.dev, "ei: %d size: %d", ei, stats_size);
 }
 
 static void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 76ac5069638f..7d53ddd3bf15 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -1135,17 +1135,34 @@ static void
 mt7921_get_et_strings(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		      u32 sset, u8 *data)
 {
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
 	if (sset != ETH_SS_STATS)
 		return;
 
 	memcpy(data, *mt7921_gstrings_stats, sizeof(mt7921_gstrings_stats));
+
+	if (mt76_is_sdio(&dev->mt76))
+		return;
+
+	data += sizeof(mt7921_gstrings_stats);
+	page_pool_ethtool_stats_get_strings(data);
 }
 
 static int
 mt7921_get_et_sset_count(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			 int sset)
 {
-	return sset == ETH_SS_STATS ? ARRAY_SIZE(mt7921_gstrings_stats) : 0;
+	struct mt7921_dev *dev = mt7921_hw_dev(hw);
+
+	if (sset != ETH_SS_STATS)
+		return 0;
+
+	if (mt76_is_sdio(&dev->mt76))
+		return ARRAY_SIZE(mt7921_gstrings_stats);
+
+	return ARRAY_SIZE(mt7921_gstrings_stats) +
+	       page_pool_ethtool_stats_get_count();
 }
 
 static void
@@ -1165,6 +1182,7 @@ void mt7921_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			 struct ethtool_stats *stats, u64 *data)
 {
 	struct mt7921_vif *mvif = (struct mt7921_vif *)vif->drv_priv;
+	int stats_size = ARRAY_SIZE(mt7921_gstrings_stats);
 	struct mt7921_phy *phy = mt7921_hw_phy(hw);
 	struct mt7921_dev *dev = phy->dev;
 	struct mib_stats *mib = &phy->mib;
@@ -1220,9 +1238,14 @@ void mt7921_get_et_stats(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		return;
 
 	ei += wi.worker_stat_count;
-	if (ei != ARRAY_SIZE(mt7921_gstrings_stats))
-		dev_err(dev->mt76.dev, "ei: %d  SSTATS_LEN: %zu",
-			ei, ARRAY_SIZE(mt7921_gstrings_stats));
+
+	if (!mt76_is_sdio(&dev->mt76)) {
+		mt76_ethtool_page_pool_stats(&dev->mt76, &data[ei], &ei);
+		stats_size += page_pool_ethtool_stats_get_count();
+	}
+
+	if (ei != stats_size)
+		dev_err(dev->mt76.dev, "ei: %d  SSTATS_LEN: %d", ei, stats_size);
 }
 
 static u64
-- 
2.39.0

