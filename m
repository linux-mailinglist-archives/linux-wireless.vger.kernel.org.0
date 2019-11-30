Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 4E43D10DE13
	for <lists+linux-wireless@lfdr.de>; Sat, 30 Nov 2019 16:30:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727244AbfK3Pat (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 30 Nov 2019 10:30:49 -0500
Received: from nbd.name ([46.4.11.11]:56068 "EHLO nbd.name"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727219AbfK3Pat (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 30 Nov 2019 10:30:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
         s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=NaRZAaGEN/3w6ORA9NBtgPNVaRuUfhTm2Lfz7BG5Gws=; b=JC/TjW3+HnznOR/ZCTjyij4Lm6
        phBxPNBl29P6NwMojTnQmMOc2loZBk455VBDDY0mwWwOBlycJs2vn4qgtyVkmBKNi/lGqsRKearke
        PR1YWW2TGwsoEj4x/QTndHKIXSZM9LCZbenseVRfDNmOF8crpoKFdTJh/MtTtijXay2c=;
Received: from p5b2067e3.dip0.t-ipconnect.de ([91.32.103.227] helo=maeck.local)
        by ds12 with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.89)
        (envelope-from <nbd@nbd.name>)
        id 1ib4hr-0006iP-RV
        for linux-wireless@vger.kernel.org; Sat, 30 Nov 2019 16:30:48 +0100
Received: by maeck.local (Postfix, from userid 501)
        id 0D293721EBEB; Sat, 30 Nov 2019 16:30:45 +0100 (CET)
From:   Felix Fietkau <nbd@nbd.name>
To:     linux-wireless@vger.kernel.org
Subject: [PATCH 06/29] mt76: add support for an extra wiphy in mt76_sta_state()
Date:   Sat, 30 Nov 2019 16:30:22 +0100
Message-Id: <20191130153045.28105-6-nbd@nbd.name>
X-Mailer: git-send-email 2.24.0
In-Reply-To: <20191130153045.28105-1-nbd@nbd.name>
References: <20191130153045.28105-1-nbd@nbd.name>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is preparation for supporting multiple wiphys per device to support the
concurrent dual-band feature of MT7615D

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 13 +++++++++----
 drivers/net/wireless/mediatek/mt76/mt76.h     | 11 +++++++++++
 drivers/net/wireless/mediatek/mt76/util.h     | 14 +++++++++++++-
 3 files changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 0c2a11172203..8cd378666c6e 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -828,7 +828,7 @@ EXPORT_SYMBOL_GPL(mt76_rx_poll_complete);
 
 static int
 mt76_sta_add(struct mt76_dev *dev, struct ieee80211_vif *vif,
-	     struct ieee80211_sta *sta)
+	     struct ieee80211_sta *sta, bool ext_phy)
 {
 	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
 	int ret;
@@ -853,6 +853,8 @@ mt76_sta_add(struct mt76_dev *dev, struct ieee80211_vif *vif,
 	}
 
 	ewma_signal_init(&wcid->rssi);
+	if (ext_phy)
+		mt76_wcid_mask_set(dev->wcid_phy_mask, wcid->idx);
 	rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
 
 out:
@@ -879,7 +881,8 @@ void __mt76_sta_remove(struct mt76_dev *dev, struct ieee80211_vif *vif,
 	mt76_tx_status_check(dev, wcid, true);
 	for (i = 0; i < ARRAY_SIZE(sta->txq); i++)
 		mt76_txq_remove(dev, sta->txq[i]);
-	mt76_wcid_free(dev->wcid_mask, idx);
+	mt76_wcid_mask_clear(dev->wcid_mask, idx);
+	mt76_wcid_mask_clear(dev->wcid_phy_mask, idx);
 }
 EXPORT_SYMBOL_GPL(__mt76_sta_remove);
 
@@ -897,11 +900,13 @@ int mt76_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		   enum ieee80211_sta_state old_state,
 		   enum ieee80211_sta_state new_state)
 {
-	struct mt76_dev *dev = hw->priv;
+	struct mt76_phy *phy = hw->priv;
+	struct mt76_dev *dev = phy->dev;
+	bool ext_phy = phy != &dev->phy;
 
 	if (old_state == IEEE80211_STA_NOTEXIST &&
 	    new_state == IEEE80211_STA_NONE)
-		return mt76_sta_add(dev, vif, sta);
+		return mt76_sta_add(dev, vif, sta, ext_phy);
 
 	if (old_state == IEEE80211_STA_AUTH &&
 	    new_state == IEEE80211_STA_ASSOC &&
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 4c0fe88155e5..8be709e1c8c3 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -504,6 +504,7 @@ struct mt76_dev {
 	struct sk_buff_head status_list;
 
 	unsigned long wcid_mask[MT76_N_WCIDS / BITS_PER_LONG];
+	unsigned long wcid_phy_mask[MT76_N_WCIDS / BITS_PER_LONG];
 
 	struct mt76_wcid global_wcid;
 	struct mt76_wcid __rcu *wcid[MT76_N_WCIDS];
@@ -596,6 +597,16 @@ enum mt76_phy_type {
 
 #define mt76_hw(dev) (dev)->mphy.hw
 
+static inline struct ieee80211_hw *
+mt76_wcid_hw(struct mt76_dev *dev, u8 wcid)
+{
+	if (wcid <= MT76_N_WCIDS &&
+	    mt76_wcid_mask_test(dev->wcid_phy_mask, wcid))
+		return dev->phy2->hw;
+
+	return dev->phy.hw;
+}
+
 bool __mt76_poll(struct mt76_dev *dev, u32 offset, u32 mask, u32 val,
 		 int timeout);
 
diff --git a/drivers/net/wireless/mediatek/mt76/util.h b/drivers/net/wireless/mediatek/mt76/util.h
index fe3479c8e561..48a71e7479e5 100644
--- a/drivers/net/wireless/mediatek/mt76/util.h
+++ b/drivers/net/wireless/mediatek/mt76/util.h
@@ -16,8 +16,20 @@
 
 int mt76_wcid_alloc(unsigned long *mask, int size);
 
+static inline bool
+mt76_wcid_mask_test(unsigned long *mask, int idx)
+{
+	return mask[idx / BITS_PER_LONG] & BIT(idx % BITS_PER_LONG);
+}
+
+static inline void
+mt76_wcid_mask_set(unsigned long *mask, int idx)
+{
+	mask[idx / BITS_PER_LONG] |= BIT(idx % BITS_PER_LONG);
+}
+
 static inline void
-mt76_wcid_free(unsigned long *mask, int idx)
+mt76_wcid_mask_clear(unsigned long *mask, int idx)
 {
 	mask[idx / BITS_PER_LONG] &= ~BIT(idx % BITS_PER_LONG);
 }
-- 
2.24.0

