Return-Path: <linux-wireless+bounces-10391-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id DED5D93782F
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 15:15:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 98D8B28222E
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Jul 2024 13:15:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CF65126F1E;
	Fri, 19 Jul 2024 13:15:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9F2B29CE6
	for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 13:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721394928; cv=none; b=Jstoy7fMCYTKyUPuxf/c17d7Lb4jnaTWjYxY2ZlKVGSMfUl3oJR8wRxaT6lAQ62+KzeRds9zBE0jtvzjH5Rdk7NZ7z7P7e6n8QqAMUtrVDegu1A2EEPw9ptBzQ4a8XchJW2fFhh4ZHm8iZcxurYPPa+9tujybH2keO9CEO/XBnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721394928; c=relaxed/simple;
	bh=nhG0L8hK0aJ8QAOpYvNFh3GgDdbv3HxQ+KwfYy/G1I4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=AK7ex34proj6g1YGgHUQeA7Hmc5OU0sPEuvH6hv897FtMr5i/mWQ3uycw5OAf91r9qKQ4+G7ygiT7/RTgHKVGR25GU9kkqvERtyG2gl09bESww6jSTRlq1LWsGeOIwNA15FizkdtEtCHkOr7GJN3zQ+KXxzjEIDCS46DHwm4R1I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f6218c0d68so282470939f.3
        for <linux-wireless@vger.kernel.org>; Fri, 19 Jul 2024 06:15:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721394926; x=1721999726;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bAsqq5zX52oth84grFD9bc9mvJq+JzKcbZ6rPWocMUM=;
        b=wRKl/0NBAiH4k/ED3oiXsYV7dlLGljLZwc4WFG7kjB6S41nunWELejmr8GkKid8DA9
         hdI0bA6njPz/Uh3d9irphOR2WE8uMi0sGXdBMkUd0rdyS3jILIVMKCB0Q2AzhXOxaMSS
         ED+DUcHsD4MRY9q8d5dplDFe6iAs9xWWa1zIu86CjfUjcZjWpKIr5oJOV4Wq+WRB6RZF
         Hgudn1c6fTKxhL2oiLf1U5uTN6niLgnllMObIDZYQnLOkifoVRtLmBj5DtgvpAFrkYHc
         dhOhv11msUDulJdJkQLgT8G3M5t980X6hG2DTZrfEG/SDVeapjLasOEIEQscn2C0RqL7
         i3Dg==
X-Forwarded-Encrypted: i=1; AJvYcCWfngc872s0P8iwuEIl4PDo6S35kV+qx7VL2t+GG1XFvVaz6rXS30MzEWS6V5pACKP3MM6fCYzLsg7jj7YNtQ8uliwmHCF/gJGVpXuAMKw=
X-Gm-Message-State: AOJu0Yx9I8rC0NYe3twXa/SG0Kg+NJeh6p24mQieSs6LTSYK7oyWirBw
	n/JJgdNS1CTqhy5UZPZoi2lTH2LaBz7XDft9ufp3//4NLPcjtAc05dCi+H41ZmENVlbqcDqX2cf
	XGj9Wn3O5voABGLnoFW8MPUHal7GTiyGNFj2PvpEm6vaPg2RqtIYbqAs=
X-Google-Smtp-Source: AGHT+IHu/+avDE7Yp8vuL7xtw6mv9X9KpZSPGs5C8W18jPlVC6Q4/YNlDAUtej9gRvNMpA5RDTIMh03tqnhqHPodDNYaXMGPgPt9
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6638:2108:b0:4c0:9a05:44d0 with SMTP id
 8926c6da1cb9f-4c2158b9837mr432521173.1.1721394925743; Fri, 19 Jul 2024
 06:15:25 -0700 (PDT)
Date: Fri, 19 Jul 2024 06:15:25 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000114385061d997d9c@google.com>
Subject: [syzbot] [wireless?] INFO: task hung in rfkill_global_led_trigger_worker
 (3)
From: syzbot <syzbot+50499e163bfa302dfe7b@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b1bc554e009e Merge tag 'media/v6.11-1' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=14478ba5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=2899dbd4b1c2b65c
dashboard link: https://syzkaller.appspot.com/bug?extid=50499e163bfa302dfe7b
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c44f53981874/disk-b1bc554e.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/04c685d98327/vmlinux-b1bc554e.xz
kernel image: https://storage.googleapis.com/syzbot-assets/3627aa754881/bzImage-b1bc554e.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+50499e163bfa302dfe7b@syzkaller.appspotmail.com

INFO: task kworker/0:7:5185 blocked for more than 143 seconds.
      Not tainted 6.10.0-syzkaller-05505-gb1bc554e009e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:7     state:D stack:24512 pid:5185  tgid:5185  ppid:2      flags:0x00004000
Workqueue: events rfkill_global_led_trigger_worker
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 rfkill_global_led_trigger_worker+0x1b/0x160 net/rfkill/core.c:182
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
INFO: task syz.0.1037:9686 blocked for more than 143 seconds.
      Not tainted 6.10.0-syzkaller-05505-gb1bc554e009e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.1037      state:D stack:29056 pid:9686  tgid:9664  ppid:8495   flags:0x00004006
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 rfkill_unregister+0xde/0x2c0 net/rfkill/core.c:1149
 nfc_unregister_device+0x94/0x330 net/nfc/core.c:1167
 virtual_ncidev_close+0x51/0xb0 drivers/nfc/virtual_ncidev.c:172
 __fput+0x408/0xbb0 fs/file_table.c:422
 task_work_run+0x14e/0x250 kernel/task_work.c:222
 get_signal+0x1ca/0x2770 kernel/signal.c:2689
 arch_do_signal_or_restart+0x90/0x7e0 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0x150/0x2a0 kernel/entry/common.c:218
 do_syscall_64+0xda/0x250 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe7da775b59
RSP: 002b:00007fe7db4aa048 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: fffffffffffffff2 RBX: 00007fe7da904398 RCX: 00007fe7da775b59
RDX: 0000000000000064 RSI: 0000000020000680 RDI: 0000000000000003
RBP: 00007fe7da7e4e5d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fe7da904398 R15: 00007ffc498102f8
 </TASK>
INFO: task syz.0.1037:9688 blocked for more than 143 seconds.
      Not tainted 6.10.0-syzkaller-05505-gb1bc554e009e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.0.1037      state:D stack:27760 pid:9688  tgid:9664  ppid:8495   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 device_lock include/linux/device.h:1009 [inline]
 nfc_deactivate_target+0x3c/0x350 net/nfc/core.c:449
 nfc_genl_activate_target+0x1e4/0x290 net/nfc/netlink.c:899
 genl_family_rcv_msg_doit+0x202/0x2f0 net/netlink/genetlink.c:1115
 genl_family_rcv_msg net/netlink/genetlink.c:1195 [inline]
 genl_rcv_msg+0x565/0x800 net/netlink/genetlink.c:1210
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x544/0x830 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 ____sys_sendmsg+0xab5/0xc90 net/socket.c:2597
 ___sys_sendmsg+0x135/0x1e0 net/socket.c:2651
 __sys_sendmsg+0x117/0x1f0 net/socket.c:2680
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fe7da775b59
RSP: 002b:00007fe7db489048 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
RAX: ffffffffffffffda RBX: 00007fe7da904470 RCX: 00007fe7da775b59
RDX: 0000000000000000 RSI: 0000000020000780 RDI: 0000000000000005
RBP: 00007fe7da7e4e5d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fe7da904470 R15: 00007ffc498102f8
 </TASK>
INFO: task syz.1.1041:9685 blocked for more than 144 seconds.
      Not tainted 6.10.0-syzkaller-05505-gb1bc554e009e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.1.1041      state:D stack:28160 pid:9685  tgid:9681  ppid:9019   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 genl_lock net/netlink/genetlink.c:35 [inline]
 genl_op_lock net/netlink/genetlink.c:60 [inline]
 genl_op_lock net/netlink/genetlink.c:57 [inline]
 genl_rcv_msg+0x580/0x800 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x544/0x830 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x47f/0x4e0 net/socket.c:2204
 __do_sys_sendto net/socket.c:2216 [inline]
 __se_sys_sendto net/socket.c:2212 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2212
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f3c051778ec
RSP: 002b:00007f3c05f1eea0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f3c05f1efb0 RCX: 00007f3c051778ec
RDX: 0000000000000028 RSI: 00007f3c05f1f000 RDI: 000000000000000a
RBP: 0000000000000000 R08: 00007f3c05f1eef4 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 000000000000000a
R13: 00007f3c05f1ef48 R14: 00007f3c05f1f000 R15: 0000000000000000
 </TASK>
INFO: task syz.4.1047:9706 blocked for more than 144 seconds.
      Not tainted 6.10.0-syzkaller-05505-gb1bc554e009e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.4.1047      state:D stack:28672 pid:9706  tgid:9705  ppid:8498   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 genl_lock net/netlink/genetlink.c:35 [inline]
 genl_op_lock net/netlink/genetlink.c:60 [inline]
 genl_op_lock net/netlink/genetlink.c:57 [inline]
 genl_rcv_msg+0x580/0x800 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x544/0x830 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x47f/0x4e0 net/socket.c:2204
 __do_sys_sendto net/socket.c:2216 [inline]
 __se_sys_sendto net/socket.c:2212 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2212
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f4722d778ec
RSP: 002b:00007f4723bd6ed0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f4723bd6fd0 RCX: 00007f4722d778ec
RDX: 000000000000001c RSI: 00007f4723bd7020 RDI: 0000000000000004
RBP: 0000000000000000 R08: 00007f4723bd6f24 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000004
R13: 00007f4723bd6f78 R14: 00007f4723bd7020 R15: 0000000000000000
 </TASK>
INFO: task syz.3.1051:9717 blocked for more than 144 seconds.
      Not tainted 6.10.0-syzkaller-05505-gb1bc554e009e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.1051      state:D stack:27296 pid:9717  tgid:9716  ppid:8081   flags:0x00004004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 rfkill_register+0x3a/0xb40 net/rfkill/core.c:1075
 nfc_register_device+0x11f/0x3c0 net/nfc/core.c:1132
 nci_register_device+0x7f4/0xb80 net/nfc/nci/core.c:1266
 virtual_ncidev_open+0x147/0x220 drivers/nfc/virtual_ncidev.c:157
 misc_open+0x3da/0x4c0 drivers/char/misc.c:165
 chrdev_open+0x26d/0x6f0 fs/char_dev.c:414
 do_dentry_open+0x91f/0x15f0 fs/open.c:959
 vfs_open+0x82/0x3f0 fs/open.c:1089
 do_open fs/namei.c:3727 [inline]
 path_openat+0x2141/0x2d20 fs/namei.c:3886
 do_filp_open+0x1dc/0x430 fs/namei.c:3913
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f97a3975b59
RSP: 002b:00007f97a4836048 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007f97a3b03f60 RCX: 00007f97a3975b59
RDX: 0000000000000002 RSI: 0000000020000080 RDI: ffffffffffffff9c
RBP: 00007f97a39e4e5d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007f97a3b03f60 R15: 00007fffba983848
 </TASK>
INFO: task syz.3.1051:9721 blocked for more than 145 seconds.
      Not tainted 6.10.0-syzkaller-05505-gb1bc554e009e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.3.1051      state:D stack:28672 pid:9721  tgid:9716  ppid:8081   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 genl_lock net/netlink/genetlink.c:35 [inline]
 genl_op_lock net/netlink/genetlink.c:60 [inline]
 genl_op_lock net/netlink/genetlink.c:57 [inline]
 genl_rcv_msg+0x580/0x800 net/netlink/genetlink.c:1209
 netlink_rcv_skb+0x16b/0x440 net/netlink/af_netlink.c:2550
 genl_rcv+0x28/0x40 net/netlink/genetlink.c:1219
 netlink_unicast_kernel net/netlink/af_netlink.c:1331 [inline]
 netlink_unicast+0x544/0x830 net/netlink/af_netlink.c:1357
 netlink_sendmsg+0x8b8/0xd70 net/netlink/af_netlink.c:1901
 sock_sendmsg_nosec net/socket.c:730 [inline]
 __sock_sendmsg net/socket.c:745 [inline]
 __sys_sendto+0x47f/0x4e0 net/socket.c:2204
 __do_sys_sendto net/socket.c:2216 [inline]
 __se_sys_sendto net/socket.c:2212 [inline]
 __x64_sys_sendto+0xe0/0x1c0 net/socket.c:2212
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f97a39778ec
RSP: 002b:00007f97a4813ed0 EFLAGS: 00000293 ORIG_RAX: 000000000000002c
RAX: ffffffffffffffda RBX: 00007f97a4813fd0 RCX: 00007f97a39778ec
RDX: 000000000000001c RSI: 00007f97a4814020 RDI: 0000000000000005
RBP: 0000000000000000 R08: 00007f97a4813f24 R09: 000000000000000c
R10: 0000000000000000 R11: 0000000000000293 R12: 0000000000000005
R13: 00007f97a4813f78 R14: 00007f97a4814020 R15: 0000000000000000
 </TASK>
INFO: task syz.2.1052:9726 blocked for more than 145 seconds.
      Not tainted 6.10.0-syzkaller-05505-gb1bc554e009e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.1052      state:D stack:28784 pid:9726  tgid:9725  ppid:8496   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 misc_open+0x59/0x4c0 drivers/char/misc.c:129
 chrdev_open+0x26d/0x6f0 fs/char_dev.c:414
 do_dentry_open+0x91f/0x15f0 fs/open.c:959
 vfs_open+0x82/0x3f0 fs/open.c:1089
 do_open fs/namei.c:3727 [inline]
 path_openat+0x2141/0x2d20 fs/namei.c:3886
 do_filp_open+0x1dc/0x430 fs/namei.c:3913
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc716b75b59
RSP: 002b:00007fc71795c048 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fc716d03f60 RCX: 00007fc716b75b59
RDX: 0000000000000000 RSI: 0000000020000040 RDI: ffffffffffffff9c
RBP: 00007fc716be4e5d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000000b R14: 00007fc716d03f60 R15: 00007fffbe046538
 </TASK>
INFO: task syz.2.1052:9727 blocked for more than 145 seconds.
      Not tainted 6.10.0-syzkaller-05505-gb1bc554e009e #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:syz.2.1052      state:D stack:28784 pid:9727  tgid:9725  ppid:8496   flags:0x00000004
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5188 [inline]
 __schedule+0xe37/0x5490 kernel/sched/core.c:6529
 __schedule_loop kernel/sched/core.c:6606 [inline]
 schedule+0xe7/0x350 kernel/sched/core.c:6621
 schedule_preempt_disabled+0x13/0x30 kernel/sched/core.c:6678
 __mutex_lock_common kernel/locking/mutex.c:684 [inline]
 __mutex_lock+0x5b8/0x9c0 kernel/locking/mutex.c:752
 misc_open+0x59/0x4c0 drivers/char/misc.c:129
 chrdev_open+0x26d/0x6f0 fs/char_dev.c:414
 do_dentry_open+0x91f/0x15f0 fs/open.c:959
 vfs_open+0x82/0x3f0 fs/open.c:1089
 do_open fs/namei.c:3727 [inline]
 path_openat+0x2141/0x2d20 fs/namei.c:3886
 do_filp_open+0x1dc/0x430 fs/namei.c:3913
 do_sys_openat2+0x17a/0x1e0 fs/open.c:1416
 do_sys_open fs/open.c:1431 [inline]
 __do_sys_openat fs/open.c:1447 [inline]
 __se_sys_openat fs/open.c:1442 [inline]
 __x64_sys_openat+0x175/0x210 fs/open.c:1442
 do_syscall_x64 arch/x86/entry/common.c:52 [inline]
 do_syscall_64+0xcd/0x250 arch/x86/entry/common.c:83
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fc716b75b59
RSP: 002b:00007fc71793b048 EFLAGS: 00000246 ORIG_RAX: 0000000000000101
RAX: ffffffffffffffda RBX: 00007fc716d04038 RCX: 00007fc716b75b59
RDX: 0000000000000002 RSI: 0000000020000300 RDI: ffffffffffffff9c
RBP: 00007fc716be4e5d R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 000000000000006e R14: 00007fc716d04038 R15: 00007fffbe046538
 </TASK>

Showing all locks held in the system:
1 lock held by khungtaskd/31:
 #0: ffffffff8dbb15e0 (rcu_read_lock){....}-{1:2}, at: rcu_lock_acquire include/linux/rcupdate.h:327 [inline]
 #0: ffffffff8dbb15e0 (rcu_read_lock){....}-{1:2}, at: rcu_read_lock include/linux/rcupdate.h:839 [inline]
 #0: ffffffff8dbb15e0 (rcu_read_lock){....}-{1:2}, at: debug_show_all_locks+0x75/0x340 kernel/locking/lockdep.c:6613
2 locks held by getty/4844:
 #0: ffff88802ea020a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc90002f062f0 (&ldata->atomic_read_lock){+.+.}-{3:3}, at: n_tty_read+0xfc8/0x1490 drivers/tty/n_tty.c:2211
4 locks held by kworker/0:4/5141:
 #0: ffff888015480948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc900034cfd80 ((rfkill_op_work).work){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffffffff8fbe2aa8 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_epo+0x55/0x1d0 net/rfkill/core.c:462
 #3: ffff888022cb7100 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #3: ffff888022cb7100 (&dev->mutex){....}-{3:3}, at: nfc_dev_down+0x2d/0x2e0 net/nfc/core.c:143
3 locks held by kworker/0:7/5185:
 #0: ffff888015480948 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1277/0x1b40 kernel/workqueue.c:3206
 #1: ffffc90003c5fd80 ((work_completion)(&rfkill_global_led_trigger_work)){+.+.}-{0:0}, at: process_one_work+0x921/0x1b40 kernel/workqueue.c:3207
 #2: ffffffff8fbe2aa8 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_global_led_trigger_worker+0x1b/0x160 net/rfkill/core.c:182
2 locks held by syz.0.1037/9686:
 #0: ffff888022cb7100 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #0: ffff888022cb7100 (&dev->mutex){....}-{3:3}, at: nfc_unregister_device+0x60/0x330 net/nfc/core.c:1165
 #1: ffffffff8fbe2aa8 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_unregister+0xde/0x2c0 net/rfkill/core.c:1149
3 locks held by syz.0.1037/9688:
 #0: ffffffff8f7f6ab0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8f7f6b68 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8f7f6b68 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8f7f6b68 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:57 [inline]
 #1: ffffffff8f7f6b68 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x580/0x800 net/netlink/genetlink.c:1209
 #2: ffff888022cb7100 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #2: ffff888022cb7100 (&dev->mutex){....}-{3:3}, at: nfc_deactivate_target+0x3c/0x350 net/nfc/core.c:449
2 locks held by syz.1.1041/9685:
 #0: ffffffff8f7f6ab0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8f7f6b68 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8f7f6b68 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8f7f6b68 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:57 [inline]
 #1: ffffffff8f7f6b68 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x580/0x800 net/netlink/genetlink.c:1209
2 locks held by syz.4.1047/9706:
 #0: ffffffff8f7f6ab0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8f7f6b68 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8f7f6b68 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8f7f6b68 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:57 [inline]
 #1: ffffffff8f7f6b68 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x580/0x800 net/netlink/genetlink.c:1209
3 locks held by syz.3.1051/9717:
 #0: ffffffff8e7dcfa8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x59/0x4c0 drivers/char/misc.c:129
 #1: ffff8880620e9100 (&dev->mutex){....}-{3:3}, at: device_lock include/linux/device.h:1009 [inline]
 #1: ffff8880620e9100 (&dev->mutex){....}-{3:3}, at: nfc_register_device+0x9a/0x3c0 net/nfc/core.c:1128
 #2: ffffffff8fbe2aa8 (rfkill_global_mutex){+.+.}-{3:3}, at: rfkill_register+0x3a/0xb40 net/rfkill/core.c:1075
2 locks held by syz.3.1051/9721:
 #0: ffffffff8f7f6ab0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x40 net/netlink/genetlink.c:1218
 #1: ffffffff8f7f6b68 (genl_mutex){+.+.}-{3:3}, at: genl_lock net/netlink/genetlink.c:35 [inline]
 #1: ffffffff8f7f6b68 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:60 [inline]
 #1: ffffffff8f7f6b68 (genl_mutex){+.+.}-{3:3}, at: genl_op_lock net/netlink/genetlink.c:57 [inline]
 #1: ffffffff8f7f6b68 (genl_mutex){+.+.}-{3:3}, at: genl_rcv_msg+0x580/0x800 net/netlink/genetlink.c:1209
1 lock held by syz.2.1052/9726:
 #0: ffffffff8e7dcfa8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x59/0x4c0 drivers/char/misc.c:129
1 lock held by syz.2.1052/9727:
 #0: ffffffff8e7dcfa8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x59/0x4c0 drivers/char/misc.c:129
1 lock held by syz-executor/9732:
 #0: ffffffff8e7dcfa8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x59/0x4c0 drivers/char/misc.c:129
1 lock held by syz-executor/9734:
 #0: ffffffff8e7dcfa8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x59/0x4c0 drivers/char/misc.c:129
1 lock held by syz-executor/9737:
 #0: ffffffff8e7dcfa8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x59/0x4c0 drivers/char/misc.c:129
1 lock held by syz-executor/9738:
 #0: ffffffff8e7dcfa8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x59/0x4c0 drivers/char/misc.c:129
1 lock held by syz-executor/9740:
 #0: ffffffff8e7dcfa8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x59/0x4c0 drivers/char/misc.c:129
1 lock held by syz-executor/9743:
 #0: ffffffff8e7dcfa8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x59/0x4c0 drivers/char/misc.c:129
1 lock held by syz-executor/9745:
 #0: ffffffff8e7dcfa8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x59/0x4c0 drivers/char/misc.c:129
1 lock held by syz-executor/9748:
 #0: ffffffff8e7dcfa8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x59/0x4c0 drivers/char/misc.c:129
1 lock held by syz-executor/9749:
 #0: ffffffff8e7dcfa8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x59/0x4c0 drivers/char/misc.c:129
1 lock held by syz-executor/9751:
 #0: ffffffff8e7dcfa8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x59/0x4c0 drivers/char/misc.c:129
1 lock held by syz-executor/9753:
 #0: ffffffff8e7dcfa8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x59/0x4c0 drivers/char/misc.c:129
1 lock held by syz-executor/9755:
 #0: ffffffff8e7dcfa8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x59/0x4c0 drivers/char/misc.c:129
1 lock held by syz-executor/9758:
 #0: ffffffff8e7dcfa8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x59/0x4c0 drivers/char/misc.c:129
1 lock held by syz-executor/9759:
 #0: ffffffff8e7dcfa8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x59/0x4c0 drivers/char/misc.c:129
1 lock held by syz-executor/9761:
 #0: ffffffff8e7dcfa8 (misc_mtx){+.+.}-{3:3}, at: misc_open+0x59/0x4c0 drivers/char/misc.c:129

=============================================

NMI backtrace for cpu 1
CPU: 1 PID: 31 Comm: khungtaskd Not tainted 6.10.0-syzkaller-05505-gb1bc554e009e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:88 [inline]
 dump_stack_lvl+0x116/0x1f0 lib/dump_stack.c:114
 nmi_cpu_backtrace+0x27b/0x390 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x29c/0x300 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:162 [inline]
 check_hung_uninterruptible_tasks kernel/hung_task.c:223 [inline]
 watchdog+0xf86/0x1240 kernel/hung_task.c:379
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Sending NMI from CPU 1 to CPUs 0:
NMI backtrace for cpu 0
CPU: 0 PID: 5177 Comm: kworker/0:6 Not tainted 6.10.0-syzkaller-05505-gb1bc554e009e #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: events nsim_dev_trap_report_work
RIP: 0010:__lock_acquire+0x2b0/0x3b30 kernel/locking/lockdep.c:5071
Code: 00 e0 44 09 f8 66 41 89 46 20 48 b8 00 00 00 00 00 fc ff df 80 3c 02 00 0f 85 fd 2a 00 00 48 8b 84 24 30 01 00 00 49 89 46 08 <49> 8d 46 10 48 89 c2 48 89 44 24 58 48 b8 00 00 00 00 00 fc ff df
RSP: 0018:ffffc900035af2f0 EFLAGS: 00000046
RAX: ffffffff81de7ed3 RBX: 0000000000000001 RCX: 0000000000000002
RDX: 1ffff11005304171 RSI: 0000000000000027 RDI: ffff888029820b88
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: 0000000000000014 R11: dffffc0000000000 R12: ffff88813fffa810
R13: 0000000000000000 R14: ffff888029820b80 R15: 0000000000000027
FS:  0000000000000000(0000) GS:ffff8880b9200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000055c79a0986f8 CR3: 000000000d97a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <NMI>
 </NMI>
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5753 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5718
 seqcount_lockdep_reader_access include/linux/seqlock.h:72 [inline]
 read_seqbegin include/linux/seqlock.h:772 [inline]
 zone_span_seqbegin include/linux/memory_hotplug.h:151 [inline]
 page_outside_zone_boundaries mm/page_alloc.c:434 [inline]
 bad_range+0x252/0x440 mm/page_alloc.c:453
 rmqueue mm/page_alloc.c:3030 [inline]
 get_page_from_freelist+0x1333/0x2e50 mm/page_alloc.c:3422
 __alloc_pages_noprof+0x22b/0x2460 mm/page_alloc.c:4683
 __alloc_pages_node_noprof include/linux/gfp.h:269 [inline]
 alloc_pages_node_noprof include/linux/gfp.h:296 [inline]
 alloc_slab_page+0x56/0x110 mm/slub.c:2265
 allocate_slab mm/slub.c:2428 [inline]
 new_slab+0x84/0x260 mm/slub.c:2481
 ___slab_alloc+0xdac/0x1870 mm/slub.c:3667
 __slab_alloc.constprop.0+0x56/0xb0 mm/slub.c:3757
 __slab_alloc_node mm/slub.c:3810 [inline]
 slab_alloc_node mm/slub.c:3990 [inline]
 __do_kmalloc_node mm/slub.c:4122 [inline]
 kmalloc_node_track_caller_noprof+0x355/0x430 mm/slub.c:4143
 kmalloc_reserve+0xef/0x2c0 net/core/skbuff.c:605
 __alloc_skb+0x164/0x380 net/core/skbuff.c:674
 alloc_skb include/linux/skbuff.h:1320 [inline]
 nsim_dev_trap_skb_build drivers/net/netdevsim/dev.c:748 [inline]
 nsim_dev_trap_report drivers/net/netdevsim/dev.c:805 [inline]
 nsim_dev_trap_report_work+0x2a4/0xc80 drivers/net/netdevsim/dev.c:850
 process_one_work+0x9c5/0x1b40 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf20 kernel/workqueue.c:3390
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>


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

