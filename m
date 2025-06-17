Return-Path: <linux-wireless+bounces-24166-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9442DADBF35
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 04:32:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F7A5164F84
	for <lists+linux-wireless@lfdr.de>; Tue, 17 Jun 2025 02:32:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A6EF34A0C;
	Tue, 17 Jun 2025 02:32:34 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f207.google.com (mail-il1-f207.google.com [209.85.166.207])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9631171C9
	for <linux-wireless@vger.kernel.org>; Tue, 17 Jun 2025 02:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.207
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750127554; cv=none; b=P96emMwJAKbuhKY5NkLZPChVtHSMNusT6cUwwGEDAN9c0fbs4GxV5eC7ORk/9vnRkwwiqZQDKHxYfX65Qgfaid0dFXlZ/cfGpDbUOxtkCQGYegdYxvHC77wLS0ZelWd9sIlKi6tfMXPaesKd0j9hjPdyzh7ngn92UIAIISxLJTo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750127554; c=relaxed/simple;
	bh=h4q1rdV/jvVwTNYLtRk4eAkzcqF8Q9upnPzV7KCRXuM=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=FcD590S0LRXAUlBK3BSNkHUq2eyy28bc2UJv9ebJ2ow6GoQTTnKfjrHHtPuiEapB03/66+JdPTn8KAaULjbBwpkUwHKnUXfZEwqXgxKX6sp7TwTpVxl4KMKqxxfFXectXUKUrlZg3lXw0B/w5NT2h6dcHjJJqEMMA5LJSaKobyU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.207
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f207.google.com with SMTP id e9e14a558f8ab-3ddafe52d04so140889075ab.1
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 19:32:29 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750127549; x=1750732349;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2kFs6ehQrsbeV5OtP9QYHlGeA6LyGbaav1qAD3QYV/E=;
        b=eDJfDPSeRTuYD/2AD4xk7zMtK22wsE7N1NDpyu6VyrvjvuT7s2g2AbOyYg0iUqw77U
         wCp0UiHfxMUCHNVxoWpZaRIsLKUauhHVbEJeg/PhfQoo8UvNoafGH+6aVZmUqlnyzXqJ
         RVR2JjJK76Z9/VMn6wEhOBgW9ynUJy+TboS1tkHFK+QXC5bc4xSyvSbyhGQHkd3qMRk0
         CZuIk6Gp6RIW2PwEu82Tmp1hoRTBdjyYmeBiVOdIc2UdIQxlDnpYSoOTTtfn7cUrQk5V
         RxUQ1dZJ8Iv2iS1qhQxh4hsJCY0f+YX+tpHNg0qJbzTke0XCoHfrQR41xH0Fb9TTaOQR
         ILnA==
X-Forwarded-Encrypted: i=1; AJvYcCXHwEMDdEwTcXohbKeD3hzkIuHewA611ElLIywOJOXD+cZQ4IkEu0lwWAPVLwzwvkVEMFBCyl+0QqFs8Vpnvg==@vger.kernel.org
X-Gm-Message-State: AOJu0YzLhZW1AJM2VBLAhG2s4CmNHZczsQ1TUcScIPwOiDBNXk9hQLRy
	90/l8GMM76AGX//0VL3MVNI7Oo24qkTDvB3FWxXUr6Y/vcQq5nkmzLujtU+CO+wGtrIQn98fIIm
	eNrKg48r72XlRF2nPBMknUj90ZW6Jqhf70E1MUN8r5Mzgbly2CQftADyc2gw=
X-Google-Smtp-Source: AGHT+IGojPqlwd05Ofb94SwCCl6PaTM0bN7hniK2siRdvVj6Tbgu9X+chhmupx/zHOzGW4YUeA41zt3BbVmujP3nhoOv+1667f7c
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1a2b:b0:3dd:d746:25eb with SMTP id
 e9e14a558f8ab-3de07cd170amr127784865ab.16.1750127549067; Mon, 16 Jun 2025
 19:32:29 -0700 (PDT)
Date: Mon, 16 Jun 2025 19:32:29 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <6850d3bd.a70a0220.395abc.01fa.GAE@google.com>
Subject: [syzbot] [wireless?] WARNING: net/mac80211/tx.c:LINE at
 __ieee80211_beacon_get, CPU: syz.NUM.NUM/NUM
From: syzbot <syzbot+468656785707b0e995df@syzkaller.appspotmail.com>
To: johannes@sipsolutions.net, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org, 
	syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    050f8ad7b58d Add linux-next specific files for 20250616
git tree:       linux-next
console output: https://syzkaller.appspot.com/x/log.txt?x=125e190c580000
kernel config:  https://syzkaller.appspot.com/x/.config?x=d2efc7740224b93a
dashboard link: https://syzkaller.appspot.com/bug?extid=468656785707b0e995df
compiler:       Debian clang version 20.1.6 (++20250514063057+1e4d39e07757-1~exp1~20250514183223.118), Debian LLD 20.1.6

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/49faa18d2f53/disk-050f8ad7.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/7c6f9cd7fe5d/vmlinux-050f8ad7.xz
kernel image: https://storage.googleapis.com/syzbot-assets/84a08d6403ee/bzImage-050f8ad7.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+468656785707b0e995df@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: net/mac80211/tx.c:5024 at __ieee80211_beacon_update_cntdwn net/mac80211/tx.c:5024 [inline], CPU#1: syz.4.243/6807
WARNING: net/mac80211/tx.c:5024 at __ieee80211_beacon_get+0x125d/0x1630 net/mac80211/tx.c:5453, CPU#1: syz.4.243/6807
Modules linked in:
CPU: 1 UID: 0 PID: 6807 Comm: syz.4.243 Not tainted 6.16.0-rc2-next-20250616-syzkaller #0 PREEMPT(full) 
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 05/07/2025
RIP: 0010:__ieee80211_beacon_update_cntdwn net/mac80211/tx.c:5024 [inline]
RIP: 0010:__ieee80211_beacon_get+0x125d/0x1630 net/mac80211/tx.c:5453
Code: e7 e8 27 f2 2f f7 45 31 f6 4c 8b bc 24 a0 00 00 00 e9 78 fe ff ff e8 92 bf d6 f6 90 0f 0b 90 e9 e0 f7 ff ff e8 84 bf d6 f6 90 <0f> 0b 90 e9 38 fb ff ff e8 76 bf d6 f6 48 c7 c7 a0 5c 79 8f 4c 89
RSP: 0018:ffffc90000a089f8 EFLAGS: 00010246
RAX: ffffffff8ae9aaac RBX: ffffffff8ae99886 RCX: ffff888025e8da00
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000000000 R08: ffff888025e8da00 R09: 0000000000000003
R10: 0000000000000007 R11: 0000000000000100 R12: ffff888058976500
R13: dffffc0000000000 R14: ffff8880589769d0 R15: ffff888032955024
FS:  00007fbd84f5b6c0(0000) GS:ffff888125d40000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000555570bf35c8 CR3: 000000002eed6000 CR4: 00000000003526f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 ieee80211_beacon_get_tim+0xb4/0x2b0 net/mac80211/tx.c:5580
 ieee80211_beacon_get include/net/mac80211.h:5638 [inline]
 mac80211_hwsim_beacon_tx+0x3ce/0x860 drivers/net/wireless/virtual/mac80211_hwsim.c:2319
 __iterate_interfaces+0x2a8/0x590 net/mac80211/util.c:761
 ieee80211_iterate_active_interfaces_atomic+0xdb/0x180 net/mac80211/util.c:797
 mac80211_hwsim_beacon+0xbb/0x1c0 drivers/net/wireless/virtual/mac80211_hwsim.c:2353
 __run_hrtimer kernel/time/hrtimer.c:1761 [inline]
 __hrtimer_run_queues+0x529/0xc60 kernel/time/hrtimer.c:1825
 hrtimer_run_softirq+0x187/0x2b0 kernel/time/hrtimer.c:1842
 handle_softirqs+0x283/0x870 kernel/softirq.c:579
 __do_softirq kernel/softirq.c:613 [inline]
 invoke_softirq kernel/softirq.c:453 [inline]
 __irq_exit_rcu+0xca/0x1f0 kernel/softirq.c:680
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:696
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1050 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1050
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:finish_wait+0x5/0x1f0 kernel/sched/wait.c:358
Code: 0f 1e fa 44 89 ef e8 7a 68 f5 ff eb 96 0f 1f 84 00 00 00 00 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 f3 0f 1e fa 55 <41> 57 41 56 41 55 41 54 53 48 83 ec 10 48 89 f3 49 89 fd 48 bd 00
RSP: 0018:ffffc9001bccf5f0 EFLAGS: 00000246
RAX: 7fffffffffffffff RBX: dffffc0000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: ffffc9001bccf640 RDI: ffff888028058700
RBP: ffffc9001bccf6f0 R08: ffffffff8fa14ff7 R09: 1ffffffff1f429fe
R10: dffffc0000000000 R11: fffffbfff1f429ff R12: ffff888028058700
R13: ffffc9001bccf640 R14: 1ffff92003799ec4 R15: 7fffffffffffffff
 unix_wait_for_peer+0x22f/0x2e0 net/unix/af_unix.c:1587
 unix_dgram_sendmsg+0xb1f/0x1870 net/unix/af_unix.c:2188
 sock_sendmsg_nosec net/socket.c:712 [inline]
 __sock_sendmsg+0x219/0x270 net/socket.c:727
 ____sys_sendmsg+0x52d/0x830 net/socket.c:2566
 ___sys_sendmsg+0x21f/0x2a0 net/socket.c:2620
 __sys_sendmmsg+0x227/0x430 net/socket.c:2709
 __do_sys_sendmmsg net/socket.c:2736 [inline]
 __se_sys_sendmmsg net/socket.c:2733 [inline]
 __x64_sys_sendmmsg+0xa0/0xc0 net/socket.c:2733
 do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
 do_syscall_64+0xfa/0x3b0 arch/x86/entry/syscall_64.c:94
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7fbd8418e929
Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 a8 ff ff ff f7 d8 64 89 01 48
RSP: 002b:00007fbd84f5b038 EFLAGS: 00000246 ORIG_RAX: 0000000000000133
RAX: ffffffffffffffda RBX: 00007fbd843b5fa0 RCX: 00007fbd8418e929
RDX: 0400000000000041 RSI: 0000200000000000 RDI: 0000000000000005
RBP: 00007fbd84210b39 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
R13: 0000000000000000 R14: 00007fbd843b5fa0 R15: 00007ffe98cac8e8
 </TASK>
----------------
Code disassembly (best guess):
   0:	0f 1e fa             	nop    %edx
   3:	44 89 ef             	mov    %r13d,%edi
   6:	e8 7a 68 f5 ff       	call   0xfff56885
   b:	eb 96                	jmp    0xffffffa3
   d:	0f 1f 84 00 00 00 00 	nopl   0x0(%rax,%rax,1)
  14:	00
  15:	90                   	nop
  16:	90                   	nop
  17:	90                   	nop
  18:	90                   	nop
  19:	90                   	nop
  1a:	90                   	nop
  1b:	90                   	nop
  1c:	90                   	nop
  1d:	90                   	nop
  1e:	90                   	nop
  1f:	90                   	nop
  20:	90                   	nop
  21:	90                   	nop
  22:	90                   	nop
  23:	90                   	nop
  24:	90                   	nop
  25:	f3 0f 1e fa          	endbr64
  29:	55                   	push   %rbp
* 2a:	41 57                	push   %r15 <-- trapping instruction
  2c:	41 56                	push   %r14
  2e:	41 55                	push   %r13
  30:	41 54                	push   %r12
  32:	53                   	push   %rbx
  33:	48 83 ec 10          	sub    $0x10,%rsp
  37:	48 89 f3             	mov    %rsi,%rbx
  3a:	49 89 fd             	mov    %rdi,%r13
  3d:	48                   	rex.W
  3e:	bd                   	.byte 0xbd


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

