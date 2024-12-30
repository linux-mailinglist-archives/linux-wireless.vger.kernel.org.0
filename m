Return-Path: <linux-wireless+bounces-16921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4A0FB9FEA6B
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 20:42:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 54FB83A2C5F
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Dec 2024 19:42:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 83E43EAD0;
	Mon, 30 Dec 2024 19:42:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="JUPrNXxb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A32C619ADA4
	for <linux-wireless@vger.kernel.org>; Mon, 30 Dec 2024 19:42:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735587735; cv=none; b=gHQOmCqerIQ87LS+rRdqqGHUTdTnGd/o7b0l9hEDEBwdflgKa9zt0bFRhN1It8O9TSC7mL0CwEBVNx01tqHRmTvC36WCwKhPdQEUH3MHROibFldwqgCiNW8kFZrEuu0VzsOUt8BWcGe5diAsX5AU+WS0vGObRoMA/LkgYA/fpFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735587735; c=relaxed/simple;
	bh=v3qbOXpgEum+0L51Yp8G1ReukbFiuMr4wXE/SkSz3KY=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EyZ8QZX9Doy/DLSlHrHO3VXKWepyjP9HTJm40R4UYRFZqYYDx37DnspPIQ/QwEDueIZb6811u88F/TqyZP6uEZumEJSXDPgoAuVN4RDhxwNDUMtzkIl+p8KU3WaXRTHwuG6ux4Fg1ypcJWzTWuiPyPDv2V4sr+seWlV6g1pSKlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=JUPrNXxb; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=qoY2i8BoUdLuFv+4+eR0xHQSVSACGLYFbM6e1qsfWX8=; b=JUPrNXxbPJY8of1IUFMoY6ZaEK
	l/mEpD0cPOTdQH2RNLNh2rb1Kkfe2IjaN2E0W9T0LIWoKLHhJ4XmeT0g7VVz87AUmloCmow39oUgM
	3Q7PnW81Y+nr1+l4Rkl4AMV4VksMHDsdOhJWg4ZHqf+BHKIqmiNTouISHdj5SnpNonPI=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tSLeV-00GKzc-2c
	for linux-wireless@vger.kernel.org;
	Mon, 30 Dec 2024 20:42:11 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 14/14] wifi: mt76: do not add wcid entries to sta poll list during MCU reset
Date: Mon, 30 Dec 2024 20:42:02 +0100
Message-ID: <20241230194202.95065-14-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241230194202.95065-1-nbd@nbd.name>
References: <20241230194202.95065-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fixes linked list management issues during restart, where sta entries
can be recreated and reinitialized while still in the poll list, triggering
kernel warnings.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c   | 12 ++++++++++++
 drivers/net/wireless/mediatek/mt76/mt76.h       |  1 +
 drivers/net/wireless/mediatek/mt76/mt7603/mac.c |  7 +------
 drivers/net/wireless/mediatek/mt76/mt7615/mac.c | 12 ++----------
 .../wireless/mediatek/mt76/mt76_connac_mac.c    |  6 +-----
 drivers/net/wireless/mediatek/mt76/mt7915/mac.c | 17 +++--------------
 drivers/net/wireless/mediatek/mt76/mt7921/mac.c | 17 +++--------------
 drivers/net/wireless/mediatek/mt76/mt7925/mac.c | 17 +++--------------
 drivers/net/wireless/mediatek/mt76/mt7996/mac.c | 17 +++--------------
 9 files changed, 29 insertions(+), 77 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 3642c490fa6d..6db59652be6e 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1595,6 +1595,18 @@ void mt76_wcid_cleanup(struct mt76_dev *dev, struct mt76_wcid *wcid)
 }
 EXPORT_SYMBOL_GPL(mt76_wcid_cleanup);
 
+void mt76_wcid_add_poll(struct mt76_dev *dev, struct mt76_wcid *wcid)
+{
+	if (test_bit(MT76_MCU_RESET, &dev->phy.state))
+		return;
+
+	spin_lock_bh(&dev->sta_poll_lock);
+	if (list_empty(&wcid->poll_list))
+		list_add_tail(&wcid->poll_list, &dev->sta_poll_list);
+	spin_unlock_bh(&dev->sta_poll_lock);
+}
+EXPORT_SYMBOL_GPL(mt76_wcid_add_poll);
+
 int mt76_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		     unsigned int link_id, int *dbm)
 {
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 3bc591c14b65..34b6b094b8eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1735,5 +1735,6 @@ mt76_token_put(struct mt76_dev *dev, int token)
 
 void mt76_wcid_init(struct mt76_wcid *wcid);
 void mt76_wcid_cleanup(struct mt76_dev *dev, struct mt76_wcid *wcid);
+void mt76_wcid_add_poll(struct mt76_dev *dev, struct mt76_wcid *wcid);
 
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
index dc8a77f0a1cc..dafa4b05f623 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mac.c
@@ -1277,12 +1277,7 @@ void mt7603_mac_add_txs(struct mt7603_dev *dev, void *data)
 
 	msta = container_of(wcid, struct mt7603_sta, wcid);
 	sta = wcid_to_sta(wcid);
-
-	if (list_empty(&msta->wcid.poll_list)) {
-		spin_lock_bh(&dev->mt76.sta_poll_lock);
-		list_add_tail(&msta->wcid.poll_list, &dev->mt76.sta_poll_list);
-		spin_unlock_bh(&dev->mt76.sta_poll_lock);
-	}
+	mt76_wcid_add_poll(&dev->mt76, &msta->wcid);
 
 	if (mt7603_mac_add_txs_skb(dev, msta, pid, txs_data))
 		goto out;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
index 7ba789834e8d..27c3857bcd7b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mac.c
@@ -387,11 +387,7 @@ static int mt7615_mac_fill_rx(struct mt7615_dev *dev, struct sk_buff *skb)
 		struct mt7615_sta *msta;
 
 		msta = container_of(status->wcid, struct mt7615_sta, wcid);
-		spin_lock_bh(&dev->mt76.sta_poll_lock);
-		if (list_empty(&msta->wcid.poll_list))
-			list_add_tail(&msta->wcid.poll_list,
-				      &dev->mt76.sta_poll_list);
-		spin_unlock_bh(&dev->mt76.sta_poll_lock);
+		mt76_wcid_add_poll(&dev->mt76, &msta->wcid);
 	}
 
 	if (mt76_is_mmio(&dev->mt76) && (rxd0 & csum_mask) == csum_mask &&
@@ -1514,11 +1510,7 @@ static void mt7615_mac_add_txs(struct mt7615_dev *dev, void *data)
 
 	msta = container_of(wcid, struct mt7615_sta, wcid);
 	sta = wcid_to_sta(wcid);
-
-	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (list_empty(&msta->wcid.poll_list))
-		list_add_tail(&msta->wcid.poll_list, &dev->mt76.sta_poll_list);
-	spin_unlock_bh(&dev->mt76.sta_poll_lock);
+	mt76_wcid_add_poll(&dev->mt76, &msta->wcid);
 
 	if (mt7615_mac_add_txs_skb(dev, msta, pid, txs_data))
 		goto out;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
index a72551ba27e4..f719457e39b2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mac.c
@@ -1174,11 +1174,7 @@ void mt76_connac2_txwi_free(struct mt76_dev *dev, struct mt76_txwi_cache *t,
 		if (wcid && wcid->sta) {
 			sta = container_of((void *)wcid, struct ieee80211_sta,
 					   drv_priv);
-			spin_lock_bh(&dev->sta_poll_lock);
-			if (list_empty(&wcid->poll_list))
-				list_add_tail(&wcid->poll_list,
-					      &dev->sta_poll_list);
-			spin_unlock_bh(&dev->sta_poll_lock);
+			mt76_wcid_add_poll(dev, wcid);
 		}
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
index e2693aea2e8e..13bdc0a7174c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mac.c
@@ -333,11 +333,7 @@ mt7915_mac_fill_rx(struct mt7915_dev *dev, struct sk_buff *skb,
 
 	if (status->wcid) {
 		msta = container_of(status->wcid, struct mt7915_sta, wcid);
-		spin_lock_bh(&dev->mt76.sta_poll_lock);
-		if (list_empty(&msta->wcid.poll_list))
-			list_add_tail(&msta->wcid.poll_list,
-				      &dev->mt76.sta_poll_list);
-		spin_unlock_bh(&dev->mt76.sta_poll_lock);
+		mt76_wcid_add_poll(&dev->mt76, &msta->wcid);
 	}
 
 	status->freq = mphy->chandef.chan->center_freq;
@@ -927,11 +923,7 @@ mt7915_mac_tx_free(struct mt7915_dev *dev, void *data, int len)
 				continue;
 
 			msta = container_of(wcid, struct mt7915_sta, wcid);
-			spin_lock_bh(&mdev->sta_poll_lock);
-			if (list_empty(&msta->wcid.poll_list))
-				list_add_tail(&msta->wcid.poll_list,
-					      &mdev->sta_poll_list);
-			spin_unlock_bh(&mdev->sta_poll_lock);
+			mt76_wcid_add_poll(&dev->mt76, &msta->wcid);
 			continue;
 		}
 
@@ -1040,10 +1032,7 @@ static void mt7915_mac_add_txs(struct mt7915_dev *dev, void *data)
 	if (!wcid->sta)
 		goto out;
 
-	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (list_empty(&msta->wcid.poll_list))
-		list_add_tail(&msta->wcid.poll_list, &dev->mt76.sta_poll_list);
-	spin_unlock_bh(&dev->mt76.sta_poll_lock);
+	mt76_wcid_add_poll(&dev->mt76, &msta->wcid);
 
 out:
 	rcu_read_unlock();
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
index bd1455698ebe..5dd57de59f27 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mac.c
@@ -216,11 +216,7 @@ mt7921_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 	if (status->wcid) {
 		mlink = container_of(status->wcid, struct mt792x_link_sta, wcid);
 		msta = container_of(mlink, struct mt792x_sta, deflink);
-		spin_lock_bh(&dev->mt76.sta_poll_lock);
-		if (list_empty(&mlink->wcid.poll_list))
-			list_add_tail(&mlink->wcid.poll_list,
-				      &dev->mt76.sta_poll_list);
-		spin_unlock_bh(&dev->mt76.sta_poll_lock);
+		mt76_wcid_add_poll(&dev->mt76, &mlink->wcid);
 	}
 
 	mt792x_get_status_freq_info(status, chfreq);
@@ -479,10 +475,7 @@ void mt7921_mac_add_txs(struct mt792x_dev *dev, void *data)
 	if (!wcid->sta)
 		goto out;
 
-	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (list_empty(&mlink->wcid.poll_list))
-		list_add_tail(&mlink->wcid.poll_list, &dev->mt76.sta_poll_list);
-	spin_unlock_bh(&dev->mt76.sta_poll_lock);
+	mt76_wcid_add_poll(&dev->mt76, &mlink->wcid);
 
 out:
 	rcu_read_unlock();
@@ -529,11 +522,7 @@ static void mt7921_mac_tx_free(struct mt792x_dev *dev, void *data, int len)
 				continue;
 
 			mlink = container_of(wcid, struct mt792x_link_sta, wcid);
-			spin_lock_bh(&mdev->sta_poll_lock);
-			if (list_empty(&mlink->wcid.poll_list))
-				list_add_tail(&mlink->wcid.poll_list,
-					      &mdev->sta_poll_list);
-			spin_unlock_bh(&mdev->sta_poll_lock);
+			mt76_wcid_add_poll(&dev->mt76, &mlink->wcid);
 			continue;
 		}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
index a095fb31e391..187770537a1a 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mac.c
@@ -395,11 +395,7 @@ mt7925_mac_fill_rx(struct mt792x_dev *dev, struct sk_buff *skb)
 
 	if (status->wcid) {
 		mlink = container_of(status->wcid, struct mt792x_link_sta, wcid);
-		spin_lock_bh(&dev->mt76.sta_poll_lock);
-		if (list_empty(&mlink->wcid.poll_list))
-			list_add_tail(&mlink->wcid.poll_list,
-				      &dev->mt76.sta_poll_list);
-		spin_unlock_bh(&dev->mt76.sta_poll_lock);
+		mt76_wcid_add_poll(&dev->mt76, &mlink->wcid);
 	}
 
 	mt792x_get_status_freq_info(status, chfreq);
@@ -1054,10 +1050,7 @@ void mt7925_mac_add_txs(struct mt792x_dev *dev, void *data)
 	if (!wcid->sta)
 		goto out;
 
-	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (list_empty(&mlink->wcid.poll_list))
-		list_add_tail(&mlink->wcid.poll_list, &dev->mt76.sta_poll_list);
-	spin_unlock_bh(&dev->mt76.sta_poll_lock);
+	mt76_wcid_add_poll(&dev->mt76, &mlink->wcid);
 
 out:
 	rcu_read_unlock();
@@ -1135,11 +1128,7 @@ mt7925_mac_tx_free(struct mt792x_dev *dev, void *data, int len)
 				continue;
 
 			mlink = container_of(wcid, struct mt792x_link_sta, wcid);
-			spin_lock_bh(&mdev->sta_poll_lock);
-			if (list_empty(&mlink->wcid.poll_list))
-				list_add_tail(&mlink->wcid.poll_list,
-					      &mdev->sta_poll_list);
-			spin_unlock_bh(&mdev->sta_poll_lock);
+			mt76_wcid_add_poll(&dev->mt76, &mlink->wcid);
 			continue;
 		}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
index 4706ddefea9e..8e3620d8a7c8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mac.c
@@ -478,11 +478,7 @@ mt7996_mac_fill_rx(struct mt7996_dev *dev, enum mt76_rxq_id q,
 
 	if (status->wcid) {
 		msta = container_of(status->wcid, struct mt7996_sta, wcid);
-		spin_lock_bh(&dev->mt76.sta_poll_lock);
-		if (list_empty(&msta->wcid.poll_list))
-			list_add_tail(&msta->wcid.poll_list,
-				      &dev->mt76.sta_poll_list);
-		spin_unlock_bh(&dev->mt76.sta_poll_lock);
+		mt76_wcid_add_poll(&dev->mt76, &msta->wcid);
 	}
 
 	status->freq = mphy->chandef.chan->center_freq;
@@ -1149,11 +1145,7 @@ mt7996_mac_tx_free(struct mt7996_dev *dev, void *data, int len)
 				continue;
 
 			msta = container_of(wcid, struct mt7996_sta, wcid);
-			spin_lock_bh(&mdev->sta_poll_lock);
-			if (list_empty(&msta->wcid.poll_list))
-				list_add_tail(&msta->wcid.poll_list,
-					      &mdev->sta_poll_list);
-			spin_unlock_bh(&mdev->sta_poll_lock);
+			mt76_wcid_add_poll(&dev->mt76, &msta->wcid);
 			continue;
 		} else if (info & MT_TXFREE_INFO_HEADER) {
 			u32 tx_retries = 0, tx_failed = 0;
@@ -1379,10 +1371,7 @@ static void mt7996_mac_add_txs(struct mt7996_dev *dev, void *data)
 	if (!wcid->sta)
 		goto out;
 
-	spin_lock_bh(&dev->mt76.sta_poll_lock);
-	if (list_empty(&msta->wcid.poll_list))
-		list_add_tail(&msta->wcid.poll_list, &dev->mt76.sta_poll_list);
-	spin_unlock_bh(&dev->mt76.sta_poll_lock);
+	mt76_wcid_add_poll(&dev->mt76, &msta->wcid);
 
 out:
 	rcu_read_unlock();
-- 
2.47.1


