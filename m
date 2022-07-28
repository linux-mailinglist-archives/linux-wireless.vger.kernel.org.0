Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A416583B9E
	for <lists+linux-wireless@lfdr.de>; Thu, 28 Jul 2022 11:59:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234937AbiG1J7V (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 28 Jul 2022 05:59:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbiG1J7U (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 28 Jul 2022 05:59:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A99366110
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 02:59:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C1FFB82397
        for <linux-wireless@vger.kernel.org>; Thu, 28 Jul 2022 09:59:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A500AC433D6;
        Thu, 28 Jul 2022 09:59:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659002357;
        bh=1Oa/NGYMruzG6hH1+1RtEJhG6cPttfuD/vGpI+4/e2g=;
        h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
        b=kHks5zX2WWvudasml4gJpvi3OnueYIF0gG8EXyAlW4UdRFY/iwQygPw0MXdeRUNq+
         ObMZ3FdAh8F5a0ciVBM0hi+83Uf+C/EgC8MyBzog0Yfed7bUXQOR77PzRaabZpUhOS
         W2qk+PJXboaT/E6Z2h7bdFM75+5SGCav0hmrokbUDWCiKcGMgpF1t0Bt3/XxvloSTw
         RSkjoqRkpXX2HEJi9rcXIgALrSrVZROO5xu5jXhvmeYwSbkkDuEey15hg4dGb9wgp7
         aAqRHUAd68TjteEILxIajDIeioXzudzek94Zz8Xe7jP5lfMIdP1UYj2OxwkPlC8Ct/
         L68+Y1zMT2osQ==
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [v5] wifi: brcmfmac: prevent double-free on hardware-reset
From:   Kalle Valo <kvalo@kernel.org>
In-Reply-To: <id1HN6qCMAirApBzTA6fT7ZFWBBGCJhULpflxQ7NT6cgCboVnn3RHpiOFjA9SbRqzBRFLk9ES0C4FNvO6fUQsNg7pqF6ZSNAYUo99nHy8PY=@dannyvanheumen.nl>
References: <id1HN6qCMAirApBzTA6fT7ZFWBBGCJhULpflxQ7NT6cgCboVnn3RHpiOFjA9SbRqzBRFLk9ES0C4FNvO6fUQsNg7pqF6ZSNAYUo99nHy8PY=@dannyvanheumen.nl>
To:     Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Arend van Spriel <aspriel@gmail.com>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.7.3
Message-ID: <165900235357.25113.1552774004485936169.kvalo@kernel.org>
Date:   Thu, 28 Jul 2022 09:59:15 +0000 (UTC)
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

Danny van Heumen <danny@dannyvanheumen.nl> wrote:

> In case of buggy firmware, brcmfmac may perform a hardware reset. If during
> reset and subsequent probing an early failure occurs, a memory region is
> accidentally double-freed. With hardened memory allocation enabled, this error
> will be detected.
> 
> - return early where appropriate to skip unnecessary clean-up.
> - set '.freezer' pointer to NULL to prevent double-freeing under possible
>   other circumstances and to re-align result under various different
>   behaviors of memory allocation freeing.
> - correctly claim host on func1 for disabling func2.
> - after reset, do not initiate probing immediately, but rely on events.
> 
> Given a firmware crash, function 'brcmf_sdio_bus_reset' is called. It calls
> 'brcmf_sdiod_remove', then follows up with 'brcmf_sdiod_probe' to reinitialize
> the hardware. If 'brcmf_sdiod_probe' fails to "set F1 blocksize", it exits
> early, which includes calling 'brcmf_sdiod_remove'. In both cases
> 'brcmf_sdiod_freezer_detach' is called to free allocated '.freezer', which
> has not yet been re-allocated the second time.
> 
> Stacktrace of (failing) hardware reset after firmware-crash:
> 
> Code: b9402b82 8b0202c0 eb1a02df 54000041 (d4210000)
>  ret_from_fork+0x10/0x20
>  kthread+0x154/0x160
>  worker_thread+0x188/0x504
>  process_one_work+0x1f4/0x490
>  brcmf_core_bus_reset+0x34/0x44 [brcmfmac]
>  brcmf_sdio_bus_reset+0x68/0xc0 [brcmfmac]
>  brcmf_sdiod_probe+0x170/0x21c [brcmfmac]
>  brcmf_sdiod_remove+0x48/0xc0 [brcmfmac]
>  kfree+0x210/0x220
>  __slab_free+0x58/0x40c
> Call trace:
> x2 : 0000000000000040 x1 : fffffc00002d2b80 x0 : ffff00000b4aee40
> x5 : ffff8000013fa728 x4 : 0000000000000001 x3 : ffff00000b4aee00
> x8 : ffff800009967ce0 x7 : ffff8000099bfce0 x6 : 00000006f8005d01
> x11: ffff8000099bfce0 x10: 00000000fffff000 x9 : ffff8000083401d0
> x14: 0000000000000000 x13: 657a69736b636f6c x12: 6220314620746573
> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000030
> x20: fffffc00002d2ba0 x19: fffffc00002d2b80 x18: 0000000000000000
> x23: ffff00000b4aee00 x22: ffff00000b4aee00 x21: 0000000000000001
> x26: ffff00000b4aee00 x25: ffff0000f7753705 x24: 000000000001288a
> x29: ffff80000a22bbf0 x28: ffff000000401200 x27: 000000008020001a
> sp : ffff80000a22bbf0
> lr : kfree+0x210/0x220
> pc : __slab_free+0x58/0x40c
> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
> Workqueue: events brcmf_core_bus_reset [brcmfmac]
> Hardware name: Pine64 Pinebook Pro (DT)
> CPU: 2 PID: 639 Comm: kworker/2:2 Tainted: G         C        5.16.0-0.bpo.4-arm64 #1  Debian 5.16.12-1~bpo11+1
>  nvmem_rockchip_efuse industrialio_triggered_buffer videodev snd_soc_core snd_pcm_dmaengine kfifo_buf snd_pcm io_domain mc industrialio mt>
> Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_device nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reje>
> Internal error: Oops - BUG: 0 [#1] SMP
> kernel BUG at mm/slub.c:379!
> 
> Signed-off-by: Danny van Heumen <danny@dannyvanheumen.nl>
> Reviewed-by: Arend van Spriel <aspriel.gmail.com>
> Reviewed-by: Ulf Hansson <ulf.hansson@linaro.org>

Patch applied to wireless-next.git, thanks.

cb774bd35318 wifi: brcmfmac: prevent double-free on hardware-reset

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/id1HN6qCMAirApBzTA6fT7ZFWBBGCJhULpflxQ7NT6cgCboVnn3RHpiOFjA9SbRqzBRFLk9ES0C4FNvO6fUQsNg7pqF6ZSNAYUo99nHy8PY=@dannyvanheumen.nl/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

