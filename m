Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1F653FB42E
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Aug 2021 12:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236406AbhH3LAE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 30 Aug 2021 07:00:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236373AbhH3LAE (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 30 Aug 2021 07:00:04 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D768DC06175F
        for <linux-wireless@vger.kernel.org>; Mon, 30 Aug 2021 03:59:10 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id q39so19175483oiw.12
        for <linux-wireless@vger.kernel.org>; Mon, 30 Aug 2021 03:59:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=w4Hz/ZMyuafdfis83n6BFQ2A0W205yMbTmpiuLeGkpE=;
        b=r4ViFxvlcDTc4M++mEKQRIIrlZ9ZkJpXAvd+5sn2ts8/9iII4j1kDpRNVE84qe0Gbc
         D2QRcx7woJiDoJHq0JprDLoRZfEp7HbfwrrXBFIWumkfeIZnFUd5Lv6249KAT451a/F6
         1pdfklrGFIyTNq0RgXBDUSHXdkW9gu9zdFAD9NUEX/v07LpAvaePuamO2HfmR1toDB8+
         SPrJMAp7PUNYkOjXJTZ14ld2LI2g0ZbxpmZG1/+2z9sZS+Uv7ajYzOL/FsmqVBvc5f46
         aUdi/0bmjHqAxYsuwsKVAVTST+nGSSaMLfyVeub8VQKKN/ZVBucs8stNtFoKWBYfUXWm
         L8Mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=w4Hz/ZMyuafdfis83n6BFQ2A0W205yMbTmpiuLeGkpE=;
        b=KbdaEqcbFYVKTzfCDdjC3YFREcHESf5xwQVNuuoD9CD59e3WM6J3yt2FkMBZZ6/Fj3
         6W/BJnmGoOzThDRLoEBF0wxI67fp6tinix17HYoBh9Qi/PqhAebPvOZItMXTG6NkpLho
         639lAEELOaa6v6YyHdwpO45QxqvGNEhKHxzmSBRuja4m7MS5aCD5mLUHTw67b1ek9KZR
         UW3t5tvwqEsIvUNSarPKuzRj+MmkofyNr9VnlpHPLu9JWPp2B5YS1lRusXP8aXFgqYNh
         umxizWRV/tJTEVARb9A3QZfg6L2z+93DGhi9S54n50+aT4N6kx9TqYzoeBcHLmfTOMHY
         kaow==
X-Gm-Message-State: AOAM531ESGOrFE9pUq0nnC9HI4tUm1sGf3UEt5aGsyFUbEQgDNbIiwT1
        YO2pAtkZOyM6e5Rt47vcF57qbWHc6EY73jDW12FZYA==
X-Google-Smtp-Source: ABdhPJzCCUQEn0BDbQH2wrxBgV4pmX60dqBj7RoFLZd1e3XjyzvMzteLd59si+CFl4hKUjcSXQzuTmw7YrwLhKDePso=
X-Received: by 2002:a54:4005:: with SMTP id x5mr22724083oie.160.1630321149764;
 Mon, 30 Aug 2021 03:59:09 -0700 (PDT)
MIME-Version: 1.0
References: <000000000000eaacf005ca975d1a@google.com>
In-Reply-To: <000000000000eaacf005ca975d1a@google.com>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Mon, 30 Aug 2021 12:58:58 +0200
Message-ID: <CACT4Y+Y=hu-pED9Qb9_k3-YoisMkZi_-BQ3JOhuOcQHRJLa25g@mail.gmail.com>
Subject: Re: [syzbot] INFO: rcu detected stall in syscall_exit_to_user_mode
To:     syzbot <syzbot+0e964fad69a9c462bc1e@syzkaller.appspotmail.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        Aleksandr Nogikh <nogikh@google.com>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>
Cc:     bp@alien8.de, hpa@zytor.com, jirislaby@kernel.org,
        jpoimboe@redhat.com, jthierry@redhat.com,
        linux-kernel@vger.kernel.org, mingo@redhat.com,
        peterz@infradead.org, syzkaller-bugs@googlegroups.com,
        tglx@linutronix.de, x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 28 Aug 2021 at 06:52, syzbot
<syzbot+0e964fad69a9c462bc1e@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following issue on:
>
> HEAD commit:    d5ae8d7f85b7 Revert "media: dvb header files: move some he..
> git tree:       upstream
> console output: https://syzkaller.appspot.com/x/log.txt?x=1138c9ad300000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=765eea9a273a8879
> dashboard link: https://syzkaller.appspot.com/bug?extid=0e964fad69a9c462bc1e
> compiler:       gcc (Debian 10.2.1-6) 10.2.1 20210110, GNU ld (GNU Binutils for Debian) 2.35.1
>
> Unfortunately, I don't have any reproducer for this issue yet.
>
> IMPORTANT: if you fix the issue, please add the following tag to the commit:
> Reported-by: syzbot+0e964fad69a9c462bc1e@syzkaller.appspotmail.com

It seems that lots of these stalls actually happen in invoke_softirq()
-> mac80211_hwsim_beacon().
See https://github.com/google/syzkaller/issues/2732 for examples, also
the issue to attribute it properly in future.
+drivers/net/wireless/mac80211_hwsim.c maintainers


> rcu: INFO: rcu_preempt self-detected stall on CPU
> rcu:    1-...!: (1 GPs behind) idle=70e/1/0x4000000000000000 softirq=60586/60587 fqs=2492
>         (t=10501 jiffies g=90689 q=3510)
> rcu: rcu_preempt kthread starved for 5495 jiffies! g90689 f0x0 RCU_GP_WAIT_FQS(5) ->state=0x0 ->cpu=0
> rcu:    Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
> rcu: RCU grace-period kthread stack dump:
> task:rcu_preempt     state:R  running task     stack:28864 pid:   14 ppid:     2 flags:0x00004000
> Call Trace:
>  context_switch kernel/sched/core.c:4681 [inline]
>  __schedule+0x93a/0x26f0 kernel/sched/core.c:5938
>  schedule+0xd3/0x270 kernel/sched/core.c:6017
>  schedule_timeout+0x14a/0x2a0 kernel/time/timer.c:1881
>  rcu_gp_fqs_loop kernel/rcu/tree.c:1996 [inline]
>  rcu_gp_kthread+0xd34/0x1980 kernel/rcu/tree.c:2169
>  kthread+0x3e5/0x4d0 kernel/kthread.c:319
>  ret_from_fork+0x1f/0x30 arch/x86/entry/entry_64.S:295
> rcu: Stack dump where RCU GP kthread last ran:
> Sending NMI from CPU 1 to CPUs 0:
> NMI backtrace for cpu 0
> CPU: 0 PID: 10491 Comm: syz-executor.3 Not tainted 5.14.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> RIP: 0010:unwind_next_frame+0x829/0x1ce0 arch/x86/kernel/unwind_orc.c:466
> Code: 83 e0 07 40 38 c6 40 0f 9e c7 40 84 f6 0f 95 c0 40 84 c7 0f 85 bc 0f 00 00 49 0f bf 30 48 01 d6 48 89 74 24 60 e9 d8 fd ff ff <48> b8 00 00 00 00 00 fc ff df 48 8b 54 24 08 48 c1 ea 03 80 3c 02
> RSP: 0018:ffffc90000007698 EFLAGS: 00000297
> RAX: 0000000000000005 RBX: 1ffff92000000edb RCX: ffffffff8e5a56dd
> RDX: 0000000000000005 RSI: 0000000000000001 RDI: 0000000000000001
> RBP: 0000000000000002 R08: ffffffff8e5a56d8 R09: ffffffff8e5a56a8
> R10: fffff52000000ef9 R11: 0000000000086088 R12: ffffc900000077b8
> R13: ffffc900000077a5 R14: ffffc90000007770 R15: ffffffff8e5a56dc
> FS:  0000000000000000(0000) GS:ffff8880b9c00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000c01b7ba1b0 CR3: 0000000014fb2000 CR4: 00000000001526f0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>  <IRQ>
>  arch_stack_walk+0x7d/0xe0 arch/x86/kernel/stacktrace.c:25
>  stack_trace_save+0x8c/0xc0 kernel/stacktrace.c:121
>  kasan_save_stack+0x1b/0x40 mm/kasan/common.c:38
>  kasan_set_track mm/kasan/common.c:46 [inline]
>  set_alloc_info mm/kasan/common.c:434 [inline]
>  __kasan_slab_alloc+0x83/0xb0 mm/kasan/common.c:467
>  kasan_slab_alloc include/linux/kasan.h:254 [inline]
>  slab_post_alloc_hook mm/slab.h:519 [inline]
>  slab_alloc_node mm/slub.c:2959 [inline]
>  kmem_cache_alloc_node+0x266/0x3e0 mm/slub.c:2995
>  __alloc_skb+0x20b/0x340 net/core/skbuff.c:414
>  skb_copy+0x137/0x2f0 net/core/skbuff.c:1581
>  mac80211_hwsim_tx_frame_no_nl.isra.0+0xb17/0x1330 drivers/net/wireless/mac80211_hwsim.c:1565
>  mac80211_hwsim_tx_frame+0x1ee/0x2a0 drivers/net/wireless/mac80211_hwsim.c:1784
>  mac80211_hwsim_beacon_tx+0x49b/0x930 drivers/net/wireless/mac80211_hwsim.c:1838
>  __iterate_interfaces+0x1e5/0x520 net/mac80211/util.c:793
>  ieee80211_iterate_active_interfaces_atomic+0x70/0x180 net/mac80211/util.c:829
>  mac80211_hwsim_beacon+0xd5/0x1a0 drivers/net/wireless/mac80211_hwsim.c:1861
>  __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
>  __hrtimer_run_queues+0x609/0xe50 kernel/time/hrtimer.c:1601
>  hrtimer_run_softirq+0x17b/0x360 kernel/time/hrtimer.c:1618
>  __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
>  invoke_softirq kernel/softirq.c:432 [inline]
>  __irq_exit_rcu+0x16e/0x1c0 kernel/softirq.c:636
>  irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
>  sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1100
>  </IRQ>
>  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
> RIP: 0010:__page_mapcount+0x2/0x350 mm/util.c:716
> Code: 89 e7 e8 31 cf 17 00 e9 10 fe ff ff e8 27 cf 17 00 e9 74 fe ff ff e8 1d cf 17 00 e9 3c fe ff ff 0f 1f 84 00 00 00 00 00 41 56 <41> 55 41 54 55 48 89 fd 4c 8d 65 30 53 e8 ec 94 d1 ff be 04 00 00
> RSP: 0018:ffffc900180177a0 EFLAGS: 00000293
> RAX: 0000000000000000 RBX: 0000000000000001 RCX: 0000000000000000
> RDX: ffff88807d149c40 RSI: ffffffff81aa23f5 RDI: ffffea0001deaa80
> RBP: ffffea0001deaa80 R08: 0000000000000000 R09: 0000000000000000
> R10: ffffffff81aa28ae R11: 0000000000000000 R12: ffffea0001deaa88
> R13: 0000000000000001 R14: dffffc0000000000 R15: 0000000000aab000
>  page_mapcount include/linux/mm.h:875 [inline]
>  zap_pte_range mm/memory.c:1363 [inline]
>  zap_pmd_range mm/memory.c:1481 [inline]
>  zap_pud_range mm/memory.c:1510 [inline]
>  zap_p4d_range mm/memory.c:1531 [inline]
>  unmap_page_range+0xf1d/0x2a10 mm/memory.c:1552
>  unmap_single_vma+0x198/0x300 mm/memory.c:1597
>  unmap_vmas+0x16d/0x2f0 mm/memory.c:1629
>  exit_mmap+0x1d0/0x620 mm/mmap.c:3201
>  __mmput+0x122/0x470 kernel/fork.c:1101
>  mmput+0x58/0x60 kernel/fork.c:1122
>  exit_mm kernel/exit.c:501 [inline]
>  do_exit+0xae2/0x2a60 kernel/exit.c:812
>  do_group_exit+0x125/0x310 kernel/exit.c:922
>  get_signal+0x47f/0x2160 kernel/signal.c:2808
>  arch_do_signal_or_restart+0x2a9/0x1c40 arch/x86/kernel/signal.c:865
>  handle_signal_work kernel/entry/common.c:148 [inline]
>  exit_to_user_mode_loop kernel/entry/common.c:172 [inline]
>  exit_to_user_mode_prepare+0x17d/0x290 kernel/entry/common.c:209
>  __syscall_exit_to_user_mode_work kernel/entry/common.c:291 [inline]
>  syscall_exit_to_user_mode+0x19/0x60 kernel/entry/common.c:302
>  do_syscall_64+0x42/0xb0 arch/x86/entry/common.c:86
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x4665e9
> Code: Unable to access opcode bytes at RIP 0x4665bf.
> RSP: 002b:00007f1283537218 EFLAGS: 00000246 ORIG_RAX: 00000000000000ca
> RAX: fffffffffffffe00 RBX: 000000000056bf88 RCX: 00000000004665e9
> RDX: 0000000000000000 RSI: 0000000000000080 RDI: 000000000056bf88
> RBP: 000000000056bf80 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf8c
> R13: 0000000000a9fb1f R14: 00007f1283537300 R15: 0000000000022000
> NMI backtrace for cpu 1
> CPU: 1 PID: 4075 Comm: syz-executor.4 Not tainted 5.14.0-rc7-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:88 [inline]
>  dump_stack_lvl+0xcd/0x134 lib/dump_stack.c:105
>  nmi_cpu_backtrace.cold+0x44/0xd7 lib/nmi_backtrace.c:105
>  nmi_trigger_cpumask_backtrace+0x1b3/0x230 lib/nmi_backtrace.c:62
>  trigger_single_cpu_backtrace include/linux/nmi.h:164 [inline]
>  rcu_dump_cpu_stacks+0x25e/0x3f0 kernel/rcu/tree_stall.h:342
>  print_cpu_stall kernel/rcu/tree_stall.h:625 [inline]
>  check_cpu_stall kernel/rcu/tree_stall.h:700 [inline]
>  rcu_pending kernel/rcu/tree.c:3922 [inline]
>  rcu_sched_clock_irq.cold+0x9f/0x747 kernel/rcu/tree.c:2641
>  update_process_times+0x16d/0x200 kernel/time/timer.c:1785
>  tick_sched_handle+0x9b/0x180 kernel/time/tick-sched.c:226
>  tick_sched_timer+0x1b0/0x2d0 kernel/time/tick-sched.c:1421
>  __run_hrtimer kernel/time/hrtimer.c:1537 [inline]
>  __hrtimer_run_queues+0x1c0/0xe50 kernel/time/hrtimer.c:1601
>  hrtimer_interrupt+0x330/0xa00 kernel/time/hrtimer.c:1663
>  local_apic_timer_interrupt arch/x86/kernel/apic/apic.c:1089 [inline]
>  __sysvec_apic_timer_interrupt+0x146/0x530 arch/x86/kernel/apic/apic.c:1106
>  sysvec_apic_timer_interrupt+0x40/0xc0 arch/x86/kernel/apic/apic.c:1100
>  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
> RIP: 0010:__raw_spin_unlock_irqrestore include/linux/spinlock_api_smp.h:161 [inline]
> RIP: 0010:_raw_spin_unlock_irqrestore+0x38/0x70 kernel/locking/spinlock.c:191
> Code: 74 24 10 e8 9a fa 2d f8 48 89 ef e8 42 70 2e f8 81 e3 00 02 00 00 75 25 9c 58 f6 c4 02 75 2d 48 85 db 74 01 fb bf 01 00 00 00 <e8> 03 4e 22 f8 65 8b 05 ec c8 d4 76 85 c0 74 0a 5b 5d c3 e8 e0 aa
> RSP: 0018:ffffc90000dc0c08 EFLAGS: 00000206
> RAX: 0000000000000002 RBX: 0000000000000200 RCX: 1ffffffff1fa4e6a
> RDX: 0000000000000000 RSI: 0000000000000102 RDI: 0000000000000001
> RBP: ffff8880b9d40280 R08: 0000000000000001 R09: ffffffff8fcd59bf
> R10: 0000000000000001 R11: 0000000000000000 R12: 000000010000c10b
> R13: ffff8880b9d40280 R14: 0000000000000000 R15: 00000000ffffffff
>  __mod_timer+0x837/0xe30 kernel/time/timer.c:1065
>  call_timer_fn+0x1a5/0x6b0 kernel/time/timer.c:1421
>  expire_timers kernel/time/timer.c:1466 [inline]
>  __run_timers.part.0+0x675/0xa20 kernel/time/timer.c:1734
>  __run_timers kernel/time/timer.c:1715 [inline]
>  run_timer_softirq+0xb3/0x1d0 kernel/time/timer.c:1747
>  __do_softirq+0x29b/0x9c2 kernel/softirq.c:558
>  invoke_softirq kernel/softirq.c:432 [inline]
>  __irq_exit_rcu+0x16e/0x1c0 kernel/softirq.c:636
>  irq_exit_rcu+0x5/0x20 kernel/softirq.c:648
>  sysvec_apic_timer_interrupt+0x93/0xc0 arch/x86/kernel/apic/apic.c:1100
>  </IRQ>
>  asm_sysvec_apic_timer_interrupt+0x12/0x20 arch/x86/include/asm/idtentry.h:638
> RIP: 0010:finish_task_switch.isra.0+0x23c/0xa50 kernel/sched/core.c:4555
> Code: 8b 3a 4c 89 e7 48 c7 02 00 00 00 00 ff d1 4d 85 ff 75 bf 4c 89 e7 e8 23 3c dd 07 e8 fe e7 2b 00 fb 65 48 8b 1c 25 40 f0 01 00 <48> 8d bb 10 15 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1
> RSP: 0018:ffffc90003ae7810 EFLAGS: 00000202
> RAX: 00000000000003cd RBX: ffff888030a13880 RCX: 1ffffffff1f9c5a2
> RDX: 0000000000000000 RSI: 0000000000000001 RDI: 0000000000000000
> RBP: ffffc90003ae7850 R08: 0000000000000001 R09: ffffffff8fcd5907
> R10: 0000000000000001 R11: 0000000000000000 R12: ffff8880b9d51b00
> R13: ffff88801f1c1c40 R14: 0000000000000000 R15: ffff8880b9d51b18
>  context_switch kernel/sched/core.c:4684 [inline]
>  __schedule+0x942/0x26f0 kernel/sched/core.c:5938
>  preempt_schedule_common+0x45/0xc0 kernel/sched/core.c:6098
>  preempt_schedule_thunk+0x16/0x18 arch/x86/entry/thunk_64.S:35
>  put_cpu_partial+0x1a1/0x230 mm/slub.c:2482
>  qlink_free mm/kasan/quarantine.c:146 [inline]
>  qlist_free_all+0x5a/0xc0 mm/kasan/quarantine.c:165
>  kasan_quarantine_reduce+0x180/0x200 mm/kasan/quarantine.c:272
>  __kasan_slab_alloc+0x95/0xb0 mm/kasan/common.c:444
>  kasan_slab_alloc include/linux/kasan.h:254 [inline]
>  slab_post_alloc_hook mm/slab.h:519 [inline]
>  slab_alloc_node mm/slub.c:2959 [inline]
>  slab_alloc mm/slub.c:2967 [inline]
>  __kmalloc+0x1f4/0x330 mm/slub.c:4111
>  kmalloc include/linux/slab.h:596 [inline]
>  tomoyo_realpath_from_path+0xc3/0x620 security/tomoyo/realpath.c:254
>  tomoyo_realpath_nofollow+0xc8/0xe0 security/tomoyo/realpath.c:309
>  tomoyo_find_next_domain+0x280/0x1f80 security/tomoyo/domain.c:727
>  tomoyo_bprm_check_security security/tomoyo/tomoyo.c:101 [inline]
>  tomoyo_bprm_check_security+0x121/0x1a0 security/tomoyo/tomoyo.c:91
>  security_bprm_check+0x45/0xa0 security/security.c:866
>  search_binary_handler fs/exec.c:1709 [inline]
>  exec_binprm fs/exec.c:1762 [inline]
>  bprm_execve fs/exec.c:1831 [inline]
>  bprm_execve+0x732/0x19b0 fs/exec.c:1793
>  do_execveat_common+0x5e3/0x780 fs/exec.c:1920
>  do_execve fs/exec.c:1988 [inline]
>  __do_sys_execve fs/exec.c:2064 [inline]
>  __se_sys_execve fs/exec.c:2059 [inline]
>  __x64_sys_execve+0x8f/0xc0 fs/exec.c:2059
>  do_syscall_x64 arch/x86/entry/common.c:50 [inline]
>  do_syscall_64+0x35/0xb0 arch/x86/entry/common.c:80
>  entry_SYSCALL_64_after_hwframe+0x44/0xae
> RIP: 0033:0x4665e9
> Code: ff ff c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 bc ff ff ff f7 d8 64 89 01 48
> RSP: 002b:00007fc2fc6a3188 EFLAGS: 00000246 ORIG_RAX: 000000000000003b
> RAX: ffffffffffffffda RBX: 000000000056bf80 RCX: 00000000004665e9
> RDX: 0000000000000000 RSI: 0000000000000000 RDI: 0000000020000180
> RBP: 00000000004bfcc4 R08: 0000000000000000 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000246 R12: 000000000056bf80
> R13: 0000000000a9fb1f R14: 00007fc2fc6a3300 R15: 0000000000022000
> ----------------
> Code disassembly (best guess):
>    0:   83 e0 07                and    $0x7,%eax
>    3:   40 38 c6                cmp    %al,%sil
>    6:   40 0f 9e c7             setle  %dil
>    a:   40 84 f6                test   %sil,%sil
>    d:   0f 95 c0                setne  %al
>   10:   40 84 c7                test   %al,%dil
>   13:   0f 85 bc 0f 00 00       jne    0xfd5
>   19:   49 0f bf 30             movswq (%r8),%rsi
>   1d:   48 01 d6                add    %rdx,%rsi
>   20:   48 89 74 24 60          mov    %rsi,0x60(%rsp)
>   25:   e9 d8 fd ff ff          jmpq   0xfffffe02
> * 2a:   48 b8 00 00 00 00 00    movabs $0xdffffc0000000000,%rax <-- trapping instruction
>   31:   fc ff df
>   34:   48 8b 54 24 08          mov    0x8(%rsp),%rdx
>   39:   48 c1 ea 03             shr    $0x3,%rdx
>   3d:   80                      .byte 0x80
>   3e:   3c 02                   cmp    $0x2,%al
>
>
> ---
> This report is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this issue. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.
>
> --
> You received this message because you are subscribed to the Google Groups "syzkaller-bugs" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to syzkaller-bugs+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/syzkaller-bugs/000000000000eaacf005ca975d1a%40google.com.
