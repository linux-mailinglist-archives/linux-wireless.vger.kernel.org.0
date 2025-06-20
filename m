Return-Path: <linux-wireless+bounces-24291-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EE50AE1F93
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 17:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9F62E171DD2
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Jun 2025 15:57:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 811382D4B42;
	Fri, 20 Jun 2025 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XGZJz9U9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5326128B3E2;
	Fri, 20 Jun 2025 15:56:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750435016; cv=none; b=N8IaYbljmHq/Rr/xSDP4SfNubCFP+dJZH5/pel+ouYvMQK6QpTv9rpOOn+ZGuxgLUVr9mD7p7o3DVGukU5LbN1iNvmfZE5CBusvskiWK3f9QpaPnVYlA68Hjdg3HCmV/CqOgLYpqnTt64m1YK/2rxEp6df3WE/k6tLQ0Uu91nho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750435016; c=relaxed/simple;
	bh=N8WwDnl3pZ51GjycAjgK8S3vmC+4jFGasDU9CnD2Hf8=;
	h=Message-ID:Date:MIME-Version:To:Cc:From:Subject:Content-Type; b=XB6JfpY68CGJ/ly3j9W5B4xEwdrfPn77HAmgBZ2aSroF4yKkySn4AIr6QOKlGL7AjQ0DtzTE6voZyn8xfdNNgF058Fp+7ckuGA6YBLJgw7S+ZspKDaM9ZFpbaozqgFTBTB5MT77K8vdiwmMqng67b3cdnF6J6I31GC48kDUyzqM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XGZJz9U9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 693DCC4CEE3;
	Fri, 20 Jun 2025 15:56:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750435015;
	bh=N8WwDnl3pZ51GjycAjgK8S3vmC+4jFGasDU9CnD2Hf8=;
	h=Date:To:Cc:From:Subject:From;
	b=XGZJz9U9HXpNyk0k7xr5/F5VYE2wam805FF4qfRjRU8ugbjjN/A6KATWQgQMzEE2i
	 rvlcQoTcgLcZiq1rDfeYbR8X+Untxz22oBqexqubvzgv4twF6V65PcfXMyAnC0Ivkd
	 GKC+HsJ0eWCPYMSfSKSXN5bAS9YM7P0dVgbLbvy376o72oj2BrZ6chIOGIcbilNfdl
	 kjiG/zP7S+l3JDGkqz/hJ3kGBpN9bkldXgrXdhP2nSFzdtDNlJNC9WjHAGd79wNl3E
	 +j/2hor48Xh2deEToDP+ra/BM4Pm3VytLbZ2zmHQoVLxQo/h6r7p3r///uz2FjIRVi
	 BTR4JbXs3YXMw==
Message-ID: <e9d7ef79-6a24-4515-aa35-d1f2357da798@kernel.org>
Date: Fri, 20 Jun 2025 17:56:52 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US, nl
To: Miri Korenblit <miriam.rachel.korenblit@intel.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, Zhang Rui <rui.zhang@intel.com>,
 Lukasz Luba <lukasz.luba@arm.com>
Cc: linux-wireless <linux-wireless@vger.kernel.org>,
 Linux PM <linux-pm@vger.kernel.org>
From: Hans de Goede <hansg@kernel.org>
Subject: 6.16-rc2+ lockdep circular locking between iwlwifi and thermal_zone
 code
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi All,

While testing 6.16-rc2+ on a Dell XPS 9640 I got the following lockdep report:

(Note this was a build without debuginfo, so I did not run decode_stacktrace.sh)

[   19.690210] ======================================================
[   19.690212] WARNING: possible circular locking dependency detected
[   19.690214] 6.16.0-rc2+ #3 Tainted: G            E      
[   19.690217] ------------------------------------------------------
[   19.690218] modprobe/906 is trying to acquire lock:
[   19.690220] ffff89da8e948768 (&rdev->wiphy.mtx){+.+.}-{4:4}, at: iwl_mld_tzone_get_temp+0x2f/0x1d0 [iwlmld]
[   19.690269] 
               but task is already holding lock:
[   19.690270] ffff89da41ac2708 (&tz->lock){+.+.}-{4:4}, at: thermal_zone_device_set_mode+0x20/0xa0
[   19.690284] 
               which lock already depends on the new lock.

[   19.690285] 
               the existing dependency chain (in reverse order) is:
[   19.690287] 
               -> #4 (&tz->lock){+.+.}-{4:4}:
[   19.690291]        __mutex_lock+0x9f/0xed0
[   19.690299]        thermal_zone_device_set_mode+0x20/0xa0
[   19.690302]        pkg_thermal_cpu_online+0x2ad/0x330 [x86_pkg_temp_thermal]
[   19.690308]        cpuhp_invoke_callback+0x1ab/0x660
[   19.690315]        cpuhp_thread_fun+0x187/0x270
[   19.690318]        smpboot_thread_fn+0x12a/0x2e0
[   19.690323]        kthread+0x108/0x240
[   19.690328]        ret_from_fork+0x232/0x2a0
[   19.690334]        ret_from_fork_asm+0x1a/0x30
[   19.690340] 
               -> #3 (cpuhp_state-up){+.+.}-{0:0}:
[   19.690344]        cpuhp_thread_fun+0x99/0x270
[   19.690348]        smpboot_thread_fn+0x12a/0x2e0
[   19.690351]        kthread+0x108/0x240
[   19.690355]        ret_from_fork+0x232/0x2a0
[   19.690358]        ret_from_fork_asm+0x1a/0x30
[   19.690361] 
               -> #2 (cpu_hotplug_lock){++++}-{0:0}:
[   19.690364]        cpus_read_lock+0x3c/0xe0
[   19.690368]        static_key_slow_inc+0x12/0x30
[   19.690375]        __nf_register_net_hook+0xb7/0x210
[   19.690382]        nf_register_net_hook+0x2d/0x90
[   19.690385]        nf_tables_addchain.constprop.0+0x2dd/0x6f0 [nf_tables]
[   19.690410]        nf_tables_newchain+0x78f/0xb10 [nf_tables]
[   19.690424]        nfnetlink_rcv_batch+0x7a5/0xc50 [nfnetlink]
[   19.690430]        nfnetlink_rcv+0x12d/0x150 [nfnetlink]
[   19.690432]        netlink_unicast+0x1bf/0x2b0
[   19.690436]        netlink_sendmsg+0x211/0x430
[   19.690438]        ____sys_sendmsg+0x373/0x3b0
[   19.690444]        ___sys_sendmsg+0x7d/0xc0
[   19.690447]        __sys_sendmsg+0x5e/0xb0
[   19.690449]        do_syscall_64+0x94/0x3d0
[   19.690454]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   19.690458] 
               -> #1 (&nft_net->commit_mutex){+.+.}-{4:4}:
[   19.690462]        __mutex_lock+0x9f/0xed0
[   19.690464]        nf_tables_netdev_event+0x59/0xc0 [nf_tables]
[   19.690480]        notifier_call_chain+0x3d/0x100
[   19.690485]        register_netdevice+0x731/0x8f0
[   19.690489]        cfg80211_register_netdevice+0x4c/0xf0 [cfg80211]
[   19.690587]        ieee80211_if_add+0x475/0x740 [mac80211]
[   19.690721]        ieee80211_register_hw+0xd6b/0xdb0 [mac80211]
[   19.690796]        iwl_op_mode_mld_start+0x438/0x4b0 [iwlmld]
[   19.690827]        _iwl_op_mode_start+0x67/0x100 [iwlwifi]
[   19.690856]        iwl_opmode_register+0x6b/0xc0 [iwlwifi]
[   19.690874]        iwl_mld_init+0x19/0xff0 [iwlmld]
[   19.690906]        do_one_initcall+0x54/0x390
[   19.690912]        do_init_module+0x62/0x240
[   19.690917]        __do_sys_init_module+0x164/0x190
[   19.690920]        do_syscall_64+0x94/0x3d0
[   19.690926]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   19.690928] 
               -> #0 (&rdev->wiphy.mtx){+.+.}-{4:4}:
[   19.690933]        __lock_acquire+0x1481/0x2270
[   19.690939]        lock_acquire+0xc9/0x2c0
[   19.690942]        __mutex_lock+0x9f/0xed0
[   19.690947]        iwl_mld_tzone_get_temp+0x2f/0x1d0 [iwlmld]
[   19.690968]        __thermal_zone_get_temp+0x29/0x90
[   19.690973]        __thermal_zone_device_update+0x69/0x480
[   19.690977]        thermal_zone_device_set_mode+0x52/0xa0
[   19.690981]        iwl_mld_thermal_zone_register+0x144/0x1d0 [iwlmld]
[   19.690994]        iwl_op_mode_mld_start+0x460/0x4b0 [iwlmld]
[   19.691009]        _iwl_op_mode_start+0x67/0x100 [iwlwifi]
[   19.691029]        iwl_opmode_register+0x6b/0xc0 [iwlwifi]
[   19.691044]        iwl_mld_init+0x19/0xff0 [iwlmld]
[   19.691062]        do_one_initcall+0x54/0x390
[   19.691064]        do_init_module+0x62/0x240
[   19.691067]        __do_sys_init_module+0x164/0x190
[   19.691069]        do_syscall_64+0x94/0x3d0
[   19.691071]        entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   19.691074] 
               other info that might help us debug this:

[   19.691075] Chain exists of:
                 &rdev->wiphy.mtx --> cpuhp_state-up --> &tz->lock

[   19.691080]  Possible unsafe locking scenario:

[   19.691082]        CPU0                    CPU1
[   19.691083]        ----                    ----
[   19.691085]   lock(&tz->lock);
[   19.691087]                                lock(cpuhp_state-up);
[   19.691089]                                lock(&tz->lock);
[   19.691091]   lock(&rdev->wiphy.mtx);
[   19.691094] 
                *** DEADLOCK ***

[   19.691095] 2 locks held by modprobe/906:
[   19.691097]  #0: ffffffffc156dc68 (iwlwifi_opmode_table_mtx){+.+.}-{4:4}, at: iwl_opmode_register+0x21/0xc0 [iwlwifi]
[   19.691117]  #1: ffff89da41ac2708 (&tz->lock){+.+.}-{4:4}, at: thermal_zone_device_set_mode+0x20/0xa0
[   19.691124] 
               stack backtrace:
[   19.691127] CPU: 17 UID: 0 PID: 906 Comm: modprobe Tainted: G            E       6.16.0-rc2+ #3 PREEMPT(lazy) 
[   19.691131] Tainted: [E]=UNSIGNED_MODULE
[   19.691132] Hardware name: Dell Inc. XPS 16 9640/09CK4V, BIOS 1.12.0 02/10/2025
[   19.691134] Call Trace:
[   19.691137]  <TASK>
[   19.691138]  dump_stack_lvl+0x68/0x90
[   19.691144]  print_circular_bug.cold+0x185/0x1d0
[   19.691150]  check_noncircular+0x10f/0x130
[   19.691154]  ? __kernel_text_address+0xe/0x30
[   19.691158]  ? unwind_get_return_address+0x26/0x50
[   19.691165]  __lock_acquire+0x1481/0x2270
[   19.691171]  lock_acquire+0xc9/0x2c0
[   19.691174]  ? iwl_mld_tzone_get_temp+0x2f/0x1d0 [iwlmld]
[   19.691190]  __mutex_lock+0x9f/0xed0
[   19.691194]  ? iwl_mld_tzone_get_temp+0x2f/0x1d0 [iwlmld]
[   19.691207]  ? iwl_mld_tzone_get_temp+0x2f/0x1d0 [iwlmld]
[   19.691218]  ? lock_acquire+0xc9/0x2c0
[   19.691221]  ? thermal_zone_device_set_mode+0x20/0xa0
[   19.691225]  ? lock_acquire+0xd9/0x2c0
[   19.691229]  ? iwl_mld_tzone_get_temp+0x2f/0x1d0 [iwlmld]
[   19.691240]  iwl_mld_tzone_get_temp+0x2f/0x1d0 [iwlmld]
[   19.691253]  ? lock_is_held_type+0xd5/0x140
[   19.691258]  __thermal_zone_get_temp+0x29/0x90
[   19.691261]  __thermal_zone_device_update+0x69/0x480
[   19.691266]  thermal_zone_device_set_mode+0x52/0xa0
[   19.691270]  iwl_mld_thermal_zone_register+0x144/0x1d0 [iwlmld]
[   19.691287]  iwl_op_mode_mld_start+0x460/0x4b0 [iwlmld]
[   19.691304]  _iwl_op_mode_start+0x67/0x100 [iwlwifi]
[   19.691322]  iwl_opmode_register+0x6b/0xc0 [iwlwifi]
[   19.691338]  ? __pfx_iwl_mld_init+0x10/0x10 [iwlmld]
[   19.691353]  iwl_mld_init+0x19/0xff0 [iwlmld]
[   19.691366]  do_one_initcall+0x54/0x390
[   19.691372]  do_init_module+0x62/0x240
[   19.691375]  ? __do_sys_init_module+0x164/0x190
[   19.691377]  __do_sys_init_module+0x164/0x190
[   19.691383]  do_syscall_64+0x94/0x3d0
[   19.691387]  ? lock_acquire+0xc9/0x2c0
[   19.691390]  ? __folio_batch_add_and_move+0x8f/0x2f0
[   19.691395]  ? lock_acquire+0xd9/0x2c0
[   19.691397]  ? find_held_lock+0x2b/0x80
[   19.691401]  ? find_held_lock+0x2b/0x80
[   19.691402]  ? find_held_lock+0x2b/0x80
[   19.691405]  ? rcu_read_unlock+0x17/0x60
[   19.691411]  ? lock_release+0x1a0/0x2d0
[   19.691416]  ? __lock_acquire+0x45f/0x2270
[   19.691420]  ? __handle_mm_fault+0xaf4/0xe20
[   19.691426]  ? lock_acquire+0xc9/0x2c0
[   19.691429]  ? find_held_lock+0x2b/0x80
[   19.691431]  ? rcu_read_unlock+0x17/0x60
[   19.691433]  ? lock_release+0x1a0/0x2d0
[   19.691436]  ? find_held_lock+0x2b/0x80
[   19.691439]  ? exc_page_fault+0x8c/0x240
[   19.691441]  ? lock_release+0x1a0/0x2d0
[   19.691445]  ? do_user_addr_fault+0x370/0x6b0
[   19.691450]  entry_SYSCALL_64_after_hwframe+0x76/0x7e
[   19.691453] RIP: 0033:0x7f111e502bae
[   19.691457] Code: 48 8b 0d 5d 32 0f 00 f7 d8 64 89 01 48 83 c8 ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 49 89 ca b8 af 00 00 00 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 8b 0d 2a 32 0f 00 f7 d8 64 89 01 48
[   19.691460] RSP: 002b:00007ffd319c0df8 EFLAGS: 00000246 ORIG_RAX: 00000000000000af
[   19.691463] RAX: ffffffffffffffda RBX: 0000558224041e60 RCX: 00007f111e502bae
[   19.691465] RDX: 00005581ee14b5ee RSI: 00000000000cbf71 RDI: 0000558224bf0cd0
[   19.691466] RBP: 00007ffd319c0eb0 R08: 0000558224041d40 R09: 00007f111e5f6ac0
[   19.691467] R10: 0000558224041010 R11: 0000000000000246 R12: 0000000000040000
[   19.691468] R13: 0000558224041dc0 R14: 00005581ee14b5ee R15: 0000000000000000
[   19.691472]  </TASK>

I'll glady test any potential fixes.

Regards,

Hans



