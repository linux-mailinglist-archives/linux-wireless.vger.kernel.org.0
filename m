Return-Path: <linux-wireless+bounces-27301-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4979BB57219
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 09:59:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F08D117BA31
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 07:59:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 94ADE2EAB66;
	Mon, 15 Sep 2025 07:59:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="IXuNhiLf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A35E82E9EB9
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 07:59:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923161; cv=none; b=GyM1//MtsBOl1YLpUixWXdcs/nmqDviYjEgyk2HMQaRJWGC4fgVqAl/xjxO5AWuOgdSWW5YFlRJwbJ7X7MHETsViyaNEpiavEFs3pYnA/v5ymL79KSp2dhOFeYRTiSOyV/3Oh/1dglSlUGKq/WpMxMZLyQXl+ZQMEmhtZ0GCC/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923161; c=relaxed/simple;
	bh=LAXdAg4+gp9k3/XQfuwAuHy/XcerXNjcIzzwxQuRV1A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZvMmrm1zyjzy7Tj/PgufyLV8P0o+0eSDvhqQW5L9sO2bwmCohZ6U0+7/ojqv3xpLMoZ1adRV2EM2FIR5TP3f0+skH2Mi+Ks1ODdV+QGLjQuWcb5/0UaTQBPf4A+bDbIDDit/jDDqzJT8sY5hAgHrHHJ02LK+lzKcEn6VlGecI2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=IXuNhiLf; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=sawvS4NBledFk0v5NafD8k4N/FJpliF/uRht5qivOQA=; b=IXuNhiLfwK1U3A71EfCKcskrJ2
	CDM2E0P7EhVieD6PSxmJ/YypzCaGmNf8xfXNETK271bZe3Zlzphunt7NiBaLtEotjEXyx6doOcany
	mHGKaKRGwOgPQdJBIbEMN9Cpi4EQG/N/Bjv0CKiTZAPbhhGhQfSrlsCphsl4rzqrSXHQ=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uy47D-0078GN-0r
	for linux-wireless@vger.kernel.org;
	Mon, 15 Sep 2025 09:59:11 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH mt76 02/15] wifi: mt76: mt7996: improve hardware restart reliability
Date: Mon, 15 Sep 2025 09:58:57 +0200
Message-ID: <20250915075910.47558-2-nbd@nbd.name>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20250915075910.47558-1-nbd@nbd.name>
References: <20250915075910.47558-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Port latest version of similar changes from mt7915:
- use reconfig_complete to restart mac_work / queues
- clear wcid and vif mask to avoid leak
- fix sta poll list corruption
- reset station links
- reset interface links
- clear rro list

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7996/mac.c   | 86 +++++++++++++++++--
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 25 ++++--
 .../wireless/mediatek/mt76/mt7996/mt7996.h    |  2 +
 3 files changed, 100 insertions(+), 13 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index f6c725f52c4a..fd57569a7da7 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2355,11 +2355,59 @@ mt7996_mac_restart(struct mt7996_dev *dev)
 	return ret;
 }
 
+static void
+mt7996_mac_reset_sta_iter(void *data, struct ieee80211_sta *sta)
+{
+	struct mt7996_sta *msta = (struct mt7996_sta *)sta->drv_priv;
+	struct mt7996_dev *dev = data;
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(msta->link); i++) {
+		struct mt7996_sta_link *msta_link = NULL;
+
+		msta_link = rcu_replace_pointer(msta->link[i], msta_link,
+						lockdep_is_held(&dev->mt76.mutex));
+		if (!msta_link)
+			continue;
+
+		mt7996_mac_sta_deinit_link(dev, msta_link);
+
+		if (msta->deflink_id == i) {
+			msta->deflink_id = IEEE80211_LINK_UNSPECIFIED;
+			continue;
+		}
+
+		kfree_rcu(msta_link, rcu_head);
+	}
+}
+
+static void
+mt7996_mac_reset_vif_iter(void *data, u8 *mac, struct ieee80211_vif *vif)
+{
+	struct mt76_vif_link *mlink = (struct mt76_vif_link *)vif->drv_priv;
+	struct mt76_vif_data *mvif = mlink->mvif;
+	struct mt7996_dev *dev = data;
+	int i;
+
+	rcu_read_lock();
+	for (i = 0; i < ARRAY_SIZE(mvif->link); i++) {
+
+		mlink = mt76_dereference(mvif->link[i], &dev->mt76);
+		if (!mlink || mlink == (struct mt76_vif_link *)vif->drv_priv)
+			continue;
+
+		rcu_assign_pointer(mvif->link[i], NULL);
+		kfree_rcu(mlink, rcu_head);
+	}
+	rcu_read_unlock();
+}
+
 static void
 mt7996_mac_full_reset(struct mt7996_dev *dev)
 {
 	struct ieee80211_hw *hw = mt76_hw(dev);
 	struct mt7996_phy *phy;
+	LIST_HEAD(list);
 	int i;
 
 	dev->recovery.hw_full_reset = true;
@@ -2376,18 +2424,42 @@ mt7996_mac_full_reset(struct mt7996_dev *dev)
 		if (!mt7996_mac_restart(dev))
 			break;
 	}
-	mutex_unlock(&dev->mt76.mutex);
 
 	if (i == 10)
 		dev_err(dev->mt76.dev, "chip full reset failed\n");
 
-	ieee80211_restart_hw(mt76_hw(dev));
-	ieee80211_wake_queues(mt76_hw(dev));
-
-	dev->recovery.hw_full_reset = false;
 	mt7996_for_each_phy(dev, phy)
-		ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
-					     MT7996_WATCHDOG_TIME);
+		phy->omac_mask = 0;
+
+	ieee80211_iterate_stations_atomic(hw, mt7996_mac_reset_sta_iter, dev);
+	ieee80211_iterate_active_interfaces_atomic(hw,
+						   IEEE80211_IFACE_SKIP_SDATA_NOT_IN_DRIVER,
+						   mt7996_mac_reset_vif_iter, dev);
+	mt76_reset_device(&dev->mt76);
+
+	INIT_LIST_HEAD(&dev->sta_rc_list);
+	INIT_LIST_HEAD(&dev->twt_list);
+
+	spin_lock_bh(&dev->wed_rro.lock);
+	list_splice_init(&dev->wed_rro.poll_list, &list);
+	spin_unlock_bh(&dev->wed_rro.lock);
+
+	while (!list_empty(&list)) {
+		struct mt7996_wed_rro_session_id *e;
+
+		e = list_first_entry(&list, struct mt7996_wed_rro_session_id,
+				     list);
+		list_del_init(&e->list);
+		kfree(e);
+	}
+
+	i = mt76_wcid_alloc(dev->mt76.wcid_mask, MT7996_WTBL_STA);
+	dev->mt76.global_wcid.idx = i;
+	dev->recovery.hw_full_reset = false;
+
+	mutex_unlock(&dev->mt76.mutex);
+
+	ieee80211_restart_hw(mt76_hw(dev));
 }
 
 void mt7996_mac_reset_work(struct work_struct *work)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 6adb7f7bdd6f..8fbe60723071 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -986,13 +986,9 @@ mt7996_mac_sta_init_link(struct mt7996_dev *dev,
 	return 0;
 }
 
-static void
-mt7996_mac_sta_deinit_link(struct mt7996_dev *dev,
-			   struct mt7996_sta_link *msta_link)
+void mt7996_mac_sta_deinit_link(struct mt7996_dev *dev,
+				struct mt7996_sta_link *msta_link)
 {
-	mt7996_mac_wtbl_update(dev, msta_link->wcid.idx,
-			       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
-
 	spin_lock_bh(&dev->mt76.sta_poll_lock);
 	if (!list_empty(&msta_link->wcid.poll_list))
 		list_del_init(&msta_link->wcid.poll_list);
@@ -1022,6 +1018,9 @@ mt7996_mac_sta_remove_links(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		if (!msta_link)
 			continue;
 
+		mt7996_mac_wtbl_update(dev, msta_link->wcid.idx,
+				       MT_WTBL_UPDATE_ADM_COUNT_CLEAR);
+
 		mt7996_mac_sta_deinit_link(dev, msta_link);
 		link = mt7996_vif_link(dev, vif, link_id);
 		if (!link)
@@ -2206,6 +2205,19 @@ mt7996_change_vif_links(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return 0;
 }
 
+static void
+mt7996_reconfig_complete(struct ieee80211_hw *hw,
+			 enum ieee80211_reconfig_type reconfig_type)
+{
+	struct mt7996_dev *dev = mt7996_hw_dev(hw);
+	struct mt7996_phy *phy;
+
+	ieee80211_wake_queues(hw);
+	mt7996_for_each_phy(dev, phy)
+		ieee80211_queue_delayed_work(hw, &phy->mt76->mac_work,
+					     MT7996_WATCHDOG_TIME);
+}
+
 const struct ieee80211_ops mt7996_ops = {
 	.add_chanctx = mt76_add_chanctx,
 	.remove_chanctx = mt76_remove_chanctx,
@@ -2264,4 +2276,5 @@ const struct ieee80211_ops mt7996_ops = {
 #endif
 	.change_vif_links = mt7996_change_vif_links,
 	.change_sta_links = mt7996_mac_sta_change_links,
+	.reconfig_complete = mt7996_reconfig_complete,
 };
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
index be26e04b7da7..fa10aa6f517a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mt7996.h
@@ -817,6 +817,8 @@ void mt7996_mac_twt_teardown_flow(struct mt7996_dev *dev,
 				  struct mt7996_vif_link *link,
 				  struct mt7996_sta_link *msta_link,
 				  u8 flowid);
+void mt7996_mac_sta_deinit_link(struct mt7996_dev *dev,
+				struct mt7996_sta_link *msta_link);
 void mt7996_mac_add_twt_setup(struct ieee80211_hw *hw,
 			      struct ieee80211_sta *sta,
 			      struct ieee80211_twt_setup *twt);
-- 
2.51.0


