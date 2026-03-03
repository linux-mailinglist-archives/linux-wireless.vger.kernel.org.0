Return-Path: <linux-wireless+bounces-32427-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id oB6BM1Nlp2mghAAAu9opvQ
	(envelope-from <linux-wireless+bounces-32427-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 23:48:51 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 906021F8287
	for <lists+linux-wireless@lfdr.de>; Tue, 03 Mar 2026 23:48:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 2F4BB300C83B
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Mar 2026 22:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C98E439022D;
	Tue,  3 Mar 2026 22:48:29 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com [209.85.161.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E16A39022B
	for <linux-wireless@vger.kernel.org>; Tue,  3 Mar 2026 22:48:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772578109; cv=none; b=V3mID+2pCMZlM+F03Ci0U3d1dC99xjkuQJFKsFdD8SFWGusGgNeUevNEMy5bS/sxtwsvDRKJROU34iK5X64zR68S97OI8b3WyaVLsZxA2M9wsQwnID1Hn84tpLVfbGTnTSdQj4kFh5+RzyEqeby2loC8kIBESC3ySqSm94x80/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772578109; c=relaxed/simple;
	bh=SLzG06fmnXklYyYJYWanS18GEPD4baSzZphAPsqBB6c=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=JIB5+ylL1WvD6QVX/PXsVI21g38f6Dc0Vo3+2Mat0PzQQbQpvWZzpjfISvfzpMablROwtJ2WI7mXGi6byqDPabCeIMleyWc1l09UOBKu9VaqltMdZ8/tzOAxjsnuGSYnjWtTVf2yh1JC18YjdGNK8miAhXduhSC7wTWshdqBjPI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-66b47c7a795so66895745eaf.2
        for <linux-wireless@vger.kernel.org>; Tue, 03 Mar 2026 14:48:28 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772578107; x=1773182907;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zyfmorJRasI8+9qvadPfl1VjzCk+3pZrlG6H9/L3uPY=;
        b=CZjeiJoXsliJcuuGSTD0b/9jzgOSodkIeTdbsXCicuD2meaCchrDLLMdi3DID8wgP0
         lynNW26WwLZtVUtRPP27FWiaxJBfxfvdMCFJYFnzShH+iZvKUMg+pEktUoNQlD45nXz1
         JK0gl19pr6g1xkO6V2T7Q/GTY5DDSa1ql0vMBhet/c+4O1Blb1Hd7YWMOh1cr9WSMsOW
         /YTIdJa+WywsZGXPEhxGxPJxIpVGos4VVKgDJr+/JmaEYoDYNPneGS1+HkukWXy+zZbn
         QTWk7OOXzBcifU8NM6VEVkKmoqVtUv5j0xlgIMe4NjCGcczVfe2Ynrh2yoXllj+aruXg
         G2ag==
X-Forwarded-Encrypted: i=1; AJvYcCV/Wlor4qs0p6oWteqGKQaITeGFM8vQ8usFjXJYqFhOk637LTevCZmePCjNGkHgGCMSfC6aSNLCTHQSTKwUfw==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCO4TbkPX0KnQW5aNd+55zpuZGVGZiXw7zsJfXcXHQp6bc9c/Q
	57dY5Ua3XTEMxblT0E3JqZRPdLLB13hbmSVTjN7fP9f/gVOvrKWKTWX74Bfs+6G/Lh5Ek13pv0J
	XPv/PfMGPqKEC8VFlfEm5WwbhQRtPY41wNGfsAD7tiEF01ayh99yCRANbqmc=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a4a:ec4c:0:b0:679:e765:dafc with SMTP id
 006d021491bc7-67b177035f1mr104406eaf.19.1772578107324; Tue, 03 Mar 2026
 14:48:27 -0800 (PST)
Date: Tue, 03 Mar 2026 14:48:27 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <69a7653b.050a0220.21ae90.000f.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING: refcount bug in rsi_91x_deinit
From: syzbot <syzbot+ba76f6da746fd674d311@syzkaller.appspotmail.com>
To: linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Queue-Id: 906021F8287
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.36 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=f1500201919951cc];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MISSING_XM_UA(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32427-lists,linux-wireless=lfdr.de,ba76f6da746fd674d311];
	RCVD_TLS_LAST(0.00)[];
	RCVD_COUNT_THREE(0.00)[4];
	FORGED_SENDER_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	SUBJECT_HAS_QUESTION(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	RCPT_COUNT_FIVE(0.00)[5];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[goo.gl:url,googlegroups.com:email,appspotmail.com:email,storage.googleapis.com:url,syzkaller.appspot.com:url,tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo]
X-Rspamd-Action: no action

Hello,

syzbot found the following issue on:

HEAD commit:    bb375c251ab4 dt-bindings: usb: st,st-ohci-300x: convert to..
git tree:       https://git.kernel.org/pub/scm/linux/kernel/git/gregkh/usb.git usb-testing
console output: https://syzkaller.appspot.com/x/log.txt?x=1416c5aa580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=f1500201919951cc
dashboard link: https://syzkaller.appspot.com/bug?extid=ba76f6da746fd674d311
compiler:       gcc (Debian 14.2.0-19) 14.2.0, GNU ld (GNU Binutils for Debian) 2.44

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/2475c3172471/disk-bb375c25.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/30449aa672dd/vmlinux-bb375c25.xz
kernel image: https://storage.googleapis.com/syzbot-assets/46d3937d1c16/bzImage-bb375c25.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+ba76f6da746fd674d311@syzkaller.appspotmail.com

------------[ cut here ]------------
refcount_t: addition on 0; use-after-free.
WARNING: lib/refcount.c:25 at refcount_warn_saturate+0x111/0x130 lib/refcount.c:25, CPU#0: kworker/0:1/10
Modules linked in:
CPU: 0 UID: 0 PID: 10 Comm: kworker/0:1 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 02/12/2026
Workqueue: usb_hub_wq hub_event
RIP: 0010:refcount_warn_saturate+0x111/0x130 lib/refcount.c:25
Code: cc e8 43 d8 e5 fe 48 8d 3d 4c 6c 28 08 67 48 0f b9 3a e8 32 d8 e5 fe 5b 5d e9 cb 88 9f 04 e8 26 d8 e5 fe 48 8d 3d 3f 6c 28 08 <67> 48 0f b9 3a e8 15 d8 e5 fe 5b 5d c3 cc cc cc cc 48 89 df e8 46
RSP: 0018:ffffc900000aef30 EFLAGS: 00010246
RAX: 0000000000100000 RBX: ffff88811d6f9d28 RCX: ffffc90015361000
RDX: 0000000000100000 RSI: ffffffff82cbe1da RDI: ffffffff8af44e20
RBP: 0000000000000002 R08: 0000000000000005 R09: 0000000000000004
R10: 0000000000000002 R11: ffff8881f5639708 R12: ffff88811bdf0000
R13: ffff88811d6f9d28 R14: 0000000000000000 R15: 0000000000000002
FS:  0000000000000000(0000) GS:ffff8882686d3000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f04409cb6b0 CR3: 0000000121146000 CR4: 00000000003506f0
Call Trace:
 <TASK>
 __refcount_add include/linux/refcount.h:289 [inline]
 __refcount_inc include/linux/refcount.h:366 [inline]
 refcount_inc include/linux/refcount.h:383 [inline]
 get_task_struct include/linux/sched/task.h:116 [inline]
 kthread_stop+0x602/0x680 kernel/kthread.c:785
 rsi_kill_thread drivers/net/wireless/rsi/rsi_common.h:78 [inline]
 rsi_91x_deinit+0x102/0x1f0 drivers/net/wireless/rsi/rsi_91x_main.c:405
 rsi_probe+0xd27/0x1aa0 drivers/net/wireless/rsi/rsi_91x_usb.c:861
 usb_probe_interface+0x303/0x8f0 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:583 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:661
 __driver_probe_device+0x1de/0x400 drivers/base/dd.c:803
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:833
 __device_attach_driver+0x1ff/0x3e0 drivers/base/dd.c:961
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1033
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1088
 bus_probe_device+0x64/0x160 drivers/base/bus.c:574
 device_add+0x11d9/0x1950 drivers/base/core.c:3689
 usb_set_configuration+0xd97/0x1c60 drivers/usb/core/message.c:2208
 usb_generic_driver_probe+0xa1/0xe0 drivers/usb/core/generic.c:250
 usb_probe_device+0xef/0x400 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:583 [inline]
 really_probe+0x241/0xa60 drivers/base/dd.c:661
 __driver_probe_device+0x1de/0x400 drivers/base/dd.c:803
 driver_probe_device+0x4c/0x1b0 drivers/base/dd.c:833
 __device_attach_driver+0x1ff/0x3e0 drivers/base/dd.c:961
 bus_for_each_drv+0x159/0x1e0 drivers/base/bus.c:500
 __device_attach+0x1e4/0x4d0 drivers/base/dd.c:1033
 device_initial_probe+0xaf/0xd0 drivers/base/dd.c:1088
 bus_probe_device+0x64/0x160 drivers/base/bus.c:574
 device_add+0x11d9/0x1950 drivers/base/core.c:3689
 usb_new_device.cold+0x685/0x115c drivers/usb/core/hub.c:2695
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x314d/0x4af0 drivers/usb/core/hub.c:5953
 process_one_work+0x9d7/0x1920 kernel/workqueue.c:3275
 process_scheduled_works kernel/workqueue.c:3358 [inline]
 worker_thread+0x5da/0xe40 kernel/workqueue.c:3439
 kthread+0x370/0x450 kernel/kthread.c:467
 ret_from_fork+0x6c3/0xcb0 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	cc                   	int3
   1:	e8 43 d8 e5 fe       	call   0xfee5d849
   6:	48 8d 3d 4c 6c 28 08 	lea    0x8286c4c(%rip),%rdi        # 0x8286c59
   d:	67 48 0f b9 3a       	ud1    (%edx),%rdi
  12:	e8 32 d8 e5 fe       	call   0xfee5d849
  17:	5b                   	pop    %rbx
  18:	5d                   	pop    %rbp
  19:	e9 cb 88 9f 04       	jmp    0x49f88e9
  1e:	e8 26 d8 e5 fe       	call   0xfee5d849
  23:	48 8d 3d 3f 6c 28 08 	lea    0x8286c3f(%rip),%rdi        # 0x8286c69
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	e8 15 d8 e5 fe       	call   0xfee5d849
  34:	5b                   	pop    %rbx
  35:	5d                   	pop    %rbp
  36:	c3                   	ret
  37:	cc                   	int3
  38:	cc                   	int3
  39:	cc                   	int3
  3a:	cc                   	int3
  3b:	48 89 df             	mov    %rbx,%rdi
  3e:	e8                   	.byte 0xe8
  3f:	46                   	rex.RX


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

