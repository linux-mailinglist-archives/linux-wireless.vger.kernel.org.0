Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 119B56EEE7A
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Apr 2023 08:42:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239561AbjDZGmD (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 26 Apr 2023 02:42:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239408AbjDZGlw (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 26 Apr 2023 02:41:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9201F270B;
        Tue, 25 Apr 2023 23:41:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2BE8663225;
        Wed, 26 Apr 2023 06:41:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C7B5C433EF;
        Wed, 26 Apr 2023 06:41:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682491309;
        bh=33xG/M/NBRJczmm4X8iDO3HtDmQq6ILZHrp/h2howPo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=dhZLYNZb5OlgY2Dkmwt2JWngNzdJtJNY2OogDAG7OFmxDZsA9SgNiGxff17Ug+895
         MGO9gKp8Lciw0PD/fqxZv6hVOAzRPW/AXVKSQ+ist12vspGYmJSPBO5QOpkpH6bRcB
         3EmEZ5ctV+WW3D5kZONuSmj63Rijv46DHqTg/NZRtOBHoYlMIiXi4/1PB0Y2/mltg5
         V47oo+zs4Ki4q7jfqKj0Cna+1hD02FmKfzSDJQdQxFU7nWul+Nw3RBhAC0lH6cQ3MK
         EaNVVNTCDBu7tgqiatKWUeG8lc3Ms5zgdhFDMdQLkWAl87cGZGy9zIHTlz6WZW85kg
         WH+RYX/VFNDhA==
Date:   Wed, 26 Apr 2023 09:41:45 +0300
From:   Leon Romanovsky <leon@kernel.org>
To:     Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
Cc:     Johannes Berg <johannes.berg@intel.com>,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johannes Berg <johannes@sipsolutions.net>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Alexander Wetzel <alexander@wetzel-home.de>
Subject: Re: [PATCH v4 1/1] wifi: mac80211: fortify the spinlock against
 deadlock by interrupt
Message-ID: <20230426064145.GE27649@unreal>
References: <20230425164005.25272-1-mirsad.todorovac@alu.unizg.hr>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230425164005.25272-1-mirsad.todorovac@alu.unizg.hr>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Tue, Apr 25, 2023 at 06:40:08PM +0200, Mirsad Goran Todorovac wrote:
> In the function ieee80211_tx_dequeue() there is a particular locking
> sequence:
> 
> begin:
> 	spin_lock(&local->queue_stop_reason_lock);
> 	q_stopped = local->queue_stop_reasons[q];
> 	spin_unlock(&local->queue_stop_reason_lock);
> 
> However small the chance (increased by ftracetest), an asynchronous
> interrupt can occur in between of spin_lock() and spin_unlock(),
> and the interrupt routine will attempt to lock the same
> &local->queue_stop_reason_lock again.
> 
> This will cause a costly reset of the CPU and the wifi device or an
> altogether hang in the single CPU and single core scenario.
> 
> The only remaining spin_lock(&local->queue_stop_reason_lock) that
> did not disable interrupts was patched, which should prevent any
> deadlocks on the same CPU/core and the same wifi device.
> 
> This is the probable trace of the deadlock:
> 
> kernel: ================================
> kernel: WARNING: inconsistent lock state
> kernel: 6.3.0-rc6-mt-20230401-00001-gf86822a1170f #4 Tainted: G        W
> kernel: --------------------------------
> kernel: inconsistent {IN-SOFTIRQ-W} -> {SOFTIRQ-ON-W} usage.
> kernel: kworker/5:0/25656 [HC0[0]:SC0[0]:HE1:SE1] takes:
> kernel: ffff9d6190779478 (&local->queue_stop_reason_lock){+.?.}-{2:2}, at: return_to_handler+0x0/0x40
> kernel: {IN-SOFTIRQ-W} state was registered at:
> kernel:   lock_acquire+0xc7/0x2d0
> kernel:   _raw_spin_lock+0x36/0x50
> kernel:   ieee80211_tx_dequeue+0xb4/0x1330 [mac80211]
> kernel:   iwl_mvm_mac_itxq_xmit+0xae/0x210 [iwlmvm]
> kernel:   iwl_mvm_mac_wake_tx_queue+0x2d/0xd0 [iwlmvm]
> kernel:   ieee80211_queue_skb+0x450/0x730 [mac80211]
> kernel:   __ieee80211_xmit_fast.constprop.66+0x834/0xa50 [mac80211]
> kernel:   __ieee80211_subif_start_xmit+0x217/0x530 [mac80211]
> kernel:   ieee80211_subif_start_xmit+0x60/0x580 [mac80211]
> kernel:   dev_hard_start_xmit+0xb5/0x260
> kernel:   __dev_queue_xmit+0xdbe/0x1200
> kernel:   neigh_resolve_output+0x166/0x260
> kernel:   ip_finish_output2+0x216/0xb80
> kernel:   __ip_finish_output+0x2a4/0x4d0
> kernel:   ip_finish_output+0x2d/0xd0
> kernel:   ip_output+0x82/0x2b0
> kernel:   ip_local_out+0xec/0x110
> kernel:   igmpv3_sendpack+0x5c/0x90
> kernel:   igmp_ifc_timer_expire+0x26e/0x4e0
> kernel:   call_timer_fn+0xa5/0x230
> kernel:   run_timer_softirq+0x27f/0x550
> kernel:   __do_softirq+0xb4/0x3a4
> kernel:   irq_exit_rcu+0x9b/0xc0
> kernel:   sysvec_apic_timer_interrupt+0x80/0xa0
> kernel:   asm_sysvec_apic_timer_interrupt+0x1f/0x30
> kernel:   _raw_spin_unlock_irqrestore+0x3f/0x70
> kernel:   free_to_partial_list+0x3d6/0x590
> kernel:   __slab_free+0x1b7/0x310
> kernel:   kmem_cache_free+0x52d/0x550
> kernel:   putname+0x5d/0x70
> kernel:   do_sys_openat2+0x1d7/0x310
> kernel:   do_sys_open+0x51/0x80
> kernel:   __x64_sys_openat+0x24/0x30
> kernel:   do_syscall_64+0x5c/0x90
> kernel:   entry_SYSCALL_64_after_hwframe+0x72/0xdc
> kernel: irq event stamp: 5120729
> kernel: hardirqs last  enabled at (5120729): [<ffffffff9d149936>] trace_graph_return+0xd6/0x120
> kernel: hardirqs last disabled at (5120728): [<ffffffff9d149950>] trace_graph_return+0xf0/0x120
> kernel: softirqs last  enabled at (5069900): [<ffffffff9cf65b60>] return_to_handler+0x0/0x40
> kernel: softirqs last disabled at (5067555): [<ffffffff9cf65b60>] return_to_handler+0x0/0x40
> kernel:
>         other info that might help us debug this:
> kernel:  Possible unsafe locking scenario:
> kernel:        CPU0
> kernel:        ----
> kernel:   lock(&local->queue_stop_reason_lock);
> kernel:   <Interrupt>
> kernel:     lock(&local->queue_stop_reason_lock);
> kernel:
>          *** DEADLOCK ***
> kernel: 8 locks held by kworker/5:0/25656:
> kernel:  #0: ffff9d618009d138 ((wq_completion)events_freezable){+.+.}-{0:0}, at: process_one_work+0x1ca/0x530
> kernel:  #1: ffffb1ef4637fe68 ((work_completion)(&local->restart_work)){+.+.}-{0:0}, at: process_one_work+0x1ce/0x530
> kernel:  #2: ffffffff9f166548 (rtnl_mutex){+.+.}-{3:3}, at: return_to_handler+0x0/0x40
> kernel:  #3: ffff9d6190778728 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: return_to_handler+0x0/0x40
> kernel:  #4: ffff9d619077b480 (&mvm->mutex){+.+.}-{3:3}, at: return_to_handler+0x0/0x40
> kernel:  #5: ffff9d61907bacd8 (&trans_pcie->mutex){+.+.}-{3:3}, at: return_to_handler+0x0/0x40
> kernel:  #6: ffffffff9ef9cda0 (rcu_read_lock){....}-{1:2}, at: iwl_mvm_queue_state_change+0x59/0x3a0 [iwlmvm]
> kernel:  #7: ffffffff9ef9cda0 (rcu_read_lock){....}-{1:2}, at: iwl_mvm_mac_itxq_xmit+0x42/0x210 [iwlmvm]
> kernel:
>         stack backtrace:
> kernel: CPU: 5 PID: 25656 Comm: kworker/5:0 Tainted: G        W          6.3.0-rc6-mt-20230401-00001-gf86822a1170f #4
> kernel: Hardware name: LENOVO 82H8/LNVNB161216, BIOS GGCN51WW 11/16/2022
> kernel: Workqueue: events_freezable ieee80211_restart_work [mac80211]
> kernel: Call Trace:
> kernel:  <TASK>
> kernel:  ? ftrace_regs_caller_end+0x66/0x66
> kernel:  dump_stack_lvl+0x5f/0xa0
> kernel:  dump_stack+0x14/0x20
> kernel:  print_usage_bug.part.46+0x208/0x2a0
> kernel:  mark_lock.part.47+0x605/0x630
> kernel:  ? sched_clock+0xd/0x20
> kernel:  ? trace_clock_local+0x14/0x30
> kernel:  ? __rb_reserve_next+0x5f/0x490
> kernel:  ? _raw_spin_lock+0x1b/0x50
> kernel:  __lock_acquire+0x464/0x1990
> kernel:  ? mark_held_locks+0x4e/0x80
> kernel:  lock_acquire+0xc7/0x2d0
> kernel:  ? ftrace_regs_caller_end+0x66/0x66
> kernel:  ? ftrace_return_to_handler+0x8b/0x100
> kernel:  ? preempt_count_add+0x4/0x70
> kernel:  _raw_spin_lock+0x36/0x50
> kernel:  ? ftrace_regs_caller_end+0x66/0x66
> kernel:  ? ftrace_regs_caller_end+0x66/0x66
> kernel:  ieee80211_tx_dequeue+0xb4/0x1330 [mac80211]
> kernel:  ? prepare_ftrace_return+0xc5/0x190
> kernel:  ? ftrace_graph_func+0x16/0x20
> kernel:  ? 0xffffffffc02ab0b1
> kernel:  ? lock_acquire+0xc7/0x2d0
> kernel:  ? iwl_mvm_mac_itxq_xmit+0x42/0x210 [iwlmvm]
> kernel:  ? ieee80211_tx_dequeue+0x9/0x1330 [mac80211]
> kernel:  ? __rcu_read_lock+0x4/0x40
> kernel:  ? ftrace_regs_caller_end+0x66/0x66
> kernel:  iwl_mvm_mac_itxq_xmit+0xae/0x210 [iwlmvm]
> kernel:  ? ftrace_regs_caller_end+0x66/0x66
> kernel:  iwl_mvm_queue_state_change+0x311/0x3a0 [iwlmvm]
> kernel:  ? ftrace_regs_caller_end+0x66/0x66
> kernel:  iwl_mvm_wake_sw_queue+0x17/0x20 [iwlmvm]
> kernel:  ? ftrace_regs_caller_end+0x66/0x66
> kernel:  iwl_txq_gen2_unmap+0x1c9/0x1f0 [iwlwifi]
> kernel:  ? ftrace_regs_caller_end+0x66/0x66
> kernel:  iwl_txq_gen2_free+0x55/0x130 [iwlwifi]
> kernel:  ? ftrace_regs_caller_end+0x66/0x66
> kernel:  iwl_txq_gen2_tx_free+0x63/0x80 [iwlwifi]
> kernel:  ? ftrace_regs_caller_end+0x66/0x66
> kernel:  _iwl_trans_pcie_gen2_stop_device+0x3f3/0x5b0 [iwlwifi]
> kernel:  ? _iwl_trans_pcie_gen2_stop_device+0x9/0x5b0 [iwlwifi]
> kernel:  ? mutex_lock_nested+0x4/0x30
> kernel:  ? ftrace_regs_caller_end+0x66/0x66
> kernel:  iwl_trans_pcie_gen2_stop_device+0x5f/0x90 [iwlwifi]
> kernel:  ? ftrace_regs_caller_end+0x66/0x66
> kernel:  iwl_mvm_stop_device+0x78/0xd0 [iwlmvm]
> kernel:  ? ftrace_regs_caller_end+0x66/0x66
> kernel:  __iwl_mvm_mac_start+0x114/0x210 [iwlmvm]
> kernel:  ? ftrace_regs_caller_end+0x66/0x66
> kernel:  iwl_mvm_mac_start+0x76/0x150 [iwlmvm]
> kernel:  ? ftrace_regs_caller_end+0x66/0x66
> kernel:  drv_start+0x79/0x180 [mac80211]
> kernel:  ? ftrace_regs_caller_end+0x66/0x66
> kernel:  ieee80211_reconfig+0x1523/0x1ce0 [mac80211]
> kernel:  ? synchronize_net+0x4/0x50
> kernel:  ? ftrace_regs_caller_end+0x66/0x66
> kernel:  ieee80211_restart_work+0x108/0x170 [mac80211]
> kernel:  ? ftrace_regs_caller_end+0x66/0x66
> kernel:  process_one_work+0x250/0x530
> kernel:  ? ftrace_regs_caller_end+0x66/0x66
> kernel:  worker_thread+0x48/0x3a0
> kernel:  ? __pfx_worker_thread+0x10/0x10
> kernel:  kthread+0x10f/0x140
> kernel:  ? __pfx_kthread+0x10/0x10
> kernel:  ret_from_fork+0x29/0x50
> kernel:  </TASK>
> 
> Fixes: 4444bc2116ae ("wifi: mac80211: Proper mark iTXQs for resumption")
> Link: https://lore.kernel.org/all/1f58a0d1-d2b9-d851-73c3-93fcc607501c@alu.unizg.hr/
> Reported-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> Cc: Gregory Greenman <gregory.greenman@intel.com>
> Cc: Johannes Berg <johannes.berg@intel.com>
> Link: https://lore.kernel.org/all/cdc80531-f25f-6f9d-b15f-25e16130b53a@alu.unizg.hr/
> Cc: David S. Miller <davem@davemloft.net>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Leon Romanovsky <leon@kernel.org>
> Cc: Alexander Wetzel <alexander@wetzel-home.de>
> Signed-off-by: Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
> ---
> v3 -> v4:
> - Added whole lockdep trace as advised.
> - Trimmed irrelevant line prefix.
> v2 -> v3:
> - Fix the Fixes: tag as advised.
> - Change the net: to wifi: to comply with the original patch that
>   is being fixed.
> v1 -> v2:
> - Minor rewording and clarification.
> - Cc:-ed people that replied to the original bug report (forgotten
>   in v1 by omission).
> 
>  net/mac80211/tx.c | 5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 

Thanks,
Reviewed-by: Leon Romanovsky <leonro@nvidia.com>
