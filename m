Return-Path: <linux-wireless+bounces-10345-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B508934A5F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 10:50:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D52BA2888A5
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 08:50:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 258E17EEF5;
	Thu, 18 Jul 2024 08:46:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-io1-f71.google.com (mail-io1-f71.google.com [209.85.166.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 752C97E591
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 08:46:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721292386; cv=none; b=lhJIolZ5B4nNpN6xYzlIghq/fXJaCU7UOq63phgZ9fQt5OxQ3/rO4ISgIy6pScetsWjXdN9NPBd9NWkCGZVXynuGrSBV68rgOmLf5wcxpjiC1hnp0xf7f07iwaS+23FDkUYGRUYdS0TaHnJcg1trCvCXBWykxHSPYMJMYHVRndg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721292386; c=relaxed/simple;
	bh=wV5ybvQPor2bnJGgnEn0Oh+kFS+xgnjnr0Hxc8kRgHA=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FGjc0CJl3+FJ2dTuLmZnxZQNQiPMSj4AKGK18u88J0c6REA2OXH9BSEJuBP6DPkBB+ON8/NiKSkDvECvkvTwF46Y2wEztEmSyNoIZvlrL/SCuvFibk9kFMKFezsVMzpQLbN6sxGpqled9LqkO0DupGWkfysmZZqy9Q0TVj7lnes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-io1-f71.google.com with SMTP id ca18e2360f4ac-7f3b0bc9cf6so103716739f.0
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 01:46:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721292383; x=1721897183;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=4zPAYIuXO5OCe6dNXtaa4wLM0bA3nIGaPdAwSXVyIi4=;
        b=E4Rq5KibVatVrRYEABwqvWG6qYI+GDATrsFEcp1DNXK3SvRSoOtCIL9KeERcSy2TMu
         0uKyy+NPay7KxNtMwG6MaeFAZOh0roM+DPasB1UcuWEV+VyBjI2BUps7ABaWW7bmAlyL
         evJGWnDxsyh3NVEruJTjtyPmlmr0yYGjE8VXhK8VLbbkxdM4NwQrj9hLXUULQHkSDhRc
         NhDW6m/MOt3qW2fgHthPYT3HO1OtvGxbH5QhBUF9m4Vkm+lPAvXp4OlokLnQ/RSqTic9
         m8ckXWq0HNP+b8N6UkLszG8L1hDZ4DPn5gJ3tCx6S8LUjIXBYRIHFGD3UL6TZ/JFRdo9
         xIhg==
X-Forwarded-Encrypted: i=1; AJvYcCV2LnNvSS7FPGEUTF5etujmdN4Kg2ohkxqe3hHgAJMwUDR1GNePmdDA7GQU/H2dO23W2QOTd3eWaLD9DmB+1NR3TiWacqCSA4Ck8IIGiJM=
X-Gm-Message-State: AOJu0YyWdvOhKAZjRPkQ4L0v8rK0kSaiEhcf+gxfdOphHp36owXMxiqx
	v/wQIRKbJx5d26C2JLppyrB2Crz7ARzA1f0o7/53Ssy9Sm8HsR4Ti5PPvxSfkpnO47ur5e8PZxX
	bUDvup/tRMF+/b0CmjQ5KqpEV9UqVAV9kns8BQ2C+aMwIyf59/lSLuq8=
X-Google-Smtp-Source: AGHT+IHfTQRHpCcbQEQMMigbvGYeylVBPR6NAUlcDpcwGlttqEKqQ56bCIDRYDV+m5WxrLtGPQzHuSWwSK9BUAxYbpReV8TK97NX
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:219c:b0:397:3a28:94e8 with SMTP id
 e9e14a558f8ab-3973a28973fmr25725ab.3.1721292383653; Thu, 18 Jul 2024 01:46:23
 -0700 (PDT)
Date: Thu, 18 Jul 2024 01:46:23 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <000000000000152438061d819d0b@google.com>
Subject: [syzbot] [wireless?] divide error in mac80211_hwsim_link_info_changed
From: syzbot <syzbot+c6f3c081bf956c97e4de@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, kvalo@kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    51835949dda3 Merge tag 'net-next-6.11' of git://git.kernel..
git tree:       net-next
console output: https://syzkaller.appspot.com/x/log.txt?x=15f207a5980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d3bdd09ea2371c89
dashboard link: https://syzkaller.appspot.com/bug?extid=c6f3c081bf956c97e4de
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/9690deac1819/disk-51835949.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/54d261dbb3f0/vmlinux-51835949.xz
kernel image: https://storage.googleapis.com/syzbot-assets/e61465cd524f/bzImage-51835949.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+c6f3c081bf956c97e4de@syzkaller.appspotmail.com

Oops: divide error: 0000 [#1] PREEMPT SMP KASAN PTI
CPU: 0 PID: 11 Comm: kworker/u8:0 Not tainted 6.10.0-syzkaller-04472-g51835949dda3 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 06/07/2024
Workqueue: events_unbound cfg80211_wiphy_work

RIP: 0010:mac80211_hwsim_link_info_changed+0x409/0xf00 drivers/net/wireless/virtual/mac80211_hwsim.c:2547
Code: 00 fc ff df 43 80 7c 3d 00 00 48 8b 44 24 20 74 0f 48 8b 7c 24 20 e8 a6 ff 0d fb 48 8b 44 24 20 48 8b 08 89 ce 48 89 d8 31 d2 <48> f7 f6 29 d1 48 69 f1 e8 03 00 00 4c 89 f7 31 d2 b9 05 00 00 00
RSP: 0018:ffffc900001077a0 EFLAGS: 00010246

RAX: 00061d780b08a1f3 RBX: 00061d780b08a1f3 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000040
RBP: ffffc90000107890 R08: ffffffff8183f431 R09: 1ffffffff25f9ec5
R10: dffffc0000000000 R11: ffffffff813597f0 R12: 0000000000000200
R13: 1ffff1100c778e08 R14: ffff888063bc7048 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9400000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 000000110c34d35b CR3: 000000006a936000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <TASK>
 drv_link_info_changed+0x53d/0x8b0
 ieee80211_offchannel_return+0x3a4/0x530 net/mac80211/offchannel.c:160
 __ieee80211_scan_completed+0x77f/0xb60 net/mac80211/scan.c:495
 ieee80211_scan_work+0x1cc/0x1da0 net/mac80211/scan.c:1162
 cfg80211_wiphy_work+0x2db/0x490 net/wireless/core.c:440
 process_one_work kernel/workqueue.c:3231 [inline]
 process_scheduled_works+0xa2c/0x1830 kernel/workqueue.c:3312
 worker_thread+0x86d/0xd40 kernel/workqueue.c:3390
 kthread+0x2f0/0x390 kernel/kthread.c:389
 ret_from_fork+0x4b/0x80 arch/x86/kernel/process.c:147
 ret_from_fork_asm+0x1a/0x30 arch/x86/entry/entry_64.S:244
 </TASK>
Modules linked in:
---[ end trace 0000000000000000 ]---
RIP: 0010:mac80211_hwsim_link_info_changed+0x409/0xf00 drivers/net/wireless/virtual/mac80211_hwsim.c:2547
Code: 00 fc ff df 43 80 7c 3d 00 00 48 8b 44 24 20 74 0f 48 8b 7c 24 20 e8 a6 ff 0d fb 48 8b 44 24 20 48 8b 08 89 ce 48 89 d8 31 d2 <48> f7 f6 29 d1 48 69 f1 e8 03 00 00 4c 89 f7 31 d2 b9 05 00 00 00
RSP: 0018:ffffc900001077a0 EFLAGS: 00010246
RAX: 00061d780b08a1f3 RBX: 00061d780b08a1f3 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000040
RBP: ffffc90000107890 R08: ffffffff8183f431 R09: 1ffffffff25f9ec5
R10: dffffc0000000000 R11: ffffffff813597f0 R12: 0000000000000200
R13: 1ffff1100c778e08 R14: ffff888063bc7048 R15: dffffc0000000000
FS:  0000000000000000(0000) GS:ffff8880b9500000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f37c5e6dfc8 CR3: 000000001f47a000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
----------------
Code disassembly (best guess), 3 bytes skipped:
   0:	df 43 80             	filds  -0x80(%rbx)
   3:	7c 3d                	jl     0x42
   5:	00 00                	add    %al,(%rax)
   7:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
   c:	74 0f                	je     0x1d
   e:	48 8b 7c 24 20       	mov    0x20(%rsp),%rdi
  13:	e8 a6 ff 0d fb       	call   0xfb0dffbe
  18:	48 8b 44 24 20       	mov    0x20(%rsp),%rax
  1d:	48 8b 08             	mov    (%rax),%rcx
  20:	89 ce                	mov    %ecx,%esi
  22:	48 89 d8             	mov    %rbx,%rax
  25:	31 d2                	xor    %edx,%edx
* 27:	48 f7 f6             	div    %rsi <-- trapping instruction
  2a:	29 d1                	sub    %edx,%ecx
  2c:	48 69 f1 e8 03 00 00 	imul   $0x3e8,%rcx,%rsi
  33:	4c 89 f7             	mov    %r14,%rdi
  36:	31 d2                	xor    %edx,%edx
  38:	b9 05 00 00 00       	mov    $0x5,%ecx


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

