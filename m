Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 58A7717A72B
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Mar 2020 15:13:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726099AbgCEON4 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 5 Mar 2020 09:13:56 -0500
Received: from fold.natur.cuni.cz ([195.113.57.32]:45770 "EHLO
        fold.natur.cuni.cz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725974AbgCEON4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 5 Mar 2020 09:13:56 -0500
X-Greylist: delayed 341 seconds by postgrey-1.27 at vger.kernel.org; Thu, 05 Mar 2020 09:13:55 EST
Received: from [192.168.251.10] (asus_g552vw [192.168.251.10])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by fold.natur.cuni.cz (Postfix) with ESMTPS id C974F10FC295
        for <linux-wireless@vger.kernel.org>; Thu,  5 Mar 2020 15:08:12 +0100 (MET)
To:     linux-wireless@vger.kernel.org
From:   Martin Mokrejs <mmokrejs@fold.natur.cuni.cz>
Subject: 5.4.20: WARNING: CPU: 1 PID: 2721 at
 drivers/net/wireless/intel/iwlwifi/mvm/tx.c:333
 iwl_mvm_get_tx_rate.isra.0+0xb7/0xd0
Autocrypt: addr=mmokrejs@fold.natur.cuni.cz; prefer-encrypt=mutual; keydata=
 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
 vhAAniqNXIsAJtnhCdggmBmY0OwRUQNY
Message-ID: <8fa3df7d-cb9b-a8fd-61bb-78ddfa8456a2@fold.natur.cuni.cz>
Date:   Thu, 5 Mar 2020 15:08:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hi,
  I just want to report the following message I received on Dell Latitude E5580:

[359398.815450] ------------[ cut here ]------------
[359398.815452] Got an HT rate (flags:0x88/mcs:14) for a non data frame
[359398.815466] WARNING: CPU: 1 PID: 2721 at drivers/net/wireless/intel/iwlwifi/mvm/tx.c:333 iwl_mvm_get_tx_rate.isra.0+0xb7/0xd0
[359398.815467] Modules linked in: vmnet(O) vmmon(O) vmw_vsock_vmci_transport vmw_vmci vboxnetadp(O) vboxnetflt(O) uvcvideo videobuf2_vmalloc videobuf2_memops videobuf2_v4l2 videobuf2_common vboxdrv(O) dell_smm_hwmon x86_pkg_temp_thermal coretemp kvm_intel kvm irqbypass mei_wdt intel_pch_thermal hid_alps rtsx_pci_sdmmc i2c_hid
[359398.815476] CPU: 1 PID: 2721 Comm: irq/132-iwlwifi Tainted: G           O      5.4.20 #1
[359398.815477] Hardware name: Dell Inc. Latitude 5580/0DW6V0, BIOS 1.16.0 07/03/2019
[359398.815479] RIP: 0010:iwl_mvm_get_tx_rate.isra.0+0xb7/0xd0
[359398.815480] Code: 09 d0 41 5d c3 0f 0b 31 db eb d4 80 3d 4d 81 1d 01 00 75 85 0f b7 f1 48 c7 c7 08 1e 80 82 c6 05 3a 81 1d 01 01 e8 c2 98 79 ff <0f> 0b 0f be 55 08 89 d3 e9 62 ff ff ff 66 66 2e 0f 1f 84 00 00 00
[359398.815481] RSP: 0000:ffffc90001457240 EFLAGS: 00010286
[359398.815481] RAX: 0000000000000000 RBX: 000000000000000e RCX: 0000000000000006
[359398.815482] RDX: 0000000000000007 RSI: 0000000000000082 RDI: ffff88880e256430
[359398.815482] RBP: ffffc90001457390 R08: 0000000000000001 R09: 0000000000000f63
[359398.815483] R10: 000000000004f754 R11: 0000000000000000 R12: ffff888505c028a0
[359398.815484] R13: ffff8887fad6abd0 R14: ffffc90001457390 R15: 0000000000004188
[359398.815484] FS:  0000000000000000(0000) GS:ffff88880e240000(0000) knlGS:0000000000000000
[359398.815485] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[359398.815486] CR2: 00007ff5fc913000 CR3: 00000007f6c68003 CR4: 00000000003606e0
[359398.815486] DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
[359398.815487] DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
[359398.815487] Call Trace:
[359398.815491]  iwl_mvm_set_tx_cmd_rate+0x61/0xc0
[359398.815492]  iwl_mvm_set_tx_params+0x16b/0x480
[359398.815494]  iwl_mvm_tx_mpdu+0x8e/0x590
[359398.815496]  ? ktime_get+0x33/0x90
[359398.815498]  iwl_mvm_tx_skb_sta+0x196/0x450
[359398.815499]  iwl_mvm_tx_skb+0x12/0x30
[359398.815500]  iwl_mvm_mac_itxq_xmit+0x6e/0xd0
[359398.815502]  ieee80211_queue_skb+0x2a5/0x410
[359398.815504]  __ieee80211_subif_start_xmit+0xb18/0xc50
[359398.815506]  ? ___bpf_prog_run+0x945/0x13a0
[359398.815507]  ? __bpf_prog_run32+0x34/0x60
[359398.815508]  ieee80211_subif_start_xmit+0x40/0x2d0
[359398.815510]  ? dev_queue_xmit_nit+0x23b/0x250
[359398.815511]  dev_hard_start_xmit+0x88/0x1d0
[359398.815512]  __dev_queue_xmit+0x551/0x7e0
[359398.815515]  ip_finish_output2+0x2a1/0x560
[359398.815516]  ? nf_nat_ipv4_out+0xf/0x90
[359398.815517]  ip_output+0x6c/0xf0
[359398.815518]  ? __ip_finish_output+0x1b0/0x1b0
[359398.815519]  __ip_queue_xmit+0x152/0x3c0
[359398.815521]  __tcp_transmit_skb+0x51e/0xa60
[359398.815522]  tcp_write_xmit+0x373/0x1150
[359398.815523]  __tcp_push_pending_frames+0x2d/0xe0
[359398.815524]  tcp_rcv_established+0x316/0x630
[359398.815525]  tcp_v4_do_rcv+0x12c/0x1f0
[359398.815526]  tcp_v4_rcv+0xacb/0xbd0
[359398.815528]  ip_protocol_deliver_rcu+0x26/0x1b0
[359398.815529]  ip_local_deliver_finish+0x3f/0x50
[359398.815530]  ip_local_deliver+0xe0/0xf0
[359398.815530]  ? ip_protocol_deliver_rcu+0x1b0/0x1b0
[359398.815531]  ip_rcv+0xb7/0xc0
[359398.815533]  ? ip_rcv_finish_core.isra.0+0x340/0x340
[359398.815534]  __netif_receive_skb_one_core+0x7b/0x90
[359398.815535]  netif_receive_skb_internal+0x2a/0xa0
[359398.815536]  napi_gro_receive+0xf2/0x150
[359398.815539]  ieee80211_deliver_skb+0xbf/0x210
[359398.815541]  __ieee80211_rx_h_amsdu+0x144/0x1d0
[359398.815542]  ieee80211_rx_handlers+0x705/0x2800
[359398.815544]  ? dma_pte_clear_level+0x15b/0x1b0
[359398.815545]  ? ieee80211_sta_reorder_release.isra.0+0xab/0x340
[359398.815546]  ieee80211_prepare_and_rx_handle+0x74c/0x1250
[359398.815547]  ? dma_pte_clear_level+0x12e/0x1b0
[359398.815548]  ieee80211_rx_napi+0x34d/0xa00
[359398.815551]  iwl_pcie_rx_handle+0x3e7/0xa80
[359398.815553]  iwl_pcie_irq_handler+0x528/0xa50
[359398.815555]  ? irq_forced_thread_fn+0x70/0x70
[359398.815556]  irq_thread_fn+0x1b/0x60
[359398.815557]  irq_thread+0xd3/0x150
[359398.815559]  ? wake_threads_waitq+0x30/0x30
[359398.815560]  ? irq_thread_dtor+0x80/0x80
[359398.815562]  kthread+0x113/0x130
[359398.815563]  ? kthread_create_worker_on_cpu+0x60/0x60
[359398.815565]  ret_from_fork+0x35/0x40
[359398.815566] ---[ end trace ddf22f1e4ae1932d ]---


01:00.0 Network controller: Intel Corporation Wireless 8265 / 8275 (rev 78)
	Subsystem: Intel Corporation Wireless 8265 / 8275
	Flags: bus master, fast devsel, latency 0, IRQ 132
	Memory at ef200000 (64-bit, non-prefetchable) [size=8K]
	Capabilities: [c8] Power Management version 3
	Capabilities: [d0] MSI: Enable+ Count=1/1 Maskable- 64bit+
	Capabilities: [40] Express Endpoint, MSI 00
	Capabilities: [100] Advanced Error Reporting
	Capabilities: [140] Device Serial Number cc-2f-71-ff-xx-xx-xx-xx
	Capabilities: [14c] Latency Tolerance Reporting
	Capabilities: [154] L1 PM Substates
	Kernel driver in use: iwlwifi


Hope this helps,
Martin
