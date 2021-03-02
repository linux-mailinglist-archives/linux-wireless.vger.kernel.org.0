Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A539D32AF88
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Mar 2021 04:29:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238064AbhCCA0T (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 2 Mar 2021 19:26:19 -0500
Received: from mail.kernel.org ([198.145.29.99]:45682 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1838109AbhCBJ2U (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 2 Mar 2021 04:28:20 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 2CFF064F0B;
        Tue,  2 Mar 2021 09:27:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1614677258;
        bh=/d9JcsrJy2ZQxdWam/1fe7GqsKrPDyLOFEO8rkB2fm0=;
        h=Date:From:To:cc:Subject:In-Reply-To:References:From;
        b=RpH6VV3LMhbD9S6/59a+5Ujmb1jNo8XGen3nZaJR1KibWK8aoNvfZsCbtZ49VSrf7
         wmAWAvADsOvx4jhlR5X7x5kfGom9gyPGSlshAsMKrxNse7zzPGVGx/1Tb8YhO48lm0
         mFKp/ag1NMswZfccEiLxadZ8fUq4MaSpxwcHDKNOLxYCwpWz0UmFLcp7+YUh6tGpTQ
         pqMd3oEmatMAjAWWk6P+yea4ux/CAhyWWHlGVkS8WImaqijaraWPtotZnDyGijXLa0
         scLcji3zZ189biIYvoNG5UWHAW5nBYkzpLPvYifUioN3N5I/l7KJoKQI14yNaN2uZ4
         33tRGUEH0I4jA==
Date:   Tue, 2 Mar 2021 10:27:34 +0100 (CET)
From:   Jiri Kosina <jikos@kernel.org>
To:     Johannes Berg <johannes@sipsolutions.net>
cc:     Luca Coelho <luciano.coelho@intel.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] iwlwifi: don't call netif_napi_add() with rxq->lock held
 (was Re: Lockdep warning in iwl_pcie_rx_handle())
In-Reply-To: <2db8f779b4b37d4498cfeaed77d5ede54e429a6e.camel@sipsolutions.net>
Message-ID: <nycvar.YFH.7.76.2103021025410.12405@cbobk.fhfr.pm>
References: <nycvar.YFH.7.76.2103012136570.12405@cbobk.fhfr.pm>  (sfid-20210301_215846_256695_15E0D07E) <2db8f779b4b37d4498cfeaed77d5ede54e429a6e.camel@sipsolutions.net>
User-Agent: Alpine 2.21 (LSU 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Mon, 1 Mar 2021, Johannes Berg wrote:

> > I am getting the splat below with Linus' tree as of today (5.11-rc1, 
> > fe07bfda2fb). I haven't started to look into the code yet, but apparently 
> > this has been already reported by Heiner here:
> > 
> > 	https://www.spinics.net/lists/linux-wireless/msg208353.html
> > 
> > so before I start digging deep into it (the previous kernel this 
> > particular machine had is 5.9, so I'd rather avoid lenghty bisect for now 
> > in case someone has already looked into it and has ideas where the problem 
> > is), I thought I'd ask whether this has been root-caused elsewhere 
> > already.
> 
> Yeah, I'm pretty sure we have a fix for this, though I'm not sure right
> now where it is in the pipeline.
> 
> It's called "iwlwifi: pcie: don't add NAPI under rxq->lock" but right
> now I can't find it in any of the public archives.

I was not able to find that patch anywhere indeed, but in the meantime I 
fixed it by the patch below. Please consider merging either of the fixes.

Also I am still seeing

	WARNING: CPU: 2 PID: 1138 at kernel/softirq.c:178 __local_bh_enable_ip+0xa5/0xf0

on the

	[   21.902173]  iwl_pcie_enqueue_hcmd+0x5d9/0xa00 [iwlwifi]
	[   21.906445]  iwl_trans_txq_send_hcmd+0x6c/0x430 [iwlwifi]
	[   21.910757]  iwl_trans_send_cmd+0x88/0x170 [iwlwifi]
	[   21.915074]  ? lock_acquire+0x277/0x3d0
	[   21.919327]  iwl_mvm_send_cmd+0x32/0x80 [iwlmvm]
	[   21.923616]  iwl_mvm_led_set+0xc2/0xe0 [iwlmvm]

codepath, but I'll look into it separately.



From: Jiri Kosina <jkosina@suse.cz>
Subject: [PATCH] iwlwifi: don't call netif_napi_add() with rxq->lock held

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
 drivers/net/wireless/intel/iwlwifi/pcie/rx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
index 1bccaa034284..6262dd9043aa 100644
--- a/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
+++ b/drivers/net/wireless/intel/iwlwifi/pcie/rx.c
@@ -1063,11 +1063,12 @@ static int _iwl_pcie_rx_init(struct iwl_trans *trans)
 
 		iwl_pcie_rx_init_rxb_lists(rxq);
 
+		spin_unlock_bh(&rxq->lock);
+
 		if (!rxq->napi.poll)
 			netif_napi_add(&trans_pcie->napi_dev, &rxq->napi,
 				       iwl_pcie_dummy_napi_poll, 64);
 
-		spin_unlock_bh(&rxq->lock);
 	}
 
 	/* move the pool to the default queue and allocator ownerships */


-- 
Jiri Kosina
SUSE Labs

