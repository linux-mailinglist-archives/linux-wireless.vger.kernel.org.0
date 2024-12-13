Return-Path: <linux-wireless+bounces-16361-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 507F69F0674
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 09:36:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E8C188ACBF
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 08:36:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E71E61AA1E1;
	Fri, 13 Dec 2024 08:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b="qE17iWIn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp-fw-6002.amazon.com (smtp-fw-6002.amazon.com [52.95.49.90])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDAF21A8F89;
	Fri, 13 Dec 2024 08:36:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=52.95.49.90
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734078980; cv=none; b=TdVdFG1DToP4OBNclgVdQD3VuLcprnGmyzuO/j3VeYtCUuGdkLEstRXIpFl8HWnDN5AYRYERfhzsdPaiBnMF/8uw4/4S75/YwFM8FX6eROzN6mQRjvBJqXJEVooWKAIFyjIcYh5qHkDTwTC6x3tOEL2ybDWYsbsiIe0Pkw5qBic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734078980; c=relaxed/simple;
	bh=iIqF6YPbraicQQ/unRv/YNWsk5+yLSAQ9J3YLP7cLjc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=LWlyIidbOL3mrxtkhFMZ4hwcDKpGBEGjlsVvhw/3vwhdWK7VKEjQlMcPpCFJat0dvef1MHYfzE3ZdIKkGjthV1ulvtbWeSEqUbRbq5K35iR3X5/wfonzceTGtyZXCwHmt2EY3gES4Lb7YO+owCEJ8SSEOvzF7XiVQcfzOlGq4zY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com; spf=pass smtp.mailfrom=amazon.co.jp; dkim=pass (1024-bit key) header.d=amazon.com header.i=@amazon.com header.b=qE17iWIn; arc=none smtp.client-ip=52.95.49.90
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amazon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=amazon.co.jp
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1734078980; x=1765614980;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=2AxhSclKsu32dkton7UtZYZFiO//vi/AGe7eUOoTBXg=;
  b=qE17iWInpJcdIZKeimoCbqSN2xenhJKj5QeUhuK+DQ1bP0I2GVNBisrp
   5s/lxbIGp4G7RQblnw7oquOkQlthH/IcMMoYafWXENB+qUfGgsuSMqesQ
   KyEV9oFtNG8KVzKWVFC9mjjrJ4y5DnfGsfkbp5Ciz0w0mmh3BJUzGyHfL
   I=;
X-IronPort-AV: E=Sophos;i="6.12,230,1728950400"; 
   d="scan'208";a="455754317"
Received: from iad12-co-svc-p1-lb1-vlan3.amazon.com (HELO smtpout.prod.us-west-2.prod.farcaster.email.amazon.dev) ([10.43.8.6])
  by smtp-border-fw-6002.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Dec 2024 08:36:16 +0000
Received: from EX19MTAUWC001.ant.amazon.com [10.0.21.151:48785]
 by smtpin.naws.us-west-2.prod.farcaster.email.amazon.dev [10.0.33.57:2525] with esmtp (Farcaster)
 id 37a2e523-9e48-4cd6-97db-f4b56a9688bf; Fri, 13 Dec 2024 08:36:14 +0000 (UTC)
X-Farcaster-Flow-ID: 37a2e523-9e48-4cd6-97db-f4b56a9688bf
Received: from EX19D004ANA001.ant.amazon.com (10.37.240.138) by
 EX19MTAUWC001.ant.amazon.com (10.250.64.174) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 08:36:14 +0000
Received: from 6c7e67c6786f.amazon.com (10.119.14.208) by
 EX19D004ANA001.ant.amazon.com (10.37.240.138) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1258.39;
 Fri, 13 Dec 2024 08:36:10 +0000
From: Kuniyuki Iwashima <kuniyu@amazon.com>
To: <johannes@sipsolutions.net>
CC: <jv@jvosburgh.net>, <linux-kernel@vger.kernel.org>,
	<linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>,
	<syzbot+3647b9259b77c1bb8e94@syzkaller.appspotmail.com>,
	<syzkaller-bugs@googlegroups.com>, <kuniyu@amazon.com>
Subject: Re: [syzbot] [wireless?] BUG: sleeping function called from invalid context in wext_netdev_notifier_call
Date: Fri, 13 Dec 2024 17:36:07 +0900
Message-ID: <20241213083607.8520-1-kuniyu@amazon.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <301ccb4cf2451c748d2b9b68648be7cfadf75c6a.camel@sipsolutions.net>
References: <301ccb4cf2451c748d2b9b68648be7cfadf75c6a.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EX19D031UWA004.ant.amazon.com (10.13.139.19) To
 EX19D004ANA001.ant.amazon.com (10.37.240.138)

From: Johannes Berg <johannes@sipsolutions.net>
Date: Thu, 12 Dec 2024 09:52:44 +0100
> On Wed, 2024-12-11 at 20:41 -0800, syzbot wrote:
> > CPU: 1 UID: 0 PID: 12894 Comm: kworker/u8:18 Not tainted 6.13.0-rc1-syzkaller-00183-g4c49f38e20a5 #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 09/13/2024
> > Workqueue: bond0 bond_mii_monitor
> > Call Trace:
> >  <TASK>
> >  __dump_stack lib/dump_stack.c:94 [inline]
> >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> >  __might_resched+0x5d4/0x780 kernel/sched/core.c:8758
> >  down_read+0x8e/0xa40 kernel/locking/rwsem.c:1523
> >  wireless_nlevent_flush net/wireless/wext-core.c:351 [inline]
> >  wext_netdev_notifier_call+0x1f/0x120 net/wireless/wext-core.c:371
> >  notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
> >  netdev_state_change+0x11f/0x1a0 net/core/dev.c:1378
> >  linkwatch_do_dev+0x112/0x170 net/core/link_watch.c:182
> >  ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
> >  bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:873
> >  bond_miimon_inspect drivers/net/bonding/bond_main.c:2740 [inline]
> >  bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2962
> 
> Yeah this isn't new. I thought we were going to just squash this with
> 
> https://lore.kernel.org/netdev/2730097.1721581672@famine/
> 
> Whatever came of that?

Now I remember I forgot to respin this patch.
https://lore.kernel.org/linux-wireless/20241014205543.94787-4-kuniyu@amazon.com/

If the issue above is still not fixed, I will respin it on
wireless.git with Fixes tag.

What do you think ?



