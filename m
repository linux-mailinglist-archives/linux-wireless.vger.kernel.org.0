Return-Path: <linux-wireless+bounces-8328-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A83B8D52F0
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 22:15:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 26EC62874B1
	for <lists+linux-wireless@lfdr.de>; Thu, 30 May 2024 20:15:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8ABE135A7E;
	Thu, 30 May 2024 20:15:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f79.google.com (mail-io1-f79.google.com [209.85.166.79])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4047474052
	for <linux-wireless@vger.kernel.org>; Thu, 30 May 2024 20:15:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.79
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717100128; cv=none; b=nuNb0OyIg5psSqmj82PQB4J4UkxKbDiR1SxiIYp7dvwGYtJ3AsEGHts8ZK0+wgjGfVQOwvoCTSsCU7FEWnMsMYclowC4d00LqV4xnvh6Bo17QsDsmxc/EVPlxcb7Ul66y3q0hzZ2j+3r4+FV98//qNJ8FulwMzldi13cScKuGCA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717100128; c=relaxed/simple;
	bh=eYSGgU0e7o3r5dR8Tt7lVgtJXXcKm4en1UBjrXl2qC8=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=s6D+lXEAGydpqF0cxPuL4RxCtFv+ETjJAz14p7xcZvSA0bSZy3SP4boLaGyBWC2e8fXvZm3rPfvAe1w2yVOvM+WZobx198nPq+YiYyQ69dSFBawAuKXwb78lSc3PONYNrMxtvvydN2iUVxUCH+wSuPts1NNge+UT8b6/37gco7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.79
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f79.google.com with SMTP id ca18e2360f4ac-7e6ff0120a5so38282239f.1
        for <linux-wireless@vger.kernel.org>; Thu, 30 May 2024 13:15:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717100126; x=1717704926;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=A3StR6mZe3YmJy3qS4VUKmhxhqo1zmXvkNJZo68Xt4w=;
        b=OY/Lbczl2f47T1B7Z4ZplOIPZ/VlI6HbM18YTpzbfoxgfozzuXpyLepEBtkAd/dEU/
         /C/8+H/RIY8Ah4qC23jiG36cgJINIwSQYWCbWuuT0tkrkJ5bPxoYEJlFxRwQvDRcTBsv
         E3JHIqtOqs/Fqf7wz+lrHDNw9+nuSOjC5L9FsY9DFptBQ61iYLLrzZtjP2Dja7mgRlKj
         7Ge5er53PFCusKKvGEyfCTmhb/I8JdIg7gR3ZhVttTdg5e6kDER98wrHfrHPKCYe9uJZ
         KIwsqTJPztKPFsCFE/muIN0UVA7ZYLvc/izEej9jKI3MY/MiAlioTHKDILddmvpEeYtC
         thgw==
X-Forwarded-Encrypted: i=1; AJvYcCUe+nUA7UMduZGglukYvIw6rD3OqoqpEAJ8pCY3WszP5NqDbLcNQYikz4yav/IL58+n6Tw4BeyfuntP45oHa1AMrYvdSNvc/gslNxlGJUs=
X-Gm-Message-State: AOJu0YxWx0TwHNwymNkbUmCyn0BQlkeAycUA8gNFuWp81Zew8Z1lXrW1
	tELev3EXIgFqlHeTPlfjS4xuas3fk8w41jXmftDos6ux/Jxc4Tg3B5FELyghOGFri8VpV90oShc
	Xpu57/QOj6wjOcvh0tx8huufveS5KCxc2GUZ3PRFJnVDSItdJvZQ4ZSU=
X-Google-Smtp-Source: AGHT+IGRB/tWbS4xqZF+WYsVWxEe1U0FocGy13H0qds2KNsHhd+oXsKOL5MvlPaU53/mLxxTkpVlTv6dtJI4bzKVp/MiDr/Su3cV
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:35a5:b0:488:7838:5aba with SMTP id
 8926c6da1cb9f-4b1e4c01d47mr217371173.2.1717100126558; Thu, 30 May 2024
 13:15:26 -0700 (PDT)
Date: Thu, 30 May 2024 13:15:26 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000166d3c0619b187e8@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in ieee80211_unregister_hw
From: syzbot <syzbot+2782e03212f5ae711088@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    e0cce98fe279 Merge tag 'tpmdd-next-6.10-rc2' of git://git...
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=125ada62980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=238430243a58f702
dashboard link: https://syzkaller.appspot.com/bug?extid=2782e03212f5ae711088
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/d23687674aed/disk-e0cce98f.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/780007429aa0/vmlinux-e0cce98f.xz
kernel image: https://storage.googleapis.com/syzbot-assets/43ef750cb8d4/bzImage-e0cce98f.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+2782e03212f5ae711088@syzkaller.appspotmail.com

INFO: task kworker/u8:3:51 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc1-syzkaller-00021-ge0cce98fe279 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/u8:3    state:D stack:24512 pid:51    tgid:51    ppid:2      flags:0x00004000
Workqueue: netns cleanup_net
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 ieee80211_unregister_hw+0x4d/0x3a0 net/mac80211/main.c:1645
 mac80211_hwsim_del_radio drivers/net/wireless/virtual/mac80211_hwsim.c:5576 [inline]
 hwsim_exit_net+0x3ad/0x7d0 drivers/net/wireless/virtual/mac80211_hwsim.c:6453
 ops_exit_list+0xb0/0x180 net/core/net_namespace.c:173
 cleanup_net+0x5b7/0xbf0 net/core/net_namespace.c:640
 process_one_work+0x9fb/0x1b60 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz-executor.1:5928 blocked for more than 143 seconds.
      Not tainted 6.10.0-rc1-syzkaller-00021-ge0cce98fe279 #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz-executor.1  state:D stack:25408 pid:5928  tgid:5928  ppid:1      flags:0x00000006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5408 [inline]
 __schedule+0xf15/0x5d00 kernel/sched/core.c:6745
 __schedule_loop kernel/sched/core.c:6822 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6837
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6894
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 rtnl_lock net/core/rtnetlink.c:79 [inline]
 rtnetlink_rcv_msg+0x372/0xe60 net/core/rtnetlink.c:6592
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2564
 netlink_unicast_kernel net/netlink/af_netlink.c:1335 [inline]
 netlink_unicast+0x542/0x820 net/netlink/af_netlink.c:1361
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1905
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x47f/0x4e0 net/socket.c:2192


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

