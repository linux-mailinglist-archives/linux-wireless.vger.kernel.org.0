Return-Path: <linux-wireless+bounces-12637-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB454970AB5
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 02:10:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 052F21C215C8
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 00:10:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9006F33FE;
	Mon,  9 Sep 2024 00:10:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-il1-f206.google.com (mail-il1-f206.google.com [209.85.166.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCED029B0
	for <linux-wireless@vger.kernel.org>; Mon,  9 Sep 2024 00:10:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725840627; cv=none; b=QLuoS5eWS+c3V5p+x4gIGqCZD3zi/YW8TDGHZXFwEpN/N3E3sQanhvz85YBE54z522KYq94FuWmguYNgXO8yep1+aQvnOObw4218hbOBQFXI45HvyAmjOCTBOfaXPysj5vyyVe4WWbF55iau/0nmlZKf4J3W2vX7QSO+xmBhNz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725840627; c=relaxed/simple;
	bh=gdXA8mdv9/Wt2N4JT/taEM5Rjv7oKk9dwwaTJGj93h4=;
	h=MIME-Version:Date:Message-ID:Subject:From:To:Content-Type; b=cI1CKb68VFPEOzHfnpJ2JxAK8YRp2ARwyJ6wuYE83zjOOBafa/KN7dTAlMyPE1cjAX01RxjDtrhUredYmxRipWnMUb4B6gSviiCTMd/Mjz/ZmITGIpPYjxwBwkcc3JGYA12QNes5ALdvFzxUnvOx6cECKeX7qZII/1mQM/Nvba4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com; arc=none smtp.client-ip=209.85.166.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=syzkaller.appspotmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=M3KW2WVRGUFZ5GODRSRYTGD7.apphosting.bounces.google.com
Received: by mail-il1-f206.google.com with SMTP id e9e14a558f8ab-39d2c44422eso60135575ab.2
        for <linux-wireless@vger.kernel.org>; Sun, 08 Sep 2024 17:10:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725840625; x=1726445425;
        h=to:from:subject:message-id:date:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8YMGwHLqSidkmjKDWpogpRqKoOdeBh1Yx5Vlies0YHU=;
        b=MppW5fcGPzekdGE096bC59PzkhF5Wd0SPYOdb3tYZ98TZmy+L8f1YUWRDAfxmSsU93
         R5PQdgA6yYXFTv9DF/wXP3IbwNJaiiMiuaNJ8a3del16ALWPKN2zFxYTac6VUmPOZrOm
         Il+P2g8B0KnDfNJXBvr/+FPh5co9gbKUdbgoVag4mo9o9t9I0i0bLPyFwIy2ptHqRHft
         Bq3GF91VFbFWoE8v55Q0KfvfXT6zxvqLC8RpuPRhawmLSh0jG0KAu0om3C9wVxXmNDe6
         rHsTUBcJdTD5I5kj/u8O7WFpBu5gqt4O0lTwMpQo+agjYCbUwZ/oTIwEsHGGyprhVu8+
         NzkA==
X-Forwarded-Encrypted: i=1; AJvYcCWKYYudAy+8TRK+x4Z4cPjllAwuIVuatFcDlMxOkTbLQCymqiAmZZ1gbK/kVTBS+Xn2nQUImG/KEQTgiP1YpQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzCfF2p1L+CiUy5aOtbWNIc/7tIC8zRcWX/4NN0o8NfPVaT1suP
	Wh0J5riA/DGErIfFpj9QnV65y2NI8J0BS6jAgWT2U1/6nzXgzIdQKn07eEmWXhz0cYSmfeEIdZj
	F2S1QPn06YeFXmkW4/ZMDA+tfDeGzw8ThxpyuxmXm0nMhAHP/72bf/WM=
X-Google-Smtp-Source: AGHT+IH00w4Kg+tsfr8fLDMpUFza9Z96V2kwo2YniuJyIWsjrr7eS/chyIEuZyk1h1BmK7ZkMmRNdbeQ381GjimXyHDX7Q2uI7GU
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Received: by 2002:a05:6e02:1aa4:b0:397:6dfc:993a with SMTP id
 e9e14a558f8ab-3a04f0fdd80mr115191015ab.21.1725840624880; Sun, 08 Sep 2024
 17:10:24 -0700 (PDT)
Date: Sun, 08 Sep 2024 17:10:24 -0700
X-Google-Appengine-App-Id: s~syzkaller
X-Google-Appengine-App-Id-Alias: syzkaller
Message-ID: <00000000000062a2960621a49519@google.com>
Subject: [syzbot] [wireless?] WARNING in ieee80211_rx_list (3)
From: syzbot <syzbot+b4aa2b672b18f1d4dc5f@syzkaller.appspotmail.com>
To: davem@davemloft.net, edumazet@google.com, johannes@sipsolutions.net, 
	kuba@kernel.org, linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org, 
	netdev@vger.kernel.org, pabeni@redhat.com, syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hello,

syzbot found the following issue on:

HEAD commit:    b6ecc6620376 net: mana: Fix error handling in mana_create_..
git tree:       net
console output: https://syzkaller.appspot.com/x/log.txt?x=15b5ecab980000
kernel config:  https://syzkaller.appspot.com/x/.config?x=996585887acdadb3
dashboard link: https://syzkaller.appspot.com/bug?extid=b4aa2b672b18f1d4dc5f
compiler:       Debian clang version 15.0.6, GNU ld (GNU Binutils for Debian) 2.40

Unfortunately, I don't have any reproducer for this issue yet.

Downloadable assets:
disk image: https://storage.googleapis.com/syzbot-assets/c4574f06e044/disk-b6ecc662.raw.xz
vmlinux: https://storage.googleapis.com/syzbot-assets/305e39881a39/vmlinux-b6ecc662.xz
kernel image: https://storage.googleapis.com/syzbot-assets/14c5c8efb32e/bzImage-b6ecc662.xz

IMPORTANT: if you fix the issue, please add the following tag to the commit:
Reported-by: syzbot+b4aa2b672b18f1d4dc5f@syzkaller.appspotmail.com

------------[ cut here ]------------
WARNING: CPU: 1 PID: 14994 at net/mac80211/rx.c:5375 ieee80211_rx_list+0x2a07/0x3780 net/mac80211/rx.c:5375
Modules linked in:
CPU: 1 UID: 0 PID: 14994 Comm: syz.0.2232 Not tainted 6.11.0-rc5-syzkaller-00192-gb6ecc6620376 #0
Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 08/06/2024
RIP: 0010:ieee80211_rx_list+0x2a07/0x3780 net/mac80211/rx.c:5375
Code: 90 e9 21 da ff ff e8 f8 1e 64 f6 e9 17 da ff ff e8 ee 1e 64 f6 e9 0d da ff ff e8 e4 1e 64 f6 e9 03 da ff ff e8 da 1e 64 f6 90 <0f> 0b 90 e9 f5 d9 ff ff e8 cc 1e 64 f6 31 c0 48 89 44 24 60 e9 e5
RSP: 0018:ffffc90000a189a0 EFLAGS: 00010246
RAX: ffffffff8b2f6d56 RBX: 0000000000000000 RCX: ffff888061fc8000
RDX: 0000000000000100 RSI: 0000000000000000 RDI: 0000000000000000
RBP: ffffc90000a18bf0 R08: ffffffff8b2f4592 R09: 1ffffffff283c708
R10: dffffc0000000000 R11: fffffbfff283c709 R12: dffffc0000000000
R13: ffff88806d804640 R14: ffff88805f0c0e40 R15: ffff88805f0c30c8
FS:  0000000000000000(0000) GS:ffff8880b8900000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00007f251b600020 CR3: 000000006190e000 CR4: 00000000003506f0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
 <IRQ>
 ieee80211_rx_napi+0x18a/0x3c0 net/mac80211/rx.c:5485
 ieee80211_rx include/net/mac80211.h:5124 [inline]
 ieee80211_handle_queued_frames+0xe7/0x1e0 net/mac80211/main.c:439
 tasklet_action_common+0x321/0x4d0 kernel/softirq.c:785
 handle_softirqs+0x2c4/0x970 kernel/softirq.c:554
 __do_softirq kernel/softirq.c:588 [inline]
 invoke_softirq kernel/softirq.c:428 [inline]
 __irq_exit_rcu+0xf4/0x1c0 kernel/softirq.c:637
 irq_exit_rcu+0x9/0x30 kernel/softirq.c:649
 instr_sysvec_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1043 [inline]
 sysvec_apic_timer_interrupt+0xa6/0xc0 arch/x86/kernel/apic/apic.c:1043
 </IRQ>
 <TASK>
 asm_sysvec_apic_timer_interrupt+0x1a/0x20 arch/x86/include/asm/idtentry.h:702
RIP: 0010:__sanitizer_cov_trace_pc+0x0/0x70 kernel/kcov.c:209
Code: 89 fb e8 23 00 00 00 48 8b 3d dc 76 96 0c 48 89 de 5b e9 83 9d 5b 00 0f 1f 00 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 <f3> 0f 1e fa 48 8b 04 24 65 48 8b 0c 25 00 d7 03 00 65 8b 15 c0 4a
RSP: 0018:ffffc900039bf290 EFLAGS: 00000246
RAX: 0000000000000000 RBX: ffffea0001c6b388 RCX: ffff888061fc8000
RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000000000000
RBP: 0000000000013115 R08: ffffffff81ea2868 R09: 1ffffd400038d678
R10: dffffc0000000000 R11: fffff9400038d679 R12: ffffea0001c6b3c0
R13: ffffea0001c6b3c0 R14: 0000000000000001 R15: 0000000000000000
 arch_static_branch arch/x86/include/asm/jump_label.h:27 [inline]
 page_fixed_fake_head include/linux/page-flags.h:203 [inline]
 _compound_head include/linux/page-flags.h:244 [inline]
 __folio_rmap_sanity_checks+0x11f/0x670 include/linux/rmap.h:216
 __folio_remove_rmap mm/rmap.c:1518 [inline]
 folio_remove_rmap_ptes+0x3d/0x490 mm/rmap.c:1599
 zap_present_folio_ptes mm/memory.c:1517 [inline]
 zap_present_ptes mm/memory.c:1576 [inline]
 zap_pte_range mm/memory.c:1618 [inline]
 zap_pmd_range mm/memory.c:1736 [inline]
 zap_pud_range mm/memory.c:1765 [inline]
 zap_p4d_range mm/memory.c:1786 [inline]
 unmap_page_range+0x1b93/0x42c0 mm/memory.c:1807
 unmap_vmas+0x3cc/0x5f0 mm/memory.c:1897
 exit_mmap+0x264/0xc80 mm/mmap.c:3412
 __mmput+0x115/0x390 kernel/fork.c:1345
 exit_mm+0x220/0x310 kernel/exit.c:571
 do_exit+0x9b2/0x27f0 kernel/exit.c:869
 do_group_exit+0x207/0x2c0 kernel/exit.c:1031
 get_signal+0x16a1/0x1740 kernel/signal.c:2917
 arch_do_signal_or_restart+0x96/0x860 arch/x86/kernel/signal.c:310
 exit_to_user_mode_loop kernel/entry/common.c:111 [inline]
 exit_to_user_mode_prepare include/linux/entry-common.h:328 [inline]
 __syscall_exit_to_user_mode_work kernel/entry/common.c:207 [inline]
 syscall_exit_to_user_mode+0xc9/0x370 kernel/entry/common.c:218
 do_syscall_64+0x100/0x230 arch/x86/entry/common.c:89
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
RIP: 0033:0x7f6654f7cef9
Code: Unable to access opcode bytes at 0x7f6654f7cecf.
RSP: 002b:00007f6655e5b0e8 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
RAX: fffffffffffffe00 RBX: 00007f6655135f88 RCX: 00007f6654f7cef9
RDX: 0000000000000000 RSI: 0000000000000080 RDI: 00007f6655135f88
RBP: 00007f6655135f80 R08: 0000000000000000 R09: 0000000000000000
R10: 0000000000000000 R11: 0000000000000246 R12: 00007f6655135f8c
R13: 0000000000000000 R14: 00007fffa4ac5d00 R15: 00007fffa4ac5de8
 </TASK>
----------------
Code disassembly (best guess):
   0:	89 fb                	mov    %edi,%ebx
   2:	e8 23 00 00 00       	call   0x2a
   7:	48 8b 3d dc 76 96 0c 	mov    0xc9676dc(%rip),%rdi        # 0xc9676ea
   e:	48 89 de             	mov    %rbx,%rsi
  11:	5b                   	pop    %rbx
  12:	e9 83 9d 5b 00       	jmp    0x5b9d9a
  17:	0f 1f 00             	nopl   (%rax)
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
  25:	90                   	nop
  26:	90                   	nop
  27:	90                   	nop
  28:	90                   	nop
  29:	90                   	nop
* 2a:	f3 0f 1e fa          	endbr64 <-- trapping instruction
  2e:	48 8b 04 24          	mov    (%rsp),%rax
  32:	65 48 8b 0c 25 00 d7 	mov    %gs:0x3d700,%rcx
  39:	03 00
  3b:	65                   	gs
  3c:	8b                   	.byte 0x8b
  3d:	15                   	.byte 0x15
  3e:	c0                   	.byte 0xc0
  3f:	4a                   	rex.WX


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

