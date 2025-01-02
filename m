Return-Path: <linux-wireless+bounces-17004-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 534DC9FFBD6
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:37:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 822B71883042
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:37:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9921117BB16;
	Thu,  2 Jan 2025 16:35:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="E90MEA+W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC9C615573A
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835723; cv=none; b=DRvUUkNqg+acvuuKaMrleaqi8EDzfjZG6YSb5h/28BBbpvMHhRjLhryOM7K7TJS2LV6kQb9N1n3ydQYcJfgBFW3EKeaqZvj3a5AZVOlzIzxSpgsIcf9kHVeRIQQSEEwvm9DiKQ0nHQzyDoEOWsNV1KdLRmc3H5NPSiiT/HdkvFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835723; c=relaxed/simple;
	bh=rKgyb4FNtmWv8bUiGob2xS7KsGqfhLjINB8lqM1dSvQ=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BGB+Vffrop9+3E241PzcOhYMRBUcoQZBvTP6YmVYSCvuhLtIaDg0/EV/EiBaUcEJLt1N81XtZH1H8sCzXL3WzO7TQZJoUjDhnKSTdDJw0L8QPjv9XuBm4CDxRj6hc2FYuEtrXMubZcbVPCa/QgJDeTYnGKdH0CCZZnFY+WkZZvQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=E90MEA+W; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=WdGI3OZBVALQeTjRk2rfIqptKFL/HH1zVjB7JHCJIWA=; b=E90MEA+W2bMSPvxTbL2G1XUsda
	rzPWL/SknJsDDnC6Zvm4h27x1s/aCKNmk4ngvB7j9Pkz9m+dGrufY8iq1vei/gt2pHlGDezsmmpvj
	ZMIPmSzePCx3VFPktJbFMagqcJeOH66qbHVIQwRFJ+qz1bekiduqyvXvCOqJ351Zii20=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAB-0008GS-2P
	for linux-wireless@vger.kernel.org;
	Thu, 02 Jan 2025 17:35:11 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 02/24] wifi: mt76: add support for allocating a phy without hw
Date: Thu,  2 Jan 2025 17:34:46 +0100
Message-ID: <20250102163508.52945-2-nbd@nbd.name>
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

Preparation for supporting a single hw with multiple radios

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mac80211.c | 39 ++++++++++++++++---
 drivers/net/wireless/mediatek/mt76/mt76.h     |  2 +
 2 files changed, 36 insertions(+), 5 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mac80211.c b/drivers/net/wireless/mediatek/mt76/mac80211.c
index 69fcea08e3fd..5a77f94b7f82 100644
--- a/drivers/net/wireless/mediatek/mt76/mac80211.c
+++ b/drivers/net/wireless/mediatek/mt76/mac80211.c
@@ -411,13 +411,15 @@ mt76_check_sband(struct mt76_phy *phy, struct mt76_sband *msband,
 	}
 
 	if (found) {
-		phy->chandef.chan = &sband->channels[0];
+		cfg80211_chandef_create(&phy->chandef, &sband->channels[0],
+					NL80211_CHAN_HT20);
 		phy->chan_state = &msband->chan[0];
 		return;
 	}
 
 	sband->n_channels = 0;
-	phy->hw->wiphy->bands[band] = NULL;
+	if (phy->hw->wiphy->bands[band] == sband)
+		phy->hw->wiphy->bands[band] = NULL;
 }
 
 static int
@@ -429,6 +431,9 @@ mt76_phy_init(struct mt76_phy *phy, struct ieee80211_hw *hw)
 	INIT_LIST_HEAD(&phy->tx_list);
 	spin_lock_init(&phy->tx_lock);
 
+	if ((void *)phy != hw->priv)
+		return 0;
+
 	SET_IEEE80211_DEV(hw, dev->dev);
 	SET_IEEE80211_PERM_ADDR(hw, phy->macaddr);
 
@@ -480,6 +485,28 @@ mt76_phy_init(struct mt76_phy *phy, struct ieee80211_hw *hw)
 	return 0;
 }
 
+struct mt76_phy *
+mt76_alloc_radio_phy(struct mt76_dev *dev, unsigned int size,
+		     u8 band_idx)
+{
+	struct ieee80211_hw *hw = dev->phy.hw;
+	unsigned int phy_size;
+	struct mt76_phy *phy;
+
+	phy_size = ALIGN(sizeof(*phy), 8);
+	phy = devm_kzalloc(dev->dev, size + phy_size, GFP_KERNEL);
+	if (!phy)
+		return NULL;
+
+	phy->dev = dev;
+	phy->hw = hw;
+	phy->priv = (void *)phy + phy_size;
+	phy->band_idx = band_idx;
+
+	return phy;
+}
+EXPORT_SYMBOL_GPL(mt76_alloc_radio_phy);
+
 struct mt76_phy *
 mt76_alloc_phy(struct mt76_dev *dev, unsigned int size,
 	       const struct ieee80211_ops *ops, u8 band_idx)
@@ -552,9 +579,11 @@ int mt76_register_phy(struct mt76_phy *phy, bool vht,
 	mt76_check_sband(phy, &phy->sband_5g, NL80211_BAND_5GHZ);
 	mt76_check_sband(phy, &phy->sband_6g, NL80211_BAND_6GHZ);
 
-	ret = ieee80211_register_hw(phy->hw);
-	if (ret)
-		return ret;
+	if ((void *)phy == phy->hw->priv) {
+		ret = ieee80211_register_hw(phy->hw);
+		if (ret)
+			return ret;
+	}
 
 	set_bit(MT76_STATE_REGISTERED, &phy->state);
 	phy->dev->phys[phy->band_idx] = phy;
diff --git a/drivers/net/wireless/mediatek/mt76/mt76.h b/drivers/net/wireless/mediatek/mt76/mt76.h
index b649039f384b..aac8ca7265c2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76.h
@@ -1177,6 +1177,8 @@ void mt76_unregister_device(struct mt76_dev *dev);
 void mt76_free_device(struct mt76_dev *dev);
 void mt76_unregister_phy(struct mt76_phy *phy);
 
+struct mt76_phy *mt76_alloc_radio_phy(struct mt76_dev *dev, unsigned int size,
+				      u8 band_idx);
 struct mt76_phy *mt76_alloc_phy(struct mt76_dev *dev, unsigned int size,
 				const struct ieee80211_ops *ops,
 				u8 band_idx);
-- 
2.47.1


