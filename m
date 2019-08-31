Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00BB8A44A8
	for <lists+linux-wireless@lfdr.de>; Sat, 31 Aug 2019 15:45:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727305AbfHaNpZ (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 31 Aug 2019 09:45:25 -0400
Received: from isilmar-4.linta.de ([136.243.71.142]:47826 "EHLO
        isilmar-4.linta.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726740AbfHaNpZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 31 Aug 2019 09:45:25 -0400
X-Greylist: delayed 377 seconds by postgrey-1.27 at vger.kernel.org; Sat, 31 Aug 2019 09:45:23 EDT
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
X-isilmar-external: YES
Received: from owl.dominikbrodowski.net (owl-tcp.brodo.linta [10.1.0.111])
        by isilmar-4.linta.de (Postfix) with ESMTPSA id 2FE5E2006F8;
        Sat, 31 Aug 2019 13:39:05 +0000 (UTC)
Received: by owl.dominikbrodowski.net (Postfix, from userid 1000)
        id E932D807DA; Sat, 31 Aug 2019 15:38:52 +0200 (CEST)
Date:   Sat, 31 Aug 2019 15:38:52 +0200
From:   Dominik Brodowski <linux@dominikbrodowski.net>
To:     johannes.berg@intel.com, emmanuel.grumbach@intel.com,
        luciano.coelho@intel.com, linuxwifi@intel.com
Cc:     linux-wireless@vger.kernel.org
Subject: iwlwifi: WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
Message-ID: <20190831133852.GA5488@owl.dominikbrodowski.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi!

On 5.3.0-rc6+, I get the following lockdep warning:

=====================================================
WARNING: SOFTIRQ-safe -> SOFTIRQ-unsafe lock order detected
5.3.0-rc6+ #1 Tainted: G                T
-----------------------------------------------------
kworker/u16:1/59 [HC0[0]:SC0[2]:HE1:SE0] is trying to acquire:
000000009c839cff (&(&mvm_sta->lq_sta.rs_drv.pers.lock)->rlock){+.+.}, at: iwl_mvm_rs_rate_init+0x53/0x80

0000000084f6e8c2 (&(&sta->rate_ctrl_lock)->rlock){+.-.}, at: rate_control_rate_update+0xd0/0x1f0
which would create a new lock dependency:
 (&(&sta->rate_ctrl_lock)->rlock){+.-.} -> (&(&mvm_sta->lq_sta.rs_drv.pers.lock)->rlock){+.+.}

 (&(&sta->rate_ctrl_lock)->rlock){+.-.}

  lock_acquire+0xb8/0x1b0
  _raw_spin_lock_bh+0x39/0x80
  rate_control_get_rate+0x10e/0x140
  ieee80211_tx_h_rate_ctrl+0x1a9/0x3f0
  ieee80211_xmit_fast+0x260/0x9d0
  __ieee80211_subif_start_xmit+0x146/0x390
  ieee80211_subif_start_xmit+0x4a/0x3c0
  dev_hard_start_xmit+0xb0/0x310
  sch_direct_xmit+0xed/0x230
  __dev_queue_xmit+0x5ef/0xc10
  ip_finish_output2+0x2f2/0x9a0
  ip_output+0x84/0x250
  __ip_queue_xmit+0x1e0/0x5e0
  __tcp_transmit_skb+0x59f/0xb70
  tcp_write_xmit+0x369/0x1110
  tcp_tsq_handler+0x4f/0xa0
  tcp_tasklet_func+0xdd/0x120
  tasklet_action_common.isra.0+0x60/0xb0
  __do_softirq+0xf0/0x478
  do_softirq_own_stack+0x2a/0x40
  do_softirq.part.0+0x4e/0x50
  __local_bh_enable_ip+0xfb/0x100
  iwl_pcie_irq_handler+0x1e9/0x7e0
  irq_thread_fn+0x20/0x60
  irq_thread+0xfa/0x1b0
  kthread+0x10a/0x140
  ret_from_fork+0x3a/0x50

 (&(&mvm_sta->lq_sta.rs_drv.pers.lock)->rlock){+.+.}

...
  lock_acquire+0xb8/0x1b0
  _raw_spin_lock+0x34/0x80
  iwl_mvm_rs_rate_init+0x53/0x80
  iwl_mvm_mac_sta_state+0x39c/0x640
  drv_sta_state+0xb2/0x7c0
  sta_info_move_state+0x196/0x280
  ieee80211_assoc_success+0x91e/0xfd0
  ieee80211_rx_mgmt_assoc_resp.cold+0x2dd/0x5f4
  ieee80211_sta_rx_queued_mgmt+0xd7/0x7d0
  ieee80211_iface_work+0x1c4/0x2f0
  process_one_work+0x234/0x580
  worker_thread+0x50/0x3b0
  kthread+0x10a/0x140
  ret_from_fork+0x3a/0x50

 Possible interrupt unsafe locking scenario:
       CPU0                    CPU1
       ----                    ----
  lock(&(&mvm_sta->lq_sta.rs_drv.pers.lock)->rlock);
                               local_irq_disable();
                               lock(&(&sta->rate_ctrl_lock)->rlock);
                               lock(&(&mvm_sta->lq_sta.rs_drv.pers.lock)->rlock);
  <Interrupt>
    lock(&(&sta->rate_ctrl_lock)->rlock);

6 locks held by kworker/u16:1/59:
 #0: 000000001e6d0995 ((wq_completion)phy0){+.+.}, at: process_one_work+0x1b1/0x580
 #1: 00000000378cac4d ((work_completion)(&sdata->work)){+.+.}, at: process_one_work+0x1b1/0x580
 #2: 00000000bbbbed75 (&wdev->mtx){+.+.}, at: ieee80211_sta_rx_queued_mgmt+0x51/0x7d0
 #3: 000000007f128f47 (&local->sta_mtx){+.+.}, at: ieee80211_rx_mgmt_beacon+0x583/0x16c0
 #4: 00000000fc24f76f (rcu_read_lock){....}, at: rate_control_rate_update+0x44/0x1f0
 #5: 0000000084f6e8c2 (&(&sta->rate_ctrl_lock)->rlock){+.-.}, at: rate_control_rate_update+0xd0/0x1f0

-> (&(&sta->rate_ctrl_lock)->rlock){+.-.} ops: 99793 {
   HARDIRQ-ON-W at:
                    lock_acquire+0xb8/0x1b0
                    _raw_spin_lock_bh+0x39/0x80
                    rate_control_rate_init+0xba/0x1d0
                    ieee80211_assoc_success+0x8bc/0xfd0
                    ieee80211_rx_mgmt_assoc_resp.cold+0x2dd/0x5f4
                    ieee80211_sta_rx_queued_mgmt+0xd7/0x7d0
                    ieee80211_iface_work+0x1c4/0x2f0
                    process_one_work+0x234/0x580
                    worker_thread+0x50/0x3b0
                    kthread+0x10a/0x140
                    ret_from_fork+0x3a/0x50
   IN-SOFTIRQ-W at:
                    lock_acquire+0xb8/0x1b0
                    _raw_spin_lock_bh+0x39/0x80
                    rate_control_get_rate+0x10e/0x140
                    ieee80211_tx_h_rate_ctrl+0x1a9/0x3f0
                    ieee80211_xmit_fast+0x260/0x9d0
                    __ieee80211_subif_start_xmit+0x146/0x390
                    ieee80211_subif_start_xmit+0x4a/0x3c0
                    dev_hard_start_xmit+0xb0/0x310
                    sch_direct_xmit+0xed/0x230
                    __dev_queue_xmit+0x5ef/0xc10
                    ip_finish_output2+0x2f2/0x9a0
                    ip_output+0x84/0x250
                    __ip_queue_xmit+0x1e0/0x5e0
                    __tcp_transmit_skb+0x59f/0xb70
                    tcp_write_xmit+0x369/0x1110
                    tcp_tsq_handler+0x4f/0xa0
                    tcp_tasklet_func+0xdd/0x120
                    tasklet_action_common.isra.0+0x60/0xb0
                    __do_softirq+0xf0/0x478
                    do_softirq_own_stack+0x2a/0x40
                    do_softirq.part.0+0x4e/0x50
                    __local_bh_enable_ip+0xfb/0x100
                    iwl_pcie_irq_handler+0x1e9/0x7e0
                    irq_thread_fn+0x20/0x60
                    irq_thread+0xfa/0x1b0
                    kthread+0x10a/0x140
                    ret_from_fork+0x3a/0x50
   INITIAL USE at:
                   lock_acquire+0xb8/0x1b0
                   _raw_spin_lock_bh+0x39/0x80
                   rate_control_rate_init+0xba/0x1d0
                   ieee80211_assoc_success+0x8bc/0xfd0
                   ieee80211_rx_mgmt_assoc_resp.cold+0x2dd/0x5f4
                   ieee80211_sta_rx_queued_mgmt+0xd7/0x7d0
                   ieee80211_iface_work+0x1c4/0x2f0
                   process_one_work+0x234/0x580
                   worker_thread+0x50/0x3b0
                   kthread+0x10a/0x140
                   ret_from_fork+0x3a/0x50
 }
 ... key      at: [<ffffffff8ca725b0>] __key.104096+0x0/0x10
 ... acquired at:
   lock_acquire+0xb8/0x1b0
   _raw_spin_lock+0x34/0x80
   iwl_mvm_rs_rate_init+0x53/0x80
   rate_control_rate_update+0xf2/0x1f0
   ieee80211_rx_mgmt_beacon.cold+0x131/0x20b
   ieee80211_sta_rx_queued_mgmt+0x8b/0x7d0
   ieee80211_iface_work+0x1c4/0x2f0
   process_one_work+0x234/0x580
   worker_thread+0x50/0x3b0
   kthread+0x10a/0x140
   ret_from_fork+0x3a/0x50


 and SOFTIRQ-irq-unsafe lock:
-> (&(&mvm_sta->lq_sta.rs_drv.pers.lock)->rlock){+.+.} ops: 51276 {
   HARDIRQ-ON-W at:
                    lock_acquire+0xb8/0x1b0
                    _raw_spin_lock+0x34/0x80
                    iwl_mvm_rs_rate_init+0x53/0x80
                    iwl_mvm_mac_sta_state+0x39c/0x640
                    drv_sta_state+0xb2/0x7c0
                    sta_info_move_state+0x196/0x280
                    ieee80211_assoc_success+0x91e/0xfd0
                    ieee80211_rx_mgmt_assoc_resp.cold+0x2dd/0x5f4
                    ieee80211_sta_rx_queued_mgmt+0xd7/0x7d0
                    ieee80211_iface_work+0x1c4/0x2f0
                    process_one_work+0x234/0x580
                    worker_thread+0x50/0x3b0
                    kthread+0x10a/0x140
                    ret_from_fork+0x3a/0x50
   SOFTIRQ-ON-W at:
                    lock_acquire+0xb8/0x1b0
                    _raw_spin_lock+0x34/0x80
                    iwl_mvm_rs_rate_init+0x53/0x80
                    iwl_mvm_mac_sta_state+0x39c/0x640
                    drv_sta_state+0xb2/0x7c0
                    sta_info_move_state+0x196/0x280
                    ieee80211_assoc_success+0x91e/0xfd0
                    ieee80211_rx_mgmt_assoc_resp.cold+0x2dd/0x5f4
                    ieee80211_sta_rx_queued_mgmt+0xd7/0x7d0
                    ieee80211_iface_work+0x1c4/0x2f0
                    process_one_work+0x234/0x580
                    worker_thread+0x50/0x3b0
                    kthread+0x10a/0x140
                    ret_from_fork+0x3a/0x50
   INITIAL USE at:
                   lock_acquire+0xb8/0x1b0
                   _raw_spin_lock+0x34/0x80
                   iwl_mvm_rs_rate_init+0x53/0x80
                   iwl_mvm_mac_sta_state+0x39c/0x640
                   drv_sta_state+0xb2/0x7c0
                   sta_info_move_state+0x196/0x280
                   ieee80211_assoc_success+0x91e/0xfd0
                   ieee80211_rx_mgmt_assoc_resp.cold+0x2dd/0x5f4
                   ieee80211_sta_rx_queued_mgmt+0xd7/0x7d0
                   ieee80211_iface_work+0x1c4/0x2f0
                   process_one_work+0x234/0x580
                   worker_thread+0x50/0x3b0
                   kthread+0x10a/0x140
                   ret_from_fork+0x3a/0x50
 }
 ... key      at: [<ffffffff8ca40eb0>] __key.90552+0x0/0x10
 ... acquired at:
   lock_acquire+0xb8/0x1b0
   _raw_spin_lock+0x34/0x80
   iwl_mvm_rs_rate_init+0x53/0x80
   rate_control_rate_update+0xf2/0x1f0
   ieee80211_rx_mgmt_beacon.cold+0x131/0x20b
   ieee80211_sta_rx_queued_mgmt+0x8b/0x7d0
   ieee80211_iface_work+0x1c4/0x2f0
   process_one_work+0x234/0x580
   worker_thread+0x50/0x3b0
   kthread+0x10a/0x140
   ret_from_fork+0x3a/0x50


CPU: 2 PID: 59 Comm: kworker/u16:1 Tainted: G                T 5.3.0-rc6+ #1
Hardware name: Dell Inc. Latitude 7390/09386V, BIOS 1.9.2 04/03/2019
Workqueue: phy0 ieee80211_iface_work
Call Trace:
 dump_stack+0x67/0x98
 check_irq_usage.cold+0x495/0x50a
 ? mark_held_locks+0x46/0x70
 ? check_noncircular+0xbf/0x1c0
 ? lockdep_hardirqs_on+0xe3/0x1b0
 ? __lock_acquire+0xe6a/0x1ac0
 __lock_acquire+0xe6a/0x1ac0
 lock_acquire+0xb8/0x1b0
 ? iwl_mvm_rs_rate_init+0x53/0x80
 _raw_spin_lock+0x34/0x80
 ? iwl_mvm_rs_rate_init+0x53/0x80
 iwl_mvm_rs_rate_init+0x53/0x80
 rate_control_rate_update+0xf2/0x1f0
 ieee80211_rx_mgmt_beacon.cold+0x131/0x20b
 ? _raw_spin_unlock_irqrestore+0x34/0x60
 ? _raw_spin_unlock_irqrestore+0x3e/0x60
 ieee80211_sta_rx_queued_mgmt+0x8b/0x7d0
 ? __lock_acquire+0x4dc/0x1ac0
 ? __lock_acquire+0x4dc/0x1ac0
 ? skb_dequeue+0x18/0x70
 ? preempt_count_sub+0x9b/0xd0
 ieee80211_iface_work+0x1c4/0x2f0
 process_one_work+0x234/0x580
 worker_thread+0x50/0x3b0
 kthread+0x10a/0x140
 ? process_one_work+0x580/0x580
 ? kthread_park+0x80/0x80
 ret_from_fork+0x3a/0x50


Thanks,
	Dominik
