Return-Path: <linux-wireless+bounces-26376-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32B8EB25609
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 23:57:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 569E81BC387C
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 21:57:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4EA2EB5A7;
	Wed, 13 Aug 2025 21:57:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f80.google.com (mail-io1-f80.google.com [209.85.166.80])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348A72D0C6F
	for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 21:57:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.80
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755122252; cv=none; b=K6uSU8DwF0Z83XTbRCDs3UNk3rgs/LgN3TvfORikgYr0pKLf48sJ2nCGssArySz724FkU9bL0gOJGww7SoW+raWcItHkgNonVmH0YO9BXFhYPunjenc8UWPnTwm+SEVAj+j9KqVBVW4/H1Z+e1dMfy7HZizT1of6F0iTqKvQC+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755122252; c=relaxed/simple;
	bh=g8SKf55UHpC1R9HhoeTRN613o7RFLiqJrejbFk7ELlQ=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=mB78zQh58KJLWw+N/dmT8Nm936jni07rs+xhwauuXV1kp654hrgN4UHJYNh0z2uh5WSCwku27YoVduwwITT9IRIlRFLsP2EsHQcRqK0LVcwuqouCUMYY6/GwE9EAMaycTsBh4bWTOSdRMDtxKoBYnuJZcqmtK459/uov3d13hjg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.80
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f80.google.com with SMTP id ca18e2360f4ac-88432ccc211so38610539f.0
        for <linux-wireless@vger.kernel.org>; Wed, 13 Aug 2025 14:57:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755122250; x=1755727050;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=OhNAJmyrCIRYIf0n2hFZpSocShW2AymOERvtSBi8Sfw=;
        b=vQQwB2f9sLkSOs4Xf1LTjb1Gr04Zko2uSrmpwg7YYvFGAGKU1IRZhU/FlW5uIqT8+B
         NQ5BoFlvO0q1Ym1CQ4nrLPWSN2IhA8iEtLit5HuQIIQoyKgojgQLTmdSR5E64QeBZLBA
         JWvlfaCFBrELpYxOW7YwKT01VGz3Dx2UFhcm60mbtt79N1fdBcivOkRiu9VCGMpPbMuJ
         j7o0YTNaHDZlE3lYodzkWfyPzXKPNT924mwDQ85YAXK2JpI9Sxc8vK3f/Kj6qbPXviWm
         D01/PGIRXSKn8ag0DS8XNjkcBi+i5EMlvHaBg+ch4gP5T2EQeqpOHjYCuOWFd+Z9hi5+
         NOBQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWAfBC1ZK7TZBy5E7fmzLi2+09zNdTb+yr+SRHOyvK+oecf0WgANp//xi+HsBG2ULhR513EI51NGILFbCslA==@vger.kernel.org
X-Gm-Message-State: AOJu0YyVo/1Y2WwVUys4kcHbuD2FSCYPbU3DmPsNsdOri7LePjqLslAI
	brkTsiQHyu6eOih+4PyIy5r9HwszaZ8lZetB3+K70Kke3NTOQY9bteALxuar8sGy09EEzZ3Ve7q
	YPMv33G/bKjyfHQSK0XiBGG4FZjuHCZp5FyjGC33X1QWgvI1f5yt+xSg/+hk=
X-Google-Smtp-Source: AGHT+IGQlqjVyflUIdFKlRCnjODApJd2sLp7ynJgYNwUL12oDSSaRuzlGLb/bZG7d8ECjVV6FONTFvLSc9yzghnoA6pwCTIzDPQz
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6602:830a:b0:87c:72f3:d5d7 with SMTP id
 ca18e2360f4ac-88433986e1dmr97246739f.13.1755122250140; Wed, 13 Aug 2025
 14:57:30 -0700 (PDT)
Date: Wed, 13 Aug 2025 14:57:30 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <689d0a4a.050a0220.7f033.0164.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in cfg80211_rehash_bss
From: syzbot <syzbot+dc6f4dce0d707900cdea@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    c30a13538d9f Merge tag 'bpf-fixes' of git://git.kernel.org..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1345d434580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=e143c1cd9dadd720
dashboard link: https://syzkaller.appspot.com/bug?extid=dc6f4dce0d707900cdea
compiler:       Debian clang version 20.1.7 (++20250616065708+6146a88f6049-1~exp1~20250616065826.132), Debian LLD 20.1.7

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-c30a1353.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/8cefa7e1536e/vmlinux-c30a1353.xz
kernel image: https://storage.googleapis.com/syzbot-assets/68b8ee3da77f/bzImage-c30a1353.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+dc6f4dce0d707900cdea@syzkaller.appspotmail.com

wlan1: authenticated
wlan1: associate with 08:02:11:00:00:00 (try 1/3)
------------[ cut here ]------------
WARNING: CPU: 0 PID: 54 at net/wireless/scan.c:1666 rb_insert_bss net/wireless/scan.c:1666 [inline]
WARNING: CPU: 0 PID: 54 at net/wireless/scan.c:1666 cfg80211_rehash_bss+0x1e6/0x540 net/wireless/scan.c:1723
Modules linked in:
CPU: 0 UID: 0 PID: 54 Comm: kworker/u4:4 Not tainted 6.16.0-syzkaller-12250-gc30a13538d9f #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:rb_insert_bss net/wireless/scan.c:1666 [inline]
RIP: 0010:cfg80211_rehash_bss+0x1e6/0x540 net/wireless/scan.c:1723
Code: e8 48 c1 e8 03 42 0f b6 04 30 84 c0 0f 85 33 03 00 00 ff 45 00 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d c3 cc cc cc cc cc 90 <0f> 0b 90 4c 8b 2c 24 4c 89 ef e8 bb cf 02 fa 84 c0 74 78 e8 92 07
RSP: 0018:ffffc9000100ef20 EFLAGS: 00010246
RAX: ffffffff8aceb2b5 RBX: 0000000000000000 RCX: 0000000000000002
RDX: ffff88801f35c880 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffff88803fe97068 R08: 0000000000000000 R09: 0000000000000002
R10: 0000000000000002 R11: 0000000000000002 R12: ffff88803ea081a0
R13: ffff88803fea9c30 R14: dffffc0000000000 R15: ffff88803feaa020
FS:  0000000000000000(0000) GS:ffff88808d211000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f02a5ad3f70 CR3: 0000000043d13000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 cfg80211_update_assoc_bss_entry+0x3f6/0x6a0 net/wireless/scan.c:3470
 cfg80211_ch_switch_notify+0x3c1/0x780 net/wireless/nl80211.c:20398
 ieee80211_sta_process_chanswitch+0xad4/0x2870 net/mac80211/mlme.c:-1
 ieee80211_rx_mgmt_beacon+0x19c7/0x2cd0 net/mac80211/mlme.c:7515
 ieee80211_sta_rx_queued_mgmt+0x4ed/0x4470 net/mac80211/mlme.c:8085
 ieee80211_iface_process_skb net/mac80211/iface.c:1696 [inline]
 ieee80211_iface_work+0x652/0x12d0 net/mac80211/iface.c:1753
 cfg80211_wiphy_work+0x2b8/0x470 net/wireless/core.c:435
 process_one_work kernel/workqueue.c:3236 [inline]
 process_scheduled_works+0xade/0x17b0 kernel/workqueue.c:3319
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3400
 kthread+0x70e/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x3fc/0x770 arch/x86/kernel/process.c:148
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:245
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

