Return-Path: <linux-wireless+bounces-9237-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DAE2F90E694
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 11:11:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F2EB1F2200E
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Jun 2024 09:11:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CD647E776;
	Wed, 19 Jun 2024 09:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="VrbbUr5Z"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6281C7E576
	for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 09:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718788255; cv=none; b=kjrL0/DDwSJmCoesf0Ex5TW9zH5w5Xg1QVFfiJTOx7mWjSeHS+fXLyIDzGcXGOHd71C1fvwTDh3OMAHa2nW/r7e0of4hfPKI1Gp7EURlHn1DH5B4lGxw6Hlgz4MKw/mNAfC2eJT/35bmeaaosBzSpTqb2APctjc9xUcJsjPETuU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718788255; c=relaxed/simple;
	bh=wN8yFVyqS4IZa+6gbD+BAY5GZqBxwAbBGa807SgLH5I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=br26vylzMHrBa9DZVwO3Z+4wIelxCszL3ZwontYazlHNiBoWhV9Gxbm/YLgKL+En5kjJQrrKCdosRk6g/5Aqawr+x1tsMIR5v0fqLJAz8P6owJclRdXHnwTt4RtDwSA43COZaEBwwTqGsI5iHfS89xRxRTMnPUNLlUZ9ZyU6qe0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=VrbbUr5Z; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-57d16251a07so1650a12.1
        for <linux-wireless@vger.kernel.org>; Wed, 19 Jun 2024 02:10:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718788251; x=1719393051; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WxdzoaDML2ndueel6BZlI16I6zBV/MwHlcg6wwmngnE=;
        b=VrbbUr5ZlXpbBv99r+//xb3fINJrGFm9vKOgAElAmzTrUrOCwFGxU9yU/3tpQ5h1LK
         MGGVZuhwZuFCuHPMB3pzwpnrROyn29EfNPbViTUYzBGEQztXvH4GU9/90l+PPeg6AzCL
         VAHfxcoOKyBuC9L2Q+oiILQsKgwYloO84qqNrXjgHjRHm/Rf7WOUP/RWB+4bozPYXlii
         Bc+U3GchqDOekKx/plgWWd3mdfDLG2qtaZwkJBu7OGroKtwLAuNknmsI9qAWih2dQdRV
         HblZcAycEc1VgmkxxlXz+eB+daWsCuC0lVRBbUWneBgabWf+GPazNA9hhYLVRicBrCqZ
         Sxnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718788251; x=1719393051;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WxdzoaDML2ndueel6BZlI16I6zBV/MwHlcg6wwmngnE=;
        b=YN7hi/gRPY8/2FQlfbvnWeCPWrn9qobx4TZVbKhOzSLQWABv8grq+niTQeFcQcPmdG
         tSYPkMGHrXEhkdouQlRgGmwGWggJMIeNrjapbpO/nPal8cgWvGMYO0yewS0h5GSosp8s
         gVD77ftg+7zFCicZ5vsCS4oPE9HSV9bElrrUwb0ceKavVWMdEgSx3qUYSVydowzjqfla
         jXbYJXkbOr4YlvDxlW5CAjvY6lVhqbnA9QXwEtCKW34vz5jEPfaKgkanYMHqHRyYY5/y
         0ptBcyn6smT9GuuVg3fGvLr8Xwl8p3162Rbpo87Dc3xDlFcpsWlNhSECk8+3DuPShTro
         r4cw==
X-Forwarded-Encrypted: i=1; AJvYcCXWKp2Ftq+ZioDkdN5p09G/xastHjW+5yyUYP6pBUfuE3Ck2ywEpeDgddjerwY4FohDCNe05fGrKZIqIM4Y9aPi4MIIvcbrGBoKM5Wqo0I=
X-Gm-Message-State: AOJu0Yx2++YajcYmlY1hF2svBakCHYscCZMwfDfXZXGtuxy/WIjC9o1v
	wiEW4uKGf55DpXmWB5+9zETJ+pMRDzOjZrtSPyiqyk4mkwrtbG7kyWsLSStfJ26P3BQrQS0TYr1
	uAldndPTmArSKHzyzOFdsmedoXmb7MkwFCjh7zA0CP5G/ey9JXgEm
X-Google-Smtp-Source: AGHT+IHyEGupMiDJLxHWnla1YueniKdz+Sr8fbjJoc2PshALijrsFrMyRk2qFx9rbwk0F8Ximq0yAaim9WmXLQG67KI=
X-Received: by 2002:a05:6402:2709:b0:57c:fef9:1a9 with SMTP id
 4fb4d7f45d1cf-57d0ec442cfmr106610a12.1.1718788251172; Wed, 19 Jun 2024
 02:10:51 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240615160800.250667-1-edumazet@google.com> <87zfrjk8wi.fsf@kernel.org>
In-Reply-To: <87zfrjk8wi.fsf@kernel.org>
From: Eric Dumazet <edumazet@google.com>
Date: Wed, 19 Jun 2024 11:10:39 +0200
Message-ID: <CANn89iJ2SHPGVM1mxx4x4WU5X0CcVmmBhSD-FZS5fPs_Z1D01A@mail.gmail.com>
Subject: Re: [PATCH net] wifi: cfg80211: restrict NL80211_ATTR_TXQ_QUANTUM values
To: Kalle Valo <kvalo@kernel.org>
Cc: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 17, 2024 at 3:15=E2=80=AFPM Kalle Valo <kvalo@kernel.org> wrote=
:
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
> cfg80211 patches go to wireless tree, not net.
>
> --
> https://patchwork.kernel.org/project/linux-wireless/list/
>
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpa=
tches


I used as usual for wifi paches :

git send-email \
    --to "David S. Miller <davem@davemloft.net>" \
   --to "Jakub Kicinski <kuba@kernel.org>" \
   --to "Paolo Abeni <pabeni@redhat.com>" \
   --cc "linux-wireless@vger.kernel.org" \
   --to "Johannes Berg <johannes@sipsolutions.net>" \
    --cc "netdev@vger.kernel.org" \
--cc "eric.dumazet@gmail.com" \
--validate \
0001-wifi-cfg80211-restrict-NL80211_ATTR_TXQ_QUANTUM-valu.patch


What did I miss ?

