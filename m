Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 84D161ED1C2
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Jun 2020 16:10:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725937AbgFCOKq (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 3 Jun 2020 10:10:46 -0400
Received: from smail.rz.tu-ilmenau.de ([141.24.186.67]:60872 "EHLO
        smail.rz.tu-ilmenau.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725833AbgFCOKp (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 3 Jun 2020 10:10:45 -0400
Received: from [192.168.178.25] (unknown [87.147.49.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by smail.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 57D7A580247
        for <linux-wireless@vger.kernel.org>; Wed,  3 Jun 2020 16:10:40 +0200 (CEST)
To:     linux-wireless@vger.kernel.org
From:   Markus Theil <markus.theil@tu-ilmenau.de>
Subject: BUG: deadlock on flushing mgmt registrations update work
Autocrypt: addr=markus.theil@tu-ilmenau.de; keydata=
 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
 HbCBIiM=
Message-ID: <e8143f03-d4a7-16ee-2e9a-e8d676ffef6d@tu-ilmenau.de>
Date:   Wed, 3 Jun 2020 16:10:40 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

While running hostapd tests, the following deadlock showed up:

cfg80211_mgmt_registrations_update_wk locks the rtnl lock, which
is already hold by nl80211 when going into __cfg80211_unregister_wdev,
which flushes cfg80211_mgmt_registrations_update_wk.

[   22.500591] ======================================================
[   22.501296] WARNING: possible circular locking dependency detected
[   22.501992] 5.7.0-rc7-wt #2 Not tainted
[   22.502413] ------------------------------------------------------
[   22.503084] wpa_supplicant/797 is trying to acquire lock:
[   22.503680] ffff88800b29a9f8
((work_completion)(&wdev->mgmt_registrations_update_wk)){+.+.}-{0:0},
at: __flush_work+0x78/0xf0
[   22.504903]
               but task is already holding lock:
[   22.506668] ffffffff81e954f0 (rtnl_mutex){+.+.}-{3:3}, at:
nl80211_pre_doit+0xd7/0x1a0
[   22.507540]
               which lock already depends on the new lock.

[   22.508439]
               the existing dependency chain (in reverse order) is:
[   22.509333]
               -> #1 (rtnl_mutex){+.+.}-{3:3}:
[   22.509960]        __lock_acquire+0x3a1/0x6b0
[   22.510445]        lock_acquire+0xc3/0x420
[   22.510902]        __mutex_lock+0x85/0x820
[   22.511356]        cfg80211_mgmt_registrations_update_wk+0xe/0x20
[   22.512034]        process_one_work+0x261/0x5b0
[   22.512530]        worker_thread+0x4e/0x310
[   22.512991]        kthread+0x13d/0x160
[   22.513407]        ret_from_fork+0x27/0x50
[   22.513859]
               -> #0
((work_completion)(&wdev->mgmt_registrations_update_wk)){+.+.}-{0:0}:
[   22.514893]        check_prev_add+0x8e/0x9a0
[   22.515374]        validate_chain+0x441/0x700
[   22.515856]        __lock_acquire+0x3a1/0x6b0
[   22.519193]        lock_acquire+0xc3/0x420
[   22.524218]        __flush_work+0x98/0xf0
[   22.524664]        __cfg80211_unregister_wdev+0x9b/0x150
[   22.525260]        cfg80211_netdev_notifier_call+0x3a4/0x4ef
[   22.525874]        notifier_call_chain+0x46/0xb0
[   22.526657]        rollback_registered_many+0x275/0x4e0
[   22.528048]        unregister_netdevice_queue+0xcf/0x180
[   22.529184]        ieee80211_del_iface+0xe/0x20
[   22.529687]        nl80211_del_interface+0x64/0x150
[   22.532320]        genl_family_rcv_msg+0x189/0x3b0
[   22.533144]        genl_rcv_msg+0x47/0x90
[   22.533807]        netlink_rcv_skb+0x47/0x110
[   22.534474]        genl_rcv+0x24/0x40
[   22.535145]        netlink_unicast+0x191/0x250
[   22.536285]        netlink_sendmsg+0x207/0x420
[   22.539059]        ____sys_sendmsg+0x206/0x230
[   22.539948]        ___sys_sendmsg+0xab/0xf0
[   22.544879]        __sys_sendmsg+0x51/0x90
[   22.547945]        do_syscall_64+0x4f/0x260
[   22.548412]        entry_SYSCALL_64_after_hwframe+0x49/0xb3
[   22.549030]
               other info that might help us debug this:

[   22.549909]  Possible unsafe locking scenario:

[   22.550561]        CPU0                    CPU1
[   22.551061]        ----                    ----
[   22.555277]   lock(rtnl_mutex);
[   22.555631]                               
lock((work_completion)(&wdev->mgmt_registrations_update_wk));
[   22.557354]                                lock(rtnl_mutex);
[   22.558108]  
lock((work_completion)(&wdev->mgmt_registrations_update_wk));
[   22.559149]
                *** DEADLOCK ***

[   22.560215] 2 locks held by wpa_supplicant/797:
[   22.560713]  #0: ffffffff81e9d8d8 (cb_lock){++++}-{3:3}, at:
genl_rcv+0x15/0x40
[   22.561513]  #1: ffffffff81e954f0 (rtnl_mutex){+.+.}-{3:3}, at:
nl80211_pre_doit+0xd7/0x1a0
[   22.562427]
               stack backtrace:
[   22.562909] CPU: 2 PID: 797 Comm: wpa_supplicant Not tainted
5.7.0-rc7-wt #2
[   22.563673] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
BIOS ?-20200516_175120-felixonmars2 04/01/2014
[   22.564779] Call Trace:
[   22.565057]  dump_stack+0x71/0xa0
[   22.565434]  check_noncircular+0x182/0x1a0
[   22.565889]  check_prev_add+0x8e/0x9a0
[   22.566558]  ? add_chain_cache+0x21d/0x460
[   22.567013]  validate_chain+0x441/0x700
[   22.567441]  __lock_acquire+0x3a1/0x6b0
[   22.567869]  lock_acquire+0xc3/0x420
[   22.568296]  ? __flush_work+0x78/0xf0
[   22.568884]  ? __lock_acquire+0x3c0/0x6b0
[   22.569329]  __flush_work+0x98/0xf0
[   22.571083]  ? __flush_work+0x78/0xf0
[   22.571495]  ? kvm_sched_clock_read+0x14/0x40
[   22.572112]  ? sched_clock+0x5/0x10
[   22.572508]  ? sched_clock_cpu+0xe/0xd0
[   22.572939]  ? __lock_release+0x1b0/0x2c0
[   22.573386]  ? rcu_read_lock_sched_held+0x57/0x90
[   22.573917]  ? cfg80211_mgmt_registrations_update+0x3c3/0x400
[   22.574550]  __cfg80211_unregister_wdev+0x9b/0x150
[   22.575081]  cfg80211_netdev_notifier_call+0x3a4/0x4ef
[   22.575734]  ? kvm_sched_clock_read+0x14/0x40
[   22.576209]  ? sched_clock+0x5/0x10
[   22.576603]  ? sched_clock_cpu+0xe/0xd0
[   22.577023]  ? mark_held_locks+0x45/0x70
[   22.577454]  ? __local_bh_enable_ip+0x79/0xf0
[   22.577934]  ? __trace_hardirqs_on_caller+0x62/0x90
[   22.578514]  ? rt_flush_dev+0x9d/0xb0
[   22.578935]  ? lockdep_hardirqs_on+0x7f/0x130
[   22.579411]  ? __local_bh_enable_ip+0x79/0xf0
[   22.579886]  ? cpumask_next+0x16/0x20
[   22.580290]  ? rt_flush_dev+0x2a/0xb0
[   22.580701]  notifier_call_chain+0x46/0xb0
[   22.581152]  rollback_registered_many+0x275/0x4e0
[   22.581667]  unregister_netdevice_queue+0xcf/0x180
[   22.582197]  ieee80211_del_iface+0xe/0x20
[   22.582761]  nl80211_del_interface+0x64/0x150
[   22.583241]  genl_family_rcv_msg+0x189/0x3b0
[   22.583718]  ? __lock_acquire+0x3c0/0x6b0
[   22.584163]  genl_rcv_msg+0x47/0x90
[   22.584552]  ? __lock_acquired+0xf4/0x320
[   22.584998]  ? genl_family_rcv_msg+0x3b0/0x3b0
[   22.585512]  netlink_rcv_skb+0x47/0x110
[   22.585931]  genl_rcv+0x24/0x40
[   22.586253]  netlink_unicast+0x191/0x250
[   22.586689]  netlink_sendmsg+0x207/0x420
[   22.587117]  ? __might_fault+0x3e/0x90
[   22.587537]  ? netlink_broadcast_filtered+0x1a0/0x1a0
[   22.588091]  ____sys_sendmsg+0x206/0x230
[   22.588587]  ? import_iovec+0x37/0xf0
[   22.588991]  ___sys_sendmsg+0xab/0xf0
[   22.589397]  ? __lock_acquire+0x3c0/0x6b0
[   22.589845]  ? kvm_sched_clock_read+0x14/0x40
[   22.590313]  ? sched_clock+0x5/0x10
[   22.590698]  ? sched_clock_cpu+0xe/0xd0
[   22.591804]  ? __lock_release+0x1b0/0x2c0
[   22.592363]  __sys_sendmsg+0x51/0x90
[   22.592730]  ? lockdep_hardirqs_off+0x79/0xd0
[   22.593113]  do_syscall_64+0x4f/0x260
[   22.593424]  entry_SYSCALL_64_after_hwframe+0x49/0xb3
[   22.593852] RIP: 0033:0x7f3dc6874137
[   22.594156] Code: 0b 00 f7 d8 64 89 02 48 c7 c0 ff ff ff ff eb b7 0f
1f 00 f3 0f 1e fa 64 8b 04 25 18 00 00 00 85 c0 75 10 b8 2e 00 00 00 0f
05 <48> 3d 00 f0 ff ff 77 51 c3 48 83 ec 28 89 54 24 1c 48 89 74 24 10
[   22.595809] RSP: 002b:00007ffd7df99488 EFLAGS: 00000246 ORIG_RAX:
000000000000002e
[   22.596648] RAX: ffffffffffffffda RBX: 0000606000000200 RCX:
00007f3dc6874137
[   22.597419] RDX: 0000000000000000 RSI: 00007ffd7df994f0 RDI:
0000000000000006
[   22.598102] RBP: 00007ffd7df994f0 R08: 0000000000000004 R09:
0000000000000011
[   22.598816] R10: 00007ffd7df99640 R11: 0000000000000246 R12:
00006070000250f0
[   22.599449] R13: 00007ffd7df994f0 R14: 00007ffd7df99600 R15:
0000000000000000
