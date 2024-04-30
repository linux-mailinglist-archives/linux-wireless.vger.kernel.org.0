Return-Path: <linux-wireless+bounces-7042-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6C8DF8B74FB
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 13:55:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2317C284320
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 11:55:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C4E41448EE;
	Tue, 30 Apr 2024 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kTiNl6NE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3786813D267
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 11:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714478088; cv=none; b=AO+QNz6/U0NWVrNjfo8G8VBszXocDcYO/hs92BKqvxgAeaA0Y9aEICQsdXyMJ3ZOT4jbOa5BfZRwg1DMp/vGK5BCHg4sO92IQrm2rYbiDy9CA8E+BNcc2GqanQL3KiStaYPrqFiBo38jQZYi/T78xTfgoIwq9HtTPVjGNYYPD7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714478088; c=relaxed/simple;
	bh=IQWtCd719Zma38GyNLfnAamwXy6kp1a/4FMFeEHhtzg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=NNhJfqMOdldQY1YZkLZBC2h2d2+P/McLdDdH+JC/JHA6IYIX/1ID862GJsErpG7yivB43IIJ4fsR9QWZS2id5j+YCTQjwEDS/z4OGaTwvvDyoJGVWLE+8Nqj73ye0BmjkIU9e6lauhnOa9ZYFyht3K+sULcy6Cw63LsaJkavq0o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kTiNl6NE; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28182C4AF18;
	Tue, 30 Apr 2024 11:54:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714478088;
	bh=IQWtCd719Zma38GyNLfnAamwXy6kp1a/4FMFeEHhtzg=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=kTiNl6NEM7Qgz0+L6XhwQ7S9hIS0enhQYtzo0aStuQYsiW/x8EJDSQVpbIRHCwehf
	 SsZ4unjwafv+/PcuH8yBIOQ4nURQOn6FHlSO+n5q3edLU3bUvh00QGdiEq2kmtJEoU
	 06FPKPTir4QM/Ad5RiNJJ5OaHLX9kq7nzgquQ04FFiQjLzMAYrV6bwFussHp5ctq4c
	 mNpO8M5Hx+8u9JPwyMHvHXv/E8UmM8OgU4WvCVnhm4D6olp7I2mvBAlBZ2kjMoO9Hp
	 DaHflrfgmu72YWZGb7RMoGSHmPYkS8FBq5XtZh/tZZKfXquPCSYeajoJkevh9h54qE
	 WiQ4ieRN/cvpA==
From: Kalle Valo <kvalo@kernel.org>
To: Harshitha Prem <quic_hprem@quicinc.com>
Cc: ath12k@lists.infradead.org,  linux-wireless@vger.kernel.org
Subject: Re: [PATCH v2 0/8] wifi: ath12k: Introduce device group abstraction
References: <20240425055759.1181165-1-quic_hprem@quicinc.com>
Date: Tue, 30 Apr 2024 14:54:45 +0300
In-Reply-To: <20240425055759.1181165-1-quic_hprem@quicinc.com> (Harshitha
	Prem's message of "Thu, 25 Apr 2024 11:27:51 +0530")
Message-ID: <87le4voyka.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Harshitha Prem <quic_hprem@quicinc.com> writes:

> To support multi-link operation, multiple devices with different bands say
> 2 GHz or 5 GHz or 6 GHz can be combined together as a group and provide
> an abstraction to mac80211.
>
> Device group abstraction - when there are multiple devices that are
> connected by any means of communication interface between them, then these
> devices can be combined together as a single group using a group id to form
> a group abstraction. In ath12k driver, this abstraction would be named as
> ath12k_hw_group (ag).
>
> Please find below illustration of device group abstraction with two
> devices.
>
>                  Grouping of multiple devices (in future)
> +------------------------------------------------------------------------+
> |  +-------------------------------------+       +-------------------+   |
> |  |   +-----------+ | | +-----------+   |       |   +-----------+   |   |
> |  |   | ar (2GHz) | | | | ar (5GHz) |   |       |   | ar (6GHz) |   |   |
> |  |   +-----------+ | | +-----------+   |       |   +-----------+   |   |
> |  |          ath12k_base (ab)           |       | ath12k_base (ab)  |   |
> |  |         (Dual band device)          |       |                   |   |
> |  +-------------------------------------+       +-------------------+   |
> |                 ath12k_hw_group (ag) based on group id                 |
> +------------------------------------------------------------------------+
>
> Say for example, device 1 has two radios (2 GHz and 5 GHz band) and
> device 2 has one radio (6 GHz).
>
> In existing code -
>         device 1 will have two hardware abstractions hw1 (2 GHz) and hw2
>         (5 GHz) will be registered separately to mac80211 as phy0 and phy1
>         respectively. Similarly, device 2 will register its hw (6GHz) as
>         phy2 to mac80211.
>
> In future, with multi-link abstraction
>
>         combination 1 - Different group id for device1 and device 2
>                 Device 1 will create a single hardware abstraction hw1
>                 (2 GHz and  5 GHz) and will be registered to mac80211 as
>                 phy0. similarly, device 2 will register its hardware
>                 (6 GHz) to mac80211 as phy1.
>
>         combination 2 - Same group id for device1 and device 2
>                 Both device details are combined together as a group, say
>                 group1, with single hardware abstraction of radios 2 GHz,
>                 5 GHz and 6 GHz band details and will be registered to
>                 mac80211 as phy0.
>
> Add base infrastructure changes to add device grouping abstraction with
> a single device.
>
> This patch series brings the base code changes with following order:
>         1. Refactor existing code which would facilitate in introducing
>            device group abstraction.
>         2. Create a device group abstraction during device probe.
>         3. Start the device group only after QMI firmware ready event is
>            received for all the devices that are combined in the group.
>         4. Move the hardware abstractions (ath12k_hw - ah) from device
>            (ath12k_base - ab) to device group abstraction (ag) as it would
>            ease in having different combinations of group abstraction that
>            can be registered to mac80211.
>
>
> Depends-on:
>         [PATCH v2 0/3] wifi: ath12k: Refactor the hardware recovery
> 	procedures.
> 	Link - https://lore.kernel.org/ath12k/87a5ljt0p9.fsf@kernel.org/T/
>
> v2:
>  - Rebased to ToT
>
> Karthikeyan Periyasamy (8):
>   wifi: ath12k: Refactor core start api
>   wifi: ath12k: Add helpers to get or set ath12k_hw
>   wifi: ath12k: Add ath12k_get_num_hw api
>   wifi: ath12k: Introduce QMI firmware ready flag
>   wifi: ath12k: move ATH12K_FLAG_REGISTERED flag set to mac_register api
>   wifi: ath12k: Introduce device group abstraction
>   wifi: ath12k: refactor core start based on hardware group
>   wifi: ath12k: move ath12k_hw from per soc to group

I see a deadlock warning in master-pending branch (tag
ath-pending-202404291731) and based on manual bisect between patchsets
it seems to come from this patchset. Do note that I didn't look at the
patchset otherwise.

Here's the warning I see during rmmod with WCN7850 and I see it every
time:

[  147.211487] ======================================================
[  147.211547] WARNING: possible circular locking dependency detected
[  147.211599] 6.9.0-rc5-wt-ath+ #1403 Not tainted
[  147.211646] ------------------------------------------------------
[  147.211695] rmmod/1975 is trying to acquire lock:
[  147.211741] ffff888105c7f158 ((wq_completion)ath12k_qmi_driver_event){+.+.}-{0:0}, at: touch_wq_lockdep_map+0x46/0xf0
[  147.211815] #012[  147.211815] but task is already holding lock:
[  147.211864] ffff88810db290a8 (&ag->mutex_lock){+.+.}-{3:3}, at: ath12k_core_hw_group_destroy.part.0+0x26/0x290 [ath12k]
[  147.212003] #012[  147.212003] which lock already depends on the new lock.#012[  147.212003] 
[  147.212069] #012[  147.212069] the existing dependency chain (in reverse order) is:
[  147.212135] #012[  147.212135] -> #2 (&ag->mutex_lock){+.+.}-{3:3}:
[  147.212189]        __lock_acquire+0xd43/0x1dd0
[  147.212238]        lock_acquire+0x1b0/0x560
[  147.212280]        __mutex_lock+0x154/0x1430
[  147.212327]        mutex_lock_nested+0x16/0x20
[  147.212369]        ath12k_core_qmi_firmware_ready+0x9d/0x400 [ath12k]
[  147.212436]        ath12k_qmi_driver_event_work+0x4e9/0x6e0 [ath12k]
[  147.212507]        process_one_work+0x8a4/0x1980
[  147.212551]        worker_thread+0x715/0x1270
[  147.212594]        kthread+0x2fa/0x3f0
[  147.212636]        ret_from_fork+0x31/0x70
[  147.212679]        ret_from_fork_asm+0x11/0x20
[  147.212754] #012[  147.212754] -> #1 ((work_completion)(&ab->qmi.event_work)){+.+.}-{0:0}:
[  147.212828]        __lock_acquire+0xd43/0x1dd0
[  147.212885]        lock_acquire+0x1b0/0x560
[  147.213000]        process_one_work+0x82d/0x1980
[  147.213055]        worker_thread+0x715/0x1270
[  147.213779]        kthread+0x2fa/0x3f0
[  147.214529]        ret_from_fork+0x31/0x70
[  147.215291]        ret_from_fork_asm+0x11/0x20
[  147.216044] #012[  147.216044] -> #0 ((wq_completion)ath12k_qmi_driver_event){+.+.}-{0:0}:
[  147.217433]        check_prev_add+0x1bd/0x2330
[  147.218174]        validate_chain+0xf4e/0x1cf0
[  147.218853]        __lock_acquire+0xd43/0x1dd0
[  147.219589]        lock_acquire+0x1b0/0x560
[  147.220324]        touch_wq_lockdep_map+0x66/0xf0
[  147.221055]        __flush_workqueue+0xeb/0x1120
[  147.221731]        drain_workqueue+0xf5/0x320
[  147.222460]        destroy_workqueue+0xb2/0x920
[  147.223187]        ath12k_qmi_deinit_service+0x5a/0x1f0 [ath12k]
[  147.223876]        ath12k_core_hw_group_destroy.part.0+0x1f8/0x290 [ath12k]
[  147.224606]        ath12k_core_deinit+0x37/0x50 [ath12k]
[  147.225314]        ath12k_pci_remove+0xad/0x1b0 [ath12k]
[  147.226640]        pci_device_remove+0x9b/0x1b0
[  147.227326]        device_remove+0xbf/0x150
[  147.227986]        device_release_driver_internal+0x3c3/0x580
[  147.228619]        driver_detach+0xc4/0x190
[  147.229290]        bus_remove_driver+0x130/0x2a0
[  147.229900]        driver_unregister+0x68/0x90
[  147.230576]        pci_unregister_driver+0x24/0x240
[  147.231240]        ath12k_pci_exit+0x10/0x20 [ath12k]
[  147.231866]        __do_sys_delete_module+0x32c/0x580
[  147.232523]        __x64_sys_delete_module+0x4f/0x70
[  147.233168]        x64_sys_call+0x51b/0x9e0
[  147.233756]        do_syscall_64+0x65/0x130
[  147.234396]        entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  147.235023] #012[  147.235023] other info that might help us debug this:#012[  147.235023] 
[  147.236688] Chain exists of:#012[  147.236688]   (wq_completion)ath12k_qmi_driver_event --> (work_completion)(&ab->qmi.event_work) --> &ag->mutex_lock#012[  147.236688] 
[  147.238414]  Possible unsafe locking scenario:#012[  147.238414] 
[  147.239520]        CPU0                    CPU1
[  147.240114]        ----                    ----
[  147.240633]   lock(&ag->mutex_lock);
[  147.241212]                                lock((work_completion)(&ab->qmi.event_work));
[  147.241746]                                lock(&ag->mutex_lock);
[  147.242341]   lock((wq_completion)ath12k_qmi_driver_event);
[  147.242876] #012[  147.242876]  *** DEADLOCK ***#012[  147.242876] 
[  147.244460] 2 locks held by rmmod/1975:
[  147.245040]  #0: ffff88810d7191b8 (&dev->mutex){....}-{3:3}, at: device_release_driver_internal+0x9d/0x580
[  147.245597]  #1: ffff88810db290a8 (&ag->mutex_lock){+.+.}-{3:3}, at: ath12k_core_hw_group_destroy.part.0+0x26/0x290 [ath12k]
[  147.246230] #012[  147.246230] stack backtrace:
[  147.247338] CPU: 5 PID: 1975 Comm: rmmod Not tainted 6.9.0-rc5-wt-ath+ #1403
[  147.247900] Hardware name: Intel(R) Client Systems NUC8i7HVK/NUC8i7HVB, BIOS HNKBLi70.86A.0067.2021.0528.1339 05/28/2021
[  147.248545] Call Trace:
[  147.249181]  <TASK>
[  147.249757]  dump_stack_lvl+0x7d/0xe0
[  147.250401]  dump_stack+0x10/0x20
[  147.251031]  print_circular_bug+0x2e8/0x480
[  147.251606]  check_noncircular+0x2f2/0x3d0
[  147.252235]  ? print_circular_bug+0x480/0x480
[  147.252808]  ? validate_chain+0x15e/0x1cf0
[  147.253435]  ? __kasan_check_read+0x11/0x20
[  147.254065]  ? mark_lock+0xe6/0x1470
[  147.254636]  ? alloc_chain_hlocks+0x4cc/0x790
[  147.255265]  check_prev_add+0x1bd/0x2330
[  147.255839]  ? __kasan_check_read+0x11/0x20
[  147.256474]  validate_chain+0xf4e/0x1cf0
[  147.257104]  ? check_prev_add+0x2330/0x2330
[  147.257673]  __lock_acquire+0xd43/0x1dd0
[  147.258303]  lock_acquire+0x1b0/0x560
[  147.258875]  ? touch_wq_lockdep_map+0x46/0xf0
[  147.259502]  ? lock_sync+0x1a0/0x1a0
[  147.260131]  ? __lock_acquired+0x208/0x810
[  147.260699]  ? lockdep_init_map_type+0x1a3/0x850
[  147.261326]  ? lockdep_init_map_type+0x1a3/0x850
[  147.261892]  ? touch_wq_lockdep_map+0x46/0xf0
[  147.262513]  touch_wq_lockdep_map+0x66/0xf0
[  147.263126]  ? touch_wq_lockdep_map+0x46/0xf0
[  147.263684]  __flush_workqueue+0xeb/0x1120
[  147.264301]  ? drain_workqueue+0xae/0x320
[  147.264862]  ? drain_workqueue+0xae/0x320
[  147.265471]  ? __this_cpu_preempt_check+0x13/0x20
[  147.266086]  ? wq_update_node_max_active+0x540/0x540
[  147.266640]  ? destroy_workqueue+0xaa/0x920
[  147.267249]  ? __this_cpu_preempt_check+0x13/0x20
[  147.267806]  ? bit_wait_timeout+0x160/0x160
[  147.268420]  ? __kasan_check_write+0x14/0x20
[  147.269031]  drain_workqueue+0xf5/0x320
[  147.269586]  destroy_workqueue+0xb2/0x920
[  147.270202]  ath12k_qmi_deinit_service+0x5a/0x1f0 [ath12k]
[  147.270785]  ? debugfs_remove+0x52/0x60
[  147.271400]  ath12k_core_hw_group_destroy.part.0+0x1f8/0x290 [ath12k]
[  147.272046]  ath12k_core_deinit+0x37/0x50 [ath12k]
[  147.272628]  ath12k_pci_remove+0xad/0x1b0 [ath12k]
[  147.273271]  pci_device_remove+0x9b/0x1b0
[  147.273829]  device_remove+0xbf/0x150
[  147.274446]  device_release_driver_internal+0x3c3/0x580
[  147.275052]  ? __kasan_check_read+0x11/0x20
[  147.275592]  driver_detach+0xc4/0x190
[  147.276189]  bus_remove_driver+0x130/0x2a0
[  147.276728]  driver_unregister+0x68/0x90
[  147.277325]  pci_unregister_driver+0x24/0x240
[  147.277876]  ? find_module_all+0x13e/0x1e0
[  147.278469]  ath12k_pci_exit+0x10/0x20 [ath12k]
[  147.279087]  __do_sys_delete_module+0x32c/0x580
[  147.279626]  ? __kasan_slab_free+0x102/0x170
[  147.280209]  ? module_flags+0x2f0/0x2f0
[  147.280741]  ? kmem_cache_free+0xed/0x3e0
[  147.281334]  ? __fput+0x40c/0xa60
[  147.281870]  ? __fput+0x40c/0xa60
[  147.282462]  ? debug_smp_processor_id+0x17/0x20
[  147.283045]  __x64_sys_delete_module+0x4f/0x70
[  147.283558]  x64_sys_call+0x51b/0x9e0
[  147.284125]  do_syscall_64+0x65/0x130
[  147.284613]  entry_SYSCALL_64_after_hwframe+0x4b/0x53
[  147.285159] RIP: 0033:0x7f2df2adcc8b
[  147.286954] Code: 73 01 c3 48 8b 0d 05 c2 0c 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa b8 b0 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d d5 c1 0c 00 f7 d8 64 89 01 48
[  147.288033] RSP: 002b:00007ffdc52ca298 EFLAGS: 00000206 ORIG_RAX: 00000000000000b0
[  147.288563] RAX: ffffffffffffffda RBX: 000055d10d0237e0 RCX: 00007f2df2adcc8b
[  147.289155] RDX: 000000000000000a RSI: 0000000000000800 RDI: 000055d10d023848
[  147.289691] RBP: 00007ffdc52ca2f8 R08: 0000000000000000 R09: 0000000000000000
[  147.290292] R10: 00007f2df2b58ac0 R11: 0000000000000206 R12: 00007ffdc52ca4d0
[  147.290830] R13: 00007ffdc52caebf R14: 000055d10d0222a0 R15: 000055d10d0237e0
[  147.291444]  </TASK>

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

