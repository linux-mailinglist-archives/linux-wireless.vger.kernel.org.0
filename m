Return-Path: <linux-wireless+bounces-17019-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF6809FFBE6
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 17:38:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 662F47A1C51
	for <lists+linux-wireless@lfdr.de>; Thu,  2 Jan 2025 16:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 389AA18FDB2;
	Thu,  2 Jan 2025 16:35:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="Ijb31PvW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E75A516DEB3
	for <linux-wireless@vger.kernel.org>; Thu,  2 Jan 2025 16:35:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735835728; cv=none; b=SVaNdLljpulDMSDx6/bTGD7ODd4tBz0oh8lsbdIYr7/9b4dZcxPUe3iQE3Jn+4h3WPPnLKlrDOVjipUQ6XJFWC+630ChSxrfeEaAT6UW9Due6BIBEqJjYKygY30FWnx7rutCZQyPVY6DDWeX5PEB3Q5sdcjxrx7Nl3rhmEvdJGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735835728; c=relaxed/simple;
	bh=ofiw99JaJkgZJ4MUWkH+6H6uUC1UhFAAorIXI8jJHdM=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dVIh1kP/OBev7UB8uvSr6jTqYSUxe/mhFuP0myf7m/NkDoxG7++t2niBdkeWf57Kr0zbsGBbxcf3bdrOAQ8TGMeRfExhuk3US+vZc/NoaSGwUn/ZPqsjVgICPjmB0Gyj17pAryOY1+p0UUXY7E6HDjpeDhLq/B68w/7iQjhTfTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=Ijb31PvW; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:To:From:Sender:Reply-To:Cc:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=TfNOHzz8Hpdz7841k7tVFy3u2GxPrxsONvEiID0mxU4=; b=Ijb31PvWOOul7mW6q0bz7h7zfs
	Sud26A5WdM5XvfkuMvKuAicnrmVZ450Thr9Slt/KUxeHjzXa+x666u9I3ScRTYt1cBYbETg78GXie
	DloCqNmfRZiZayrEp3cNL1io9ej28A+Jxy15m9jvSC2zs8KpX8PyBlymJ6uZWO/Z1yRI=;
Received: from p4ff13c5f.dip0.t-ipconnect.de ([79.241.60.95] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1tTOAE-0008GS-1Q
	for linux-wireless@vger.kernel.org;
	Thu, 02 Jan 2025 17:35:14 +0100
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Subject: [PATCH 19/24] wifi: mt76: connac: prepare mt76_connac_mcu_sta_basic_tlv for MLO support
Date: Thu,  2 Jan 2025 17:35:03 +0100
Message-ID: <20250102163508.52945-19-nbd@nbd.name>
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

Pass in struct ieee80211_bss_conf in order to use link specific data.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 drivers/net/wireless/mediatek/mt76/mt7615/mcu.c      |  4 ++--
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c | 12 ++++++++----
 drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h |  3 ++-
 drivers/net/wireless/mediatek/mt76/mt7915/mcu.c      |  2 +-
 drivers/net/wireless/mediatek/mt76/mt7925/mcu.c      |  5 +++--
 drivers/net/wireless/mediatek/mt76/mt7996/mcu.c      |  2 +-
 6 files changed, 17 insertions(+), 11 deletions(-)

diff --git a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
index 5373937b0e04..b8fcd4eb3fbb 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7615/mcu.c
@@ -865,8 +865,8 @@ mt7615_mcu_wtbl_sta_add(struct mt7615_phy *phy, struct ieee80211_vif *vif,
 			mvif->sta_added = true;
 	}
 	conn_state = enable ? CONN_STATE_PORT_SECURE : CONN_STATE_DISCONNECT;
-	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, sskb, vif, link_sta,
-				      conn_state, new_entry);
+	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, sskb, &vif->bss_conf,
+				      link_sta, conn_state, new_entry);
 	if (enable && sta)
 		mt76_connac_mcu_sta_tlv(phy->mt76, sskb, sta, vif, 0,
 					MT76_STA_INFO_STATE_ASSOC);
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
index 5c76a0885278..6e52e184aa20 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.c
@@ -369,10 +369,11 @@ void mt76_connac_mcu_bss_omac_tlv(struct sk_buff *skb,
 EXPORT_SYMBOL_GPL(mt76_connac_mcu_bss_omac_tlv);
 
 void mt76_connac_mcu_sta_basic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
-				   struct ieee80211_vif *vif,
+				   struct ieee80211_bss_conf *link_conf,
 				   struct ieee80211_link_sta *link_sta,
 				   int conn_state, bool newly)
 {
+	struct ieee80211_vif *vif = link_conf->vif;
 	struct sta_rec_basic *basic;
 	struct tlv *tlv;
 	int conn_type;
@@ -390,8 +391,8 @@ void mt76_connac_mcu_sta_basic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
 		basic->conn_type = cpu_to_le32(CONNECTION_INFRA_BC);
 
 		if (vif->type == NL80211_IFTYPE_STATION &&
-		    !is_zero_ether_addr(vif->bss_conf.bssid)) {
-			memcpy(basic->peer_addr, vif->bss_conf.bssid, ETH_ALEN);
+		    !is_zero_ether_addr(link_conf->bssid)) {
+			memcpy(basic->peer_addr, link_conf->bssid, ETH_ALEN);
 			basic->aid = cpu_to_le16(vif->cfg.aid);
 		} else {
 			eth_broadcast_addr(basic->peer_addr);
@@ -1049,6 +1050,9 @@ int mt76_connac_mcu_sta_cmd(struct mt76_phy *phy,
 	struct sk_buff *skb;
 	int conn_state;
 
+	if (!info->link_conf)
+		info->link_conf = &info->vif->bss_conf;
+
 	skb = mt76_connac_mcu_alloc_sta_req(dev, mvif, info->wcid);
 	if (IS_ERR(skb))
 		return PTR_ERR(skb);
@@ -1057,7 +1061,7 @@ int mt76_connac_mcu_sta_cmd(struct mt76_phy *phy,
 				    CONN_STATE_DISCONNECT;
 	link_sta = info->sta ? &info->sta->deflink : NULL;
 	if (info->sta || !info->offload_fw)
-		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->vif,
+		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->link_conf,
 					      link_sta, conn_state,
 					      info->newly);
 	if (info->sta && info->enable)
diff --git a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
index 8f23b9e58d2a..541b3c17168b 100644
--- a/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
+++ b/drivers/net/wireless/mediatek/mt76/mt76_connac_mcu.h
@@ -1758,6 +1758,7 @@ struct mt76_sta_cmd_info {
 	struct mt76_wcid *wcid;
 
 	struct ieee80211_vif *vif;
+	struct ieee80211_bss_conf *link_conf;
 
 	bool offload_fw;
 	bool enable;
@@ -1903,7 +1904,7 @@ mt76_connac_mcu_add_tlv(struct sk_buff *skb, int tag, int len)
 int mt76_connac_mcu_set_channel_domain(struct mt76_phy *phy);
 int mt76_connac_mcu_set_vif_ps(struct mt76_dev *dev, struct ieee80211_vif *vif);
 void mt76_connac_mcu_sta_basic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
-				   struct ieee80211_vif *vif,
+				   struct ieee80211_bss_conf *link_conf,
 				   struct ieee80211_link_sta *link_sta,
 				   int state, bool newly);
 void mt76_connac_mcu_wtbl_generic_tlv(struct mt76_dev *dev, struct sk_buff *skb,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
index 7115394f6bd6..9d790f234e82 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7915/mcu.c
@@ -1699,7 +1699,7 @@ int mt7915_mcu_add_sta(struct mt7915_dev *dev, struct ieee80211_vif *vif,
 		return PTR_ERR(skb);
 
 	/* starec basic */
-	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, skb, vif, link_sta,
+	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, skb, &vif->bss_conf, link_sta,
 				      conn_state, newly);
 	/* tag order is in accordance with firmware dependency. */
 	if (sta && conn_state != CONN_STATE_DISCONNECT) {
diff --git a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
index 6bd5322bcf14..4c378af715e2 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7925/mcu.c
@@ -1820,7 +1820,7 @@ mt7925_mcu_sta_cmd(struct mt76_phy *phy,
 	conn_state = info->enable ? CONN_STATE_PORT_SECURE :
 				    CONN_STATE_DISCONNECT;
 	if (info->link_sta)
-		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->vif,
+		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->link_conf,
 					      info->link_sta,
 					      conn_state, info->newly);
 	if (info->link_sta && info->enable) {
@@ -1874,7 +1874,7 @@ mt7925_mcu_mlo_sta_cmd(struct mt76_phy *phy,
 		return PTR_ERR(skb);
 
 	if (info->enable)
-		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->vif,
+		mt76_connac_mcu_sta_basic_tlv(dev, skb, info->link_conf,
 					      info->link_sta,
 					      info->enable, info->newly);
 
@@ -1920,6 +1920,7 @@ int mt7925_mcu_sta_update(struct mt792x_dev *dev,
 	struct mt76_sta_cmd_info info = {
 		.link_sta = link_sta,
 		.vif = vif,
+		.link_conf = &vif->bss_conf,
 		.enable = enable,
 		.cmd = MCU_UNI_CMD(STA_REC_UPDATE),
 		.state = state,
diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
index e9d449bd55ef..8ae98b724668 100644
--- a/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
+++ b/drivers/net/wireless/mediatek/mt76/mt7996/mcu.c
@@ -2174,7 +2174,7 @@ int mt7996_mcu_add_sta(struct mt7996_dev *dev, struct ieee80211_vif *vif,
 		return PTR_ERR(skb);
 
 	/* starec basic */
-	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, skb, vif, link_sta,
+	mt76_connac_mcu_sta_basic_tlv(&dev->mt76, skb, &vif->bss_conf, link_sta,
 				      conn_state, newly);
 
 	if (conn_state == CONN_STATE_DISCONNECT)
-- 
2.47.1


