Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 67F4F3709BB
	for <lists+linux-wireless@lfdr.de>; Sun,  2 May 2021 05:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbhEBDVM (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 1 May 2021 23:21:12 -0400
Received: from dispatchb-us1.ppe-hosted.com ([148.163.129.53]:58490 "EHLO
        dispatchb-us1.ppe-hosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230409AbhEBDVL (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 1 May 2021 23:21:11 -0400
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mx1-us1.ppe-hosted.com (unknown [10.7.67.122])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTPS id E775F1A0062
        for <linux-wireless@vger.kernel.org>; Sun,  2 May 2021 03:20:19 +0000 (UTC)
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id BA55040061
        for <linux-wireless@vger.kernel.org>; Sun,  2 May 2021 03:20:19 +0000 (UTC)
Received: from [192.168.254.6] (unknown [50.34.172.155])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id F26F413C2B1
        for <linux-wireless@vger.kernel.org>; Sat,  1 May 2021 20:20:18 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com F26F413C2B1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1619925619;
        bh=JLJjUXPXi86w7lS9fn4V/siXWNj1TESROaU0QrNAyJI=;
        h=To:From:Subject:Date:From;
        b=C8d/WysibX3Nsi6kWqOU5QXDxPK1lAwhuiDXkfOYQlMnDA6Y5Ti4JLXSBElsGfhkF
         8XWeptZMYb5uWaL4tJtZD3bIAnBVREvyM1yRffwjP+sGnkS0CxZYjkYQC1vYT9tapC
         Tf3A4h2GvhRDGC0yGsXvZot+sdBAoVtGBacAgFZE=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: iwlwifi firmware crash and kernel crash.
Organization: Candela Technologies
Message-ID: <e6885c76-3853-4472-a8b4-18cde518adf4@candelatech.com>
Date:   Sat, 1 May 2021 20:20:18 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1619925620-CzMQdI98I_no
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

This is a 5.11-ish kernel, with a lot of 5.12-ish iwlwifi backported, and lots of hacks
of my own...

Curious if anyone has seen similar problems or have suggestions to try?

I'll build a KASAN kernel and see if I can reproduce under that...

iwlwifi 0000:0c:00.0: Microcode SW error detected. Restarting 0x0.
iwlwifi 0000:0c:00.0: Start IWL Error Log Dump:
iwlwifi 0000:0c:00.0: Status: 0x00000040, count: 6
iwlwifi 0000:0c:00.0: Loaded firmware version: 62.49eeb572.0 ty-a0-gf-a0-62.ucode
iwlwifi 0000:0c:00.0: 0x00000942 | ADVANCED_SYSASSERT
iwlwifi 0000:0c:00.0: 0x000002F0 | trm_hw_status0
iwlwifi 0000:0c:00.0: 0x00000000 | trm_hw_status1
iwlwifi 0000:0c:00.0: 0x004DA02C | branchlink2
iwlwifi 0000:0c:00.0: 0x00001592 | interruptlink1
iwlwifi 0000:0c:00.0: 0x00001592 | interruptlink2
iwlwifi 0000:0c:00.0: 0x0004FFF5 | data1
iwlwifi 0000:0c:00.0: 0x2A010200 | data2
iwlwifi 0000:0c:00.0: 0x020C0606 | data3
iwlwifi 0000:0c:00.0: 0x098131BA | beacon time
iwlwifi 0000:0c:00.0: 0x9A39FE56 | tsf low
iwlwifi 0000:0c:00.0: 0x00000013 | tsf hi
iwlwifi 0000:0c:00.0: 0x00000000 | time gp1
iwlwifi 0000:0c:00.0: 0x06ADA48B | time gp2
iwlwifi 0000:0c:00.0: 0x00000001 | uCode revision type
iwlwifi 0000:0c:00.0: 0x0000003E | uCode version major
iwlwifi 0000:0c:00.0: 0x49EEB572 | uCode version minor
iwlwifi 0000:0c:00.0: 0x00000420 | hw version
iwlwifi 0000:0c:00.0: 0x00C89002 | board version
iwlwifi 0000:0c:00.0: 0x8062FD27 | hcmd
iwlwifi 0000:0c:00.0: 0x80121010 | isr0
iwlwifi 0000:0c:00.0: 0x00400000 | isr1
iwlwifi 0000:0c:00.0: 0x48F0000A | isr2
iwlwifi 0000:0c:00.0: 0x04C315DC | isr3
iwlwifi 0000:0c:00.0: 0x00200000 | isr4
iwlwifi 0000:0c:00.0: 0x02F3001C | last cmd Id
iwlwifi 0000:0c:00.0: 0x004D6718 | wait_event
iwlwifi 0000:0c:00.0: 0x00000024 | l2p_control
iwlwifi 0000:0c:00.0: 0x00000000 | l2p_duration
iwlwifi 0000:0c:00.0: 0x0000000F | l2p_mhvalid
iwlwifi 0000:0c:00.0: 0x08001888 | l2p_addr_match
iwlwifi 0000:0c:00.0: 0x00000009 | lmpm_pmg_sel
iwlwifi 0000:0c:00.0: 0x00000000 | timestamp
iwlwifi 0000:0c:00.0: 0x00000808 | flow_handler
iwlwifi 0000:0c:00.0: Start IWL Error Log Dump:
iwlwifi 0000:0c:00.0: Status: 0x00000040, count: 7
iwlwifi 0000:0c:00.0: 0x20000070 | NMI_INTERRUPT_LMAC_FATAL
iwlwifi 0000:0c:00.0: 0x00000000 | umac branchlink1
iwlwifi 0000:0c:00.0: 0x8045C7E4 | umac branchlink2
iwlwifi 0000:0c:00.0: 0x8047E400 | umac interruptlink1
iwlwifi 0000:0c:00.0: 0x8047E400 | umac interruptlink2
iwlwifi 0000:0c:00.0: 0x00000002 | umac data1
iwlwifi 0000:0c:00.0: 0x8047E400 | umac data2
iwlwifi 0000:0c:00.0: 0x00000000 | umac data3
iwlwifi 0000:0c:00.0: 0x0000003E | umac major
iwlwifi 0000:0c:00.0: 0x49EEB572 | umac minor
iwlwifi 0000:0c:00.0: 0x06ADA9BB | frame pointer
iwlwifi 0000:0c:00.0: 0xC0886264 | stack pointer
iwlwifi 0000:0c:00.0: 0x0043010C | last host cmd
iwlwifi 0000:0c:00.0: 0x00000000 | isr status reg
iwlwifi 0000:0c:00.0: IML/ROM dump:
iwlwifi 0000:0c:00.0: 0x00000B03 | IML/ROM error/state
iwlwifi 0000:0c:00.0: 0x00007EE9 | IML/ROM data1
iwlwifi 0000:0c:00.0: 0x00000080 | IML/ROM WFPM_AUTH_KEY_0
iwlwifi 0000:0c:00.0: Fseq Registers:
iwlwifi 0000:0c:00.0: 0x60000000 | FSEQ_ERROR_CODE
iwlwifi 0000:0c:00.0: 0x80440002 | FSEQ_TOP_INIT_VERSION
iwlwifi 0000:0c:00.0: 0x00070008 | FSEQ_CNVIO_INIT_VERSION
iwlwifi 0000:0c:00.0: 0x0000A652 | FSEQ_OTP_VERSION
iwlwifi 0000:0c:00.0: 0x00000002 | FSEQ_TOP_CONTENT_VERSION
iwlwifi 0000:0c:00.0: 0x4552414E | FSEQ_ALIVE_TOKEN
iwlwifi 0000:0c:00.0: 0x00400410 | FSEQ_CNVI_ID
iwlwifi 0000:0c:00.0: 0x00400410 | FSEQ_CNVR_ID
iwlwifi 0000:0c:00.0: 0x00400410 | CNVI_AUX_MISC_CHIP
iwlwifi 0000:0c:00.0: 0x00400410 | CNVR_AUX_MISC_CHIP
iwlwifi 0000:0c:00.0: 0x00009061 | CNVR_SCU_SD_REGS_SD_REG_DIG_DCDC_VTRIM
iwlwifi 0000:0c:00.0: 0x00000061 | CNVR_SCU_SD_REGS_SD_REG_ACTIVE_VDIG_MIRROR
BUG: kernel NULL pointer dereference, address: 0000000000000084
#PF: supervisor read access in kernel mode
#PF: error_code(0x0000) - not-present page
PGD 0 P4D 0
Oops: 0000 [#1] PREEMPT SMP
CPU: 6 PID: 1142 Comm: irq/236-iwlwifi Not tainted 5.11.10+ #29
Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
RIP: 0010:rb_next+0x1d/0x50
Code: 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 8b 0f 48 39 cf 74 39 48 8b 47 08 48 85 c0 74 22 48 8b 50 10 48 85 d2 74 0c 48 89 d0 <48> 8b 50 10 48 85 d2 75 f4 
c3 48 3b 79 08 75 17
RSP: 0018:ffffc9000021cde0 EFLAGS: 00010206
RAX: 0000000000000074 RBX: ffff88811d5388c0 RCX: ffff8881124ae200
RDX: 0000000000000074 RSI: ffff888117f0c600 RDI: ffff888117f0c600
RBP: 0000000000000000 R08: 000000000000df88 R09: 0000000000000023
R10: ffffc9000021cf28 R11: 00000000000065d0 R12: ffffffff8280aec0
R13: ffff888117f0c600 R14: ffff888157475600 R15: 0000000000000000
FS:  0000000000000000(0000) GS:ffff88846dd80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 0000000000000084 CR3: 000000000260f001 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <IRQ>
  tcp_enter_loss+0xbf/0x350
  tcp_retransmit_timer+0x35a/0x970
  ? netif_receive_skb_list_internal+0x1a6/0x2a0
  tcp_write_timer_handler+0x87/0x1d0
  tcp_write_timer+0x91/0xd0
  ? tcp_write_timer_handler+0x1d0/0x1d0
  ? tcp_write_timer_handler+0x1d0/0x1d0
  call_timer_fn+0x22/0x120
  run_timer_softirq+0x1e2/0x410
  ? net_rx_action+0x224/0x2a0
  __do_softirq+0xc6/0x2bb
  ? irq_finalize_oneshot.part.49+0xd0/0xd0
  asm_call_irq_on_stack+0xf/0x20
  </IRQ>

(gdb) l *(tcp_enter_loss+0xbf)
0xffffffff81a3862f is in tcp_enter_loss (/home2/greearb/git/linux-5.11.dev.y/net/ipv4/tcp_input.c:2081).
2076		} else if (tcp_is_reno(tp)) {
2077			tcp_reset_reno_sack(tp);
2078		}
2079	
2080		skb = head;
2081		skb_rbtree_walk_from(skb) {
2082			if (is_reneg)
2083				TCP_SKB_CB(skb)->sacked &= ~TCPCB_SACKED_ACKED;
2084			else if (tcp_is_rack(sk) && skb != head &&
2085				 tcp_rack_skb_timeout(tp, skb, 0) > 0)
(gdb)

(gdb) l *(rb_next+0x1d)
0xffffffff815d16bd is in rb_next (/home2/greearb/git/linux-5.11.dev.y/lib/rbtree.c:503).
498	
499		/*
500		 * If we have a right-hand child, go down and then left as far
501		 * as we can.
502		 */
503		if (node->rb_right) {
504			node = node->rb_right;
505			while (node->rb_left)
506				node = node->rb_left;
507			return (struct rb_node *)node;
(gdb)


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
