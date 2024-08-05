Return-Path: <linux-wireless+bounces-10970-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E08194823E
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 21:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 299D11F22B09
	for <lists+linux-wireless@lfdr.de>; Mon,  5 Aug 2024 19:23:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A897916B743;
	Mon,  5 Aug 2024 19:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="tVDDAPM4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E796B16A952
	for <linux-wireless@vger.kernel.org>; Mon,  5 Aug 2024 19:23:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722885820; cv=none; b=AjEucnBPDQ7hHAWwQcdfvgyYQ7WykD75wt7MgBBFbAx0cu7Favbrz8LcixT+zh1cnRqt7XjRBwmJJtay1lkOI81FjpQHzQAXGzM2fvcUajVn9JNjnaiOaZnG67pAHiz09Ls2pseIU0C8myOC5Ju2Mp6eFBYn5JgNDEeNB4DKE/I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722885820; c=relaxed/simple;
	bh=e14meo4vm/W9CUI8Qb5PXcIGJCJ0UNStQKC0/DQmYl8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KmUSBA30NgzFJMndHVR33mI5t679gBXItWNvyEb+KKLkTmFzSoOeLNToi4SAR7tZKMgMmpynVsCRYZa785AVaY0Y03xcsOaHslkW03nIYKbL/fAZ3+nXaEA8EwibOhLJKg+IJG/to4VfULtsCqV7usRuNohUbqj8URM4rjxg5XI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=tVDDAPM4; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=oRJjrTA0PNIw4kWKLnN547aLQx5u/TICMg5/gyFZsrQ=; b=tVDDAPM4Ig2ytSJbhuBoooV9oe
	MEz9rnynNNgtH79lAckmt8Ds2gurZwnx6IF+t2+d/GqPTWRIkGBjr09pt7w9VM3qOQgpRGh/yVXIS
	tzJj11x4iuDdJ0zX/S2sSZ8NftM1WXOxjg91Qr8MBt2v+mqYl8rXzr/0D932XDriSiL8=;
Received: from p54ae9b72.dip0.t-ipconnect.de ([84.174.155.114] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sb3Iv-00EHlS-09;
	Mon, 05 Aug 2024 21:23:37 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [RFC 6/6] wifi: mac80211: check vif radio_mask for monitor mode rx
Date: Mon,  5 Aug 2024 21:23:34 +0200
Message-ID: <7d713206957ec56dc297d5645203b45341578588.1722885720.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.44.0
In-Reply-To: <cover.c32cfe64c671566c111b1b7ea426dbd1e8f2c568.1722885720.git-series.nbd@nbd.name>
References: <cover.c32cfe64c671566c111b1b7ea426dbd1e8f2c568.1722885720.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When restricting a monitor vif to only operate on a specific set of radios,
filter out rx packets belonging to other radios. This only works if drivers
fill in radio_valid and radio_idx in the rx status.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 include/net/mac80211.h |  3 ++-
 net/mac80211/rx.c      | 58 +++++++++++++++++++++++--------------------
 2 files changed, 35 insertions(+), 26 deletions(-)

diff --git a/include/net/mac80211.h b/include/net/mac80211.h
index 7a5418713dfc..6222f4f44ac2 100644
--- a/include/net/mac80211.h
+++ b/include/net/mac80211.h
@@ -1619,6 +1619,8 @@ enum mac80211_rx_encoding {
  * @ampdu_reference: A-MPDU reference number, must be a different value for
  *	each A-MPDU but the same for each subframe within one A-MPDU
  * @zero_length_psdu_type: radiotap type of the 0-length PSDU
+ * @radio_valid: if the index of the radio in radio_idx is valid.
+ * @radio_idx: index of the wiphy radio that the frame was received on.
  * @link_valid: if the link which is identified by @link_id is valid. This flag
  *	is set only when connection is MLO.
  * @link_id: id of the link used to receive the packet. This is used along with
@@ -1656,6 +1658,7 @@ struct ieee80211_rx_status {
 	u8 chains;
 	s8 chain_signal[IEEE80211_MAX_CHAINS];
 	u8 zero_length_psdu_type;
+	u8 radio_valid:1, radio_idx:5;
 	u8 link_valid:1, link_id:4;
 };
 
diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index 718f02f0a181..de4196fa3eb5 100644
--- a/net/mac80211/rx.c
+++ b/net/mac80211/rx.c
@@ -762,8 +762,8 @@ ieee80211_rx_monitor(struct ieee80211_local *local, struct sk_buff *origskb,
 		     struct ieee80211_rate *rate)
 {
 	struct ieee80211_rx_status *status = IEEE80211_SKB_RXCB(origskb);
-	struct ieee80211_sub_if_data *sdata;
-	struct sk_buff *monskb = NULL;
+	struct ieee80211_sub_if_data *sdata, *prev_sdata = NULL;
+	struct sk_buff *skb, *monskb = NULL;
 	int present_fcs_len = 0;
 	unsigned int rtap_space = 0;
 	struct ieee80211_sub_if_data *monitor_sdata =
@@ -837,40 +837,46 @@ ieee80211_rx_monitor(struct ieee80211_local *local, struct sk_buff *origskb,
 	ieee80211_handle_mu_mimo_mon(monitor_sdata, origskb, rtap_space);
 
 	list_for_each_entry_rcu(sdata, &local->mon_list, u.mntr.list) {
-		bool last_monitor = list_is_last(&sdata->u.mntr.list,
-						 &local->mon_list);
+		if (status->radio_valid &&
+		    !(sdata->wdev.radio_mask & BIT(status->radio_idx)))
+			continue;
+
+		if (!prev_sdata) {
+			prev_sdata = sdata;
+			continue;
+		}
 
 		if (!monskb)
 			monskb = ieee80211_make_monitor_skb(local, &origskb,
 							    rate, rtap_space,
-							    only_monitor &&
-							    last_monitor);
+							    false);
+		if (!monskb)
+			continue;
 
-		if (monskb) {
-			struct sk_buff *skb;
+		skb = skb_clone(monskb, GFP_ATOMIC);
+		if (!skb)
+			continue;
 
-			if (last_monitor) {
-				skb = monskb;
-				monskb = NULL;
-			} else {
-				skb = skb_clone(monskb, GFP_ATOMIC);
-			}
+		skb->dev = prev_sdata->dev;
+		dev_sw_netstats_rx_add(skb->dev, skb->len);
+		netif_receive_skb(skb);
+		prev_sdata = sdata;
+	}
 
-			if (skb) {
-				skb->dev = sdata->dev;
-				dev_sw_netstats_rx_add(skb->dev, skb->len);
-				netif_receive_skb(skb);
-			}
+	if (prev_sdata) {
+		if (monskb)
+			skb = monskb;
+		else
+			skb = ieee80211_make_monitor_skb(local, &origskb,
+							 rate, rtap_space,
+							 only_monitor);
+		if (skb) {
+			skb->dev = prev_sdata->dev;
+			dev_sw_netstats_rx_add(skb->dev, skb->len);
+			netif_receive_skb(skb);
 		}
-
-		if (last_monitor)
-			break;
 	}
 
-	/* this happens if last_monitor was erroneously false */
-	dev_kfree_skb(monskb);
-
-	/* ditto */
 	if (!origskb)
 		return NULL;
 
-- 
git-series 0.9.1

