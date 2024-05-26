Return-Path: <linux-wireless+bounces-8068-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F3D1E8CF608
	for <lists+linux-wireless@lfdr.de>; Sun, 26 May 2024 22:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 285691C20972
	for <lists+linux-wireless@lfdr.de>; Sun, 26 May 2024 20:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B0A139D0A;
	Sun, 26 May 2024 20:55:31 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73941139CF7
	for <linux-wireless@vger.kernel.org>; Sun, 26 May 2024 20:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716756931; cv=none; b=gXUVVVTs8EdMEkJ2uGed20VGft+QCc1jQtrzQQ3CNKJFRgqAPv0fSjMszgs3o5Gh3CmLUV+Y5D775g+wLNwDgDoWHj2B3UjTD6zwXuOK8U1YKIxtsRoUSyJMBxA3AeO85bLDCzM2IfBp4A9k9ZZ8bQpr7ioE/quZZC2kXmHiWLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716756931; c=relaxed/simple;
	bh=UImQxAPOx24VQj0f4Xlu8jEy6VeoT2nd6Lxbc1zqsKA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=g57DHLgUClbFqd5ETVLazSDBn3tfeteezuz2XDkJzhG5WuypM4DvCiZCiBbp/R+zYtKLZFFMEYp+7Yd3s+GGYi/6V8MQ+hib5wYnpCFpfMcyfKabKaNVmAAm6eS9K0Yf6xcxedPEBkVygJ06Rwes0JqCTnEmcmw31flRVPmioEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3737b3ee909so27637605ab.2
        for <linux-wireless@vger.kernel.org>; Sun, 26 May 2024 13:55:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716756928; x=1717361728;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T8Ff/1i31+BE7EFvYOmkzv6BYjG0wA2YgwTzF6+Ho68=;
        b=B9+0omWimLYROmwj0dTD4xVQ+3jIcB5zhK3Ix3zOc5FnHP7GrhlqJf3xmYkFDGqPXj
         XI7utcgqyRTiCpAd0QPyR7PhB4yGboBhVqqvfR8copdz4q61aj1rI3c84NuqfCEL9/It
         Pr82x8ZIGzi3gKmCCnThQAmIjGnEtvzF7PK6Oa1ZX7wqaEutBibB6MQqwdmuBrUv2deJ
         AvaLRTb9q0aC88eUKJTm5ZrVuR0+blCtoQJpM33FkxCgEuPGP8CsVODCXLkAoKjnfVhw
         Or/6ZXNTiJsnxMmsTR6xBb+e7ozBKazmR/BrkrKuTYGhrKuMoEO5TTe6SQ03Od1ePmiR
         zobQ==
X-Forwarded-Encrypted: i=1; AJvYcCWeETej5dPie78dIsI93zTFs1A6zJBsdWelHt/cXQI/S/ldvlM3D/GH8Y+25Qe4h9aGIGg88Jvs0C8Q2j65HM7ieaV10R+kUGhtKt23rDo=
X-Gm-Message-State: AOJu0YymQFgnhejU+F3Lks/BS2gf2dt0iAgwCrWIdRxJdhIl1BRiZ+Yw
	QJT8Pf+LoS0BU+BixMUYy0114ZPnYVcCuDi9DDME2jickEp1lXexYXEeij5IGJHDZoB9SZhV/2m
	+1lyz2U+wpE/4SCpSSDmr02fY8OjAtu543D8dUh7qT86HdfoTFcvTsEg=
X-Google-Smtp-Source: AGHT+IHKtIYDeim0+FderWP+Oqk6I75pKU2LVNzMNywyRdzmWMGswo8cRl9x+ksnl0xQupaLUAzmDNKQenn7vTK7+xQVqHqKHx/q
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1c09:b0:374:5382:72be with SMTP id
 e9e14a558f8ab-37453827482mr1696825ab.3.1716756928762; Sun, 26 May 2024
 13:55:28 -0700 (PDT)
Date: Sun, 26 May 2024 13:55:28 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000e7a9080619619e8a@google.com>
Subject: [syzbot] [wireless?] general protection fault in ieee80211_unregister_hw
From: syzbot <syzbot+b48ecffcca0f460a4cf4@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    2a8120d7b482 Merge tag 's390-6.10-2' of git://git.kernel.o..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=1574fadc980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=5dd4fde1337a9e18
dashboard link: https://syzkaller.appspot.com/bug?extid=b48ecffcca0f460a4cf4
compiler:       gcc (Debian 12.2.0-14) 12.2.0, GNU ld (GNU Binutils for Debian) 2.40
userspace arch: i386

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/7bc7510fe41f/non_bootable_disk-2a8120d7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/78c72ae6bdaf/vmlinux-2a8120d7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/99dbb805b738/bzImage-2a8120d7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b48ecffcca0f460a4cf4@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xe01ffbf11002a963: 0000 [#1] PREEMPT SMP KASAN NOPTI
KASAN: maybe wild-memory-access in range [0x00ffff8880154b18-0x00ffff8880154b1f]
CPU: 2 PID: 1185 Comm: kworker/u32:10 Not tainted 6.9.0-syzkaller-10713-g2a8120d7b482 #0
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.2-debian-1.16.2-1 04/01/2014
Workqueue: netns cleanup_net
RIP: 0010:__lock_acquire+0xe3e/0x3b30 kernel/locking/lockdep.c:5005
Code: 11 00 00 39 05 b3 cf 1f 12 0f 82 be 05 00 00 ba 01 00 00 00 e9 e4 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 82 1f 00 00 49 81 3c 24 a0 3d e3 92 0f 84 98 f2
RSP: 0018:ffffc90006ecf7a0 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 001ffff11002a963 RSI: ffff888020952440 RDI: 00ffff8880154b18
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8fe29817 R11: 0000000000000004 R12: 00ffff8880154b18
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88802c200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f711b1cd440 CR3: 000000002686c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 lock_acquire kernel/locking/lockdep.c:5754 [inline]
 lock_acquire+0x1b1/0x560 kernel/locking/lockdep.c:5719
 __raw_spin_lock_irq include/linux/spinlock_api_smp.h:119 [inline]
 _raw_spin_lock_irq+0x36/0x50 kernel/locking/spinlock.c:170
 put_pwq_unlocked kernel/workqueue.c:1662 [inline]
 put_pwq_unlocked kernel/workqueue.c:1655 [inline]
 destroy_workqueue+0x5df/0xaa0 kernel/workqueue.c:5851
 ieee80211_unregister_hw+0x276/0x3a0 net/mac80211/main.c:1676
 mac80211_hwsim_del_radio+0x266/0x370 drivers/net/wireless/virtual/mac80211_hwsim.c:5576
 hwsim_exit_net+0x33f/0x6d0 drivers/net/wireless/virtual/mac80211_hwsim.c:6453
 ops_exit_list+0xb0/0x180 net/core/net_namespace.c:173
 cleanup_net+0x5b7/0xbf0 net/core/net_namespace.c:640
 process_one_work+0x958/0x1ad0 kernel/workqueue.c:3231
 process_scheduled_works kernel/workqueue.c:3312 [inline]
 worker_thread+0x6c8/0xf70 kernel/workqueue.c:3393
 kthread+0x2c1/0x3a0 kernel/kthread.c:389
 ret_from_fork+0x45/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:__lock_acquire+0xe3e/0x3b30 kernel/locking/lockdep.c:5005
Code: 11 00 00 39 05 b3 cf 1f 12 0f 82 be 05 00 00 ba 01 00 00 00 e9 e4 00 00 00 48 b8 00 00 00 00 00 fc ff df 4c 89 e2 48 c1 ea 03 <80> 3c 02 00 0f 85 82 1f 00 00 49 81 3c 24 a0 3d e3 92 0f 84 98 f2
RSP: 0018:ffffc90006ecf7a0 EFLAGS: 00010006
RAX: dffffc0000000000 RBX: 0000000000000001 RCX: 0000000000000000
RDX: 001ffff11002a963 RSI: ffff888020952440 RDI: 00ffff8880154b18
RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
R10: ffffffff8fe29817 R11: 0000000000000004 R12: 00ffff8880154b18
R13: 0000000000000000 R14: 0000000000000000 R15: 0000000000000001
FS:  0000000000000000(0000) GS:ffff88802c200000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f711b1cd440 CR3: 000000002686c000 CR4: 0000000000350ef0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess):
   0:	11 00                	adc    %eax,(%rax)
   2:	00 39                	add    %bh,(%rcx)
   4:	05 b3 cf 1f 12       	add    $0x121fcfb3,%eax
   9:	0f 82 be 05 00 00    	jb     0x5cd
   f:	ba 01 00 00 00       	mov    $0x1,%edx
  14:	e9 e4 00 00 00       	jmp    0xfd
  19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
  20:	fc ff df
  23:	4c 89 e2             	mov    %r12,%rdx
  26:	48 c1 ea 03          	shr    $0x3,%rdx
* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
  2e:	0f 85 82 1f 00 00    	jne    0x1fb6
  34:	49 81 3c 24 a0 3d e3 	cmpq   $0xffffffff92e33da0,(%r12)
  3b:	92
  3c:	0f                   	.byte 0xf
  3d:	84                   	.byte 0x84
  3e:	98                   	cwtl
  3f:	f2                   	repnz


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

