Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E222232AF98
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Mar 2021 04:29:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238297AbhCCA1N (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Mar 2021 19:27:13 -0500
Received: from mail.kernel.org ([198.145.29.99]:37520 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1578093AbhCBKfg (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Mar 2021 05:35:36 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8F64264F0D;
        Tue,  2 Mar 2021 10:34:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614681294;
        bh=ugJHg9cYk74SjXydnucoKS21JJi70MPT/T1tFbGj1Aw=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=XHfzaFb3CI/GV4HUw7gVLbAtfxuEFo8wByxVuPgt7dni1p6zPlFgUXJUUYZc7XMsw
         LF/76BS7cBXKtfjQ00Vab5i8La+GUupSGypjSfAM/NTc9CJmbV+8Y72hm3il4AC5NJ
         JN26aE/zppIjV6ZatuVBzv8mjAydhHhwfJCsE/7B5drCPuAw1rDl1oJbY1LNGLBOUh
         V973vLkV9gGPa6Wjegi71ADKHC+vKJIPCRYDw2yfR0cjV/JlJWatpd/jdiTjMroWS5
         bNgSSZ1EcpeBoYLS98p/l5UYCC+FI6pPR3IwymQ57gB16cUZRxytQA1xMxIvS3LnLE
         oFQAa7GOlwrZw==
Date:   Tue, 2 Mar 2021 11:34:51 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
cc:     Luca Coelho <luciano.coelho@intel.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] iwlwifi: don't call netif_napi_add() with rxq->lock held
 (was Re: Lockdep warning in iwl_pcie_rx_handle())
In-Reply-To: <nycvar.YFH.7.76.2103021025410.12405@cbobk.fhfr.pm>
Message-ID: <nycvar.YFH.7.76.2103021134060.12405@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2103012136570.12405@cbobk.fhfr.pm>  (sfid-20210301_215846_256695_15E0D07E) <2db8f779b4b37d4498cfeaed77d5ede54e429a6e.camel@sipsolutions.net> <nycvar.YFH.7.76.2103021025410.12405@cbobk.fhfr.pm>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

From: Jiri Kosina <jkosina@suse.cz>

We can't call netif_napi_add() with rxq-lock held, as there is a potential
for deadlock as spotted by lockdep (see below). rxq->lock is not
protecting anything over the netif_napi_add() codepath anyway, so let's
drop it just before calling into NAPI.

 ========================================================
 WARNING: possible irq lock inversion dependency detected
 5.12.0-rc1-00002-gbada49429032 #5 Not tainted
 --------------------------------------------------------
 irq/136-iwlwifi/565 just changed the state of lock:
 ffff89f28433b0b0 (&rxq->lock){+.-.}-{2:2}, at: iwl_pcie_rx_handle+0x7f/0x960 [iwlwifi]
 but this lock took another, SOFTIRQ-unsafe lock in the past:
  (napi_hash_lock){+.+.}-{2:2}

 and interrupts could create inverse lock ordering between them.

 other info that might help us debug this:
  Possible interrupt unsafe locking scenario:

        CPU0                    CPU1
        ----                    ----
   lock(napi_hash_lock);
                                local_irq_disable();
                                lock(&rxq->lock);
                                lock(napi_hash_lock);
   <Interrupt>
     lock(&rxq->lock);

  *** DEADLOCK ***

 1 lock held by irq/136-iwlwifi/565:
  #0: ffff89f2b1440170 (sync_cmd_lockdep_map){+.+.}-{0:0}, at: iwl_pcie_irq_handler+0x5/0xb30

 the shortest dependencies between 2nd lock and 1st lock:
  -> (napi_hash_lock){+.+.}-{2:2} {
     HARDIRQ-ON-W at:
                       lock_acquire+0x277/0x3d0
                       _raw_spin_lock+0x2c/0x40
                       netif_napi_add+0x14b/0x270
                       e1000_probe+0x2fe/0xee0 [e1000e]
                       local_pci_probe+0x42/0x90
                       pci_device_probe+0x10b/0x1c0
                       really_probe+0xef/0x4b0
                       driver_probe_device+0xde/0x150
                       device_driver_attach+0x4f/0x60
                       __driver_attach+0x9c/0x140
                       bus_for_each_dev+0x79/0xc0
                       bus_add_driver+0x18d/0x220
                       driver_register+0x5b/0xf0
                       do_one_initcall+0x5b/0x300
                       do_init_module+0x5b/0x21c
                       load_module+0x1dae/0x22c0
                       __do_sys_finit_module+0xad/0x110
                       do_syscall_64+0x33/0x80
                       entry_SYSCALL_64_after_hwframe+0x44/0xae
     SOFTIRQ-ON-W at:
                       lock_acquire+0x277/0x3d0
                       _raw_spin_lock+0x2c/0x40
                       netif_napi_add+0x14b/0x270
                       e1000_probe+0x2fe/0xee0 [e1000e]
                       local_pci_probe+0x42/0x90
                       pci_device_probe+0x10b/0x1c0
                       really_probe+0xef/0x4b0
                       driver_probe_device+0xde/0x150
                       device_driver_attach+0x4f/0x60
                       __driver_attach+0x9c/0x140
                       bus_for_each_dev+0x79/0xc0
                       bus_add_driver+0x18d/0x220
                       driver_register+0x5b/0xf0
                       do_one_initcall+0x5b/0x300
                       do_init_module+0x5b/0x21c
                       load_module+0x1dae/0x22c0
                       __do_sys_finit_module+0xad/0x110
                       do_syscall_64+0x33/0x80
                       entry_SYSCALL_64_after_hwframe+0x44/0xae
     INITIAL USE at:
                      lock_acquire+0x277/0x3d0
                      _raw_spin_lock+0x2c/0x40
                      netif_napi_add+0x14b/0x270
                      e1000_probe+0x2fe/0xee0 [e1000e]
                      local_pci_probe+0x42/0x90
                      pci_device_probe+0x10b/0x1c0
                      really_probe+0xef/0x4b0
                      driver_probe_device+0xde/0x150
                      device_driver_attach+0x4f/0x60
                      __driver_attach+0x9c/0x140
                      bus_for_each_dev+0x79/0xc0
                      bus_add_driver+0x18d/0x220
                      driver_register+0x5b/0xf0
                      do_one_initcall+0x5b/0x300
                      do_init_module+0x5b/0x21c
                      load_module+0x1dae/0x22c0
                      __do_sys_finit_module+0xad/0x110
                      do_syscall_64+0x33/0x80
                      entry_SYSCALL_64_after_hwframe+0x44/0xae
   }
   ... key      at: [<ffffffffae84ef38>] napi_hash_lock+0x18/0x40
   ... acquired at:
    _raw_spin_lock+0x2c/0x40
    netif_napi_add+0x14b/0x270
    _iwl_pcie_rx_init+0x1f4/0x710 [iwlwifi]
    iwl_pcie_rx_init+0x1b/0x3b0 [iwlwifi]
    iwl_trans_pcie_start_fw+0x2ac/0x6a0 [iwlwifi]
    iwl_mvm_load_ucode_wait_alive+0x116/0x460 [iwlmvm]
    iwl_run_init_mvm_ucode+0xa4/0x3a0 [iwlmvm]
    iwl_op_mode_mvm_start+0x9ed/0xbf0 [iwlmvm]
    _iwl_op_mode_start.isra.4+0x42/0x80 [iwlwifi]
    iwl_opmode_register+0x71/0xe0 [iwlwifi]
    iwl_mvm_init+0x34/0x1000 [iwlmvm]
    do_one_initcall+0x5b/0x300
    do_init_module+0x5b/0x21c
    load_module+0x1dae/0x22c0
    __do_sys_finit_module+0xad/0x110
    do_syscall_64+0x33/0x80
    entry_SYSCALL_64_after_hwframe+0x44/0xae

[ ... lockdep output trimmed .... ]

Fixes: 25edc8f259c7106 ("iwlwifi: pcie: properly implement NAPI")
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
---

v1->v2: Previous patch was not refreshed against current code-base, sorry.

 drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 42426e25cac6..2bec97133119 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1129,6 +1129,8 @@ static int _iwl_pcie_rx_init(struct iwl_trans *trans)
 
 		iwl_pcie_rx_init_rxb_lists(rxq);
 
+		spin_unlock_bh(&rxq->lock);
+
 		if (!rxq->napi.poll) {
 			int (*poll)(struct napi_struct *, int) = iwl_pcie_napi_poll;
 
@@ -1149,7 +1151,6 @@ static int _iwl_pcie_rx_init(struct iwl_trans *trans)
 			napi_enable(&rxq->napi);
 		}
 
-		spin_unlock_bh(&rxq->lock);
 	}
 
 	/* move the pool to the default queue and allocator ownerships */


-- 
Jiri Kosina
SUSE Labs

