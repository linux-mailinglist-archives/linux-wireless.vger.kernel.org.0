Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C6E56512D
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 11:44:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233130AbiGDJoC (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 05:44:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233643AbiGDJn4 (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 05:43:56 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B532CBCB3
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 02:43:54 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id b24so6446142qkn.4
        for <linux-wireless@vger.kernel.org>; Mon, 04 Jul 2022 02:43:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=hzeCLp00L2CC+O2GQ9ryEDIHCx7qJHqVYy7NMiedFjA=;
        b=AE42GmBamxUQHUwb5K4CBagiz6Ki/i+OdJLs71JHaaec5lMPXFPzI8f5Xg2fk+CsNj
         k93t7e+0vgbd8w8ksxg3Ag3n/VL468E5txsPplgQv05RLDd6ODAhd7Bw2uif+lb+zLig
         /ydSn36Axmpv225jrF4Ksrdtx6cZgseMprrWg3TmIyH2e41FTw0m4T93LXALWFKkFPXo
         OOAtUL/7ftcEn5jipO9m58CJa6joW9Fcg2KYnV0KcsqZXu07XZdDGsSoQ/HX8TKdYj8A
         MxJU+Tj7UTfcS6EXhERMIcSA3utywC3FjVCyFd7EkIjL0drkqll0aqK3L+BvfiWVp7Nf
         q9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=hzeCLp00L2CC+O2GQ9ryEDIHCx7qJHqVYy7NMiedFjA=;
        b=h7VdIHkL7mn49W1XzkO1LcGvHWAQqP6MrE38eTEFaQ7TxtADIi1/rboJgqnT/H85/d
         CUuXYyPQUxvQgJ0Q/AtUYZeCxpa8ORfvi3FKPrMA6aqX5YASXTpEQk40fnMYA5QMesaF
         KAownNTQHbOtQ/ma94VVg8lmom/ITMDrPaS1t1oyrHw3mM1sU9do5N7/MSACZ+lw1VBi
         +9hADpKk7DS5kO7pnlUhgdow65YPb70QqvREwozQTjo21DlX2J3YahY6tylm3epiXq+z
         1LV6HeoIL67ymKxKxCJGs8mCV9imQy8hW8ClZBnlLeVI9KRyz5yWYi81h8kf75PvfDXV
         4P6w==
X-Gm-Message-State: AJIora8Uv3Wc3nroCYyGNV2vPsnu1d459xSLZiDHBFXdk52nQVPetECZ
        eHT80YHUKYjsiBACsAcVrNI=
X-Google-Smtp-Source: AGRyM1urkNx3JKWsbe8A8DKP99GQ0cBv9ri+tqGmxtJ28LVXiUydspK/VN1aEhWQuWbkF2pwZECKSg==
X-Received: by 2002:a05:620a:3c4:b0:6af:6468:1c0b with SMTP id r4-20020a05620a03c400b006af64681c0bmr19212782qkm.584.1656927833862;
        Mon, 04 Jul 2022 02:43:53 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id hh10-20020a05622a618a00b003154e7466casm19560983qtb.51.2022.07.04.02.43.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 02:43:53 -0700 (PDT)
Message-ID: <a2d63d48-74bf-06e5-0b90-d046dd0966bd@gmail.com>
Date:   Mon, 4 Jul 2022 11:43:51 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] brcmfmac: prevent double-free on hardware-reset
Content-Language: en-US
To:     Danny van Heumen <danny@dannyvanheumen.nl>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc:     Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
References: <g_Py6bM1lfcJOWWmHwKU8x4tCFrTRdgFtoM13qYHeN441F392j_6etJnEJ8gHJMRZ6OEKxpJYuP45x3iziHqY6HNXnVwIiyvJLYjvzxT0Xk=@dannyvanheumen.nl>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <g_Py6bM1lfcJOWWmHwKU8x4tCFrTRdgFtoM13qYHeN441F392j_6etJnEJ8gHJMRZ6OEKxpJYuP45x3iziHqY6HNXnVwIiyvJLYjvzxT0Xk=@dannyvanheumen.nl>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/2/2022 7:35 PM, Danny van Heumen wrote:
> In case of buggy firmware, brcmfmac may perform a hardware reset. If during
> reset and subsequent probing an early failure occurs, a memory region is
> accidentally double-freed. With hardened memory allocation enabled, this error
> will be detected.
> 
> - return early where appropriate to skip unnecessary clean-up.
> - set '.freezer' pointer to NULL to prevent double-freeing under possible
>    other circumstances and to re-align result under various different
>    behaviors of memory allocation freeing.
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
>   ret_from_fork+0x10/0x20
>   kthread+0x154/0x160
>   worker_thread+0x188/0x504
>   process_one_work+0x1f4/0x490
>   brcmf_core_bus_reset+0x34/0x44 [brcmfmac]
>   brcmf_sdio_bus_reset+0x68/0xc0 [brcmfmac]
>   brcmf_sdiod_probe+0x170/0x21c [brcmfmac]
>   brcmf_sdiod_remove+0x48/0xc0 [brcmfmac]
>   kfree+0x210/0x220
>   __slab_free+0x58/0x40c
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
>   nvmem_rockchip_efuse industrialio_triggered_buffer videodev snd_soc_core snd_pcm_dmaengine kfifo_buf snd_pcm io_domain mc industrialio mt>
> Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_device nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reje>
> Internal error: Oops - BUG: 0 [#1] SMP
> kernel BUG at mm/slub.c:379!
> 
> Signed-off-by: Danny van Heumen <danny@dannyvanheumen.nl>
> ---
It is good practice to throw in a changelog here so people know what has 
changed since earlier version of the patch.
---
>   .../broadcom/brcm80211/brcmfmac/bcmsdh.c      | 31 ++++++++++++-------
>   .../broadcom/brcm80211/brcmfmac/sdio.c        | 10 +-----
>   2 files changed, 21 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> index ac02244a6fdf..dd634edaa0b3 100644
> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c

[...]

> @@ -1096,12 +1093,24 @@ static void brcmf_ops_sdio_remove(struct sdio_func *func)
>   	if (bus_if) {
>   		sdiodev = bus_if->bus_priv.sdio;
> 
> +		if (func->num != 1) {
> +			/* Satisfy kernel expectation that the irq is released once the
> +			 * '.remove' callback has executed, while respecting the design
> +			 * that removal is executed for 'sdiodev', instead of individual
> +			 * function.
> +			 */
> +			brcmf_dbg(SDIO, "Only release irq for function %d", func->num);
> +			sdio_claim_host(sdiodev->func1);
> +			sdio_release_irq(func);
> +			sdio_release_host(sdiodev->func1);
> +			return;
> +		}
> +
> +		/* func 1: so do full clean-up and removal */
> +

The problem is that upon driver unload we get remove for function 2 and 
then for function 1. Upon mmc_hw_reset() we get a remove for function 1 
and then for function 2. So in the scenario of mmc_hw_reset() we free 
sdiodev upon func 1 removal and then for func 2 removal we have a 
use-after-free of sdiodev. The code currently relies on the order in 
which remove callback is done. To make it more robust we could throw in 
a refcount for sdiodev and only do the full clean-up when refcount hits 
zero.

Regards,
Arend
