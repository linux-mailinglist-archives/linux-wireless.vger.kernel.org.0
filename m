Return-Path: <linux-wireless+bounces-16297-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5DC49EE1E7
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 09:52:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4DC371675D4
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Dec 2024 08:52:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CA7620E013;
	Thu, 12 Dec 2024 08:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="vRrG1WX1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D491A209F41;
	Thu, 12 Dec 2024 08:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733993569; cv=none; b=reNQTnry5bR1HOaANcMIpSi3DSZu6VEqMQq7XfOnJEtt/je9ZQF+2OkDWTIm7i3+qbCIJ5MAbgW02hPW6QAzgdL3mmbgsiZR1iG78g2s9joSENAnY7oi6nUpPmDU9NKFLrvSJ/rbOSA8tdphN+CwS15OXxOi896f28HI8W7lG+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733993569; c=relaxed/simple;
	bh=zKYRiVDZDdBDBpZiIGg3izZHsTSSNFJWT7GjC/8Wi0s=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=sh6JuCXmveYwAXCKvY+dCbETfnSJ/eODP5cvQ2HUbFBcj6vS9cI/72MQ0edPK3ZF2tUJSzM+UuGy609cePp+APlJjNX1Dfs7w9lb2vnFRN+G+Z5zz2LNGH6qeFDQRKP5Bfb65arpiEKi/kwCxtTMR3DDA9ibkC8cm+Zb8wY3W3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=vRrG1WX1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=qLj+Afwh+9fhcCfqdeum+6vZlKylpxMDdFRhWoqXL3Y=;
	t=1733993567; x=1735203167; b=vRrG1WX1ErFVHH0mfEJ/6xrr5hgWr8F1SxOfe48kVifU/tm
	SUoEI96BQ4RPX6wD9643QAAMi9vGa85tK7hSpiGpJvEVDW7e33BQ39VVha1mh289Up188HxaqCCFO
	QpQbIVa/D1MkJoecOjOVMhHOc9VGIkhy/oHaqRvLrAD4gzxuPvyBj91tHK5DiSkxi3EkffAPIYsh4
	P/6sFOre7K9VDrsD9d5S2KX+nIfPtnxnlAt2X3vw1ZvI3n5/3qYTG1dguST3nzDaPAQSK0cuIyYlM
	9IvJxxepJ2bGNX8DHNx5/fvLdtfvhacMu4pDfTjxKfD3widmlSFbNJSgUFco77Rg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98)
	(envelope-from <johannes@sipsolutions.net>)
	id 1tLew9-0000000EMrs-1QBk;
	Thu, 12 Dec 2024 09:52:45 +0100
Message-ID: <301ccb4cf2451c748d2b9b68648be7cfadf75c6a.camel@sipsolutions.net>
Subject: Re: [syzbot] [wireless?] BUG: sleeping function called from invalid
 context in wext_netdev_notifier_call
From: Johannes Berg <johannes@sipsolutions.net>
To: syzbot <syzbot+3647b9259b77c1bb8e94@syzkaller.appspotmail.com>, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Cc: Jay Vosburgh <jv@jvosburgh.net>
Date: Thu, 12 Dec 2024 09:52:44 +0100
In-Reply-To: <675a6973.050a0220.17f54a.0050.GAE@google.com>
References: <675a6973.050a0220.17f54a.0050.GAE@google.com>
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

On Wed, 2024-12-11 at 20:41 -0800, syzbot wrote:
> CPU: 1 UID: 0 PID: 12894 Comm: kworker/u8:18 Not tainted 6.13.0-rc1-syzka=
ller-00183-g4c49f38e20a5 #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 09/13/2024
> Workqueue: bond0 bond_mii_monitor
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  __might_resched+0x5d4/0x780 kernel/sched/core.c:8758
>  down_read+0x8e/0xa40 kernel/locking/rwsem.c:1523
>  wireless_nlevent_flush net/wireless/wext-core.c:351 [inline]
>  wext_netdev_notifier_call+0x1f/0x120 net/wireless/wext-core.c:371
>  notifier_call_chain+0x1a5/0x3f0 kernel/notifier.c:85
>  netdev_state_change+0x11f/0x1a0 net/core/dev.c:1378
>  linkwatch_do_dev+0x112/0x170 net/core/link_watch.c:182
>  ethtool_op_get_link+0x15/0x60 net/ethtool/ioctl.c:62
>  bond_check_dev_link+0x1f1/0x3f0 drivers/net/bonding/bond_main.c:873
>  bond_miimon_inspect drivers/net/bonding/bond_main.c:2740 [inline]
>  bond_mii_monitor+0x49a/0x3170 drivers/net/bonding/bond_main.c:2962

Yeah this isn't new. I thought we were going to just squash this with

https://lore.kernel.org/netdev/2730097.1721581672@famine/

Whatever came of that?

johannes

