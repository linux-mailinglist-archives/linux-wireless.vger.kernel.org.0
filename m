Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F01C4BE5AC
	for <lists+linux-wireless@lfdr.de>; Mon, 21 Feb 2022 19:01:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244307AbiBULFN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 21 Feb 2022 06:05:13 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355445AbiBULCv (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 21 Feb 2022 06:02:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D11B3D489
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 02:29:50 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3263FB80EF9
        for <linux-wireless@vger.kernel.org>; Mon, 21 Feb 2022 10:29:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 321FDC340E9;
        Mon, 21 Feb 2022 10:29:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645439388;
        bh=Igdikhyb2XvJ3fQB4QoJhgC7x9py83gP6jHUt09MnC0=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=QGAxy5ESa9QUzABBaHnUy869UvDUzRYWLcCouKsVd5Ey3xt3db2Zvw3SKMQLJWU5j
         nZCLbZbBkxEupScVjcX0/dEX+iNfKoYV8/+upXN6w67WTQCK/xWGG7UjGC5O327OXb
         qXHt4XDvIYWU0gtc/nFkzlmzOqXTmRSWrx8eAGyVQvBIGhaYp+fyvORVy3tuC1OSRn
         XyhxRCh78pNeEeINGiHhGkpAXU7kRdY1I9TZ9SisWZ/TSAs2Xdc4/R5VQM10rY+5y+
         6iDsU+BiEJx+4EFnUDYtFGqbDJESqoKhIo44gGmnyZgvyA+/lTMoOA6XwgpRliwc+c
         OK8UD2bOwJKrQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath11k: Fix frames flush failure caused by deadlock
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20220217084545.18844-1-quic_bqiang@quicinc.com>
References: <20220217084545.18844-1-quic_bqiang@quicinc.com>
To:     Baochen Qiang <quic_bqiang@quicinc.com>
Cc:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <164543938476.26423.17142635972047330239.kvalo@kernel.org>
Date:   Mon, 21 Feb 2022 10:29:47 +0000 (UTC)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> We are seeing below warnings:
> 
> kernel: [25393.301506] ath11k_pci 0000:01:00.0: failed to flush mgmt transmit queue 0
> kernel: [25398.421509] ath11k_pci 0000:01:00.0: failed to flush mgmt transmit queue 0
> kernel: [25398.421831] ath11k_pci 0000:01:00.0: dropping mgmt frame for vdev 0, is_started 0
> 
> this means ath11k fails to flush mgmt. frames because wmi_mgmt_tx_work
> has no chance to run in 5 seconds.
> 
> By setting /proc/sys/kernel/hung_task_timeout_secs to 20 and increasing
> ATH11K_FLUSH_TIMEOUT to 50 we get below warnings:
> 
> kernel: [  120.763160] INFO: task wpa_supplicant:924 blocked for more than 20 seconds.
> kernel: [  120.763169]       Not tainted 5.10.90 #12
> kernel: [  120.763177] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kernel: [  120.763186] task:wpa_supplicant  state:D stack:    0 pid:  924 ppid:     1 flags:0x000043a0
> kernel: [  120.763201] Call Trace:
> kernel: [  120.763214]  __schedule+0x785/0x12fa
> kernel: [  120.763224]  ? lockdep_hardirqs_on_prepare+0xe2/0x1bb
> kernel: [  120.763242]  schedule+0x7e/0xa1
> kernel: [  120.763253]  schedule_timeout+0x98/0xfe
> kernel: [  120.763266]  ? run_local_timers+0x4a/0x4a
> kernel: [  120.763291]  ath11k_mac_flush_tx_complete+0x197/0x2b1 [ath11k 13c3a9bf37790f4ac8103b3decf7ab4008ac314a]
> kernel: [  120.763306]  ? init_wait_entry+0x2e/0x2e
> kernel: [  120.763343]  __ieee80211_flush_queues+0x167/0x21f [mac80211 335da900954f1c5ea7f1613d92088ce83342042c]
> kernel: [  120.763378]  __ieee80211_recalc_idle+0x105/0x125 [mac80211 335da900954f1c5ea7f1613d92088ce83342042c]
> kernel: [  120.763411]  ieee80211_recalc_idle+0x14/0x27 [mac80211 335da900954f1c5ea7f1613d92088ce83342042c]
> kernel: [  120.763441]  ieee80211_free_chanctx+0x77/0xa2 [mac80211 335da900954f1c5ea7f1613d92088ce83342042c]
> kernel: [  120.763473]  __ieee80211_vif_release_channel+0x100/0x131 [mac80211 335da900954f1c5ea7f1613d92088ce83342042c]
> kernel: [  120.763540]  ieee80211_vif_release_channel+0x66/0x81 [mac80211 335da900954f1c5ea7f1613d92088ce83342042c]
> kernel: [  120.763572]  ieee80211_destroy_auth_data+0xa3/0xe6 [mac80211 335da900954f1c5ea7f1613d92088ce83342042c]
> kernel: [  120.763612]  ieee80211_mgd_deauth+0x178/0x29b [mac80211 335da900954f1c5ea7f1613d92088ce83342042c]
> kernel: [  120.763654]  cfg80211_mlme_deauth+0x1a8/0x22c [cfg80211 8945aa5bc2af5f6972336665d8ad6f9c191ad5be]
> kernel: [  120.763697]  nl80211_deauthenticate+0xfa/0x123 [cfg80211 8945aa5bc2af5f6972336665d8ad6f9c191ad5be]
> kernel: [  120.763715]  genl_rcv_msg+0x392/0x3c2
> kernel: [  120.763750]  ? nl80211_associate+0x432/0x432 [cfg80211 8945aa5bc2af5f6972336665d8ad6f9c191ad5be]
> kernel: [  120.763782]  ? nl80211_associate+0x432/0x432 [cfg80211 8945aa5bc2af5f6972336665d8ad6f9c191ad5be]
> kernel: [  120.763802]  ? genl_rcv+0x36/0x36
> kernel: [  120.763814]  netlink_rcv_skb+0x89/0xf7
> kernel: [  120.763829]  genl_rcv+0x28/0x36
> kernel: [  120.763840]  netlink_unicast+0x179/0x24b
> kernel: [  120.763854]  netlink_sendmsg+0x393/0x401
> kernel: [  120.763872]  sock_sendmsg+0x72/0x76
> kernel: [  120.763886]  ____sys_sendmsg+0x170/0x1e6
> kernel: [  120.763897]  ? copy_msghdr_from_user+0x7a/0xa2
> kernel: [  120.763914]  ___sys_sendmsg+0x95/0xd1
> kernel: [  120.763940]  __sys_sendmsg+0x85/0xbf
> kernel: [  120.763956]  do_syscall_64+0x43/0x55
> kernel: [  120.763966]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> kernel: [  120.763977] RIP: 0033:0x79089f3fcc83
> kernel: [  120.763986] RSP: 002b:00007ffe604f0508 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
> kernel: [  120.763997] RAX: ffffffffffffffda RBX: 000059b40e987690 RCX: 000079089f3fcc83
> kernel: [  120.764006] RDX: 0000000000000000 RSI: 00007ffe604f0558 RDI: 0000000000000009
> kernel: [  120.764014] RBP: 00007ffe604f0540 R08: 0000000000000004 R09: 0000000000400000
> kernel: [  120.764023] R10: 00007ffe604f0638 R11: 0000000000000246 R12: 000059b40ea04980
> kernel: [  120.764032] R13: 00007ffe604f0638 R14: 000059b40e98c360 R15: 00007ffe604f0558
> ...
> kernel: [  120.765230] INFO: task kworker/u32:26:4239 blocked for more than 20 seconds.
> kernel: [  120.765238]       Not tainted 5.10.90 #12
> kernel: [  120.765245] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> kernel: [  120.765253] task:kworker/u32:26  state:D stack:    0 pid: 4239 ppid:     2 flags:0x00004080
> kernel: [  120.765284] Workqueue: phy0 ieee80211_iface_work [mac80211]
> kernel: [  120.765295] Call Trace:
> kernel: [  120.765306]  __schedule+0x785/0x12fa
> kernel: [  120.765316]  ? find_held_lock+0x3d/0xb2
> kernel: [  120.765331]  schedule+0x7e/0xa1
> kernel: [  120.765340]  schedule_preempt_disabled+0x15/0x1e
> kernel: [  120.765349]  __mutex_lock_common+0x561/0xc0d
> kernel: [  120.765375]  ? ieee80211_sta_work+0x3e/0x1232 [mac80211 335da900954f1c5ea7f1613d92088ce83342042c]
> kernel: [  120.765390]  mutex_lock_nested+0x20/0x26
> kernel: [  120.765416]  ieee80211_sta_work+0x3e/0x1232 [mac80211 335da900954f1c5ea7f1613d92088ce83342042c]
> kernel: [  120.765430]  ? skb_dequeue+0x54/0x5e
> kernel: [  120.765456]  ? ieee80211_iface_work+0x7b/0x339 [mac80211 335da900954f1c5ea7f1613d92088ce83342042c]
> kernel: [  120.765485]  process_one_work+0x270/0x504
> kernel: [  120.765501]  worker_thread+0x215/0x376
> kernel: [  120.765514]  kthread+0x159/0x168
> kernel: [  120.765526]  ? pr_cont_work+0x5b/0x5b
> kernel: [  120.765536]  ? kthread_blkcg+0x31/0x31
> kernel: [  120.765550]  ret_from_fork+0x22/0x30
> ...
> kernel: [  120.765867] Showing all locks held in the system:
> ...
> kernel: [  120.766164] 5 locks held by wpa_supplicant/924:
> kernel: [  120.766172]  #0: ffffffffb1e63eb0 (cb_lock){++++}-{3:3}, at: genl_rcv+0x19/0x36
> kernel: [  120.766197]  #1: ffffffffb1e5b1c8 (rtnl_mutex){+.+.}-{3:3}, at: nl80211_pre_doit+0x2a/0x15c [cfg80211]
> kernel: [  120.766238]  #2: ffff99f08347cd08 (&wdev->mtx){+.+.}-{3:3}, at: nl80211_deauthenticate+0xde/0x123 [cfg80211]
> kernel: [  120.766279]  #3: ffff99f09df12a48 (&local->mtx){+.+.}-{3:3}, at: ieee80211_destroy_auth_data+0x9b/0xe6 [mac80211]
> kernel: [  120.766321]  #4: ffff99f09df12ce0 (&local->chanctx_mtx){+.+.}-{3:3}, at: ieee80211_vif_release_channel+0x5e/0x81 [mac80211]
> ...
> kernel: [  120.766585] 3 locks held by kworker/u32:26/4239:
> kernel: [  120.766593]  #0: ffff99f04458f948 ((wq_completion)phy0){+.+.}-{0:0}, at: process_one_work+0x19a/0x504
> kernel: [  120.766621]  #1: ffffbad54b3cfe50 ((work_completion)(&sdata->work)){+.+.}-{0:0}, at: process_one_work+0x1c0/0x504
> kernel: [  120.766649]  #2: ffff99f08347cd08 (&wdev->mtx){+.+.}-{3:3}, at: ieee80211_sta_work+0x3e/0x1232 [mac80211]
> 
> With above info the issue is clear: First wmi_mgmt_tx_work is inserted
> to local->workqueue after sdata->work inserted, then wpa_supplicant
> acquires wdev->mtx in nl80211_deauthenticate and finally calls
> ath11k_mac_op_flush where it waits all mgmt. frames to be sent out by
> wmi_mgmt_tx_work. Meanwhile, sdata->work is blocked by wdev->mtx in
> ieee80211_sta_work, as a result wmi_mgmt_tx_work has no chance to run.
> 
> Change to use ab->workqueue instead of local->workqueue to fix this issue.
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

261b07519518 ath11k: Fix frames flush failure caused by deadlock

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20220217084545.18844-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

