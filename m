Return-Path: <linux-wireless+bounces-37605-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cqnaIB6cKGoZGwMAu9opvQ
	(envelope-from <linux-wireless+bounces-37605-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 01:05:02 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id D34C3664B2C
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 01:05:01 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=none;
	dmarc=fail reason="SPF not aligned (relaxed), No valid DKIM" header.from=appspotmail.com (policy=none);
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37605-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37605-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id CBD6F3051C53
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Jun 2026 23:04:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C363EB0E6;
	Tue,  9 Jun 2026 23:04:36 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f80.google.com (mail-oo1-f80.google.com [209.85.161.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EB253B27EE
	for <linux-wireless@vger.kernel.org>; Tue,  9 Jun 2026 23:04:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781046275; cv=none; b=XimMeul5WTuUJ/m5j0GLnINd9keSo/tbUHXKkOZ0SjrZJUsJnHqY5unuhMjkQ4KKXAB3o0dsFSKrB1nM/Q1tyVk2eU1Zrs0Bknz8mJTwtQAvTuCf++olcZHKOfUO/r78toPzHN5hJcpePPhcaWBeKh9qjBrYNI2HlklxAoQs5JY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781046275; c=relaxed/simple;
	bh=YUqga8davzo7RXFWDkh6tFdj/a3Vd2XQriJ+oRVKN+w=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=f8hdKKbExDGP3P8Ks/wji4Dpn2gxKDiSHlH5MskzuBBNUIMkXsRO9hhcIKxZZUXdkrw0CXQ4UfiolBTPydaPqbii1rrPNKF6mNrS/72JqXxA0cqouK5M7N+MjZf2mEhVCACtQuAp8TfGMDY7b0LV19LsnXCJtgpUkkRl27GHEZI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.161.80
Received: by mail-oo1-f80.google.com with SMTP id 006d021491bc7-69e1eb09b3aso6137832eaf.2
        for <linux-wireless@vger.kernel.org>; Tue, 09 Jun 2026 16:04:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781046273; x=1781651073;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xsUWkrQ8rmjNpBE5wMBkO9QXkVTkJMjHrIkMU52dqvA=;
        b=dbigcZ25rSw8fxtv/hToQPF1Cv/jyf2N1PsXDbwrtW5VX9KnuW77kFcU/zlKzSnwD/
         RlUq9zpFL9IGx2FL/v7idXcJqbKX6ZCSIqSfNNZ5RrRE2vZe0taRxpubvvdqzojbu1uR
         6hiAvhWYGy7ovW9d7zK695DA/Z9yPSdpTSlO/gBIic3onZwKPjgk+dW3155PJmzSh9n9
         pLmonUd3C7NUsa4Pf9v3XRNAPpIhs467pNXUQrD5LZ7srKhmzPOOGqHuVVU5/GEae4V1
         xpZSEjWUFXmaZ/f23fOzBdBlz9OtYnZc2rQqjQNE7svFoCJmPURirvconsZOSrzMj+Cb
         1l6g==
X-Forwarded-Encrypted: i=1; AFNElJ/893o2ya8HrWM9B5YE/4wDVJxHv1xjs74cZPZQqEKA+IwZshVRkLyOjoAW40c+BH9ISlimTd22r20708CesA==@vger.kernel.org
X-Gm-Message-State: AOJu0YzxZ//V1TPOEImpeEDhSqtEkH1/1/4kdF+8m9G8bZUa+LRpl2MY
	YQIbQTxAuZSp6sKQSNqSrbK5TVDzyzjOdog5h/nwpzGJBpo+360uh9YhYtnXRVNwPHBgw1yzHt+
	UTsUsH4hmEsJMRh4rmRrWpte1rjdXYWfkWPIo3eV4DM5xCdlFTmSGyHPWQgw=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:413:b0:67e:251a:bd3e with SMTP id
 006d021491bc7-69e68b5f6f6mr10350886eaf.18.1781046273642; Tue, 09 Jun 2026
 16:04:33 -0700 (PDT)
Date: Tue, 09 Jun 2026 16:04:33 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6a289c01.39669fcc.33b062.00aa.GAE@google.com>
Subject: [syzbot] [btrfs?] WARNING in __alloc_workqueue (2)
From: syzbot <syzbot+f80c62f371ba6a1e7d79@syzkaller.appspotmail.com>
To: clm@fb.com, dsterba@suse.com, linux-btrfs@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-0.36 / 15.00];
	URI_HIDDEN_PATH(1.00)[https://syzkaller.appspot.com/x/.config?x=da47745f686dc823];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	DMARC_POLICY_SOFTFAIL(0.10)[appspotmail.com : SPF not aligned (relaxed), No valid DKIM,none];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-37605-lists,linux-wireless=lfdr.de,f80c62f371ba6a1e7d79];
	RCVD_TLS_LAST(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,appspotmail.com:email,syzkaller.appspotmail.com:from_mime,storage.googleapis.com:url,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,googlegroups.com:email,syzkaller.appspot.com:url];
	FORGED_RECIPIENTS(0.00)[m:clm@fb.com,m:dsterba@suse.com,m:linux-btrfs@vger.kernel.org,m:linux-kernel@vger.kernel.org,m:linux-wireless@vger.kernel.org,m:syzkaller-bugs@googlegroups.com,s:lists@lfdr.de];
	RCVD_COUNT_THREE(0.00)[4];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FORGED_SENDER_MAILLIST(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[6];
	PRECEDENCE_BULK(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[syzbot@syzkaller.appspotmail.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	TO_DN_NONE(0.00)[];
	R_DKIM_NA(0.00)[];
	ALIAS_RESOLVED(0.00)[];
	REDIRECTOR_URL(0.00)[goo.gl];
	TAGGED_RCPT(0.00)[linux-wireless];
	SUBJECT_HAS_QUESTION(0.00)[]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: D34C3664B2C

Hello,

syzbot found the following issue on:

HEAD commit:    a87737435cfa Add linux-next specific files for 20260608
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=178a7f2e580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=da47745f686dc823
dashboard link: https://syzkaller.appspot.com/bug?extid=f80c62f371ba6a1e7d79
compiler:       Debian clang version 21.1.8 (++20251221033036+2078da43e25a-1~exp1~20251221153213.50), Debian LLD 21.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=170260ae580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=124f11b6580000

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/85d19fe6bb4e/disk-a8773743.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/30c683ce26e1/vmlinux-a8773743.xz
kernel image: https://storage.googleapis.com/syzbot-assets/4db5027513d2/bzImage-a8773743.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+f80c62f371ba6a1e7d79@syzkaller.appspotmail.com

usb 1-1: config 0 interface 0 altsetting 0 has an invalid descriptor for endpoint zero, skipping
usb 1-1: New USB device found, idVendor=0cf3, idProduct=9374, bcdDevice=bc.3b
usb 1-1: New USB device strings: Mfr=0, Product=0, SerialNumber=0
usb 1-1: config 0 descriptor??
------------[ cut here ]------------
workqueue: ath6kl_wq is using neither WQ_PERCPU or WQ_UNBOUND. Setting WQ_PERCPU.
WARNING: kernel/workqueue.c:5856 at __alloc_workqueue+0x1d02/0x2070 kernel/workqueue.c:5855, CPU#0: kworker/0:3/5630
Modules linked in:
CPU: 0 UID: 0 PID: 5630 Comm: kworker/0:3 Not tainted syzkaller #0 PREEMPT_{RT,(full)} 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 04/18/2026
Workqueue: usb_hub_wq hub_event
RIP: 0010:__alloc_workqueue+0x1d07/0x2070 kernel/workqueue.c:5855
Code: e9 36 f9 ff ff e8 e9 89 37 00 e9 05 fb ff ff e8 df 89 37 00 e9 92 fb ff ff e8 d5 89 37 00 48 8d 3d 1e b7 43 0e 48 8b 74 24 20 <67> 48 0f b9 3a 81 cd 00 01 00 00 e9 88 e5 ff ff e8 b4 89 37 00 48
RSP: 0018:ffffc90004606bc8 EFLAGS: 00010293
RAX: ffffffff818e312b RBX: 0000000000000000 RCX: ffff8880342dbe00
RDX: 0000000000000000 RSI: ffff8880448f3d68 RDI: ffffffff8fd1e850
RBP: 0000000000000000 R08: ffff8880342dbe00 R09: 0000000000000002
R10: 0000000000000100 R11: 0000000000000102 R12: dffffc0000000000
R13: ffff8880448f3c00 R14: ffffc90004606ce0 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff888125a76000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007fdb09f620f5 CR3: 0000000028f60000 CR4: 00000000003526f0
Call Trace:
 <TASK>
 alloc_workqueue_va kernel/workqueue.c:5950 [inline]
 alloc_workqueue_noprof+0xe3/0x210 kernel/workqueue.c:5966
 ath6kl_usb_create drivers/net/wireless/ath/ath6kl/usb.c:639 [inline]
 ath6kl_usb_probe+0xaa/0x1580 drivers/net/wireless/ath/ath6kl/usb.c:1143
 usb_probe_interface+0x659/0xc70 drivers/usb/core/driver.c:396
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x267/0xaf0 drivers/base/dd.c:706
 __driver_probe_device+0x1e2/0x350 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c8/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:620
 device_add+0x7ec/0xb90 drivers/base/core.c:3772
 usb_set_configuration+0x1a87/0x2110 drivers/usb/core/message.c:2268
 usb_generic_driver_probe+0x8d/0x150 drivers/usb/core/generic.c:250
 usb_probe_device+0x1c4/0x3b0 drivers/usb/core/driver.c:291
 call_driver_probe drivers/base/dd.c:-1 [inline]
 really_probe+0x267/0xaf0 drivers/base/dd.c:706
 __driver_probe_device+0x1e2/0x350 drivers/base/dd.c:868
 driver_probe_device+0x4f/0x240 drivers/base/dd.c:898
 __device_attach_driver+0x270/0x410 drivers/base/dd.c:1026
 bus_for_each_drv+0x25b/0x2f0 drivers/base/bus.c:500
 __device_attach+0x2c8/0x450 drivers/base/dd.c:1098
 device_initial_probe+0xa1/0xd0 drivers/base/dd.c:1153
 bus_probe_device+0x12d/0x220 drivers/base/bus.c:620
 device_add+0x7ec/0xb90 drivers/base/core.c:3772
 usb_new_device+0x9f8/0x16e0 drivers/usb/core/hub.c:2695
 hub_port_connect drivers/usb/core/hub.c:5567 [inline]
 hub_port_connect_change drivers/usb/core/hub.c:5707 [inline]
 port_event drivers/usb/core/hub.c:5871 [inline]
 hub_event+0x2a49/0x4f60 drivers/usb/core/hub.c:5953
 process_one_work+0x98b/0x1630 kernel/workqueue.c:3326
 process_scheduled_works kernel/workqueue.c:3409 [inline]
 worker_thread+0xb49/0x1140 kernel/workqueue.c:3490
 kthread+0x388/0x470 kernel/kthread.c:436
 ret_from_fork+0x514/0xb70 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
----------------
Code disassembly (best guess):
   0:	e9 36 f9 ff ff       	jmp    0xfffff93b
   5:	e8 e9 89 37 00       	call   0x3789f3
   a:	e9 05 fb ff ff       	jmp    0xfffffb14
   f:	e8 df 89 37 00       	call   0x3789f3
  14:	e9 92 fb ff ff       	jmp    0xfffffbab
  19:	e8 d5 89 37 00       	call   0x3789f3
  1e:	48 8d 3d 1e b7 43 0e 	lea    0xe43b71e(%rip),%rdi        # 0xe43b743
  25:	48 8b 74 24 20       	mov    0x20(%rsp),%rsi
* 2a:	67 48 0f b9 3a       	ud1    (%edx),%rdi <-- trapping instruction
  2f:	81 cd 00 01 00 00    	or     $0x100,%ebp
  35:	e9 88 e5 ff ff       	jmp    0xffffe5c2
  3a:	e8 b4 89 37 00       	call   0x3789f3
  3f:	48                   	rex.W


---
This report is generated by a bot. It may contain errors.
See https://goo.gl/tpsmEJ for more information about syzbot.
syzbot engineers can be reached at syzkaller@googlegroups.com.

syzbot will keep track of this issue. See:
https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

If the report is already addressed, let syzbot know by replying with:
#syz fix: exact-commit-title

If you want syzbot to run the reproducer, reply with:
#syz test: git://repo/address.git branch-or-commit-hash
If you attach or paste a git patch, syzbot will apply it before testing.

If you want to overwrite report's subsystems, reply with:
#syz set subsystems: new-subsystem
(See the list of subsystem names on the web dashboard)

If the report is a duplicate of another one, reply with:
#syz dup: exact-subject-of-another-report

If you want to undo deduplication, reply with:
#syz undup

