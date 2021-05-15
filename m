Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EAEF63819BB
	for <lists+linux-wireless@lfdr.de>; Sat, 15 May 2021 18:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233150AbhEOQFx (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 15 May 2021 12:05:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:44592 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233070AbhEOQFs (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 15 May 2021 12:05:48 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 00C756120D;
        Sat, 15 May 2021 16:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1621094674;
        bh=IbBnJbdzaWQ0BdgRG0FjeII8acpou7SmcKweyc9UvOs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W7G9od7nZCcjxuf8z2JwAOLr7XPUBKuMqPbI/oQUKsOiRLEyv/nJz3tSpPtjCTOJX
         InjN0qEA1Nhq+io6HZyN1Z2CdHCoEnJmfL0ZHHjQx4ro1GbTZjKwdAT/lGae7zR5J+
         pQJvbMk01DXAUgKj2rTj1WCZVVGey20Dbbh2Wt8YPaf0rFs5Pih0q74zvmLyNy1Z64
         d3VQQM3dlaKidnO7QC0cJnUN1X+5qXDdJhATKUehvQ++KL1rljRnXNLnUe1JVn7pbF
         NGrBBMN1nj0D+hqt1tJq1MCv7RAUKv56lv2dN8kyj0HIpor6kLNW/Qw+YVZIl3Lgp/
         vSnLAb+5V7Pqw==
Received: by pali.im (Postfix)
        id 8277FA3B; Sat, 15 May 2021 18:04:31 +0200 (CEST)
Date:   Sat, 15 May 2021 18:04:31 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Kalle Valo <kvalo@codeaurora.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ath9k-devel@qca.qualcomm.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] ath9k: Fix kernel NULL pointer dereference during
 ath_reset_internal()
Message-ID: <20210515160431.jna3y6xmkd3egkfn@pali>
References: <20210402122653.24014-1-pali@kernel.org>
 <87eef2jung.fsf@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87eef2jung.fsf@codeaurora.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On Thursday 22 April 2021 16:50:11 Kalle Valo wrote:
> Pali Rohár <pali@kernel.org> writes:
> 
> > Function ath9k_hw_reset() is dereferencing chan structure pointer, so it
> > needs to be non-NULL pointer.
> >
> > Function ath9k_stop() already contains code which sets ah->curchan to valid
> > non-NULL pointer prior calling ath9k_hw_reset() function.
> >
> > Add same code pattern also into ath_reset_internal() function to prevent
> > kernel NULL pointer dereference in ath9k_hw_reset() function.
> >
> > This change fixes kernel NULL pointer dereference in ath9k_hw_reset() which
> > is caused by calling ath9k_hw_reset() from ath_reset_internal() with NULL
> > chan structure.
> >
> >     [   45.334305] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
> >     [   45.344417] Mem abort info:
> >     [   45.347301]   ESR = 0x96000005
> >     [   45.350448]   EC = 0x25: DABT (current EL), IL = 32 bits
> >     [   45.356166]   SET = 0, FnV = 0
> >     [   45.359350]   EA = 0, S1PTW = 0
> >     [   45.362596] Data abort info:
> >     [   45.365756]   ISV = 0, ISS = 0x00000005
> >     [   45.369735]   CM = 0, WnR = 0
> >     [   45.372814] user pgtable: 4k pages, 39-bit VAs, pgdp=000000000685d000
> >     [   45.379663] [0000000000000008] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
> >     [   45.388856] Internal error: Oops: 96000005 [#1] SMP
> >     [   45.393897] Modules linked in: ath9k ath9k_common ath9k_hw
> >     [   45.399574] CPU: 1 PID: 309 Comm: kworker/u4:2 Not tainted 5.12.0-rc2-dirty #785
> >     [   45.414746] Workqueue: phy0 ath_reset_work [ath9k]
> >     [   45.419713] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
> >     [   45.425910] pc : ath9k_hw_reset+0xc4/0x1c48 [ath9k_hw]
> >     [   45.431234] lr : ath9k_hw_reset+0xc0/0x1c48 [ath9k_hw]
> >     [   45.436548] sp : ffffffc0118dbca0
> >     [   45.439961] x29: ffffffc0118dbca0 x28: 0000000000000000
> >     [   45.445442] x27: ffffff800dee4080 x26: 0000000000000000
> >     [   45.450923] x25: ffffff800df9b9d8 x24: 0000000000000000
> >     [   45.456404] x23: ffffffc0115f6000 x22: ffffffc008d0d408
> >     [   45.461885] x21: ffffff800dee5080 x20: ffffff800df9b9d8
> >     [   45.467366] x19: 0000000000000000 x18: 0000000000000000
> >     [   45.472846] x17: 0000000000000000 x16: 0000000000000000
> >     [   45.478326] x15: 0000000000000010 x14: ffffffffffffffff
> >     [   45.483807] x13: ffffffc0918db94f x12: ffffffc011498720
> >     [   45.489289] x11: 0000000000000003 x10: ffffffc0114806e0
> >     [   45.494770] x9 : ffffffc01014b2ec x8 : 0000000000017fe8
> >     [   45.500251] x7 : c0000000ffffefff x6 : 0000000000000001
> >     [   45.505733] x5 : 0000000000000000 x4 : 0000000000000000
> >     [   45.511213] x3 : 0000000000000000 x2 : ffffff801fece870
> >     [   45.516693] x1 : ffffffc00eded000 x0 : 000000000000003f
> >     [   45.522174] Call trace:
> >     [   45.524695]  ath9k_hw_reset+0xc4/0x1c48 [ath9k_hw]
> >     [   45.529653]  ath_reset_internal+0x1a8/0x2b8 [ath9k]
> >     [   45.534696]  ath_reset_work+0x2c/0x40 [ath9k]
> >     [   45.539198]  process_one_work+0x210/0x480
> >     [   45.543339]  worker_thread+0x5c/0x510
> >     [   45.547115]  kthread+0x12c/0x130
> >     [   45.550445]  ret_from_fork+0x10/0x1c
> >     [   45.554138] Code: 910922c2 9117e021 95ff0398 b4000294 (b9400a61)
> >     [   45.560430] ---[ end trace 566410ba90b50e8b ]---
> >     [   45.565193] Kernel panic - not syncing: Oops: Fatal exception in interrupt
> >     [   45.572282] SMP: stopping secondary CPUs
> >     [   45.576331] Kernel Offset: disabled
> >     [   45.579924] CPU features: 0x00040002,0000200c
> >     [   45.584416] Memory Limit: none
> >     [   45.587564] Rebooting in 3 seconds..
> >
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> > Cc: stable@vger.kernel.org
> 
> In what scenarios do you see this bug? Please describe the use case to better
> understand when and how this happens. I guess this is a rare problem as nobody
> else has reported it?

Hello! Sorry for a long delay. I got this crash more times during
debugging of PCIe controller and crash happens somehow at the time when
PCIe kernel code started link retraining (as part of ASPM code) when at
the same time PCIe link went down and ath9k probably executed hw reset
procedure.

Currently I'm not able to reproduce this issue as it looks like to be
some race condition between link training, ASPM, link down and reset
path. And as always, race conditions which depends on more input
parameters are hard to reproduce as it depends on precise timings.

But it is clear that pointers are zero in this case and should be
properly filled as same code pattern is used in ath9k_stop() function.


Anyway I was able to reproduce this crash by manually triggering ath
reset worker prior putting card up. I created simple patch to export
reset functionality via debugfs and use it to "simulate" of triggering
reset.

So this proved that NULL-pointer dereference issue is there.

It is enough, or do you need more investigation?

> I can add that info to the commit log.
> 
> -- 
> https://patchwork.kernel.org/project/linux-wireless/list/
> 
> https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
