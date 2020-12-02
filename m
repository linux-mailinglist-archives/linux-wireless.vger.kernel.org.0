Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 720FE2CC549
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Dec 2020 19:37:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730986AbgLBSe5 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 2 Dec 2020 13:34:57 -0500
Received: from a2.mail.mailgun.net ([198.61.254.61]:10564 "EHLO
        a2.mail.mailgun.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730978AbgLBSe5 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 2 Dec 2020 13:34:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1606934073; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=sJXK0hioMWJbLy6qOvXV5jp9qLCcGF2Qho7EjwcDBo8=;
 b=IcXhgF3mXWWVpWIqe6x35ZCdxWdWaTW0CUcMynSfh3n9ZdoeVnPF8a4NfsgxSlCZlu25jJ9v
 3/y3TWO3iAQud35/NV3+Ou28N/Bg3clSjOfVhmp4ykynd4q3NNzBcBb5sQEzvjB97lXQpjKv
 WbsOtvXLt2N5PQN5fZ8mxFR1SRA=
X-Mailgun-Sending-Ip: 198.61.254.61
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n09.prod.us-west-2.postgun.com with SMTP id
 5fc7de2a07535c81baf542fa (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 02 Dec 2020 18:34:18
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5AB5AC433ED; Wed,  2 Dec 2020 18:34:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id DB0FFC433C6;
        Wed,  2 Dec 2020 18:34:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org DB0FFC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: dp_rx: fix monitor status dma unmap direction
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <1606156046-24764-1-git-send-email-kvalo@codeaurora.org>
References: <1606156046-24764-1-git-send-email-kvalo@codeaurora.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     ath11k@lists.infradead.org, linux-wireless@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.5.2
Message-Id: <20201202183418.5AB5AC433ED@smtp.codeaurora.org>
Date:   Wed,  2 Dec 2020 18:34:18 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Kalle Valo <kvalo@codeaurora.org> wrote:

> After enabling CONFIG_DMA_API_DEBUG there was a warning about using
> dma_unmap_single() in wrong direction from ath11k_dp_rx_process_mon_status().
> 
> [  140.279477] ------------[ cut here ]------------
> [  140.279908] DMA-API: ath11k_pci 0000:06:00.0: device driver syncs DMA memory with different direction [device address=0x00000000fac08a40] [size=2176 bytes] [mapped with DMA_FROM_DEVICE] [s
> [  140.279925] WARNING: CPU: 7 PID: 97 at kernel/dma/debug.c:1120 check_sync+0x494/0x730
> [  140.279939] Modules linked in: ath11k_pci ath11k mac80211 libarc4 cfg80211 qmi_helpers qrtr_mhi mhi qrtr ns nvme nvme_core
> [  140.279958] CPU: 7 PID: 97 Comm: kworker/u16:1 Not tainted 5.10.0-rc4+ #262
> [  140.279968] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0049.2018.0801.1601 08/01/2018
> [  140.279995] Workqueue: phy0 ieee80211_scan_work [mac80211]
> [  140.280009] RIP: 0010:check_sync+0x494/0x730
> [  140.280022] Code: 8b 4c 24 10 4c 8b 44 24 18 4c 8b 54 24 20 48 89 c6 4c 89 54 24 10 4c 89 f9 4c 89 ea 48 c7 c7 40 b9 74 9c 41 56 e8 2f a0 ab 00 <0f> 0b 48 89 ef e8 e5 17 ac 00 41 58 4c 8b
> [  140.280033] RSP: 0018:ffff9f588024cbd8 EFLAGS: 00010086
> [  140.280046] RAX: 0000000000000000 RBX: ffff9f588024cc40 RCX: ffff8eed18dd9f98
> [  140.280057] RDX: 00000000ffffffd8 RSI: 0000000000000027 RDI: ffff8eed18dd9f90
> [  140.280067] RBP: ffff8eebc1407800 R08: 00000000ffffffea R09: 0000000000000000
> [  140.280082] R10: 0000000000000003 R11: 3fffffffffffffff R12: ffffffff9e081060
> [  140.280093] R13: ffff8eebc43908b0 R14: ffffffff9c74c104 R15: 00000000fac08a40
> [  140.280104] FS:  0000000000000000(0000) GS:ffff8eed18c00000(0000) knlGS:0000000000000000
> [  140.280115] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> [  140.280127] CR2: 00007f6feafb12a0 CR3: 00000001604ca001 CR4: 00000000003706e0
> [  140.280138] Call Trace:
> [  140.280149]  <IRQ>
> [  140.280161]  debug_dma_sync_single_for_cpu+0x79/0x80
> [  140.280173]  ? mark_held_locks+0x50/0x80
> [  140.280185]  ? lockdep_hardirqs_on_prepare.part.0+0x65/0x130
> [  140.280197]  ? __local_bh_enable_ip+0x6f/0xb0
> [  140.280215]  ? ath11k_dp_rx_reap_mon_status_ring+0x202/0x340 [ath11k]
> [  140.280231]  ath11k_dp_rx_reap_mon_status_ring+0x22c/0x340 [ath11k]
> [  140.280249]  ? ath11k_dp_rx_process_mon_rings+0x1a0/0x1a0 [ath11k]
> [  140.280265]  ath11k_dp_rx_process_mon_status+0x83/0x3c0 [ath11k]
> [  140.280278]  ? __lock_acquire+0x3bd/0x6d0
> [  140.280296]  ? ath11k_dp_rx_process_mon_rings+0x1a0/0x1a0 [ath11k]
> [  140.280311]  ? ath11k_dp_rx_process_mon_rings+0x1a0/0x1a0 [ath11k]
> [  140.280326]  ? ath11k_hw_mac_id_to_srng_id_qca6390+0x10/0x10 [ath11k]
> [  140.280341]  ? ath11k_dp_rx_process_mon_rings+0x4a/0x1a0 [ath11k]
> [  140.280353]  ? timer_fixup_init+0x30/0x30
> [  140.280367]  ? ath11k_dp_rx_process_mon_rings+0x1a0/0x1a0 [ath11k]
> [  140.280385]  ath11k_dp_service_mon_ring+0x2b/0x50 [ath11k]
> [  140.280400]  ? ath11k_dp_rx_process_mon_rings+0x1a0/0x1a0 [ath11k]
> [  140.280413]  call_timer_fn+0xb1/0x2d0
> [  140.280426]  __run_timers.part.0+0x205/0x2f0
> [  140.280439]  run_timer_softirq+0x21/0x50
> [  140.280450]  __do_softirq+0xc2/0x454
> [  140.280463]  asm_call_irq_on_stack+0x12/0x20
> [  140.280476]  </IRQ>
> [  140.280488]  do_softirq_own_stack+0x56/0x60
> [  140.280500]  irq_exit_rcu+0x9a/0xd0
> [  140.280511]  sysvec_apic_timer_interrupt+0x43/0xa0
> [  140.280526]  asm_sysvec_apic_timer_interrupt+0x12/0x20
> [  140.280540] RIP: 0010:_raw_spin_unlock_irqrestore+0x25/0x40
> [  140.280551] Code: 80 00 00 00 00 55 48 89 fd 48 83 c7 18 53 48 89 f3 48 8b 74 24 10 e8 ca 8f 4b ff 48 89 ef e8 22 dc 4b ff f6 c7 02 75 0c 53 9d <65> ff 0d 04 51 20 64 5b 5d c3 e8 9c 08 56
> [  140.280563] RSP: 0018:ffff9f58802e7878 EFLAGS: 00000246
> [  140.280578] RAX: 00000000000435ef RBX: 0000000000000246 RCX: 0000000000000040
> [  140.280592] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffffffff9be13e84
> [  140.280603] RBP: ffff8eed18dde480 R08: 0000000000000001 R09: ffff8eebc2292760
> [  140.280614] R10: 0000000000000005 R11: ffff8eebc2292760 R12: 0000000000000000
> [  140.280625] R13: ffff9f58802e7900 R14: ffff8eed18dde480 R15: ffff8eed18dde480
> [  140.280637]  ? _raw_spin_unlock_irqrestore+0x34/0x40
> [  140.280649]  __mod_timer+0x274/0x400
> [  140.280661]  ? wait_for_completion_timeout+0x76/0x110
> [  140.280675]  schedule_timeout+0xa8/0x140
> [  140.280687]  ? __next_timer_interrupt+0x100/0x100
> [  140.280698]  wait_for_completion_timeout+0xa2/0x110
> [  140.280714]  ath11k_start_scan+0x4c/0xf0 [ath11k]
> [  140.280730]  ath11k_mac_op_hw_scan+0x1e9/0x2c0 [ath11k]
> [  140.280763]  drv_hw_scan+0x79/0x260 [mac80211]
> [  140.280789]  __ieee80211_scan_completed+0x379/0x440 [mac80211]
> [  140.280816]  ieee80211_scan_work+0x12f/0x330 [mac80211]
> [  140.280830]  process_one_work+0x279/0x5b0
> [  140.280842]  worker_thread+0x49/0x300
> [  140.280854]  ? process_one_work+0x5b0/0x5b0
> [  140.280868]  kthread+0x135/0x150
> [  140.280880]  ? __kthread_bind_mask+0x60/0x60
> [  140.280891]  ret_from_fork+0x22/0x30
> [  140.280903] irq event stamp: 275961
> [  140.280918] hardirqs last  enabled at (275960): [<ffffffff9b270f1f>] __local_bh_enable_ip+0x6f/0xb0
> [  140.280931] hardirqs last disabled at (275961): [<ffffffff9be13ca3>] _raw_spin_lock_irqsave+0x63/0x80
> [  140.280946] softirqs last  enabled at (275944): [<ffffffffc055288d>] ath11k_ce_send+0x14d/0x260 [ath11k]
> [  140.280958] softirqs last disabled at (275953): [<ffffffff9c000f72>] asm_call_irq_on_stack+0x12/0x20
> [  140.280971] ---[ end trace 31cb94e18d401398 ]---
> 
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
> 
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

cd6181ff7e93 ath11k: dp_rx: fix monitor status dma unmap direction

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/1606156046-24764-1-git-send-email-kvalo@codeaurora.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

