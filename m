Return-Path: <linux-wireless+bounces-30957-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4602AD3AA8F
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 14:42:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 01F723042755
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Jan 2026 13:42:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7A50D36AB7E;
	Mon, 19 Jan 2026 13:42:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f77.google.com (mail-oa1-f77.google.com [209.85.160.77])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0A8236921C
	for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 13:42:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.77
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768830146; cv=none; b=FR8mAffTr8VFJLk/Yf/YPdiC8anqyhjJ4+/cBgbXonPZEkCW3DDB4zawU94//WcVG0PTitBegm1EfJCBCrC6m1hJZhK2yvzAqMRD+xNYc/QFNt0F3BR2z4xMqGk/3ZwIzj3WMNXQVZNA4gd9SjkQ7gBoF10VhBaa5blkIiiG3j0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768830146; c=relaxed/simple;
	bh=FMLcUUKCHc94/oLuNfGCQc4E6ZGfdlUDKBXGmEjPQ8A=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=RXxWO/pxrXEi5wECVoNKeKvtMJswCdScATzl/oFjHyi1T11nGgkK/aLZvJ4emFrPhZSbzc3BerFxNtK37QMDrjy+lYvXzntEIrvjPVwjzu2u3eKJD+r98qv6IT1TuGFagFoEtMydrhWfVA8ygUqyn/P8646g8hXvL2vjj0YsfVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.160.77
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-oa1-f77.google.com with SMTP id 586e51a60fabf-402d5d2706fso4698459fac.3
        for <linux-wireless@vger.kernel.org>; Mon, 19 Jan 2026 05:42:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768830144; x=1769434944;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2XDY1/DfyQ23j23GzmXoCuFXSYNZFVLA6MfwMPKtank=;
        b=PqMd13U8+YO+GR2b+D+/Rpj4QWN/2KPpVC0Dkp+csCAP61QqwaSPbhRqJneZxwi5L4
         C23tkFVhTlwCBxsTe3EEQ+5CBa8FMy55yu2Zug16yCXG0xN8ZaFO/QliPgdG6zsz0hYo
         7nNIEEXgSWDNUYgxJiGyc5WBSRhH+DilqTRXPDuH1VQEe2UZev7/iXYzi7QXlQbL77ah
         yQw9IXIafuG+Pmrfv8Pbumx/DKvA7UEVBiIwdupwg56HMt5EPvxm2X+qeFT98TeV1qYS
         8VpQmJYi8/E5z4Mc1MgtagwjK+ZKR1/dA4UnPICMov2D720gu9BlPirSY3rKDvWnRUTg
         PQ+w==
X-Forwarded-Encrypted: i=1; AJvYcCU11UfHSW8IZMsV7TdihBZWABuzdHV5/BulEbAEzeE4BKjTcTMKrUR68sfaUfkdrvtey7thLEILmGooRo1Nmg==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzf2LTkMHepJrcOM+0cQT6cZdMkxI/wEhcot7lZaeFURPgb3JWo
	C4LV3MIAUVvcBvbVSmWGEw+zXYJnRWJ6ibTVnE3KjSjB/Z+coiZNvHYq7VDdLpD3I2eLaWhMU2J
	pjXMvHgJ2emR1mBMNSCXml9H+sGN0lkEOQ3baU1O5H3G0RFiImFeYM3l6qv8=
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6820:1b0d:b0:65f:6cc6:6023 with SMTP id
 006d021491bc7-66117a19629mr4228397eaf.76.1768830143889; Mon, 19 Jan 2026
 05:42:23 -0800 (PST)
Date: Mon, 19 Jan 2026 05:42:23 -0800
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <696e34bf.a70a0220.34546f.04ad.GAE@google.com>
Subject: [syzbot] [wireless?] general protection fault in ieee80211_put_srates_elem
From: syzbot <syzbot+81cd9dc1596563141d19@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    54e82e93ca93 Merge tag 'core_urgent_for_v6.19_rc4' of git:..
git tree:       upstream
console output: https://syzkaller.appspot.com/x/log.txt?x=17bceb9a580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=513255d80ab78f2b
dashboard link: https://syzkaller.appspot.com/bug?extid=81cd9dc1596563141d19
compiler:       Debian clang version 20.1.8 (++20250708063551+0c9f909b7976-1~exp1~20250708183702.136), Debian LLD 20.1.8
syz repro:      https://syzkaller.appspot.com/x/repro.syz?x=13924b9a580000
C reproducer:   https://syzkaller.appspot.com/x/repro.c?x=12d46852580000

Downloadable assets:
disk image (non-bootable): https://storage.googleapis.com/syzbot-assets/d900f083ada3/non_bootable_disk-54e82e93.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/f3befb5f53a4/vmlinux-54e82e93.xz
kernel image: https://storage.googleapis.com/syzbot-assets/92820ca1dbd8/bzImage-54e82e93.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+81cd9dc1596563141d19@syzkaller.appspotmail.com

Oops: general protection fault, probably for non-canonical address 0xdffffc0000000003: 0000 [#1] SMP KASAN NOPTI
KASAN: null-ptr-deref in range [0x0000000000000018-0x000000000000001f]
CPU: 0 UID: 0 PID: 3030 Comm: kworker/u4:13 Not tainted syzkaller #0 PREEMPT(full) 
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2~bpo12+1 04/01/2014
Workqueue: events_unbound cfg80211_wiphy_work
RIP: 0010:ieee80211_put_srates_elem+0x42/0x640 net/mac80211/util.c:3272
Code: 18 89 54 24 28 48 89 f3 49 89 fe 49 bc 00 00 00 00 00 fc ff df e8 ae 3f e3 f6 48 89 5c 24 38 4c 8d 6b 18 4d 89 ef 49 c1 ef 03 <43> 0f b6 04 27 84 c0 0f 85 19 05 00 00 41 8b 5d 00 31 ff 89 de e8
RSP: 0018:ffffc9000981f7b8 EFLAGS: 00010206
RAX: ffffffff8addc7b2 RBX: 0000000000000000 RCX: ffff888038e9c980
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88801a1bb000
RBP: 0000000000000001 R08: 0000000000000001 R09: ffffffff8df41aa0
R10: dffffc0000000000 R11: ffffed100343d00b R12: dffffc0000000000
R13: 0000000000000018 R14: ffff88801a1bb000 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff88808d414000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f709ef1fa30 CR3: 0000000053e50000 CR4: 0000000000352ef0
Call Trace:
 <TASK>
 ieee80211_mesh_build_beacon+0xa83/0x1b50 net/mac80211/mesh.c:1093
 ieee80211_mesh_rebuild_beacon+0xc7/0x170 net/mac80211/mesh.c:1147
 ieee80211_mesh_finish_csa+0x131/0x210 net/mac80211/mesh.c:1542
 ieee80211_set_after_csa_beacon net/mac80211/cfg.c:4085 [inline]
 __ieee80211_csa_finalize net/mac80211/cfg.c:4133 [inline]
 ieee80211_csa_finalize+0x633/0x1150 net/mac80211/cfg.c:4155
 cfg80211_wiphy_work+0x2ab/0x450 net/wireless/core.c:438
 process_one_work kernel/workqueue.c:3257 [inline]
 process_scheduled_works+0xad1/0x1770 kernel/workqueue.c:3340
 worker_thread+0x8a0/0xda0 kernel/workqueue.c:3421
 kthread+0x711/0x8a0 kernel/kthread.c:463
 ret_from_fork+0x510/0xa50 arch/x86/kernel/process.c:158
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:246
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:ieee80211_put_srates_elem+0x42/0x640 net/mac80211/util.c:3272
Code: 18 89 54 24 28 48 89 f3 49 89 fe 49 bc 00 00 00 00 00 fc ff df e8 ae 3f e3 f6 48 89 5c 24 38 4c 8d 6b 18 4d 89 ef 49 c1 ef 03 <43> 0f b6 04 27 84 c0 0f 85 19 05 00 00 41 8b 5d 00 31 ff 89 de e8
RSP: 0018:ffffc9000981f7b8 EFLAGS: 00010206
RAX: ffffffff8addc7b2 RBX: 0000000000000000 RCX: ffff888038e9c980
RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88801a1bb000
RBP: 0000000000000001 R08: 0000000000000001 R09: ffffffff8df41aa0
R10: dffffc0000000000 R11: ffffed100343d00b R12: dffffc0000000000
R13: 0000000000000018 R14: ffff88801a1bb000 R15: 0000000000000003
FS:  0000000000000000(0000) GS:ffff88808d414000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007ffd6f05c5e0 CR3: 000000001206c000 CR4: 0000000000352ef0
----------------
Code disassembly (best guess):
   0:	18 89 54 24 28 48    	sbb    %cl,0x48282454(%rcx)
   6:	89 f3                	mov    %esi,%ebx
   8:	49 89 fe             	mov    %rdi,%r14
   b:	49 bc 00 00 00 00 00 	movabs $0xdffffc0000000000,%r12
  12:	fc ff df
  15:	e8 ae 3f e3 f6       	call   0xf6e33fc8
  1a:	48 89 5c 24 38       	mov    %rbx,0x38(%rsp)
  1f:	4c 8d 6b 18          	lea    0x18(%rbx),%r13
  23:	4d 89 ef             	mov    %r13,%r15
  26:	49 c1 ef 03          	shr    $0x3,%r15
* 2a:	43 0f b6 04 27       	movzbl (%r15,%r12,1),%eax <-- trapping instruction
  2f:	84 c0                	test   %al,%al
  31:	0f 85 19 05 00 00    	jne    0x550
  37:	41 8b 5d 00          	mov    0x0(%r13),%ebx
  3b:	31 ff                	xor    %edi,%edi
  3d:	89 de                	mov    %ebx,%esi
  3f:	e8                   	.byte 0xe8


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

