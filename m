Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DC24C329301
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Mar 2021 21:58:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243745AbhCAU4z (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 1 Mar 2021 15:56:55 -0500
Received: from mail.kernel.org ([198.145.29.99]:57402 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S243991AbhCAUyF (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 1 Mar 2021 15:54:05 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 6E3EC600CC;
        Mon,  1 Mar 2021 20:44:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614631461;
        bh=fmAUYJTuQuN9ts9ROQS7R/34dpGzfN1n7RIn3y481cQ=;
        h=Date:From:To:cc:Subject:From;
        b=lYH4MuTlY1OO42J8MWkqUa11LHO+uoOVdWH+QOa+osTpp3CTACDH2Z4LB08M8qMMC
         J0auL6n78g39+zVYn/AG2JV73KAV+4TGgFX2lyYXXoS+FDuKEBHu0vyotDgS7JS7vZ
         utNkVx+hy68Gh+vHs0Lvt4CFSQoI4Ply3kvsW1mVcJ3WQGmViE3if+uIZ+LeZLxI1T
         N2TUiYHjLJoIRxIncA4CjvQAc2CsO+6LHeL23NwPIfn3N/Kq4HxrZfWmZqzZAO97iZ
         IPqavkiHNDDT8YpnKxTh18IJq95AfxtnLqt8hng59Nw1N7XNPqgcdqhygkV9sfXe/5
         z+LGQ7KANU1sA==
Date:   Mon, 1 Mar 2021 21:44:18 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Luca Coelho <luciano.coelho@intel.com>
cc:     Heiner Kallweit <hkallweit1@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Lockdep warning in iwl_pcie_rx_handle()
Message-ID: <nycvar.YFH.7.76.2103012136570.12405@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,

I am getting the splat below with Linus' tree as of today (5.11-rc1, 
fe07bfda2fb). I haven't started to look into the code yet, but apparently 
this has been already reported by Heiner here:

	https://www.spinics.net/lists/linux-wireless/msg208353.html

so before I start digging deep into it (the previous kernel this 
particular machine had is 5.9, so I'd rather avoid lenghty bisect for now 
in case someone has already looked into it and has ideas where the problem 
is), I thought I'd ask whether this has been root-caused elsewhere 
already.

Thanks.




[    9.970414] ========================================================
[    9.973157] WARNING: possible irq lock inversion dependency detected
[    9.976186] 5.12.0-rc1-00002-gbada49429032 #5 Not tainted
[    9.979239] --------------------------------------------------------
[    9.982223] irq/136-iwlwifi/565 just changed the state of lock:
[    9.984904] ffff89f28433b0b0 (&rxq->lock){+.-.}-{2:2}, at: iwl_pcie_rx_handle+0x7f/0x960 [iwlwifi]
[    9.987932] but this lock took another, SOFTIRQ-unsafe lock in the past:
[    9.990980]  (napi_hash_lock){+.+.}-{2:2}
[    9.990986] 
               
               and interrupts could create inverse lock ordering between them.

[   10.003955] 
               other info that might help us debug this:
[   10.008989]  Possible interrupt unsafe locking scenario:

[   10.013966]        CPU0                    CPU1
[   10.016404]        ----                    ----
[   10.018976]   lock(napi_hash_lock);
[   10.021529]                                local_irq_disable();
[   10.023985]                                lock(&rxq->lock);
[   10.026340]                                lock(napi_hash_lock);
[   10.028644]   <Interrupt>
[   10.030934]     lock(&rxq->lock);
[   10.033119] 
                *** DEADLOCK ***

[   10.039456] 1 lock held by irq/136-iwlwifi/565:
[   10.041549]  #0: ffff89f2b1440170 (sync_cmd_lockdep_map){+.+.}-{0:0}, at: iwl_pcie_irq_handler+0x5/0xb30 [iwlwifi]
[   10.043728] 
               the shortest dependencies between 2nd lock and 1st lock:
[   10.047836]  -> (napi_hash_lock){+.+.}-{2:2} {
[   10.049845]     HARDIRQ-ON-W at:
[   10.051860]                       lock_acquire+0x277/0x3d0
[   10.053881]                       _raw_spin_lock+0x2c/0x40
[   10.056170]                       netif_napi_add+0x14b/0x270
[   10.058349]                       e1000_probe+0x2fe/0xee0 [e1000e]
[   10.060539]                       local_pci_probe+0x42/0x90
[   10.062609]                       pci_device_probe+0x10b/0x1c0
[   10.064579]                       really_probe+0xef/0x4b0
[   10.066578]                       driver_probe_device+0xde/0x150
[   10.068765]                       device_driver_attach+0x4f/0x60
[   10.070890]                       __driver_attach+0x9c/0x140
[   10.073115]                       bus_for_each_dev+0x79/0xc0
[   10.075304]                       bus_add_driver+0x18d/0x220
[   10.077464]                       driver_register+0x5b/0xf0
[   10.079615]                       do_one_initcall+0x5b/0x300
[   10.081686]                       do_init_module+0x5b/0x21c
[   10.083730]                       load_module+0x1dae/0x22c0
[   10.085751]                       __do_sys_finit_module+0xad/0x110
[   10.087799]                       do_syscall_64+0x33/0x80
[   10.089758]                       entry_SYSCALL_64_after_hwframe+0x44/0xae
[   10.091747]     SOFTIRQ-ON-W at:
[   10.093634]                       lock_acquire+0x277/0x3d0
[   10.095514]                       _raw_spin_lock+0x2c/0x40
[   10.097353]                       netif_napi_add+0x14b/0x270
[   10.099208]                       e1000_probe+0x2fe/0xee0 [e1000e]
[   10.101032]                       local_pci_probe+0x42/0x90
[   10.102835]                       pci_device_probe+0x10b/0x1c0
[   10.104648]                       really_probe+0xef/0x4b0
[   10.106439]                       driver_probe_device+0xde/0x150
[   10.106443]                       device_driver_attach+0x4f/0x60
[   10.106446]                       __driver_attach+0x9c/0x140
[   10.111451]                       bus_for_each_dev+0x79/0xc0
[   10.111454]                       bus_add_driver+0x18d/0x220
[   10.111456]                       driver_register+0x5b/0xf0
[   10.111459]                       do_one_initcall+0x5b/0x300
[   10.111462]                       do_init_module+0x5b/0x21c
[   10.111467]                       load_module+0x1dae/0x22c0
[   10.111469]                       __do_sys_finit_module+0xad/0x110
[   10.122761]                       do_syscall_64+0x33/0x80
[   10.122768]                       entry_SYSCALL_64_after_hwframe+0x44/0xae
[   10.122772]     INITIAL USE at:
[   10.122775]                      lock_acquire+0x277/0x3d0
[   10.128672]                      _raw_spin_lock+0x2c/0x40
[   10.130160]                      netif_napi_add+0x14b/0x270
[   10.131725]                      e1000_probe+0x2fe/0xee0 [e1000e]
[   10.133268]                      local_pci_probe+0x42/0x90
[   10.134783]                      pci_device_probe+0x10b/0x1c0
[   10.136325]                      really_probe+0xef/0x4b0
[   10.137864]                      driver_probe_device+0xde/0x150
[   10.139394]                      device_driver_attach+0x4f/0x60
[   10.140908]                      __driver_attach+0x9c/0x140
[   10.142429]                      bus_for_each_dev+0x79/0xc0
[   10.143947]                      bus_add_driver+0x18d/0x220
[   10.145490]                      driver_register+0x5b/0xf0
[   10.147024]                      do_one_initcall+0x5b/0x300
[   10.148566]                      do_init_module+0x5b/0x21c
[   10.150013]                      load_module+0x1dae/0x22c0
[   10.151293]                      __do_sys_finit_module+0xad/0x110
[   10.152571]                      do_syscall_64+0x33/0x80
[   10.153740]                      entry_SYSCALL_64_after_hwframe+0x44/0xae
[   10.154889]   }
[   10.156023]   ... key      at: [<ffffffffae84ef38>] napi_hash_lock+0x18/0x40
[   10.157191]   ... acquired at:
[   10.158318]    _raw_spin_lock+0x2c/0x40
[   10.159418]    netif_napi_add+0x14b/0x270
[   10.160500]    _iwl_pcie_rx_init+0x1f4/0x710 [iwlwifi]
[   10.161609]    iwl_pcie_rx_init+0x1b/0x3b0 [iwlwifi]
[   10.162704]    iwl_trans_pcie_start_fw+0x2ac/0x6a0 [iwlwifi]
[   10.163813]    iwl_mvm_load_ucode_wait_alive+0x116/0x460 [iwlmvm]
[   10.164955]    iwl_run_init_mvm_ucode+0xa4/0x3a0 [iwlmvm]
[   10.166079]    iwl_op_mode_mvm_start+0x9ed/0xbf0 [iwlmvm]
[   10.167206]    _iwl_op_mode_start.isra.4+0x42/0x80 [iwlwifi]
[   10.168326]    iwl_opmode_register+0x71/0xe0 [iwlwifi]
[   10.169451]    iwl_mvm_init+0x34/0x1000 [iwlmvm]
[   10.170585]    do_one_initcall+0x5b/0x300
[   10.171699]    do_init_module+0x5b/0x21c
[   10.172818]    load_module+0x1dae/0x22c0
[   10.173933]    __do_sys_finit_module+0xad/0x110
[   10.175048]    do_syscall_64+0x33/0x80
[   10.176164]    entry_SYSCALL_64_after_hwframe+0x44/0xae

[   10.178421] -> (&rxq->lock){+.-.}-{2:2} {
[   10.179564]    HARDIRQ-ON-W at:
[   10.180709]                     lock_acquire+0x277/0x3d0
[   10.181874]                     _raw_spin_lock_bh+0x34/0x40
[   10.183049]                     _iwl_pcie_rx_init+0x130/0x710 [iwlwifi]
[   10.184229]                     iwl_pcie_rx_init+0x1b/0x3b0 [iwlwifi]
[   10.185397]                     iwl_trans_pcie_start_fw+0x2ac/0x6a0 [iwlwifi]
[   10.186572]                     iwl_mvm_load_ucode_wait_alive+0x116/0x460 [iwlmvm]
[   10.187759]                     iwl_run_init_mvm_ucode+0xa4/0x3a0 [iwlmvm]
[   10.188950]                     iwl_op_mode_mvm_start+0x9ed/0xbf0 [iwlmvm]
[   10.190132]                     _iwl_op_mode_start.isra.4+0x42/0x80 [iwlwifi]
[   10.191312]                     iwl_opmode_register+0x71/0xe0 [iwlwifi]
[   10.192497]                     iwl_mvm_init+0x34/0x1000 [iwlmvm]
[   10.193685]                     do_one_initcall+0x5b/0x300
[   10.194868]                     do_init_module+0x5b/0x21c
[   10.196048]                     load_module+0x1dae/0x22c0
[   10.197225]                     __do_sys_finit_module+0xad/0x110
[   10.198409]                     do_syscall_64+0x33/0x80
[   10.199601]                     entry_SYSCALL_64_after_hwframe+0x44/0xae
[   10.200801]    IN-SOFTIRQ-W at:
[   10.202000]                     lock_acquire+0x277/0x3d0
[   10.203202]                     _raw_spin_lock+0x2c/0x40
[   10.204412]                     iwl_pcie_rx_handle+0x7f/0x960 [iwlwifi]
[   10.205653]                     iwl_pcie_napi_poll+0x2c/0x100 [iwlwifi]
[   10.206879]                     __napi_poll+0x2d/0x220
[   10.208075]                     net_rx_action+0x106/0x280
[   10.209276]                     __do_softirq+0xd4/0x461
[   10.210486]                     do_softirq+0x63/0xa0
[   10.211677]                     __local_bh_enable_ip+0xd1/0xf0
[   10.212879]                     iwl_pcie_irq_handler+0x67d/0xb30 [iwlwifi]
[   10.214092]                     irq_thread_fn+0x21/0x60
[   10.215298]                     irq_thread+0x107/0x1a0
[   10.216491]                     kthread+0x13e/0x160
[   10.217670]                     ret_from_fork+0x22/0x30
[   10.218855]    INITIAL USE at:
[   10.220030]                    lock_acquire+0x277/0x3d0
[   10.221239]                    _raw_spin_lock_bh+0x34/0x40
[   10.222438]                    _iwl_pcie_rx_init+0x130/0x710 [iwlwifi]
[   10.223667]                    iwl_pcie_rx_init+0x1b/0x3b0 [iwlwifi]
[   10.224894]                    iwl_trans_pcie_start_fw+0x2ac/0x6a0 [iwlwifi]
[   10.226167]                    iwl_mvm_load_ucode_wait_alive+0x116/0x460 [iwlmvm]
[   10.227448]                    iwl_run_init_mvm_ucode+0xa4/0x3a0 [iwlmvm]
[   10.228718]                    iwl_op_mode_mvm_start+0x9ed/0xbf0 [iwlmvm]
[   10.229977]                    _iwl_op_mode_start.isra.4+0x42/0x80 [iwlwifi]
[   10.231236]                    iwl_opmode_register+0x71/0xe0 [iwlwifi]
[   10.232492]                    iwl_mvm_init+0x34/0x1000 [iwlmvm]
[   10.233758]                    do_one_initcall+0x5b/0x300
[   10.235002]                    do_init_module+0x5b/0x21c
[   10.236224]                    load_module+0x1dae/0x22c0
[   10.237454]                    __do_sys_finit_module+0xad/0x110
[   10.238679]                    do_syscall_64+0x33/0x80
[   10.239906]                    entry_SYSCALL_64_after_hwframe+0x44/0xae
[   10.241137]  }
[   10.242327]  ... key      at: [<ffffffffc111f0c0>] __key.69825+0x0/0xfffffffffffe2f40 [iwlwifi]
[   10.243587]  ... acquired at:
[   10.244814]    __lock_acquire+0x27d/0x1a50
[   10.246055]    lock_acquire+0x277/0x3d0
[   10.247296]    _raw_spin_lock+0x2c/0x40
[   10.248518]    iwl_pcie_rx_handle+0x7f/0x960 [iwlwifi]
[   10.249789]    iwl_pcie_napi_poll+0x2c/0x100 [iwlwifi]
[   10.251028]    __napi_poll+0x2d/0x220
[   10.252254]    net_rx_action+0x106/0x280
[   10.253484]    __do_softirq+0xd4/0x461
[   10.254731]    do_softirq+0x63/0xa0
[   10.255946]    __local_bh_enable_ip+0xd1/0xf0
[   10.257157]    iwl_pcie_irq_handler+0x67d/0xb30 [iwlwifi]
[   10.258382]    irq_thread_fn+0x21/0x60
[   10.259608]    irq_thread+0x107/0x1a0
[   10.260819]    kthread+0x13e/0x160
[   10.262022]    ret_from_fork+0x22/0x30

[   10.264433] 
               stack backtrace:
[   10.266755] CPU: 2 PID: 565 Comm: irq/136-iwlwifi Not tainted 5.12.0-rc1-00002-gbada49429032 #5
[   10.267964] Hardware name: LENOVO 20K5S22R00/20K5S22R00, BIOS R0IET38W (1.16 ) 05/31/2017
[   10.269175] Call Trace:
[   10.270376]  <IRQ>
[   10.271566]  dump_stack+0x7f/0xa1
[   10.272750]  mark_lock.part.49+0x8cb/0xc70
[   10.273950]  ? __lock_acquire+0x2e1/0x1a50
[   10.275164]  ? __lock_acquire+0x27d/0x1a50
[   10.276372]  __lock_acquire+0x27d/0x1a50
[   10.277562]  ? __lock_acquire+0x2e1/0x1a50
[   10.278754]  ? __lock_acquire+0x2e1/0x1a50
[   10.279937]  lock_acquire+0x277/0x3d0
[   10.281110]  ? iwl_pcie_rx_handle+0x7f/0x960 [iwlwifi]
[   10.282317]  ? lock_is_held_type+0xb4/0x120
[   10.283483]  _raw_spin_lock+0x2c/0x40
[   10.284637]  ? iwl_pcie_rx_handle+0x7f/0x960 [iwlwifi]
[   10.285813]  iwl_pcie_rx_handle+0x7f/0x960 [iwlwifi]
[   10.286985]  ? __lock_acquire+0x2e1/0x1a50
[   10.288148]  ? try_to_wake_up+0x41c/0x600
[   10.289323]  ? print_dl_rq+0xcc/0x160
[   10.290490]  iwl_pcie_napi_poll+0x2c/0x100 [iwlwifi]
[   10.291684]  __napi_poll+0x2d/0x220
[   10.292862]  net_rx_action+0x106/0x280
[   10.294034]  __do_softirq+0xd4/0x461
[   10.295185]  do_softirq+0x63/0xa0
[   10.296349]  </IRQ>
[   10.297514]  __local_bh_enable_ip+0xd1/0xf0
[   10.298683]  ? iwl_pcie_irq_handler+0x66c/0xb30 [iwlwifi]
[   10.299882]  iwl_pcie_irq_handler+0x67d/0xb30 [iwlwifi]
[   10.301076]  ? irq_forced_thread_fn+0x80/0x80
[   10.302265]  irq_thread_fn+0x21/0x60
[   10.303434]  ? irq_thread+0xa1/0x1a0
[   10.304596]  irq_thread+0x107/0x1a0
[   10.305766]  ? wake_threads_waitq+0x30/0x30
[   10.306922]  ? irq_thread_dtor+0xa0/0xa0
[   10.308078]  kthread+0x13e/0x160
[   10.309246]  ? kthread_create_worker_on_cpu+0x70/0x70
[   10.310410]  ret_from_fork+0x22/0x30

