Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 88FAB19F79C
	for <lists+linux-wireless@lfdr.de>; Mon,  6 Apr 2020 16:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728562AbgDFOI0 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 6 Apr 2020 10:08:26 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:36067 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728546AbgDFOIZ (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 6 Apr 2020 10:08:25 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586182105; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=M/JPvQT+JGrT6D39PypEePUcD3pa0D4fO84y825304M=;
 b=F3w8X/i9gEGnyNfvgVj+ZcUXsvXVTgr9JUdqliiBJBdCWArtRdN2MqOF3seTrlS4EXoubYt4
 G99h1stTDJ3MAWLnXRUsPRxIdwuH+4WcYJZphytWyJ8FhF9AFLs3yeLsAZIrQS5vJNg5z7RF
 3JIaB4+lk8INGO2mRB0jYdSE5yg=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8b37cc.7ff13480c308-smtp-out-n01;
 Mon, 06 Apr 2020 14:08:12 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A03F0C43636; Mon,  6 Apr 2020 14:08:12 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 85459C433BA;
        Mon,  6 Apr 2020 14:08:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 85459C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 5.6+] brcmfmac: add stub for monitor interface xmit
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200327130307.26477-1-zajec5@gmail.com>
References: <20200327130307.26477-1-zajec5@gmail.com>
To:     =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?utf-8?b?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200406140812.A03F0C43636@smtp.codeaurora.org>
Date:   Mon,  6 Apr 2020 14:08:12 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rafał Miłecki wrote:

> From: Rafał Miłecki <rafal@milecki.pl>
> 
> According to the struct net_device_ops documentation .ndo_start_xmit is
> "Required; cannot be NULL.". Missing it may crash kernel easily:
> 
> [  341.216709] Unable to handle kernel NULL pointer dereference at virtual address 00000000
> [  341.224836] pgd = 26088755
> [  341.227544] [00000000] *pgd=00000000
> [  341.231135] Internal error: Oops: 80000007 [#1] SMP ARM
> [  341.236367] Modules linked in: pppoe ppp_async iptable_nat brcmfmac xt_state xt_nat xt_conntrack xt_REDIRECT xt_MASQU
> [  341.304689] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.24 #0
> [  341.310621] Hardware name: BCM5301X
> [  341.314116] PC is at 0x0
> [  341.316664] LR is at dev_hard_start_xmit+0x8c/0x11c
> [  341.321546] pc : [<00000000>]    lr : [<c0469fa8>]    psr: 60000113
> [  341.327821] sp : c0801c30  ip : c610cf00  fp : c08048e4
> [  341.333051] r10: c073a63a  r9 : c08044dc  r8 : c6c04e00
> [  341.338283] r7 : 00000000  r6 : c60f5000  r5 : 00000000  r4 : c6a9c3c0
> [  341.344820] r3 : 00000000  r2 : bf25a13c  r1 : c60f5000  r0 : c6a9c3c0
> [  341.351358] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [  341.358504] Control: 10c5387d  Table: 0611c04a  DAC: 00000051
> [  341.364257] Process swapper/0 (pid: 0, stack limit = 0xc68ed0ca)
> [  341.370271] Stack: (0xc0801c30 to 0xc0802000)
> [  341.374633] 1c20:                                     c6e7d480 c0802d00 c60f5050 c0801c6c
> [  341.382825] 1c40: c60f5000 c6a9c3c0 c6f90000 c6f9005c c6c04e00 c60f5000 00000000 c6f9005c
> [  341.391015] 1c60: 00000000 c04a033c 00f90200 00000010 c6a9c3c0 c6a9c3c0 c6f90000 00000000
> [  341.399205] 1c80: 00000000 00000000 00000000 c046a7ac c6f9005c 00000001 fffffff4 00000000
> [  341.407395] 1ca0: c6f90200 00000000 c60f5000 c0479550 00000000 c6f90200 c6a9c3c0 16000000
> [  341.415586] 1cc0: 0000001c 6f4ad52f c6197040 b6df9387 36000000 c0520404 c073a80c c6a9c3c0
> [  341.423777] 1ce0: 00000000 c6d643c0 c6a9c3c0 c0800024 00000001 00000001 c6d643c8 c6a9c3c0
> [  341.431967] 1d00: c081b9c0 c7abca80 c610c840 c081b9c0 0000001c 00400000 c6bc5e6c c0522fb4
> [  341.440157] 1d20: c6d64400 00000004 c6bc5e0a 00000000 c60f5000 c7abca80 c081b9c0 c0522f54
> [  341.448348] 1d40: c6a9c3c0 c7abca80 c0803e48 c0549c94 c610c828 0000000a c0801d74 00000003
> [  341.456538] 1d60: c6ec8f0a 00000000 c60f5000 c7abca80 c081b9c0 c0548520 0000000a 00000000
> [  341.464728] 1d80: 00000000 003a0000 00000000 00000000 00000000 00000000 00000000 00000000
> [  341.472919] 1da0: 000002ff 00000000 00000000 16000000 00000000 00000000 00000000 00000000
> [  341.481110] 1dc0: 00000000 0000008f 00000000 00000000 00000000 2d132a69 c6bc5e40 00000000
> [  341.489300] 1de0: c6bc5e40 c6a9c3c0 00000000 c6ec8e50 00000001 c054b070 00000001 00000000
> [  341.497490] 1e00: c0807200 c6bc5e00 00000000 ffffe000 00000100 c054aea4 00000000 00000000
> [  341.505681] 1e20: 00000122 00400000 c0802d00 c0172e80 6f56a70e ffffffff 6f56a70e c7eb9cc0
> [  341.513871] 1e40: c7eb82c0 00000000 c0801e60 c017309c 00000000 00000000 07780000 c07382c0
> [  341.522061] 1e60: 00000000 c7eb9cc0 c0739cc0 c0803f74 c0801e70 c0801e70 c0801ea4 c013d380
> [  341.530253] 1e80: 00000000 000000a0 00000001 c0802084 c0802080 40000001 ffffe000 00000100
> [  341.538443] 1ea0: c0802080 c01021e8 c8803100 10c5387d 00000000 c07341f0 c0739880 0000000a
> [  341.546633] 1ec0: c0734180 00001017 c0802d00 c062aa98 00200002 c062aa60 c8803100 c073984c
> [  341.554823] 1ee0: 00000000 00000001 00000000 c7810000 c8803100 10c5387d 00000000 c011c188
> [  341.563014] 1f00: c073984c c015f0f8 c0804244 c0815ae4 c880210c c8802100 c0801f40 c037c584
> [  341.571204] 1f20: c01035f8 60000013 ffffffff c0801f74 c080afd4 c0800000 10c5387d c0101a8c
> [  341.579395] 1f40: 00000000 004ac9dc c7eba4b4 c010ee60 ffffe000 c0803e68 c0803ea8 00000001
> [  341.587587] 1f60: c080afd4 c062ca20 10c5387d 00000000 00000000 c0801f90 c01035f4 c01035f8
> [  341.595776] 1f80: 60000013 ffffffff 00000051 00000000 ffffe000 c013ff50 000000ce c0803e40
> [  341.603967] 1fa0: c082216c 00000000 00000001 c072ba38 10c5387d c0140214 c0822184 c0700df8
> [  341.612157] 1fc0: ffffffff ffffffff 00000000 c070058c c072ba38 2d162e71 00000000 c0700330
> [  341.620348] 1fe0: 00000051 10c0387d 000000ff 00a521d0 413fc090 00000000 00000000 00000000
> [  341.628558] [<c0469fa8>] (dev_hard_start_xmit) from [<c04a033c>] (sch_direct_xmit+0xe4/0x2bc)
> [  341.637106] [<c04a033c>] (sch_direct_xmit) from [<c046a7ac>] (__dev_queue_xmit+0x6a4/0x72c)
> [  341.645481] [<c046a7ac>] (__dev_queue_xmit) from [<c0520404>] (ip6_finish_output2+0x18c/0x434)
> [  341.654112] [<c0520404>] (ip6_finish_output2) from [<c0522fb4>] (ip6_output+0x5c/0xd0)
> [  341.662053] [<c0522fb4>] (ip6_output) from [<c0549c94>] (mld_sendpack+0x1a0/0x1a8)
> [  341.669640] [<c0549c94>] (mld_sendpack) from [<c054b070>] (mld_ifc_timer_expire+0x1cc/0x2e4)
> [  341.678111] [<c054b070>] (mld_ifc_timer_expire) from [<c0172e80>] (call_timer_fn.constprop.3+0x24/0x98)
> [  341.687527] [<c0172e80>] (call_timer_fn.constprop.3) from [<c017309c>] (run_timer_softirq+0x1a8/0x1e4)
> [  341.696860] [<c017309c>] (run_timer_softirq) from [<c01021e8>] (__do_softirq+0x120/0x2b0)
> [  341.705066] [<c01021e8>] (__do_softirq) from [<c011c188>] (irq_exit+0x78/0x84)
> [  341.712317] [<c011c188>] (irq_exit) from [<c015f0f8>] (__handle_domain_irq+0x60/0xb4)
> [  341.720179] [<c015f0f8>] (__handle_domain_irq) from [<c037c584>] (gic_handle_irq+0x4c/0x90)
> [  341.728549] [<c037c584>] (gic_handle_irq) from [<c0101a8c>] (__irq_svc+0x6c/0x90)
> 
> Fixes: 20f2c5fa3af0 ("brcmfmac: add initial support for monitor mode")
> Signed-off-by: Rafał Miłecki <rafal@milecki.pl>

Patch applied to wireless-drivers.git, thanks.

5bf8e6096c73 brcmfmac: add stub for monitor interface xmit

-- 
https://patchwork.kernel.org/patch/11462383/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
