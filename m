Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 03EAA1957E0
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2020 14:19:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727173AbgC0NTa (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 27 Mar 2020 09:19:30 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:45700 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726275AbgC0NTa (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 27 Mar 2020 09:19:30 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585315169; h=Content-Transfer-Encoding: Content-Type:
 MIME-Version: Message-ID: In-Reply-To: Date: References: Subject: Cc:
 To: From: Sender; bh=+qX4de2k0TlZhToG0h7UW5Q3J3fm5zuowdIuPwNlw4o=; b=GWN6gGIa8IXSdMq/oFgBg4TcoOQ4L4V3JytX5dm5UbA3rMPPK/OCNrFnr8JZ3QKwo0IGCrpX
 jrJ5oOh2VMXEhdB+3mDuUva2PiubOqkWvPEeMlq7Ut/6sjY2A+NDKBdlpOj3+rAH2u1CvQyy
 s4pndJ5LTMxkhGMHmmFPCx+xc64=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e7dfd56.7f90c7802260-smtp-out-n04;
 Fri, 27 Mar 2020 13:19:18 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 679DEC4478F; Fri, 27 Mar 2020 13:19:18 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.0
Received: from x230.qca.qualcomm.com (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CD49CC433F2;
        Fri, 27 Mar 2020 13:19:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CD49CC433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
From:   Kalle Valo <kvalo@codeaurora.org>
To:     =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <zajec5@gmail.com>
Cc:     Arend van Spriel <arend.vanspriel@broadcom.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Chi-Hsien Lin <chi-hsien.lin@cypress.com>,
        Wright Feng <wright.feng@cypress.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        linux-wireless@vger.kernel.org,
        brcm80211-dev-list.pdl@broadcom.com,
        brcm80211-dev-list@cypress.com,
        =?utf-8?Q?Rafa=C5=82_Mi=C5=82ecki?= <rafal@milecki.pl>
Subject: Re: [PATCH 5.6+] brcmfmac: add stub for monitor interface xmit
References: <20200327130307.26477-1-zajec5@gmail.com>
Date:   Fri, 27 Mar 2020 15:19:10 +0200
In-Reply-To: <20200327130307.26477-1-zajec5@gmail.com> (=?utf-8?Q?=22Rafa?=
 =?utf-8?Q?=C5=82_Mi=C5=82ecki=22's?=
        message of "Fri, 27 Mar 2020 14:03:07 +0100")
Message-ID: <878sjmhr5d.fsf@codeaurora.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.5 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Rafa=C5=82 Mi=C5=82ecki <zajec5@gmail.com> writes:

> From: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
>
> According to the struct net_device_ops documentation .ndo_start_xmit is
> "Required; cannot be NULL.". Missing it may crash kernel easily:
>
> [  341.216709] Unable to handle kernel NULL pointer dereference at virtua=
l address 00000000
> [  341.224836] pgd =3D 26088755
> [  341.227544] [00000000] *pgd=3D00000000
> [  341.231135] Internal error: Oops: 80000007 [#1] SMP ARM
> [  341.236367] Modules linked in: pppoe ppp_async iptable_nat brcmfmac xt=
_state xt_nat xt_conntrack xt_REDIRECT xt_MASQU
> [  341.304689] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 5.4.24 #0
> [  341.310621] Hardware name: BCM5301X
> [  341.314116] PC is at 0x0
> [  341.316664] LR is at dev_hard_start_xmit+0x8c/0x11c
> [  341.321546] pc : [<00000000>]    lr : [<c0469fa8>]    psr: 60000113
> [  341.327821] sp : c0801c30  ip : c610cf00  fp : c08048e4
> [  341.333051] r10: c073a63a  r9 : c08044dc  r8 : c6c04e00
> [  341.338283] r7 : 00000000  r6 : c60f5000  r5 : 00000000  r4 : c6a9c3c0
> [  341.344820] r3 : 00000000  r2 : bf25a13c  r1 : c60f5000  r0 : c6a9c3c0
> [  341.351358] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segme=
nt none
> [  341.358504] Control: 10c5387d  Table: 0611c04a  DAC: 00000051
> [  341.364257] Process swapper/0 (pid: 0, stack limit =3D 0xc68ed0ca)
> [  341.370271] Stack: (0xc0801c30 to 0xc0802000)
> [  341.374633] 1c20:                                     c6e7d480 c0802d0=
0 c60f5050 c0801c6c
> [  341.382825] 1c40: c60f5000 c6a9c3c0 c6f90000 c6f9005c c6c04e00 c60f500=
0 00000000 c6f9005c
> [  341.391015] 1c60: 00000000 c04a033c 00f90200 00000010 c6a9c3c0 c6a9c3c=
0 c6f90000 00000000
> [  341.399205] 1c80: 00000000 00000000 00000000 c046a7ac c6f9005c 0000000=
1 fffffff4 00000000
> [  341.407395] 1ca0: c6f90200 00000000 c60f5000 c0479550 00000000 c6f9020=
0 c6a9c3c0 16000000
> [  341.415586] 1cc0: 0000001c 6f4ad52f c6197040 b6df9387 36000000 c052040=
4 c073a80c c6a9c3c0
> [  341.423777] 1ce0: 00000000 c6d643c0 c6a9c3c0 c0800024 00000001 0000000=
1 c6d643c8 c6a9c3c0
> [  341.431967] 1d00: c081b9c0 c7abca80 c610c840 c081b9c0 0000001c 0040000=
0 c6bc5e6c c0522fb4
> [  341.440157] 1d20: c6d64400 00000004 c6bc5e0a 00000000 c60f5000 c7abca8=
0 c081b9c0 c0522f54
> [  341.448348] 1d40: c6a9c3c0 c7abca80 c0803e48 c0549c94 c610c828 0000000=
a c0801d74 00000003
> [  341.456538] 1d60: c6ec8f0a 00000000 c60f5000 c7abca80 c081b9c0 c054852=
0 0000000a 00000000
> [  341.464728] 1d80: 00000000 003a0000 00000000 00000000 00000000 0000000=
0 00000000 00000000
> [  341.472919] 1da0: 000002ff 00000000 00000000 16000000 00000000 0000000=
0 00000000 00000000
> [  341.481110] 1dc0: 00000000 0000008f 00000000 00000000 00000000 2d132a6=
9 c6bc5e40 00000000
> [  341.489300] 1de0: c6bc5e40 c6a9c3c0 00000000 c6ec8e50 00000001 c054b07=
0 00000001 00000000
> [  341.497490] 1e00: c0807200 c6bc5e00 00000000 ffffe000 00000100 c054aea=
4 00000000 00000000
> [  341.505681] 1e20: 00000122 00400000 c0802d00 c0172e80 6f56a70e fffffff=
f 6f56a70e c7eb9cc0
> [  341.513871] 1e40: c7eb82c0 00000000 c0801e60 c017309c 00000000 0000000=
0 07780000 c07382c0
> [  341.522061] 1e60: 00000000 c7eb9cc0 c0739cc0 c0803f74 c0801e70 c0801e7=
0 c0801ea4 c013d380
> [  341.530253] 1e80: 00000000 000000a0 00000001 c0802084 c0802080 4000000=
1 ffffe000 00000100
> [  341.538443] 1ea0: c0802080 c01021e8 c8803100 10c5387d 00000000 c07341f=
0 c0739880 0000000a
> [  341.546633] 1ec0: c0734180 00001017 c0802d00 c062aa98 00200002 c062aa6=
0 c8803100 c073984c
> [  341.554823] 1ee0: 00000000 00000001 00000000 c7810000 c8803100 10c5387=
d 00000000 c011c188
> [  341.563014] 1f00: c073984c c015f0f8 c0804244 c0815ae4 c880210c c880210=
0 c0801f40 c037c584
> [  341.571204] 1f20: c01035f8 60000013 ffffffff c0801f74 c080afd4 c080000=
0 10c5387d c0101a8c
> [  341.579395] 1f40: 00000000 004ac9dc c7eba4b4 c010ee60 ffffe000 c0803e6=
8 c0803ea8 00000001
> [  341.587587] 1f60: c080afd4 c062ca20 10c5387d 00000000 00000000 c0801f9=
0 c01035f4 c01035f8
> [  341.595776] 1f80: 60000013 ffffffff 00000051 00000000 ffffe000 c013ff5=
0 000000ce c0803e40
> [  341.603967] 1fa0: c082216c 00000000 00000001 c072ba38 10c5387d c014021=
4 c0822184 c0700df8
> [  341.612157] 1fc0: ffffffff ffffffff 00000000 c070058c c072ba38 2d162e7=
1 00000000 c0700330
> [  341.620348] 1fe0: 00000051 10c0387d 000000ff 00a521d0 413fc090 0000000=
0 00000000 00000000
> [  341.628558] [<c0469fa8>] (dev_hard_start_xmit) from [<c04a033c>] (sch_=
direct_xmit+0xe4/0x2bc)
> [  341.637106] [<c04a033c>] (sch_direct_xmit) from [<c046a7ac>] (__dev_qu=
eue_xmit+0x6a4/0x72c)
> [  341.645481] [<c046a7ac>] (__dev_queue_xmit) from [<c0520404>] (ip6_fin=
ish_output2+0x18c/0x434)
> [  341.654112] [<c0520404>] (ip6_finish_output2) from [<c0522fb4>] (ip6_o=
utput+0x5c/0xd0)
> [  341.662053] [<c0522fb4>] (ip6_output) from [<c0549c94>] (mld_sendpack+=
0x1a0/0x1a8)
> [  341.669640] [<c0549c94>] (mld_sendpack) from [<c054b070>] (mld_ifc_tim=
er_expire+0x1cc/0x2e4)
> [  341.678111] [<c054b070>] (mld_ifc_timer_expire) from [<c0172e80>] (cal=
l_timer_fn.constprop.3+0x24/0x98)
> [  341.687527] [<c0172e80>] (call_timer_fn.constprop.3) from [<c017309c>]=
 (run_timer_softirq+0x1a8/0x1e4)
> [  341.696860] [<c017309c>] (run_timer_softirq) from [<c01021e8>] (__do_s=
oftirq+0x120/0x2b0)
> [  341.705066] [<c01021e8>] (__do_softirq) from [<c011c188>] (irq_exit+0x=
78/0x84)
> [  341.712317] [<c011c188>] (irq_exit) from [<c015f0f8>] (__handle_domain=
_irq+0x60/0xb4)
> [  341.720179] [<c015f0f8>] (__handle_domain_irq) from [<c037c584>] (gic_=
handle_irq+0x4c/0x90)
> [  341.728549] [<c037c584>] (gic_handle_irq) from [<c0101a8c>] (__irq_svc=
+0x6c/0x90)
>
> Fixes: 20f2c5fa3af0 ("brcmfmac: add initial support for monitor mode")
> Signed-off-by: Rafa=C5=82 Mi=C5=82ecki <rafal@milecki.pl>
> ---
> This fixes bug introduced in 5.6-rc1. If it's too late for 5.6 this can
> go to 5.7 and get into stable/linux.git later.

I'm not planning to send anything to v5.6 so I'll queue this v5.7.

--=20
https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes
