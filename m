Return-Path: <linux-wireless+bounces-16365-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A574A9F06DA
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 09:46:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 11E53188B34A
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 08:46:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9A671ACDF0;
	Fri, 13 Dec 2024 08:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="URCMUdDR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-fw-9106.amazon.com (smtp-fw-9106.amazon.com [207.171.188.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1BB0618FC8C;
	Fri, 13 Dec 2024 08:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=207.171.188.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079559; cv=none; b=TAZBHQNrjf3f0ZHv9GLP9K9zR7zLYAxbhYO0HAVDfQ7NYpBEFMDvyNujPM0/lp0JyfKzlTI5pnLJTZLCwFaCbp6r6r2uzb3HpYf/TuX/bN4RRQ67CVXn0n9lY1a9YlrsbpZsMclIbBdmyLBVrWz2UYQzb22yoUyaPoYAdcvL6mQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079559; c=relaxed/simple;
	bh=7tOsFkhegUXi46ykiN36/Nom6dJDvLgVB3l+A8GE1rI=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=dINuL404WHyxNawVNUPuAt/d2gcLi5Vfv715fjV0VulhKI4VMjZG1y4HKakPHwlL6cl//ObiWFwWzNsj5jWcpLJ0oNM2VKkZUFwmaziCQW394W/952JqDPtdiiWpZL6vKQU+XX+8kNGKs5Mgo/ur9vf6sLJJY+Vf1dGIZX14tUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=URCMUdDR; arc=none smtp.client-ip=207.171.188.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734079560; x=1765615560;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=FTLQQ3ciLT+wfJ7M5N5AU0bTlDD2VxYKtx/rr7kHNjo=;
  b=URCMUdDRl8lJT88EpfAv0yP3NuloqapTW1F+9yUx82VLS1hqDsWWfjtK
   fyJG0joRusKu51Cz2bG7MSxvX4M29RhPo0M6/tkZ72k8XGmtMpwksi872
   pS6mE3CFubNN90pvMvw9Ow4bkMk5yFLlgE61bqD2k6UI3uIdnAy1gIUOp
   Q=;
X-IronPort-AV: E=Sophos;i="6.12,230,1728950400"; 
   d="scan'208";a="783108223"
Received: from pdx4-co-svc-p1-lb2-vlan2.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.25.36.210])
  by smtp-border-fw-9106.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 08:45:56 +0000
Received: from EX19MTAUWC002.ant.amazon.com [10.0.7.35:46046]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.59.69:2525] with esmtp (Farcaster)
 id f3d5d3de-f273-46d6-997e-d54eceaa6d55; Fri, 13 Dec 2024 08:45:54 +0000 (UTC)
X-Farcaster-Flow-ID: f3d5d3de-f273-46d6-997e-d54eceaa6d55
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 08:45:53 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 08:45:50 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <johannes@sipsolutions.net>
CC: <jv@jvosburgh.net>, <kuniyu@amazon.com>, <linux-kernel@vger.kernel.org>,
	<linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
	<syzbot+3647b9259b77c1bb8e94@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>
Subject: Re: [syzbot] [wireless?] BUG: sleeping function called from invalid context in wext_netdev_notifier_call
Date: Fri, 13 Dec 2024 17:45:47 +0900
Message-ID: <20241213084547.9791-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <104be155826cbf9ba3b3e65fa5186b39dbcf4906.camel@sipsolutions.net>
References: <104be155826cbf9ba3b3e65fa5186b39dbcf4906.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D044UWB001.ant.amazon.com (10.13.139.171) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Johannes Berg <johannes@sipsolutions.net>
Date: Fri, 13 Dec 2024 09:39:04 +0100
> On Fri, 2024-12-13 at 17:36 +0900, Kuniyuki Iwashima wrote:
> > From: Johannes Berg <johannes@sipsolutions.net>
> > Date: Thu, 12 Dec 2024 09:52:44 +0100
> > > On Wed, 2024-12-11 at 20:41 -0800, syzbot wrote:
> > > > CPU: 1 UID: 0 PID: 12894 Comm: kworker/u8:18 Not tainted 6.13.0-rc1-syzkaller-00183-g4c49f38e20a5 #0
> > > > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> > > > Workqueue: bond0 bond_mii_monitor
> > > > Call Trace:
> > > >  <TASK>
> > > >  __dump_stack lib/dump_stack.c:94 [inline]
> > > >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> > > >  __might_resched+0x5d4/0x780 kernel/sched/core.c:8758
> > > >  down_read+0x8e/0xa40 kernel/locking/rwsem.c:1523
> > > >  wireless_nlevent_flush net/wireless/wext-core.c:351 [inline]
> > > >  wext_netdev_notifier_call+0x1f/0x120 net/wireless/wext-core.c:371
> > > >  notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
> > > >  netdev_state_change+0x11f/0x1a0 net/core/dev.c:1378
> > > >  linkwatch_do_dev+0x112/0x170 net/core/link_watch.c:182
> > > >  ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
> > > >  bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:873
> > > >  bond_miimon_inspect drivers/net/bonding/bond_main.c:2740 [inline]
> > > >  bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2962
> > > 
> > > Yeah this isn't new. I thought we were going to just squash this with
> > > 
> > > https://lore.kernel.org/netdev/2730097.1721581672@famine/
> > > 
> > > Whatever came of that?
> > 
> > Now I remember I forgot to respin this patch.
> > https://lore.kernel.org/linux-wireless/20241014205543.94787-4-kuniyu@amazon.com/
> > 
> > If the issue above is still not fixed, I will respin it on
> > wireless.git with Fixes tag.
> 
> Wait, that's not related at all? The bonding issue still is that it
> calls ethtool ops under RCU but ethtool ops can sleep. That issue has
> nothing to do with the wext nlevent namespace-ification?

Ah okay, I thought removing the mutex there was another option
to silence it, but I didn't check other places.

> 
> 
> We can still do the namespace thing for wext nlevent, but it's not going
> to fix this issue, and I don't think we need to on wireless (rather than
> wireless-next)

I see, will post to -next.

Thanks!

