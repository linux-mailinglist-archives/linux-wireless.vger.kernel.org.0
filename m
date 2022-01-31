Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EDAFC4A4882
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Jan 2022 14:43:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377767AbiAaNnm (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 31 Jan 2022 08:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54626 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbiAaNnk (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 31 Jan 2022 08:43:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39CD7C061714
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jan 2022 05:43:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ED8A7B82ADB
        for <linux-wireless@vger.kernel.org>; Mon, 31 Jan 2022 13:43:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FE0C340E8;
        Mon, 31 Jan 2022 13:43:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643636617;
        bh=B95mH1TMLqa08GOnhNnTlKAn/T77CIlSoBsqQmLjxwM=;
        h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
        b=anOXQSmP80JP6C0zFtfqBrDZW3YmubY53bbBTaUY/+leTjlsKwXkjTjiv4DW+rfCR
         03VdXiXc9qloVyDdAwDZPZlfMnnaNialwNWTcvj1gAC9wMpvCM47zHrbrcPql35zLU
         PGyt91bs4pxkF9kVb7/K0h2PRJfWD1U/TYayrfiY40NmGGS7AQrbs6ohMnE95Eo6Z3
         EyorX1plNQhx78QNW+Y8tujn6m/TbXo94FGB1HlNisAHRjv1a7qwCoSuPxHyg7211V
         LhcqzuLXdqDFzXyq1Mb0FjmQSR7C8QMgA3Hli34W1GskC8Ht1z8ofzzsBPF5LlmjJ0
         XBn3+eamXCycQ==
From:   Kalle Valo <kvalo@kernel.org>
To:     Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH v2] ath11k: Add peer rhash table support
References: <1643609184-32353-1-git-send-email-quic_periyasa@quicinc.com>
Date:   Mon, 31 Jan 2022 15:43:34 +0200
In-Reply-To: <1643609184-32353-1-git-send-email-quic_periyasa@quicinc.com>
        (Karthikeyan Periyasamy's message of "Mon, 31 Jan 2022 11:36:24
        +0530")
Message-ID: <87h79kdnqx.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Karthikeyan Periyasamy <quic_periyasa@quicinc.com> writes:

> When more clients (128) are connected, the UL data traffic
> KPI measurement is low compared to single client. This issue
> is due to more CPU cycles spent on the peer lookup operation
> with more clients. So reduce the peer lookup operation by
> modifying the linear based lookup operation into the rhash
> based lookup operation. This improve the peak throughput
> measurement. Since this is a software algorithm change, it is
> applicable for all the platforms.
>
> TCP UL 128 Clients test case Observation (64bit system):
> Previous: ~550 Mbps
> Now	: ~860 Mbps
>
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.5.0.1-01067-QCAHKSWPL_SILICONZ-1
>
> Signed-off-by: Karthikeyan Periyasamy <quic_periyasa@quicinc.com>

I didn't review this yet, but while testing I saw a new warning with
QCA6390:

[  292.395491] BUG: sleeping function called from invalid context at kernel/workqueue.c:3028
[  292.395719] in_atomic(): 1, irqs_disabled(): 0, non_block: 0, pid: 2142, name: rmmod
[  292.395779] preempt_count: 201, expected: 0
[  292.395851] RCU nest depth: 0, expected: 0
[  292.395908] 3 locks held by rmmod/2142:
[  292.395972]  #0: ffff88810e849260 (&dev->mutex){....}-{3:3}, at: driver_detach+0x1b8/0x2c0
[  292.396037]  #1: ffff88814c50c588 (&ab->core_lock){+.+.}-{3:3}, at: ath11k_core_deinit+0x21/0x150 [ath11k]
[  292.396112]  #2: ffff88814c50c5d0 (&ab->base_lock){+.-.}-{2:2}, at: ath11k_peer_rhash_tbl_destroy+0x1d/0x160 [ath11k]
[  292.396187] Preemption disabled at:
[  292.396190] [<0000000000000000>] 0x0
[  292.396290] CPU: 2 PID: 2142 Comm: rmmod Kdump: loaded Not tainted 5.17.0-rc1-wt-ath+ #569
[  292.396342] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
[  292.396391] Call Trace:
[  292.396441]  <TASK>
[  292.396493]  dump_stack_lvl+0x57/0x7d
[  292.396546]  __might_resched.cold+0x222/0x26b
[  292.396598]  start_flush_work+0x2c/0x8c0
[  292.396684]  __flush_work+0xcd/0x1a0
[  292.396750]  ? start_flush_work+0x8c0/0x8c0
[  292.396801]  ? validate_chain+0xac3/0x1b30
[  292.396854]  ? mark_lock+0xd0/0x14a0
[  292.396907]  ? mark_lock_irq+0x1c30/0x1c30
[  292.396958]  ? check_prev_add+0x20f0/0x20f0
[  292.397008]  ? mark_lock_irq+0x1c30/0x1c30
[  292.397063]  ? mark_held_locks+0xa5/0xe0
[  292.397124]  ? lockdep_hardirqs_on_prepare.part.0+0x18c/0x370
[  292.397212]  __cancel_work_timer+0x315/0x460
[  292.397294]  ? try_to_grab_pending+0x80/0x80
[  292.397352]  ? lock_acquire.part.0+0x117/0x340
[  292.397404]  ? find_held_lock+0x33/0x110
[  292.397465]  rhashtable_free_and_destroy+0x22/0x700
[  292.397527]  ? ath11k_peer_rhash_tbl_destroy+0x1d/0x160 [ath11k]
[  292.397598]  ath11k_peer_rhash_tbl_destroy+0x49/0x160 [ath11k]
[  292.397693]  ath11k_core_deinit+0x39/0x150 [ath11k]
[  292.397773]  ath11k_pci_remove+0xd2/0x260 [ath11k_pci]
[  292.397827]  pci_device_remove+0x9a/0x1c0
[  292.397884]  __device_release_driver+0x332/0x660
[  292.397940]  driver_detach+0x1e7/0x2c0
[  292.397996]  bus_remove_driver+0xe2/0x2d0
[  292.398048]  pci_unregister_driver+0x21/0x250
[  292.398109]  __do_sys_delete_module+0x30a/0x4b0
[  292.398163]  ? free_module+0xac0/0xac0
[  292.398220]  ? lockdep_hardirqs_on_prepare.part.0+0x18c/0x370
[  292.398273]  ? syscall_enter_from_user_mode+0x1d/0x50
[  292.398324]  ? lockdep_hardirqs_on+0x79/0x100
[  292.398376]  do_syscall_64+0x3b/0x90
[  292.398430]  entry_SYSCALL_64_after_hwframe+0x44/0xae
[  292.398478] RIP: 0033:0x7f9d82378bcb
[  292.398531] Code: 73 01 c3 48 8b 0d c5 82 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 95 82 0c 00 f7 d8 64 89 01 48
[  292.398591] RSP: 002b:00007ffd450a9928 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  292.398672] RAX: ffffffffffffffda RBX: 00007f9d82b5d7a0 RCX: 00007f9d82378bcb
[  292.398752] RDX: 000000000000000a RSI: 0000000000000800 RDI: 00007f9d82b5d808
[  292.398806] RBP: 00007ffd450a9988 R08: 0000000000000000 R09: 0000000000000000
[  292.398858] R10: 00007f9d823f4ac0 R11: 0000000000000206 R12: 00007ffd450a9b60
[  292.398911] R13: 00007ffd450aaeb7 R14: 00007f9d82b5c2a0 R15: 00007f9d82b5d7a0
[  292.398974]  </TASK>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
