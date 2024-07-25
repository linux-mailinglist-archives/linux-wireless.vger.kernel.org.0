Return-Path: <linux-wireless+bounces-10499-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7558493BEC3
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 11:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 315DD28229C
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jul 2024 09:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 35743196D9E;
	Thu, 25 Jul 2024 09:10:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b="VuW17b5c"
X-Original-To: linux-wireless@vger.kernel.org
Received: from forward103b.mail.yandex.net (forward103b.mail.yandex.net [178.154.239.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 492C81741EF
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jul 2024 09:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.154.239.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721898634; cv=none; b=KxUYErn5wOMHyMr1D0MeghHhSFJplvWzNwWlApOsbmZme/9FJdGWJxlYNMF3oLn87+26Fr7tFvnPCu1dzRsy4tNOf9o6GePOCbrYxp6rayaMZ8b9FgIWvsKtR46I7tMc0adNNvGtQzxQOR2dNqVeSwGPkYpiH5Kb/lxC+cHRsEM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721898634; c=relaxed/simple;
	bh=nWMZ0Y3aXuI9YwV0yhrsjqy7A3rH8SSYfMaFTzVLp6E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=TXMWsAe2SuDPM1fYYzMTynRxtRtTBZoEdBTRMIt/OduPazySKmSictlWpGcinNSxSjgjiKZekotAnygFreHnQbCSJQzQ/s2agR5k5B66xu57SH0rO/sDYVmzBFo2qxjMqDPitCPNMTWFqx3NOiy5r4L1jAP15MV2l6aYA45J/2I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru; spf=pass smtp.mailfrom=yandex.ru; dkim=pass (1024-bit key) header.d=yandex.ru header.i=@yandex.ru header.b=VuW17b5c; arc=none smtp.client-ip=178.154.239.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=yandex.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=yandex.ru
Received: from mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net [IPv6:2a02:6b8:c24:a33:0:640:d837:0])
	by forward103b.mail.yandex.net (Yandex) with ESMTPS id 1A1A260917;
	Thu, 25 Jul 2024 12:10:22 +0300 (MSK)
Received: by mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net (smtp/Yandex) with ESMTPSA id KAM1Su5Qm8c0-eJrdix6z;
	Thu, 25 Jul 2024 12:10:21 +0300
X-Yandex-Fwd: 1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yandex.ru; s=mail;
	t=1721898621; bh=7wghcsEtHmUU7lZcKVKGQxpP/saU/W9Ri0pCWTCr5Jo=;
	h=Message-ID:Date:Cc:Subject:To:From;
	b=VuW17b5cWPdg40z5PB+DKmQ62lRT8YIobEXIHyiiQZihErS7qO0SHjC+v737I4C/2
	 jvivq1OZfTYFy7/r0Vgx7y8ZbTv9Udh6uNVklOBjh0UutZ6+R6+5Eo1u77ZRIQJauO
	 msvRmeeEnIyOB3Ng90s0aSd8Ww4lT/6OTHY9mf7g=
Authentication-Results: mail-nwsmtp-smtp-production-main-44.sas.yp-c.yandex.net; dkim=pass header.i=@yandex.ru
From: Dmitry Antipov <dmantipov@yandex.ru>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: Dmitry Kandybka <d.kandybka@gmail.com>,
	linux-wireless@vger.kernel.org,
	Dmitry Antipov <dmantipov@yandex.ru>
Subject: [PATCH] wifi: mac80211: refactor block ack management code
Date: Thu, 25 Jul 2024 12:09:25 +0300
Message-ID: <20240725090925.6022-1-dmantipov@yandex.ru>
X-Mailer: git-send-email 2.45.2
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Introduce 'ieee80211_mgmt_ba()' to avoid code duplication between
'ieee80211_send_addba_resp()', 'ieee80211_send_addba_request()',
and 'ieee80211_send_delba()', ensure that all related addresses
are '__aligned(2)', and prefer convenient 'ether_addr_copy()'
over generic 'memcpy()'. No functional changes expected.

Signed-off-by: Dmitry Antipov <dmantipov@yandex.ru>
---
 include/net/mac80211.h     |  2 +-
 net/mac80211/agg-rx.c      | 15 +--------------
 net/mac80211/agg-tx.c      | 15 +--------------
 net/mac80211/ht.c          | 15 +--------------
 net/mac80211/ieee80211_i.h | 23 +++++++++++++++++++++++
 5 files changed, 27 insertions(+), 43 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 0a04eaf5343c..9406f687cffb 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -2487,7 +2487,7 @@ struct ieee80211_link_sta {
  * @spp_amsdu: indicates whether the STA uses SPP A-MSDU or not.
  */
 struct ieee80211_sta {
-	u8 addr[ETH_ALEN];
+	u8 addr[ETH_ALEN] __aligned(2);
 	u16 aid;
 	u16 max_rx_aggregation_subframes;
 	bool wme;
diff --git a/net/mac80211/agg-rx.c b/net/mac80211/agg-rx.c
index 9bffac7a4974..fe7eab4b681b 100644
--- a/net/mac80211/agg-rx.c
+++ b/net/mac80211/agg-rx.c
@@ -207,20 +207,7 @@ static void ieee80211_send_addba_resp(struct sta_info *sta, u8 *da, u16 tid,
 		return;
 
 	skb_reserve(skb, local->hw.extra_tx_headroom);
-	mgmt = skb_put_zero(skb, 24);
-	memcpy(mgmt->da, da, ETH_ALEN);
-	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
-	if (sdata->vif.type == NL80211_IFTYPE_AP ||
-	    sdata->vif.type == NL80211_IFTYPE_AP_VLAN ||
-	    sdata->vif.type == NL80211_IFTYPE_MESH_POINT)
-		memcpy(mgmt->bssid, sdata->vif.addr, ETH_ALEN);
-	else if (sdata->vif.type == NL80211_IFTYPE_STATION)
-		memcpy(mgmt->bssid, sdata->vif.cfg.ap_addr, ETH_ALEN);
-	else if (sdata->vif.type == NL80211_IFTYPE_ADHOC)
-		memcpy(mgmt->bssid, sdata->u.ibss.bssid, ETH_ALEN);
-
-	mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
-					  IEEE80211_STYPE_ACTION);
+	mgmt = ieee80211_mgmt_ba(skb, da, sdata);
 
 	skb_put(skb, 1 + sizeof(mgmt->u.action.u.addba_resp));
 	mgmt->u.action.category = WLAN_CATEGORY_BACK;
diff --git a/net/mac80211/agg-tx.c b/net/mac80211/agg-tx.c
index 677bbbac9f16..1c18b862ef8c 100644
--- a/net/mac80211/agg-tx.c
+++ b/net/mac80211/agg-tx.c
@@ -74,20 +74,7 @@ static void ieee80211_send_addba_request(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	skb_reserve(skb, local->hw.extra_tx_headroom);
-	mgmt = skb_put_zero(skb, 24);
-	memcpy(mgmt->da, da, ETH_ALEN);
-	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
-	if (sdata->vif.type == NL80211_IFTYPE_AP ||
-	    sdata->vif.type == NL80211_IFTYPE_AP_VLAN ||
-	    sdata->vif.type == NL80211_IFTYPE_MESH_POINT)
-		memcpy(mgmt->bssid, sdata->vif.addr, ETH_ALEN);
-	else if (sdata->vif.type == NL80211_IFTYPE_STATION)
-		memcpy(mgmt->bssid, sdata->vif.cfg.ap_addr, ETH_ALEN);
-	else if (sdata->vif.type == NL80211_IFTYPE_ADHOC)
-		memcpy(mgmt->bssid, sdata->u.ibss.bssid, ETH_ALEN);
-
-	mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
-					  IEEE80211_STYPE_ACTION);
+	mgmt = ieee80211_mgmt_ba(skb, da, sdata);
 
 	skb_put(skb, 1 + sizeof(mgmt->u.action.u.addba_req));
 
diff --git a/net/mac80211/ht.c b/net/mac80211/ht.c
index 79caeb485fd5..1c2b7dd8976a 100644
--- a/net/mac80211/ht.c
+++ b/net/mac80211/ht.c
@@ -467,20 +467,7 @@ void ieee80211_send_delba(struct ieee80211_sub_if_data *sdata,
 		return;
 
 	skb_reserve(skb, local->hw.extra_tx_headroom);
-	mgmt = skb_put_zero(skb, 24);
-	memcpy(mgmt->da, da, ETH_ALEN);
-	memcpy(mgmt->sa, sdata->vif.addr, ETH_ALEN);
-	if (sdata->vif.type == NL80211_IFTYPE_AP ||
-	    sdata->vif.type == NL80211_IFTYPE_AP_VLAN ||
-	    sdata->vif.type == NL80211_IFTYPE_MESH_POINT)
-		memcpy(mgmt->bssid, sdata->vif.addr, ETH_ALEN);
-	else if (sdata->vif.type == NL80211_IFTYPE_STATION)
-		memcpy(mgmt->bssid, sdata->vif.cfg.ap_addr, ETH_ALEN);
-	else if (sdata->vif.type == NL80211_IFTYPE_ADHOC)
-		memcpy(mgmt->bssid, sdata->u.ibss.bssid, ETH_ALEN);
-
-	mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
-					  IEEE80211_STYPE_ACTION);
+	mgmt = ieee80211_mgmt_ba(skb, da, sdata);
 
 	skb_put(skb, 1 + sizeof(mgmt->u.action.u.delba));
 
diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
index a3485e4c6132..fdd2bad15076 100644
--- a/net/mac80211/ieee80211_i.h
+++ b/net/mac80211/ieee80211_i.h
@@ -2136,6 +2136,29 @@ void ieee80211_process_addba_request(struct ieee80211_local *local,
 				     struct ieee80211_mgmt *mgmt,
 				     size_t len);
 
+static inline struct ieee80211_mgmt *
+ieee80211_mgmt_ba(struct sk_buff *skb, const u8 *da,
+		  struct ieee80211_sub_if_data *sdata)
+{
+	struct ieee80211_mgmt *mgmt = skb_put_zero(skb, 24);
+
+	ether_addr_copy(mgmt->da, da);
+	ether_addr_copy(mgmt->sa, sdata->vif.addr);
+
+	if (sdata->vif.type == NL80211_IFTYPE_AP ||
+	    sdata->vif.type == NL80211_IFTYPE_AP_VLAN ||
+	    sdata->vif.type == NL80211_IFTYPE_MESH_POINT)
+		ether_addr_copy(mgmt->bssid, sdata->vif.addr);
+	else if (sdata->vif.type == NL80211_IFTYPE_STATION)
+		ether_addr_copy(mgmt->bssid, sdata->vif.cfg.ap_addr);
+	else if (sdata->vif.type == NL80211_IFTYPE_ADHOC)
+		ether_addr_copy(mgmt->bssid, sdata->u.ibss.bssid);
+
+	mgmt->frame_control = cpu_to_le16(IEEE80211_FTYPE_MGMT |
+					  IEEE80211_STYPE_ACTION);
+	return mgmt;
+}
+
 int __ieee80211_stop_tx_ba_session(struct sta_info *sta, u16 tid,
 				   enum ieee80211_agg_stop_reason reason);
 void ieee80211_start_tx_ba_cb(struct sta_info *sta, int tid,
-- 
2.45.2


