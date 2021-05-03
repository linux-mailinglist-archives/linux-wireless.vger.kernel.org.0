Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 729123713E8
	for <lists+linux-wireless@lfdr.de>; Mon,  3 May 2021 12:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233390AbhECK7x (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 3 May 2021 06:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233342AbhECK7w (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 3 May 2021 06:59:52 -0400
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:191:4433::2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BCDC06174A
        for <linux-wireless@vger.kernel.org>; Mon,  3 May 2021 03:58:59 -0700 (PDT)
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_SECP256R1__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
        (Exim 4.94)
        (envelope-from <johannes@sipsolutions.net>)
        id 1ldWHx-003Lpz-6k; Mon, 03 May 2021 12:58:57 +0200
Message-ID: <1a8fac9fc130813aa7987284d4a25a71ba7f615d.camel@sipsolutions.net>
Subject: Re: iwlwifi firmware crash and kernel crash.
From:   Johannes Berg <johannes@sipsolutions.net>
To:     Ben Greear <greearb@candelatech.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Date:   Mon, 03 May 2021 12:58:56 +0200
In-Reply-To: <e6885c76-3853-4472-a8b4-18cde518adf4@candelatech.com> (sfid-20210502_052027_241432_75ADD3BB)
References: <e6885c76-3853-4472-a8b4-18cde518adf4@candelatech.com>
         (sfid-20210502_052027_241432_75ADD3BB)
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.4 (3.38.4-1.fc33) 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-malware-bazaar: not-scanned
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Sat, 2021-05-01 at 20:20 -0700, Ben Greear wrote:
> This is a 5.11-ish kernel, with a lot of 5.12-ish iwlwifi backported, and lots of hacks
> of my own...
> 
> Curious if anyone has seen similar problems or have suggestions to try?
> 
> I'll build a KASAN kernel and see if I can reproduce under that...
> 
> iwlwifi 0000:0c:00.0: Microcode SW error detected. Restarting 0x0.
> iwlwifi 0000:0c:00.0: Start IWL Error Log Dump:
> iwlwifi 0000:0c:00.0: Status: 0x00000040, count: 6
> iwlwifi 0000:0c:00.0: Loaded firmware version: 62.49eeb572.0 ty-a0-gf-a0-62.ucode
> iwlwifi 0000:0c:00.0: 0x00000942 | ADVANCED_SYSASSERT

That's a calibration error, but I don't know anything beyond that.

> BUG: kernel NULL pointer dereference, address: 0000000000000084

And I guess that's the driver not dealing with it well ...

> #PF: supervisor read access in kernel mode
> #PF: error_code(0x0000) - not-present page
> PGD 0 P4D 0
> Oops: 0000 [#1] PREEMPT SMP
> CPU: 6 PID: 1142 Comm: irq/236-iwlwifi Not tainted 5.11.10+ #29
> Hardware name: Default string Default string/SKYBAY, BIOS 5.12 08/04/2020
> RIP: 0010:rb_next+0x1d/0x50
> Code: 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 00 48 8b 0f 48 39 cf 74 39 48 8b 47 08 48 85 c0 74 22 48 8b 50 10 48 85 d2 74 0c 48 89 d0 <48> 8b 50 10 48 85 d2 75 f4 
> c3 48 3b 79 08 75 17
> RSP: 0018:ffffc9000021cde0 EFLAGS: 00010206
> RAX: 0000000000000074 RBX: ffff88811d5388c0 RCX: ffff8881124ae200
> RDX: 0000000000000074 RSI: ffff888117f0c600 RDI: ffff888117f0c600
> RBP: 0000000000000000 R08: 000000000000df88 R09: 0000000000000023
> R10: ffffc9000021cf28 R11: 00000000000065d0 R12: ffffffff8280aec0
> R13: ffff888117f0c600 R14: ffff888157475600 R15: 0000000000000000
> FS:  0000000000000000(0000) GS:ffff88846dd80000(0000) knlGS:0000000000000000
> CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
> CR2: 0000000000000084 CR3: 000000000260f001 CR4: 00000000003706e0
> DR0: 0000000000000000 DR1: 0000000000000000 DR2: 0000000000000000
> DR3: 0000000000000000 DR6: 00000000fffe0ff0 DR7: 0000000000000400
> Call Trace:
>   <IRQ>
>   tcp_enter_loss+0xbf/0x350
>   tcp_retransmit_timer+0x35a/0x970
>   ? netif_receive_skb_list_internal+0x1a6/0x2a0
>   tcp_write_timer_handler+0x87/0x1d0
>   tcp_write_timer+0x91/0xd0

although it's TCP? Probably trying to retransmit a frame that was freed,
or so?

johannes

