Return-Path: <linux-wireless+bounces-9239-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BB08F90E762
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 11:52:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BDA0B1C214D9
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 09:52:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66815811E2;
	Wed, 19 Jun 2024 09:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="aDn9mH4H"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CF7C12F582;
	Wed, 19 Jun 2024 09:52:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718790744; cv=none; b=RRwfu0Trex53bLDznHvCagBK6WdpRniuKAnqTBX8A4viFGa/VFTtib9aNKlcv5M/+f9kTUQP3pNX52aOVBDDcKZ7qsDsZl+9OFg2eG5pf0iDCMTeQFdaV96eTDzL8QhGENAKRNP8BvIqxUHRLtzrA8y+rF4LGw2jW9lF9ttfabg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718790744; c=relaxed/simple;
	bh=qCSgofjdHhNFXPYqdCmYV5GfYSJvqcakxW9vc2yZBw4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=PIHnqmWy6dPMTn3FcD+7qWLzn6yYSyh8j7amQhff3YBNdD+ZvPfoHWadmepeTdOnit1x5xOg4mntQSn41yPK3+GWic4uYn5CGimImqBALWA41QYb3/p578kO+pgx+GRTNh5B5ZpPBR4tWRVdkpx9vIeoTexgd4o2z0PiIEzppbA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=aDn9mH4H; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA1E7C2BBFC;
	Wed, 19 Jun 2024 09:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718790743;
	bh=qCSgofjdHhNFXPYqdCmYV5GfYSJvqcakxW9vc2yZBw4=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=aDn9mH4HtOXgT23GFcI39ne/vkN55NKXyFRey+HTcS/M7bSa+y1yrzVTwxr0MyMdD
	 6cKqLUDECgPgYOJWCMghV3+TfcdDXxqf4e1Z1o+5j/o4uS6uCtC11Z/9BNtPFDtHBr
	 YQcwUPhDo1TO8K6VwkrrTOIFyXoA5Ole7AKz7uI+/qWn0h/kHcGiq20AEe53mK9fyw
	 GVS28XNYTwO5XTZDYjahYnUtSRcAUf0wYFoh8Wfpk+oPia9zD5EIgiPrdTWDmecKg1
	 rvCO6AdeZh3b3vwnV7Vt6R2Plk0Dzn7M108bE3cLjjMVAyCtFNe7vHGRj1B5E1A0qN
	 i2h0Bbl7l6ZoA==
From: Kalle Valo <kvalo@kernel.org>
To: Eric Dumazet <edumazet@google.com>
Cc: "David S . Miller" <davem@davemloft.net>,  Jakub Kicinski
 <kuba@kernel.org>,  Paolo Abeni <pabeni@redhat.com>,  Johannes Berg
 <johannes@sipsolutions.net>,  linux-wireless@vger.kernel.org,
  netdev@vger.kernel.org,  eric.dumazet@gmail.com,  Toke =?utf-8?Q?H=C3=B8?=
 =?utf-8?Q?iland-J=C3=B8rgensen?=
 <toke@toke.dk>
Subject: Re: [PATCH net] wifi: cfg80211: restrict NL80211_ATTR_TXQ_QUANTUM
 values
References: <20240615160800.250667-1-edumazet@google.com>
	<87zfrjk8wi.fsf@kernel.org>
	<CANn89iJ2SHPGVM1mxx4x4WU5X0CcVmmBhSD-FZS5fPs_Z1D01A@mail.gmail.com>
Date: Wed, 19 Jun 2024 12:52:19 +0300
In-Reply-To: <CANn89iJ2SHPGVM1mxx4x4WU5X0CcVmmBhSD-FZS5fPs_Z1D01A@mail.gmail.com>
	(Eric Dumazet's message of "Wed, 19 Jun 2024 11:10:39 +0200")
Message-ID: <87sex9l0oc.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Eric Dumazet <edumazet@google.com> writes:

> On Mon, Jun 17, 2024 at 3:15=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wro=
te:
>
>>
>> Eric Dumazet <edumazet@google.com> writes:
>>
>> > syzbot is able to trigger softlockups, setting NL80211_ATTR_TXQ_QUANTUM
>> > to 2^31.
>> >
>> > We had a similar issue in sch_fq, fixed with commit
>> > d9e15a273306 ("pkt_sched: fq: do not accept silly TCA_FQ_QUANTUM")
>> >
>> > watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [kworker/1:0:24]
>> > Modules linked in:
>> > irq event stamp: 131135
>> >  hardirqs last  enabled at (131134): [<ffff80008ae8778c>] __exit_to_ke=
rnel_mode arch/arm64/kernel/entry-common.c:85 [inline]
>> >  hardirqs last  enabled at (131134): [<ffff80008ae8778c>] exit_to_kern=
el_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:95
>> >  hardirqs last disabled at (131135): [<ffff80008ae85378>] __el1_irq ar=
ch/arm64/kernel/entry-common.c:533 [inline]
>> >  hardirqs last disabled at (131135): [<ffff80008ae85378>] el1_interrup=
t+0x24/0x68 arch/arm64/kernel/entry-common.c:551
>> >  softirqs last  enabled at (125892): [<ffff80008907e82c>] neigh_hh_ini=
t net/core/neighbour.c:1538 [inline]
>> >  softirqs last  enabled at (125892): [<ffff80008907e82c>] neigh_resolv=
e_output+0x268/0x658 net/core/neighbour.c:1553
>> >  softirqs last disabled at (125896): [<ffff80008904166c>] local_bh_dis=
able+0x10/0x34 include/linux/bottom_half.h:19
>> > CPU: 1 PID: 24 Comm: kworker/1:0 Not tainted 6.9.0-rc7-syzkaller-gfda5=
695d692c #0
>> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIO=
S Google 03/27/2024
>> > Workqueue: mld mld_ifc_work
>> > pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
>> >  pc : __list_del include/linux/list.h:195 [inline]
>> >  pc : __list_del_entry include/linux/list.h:218 [inline]
>> >  pc : list_move_tail include/linux/list.h:310 [inline]
>> >  pc : fq_tin_dequeue include/net/fq_impl.h:112 [inline]
>> >  pc : ieee80211_tx_dequeue+0x6b8/0x3b4c net/mac80211/tx.c:3854
>> >  lr : __list_del_entry include/linux/list.h:218 [inline]
>> >  lr : list_move_tail include/linux/list.h:310 [inline]
>> >  lr : fq_tin_dequeue include/net/fq_impl.h:112 [inline]
>> >  lr : ieee80211_tx_dequeue+0x67c/0x3b4c net/mac80211/tx.c:3854
>> > sp : ffff800093d36700
>> > x29: ffff800093d36a60 x28: ffff800093d36960 x27: dfff800000000000
>> > x26: ffff0000d800ad50 x25: ffff0000d800abe0 x24: ffff0000d800abf0
>> > x23: ffff0000e0032468 x22: ffff0000e00324d4 x21: ffff0000d800abf0
>> > x20: ffff0000d800abf8 x19: ffff0000d800abf0 x18: ffff800093d363c0
>> > x17: 000000000000d476 x16: ffff8000805519dc x15: ffff7000127a6cc8
>> > x14: 1ffff000127a6cc8 x13: 0000000000000004 x12: ffffffffffffffff
>> > x11: ffff7000127a6cc8 x10: 0000000000ff0100 x9 : 0000000000000000
>> > x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
>> > x5 : ffff80009287aa08 x4 : 0000000000000008 x3 : ffff80008034c7fc
>> > x2 : ffff0000e0032468 x1 : 00000000da0e46b8 x0 : ffff0000e0032470
>> > Call trace:
>> >   __list_del include/linux/list.h:195 [inline]
>> >   __list_del_entry include/linux/list.h:218 [inline]
>> >   list_move_tail include/linux/list.h:310 [inline]
>> >   fq_tin_dequeue include/net/fq_impl.h:112 [inline]
>> >   ieee80211_tx_dequeue+0x6b8/0x3b4c net/mac80211/tx.c:3854
>> >   wake_tx_push_queue net/mac80211/util.c:294 [inline]
>> >   ieee80211_handle_wake_tx_queue+0x118/0x274 net/mac80211/util.c:315
>> >   drv_wake_tx_queue net/mac80211/driver-ops.h:1350 [inline]
>> >   schedule_and_wake_txq net/mac80211/driver-ops.h:1357 [inline]
>> >   ieee80211_queue_skb+0x18e8/0x2244 net/mac80211/tx.c:1664
>> >   ieee80211_tx+0x260/0x400 net/mac80211/tx.c:1966
>> >   ieee80211_xmit+0x278/0x354 net/mac80211/tx.c:2062
>> >   __ieee80211_subif_start_xmit+0xab8/0x122c net/mac80211/tx.c:4338
>> >   ieee80211_subif_start_xmit+0xe0/0x438 net/mac80211/tx.c:4532
>> >   __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
>> >   netdev_start_xmit include/linux/netdevice.h:4917 [inline]
>> >   xmit_one net/core/dev.c:3531 [inline]
>> >   dev_hard_start_xmit+0x27c/0x938 net/core/dev.c:3547
>> >   __dev_queue_xmit+0x1678/0x33fc net/core/dev.c:4341
>> >   dev_queue_xmit include/linux/netdevice.h:3091 [inline]
>> >   neigh_resolve_output+0x558/0x658 net/core/neighbour.c:1563
>> >   neigh_output include/net/neighbour.h:542 [inline]
>> >   ip6_finish_output2+0x104c/0x1ee8 net/ipv6/ip6_output.c:137
>> >   ip6_finish_output+0x428/0x7a0 net/ipv6/ip6_output.c:222
>> >   NF_HOOK_COND include/linux/netfilter.h:303 [inline]
>> >   ip6_output+0x270/0x594 net/ipv6/ip6_output.c:243
>> >   dst_output include/net/dst.h:450 [inline]
>> >   NF_HOOK+0x160/0x4f0 include/linux/netfilter.h:314
>> >   mld_sendpack+0x7b4/0x10f4 net/ipv6/mcast.c:1818
>> >   mld_send_cr net/ipv6/mcast.c:2119 [inline]
>> >   mld_ifc_work+0x840/0xd0c net/ipv6/mcast.c:2650
>> >   process_one_work+0x7b8/0x15d4 kernel/workqueue.c:3267
>> >   process_scheduled_works kernel/workqueue.c:3348 [inline]
>> >   worker_thread+0x938/0xef4 kernel/workqueue.c:3429
>> >   kthread+0x288/0x310 kernel/kthread.c:388
>> >   ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
>> >
>> > Fixes: 52539ca89f36 ("cfg80211: Expose TXQ stats and parameters to use=
rspace")
>> > Signed-off-by: Eric Dumazet <edumazet@google.com>
>> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>>
>> cfg80211 patches go to wireless tree, not net.
>>
>> --
>> https://patchwork.kernel.org/project/linux-wireless/list/
>>
>> https://wireless.wiki.kernel.org/en/developers/documentation/submittingp=
atches
>
>
> I used as usual for wifi paches :
>
> git send-email \
>     --to "David S. Miller <davem@davemloft.net>" \
>    --to "Jakub Kicinski <kuba@kernel.org>" \
>    --to "Paolo Abeni <pabeni@redhat.com>" \
>    --cc "linux-wireless@vger.kernel.org" \
>    --to "Johannes Berg <johannes@sipsolutions.net>" \
>     --cc "netdev@vger.kernel.org" \
> --cc "eric.dumazet@gmail.com" \
> --validate \
> 0001-wifi-cfg80211-restrict-NL80211_ATTR_TXQ_QUANTUM-valu.patch
>
>
> What did I miss ?

Just the tag in subject claims it's for the net tree:

Subject: [PATCH net] ...

Not a big deal, actually happens quite often. I just usually send a
reply to remind the net maintainers not take the patch :)

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

