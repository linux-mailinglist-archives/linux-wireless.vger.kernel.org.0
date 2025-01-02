Return-Path: <linux-wireless+bounces-16998-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C3F219FFBD4
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:36:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C4BA918839AC
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:36:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AA9017BED0;
	Thu,  2 Jan 2025 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Sg/t4MNN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC8261531DC
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835722; cv=none; b=ESVO0vIjB2UpFlblprQhj0Yw/HA9llh294+z7PcwkUXATsWiYndn3hNx2cbVEBeHRc7tunSjLkXXzCzCW7miJTLWkHfMhR3gHxuUCZvr7WoQnxjemDotY6gb29DftApqdy7KGUDJU2/ovtSQZdBgXlbWMejqq0riLMAaUX5aJzA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835722; c=relaxed/simple;
	bh=x9yX45C4W67MkeRBHnBYEjsl8jpSdjjKWQeQQ63z4jg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=dJrbH1C9XsviVgAuJHtTJR27Y4+vLbx7hZ9vzrv0NIWowlybo9JW5iJVQfM1rt30bCEv4gyRSrbHB9kAdLpZo+XsI6E6fNqn6FiWTGy1vRbgeEpMBLk3jkEOGDa4JM0nOgi4o8xA0qyAvccQ1ZAN06QIg1dhe1b5mop3LSsKVpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Sg/t4MNN; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:Message-ID:Date:Subject:
	Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=GbaAbgFpcCsTpusAE0VaTWFfZElBJVjpXutfjrbZI/o=; b=Sg/t4MNNZLIlMNm2DzRO+y/2KN
	mLaw+DaMgxgwCBk8UKHNfpq/c7VOpyJLmGHCGPvByKTn2/mrjsL7POIctNu94RPw7QudJ8LwIkmS1
	FNRBcn7G48qa21xbkkH8IyRaV1zl8C6xHl90261icS+579m+v4fNdMZB/AYG7gqUPiyE=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAB-0008GS-1r;
	Thu, 02 Jan 2025 17:35:11 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: Peter Chiu <chui-hao.chiu@mediatek.com>,
	Michael-CY Lee <michael-cy.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>
Subject: [PATCH 01/24] wifi: mt76: add code for emulating hardware scanning
Date: Thu,  2 Jan 2025 17:34:45 +0100
Message-ID: <20250102163508.52945-1-nbd@nbd.name>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Preparation for supporting multiple radios on a single wiphy on devices
where firmware does not support actual hardware scanning.
This is also a prerequisite for full MLO support

Co-developed-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Signed-off-by: Peter Chiu <chui-hao.chiu@mediatek.com>
Co-developed-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
Signed-off-by: Michael-CY Lee <michael-cy.lee@mediatek.com>
Co-developed-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Shayne Chen <shayne.chen@mediatek.com>
Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/Makefile   |   2 +-
 drivers/net/wireless/mediatek/mt76/mac80211.c |  20 ++-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  20 ++-
 .../net/wireless/mediatek/mt76/mt7615/main.c  |   1 +
 .../net/wireless/mediatek/mt76/mt76x02_mmio.c |   2 +-
 .../net/wireless/mediatek/mt76/mt7915/main.c  |   1 +
 .../net/wireless/mediatek/mt76/mt7996/main.c  |   1 +
 drivers/net/wireless/mediatek/mt76/scan.c     | 153 ++++++++++++++++++
 8 files changed, 189 insertions(+), 11 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/scan.c

diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index f7f2d9a8ab0f..f6e4de9334bf 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_MT792x_USB) += mt792x-usb.o
 
 mt76-y := \
 	mmio.o util.o trace.o dma.o mac80211.o debugfs.o eeprom.o \
-	tx.o agg-rx.o mcu.o wed.o
+	tx.o agg-rx.o mcu.o wed.o scan.o
 
 mt76-$(CONFIG_PCI) += pci.o
 mt76-$(CONFIG_NL80211_TESTMODE) += testmode.o
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 6db59652be6e..69fcea08e3fd 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -690,6 +690,7 @@ mt76_alloc_device(struct device *pdev, unsigned int size,
 	INIT_LIST_HEAD(&dev->txwi_cache);
 	INIT_LIST_HEAD(&dev->rxwi_cache);
 	dev->token_size = dev->drv->token_size;
+	INIT_DELAYED_WORK(&dev->scan_work, mt76_scan_work);
 
 	for (i = 0; i < ARRAY_SIZE(dev->q_rx); i++)
 		skb_queue_head_init(&dev->rx_skb[i]);
@@ -954,9 +955,9 @@ int mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
 	phy->offchannel = offchannel;
 
 	if (!offchannel)
-		phy->main_chan = chandef->chan;
+		phy->main_chandef = *chandef;
 
-	if (chandef->chan != phy->main_chan)
+	if (chandef->chan != phy->main_chandef.chan)
 		memset(phy->chan_state, 0, sizeof(*phy->chan_state));
 
 	ret = dev->drv->set_channel(phy);
@@ -1021,7 +1022,7 @@ int mt76_get_survey(struct ieee80211_hw *hw, int idx,
 	if (state->noise)
 		survey->filled |= SURVEY_INFO_NOISE_DBM;
 
-	if (chan == phy->main_chan) {
+	if (chan == phy->main_chandef.chan) {
 		survey->filled |= SURVEY_INFO_IN_USE;
 
 		if (dev->drv->drv_flags & MT_DRV_SW_RX_AIRTIME)
@@ -1466,6 +1467,7 @@ mt76_sta_add(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		mt76_wcid_mask_set(dev->wcid_phy_mask, wcid->idx);
 	wcid->phy_idx = phy->band_idx;
 	rcu_assign_pointer(dev->wcid[wcid->idx], wcid);
+	phy->num_sta++;
 
 	mt76_wcid_init(wcid);
 out:
@@ -1474,9 +1476,10 @@ mt76_sta_add(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	return ret;
 }
 
-void __mt76_sta_remove(struct mt76_dev *dev, struct ieee80211_vif *vif,
+void __mt76_sta_remove(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta)
 {
+	struct mt76_dev *dev = phy->dev;
 	struct mt76_wcid *wcid = (struct mt76_wcid *)sta->drv_priv;
 	int i, idx = wcid->idx;
 
@@ -1490,15 +1493,18 @@ void __mt76_sta_remove(struct mt76_dev *dev, struct ieee80211_vif *vif,
 
 	mt76_wcid_mask_clear(dev->wcid_mask, idx);
 	mt76_wcid_mask_clear(dev->wcid_phy_mask, idx);
+	phy->num_sta--;
 }
 EXPORT_SYMBOL_GPL(__mt76_sta_remove);
 
 static void
-mt76_sta_remove(struct mt76_dev *dev, struct ieee80211_vif *vif,
+mt76_sta_remove(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		struct ieee80211_sta *sta)
 {
+	struct mt76_dev *dev = phy->dev;
+
 	mutex_lock(&dev->mutex);
-	__mt76_sta_remove(dev, vif, sta);
+	__mt76_sta_remove(phy, vif, sta);
 	mutex_unlock(&dev->mutex);
 }
 
@@ -1517,7 +1523,7 @@ int mt76_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	if (old_state == IEEE80211_STA_NONE &&
 	    new_state == IEEE80211_STA_NOTEXIST)
-		mt76_sta_remove(dev, vif, sta);
+		mt76_sta_remove(phy, vif, sta);
 
 	if (!dev->drv->sta_event)
 		return 0;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 34b6b094b8eb..b649039f384b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -765,6 +765,7 @@ struct mt76_vif {
 	u8 mcast_rates_idx;
 	u8 beacon_rates_idx;
 	struct ieee80211_chanctx_conf *ctx;
+	struct mt76_wcid *wcid;
 };
 
 struct mt76_phy {
@@ -773,6 +774,7 @@ struct mt76_phy {
 	void *priv;
 
 	unsigned long state;
+	unsigned int num_sta;
 	u8 band_idx;
 
 	spinlock_t tx_lock;
@@ -780,7 +782,7 @@ struct mt76_phy {
 	struct mt76_queue *q_tx[__MT_TXQ_MAX];
 
 	struct cfg80211_chan_def chandef;
-	struct ieee80211_channel *main_chan;
+	struct cfg80211_chan_def main_chandef;
 	bool offchannel;
 
 	struct mt76_channel_state *chan_state;
@@ -910,6 +912,15 @@ struct mt76_dev {
 
 	u32 rxfilter;
 
+	struct delayed_work scan_work;
+	struct {
+		struct cfg80211_scan_request *req;
+		struct ieee80211_channel *chan;
+		struct ieee80211_vif *vif;
+		struct mt76_phy *phy;
+		int chan_idx;
+	} scan;
+
 #ifdef CONFIG_NL80211_TESTMODE
 	const struct mt76_testmode_ops *test_ops;
 	struct {
@@ -1422,7 +1433,7 @@ int mt76_sta_state(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		   struct ieee80211_sta *sta,
 		   enum ieee80211_sta_state old_state,
 		   enum ieee80211_sta_state new_state);
-void __mt76_sta_remove(struct mt76_dev *dev, struct ieee80211_vif *vif,
+void __mt76_sta_remove(struct mt76_phy *phy, struct ieee80211_vif *vif,
 		       struct ieee80211_sta *sta);
 void mt76_sta_pre_rcu_remove(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 			     struct ieee80211_sta *sta);
@@ -1446,6 +1457,9 @@ void mt76_insert_ccmp_hdr(struct sk_buff *skb, u8 key_id);
 int mt76_get_rate(struct mt76_dev *dev,
 		  struct ieee80211_supported_band *sband,
 		  int idx, bool cck);
+int mt76_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		 struct ieee80211_scan_request *hw_req);
+void mt76_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif);
 void mt76_sw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		  const u8 *mac);
 void mt76_sw_scan_complete(struct ieee80211_hw *hw,
@@ -1498,6 +1512,8 @@ void mt76_queue_tx_complete(struct mt76_dev *dev, struct mt76_queue *q,
 			    struct mt76_queue_entry *e);
 int mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
 		     bool offchannel);
+void mt76_scan_work(struct work_struct *work);
+void mt76_abort_scan(struct mt76_dev *dev);
 
 /* usb */
 static inline bool mt76u_urb_error(struct urb *urb)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/main.c b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
index 376975388007..646474aa828d 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/main.c
@@ -209,6 +209,7 @@ static int mt7615_add_interface(struct ieee80211_hw *hw,
 
 	mvif->mt76.band_idx = ext_phy;
 	mvif->mt76.wmm_idx = vif->type != NL80211_IFTYPE_AP;
+	mvif->mt76.wcid = &mvif->sta.wcid;
 	if (ext_phy)
 		mvif->mt76.wmm_idx += 2;
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
index 4a49a3036a46..7d840ad4ae65 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76x02_mmio.c
@@ -423,7 +423,7 @@ static void mt76x02_reset_state(struct mt76x02_dev *dev)
 		priv = msta->vif;
 		vif = container_of(priv, struct ieee80211_vif, drv_priv);
 
-		__mt76_sta_remove(&dev->mt76, vif, sta);
+		__mt76_sta_remove(&dev->mphy, vif, sta);
 		memset(msta, 0, sizeof(*msta));
 	}
 
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/main.c b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
index fd337aede99e..565d22019aac 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/main.c
@@ -233,6 +233,7 @@ static int mt7915_add_interface(struct ieee80211_hw *hw,
 	mvif->mt76.omac_idx = idx;
 	mvif->phy = phy;
 	mvif->mt76.band_idx = phy->mt76->band_idx;
+	mvif->mt76.wcid = &mvif->sta.wcid;
 
 	mvif->mt76.wmm_idx = vif->type != NL80211_IFTYPE_AP;
 	if (ext_phy)
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index a1f091dff26a..f3ca01899503 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -203,6 +203,7 @@ static int mt7996_add_interface(struct ieee80211_hw *hw,
 	mvif->phy = phy;
 	mvif->mt76.band_idx = band_idx;
 	mvif->mt76.wmm_idx = vif->type == NL80211_IFTYPE_AP ? 0 : 3;
+	mvif->mt76.wcid = &mvif->sta.wcid;
 
 	ret = mt7996_mcu_add_dev_info(phy, vif, true);
 	if (ret)
diff --git a/drivers/net/wireless/mediatek/mt76/scan.c b/drivers/net/wireless/mediatek/mt76/scan.c
new file mode 100644
index 000000000000..79172ad3fa6e
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/scan.c
@@ -0,0 +1,153 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2024 Felix Fietkau <nbd@nbd.name>
+ */
+#include "mt76.h"
+
+static void mt76_scan_complete(struct mt76_dev *dev, bool abort)
+{
+	struct mt76_phy *phy = dev->scan.phy;
+	struct cfg80211_scan_info info = {
+		.aborted = abort,
+	};
+
+	if (!phy)
+		return;
+
+	clear_bit(MT76_SCANNING, &phy->state);
+
+	if (dev->scan.chan && phy->main_chandef.chan)
+		mt76_set_channel(phy, &phy->main_chandef, false);
+	memset(&dev->scan, 0, sizeof(dev->scan));
+	ieee80211_scan_completed(phy->hw, &info);
+}
+
+void mt76_abort_scan(struct mt76_dev *dev)
+{
+	cancel_delayed_work_sync(&dev->scan_work);
+	mt76_scan_complete(dev, true);
+}
+
+static void
+mt76_scan_send_probe(struct mt76_dev *dev, struct cfg80211_ssid *ssid)
+{
+	struct cfg80211_scan_request *req = dev->scan.req;
+	struct ieee80211_vif *vif = dev->scan.vif;
+	struct mt76_vif *mvif = (struct mt76_vif *)vif->drv_priv;
+	enum nl80211_band band = dev->scan.chan->band;
+	struct mt76_phy *phy = dev->scan.phy;
+	struct ieee80211_tx_info *info;
+	struct sk_buff *skb;
+
+	skb = ieee80211_probereq_get(phy->hw, vif->addr, ssid->ssid,
+				     ssid->ssid_len, req->ie_len);
+	if (!skb)
+		return;
+
+	if (is_unicast_ether_addr(req->bssid)) {
+		struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)skb->data;
+
+		ether_addr_copy(hdr->addr1, req->bssid);
+		ether_addr_copy(hdr->addr3, req->bssid);
+	}
+
+	info = IEEE80211_SKB_CB(skb);
+	if (req->no_cck)
+		info->flags |= IEEE80211_TX_CTL_NO_CCK_RATE;
+	info->control.flags |= IEEE80211_TX_CTRL_DONT_USE_RATE_MASK;
+
+	if (req->ie_len)
+		skb_put_data(skb, req->ie, req->ie_len);
+
+	skb->priority = 7;
+	skb_set_queue_mapping(skb, IEEE80211_AC_VO);
+
+	rcu_read_lock();
+	if (ieee80211_tx_prepare_skb(phy->hw, vif, skb, band, NULL))
+		mt76_tx(phy, NULL, mvif->wcid, skb);
+	else
+		ieee80211_free_txskb(phy->hw, skb);
+	rcu_read_unlock();
+}
+
+void mt76_scan_work(struct work_struct *work)
+{
+	struct mt76_dev *dev = container_of(work, struct mt76_dev,
+					    scan_work.work);
+	struct cfg80211_scan_request *req = dev->scan.req;
+	struct cfg80211_chan_def chandef = {};
+	struct mt76_phy *phy = dev->scan.phy;
+	int duration = HZ / 9; /* ~110 ms */
+	int i;
+
+	if (dev->scan.chan_idx >= req->n_channels) {
+		mt76_scan_complete(dev, false);
+		return;
+	}
+
+	if (dev->scan.chan && phy->num_sta) {
+		dev->scan.chan = NULL;
+		mt76_set_channel(phy, &phy->main_chandef, false);
+		goto out;
+	}
+
+	dev->scan.chan = req->channels[dev->scan.chan_idx++];
+	cfg80211_chandef_create(&chandef, dev->scan.chan, NL80211_CHAN_HT20);
+	mt76_set_channel(phy, &chandef, true);
+
+	if (!req->n_ssids ||
+	    chandef.chan->flags & (IEEE80211_CHAN_NO_IR | IEEE80211_CHAN_RADAR))
+		goto out;
+
+	duration = HZ / 16; /* ~60 ms */
+	local_bh_disable();
+	for (i = 0; i < req->n_ssids; i++)
+		mt76_scan_send_probe(dev, &req->ssids[i]);
+	local_bh_enable();
+
+out:
+	if (!duration)
+		return;
+
+	if (dev->scan.chan)
+		duration = max_t(int, duration,
+			         msecs_to_jiffies(req->duration +
+						  (req->duration >> 5)));
+
+	ieee80211_queue_delayed_work(dev->phy.hw, &dev->scan_work, duration);
+}
+
+int mt76_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+		 struct ieee80211_scan_request *req)
+{
+	struct mt76_phy *phy = hw->priv;
+	struct mt76_dev *dev = phy->dev;
+	int ret = 0;
+
+	mutex_lock(&dev->mutex);
+
+	if (dev->scan.req) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	memset(&dev->scan, 0, sizeof(dev->scan));
+	dev->scan.req = &req->req;
+	dev->scan.vif = vif;
+	dev->scan.phy = phy;
+	ieee80211_queue_delayed_work(dev->phy.hw, &dev->scan_work, 0);
+
+out:
+	mutex_unlock(&dev->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt76_hw_scan);
+
+void mt76_cancel_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif)
+{
+	struct mt76_phy *phy = hw->priv;
+
+	mt76_abort_scan(phy->dev);
+}
+EXPORT_SYMBOL_GPL(mt76_cancel_hw_scan);
-- 
2.47.1


