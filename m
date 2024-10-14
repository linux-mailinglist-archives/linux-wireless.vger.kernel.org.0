Return-Path: <linux-wireless+bounces-13946-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F8A099D8A7
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 22:56:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 494611F21743
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 20:56:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3FEB1CB330;
	Mon, 14 Oct 2024 20:56:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="p9wAE1UX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E233C1D0B9B
	for <linux-wireless@vger.kernel.org>; Mon, 14 Oct 2024 20:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939374; cv=none; b=srTCJ9zLPz+aADRdqdSTCSR7nViZlOyzAzsB98/Y5cckBlT8XvmTqjcBmwoEd1OeWiptaBX8izqZ+slRCwH5ckDhULASYpM4BJnKTKbq6PCqrUQ5iEVEH7lYUzuON68gD1QPjfkwxAecR83FuOoEz1D4agTmz6fO4ROUx1M8ON8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939374; c=relaxed/simple;
	bh=hMzQxBDyrGsZ1w+Utbf2ii3rYMTMAVua+VyaLeJ96lA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TRhDLEy8S8C2AFgmcOAUkBT/+MSbybNZeMIJSgF836ackOVw4KoVUKwRtdq8Pi5jfBUQWkqbBZDuiiil7MiW2UHpLhK/cW3/w31HmqT2ZH0iSvW2RD+6L2voa7k5KaG9PLigdlr8j2SzCmTfEPFyhcu8L7S4LvQ9sfvp/VbQWyc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=p9wAE1UX; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728939373; x=1760475373;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=5PCVUGqBIB9Z66+UMJ2tXFmGcFdyToB2bnYnw/GOuHU=;
  b=p9wAE1UXZdOoHDk+EEK/8yZ/o++/bo+QengftS7pelpBuSyYBF6EWONV
   qQLpTsy/HWCQRlTUFaXIHkwAb5OsdOHpOxJznOoiaO3SL8tfacqWMhXjN
   g2UbGolGqobYLLFKcEJWlSE3kan99S3ttgUcVDzKzMtr9dw2Jeq+ZkMuC
   o=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="440753089"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 20:56:09 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:45872]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.29:2525] with esmtp (Farcaster)
 id ab3589ff-fae7-46a9-8f66-b1ad8bb9bf64; Mon, 14 Oct 2024 20:56:09 +0000 (UTC)
X-Farcaster-Flow-ID: ab3589ff-fae7-46a9-8f66-b1ad8bb9bf64
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 20:56:08 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 20:56:06 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Johannes Berg <johannes.berg@intel.com>
CC: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<linux-wireless@vger.kernel.org>
Subject: [PATCH v1 wl-next 1/3] wifi: wext: Move wext_nlevents to net->gen[].
Date: Mon, 14 Oct 2024 13:55:41 -0700
Message-ID: <20241014205543.94787-2-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

CONFIG_WEXT_CORE cannot be built as a module and is enabled in a
generic kernel in major distros.

We will namespacify wireless_nlevent_work that would require yet
another wext-specific field in struct net.

Given wext has already registered its pernet_operations, we can
use struct net_generic for wext-specific storage.

Let's move wext_nlevents to net->gen[].

Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 include/net/net_namespace.h |  3 ---
 net/wireless/wext-core.c    | 31 +++++++++++++++++++++++++++----
 2 files changed, 27 insertions(+), 7 deletions(-)

diff --git a/include/net/net_namespace.h b/include/net/net_namespace.h
index 873c0f9fdac6..f720225f7f6d 100644
--- a/include/net/net_namespace.h
+++ b/include/net/net_namespace.h
@@ -150,9 +150,6 @@ struct net {
 #if IS_ENABLED(CONFIG_NF_FLOW_TABLE)
 	struct netns_ft ft;
 #endif
-#endif
-#ifdef CONFIG_WEXT_CORE
-	struct sk_buff_head	wext_nlevents;
 #endif
 	struct net_generic __rcu	*gen;
 
diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index 3bb04b05c5ce..bfc13e0d9883 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -20,6 +20,7 @@
 #include <net/netlink.h>
 #include <net/wext.h>
 #include <net/net_namespace.h>
+#include <net/netns/generic.h>
 
 typedef int (*wext_ioctl_func)(struct net_device *, struct iwreq *,
 			       unsigned int, struct iw_request_info *,
@@ -343,6 +344,17 @@ static const int compat_event_type_size[] = {
 
 /* IW event code */
 
+struct wext_net {
+	struct sk_buff_head nlevents;
+};
+
+static int wext_net_id;
+
+static struct wext_net *wext_net(struct net *net)
+{
+	return net_generic(net, wext_net_id);
+}
+
 void wireless_nlevent_flush(void)
 {
 	struct sk_buff *skb;
@@ -350,7 +362,9 @@ void wireless_nlevent_flush(void)
 
 	down_read(&net_rwsem);
 	for_each_net(net) {
-		while ((skb = skb_dequeue(&net->wext_nlevents)))
+		struct wext_net *wnet = wext_net(net);
+
+		while ((skb = skb_dequeue(&wnet->nlevents)))
 			rtnl_notify(skb, net, 0, RTNLGRP_LINK, NULL,
 				    GFP_KERNEL);
 	}
@@ -379,18 +393,25 @@ static struct notifier_block wext_netdev_notifier = {
 
 static int __net_init wext_pernet_init(struct net *net)
 {
-	skb_queue_head_init(&net->wext_nlevents);
+	struct wext_net *wnet = wext_net(net);
+
+	skb_queue_head_init(&wnet->nlevents);
+
 	return 0;
 }
 
 static void __net_exit wext_pernet_exit(struct net *net)
 {
-	skb_queue_purge(&net->wext_nlevents);
+	struct wext_net *wnet = wext_net(net);
+
+	skb_queue_purge(&wnet->nlevents);
 }
 
 static struct pernet_operations wext_pernet_ops = {
 	.init = wext_pernet_init,
 	.exit = wext_pernet_exit,
+	.id = &wext_net_id,
+	.size = sizeof(struct wext_net),
 };
 
 static int __init wireless_nlevent_init(void)
@@ -462,6 +483,7 @@ void wireless_send_event(struct net_device *	dev,
 	int wrqu_off = 0;			/* Offset in wrqu */
 	/* Don't "optimise" the following variable, it will crash */
 	unsigned int	cmd_index;		/* *MUST* be unsigned */
+	struct wext_net *wnet;
 	struct sk_buff *skb;
 	struct nlmsghdr *nlh;
 	struct nlattr *nla;
@@ -632,7 +654,8 @@ void wireless_send_event(struct net_device *	dev,
 
 	skb_shinfo(skb)->frag_list = compskb;
 #endif
-	skb_queue_tail(&dev_net(dev)->wext_nlevents, skb);
+	wnet = wext_net(dev_net(dev));
+	skb_queue_tail(&wnet->nlevents, skb);
 	schedule_work(&wireless_nlevent_work);
 }
 EXPORT_SYMBOL(wireless_send_event);
-- 
2.39.5 (Apple Git-154)


