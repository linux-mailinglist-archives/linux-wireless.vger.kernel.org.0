Return-Path: <linux-wireless+bounces-32295-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id OB5rIGJ/oWkUtgQAu9opvQ
	(envelope-from <linux-wireless+bounces-32295-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 12:26:26 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id CEE391B6899
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 12:26:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 1ACAD301494A
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 11:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8D1D3EF0B0;
	Fri, 27 Feb 2026 11:22:28 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oi1-f200.google.com (mail-oi1-f200.google.com [209.85.167.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E5233ECBC0
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 11:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772191348; cv=none; b=RI9IFOpAKhDTvzabUHET2qtj6RRtPGlorv3ZHpNCezWI9aji8saNoMBOOvKPXHg4GltbLRR76Po+hYQ0qOqUPbjsa6nE0EWNpSspHRPapGJaPLP+fb/SkJA5zBtu/kjgcUHD17NWF6CaeWPjF/vx+8EzP61dohogy0sYKazT11E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772191348; c=relaxed/simple;
	bh=DlLJLaL/ZKcggPk8WToHyIMnlav4U4KgOA3R6MQ4WNI=;
	h=MIME-Version:Date:In-Reply-To:Message-ID:Subject:From:To:
	 Content-Type; b=TryqRGyewSN0Pt5MHULDsjn2lNYsZkrj9/NrxTCs5L/S0HCSfWV63aoj8iUCjEHogWhp+f4ZLtpvQe1wA7f6JTLjn8GEEIdiqGNmzQT1VYb90w+lp61FeLFLkiumO5FFSh3UjMY+9LsdoqwNpdhb++bh+W4OSwsRfedzHg1h7Vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.167.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oi1-f200.google.com with SMTP id 5614622812f47-45f0bfd68a3so10646987b6e.3
        for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 03:22:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772191346; x=1772796146;
        h=to:from:subject:message-id:in-reply-to:date:mime-version
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wOpbA34JuaoEVyB7jjFGI/wMKC491jZlDU4MLpMCtMM=;
        b=XVUR31UbQRX0H+4XjE1+2pUVW8btpUDelC26W6CSxE4DapUHZ40a8/MUsE6dBMiaxt
         oKuC2WoH3vOPztBrZ/0H1FDt7cH19QuKa215tfFiSP9vLiG0L4ItKFa4mV6dwOarAyWw
         psbKdCrXd3Q/1BTENT5BIXaVKQwcIWh/N1YwSG39gYrxieAHSFO7SK4CqKQR/n3k/bMT
         wtM1dskiV8p4vQaOIlRGjiASqGtT7FO4pYBJbKYZmu+lBaBFqGd8rs6xMU8r9zRFcDvR
         /7U0G8N19eTJApzQEcND25ugWfja2CFdW5d8dtn/JQWA0/ZGhrLQLCoUaLrbgArIPAf4
         B4zA==
X-Forwarded-Encrypted: i=1; AJvYcCXdlvKm/wU34HBq4MrCrjhfCnsluMblCEvlQf9lFC/MzcEqIXBizVFq8sNqShVxdGL0trLGnvaF/j83ehXvcw==@vger.kernel.org
X-Gm-Message-State: AOJu0YyScDYS57vA/JhyDZBseXTS9A89WdkT04QUpmWS+TCSWbmW0GS/
	ot6WGPuQqqoKh1m83uoiGh00XK7fnJOHr4EwK4G0L909f+HCex3XcBekxRVpvkOBsEVF5rdt2EW
	6cTG39x+vLwU32ixP30XpVtjPodGBbauW7yCXTaLvhtcmZZ+6XiXj6KD0PoY=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:2908:b0:679:e6eb:816 with SMTP id
 006d021491bc7-679faf48137mr1528326eaf.60.1772191346216; Fri, 27 Feb 2026
 03:22:26 -0800 (PST)
Date: Fri, 27 Feb 2026 03:22:26 -0800
In-Reply-To: <689daf88.050a0220.2d37a5.0001.GAE@google.com>
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a17e72.050a0220.305b49.00de.GAE@google.com>
Subject: Re: [syzbot] [libertas?] INFO: task hung in lbs_remove_card
From: syzbot <syzbot+c99d17aa44dbdba16ad2@syzkaller.appspotmail.com>
To: libertas-dev@lists.infradead.org, linux-kernel@vger.kernel.org, 
	linux-usb@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f1500201919951cc];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-32295-lists,linux-wireless=lfdr.de,c99d17aa44dbdba16ad2];
	RCVD_COUNT_THREE(0.00)[4];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	SUBJECT_HAS_QUESTION(0.00)[];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,appspotmail.com:email,storage.googleapis.com:url,syzkaller.appspot.com:url]
X-Rspamd-Queue-Id: CEE391B6899
X-Rspamd-Action: no action

syzbot has found a reproducer for the following issue on:

HEAD commit:    bb375c251ab4 dt-bindings: usb: st,st-ohci-300x: convert to..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1141755a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1500201919951cc
dashboard link: https://syzkaller.appspot.com/bug?extid=c99d17aa44dbdba16ad2
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=1191555a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=114a15c6580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2475c3172471/disk-bb375c25.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/30449aa672dd/vmlinux-bb375c25.xz
kernel image: https://storage.googleapis.com/syzbot-assets/46d3937d1c16/bzImage-bb375c25.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c99d17aa44dbdba16ad2@syzkaller.appspotmail.com

INFO: task kworker/0:1:10 blocked for more than 143 seconds.
      Not tainted syzkaller #0
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
task:kworker/0:1     state:D stack:26840 pid:10    tgid:10    ppid:2      task_flags:0x4288060 flags:0x00080000
Workqueue: usb_hub_wq hub_event
Call Trace:
 <TASK>
 context_switch kernel/sched/core.c:5295 [inline]
 __schedule+0xeb1/0x41f0 kernel/sched/core.c:6907
 __schedule_loop kernel/sched/core.c:6989 [inline]
 schedule+0xdd/0x390 kernel/sched/core.c:7004
 lbs_wait_for_firmware_load+0x11e/0x1e0 drivers/net/wireless/marvell/libertas/firmware.c:116
 lbs_remove_card+0x84/0x390 drivers/net/wireless/marvell/libertas/main.c:913
 if_usb_disconnect+0xaf/0x2e0 drivers/net/wireless/marvell/libertas/if_usb.c:316
 usb_unbind_interface+0x1dd/0x9e0 drivers/usb/core/driver.c:458
 device_remove drivers/base/dd.c:573 [inline]
 device_remove+0x12a/0x180 drivers/base/dd.c:565
 __device_release_driver drivers/base/dd.c:1284 [inline]
 device_release_driver_internal+0x42e/0x600 drivers/base/dd.c:1307
 bus_remove_device+0x22f/0x440 drivers/base/bus.c:616
 device_del+0x376/0x9b0 drivers/base/core.c:3878
 usb_disable_device+0x367/0x810 drivers/usb/core/message.c:1418
 usb_disconnect+0x2e2/0x9a0 drivers/usb/core/hub.c:2345
 hub_port_connect drivers/usb/core/hub.c:5407 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x1d0c/0x4af0 drivers/usb/core/hub.c:5953
 process_one_work+0x9d7/0x1920 kernel/workqueue.c:3275
 process_scheduled_works kernel/workqueue.c:3358 [inline]
 worker_thread+0x5da/0xe40 kernel/workqueue.c:3439
 kthread+0x370/0x450 kernel/kthread.c:467
 ret_from_fork+0x6c3/0xcb0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>

Showing all locks held in the system:
5 locks held by kworker/0:1/10:
 #0: ffff8881056afd48 ((wq_completion)usb_hub_wq){+.+.}-{0:0}, at: process_one_work+0x1287/0x1920 kernel/workqueue.c:3250
 #1: ffffc900000afd18 ((work_completion)(&hub->events)){+.+.}-{0:0}, at: process_one_work+0x93c/0x1920 kernel/workqueue.c:3251
 #2: ffff88810b795198 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:895 [inline]
 #2: ffff88810b795198 (&dev->mutex){....}-{4:4}, at: hub_event+0x1bd/0x4af0 drivers/usb/core/hub.c:5899
 #3: ffff88811c2c3198 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:895 [inline]
 #3: ffff88811c2c3198 (&dev->mutex){....}-{4:4}, at: usb_disconnect+0x10a/0x9a0 drivers/usb/core/hub.c:2336
 #4: ffff88811bcbf160 (&dev->mutex){....}-{4:4}, at: device_lock include/linux/device.h:895 [inline]
 #4: ffff88811bcbf160 (&dev->mutex){....}-{4:4}, at: __device_driver_lock drivers/base/dd.c:1106 [inline]
 #4: ffff88811bcbf160 (&dev->mutex){....}-{4:4}, at: device_release_driver_internal+0xaa/0x600 drivers/base/dd.c:1304
2 locks held by kworker/1:0/23:
 #0: ffff88810006b548 ((wq_completion)events){+.+.}-{0:0}, at: process_one_work+0x1287/0x1920 kernel/workqueue.c:3250
 #1: ffffc9000018fd18 ((work_completion)(&fw_work->work)){+.+.}-{0:0}, at: process_one_work+0x93c/0x1920 kernel/workqueue.c:3251
1 lock held by khungtaskd/30:
 #0: ffffffff896e05a0 (rcu_read_lock){....}-{1:3}, at: rcu_lock_acquire include/linux/rcupdate.h:312 [inline]
 #0: ffffffff896e05a0 (rcu_read_lock){....}-{1:3}, at: rcu_read_lock include/linux/rcupdate.h:850 [inline]
 #0: ffffffff896e05a0 (rcu_read_lock){....}-{1:3}, at: debug_show_all_locks+0x3d/0x184 kernel/locking/lockdep.c:6775
2 locks held by getty/2917:
 #0: ffff888115dd90a0 (&tty->ldisc_sem){++++}-{0:0}, at: tty_ldisc_ref_wait+0x24/0x80 drivers/tty/tty_ldisc.c:243
 #1: ffffc900000432f0 (&ldata->atomic_read_lock){+.+.}-{4:4}, at: n_tty_read+0x419/0x1500 drivers/tty/n_tty.c:2211

=============================================

NMI backtrace for cpu 0
CPU: 0 UID: 0 PID: 30 Comm: khungtaskd Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Call Trace:
 <TASK>
 __dump_stack lib/dump_stack.c:94 [inline]
 dump_stack_lvl+0x100/0x190 lib/dump_stack.c:120
 nmi_cpu_backtrace.cold+0x12d/0x151 lib/nmi_backtrace.c:113
 nmi_trigger_cpumask_backtrace+0x1d7/0x230 lib/nmi_backtrace.c:62
 trigger_all_cpu_backtrace include/linux/nmi.h:161 [inline]
 __sys_info lib/sys_info.c:157 [inline]
 sys_info+0x141/0x190 lib/sys_info.c:165
 check_hung_uninterruptible_tasks kernel/hung_task.c:346 [inline]
 watchdog+0xd25/0x1050 kernel/hung_task.c:515
 kthread+0x370/0x450 kernel/kthread.c:467
 ret_from_fork+0x6c3/0xcb0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Sending NMI from CPU 0 to CPUs 1:
NMI backtrace for cpu 1
CPU: 1 UID: 0 PID: 0 Comm: swapper/1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
RIP: 0010:pv_native_safe_halt+0xf/0x20 arch/x86/kernel/paravirt.c:63
Code: ae b1 01 e9 13 e8 02 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 66 90 0f 00 2d d3 e1 1d 00 fb f4 <c3> cc cc cc cc 66 2e 0f 1f 84 00 00 00 00 00 66 90 90 90 90 90 90
RSP: 0018:ffffc9000013fe00 EFLAGS: 00000242
RAX: 000000000007f00b RBX: ffff8881022a1d00 RCX: ffffffff876898d5
RDX: 0000000000000000 RSI: ffffffff8901db96 RDI: ffffffff87afa420
RBP: 0000000000000001 R08: 0000000000000001 R09: ffffed103eae6725
R10: ffff8881f573392b R11: 0000000000000000 R12: ffffed10204543a0
R13: 0000000000000001 R14: ffffffff8aefe2d0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff8882687d3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f983bef5900 CR3: 0000000116d22000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 arch_safe_halt arch/x86/include/asm/paravirt.h:73 [inline]
 default_idle+0x9/0x10 arch/x86/kernel/process.c:767
 default_idle_call+0x6c/0xb0 kernel/sched/idle.c:122
 cpuidle_idle_call kernel/sched/idle.c:191 [inline]
 do_idle+0x35b/0x4b0 kernel/sched/idle.c:332
 cpu_startup_entry+0x4f/0x60 kernel/sched/idle.c:430
 start_secondary+0x21d/0x2d0 arch/x86/kernel/smpboot.c:312
 common_startup_64+0x13e/0x148
 </TASK>


---
If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

