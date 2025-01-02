Return-Path: <linux-wireless+bounces-17006-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09A5E9FFBD8
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:37:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 517027A159B
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:37:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B49C514F9CF;
	Thu,  2 Jan 2025 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="SNt6P+Z2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A84FC15B102
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835724; cv=none; b=lxjxgbXJXi5uRj9PrMNaljMLVHUZrzC57QFWh1adgDC7x7hpBO5dcFUuXs7G53R1Vbw9kQX0Ot+DtSBn43kSTg11IuLddaY75F+Jkk7MLG+vXZ4kCSdelA8Fx7ikA1wbjAAXBF8UTDL7Oj0/MRUYFc14rrXArWiEBDFk3t1M24Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835724; c=relaxed/simple;
	bh=dPcEJaFw3qHUMuzexlQ1n5nbwd49y06N7w5+rBaJPL0=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZR5Tut0IPXs4hC/gVNv589ZUlqVbOWjsl6mf6PcjDpb2qiLAIWUf4eRFi0STA8Q+uScNQKyXJmiR2tpBDy8u+5lJAyhGqN8DbsQODMYHEBEZM14sNvvIjmZVIs4VCNZP6c1tFgEExKlRR2vezNvtLRz3ELr/3JTQJymULRrbpDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=SNt6P+Z2; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=9V4q8q/mEq84lgkClq0xcRIVO5ykbhtNB4ZIMfGamf8=; b=SNt6P+Z2m5roGKKUJMUirUNvz/
	5NPdCnUhk742EtTKPauvO6XiA9VLCTc4yzSUiFyvBdvHwlg5giX7Vb91/35nnqCKP71WxBAUz3pXk
	YPXKdv/9mZ9yhDaeEOVFlAuH9pKNOWcf9znl7eAogeUKAmej8lLTIXxY1fBB7fCHmyes=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAD-0008GS-0a
	for linux-wireless@vger.kernel.org;
	Thu, 02 Jan 2025 17:35:13 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 11/24] wifi: mt76: add multi-radio support to scanning code
Date: Thu,  2 Jan 2025 17:34:55 +0100
Message-ID: <20250102163508.52945-11-nbd@nbd.name>
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

When scanning on a phy/vif combination that does not have an active link,
create a temporary link in order to ensure that we have a valid wcid.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/channel.c | 62 +++++++++++++++++++-
 drivers/net/wireless/mediatek/mt76/mt76.h    |  6 ++
 drivers/net/wireless/mediatek/mt76/scan.c    | 11 +++-
 3 files changed, 77 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/channel.c b/drivers/net/wireless/mediatek/mt76/channel.c
index a577a01e4cc2..541b32cb1f65 100644
--- a/drivers/net/wireless/mediatek/mt76/channel.c
+++ b/drivers/net/wireless/mediatek/mt76/channel.c
@@ -4,6 +4,20 @@
  */
 #include "mt76.h"
 
+static struct mt76_vif_link *
+mt76_alloc_mlink(struct mt76_dev *dev, struct mt76_vif_data *mvif)
+{
+	struct mt76_vif_link *mlink;
+
+	mlink = kzalloc(dev->drv->link_data_size, GFP_KERNEL);
+	if (!mlink)
+		return NULL;
+
+	mlink->mvif = mvif;
+
+	return mlink;
+}
+
 static int
 mt76_phy_update_channel(struct mt76_phy *phy,
 			struct ieee80211_chanctx_conf *conf)
@@ -108,7 +122,7 @@ int mt76_assign_vif_chanctx(struct ieee80211_hw *hw,
 
 	mlink = mt76_vif_conf_link(dev, vif, link_conf);
 	if (!mlink) {
-		mlink = kzalloc(dev->drv->link_data_size, GFP_KERNEL);
+		mlink = mt76_alloc_mlink(dev, mvif);
 		if (!mlink) {
 			ret = -ENOMEM;
 			goto out;
@@ -220,3 +234,49 @@ int mt76_switch_vif_chanctx(struct ieee80211_hw *hw,
 	return ret;
 }
 EXPORT_SYMBOL_GPL(mt76_switch_vif_chanctx);
+
+struct mt76_vif_link *mt76_get_vif_phy_link(struct mt76_phy *phy,
+					    struct ieee80211_vif *vif)
+{
+	struct mt76_vif_link *mlink = (struct mt76_vif_link *)vif->drv_priv;
+	struct mt76_vif_data *mvif = mlink->mvif;
+	struct mt76_dev *dev = phy->dev;
+	int i, ret;
+
+	for (i = 0; i < ARRAY_SIZE(mvif->link); i++) {
+		mlink = mt76_dereference(mvif->link[i], dev);
+		if (!mlink)
+			continue;
+
+		if (mt76_vif_link_phy(mlink) == phy)
+			return mlink;
+	}
+
+	if (!dev->drv->vif_link_add)
+		return ERR_PTR(-EINVAL);
+
+	mlink = mt76_alloc_mlink(dev, mvif);
+	if (!mlink)
+		return ERR_PTR(-ENOMEM);
+
+	mlink->offchannel = true;
+	ret = dev->drv->vif_link_add(phy, vif, &vif->bss_conf, mlink);
+	if (ret) {
+		kfree(mlink);
+		return ERR_PTR(ret);
+	}
+
+	return mlink;
+}
+
+void mt76_put_vif_phy_link(struct mt76_phy *phy, struct ieee80211_vif *vif,
+			   struct mt76_vif_link *mlink)
+{
+	struct mt76_dev *dev = phy->dev;
+
+	if (IS_ERR_OR_NULL(mlink) || !mlink->offchannel)
+		return;
+
+	dev->drv->vif_link_remove(phy, vif, &vif->bss_conf, mlink);
+	kfree(mlink);
+}
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index 85b2f21acd70..b61f1eb138e8 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -777,6 +777,7 @@ struct mt76_vif_link {
 	u8 basic_rates_idx;
 	u8 mcast_rates_idx;
 	u8 beacon_rates_idx;
+	bool offchannel;
 	struct ieee80211_chanctx_conf *ctx;
 	struct mt76_wcid *wcid;
 	struct mt76_vif_data *mvif;
@@ -942,6 +943,7 @@ struct mt76_dev {
 		struct cfg80211_scan_request *req;
 		struct ieee80211_channel *chan;
 		struct ieee80211_vif *vif;
+		struct mt76_vif_link *mlink;
 		struct mt76_phy *phy;
 		int chan_idx;
 	} scan;
@@ -1570,6 +1572,10 @@ int mt76_set_channel(struct mt76_phy *phy, struct cfg80211_chan_def *chandef,
 		     bool offchannel);
 void mt76_scan_work(struct work_struct *work);
 void mt76_abort_scan(struct mt76_dev *dev);
+struct mt76_vif_link *mt76_get_vif_phy_link(struct mt76_phy *phy,
+					    struct ieee80211_vif *vif);
+void mt76_put_vif_phy_link(struct mt76_phy *phy, struct ieee80211_vif *vif,
+			   struct mt76_vif_link *mlink);
 
 /* usb */
 static inline bool mt76u_urb_error(struct urb *urb)
diff --git a/drivers/net/wireless/mediatek/mt76/scan.c b/drivers/net/wireless/mediatek/mt76/scan.c
index d186a68b0fb8..9f3485be5747 100644
--- a/drivers/net/wireless/mediatek/mt76/scan.c
+++ b/drivers/net/wireless/mediatek/mt76/scan.c
@@ -18,6 +18,7 @@ static void mt76_scan_complete(struct mt76_dev *dev, bool abort)
 
 	if (dev->scan.chan && phy->main_chandef.chan)
 		mt76_set_channel(phy, &phy->main_chandef, false);
+	mt76_put_vif_phy_link(phy, dev->scan.vif, dev->scan.mlink);
 	memset(&dev->scan, 0, sizeof(dev->scan));
 	ieee80211_scan_completed(phy->hw, &info);
 }
@@ -33,7 +34,7 @@ mt76_scan_send_probe(struct mt76_dev *dev, struct cfg80211_ssid *ssid)
 {
 	struct cfg80211_scan_request *req = dev->scan.req;
 	struct ieee80211_vif *vif = dev->scan.vif;
-	struct mt76_vif_link *mvif = (struct mt76_vif_link *)vif->drv_priv;
+	struct mt76_vif_link *mvif = dev->scan.mlink;
 	enum nl80211_band band = dev->scan.chan->band;
 	struct mt76_phy *phy = dev->scan.phy;
 	struct ieee80211_tx_info *info;
@@ -122,6 +123,7 @@ int mt76_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 {
 	struct mt76_phy *phy = hw->priv;
 	struct mt76_dev *dev = phy->dev;
+	struct mt76_vif_link *mlink;
 	int ret = 0;
 
 	if (hw->wiphy->n_radio > 1) {
@@ -137,10 +139,17 @@ int mt76_hw_scan(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		goto out;
 	}
 
+	mlink = mt76_get_vif_phy_link(phy, vif);
+	if (IS_ERR(mlink)) {
+		ret = PTR_ERR(mlink);
+		goto out;
+	}
+
 	memset(&dev->scan, 0, sizeof(dev->scan));
 	dev->scan.req = &req->req;
 	dev->scan.vif = vif;
 	dev->scan.phy = phy;
+	dev->scan.mlink = mlink;
 	ieee80211_queue_delayed_work(dev->phy.hw, &dev->scan_work, 0);
 
 out:
-- 
2.47.1


