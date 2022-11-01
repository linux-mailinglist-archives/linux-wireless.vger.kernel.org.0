Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD37C614848
	for <lists+linux-wireless@lfdr.de>; Tue,  1 Nov 2022 12:14:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbiKALOh (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 1 Nov 2022 07:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230149AbiKALOf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 1 Nov 2022 07:14:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABDB81835F
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 04:14:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 61100B81BD1
        for <linux-wireless@vger.kernel.org>; Tue,  1 Nov 2022 11:14:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1011C433D7;
        Tue,  1 Nov 2022 11:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667301272;
        bh=7IeREP9MWffW1YayRp1bw+Y1tHtC3xePLebPfImWBEM=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=oq2knVN0BMFZcWQkc4VPAu3JPQCOA437UPvCYjb9fOcEbGNqHQEucZix6hJ7NT1Z5
         Ja5iZnppbx7BZOQygHK8b1eUItwC9aeexS+d3mxVWtTuwA4IupRqI59wgD5mhalqPm
         LNfVH7U+FjgJdpQWCs/6egVL4L41bDjKjg/E96BKcrKpXZYm5vel9fQaJJJfFhF2kW
         UqjM2mHypUmAlbTSnfXv4ijv5eqC+BAJJbucAJWS4vSHXMcPceJCEUqmkI/DZ/2Qqt
         Gp/DTo+ReO8hV4M4RlNTGU4OwD9fhO/6H6LdhbKq4ILUXvsGVEgEgF9yMTR3VDx57q
         EpvnyoRuOsMOA==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v3] wifi: brcmfmac: Fix potential buffer overflow in
 brcmf_fweh_event_worker()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20221021061359.GA550858@laguna>
References: <20221021061359.GA550858@laguna>
To:     Dokyung Song <dokyung.song@gmail.com>
Cc:     Arend Van Spriel <aspriel@gmail.com>,
        linux-wireless@vger.kernel.org,
        Jisoo Jang <jisoo.jang@yonsei.ac.kr>,
        Minsuk Kang <linuxlovemin@yonsei.ac.kr>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <166730126891.29834.3538576129276375890.kvalo@kernel.org>
Date:   Tue,  1 Nov 2022 11:14:30 +0000 (UTC)
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Dokyung Song <dokyung.song@gmail.com> wrote:

> This patch fixes an intra-object buffer overflow in brcmfmac that occurs
> when the device provides a 'bsscfgidx' equal to or greater than the
> buffer size. The patch adds a check that leads to a safe failure if that
> is the case.
> 
> This fixes CVE-2022-3628.
> 
> UBSAN: array-index-out-of-bounds in drivers/net/wireless/broadcom/brcm80211/brcmfmac/fweh.c
> index 52 is out of range for type 'brcmf_if *[16]'
> CPU: 0 PID: 1898 Comm: kworker/0:2 Tainted: G           O      5.14.0+ #132
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> Workqueue: events brcmf_fweh_event_worker
> Call Trace:
>  dump_stack_lvl+0x57/0x7d
>  ubsan_epilogue+0x5/0x40
>  __ubsan_handle_out_of_bounds+0x69/0x80
>  ? memcpy+0x39/0x60
>  brcmf_fweh_event_worker+0xae1/0xc00
>  ? brcmf_fweh_call_event_handler.isra.0+0x100/0x100
>  ? rcu_read_lock_sched_held+0xa1/0xd0
>  ? rcu_read_lock_bh_held+0xb0/0xb0
>  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
>  process_one_work+0x873/0x13e0
>  ? lock_release+0x640/0x640
>  ? pwq_dec_nr_in_flight+0x320/0x320
>  ? rwlock_bug.part.0+0x90/0x90
>  worker_thread+0x8b/0xd10
>  ? __kthread_parkme+0xd9/0x1d0
>  ? process_one_work+0x13e0/0x13e0
>  kthread+0x379/0x450
>  ? _raw_spin_unlock_irq+0x24/0x30
>  ? set_kthread_struct+0x100/0x100
>  ret_from_fork+0x1f/0x30
> ================================================================================
> general protection fault, probably for non-canonical address 0xe5601c0020023fff: 0000 [#1] SMP KASAN
> KASAN: maybe wild-memory-access in range [0x2b0100010011fff8-0x2b0100010011ffff]
> CPU: 0 PID: 1898 Comm: kworker/0:2 Tainted: G           O      5.14.0+ #132
> Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS rel-1.12.1-0-ga5cab58e9a3f-prebuilt.qemu.org 04/01/2014
> Workqueue: events brcmf_fweh_event_worker
> RIP: 0010:brcmf_fweh_call_event_handler.isra.0+0x42/0x100
> Code: 89 f5 53 48 89 fb 48 83 ec 08 e8 79 0b 38 fe 48 85 ed 74 7e e8 6f 0b 38 fe 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 8b 00 00 00 4c 8b 7d 00 44 89 e0 48 ba 00 00 00
> RSP: 0018:ffffc9000259fbd8 EFLAGS: 00010207
> RAX: dffffc0000000000 RBX: ffff888115d8cd50 RCX: 0000000000000000
> RDX: 0560200020023fff RSI: ffffffff8304bc91 RDI: ffff888115d8cd50
> RBP: 2b0100010011ffff R08: ffff888112340050 R09: ffffed1023549809
> R10: ffff88811aa4c047 R11: ffffed1023549808 R12: 0000000000000045
> R13: ffffc9000259fca0 R14: ffff888112340050 R15: ffff888112340000
> FS:  0000000000000000(0000) GS:ffff88811aa00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000004053ccc0 CR3: 0000000112740000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Call Trace:
>  brcmf_fweh_event_worker+0x117/0xc00
>  ? brcmf_fweh_call_event_handler.isra.0+0x100/0x100
>  ? rcu_read_lock_sched_held+0xa1/0xd0
>  ? rcu_read_lock_bh_held+0xb0/0xb0
>  ? lockdep_hardirqs_on_prepare+0x273/0x3e0
>  process_one_work+0x873/0x13e0
>  ? lock_release+0x640/0x640
>  ? pwq_dec_nr_in_flight+0x320/0x320
>  ? rwlock_bug.part.0+0x90/0x90
>  worker_thread+0x8b/0xd10
>  ? __kthread_parkme+0xd9/0x1d0
>  ? process_one_work+0x13e0/0x13e0
>  kthread+0x379/0x450
>  ? _raw_spin_unlock_irq+0x24/0x30
>  ? set_kthread_struct+0x100/0x100
>  ret_from_fork+0x1f/0x30
> Modules linked in: 88XXau(O) 88x2bu(O)
> ---[ end trace 41d302138f3ff55a ]---
> RIP: 0010:brcmf_fweh_call_event_handler.isra.0+0x42/0x100
> Code: 89 f5 53 48 89 fb 48 83 ec 08 e8 79 0b 38 fe 48 85 ed 74 7e e8 6f 0b 38 fe 48 89 ea 48 b8 00 00 00 00 00 fc ff df 48 c1 ea 03 <80> 3c 02 00 0f 85 8b 00 00 00 4c 8b 7d 00 44 89 e0 48 ba 00 00 00
> RSP: 0018:ffffc9000259fbd8 EFLAGS: 00010207
> RAX: dffffc0000000000 RBX: ffff888115d8cd50 RCX: 0000000000000000
> RDX: 0560200020023fff RSI: ffffffff8304bc91 RDI: ffff888115d8cd50
> RBP: 2b0100010011ffff R08: ffff888112340050 R09: ffffed1023549809
> R10: ffff88811aa4c047 R11: ffffed1023549808 R12: 0000000000000045
> R13: ffffc9000259fca0 R14: ffff888112340050 R15: ffff888112340000
> FS:  0000000000000000(0000) GS:ffff88811aa00000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 000000004053ccc0 CR3: 0000000112740000 CR4: 0000000000750ef0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> PKRU: 55555554
> Kernel panic - not syncing: Fatal exception
> 
> Reported-by: Dokyung Song <dokyungs@yonsei.ac.kr>
> Reported-by: Jisoo Jang <jisoo.jang@yonsei.ac.kr>
> Reported-by: Minsuk Kang <linuxlovemin@yonsei.ac.kr>
> Reviewed-by: Arend van Spriel <aspriel@gmail.com>
> Cc: <stable@vger.kernel.org>
> Signed-off-by: Dokyung Song <dokyung.song@gmail.com>

Patch applied to wireless.git, thanks.

6788ba8aed4e wifi: brcmfmac: Fix potential buffer overflow in brcmf_fweh_event_worker()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20221021061359.GA550858@laguna/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

