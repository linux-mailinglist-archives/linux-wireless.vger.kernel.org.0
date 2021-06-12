Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BA933A4E2D
	for <lists+linux-wireless@lfdr.de>; Sat, 12 Jun 2021 12:25:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230427AbhFLK04 (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sat, 12 Jun 2021 06:26:56 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:58290 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229942AbhFLK0z (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Sat, 12 Jun 2021 06:26:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1623493496; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=Gmik4Qo26TbcgoIzzqX1GLkTo+gMg0Lq8a/6WzSipVQ=;
 b=s1LN6IYv4qBiXCzkkzBcJRTQH2ZelliHOYW5Aa7BrVXfKnZ9W7wXSfIPKKRhmUgQDKL0qtrt
 7+rPBruSXUDkHPub80vpUCcMrTxCHOVc+4xANqr5K/6frJMiI1RuQNU0RtnrcUJhlsLQZ+4p
 hnw2l1cBNqmbi+7QY0VkBXvfIew=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n07.prod.us-west-2.postgun.com with SMTP id
 60c48b63b6ccaab75377636e (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 12 Jun 2021 10:24:35
 GMT
Sender: kvalo=codeaurora.org@mg.codeaurora.org
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7B3B1C4338A; Sat, 12 Jun 2021 10:24:34 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=2.0 tests=ALL_TRUSTED,BAYES_00,
        MISSING_DATE,MISSING_MID,SPF_FAIL,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.0
Received: from tykki.adurom.net (tynnyri.adurom.net [51.15.11.48])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 2BBD6C433D3;
        Sat, 12 Jun 2021 10:24:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 2BBD6C433D3
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=fail smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] ath9k: Fix kernel NULL pointer dereference during
 ath_reset_internal()
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20210402122653.24014-1-pali@kernel.org>
References: <20210402122653.24014-1-pali@kernel.org>
To:     =?utf-8?q?Pali_Roh=C3=A1r?= <pali@kernel.org>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>, ath9k-devel@qca.qualcomm.com,
        linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.0-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-Id: <20210612102434.7B3B1C4338A@smtp.codeaurora.org>
Date:   Sat, 12 Jun 2021 10:24:34 +0000 (UTC)
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Pali Rohár <pali@kernel.org> wrote:

> I got this crash more times during debugging of PCIe controller and crash
> happens somehow at the time when PCIe kernel code started link retraining (as
> part of ASPM code) when at the same time PCIe link went down and ath9k probably
> executed hw reset procedure.
> 
> Currently I'm not able to reproduce this issue as it looks like to be
> some race condition between link training, ASPM, link down and reset
> path. And as always, race conditions which depends on more input
> parameters are hard to reproduce as it depends on precise timings.
> 
> But it is clear that pointers are zero in this case and should be
> properly filled as same code pattern is used in ath9k_stop() function.
> Anyway I was able to reproduce this crash by manually triggering ath
> reset worker prior putting card up. I created simple patch to export
> reset functionality via debugfs and use it to "simulate" of triggering
> reset.    s proved that NULL-pointer dereference issue is there.
> 
> Function ath9k_hw_reset() is dereferencing chan structure pointer, so it
> needs to be non-NULL pointer.
> 
> Function ath9k_stop() already contains code which sets ah->curchan to valid
> non-NULL pointer prior calling ath9k_hw_reset() function.
> 
> Add same code pattern also into ath_reset_internal() function to prevent
> kernel NULL pointer dereference in ath9k_hw_reset() function.
> 
> This change fixes kernel NULL pointer dereference in ath9k_hw_reset() which
> is caused by calling ath9k_hw_reset() from ath_reset_internal() with NULL
> chan structure.
> 
>     [   45.334305] Unable to handle kernel NULL pointer dereference at virtual address 0000000000000008
>     [   45.344417] Mem abort info:
>     [   45.347301]   ESR = 0x96000005
>     [   45.350448]   EC = 0x25: DABT (current EL), IL = 32 bits
>     [   45.356166]   SET = 0, FnV = 0
>     [   45.359350]   EA = 0, S1PTW = 0
>     [   45.362596] Data abort info:
>     [   45.365756]   ISV = 0, ISS = 0x00000005
>     [   45.369735]   CM = 0, WnR = 0
>     [   45.372814] user pgtable: 4k pages, 39-bit VAs, pgdp=000000000685d000
>     [   45.379663] [0000000000000008] pgd=0000000000000000, p4d=0000000000000000, pud=0000000000000000
>     [   45.388856] Internal error: Oops: 96000005 [#1] SMP
>     [   45.393897] Modules linked in: ath9k ath9k_common ath9k_hw
>     [   45.399574] CPU: 1 PID: 309 Comm: kworker/u4:2 Not tainted 5.12.0-rc2-dirty #785
>     [   45.414746] Workqueue: phy0 ath_reset_work [ath9k]
>     [   45.419713] pstate: 40000005 (nZcv daif -PAN -UAO -TCO BTYPE=--)
>     [   45.425910] pc : ath9k_hw_reset+0xc4/0x1c48 [ath9k_hw]
>     [   45.431234] lr : ath9k_hw_reset+0xc0/0x1c48 [ath9k_hw]
>     [   45.436548] sp : ffffffc0118dbca0
>     [   45.439961] x29: ffffffc0118dbca0 x28: 0000000000000000
>     [   45.445442] x27: ffffff800dee4080 x26: 0000000000000000
>     [   45.450923] x25: ffffff800df9b9d8 x24: 0000000000000000
>     [   45.456404] x23: ffffffc0115f6000 x22: ffffffc008d0d408
>     [   45.461885] x21: ffffff800dee5080 x20: ffffff800df9b9d8
>     [   45.467366] x19: 0000000000000000 x18: 0000000000000000
>     [   45.472846] x17: 0000000000000000 x16: 0000000000000000
>     [   45.478326] x15: 0000000000000010 x14: ffffffffffffffff
>     [   45.483807] x13: ffffffc0918db94f x12: ffffffc011498720
>     [   45.489289] x11: 0000000000000003 x10: ffffffc0114806e0
>     [   45.494770] x9 : ffffffc01014b2ec x8 : 0000000000017fe8
>     [   45.500251] x7 : c0000000ffffefff x6 : 0000000000000001
>     [   45.505733] x5 : 0000000000000000 x4 : 0000000000000000
>     [   45.511213] x3 : 0000000000000000 x2 : ffffff801fece870
>     [   45.516693] x1 : ffffffc00eded000 x0 : 000000000000003f
>     [   45.522174] Call trace:
>     [   45.524695]  ath9k_hw_reset+0xc4/0x1c48 [ath9k_hw]
>     [   45.529653]  ath_reset_internal+0x1a8/0x2b8 [ath9k]
>     [   45.534696]  ath_reset_work+0x2c/0x40 [ath9k]
>     [   45.539198]  process_one_work+0x210/0x480
>     [   45.543339]  worker_thread+0x5c/0x510
>     [   45.547115]  kthread+0x12c/0x130
>     [   45.550445]  ret_from_fork+0x10/0x1c
>     [   45.554138] Code: 910922c2 9117e021 95ff0398 b4000294 (b9400a61)
>     [   45.560430] ---[ end trace 566410ba90b50e8b ]---
>     [   45.565193] Kernel panic - not syncing: Oops: Fatal exception in interrupt
>     [   45.572282] SMP: stopping secondary CPUs
>     [   45.576331] Kernel Offset: disabled
>     [   45.579924] CPU features: 0x00040002,0000200c
>     [   45.584416] Memory Limit: none
>     [   45.587564] Rebooting in 3 seconds..
> 
> Signed-off-by: Pali Rohár <pali@kernel.org>
> Cc: stable@vger.kernel.org
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

fb312ac5ccb0 ath9k: Fix kernel NULL pointer dereference during ath_reset_internal()

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20210402122653.24014-1-pali@kernel.org/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

