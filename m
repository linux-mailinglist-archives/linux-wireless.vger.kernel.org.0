Return-Path: <linux-wireless+bounces-9019-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BB8A9098FE
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2024 18:08:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A10471F218A5
	for <lists+linux-wireless@lfdr.de>; Sat, 15 Jun 2024 16:08:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87EB54CDEC;
	Sat, 15 Jun 2024 16:08:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="dkX3vbuI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56220482EB
	for <linux-wireless@vger.kernel.org>; Sat, 15 Jun 2024 16:08:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718467686; cv=none; b=bQv+KzfFYG61OqvbcHXwCrUfso+tVncJXEhBgXlMwRvE0rAo9/i8B+TyRRPuks3FH/f5/5AGtbqaYCtLl0JUmEXHqLtDy2JX7R9lOyXJQgg5Ad3mH4h8Y1QInAcFFf1dPVPB+2DfZlTbTq+gSaHCOuUfIyqILq/9yrEZVLVlJYc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718467686; c=relaxed/simple;
	bh=fRhejE+LD/p9cqrf/3lNvG4iuIolAEo0RFfvpCA+VJE=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=oPqeviLUH+X5sxScRuy/XCPUZzToNm9Q3GhBzhtJnPdeNI2k6xwf+jb6irQAxBdirYkJOtxiKpBZfNBxqaVNIce2lSBsjnHrMcPjsnWYwu5QdusMiHz0AVohEw+uT2DzTeaxgTqqjtLzkY/RJWK+9Hz1uFOniyhR/65D95lgxxg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=dkX3vbuI; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dfeec5da787so5498821276.1
        for <linux-wireless@vger.kernel.org>; Sat, 15 Jun 2024 09:08:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1718467682; x=1719072482; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:from:to:cc:subject:date:message-id:reply-to;
        bh=/STVbNQ0XyXh73+jy1lVdnu8EOuL4NxrKZzvrDAl7aQ=;
        b=dkX3vbuIml9nRVIkKJV6GTmen1PGV/PTfOQnX4+aQJ/7xQtgJE8rEsXVTfXnBaGHYp
         /hfgLmjI3nsRiHaUDu5XH9QHFG3ULjdAVTJ7QZPNG1+kXbmHtUWMZQdO3EQpenkoNOw8
         Sp8dYr8h1jjV0NPUC5bOsCzQOHJ51WjKxa1B8eWy6f4ZNbTU9iemshoHMjsULOH11i/h
         I7ViI2M5XbNrjq+9mcm25DXW538E1N2IuJp8QPlkqpiVvxzL5zbjqdBP16x2DSFH+RCM
         eQFEzOYo4oQCrYYjRf11nHa34Np/SzPq/nqh4lKI4sPz115oJ5u3zJyF8bnlIxXxo1RG
         /8Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1718467682; x=1719072482;
        h=content-transfer-encoding:cc:to:from:subject:message-id
         :mime-version:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/STVbNQ0XyXh73+jy1lVdnu8EOuL4NxrKZzvrDAl7aQ=;
        b=ruc7FeILwDlXHSrgAyolPBJZglrbW2ANf8xd9vZMMbTIs82KShZRIE2KOEdClp/qS3
         WCHOau3iRK16wlE8F1AmXwr3kvAF5zaGkf3pxIxlfZv3rpGHggJXRGPg+Yy0ZCw/cmeF
         UMkFvBe3Nky4UGyXlF3u/ibSUWHbQbmVUf7cY0xv834qGya6mqgx6xk+hVAMC+YpzzX6
         DVOFI0DncFFkk7ebUV0vYoBRrsZqeNsOe/ukfi0j92C9hS0rExk9qrBeQUhoRiiAod5d
         SiiXY3Jht1pzIVdttBGrNyIXbVp8sahFKZNWiH9F+dnpwxdSA2Tqvg9tv/nxjzEAK9nG
         WTdw==
X-Gm-Message-State: AOJu0Yyc5Xwst3UQ59Ta6URRYFz1bPbEg9sknOIUy0PikvhwQMh4eSpf
	iwxYv0sSIYeOgp159CI2T7WSXF3+N8lJ5mlJHa0114Z15+MfASFrCkW7rlcqNIrSMnpLPSAytN5
	cWMkH3n5pJQ==
X-Google-Smtp-Source: AGHT+IGU+Y1whwXT9toa8M9TWzf/Dla68DMs2soP9H+LllNWPALjBNg4Oxw17Lz4Q1U4/+OYvvLhg91GBarDVg==
X-Received: from edumazet1.c.googlers.com ([fda3:e722:ac3:cc00:2b:7d90:c0a8:395a])
 (user=edumazet job=sendgmr) by 2002:a25:938b:0:b0:dda:d7cf:5c2c with SMTP id
 3f1490d57ef6-dff154676camr312528276.13.1718467682196; Sat, 15 Jun 2024
 09:08:02 -0700 (PDT)
Date: Sat, 15 Jun 2024 16:08:00 +0000
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.45.2.627.g7a2c4fd464-goog
Message-ID: <20240615160800.250667-1-edumazet@google.com>
Subject: [PATCH net] wifi: cfg80211: restrict NL80211_ATTR_TXQ_QUANTUM values
From: Eric Dumazet <edumazet@google.com>
To: "David S . Miller" <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	eric.dumazet@gmail.com, Eric Dumazet <edumazet@google.com>, 
	"=?UTF-8?q?Toke=20H=C3=B8iland-J=C3=B8rgensen?=" <toke@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

syzbot is able to trigger softlockups, setting NL80211_ATTR_TXQ_QUANTUM
to 2^31.

We had a similar issue in sch_fq, fixed with commit
d9e15a273306 ("pkt_sched: fq: do not accept silly TCA_FQ_QUANTUM")

watchdog: BUG: soft lockup - CPU#1 stuck for 26s! [kworker/1:0:24]
Modules linked in:
irq event stamp: 131135
 hardirqs last  enabled at (131134): [<ffff80008ae8778c>] __exit_to_kernel_=
mode arch/arm64/kernel/entry-common.c:85 [inline]
 hardirqs last  enabled at (131134): [<ffff80008ae8778c>] exit_to_kernel_mo=
de+0xdc/0x10c arch/arm64/kernel/entry-common.c:95
 hardirqs last disabled at (131135): [<ffff80008ae85378>] __el1_irq arch/ar=
m64/kernel/entry-common.c:533 [inline]
 hardirqs last disabled at (131135): [<ffff80008ae85378>] el1_interrupt+0x2=
4/0x68 arch/arm64/kernel/entry-common.c:551
 softirqs last  enabled at (125892): [<ffff80008907e82c>] neigh_hh_init net=
/core/neighbour.c:1538 [inline]
 softirqs last  enabled at (125892): [<ffff80008907e82c>] neigh_resolve_out=
put+0x268/0x658 net/core/neighbour.c:1553
 softirqs last disabled at (125896): [<ffff80008904166c>] local_bh_disable+=
0x10/0x34 include/linux/bottom_half.h:19
CPU: 1 PID: 24 Comm: kworker/1:0 Not tainted 6.9.0-rc7-syzkaller-gfda5695d6=
92c #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Goo=
gle 03/27/2024
Workqueue: mld mld_ifc_work
pstate: 80400005 (Nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=3D--)
 pc : __list_del include/linux/list.h:195 [inline]
 pc : __list_del_entry include/linux/list.h:218 [inline]
 pc : list_move_tail include/linux/list.h:310 [inline]
 pc : fq_tin_dequeue include/net/fq_impl.h:112 [inline]
 pc : ieee80211_tx_dequeue+0x6b8/0x3b4c net/mac80211/tx.c:3854
 lr : __list_del_entry include/linux/list.h:218 [inline]
 lr : list_move_tail include/linux/list.h:310 [inline]
 lr : fq_tin_dequeue include/net/fq_impl.h:112 [inline]
 lr : ieee80211_tx_dequeue+0x67c/0x3b4c net/mac80211/tx.c:3854
sp : ffff800093d36700
x29: ffff800093d36a60 x28: ffff800093d36960 x27: dfff800000000000
x26: ffff0000d800ad50 x25: ffff0000d800abe0 x24: ffff0000d800abf0
x23: ffff0000e0032468 x22: ffff0000e00324d4 x21: ffff0000d800abf0
x20: ffff0000d800abf8 x19: ffff0000d800abf0 x18: ffff800093d363c0
x17: 000000000000d476 x16: ffff8000805519dc x15: ffff7000127a6cc8
x14: 1ffff000127a6cc8 x13: 0000000000000004 x12: ffffffffffffffff
x11: ffff7000127a6cc8 x10: 0000000000ff0100 x9 : 0000000000000000
x8 : 0000000000000000 x7 : 0000000000000000 x6 : 0000000000000000
x5 : ffff80009287aa08 x4 : 0000000000000008 x3 : ffff80008034c7fc
x2 : ffff0000e0032468 x1 : 00000000da0e46b8 x0 : ffff0000e0032470
Call trace:
  __list_del include/linux/list.h:195 [inline]
  __list_del_entry include/linux/list.h:218 [inline]
  list_move_tail include/linux/list.h:310 [inline]
  fq_tin_dequeue include/net/fq_impl.h:112 [inline]
  ieee80211_tx_dequeue+0x6b8/0x3b4c net/mac80211/tx.c:3854
  wake_tx_push_queue net/mac80211/util.c:294 [inline]
  ieee80211_handle_wake_tx_queue+0x118/0x274 net/mac80211/util.c:315
  drv_wake_tx_queue net/mac80211/driver-ops.h:1350 [inline]
  schedule_and_wake_txq net/mac80211/driver-ops.h:1357 [inline]
  ieee80211_queue_skb+0x18e8/0x2244 net/mac80211/tx.c:1664
  ieee80211_tx+0x260/0x400 net/mac80211/tx.c:1966
  ieee80211_xmit+0x278/0x354 net/mac80211/tx.c:2062
  __ieee80211_subif_start_xmit+0xab8/0x122c net/mac80211/tx.c:4338
  ieee80211_subif_start_xmit+0xe0/0x438 net/mac80211/tx.c:4532
  __netdev_start_xmit include/linux/netdevice.h:4903 [inline]
  netdev_start_xmit include/linux/netdevice.h:4917 [inline]
  xmit_one net/core/dev.c:3531 [inline]
  dev_hard_start_xmit+0x27c/0x938 net/core/dev.c:3547
  __dev_queue_xmit+0x1678/0x33fc net/core/dev.c:4341
  dev_queue_xmit include/linux/netdevice.h:3091 [inline]
  neigh_resolve_output+0x558/0x658 net/core/neighbour.c:1563
  neigh_output include/net/neighbour.h:542 [inline]
  ip6_finish_output2+0x104c/0x1ee8 net/ipv6/ip6_output.c:137
  ip6_finish_output+0x428/0x7a0 net/ipv6/ip6_output.c:222
  NF_HOOK_COND include/linux/netfilter.h:303 [inline]
  ip6_output+0x270/0x594 net/ipv6/ip6_output.c:243
  dst_output include/net/dst.h:450 [inline]
  NF_HOOK+0x160/0x4f0 include/linux/netfilter.h:314
  mld_sendpack+0x7b4/0x10f4 net/ipv6/mcast.c:1818
  mld_send_cr net/ipv6/mcast.c:2119 [inline]
  mld_ifc_work+0x840/0xd0c net/ipv6/mcast.c:2650
  process_one_work+0x7b8/0x15d4 kernel/workqueue.c:3267
  process_scheduled_works kernel/workqueue.c:3348 [inline]
  worker_thread+0x938/0xef4 kernel/workqueue.c:3429
  kthread+0x288/0x310 kernel/kthread.c:388
  ret_from_fork+0x10/0x20 arch/arm64/kernel/entry.S:860

Fixes: 52539ca89f36 ("cfg80211: Expose TXQ stats and parameters to userspac=
e")
Signed-off-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>
---
 net/wireless/nl80211.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/wireless/nl80211.c b/net/wireless/nl80211.c
index 3c0bca4238d357c01b6fe92bb0f2b2b8a2917725..72c7bf55858166b8fc12114f090=
bf085d652db6b 100644
--- a/net/wireless/nl80211.c
+++ b/net/wireless/nl80211.c
@@ -468,6 +468,10 @@ static const struct netlink_range_validation nl80211_p=
unct_bitmap_range =3D {
 	.max =3D 0xffff,
 };
=20
+static const struct netlink_range_validation q_range =3D {
+	.max =3D INT_MAX,
+};
+
 static const struct nla_policy nl80211_policy[NUM_NL80211_ATTR] =3D {
 	[0] =3D { .strict_start_type =3D NL80211_ATTR_HE_OBSS_PD },
 	[NL80211_ATTR_WIPHY] =3D { .type =3D NLA_U32 },
@@ -754,7 +758,7 @@ static const struct nla_policy nl80211_policy[NUM_NL802=
11_ATTR] =3D {
=20
 	[NL80211_ATTR_TXQ_LIMIT] =3D { .type =3D NLA_U32 },
 	[NL80211_ATTR_TXQ_MEMORY_LIMIT] =3D { .type =3D NLA_U32 },
-	[NL80211_ATTR_TXQ_QUANTUM] =3D { .type =3D NLA_U32 },
+	[NL80211_ATTR_TXQ_QUANTUM] =3D NLA_POLICY_FULL_RANGE(NLA_U32, &q_range),
 	[NL80211_ATTR_HE_CAPABILITY] =3D
 		NLA_POLICY_VALIDATE_FN(NLA_BINARY, validate_he_capa,
 				       NL80211_HE_MAX_CAPABILITY_LEN),
--=20
2.45.2.627.g7a2c4fd464-goog


