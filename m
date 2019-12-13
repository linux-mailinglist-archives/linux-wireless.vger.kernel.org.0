Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CE9EF11ECF8
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2019 22:36:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726427AbfLMVgc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 13 Dec 2019 16:36:32 -0500
Received: from nbd.name ([46.4.11.11]:47442 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725945AbfLMVgc (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 13 Dec 2019 16:36:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=yAZ8C60XPk3M2i7CF9Q6LKWSu8o++aHRCcHRq7tn1lg=; b=OeXowF1G2stWVbukLSoLAqqm7P
        rVmZ3ssoBqUy+/IAumo4T2cMuy1D/2J6btbZOcGO78S/nWth5/jigYe5krliGA50Ik7Uap9Q8ZGlk
        1XksCnMr/9PnU0hXBO9G2uJQ5Nrif1d0JCxEhke9aDNThIv3Ssm9cbwTQBHAeVUeCtHc=;
Received: from p4ff13e83.dip0.t-ipconnect.de ([79.241.62.131] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ifsbt-0001nX-Lb
        for linux-wireless@vger.kernel.org; Fri, 13 Dec 2019 22:36:30 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 21A0973C1140; Fri, 13 Dec 2019 22:36:28 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 2/4] mt7615: replace sta_state callback with sta_add/sta_remove
Date:   Fri, 13 Dec 2019 22:36:26 +0100
Message-Id: <20191213213628.73840-2-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191213213628.73840-1-nbd@nbd.name>
References: <20191213213628.73840-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

The MT7615 firmware needs to know the association id at creation time,
which is unavailable during the transition from notexist to none in
.sta_state.
This can cause a number of issues, probably also breaking powersave
support.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7615/main.c  | 38 ++++++++++++-------
 .../wireless/mediatek/mt76/mt7615/mt7615.h    |  8 ++--
 .../net/wireless/mediatek/mt76/mt7615/pci.c   |  5 +--
 3 files changed, 29 insertions(+), 22 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index c6a0ca1034c0..d759f009599b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -434,8 +434,8 @@ mt7615_channel_switch_beacon(struct ieee80211_hw *hw,
 	mutex_unlock(&dev->mt76.mutex);
 }
 
-int mt7615_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-		   struct ieee80211_sta *sta)
+int mt7615_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+		       struct ieee80211_sta *sta)
 {
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
@@ -455,21 +455,14 @@ int mt7615_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 
 	mt7615_mcu_add_wtbl(dev, vif, sta);
 	mt7615_mcu_set_sta_rec(dev, vif, sta, 1);
+	if (sta->ht_cap.ht_supported)
+		mt7615_mcu_set_ht_cap(dev, vif, sta);
 
 	return 0;
 }
 
-void mt7615_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-		      struct ieee80211_sta *sta)
-{
-	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
-
-	if (sta->ht_cap.ht_supported)
-		mt7615_mcu_set_ht_cap(dev, vif, sta);
-}
-
-void mt7615_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-		       struct ieee80211_sta *sta)
+void mt7615_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta)
 {
 	struct mt7615_dev *dev = container_of(mdev, struct mt7615_dev, mt76);
 	struct mt7615_sta *msta = (struct mt7615_sta *)sta->drv_priv;
@@ -605,6 +598,22 @@ mt7615_ampdu_action(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	return ret;
 }
 
+static int
+mt7615_sta_add(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+	       struct ieee80211_sta *sta)
+{
+    return mt76_sta_state(hw, vif, sta, IEEE80211_STA_NOTEXIST,
+			  IEEE80211_STA_NONE);
+}
+
+static int
+mt7615_sta_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		  struct ieee80211_sta *sta)
+{
+    return mt76_sta_state(hw, vif, sta, IEEE80211_STA_NONE,
+			  IEEE80211_STA_NOTEXIST);
+}
+
 const struct ieee80211_ops mt7615_ops = {
 	.tx = mt7615_tx,
 	.start = mt7615_start,
@@ -615,7 +624,8 @@ const struct ieee80211_ops mt7615_ops = {
 	.conf_tx = mt7615_conf_tx,
 	.configure_filter = mt7615_configure_filter,
 	.bss_info_changed = mt7615_bss_info_changed,
-	.sta_state = mt76_sta_state,
+	.sta_add = mt7615_sta_add,
+	.sta_remove = mt7615_sta_remove,
 	.set_key = mt7615_set_key,
 	.ampdu_action = mt7615_ampdu_action,
 	.set_rts_threshold = mt7615_set_rts_threshold,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
index b4d6727cf285..4fe6dc60e0cd 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mt7615.h
@@ -313,12 +313,10 @@ void mt7615_tx_complete_skb(struct mt76_dev *mdev, enum mt76_txq_id qid,
 void mt7615_queue_rx_skb(struct mt76_dev *mdev, enum mt76_rxq_id q,
 			 struct sk_buff *skb);
 void mt7615_sta_ps(struct mt76_dev *mdev, struct ieee80211_sta *sta, bool ps);
-int mt7615_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-		   struct ieee80211_sta *sta);
-void mt7615_sta_assoc(struct mt76_dev *mdev, struct ieee80211_vif *vif,
-		      struct ieee80211_sta *sta);
-void mt7615_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+int mt7615_mac_sta_add(struct mt76_dev *mdev, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
+void mt7615_mac_sta_remove(struct mt76_dev *mdev, struct ieee80211_vif *vif,
+			   struct ieee80211_sta *sta);
 void mt7615_mac_work(struct work_struct *work);
 void mt7615_txp_skb_unmap(struct mt76_dev *dev,
 			  struct mt76_txwi_cache *txwi);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
index dd9ee80dbef7..7e3556c3b6eb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/pci.c
@@ -81,9 +81,8 @@ static int mt7615_pci_probe(struct pci_dev *pdev,
 		.rx_skb = mt7615_queue_rx_skb,
 		.rx_poll_complete = mt7615_rx_poll_complete,
 		.sta_ps = mt7615_sta_ps,
-		.sta_add = mt7615_sta_add,
-		.sta_assoc = mt7615_sta_assoc,
-		.sta_remove = mt7615_sta_remove,
+		.sta_add = mt7615_mac_sta_add,
+		.sta_remove = mt7615_mac_sta_remove,
 		.update_survey = mt7615_update_channel,
 	};
 	struct mt7615_dev *dev;
-- 
2.24.0

