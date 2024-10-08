Return-Path: <linux-wireless+bounces-13725-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A04D49955F7
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 19:48:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0DB36B22A5A
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 17:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 628D320C47A;
	Tue,  8 Oct 2024 17:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="gmokPjIA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-fw-52004.amazon.com (smtp-fw-52004.amazon.com [52.119.213.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C9C1E0E0D;
	Tue,  8 Oct 2024 17:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.119.213.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728409687; cv=none; b=tl/WIXPOh6u4ypccAINwGcWWnLgZGqCkgFEhN/DZglROmM/iZTRwBQWK0uvu4lT7KRPwZPxiJwAnKyt48oufwC+30/Zdu9pg58vxqB7Wo+csqyl4G9Oubhp8smncLmr+FjTr4X8ud/1OXd3jIF+Vf8FrhHgyDihL48UYw0XmYps=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728409687; c=relaxed/simple;
	bh=RgWxgKNOG24VS/qCaBqQTpp+xpNvvfArZGbRGOmvIA8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=CnXY+vbuybwPC/cZkFm9KUZgCRSGi4KafMl0me/aVgGy8uQa4OP5xRRwf8Th80khCb8lEEWKDQqnndXTgyCFeo6Q8QjTpFgS8bqyAGdEzBMrP6K9wS33wBS6X7ptIPNB2fnHWYuomG/WasXmPOJqhEPru4mmq532dOKj1Zr4NOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=gmokPjIA; arc=none smtp.client-ip=52.119.213.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728409686; x=1759945686;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Zf9YAPZnVHLiv61BoxQUx3KbaKBkOZlqQ4LrmxK5WSk=;
  b=gmokPjIAgmTJwyzYSlSqmD0/XLuybDK8KVnoNTC/Cx2JxYeeMt+jQatm
   5u/WcSuRpm/aPltEkS2cNRhq91/r9BgBa+bi1izIwpsX9mCZbVHppDNgW
   fbkUMoN82COf08nGUPqKvFhNPVGr8BZ8cuECyD8Du/KME0aQdbfq4Z83O
   k=;
X-IronPort-AV: E=Sophos;i="6.11,187,1725321600"; 
   d="scan'208";a="237721142"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO smtpout.prod.us-east-1.prod.farcaster.email.amazon.dev) ([10.43.8.2])
  by smtp-border-fw-52004.iad7.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 17:48:03 +0000
Received: from EX19MTAUWA001.ant.amazon.com [10.0.21.151:33737]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.23:2525] with esmtp (Farcaster)
 id 064efbfd-710e-439c-af15-e93a74588667; Tue, 8 Oct 2024 17:48:01 +0000 (UTC)
X-Farcaster-Flow-ID: 064efbfd-710e-439c-af15-e93a74588667
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWA001.ant.amazon.com (10.250.64.218) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 8 Oct 2024 17:48:01 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 8 Oct 2024 17:47:58 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <alexandre.ferrieux@gmail.com>
CC: <alexandre.ferrieux@orange.com>, <edumazet@google.com>,
	<horms@kernel.org>, <netdev@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>, <linux-wireless@vger.kernel.org>,
	<kuniyu@amazon.com>
Subject: Re: RFC: Should net namespaces scale up (>10k) ?
Date: Tue, 8 Oct 2024 10:47:51 -0700
Message-ID: <20241008174751.2995-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <CAKYWH0Ti3=4GeeuVyWKJ9LyTuRnf3Wy9GKg4Jb7tdeaT39qADA@mail.gmail.com>
References: <CAKYWH0Ti3=4GeeuVyWKJ9LyTuRnf3Wy9GKg4Jb7tdeaT39qADA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D038UWB002.ant.amazon.com (10.13.139.185) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

+Johannes and wireless ML.

From: Alexandre Ferrieux <alexandre.ferrieux@gmail.com>
Date: Sun, 15 Sep 2024 22:49:22 +0200
> (thanks Simon, reposting with another account to avoid the offending disclaimer)
> 
> Hi,
> 
> Currently, netns don't really scale beyond a few thousands, for
> mundane reasons (see below). But should they ? Is there, in the
> design, an assumption that tens of thousands of network namespaces are
> considered "unreasonable" ?
> 
> A typical use case for such ridiculous numbers is a tester for
> firewalls or carrier-grade NATs. In these, you typically want tens of
> thousands of tunnels, each of which is perfectly instantiated as an
> interface. And, to avoid an explosion in source routing rules, you
> want them in separate namespaces.
> 
> Now why don't they scale *today* ? For two independent, seemingly
> accidental, O(N) scans of the netns list.
> 
> 1. The "netdevice notifier" from the Wireless Extensions subsystem
> insists on scanning the whole list regardless of the nature of the
> change, nor wondering whether all these namespaces hold any wireless
> interface, nor even whether the system has _any_ wireless hardware...
> 
>         for_each_net(net) {
>                 while ((skb = skb_dequeue(&net->wext_nlevents)))
>                         rtnl_notify(skb, net, 0, RTNLGRP_LINK, NULL,
>                                     GFP_KERNEL);
>         }
>

Alex forwarded this mail to me and asked about 1.

I checked 8bf862739a778, but I didn't see why wext_netdev_notifier_call()
needs to iterate all netns.

Is there a case where flushing messages in the notified dev's netns is not
enough for wext dev ?

---8<---
diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
index 838ad6541a17..d4b613fc650c 100644
--- a/net/wireless/wext-core.c
+++ b/net/wireless/wext-core.c
@@ -343,17 +343,22 @@ static const int compat_event_type_size[] = {
 
 /* IW event code */
 
-void wireless_nlevent_flush(void)
+static void wireless_nlevent_flush_net(struct net *net)
 {
 	struct sk_buff *skb;
+
+	while ((skb = skb_dequeue(&net->wext_nlevents)))
+		rtnl_notify(skb, net, 0, RTNLGRP_LINK, NULL,
+			    GFP_KERNEL);
+}
+
+void wireless_nlevent_flush(void)
+{
 	struct net *net;
 
 	down_read(&net_rwsem);
-	for_each_net(net) {
-		while ((skb = skb_dequeue(&net->wext_nlevents)))
-			rtnl_notify(skb, net, 0, RTNLGRP_LINK, NULL,
-				    GFP_KERNEL);
-	}
+	for_each_net(net)
+		wireless_nlevent_flush_net(net);
 	up_read(&net_rwsem);
 }
 EXPORT_SYMBOL_GPL(wireless_nlevent_flush);
@@ -361,6 +366,8 @@ EXPORT_SYMBOL_GPL(wireless_nlevent_flush);
 static int wext_netdev_notifier_call(struct notifier_block *nb,
 				     unsigned long state, void *ptr)
 {
+	struct net_device *dev = netdev_notifier_info_to_dev(ptr);
+
 	/*
 	 * When a netdev changes state in any way, flush all pending messages
 	 * to avoid them going out in a strange order, e.g. RTM_NEWLINK after
@@ -368,7 +375,7 @@ static int wext_netdev_notifier_call(struct notifier_block *nb,
 	 * or similar - all of which could otherwise happen due to delays from
 	 * schedule_work().
 	 */
-	wireless_nlevent_flush();
+	wireless_nlevent_flush_net(dev_net(dev));
 
 	return NOTIFY_OK;
 }
---8<---

