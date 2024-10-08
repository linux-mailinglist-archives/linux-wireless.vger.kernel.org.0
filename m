Return-Path: <linux-wireless+bounces-13731-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B35A4995747
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 20:57:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7316028902C
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Oct 2024 18:57:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BA482212D38;
	Tue,  8 Oct 2024 18:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="JoL8C09S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-fw-80008.amazon.com (smtp-fw-80008.amazon.com [99.78.197.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3DE9A21263C;
	Tue,  8 Oct 2024 18:56:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=99.78.197.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728413820; cv=none; b=DrKazVaMgaC/YLTSSNCnsyiLgkK5yVgSWChrL8Gk+EFZ4/0q0bSqWaodpgtwDNWYA4YmcIrw1krDiJ+oAxJNZti6dJ2OD+ZPTrNo6IfzESb3UvvBYpHahn3L4XoCixmSnBupko5QgAN0QTAYblNa6Q+4P5gHmKCmL5odtJHSLTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728413820; c=relaxed/simple;
	bh=VwNWaWIVxbDyLLLL/EJoMVhKF/r2JvlnR4UN4DfT2Dg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s1sPCak9D9i69QkWxxOU6TWc7kK/tp6JV3AmroYHoKrz6wQLTY8Py2+OWiw0kg+zQ5/+0N4TnWrISIWNUAa8UEvQN4nbc4I+xq1CDvKOfC+RcIjF1B4ald4F0VZRmm0J1TuPlNZvx+wYleLTmVosxLIlGPV2oEqZ4XtDpSyu5Fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=JoL8C09S; arc=none smtp.client-ip=99.78.197.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1728413819; x=1759949819;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=JK3hLHdGBhlmZHto2d7jkVXOrpL9yD9Nk0HLi6Y6wEo=;
  b=JoL8C09SSLqRIX6IMLSPx/rLGrqvm51cvojfq1INz8CTZm7ZI0HVELKg
   b8KINIFCnuc7ZR99jXk1zjCdyH5gtSk8qFe++mzF7B/bYxkJ63S2InpEm
   HlnbXyhDWzPTkyxljd3qIjKr8T9EJUQTDdsfzftkf2tcu5I1F7LPUc3yg
   w=;
X-IronPort-AV: E=Sophos;i="6.11,187,1725321600"; 
   d="scan'208";a="136770585"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.214])
  by smtp-border-fw-80008.pdx80.corp.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Oct 2024 18:56:58 +0000
Received: from EX19MTAUWB001.ant.amazon.com [10.0.21.151:24979]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.49.108:2525] with esmtp (Farcaster)
 id ae7694b7-89df-46c8-975a-1e650f51393e; Tue, 8 Oct 2024 18:56:58 +0000 (UTC)
X-Farcaster-Flow-ID: ae7694b7-89df-46c8-975a-1e650f51393e
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWB001.ant.amazon.com (10.250.64.248) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.34;
 Tue, 8 Oct 2024 18:56:57 +0000
Received: from 88665a182662.ant.amazon.com (10.187.170.17) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.35;
 Tue, 8 Oct 2024 18:56:55 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <johannes@sipsolutions.net>
CC: <alexandre.ferrieux@gmail.com>, <alexandre.ferrieux@orange.com>,
	<edumazet@google.com>, <horms@kernel.org>, <kuniyu@amazon.com>,
	<linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>
Subject: Re: RFC: Should net namespaces scale up (>10k) ?
Date: Tue, 8 Oct 2024 11:56:47 -0700
Message-ID: <20241008185647.10517-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <cd8045c03573a012f71a1afdcfb5d9c108b6fefa.camel@sipsolutions.net>
References: <cd8045c03573a012f71a1afdcfb5d9c108b6fefa.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D036UWC001.ant.amazon.com (10.13.139.233) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Johannes Berg <johannes@sipsolutions.net>
Date: Tue, 08 Oct 2024 20:22:38 +0200
> On Tue, 2024-10-08 at 10:47 -0700, Kuniyuki Iwashima wrote:
> 
> > > 1. The "netdevice notifier" from the Wireless Extensions subsystem
> > > insists on scanning the whole list regardless of the nature of the
> > > change, nor wondering whether all these namespaces hold any wireless
> > > interface, nor even whether the system has _any_ wireless hardware...
> > > 
> > >         for_each_net(net) {
> > >                 while ((skb = skb_dequeue(&net->wext_nlevents)))
> > >                         rtnl_notify(skb, net, 0, RTNLGRP_LINK, NULL,
> > >                                     GFP_KERNEL);
> > >         }
> > > 
> > 
> > Alex forwarded this mail to me and asked about 1.
> > 
> > I checked 8bf862739a778, but I didn't see why wext_netdev_notifier_call()
> > needs to iterate all netns.
> 
> Agree. That code is ancient, and I don't remember why, but I'd think
> it's just because I was lazy then.
> 
> > diff --git a/net/wireless/wext-core.c b/net/wireless/wext-core.c
> > index 838ad6541a17..d4b613fc650c 100644
> > --- a/net/wireless/wext-core.c
> > +++ b/net/wireless/wext-core.c
> > @@ -343,17 +343,22 @@ static const int compat_event_type_size[] = {
> >  
> >  /* IW event code */
> >  
> > -void wireless_nlevent_flush(void)
> > +static void wireless_nlevent_flush_net(struct net *net)
> >  {
> >  	struct sk_buff *skb;
> > +
> > +	while ((skb = skb_dequeue(&net->wext_nlevents)))
> > +		rtnl_notify(skb, net, 0, RTNLGRP_LINK, NULL,
> > +			    GFP_KERNEL);
> > +}
> > +
> > +void wireless_nlevent_flush(void)
> > +{
> >  	struct net *net;
> >  
> >  	down_read(&net_rwsem);
> > -	for_each_net(net) {
> > -		while ((skb = skb_dequeue(&net->wext_nlevents)))
> > -			rtnl_notify(skb, net, 0, RTNLGRP_LINK, NULL,
> > -				    GFP_KERNEL);
> > -	}
> > +	for_each_net(net)
> > +		wireless_nlevent_flush_net(net);
> >  	up_read(&net_rwsem);
> >  }
> >  EXPORT_SYMBOL_GPL(wireless_nlevent_flush);
> 
> Note 1: I just posted this patch yesterday:
> https://lore.kernel.org/linux-wireless/20241007214715.3dd736dc3ac0.I1388536e99c37f28a007dd753c473ad21513d9a9@changeid/
> 
> so that would conflict here, I'd think.
> 
> Note 2: the only other caller to wireless_nlevent_flush() is from
> wireless_nlevent_process()/wireless_nlevent_work, and that work could
> easily be made per netns since it comes along with net->wext_nlevents,
> and then we don't need any global function at all. Seems this could be
> implemented in wext_pernet_init()/wext_pernet_exit() pretty easily?

Sounds good.

I'll post a patch after yours lands on wireless-next.

Thanks!

