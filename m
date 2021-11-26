Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CA7F045EC98
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Nov 2021 12:25:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239120AbhKZL2Y (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 26 Nov 2021 06:28:24 -0500
Received: from alexa-out-sd-01.qualcomm.com ([199.106.114.38]:38441 "EHLO
        alexa-out-sd-01.qualcomm.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1347196AbhKZL0W (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 26 Nov 2021 06:26:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1637925790; x=1669461790;
  h=message-id:date:mime-version:subject:from:to:cc:
   references:in-reply-to:content-transfer-encoding;
  bh=V4+AK6VXBo3F5RNiqfvuyhEYvT++34wr2Tfh1MZf108=;
  b=taFKdclvY4WVu+Kd+9JwmzNkeLTy3ajLZRiM27wI4BzaQ2emN4owW2Aw
   s75tVavKa6mAxLHEDthV3ZHjhGa+By4NDsXI6JP2lHQMdGqt7LefrxYN1
   s96AaSanC7ObCL5orEm/3B9WC+byGtU3zyqNOqUV7jOOHtsxtO/TAcQxh
   M=;
Received: from unknown (HELO ironmsg-SD-alpha.qualcomm.com) ([10.53.140.30])
  by alexa-out-sd-01.qualcomm.com with ESMTP; 26 Nov 2021 03:23:09 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-SD-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2021 03:23:09 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Fri, 26 Nov 2021 03:23:08 -0800
Received: from [10.231.195.37] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.922.19; Fri, 26 Nov
 2021 03:23:07 -0800
Message-ID: <84a96041-bb32-49b6-4c90-a81c918fa486@quicinc.com>
Date:   Fri, 26 Nov 2021 19:23:05 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH v2 0/2] ath11k: add 11d scan offload support for
 QCA6390/WCN6855
Content-Language: en-US
From:   Wen Gong <quic_wgong@quicinc.com>
To:     Kalle Valo <kvalo@codeaurora.org>
CC:     <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>
References: <20211118100557.9029-1-quic_wgong@quicinc.com>
 <87wnl08jcy.fsf@codeaurora.org>
 <6cd986ed-8fa7-895e-2d9f-67886f9f8083@quicinc.com>
In-Reply-To: <6cd986ed-8fa7-895e-2d9f-67886f9f8083@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi Kalle,

I read the 2 patches of "11d scan offload" again, not found it will 
introduce this new lockdep directly.

Could you tell what the steps/operation in your test?

I can try to reproduce it after enable the lockdep config.

On 11/25/2021 7:01 PM, Wen Gong wrote:
> Hi Kalle,
>
> I am afraid you hit same issue of below patch, they looks similar, but 
> I am not sure they are the same root cause.
>
> https://patchwork.kernel.org/project/linux-wireless/patch/1608617166-17180-1-git-send-email-wgong@codeaurora.org/ 
>
>
> [RFC] ath11k: fix blocked for more than 120 seconds caused by reg update
>
> On 11/22/2021 8:28 PM, Kalle Valo wrote:
>> Wen Gong <quic_wgong@quicinc.com> writes:
>>
>>> v2:
>>>     1. rebased to latest ath.git master ath-202111170737
>>>     2. add "ath11k: add configure country code for QCA6390 and 
>>> WCN6855", it is needed for
>>>        patch "ath11k: add 11d scan offload support"
>>>
>>> Wen Gong (2):
>>>    ath11k: add configure country code for QCA6390 and WCN6855
>>>    ath11k: add 11d scan offload support
>>>
>>>   drivers/net/wireless/ath/ath11k/core.c |  30 +++++
>>>   drivers/net/wireless/ath/ath11k/core.h |   9 ++
>>>   drivers/net/wireless/ath/ath11k/mac.c  | 162 
>>> ++++++++++++++++++++++++-
>>>   drivers/net/wireless/ath/ath11k/mac.h  |   7 ++
>>>   drivers/net/wireless/ath/ath11k/pci.c  |   1 +
>>>   drivers/net/wireless/ath/ath11k/reg.c  |  15 +++
>>>   drivers/net/wireless/ath/ath11k/wmi.c  | 145 ++++++++++++++++++++++
>>>   drivers/net/wireless/ath/ath11k/wmi.h  |  39 ++++++
>>>   8 files changed, 407 insertions(+), 1 deletion(-)
>> I suspect this patch adds a new lockdep warning on my NUC testbox.
>>
>> Tag:    ath-202111221111
>>
>> [   87.034989] ath11k_pci 0000:06:00.0: MSI vectors: 32
>> [   87.035059] ath11k_pci 0000:06:00.0: qca6390 hw2.0
>> [   87.684032] ath11k_pci 0000:06:00.0: chip_id 0x0 chip_family 0xb 
>> board_id 0xff soc_id 0xffffffff
>> [   87.684277] ath11k_pci 0000:06:00.0: fw_version 0x101c06cc 
>> fw_build_timestamp 2020-06-24 19:50 fw_build
>>
>> [...]
>>
>> [  527.024672] ======================================================
>> [  527.024708] WARNING: possible circular locking dependency detected
>> [  527.024746] 5.16.0-rc1-wt-ath+ #528 Not tainted
>> [  527.024785] ------------------------------------------------------
>> [  527.024819] wpa_supplicant/2309 is trying to acquire lock:
>> [  527.024857] ffff88811fe6f148 ((wq_completion)phy0){+.+.}-{0:0}, 
>> at: flush_workqueue+0xd9/0x1340
>> [  527.024901]
>>                 but task is already holding lock:
>> [  527.024934] ffff8881563b07d0 (&rdev->wiphy.mtx){+.+.}-{3:3}, at: 
>> ieee80211_stop+0xa0/0x680 [mac80211]
>> [  527.025023]
>>                 which lock already depends on the new lock.
>>
>> [  527.025058]
>>                 the existing dependency chain (in reverse order) is:
>> [  527.025091]
>>                 -> #3 (&rdev->wiphy.mtx){+.+.}-{3:3}:
>> [  527.025129]        __lock_acquire+0xb72/0x1870
>> [  527.025166]        lock_acquire.part.0+0x117/0x340
>> [  527.025219]        __mutex_lock+0x15a/0x1610
>> [  527.025267]        reg_process_self_managed_hints+0x5e/0x130 
>> [cfg80211]
>> [  527.025343]        wiphy_register+0x1607/0x2640 [cfg80211]
>> [  527.025409]        ieee80211_register_hw+0x17d5/0x3150 [mac80211]
>> [  527.025481]        __ath11k_mac_register+0x1944/0x25c0 [ath11k]
>> [  527.025530]        ath11k_mac_register+0x2ee/0x610 [ath11k]
>> [  527.025578] ath11k_core_qmi_firmware_ready.part.0+0x9e/0x2b0 [ath11k]
>> [  527.025626]        ath11k_qmi_driver_event_work+0x49c/0xa80 [ath11k]
>> [  527.025674]        process_one_work+0x866/0x1490
>> [  527.026142]        worker_thread+0x596/0x1010
>> [  527.026180]        kthread+0x35d/0x420
>> [  527.026247]        ret_from_fork+0x22/0x30
>> [  527.026282]
>>                 -> #2 (rtnl_mutex){+.+.}-{3:3}:
>> [  527.026319]        __lock_acquire+0xb72/0x1870
>> [  527.026355]        lock_acquire.part.0+0x117/0x340
>> [  527.026388]        __mutex_lock+0x15a/0x1610
>> [  527.026423]        ath11k_regd_update+0x1ce/0x580 [ath11k]
>> [  527.026471]        process_one_work+0x866/0x1490
>> [  527.026505]        worker_thread+0x596/0x1010
>> [  527.026540]        kthread+0x35d/0x420
>> [  527.026574]        ret_from_fork+0x22/0x30
>> [  527.026608]
>>                 -> #1 
>> ((work_completion)(&ar->regd_update_work)){+.+.}-{0:0}:
>> [  527.026645]        __lock_acquire+0xb72/0x1870
>> [  527.026679]        lock_acquire.part.0+0x117/0x340
>> [  527.026714]        process_one_work+0x7f6/0x1490
>> [  527.026748]        worker_thread+0x596/0x1010
>> [  527.026782]        kthread+0x35d/0x420
>> [  527.026814]        ret_from_fork+0x22/0x30
>> [  527.026848]
>>                 -> #0 ((wq_completion)phy0){+.+.}-{0:0}:
>> [  527.026883]        check_prev_add+0x15e/0x20f0
>> [  527.026917]        validate_chain+0xf7f/0x1b30
>> [  527.026957]        __lock_acquire+0xb72/0x1870
>> [  527.026992]        lock_acquire.part.0+0x117/0x340
>> [  527.027026]        flush_workqueue+0xfc/0x1340
>> [  527.027061]        ieee80211_stop_device+0x50/0x60 [mac80211]
>> [  527.027142]        ieee80211_do_stop+0x11cf/0x1a20 [mac80211]
>> [  527.027248]        ieee80211_stop+0xad/0x680 [mac80211]
>> [  527.027322]        __dev_close_many+0x18f/0x2a0
>> [  527.027357]        __dev_change_flags+0x264/0x680
>> [  527.027391]        dev_change_flags+0x86/0x150
>> [  527.027425]        devinet_ioctl+0xfbb/0x18f0
>> [  527.027460]        inet_ioctl+0x2ae/0x2f0
>> [  527.027493]        sock_do_ioctl+0xd5/0x1d0
>> [  527.027527]        sock_ioctl+0x1c1/0x570
>> [  527.027561]        __x64_sys_ioctl+0x122/0x190
>> [  527.027598]        do_syscall_64+0x3b/0x90
>> [  527.027631]        entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [  527.027666]
>>                 other info that might help us debug this:
>>
>> [  527.027700] Chain exists of:
>>                   (wq_completion)phy0 --> rtnl_mutex --> 
>> &rdev->wiphy.mtx
>>
>> [  527.027739]  Possible unsafe locking scenario:
>>
>> [  527.027772]        CPU0                    CPU1
>> [  527.027808]        ----                    ----
>> [  527.027841]   lock(&rdev->wiphy.mtx);
>> [  527.027880]                                lock(rtnl_mutex);
>> [  527.027916] lock(&rdev->wiphy.mtx);
>> [  527.027950]   lock((wq_completion)phy0);
>> [  527.027984]
>>                  *** DEADLOCK ***
>>
>> [  527.028017] 2 locks held by wpa_supplicant/2309:
>> [  527.028051]  #0: ffffffff8ff3cb70 (rtnl_mutex){+.+.}-{3:3}, at: 
>> devinet_ioctl+0x182/0x18f0
>> [  527.029006]  #1: ffff8881563b07d0 (&rdev->wiphy.mtx){+.+.}-{3:3}, 
>> at: ieee80211_stop+0xa0/0x680 [mac80211]
>> [  527.029087]
>>                 stack backtrace:
>> [  527.029121] CPU: 6 PID: 2309 Comm: wpa_supplicant Kdump: loaded 
>> Not tainted 5.16.0-rc1-wt-ath+ #528
>> [  527.029158] Hardware name: Intel(R) Client Systems 
>> NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
>> [  527.029211] Call Trace:
>> [  527.029246]  <TASK>
>> [  527.029292]  dump_stack_lvl+0x57/0x7d
>> [  527.029328]  check_noncircular+0x26a/0x310
>> [  527.029363]  ? print_circular_bug+0x450/0x450
>> [  527.029403]  ? __kernel_text_address+0x9/0x30
>> [  527.029439]  ? alloc_chain_hlocks+0x1de/0x530
>> [  527.029474]  check_prev_add+0x15e/0x20f0
>> [  527.029511]  ? __lock_acquire+0xb72/0x1870
>> [  527.029547]  validate_chain+0xf7f/0x1b30
>> [  527.029583]  ? check_prev_add+0x20f0/0x20f0
>> [  527.029618]  ? __lock_release+0x4bd/0x9f0
>> [  527.029655]  __lock_acquire+0xb72/0x1870
>> [  527.029691]  lock_acquire.part.0+0x117/0x340
>> [  527.029727]  ? flush_workqueue+0xd9/0x1340
>> [  527.029763]  ? rcu_read_unlock+0x40/0x40
>> [  527.029799]  ? rcu_read_lock_sched_held+0x3a/0x70
>> [  527.029833]  ? lock_acquire+0x1a8/0x210
>> [  527.029868]  ? flush_workqueue+0xd9/0x1340
>> [  527.029903]  flush_workqueue+0xfc/0x1340
>> [  527.029936]  ? flush_workqueue+0xd9/0x1340
>> [  527.029970]  ? mark_held_locks+0xa5/0xe0
>> [  527.030009]  ? lockdep_hardirqs_on_prepare.part.0+0x18c/0x370
>> [  527.030044]  ? check_flush_dependency+0x350/0x350
>> [  527.030082]  ? ath11k_mac_op_remove_interface+0x58b/0xa20 [ath11k]
>> [  527.030131]  ? ieee80211_stop_device+0x50/0x60 [mac80211]
>> [  527.030241]  ieee80211_stop_device+0x50/0x60 [mac80211]
>> [  527.030321]  ieee80211_do_stop+0x11cf/0x1a20 [mac80211]
>> [  527.030397]  ? mutex_lock_io_nested+0x1470/0x1470
>> [  527.030436]  ? lock_downgrade+0x130/0x130
>> [  527.030473]  ? ieee80211_adjust_monitor_flags+0x1f0/0x1f0 [mac80211]
>> [  527.030547]  ? mark_held_locks+0xa5/0xe0
>> [  527.030583]  ? lockdep_hardirqs_on_prepare.part.0+0x18c/0x370
>> [  527.030618]  ? __local_bh_enable_ip+0xa0/0x110
>> [  527.030654]  ieee80211_stop+0xad/0x680 [mac80211]
>> [  527.030728]  __dev_close_many+0x18f/0x2a0
>> [  527.030764]  ? unregister_netdevice_notifier+0x150/0x150
>> [  527.030799]  ? lockdep_hardirqs_on_prepare.part.0+0x18c/0x370
>> [  527.030834]  ? __local_bh_enable_ip+0xa0/0x110
>> [  527.030869]  __dev_change_flags+0x264/0x680
>> [  527.030903]  ? dev_set_allmulti+0x10/0x10
>> [  527.030940]  dev_change_flags+0x86/0x150
>> [  527.030976]  devinet_ioctl+0xfbb/0x18f0
>> [  527.031011]  inet_ioctl+0x2ae/0x2f0
>> [  527.031048]  ? inet_dgram_connect+0x220/0x220
>> [  527.031087]  ? lock_downgrade+0x130/0x130
>> [  527.032054]  ? __might_fault+0xb3/0x160
>> [  527.032090]  ? __might_fault+0xb3/0x160
>> [  527.032124]  ? _copy_to_user+0x94/0xb0
>> [  527.032160]  sock_do_ioctl+0xd5/0x1d0
>> [  527.032216]  ? put_user_ifreq+0x70/0x70
>> [  527.032279]  ? vfs_fileattr_set+0x930/0x930
>> [  527.032314]  ? selinux_file_ioctl+0x375/0x520
>> [  527.032350]  sock_ioctl+0x1c1/0x570
>> [  527.032385]  ? br_ioctl_call+0x90/0x90
>> [  527.032420]  ? __ia32_sys_sendmmsg+0xeb/0xf0
>> [  527.032454]  ? __sys_recvmsg_sock+0x10/0x10
>> [  527.032492]  __x64_sys_ioctl+0x122/0x190
>> [  527.032527]  do_syscall_64+0x3b/0x90
>> [  527.032562]  entry_SYSCALL_64_after_hwframe+0x44/0xae
>> [  527.032597] RIP: 0033:0x7fd37113850b
>> [  527.032636] Code: 0f 1e fa 48 8b 05 85 39 0d 00 64 c7 00 26 00 00 
>> 00 48 c7 c0 ff ff ff ff c3 66 0f 1f 44 00 00 f3 0f 1e fa b8 10 00 00 
>> 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 55 39 0d 00 f7 d8 64 
>> 89 01 48
>> [  527.032679] RSP: 002b:00007ffd0174b258 EFLAGS: 00000246 ORIG_RAX: 
>> 0000000000000010
>> [  527.032718] RAX: ffffffffffffffda RBX: 0000000000000000 RCX: 
>> 00007fd37113850b
>> [  527.032755] RDX: 00007ffd0174b260 RSI: 0000000000008914 RDI: 
>> 0000000000000008
>> [  527.032790] RBP: 0000000000000008 R08: 0000000000000007 R09: 
>> 00007fd37120cb80
>> [  527.032824] R10: 0000000000000007 R11: 0000000000000246 R12: 
>> 0000000000000000
>> [  527.032857] R13: 00005641e16bfa70 R14: 00007ffd0174b260 R15: 
>> 00005641e16b4840
>> [  527.032894]  </TASK>
>>
