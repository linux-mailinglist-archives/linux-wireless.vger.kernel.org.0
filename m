Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4CEC744D322
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Nov 2021 09:24:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232203AbhKKI1e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 11 Nov 2021 03:27:34 -0500
Received: from alexa-out-sd-02.qualcomm.com ([199.106.114.39]:6076 "EHLO
        alexa-out-sd-02.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229674AbhKKI1c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 11 Nov 2021 03:27:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1636619084; x=1668155084;
  h=message-id:date:mime-version:subject:to:cc:references:
   from:in-reply-to:content-transfer-encoding;
  bh=F1O4A7EVHWCQWbGNi02HY/1ru1Ba80riii6f4yk8K/g=;
  b=FqYoryZjhTwKZqcqtrnqbC2rqpBgDX5hWn5KReUGopCU0Rb9uWWPS/12
   5sfpBds2nyXq0jAmJHQwtQEopUFFTQJ++plr5fGgSdOTfg3e3tDgpdzdt
   p9N7WkWyP/PyS1bykVyyOYSWuPURO4AhKu45a5vAgHduKGr6Cyrj4evXF
   c=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 11 Nov 2021 00:24:44 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Nov 2021 00:24:43 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.7;
 Thu, 11 Nov 2021 00:24:42 -0800
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Thu, 11 Nov
 2021 00:24:41 -0800
Message-ID: <7dbaf91d-5413-1e6d-457d-d66603e05495@quicinc.com>
Date:   Thu, 11 Nov 2021 16:24:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [RFC] ath11k: fix blocked for more than 120 seconds caused by reg
 update
Content-Language: en-US
To:     <ath11k@lists.infradead.org>
CC:     <linux-wireless@vger.kernel.org>
References: <20211027091409.15315-1-quic_wgong@quicinc.com>
From:   Wen Gong <quic_wgong@quicinc.com>
In-Reply-To: <20211027091409.15315-1-quic_wgong@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

has anyone have comments/advise for this patch?

On 10/27/2021 5:14 PM, Wen Gong wrote:
> When WMI_REG_CHAN_LIST_CC_EVENTID arrived, ath11k queue regd_update_work
> to workqueue of mac80211, then ath11k_regd_update start to acquire the
> rtnl_mutex by rtnl_lock, if the lock is already acquired by other thread,
> then it is easy happen deadlock, it is very easy to happen that while
> it is in progress of wlan shut down.
>
> Below is 3 type of deadlock.
>
> Type 1:
> cfg80211_rfkill_set_block of thread A called rtnl_lock and acquired
> the rtnl_mutex, then ath11k_regd_update begin run in workqueue of
> mac80211, but it can not acquire the rtnl_mutex by rtnl_lock and enter
> sleep state. Then thread A continue run and called arrive function
> ieee80211_stop_device which flush_workqueue of mac80211, it is the same
> workqueue which is running ath11k_regd_update, so deadlock happened.
> Thread A wait all work complete in workqueue of mac80211, but the work
> of ath11k_regd_update is waiting Thread A release the rtnl_mutex.
>
> workqueue of ath11k_regd_update
> [  363.570365] INFO: task kworker/u16:3:240 blocked for more than 120 seconds.
> [  363.570369]       Tainted: G        W         5.7.0-rc7-wt-ath+ #3
> [  363.570372] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  363.570376] kworker/u16:3   D    0   240      2 0x80004000
> [  363.570412] Workqueue: phy0 ath11k_regd_update_work [ath11k]
> [  363.570415] Call Trace:
> [  363.570423]  __schedule+0x44e/0x6f0
> [  363.570432]  schedule+0x4a/0xb0
> [  363.570439]  schedule_preempt_disabled+0xa/0x10
> [  363.570446]  __mutex_lock.isra.9+0x260/0x4f0
> [  363.570472]  ? ath11k_regd_update+0x1f2/0x250 [ath11k]
> [  363.570494]  ath11k_regd_update+0x1f2/0x250 [ath11k]
> [  363.570504]  process_one_work+0x16c/0x3f0
> [  363.570510]  worker_thread+0x4c/0x440
> [  363.570516]  ? rescuer_thread+0x350/0x350
> [  363.570521]  kthread+0xf8/0x130
> [  363.570526]  ? kthread_unpark+0x70/0x70
> [  363.570535]  ret_from_fork+0x35/0x40
>
> Thread A
> [  363.570987] INFO: task gsd-rfkill:1517 blocked for more than 120 seconds.
> [  363.570991]       Tainted: G        W         5.7.0-rc7-wt-ath+ #3
> [  363.570994] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  363.570996] gsd-rfkill      D    0  1517   1149 0x00004000
> [  363.571001] Call Trace:
> [  363.571009]  __schedule+0x44e/0x6f0
> [  363.571016]  schedule+0x4a/0xb0
> [  363.571022]  schedule_timeout+0x1dd/0x2f0
> [  363.571033]  ? dev_printk+0x56/0x72
> [  363.571041]  wait_for_completion+0x95/0x100
> [  363.571048]  flush_workqueue+0x126/0x3d0
> [  363.571117]  ? ieee80211_stop_device+0x37/0x40 [mac80211]
> [  363.571168]  ieee80211_stop_device+0x37/0x40 [mac80211]
> [  363.571215]  ieee80211_do_stop+0x549/0x850 [mac80211]
> [  363.571261]  ieee80211_stop+0x16/0x20 [mac80211]
> [  363.571268]  __dev_close_many+0x9e/0x110
> [  363.571274]  dev_close_many+0x81/0x130
> [  363.571281]  dev_close.part.104+0x3e/0x70
> [  363.571334]  cfg80211_shutdown_all_interfaces+0x43/0xd0 [cfg80211]
> [  363.571373]  cfg80211_rfkill_set_block+0x22/0x30 [cfg80211]
> [  363.571380]  rfkill_set_block+0x93/0x150
> [  363.571387]  rfkill_fop_write+0x102/0x1a0
> [  363.571393]  vfs_write+0xb3/0x1b0
> [  363.571399]  ksys_write+0xc2/0xe0
> [  363.571408]  ? __x64_sys_poll+0xe9/0x130
> [  363.571415]  do_syscall_64+0x52/0x1e0
> [  363.571422]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> Type 2:
> It is same with type 1, thread A's ieee80211_do_stop of mac80211 flush
> scan_work which is queued in workqueue of mac80211, but it not start
> run because ath11k_regd_update is running in the same workqueue and it
> is waiting rtnl_mutex which acquired by thread A, so deadlock happened.
>
> Thread A
> [  253.749270] INFO: task NetworkManager:1210 blocked for more than 120 seconds.
> [  253.749273]       Tainted: G        W         5.7.0-rc7-wt-ath+ #3
> [  253.749274] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  253.749275] NetworkManager  D    0  1210      1 0x00004004
> [  253.749278] Call Trace:
> [  253.749281]  __schedule+0x44e/0x6f0
> [  253.749284]  ? enqueue_entity+0xff/0x610
> [  253.749286]  schedule+0x4a/0xb0
> [  253.749289]  schedule_timeout+0x1dd/0x2f0
> [  253.749292]  ? check_preempt_curr+0x50/0x90
> [  253.749294]  ? ttwu_do_wakeup+0x19/0x150
> [  253.749297]  wait_for_completion+0x95/0x100
> [  253.749300]  __flush_work+0x126/0x1d0
> [  253.749302]  ? worker_detach_from_pool+0xa0/0xa0
> [  253.749332]  ieee80211_do_stop+0x831/0x850 [mac80211]
> [  253.749358]  ieee80211_stop+0x16/0x20 [mac80211]
> [  253.749361]  __dev_close_many+0x9e/0x110
> [  253.749364]  __dev_change_flags+0xc1/0x1c0
> [  253.749368]  dev_change_flags+0x23/0x60
> [  253.749370]  do_setlink+0x373/0xe70
> [  253.749377]  ? __nla_validate_parse.part.6+0x53/0x970
> [  253.749379]  ? cpumask_next+0x16/0x20
> [  253.749384]  ? __snmp6_fill_stats64.isra.47+0x68/0x110
> [  253.749387]  __rtnl_newlink+0x553/0x860
> [  253.749391]  ? __nla_reserve+0x38/0x50
> [  253.749393]  ? __nla_put+0xc/0x20
> [  253.749396]  ? nla_put+0x2f/0x40
> [  253.749400]  ? __kmalloc_node_track_caller+0x58/0x300
> [  253.749402]  ? __nla_reserve+0x38/0x50
> [  253.749406]  ? __kmalloc_reserve.isra.55+0x2e/0x80
> [  253.749410]  ? security_sock_rcv_skb+0x34/0x50
> [  253.749412]  ? sk_filter_trim_cap+0x41/0x1f0
> [  253.749416]  ? netlink_attachskb+0x1ac/0x210
> [  253.749418]  ? skb_queue_tail+0x1b/0x50
> [  253.749423]  ? _cond_resched+0x16/0x40
> [  253.749427]  ? kmem_cache_alloc_trace+0x1ab/0x230
> [  253.749430]  rtnl_newlink+0x43/0x60
> [  253.749432]  rtnetlink_rcv_msg+0x289/0x340
> [  253.749436]  ? __wake_up_common+0x8c/0x130
> [  253.749438]  ? _cond_resched+0x16/0x40
> [  253.749440]  ? __kmalloc_node_track_caller+0x58/0x300
> [  253.749442]  ? rtnl_calcit.isra.33+0x120/0x120
> [  253.749444]  netlink_rcv_skb+0xd1/0x110
> [  253.749447]  netlink_unicast+0x203/0x310
> [  253.749449]  netlink_sendmsg+0x30f/0x450
> [  253.749455]  sock_sendmsg+0x5b/0x60
> [  253.749458]  ____sys_sendmsg+0x219/0x240
> [  253.749461]  ? copy_msghdr_from_user+0x5c/0x90
> [  253.749463]  ? enqueue_task_fair+0xa2/0x570
> [  253.749465]  ___sys_sendmsg+0x88/0xd0
> [  253.749470]  ? futex_wake+0x78/0x160
> [  253.749473]  ? do_futex+0x4fe/0xb80
> [  253.749476]  ? __wake_up_common+0x8c/0x130
> [  253.749478]  ? __sys_sendmsg+0x63/0xa0
> [  253.749480]  __sys_sendmsg+0x63/0xa0
> [  253.749484]  ? ksys_write+0x81/0xe0
> [  253.749489]  do_syscall_64+0x52/0x1e0
> [  253.749492]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> workqueue of ath11k_regd_update
> [  253.749849] INFO: task kworker/u32:26:5833 blocked for more than 120 seconds.
> [  253.749850]       Tainted: G        W         5.7.0-rc7-wt-ath+ #3
> [  253.749851] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [  253.749853] kworker/u32:26  D    0  5833      2 0x80004000
> [  253.749869] Workqueue: phy0 ath11k_regd_update_work [ath11k]
> [  253.749870] Call Trace:
> [  253.749873]  __schedule+0x44e/0x6f0
> [  253.749875]  ? __switch_to_asm+0x40/0x70
> [  253.749878]  schedule+0x4a/0xb0
> [  253.749880]  schedule_preempt_disabled+0xa/0x10
> [  253.749882]  __mutex_lock.isra.9+0x260/0x4f0
> [  253.749884]  ? __switch_to_asm+0x40/0x70
> [  253.749887]  ? __switch_to_asm+0x34/0x70
> [  253.749889]  ? __switch_to_asm+0x34/0x70
> [  253.749892]  ? __switch_to_asm+0x40/0x70
> [  253.749902]  ? ath11k_regd_update+0x156/0x250 [ath11k]
> [  253.749912]  ath11k_regd_update+0x156/0x250 [ath11k]
> [  253.749915]  process_one_work+0x16c/0x3f0
> [  253.749918]  worker_thread+0x4c/0x440
> [  253.749920]  ? rescuer_thread+0x350/0x350
> [  253.749922]  kthread+0xf8/0x130
> [  253.749923]  ? kthread_unpark+0x70/0x70
> [  253.749926]  ret_from_fork+0x22/0x40
>
> Type 3:
> rtnetlink_rcv_msg of thread C acquired rtnl_mutex and then arrive to
> ath11k_debug_get_fw_stats of ath11k, it then acquire the conf_mutex of
> ath11k, but is already acquired by thread B which is doing reset by
> ath11k_core_halt, then it cancel work of regd_update_work which is
> running in thread A, but thread A is sleep because the rtnl_mutex is
> acquired by thread C, so deadlock happened. It is thread A wait thread C
> release lock, meanwhile thread C wait thread B release lock, and thread
> B wait thread A.
>
> Thread A workqueue of ath11k_regd_update
> [ 3021.881737] INFO: task kworker/u16:4:264 blocked for more than 120 seconds.
> [ 3021.881739]       Tainted: G        W         5.7.0-rc7-wt-ath+ #3
> [ 3021.881740] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 3021.881741] kworker/u16:4   D    0   264      2 0x80004000
> [ 3021.881750] Workqueue: phy0 ath11k_regd_update_work [ath11k]
> [ 3021.881752] Call Trace:
> [ 3021.881756]  __schedule+0x44e/0x6f0
> [ 3021.881758]  ? __switch_to_asm+0x40/0x70
> [ 3021.881759]  schedule+0x4a/0xb0
> [ 3021.881761]  schedule_preempt_disabled+0xa/0x10
> [ 3021.881763]  __mutex_lock.isra.9+0x260/0x4f0
> [ 3021.881764]  ? __switch_to_asm+0x40/0x70
> [ 3021.881766]  ? __switch_to_asm+0x34/0x70
> [ 3021.881767]  ? __switch_to_asm+0x34/0x70
> [ 3021.881768]  ? __switch_to_asm+0x40/0x70
> [ 3021.881774]  ? ath11k_regd_update+0x156/0x250 [ath11k]
> [ 3021.881779]  ath11k_regd_update+0x156/0x250 [ath11k]
> [ 3021.881781]  process_one_work+0x16c/0x3f0
> [ 3021.881783]  worker_thread+0x4c/0x440
> [ 3021.881784]  ? rescuer_thread+0x350/0x350
> [ 3021.881785]  kthread+0xf8/0x130
> [ 3021.881787]  ? kthread_unpark+0x70/0x70
> [ 3021.881788]  ret_from_fork+0x35/0x40
>
> Thread B
> [ 3021.881937] INFO: task kworker/u16:5:2513 blocked for more than 120 seconds.
> [ 3021.881938]       Tainted: G        W         5.7.0-rc7-wt-ath+ #3
> [ 3021.881938] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 3021.881939] kworker/u16:5   D    0  2513      2 0x80004000
> [ 3021.881945] Workqueue: ath11k_wq ath11k_core_restart [ath11k]
> [ 3021.881945] Call Trace:
> [ 3021.881947]  __schedule+0x44e/0x6f0
> [ 3021.881949]  ? enqueue_entity+0xff/0x610
> [ 3021.881950]  schedule+0x4a/0xb0
> [ 3021.881951]  schedule_timeout+0x1dd/0x2f0
> [ 3021.881953]  ? check_preempt_curr+0x50/0x90
> [ 3021.881954]  ? ttwu_do_wakeup+0x19/0x150
> [ 3021.881956]  wait_for_completion+0x95/0x100
> [ 3021.881957]  __flush_work+0x126/0x1d0
> [ 3021.881958]  ? worker_detach_from_pool+0xa0/0xa0
> [ 3021.881960]  __cancel_work_timer+0x10c/0x190
> [ 3021.881962]  ? put_cpu_partial+0x99/0x100
> [ 3021.881966]  ath11k_core_halt+0x57/0xe0 [ath11k]
> [ 3021.881970]  ath11k_core_restart+0x2ca/0x390 [ath11k]
> [ 3021.881971]  process_one_work+0x16c/0x3f0
> [ 3021.881972]  worker_thread+0x4c/0x440
> [ 3021.881974]  ? rescuer_thread+0x350/0x350
> [ 3021.881975]  kthread+0xf8/0x130
> [ 3021.881976]  ? kthread_unpark+0x70/0x70
> [ 3021.881977]  ret_from_fork+0x35/0x40
>
> Thread C:
> [ 3021.881795] INFO: task NetworkManager:898 blocked for more than 120 seconds.
> [ 3021.881796]       Tainted: G        W         5.7.0-rc7-wt-ath+ #3
> [ 3021.881797] "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> [ 3021.881798] NetworkManager  D    0   898      1 0x00004000
> [ 3021.881799] Call Trace:
> [ 3021.881800]  __schedule+0x44e/0x6f0
> [ 3021.881802]  ? __switch_to_asm+0x40/0x70
> [ 3021.881803]  schedule+0x4a/0xb0
> [ 3021.881804]  schedule_preempt_disabled+0xa/0x10
> [ 3021.881806]  __mutex_lock.isra.9+0x260/0x4f0
> [ 3021.881811]  ? ath11k_debug_get_fw_stats+0x4b/0xf0 [ath11k]
> [ 3021.881816]  ath11k_debug_get_fw_stats+0x4b/0xf0 [ath11k]
> [ 3021.881821]  ath11k_mac_op_sta_statistics+0x184/0x1a0 [ath11k]
> [ 3021.881836]  sta_set_sinfo+0xab/0xb30 [mac80211]
> [ 3021.881849]  ieee80211_get_station+0x50/0x70 [mac80211]
> [ 3021.881867]  nl80211_get_station+0x8e/0x250 [cfg80211]
> [ 3021.881870]  genl_rcv_msg+0x1e5/0x420
> [ 3021.881873]  ? __rtnl_unlock+0x25/0x50
> [ 3021.881875]  ? netdev_run_todo+0x5d/0x2d0
> [ 3021.881876]  ? genl_family_rcv_msg_attrs_parse+0x120/0x120
> [ 3021.881878]  netlink_rcv_skb+0xd1/0x110
> [ 3021.881879]  genl_rcv+0x24/0x40
> [ 3021.881880]  netlink_unicast+0x203/0x310
> [ 3021.881882]  netlink_sendmsg+0x30f/0x450
> [ 3021.881884]  sock_sendmsg+0x5b/0x60
> [ 3021.881886]  ____sys_sendmsg+0x219/0x240
> [ 3021.881887]  ? copy_msghdr_from_user+0x5c/0x90
> [ 3021.881888]  ? ____sys_recvmsg+0xa7/0x1a0
> [ 3021.881890]  ___sys_sendmsg+0x88/0xd0
> [ 3021.881891]  ? copy_msghdr_from_user+0x5c/0x90
> [ 3021.881892]  ? ___sys_recvmsg+0x9e/0xd0
> [ 3021.881895]  ? poll_select_finish+0x210/0x210
> [ 3021.881897]  ? ep_poll+0x2da/0x430
> [ 3021.881898]  ? poll_select_finish+0x210/0x210
> [ 3021.881899]  ? __sys_sendmsg+0x63/0xa0
> [ 3021.881900]  __sys_sendmsg+0x63/0xa0
> [ 3021.881902]  ? do_epoll_wait+0x83/0xc0
> [ 3021.881904]  do_syscall_64+0x52/0x1e0
> [ 3021.881906]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
>
> This patch add max wait for 3 seconds for the rtnl_mutex, if not
> acquire until 3 seconds, then return fail. Then it not happen
> "blocked for more than 120 seconds" with this patch after do
> simulate test with command:"iw reg set;ifconfig wlan down
>
> This patch also add cond_resched while rtnl_trylock to avoid
> synchronize_rcu wait.
>
> It is very easy to happen synchronize_rcu wait ATH11K_MAX_REG_WAIT
> which is 3 seconds without add cond_resched.
>
> Test steps:
> 1. rmmod ath11k_pci
> 2. insmod ath11k_pci
> 3. dmesg show log: ath11k_pci 0000:05:00.0: rtnl acquire failed
>
> The reason is because when insmod ath11k_pci, wlan is up, then thread A
> systemd-udevd acquired rtnl_mutex and call dev_change_name with below
> call stack but meanwhile ath11k_regd_update is called from function
> __ath11k_mac_register of thread B. Function rtnl_trylock thread B
> failed every time until ATH11K_MAX_REG_WAIT which is 3 seconds, because
> rtnl_mutex is acquired by thread A before, meanwhile, dev_change_name
> of thread A called to synchronize_rcu, and it entered to sleep state
> until thread B exit rtnl_trylock, it is same time of ATH11K_MAX_REG_WAIT
> which is 3 seconds, after 3 seconds, ath11k_regd_update of thread B
> return with fail and lead __ath11k_mac_register fail, and function
> synchronize_rcu of thread A return.
>
> The wait of synchronize_rcu is because only CONFIG_PREEMPT_VOLUNTARY is
> enabled(not enabled PREEMPT and PREEMPT_RT), it lead schedule only
> happened when voluntarily preempt. Thread B called rtnl_trylock in
> loop until 3 seconds, it not happened voluntarily preempt and no
> schedule in the 3 seconds, and synchronize_rcu need wait schedule
> happened on all cpus. Schedule on the cpu of thread B happened 3
> seconds later, it lead synchronize_rcu wait 3 seconds for thread B,
> then synchronize_rcu returned.
>
> Call stack of thread A
> [ 5158.606564] task:systemd-udevd   state:D stack:    0 pid: 3359 ppid:   283 flags:0x00004000
> [ 5158.606570] Call Trace:
> [ 5158.606585]  __schedule+0x2d0/0x7e0
> [ 5158.606594]  schedule+0x46/0xb0
> [ 5158.606599]  schedule_timeout+0x206/0x2b0
> [ 5158.606605]  ? kfree+0xae/0x210
> [ 5158.606609]  wait_for_completion+0x85/0xe0
> [ 5158.606615]  __wait_rcu_gp+0xfc/0x130
> [ 5158.606624]  synchronize_rcu+0x3e/0x50
> [ 5158.606629]  ? invoke_rcu_core+0x90/0x90
> [ 5158.606632]  ? __bpf_trace_rcu_utilization+0x10/0x10
> [ 5158.606636]  dev_change_name+0x1c9/0x2e0
> [ 5158.606643]  do_setlink+0xc18/0xfc0
> [ 5158.606649]  ? __nla_validate_parse.part.7+0x44/0xaf0
> [ 5158.606654]  rtnl_setlink+0x107/0x160
> [ 5158.606669]  rtnetlink_rcv_msg+0x130/0x350
> [ 5158.606674]  ? mntput_no_expire+0x35/0x220
> [ 5158.606679]  ? _cond_resched+0x16/0x40
> [ 5158.606684]  ? rtnl_calcit.isra.36+0x100/0x100
> [ 5158.606691]  netlink_rcv_skb+0xb9/0xf0
> [ 5158.606698]  netlink_unicast+0x16a/0x270
> [ 5158.606703]  netlink_sendmsg+0x2e4/0x420
> [ 5158.606709]  sock_sendmsg+0x5b/0x60
> [ 5158.606713]  __sys_sendto+0xd8/0x150
> [ 5158.606723]  ? aa_sk_perm+0x3e/0x1f0
> [ 5158.606728]  ? netlink_getsockopt+0x1bf/0x250
> [ 5158.606734]  ? exit_to_user_mode_prepare+0x38/0x130
> [ 5158.606738]  __x64_sys_sendto+0x24/0x30
> [ 5158.606744]  do_syscall_64+0x33/0x80
> [ 5158.606750]  entry_SYSCALL_64_after_hwframe+0x44/0xa9
> [ 5158.606755] RIP: 0033:0x7f5a188f5ab3
> [ 5158.606757] Code: Unable to access opcode bytes at RIP 0x7f5a188f5a89.
> [ 5158.606760] RSP: 002b:00007ffde036f398 EFLAGS: 00000246 ORIG_RAX: 000000000000002c
> [ 5158.606763] RAX: ffffffffffffffda RBX: 0000560825157800 RCX: 00007f5a188f5ab3
> [ 5158.606765] RDX: 000000000000002c RSI: 0000560825130c90 RDI: 000000000000000f
> [ 5158.606767] RBP: 0000000000000d1f R08: 00007ffde036f450 R09: 0000000000000010
> [ 5158.606769] R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000006
> [ 5158.606771] R13: 0000560825130b80 R14: 000000000000000e R15: 0000560825144800
> [ 5158.606777] ath11k_pci 0000:05:00.0: rtnl acquire failed
>
> Below is time cost of synchronize_rcu called from dev_change_name.
> It is 3 seconds from dev_change_name_L67 to  dev_change_name_L69, this
> is time cost of synchronize_rcu in dev_change_name.
> log:
> systemd-udevd  3109 [003]   545.393423: probe:dev_change_name_L65: (ffffffffbb891b84)
> systemd-udevd  3109 [003]   545.393452: probe:dev_change_name_L65: (ffffffffbb891b8f)
> [  545.393339] ath11k_pci 0000:05:00.0 wls1: renamed from wlan0
> systemd-udevd  3109 [003]   545.393470: probe:dev_change_name_L67: (ffffffffbb891b94)
> [  548.398407] ath11k_pci 0000:05:00.0: rtnl acquire failed
> systemd-udevd  3109 [000]   548.406522: probe:dev_change_name_L69: (ffffffffbb891b99)
>
> After add cond_resched, the wait of 3 seconds by synchronize_rcu disappeared.
> log:
> systemd-udevd  3834 [001]  1918.635387: probe:dev_change_name_L65: (ffffffffbb891b84)
> systemd-udevd  3834 [001]  1918.635391: probe:dev_change_name_L65: (ffffffffbb891b8f)
> systemd-udevd  3834 [001]  1918.635395: probe:dev_change_name_L67: (ffffffffbb891b94)
> systemd-udevd  3834 [000]  1918.662665: probe:dev_change_name_L69: (ffffffffbb891b99)
>
> Tested-on: QCA6390 hw2.0 PCI WLAN.HST.1.0.1-01740-QCAHSTSWPLZ_V2_TO_X86-1
>
> Signed-off-by: Wen Gong <quic_wgong@quicinc.com>
> ---
>   drivers/net/wireless/ath/ath11k/reg.c | 19 ++++++++++++++++++-
>   1 file changed, 18 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/net/wireless/ath/ath11k/reg.c b/drivers/net/wireless/ath/ath11k/reg.c
> index a098684ee138..ac5149295355 100644
> --- a/drivers/net/wireless/ath/ath11k/reg.c
> +++ b/drivers/net/wireless/ath/ath11k/reg.c
> @@ -15,6 +15,7 @@
>   #define ETSI_WEATHER_RADAR_BAND_LOW		5590
>   #define ETSI_WEATHER_RADAR_BAND_HIGH		5650
>   #define ETSI_WEATHER_RADAR_BAND_CAC_TIMEOUT	600000
> +#define ATH11K_MAX_REG_WAIT	(3 * HZ)
>   
>   static const struct ieee80211_regdomain ath11k_world_regd = {
>   	.n_reg_rules = 3,
> @@ -227,6 +228,8 @@ int ath11k_regd_update(struct ath11k *ar, bool init)
>   	struct ieee80211_regdomain *regd, *regd_copy = NULL;
>   	int ret, regd_len, pdev_id;
>   	struct ath11k_base *ab;
> +	unsigned long before;
> +	int acquired;
>   
>   	ab = ar->ab;
>   	pdev_id = ar->pdev_idx;
> @@ -273,7 +276,21 @@ int ath11k_regd_update(struct ath11k *ar, bool init)
>   	if (ar->pending_11d)
>   		complete(&ar->finish_11d_scan);
>   
> -	rtnl_lock();
> +	before = jiffies;
> +	while (true) {
> +		acquired = rtnl_trylock();
> +		if (!acquired)
> +			cond_resched();
> +		if (acquired || time_after(jiffies, before + ATH11K_MAX_REG_WAIT))
> +			break;
> +	}
> +
> +	if (!acquired) {
> +		ret = -EBUSY;
> +		ath11k_warn(ar->ab, "rtnl acquire failed\n");
> +		goto err;
> +	}
> +
>   	wiphy_lock(ar->hw->wiphy);
>   
>   	if (ar->pending_11d)
