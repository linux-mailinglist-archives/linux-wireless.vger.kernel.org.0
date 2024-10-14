Return-Path: <linux-wireless+bounces-13947-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D906D99D8A8
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 22:56:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 911CC1F22921
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 20:56:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAE61C75FA;
	Mon, 14 Oct 2024 20:56:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JR8R6uil"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3E5E1D0B9B
	for <linux-wireless@vger.kernel.org>; Mon, 14 Oct 2024 20:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728939392; cv=none; b=ruP4OWAoz+dKtC74uJbBF52/0U7ZhtEZxOUOYvN5o3TV37ttwOvrBrSfVh2k/a9FRN+TQ4Y0cV+ScZKXQt9h1RCCeUa+lg4DVJfpUmeUBhHazWTBZCN6oNBbinwvR5pFv2kOah5JVOY2hnVjPnuoQpckciF1FB54OTSBrvCpCng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728939392; c=relaxed/simple;
	bh=NPvDKmuVn6SLlT3u9SVVKp0wu1ZIulav4z1ZVQ6GSr8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=itwAz3iphHMf7HirWUlpi0KTHk/pg+o8dIuu198OznRvRIj0hmD/2bsbeQnrN8OFCzjuA/EQwmLe4p8Soms/Bfs/BH5FKbqVHCglRowDuYgo1zOjWGibHC06pfxc9VPhh+f1cYrZTL49RpUFbdpNCgcmPdRSNNR6RvVXTG5URt4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JR8R6uil; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728939391; x=1760475391;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=wyxzhCH+RCz4TZof/qFBe9QhQjwPHrezipTzY+vYTNU=;
  b=JR8R6uil8/PWa7JEAKourTtC2AHIXGazCi7KDlXWTonTDVBiPDcNtNXp
   LgpTXZhTKaBNXCsTbVdooJGZhcn05X18AWd2iaEMNaR9yZ4x1xoXUDfkL
   zV5traSv0/345w0qch8bi+NbUnXCljiIz3qxt2xla7O2dUjvCaaJbSwc3
   E=;
X-IronPort-AV: E=Sophos;i="6.11,203,1725321600"; 
   d="scan'208";a="440753173"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Oct 2024 20:56:29 +0000
Received: from EX19MTAUWB002.ant.amazon.com [10.0.21.151:20236]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.0.29:2525] with esmtp (Farcaster)
 id 0b66a69c-5cba-473b-99e5-860f1058305c; Mon, 14 Oct 2024 20:56:29 +0000 (UTC)
X-Farcaster-Flow-ID: 0b66a69c-5cba-473b-99e5-860f1058305c
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB002.ant.amazon.com (10.250.64.231) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Mon, 14 Oct 2024 20:56:27 +0000
Received: from 6c7e67c6786f.amazon.com (10.106.101.44) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Mon, 14 Oct 2024 20:56:25 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: Johannes Berg <johannes.berg@intel.com>
CC: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>, Kuniyuki Iwashima
	<kuniyu@amazon.com>, Kuniyuki Iwashima <kuni1840@gmail.com>,
	<linux-wireless@vger.kernel.org>
Subject: [PATCH v1 wl-next 2/3] wifi: wext: Convert wireless_nlevent_work to per-netns work.
Date: Mon, 14 Oct 2024 13:55:42 -0700
Message-ID: <20241014205543.94787-3-kuniyu@amazon.com>
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
X-ClientProxiedBy: EX19D032UWB002.ant.amazon.com (10.13.139.190) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

The next patch will namespacify wireless_nlevent_flush(), which is called
by wireless_nlevent_process() and two netdev notifiers.

As a preparation, let's convert wireless_nlevent_work to per-netns work.

Suggested-by: Johannes Berg <johannes.berg@intel.com>
Link: https://lore.kernel.org/netdev/cd8045c03573a012f71a1afdcfb5d9c108b6fefa.camel@sipsolutions.net/
Signed-off-by: Kuniyuki Iwashima <kuniyu@amazon.com>
---
 net/wireless/wext-core.c | 19 ++++++++++---------
 1 file changed, 10 insertions(+), 9 deletions(-)

diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index bfc13e0d9883..4d7699135f46 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -346,6 +346,7 @@ static const int compat_event_type_size[] = {
 
 struct wext_net {
 	struct sk_buff_head nlevents;
+	struct work_struct nlevent_work;
 };
 
 static int wext_net_id;
@@ -391,11 +392,18 @@ static struct notifier_block wext_netdev_notifier = {
 	.notifier_call = wext_netdev_notifier_call,
 };
 
+/* Process events generated by the wireless layer or the driver. */
+static void wireless_nlevent_process(struct work_struct *work)
+{
+	wireless_nlevent_flush();
+}
+
 static int __net_init wext_pernet_init(struct net *net)
 {
 	struct wext_net *wnet = wext_net(net);
 
 	skb_queue_head_init(&wnet->nlevents);
+	INIT_WORK(&wnet->nlevent_work, wireless_nlevent_process);
 
 	return 0;
 }
@@ -405,6 +413,7 @@ static void __net_exit wext_pernet_exit(struct net *net)
 	struct wext_net *wnet = wext_net(net);
 
 	skb_queue_purge(&wnet->nlevents);
+	cancel_work_sync(&wnet->nlevent_work);
 }
 
 static struct pernet_operations wext_pernet_ops = {
@@ -429,14 +438,6 @@ static int __init wireless_nlevent_init(void)
 
 subsys_initcall(wireless_nlevent_init);
 
-/* Process events generated by the wireless layer or the driver. */
-static void wireless_nlevent_process(struct work_struct *work)
-{
-	wireless_nlevent_flush();
-}
-
-static DECLARE_WORK(wireless_nlevent_work, wireless_nlevent_process);
-
 static struct nlmsghdr *rtnetlink_ifinfo_prep(struct net_device *dev,
 					      struct sk_buff *skb)
 {
@@ -656,7 +657,7 @@ void wireless_send_event(struct net_device *	dev,
 #endif
 	wnet = wext_net(dev_net(dev));
 	skb_queue_tail(&wnet->nlevents, skb);
-	schedule_work(&wireless_nlevent_work);
+	schedule_work(&wnet->nlevent_work);
 }
 EXPORT_SYMBOL(wireless_send_event);
 
-- 
2.39.5 (Apple Git-154)


