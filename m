Return-Path: <linux-wireless+bounces-11571-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11985955015
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 19:36:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 673D7B2575C
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 17:36:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA9CF1BE22D;
	Fri, 16 Aug 2024 17:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="kcWYx8fh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA1681C0DCC
	for <linux-wireless@vger.kernel.org>; Fri, 16 Aug 2024 17:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723829744; cv=none; b=qR+jq9DBCsxeG384qyOg0XaoU711WTHK41+0JRgoAT8IUstFO/w2JqfRf5GReliochG0rKfyBzScvAGZJyyhNy3YmMuClJz9ujtPFfQgqvfVxH7aw86OrNaPZxC4BuxAcGNLnY36by4Yh7Vo0vzKBfXrRwgvG/4xXqjkGXwLJJk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723829744; c=relaxed/simple;
	bh=IlYzzxtq5fy7uhAzu5u2JVtEeiB5FRAlWMCBrqssWac=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VxU+t0q98U4osqi+msJNNtPm5/Z48hVoKGEmy3StAK9YbWQ8NO9uFq7Lm2QAhQlanHipOSWvRblosdCermtiLwy0Feh/0yS5ePFFREHTjwB0LPAXyBxy1VJh007Hqqmkd9kv5bZig6Wy5P39JhZTy++k0EARlo3LFXihzZSN7do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=kcWYx8fh; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=OmdGPetB4G83SjQzABQ2lRbTLyOc/EyD59Q72rTeCq0=; b=kcWYx8fhvsuCaOJihHETeOXzJK
	DhheToQfYMMAtNGmqi+V95r5vaQUNtixXp1Sz+vyF4hZ0U5HffrvD0GXfCJEAYRpapTZQnf2cQZk7
	r2paqe/Yxzk4LwpTUwE+zRZJ7OJuZNo42czwjwNGlbNt4rlWxYWkH/DZ8iV2K3tS8Hxo=;
Received: from p54ae95e7.dip0.t-ipconnect.de ([84.174.149.231] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sf0rS-000ObE-0Z
	for linux-wireless@vger.kernel.org;
	Fri, 16 Aug 2024 19:35:38 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 10/16] wifi: mt76: connac: add support for passing connection state directly
Date: Fri, 16 Aug 2024 19:35:23 +0200
Message-ID: <20240816173529.17873-10-nbd@nbd.name>
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

Preparation for improvements to sta handling. No functional changes.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c |  4 +++-
 .../wireless/mediatek/mt76/mt76_connac_mcu.c    | 17 ++++++++---------
 .../wireless/mediatek/mt76/mt76_connac_mcu.h    |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c |  4 +++-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c |  5 ++++-
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c |  4 +++-
 6 files changed, 22 insertions(+), 14 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 3b57d967190a..f6eb9939c3e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -847,6 +847,7 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 	struct wtbl_req_hdr *wtbl_hdr;
 	struct mt7615_sta *msta;
 	bool new_entry = true;
+	int conn_state;
 	int cmd, err;
 
 	msta = sta ? (struct mt7615_sta *)sta->drv_priv : &mvif->sta;
@@ -863,8 +864,9 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 		else
 			mvif->sta_added = true;
 	}
+	conn_state = enable ? CONN_STATE_PORT_SECURE : CONN_STATE_DISCONNECT;
 	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, sskb, vif, link_sta,
-				      enable, new_entry);
+				      conn_state, new_entry);
 	if (enable && sta)
 		mt76_connac_mcu_sta_tlv(phy->mt76, sskb, sta, vif, 0,
 					MT76_STA_INFO_STATE_ASSOC);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 4dce03ddbfa4..7afb9ac30ab9 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -371,7 +371,7 @@ EXPORT_SYMBOL_GPL(mt76_connac_mcu_bss_omac_tlv);
 void mt76_connac_mcu_sta_basic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_link_sta *link_sta,
-				   bool enable, bool newly)
+				   int conn_state, bool newly)
 {
 	struct sta_rec_basic *basic;
 	struct tlv *tlv;
@@ -382,13 +382,9 @@ void mt76_connac_mcu_sta_basic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 	basic = (struct sta_rec_basic *)tlv;
 	basic->extra_info = cpu_to_le16(EXTRA_INFO_VER);
 
-	if (enable) {
-		if (newly)
-			basic->extra_info |= cpu_to_le16(EXTRA_INFO_NEW);
-		basic->conn_state = CONN_STATE_PORT_SECURE;
-	} else {
-		basic->conn_state = CONN_STATE_DISCONNECT;
-	}
+	if (newly && conn_state != CONN_STATE_DISCONNECT)
+		basic->extra_info |= cpu_to_le16(EXTRA_INFO_NEW);
+	basic->conn_state = conn_state;
 
 	if (!link_sta) {
 		basic->conn_type = cpu_to_le32(CONNECTION_INFRA_BC);
@@ -1051,15 +1047,18 @@ int mt76_connac_mcu_sta_cmd(struct mt76_phy *phy,
 	struct wtbl_req_hdr *wtbl_hdr;
 	struct tlv *sta_wtbl;
 	struct sk_buff *skb;
+	int conn_state;
 
 	skb = mt76_connac_mcu_alloc_sta_req(dev, mvif, info->wcid);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
+	conn_state = info->enable ? CONN_STATE_PORT_SECURE :
+				    CONN_STATE_DISCONNECT;
 	link_sta = info->sta ? &info->sta->deflink : NULL;
 	if (info->sta || !info->offload_fw)
 		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->vif,
-					      link_sta, info->enable,
+					      link_sta, conn_state,
 					      info->newly);
 	if (info->sta && info->enable)
 		mt76_connac_mcu_sta_tlv(phy, skb, info->sta,
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 4242d436de26..e04ae7eddb01 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1898,7 +1898,7 @@ int mt76_connac_mcu_set_vif_ps(struct mt76_dev *dev, struct ieee80211_vif *vif);
 void mt76_connac_mcu_sta_basic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				   struct ieee80211_vif *vif,
 				   struct ieee80211_link_sta *link_sta,
-				   bool enable, bool newly);
+				   int state, bool newly);
 void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 				      struct ieee80211_vif *vif,
 				      struct ieee80211_sta *sta, void *sta_wtbl,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 43f1a45b34ab..10de8b994e2e 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1663,6 +1663,7 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 	struct ieee80211_link_sta *link_sta;
 	struct mt7915_sta *msta;
 	struct sk_buff *skb;
+	int conn_state;
 	int ret;
 
 	msta = sta ? (struct mt7915_sta *)sta->drv_priv : &mvif->sta;
@@ -1674,7 +1675,8 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		return PTR_ERR(skb);
 
 	/* starec basic */
-	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, skb, vif, link_sta, enable,
+	conn_state = enable ? CONN_STATE_PORT_SECURE : CONN_STATE_DISCONNECT;
+	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, skb, vif, link_sta, conn_state,
 				      !rcu_access_pointer(dev->mt76.wcid[msta->wcid.idx]));
 	if (!enable)
 		goto out;
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 9dc22fbe25d3..473ed54e8710 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1770,16 +1770,19 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 	struct mt76_vif *mvif = (struct mt76_vif *)info->vif->drv_priv;
 	struct mt76_dev *dev = phy->dev;
 	struct sk_buff *skb;
+	int conn_state;
 
 	skb = __mt76_connac_mcu_alloc_sta_req(dev, mvif, info->wcid,
 					      MT7925_STA_UPDATE_MAX_SIZE);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
 
+	conn_state = info->enable ? CONN_STATE_PORT_SECURE :
+				    CONN_STATE_DISCONNECT;
 	if (info->link_sta)
 		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->vif,
 					      info->link_sta,
-					      info->enable, info->newly);
+					      conn_state, info->newly);
 	if (info->link_sta && info->enable) {
 		mt7925_mcu_sta_phy_tlv(skb, info->vif, info->link_sta);
 		mt7925_mcu_sta_ht_tlv(skb, info->link_sta);
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index a1a0df43e1cd..caa0ff619475 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2163,6 +2163,7 @@ int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 	struct ieee80211_link_sta *link_sta;
 	struct mt7996_sta *msta;
 	struct sk_buff *skb;
+	int conn_state;
 	int ret;
 
 	msta = sta ? (struct mt7996_sta *)sta->drv_priv : &mvif->sta;
@@ -2175,8 +2176,9 @@ int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		return PTR_ERR(skb);
 
 	/* starec basic */
+	conn_state = enable ? CONN_STATE_PORT_SECURE : CONN_STATE_DISCONNECT;
 	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, skb, vif, link_sta,
-				      enable, newly);
+				      conn_state, newly);
 
 	if (!enable)
 		goto out;
-- 
2.44.0


