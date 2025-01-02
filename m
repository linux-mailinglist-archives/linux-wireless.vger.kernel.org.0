Return-Path: <linux-wireless+bounces-17000-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAF679FFBD1
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:36:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EDD8118813DE
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:36:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE2217B4EC;
	Thu,  2 Jan 2025 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="aIIJ1iz2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85AD15B54C
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835723; cv=none; b=Jo9auXp83MRXtsW+SvAatJt13pEg++mT51IvvzxBuV+5n3etKwS96GJripyTwtj2sPgtU5mtEQk3SFitmwQmqboCC4aid9bA6yzmmmmCme7QInXIUn+xLTR9twYImpQJjV0ACopR42XP1JTXbt6DgvmjTVHMA8KtlJzxhJ4xwk8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835723; c=relaxed/simple;
	bh=TGXeBcZrZck6iUy0XLqep0GI1dxL/EIdbGfO1xYe2wU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=qE3iUh2WxOknm87p159TPmuAJFgX1deQXj7k5kmZ5MRp/Hmzh0+T2+tlENISUFySxoX1Re9QyRBbOKKdYSj0svyPjZpH70JjQGzq7pFtvOJKJZXq9yVxhdN6wtJJGdxl/EGRkJh+KtYgAKmq7cOdXG8zK6Hra+d9z2/ds9IOK/A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=aIIJ1iz2; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=H1p8vtPg65Ky+HUsKJsAsit2rPuuB9T6ZP7IQOcEdFA=; b=aIIJ1iz2jx9XK8KnW9orWkOjeh
	eAKPLTH1R4w5q8C9MfKDUDrhp5jAt95u23zf7eTcwGAmUb1gVKcZInByO5895oq0ouQuBCcqrj6/L
	cZFoKgiAhQPnccqsD6F7ib/W9DlCIfQd8FnlE6PhSjLxqgIYEoIkdVqzciApdlmsnZGA=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAC-0008GS-2G
	for linux-wireless@vger.kernel.org;
	Thu, 02 Jan 2025 17:35:12 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 08/24] wifi: mt76: remove dev->wcid_phy_mask
Date: Thu,  2 Jan 2025 17:34:52 +0100
Message-ID: <20250102163508.52945-8-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20250102163508.52945-1-nbd@nbd.name>
References: <20250102163508.52945-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Explicitly check wcid->phy_idx instead. Reduces allocated data size.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c    |  3 ---
 drivers/net/wireless/mediatek/mt76/mt76.h        |  3 +--
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x0/phy.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt76x2/phy.c  |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/main.c |  1 -
 drivers/net/wireless/mediatek/mt76/util.c        | 10 +++-------
 7 files changed, 7 insertions(+), 16 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 9549510057fa..9173438f963e 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1505,8 +1505,6 @@ mt76_sta_add(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	}
 
 	ewma_signal_init(&wcid->rssi);
-	if (phy->band_idx == MT_BAND1)
-		mt76_wcid_mask_set(dev->wcid_phy_mask, wcid->idx);
 	rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
 	phy->num_sta++;
 
@@ -1533,7 +1531,6 @@ void __mt76_sta_remove(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	mt76_wcid_cleanup(dev, wcid);
 
 	mt76_wcid_mask_clear(dev->wcid_mask, idx);
-	mt76_wcid_mask_clear(dev->wcid_phy_mask, idx);
 	phy->num_sta--;
 }
 EXPORT_SYMBOL_GPL(__mt76_sta_remove);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 307e6255f199..85b2f21acd70 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -909,7 +909,6 @@ struct mt76_dev {
 	spinlock_t status_lock;
 
 	u32 wcid_mask[DIV_ROUND_UP(MT76_N_WCIDS, 32)];
-	u32 wcid_phy_mask[DIV_ROUND_UP(MT76_N_WCIDS, 32)];
 
 	u64 vif_mask;
 
@@ -1474,7 +1473,7 @@ void __mt76_sta_remove(struct mt76_phy *phy, struct ieee80211_vif *vif,
 void mt76_sta_pre_rcu_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			     struct ieee80211_sta *sta);
 
-int mt76_get_min_avg_rssi(struct mt76_dev *dev, bool ext_phy);
+int mt76_get_min_avg_rssi(struct mt76_dev *dev, u8 phy_idx);
 
 int mt76_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		     unsigned int link_id, int *dbm);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index dafa4b05f623..a259f4dd9540 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1788,7 +1788,7 @@ mt7603_false_cca_check(struct mt7603_dev *dev)
 
 	mt7603_cca_stats_reset(dev);
 
-	min_signal = mt76_get_min_avg_rssi(&dev->mt76, false);
+	min_signal = mt76_get_min_avg_rssi(&dev->mt76, 0);
 	if (!min_signal) {
 		dev->sensitivity = 0;
 		dev->last_cca_adj = jiffies;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
index d543ef3de65b..ec554a059216 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x0/phy.c
@@ -1071,7 +1071,7 @@ mt76x0_phy_update_channel_gain(struct mt76x02_dev *dev)
 	u8 gain_delta;
 	int low_gain;
 
-	dev->cal.avg_rssi_all = mt76_get_min_avg_rssi(&dev->mt76, false);
+	dev->cal.avg_rssi_all = mt76_get_min_avg_rssi(&dev->mt76, 0);
 	if (!dev->cal.avg_rssi_all)
 		dev->cal.avg_rssi_all = -75;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c b/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
index f84517d932dc..e2b4cf30dc44 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x2/phy.c
@@ -280,7 +280,7 @@ void mt76x2_phy_update_channel_gain(struct mt76x02_dev *dev)
 	int low_gain;
 	u32 val;
 
-	dev->cal.avg_rssi_all = mt76_get_min_avg_rssi(&dev->mt76, false);
+	dev->cal.avg_rssi_all = mt76_get_min_avg_rssi(&dev->mt76, 0);
 	if (!dev->cal.avg_rssi_all)
 		dev->cal.avg_rssi_all = -75;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index d0a91b3cdc27..c58838ad0189 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1188,7 +1188,6 @@ mt7925_mac_sta_remove_links(struct mt792x_dev *dev, struct ieee80211_vif *vif,
 		if (link_sta != mlink->pri_link) {
 			mt76_wcid_cleanup(mdev, wcid);
 			mt76_wcid_mask_clear(mdev->wcid_mask, wcid->idx);
-			mt76_wcid_mask_clear(mdev->wcid_phy_mask, wcid->idx);
 		}
 
 		if (msta->deflink_id == link_id)
diff --git a/drivers/net/wireless/mediatek/mt76/util.c b/drivers/net/wireless/mediatek/mt76/util.c
index d6c01a2dd198..95b3dc96e4c4 100644
--- a/drivers/net/wireless/mediatek/mt76/util.c
+++ b/drivers/net/wireless/mediatek/mt76/util.c
@@ -64,7 +64,7 @@ int mt76_wcid_alloc(u32 *mask, int size)
 }
 EXPORT_SYMBOL_GPL(mt76_wcid_alloc);
 
-int mt76_get_min_avg_rssi(struct mt76_dev *dev, bool ext_phy)
+int mt76_get_min_avg_rssi(struct mt76_dev *dev, u8 phy_idx)
 {
 	struct mt76_wcid *wcid;
 	int i, j, min_rssi = 0;
@@ -75,20 +75,16 @@ int mt76_get_min_avg_rssi(struct mt76_dev *dev, bool ext_phy)
 
 	for (i = 0; i < ARRAY_SIZE(dev->wcid_mask); i++) {
 		u32 mask = dev->wcid_mask[i];
-		u32 phy_mask = dev->wcid_phy_mask[i];
 
 		if (!mask)
 			continue;
 
-		for (j = i * 32; mask; j++, mask >>= 1, phy_mask >>= 1) {
+		for (j = i * 32; mask; j++, mask >>= 1) {
 			if (!(mask & 1))
 				continue;
 
-			if (!!(phy_mask & 1) != ext_phy)
-				continue;
-
 			wcid = rcu_dereference(dev->wcid[j]);
-			if (!wcid)
+			if (!wcid || wcid->phy_idx != phy_idx)
 				continue;
 
 			spin_lock(&dev->rx_lock);
-- 
2.47.1


