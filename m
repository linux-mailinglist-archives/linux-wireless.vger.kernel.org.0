Return-Path: <linux-wireless+bounces-9236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C5CF090E682
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 11:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CC9B01C21A93
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 09:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B1C447EEF5;
	Wed, 19 Jun 2024 09:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="iGDonf6M"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A86DE224D4
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 09:07:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788061; cv=none; b=TR+HVMC2CNkKS9wiKI+/1zBWN7eElEXpM2wmVDR7cdY1eQ9FM9RnHEF0Py1dpvuAw9ubH3GlwASVtBNVu/VFIESih236lJVRmfvK7Hfg/vREVFrTZ79Sub2hPotFzY8v5JcxZ+VBXOC1udIhyC/lmtSA59QDOh/rPu2AmiRgRKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788061; c=relaxed/simple;
	bh=NQVWWg76uzx9c7sOz2NReyLbKGOFOQCF4FoB84SLZls=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=agzhiXplBS+C7+UpRJZ+PChl/cS7PLpKYH7blKYA6cMxAwQ8ZhYG4YB/qTQA1rnI4ZDxW4FnJCMaK5CxJE5jMzaqSShOWoBEjTa6pi6fqkFxjgnup96Gxg+JKGDZ33mQbbqwdLlGTTmYwCQbcAIDlgUZ0AXmXP6mMvTjnTQas+0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=iGDonf6M; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-57d119fddd9so2993a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 02:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718788057; x=1719392857; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=w040dDSggZKx2nZfSuhbq5UJxonhiqKtPHidmMpJCDg=;
        b=iGDonf6MLJStjsLCV5m4q4NdrWnCPQcwMOMXyNBRsydT5jO1d68galnGmA9gGpqt/F
         MOtP1oiWC25QneX9QVFl+KKtQK4n8uegDQc19Z0s8GEGytl3y1c2jtzbxDsrVckv8x32
         rTQVJTmyUm/pp8dBGvFVTAuEDa5Q8radCItEWNEBnyWM+BX0EVefC8zvJhWK52m+pVN1
         hU/FKd5rZHL98l/fJz8+b9m9+P40oWCNpmbC4OaqMfjZQQFAk4cOWCRZgquXGJO8TqPr
         jLJ8CawMAGr4gSVhSrtMWuyvAXPO/eccY/KaAMJVsyn+u6j0pQHEFtjUa7VKVSdq3lTt
         Y9uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718788057; x=1719392857;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=w040dDSggZKx2nZfSuhbq5UJxonhiqKtPHidmMpJCDg=;
        b=af1VHLxz7vp81j0g1HM0+TJ1rW5VT4Tywijq+H6zHIX4gWsCtbRq1ksnemtl4kHtas
         GznyC4S54Km3hOh1VkA17glybgRS3nDNy1wp3EUvSNs133RTq9s/tmKs4YF6kD1yEyax
         Obm65kv/VoGq4e6diBcqnpRCSO/CDmYnC8gZ3VF3hpcEe7V0ixVBKY+e/FHunwQFvBh9
         aKjGKym72J4RRstU9teN/9Z/c7k19I2DFlydZFwQ1ILVQOJgh6h2o61vU7WMyD6egDZj
         DGCIpaKytgXt4gmHGLv705MApCO/XZECiZvItFlycF2uVyFzo1Nk0uuQqAxdLQyQuwR1
         50Jg==
X-Forwarded-Encrypted: i=1; AJvYcCX2pwYsYFANDEJvb3iRAdyrKzd0wdcA2qIN3Bj01hiyPN+a/+rHUQNzI/cy+PRI9+qjUKfs8u8KijrON8ZU6rXaqLYnBfvFdW9LoejBMp4=
X-Gm-Message-State: AOJu0YzEHF/kwSiQK682V0MwUS57x46XGWZXgsbjtF4Ku0XxRpj7l4oO
	VkeOhEE68N7genyIarbM+yvFdQ1cPD7gVe6RpILUmOiuIQjwUflInZgCw+YFGBi6wVKtxRtjSCk
	q4+8FyeXWVVr9koSWEC6MKFERy9Ue66GZ17m2
X-Google-Smtp-Source: AGHT+IElx942k2fjN+uRGV/WODZr3r0SpvBDEzr451hiqnQXMwt0fRXsF+AR2hfpZbUVs8vVoRsS/ioUtJlCWboGOAE=
X-Received: by 2002:a05:6402:278f:b0:57c:d1dd:e645 with SMTP id
 4fb4d7f45d1cf-57d0ec619f9mr96189a12.5.1718788056714; Wed, 19 Jun 2024
 02:07:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615160800.250667-1-edumazet@google.com> <87sexbsvqj.fsf@toke.dk>
In-Reply-To: <87sexbsvqj.fsf@toke.dk>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Jun 2024 11:07:25 +0200
Message-ID: <CANn89iK=9_oWemL+qoHcrPH=hWe49NKJr9=tuGQ2yMqXVNOaaw@mail.gmail.com>
Subject: Re: [PATCH net] wifi: cfg80211: restrict NL80211_ATTR_TXQ_QUANTUM values
To: =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 12:35=E2=80=AFPM Toke H=C3=B8iland-J=C3=B8rgensen <=
toke@toke.dk> wrote:
>
> Eric Dumazet <edumazet@google.com> writes:
>
> > syzbot is able to trigger softlockups, setting NL80211_ATTR_TXQ_QUANTUM
> > to 2^31.
> >
> > We had a similar issue in sch_fq, fixed with commit
> > d9e15a273306 ("pkt_sched: fq: do not accept silly TCA_FQ_QUANTUM")
> >
> > watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [kworker/1:0:24]
> > Modules linked in:
> > irq event stamp: 131135
> >  hardirqs last  enabled at (131134): [<ffff80008ae8778c>] __exit_to_ker=
nel_mode arch/arm64/kernel/entry-common.c:85 [inline]
> >  hardirqs last  enabled at (131134): [<ffff80008ae8778c>] exit_to_kerne=
l_mode+0xdc/0x10c arch/arm64/kernel/entry-common.c:95
> >  hardirqs last disabled at (131135): [<ffff80008ae85378>] __el1_irq arc=
h/arm64/kernel/entry-common.c:533 [inline]
> >  hardirqs last disabled at (131135): [<ffff80008ae85378>] el1_interrupt=
+0x24/0x68 arch/arm64/kernel/entry-common.c:551
> >  softirqs last  enabled at (125892): [<ffff80008907e82c>] neigh_hh_init=
 net/core/neighbour.c:1538 [inline]
> >  softirqs last  enabled at (125892): [<ffff80008907e82c>] neigh_resolve=
_output+0x268/0x658 net/core/neighbour.c:1553
> >  softirqs last disabled at (125896): [<ffff80008904166c>] local_bh_disa=
ble+0x10/0x34 include/linux/bottom_half.h:19
> > CPU: 1 PID: 24 Comm: kworker/1:0 Not tainted 6.9.0-rc7-syzkaller-gfda56=
95d692c #0
> > Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS=
 Google 03/27/2024
> > Workqueue: mld mld_ifc_work
> > pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
> >  pc : __list_del include/linux/list.h:195 [inline]
> >  pc : __list_del_entry include/linux/list.h:218 [inline]
> >  pc : list_move_tail include/linux/list.h:310 [inline]
> >  pc : fq_tin_dequeue include/net/fq_impl.h:112 [inline]
> >  pc : ieee80211_tx_dequeue+0x6b8/0x3b4c net/mac80211/tx.c:3854
> >  lr : __list_del_entry include/linux/list.h:218 [inline]
> >  lr : list_move_tail include/linux/list.h:310 [inline]
> >  lr : fq_tin_dequeue include/net/fq_impl.h:112 [inline]
> >  lr : ieee80211_tx_dequeue+0x67c/0x3b4c net/mac80211/tx.c:3854
> > sp : ffff800093d36700
> > x29: ffff800093d36a60 x28: ffff800093d36960 x27: dfff800000000000
> > x26: ffff0000d800ad50 x25: ffff0000d800abe0 x24: ffff0000d800abf0
> > x23: ffff0000e0032468 x22: ffff0000e00324d4 x21: ffff0000d800abf0
> > x20: ffff0000d800abf8 x19: ffff0000d800abf0 x18: ffff800093d363c0
> > x17: 000000000000d476 x16: ffff8000805519dc x15: ffff7000127a6cc8
> > x14: 1ffff000127a6cc8 x13: 0000000000000004 x12: ffffffffffffffff
> > x11: ffff7000127a6cc8 x10: 0000000000ff0100 x9 : 0000000000000000
> > x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
> > x5 : ffff80009287aa08 x4 : 0000000000000008 x3 : ffff80008034c7fc
> > x2 : ffff0000e0032468 x1 : 00000000da0e46b8 x0 : ffff0000e0032470
> > Call trace:
> >   __list_del include/linux/list.h:195 [inline]
> >   __list_del_entry include/linux/list.h:218 [inline]
> >   list_move_tail include/linux/list.h:310 [inline]
> >   fq_tin_dequeue include/net/fq_impl.h:112 [inline]
> >   ieee80211_tx_dequeue+0x6b8/0x3b4c net/mac80211/tx.c:3854
> >   wake_tx_push_queue net/mac80211/util.c:294 [inline]
> >   ieee80211_handle_wake_tx_queue+0x118/0x274 net/mac80211/util.c:315
> >   drv_wake_tx_queue net/mac80211/driver-ops.h:1350 [inline]
> >   schedule_and_wake_txq net/mac80211/driver-ops.h:1357 [inline]
> >   ieee80211_queue_skb+0x18e8/0x2244 net/mac80211/tx.c:1664
> >   ieee80211_tx+0x260/0x400 net/mac80211/tx.c:1966
> >   ieee80211_xmit+0x278/0x354 net/mac80211/tx.c:2062
> >   __ieee80211_subif_start_xmit+0xab8/0x122c net/mac80211/tx.c:4338
> >   ieee80211_subif_start_xmit+0xe0/0x438 net/mac80211/tx.c:4532
> >   __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
> >   netdev_start_xmit include/linux/netdevice.h:4917 [inline]
> >   xmit_one net/core/dev.c:3531 [inline]
> >   dev_hard_start_xmit+0x27c/0x938 net/core/dev.c:3547
> >   __dev_queue_xmit+0x1678/0x33fc net/core/dev.c:4341
> >   dev_queue_xmit include/linux/netdevice.h:3091 [inline]
> >   neigh_resolve_output+0x558/0x658 net/core/neighbour.c:1563
> >   neigh_output include/net/neighbour.h:542 [inline]
> >   ip6_finish_output2+0x104c/0x1ee8 net/ipv6/ip6_output.c:137
> >   ip6_finish_output+0x428/0x7a0 net/ipv6/ip6_output.c:222
> >   NF_HOOK_COND include/linux/netfilter.h:303 [inline]
> >   ip6_output+0x270/0x594 net/ipv6/ip6_output.c:243
> >   dst_output include/net/dst.h:450 [inline]
> >   NF_HOOK+0x160/0x4f0 include/linux/netfilter.h:314
> >   mld_sendpack+0x7b4/0x10f4 net/ipv6/mcast.c:1818
> >   mld_send_cr net/ipv6/mcast.c:2119 [inline]
> >   mld_ifc_work+0x840/0xd0c net/ipv6/mcast.c:2650
> >   process_one_work+0x7b8/0x15d4 kernel/workqueue.c:3267
> >   process_scheduled_works kernel/workqueue.c:3348 [inline]
> >   worker_thread+0x938/0xef4 kernel/workqueue.c:3429
> >   kthread+0x288/0x310 kernel/kthread.c:388
> >   ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860
> >
> > Fixes: 52539ca89f36 ("cfg80211: Expose TXQ stats and parameters to user=
space")
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
>
> Hmm, extraneous s-o-b? :)
>
> > ---
> >  net/wireless/nl80211.c | 6 +++++-
> >  1 file changed, 5 insertions(+), 1 deletion(-)
> >
> > diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
> > index 3c0bca4238d357c01b6fe92bb0f2b2b8a2917725..72c7bf55858166b8fc12114=
f090bf085d652db6b 100644
> > --- a/net/wireless/nl80211.c
> > +++ b/net/wireless/nl80211.c
> > @@ -468,6 +468,10 @@ static const struct netlink_range_validation nl802=
11_punct_bitmap_range =3D {
> >       .max =3D 0xffff,
> >  };
> >
> > +static const struct netlink_range_validation q_range =3D {
> > +     .max =3D INT_MAX,
> > +};
>
> The corresponding fixes to sch_fq and fq_codel use a limit of 1<<20;
> INT_MAX is a bit above that, won't that still lead to issues?

What kind of  issues do you envision ?

I do not know what kind of aggregation level wireless will have in 2030.

