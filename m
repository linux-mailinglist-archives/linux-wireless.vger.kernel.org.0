Return-Path: <linux-wireless+bounces-24158-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6432DADB757
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 18:49:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81C8D7A2874
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 16:47:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 124EA28851B;
	Mon, 16 Jun 2025 16:48:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40B92286424
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 16:48:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750092512; cv=none; b=IKrqRHdsbctco+3mbBwJcyNxr7romZnK57w4hOB82bx2O6csxmMa+ZCNeyRD65N5PmTdMC2vaPQBTon2btDKQ1gKEczBDXNa3kZqzDiJmHIqzh3ffNmEAlPaA2ZBpR/RZIPa48bQw1gX3sd3iQ7wR4zJCSXPQ3wGouEKYkqZ7Xs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750092512; c=relaxed/simple;
	bh=e5V81vJTsurH16HupVU30ELi7Vbxcb5PLOKsR0X5FmY=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=KG2G0TO3++Hr9fcxyY6uNKB8ZXO3dKbW93o0x3zsqyFUOQHPiKZaajHv2Uaz31Px8nSXkAN7jeFHeWhpe+VLFBzXLx3Yqq19f0td0K6RTPWxQ6XblYREv/MRV8U9uKY0cqEaFyO/uCUSmsFqwUJ77xocwDg9XRutUR20JiAUdNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ddd90ca184so35434935ab.0
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 09:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750092509; x=1750697309;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DGi86GqHzCIrMHCxrqrf3ZFJEnPb6WF6Ee0Udc8mJag=;
        b=NHjJYF0htdDIxRWTY6NXmTy525I8z9Y/gUsT4hHZVBiNNpUzc92bYcVmdPW9F+2SMj
         tEnlfxMGGsg/b6cw4krRbOaVZxdpgx7HXDq2x8eUK4yXr+homVZV6Iu6UudtRXmezYo9
         UsbX3uVL9c4MrPMNdAszm7bcvrlWScgU6ikgufsrGxb8vvSoZs/XsvKVX/6osfh0+/rw
         LOvKIH5zSoCRrDYzID572DZ4EYCiSVrOMQSIinaTIIqZrZoIEfqIqITHkFx+nvlAITUq
         Lcss1ee60fi9eXSfkBPaihstJog24ae0jmKVTrcSIWdajY85RoAXu0uDk2s/E7dAMnHz
         QT/Q==
X-Forwarded-Encrypted: i=1; AJvYcCX47ugazQ49+m8mSoFT5Lj4VGrcMtPdw3bk9aXAaki/aWeVDnp9hEMBeVCUHPasOO7SKOLQJY9U4BjSKHixwA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwXRQRiwuQMlFaK5C08BszrDbZUHWtfoGyIaTRDoN2mFjmriWlo
	2W0IdrVBknGqJkhFZsEDa+CkqvgS3cuIaYa+2Ri7OvM7yoEM0n2Snh3tR+caqMwrVzucs2PO1bj
	rn8Q59MCw8AmEMCuESOzXbW0GWC2CiA8i1eg9znGTj5SQu+CsrTxean/6hB4=
X-Google-Smtp-Source: AGHT+IE5Hf5iXTuGWP6aI8KYGocSFkY8smikigrdkhwypO33dMqeNxfGi5hezPLgrQpJJAxjwEIfSBRDunDqCFjHYfFZZj2e4MpP
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:5e81:b0:3de:1583:dc2d with SMTP id
 e9e14a558f8ab-3de1583df07mr33235175ab.11.1750092509506; Mon, 16 Jun 2025
 09:48:29 -0700 (PDT)
Date: Mon, 16 Jun 2025 09:48:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <68504add.a70a0220.395abc.01e7.GAE@google.com>
Subject: [syzbot] [wireless?] UBSAN: array-index-out-of-bounds in ieee80211_rx_mgmt_beacon
From: syzbot <syzbot+6554b492c7008bcd3385@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    18531f4d1c8c Merge tag 'acpi-6.16-rc2' of git://git.kernel..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=100fc5d4580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=3a936e3316f9e2dc
dashboard link: https://syzkaller.appspot.com/bug?extid=6554b492c7008bcd3385
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=17c8710c580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=10e24e82580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-18531f4d.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/aa1e5854fc49/vmlinux-18531f4d.xz
kernel image: https://storage.googleapis.com/syzbot-assets/ca38347f64b2/bzImage-18531f4d.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+6554b492c7008bcd3385@syzkaller.appspotmail.com

wlan0: Creating new IBSS network, BSSID 50:50:50:50:50:50
wlan1: Created IBSS using preconfigured BSSID 50:50:50:50:50:50
wlan1: Creating new IBSS network, BSSID 50:50:50:50:50:50
------------[ cut here ]------------
UBSAN: array-index-out-of-bounds in net/mac80211/mlme.c:7224:41
index 4 is out of range for type 'u8[0]' (aka 'unsigned char[0]')
CPU: 0 UID: 0 PID: 38 Comm: kworker/u4:3 Not tainted 6.16.0-rc1-syzkaller-00182-g18531f4d1c8c #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound cfg80211_wiphy_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x189/0x250 lib/dump_stack.c:120
 ubsan_epilogue+0xa/0x40 lib/ubsan.c:233
 __ubsan_handle_out_of_bounds+0xe9/0xf0 lib/ubsan.c:455
 ieee80211_rx_mgmt_beacon+0x21fd/0x2c10 net/mac80211/mlme.c:7224
 ieee80211_iface_process_skb net/mac80211/iface.c:1630 [inline]
 ieee80211_iface_work+0x49c/0xfe0 net/mac80211/iface.c:1722
 cfg80211_wiphy_work+0x2df/0x460 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
---[ end trace ]---
Kernel panic - not syncing: UBSAN: panic_on_warn set ...
CPU: 0 UID: 0 PID: 38 Comm: kworker/u4:3 Not tainted 6.16.0-rc1-syzkaller-00182-g18531f4d1c8c #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound cfg80211_wiphy_work
Call Trace:
 <TASK>
 dump_stack_lvl+0x99/0x250 lib/dump_stack.c:120
 panic+0x2db/0x790 kernel/panic.c:382
 check_panic_on_warn+0x89/0xb0 kernel/panic.c:273
 __ubsan_handle_out_of_bounds+0xe9/0xf0 lib/ubsan.c:455
 ieee80211_rx_mgmt_beacon+0x21fd/0x2c10 net/mac80211/mlme.c:7224
 ieee80211_iface_process_skb net/mac80211/iface.c:1630 [inline]
 ieee80211_iface_work+0x49c/0xfe0 net/mac80211/iface.c:1722
 cfg80211_wiphy_work+0x2df/0x460 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3238 [inline]
 process_scheduled_works+0xae1/0x17b0 kernel/workqueue.c:3321
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3402
 kthread+0x70e/0x8a0 kernel/kthread.c:464
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
 </TASK>
Kernel Offset: disabled
Rebooting in 86400 seconds..


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

