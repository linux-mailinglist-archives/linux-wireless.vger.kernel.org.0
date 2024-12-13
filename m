Return-Path: <linux-wireless+bounces-16363-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 159129F0689
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 09:39:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 31A0B166F2C
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Dec 2024 08:39:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A03A41AA7B4;
	Fri, 13 Dec 2024 08:39:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="K71SpjP4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C81161AA789;
	Fri, 13 Dec 2024 08:39:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734079156; cv=none; b=qCcxEKvM7+BXc7xy+hd/yJ3BDFNhlAoYB/Wke0B35pKqROpWCBJfC/oGTJzMz4wO9bdyph0zzwmwbNLqFac/Rg7USFDGzqOW3pbztpy9BMGxPyRJHz+WFv6facPtCzhETYzYlvOuSNiSuQJQUHKnl6d5BO4Fwd+1ITa945CfETQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734079156; c=relaxed/simple;
	bh=Wuc1rQ4nZcih7sGyKwzNTjxL/+GXCsNYiAEkp6eIfzE=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=lSl9XkMBQJeUE0vl/giXWxncX81SNTzlNhtC/OgM0+6JBKkCgw0dXhunpMbdKEYmTLQrDqW5b5CIsWGvEqev0VLKmng7a7buZ7XyaqnzmYZsUJ2JZW3o+ZkaQ8HDwDdOAYb2jHkI5SvRn6kACtrpsj2xtnlFj9YZ9IOuxxcvD/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=K71SpjP4; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=c2tm0O1Fl9XERg7MDuC4aahqChWMFK/kmdhCvqemab8=;
	t=1734079154; x=1735288754; b=K71SpjP4upyZsKwjJQ4wPLTPNcwNGywW50JYy1De0SmUEVd
	1jHIZmnobv5m1jF6FQcR7HG4yCEOiHj0VBspcYmmS5F8lz+N177T6grir4h3B1gukdSFCJWA4pzNZ
	/AdAAo+dKluhLj3rUs3oiXH5zSL8PVJTvwXSIpk7vBAQ0QEEl9ND1OAJTwf94X1nvDTSsWn8+9rlU
	HJAABmEoHYLonlWZR6kQ196juhq/QxDDgfWBuP8GGEAbIDZpnbO8mqN7PK+601684Rz4u9DDT0wmh
	RXN5IuvLeCXVSPhQWCt2oLrL6x1j67s6LOlEFPef5fPTCH8Zf5v/2029knB/giRw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tM1CT-0000000FPOu-1OgI;
	Fri, 13 Dec 2024 09:39:05 +0100
Message-ID: <104be155826cbf9ba3b3e65fa5186b39dbcf4906.camel@sipsolutions.net>
Subject: Re: [syzbot] [wireless?] BUG: sleeping function called from invalid
 context in wext_netdev_notifier_call
From: Johannes Berg <johannes@sipsolutions.net>
To: Kuniyuki Iwashima <kuniyu@amazon.com>
Cc: jv@jvosburgh.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzbot+3647b9259b77c1bb8e94@syzkaller.appspotmail.com, 
	syzkaller-bugs@googlegroups.com
Date: Fri, 13 Dec 2024 09:39:04 +0100
In-Reply-To: <20241213083607.8520-1-kuniyu@amazon.com>
References: 
	<301ccb4cf2451c748d2b9b68648be7cfadf75c6a.camel@sipsolutions.net>
	 <20241213083607.8520-1-kuniyu@amazon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.2 (3.54.2-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Fri, 2024-12-13 at 17:36 +0900, Kuniyuki Iwashima wrote:
> From: Johannes Berg <johannes@sipsolutions.net>
> Date: Thu, 12 Dec 2024 09:52:44 +0100
> > On Wed, 2024-12-11 at 20:41 -0800, syzbot wrote:
> > > CPU: 1 UID: 0 PID: 12894 Comm: kworker/u8:18 Not tainted 6.13.0-rc1-s=
yzkaller-00183-g4c49f38e20a5 #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 09/13/2024
> > > Workqueue: bond0 bond_mii_monitor
> > > Call Trace:
> > >  <TASK>
> > >  __dump_stack lib/dump_stack.c:94 [inline]
> > >  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
> > >  __might_resched+0x5d4/0x780 kernel/sched/core.c:8758
> > >  down_read+0x8e/0xa40 kernel/locking/rwsem.c:1523
> > >  wireless_nlevent_flush net/wireless/wext-core.c:351 [inline]
> > >  wext_netdev_notifier_call+0x1f/0x120 net/wireless/wext-core.c:371
> > >  notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
> > >  netdev_state_change+0x11f/0x1a0 net/core/dev.c:1378
> > >  linkwatch_do_dev+0x112/0x170 net/core/link_watch.c:182
> > >  ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
> > >  bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:873
> > >  bond_miimon_inspect drivers/net/bonding/bond_main.c:2740 [inline]
> > >  bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2962
> >=20
> > Yeah this isn't new. I thought we were going to just squash this with
> >=20
> > https://lore.kernel.org/netdev/2730097.1721581672@famine/
> >=20
> > Whatever came of that?
>=20
> Now I remember I forgot to respin this patch.
> https://lore.kernel.org/linux-wireless/20241014205543.94787-4-kuniyu@amaz=
on.com/
>=20
> If the issue above is still not fixed, I will respin it on
> wireless.git with Fixes tag.

Wait, that's not related at all? The bonding issue still is that it
calls ethtool ops under RCU but ethtool ops can sleep. That issue has
nothing to do with the wext nlevent namespace-ification?


We can still do the namespace thing for wext nlevent, but it's not going
to fix this issue, and I don't think we need to on wireless (rather than
wireless-next)

johannes

