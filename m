Return-Path: <linux-wireless+bounces-11702-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D8249587CF
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 15:24:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B084B2143C
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 13:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1BCB18C91C;
	Tue, 20 Aug 2024 13:24:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UafIhYtp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ua1-f66.google.com (mail-ua1-f66.google.com [209.85.222.66])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76C6518E35F;
	Tue, 20 Aug 2024 13:24:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.66
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724160285; cv=none; b=GwED0c+jo5a5Qd9pyplqkCxUzVZ1U35b9cPBxthIYUV1HO17ocnDjCOYENN9qheqiVEkjHLSI5X26NZslK+pzoZW/WfAT3cbrxSl+vASToX4kUXulRQytZVOgOPzX8mbdErJbMw4bpTaFg1Y7N13WDbh2+6mv9Kt1ytgpbs3q7c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724160285; c=relaxed/simple;
	bh=pbdOxU2XaiHvA5F3EoI7XSroYIY6Y673S2humUWlcYo=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LJ2Mb25I2j2FQKzwTdL/dKAE4JJOc0jUvQg22iyjjM4VmL760bJ1eFRS4K9HzKJ8ebXEN4o+/w+fQ1pK7O8QCTGm1Igkr4fEiWFQkjoJI48P4lNZZ2dWak/PpMFi4QkRkqAHUFVEdNZCpp9UoWkweunRhX5Jkl4iMYZwr19tpdY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UafIhYtp; arc=none smtp.client-ip=209.85.222.66
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ua1-f66.google.com with SMTP id a1e0cc1a2514c-8430e4fb268so1099466241.3;
        Tue, 20 Aug 2024 06:24:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724160282; x=1724765082; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=QykbYYcAVqnGBsjF3taIrnyJhKGEL1mhziUhQX/mMh4=;
        b=UafIhYtp6R7gbmMRnWMOv6/lD+28oF4i2pTUWRLQTf1GGSguxFT2YsYGKWLl3djAJL
         ANaQBI/NNFnbl58Bi69ktubajtQ2uEoN6mPeYNneYqha0Qqkq2iSye+UPgchL14Ii+C7
         EVFKUTIfR29CONBdFl8XiWQNes51o7nmN9pMat6CcVTodYcYAdobLDvjh9G8cl+yHtkB
         sr4vo96+TVv+bt9c1EDjUWKWbPIWzGN9GFV/JDr3EKCN14gwYw2Bqhq5h24URB99B9GA
         FsiWc8TGDdKXI4hQtv9jQtTHy2lucqiqCmG77GYlnqosn55Eu4I0KSklo8N1eaxZ+EqG
         1LNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724160282; x=1724765082;
        h=cc:to:subject:message-id:date:from:mime-version:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QykbYYcAVqnGBsjF3taIrnyJhKGEL1mhziUhQX/mMh4=;
        b=nH7hrKuA0kqjCIboRC01SK16UEoHnAaqDvLf/kKEHD8G17lfZH7KZjh02Nb52rHTFZ
         +o8ST6lRW2LrTN5bGCaB4a4qgcOmIOIQ8zOR32QRPXLHOQvffAH4mZGQf5a6i2aJk/Cj
         8GKzHkGEtx8hP78TdCHtWGlz2ssggDqPpDLB75YPE8GFPZQ3lqo4uJvR8oYLfwTuIDYJ
         BZQofY2JgsO3266hZmcIEuYnBBULT0Q9+3VT8WyqmmVCI5qvh9cmB5ZOk2vp16E26V47
         3tCUfrl0A7drNF6OonHch7flgsWaIJVOvY/JpmZoDu3+G72WAziIN/uCktgquRibAAyc
         hRwQ==
X-Forwarded-Encrypted: i=1; AJvYcCUeSqm9MNvJ9hQ8kfECiSnDZdBh5e237YZSDgHbAdAtICCj52RgI3YmYTjnWVOGVcreQd4bbHvsq9N48M0=@vger.kernel.org, AJvYcCVTL0uSiDj7xZ/O/qCYik/IkrLDvSreDHXW9KnpNHvr4tbP1UognZgZNqdXAAFc2UgHHnYNI5G2WY4HRX+o+TI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyg1SVizToHqmatGQfU9RyN3jgN5goGnZj3YuXq7A6fXrPsgBvJ
	s9TDXo8c0fe72NMdUV7DM6W+JgVTWHn1TiQrVYjg1tpCKUkvTH53aILZLK6MB/YZxLiKmUxAgCn
	OwcqNVy+aRju21mARk8Vh+5q/SPE=
X-Google-Smtp-Source: AGHT+IGjT/2vJi9HBgHm2OYN7hNHA66frcDq1rIitprtMqHnVeilHgGmYmxlxKCXIsONXgiF7J2WSo/a03S883280Fc=
X-Received: by 2002:a05:6122:3128:b0:4f2:ec14:3b6 with SMTP id
 71dfb90a1353d-4fc6c5f6bf7mr12645284e0c.6.1724160282001; Tue, 20 Aug 2024
 06:24:42 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Hui Guo <guohui.study@gmail.com>
Date: Tue, 20 Aug 2024 21:24:30 +0800
Message-ID: <CAHOo4gK2p38mHL93ctqxF-8m3WqzL0oGTSE=b+m08m9V22znrw@mail.gmail.com>
Subject: INFO: rcu detected stall in x64_sys_call
To: Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, 
	Will Deacon <will@kernel.org>, Waiman Long <longman@redhat.com>, Boqun Feng <boqun.feng@gmail.com>, 
	linux-kernel@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Kalle Valo <kvalo@kernel.org>, linux-wireless@vger.kernel.org, 
	Juri Lelli <juri.lelli@redhat.com>, Vincent Guittot <vincent.guittot@linaro.org>, 
	Dietmar Eggemann <dietmar.eggemann@arm.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>, 
	Valentin Schneider <vschneid@redhat.com>
Cc: syzkaller-bugs@googlegroups.com
Content-Type: text/plain; charset="UTF-8"

Hi Kernel Maintainers,
Our tool found the following kernel bug "INFO: rcu detected stall in
x64_sys_call"

HEAD Commit: 6b0f8db921abf0520081d779876d3a41069dab95 Merge tag
'execve-v6.11-rc4' of
git://git.kernel.org/pub/scm/linux/kernel/git/kees/linux

console output:
https://github.com/androidAppGuard/KernelBugs/blob/main/6b0f8db921abf0520081d779876d3a41069dab95/51cc94811ebd073cf5874f118692256ef1eadf90/repro.log

kernel config: https://github.com/androidAppGuard/KernelBugs/blob/main/6b0f8db921abf0520081d779876d3a41069dab95/.config

syz repro: https://github.com/androidAppGuard/KernelBugs/blob/main/6b0f8db921abf0520081d779876d3a41069dab95/51cc94811ebd073cf5874f118692256ef1eadf90/repro.prog

C reproducer: https://github.com/androidAppGuard/KernelBugs/blob/main/6b0f8db921abf0520081d779876d3a41069dab95/51cc94811ebd073cf5874f118692256ef1eadf90/repro.cprog

Please let me know if there is anything I can help.

Best,

Hui Guo

====================================[cut
here]===========================================
rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:

rcu: Tasks blocked on level-0 rcu_node (CPUs 0-1): P8894/1:b..l P47/1:b..l

rcu: (detected by 1, t=10502 jiffies, g=11937, q=81 ncpus=2)

task:kworker/1:1     state:R  running task     stack:25680 pid:47
tgid:47    ppid:2      flags:0x00004000

Workqueue: events request_firmware_work_func

Call Trace:

 <TASK>

 context_switch
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:5188
[inline]

 __schedule+0xc3f/0x5390
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6529

 preempt_schedule_common+0x44/0xb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6708

 preempt_schedule_thunk+0x1a/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/thunk.S:12

 unwind_next_frame+0x1108/0x2220
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/unwind_orc.c:672

 arch_stack_walk+0xe6/0x160
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/stacktrace.c:25

 stack_trace_save+0x8f/0xc0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/stacktrace.c:122

 save_stack+0x153/0x1e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_owner.c:156

 __reset_page_owner+0x8d/0x400
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_owner.c:297

 reset_page_owner
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/page_owner.h:25
[inline]

 free_pages_prepare
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:1094
[inline]

 free_unref_page+0x655/0xe40
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/page_alloc.c:2612

 qlink_free data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/quarantine.c:163
[inline]

 qlist_free_all+0x50/0x150
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/quarantine.c:179

 kasan_quarantine_reduce+0x192/0x1e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/quarantine.c:286

 __kasan_slab_alloc+0x67/0x90
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/common.c:322

 kasan_slab_alloc
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/kasan.h:201
[inline]

 slab_post_alloc_hook
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/slub.c:3988
[inline]

 slab_alloc_node
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/slub.c:4037
[inline]

 __kmalloc_cache_noprof+0x121/0x320
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/slub.c:4184

 kmalloc_noprof
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/slab.h:681
[inline]

 dummy_urb_enqueue+0x8d/0x920
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/usb/gadget/udc/dummy_hcd.c:1271

 usb_hcd_submit_urb+0x2be/0x2170
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/usb/core/hcd.c:1533

 usb_submit_urb+0x86b/0x1730
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/usb/core/urb.c:581

 ath9k_hif_usb_alloc_reg_in_urbs
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/wireless/ath/ath9k/hif_usb.c:1010
[inline]

 ath9k_hif_usb_alloc_urbs+0xad2/0x1060
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/wireless/ath/ath9k/hif_usb.c:1050

 ath9k_hif_usb_dev_init
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/wireless/ath/ath9k/hif_usb.c:1136
[inline]

 ath9k_hif_usb_firmware_cb+0x146/0x620
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/wireless/ath/ath9k/hif_usb.c:1269

 request_firmware_work_func+0x133/0x240
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/base/firmware_loader/main.c:1167

 process_one_work+0x95a/0x1ad0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3231

 process_scheduled_works
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3312
[inline]

 worker_thread+0x680/0xeb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/workqueue.c:3390

 kthread+0x2ca/0x3b0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/kthread.c:389

 ret_from_fork+0x48/0x80
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/process.c:147

 ret_from_fork_asm+0x1a/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/entry_64.S:244

 </TASK>

task:syz-executor356 state:R  running task     stack:27696 pid:8894
tgid:8894  ppid:8369   flags:0x00004002

Call Trace:

 <TASK>

 context_switch
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:5188
[inline]

 __schedule+0xc3f/0x5390
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6529

 preempt_schedule_irq+0x51/0x90
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6851

 irqentry_exit+0x36/0x90
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/entry/common.c:354

 asm_sysvec_apic_timer_interrupt+0x1a/0x20
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./arch/x86/include/asm/idtentry.h:702

RIP: 0010:lock_acquire+0x1f8/0x590
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/lockdep.c:5727

Code: f6 99 7e 83 f8 01 0f 85 09 03 00 00 9c 58 f6 c4 02 0f 85 f4 02
00 00 48 83 7c 24 08 00 74 01 fb 48 b8 00 00 00 00 00 fc ff df <48> 01
c3 48 c7 03 00 00 00 00 48 c7 43 08 00 00 00 00 48 8b 84 24

RSP: 0018:ffffc9000d6f7508 EFLAGS: 00000206

RAX: dffffc0000000000 RBX: 1ffff92001adeea4 RCX: 1ffff92001adee89

RDX: 1ffff11008f1a51b RSI: 0000000000000000 RDI: 0000000000000000

RBP: 0000000000000000 R08: 0000000000000000 R09: fffffbfff28714d8

R10: ffffffff9438a6c7 R11: 0000000000000000 R12: 0000000000000002

R13: 0000000000000000 R14: ffffffff8dbb8d60 R15: 0000000000000000

 rcu_lock_acquire
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/rcupdate.h:326
[inline]

 rcu_read_lock data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/rcupdate.h:838
[inline]

 is_bpf_text_address+0x38/0x1a0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./kernel/bpf/core.c:767

 kernel_text_address
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/extable.c:125
[inline]

 kernel_text_address+0x41/0x90
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/extable.c:94

 __kernel_text_address+0xd/0x40
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/extable.c:79

 unwind_get_return_address
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/unwind_orc.c:369
[inline]

 unwind_get_return_address+0x7d/0xe0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/unwind_orc.c:364

 arch_stack_walk+0xa2/0x160
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/stacktrace.c:26

 stack_trace_save+0x8f/0xc0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/stacktrace.c:122

 kasan_save_stack+0x24/0x50
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/common.c:47

 kasan_save_track+0x14/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/common.c:68

 kasan_save_free_info+0x3b/0x60
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/generic.c:579

 poison_slab_object
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/common.c:240
[inline]

 poison_slab_object+0xf9/0x180
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/common.c:211

 __kasan_slab_free+0x33/0x50
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/common.c:256

 kasan_slab_free
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/kasan.h:184
[inline]

 slab_free_hook
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/slub.c:2252
[inline]

 slab_free data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/slub.c:4473
[inline]

 kmem_cache_free+0x12a/0x3a0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/slub.c:4548

 anon_vma_chain_free
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/rmap.c:147
[inline]

 unlink_anon_vmas+0x457/0x890
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/rmap.c:447

 free_pgtables+0xc8/0x8f0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/memory.c:388

 exit_mmap+0x3c7/0xb30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/mmap.c:3423

 __mmput+0x128/0x480
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/fork.c:1345

 mmput+0x60/0x70
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/fork.c:1367

 exit_mm data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/exit.c:571
[inline]

 do_exit+0x9b3/0x2b40
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/exit.c:869

 do_group_exit+0xd3/0x2a0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/exit.c:1031

 __do_sys_exit_group
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/exit.c:1042
[inline]

 __se_sys_exit_group
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/exit.c:1040
[inline]

 __x64_sys_exit_group+0x3e/0x50
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/exit.c:1040

 x64_sys_call+0x1832/0x1840
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./arch/x86/include/generated/asm/syscalls_64.h:232

 do_syscall_x64
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:52
[inline]

 do_syscall_64+0xcb/0x250
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/common.c:83

 entry_SYSCALL_64_after_hwframe+0x77/0x7f

RIP: 0033:0x7fdbb0458421

RSP: 002b:00007ffd20d4abf8 EFLAGS: 00000246 ORIG_RAX: 00000000000000e7

RAX: ffffffffffffffda RBX: 00007fdbb04df270 RCX: 00007fdbb0458421

RDX: 000000000000003c RSI: 00000000000000e7 RDI: 0000000000000000

RBP: 0000000000000000 R08: ffffffffffffffb8 R09: 00382e6364755f79

R10: 0000000000000011 R11: 0000000000000246 R12: 00007fdbb04df270

R13: 0000000000000000 R14: 00007fdbb04e4000 R15: 00007fdbb040c770

 </TASK>

rcu: rcu_preempt kthread starved for 620 jiffies! g11937 f0x0
RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0

rcu: Unless rcu_preempt kthread gets sufficient CPU time, OOM is now
expected behavior.

rcu: RCU grace-period kthread stack dump:

task:rcu_preempt     state:R  running task     stack:27584 pid:17
tgid:17    ppid:2      flags:0x00004000

Call Trace:

 <TASK>

 context_switch
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:5188
[inline]

 __schedule+0xc3f/0x5390
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6529

 __schedule_loop
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6606
[inline]

 schedule+0xe7/0x350
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/sched/core.c:6621

 schedule_timeout+0x128/0x290
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/time/timer.c:2581

 rcu_gp_fqs_loop+0x18f/0xa10
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/rcu/tree.c:2034

 rcu_gp_kthread+0x273/0x370
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/rcu/tree.c:2236

 kthread+0x2ca/0x3b0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/kthread.c:389

 ret_from_fork+0x48/0x80
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/process.c:147

 ret_from_fork_asm+0x1a/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/entry_64.S:244

 </TASK>

rcu: Stack dump where RCU GP kthread last ran:

Sending NMI from CPU 1 to CPUs 0:

NMI backtrace for cpu 0

CPU: 0 UID: 0 PID: 88 Comm: kswapd0 Not tainted
6.11.0-rc3-00013-g6b0f8db921ab #1

Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.15.0-1 04/01/2014

RIP: 0010:unwind_next_frame+0x4eb/0x2220
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/unwind_orc.c:505

Code: 00 00 00 00 fc ff df 4c 89 ea 48 c1 ea 03 0f b6 04 02 4c 89 ea
83 e2 07 38 d0 7f 08 84 c0 0f 85 63 19 00 00 45 0f b6 7c 24 05 <31> ff
41 83 e7 07 44 89 fe e8 c7 0b 4e 00 45 84 ff 0f 84 95 fe ff

RSP: 0018:ffffc90000006e28 EFLAGS: 00000046

RAX: 0000000000000000 RBX: ffffc90000006ea0 RCX: ffffffff813bf384

RDX: 0000000000000005 RSI: ffffffff813c0309 RDI: 0000000000000006

RBP: 0000000000000001 R08: 0000000000000820 R09: 0000000000000000

R10: ffffffff81e72e95 R11: 0000000000000000 R12: ffffffff908d9118

R13: ffffffff908d911d R14: ffffc90000006ed5 R15: 0000000000000002

FS:  0000000000000000(0000) GS:ffff88802c400000(0000) knlGS:0000000000000000

CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033

CR2: 00007fea1e094e84 CR3: 000000001c9a6000 CR4: 0000000000350ef0

Call Trace:

 <NMI>

 </NMI>

 <IRQ>

 arch_stack_walk+0xe6/0x160
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/stacktrace.c:25

 stack_trace_save+0x8f/0xc0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/stacktrace.c:122

 kasan_save_stack+0x24/0x50
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/common.c:47

 kasan_save_track+0x14/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/common.c:68

 poison_kmalloc_redzone
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/common.c:370
[inline]

 __kasan_kmalloc+0xaa/0xb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/common.c:387

 kmalloc_noprof
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/slab.h:681
[inline]

 dummy_urb_enqueue+0x8d/0x920
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/usb/gadget/udc/dummy_hcd.c:1271

 usb_hcd_submit_urb+0x2be/0x2170
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/usb/core/hcd.c:1533

 usb_submit_urb+0x86b/0x1730
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/usb/core/urb.c:581

 ath9k_hif_usb_reg_in_cb+0x493/0x690
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/wireless/ath/ath9k/hif_usb.c:792

 __usb_hcd_giveback_urb+0x38a/0x6d0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/usb/core/hcd.c:1650

 usb_hcd_giveback_urb+0x39b/0x460
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/usb/core/hcd.c:1734

 dummy_timer+0x12e6/0x31f0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/usb/gadget/udc/dummy_hcd.c:1987

 __run_hrtimer data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/time/hrtimer.c:1689
[inline]

 __hrtimer_run_queues+0x212/0xcc0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/time/hrtimer.c:1753

 hrtimer_interrupt+0x320/0x7b0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/time/hrtimer.c:1815

 local_apic_timer_interrupt
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/apic/apic.c:1032
[inline]

 __sysvec_apic_timer_interrupt+0x114/0x460
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/apic/apic.c:1049

 instr_sysvec_apic_timer_interrupt
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/apic/apic.c:1043
[inline]

 sysvec_apic_timer_interrupt+0x45/0xb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/apic/apic.c:1043

 asm_sysvec_apic_timer_interrupt+0x1a/0x20
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./arch/x86/include/asm/idtentry.h:702

RIP: 0010:pv_wait_head_or_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/qspinlock_paravirt.h:430
[inline]

RIP: 0010:__pv_queued_spin_lock_slowpath+0x405/0xc40
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/qspinlock.c:508

Code: ed c6 45 01 01 41 bc 00 80 00 00 4c 8d 74 24 78 48 c1 e9 03 41
83 e5 07 48 b8 00 00 00 00 00 fc ff df 48 8d 1c 01 eb 0c f3 90 <41> 83
ec 01 0f 84 10 05 00 00 b8 00 01 00 00 66 89 44 24 78 0f b6

RSP: 0018:ffffc900000079c0 EFLAGS: 00000206

RAX: 0000000000000003 RBX: fffffbfff1dab7a4 RCX: 1ffffffff1dab7a4

RDX: 0000000000000001 RSI: ffffffff8af70852 RDI: 0000000000000000

RBP: ffffffff8ed5bd20 R08: 0000000000000001 R09: fffffbfff28714e6

R10: 0000000000000001 R11: 0000000000000000 R12: 0000000000006d46

R13: 0000000000000000 R14: ffffc90000007a38 R15: ffff88802c43fc80

 pv_queued_spin_lock_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./arch/x86/include/asm/paravirt.h:584
[inline]

 queued_spin_lock_slowpath
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./arch/x86/include/asm/qspinlock.h:51
[inline]

 queued_spin_lock
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/asm-generic/qspinlock.h:114
[inline]

 do_raw_spin_lock+0x20f/0x2b0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/locking/spinlock_debug.c:116

 spin_lock data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/spinlock.h:351
[inline]

 mac80211_hwsim_tx_frame_no_nl.isra.0+0x6ec/0x1270
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/wireless/virtual/mac80211_hwsim.c:1817

 mac80211_hwsim_tx_frame+0x1ed/0x2a0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/wireless/virtual/mac80211_hwsim.c:2215

 __mac80211_hwsim_beacon_tx
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/wireless/virtual/mac80211_hwsim.c:2232
[inline]

 mac80211_hwsim_beacon_tx+0x56e/0x9e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/wireless/virtual/mac80211_hwsim.c:2315

 __iterate_interfaces+0x2c3/0x5d0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/mac80211/util.c:772

 ieee80211_iterate_active_interfaces_atomic+0x71/0x1b0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/net/mac80211/util.c:808

 mac80211_hwsim_beacon+0x105/0x200
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/drivers/net/wireless/virtual/mac80211_hwsim.c:2345

 __run_hrtimer data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/time/hrtimer.c:1689
[inline]

 __hrtimer_run_queues+0x212/0xcc0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/time/hrtimer.c:1753

 hrtimer_run_softirq+0x17f/0x350
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/time/hrtimer.c:1770

 handle_softirqs+0x1d7/0x870
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/softirq.c:554

 __do_softirq data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/softirq.c:588
[inline]

 invoke_softirq
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/softirq.c:428
[inline]

 __irq_exit_rcu
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/softirq.c:637
[inline]

 irq_exit_rcu+0xbb/0x120
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/softirq.c:649

 instr_sysvec_apic_timer_interrupt
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/apic/apic.c:1043
[inline]

 sysvec_apic_timer_interrupt+0x99/0xb0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/apic/apic.c:1043

 </IRQ>

 <TASK>

 asm_sysvec_apic_timer_interrupt+0x1a/0x20
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./arch/x86/include/asm/idtentry.h:702

RIP: 0010:stack_access_ok+0x13c/0x270
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/unwind_orc.c:394

Code: 3c 24 4c 39 fd 73 8c e8 52 0f 4e 00 48 8b 44 24 08 48 01 e8 49
39 c6 48 89 04 24 0f 83 72 ff ff ff e8 38 0f 4e 00 48 8b 04 24 <41> be
01 00 00 00 49 39 c7 73 a9 e9 59 ff ff ff e8 1f 0f 4e 00 48

RSP: 0018:ffffc90000ec7068 EFLAGS: 00000293

RAX: ffffc90000ec74b8 RBX: ffffc90000ec7128 RCX: ffffffff813bfc66

RDX: ffff888018a70000 RSI: ffffffff813bfd08 RDI: 0000000000000005

RBP: ffffc90000ec74b0 R08: 0000000000000002 R09: 0000000000000000

R10: 0000000000000001 R11: 0000000000000000 R12: ffffc90000ec7130

R13: ffffc90000ec7138 R14: ffffc90000ec0000 R15: ffffc90000ec8000

 deref_stack_reg
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/unwind_orc.c:403
[inline]

 unwind_next_frame+0xd41/0x2220
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/unwind_orc.c:585

 arch_stack_walk+0xe6/0x160
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/stacktrace.c:25

 stack_trace_save+0x8f/0xc0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/stacktrace.c:122

 kasan_save_stack+0x24/0x50
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/common.c:47

 kasan_save_track+0x14/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/common.c:68

 kasan_save_free_info+0x3b/0x60
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/generic.c:579

 poison_slab_object
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/common.c:240
[inline]

 poison_slab_object+0xf9/0x180
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/common.c:211

 __kasan_slab_free+0x33/0x50
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/kasan/common.c:256

 kasan_slab_free
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/./include/linux/kasan.h:184
[inline]

 slab_free_hook
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/slub.c:2252
[inline]

 slab_free data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/slub.c:4473
[inline]

 kmem_cache_free+0x12a/0x3a0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/slub.c:4548

 __merge_or_add_vmap_area
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/vmalloc.c:1401
[inline]

 merge_or_add_vmap_area_augment
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/vmalloc.c:1458
[inline]

 reclaim_list_global.part.0+0x758/0x1760
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/vmalloc.c:2126

 reclaim_list_global
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/vmalloc.c:2121
[inline]

 decay_va_pool_node+0xd22/0x1110
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/vmalloc.c:2187

 vmap_node_shrink_scan+0x43/0x70
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/vmalloc.c:5090

 do_shrink_slab+0x44e/0x1190
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/shrinker.c:435

 shrink_slab+0x18d/0x12e0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/shrinker.c:662

 shrink_one+0x4ad/0x7c0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/vmscan.c:4815

 shrink_many data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/vmscan.c:4876
[inline]

 lru_gen_shrink_node
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/vmscan.c:4954
[inline]

 shrink_node+0x23db/0x3850
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/vmscan.c:5934

 kswapd_shrink_node
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/vmscan.c:6762
[inline]

 balance_pgdat+0xba2/0x1880
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/vmscan.c:6954

 kswapd+0x702/0xd50
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/mm/vmscan.c:7223

 kthread+0x2ca/0x3b0
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/kernel/kthread.c:389

 ret_from_fork+0x48/0x80
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/kernel/process.c:147

 ret_from_fork_asm+0x1a/0x30
data/ghui/docker_data/linux_kernel/upstream/6b0f8db921abf0520081d779876d3a41069dab95/arch/x86/entry/entry_64.S:244

 </TASK>

INFO: NMI handler (nmi_cpu_backtrace_handler) took too long to run: 9.168 msecs

==========================================================================================

This report is generated by reproducing the syz repro. It may contain errors.

