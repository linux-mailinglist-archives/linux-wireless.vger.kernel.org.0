Return-Path: <linux-wireless+bounces-11577-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A76AE955084
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 20:07:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAFD11C2172F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 18:07:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C7F191482F4;
	Fri, 16 Aug 2024 18:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="crtzA8b+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1001E1BE22D
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 18:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723831649; cv=none; b=kWyrnOkl7vwSQngUfOpdDaq/KwofKr/9gJe70wonlfOwtlwvwU2SMep7W/ZzVBlyWKGUlSzHhWve5jHhnXul/3PWHlAnXKd6MRm7viPNZAhluc1J9jQ6rvx1xADoVHiRlY++A/4QBZ53xAZpUU7v31BvI9VT9WidyNOfiIgkzDQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723831649; c=relaxed/simple;
	bh=qoAI91yhJQHV5nqBaykaR458ddO0Er/lntEP7K2LOnw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CMEpge2Bc6koc3+njxezeHFMGlH+AGVey1TccXp3AgTEMYKUmuwUOe40KjozHlhABuS66Zd+X6J8druRu5lPr8IUivZ0/UiB20Te5hfVSZd4t826YWH2O6zjJqQVXCjm6hsndqNF5DYqy0LQWVEJcoUa201+hUErfDJqopazSuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=crtzA8b+; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=S1QdbQgF6ZUx6pyDsugWhsZ2FbSBxPQrm/sEIjOf3wM=; b=crtzA8b+twTvzkzL6rOx9Lu7Dp
	UezeYBkYvWA7ryZ1bYJ0wlesqsUGMmq1NCz3M+FhR0hBQkyGUVD/1cGKC/YzYQ2A8mJ0lHwqx4pCs
	L41H+yj12UuYj3VARq+uen7CNvVxPNHnZMbMn3iBkmloj0wIIYSen/Gyd5nxhILk0hRk=;
Received: from p54ae95e7.dip0.t-ipconnect.de ([84.174.149.231] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sf0rS-000ObE-1Q
	for linux-wireless@vger.kernel.org;
	Fri, 16 Aug 2024 19:35:38 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 11/16] wifi: mt76: change .sta_assoc callback to .sta_event
Date: Fri, 16 Aug 2024 19:35:24 +0200
Message-ID: <20240816173529.17873-11-nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <20240816173529.17873-1-nbd@nbd.name>
References: <20240816173529.17873-1-nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Also report auth/disassoc events, in order to give the driver more control over
handling the station state.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 23 ++++++++++++++-----
 drivers/net/wireless/mediatek/mt76/mt76.h     | 10 ++++++--
 .../net/wireless/mediatek/mt76/mt7603/init.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7603/main.c  | 14 +++++++----
 .../wireless/mediatek/mt76/mt7603/mt7603.h    |  4 ++--
 .../net/wireless/mediatek/mt76/mt7921/main.c  | 11 ++++++---
 .../wireless/mediatek/mt76/mt7921/mt7921.h    |  4 ++--
 .../net/wireless/mediatek/mt76/mt7921/pci.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/sdio.c  |  2 +-
 .../net/wireless/mediatek/mt76/mt7921/usb.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7925/main.c  | 21 +++++++++--------
 .../wireless/mediatek/mt76/mt7925/mt7925.h    |  4 ++--
 .../net/wireless/mediatek/mt76/mt7925/pci.c   |  2 +-
 .../net/wireless/mediatek/mt76/mt7925/usb.c   |  2 +-
 14 files changed, 67 insertions(+), 36 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 6183b021f6eb..9d5561f44134 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -1509,21 +1509,32 @@ int mt76_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct mt76_phy *phy = hw->priv;
 	struct mt76_dev *dev = phy->dev;
+	enum mt76_sta_event ev;
 
 	if (old_state == IEEE80211_STA_NOTEXIST &&
 	    new_state == IEEE80211_STA_NONE)
 		return mt76_sta_add(phy, vif, sta);
 
-	if (old_state == IEEE80211_STA_AUTH &&
-	    new_state == IEEE80211_STA_ASSOC &&
-	    dev->drv->sta_assoc)
-		dev->drv->sta_assoc(dev, vif, sta);
-
 	if (old_state == IEEE80211_STA_NONE &&
 	    new_state == IEEE80211_STA_NOTEXIST)
 		mt76_sta_remove(dev, vif, sta);
 
-	return 0;
+	if (!dev->drv->sta_event)
+		return 0;
+
+	if (old_state == IEEE80211_STA_AUTH &&
+	    new_state == IEEE80211_STA_ASSOC)
+		ev = MT76_STA_EVENT_ASSOC;
+	else if (old_state == IEEE80211_STA_ASSOC &&
+		 new_state == IEEE80211_STA_AUTHORIZED)
+		ev = MT76_STA_EVENT_AUTHORIZE;
+	else if (old_state == IEEE80211_STA_ASSOC &&
+		 new_state == IEEE80211_STA_AUTH)
+		ev = MT76_STA_EVENT_DISASSOC;
+	else
+		return 0;
+
+	return dev->drv->sta_event(dev, vif, sta, ev);
 }
 EXPORT_SYMBOL_GPL(mt76_sta_state);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 87048aa27fbf..f1cd9dc86b42 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -467,6 +467,12 @@ enum {
 	MT76_STATE_WED_RESET,
 };
 
+enum mt76_sta_event {
+	MT76_STA_EVENT_ASSOC,
+	MT76_STA_EVENT_AUTHORIZE,
+	MT76_STA_EVENT_DISASSOC,
+};
+
 struct mt76_hw_cap {
 	bool has_2ghz;
 	bool has_5ghz;
@@ -513,8 +519,8 @@ struct mt76_driver_ops {
 	int (*sta_add)(struct mt76_dev *dev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
 
-	void (*sta_assoc)(struct mt76_dev *dev, struct ieee80211_vif *vif,
-			  struct ieee80211_sta *sta);
+	int (*sta_event)(struct mt76_dev *dev, struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta, enum mt76_sta_event ev);
 
 	void (*sta_remove)(struct mt76_dev *dev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/init.c b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
index 1528a8be7762..86617a3e4328 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/init.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/init.c
@@ -15,7 +15,7 @@ const struct mt76_driver_ops mt7603_drv_ops = {
 	.rx_poll_complete = mt7603_rx_poll_complete,
 	.sta_ps = mt7603_sta_ps,
 	.sta_add = mt7603_sta_add,
-	.sta_assoc = mt7603_sta_assoc,
+	.sta_event = mt7603_sta_event,
 	.sta_remove = mt7603_sta_remove,
 	.update_survey = mt7603_update_channel,
 	.set_channel = mt7603_set_channel,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/main.c b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
index 3d3a4cc2bab1..574f74ad325d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/main.c
@@ -355,13 +355,19 @@ mt7603_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	return ret;
 }
 
-void
-mt7603_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-		 struct ieee80211_sta *sta)
+int
+mt7603_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+		 struct ieee80211_sta *sta, enum mt76_sta_event ev)
 {
 	struct mt7603_dev *dev = container_of(mdev, struct mt7603_dev, mt76);
 
-	mt7603_wtbl_update_cap(dev, sta);
+	if (ev == MT76_STA_EVENT_ASSOC) {
+		mutex_lock(&dev->mt76.mutex);
+		mt7603_wtbl_update_cap(dev, sta);
+		mutex_unlock(&dev->mt76.mutex);
+	}
+
+	return 0;
 }
 
 void
diff --git a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
index dbdfe596f29e..55a034ccbacd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7603/mt7603.h
@@ -246,8 +246,8 @@ void mt7603_rx_poll_complete(struct mt76_dev *mdev, enum mt76_rxq_id q);
 void mt7603_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
 int mt7603_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		   struct ieee80211_sta *sta);
-void mt7603_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-		      struct ieee80211_sta *sta);
+int mt7603_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+		     struct ieee80211_sta *sta, enum mt76_sta_event ev);
 void mt7603_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
index 8084d385053f..162eded84f25 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
@@ -821,13 +821,16 @@ int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 }
 EXPORT_SYMBOL_GPL(mt7921_mac_sta_add);
 
-void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-			  struct ieee80211_sta *sta)
+int mt7921_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta, enum mt76_sta_event ev)
 {
 	struct mt792x_dev *dev = container_of(mdev, struct mt792x_dev, mt76);
 	struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
 	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
 
+	if (ev != MT76_STA_EVENT_ASSOC)
+	    return 0;
+
 	mt792x_mutex_acquire(dev);
 
 	if (vif->type == NL80211_IFTYPE_STATION && !sta->tdls)
@@ -843,8 +846,10 @@ void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 	mt7921_mcu_sta_update(dev, sta, vif, true, MT76_STA_INFO_STATE_ASSOC);
 
 	mt792x_mutex_release(dev);
+
+	return 0;
 }
-EXPORT_SYMBOL_GPL(mt7921_mac_sta_assoc);
+EXPORT_SYMBOL_GPL(mt7921_mac_sta_event);
 
 void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
index 0b4f4c8d8858..16c89815c0b8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/mt7921.h
@@ -245,8 +245,8 @@ int mt7921_mac_init(struct mt792x_dev *dev);
 bool mt7921_mac_wtbl_update(struct mt792x_dev *dev, int idx, u32 mask);
 int mt7921_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
-void mt7921_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-			  struct ieee80211_sta *sta);
+int mt7921_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta, enum mt76_sta_event ev);
 void mt7921_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta);
 void mt7921_mac_reset_work(struct work_struct *work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
index bb8cfff78dc5..67723c22aea6 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/pci.c
@@ -244,7 +244,7 @@ static int mt7921_pci_probe(struct pci_dev *pdev,
 		.rx_skb = mt7921_queue_rx_skb,
 		.rx_poll_complete = mt792x_rx_poll_complete,
 		.sta_add = mt7921_mac_sta_add,
-		.sta_assoc = mt7921_mac_sta_assoc,
+		.sta_event = mt7921_mac_sta_event,
 		.sta_remove = mt7921_mac_sta_remove,
 		.update_survey = mt792x_update_channel,
 		.set_channel = mt7921_set_channel,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
index 2ef502d0ce9a..95f526f7bb99 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/sdio.c
@@ -100,7 +100,7 @@ static int mt7921s_probe(struct sdio_func *func,
 		.rx_skb = mt7921_queue_rx_skb,
 		.rx_check = mt7921_rx_check,
 		.sta_add = mt7921_mac_sta_add,
-		.sta_assoc = mt7921_mac_sta_assoc,
+		.sta_event = mt7921_mac_sta_event,
 		.sta_remove = mt7921_mac_sta_remove,
 		.update_survey = mt792x_update_channel,
 		.set_channel = mt7921_set_channel,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
index 3b5e52db4a13..8aa4f0203208 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7921/usb.c
@@ -151,7 +151,7 @@ static int mt7921u_probe(struct usb_interface *usb_intf,
 		.rx_skb = mt7921_queue_rx_skb,
 		.rx_check = mt7921_rx_check,
 		.sta_add = mt7921_mac_sta_add,
-		.sta_assoc = mt7921_mac_sta_assoc,
+		.sta_event = mt7921_mac_sta_event,
 		.sta_remove = mt7921_mac_sta_remove,
 		.update_survey = mt792x_update_channel,
 		.set_channel = mt7921_set_channel,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/main.c b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
index 8c0768bf9343..38a301533297 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/main.c
@@ -1078,23 +1078,26 @@ static void mt7925_mac_link_sta_assoc(struct mt76_dev *mdev,
 	mt792x_mutex_release(dev);
 }
 
-void mt7925_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-			  struct ieee80211_sta *sta)
+int mt7925_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta, enum mt76_sta_event ev)
 {
+	struct ieee80211_link_sta *link_sta = &sta->deflink;
+
+	if (ev != MT76_STA_EVENT_ASSOC)
+		return 0;
+
 	if (ieee80211_vif_is_mld(vif)) {
 		struct mt792x_sta *msta = (struct mt792x_sta *)sta->drv_priv;
-		struct ieee80211_link_sta *link_sta;
 
 		link_sta = mt792x_sta_to_link_sta(vif, sta, msta->deflink_id);
-
 		mt7925_mac_set_links(mdev, vif);
-
-		mt7925_mac_link_sta_assoc(mdev, vif, link_sta);
-	} else {
-		mt7925_mac_link_sta_assoc(mdev, vif, &sta->deflink);
 	}
+
+	mt7925_mac_link_sta_assoc(mdev, vif, link_sta);
+
+	return 0;
 }
-EXPORT_SYMBOL_GPL(mt7925_mac_sta_assoc);
+EXPORT_SYMBOL_GPL(mt7925_mac_sta_event);
 
 static void mt7925_mac_link_sta_remove(struct mt76_dev *mdev,
 				       struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
index 669f3a079d04..e80824a10b2c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mt7925.h
@@ -219,8 +219,8 @@ int mt7925_mac_init(struct mt792x_dev *dev);
 int mt7925_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
 bool mt7925_mac_wtbl_update(struct mt792x_dev *dev, int idx, u32 mask);
-void mt7925_mac_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-			  struct ieee80211_sta *sta);
+int mt7925_mac_sta_event(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			 struct ieee80211_sta *sta, enum mt76_sta_event ev);
 void mt7925_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta);
 void mt7925_mac_reset_work(struct work_struct *work);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
index 6e4f4e78c350..cb25eb50a45b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/pci.c
@@ -279,7 +279,7 @@ static int mt7925_pci_probe(struct pci_dev *pdev,
 		.rx_skb = mt7925_queue_rx_skb,
 		.rx_poll_complete = mt792x_rx_poll_complete,
 		.sta_add = mt7925_mac_sta_add,
-		.sta_assoc = mt7925_mac_sta_assoc,
+		.sta_event = mt7925_mac_sta_event,
 		.sta_remove = mt7925_mac_sta_remove,
 		.update_survey = mt792x_update_channel,
 	};
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
index 1e0f094fc905..682db1bab21c 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/usb.c
@@ -142,7 +142,7 @@ static int mt7925u_probe(struct usb_interface *usb_intf,
 		.rx_skb = mt7925_queue_rx_skb,
 		.rx_check = mt7925_rx_check,
 		.sta_add = mt7925_mac_sta_add,
-		.sta_assoc = mt7925_mac_sta_assoc,
+		.sta_event = mt7925_mac_sta_event,
 		.sta_remove = mt7925_mac_sta_remove,
 		.update_survey = mt792x_update_channel,
 	};
-- 
2.44.0


