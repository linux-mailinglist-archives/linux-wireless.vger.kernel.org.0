Return-Path: <linux-wireless+bounces-13948-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id F105999D8AB
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 22:57:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5ACE5282774
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 20:57:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DA4F81D1728;
	Mon, 14 Oct 2024 20:56:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="t8V+pgkW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-fw-80009.amazon.com (smtp-fw-80009.amazon.com [99.78.197.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6961D1518
	for <linux-wireless@vger.kernel.org>; Mon, 14 Oct 2024 20:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939410; cv=none; b=jqzPvnSUk8QE8y8UrBKkQBk9WBl0jM9z0GXEi82ZYYXzPX+Powr6HAGX4A1XGilFKtgHoR30ytvbQxBI1/O8LwNMDO3LgL1ddnCh1MQE0s10rATYs6dhuA4mi5tt9ZJwaq06u3ovQvIOL7zH4oOrta3nzTzskE/uNlqqRsEgZ/o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939410; c=relaxed/simple;
	bh=zoVxVHxBOoITHvYx/wds+4nlVcC3Cw40aNA88OH+CAs=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gwy9zJT0KwraEqFVYEW1qtETonL4N4Qd49rLm2R/GZoLtLb3wZa0EFxp8z4cVvfcAZjz9d9jtCeJrYASi3ueDhYuW1cds7XH+nEic7gkKMLHBE9kj9YWL2kPF2aHflOxIn8K6mHLq3zDaahqIj+ZOugXsXmB2sOUtgIDWrWMNVI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=t8V+pgkW; arc=none smtp.client-ip=99.78.197.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728939409; x=1760475409;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=cIC71K1ngjjnOWz/tQ2pY1RF/NWPWwSpvGOAjVKxY74=;
  b=t8V+pgkWsSXYvn36WzvBwNaqxX9D/4iG+f2+xmb8+SKdAMYcLsY1285N
   gyKNECj5PhB/NxSXKYir3tz7I0X562sOPH9Z/7RgbPPsqPwynBXfvxF+E
   wmIakueGeN/ykVtxKs3ij1rrZHlhKK1c//jnZYJokZa7sfPTsWX9sdF3f
   s=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="138018246"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-80009.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 20:56:47 +0000
Received: from EX19MTAUWA002.ant.amazon.com [10.0.21.151:43461]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.23:2525] with esmtp (Farcaster)
 id a1983923-8adc-4ffd-b998-fc6d6b098004; Mon, 14 Oct 2024 20:56:47 +0000 (UTC)
X-Farcaster-Flow-ID: a1983923-8adc-4ffd-b998-fc6d6b098004
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 20:56:47 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 20:56:44 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Johannes Berg <johannes.berg@intel.com>
CC: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<linux-wireless@vger.kernel.org>
Subject: [PATCH v1 wl-next 3/3] wifi: wext: Don't iterate all netns in wireless_nlevent_flush().
Date: Mon, 14 Oct 2024 13:55:43 -0700
Message-ID: <20241014205543.94787-4-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20241014205543.94787-1-kuniyu@amazon.com>
References: <20241014205543.94787-1-kuniyu@amazon.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D045UWC001.ant.amazon.com (10.13.139.223) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

Commit 8bf862739a77 ("wext: fix message delay/ordering") introduced
wext_netdev_notifier_call() to avoid message delay and out-of-order.

The notifier calls wireless_nlevent_flush(), which iterates all netns.

The problem is that this happens for any event and netdev, even if
the host does not have a wext device.

This is too noisy, especially on a host with thousands of netns as
reported by Alexandre Ferrieux.

Given that the wext event queue was implemented in struct net,
wireless_nlevent_flush() does not need to iterate all netns.

Let's avoid unnecessary netns iteration in wireless_nlevent_flush().

Reported-by: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Closes: https://lore.kernel.org/netdev/CAKYWH0Ti3=4GeeuVyWKJ9LyTuRnf3Wy9GKg4Jb7tdeaT39qADA@mail.gmail.com/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/iw_handler.h |  4 ++--
 net/wireless/core.c      |  2 +-
 net/wireless/wext-core.c | 25 +++++++++++++------------
 3 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/include/net/iw_handler.h b/include/net/iw_handler.h
index b80e474cb0aa..e6acff086d39 100644
--- a/include/net/iw_handler.h
+++ b/include/net/iw_handler.h
@@ -412,9 +412,9 @@ void wireless_send_event(struct net_device *dev, unsigned int cmd,
 			 union iwreq_data *wrqu, const char *extra);
 #ifdef CONFIG_WEXT_CORE
 /* flush all previous wext events - if work is done from netdev notifiers */
-void wireless_nlevent_flush(void);
+void wireless_nlevent_flush(struct net *net);
 #else
-static inline void wireless_nlevent_flush(void) {}
+static inline void wireless_nlevent_flush(struct net *net) {}
 #endif
 
 /* We may need a function to send a stream of events to user space.
diff --git a/net/wireless/core.c b/net/wireless/core.c
index 4c8d8f167409..a864ec889de3 100644
--- a/net/wireless/core.c
+++ b/net/wireless/core.c
@@ -1629,7 +1629,7 @@ static int cfg80211_netdev_notifier_call(struct notifier_block *nb,
 		return NOTIFY_DONE;
 	}
 
-	wireless_nlevent_flush();
+	wireless_nlevent_flush(dev_net(dev));
 
 	return NOTIFY_OK;
 }
diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index 4d7699135f46..28033211c9e3 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -345,6 +345,7 @@ static const int compat_event_type_size[] = {
 /* IW event code */
 
 struct wext_net {
+	struct net *net;
 	struct sk_buff_head nlevents;
 	struct work_struct nlevent_work;
 };
@@ -356,26 +357,22 @@ static struct wext_net *wext_net(struct net *net)
 	return net_generic(net, wext_net_id);
 }
 
-void wireless_nlevent_flush(void)
+void wireless_nlevent_flush(struct net *net)
 {
+	struct wext_net *wnet = wext_net(net);
 	struct sk_buff *skb;
-	struct net *net;
 
-	down_read(&net_rwsem);
-	for_each_net(net) {
-		struct wext_net *wnet = wext_net(net);
 
-		while ((skb = skb_dequeue(&wnet->nlevents)))
-			rtnl_notify(skb, net, 0, RTNLGRP_LINK, NULL,
-				    GFP_KERNEL);
-	}
-	up_read(&net_rwsem);
+	while ((skb = skb_dequeue(&wnet->nlevents)))
+		rtnl_notify(skb, net, 0, RTNLGRP_LINK, NULL, GFP_KERNEL);
 }
 EXPORT_SYMBOL_GPL(wireless_nlevent_flush);
 
 static int wext_netdev_notifier_call(struct notifier_block *nb,
 				     unsigned long state, void *ptr)
 {
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+
 	/*
 	 * When a netdev changes state in any way, flush all pending messages
 	 * to avoid them going out in a strange order, e.g. RTM_NEWLINK after
@@ -383,7 +380,7 @@ static int wext_netdev_notifier_call(struct notifier_block *nb,
 	 * or similar - all of which could otherwise happen due to delays from
 	 * schedule_work().
 	 */
-	wireless_nlevent_flush();
+	wireless_nlevent_flush(dev_net(dev));
 
 	return NOTIFY_OK;
 }
@@ -395,13 +392,17 @@ static struct notifier_block wext_netdev_notifier = {
 /* Process events generated by the wireless layer or the driver. */
 static void wireless_nlevent_process(struct work_struct *work)
 {
-	wireless_nlevent_flush();
+	struct wext_net *wnet;
+
+	wnet = container_of(work, struct wext_net, nlevent_work);
+	wireless_nlevent_flush(wnet->net);
 }
 
 static int __net_init wext_pernet_init(struct net *net)
 {
 	struct wext_net *wnet = wext_net(net);
 
+	wnet->net = net;
 	skb_queue_head_init(&wnet->nlevents);
 	INIT_WORK(&wnet->nlevent_work, wireless_nlevent_process);
 
-- 
2.39.5 (Apple Git-154)


