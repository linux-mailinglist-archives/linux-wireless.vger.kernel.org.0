Return-Path: <linux-wireless+bounces-13769-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 39208996265
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 10:26:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E8A3028647D
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Oct 2024 08:26:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 08346188906;
	Wed,  9 Oct 2024 08:26:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="F0acAJS8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ACBA1885B5
	for <linux-wireless@vger.kernel.org>; Wed,  9 Oct 2024 08:26:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728462363; cv=none; b=S0RUSygRG7MceSQ0TKf/fdFmK55ANYNILCe+2wY7zzXHHZh4TgkJ6vxx/NVp+JZzwIWRzWSCI20j7LeLGk2jyxsMXmCo64tEe+qZoS0LClpQ3zatFcZc3UjICGTabMkKcqhyG3UeNEcwl5uiobxezFvXqp2UjpQHHZT3c5F9TTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728462363; c=relaxed/simple;
	bh=IEAbqq+I332EB5KcW4QoGRh5oMSAxsgCCbI4B2ZE2vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUg343Z6Rtgioy6K4uZ+SYtUaS7ud2T5JlJf/xUcYo/GieYh2BRxFj5KPLoBncT1XbkQ0LKPKRwnUji+YW64J9xVrtVZgFlaCv+qMiTYe0d1AkFsyk75ju4YSJqQ2dvn3wCTlIc2kR659WkcxtqgO+oQ4N4lAnFJVAbeMyTuWhA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=F0acAJS8; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0DJf3PQnsoPEh+Zigym2+5abQ8Zd/z8FuqATMhQR4iA=; b=F0acAJS8M9q0BCNe16kkmhTO9O
	lGZQpPugAS4CrYUyb2nZgHEfIYmkF4Ewoesv9QRl68ftsHV8L/KWYyxZpvY7rWbA0C7/mVLVZbSLQ
	n+mBA2K9DQ873WWinL7dmQ0QLcvpvS7MHSZ82WxzcOjtRbCMGUKEMzgpcST2xhj5hUCQ=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=Maecks.lan)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1syS15-006e0I-1U;
	Wed, 09 Oct 2024 10:25:55 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v5 10/11] wifi: mac80211: refactor ieee80211_rx_monitor
Date: Wed,  9 Oct 2024 10:25:51 +0200
Message-ID: <d57d82f109643894325beb9db6da8f001fc533eb.1728462320.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.7a6c6087b8cacec78525ec7f4f4d38c649d4a647.1728462320.git-series.nbd@nbd.name>
References: <cover.7a6c6087b8cacec78525ec7f4f4d38c649d4a647.1728462320.git-series.nbd@nbd.name>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Rework the monitor mode interface iteration to get rid of the last_monitor
condition. Preparation for further filtering received monitor packets.

Signed-off-by: Felix Fietkau <nbd@nbd.name>
---
 net/mac80211/rx.c | 54 ++++++++++++++++++++++++------------------------
 1 file changed, 28 insertions(+), 26 deletions(-)

diff --git a/net/mac80211/rx.c b/net/mac80211/rx.c
index b35e1b472e82..5e43905fd26c 100644
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
@@ -837,8 +837,10 @@ ieee80211_rx_monitor(struct ieee80211_local *local, struct sk_buff *origskb,
 	ieee80211_handle_mu_mimo_mon(monitor_sdata, origskb, rtap_space);
 
 	list_for_each_entry_rcu(sdata, &local->mon_list, u.mntr.list) {
-		bool last_monitor = list_is_last(&sdata->u.mntr.list,
-						 &local->mon_list);
+		if (!prev_sdata) {
+			prev_sdata = sdata;
+			continue;
+		}
 
 		if (ieee80211_hw_check(&local->hw, NO_VIRTUAL_MONITOR))
 			ieee80211_handle_mu_mimo_mon(sdata, origskb, rtap_space);
@@ -846,34 +848,34 @@ ieee80211_rx_monitor(struct ieee80211_local *local, struct sk_buff *origskb,
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

