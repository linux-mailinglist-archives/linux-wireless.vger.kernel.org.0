Return-Path: <linux-wireless+bounces-9238-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 55E9D90E6DA
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 11:22:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DF568284FD3
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 09:22:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6913C7FBB4;
	Wed, 19 Jun 2024 09:22:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aeEs55oV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B1507D07F
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 09:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788971; cv=none; b=O5FBFuqILoWDstL5ZrkHAJ4VNPNQXuGnJU35yZ2HB2TczcprMByTKIumKBC98/P+kWiH7h9BoZK5rrVS8R7/yrLAXnPEwx4JG60djK5y9t7ezBCd6Wqu/8F9PJbtsdYguyuGdgQBv+SsSuVxditpJt4KNUcCSzQ8hlzW7BI17f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788971; c=relaxed/simple;
	bh=ijQPgA0ofI/MKZHeRYjXdg4L88GHZmRm0g2KuOYYef0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EU2MdEd8D7Zo933vWEyFnJZcCjtgqEOFFCNyEElaj4MS4GZlFGz9ZGTpojdcXyZSfj7oAOOtWCPA8qziCdi0n1BXiU+QUyUg1PUsCxrMUTJHq0GzdEmiK8HFFv8x8li3eCix6aPxvh9BMXSiW4SU+0szAK7S6C20OvfiUJUrtV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=aeEs55oV; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-57a16f4b8bfso10847a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 02:22:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718788968; x=1719393768; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=W2ZTSNEdbJVX5MWVEcHY7HYouj+mF8oeT8kc1MywnBM=;
        b=aeEs55oV1vS8QHuWUKnzn0xybbJ96f4Dr+AAAqsMPLZVAhWJACb5QHkoX/QP21CZgg
         YEbpf3vV+MkEZ+nlkdK+pBkhJBHpIa+MH41QdLUpymY6s6B1OQvDIugTgLBWy7/ygxU1
         WvaaNiZeUbIDz6Uj09MClFJwoEUYP+0fUGxAlpXzpGkZA3JsuRsn+zkiFGKjp9JB4syw
         oGkPhNQoY0M9b1DZx7kLX3KlmuEBlDdvaoDKdTOLUoKcItYWbhXPU5n7wnmSDk/f6HYe
         eLCjYQFRnPdabkeNwouAXxZF9rt8wqnPBPqaHrrzRZ54224VvquKA/p5ZcVlQbTtBqql
         1Fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718788968; x=1719393768;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W2ZTSNEdbJVX5MWVEcHY7HYouj+mF8oeT8kc1MywnBM=;
        b=X2hGvFfhBfET3w/ks2rO+oubOiT/E3UfIvnFyPxifhYgg05YZUNl8RqucZlmfDBfoo
         yZxSRk9MsvoZbSPM7B+2KMiKxnPVjv1LsJN4vCHCA7sIm25oMpqwrXd0iWZ+Ww8FX9Ue
         bwet4usGgifZAfSY70EftLcB8J2QP7oXbvPIXdIGjCIuaYTGyx0fBc8Czv/Vw3qoIFQ4
         MH0Xk0ab+2FbRFFbY5Sz9Na1uesSHD6VNDYzl6W/Qwen9+weWch4FizzNy+w3DicvpoV
         598hGhu3B55MMxFMT/YG39D1SncbDrNhrraOYd7/nHbjKGXOcNwbIOgq630Mh5PmxG3w
         NnLQ==
X-Forwarded-Encrypted: i=1; AJvYcCWW3c6B/xpiLy+dh/0OuH8fUVUYXzVaIR4668x0qu2vANChyJTE+98zyu0wnVttHoL3/yEpA8S98CZ6Cn08aG7lSsNXipZ/TBzfeeYNF2w=
X-Gm-Message-State: AOJu0YxA4mRXMMNLmoSgQB8EyhMSSjSDpMMOO3yKlKl8e5tSeTLpC45G
	n1fCMMGr5CjligJmwnZAdDgX2AzYE/bUWdRPMZ70g/ZmNLvb20eKczcyYOy2jzJOnsnsk/hGPXN
	9HF7Y9RL9shVb6ixaii9bb0YJuuqTXtUN5zztY6XpiWWDjcm7TFfE
X-Google-Smtp-Source: AGHT+IF3DlitxLLQSHjt5Xh9BaRaSRtveuTjvCx6+VuxqQBRVemFEd0wdOpeJ/A6m2jF5xjLK2zt3C1F0NQNcSDD6DU=
X-Received: by 2002:a05:6402:2345:b0:57c:c3a7:dab6 with SMTP id
 4fb4d7f45d1cf-57d0ec44f28mr118032a12.3.1718788967269; Wed, 19 Jun 2024
 02:22:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615160800.250667-1-edumazet@google.com> <87sexbsvqj.fsf@toke.dk>
 <CANn89iK=9_oWemL+qoHcrPH=hWe49NKJr9=tuGQ2yMqXVNOaaw@mail.gmail.com>
In-Reply-To: <CANn89iK=9_oWemL+qoHcrPH=hWe49NKJr9=tuGQ2yMqXVNOaaw@mail.gmail.com>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Jun 2024 11:22:32 +0200
Message-ID: <CANn89iKAsMq_9JWOXAhQmCLoiLdxHXNcLNaZqEPLK2AWjzBFTg@mail.gmail.com>
Subject: Re: [PATCH net] wifi: cfg80211: restrict NL80211_ATTR_TXQ_QUANTUM values
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 19, 2024 at 11:07=E2=80=AFAM Eric Dumazet <edumazet@google.com>=
 wrote:
>
> On Mon, Jun 17, 2024 at 12:35=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen=
 <toke@toke.dk> wrote:
> >
> > Eric Dumazet <edumazet@google.com> writes:
> >
> > > syzbot is able to trigger softlockups, setting NL80211_ATTR_TXQ_QUANT=
UM
> > > to 2^31.
> > >
> > > We had a similar issue in sch_fq, fixed with commit
> > > d9e15a273306 ("pkt_sched: fq: do not accept silly TCA_FQ_QUANTUM")
> > >
> > > watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [kworker/1:0:24]
> > > Modules linked in:
> > > irq event stamp: 131135
> > >  hardirqs last  enabled at (131134): [<ffff80008ae8778c>] __exit_to_k=
ernel_mode arch/arm64/kernel/entry-common.c:85 [inline]
> > >  hardirqs last  enabled at (131134): [<ffff80008ae8778c>] exit_to_ker=
nel_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:95
> > >  hardirqs last disabled at (131135): [<ffff80008ae85378>] __el1_irq a=
rch/arm64/kernel/entry-common.c:533 [inline]
> > >  hardirqs last disabled at (131135): [<ffff80008ae85378>] el1_interru=
pt+0x24/0x68 arch/arm64/kernel/entry-common.c:551
> > >  softirqs last  enabled at (125892): [<ffff80008907e82c>] neigh_hh_in=
it net/core/neighbour.c:1538 [inline]
> > >  softirqs last  enabled at (125892): [<ffff80008907e82c>] neigh_resol=
ve_output+0x268/0x658 net/core/neighbour.c:1553
> > >  softirqs last disabled at (125896): [<ffff80008904166c>] local_bh_di=
sable+0x10/0x34 include/linux/bottom_half.h:19
> > > CPU: 1 PID: 24 Comm: kworker/1:0 Not tainted 6.9.0-rc7-syzkaller-gfda=
5695d692c #0
> > > Hardware name: Google Google Compute Engine/Google Compute Engine, BI=
OS Google 03/27/2024
> > > Workqueue: mld mld_ifc_work
> > > pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> > >  pc : __list_del include/linux/list.h:195 [inline]
> > >  pc : __list_del_entry include/linux/list.h:218 [inline]
> > >  pc : list_move_tail include/linux/list.h:310 [inline]
> > >  pc : fq_tin_dequeue include/net/fq_impl.h:112 [inline]
> > >  pc : ieee80211_tx_dequeue+0x6b8/0x3b4c net/mac80211/tx.c:3854
> > >  lr : __list_del_entry include/linux/list.h:218 [inline]
> > >  lr : list_move_tail include/linux/list.h:310 [inline]
> > >  lr : fq_tin_dequeue include/net/fq_impl.h:112 [inline]
> > >  lr : ieee80211_tx_dequeue+0x67c/0x3b4c net/mac80211/tx.c:3854
> > > sp : ffff800093d36700
> > > x29: ffff800093d36a60 x28: ffff800093d36960 x27: dfff800000000000
> > > x26: ffff0000d800ad50 x25: ffff0000d800abe0 x24: ffff0000d800abf0
> > > x23: ffff0000e0032468 x22: ffff0000e00324d4 x21: ffff0000d800abf0
> > > x20: ffff0000d800abf8 x19: ffff0000d800abf0 x18: ffff800093d363c0
> > > x17: 000000000000d476 x16: ffff8000805519dc x15: ffff7000127a6cc8
> > > x14: 1ffff000127a6cc8 x13: 0000000000000004 x12: ffffffffffffffff
> > > x11: ffff7000127a6cc8 x10: 0000000000ff0100 x9 : 0000000000000000
> > > x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> > > x5 : ffff80009287aa08 x4 : 0000000000000008 x3 : ffff80008034c7fc
> > > x2 : ffff0000e0032468 x1 : 00000000da0e46b8 x0 : ffff0000e0032470
> > > Call trace:
> > >   __list_del include/linux/list.h:195 [inline]
> > >   __list_del_entry include/linux/list.h:218 [inline]
> > >   list_move_tail include/linux/list.h:310 [inline]
> > >   fq_tin_dequeue include/net/fq_impl.h:112 [inline]
> > >   ieee80211_tx_dequeue+0x6b8/0x3b4c net/mac80211/tx.c:3854
> > >   wake_tx_push_queue net/mac80211/util.c:294 [inline]
> > >   ieee80211_handle_wake_tx_queue+0x118/0x274 net/mac80211/util.c:315
> > >   drv_wake_tx_queue net/mac80211/driver-ops.h:1350 [inline]
> > >   schedule_and_wake_txq net/mac80211/driver-ops.h:1357 [inline]
> > >   ieee80211_queue_skb+0x18e8/0x2244 net/mac80211/tx.c:1664
> > >   ieee80211_tx+0x260/0x400 net/mac80211/tx.c:1966
> > >   ieee80211_xmit+0x278/0x354 net/mac80211/tx.c:2062
> > >   __ieee80211_subif_start_xmit+0xab8/0x122c net/mac80211/tx.c:4338
> > >   ieee80211_subif_start_xmit+0xe0/0x438 net/mac80211/tx.c:4532
> > >   __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
> > >   netdev_start_xmit include/linux/netdevice.h:4917 [inline]
> > >   xmit_one net/core/dev.c:3531 [inline]
> > >   dev_hard_start_xmit+0x27c/0x938 net/core/dev.c:3547
> > >   __dev_queue_xmit+0x1678/0x33fc net/core/dev.c:4341
> > >   dev_queue_xmit include/linux/netdevice.h:3091 [inline]
> > >   neigh_resolve_output+0x558/0x658 net/core/neighbour.c:1563
> > >   neigh_output include/net/neighbour.h:542 [inline]
> > >   ip6_finish_output2+0x104c/0x1ee8 net/ipv6/ip6_output.c:137
> > >   ip6_finish_output+0x428/0x7a0 net/ipv6/ip6_output.c:222
> > >   NF_HOOK_COND include/linux/netfilter.h:303 [inline]
> > >   ip6_output+0x270/0x594 net/ipv6/ip6_output.c:243
> > >   dst_output include/net/dst.h:450 [inline]
> > >   NF_HOOK+0x160/0x4f0 include/linux/netfilter.h:314
> > >   mld_sendpack+0x7b4/0x10f4 net/ipv6/mcast.c:1818
> > >   mld_send_cr net/ipv6/mcast.c:2119 [inline]
> > >   mld_ifc_work+0x840/0xd0c net/ipv6/mcast.c:2650
> > >   process_one_work+0x7b8/0x15d4 kernel/workqueue.c:3267
> > >   process_scheduled_works kernel/workqueue.c:3348 [inline]
> > >   worker_thread+0x938/0xef4 kernel/workqueue.c:3429
> > >   kthread+0x288/0x310 kernel/kthread.c:388
> > >   ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
> > >
> > > Fixes: 52539ca89f36 ("cfg80211: Expose TXQ stats and parameters to us=
erspace")
> > > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
> >
> > Hmm, extraneous s-o-b? :)
> >
> > > ---
> > >  net/wireless/nl80211.c | 6 +++++-
> > >  1 file changed, 5 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> > > index 3c0bca4238d357c01b6fe92bb0f2b2b8a2917725..72c7bf55858166b8fc121=
14f090bf085d652db6b 100644
> > > --- a/net/wireless/nl80211.c
> > > +++ b/net/wireless/nl80211.c
> > > @@ -468,6 +468,10 @@ static const struct netlink_range_validation nl8=
0211_punct_bitmap_range =3D {
> > >       .max =3D 0xffff,
> > >  };
> > >
> > > +static const struct netlink_range_validation q_range =3D {
> > > +     .max =3D INT_MAX,
> > > +};
> >
> > The corresponding fixes to sch_fq and fq_codel use a limit of 1<<20;
> > INT_MAX is a bit above that, won't that still lead to issues?
>
> What kind of  issues do you envision ?
>
> I do not know what kind of aggregation level wireless will have in 2030.

BTW we also chose INT_MAX in this prior commit, for syzkaller sake.

commit 7041101ff6c3073fd8f2e99920f535b111c929cb
Author: Davide Caratti <dcaratti@redhat.com>
Date:   Thu Apr 20 16:59:46 2023 +0200

    net/sched: sch_fq: fix integer overflow of "credit"

I do not think precise value is important, this is only to avoid
potential infinite loops.

