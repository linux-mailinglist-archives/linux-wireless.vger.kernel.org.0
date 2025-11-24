Return-Path: <linux-wireless+bounces-29269-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A174C7ECE5
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 03:14:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8E51B343A2C
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 02:14:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 34C0A274FFD;
	Mon, 24 Nov 2025 02:14:37 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76905274B2B
	for <linux-wireless@vger.kernel.org>; Mon, 24 Nov 2025 02:14:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763950477; cv=none; b=BuPbA41bM/c5ZFbovCBXR1q0ajTXLiPzDMy4ntt8O3mq8rlARFQW4vyDZQMg4P8Ufz/UtJaa+OoFU/CBnY9AR0Ou+Wvnmsl+a4ez2y8SuhCf3cBNTiJXdW7haq+kEoetDLmqEsZsBGKzFPHLW3jGFyykEbOx6lOe4qv2srT9bQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763950477; c=relaxed/simple;
	bh=SQJppYga/QDWWMbMQov2Py1BjOB+UQCF5MXkF4ESzZk=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=adSlrzcTNOKL59pOt8rn2gyTDPobak7c8s+P9LvFpHWGRt+NP/ahl/LpMHll6mfRBNE7/5MFtsU5LCtKrZjDs7DYMnsKRaY0stlMa+bG5LdAgktFMlbqjW7ZdgoaIVyidoqffg2nTfUAs+8jGDVWzcAyEMmz8gDBl4Ntyd9lcJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-43470d72247so39970975ab.3
        for <linux-wireless@vger.kernel.org>; Sun, 23 Nov 2025 18:14:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763950474; x=1764555274;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lwbYDO1W7tpbfeon2Bg26pMTQhJlnIRU/gIWio2icr4=;
        b=rnLXaQeJJnaItMS9buvnyxtfr2d4F6tNSEH6uXQHakPD0dcd12PgS1EcI88EtYigJJ
         i0UGjijnwIpALxtsiiMk1nmDYZk4iXbpdUSm4CzSegTRqFyH+JMas+9KV89xThlBLyXM
         +uhhfr3xLEp8Y0HiUwXvyZ3npyQZIZk3BNEpOp8F7BwrrudRs5RyZJPW2yXuCjdPDtdH
         BL2fA5p1BrNS1nEE9UrMQCl+TLU66Gs8wsvDPhIGn6lRvpSCfsbv/E+xpd8QSEv5cogO
         jqU2Vofwbl6zHbXiV+kN+hIrJHqI8YRNnzYWXxtAriuDxBJ+LQWhHsGm3xZ66hfjtAzF
         Vv+g==
X-Forwarded-Encrypted: i=1; AJvYcCXlFWtrkEZ78R58tfilglh2jApSue74LYe2y9pCgoQKCCMZ9uL7ziA8cVRrutUL1R+tAPmqIY2nF0/l6hQOGw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxE2voymdDgQYzOMF2ozWdCG3LxdSUamHNMFqE58sFxqwqQdYVl
	9fIasw0Q/LrHbQ30PyT/bpA473KpTUYRq3NCrzyiOKUy80oSxw2tHVF6zFTOekItJyrrr2KN36H
	HgBdsbl7o4yjKQ/Z7pafcMMqDHn+aHFcbUmE7O8JXygATx3K01NXqHBe49Bk=
X-Google-Smtp-Source: AGHT+IFzn3F9oQe8kIm1DeVSy18UA901kRBkit3KpghLFHxVKsmOc1LpuGCPoO2SB3iUKR2+42KYO96YAX0AnXxBrZokbArLVrTC
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a92:ca0f:0:b0:434:6f6a:fba4 with SMTP id
 e9e14a558f8ab-435b8c18b77mr89672315ab.5.1763950474682; Sun, 23 Nov 2025
 18:14:34 -0800 (PST)
Date: Sun, 23 Nov 2025 18:14:34 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6923bf8a.a70a0220.2ea503.0076.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_ocb_rx_no_sta (2)
From: syzbot <syzbot+b364457b2d1d4e4a3054@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    23cb64fb7625 Merge tag 'soc-fixes-6.18-3' of git://git.ker..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=179e0514580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=a1db0fea040c2a9f
dashboard link: https://syzkaller.appspot.com/bug?extid=b364457b2d1d4e4a3054
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=11de1742580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12ad1e0a580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-23cb64fb.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f456267fe311/vmlinux-23cb64fb.xz
kernel image: https://storage.googleapis.com/syzbot-assets/cbc9bf9bce21/bzImage-23cb64fb.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b364457b2d1d4e4a3054@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 0 PID: 15 at net/mac80211/ocb.c:63 ieee80211_ocb_rx_no_sta+0x511/0x5d0 net/mac80211/ocb.c:63
Modules linked in:
CPU: 0 UID: 0 PID: 15 Comm: ksoftirqd/0 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
RIP: 0010:ieee80211_ocb_rx_no_sta+0x511/0x5d0 net/mac80211/ocb.c:63
Code: 48 0a 00 00 48 c7 c7 40 88 8a 8c 48 89 de 4c 89 fa 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d e9 85 25 4c f6 e8 00 a7 e4 f6 90 <0f> 0b 90 48 83 c4 18 5b 41 5c 41 5d 41 5e 41 5f 5d e9 b9 00 00 00
RSP: 0018:ffffc9000041f470 EFLAGS: 00010246
RAX: ffffffff8adb6c60 RBX: ffff8880596e0d80 RCX: ffff88801ab1c900
RDX: 0000000000000100 RSI: 0000000000000001 RDI: 0000000000000000
RBP: 0000000000000001 R08: 0000000000000000 R09: ffffffff8adb6809
R10: 000000000000000c R11: 0000000000000100 R12: ffffffff8adb6809
R13: 0000000000000000 R14: dffffc0000000000 R15: ffff88804464b40a
FS:  0000000000000000(0000) GS:ffff88808d730000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000561f9cf3b950 CR3: 000000004130f000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 ieee80211_accept_frame net/mac80211/rx.c:4432 [inline]
 ieee80211_prepare_and_rx_handle+0x2555/0x6770 net/mac80211/rx.c:4994
 __ieee80211_rx_handle_packet net/mac80211/rx.c:5304 [inline]
 ieee80211_rx_list+0x2294/0x2c10 net/mac80211/rx.c:5451
 ieee80211_rx_napi+0x1a8/0x3d0 net/mac80211/rx.c:5474
 ieee80211_rx include/net/mac80211.h:5214 [inline]
 ieee80211_handle_queued_frames+0xe8/0x1f0 net/mac80211/main.c:453
 tasklet_action_common+0x36c/0x580 kernel/softirq.c:925
 handle_softirqs+0x286/0x870 kernel/softirq.c:622
 run_ksoftirqd+0x9b/0x100 kernel/softirq.c:1063
 smpboot_thread_fn+0x542/0xa60 kernel/smpboot.c:160
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x4bc/0x870 arch/x86/kernel/process.c:158
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

