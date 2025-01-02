Return-Path: <linux-wireless+bounces-17016-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2EAE29FFBE4
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 86A777A1AD3
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AE4E188587;
	Thu,  2 Jan 2025 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="d6kXICVD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85F815C13A
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835728; cv=none; b=OaBbTju1piMoh71w/6K0PZmgab2PSk+rFGjhhIP7GnWbnFqCYWuqFyGbwwnVn7PPYcqt/D7QtTxFmBkESWNcVFsVLbYq4+mSJxLa3T3s+94uBHyR/ib2lTjru05h5RDLKZIGagUYgvr6umy4dj6foPrrcuhAavQSunWZ112ZxfE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835728; c=relaxed/simple;
	bh=+OntNVOZwR8h4AS9uQnle7bEUvwiEA3ES24vc3K+f4Q=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LAM35/oJB8zJut5oQPXZjQmkSVjmHYKOk+BiuFGxIib3zpWzI1DY7y/PceLgvz/bRrXBr9l/v0qRyeOIvog+MI20ZU/T4JrskPdhfOOiehewlzEc87340TxJaY5gKHkp+gxVGEINpYljkPbuYzMGy72y0C9qD2creWQOIrwn7oI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=d6kXICVD; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=7CH0uX9srTwe8DgkLJ2e5KZygrm/XWanP/NwEhmmdr0=; b=d6kXICVDOXAHE8b2oxTDdmsgtz
	bpxIePyIodnL3sHkKEzYrCFdfjVVcJi1tHRbY/uKJJNw+Zvqy+lH4XtV/sdbHLl0gGNTvhElvdSJA
	y01ToNnYexy3F0gfORHqTTWJxLCBC7nYx1AuCagDkh+TS1q0ibPSn23bWuwqopTnwcnw=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAD-0008GS-11
	for linux-wireless@vger.kernel.org;
	Thu, 02 Jan 2025 17:35:13 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 12/24] wifi: mt76: add multi-radio remain_on_channel functions
Date: Thu,  2 Jan 2025 17:34:56 +0100
Message-ID: <20250102163508.52945-12-nbd@nbd.name>
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

This allows a driver using the generic channel context functions to
temporarily switch to another channel for off-channel rx/tx.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/channel.c  | 96 +++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mac80211.c |  3 +
 drivers/net/wireless/mediatek/mt76/mt76.h     | 12 +++
 drivers/net/wireless/mediatek/mt76/scan.c     |  2 +-
 4 files changed, 112 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/mediatek/mt76/channel.c b/drivers/net/wireless/mediatek/mt76/channel.c
index 541b32cb1f65..455c30700475 100644
--- a/drivers/net/wireless/mediatek/mt76/channel.c
+++ b/drivers/net/wireless/mediatek/mt76/channel.c
@@ -280,3 +280,99 @@ void mt76_put_vif_phy_link(struct mt76_phy *phy, struct ieee80211_vif *vif,
 	dev->drv->vif_link_remove(phy, vif, &vif->bss_conf, mlink);
 	kfree(mlink);
 }
+
+static void mt76_roc_complete(struct mt76_phy *phy)
+{
+	struct mt76_vif_link *mlink = phy->roc_link;
+
+	if (!phy->roc_vif)
+		return;
+
+	if (mlink)
+		mlink->mvif->roc_phy = NULL;
+	if (phy->main_chandef.chan)
+		mt76_set_channel(phy, &phy->main_chandef, false);
+	mt76_put_vif_phy_link(phy, phy->roc_vif, phy->roc_link);
+	phy->roc_vif = NULL;
+	phy->roc_link = NULL;
+	ieee80211_remain_on_channel_expired(phy->hw);
+}
+
+void mt76_roc_complete_work(struct work_struct *work)
+{
+	struct mt76_phy *phy = container_of(work, struct mt76_phy, roc_work.work);
+	struct mt76_dev *dev = phy->dev;
+
+	mutex_lock(&dev->mutex);
+	mt76_roc_complete(phy);
+	mutex_unlock(&dev->mutex);
+}
+
+void mt76_abort_roc(struct mt76_phy *phy)
+{
+	struct mt76_dev *dev = phy->dev;
+
+	cancel_delayed_work_sync(&phy->roc_work);
+
+	mutex_lock(&dev->mutex);
+	mt76_roc_complete(phy);
+	mutex_unlock(&dev->mutex);
+}
+
+int mt76_remain_on_channel(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			   struct ieee80211_channel *chan, int duration,
+			   enum ieee80211_roc_type type)
+{
+	struct cfg80211_chan_def chandef = {};
+	struct mt76_phy *phy = hw->priv;
+	struct mt76_dev *dev = phy->dev;
+	struct mt76_vif_link *mlink;
+	int ret = 0;
+
+	phy = dev->band_phys[chan->band];
+	if (!phy)
+		return -EINVAL;
+
+	mutex_lock(&dev->mutex);
+
+	if (phy->roc_vif || dev->scan.phy == phy) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	mlink = mt76_get_vif_phy_link(phy, vif);
+	if (IS_ERR(mlink)) {
+		ret = PTR_ERR(mlink);
+		goto out;
+	}
+
+	mlink->mvif->roc_phy = phy;
+	phy->roc_vif = vif;
+	phy->roc_link = mlink;
+	cfg80211_chandef_create(&chandef, chan, NL80211_CHAN_HT20);
+	mt76_set_channel(phy, &chandef, true);
+	ieee80211_ready_on_channel(hw);
+	ieee80211_queue_delayed_work(phy->hw, &phy->roc_work,
+				     msecs_to_jiffies(duration));
+
+out:
+	mutex_unlock(&dev->mutex);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt76_remain_on_channel);
+
+int mt76_cancel_remain_on_channel(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif)
+{
+	struct mt76_vif_link *mlink = (struct mt76_vif_link *)vif->drv_priv;
+	struct mt76_vif_data *mvif = mlink->mvif;
+	struct mt76_phy *phy = mvif->roc_phy;
+
+	if (!phy)
+		return 0;
+
+	mt76_abort_roc(phy);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(mt76_cancel_remain_on_channel);
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 1d5abe40b0c3..cea5c70cfc23 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -431,6 +431,7 @@ mt76_phy_init(struct mt76_phy *phy, struct ieee80211_hw *hw)
 
 	INIT_LIST_HEAD(&phy->tx_list);
 	spin_lock_init(&phy->tx_lock);
+	INIT_DELAYED_WORK(&phy->roc_work, mt76_roc_complete_work);
 
 	if ((void *)phy != hw->priv)
 		return 0;
@@ -1998,5 +1999,7 @@ void mt76_vif_cleanup(struct mt76_dev *dev, struct ieee80211_vif *vif)
 
 	rcu_assign_pointer(mvif->link[0], NULL);
 	mt76_abort_scan(dev);
+	if (mvif->roc_phy)
+		mt76_abort_roc(mvif->roc_phy);
 }
 EXPORT_SYMBOL_GPL(mt76_vif_cleanup);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index b61f1eb138e8..132148f7b107 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -787,6 +787,7 @@ struct mt76_vif_link {
 struct mt76_vif_data {
 	struct mt76_vif_link __rcu *link[IEEE80211_MLD_MAX_NUM_LINKS];
 
+	struct mt76_phy *roc_phy;
 	u16 valid_links;
 	u8 deflink_id;
 };
@@ -809,6 +810,10 @@ struct mt76_phy {
 	bool offchannel;
 	bool radar_enabled;
 
+	struct delayed_work roc_work;
+	struct ieee80211_vif *roc_vif;
+	struct mt76_vif_link *roc_link;
+
 	struct mt76_chanctx *chanctx;
 
 	struct mt76_channel_state *chan_state;
@@ -1521,6 +1526,11 @@ int mt76_switch_vif_chanctx(struct ieee80211_hw *hw,
 			    struct ieee80211_vif_chanctx_switch *vifs,
 			    int n_vifs,
 			    enum ieee80211_chanctx_switch_mode mode);
+int mt76_remain_on_channel(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
+			   struct ieee80211_channel *chan, int duration,
+			   enum ieee80211_roc_type type);
+int mt76_cancel_remain_on_channel(struct ieee80211_hw *hw,
+				  struct ieee80211_vif *vif);
 int mt76_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		      void *data, int len);
 int mt76_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *skb,
@@ -1572,6 +1582,8 @@ int mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
 		     bool offchannel);
 void mt76_scan_work(struct work_struct *work);
 void mt76_abort_scan(struct mt76_dev *dev);
+void mt76_roc_complete_work(struct work_struct *work);
+void mt76_abort_roc(struct mt76_phy *phy);
 struct mt76_vif_link *mt76_get_vif_phy_link(struct mt76_phy *phy,
 					    struct ieee80211_vif *vif);
 void mt76_put_vif_phy_link(struct mt76_phy *phy, struct ieee80211_vif *vif,
diff --git a/drivers/net/wireless/mediatek/mt76/scan.c b/drivers/net/wireless/mediatek/mt76/scan.c
index 9f3485be5747..1c4f9deaaada 100644
--- a/drivers/net/wireless/mediatek/mt76/scan.c
+++ b/drivers/net/wireless/mediatek/mt76/scan.c
@@ -134,7 +134,7 @@ int mt76_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 
 	mutex_lock(&dev->mutex);
 
-	if (dev->scan.req) {
+	if (dev->scan.req || phy->roc_vif) {
 		ret = -EBUSY;
 		goto out;
 	}
-- 
2.47.1


