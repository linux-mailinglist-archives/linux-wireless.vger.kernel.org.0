Return-Path: <linux-wireless+bounces-13941-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 96BC999C67C
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 11:54:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BA9C41C22EE5
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Oct 2024 09:54:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1B71146D55;
	Mon, 14 Oct 2024 09:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tL2RFCGc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-pj1-f51.google.com (mail-pj1-f51.google.com [209.85.216.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C87FE15B99D
	for <linux-wireless@vger.kernel.org>; Mon, 14 Oct 2024 09:54:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728899655; cv=none; b=beL5sa+J1eF3B4JwoX845Z4KejTKNH1mT9RD7o7dnHjZMEwFk0lMJa1aj5K/BH4Nulrb/cDYFBxYVLLfmc5PSP7doHHQf4FrMu0Qu4SVGfhqYAhWVcS0uNUz2QGmnctRZfzxdsQgWjgREY46r3Cy78PU/trSaiABoGV1PvZcrQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728899655; c=relaxed/simple;
	bh=DVBd3qXDpONaqbNtzNeQIdNWsAb8y/r9hmaj7fksrhA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pSrRXJNF2yQEZXZnC0zOpfAK8kEzyRuXXp0KTYWtkO0SEQ58Kk0gS2V+GGrSiE1ckliQavyBlxExSIy7vvwVIjXqZEews5kUoGAF1uxKEdY3EwTj//PC3zzcUjKSFpM9eBMca2lg7m1xcvVJKIukNDXWJ6xp7fOR19jjfO3zRSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tL2RFCGc; arc=none smtp.client-ip=209.85.216.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Received: by mail-pj1-f51.google.com with SMTP id 98e67ed59e1d1-2e2ed59a35eso2736733a91.0
        for <linux-wireless@vger.kernel.org>; Mon, 14 Oct 2024 02:54:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1728899653; x=1729504453; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=M1Faqy3HxaOuKMHfc4NtonnnYTIZWAT6guhpv3enJlk=;
        b=tL2RFCGcNOCrnZp9BUIS17bgFfpr2Hhj60/DmHRp4HaK047tR2oYyukI8xMIzpCJXy
         N7rAdAXwXSXry+fyCuZz+twrwRrjhO4Nb8wZ2d19496Aa0w4EJGmuZiJwGdDGKk++S0l
         wk8gUQwdzkbExA9dn2UC8j/eG/gZAPsjLJ5CgPqBquGMgxm8Cp0Ryyopgh/tCChdxBbH
         DRt/5/BeE91hiONESRKIhZTvyV17zhuRyVrucR8gKJ264k3XVykrAfB978mp0q2Mcy88
         oSgpaRpBOFEtlDtXJraWR8oi9pKotn/k+cj0Pk/PUySVREakGIo5oe4dRoSnEySI6G0Y
         qehA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728899653; x=1729504453;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=M1Faqy3HxaOuKMHfc4NtonnnYTIZWAT6guhpv3enJlk=;
        b=mUo87RA2+myGOSyqbQEa7fTQnK4WxDtWRYAlfG1fZxquJL7WyxWbh6OwucHVP/ls5c
         ZBnfOp1SEKrON++PTKLfeuqj5Ctt07wVT8SwgvMD/PRFn7cMdLA0AVMOSUWZx3dLIb/0
         x6oAcI91b28WXSyGOwII/Vbep3NZlkTDDIh2bb2Kg8vko4Uv5sGOruChaPdLugRzQCAk
         m0XnxXrK/WKEQcWDSYG6rUkuHE+9o2VwVtzmF6DMOJxMKty3ea36VYbdMRU8TH3EWQfn
         0xmvgFO1Lp7nOooLN+IUGFgRSr4etMA6cQV5Ga6S8EMVnWSwqicCF3fOi/OyqtfckjTN
         GrFw==
X-Forwarded-Encrypted: i=1; AJvYcCUb+DcJVGchz0aONBsrdHIXsrtCuAo8AxJn/BkAyPdZHZ8qg/x/8aG9wzKyTE3OdW5WP2AXZ0zDnIEMn0AMEA==@vger.kernel.org
X-Gm-Message-State: AOJu0YySjFv2fl1JxPKRChtHnzevu3rGyNchVzPXIYfZcA/88sXM5zlt
	dxBw57tAz2d7tyenhti+7swcWGVgXZS3yXUEMvhKdYbX4jxlg6ZlzxJy1lK0BKNH++Iy536U/Bi
	svEYJztH2N6nSjEEQENhQ3wqgalOuO7v+RHI7
X-Google-Smtp-Source: AGHT+IH45tjvIMTh7lS27dhZHd+EASEQRoQe+56iSwpDqOwOAKP1mYq09lv+pqCa+9Fiztw9fCqY9G1PxH88qqzf2zw=
X-Received: by 2002:a17:90a:e2d7:b0:2e2:cc47:f1b0 with SMTP id
 98e67ed59e1d1-2e2f0a065c3mr13511926a91.3.1728899652765; Mon, 14 Oct 2024
 02:54:12 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <6707f07f.050a0220.64b99.001b.GAE@google.com> <05d3d02d-69c7-24a4-c2b2-26bdb53556db@candelatech.com>
In-Reply-To: <05d3d02d-69c7-24a4-c2b2-26bdb53556db@candelatech.com>
From: Aleksandr Nogikh <nogikh@google.com>
Date: Mon, 14 Oct 2024 11:54:00 +0200
Message-ID: <CANp29Y5Jc9VG107iV1jKJuLi4H20TUpYLuLWzddan0=39qwCKw@mail.gmail.com>
Subject: Re: [syzbot] [wireless?] INFO: task hung in cfg80211_event_work (4)
To: Ben Greear <greearb@candelatech.com>
Cc: syzbot <syzbot+5506b2556159a1ab6923@syzkaller.appspotmail.com>, 
	davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Ben,

On Fri, Oct 11, 2024 at 11:50=E2=80=AFAM Ben Greear <greearb@candelatech.co=
m> wrote:
>
> On 10/10/24 08:19, syzbot wrote:
> > Hello,
> >
> > syzbot found the following issue on:
> >
> > HEAD commit:    2a130b7e1fcd Merge tag 'kbuild-fixes-v6.12' of git://gi=
t.k..
> > git tree:       upstream
> > console output: https://syzkaller.appspot.com/x/log.txt?x=3D1206e79f980=
000
> > kernel config:  https://syzkaller.appspot.com/x/.config?x=3Df38c36a9554=
31c1
> > dashboard link: https://syzkaller.appspot.com/bug?extid=3D5506b2556159a=
1ab6923
> > compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for D=
ebian) 2.40
> > syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=3D155b83279=
80000
>
> This looks like something I saw in 6.11 and 6.10.  My guess was that one =
of the
> running processes that lockdep does not print locks for is holding the wi=
phy mtx.
>
> Maybe it would help if syzbot would use sysrq to dump all running tasks t=
o the console, and maybe
> lockdep could print locks for running processes, even if they are marked =
as potentially
> unreliable?

Thanks for the suggestions!

We do have an open issue re. SysRq:
https://github.com/google/syzkaller/issues/4200
I've noted a +1 to that.

Regarding the locks -- they are actually already printed in the
original bug report, under "Showing all locks held in the system:". Or
did you mean something else?

--=20
Aleksandr

>
> Thanks,
> Ben
>
> >
> > Downloadable assets:
> > disk image (non-bootable): https://storage.googleapis.com/syzbot-assets=
/7feb34a89c2a/non_bootable_disk-2a130b7e.raw.xz
> > vmlinux: https://storage.googleapis.com/syzbot-assets/ea0b899b6053/vmli=
nux-2a130b7e.xz
> > kernel image: https://storage.googleapis.com/syzbot-assets/4ef0bad329fe=
/bzImage-2a130b7e.xz
> >
> > IMPORTANT: if you fix the issue, please add the following tag to the co=
mmit:
> > Reported-by: syzbot+5506b2556159a1ab6923@syzkaller.appspotmail.com
> >
> > INFO: task kworker/u4:4:5271 blocked for more than 143 seconds.
> >        Not tainted 6.12.0-rc1-syzkaller-00381-g2a130b7e1fcd #0
> > "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this messag=
e.
> > task:kworker/u4:4    state:D stack:25712 pid:5271  tgid:5271  ppid:2   =
   flags:0x00004000
> > Workqueue: cfg80211 cfg80211_event_work
> > Call Trace:
> >   <TASK>
> >   context_switch kernel/sched/core.c:5315 [inline]
> >   __schedule+0x1895/0x4b30 kernel/sched/core.c:6675
> >   __schedule_loop kernel/sched/core.c:6752 [inline]
> >   schedule+0x14b/0x320 kernel/sched/core.c:6767
> >   schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6824
> >   __mutex_lock_common kernel/locking/mutex.c:684 [inline]
> >   __mutex_lock+0x6a7/0xd70 kernel/locking/mutex.c:752
> >   wiphy_lock include/net/cfg80211.h:6014 [inline]
> >   cfg80211_event_work+0x27/0x40 net/wireless/core.c:334
> >   process_one_work kernel/workqueue.c:3229 [inline]
> >   process_scheduled_works+0xa63/0x1850 kernel/workqueue.c:3310
> >   worker_thread+0x870/0xd30 kernel/workqueue.c:3391
> >   kthread+0x2f0/0x390 kernel/kthread.c:389
> >   ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
> >   ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
> >   </TASK>
> >
> > Showing all locks held in the system:
> > 1 lock held by khungtaskd/25:
> >   #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquir=
e include/linux/rcupdate.h:337 [inline]
> >   #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock i=
nclude/linux/rcupdate.h:849 [inline]
> >   #0: ffffffff8e937de0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_=
locks+0x55/0x2a0 kernel/locking/lockdep.c:6720
> > 1 lock held by kswapd0/73:
> > 3 locks held by kworker/0:3/909:
> > 3 locks held by kworker/u4:9/2509:
> > 3 locks held by kworker/u4:11/3318:
> > 1 lock held by dhcpcd/4814:
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core=
/rtnetlink.c:79 [inline]
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+=
0x6e6/0xcf0 net/core/rtnetlink.c:6643
> > 2 locks held by getty/4897:
> >   #0: ffff88801dda90a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref=
_wait+0x25/0x70 drivers/tty/tty_ldisc.c:243
> >   #1: ffffc9000039b2f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tt=
y_read+0x6a6/0x1e00 drivers/tty/n_tty.c:2211
> > 3 locks held by kworker/u4:0/5118:
> >   #0: ffff88803c425948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: =
process_one_work kernel/workqueue.c:3204 [inline]
> >   #0: ffff88803c425948 ((wq_completion)ipv6_addrconf){+.+.}-{0:0}, at: =
process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
> >   #1: ffffc90002d1fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+=
.}-{0:0}, at: process_one_work kernel/workqueue.c:3205 [inline]
> >   #1: ffffc90002d1fd00 ((work_completion)(&(&ifa->dad_work)->work)){+.+=
.}-{0:0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
> >   #2: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: addrconf_dad_work+=
0xd0/0x16f0 net/ipv6/addrconf.c:4196
> > 3 locks held by kworker/0:2/5170:
> > 2 locks held by kworker/u4:2/5176:
> > 3 locks held by kworker/u4:3/5211:
> > 1 lock held by syz-executor/5254:
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers=
/net/tun.c:698 [inline]
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b=
/0x1b0 drivers/net/tun.c:3517
> > 1 lock held by syz-executor/5255:
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers=
/net/tun.c:698 [inline]
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b=
/0x1b0 drivers/net/tun.c:3517
> > 1 lock held by syz-executor/5258:
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers=
/net/tun.c:698 [inline]
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b=
/0x1b0 drivers/net/tun.c:3517
> > 1 lock held by syz-executor/5264:
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers=
/net/tun.c:698 [inline]
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b=
/0x1b0 drivers/net/tun.c:3517
> > 3 locks held by kworker/u4:4/5271:
> >   #0: ffff88801ebdf948 ((wq_completion)cfg80211){+.+.}-{0:0}, at: proce=
ss_one_work kernel/workqueue.c:3204 [inline]
> >   #0: ffff88801ebdf948 ((wq_completion)cfg80211){+.+.}-{0:0}, at: proce=
ss_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
> >   #1: ffffc90002617d00 ((work_completion)(&rdev->event_work)){+.+.}-{0:=
0}, at: process_one_work kernel/workqueue.c:3205 [inline]
> >   #1: ffffc90002617d00 ((work_completion)(&rdev->event_work)){+.+.}-{0:=
0}, at: process_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
> >   #2: ffff888055538768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock i=
nclude/net/cfg80211.h:6014 [inline]
> >   #2: ffff888055538768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: cfg80211_eve=
nt_work+0x27/0x40 net/wireless/core.c:334
> > 1 lock held by syz-executor/5273:
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_detach drivers=
/net/tun.c:698 [inline]
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: tun_chr_close+0x3b=
/0x1b0 drivers/net/tun.c:3517
> > 3 locks held by kworker/u4:6/5278:
> > 4 locks held by kworker/0:6/5390:
> >   #0: ffff88801ac75948 ((wq_completion)events_power_efficient){+.+.}-{0=
:0}, at: process_one_work kernel/workqueue.c:3204 [inline]
> >   #0: ffff88801ac75948 ((wq_completion)events_power_efficient){+.+.}-{0=
:0}, at: process_scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
> >   #1: ffffc90002adfd00 ((reg_check_chans).work){+.+.}-{0:0}, at: proces=
s_one_work kernel/workqueue.c:3205 [inline]
> >   #1: ffffc90002adfd00 ((reg_check_chans).work){+.+.}-{0:0}, at: proces=
s_scheduled_works+0x976/0x1850 kernel/workqueue.c:3310
> >   #2: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: reg_check_chans_wo=
rk+0x99/0xfd0 net/wireless/reg.c:2480
> >   #3: ffff888055538768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: wiphy_lock i=
nclude/net/cfg80211.h:6014 [inline]
> >   #3: ffff888055538768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: reg_leave_in=
valid_chans net/wireless/reg.c:2468 [inline]
> >   #3: ffff888055538768 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: reg_check_ch=
ans_work+0x164/0xfd0 net/wireless/reg.c:2483
> > 3 locks held by kworker/0:9/5444:
> > 3 locks held by kworker/0:10/5446:
> > 2 locks held by kworker/0:12/5449:
> > 3 locks held by kworker/0:14/5454:
> > 2 locks held by kworker/0:15/5455:
> > 3 locks held by kworker/0:16/5456:
> > 4 locks held by kworker/u4:10/5469:
> >   #0: ffff88801be8b148 ((wq_completion)netns){+.+.}-{0:0}, at: process_=
one_work kernel/workqueue.c:3204 [inline]
> >   #0: ffff88801be8b148 ((wq_completion)netns){+.+.}-{0:0}, at: process_=
scheduled_works+0x93b/0x1850 kernel/workqueue.c:3310
> >   #1: ffffc90002cafd00 (net_cleanup_work){+.+.}-{0:0}, at: process_one_=
work kernel/workqueue.c:3205 [inline]
> >   #1: ffffc90002cafd00 (net_cleanup_work){+.+.}-{0:0}, at: process_sche=
duled_works+0x976/0x1850 kernel/workqueue.c:3310
> >   #2: ffffffff8fcc51d0 (pernet_ops_rwsem){++++}-{3:3}, at: cleanup_net+=
0x16a/0xcc0 net/core/net_namespace.c:580
> >   #3: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: wg_netns_pre_exit+=
0x1f/0x1e0 drivers/net/wireguard/device.c:414
> > 2 locks held by kworker/u4:13/5492:
> > 1 lock held by syz-executor/5502:
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core=
/rtnetlink.c:79 [inline]
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+=
0x6e6/0xcf0 net/core/rtnetlink.c:6643
> > 1 lock held by syz-executor/5515:
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core=
/rtnetlink.c:79 [inline]
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+=
0x6e6/0xcf0 net/core/rtnetlink.c:6643
> > 1 lock held by syz-executor/5522:
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core=
/rtnetlink.c:79 [inline]
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+=
0x6e6/0xcf0 net/core/rtnetlink.c:6643
> > 1 lock held by syz-executor/5526:
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core=
/rtnetlink.c:79 [inline]
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+=
0x6e6/0xcf0 net/core/rtnetlink.c:6643
> > 1 lock held by syz-executor/5534:
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core=
/rtnetlink.c:79 [inline]
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+=
0x6e6/0xcf0 net/core/rtnetlink.c:6643
> > 1 lock held by syz-executor/5535:
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core=
/rtnetlink.c:79 [inline]
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+=
0x6e6/0xcf0 net/core/rtnetlink.c:6643
> > 1 lock held by syz-executor/5550:
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core=
/rtnetlink.c:79 [inline]
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+=
0x6e6/0xcf0 net/core/rtnetlink.c:6643
> > 1 lock held by syz-executor/5553:
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core=
/rtnetlink.c:79 [inline]
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+=
0x6e6/0xcf0 net/core/rtnetlink.c:6643
> > 1 lock held by syz-executor/5557:
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core=
/rtnetlink.c:79 [inline]
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+=
0x6e6/0xcf0 net/core/rtnetlink.c:6643
> > 1 lock held by syz-executor/5562:
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core=
/rtnetlink.c:79 [inline]
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+=
0x6e6/0xcf0 net/core/rtnetlink.c:6643
> > 1 lock held by syz-executor/5569:
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core=
/rtnetlink.c:79 [inline]
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+=
0x6e6/0xcf0 net/core/rtnetlink.c:6643
> > 1 lock held by syz-executor/5573:
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnl_lock net/core=
/rtnetlink.c:79 [inline]
> >   #0: ffffffff8fcd1cc8 (rtnl_mutex){+.+.}-{3:3}, at: rtnetlink_rcv_msg+=
0x6e6/0xcf0 net/core/rtnetlink.c:6643
> >
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
>
> --
> Ben Greear <greearb@candelatech.com>
> Candela Technologies Inc  http://www.candelatech.com
>
>
> --
> You received this message because you are subscribed to the Google Groups=
 "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an=
 email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgi=
d/syzkaller-bugs/05d3d02d-69c7-24a4-c2b2-26bdb53556db%40candelatech.com.

