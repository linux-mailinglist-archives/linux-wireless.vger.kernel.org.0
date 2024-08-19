Return-Path: <linux-wireless+bounces-11642-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0DDD9957761
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 00:23:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D7D2835B5
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 22:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56851DC46C;
	Mon, 19 Aug 2024 22:23:16 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA6D915A843;
	Mon, 19 Aug 2024 22:23:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724106196; cv=none; b=f1HRgkfZB2QYftrk/rkWmWMa6QXLfgh+8J5tRfNCwzxY7QONc7luHC9vPhDlzq3ZrwTYizbi7yz5aCXEY4FFx1MzCC3LvoP7nIthCGvR5mKHGfGGAOajwoYNIXcA1HFsUkXcJctaixxtwxIxsVHi6eEqyRRZRRjRPCO9hDznUU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724106196; c=relaxed/simple;
	bh=tz4yofYq+XhKDOjLrjsV/Hw50t1cBVsD7gcCCQwHLdI=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nCD/nfHd7oaW1Rs4uAXQmro3Kmd44Xgi6cpOQlVHbrhqA5JVELggYZWdATqMtM0ppZqv0j3NIsi8ZxWics0hFxj6cudKHwqs9qUuXqt6WXdUFouitbvdq+f4HMwpfa6r0dDrqDKmlOb79KXFp4WS8xpFONBIzRzW5X9W5XlPxx0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6A8C32782;
	Mon, 19 Aug 2024 22:23:15 +0000 (UTC)
Date: Mon, 19 Aug 2024 18:23:40 -0400
From: Steven Rostedt <rostedt@goodmis.org>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
 netdev@vger.kernel.org, linux-wireless@vger.kernel.org
Subject: Re: [PATCH v5 0/4] tracing: improve symbolic printing
Message-ID: <20240819182340.3bd23d67@gandalf.local.home>
In-Reply-To: <20240614081956.19832-6-johannes@sipsolutions.net>
References: <20240614081956.19832-6-johannes@sipsolutions.net>
X-Mailer: Claws Mail 3.20.0git84 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit


Hi Johannes,

I finally got around to testing your patches.

I did the following:

 # cat /sys/kernel/tracing/events/*/*/format

and hit this:

BUG: unable to handle page fault for address: ffffffff8e6333d0
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 183c40067 P4D 183c40067 PUD 183c41063 PMD 1003ef063 PTE 800ffffe7b9cc062
Oops: Oops: 0000 [#1] PREEMPT SMP PTI
CPU: 7 UID: 0 PID: 893 Comm: cat Not tainted 6.11.0-rc4-test-00004-g4ce2836f008b #56 68afcee1248519f8b3b088836c40746e4a6b69d3
Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
RIP: 0010:f_show (kernel/trace/trace_events.c:1601 kernel/trace/trace_events.c:1651 kernel/trace/trace_events.c:1689)
Code: 33 63 8e 48 2d d0 33 63 8e 48 c1 f8 03 85 c0 74 67 89 c0 4c 89 c3 49 8d 04 c0 48 89 04 24 eb 0a 48 83 c3 08 48 39 1c 24 74 4e <4c> 8b 3b 4d 85 ff 74 ee 49 8b 45 10 48 8b 00 49 39 07 75 e2 49 8b
All code
========
   0:   33 63 8e                xor    -0x72(%rbx),%esp
   3:   48 2d d0 33 63 8e       sub    $0xffffffff8e6333d0,%rax
   9:   48 c1 f8 03             sar    $0x3,%rax
   d:   85 c0                   test   %eax,%eax
   f:   74 67                   je     0x78
  11:   89 c0                   mov    %eax,%eax
  13:   4c 89 c3                mov    %r8,%rbx
  16:   49 8d 04 c0             lea    (%r8,%rax,8),%rax
  1a:   48 89 04 24             mov    %rax,(%rsp)
  1e:   eb 0a                   jmp    0x2a
  20:   48 83 c3 08             add    $0x8,%rbx
  24:   48 39 1c 24             cmp    %rbx,(%rsp)
  28:   74 4e                   je     0x78
  2a:*  4c 8b 3b                mov    (%rbx),%r15              <-- trapping instruction
  2d:   4d 85 ff                test   %r15,%r15
  30:   74 ee                   je     0x20
  32:   49 8b 45 10             mov    0x10(%r13),%rax
  36:   48 8b 00                mov    (%rax),%rax
  39:   49 39 07                cmp    %rax,(%r15)
  3c:   75 e2                   jne    0x20
  3e:   49                      rex.WB
  3f:   8b                      .byte 0x8b

Code starting with the faulting instruction
===========================================
   0:   4c 8b 3b                mov    (%rbx),%r15
   3:   4d 85 ff                test   %r15,%r15
   6:   74 ee                   je     0xfffffffffffffff6
   8:   49 8b 45 10             mov    0x10(%r13),%rax
   c:   48 8b 00                mov    (%rax),%rax
   f:   49 39 07                cmp    %rax,(%r15)
  12:   75 e2                   jne    0xfffffffffffffff6
  14:   49                      rex.WB
  15:   8b                      .byte 0x8b
RSP: 0018:ffffb43981457ca8 EFLAGS: 00010202
RAX: ffffffff8e6333e0 RBX: ffffffff8e6333d0 RCX: 00000000000002cd
RDX: ffff942b4b0bd000 RSI: 000000000000006e RDI: ffff942b42f9cc30
RBP: ffff942b42f9cc30 R08: ffffffff8e6333d0 R09: 63696c6f626d7973
R10: 735f746e6972705f R11: 2863696c6f626d79 R12: 0000000000000000
R13: ffffffff8de44880 R14: ffffffff8de44516 R15: ffffffff8de44515
FS:  00007f556c562740(0000) GS:ffff942cbdfc0000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: ffffffff8e6333d0 CR3: 000000010a1d0006 CR4: 0000000000170ef0
Call Trace:
<TASK>
? __die (arch/x86/kernel/dumpstack.c:421 arch/x86/kernel/dumpstack.c:434)
? page_fault_oops (arch/x86/mm/fault.c:715)
? search_module_extables (kernel/module/main.c:3280)
? search_bpf_extables (kernel/bpf/core.c:799)
? exc_page_fault (arch/x86/mm/fault.c:1198 arch/x86/mm/fault.c:1479 arch/x86/mm/fault.c:1539)
? asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)
? f_show (kernel/trace/trace_events.c:1601 kernel/trace/trace_events.c:1651 kernel/trace/trace_events.c:1689)
? f_show (kernel/trace/trace_events.c:1623 kernel/trace/trace_events.c:1689)
seq_read_iter (fs/seq_file.c:273)
seq_read (fs/seq_file.c:163)
vfs_read (fs/read_write.c:474)
? __handle_mm_fault (mm/memory.c:3945 mm/memory.c:5521 mm/memory.c:5664)
ksys_read (fs/read_write.c:619)
do_syscall_64 (arch/x86/entry/common.c:52 (discriminator 1) arch/x86/entry/common.c:83 (discriminator 1))
? handle_mm_fault (mm/memory.c:5744 (discriminator 1) mm/memory.c:5840 (discriminator 1))
? exc_page_fault (arch/x86/mm/fault.c:1342 arch/x86/mm/fault.c:1481 arch/x86/mm/fault.c:1539)
? irqentry_exit_to_user_mode (arch/x86/include/asm/entry-common.h:57 (discriminator 1) include/linux/entry-common.h:330 (discriminator 1) kernel/entry/common.c:231 (discriminator 1))
entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:130)
RIP: 0033:0x7f556c65ca5d
Code: 31 c0 e9 c6 fe ff ff 50 48 8d 3d a6 60 0a 00 e8 a9 08 02 00 66 0f 1f 84 00 00 00 00 00 80 3d 81 3b 0e 00 00 74 17 31 c0 0f 05 <48> 3d 00 f0 ff ff 77 5b c3 66 2e 0f 1f 84 00 00 00 00 00 48 83 ec
All code
========
   0:   31 c0                   xor    %eax,%eax
   2:   e9 c6 fe ff ff          jmp    0xfffffffffffffecd
   7:   50                      push   %rax
   8:   48 8d 3d a6 60 0a 00    lea    0xa60a6(%rip),%rdi        # 0xa60b5
   f:   e8 a9 08 02 00          call   0x208bd
  14:   66 0f 1f 84 00 00 00    nopw   0x0(%rax,%rax,1)
  1b:   00 00
  1d:   80 3d 81 3b 0e 00 00    cmpb   $0x0,0xe3b81(%rip)        # 0xe3ba5
  24:   74 17                   je     0x3d
  26:   31 c0                   xor    %eax,%eax
  28:   0f 05                   syscall
  2a:*  48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax         <-- trapping instruction
  30:   77 5b                   ja     0x8d
  32:   c3                      ret
  33:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
  3a:   00 00 00
  3d:   48                      rex.W
  3e:   83                      .byte 0x83 
  3f:   ec                      in     (%dx),%al

Code starting with the faulting instruction
===========================================
   0:   48 3d 00 f0 ff ff       cmp    $0xfffffffffffff000,%rax
   6:   77 5b                   ja     0x63
   8:   c3                      ret
   9:   66 2e 0f 1f 84 00 00    cs nopw 0x0(%rax,%rax,1)
  10:   00 00 00
  13:   48                      rex.W
  14:   83                      .byte 0x83 
  15:   ec                      in     (%dx),%al
RSP: 002b:00007ffc88ecb878 EFLAGS: 00000246 ORIG_RAX: 0000000000000000
RAX: ffffffffffffffda RBX: 0000000000020000 RCX: 00007f556c65ca5d
RDX: 0000000000020000 RSI: 00007f556c541000 RDI: 0000000000000003
RBP: 0000000000020000 R08: 00000000ffffffff R09: 0000000000000000
R10: 0000000000000022 R11: 0000000000000246 R12: 00007f556c541000
R13: 0000000000000003 R14: 0000000000020000 R15: 0000000000000000
</TASK>
Modules linked in: snd_hda_intel snd_intel_dspcfg snd_intel_sdw_acpi snd_hda_codec snd_hwdep snd_hda_core
CR2: ffffffff8e6333d0
---[ end trace 0000000000000000 ]---

-- Steve

