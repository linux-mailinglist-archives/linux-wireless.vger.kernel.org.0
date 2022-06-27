Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73BBF55C410
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Jun 2022 14:49:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235268AbiF0Mpa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 27 Jun 2022 08:45:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234889AbiF0Mp3 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 27 Jun 2022 08:45:29 -0400
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 27 Jun 2022 05:45:28 PDT
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39D63EE12
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jun 2022 05:45:28 -0700 (PDT)
Received: from dispatch1-us1.ppe-hosted.com (localhost.localdomain [127.0.0.1])
        by dispatch1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id 91E212529EA
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jun 2022 12:40:24 +0000 (UTC)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.48.6])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 12C00A0068
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jun 2022 12:40:23 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CD70C900061
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jun 2022 12:40:22 +0000 (UTC)
Received: from [192.168.1.188] (c-174-53-186-166.hsd1.mn.comcast.net [174.53.186.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 1335A13C2B0
        for <linux-wireless@vger.kernel.org>; Mon, 27 Jun 2022 05:40:21 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 1335A13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1656333622;
        bh=zbrY/J3E2/TGZSK7gUIpdipaxveUpB84i9g4jESnbwo=;
        h=Date:To:From:Subject:From;
        b=AMVxjYNEtALBHku4o9Ki7N/jpeVNjMsl9DgM+1EAdS2DCwy5jBA04XtGiWZCWSMKX
         0bJRywT9PrMUGhczQIqN2Gc046DotcbmSO2Bo0P+bCA5dOpCWSLtFRJaqAfsHdl6Zd
         XG2MidZQXS15t/dMtYrZAAUo5t4C7LLX1HEAqR8M=
Message-ID: <2c2f64d1-a9e1-e796-ef57-c1d389cff990@candelatech.com>
Date:   Mon, 27 Jun 2022 05:40:21 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-MW
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: ax210 use-after-free and kernel lockup in 5.17.8+ kernel.
Organization: Candela Technologies
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-MDID: 1656333623-G1dN-8grzyL4
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,HEXHASH_WORD,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

We have a system that has been getting softlockups, and after installing a debugging
kernel, our user was able to reproduce at least one of the problems.  It appears to be
use-after-free bug in iwlwifi driver.

Has anyone seen this?  Any ideas on how to debug more?

This kernel has the iwlwifi patches from 5.18 backported into
it, so it is mostly 5.18 as far as the driver is concerned.

==================================================================
BUG: KASAN: use-after-free in iwl_mvm_tx_skb_sta+0xcf/0x7b0 [iwlmvm]
Read of size 48 at addr ffff88815a683ce8 by task irq/163-iwlwifi/1031

CPU: 2 PID: 1031 Comm: irq/163-iwlwifi Tainted: G        W         5.17.8+ #33
Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
Call Trace:
  <IRQ>
  dump_stack_lvl+0x47/0x5c
  print_address_description.constprop.10+0x41/0x60
  ? iwl_mvm_tx_skb_sta+0xcf/0x7b0 [iwlmvm]
  ? iwl_mvm_tx_skb_sta+0xcf/0x7b0 [iwlmvm]
  kasan_report.cold.15+0x83/0xdf
  ? iwl_mvm_tx_skb_sta+0xcf/0x7b0 [iwlmvm]
  kasan_check_range+0x1a9/0x1c0
  memcpy+0x1f/0x60
  iwl_mvm_tx_skb_sta+0xcf/0x7b0 [iwlmvm]
  ? kasan_save_stack+0x2b/0x40
  ? kasan_save_stack+0x1c/0x40
  ? kasan_set_track+0x21/0x30
  ? ieee80211_tx_status+0xd1/0x130 [mac80211]
  ? iwl_mvm_max_amsdu_size+0x1a0/0x1a0 [iwlmvm]
  ? __local_bh_enable_ip+0x52/0x60
  ? iwl_pcie_irq_rx_msix_handler+0x108/0x220 [iwlwifi]
  ? irq_thread_fn+0x38/0x90
  ? irq_thread+0x18d/0x270
  ? kthread+0x14c/0x180
  ? ret_from_fork+0x1f/0x30
  iwl_mvm_tx_skb+0x12/0x40 [iwlmvm]
  iwl_mvm_mac_itxq_xmit+0xd4/0x1a0 [iwlmvm]
  iwl_mvm_queue_state_change+0x26d/0x330 [iwlmvm]
  iwl_txq_reclaim+0xa4e/0xab0 [iwlwifi]
  ? ieee80211_tx_status+0xd1/0x130 [mac80211]
  ? iwl_txq_progress+0x90/0x90 [iwlwifi]
  ? ieee80211_tx_status_ext+0x1460/0x1460 [mac80211]
  ? iwl_dbg_tlv_apply_config.isra.10+0x90/0x660 [iwlwifi]
  ? iwl_mvm_tx_reclaim+0x1a9/0x640 [iwlmvm]
  iwl_mvm_tx_reclaim+0x1a9/0x640 [iwlmvm]
  ? iwl_mvm_hwrate_to_tx_status+0x60/0x60 [iwlmvm]
  iwl_mvm_rx_ba_notif+0x65b/0x740 [iwlmvm]
  ? iwl_mvm_rx_tx_cmd+0x12c0/0x12c0 [iwlmvm]
  ? __iwl_dbg+0xbd/0x1b0 [iwlwifi]
  ? iwl_notification_wait+0x19/0x180 [iwlwifi]
  ? test_bit.constprop.2+0x30/0x30 [iwlwifi]
  iwl_mvm_rx_common+0x18e/0x5a0 [iwlmvm]
  ? iwl_mvm_start_post_nvm+0x1e0/0x1e0 [iwlmvm]
  ? dma_unmap_page_attrs+0x140/0x290
  iwl_pcie_rx_handle+0x7fd/0x1170 [iwlwifi]
  ? iwl_pcie_rxq_alloc_rbs+0x330/0x330 [iwlwifi]
  iwl_pcie_napi_poll_msix+0x48/0x120 [iwlwifi]
  __napi_poll+0x52/0x240
  net_rx_action+0x4ab/0x530
  ? napi_threaded_poll+0x250/0x250
  ? rcu_segcblist_ready_cbs+0x10/0x30
  ? rcu_core+0x25f/0xa80
  ? _raw_read_unlock+0x30/0x30
  ? add_interrupt_randomness+0x15a/0x320
  __do_softirq+0xf0/0x3a3
  do_softirq+0x48/0x60
  </IRQ>
  <TASK>
  __local_bh_enable_ip+0x52/0x60
  iwl_pcie_irq_rx_msix_handler+0x108/0x220 [iwlwifi]
  ? iwl_pcie_rx_free+0x280/0x280 [iwlwifi]
  ? irq_forced_thread_fn+0xc0/0xc0
  irq_thread_fn+0x38/0x90
  irq_thread+0x18d/0x270
  ? irq_thread_check_affinity.part.51+0xd0/0xd0
  ? wake_threads_waitq+0x40/0x40
  ? irq_thread_check_affinity.part.51+0xd0/0xd0
  kthread+0x14c/0x180
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30
  </TASK>

Allocated by task 2329:

Freed by task 1031:

The buggy address belongs to the object at ffff88815a683cc0
  which belongs to the cache skbuff_head_cache of size 224
The buggy address is located 40 bytes inside of
  224-byte region [ffff88815a683cc0, ffff88815a683da0)
The buggy address belongs to the page:

Memory state around the buggy address:
  ffff88815a683b80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88815a683c00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 >ffff88815a683c80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                                           ^
  ffff88815a683d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88815a683d80: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================
==================================================================
BUG: KASAN: double-free or invalid-free in iwl_mvm_mac_itxq_xmit+0xd4/0x1a0 [iwlmvm]

CPU: 2 PID: 1031 Comm: irq/163-iwlwifi Tainted: G    B   W         5.17.8+ #33
Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
Call Trace:
  <IRQ>
  dump_stack_lvl+0x47/0x5c
  print_address_description.constprop.10+0x41/0x60
  ? iwl_mvm_mac_itxq_xmit+0xd4/0x1a0 [iwlmvm]
  kasan_report_invalid_free+0x50/0x80
  ? iwl_mvm_mac_itxq_xmit+0xd4/0x1a0 [iwlmvm]
  __kasan_slab_free+0x117/0x140
  ? iwl_mvm_mac_itxq_xmit+0xd4/0x1a0 [iwlmvm]
  kmem_cache_free+0x98/0x2b0
  iwl_mvm_mac_itxq_xmit+0xd4/0x1a0 [iwlmvm]
  iwl_mvm_queue_state_change+0x26d/0x330 [iwlmvm]
  iwl_txq_reclaim+0xa4e/0xab0 [iwlwifi]
  ? ieee80211_tx_status+0xd1/0x130 [mac80211]
  ? iwl_txq_progress+0x90/0x90 [iwlwifi]
  ? ieee80211_tx_status_ext+0x1460/0x1460 [mac80211]
  ? iwl_dbg_tlv_apply_config.isra.10+0x90/0x660 [iwlwifi]
  ? iwl_mvm_tx_reclaim+0x1a9/0x640 [iwlmvm]
  iwl_mvm_tx_reclaim+0x1a9/0x640 [iwlmvm]
  ? iwl_mvm_hwrate_to_tx_status+0x60/0x60 [iwlmvm]
  iwl_mvm_rx_ba_notif+0x65b/0x740 [iwlmvm]
  ? iwl_mvm_rx_tx_cmd+0x12c0/0x12c0 [iwlmvm]
  ? __iwl_dbg+0xbd/0x1b0 [iwlwifi]
  ? iwl_notification_wait+0x19/0x180 [iwlwifi]
  ? test_bit.constprop.2+0x30/0x30 [iwlwifi]
  iwl_mvm_rx_common+0x18e/0x5a0 [iwlmvm]
  ? iwl_mvm_start_post_nvm+0x1e0/0x1e0 [iwlmvm]
  ? dma_unmap_page_attrs+0x140/0x290
  iwl_pcie_rx_handle+0x7fd/0x1170 [iwlwifi]
  ? iwl_pcie_rxq_alloc_rbs+0x330/0x330 [iwlwifi]
  iwl_pcie_napi_poll_msix+0x48/0x120 [iwlwifi]
  __napi_poll+0x52/0x240
  net_rx_action+0x4ab/0x530
  ? napi_threaded_poll+0x250/0x250
  ? rcu_segcblist_ready_cbs+0x10/0x30
  ? rcu_core+0x25f/0xa80
  ? _raw_read_unlock+0x30/0x30
  ? add_interrupt_randomness+0x15a/0x320
  __do_softirq+0xf0/0x3a3
  do_softirq+0x48/0x60
  </IRQ>
  <TASK>
  __local_bh_enable_ip+0x52/0x60
  iwl_pcie_irq_rx_msix_handler+0x108/0x220 [iwlwifi]
  ? iwl_pcie_rx_free+0x280/0x280 [iwlwifi]
  ? irq_forced_thread_fn+0xc0/0xc0
  irq_thread_fn+0x38/0x90
  irq_thread+0x18d/0x270
  ? irq_thread_check_affinity.part.51+0xd0/0xd0
  ? wake_threads_waitq+0x40/0x40
  ? irq_thread_check_affinity.part.51+0xd0/0xd0
  kthread+0x14c/0x180
  ? kthread_complete_and_exit+0x20/0x20
  ret_from_fork+0x1f/0x30
  </TASK>

Allocated by task 2329:

Freed by task 1031:

The buggy address belongs to the object at ffff88815a683cc0
  which belongs to the cache skbuff_head_cache of size 224
The buggy address is located 0 bytes inside of
  224-byte region [ffff88815a683cc0, ffff88815a683da0)
The buggy address belongs to the page:

Memory state around the buggy address:
  ffff88815a683b80: fa fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88815a683c00: fb fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
 >ffff88815a683c80: fc fc fc fc fc fc fc fc fa fb fb fb fb fb fb fb
                                            ^
  ffff88815a683d00: fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb fb
  ffff88815a683d80: fb fb fb fb fc fc fc fc fc fc fc fc fc fc fc fc
==================================================================

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
