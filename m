Return-Path: <linux-wireless+bounces-13444-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8822B98EAE8
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 09:58:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 3351B1F22CBC
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Oct 2024 07:58:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2C08126C09;
	Thu,  3 Oct 2024 07:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="I4YyZhl1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35E4112CDB6
	for <linux-wireless@vger.kernel.org>; Thu,  3 Oct 2024 07:58:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727942305; cv=none; b=oBKwkk4GP0rLxMo4zIWMoPaeM4PPYAKD4FNjJVJoMdQqlII7+YA/Al0/AmOWYJAKBBaAG/xDrEnqf0svCxc4bOr7mxQA58DJroJL8Hffv+n9YUCFBp+cyBi86eoulKc/DOKy/ugU8AeX9mYS1+3f/YAlYR0fCd2KLsoSVyh463k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727942305; c=relaxed/simple;
	bh=IEAbqq+I332EB5KcW4QoGRh5oMSAxsgCCbI4B2ZE2vo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XD+xsZ6jLX9h1mIFEW3DxVOm6x7oiSzYFs+17TTOjNgo2Ra8zlBOo9v60UAYcvDJQ8INbJTzjSO4U0rGAJCSuyP6eG+u7oDVtNthtfZfJOsziIRi8WcsIBB8AuYueXAy9XT9J2h4qLeuegBpNbca8nuSxnG8P1mQalvwrpQBmuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=I4YyZhl1; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
	Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
	List-Post:List-Owner:List-Archive;
	bh=0DJf3PQnsoPEh+Zigym2+5abQ8Zd/z8FuqATMhQR4iA=; b=I4YyZhl1o1iSdCEDAUvcGZQboc
	w86uDWt4AeabBZtcnk8+uk0hKN/CT+0XeZ9DhvpRX6Ky3F86M4bR8ccq9DyhfWWD2doBwC7dzSqGn
	PHWI4sZ8DjQTKKu2WjCkyccXQaB10gMfuD8JtsN8vBFEax05syqQmIaRkpPw9UmqztaU=;
Received: from p54ae98e8.dip0.t-ipconnect.de ([84.174.152.232] helo=localhost.localdomain)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_CHACHA20_POLY1305_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1swGj8-004Jgh-1X;
	Thu, 03 Oct 2024 09:58:22 +0200
From: Felix Fietkau <nbd@nbd.name>
To: linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
Subject: [PATCH v2 10/11] wifi: mac80211: refactor ieee80211_rx_monitor
Date: Thu,  3 Oct 2024 09:58:18 +0200
Message-ID: <9c8380381b45c3ad52701c09877cdac4b56e4d70.1727942154.git-series.nbd@nbd.name>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <cover.debd54967c43dd95013c56efa390ea6117062373.1727942154.git-series.nbd@nbd.name>
References: <cover.debd54967c43dd95013c56efa390ea6117062373.1727942154.git-series.nbd@nbd.name>
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

