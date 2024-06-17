Return-Path: <linux-wireless+bounces-9058-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F81990AC53
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 12:56:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D2AEB2626D
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Jun 2024 10:47:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AD141946D1;
	Mon, 17 Jun 2024 10:44:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="evVuYRwP"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C0841946B1;
	Mon, 17 Jun 2024 10:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718621085; cv=none; b=YMdi54pq6kpH9J8kb92wPudnW0CO+N5y6IVTCi0oh6ZxJRm1tvbwq4xrmutlxNRfUWGutew4LbZ9dScYnL5M0r4YJj40KpbJ4M0QjB5kkAJNrtqzqLRVW5wHw2DSmFvrcxIr9i2pJwhW+2vQe0vhgWPEhHUebvNaovg1xOkj6ig=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718621085; c=relaxed/simple;
	bh=/vjjLVZvlmn9Hg6zNJl4AEETdPjNk5RyTQ9ALafpsFE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HenxhCgHDsQUytgqoG4LEP2FxftsSEytsPu36URnSIW0UTKBtKuTCkr8ngIZhREzD9eoDrJD/vBUTM+kPlfCRZbPbO9SWvK48qS0suMdbfvzxRNgllb47vgnfwQ/EzAjPRwC2+6rTUYr9GdZPHZWuR6C6VcUByGoVDDfsFdGJuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=evVuYRwP; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1718620502; bh=/vjjLVZvlmn9Hg6zNJl4AEETdPjNk5RyTQ9ALafpsFE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=evVuYRwPIsNUrliAP3flhckXpGf2vEGyGAwDv/UuVxdV2Xko0uhiCPYSSLduXbQOU
	 jKj6a8SCCIDoQwQaoXBJ6eZjhZN279ms+3ntaureLSPasyj5Ah5Qf3bJwkKs6Zz05g
	 vRsKbd7KEVWSbDtd0b+tC/ArCMHYmQf01A8BsJ4PaZYQOg1xxJU7LcsHmAtJIxF2T4
	 31J4GDCg/NkoN4GwS6iIhbKhVl/oPw7VwT2hg2X3onoPk+XMYxb/9fqjSKxMh9JT1b
	 q93xd2k+6J5gNF7AA3qkBE+CTXF26rAgLCLJc3/jTyZ5gPR44mgP94aJFiHg/XQggt
	 oGdUV7ZkkIh8w==
To: Eric Dumazet <edumazet@google.com>, "David S . Miller"
 <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni
 <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>
Subject: Re: [PATCH net] wifi: cfg80211: restrict NL80211_ATTR_TXQ_QUANTUM
 values
In-Reply-To: <20240615160800.250667-1-edumazet@google.com>
References: <20240615160800.250667-1-edumazet@google.com>
Date: Mon, 17 Jun 2024 12:35:00 +0200
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87sexbsvqj.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> syzbot is able to trigger softlockups, setting NL80211_ATTR_TXQ_QUANTUM
> to 2^31.
>
> We had a similar issue in sch_fq, fixed with commit
> d9e15a273306 ("pkt_sched: fq: do not accept silly TCA_FQ_QUANTUM")
>
> watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [kworker/1:0:24]
> Modules linked in:
> irq event stamp: 131135
>  hardirqs last  enabled at (131134): [<ffff80008ae8778c>] __exit_to_kerne=
l_mode arch/arm64/kernel/entry-common.c:85 [inline]
>  hardirqs last  enabled at (131134): [<ffff80008ae8778c>] exit_to_kernel_=
mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:95
>  hardirqs last disabled at (131135): [<ffff80008ae85378>] __el1_irq arch/=
arm64/kernel/entry-common.c:533 [inline]
>  hardirqs last disabled at (131135): [<ffff80008ae85378>] el1_interrupt+0=
x24/0x68 arch/arm64/kernel/entry-common.c:551
>  softirqs last  enabled at (125892): [<ffff80008907e82c>] neigh_hh_init n=
et/core/neighbour.c:1538 [inline]
>  softirqs last  enabled at (125892): [<ffff80008907e82c>] neigh_resolve_o=
utput+0x268/0x658 net/core/neighbour.c:1553
>  softirqs last disabled at (125896): [<ffff80008904166c>] local_bh_disabl=
e+0x10/0x34 include/linux/bottom_half.h:19
> CPU: 1 PID: 24 Comm: kworker/1:0 Not tainted 6.9.0-rc7-syzkaller-gfda5695=
d692c #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 03/27/2024
> Workqueue: mld mld_ifc_work
> pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>  pc : __list_del include/linux/list.h:195 [inline]
>  pc : __list_del_entry include/linux/list.h:218 [inline]
>  pc : list_move_tail include/linux/list.h:310 [inline]
>  pc : fq_tin_dequeue include/net/fq_impl.h:112 [inline]
>  pc : ieee80211_tx_dequeue+0x6b8/0x3b4c net/mac80211/tx.c:3854
>  lr : __list_del_entry include/linux/list.h:218 [inline]
>  lr : list_move_tail include/linux/list.h:310 [inline]
>  lr : fq_tin_dequeue include/net/fq_impl.h:112 [inline]
>  lr : ieee80211_tx_dequeue+0x67c/0x3b4c net/mac80211/tx.c:3854
> sp : ffff800093d36700
> x29: ffff800093d36a60 x28: ffff800093d36960 x27: dfff800000000000
> x26: ffff0000d800ad50 x25: ffff0000d800abe0 x24: ffff0000d800abf0
> x23: ffff0000e0032468 x22: ffff0000e00324d4 x21: ffff0000d800abf0
> x20: ffff0000d800abf8 x19: ffff0000d800abf0 x18: ffff800093d363c0
> x17: 000000000000d476 x16: ffff8000805519dc x15: ffff7000127a6cc8
> x14: 1ffff000127a6cc8 x13: 0000000000000004 x12: ffffffffffffffff
> x11: ffff7000127a6cc8 x10: 0000000000ff0100 x9 : 0000000000000000
> x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> x5 : ffff80009287aa08 x4 : 0000000000000008 x3 : ffff80008034c7fc
> x2 : ffff0000e0032468 x1 : 00000000da0e46b8 x0 : ffff0000e0032470
> Call trace:
>   __list_del include/linux/list.h:195 [inline]
>   __list_del_entry include/linux/list.h:218 [inline]
>   list_move_tail include/linux/list.h:310 [inline]
>   fq_tin_dequeue include/net/fq_impl.h:112 [inline]
>   ieee80211_tx_dequeue+0x6b8/0x3b4c net/mac80211/tx.c:3854
>   wake_tx_push_queue net/mac80211/util.c:294 [inline]
>   ieee80211_handle_wake_tx_queue+0x118/0x274 net/mac80211/util.c:315
>   drv_wake_tx_queue net/mac80211/driver-ops.h:1350 [inline]
>   schedule_and_wake_txq net/mac80211/driver-ops.h:1357 [inline]
>   ieee80211_queue_skb+0x18e8/0x2244 net/mac80211/tx.c:1664
>   ieee80211_tx+0x260/0x400 net/mac80211/tx.c:1966
>   ieee80211_xmit+0x278/0x354 net/mac80211/tx.c:2062
>   __ieee80211_subif_start_xmit+0xab8/0x122c net/mac80211/tx.c:4338
>   ieee80211_subif_start_xmit+0xe0/0x438 net/mac80211/tx.c:4532
>   __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
>   netdev_start_xmit include/linux/netdevice.h:4917 [inline]
>   xmit_one net/core/dev.c:3531 [inline]
>   dev_hard_start_xmit+0x27c/0x938 net/core/dev.c:3547
>   __dev_queue_xmit+0x1678/0x33fc net/core/dev.c:4341
>   dev_queue_xmit include/linux/netdevice.h:3091 [inline]
>   neigh_resolve_output+0x558/0x658 net/core/neighbour.c:1563
>   neigh_output include/net/neighbour.h:542 [inline]
>   ip6_finish_output2+0x104c/0x1ee8 net/ipv6/ip6_output.c:137
>   ip6_finish_output+0x428/0x7a0 net/ipv6/ip6_output.c:222
>   NF_HOOK_COND include/linux/netfilter.h:303 [inline]
>   ip6_output+0x270/0x594 net/ipv6/ip6_output.c:243
>   dst_output include/net/dst.h:450 [inline]
>   NF_HOOK+0x160/0x4f0 include/linux/netfilter.h:314
>   mld_sendpack+0x7b4/0x10f4 net/ipv6/mcast.c:1818
>   mld_send_cr net/ipv6/mcast.c:2119 [inline]
>   mld_ifc_work+0x840/0xd0c net/ipv6/mcast.c:2650
>   process_one_work+0x7b8/0x15d4 kernel/workqueue.c:3267
>   process_scheduled_works kernel/workqueue.c:3348 [inline]
>   worker_thread+0x938/0xef4 kernel/workqueue.c:3429
>   kthread+0x288/0x310 kernel/kthread.c:388
>   ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
>
> Fixes: 52539ca89f36 ("cfg80211: Expose TXQ stats and parameters to usersp=
ace")
> Signed-off-by: Eric Dumazet <edumazet@google.com>
> Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

Hmm, extraneous s-o-b? :)

> ---
>  net/wireless/nl80211.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> index 3c0bca4238d357c01b6fe92bb0f2b2b8a2917725..72c7bf55858166b8fc12114f0=
90bf085d652db6b 100644
> --- a/net/wireless/nl80211.c
> +++ b/net/wireless/nl80211.c
> @@ -468,6 +468,10 @@ static const struct netlink_range_validation nl80211=
_punct_bitmap_range =3D {
>  	.max =3D 0xffff,
>  };
>=20=20
> +static const struct netlink_range_validation q_range =3D {
> +	.max =3D INT_MAX,
> +};

The corresponding fixes to sch_fq and fq_codel use a limit of 1<<20;
INT_MAX is a bit above that, won't that still lead to issues?

-Toke

