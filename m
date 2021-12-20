Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D288747B0E4
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Dec 2021 17:08:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235009AbhLTQIf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 20 Dec 2021 11:08:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232676AbhLTQIe (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 20 Dec 2021 11:08:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462C2C061574
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 08:08:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CA9C061214
        for <linux-wireless@vger.kernel.org>; Mon, 20 Dec 2021 16:08:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44C0BC36AE2;
        Mon, 20 Dec 2021 16:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640016513;
        bh=xBLIC2+2PHS7NbiEgn0Ckl21rDrfR+QlS+oRTRT4Orw=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=PbaJLNsDb3h6SCjhyiGw6qvnT+Ady5ATpQ5yWQ+mobltHn+OwPVYc7A+mRJFq/x0C
         TVfjJ2alMsuOhewMyErjKjIQTgqRmZmHR730+64bBYIsENTR4CBppa2afolcNTwD1L
         7Fv/+mlFrSzcBooPypizR7oEEE+i7NGBfmUl+f6E5WzErZSnII9jSi9cQeELmB31UU
         p05rz08QsKrfKz+Z++cBh5BYD3FQXDqeSCoHuBennfIPP9dPFuTByUEcnBTr2UGXmM
         g5zCVhZMebnpCTkbFSK3oqUX/FgObWcJ62yGNw4IhwHtJsjUhCFKp3Elhhw9xRfDSV
         9h0PwpzhVrw6g==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: fix warning of RCU usage for
 ath11k_mac_get_arvif_by_vdev_id()
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20211217064132.30911-1-quic_wgong@quicinc.com>
References: <20211217064132.30911-1-quic_wgong@quicinc.com>
To:     Wen Gong <quic_wgong@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
        <quic_wgong@quicinc.com>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164001651057.2023.16737463226034082113.kvalo@kernel.org>
Date:   Mon, 20 Dec 2021 16:08:32 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <quic_wgong@quicinc.com> wrote:

> When enable more debug config, it happen below warning. It is because
> the caller does not add rcu_read_lock()/rcu_read_unlock() to wrap the
> rcu_dereference().
> 
> Add rcu_read_lock()/rcu_read_unlock() to wrap rcu_dereference(), then
> fixed it.
> 
> [ 180.716604] =============================
> [ 180.716670] WARNING: suspicious RCU usage
> [ 180.716734] 5.16.0-rc4-wt-ath+ #542 Not tainted
> [ 180.716895] -----------------------------
> [ 180.716957] drivers/net/wireless/ath/ath11k/mac.c:506 suspicious rcu_dereference_check() usage!
> [ 180.717023]
>                other info that might help us debug this:
> 
> [ 180.717087]
>                rcu_scheduler_active = 2, debug_locks = 1
> [ 180.717151] no locks held by swapper/0/0.
> [ 180.717215]
>                stack backtrace:
> [ 180.717279] CPU: 0 PID: 0 Comm: swapper/0 Kdump: loaded Not tainted 5.16.0-rc4-wt-ath+ #542
> [ 180.717346] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
> [ 180.717411] Call Trace:
> [ 180.717475] <IRQ>
> [ 180.717541] dump_stack_lvl+0x57/0x7d
> [ 180.717610] ath11k_mac_get_arvif_by_vdev_id+0x1ab/0x2d0 [ath11k]
> [ 180.717694] ? ath11k_mac_get_arvif+0x140/0x140 [ath11k]
> [ 180.717798] ? ath11k_wmi_tlv_op_rx+0xc1b/0x2520 [ath11k]
> [ 180.717888] ? kfree+0xe8/0x2c0
> [ 180.717959] ath11k_wmi_tlv_op_rx+0xc27/0x2520 [ath11k]
> [ 180.718038] ? ath11k_mgmt_rx_event+0xda0/0xda0 [ath11k]
> [ 180.718113] ? __lock_acquire+0xb72/0x1870
> [ 180.718182] ? lockdep_hardirqs_on_prepare.part.0+0x18c/0x370
> [ 180.718250] ? sched_clock_cpu+0x15/0x1b0
> [ 180.718314] ? find_held_lock+0x33/0x110
> [ 180.718381] ? __lock_release+0x4bd/0x9f0
> [ 180.718447] ? lock_downgrade+0x130/0x130
> [ 180.718517] ath11k_htc_rx_completion_handler+0x38f/0x5b0 [ath11k]
> [ 180.718596] ? __local_bh_enable_ip+0xa0/0x110
> [ 180.718662] ath11k_ce_recv_process_cb+0x5ac/0x920 [ath11k]
> [ 180.718783] ? __lock_acquired+0x205/0x890
> [ 180.718864] ? ath11k_ce_rx_post_pipe+0x970/0x970 [ath11k]
> [ 180.718949] ? __wake_up_bit+0x100/0x100
> [ 180.719020] ath11k_pci_ce_tasklet+0x5f/0xf0 [ath11k_pci]
> [ 180.719085] ? tasklet_clear_sched+0x42/0xe0
> [ 180.719148] tasklet_action_common.constprop.0+0x204/0x2f0
> [ 180.719217] __do_softirq+0x276/0x86a
> [ 180.719281] ? __common_interrupt+0x92/0x1d0
> [ 180.719350] __irq_exit_rcu+0x11c/0x180
> [ 180.719418] irq_exit_rcu+0x5/0x20
> [ 180.719482] common_interrupt+0xa4/0xc0
> [ 180.719547] </IRQ>
> [ 180.719609] <TASK>
> [ 180.719671] asm_common_interrupt+0x1e/0x40
> [ 180.719772] RIP: 0010:cpuidle_enter_state+0x1f3/0x8d0
> [ 180.719838] Code: 00 41 8b 77 04 bf ff ff ff ff e8 78 f1 ff ff 31 ff e8 81 fa 52 fe 80 7c 24 08 00 0f 85 9e 01 00 00 e8 11 13 78 fe fb 45 85 e4 <0f> 88 8c 02 00 00 49 63 ec 48 8d 44 6d 00 48 8d 44 85 00 48 8d 7c
> [ 180.719909] RSP: 0018:ffffffffa4607dd0 EFLAGS: 00000202
> [ 180.719982] RAX: 00000000002aea91 RBX: ffffffffa4a5fec0 RCX: 1ffffffff49ca501
> [ 180.720047] RDX: 0000000000000000 RSI: ffffffffa3c6e4e0 RDI: ffffffffa3dcf2a0
> [ 180.720110] RBP: 0000000000000002 R08: 0000000000000001 R09: ffffffffa4e54d17
> [ 180.720173] R10: fffffbfff49ca9a2 R11: 0000000000000001 R12: 0000000000000002
> [ 180.720236] R13: ffff8881169ccc04 R14: 0000002a13899598 R15: ffff8881169ccc00
> [ 180.720321] cpuidle_enter+0x45/0xa0
> [ 180.720413] cpuidle_idle_call+0x274/0x3f0
> [ 180.720503] ? arch_cpu_idle_exit+0x30/0x30
> [ 180.720869] ? tsc_verify_tsc_adjust+0x97/0x2e0
> [ 180.720935] ? lockdep_hardirqs_off+0x90/0xd0
> [ 180.721002] do_idle+0xe0/0x150
> [ 180.721069] cpu_startup_entry+0x14/0x20
> [ 180.721134] start_kernel+0x3a2/0x3c2
> [ 180.721200] secondary_startup_64_no_verify+0xb0/0xbb
> [ 180.721274] </TASK>
> 
> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-02892.1-QCAHSPSWPL_V1_V2_SILICONZ_LITE-1
> 
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

01e782c89108 ath11k: fix warning of RCU usage for ath11k_mac_get_arvif_by_vdev_id()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20211217064132.30911-1-quic_wgong@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

