Return-Path: <linux-wireless+bounces-27298-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FFA0B57216
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 09:59:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A6F4A1899917
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Sep 2025 07:59:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A79C2EA15D;
	Mon, 15 Sep 2025 07:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="JAKoSwWi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 639C22E3397
	for <linux-wireless@vger.kernel.org>; Mon, 15 Sep 2025 07:59:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757923161; cv=none; b=FXso5Al/+0iq9TxY3BLYkEtLYjU5PiQMZu+wgd9vHB3Vqp+5bcaeqmqE19kBKW+1Z31hVcWbh8s0KKTv5Y9366/+eavXe+8pwIZU4BSZXiJ07geAtjw7qQ3nV/e3F2xwsWWcXzidHrm/k7Nz4O9mqZ4IHws0P1a3ysAouYsRCYI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757923161; c=relaxed/simple;
	bh=vXEjHl7HNb2VDpBHRF8kNbRGs87TIMIvAa1QHXXpNEE=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lLNS9+RnqqUWuL5l7FSXxFeZru25hHK68VtGdHHsDR3alNooQNwN6D+/RNlr65ws3WYh1oaAfqJcnIER1j42y75cKnmYWfLagDX3VMJRPNPjIAHX2kfnsj3GQQ1IbHKRG33bGf9TiM1XEvc/vGrYhrgHZeysVhjpFq1cYaMsoZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=JAKoSwWi; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=K9BDmurEnIWv51NDBkWcIXKu+ygXfBPDzKmiJJDn8FE=; b=JAKoSwWiOtn9iB5YhDlcb14mhJ
	cTivHI6Fs0XODM9twbumyXRZ43GbHY5dIBG2n+wBJ8Er28QUBdawMwJFY1pSF7PZWA7dVUI6F1yFL
	7i66aXQSzwLGMfY9EmDM3uaCYn1pWPQqAaBe7W4QrWojJFCAWOWh9s92j42ldwgDVrUY=;
Received: from p5b206816.dip0.t-ipconnect.de ([91.32.104.22] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1uy47D-0078GN-3A
	for linux-wireless@vger.kernel.org;
	Mon, 15 Sep 2025 09:59:12 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH mt76 06/15] wifi: mt76: mt7996: delete vif keys when requested
Date: Mon, 15 Sep 2025 09:59:01 +0200
Message-ID: <20250915075910.47558-6-nbd@nbd.name>
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

While deleting sta keys can be omitted in order to fix race conditions,
vif keys must be deleted before being replaced in order to prevent
accidental reuse in firmware.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 .../net/wireless/mediatek/mt76/mt7996/main.c  | 20 ++++++++++++-------
 1 file changed, 13 insertions(+), 7 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
index 84d5e0430a94..a81f2133cdc9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
@@ -252,13 +252,13 @@ mt7996_set_hw_key(struct ieee80211_hw *hw, enum set_key_cmd cmd,
 						&link->mt76, msta_link, true);
 		}
 
-		if (cmd == SET_KEY) {
+		if (cmd == SET_KEY)
 			*wcid_keyidx = idx;
-		} else {
-			if (idx == *wcid_keyidx)
-				*wcid_keyidx = -1;
+		else if (idx == *wcid_keyidx)
+			*wcid_keyidx = -1;
+
+		if (cmd != SET_KEY && sta)
 			continue;
-		}
 
 		mt76_wcid_key_setup(&dev->mt76, &msta_link->wcid, key);
 
@@ -277,10 +277,12 @@ mt7996_key_iter(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
 		struct ieee80211_sta *sta, struct ieee80211_key_conf *key,
 		void *data)
 {
+	enum set_key_cmd *cmd = data;
+
 	if (sta)
 		return;
 
-	WARN_ON(mt7996_set_hw_key(hw, SET_KEY, vif, NULL, key));
+	WARN_ON(mt7996_set_hw_key(hw, *cmd, vif, NULL, key));
 }
 
 int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
@@ -291,6 +293,7 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_sta_link *msta_link = &link->msta_link;
 	struct mt7996_phy *phy = mphy->priv;
+	enum set_key_cmd key_cmd = SET_KEY;
 	struct mt7996_dev *dev = phy->dev;
 	u8 band_idx = phy->mt76->band_idx;
 	struct mt76_txq *mtxq;
@@ -370,7 +373,7 @@ int mt7996_vif_link_add(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 				   CONN_STATE_PORT_SECURE, true);
 	rcu_assign_pointer(dev->mt76.wcid[idx], &msta_link->wcid);
 
-	ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, NULL);
+	ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, &key_cmd);
 
 	if (mvif->mt76.deflink_id == IEEE80211_LINK_UNSPECIFIED)
 		mvif->mt76.deflink_id = link_conf->link_id;
@@ -385,10 +388,13 @@ void mt7996_vif_link_remove(struct mt76_phy *mphy, struct ieee80211_vif *vif,
 	struct mt7996_vif_link *link = container_of(mlink, struct mt7996_vif_link, mt76);
 	struct mt7996_vif *mvif = (struct mt7996_vif *)vif->drv_priv;
 	struct mt7996_sta_link *msta_link = &link->msta_link;
+	enum set_key_cmd key_cmd = DISABLE_KEY;
 	struct mt7996_phy *phy = mphy->priv;
 	struct mt7996_dev *dev = phy->dev;
 	int idx = msta_link->wcid.idx;
 
+	ieee80211_iter_keys(mphy->hw, vif, mt7996_key_iter, &key_cmd);
+
 	mt7996_mcu_add_sta(dev, link_conf, NULL, link, NULL,
 			   CONN_STATE_DISCONNECT, false);
 	mt7996_mcu_add_bss_info(phy, vif, link_conf, mlink, msta_link, false);
-- 
2.51.0


