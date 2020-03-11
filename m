Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EF18E181E1B
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Mar 2020 17:40:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730100AbgCKQkf (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 11 Mar 2020 12:40:35 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:16909 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729809AbgCKQkf (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 11 Mar 2020 12:40:35 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583944834; h=Date: Message-Id: Cc: To: References:
 In-Reply-To: From: Subject: Content-Transfer-Encoding: MIME-Version:
 Content-Type: Sender; bh=7aRTmhL2LfOgbZQPoU20VOyZMiRhdGFx5aEZOm3Hq4s=;
 b=twgRX19KGxYHnBG6ZRnfOwowMB7gyyLag+QxP6bI0GwW2jqdsGXgcb6gzlwaNDXTIyc3iFeo
 wldgyRWkqjq9nfP/0O3QoSnfTIyO4OmrGpBgdMOLf8gdKiX82Unyj22JpnyeSCC1Jio6CHvz
 PzdiY2r4VHDyqLcW0CB/AQPD2hw=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI3YTAwOSIsICJsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmciLCAiYmU5ZTRhIl0=
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e691474.7f3e7b4ff308-smtp-out-n01;
 Wed, 11 Mar 2020 16:40:20 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 1CF3AC432C2; Wed, 11 Mar 2020 16:40:19 +0000 (UTC)
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
        aws-us-west-2-caf-mail-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.5 required=2.0 tests=ALL_TRUSTED,MISSING_DATE,
        MISSING_MID,SPF_NONE autolearn=no autolearn_force=no version=3.4.0
Received: from potku.adurom.net (88-114-240-156.elisa-laajakaista.fi [88.114.240.156])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: kvalo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 3EDD7C433BA;
        Wed, 11 Mar 2020 16:40:17 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 3EDD7C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kvalo@codeaurora.org
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] ath10k: use kzalloc to read for ath10k_sdio_hif_diag_read
From:   Kalle Valo <kvalo@codeaurora.org>
In-Reply-To: <20200214034218.24624-1-wgong@codeaurora.org>
References: <20200214034218.24624-1-wgong@codeaurora.org>
To:     Wen Gong <wgong@codeaurora.org>
Cc:     ath10k@lists.infradead.org, linux-wireless@vger.kernel.org,
        wgong@codeaurora.org
User-Agent: pwcli/0.0.0-git (https://github.com/kvalo/pwcli/) Python/2.7.12
Message-Id: <20200311164019.1CF3AC432C2@smtp.codeaurora.org>
Date:   Wed, 11 Mar 2020 16:40:19 +0000 (UTC)
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Wen Gong <wgong@codeaurora.org> wrote:

> When use command to read values, it crashed.
> 
> command:
> dd if=/sys/kernel/debug/ieee80211/phy0/ath10k/mem_value count=1 bs=4 skip=$((0x100233))
> 
> It will call to ath10k_sdio_hif_diag_read with address = 0x4008cc and buf_len = 4.
> 
> Then system crash:
> [ 1786.013258] Unable to handle kernel paging request at virtual address ffffffc00bd45000
> [ 1786.013273] Mem abort info:
> [ 1786.013281]   ESR = 0x96000045
> [ 1786.013291]   Exception class = DABT (current EL), IL = 32 bits
> [ 1786.013299]   SET = 0, FnV = 0
> [ 1786.013307]   EA = 0, S1PTW = 0
> [ 1786.013314] Data abort info:
> [ 1786.013322]   ISV = 0, ISS = 0x00000045
> [ 1786.013330]   CM = 0, WnR = 1
> [ 1786.013342] swapper pgtable: 4k pages, 39-bit VAs, pgdp = 000000008542a60e
> [ 1786.013350] [ffffffc00bd45000] pgd=0000000000000000, pud=0000000000000000
> [ 1786.013368] Internal error: Oops: 96000045 [#1] PREEMPT SMP
> [ 1786.013609] Process swapper/0 (pid: 0, stack limit = 0x0000000084b153c6)
> [ 1786.013623] CPU: 0 PID: 0 Comm: swapper/0 Not tainted 4.19.86 #137
> [ 1786.013631] Hardware name: MediaTek krane sku176 board (DT)
> [ 1786.013643] pstate: 80000085 (Nzcv daIf -PAN -UAO)
> [ 1786.013662] pc : __memcpy+0x94/0x180
> [ 1786.013678] lr : swiotlb_tbl_unmap_single+0x84/0x150
> [ 1786.013686] sp : ffffff8008003c60
> [ 1786.013694] x29: ffffff8008003c90 x28: ffffffae96411f80
> [ 1786.013708] x27: ffffffae960d2018 x26: ffffff8019a4b9a8
> [ 1786.013721] x25: 0000000000000000 x24: 0000000000000001
> [ 1786.013734] x23: ffffffae96567000 x22: 00000000000051d4
> [ 1786.013747] x21: 0000000000000000 x20: 00000000fe6e9000
> [ 1786.013760] x19: 0000000000000004 x18: 0000000000000020
> [ 1786.013773] x17: 0000000000000001 x16: 0000000000000000
> [ 1786.013787] x15: 00000000ffffffff x14: 00000000000044c0
> [ 1786.013800] x13: 0000000000365ba4 x12: 0000000000000000
> [ 1786.013813] x11: 0000000000000001 x10: 00000037be6e9000
> [ 1786.013826] x9 : ffffffc940000000 x8 : 000000000bd45000
> [ 1786.013839] x7 : 0000000000000000 x6 : ffffffc00bd45000
> [ 1786.013852] x5 : 0000000000000000 x4 : 0000000000000000
> [ 1786.013865] x3 : 0000000000000c00 x2 : 0000000000000004
> [ 1786.013878] x1 : fffffff7be6e9004 x0 : ffffffc00bd45000
> [ 1786.013891] Call trace:
> [ 1786.013903]  __memcpy+0x94/0x180
> [ 1786.013914]  unmap_single+0x6c/0x84
> [ 1786.013925]  swiotlb_unmap_sg_attrs+0x54/0x80
> [ 1786.013938]  __swiotlb_unmap_sg_attrs+0x8c/0xa4
> [ 1786.013952]  msdc_unprepare_data+0x6c/0x84
> [ 1786.013963]  msdc_request_done+0x58/0x84
> [ 1786.013974]  msdc_data_xfer_done+0x1a0/0x1c8
> [ 1786.013985]  msdc_irq+0x12c/0x17c
> [ 1786.013996]  __handle_irq_event_percpu+0xe4/0x250
> [ 1786.014006]  handle_irq_event_percpu+0x28/0x68
> [ 1786.014015]  handle_irq_event+0x48/0x78
> [ 1786.014026]  handle_fasteoi_irq+0xd0/0x1a0
> [ 1786.014039]  __handle_domain_irq+0x84/0xc4
> [ 1786.014050]  gic_handle_irq+0x124/0x1a4
> [ 1786.014059]  el1_irq+0xb0/0x128
> [ 1786.014072]  cpuidle_enter_state+0x298/0x328
> [ 1786.014082]  cpuidle_enter+0x30/0x40
> [ 1786.014094]  do_idle+0x190/0x268
> [ 1786.014104]  cpu_startup_entry+0x24/0x28
> [ 1786.014116]  rest_init+0xd4/0xe0
> [ 1786.014126]  start_kernel+0x30c/0x38c
> [ 1786.014139] Code: f8408423 f80084c3 36100062 b8404423 (b80044c3)
> [ 1786.014150] ---[ end trace 3b02ddb698ea69ee ]---
> [ 1786.015415] Kernel panic - not syncing: Fatal exception in interrupt
> [ 1786.015433] SMP: stopping secondary CPUs
> [ 1786.015447] Kernel Offset: 0x2e8d200000 from 0xffffff8008000000
> [ 1786.015458] CPU features: 0x0,2188200c
> [ 1786.015466] Memory Limit: none
> 
> For sdio chip, it need the memory which is kmalloc, if it is
> vmalloc from ath10k_mem_value_read, then it have a memory error.
> kzalloc of ath10k_sdio_hif_diag_read32 is the correct type, so
> add kzalloc in ath10k_sdio_hif_diag_read to replace the buffer
> which is vmalloc from ath10k_mem_value_read.
> 
> This patch only effect sdio chip.
> 
> Tested with QCA6174 SDIO with firmware WLAN.RMH.4.4.1-00029.
> 
> Signed-off-by: Wen Gong <wgong@codeaurora.org>
> Signed-off-by: Kalle Valo <kvalo@codeaurora.org>

Patch applied to ath-next branch of ath.git, thanks.

402f2992b4d6 ath10k: use kzalloc to read for ath10k_sdio_hif_diag_read

-- 
https://patchwork.kernel.org/patch/11381643/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
