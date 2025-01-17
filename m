Return-Path: <linux-wireless+bounces-17616-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DA4DAA148C0
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 05:14:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF2EA188A093
	for <lists+linux-wireless@lfdr.de>; Fri, 17 Jan 2025 04:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6A3441F667C;
	Fri, 17 Jan 2025 04:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QgxKZoUu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 529121E1A32
	for <linux-wireless@vger.kernel.org>; Fri, 17 Jan 2025 04:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737087260; cv=none; b=kIJliUf4zlMPEzh7pHUimZbF28QaasB6l+5Ly55KSkSqW8CxhPYZ4CQGBndMMLR1s8borxoocfylT5ys3cUva9PeoMccvmBhD1D9xkvIs/VtGnSmVMl/+rDFbl7tgPjPoK9RixK0w+8AJpNyUeY5mtl35ZXVdUoh+ooZuuo/OkQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737087260; c=relaxed/simple;
	bh=GCI4SN1y27vCTBvq3qlvLN6+Y02DWi1T1AnuIutJ+ro=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=E9DdY3m0gz3NAQ60wU+wHtkf1qaQ5HWK0EmDFtVqfbra79+NdACZGMU1DqRoxcuy/lh/E8GFNvW/D3ELkSFjPmbige8QJgM+0TYdVBENYpwXzl34wW2TvBP9rxtVG0kn4ayICbgHhZYHZQ2Ku0yG2gQotTNa2EkdxPqCh3RL3Wc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=QgxKZoUu; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-aaeecbb7309so316947966b.0
        for <linux-wireless@vger.kernel.org>; Thu, 16 Jan 2025 20:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1737087256; x=1737692056; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2ROuh+929mMDC4iky0HeNpGaSK8yH5uKAPHH6U0Cgig=;
        b=QgxKZoUuJZdhShVn/n2ZaW5MBxU5zfzJpz7rkYuwtYboE3Qh7Q6bS3Sp1C+OaxOk+q
         0tlOSmnG/IBR9GuyEd3p3qkrVFGw5uf5+W39mJdblp+dgnCWPsjfbOVlvQ39xJKXhDlL
         A/wGvp47Mvygc/FJVQwCEs2xYHr3n0Vs1qxMGdn7vSbaePUZ8xScY6BgEm8766bQa2eS
         igRKU6opo1WWM+eQPqJxYfndQ+HMIY8WsNQhP82+KkVLYKyLC3pdj4iuD2PgFq6vL9Vg
         lzdS+f/vYqD47v+lKKJjycf0gQAl1XRJeN0jjcI4yy6P5vogH+18ianhbnPM5/lI2MPx
         qYmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1737087256; x=1737692056;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2ROuh+929mMDC4iky0HeNpGaSK8yH5uKAPHH6U0Cgig=;
        b=N4+QxAsWzSIwNeDIabf7z2dC8+z2eITGT41/UVCZYtSVsQ8NmIxQ/nlx8faIm0eo9s
         8xOf7Bo89PV5oIUWbL/i9dxxUgWakZLZpWy1bSO5f4anx2Kx1Nt0/6wgPugeliVLWdVo
         ++aD1Yigc0PyiRmMYVrWsujMPja7c3lPdo2I5IJFZCOlwAKehicmG93wqNfu5KMWaQs4
         D6rTkDuDhSb6VbFKGcuhOu+qDBTds2bXhEzRcSo0EhJ4/xvcdiMRtK50yh81A5fzIUpj
         lM1me2u7aVMQFs/8s9wESqEJ/7i3I2ao0DieA0K1ZRV71Bif+qUoDkUKiJhOT+VbreoD
         hkUw==
X-Forwarded-Encrypted: i=1; AJvYcCXav6LVpmUm5DVYJukf2iiygj3hWy+JH+rTaqB3YQub5+5Ib7cZBLPmTy7SzCPfJrkjgn1pNaCA1xrlUzNIeQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwaQS7SIefkPaGj51zZ8lT8jDwygeXi90s36/xfJz2uRfRFjht1
	3AMb0+iTPUl1j8SNMW/TeS08jURbLOVV4ZGbUdu5ouuucR0EcFZNIRZ6X63IQyOCzCNdQP2FmhQ
	Zqwj9d1YyMv0b4va7pm3F0CkQlhIF3KqLKOhR
X-Gm-Gg: ASbGncsc2tQSN1BfmD8g2STJ9xjObmivX3W1OgPFzCkiyyoMWKw2GVNAa3FOgVatdBd
	mnLq4ONe1hILFEZGohfRnTd5FmUwOwh78/DZSHKw=
X-Google-Smtp-Source: AGHT+IE4PfKh6ogwR1JVx6LitwiG4+7efC8fuqXr6Z2dZC2zmrgG+fkQtJbyATAiKB8JS8qBK/uHXwJg521mcICmyHU=
X-Received: by 2002:a17:907:86aa:b0:ab2:faed:e305 with SMTP id
 a640c23a62f3a-ab38b1b2689mr100447766b.10.1737087255504; Thu, 16 Jan 2025
 20:14:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <000000000000c1ae9e062164e101@google.com> <6789d55f.050a0220.20d369.004e.GAE@google.com>
In-Reply-To: <6789d55f.050a0220.20d369.004e.GAE@google.com>
From: Eric Dumazet <edumazet@google.com>
Date: Fri, 17 Jan 2025 05:14:04 +0100
X-Gm-Features: AbW1kvaOdOQCmXS2ovmr2OC6hdwPt3leOeWr0-9snK5mArRAYsxnNsyWeFjQ1kI
Message-ID: <CANn89iJiQeF=7g0wFVOZ=TMUnL-7U0xvw4ZQL5H5f4+ChBp__w@mail.gmail.com>
Subject: Re: [syzbot] [wireless?] possible deadlock in ieee80211_remove_interfaces
To: syzbot <syzbot+5b9196ecf74447172a9a@syzkaller.appspotmail.com>
Cc: davem@davemloft.net, johannes@sipsolutions.net, kuba@kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 17, 2025 at 4:58=E2=80=AFAM syzbot
<syzbot+5b9196ecf74447172a9a@syzkaller.appspotmail.com> wrote:
>
> syzbot has found a reproducer for the following issue on:
>
> HEAD commit:    8d20dcda404d selftests: drv-net-hw: inject pp_alloc_fail =
e..
> git tree:       net-next
> console output: https://syzkaller.appspot.com/x/log.txt?x=3D14ef5a1858000=
0
> kernel config:  https://syzkaller.appspot.com/x/.config?x=3Dc30f048a4f128=
91
> dashboard link: https://syzkaller.appspot.com/bug?extid=3D5b9196ecf744471=
72a9a
> compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Deb=
ian) 2.40
> syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D15d7a1f8580=
000
>
> Downloadable assets:
> disk image: https://storage.googleapis.com/syzbot-assets/5ce07c743ced/dis=
k-8d20dcda.raw.xz
> vmlinux: https://storage.googleapis.com/syzbot-assets/66f2a9a35d5e/vmlinu=
x-8d20dcda.xz
> kernel image: https://storage.googleapis.com/syzbot-assets/4c790c086a46/b=
zImage-8d20dcda.xz
>
> IMPORTANT: if you fix the issue, please add the following tag to the comm=
it:
> Reported-by: syzbot+5b9196ecf74447172a9a@syzkaller.appspotmail.com
>
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D
> WARNING: possible circular locking dependency detected
> 6.13.0-rc7-syzkaller-01131-g8d20dcda404d #0 Not tainted
> ------------------------------------------------------
> kworker/u8:6/3534 is trying to acquire lock:
> ffffffff8fcb4a08 (rtnl_mutex){+.+.}-{4:4}, at: rtnl_acquire_if_cleanup_ne=
t net/core/dev.c:10281 [inline]
> ffffffff8fcb4a08 (rtnl_mutex){+.+.}-{4:4}, at: unregister_netdevice_many_=
notify+0xac2/0x2030 net/core/dev.c:11783
>
> but task is already holding lock:
> ffff8880216b0768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_construc=
tor include/net/cfg80211.h:6034 [inline]
> ffff8880216b0768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: ieee80211_remove_int=
erfaces+0x129/0x700 net/mac80211/iface.c:2276
>
> which lock already depends on the new lock.
>
>
> the existing dependency chain (in reverse order) is:
>
> -> #1 (&rdev->wiphy.mtx){+.+.}-{4:4}:
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>        __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>        __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
>        wiphy_lock include/net/cfg80211.h:6019 [inline]
>        wiphy_register+0x1a49/0x27b0 net/wireless/core.c:1006
>        ieee80211_register_hw+0x30fb/0x3e10 net/mac80211/main.c:1582
>        mac80211_hwsim_new_radio+0x2a9f/0x4a90 drivers/net/wireless/virtua=
l/mac80211_hwsim.c:5558
>        init_mac80211_hwsim+0x87a/0xb00 drivers/net/wireless/virtual/mac80=
211_hwsim.c:6910
>        do_one_initcall+0x248/0x870 init/main.c:1266
>        do_initcall_level+0x157/0x210 init/main.c:1328
>        do_initcalls+0x3f/0x80 init/main.c:1344
>        kernel_init_freeable+0x435/0x5d0 init/main.c:1577
>        kernel_init+0x1d/0x2b0 init/main.c:1466
>        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> -> #0 (rtnl_mutex){+.+.}-{4:4}:
>        check_prev_add kernel/locking/lockdep.c:3161 [inline]
>        check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>        validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
>        __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
>        lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>        __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>        __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
>        rtnl_acquire_if_cleanup_net net/core/dev.c:10281 [inline]
>        unregister_netdevice_many_notify+0xac2/0x2030 net/core/dev.c:11783
>        unregister_netdevice_many net/core/dev.c:11866 [inline]
>        unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11732
>        unregister_netdevice include/linux/netdevice.h:3320 [inline]
>        _cfg80211_unregister_wdev+0x163/0x590 net/wireless/core.c:1251
>        ieee80211_remove_interfaces+0x4ef/0x700 net/mac80211/iface.c:2301
>        ieee80211_unregister_hw+0x5d/0x2c0 net/mac80211/main.c:1676
>        mac80211_hwsim_del_radio+0x2c4/0x4c0 drivers/net/wireless/virtual/=
mac80211_hwsim.c:5664
>        hwsim_exit_net+0x5c1/0x670 drivers/net/wireless/virtual/mac80211_h=
wsim.c:6544
>        ops_exit_list net/core/net_namespace.c:172 [inline]
>        cleanup_net+0x812/0xd60 net/core/net_namespace.c:652
>        process_one_work kernel/workqueue.c:3236 [inline]
>        process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
>        worker_thread+0x870/0xd30 kernel/workqueue.c:3398
>        kthread+0x2f0/0x390 kernel/kthread.c:389
>        ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>        ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>
> other info that might help us debug this:
>
>  Possible unsafe locking scenario:
>
>        CPU0                    CPU1
>        ----                    ----
>   lock(&rdev->wiphy.mtx);
>                                lock(rtnl_mutex);
>                                lock(&rdev->wiphy.mtx);
>   lock(rtnl_mutex);
>
>  *** DEADLOCK ***
>
> 4 locks held by kworker/u8:6/3534:
>  #0: ffff88801baf5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_one=
_work kernel/workqueue.c:3211 [inline]
>  #0: ffff88801baf5948 ((wq_completion)netns){+.+.}-{0:0}, at: process_sch=
eduled_works+0x93b/0x1840 kernel/workqueue.c:3317
>  #1: ffffc9000d507d00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_wor=
k kernel/workqueue.c:3212 [inline]
>  #1: ffffc9000d507d00 (net_cleanup_work){+.+.}-{0:0}, at: process_schedul=
ed_works+0x976/0x1840 kernel/workqueue.c:3317
>  #2: ffffffff8fca8290 (pernet_ops_rwsem){++++}-{4:4}, at: cleanup_net+0x1=
7a/0xd60 net/core/net_namespace.c:606
>  #3: ffff8880216b0768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: class_wiphy_con=
structor include/net/cfg80211.h:6034 [inline]
>  #3: ffff8880216b0768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: ieee80211_remov=
e_interfaces+0x129/0x700 net/mac80211/iface.c:2276
>
> stack backtrace:
> CPU: 1 UID: 0 PID: 3534 Comm: kworker/u8:6 Not tainted 6.13.0-rc7-syzkall=
er-01131-g8d20dcda404d #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS G=
oogle 12/27/2024
> Workqueue: netns cleanup_net
> Call Trace:
>  <TASK>
>  __dump_stack lib/dump_stack.c:94 [inline]
>  dump_stack_lvl+0x241/0x360 lib/dump_stack.c:120
>  print_circular_bug+0x13a/0x1b0 kernel/locking/lockdep.c:2074
>  check_noncircular+0x36a/0x4a0 kernel/locking/lockdep.c:2206
>  check_prev_add kernel/locking/lockdep.c:3161 [inline]
>  check_prevs_add kernel/locking/lockdep.c:3280 [inline]
>  validate_chain+0x18ef/0x5920 kernel/locking/lockdep.c:3904
>  __lock_acquire+0x1397/0x2100 kernel/locking/lockdep.c:5226
>  lock_acquire+0x1ed/0x550 kernel/locking/lockdep.c:5849
>  __mutex_lock_common kernel/locking/mutex.c:585 [inline]
>  __mutex_lock+0x1ac/0xee0 kernel/locking/mutex.c:735
>  rtnl_acquire_if_cleanup_net net/core/dev.c:10281 [inline]
>  unregister_netdevice_many_notify+0xac2/0x2030 net/core/dev.c:11783
>  unregister_netdevice_many net/core/dev.c:11866 [inline]
>  unregister_netdevice_queue+0x303/0x370 net/core/dev.c:11732
>  unregister_netdevice include/linux/netdevice.h:3320 [inline]
>  _cfg80211_unregister_wdev+0x163/0x590 net/wireless/core.c:1251
>  ieee80211_remove_interfaces+0x4ef/0x700 net/mac80211/iface.c:2301
>  ieee80211_unregister_hw+0x5d/0x2c0 net/mac80211/main.c:1676
>  mac80211_hwsim_del_radio+0x2c4/0x4c0 drivers/net/wireless/virtual/mac802=
11_hwsim.c:5664
>  hwsim_exit_net+0x5c1/0x670 drivers/net/wireless/virtual/mac80211_hwsim.c=
:6544
>  ops_exit_list net/core/net_namespace.c:172 [inline]
>  cleanup_net+0x812/0xd60 net/core/net_namespace.c:652
>  process_one_work kernel/workqueue.c:3236 [inline]
>  process_scheduled_works+0xa66/0x1840 kernel/workqueue.c:3317
>  worker_thread+0x870/0xd30 kernel/workqueue.c:3398
>  kthread+0x2f0/0x390 kernel/kthread.c:389
>  ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
>  ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
>  </TASK>
> hsr_slave_0: left promiscuous mode
> hsr_slave_1: left promiscuous mode
> batman_adv: batadv0: Interface deactivated: batadv_slave_0
> batman_adv: batadv0: Removing interface: batadv_slave_0
> batman_adv: batadv0: Interface deactivated: batadv_slave_1
> batman_adv: batadv0: Removing interface: batadv_slave_1
> veth1_macvtap: left promiscuous mode
> veth0_macvtap: left promiscuous mode
> veth1_vlan: left promiscuous mode
> veth0_vlan: left promiscuous mode
> team0 (unregistering): Port device team_slave_1 removed
> team0 (unregistering): Port device team_slave_0 removed
> bridge0: port 2(bridge_slave_1) entered blocking state
> bridge0: port 2(bridge_slave_1) entered forwarding state
> bridge0: port 1(bridge_slave_0) entered blocking state
> bridge0: port 1(bridge_slave_0) entered forwarding state
> bridge0: port 2(bridge_slave_1) entered blocking state
> bridge0: port 2(bridge_slave_1) entered forwarding state
>
>
> ---
> If you want syzbot to run the reproducer, reply with:
> #syz test: git://repo/address.git branch-or-commit-hash
> If you attach or paste a git patch, syzbot will apply it before testing.

This repro is for another bug I think, caused by my recent commits in net-n=
ext:

83419b61d187ce22aa3da5ffdda850fca3a12600 net: reduce RTNL hold
duration in unregister_netdevice_many_notify() (part 2)
ae646f1a0bb97401bac0044bbe2a179a1e38b408 net: reduce RTNL hold
duration in unregister_netdevice_many_notify() (part 1)
cfa579f6665635b72d4a075fc91eb144c2b0f74e net: no longer hold RTNL
while calling flush_all_backlogs()

cleanup_net()
  rtnl_lock();
    mutex_lock(subsystem_mutex);

    unregister_netdevice();

       rtnl_unlock();       // LOCKDEP violation
       rtnl_lock();

I will work today on a fix, auditing all unregister_netdevice() and
unregister_netdevice_many()
and select which of them can safely opt-in for a variant which _can_
temporarily release RTNL.

