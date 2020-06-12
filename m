Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3D7341F7838
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jun 2020 15:00:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726358AbgFLNAc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 12 Jun 2020 09:00:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726053AbgFLNAb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 12 Jun 2020 09:00:31 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54542C03E96F
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2020 06:00:31 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id d8so3708418plo.12
        for <linux-wireless@vger.kernel.org>; Fri, 12 Jun 2020 06:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qTlS5c0XlIHho1ukeGMzh75bo5sQaeoFpUTTm2uNpzc=;
        b=ft4U1xxFtlbip1IQ4vJGXDICBx5WHS15bbpBG5y7SmanxsV3SWv2M5Qg9H6UrzgKF0
         eXz4RW47QtJWYbufLmVkPBrLLGXIVPtZp/fYH7Rs2rEYVNaZu//LA+sr46+lsdmRtN//
         E7cMRFk5DsxnQF0l0xsGPlNajzxrlwYmsZ7UiRn6PJcjazwA0lPlct0gmeCue6ejDt1E
         MlOYA1hpUQTTNXiXsHGlS//sYxqTWYIjhx/g0mTH4azyCsi4x7EXdeLhwnli5lLvRalP
         I7XkdAecAqsACmxDzIgK+IvuwyISVHZeoL/rlSgZNHA3NGIUsoKEdZl7Gzl5e7vRxzRI
         w4QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qTlS5c0XlIHho1ukeGMzh75bo5sQaeoFpUTTm2uNpzc=;
        b=VleGc2rT7l+gI8CsxgsH5poL2AlekqWcD5S2nSl0MiLfqimo8hVshXMMcHKlv9baAz
         NNyDP8d15C8upJZUbei/xCdYqEby3SNRLC360UZo3Cwativ3qMynLbQAKoRMzCihQC+p
         uGxvfOSTJfJvf2t85GpVZJS3Iav8Un5NZT2KPoCw3eGWaJ0STfZ9HTHq6QuFU+XVH7BE
         8DJQ5hUR5tedP4tuwbpa70mQR0DBtdNKNyn4d/lnT9YB4Ajt33dUYR4NvgRtihJcrB/B
         HrzRATx0/XM+mMb6IaivyrwUn/tgGhTW9FYf2jnvhb0qixzZ4d5uCgdItwB24xeIbsZr
         GUVA==
X-Gm-Message-State: AOAM533t+6/M2rrgb3yZn7ocp2T2Oo6Q31jAyEo5YVUpCXwgMqmAw8/h
        VzOmr9ocGrC4Jiqogp0IB0788GO7kj6pvfhuFWfe1A==
X-Google-Smtp-Source: ABdhPJxLXgEx4GfAJqfhwAJWdjOcw9dtGnCoLWj0+bi1jKtbZk9fzVm5XRh6o4WAs9KLwblOs3WuZ4tEMRFwhu3Yq7U=
X-Received: by 2002:a17:90a:c283:: with SMTP id f3mr12123076pjt.166.1591966829499;
 Fri, 12 Jun 2020 06:00:29 -0700 (PDT)
MIME-Version: 1.0
References: <00000000000082f13605a72fbbcb@google.com>
In-Reply-To: <00000000000082f13605a72fbbcb@google.com>
From:   Andrey Konovalov <andreyknvl@google.com>
Date:   Fri, 12 Jun 2020 15:00:18 +0200
Message-ID: <CAAeHK+wxBFC65=sQY5q7zANk8RHJ1quMsSdN9zBn=i2G4jjhmg@mail.gmail.com>
Subject: Re: KASAN: out-of-bounds Read in ath9k_hif_usb_rx_cb
To:     syzbot <syzbot+d7289ef49bcdfd654265@syzkaller.appspotmail.com>
Cc:     ath9k-devel@qca.qualcomm.com,
        "David S. Miller" <davem@davemloft.net>, kuba@kernel.org,
        Kalle Valo <kvalo@codeaurora.org>,
        LKML <linux-kernel@vger.kernel.org>,
        USB list <linux-usb@vger.kernel.org>,
        linux-wireless@vger.kernel.org, netdev <netdev@vger.kernel.org>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Wed, Jun 3, 2020 at 5:32 PM syzbot
<syzbot+d7289ef49bcdfd654265@syzkaller.appspotmail.com> wrote:
>
> Hello,
>
> syzbot found the following crash on:
>
> HEAD commit:    2089c6ed usb: core: kcov: collect coverage from usb comple..
> git tree:       https://github.com/google/kasan.git usb-fuzzer
> console output: https://syzkaller.appspot.com/x/log.txt?x=17cf6bd6100000
> kernel config:  https://syzkaller.appspot.com/x/.config?x=b7479d3935864b1b
> dashboard link: https://syzkaller.appspot.com/bug?extid=d7289ef49bcdfd654265
> compiler:       gcc (GCC) 9.0.0 20181231 (experimental)
>
> Unfortunately, I don't have any reproducer for this crash yet.
>
> IMPORTANT: if you fix the bug, please add the following tag to the commit:
> Reported-by: syzbot+d7289ef49bcdfd654265@syzkaller.appspotmail.com
>
> ==================================================================
> BUG: KASAN: out-of-bounds in ath9k_hif_usb_rx_stream drivers/net/wireless/ath/ath9k/hif_usb.c:622 [inline]
> BUG: KASAN: out-of-bounds in ath9k_hif_usb_rx_cb+0xe64/0xf90 drivers/net/wireless/ath/ath9k/hif_usb.c:666
> Read of size 4 at addr ffff8881acb6c0d0 by task swapper/1/0
>
> CPU: 1 PID: 0 Comm: swapper/1 Not tainted 5.7.0-rc6-syzkaller #0
> Hardware name: Google Google Compute Engine/Google Compute Engine, BIOS Google 01/01/2011
> Call Trace:
>  <IRQ>
>  __dump_stack lib/dump_stack.c:77 [inline]
>  dump_stack+0xef/0x16e lib/dump_stack.c:118
>  print_address_description.constprop.0.cold+0xd3/0x415 mm/kasan/report.c:382
>  __kasan_report.cold+0x37/0x7d mm/kasan/report.c:511
>  kasan_report+0x33/0x50 mm/kasan/common.c:625
>  ath9k_hif_usb_rx_stream drivers/net/wireless/ath/ath9k/hif_usb.c:622 [inline]
>  ath9k_hif_usb_rx_cb+0xe64/0xf90 drivers/net/wireless/ath/ath9k/hif_usb.c:666
>  __usb_hcd_giveback_urb+0x29a/0x550 drivers/usb/core/hcd.c:1650
>  usb_hcd_giveback_urb+0x368/0x420 drivers/usb/core/hcd.c:1716
>  dummy_timer+0x125e/0x32b4 drivers/usb/gadget/udc/dummy_hcd.c:1967
>  call_timer_fn+0x1ac/0x700 kernel/time/timer.c:1405
>  expire_timers kernel/time/timer.c:1450 [inline]
>  __run_timers kernel/time/timer.c:1774 [inline]
>  __run_timers kernel/time/timer.c:1741 [inline]
>  run_timer_softirq+0x5f9/0x1500 kernel/time/timer.c:1787
>  __do_softirq+0x21e/0x9aa kernel/softirq.c:292
>  invoke_softirq kernel/softirq.c:373 [inline]
>  irq_exit+0x178/0x1a0 kernel/softirq.c:413
>  exiting_irq arch/x86/include/asm/apic.h:546 [inline]
>  smp_apic_timer_interrupt+0x141/0x540 arch/x86/kernel/apic/apic.c:1140
>  apic_timer_interrupt+0xf/0x20 arch/x86/entry/entry_64.S:829
>  </IRQ>
> RIP: 0010:default_idle+0x28/0x300 arch/x86/kernel/process.c:698
> Code: cc cc 41 56 41 55 65 44 8b 2d 94 3f 6b 7a 41 54 55 53 0f 1f 44 00 00 e8 16 28 af fb e9 07 00 00 00 0f 00 2d 7a e1 4b 00 fb f4 <65> 44 8b 2d 70 3f 6b 7a 0f 1f 44 00 00 5b 5d 41 5c 41 5d 41 5e c3
> RSP: 0018:ffff8881da227da8 EFLAGS: 00000246 ORIG_RAX: ffffffffffffff13
> RAX: 0000000000000007 RBX: ffff8881da20b180 RCX: 0000000000000000
> RDX: 0000000000000000 RSI: 0000000000000006 RDI: ffff8881da20b9fc
> RBP: ffffed103b441630 R08: ffff8881da20b180 R09: 0000000000000000
> R10: 0000000000000000 R11: 0000000000000000 R12: 0000000000000001
> R13: 0000000000000001 R14: ffffffff87e88c40 R15: 0000000000000000
>  cpuidle_idle_call kernel/sched/idle.c:154 [inline]
>  do_idle+0x3e0/0x500 kernel/sched/idle.c:269
>  cpu_startup_entry+0x14/0x20 kernel/sched/idle.c:361
>  start_secondary+0x2ae/0x390 arch/x86/kernel/smpboot.c:268
>  secondary_startup_64+0xb6/0xc0 arch/x86/kernel/head_64.S:242
>
> The buggy address belongs to the page:
> page:ffffea0006b2db00 refcount:0 mapcount:0 mapping:0000000080660f93 index:0x0
> flags: 0x200000000000000()
> raw: 0200000000000000 0000000000000000 ffffea0006b2db08 0000000000000000
> raw: 0000000000000000 0000000000000000 00000000ffffffff 0000000000000000
> page dumped because: kasan: bad access detected
>
> Memory state around the buggy address:
>  ffff8881acb6bf80: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff8881acb6c000: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> >ffff8881acb6c080: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>                                                  ^
>  ffff8881acb6c100: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
>  ffff8881acb6c180: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff
> ==================================================================
>
>
> ---
> This bug is generated by a bot. It may contain errors.
> See https://goo.gl/tpsmEJ for more information about syzbot.
> syzbot engineers can be reached at syzkaller@googlegroups.com.
>
> syzbot will keep track of this bug report. See:
> https://goo.gl/tpsmEJ#status for how to communicate with syzbot.

#syz dup: KASAN: stack-out-of-bounds Write in ath9k_hif_usb_rx_cb
