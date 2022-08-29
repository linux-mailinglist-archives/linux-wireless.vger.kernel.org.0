Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D9A5A543F
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Aug 2022 20:57:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbiH2S5f (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 29 Aug 2022 14:57:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiH2S5d (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 29 Aug 2022 14:57:33 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [67.231.154.183])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62C3478BC7
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 11:57:32 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.110.51.24])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id 122B81A0072
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 18:57:31 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id CB3FA3C007B
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 18:57:30 +0000 (UTC)
Received: from [192.168.100.195] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 4F55A13C2B0
        for <linux-wireless@vger.kernel.org>; Mon, 29 Aug 2022 11:57:30 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 4F55A13C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1661799450;
        bh=6PLMBc1hpRYmvAqoyfDWb3oIXGPa+zAFV6KuPsk9xJQ=;
        h=To:From:Subject:Date:From;
        b=Gn2FisJKtVdJipboVilocPWt5oIWgkCLKnaCp1ietzldxrrRKbZxO/ghgq/RA9H92
         zLLKQH4sAJW4S+0yoQ2K/Ud/1zBiziX//+To7sxPRwwrXyacPEDAn2d3dqCkKLO8jp
         XOVOwao5a6LUwP+yIb6xUHAS2yLbXGTP160WD8i0=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: iwlwifi related crash in 5.19.3+
Organization: Candela Technologies
Message-ID: <dbb1e6a2-a701-b3e9-00ab-8f95f1dfc036@candelatech.com>
Date:   Mon, 29 Aug 2022 11:57:30 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-MDID: 1661799451-EyzPJSnGUt1N
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

I'm curious if anyone has seen something similar?

BUG: kernel NULL pointer dereference, address: 00000000000000b0^M
#PF: supervisor read access in kernel mode^M
pcieport 0000:00:1c.0: AER: Uncorrected (Non-Fatal) error received: 0000:03:05.0^M
#PF: error_code(0x0000) - not-present page^M
PGD 0 P4D 0 ^M
Oops: 0000 [#1] PREEMPT SMP^M
CPU: 2 PID: 1075 Comm: irq/197-iwlwifi Tainted: G        W  O      5.19.3+ #9^M
Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020^M
RIP: 0010:iwl_pcie_rx_handle+0x3a4/0x8f0 [iwlwifi]^M
Code: 8d b6 80 00 00 00 48 8b 07 39 d1 4c 89 e2 0f 85 88 fe ff ff ff 50 10 44 0f b6 04 24 45 84 c0 0f 84 88 fe ff ff 48 8b 4c 24 20 <8b> 81 b0 00 00 00 48 8b 51 
18 89 04 24 0f b7 04 24 83 e8 01 66 41^M
RSP: 0018:ffffc9000017ce30 EFLAGS: 00010202^M
RAX: 0000000000000000 RBX: 0000000000000040 RCX: 0000000000000000^M
RDX: 00000000000002ff RSI: 00000000fffffe00 RDI: ffffffffa09ed490^M
RBP: ffff88810c466db8 R08: 0000000000000001 R09: 0000000000000000^M
R10: ffffc9000017cde0 R11: ffffffff83194040 R12: ffffc9000017ce80^M
R13: ffff888111170028 R14: ffff888116ec0000 R15: ffff88812646d000^M
FS:  0000000000000000(0000) GS:ffff88845dc80000(0000) knlGS:0000000000000000^M
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033^M
CR2: 00000000000000b0 CR3: 0000000113b74001 CR4: 00000000003706e0^M
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000^M
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400^M
Call Trace:^M
  <IRQ>^M
  iwl_pcie_napi_poll_msix+0x24/0xc0 [iwlwifi]^M
  __napi_poll+0x1f/0x150^M
  net_rx_action+0x28e/0x2e0^M
  __do_softirq+0xbb/0x28e^M
  ? disable_irq_nosync+0x10/0x10^M
  do_softirq.part.0+0x38/0x50^M
  </IRQ>^M
  <TASK>^M
  __local_bh_enable_ip+0x51/0x60^M
  iwl_pcie_irq_rx_msix_handler+0xb5/0x110 [iwlwifi]^M
  irq_thread_fn+0x15/0x50^M
  irq_thread+0xde/0x1a0^M
  ? irq_thread_fn+0x50/0x50^M
  ? irq_thread_check_affinity+0x80/0x80^M
  kthread+0xd1/0x100^M
  ? kthread_complete_and_exit+0x20/0x20^M
  ret_from_fork+0x1f/0x30^M
  </TASK>^M



(gdb) l *(iwl_pcie_irq_rx_msix_handler+0xb5)
0xa855 is in iwl_pcie_irq_rx_msix_handler (/home/greearb/git/linux-5.19.dev.y/drivers/net/wireless/intel/iwlwifi/pcie/rx.c:1650).
1645			iwl_pcie_clear_irq(trans, entry->entry);
1646		local_bh_enable();
1647	
1648		lock_map_release(&trans->sync_cmd_lockdep_map);
1649	
1650		return IRQ_HANDLED;
1651	}
1652	
1653	/*
1654	 * iwl_pcie_irq_handle_error - called for HW or SW error interrupt from card
(gdb) l *(iwl_pcie_rx_handle+0x3a4)
0x9284 is in iwl_pcie_rx_handle (/home/greearb/git/linux-5.19.dev.y/drivers/net/wireless/intel/iwlwifi/pcie/rx.c:1373).
1368			if (reclaim) {
1369				u16 sequence = le16_to_cpu(pkt->hdr.sequence);
1370				int index = SEQ_TO_INDEX(sequence);
1371				int cmd_index = iwl_txq_get_cmd_index(txq, index);
1372	
1373				kfree_sensitive(txq->entries[cmd_index].free_buf);
1374				txq->entries[cmd_index].free_buf = NULL;
1375	
1376				/* Invoke any callbacks, transfer the buffer to caller,
1377				 * and fire off the (possibly) blocking
(gdb)

Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com

