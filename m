Return-Path: <linux-wireless+bounces-16999-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6DDCF9FFBD5
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5DB1615FA
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:36:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4F89717C7B1;
	Thu,  2 Jan 2025 16:35:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="E1kXsTkX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC71B1311AC
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835722; cv=none; b=ctHsiKhlj7RH9lBKGFvgUKF0UaTbQa5zlCA85WHlDo50gNq0SYKihw9XfhsUm8JYdfiqm7a2HTwiSPSZVThA61YtFaS9tMlS3WKGXVT+ov1M/ilTgf2jev+Tae4zRU8rX1VPR7m4dR38PqAakAlUkbDwhnuuc3DFMHz1Xf5nyHs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835722; c=relaxed/simple;
	bh=yNgH5l34X3VpOJp/ztHcYAKMw946GcfUaAawl0Kb7Ek=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OnwqnwNXMLcGPhslpFfCVs7cdLsBr/0bZJBJubjMcoogvgROLKh/6qOrVEchxj/qSzKI2cl7u+6AuxV40IZYQ0/SOHFnYmMB2tJqml8ZRE4NvGtDWIXrV9FkINel+11n6nmJU4a9NZyT3Et14ihkjD6dkatyN8aiqUHEniTqhhQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=E1kXsTkX; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=j4/LBmCmK1wXA/0inO78cuEa6LGJ6+0N4ZOW0k017U8=; b=E1kXsTkXV54KA/6ildujsCLoPD
	4oUFpfsdoWlngAIYCfIDAQeh+qvtJwfuKGjDGc3xNEgVLslmk8TQfHENvHVtYLxSKRxoeKtDrqSYC
	hyyqKgOhtFBq/GP8c8VCmIC8z/svDl9As/D//IYQAKcjSdvvuoAmqtaou5Gp5EzDRqDs=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAC-0008GS-1m
	for linux-wireless@vger.kernel.org;
	Thu, 02 Jan 2025 17:35:12 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 07/24] wifi: mt76: add chanctx functions for multi-channel phy support
Date: Thu,  2 Jan 2025 17:34:51 +0100
Message-ID: <20250102163508.52945-7-nbd@nbd.name>
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

This adds an implementation for the chanctx functions, which can be used
by multi-channel capable drivers. Preparation for adding MLO support.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/Makefile   |   2 +-
 drivers/net/wireless/mediatek/mt76/channel.c  | 222 ++++++++++++++++++
 drivers/net/wireless/mediatek/mt76/mac80211.c |  35 ++-
 drivers/net/wireless/mediatek/mt76/mt76.h     |  64 ++++-
 drivers/net/wireless/mediatek/mt76/scan.c     |   6 +
 5 files changed, 314 insertions(+), 15 deletions(-)
 create mode 100644 drivers/net/wireless/mediatek/mt76/channel.c

diff --git a/drivers/net/wireless/mediatek/mt76/Makefile b/drivers/net/wireless/mediatek/mt76/Makefile
index f6e4de9334bf..87512d101a91 100644
--- a/drivers/net/wireless/mediatek/mt76/Makefile
+++ b/drivers/net/wireless/mediatek/mt76/Makefile
@@ -10,7 +10,7 @@ obj-$(CONFIG_MT792x_USB) += mt792x-usb.o
 
 mt76-y := \
 	mmio.o util.o trace.o dma.o mac80211.o debugfs.o eeprom.o \
-	tx.o agg-rx.o mcu.o wed.o scan.o
+	tx.o agg-rx.o mcu.o wed.o scan.o channel.o
 
 mt76-$(CONFIG_PCI) += pci.o
 mt76-$(CONFIG_NL80211_TESTMODE) += testmode.o
diff --git a/drivers/net/wireless/mediatek/mt76/channel.c b/drivers/net/wireless/mediatek/mt76/channel.c
new file mode 100644
index 000000000000..a577a01e4cc2
--- /dev/null
+++ b/drivers/net/wireless/mediatek/mt76/channel.c
@@ -0,0 +1,222 @@
+// SPDX-License-Identifier: ISC
+/*
+ * Copyright (C) 2024 Felix Fietkau <nbd@nbd.name>
+ */
+#include "mt76.h"
+
+static int
+mt76_phy_update_channel(struct mt76_phy *phy,
+			struct ieee80211_chanctx_conf *conf)
+{
+	phy->radar_enabled = conf->radar_enabled;
+	phy->main_chandef = conf->def;
+	phy->chanctx = (struct mt76_chanctx *)conf->drv_priv;
+
+	return __mt76_set_channel(phy, &phy->main_chandef, false);
+}
+
+int mt76_add_chanctx(struct ieee80211_hw *hw,
+		     struct ieee80211_chanctx_conf *conf)
+{
+	struct mt76_chanctx *ctx = (struct mt76_chanctx *)conf->drv_priv;
+	struct mt76_phy *phy = hw->priv;
+	struct mt76_dev *dev = phy->dev;
+	int ret = -EINVAL;
+
+	phy = ctx->phy = dev->band_phys[conf->def.chan->band];
+	if (WARN_ON_ONCE(!phy))
+		return ret;
+
+	if (dev->scan.phy == phy)
+		mt76_abort_scan(dev);
+
+	mutex_lock(&dev->mutex);
+	if (!phy->chanctx)
+		ret = mt76_phy_update_channel(phy, conf);
+	else
+		ret = 0;
+	mutex_unlock(&dev->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt76_add_chanctx);
+
+void mt76_remove_chanctx(struct ieee80211_hw *hw,
+			 struct ieee80211_chanctx_conf *conf)
+{
+	struct mt76_chanctx *ctx = (struct mt76_chanctx *)conf->drv_priv;
+	struct mt76_phy *phy = hw->priv;
+	struct mt76_dev *dev = phy->dev;
+
+	phy = ctx->phy;
+	if (WARN_ON_ONCE(!phy))
+		return;
+
+	if (dev->scan.phy == phy)
+		mt76_abort_scan(dev);
+
+	mutex_lock(&dev->mutex);
+	if (phy->chanctx == ctx)
+		phy->chanctx = NULL;
+	mutex_unlock(&dev->mutex);
+}
+EXPORT_SYMBOL_GPL(mt76_remove_chanctx);
+
+void mt76_change_chanctx(struct ieee80211_hw *hw,
+			 struct ieee80211_chanctx_conf *conf,
+			 u32 changed)
+{
+	struct mt76_chanctx *ctx = (struct mt76_chanctx *)conf->drv_priv;
+	struct mt76_phy *phy = ctx->phy;
+	struct mt76_dev *dev = phy->dev;
+
+	if (!(changed & (IEEE80211_CHANCTX_CHANGE_WIDTH |
+			 IEEE80211_CHANCTX_CHANGE_RADAR)))
+		return;
+
+	cancel_delayed_work_sync(&phy->mac_work);
+
+	mutex_lock(&dev->mutex);
+	mt76_phy_update_channel(phy, conf);
+	mutex_unlock(&dev->mutex);
+}
+EXPORT_SYMBOL_GPL(mt76_change_chanctx);
+
+
+int mt76_assign_vif_chanctx(struct ieee80211_hw *hw,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link_conf,
+			    struct ieee80211_chanctx_conf *conf)
+{
+	struct mt76_chanctx *ctx = (struct mt76_chanctx *)conf->drv_priv;
+	struct mt76_vif_link *mlink = (struct mt76_vif_link *)vif->drv_priv;
+	struct mt76_vif_data *mvif = mlink->mvif;
+	int link_id = link_conf->link_id;
+	struct mt76_phy *phy = ctx->phy;
+	struct mt76_dev *dev = phy->dev;
+	bool mlink_alloc = false;
+	int ret = 0;
+
+	if (dev->scan.vif == vif)
+		mt76_abort_scan(dev);
+
+	mutex_lock(&dev->mutex);
+
+	if (vif->type == NL80211_IFTYPE_MONITOR &&
+	    is_zero_ether_addr(vif->addr))
+		goto out;
+
+	mlink = mt76_vif_conf_link(dev, vif, link_conf);
+	if (!mlink) {
+		mlink = kzalloc(dev->drv->link_data_size, GFP_KERNEL);
+		if (!mlink) {
+			ret = -ENOMEM;
+			goto out;
+		}
+		mlink_alloc = true;
+	}
+
+	mlink->ctx = conf;
+	ret = dev->drv->vif_link_add(phy, vif, link_conf, mlink);
+	if (ret) {
+		if (mlink_alloc)
+			kfree(mlink);
+		goto out;
+	}
+
+	if (link_conf != &vif->bss_conf)
+		rcu_assign_pointer(mvif->link[link_id], mlink);
+
+out:
+	mutex_unlock(&dev->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt76_assign_vif_chanctx);
+
+void mt76_unassign_vif_chanctx(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       struct ieee80211_bss_conf *link_conf,
+			       struct ieee80211_chanctx_conf *conf)
+{
+	struct mt76_chanctx *ctx = (struct mt76_chanctx *)conf->drv_priv;
+	struct mt76_vif_link *mlink = (struct mt76_vif_link *)vif->drv_priv;
+	struct mt76_vif_data *mvif = mlink->mvif;
+	int link_id = link_conf->link_id;
+	struct mt76_phy *phy = ctx->phy;
+	struct mt76_dev *dev = phy->dev;
+
+	if (dev->scan.vif == vif)
+		mt76_abort_scan(dev);
+
+	mutex_lock(&dev->mutex);
+
+	if (vif->type == NL80211_IFTYPE_MONITOR &&
+	    is_zero_ether_addr(vif->addr))
+		goto out;
+
+	mlink = mt76_vif_conf_link(dev, vif, link_conf);
+	if (!mlink)
+		goto out;
+
+	if (link_conf != &vif->bss_conf)
+		rcu_assign_pointer(mvif->link[link_id], NULL);
+
+	dev->drv->vif_link_remove(phy, vif, link_conf, mlink);
+	mlink->ctx = NULL;
+
+	if (link_conf != &vif->bss_conf)
+		kfree_rcu(mlink, rcu_head);
+
+out:
+	mutex_unlock(&dev->mutex);
+}
+EXPORT_SYMBOL_GPL(mt76_unassign_vif_chanctx);
+
+int mt76_switch_vif_chanctx(struct ieee80211_hw *hw,
+			    struct ieee80211_vif_chanctx_switch *vifs,
+			    int n_vifs,
+			    enum ieee80211_chanctx_switch_mode mode)
+{
+	struct mt76_chanctx *old_ctx = (struct mt76_chanctx *)vifs->old_ctx->drv_priv;
+	struct mt76_chanctx *new_ctx = (struct mt76_chanctx *)vifs->new_ctx->drv_priv;
+	struct mt76_phy *old_phy = old_ctx->phy;
+	struct mt76_phy *phy = new_ctx->phy;
+	struct mt76_dev *dev = phy->dev;
+	struct mt76_vif_link *mlink;
+	bool update_chan;
+	int i, ret = 0;
+
+	update_chan = phy->chanctx != new_ctx;
+	if (update_chan)
+		cancel_delayed_work_sync(&phy->mac_work);
+
+	mutex_lock(&dev->mutex);
+	if (update_chan)
+		ret = mt76_phy_update_channel(phy, vifs->new_ctx);
+
+	if (ret || old_phy == phy)
+		goto out;
+
+	for (i = 0; i < n_vifs; i++) {
+		mlink = mt76_vif_conf_link(dev, vifs[i].vif, vifs[i].link_conf);
+		if (!mlink)
+			continue;
+
+		dev->drv->vif_link_remove(old_phy, vifs[i].vif,
+					  vifs[i].link_conf, mlink);
+
+		ret = dev->drv->vif_link_add(phy, vifs[i].vif,
+					     vifs[i].link_conf, mlink);
+		if (ret)
+			break;
+
+		mlink->ctx = vifs->new_ctx;
+	}
+
+out:
+	mutex_unlock(&dev->mutex);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(mt76_switch_vif_chanctx);
diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 8863d60dbd9f..9549510057fa 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -414,6 +414,7 @@ mt76_check_sband(struct mt76_phy *phy, struct mt76_sband *msband,
 		cfg80211_chandef_create(&phy->chandef, &sband->channels[0],
 					NL80211_CHAN_HT20);
 		phy->chan_state = &msband->chan[0];
+		phy->dev->band_phys[band] = phy;
 		return;
 	}
 
@@ -959,16 +960,13 @@ void mt76_update_survey(struct mt76_phy *phy)
 }
 EXPORT_SYMBOL_GPL(mt76_update_survey);
 
-int mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
-		     bool offchannel)
+int __mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
+		       bool offchannel)
 {
 	struct mt76_dev *dev = phy->dev;
 	int timeout = HZ / 5;
 	int ret;
 
-	cancel_delayed_work_sync(&phy->mac_work);
-
-	mutex_lock(&dev->mutex);
 	set_bit(MT76_RESET, &phy->state);
 
 	mt76_worker_disable(&dev->tx_worker);
@@ -995,6 +993,19 @@ int mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
 	mt76_worker_enable(&dev->tx_worker);
 	mt76_worker_schedule(&dev->tx_worker);
 
+	return ret;
+}
+
+int mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
+		     bool offchannel)
+{
+	struct mt76_dev *dev = phy->dev;
+	int ret;
+
+	cancel_delayed_work_sync(&phy->mac_work);
+
+	mutex_lock(&dev->mutex);
+	ret = __mt76_set_channel(phy, chandef, offchannel);
 	mutex_unlock(&dev->mutex);
 
 	return ret;
@@ -1006,6 +1017,8 @@ int mt76_update_channel(struct mt76_phy *phy)
 	struct cfg80211_chan_def *chandef = &hw->conf.chandef;
 	bool offchannel = hw->conf.flags & IEEE80211_CONF_OFFCHANNEL;
 
+	phy->radar_enabled = hw->conf.radar_enabled;
+
 	return mt76_set_channel(phy, chandef, offchannel);
 }
 EXPORT_SYMBOL_GPL(mt76_update_channel);
@@ -1919,7 +1932,7 @@ enum mt76_dfs_state mt76_phy_dfs_state(struct mt76_phy *phy)
 	    test_bit(MT76_SCANNING, &phy->state))
 		return MT_DFS_STATE_DISABLED;
 
-	if (!hw->conf.radar_enabled) {
+	if (!phy->radar_enabled) {
 		if ((hw->conf.flags & IEEE80211_CONF_MONITOR) &&
 		    (phy->chandef.chan->flags & IEEE80211_CHAN_RADAR))
 			return MT_DFS_STATE_ACTIVE;
@@ -1933,3 +1946,13 @@ enum mt76_dfs_state mt76_phy_dfs_state(struct mt76_phy *phy)
 	return MT_DFS_STATE_ACTIVE;
 }
 EXPORT_SYMBOL_GPL(mt76_phy_dfs_state);
+
+void mt76_vif_cleanup(struct mt76_dev *dev, struct ieee80211_vif *vif)
+{
+	struct mt76_vif_link *mlink = (struct mt76_vif_link *)vif->drv_priv;
+	struct mt76_vif_data *mvif = mlink->mvif;
+
+	rcu_assign_pointer(mvif->link[0], NULL);
+	mt76_abort_scan(dev);
+}
+EXPORT_SYMBOL_GPL(mt76_vif_cleanup);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index a9537131a074..307e6255f199 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -50,6 +50,8 @@ struct mt76_dev;
 struct mt76_phy;
 struct mt76_wcid;
 struct mt76s_intr;
+struct mt76_chanctx;
+struct mt76_vif_link;
 
 struct mt76_reg_pair {
 	u32 reg;
@@ -497,6 +499,8 @@ struct mt76_driver_ops {
 	u16 token_size;
 	u8 mcs_rates;
 
+	unsigned int link_data_size;
+
 	void (*update_survey)(struct mt76_phy *phy);
 	int (*set_channel)(struct mt76_phy *phy);
 
@@ -528,6 +532,15 @@ struct mt76_driver_ops {
 
 	void (*sta_remove)(struct mt76_dev *dev, struct ieee80211_vif *vif,
 			   struct ieee80211_sta *sta);
+
+	int (*vif_link_add)(struct mt76_phy *phy, struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link_conf,
+			    struct mt76_vif_link *mlink);
+
+	void (*vif_link_remove)(struct mt76_phy *phy,
+				struct ieee80211_vif *vif,
+				struct ieee80211_bss_conf *link_conf,
+				struct mt76_vif_link *mlink);
 };
 
 struct mt76_channel_state {
@@ -793,6 +806,9 @@ struct mt76_phy {
 	struct cfg80211_chan_def chandef;
 	struct cfg80211_chan_def main_chandef;
 	bool offchannel;
+	bool radar_enabled;
+
+	struct mt76_chanctx *chanctx;
 
 	struct mt76_channel_state *chan_state;
 	enum mt76_dfs_state dfs_state;
@@ -837,6 +853,7 @@ struct mt76_phy {
 struct mt76_dev {
 	struct mt76_phy phy; /* must be first */
 	struct mt76_phy *phys[__MT_MAX_BAND];
+	struct mt76_phy *band_phys[NUM_NL80211_BANDS];
 
 	struct ieee80211_hw *hw;
 
@@ -1057,6 +1074,10 @@ struct mt76_ethtool_worker_info {
 	int sta_count;
 };
 
+struct mt76_chanctx {
+	struct mt76_phy *phy;
+};
+
 #define CCK_RATE(_idx, _rate) {					\
 	.bitrate = _rate,					\
 	.flags = IEEE80211_RATE_SHORT_PREAMBLE,			\
@@ -1480,6 +1501,25 @@ void mt76_sw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 void mt76_sw_scan_complete(struct ieee80211_hw *hw,
 			   struct ieee80211_vif *vif);
 enum mt76_dfs_state mt76_phy_dfs_state(struct mt76_phy *phy);
+int mt76_add_chanctx(struct ieee80211_hw *hw,
+		     struct ieee80211_chanctx_conf *conf);
+void mt76_remove_chanctx(struct ieee80211_hw *hw,
+			 struct ieee80211_chanctx_conf *conf);
+void mt76_change_chanctx(struct ieee80211_hw *hw,
+			 struct ieee80211_chanctx_conf *conf,
+			 u32 changed);
+int mt76_assign_vif_chanctx(struct ieee80211_hw *hw,
+			    struct ieee80211_vif *vif,
+			    struct ieee80211_bss_conf *link_conf,
+			    struct ieee80211_chanctx_conf *conf);
+void mt76_unassign_vif_chanctx(struct ieee80211_hw *hw,
+			       struct ieee80211_vif *vif,
+			       struct ieee80211_bss_conf *link_conf,
+			       struct ieee80211_chanctx_conf *conf);
+int mt76_switch_vif_chanctx(struct ieee80211_hw *hw,
+			    struct ieee80211_vif_chanctx_switch *vifs,
+			    int n_vifs,
+			    enum ieee80211_chanctx_switch_mode mode);
 int mt76_testmode_cmd(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		      void *data, int len);
 int mt76_testmode_dump(struct ieee80211_hw *hw, struct sk_buff *skb,
@@ -1525,6 +1565,8 @@ void mt76_rx_aggr_reorder(struct sk_buff *skb, struct sk_buff_head *frames);
 void mt76_testmode_tx_pending(struct mt76_phy *phy);
 void mt76_queue_tx_complete(struct mt76_dev *dev, struct mt76_queue *q,
 			    struct mt76_queue_entry *e);
+int __mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
+		       bool offchannel);
 int mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
 		     bool offchannel);
 void mt76_scan_work(struct work_struct *work);
@@ -1777,14 +1819,7 @@ mt76_vif_init(struct ieee80211_vif *vif, struct mt76_vif_data *mvif)
 	rcu_assign_pointer(mvif->link[0], mlink);
 }
 
-static inline void
-mt76_vif_cleanup(struct mt76_dev *dev, struct ieee80211_vif *vif)
-{
-	struct mt76_vif_link *mlink = (struct mt76_vif_link *)vif->drv_priv;
-	struct mt76_vif_data *mvif = mlink->mvif;
-
-	rcu_assign_pointer(mvif->link[0], NULL);
-}
+void mt76_vif_cleanup(struct mt76_dev *dev, struct ieee80211_vif *vif);
 
 static inline struct mt76_vif_link *
 mt76_vif_link(struct mt76_dev *dev, struct ieee80211_vif *vif, int link_id)
@@ -1808,4 +1843,17 @@ mt76_vif_conf_link(struct mt76_dev *dev, struct ieee80211_vif *vif,
 	return mt76_dereference(mvif->link[link_conf->link_id], dev);
 }
 
+static inline struct mt76_phy *
+mt76_vif_link_phy(struct mt76_vif_link *mlink)
+{
+	struct mt76_chanctx *ctx;
+
+	if (!mlink->ctx)
+		return NULL;
+
+	ctx = (struct mt76_chanctx *)mlink->ctx->drv_priv;
+
+	return ctx->phy;
+}
+
 #endif
diff --git a/drivers/net/wireless/mediatek/mt76/scan.c b/drivers/net/wireless/mediatek/mt76/scan.c
index 70884faab905..d186a68b0fb8 100644
--- a/drivers/net/wireless/mediatek/mt76/scan.c
+++ b/drivers/net/wireless/mediatek/mt76/scan.c
@@ -124,6 +124,12 @@ int mt76_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 	struct mt76_dev *dev = phy->dev;
 	int ret = 0;
 
+	if (hw->wiphy->n_radio > 1) {
+		phy = dev->band_phys[req->req.channels[0]->band];
+		if (!phy)
+			return -EINVAL;
+	}
+
 	mutex_lock(&dev->mutex);
 
 	if (dev->scan.req) {
-- 
2.47.1


