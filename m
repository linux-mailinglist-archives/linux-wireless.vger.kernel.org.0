Return-Path: <linux-wireless+bounces-27310-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D40FBB57224
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 10:00:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2B3981897540
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 08:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BB27D2EBBB4;
	Mon, 15 Sep 2025 07:59:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="WkT3Bmxi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F46D2EA159
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923164; cv=none; b=OIyXVf6GxwtfIXntX05LQ/4frb0a+NZPF7OVnkxFhmMJkCnlDXAqIJCqnOefbnn7Gy2Esc/mzFTEBVzm3OQoUWRYDZqOBuuBHPHkBVZat1dsy1iY05UwFb7QSEcNi6bZJGqPDc+oVtERUsRgiNDfmZPGcGR0igPcarL8MQnQqJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923164; c=relaxed/simple;
	bh=ScWAzRuiGu4jd1VloobObsY2wqS0LTM9xMpHeq7Qh0A=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PE7XBuQbAyfY1G8EGl3//n6gT7ZqzyD5vOzC3iFQHClu7hR8/NFMP0WNQjWFwiHtBtYdHZRTPsJ1KtcnoKtAcYTxk2BNO99m/yXzw9pACaMsLVFzyaKEw851F0eg2DiXdzmjjmTZ33a+CjzzrmHat/ClwT+W5PWcWufbqD6d4qU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=WkT3Bmxi; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=4J3SLRbQaHJV0Hhz2SuxiIfnR2N+u4it8dUXj644AVs=; b=WkT3Bmxi5ZiOHFhjevKL/4hHUI
	ZqTnb7+ygpBy24BHqGifJdtr2jYTVCiTYMF8QGzVWU8f2YjM3AmMmhVq0cTgxu72q4B7na+gEM9b4
	CYjsk7PmYYz4fu81Zym6UxO8DPsSl1e8ejXwraYND5dsaWWVd2ikyyRta0wkCG5qCH8E=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uy47F-0078GN-2L
	for linux-wireless@vger.kernel.org;
	Mon, 15 Sep 2025 09:59:13 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH mt76 15/15] wifi: mt76: abort scan/roc on hw restart
Date: Mon, 15 Sep 2025 09:59:10 +0200
Message-ID: <20250915075910.47558-15-nbd@nbd.name>
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

Avoid spurious channel changes and clean up allocated links

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/channel.c    | 13 +++++++++----
 drivers/net/wireless/mediatek/mt76/mac80211.c   |  3 +++
 drivers/net/wireless/mediatek/mt76/mt76.h       |  1 +
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c |  2 ++
 drivers/net/wireless/mediatek/mt76/scan.c       | 10 +++++++---
 5 files changed, 22 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/channel.c b/drivers/net/wireless/mediatek/mt76/channel.c
index 77b75792eb48..130af1b254db 100644
--- a/drivers/net/wireless/mediatek/mt76/channel.c
+++ b/drivers/net/wireless/mediatek/mt76/channel.c
@@ -314,21 +314,24 @@ void mt76_put_vif_phy_link(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	kfree(mlink);
 }
 
-static void mt76_roc_complete(struct mt76_phy *phy)
+void mt76_roc_complete(struct mt76_phy *phy)
 {
 	struct mt76_vif_link *mlink = phy->roc_link;
+	struct mt76_dev *dev = phy->dev;
 
 	if (!phy->roc_vif)
 		return;
 
 	if (mlink)
 		mlink->mvif->roc_phy = NULL;
-	if (phy->main_chandef.chan)
+	if (phy->main_chandef.chan &&
+	    !test_bit(MT76_MCU_RESET, &dev->phy.state))
 		mt76_set_channel(phy, &phy->main_chandef, false);
 	mt76_put_vif_phy_link(phy, phy->roc_vif, phy->roc_link);
 	phy->roc_vif = NULL;
 	phy->roc_link = NULL;
-	ieee80211_remain_on_channel_expired(phy->hw);
+	if (!test_bit(MT76_MCU_RESET, &dev->phy.state))
+		ieee80211_remain_on_channel_expired(phy->hw);
 }
 
 void mt76_roc_complete_work(struct work_struct *work)
@@ -351,6 +354,7 @@ void mt76_abort_roc(struct mt76_phy *phy)
 	mt76_roc_complete(phy);
 	mutex_unlock(&dev->mutex);
 }
+EXPORT_SYMBOL_GPL(mt76_abort_roc);
 
 int mt76_remain_on_channel(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			   struct ieee80211_channel *chan, int duration,
@@ -368,7 +372,8 @@ int mt76_remain_on_channel(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	mutex_lock(&dev->mutex);
 
-	if (phy->roc_vif || dev->scan.phy == phy) {
+	if (phy->roc_vif || dev->scan.phy == phy ||
+	    test_bit(MT76_MCU_RESET, &dev->phy.state)) {
 		ret = -EBUSY;
 		goto out;
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index f6a494812fe1..5ceaf78c9ea0 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -826,6 +826,7 @@ static void mt76_reset_phy(struct mt76_phy *phy)
 	INIT_LIST_HEAD(&phy->tx_list);
 	phy->num_sta = 0;
 	phy->chanctx = NULL;
+	mt76_roc_complete(phy);
 }
 
 void mt76_reset_device(struct mt76_dev *dev)
@@ -846,6 +847,8 @@ void mt76_reset_device(struct mt76_dev *dev)
 	}
 	rcu_read_unlock();
 
+	mt76_abort_scan(dev);
+
 	INIT_LIST_HEAD(&dev->wcid_list);
 	INIT_LIST_HEAD(&dev->sta_poll_list);
 	dev->vif_mask = 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 883356cd0c0b..e0d50b58cd01 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1643,6 +1643,7 @@ int mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
 void mt76_scan_work(struct work_struct *work);
 void mt76_abort_scan(struct mt76_dev *dev);
 void mt76_roc_complete_work(struct work_struct *work);
+void mt76_roc_complete(struct mt76_phy *phy);
 void mt76_abort_roc(struct mt76_phy *phy);
 struct mt76_vif_link *mt76_get_vif_phy_link(struct mt76_phy *phy,
 					    struct ieee80211_vif *vif);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 2d5dab535357..9501def3e0e3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -2514,10 +2514,12 @@ void mt7996_mac_reset_work(struct work_struct *work)
 
 	set_bit(MT76_RESET, &dev->mphy.state);
 	set_bit(MT76_MCU_RESET, &dev->mphy.state);
+	mt76_abort_scan(&dev->mt76);
 	wake_up(&dev->mt76.mcu.wait);
 
 	cancel_work_sync(&dev->wed_rro.work);
 	mt7996_for_each_phy(dev, phy) {
+		mt76_abort_roc(phy->mt76);
 		set_bit(MT76_RESET, &phy->mt76->state);
 		cancel_delayed_work_sync(&phy->mt76->mac_work);
 	}
diff --git a/drivers/net/wireless/mediatek/mt76/scan.c b/drivers/net/wireless/mediatek/mt76/scan.c
index 458f8cdebc10..5a875aac410f 100644
--- a/drivers/net/wireless/mediatek/mt76/scan.c
+++ b/drivers/net/wireless/mediatek/mt76/scan.c
@@ -16,11 +16,13 @@ static void mt76_scan_complete(struct mt76_dev *dev, bool abort)
 
 	clear_bit(MT76_SCANNING, &phy->state);
 
-	if (dev->scan.chan && phy->main_chandef.chan)
+	if (dev->scan.chan && phy->main_chandef.chan &&
+	    !test_bit(MT76_MCU_RESET, &dev->phy.state))
 		mt76_set_channel(phy, &phy->main_chandef, false);
 	mt76_put_vif_phy_link(phy, dev->scan.vif, dev->scan.mlink);
 	memset(&dev->scan, 0, sizeof(dev->scan));
-	ieee80211_scan_completed(phy->hw, &info);
+	if (!test_bit(MT76_MCU_RESET, &dev->phy.state))
+		ieee80211_scan_completed(phy->hw, &info);
 }
 
 void mt76_abort_scan(struct mt76_dev *dev)
@@ -28,6 +30,7 @@ void mt76_abort_scan(struct mt76_dev *dev)
 	cancel_delayed_work_sync(&dev->scan_work);
 	mt76_scan_complete(dev, true);
 }
+EXPORT_SYMBOL_GPL(mt76_abort_scan);
 
 static void
 mt76_scan_send_probe(struct mt76_dev *dev, struct cfg80211_ssid *ssid)
@@ -136,7 +139,8 @@ int mt76_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	mutex_lock(&dev->mutex);
 
-	if (dev->scan.req || phy->roc_vif) {
+	if (dev->scan.req || phy->roc_vif ||
+	    test_bit(MT76_MCU_RESET, &dev->phy.state)) {
 		ret = -EBUSY;
 		goto out;
 	}
-- 
2.51.0


