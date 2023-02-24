Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029A46A1487
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Feb 2023 02:11:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229460AbjBXBLT (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 23 Feb 2023 20:11:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBXBLS (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 23 Feb 2023 20:11:18 -0500
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9761738022
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 17:11:16 -0800 (PST)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id A860FBC0074
        for <linux-wireless@vger.kernel.org>; Fri, 24 Feb 2023 01:11:14 +0000 (UTC)
Received: from [192.168.1.115] (unknown [98.97.112.175])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 22C4213C2B0
        for <linux-wireless@vger.kernel.org>; Thu, 23 Feb 2023 17:11:14 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 22C4213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1677201074;
        bh=oTQTHQamJEraN4+emqjzv1EHfLGobbhD/D9uwArRMIo=;
        h=To:From:Subject:Date:From;
        b=IAMm6IG13qg5vSuQOqQWpVhbMTiw1KCZ65ULXJW39dfisT+67PYF0bEY+TP/udAwr
         YYKmCS3TLqSTc4kCza/x/AXbVcBicHGQj6nm7n4mB9Sf7g5zj+jnpIzum5YONN0CmT
         w7tdCmWpxk40MMk6isePqUQT5o8mfx1sU/TaQjUY=
To:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
From:   Ben Greear <greearb@candelatech.com>
Subject: Intel ax210 crash in 6.2.0+ kernel.
Organization: Candela Technologies
Message-ID: <2657a9e5-4b83-7a96-793c-c9055b9902cd@candelatech.com>
Date:   Thu, 23 Feb 2023 17:11:13 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-MW
Content-Transfer-Encoding: 7bit
X-MDID: 1677201075-mhYVBOyqzq26
X-MDID-O: us5;ut7;1677201075;mhYVBOyqzq26;<greearb@candelatech.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Hello,

We just started testing on 6.2, and hit the crash below.  We have some modest changes to ax210 radio,
so could be us...  Curious if anyone has seen similar?

I guess 'pkt' is corrupted?

And for what its worth, I am pretty sure we have seen something similar on older kernels,
though rarely.

general protection fault, probably for non-canonical address 0x5088000000000: 0P
CPU: 2 PID: 25 Comm: ksoftirqd/2 Tainted: G        W          6.2.0+ #3
Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
RIP: 0010:iwl_pcie_rx_handle+0x2a4/0x8f0 [iwlwifi]
Code: 01 da 48 b8 00 00 00 00 80 88 ff ff 49 c1 fa 06 89 54 24 58 48 63 d2 49 c3
RSP: 0018:ffffc90000167d30 EFLAGS: 00010207
RAX: ffff888000000000 RBX: 0000000000000000 RCX: 0000000000000000
RDX: 0000000000000000 RSI: 0000000000001000 RDI: 0000160000000000
RBP: ffff88812b080168 R08: 0000000000000000 R09: 000000000000000a
R10: 0005088000000000 R11: ffffffff82fcf040 R12: ffffc90000167d80
R13: ffff88810f50c028 R14: ffff888124159420 R15: 0005088000000000
FS:  0000000000000000(0000) GS:ffff88845dc80000(0000) knlGS:0000000000000000
CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
CR2: 00000000031e3208 CR3: 000000000260f002 CR4: 00000000003706e0
DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
Call Trace:
  <TASK>
  iwl_pcie_napi_poll_msix+0x24/0xc0 [iwlwifi]
  __napi_poll+0x21/0x150
  net_rx_action+0x28e/0x2e0
  __do_softirq+0xbc/0x28e
  ? sort_range+0x20/0x20
  run_ksoftirqd+0x1f/0x30
  smpboot_thread_fn+0xc2/0x1a0
Loading Candela Technologies 6.2.0+ COM1 115200 8n1 ...


(gdb) l *(iwl_pcie_rx_handle+0x2a4)
0x9294 is in iwl_pcie_rx_handle (/home/greearb/git/linux-6.2.dev.y/drivers/net/wireless/intel/iwlwifi/pcie/rx.c:1303).
1298				.truesize = max_len,
1299			};
1300	
1301			pkt = rxb_addr(&rxcb);
1302	
1303			if (pkt->len_n_flags == cpu_to_le32(FH_RSCSR_FRAME_INVALID)) {
1304				IWL_DEBUG_RX(trans,
1305					     "Q %d: RB end marker at offset %d\n",
1306					     rxq->id, offset);
1307				break;


Thanks,
Ben

-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com
