Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21B395762AA
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Jul 2022 15:19:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234612AbiGONTU (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Fri, 15 Jul 2022 09:19:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGONTT (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Fri, 15 Jul 2022 09:19:19 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A2661C139
        for <linux-wireless@vger.kernel.org>; Fri, 15 Jul 2022 06:19:18 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id k30so6247929edk.8
        for <linux-wireless@vger.kernel.org>; Fri, 15 Jul 2022 06:19:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=O8DLbgglBGHNywiyiwJp3vk5O+TxJ2vQyZzR9Mj8vPU=;
        b=WgsP1KweTVZO0H8BORqAZ9uhhHTBJ0oEl6OKRK5r2vGy4VMK23pEELqFFRhZMuA0GU
         yulnxiFUlyc9cqkexRA4oel17kqCnhpKz1pz6VhyDSOARX42a+rnrSFCrOKA0HFKUNrU
         +VpqKecJnkeuKuDwfF6BblI+33QUcbG0TfvhEiJE4vKWX7lpsiOLP4kjBDSlHQTURuTM
         gdtZDdyHx1onZTBanEtyJS4iJjZwEfJWFVMEUXGhTLEmuZb5vhmc8m4mBPJybdZ0NDde
         8HQUf/eyifRpk6ZTH3Y3jMXfwZ3qkZS0Zs/AtRLnQwu9MoZMPWvq4r235G9ZNexYF76e
         eO6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=O8DLbgglBGHNywiyiwJp3vk5O+TxJ2vQyZzR9Mj8vPU=;
        b=oABVEVi9My4pQ1bdyclJ92vM1bZDhGMgSFvr3ku0LOSBaVVoZwxWSYiqTAwglZ3OC6
         lUZVxvj1tT8N4sK0m2pI/c0IYpSFLKNZ6CkonMlpGFPrfl0lPpxGmBZcZ26kGQdsRWKP
         /og7Flmznncl5Q3xwqbNxImFQPFYnnLpyRE5c64KeslHKcO97l/ZxC0usCXAaz8OLWrS
         PeXbEmc2yZWCq50+ULNacwZygbT/JPqOp+IH/B0Zh0t25sijVT5tw44oWfI9Sqs2pQlc
         TL3O90Wqpae15lFpP0YUdBi1C9sr03H4dqfFzyvOLSGeW3CTDqYfWfOedbV8qie37BDx
         6wcg==
X-Gm-Message-State: AJIora/4S81dXU+IuoC+KImmttUmC4jMJGv/MbqqQlTXQxwm9LFACKdc
        CbrW15UoLR4F4NqOx2KAxW5aKp3KUnOzHYgtrsqEpQ==
X-Google-Smtp-Source: AGRyM1u1hhhzZnGYUeCqkt88fDqmPewDP13+7VE4LtWqtAGdO7EGobeQ64n5iLk6ebW8Zyof0susPQ==
X-Received: by 2002:a05:6402:3326:b0:43a:902b:d335 with SMTP id e38-20020a056402332600b0043a902bd335mr18952342eda.412.1657891156637;
        Fri, 15 Jul 2022 06:19:16 -0700 (PDT)
Received: from [192.168.178.136] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id c17-20020a17090618b100b006fe9e717143sm2036475ejf.94.2022.07.15.06.19.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 Jul 2022 06:19:15 -0700 (PDT)
Message-ID: <d25eb33d-858b-1d8c-4c10-0358c2d923af@gmail.com>
Date:   Fri, 15 Jul 2022 15:19:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5] brcmfmac: prevent double-free on hardware-reset
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Danny van Heumen <danny@dannyvanheumen.nl>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
References: <id1HN6qCMAirApBzTA6fT7ZFWBBGCJhULpflxQ7NT6cgCboVnn3RHpiOFjA9SbRqzBRFLk9ES0C4FNvO6fUQsNg7pqF6ZSNAYUo99nHy8PY=@dannyvanheumen.nl>
 <CAPDyKFpa6Z0Uhb0OnhMJ-KTQg5CQW93KMz1j1cQJS-Ho8FVhmQ@mail.gmail.com>
 <fa052de7-31ca-2657-858f-651b97908ba7@gmail.com>
 <CAPDyKFoRRxe8wUtJWfuDCxuz8wktUOyMD7jQApYGJO0zbax1Jw@mail.gmail.com>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <CAPDyKFoRRxe8wUtJWfuDCxuz8wktUOyMD7jQApYGJO0zbax1Jw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 7/14/2022 4:39 PM, Ulf Hansson wrote:
> On Thu, 14 Jul 2022 at 14:49, Arend Van Spriel <aspriel@gmail.com> wrote:
>>
>> On 7/14/2022 12:04 PM, Ulf Hansson wrote:
>>> On Tue, 12 Jul 2022 at 01:22, Danny van Heumen <danny@dannyvanheumen.nl> wrote:
>>>>
>>>> In case of buggy firmware, brcmfmac may perform a hardware reset. If during
>>>> reset and subsequent probing an early failure occurs, a memory region is
>>>> accidentally double-freed. With hardened memory allocation enabled, this error
>>>> will be detected.
>>>>
>>>> - return early where appropriate to skip unnecessary clean-up.
>>>> - set '.freezer' pointer to NULL to prevent double-freeing under possible
>>>>     other circumstances and to re-align result under various different
>>>>     behaviors of memory allocation freeing.
>>>> - correctly claim host on func1 for disabling func2.
>>>> - after reset, do not initiate probing immediately, but rely on events.
>>>>
>>>> Given a firmware crash, function 'brcmf_sdio_bus_reset' is called. It calls
>>>> 'brcmf_sdiod_remove', then follows up with 'brcmf_sdiod_probe' to reinitialize
>>>> the hardware. If 'brcmf_sdiod_probe' fails to "set F1 blocksize", it exits
>>>> early, which includes calling 'brcmf_sdiod_remove'. In both cases
>>>> 'brcmf_sdiod_freezer_detach' is called to free allocated '.freezer', which
>>>> has not yet been re-allocated the second time.
>>>>
>>>> Stacktrace of (failing) hardware reset after firmware-crash:
>>>>
>>>> Code: b9402b82 8b0202c0 eb1a02df 54000041 (d4210000)
>>>>    ret_from_fork+0x10/0x20
>>>>    kthread+0x154/0x160
>>>>    worker_thread+0x188/0x504
>>>>    process_one_work+0x1f4/0x490
>>>>    brcmf_core_bus_reset+0x34/0x44 [brcmfmac]
>>>>    brcmf_sdio_bus_reset+0x68/0xc0 [brcmfmac]
>>>>    brcmf_sdiod_probe+0x170/0x21c [brcmfmac]
>>>>    brcmf_sdiod_remove+0x48/0xc0 [brcmfmac]
>>>>    kfree+0x210/0x220
>>>>    __slab_free+0x58/0x40c
>>>> Call trace:
>>>> x2 : 0000000000000040 x1 : fffffc00002d2b80 x0 : ffff00000b4aee40
>>>> x5 : ffff8000013fa728 x4 : 0000000000000001 x3 : ffff00000b4aee00
>>>> x8 : ffff800009967ce0 x7 : ffff8000099bfce0 x6 : 00000006f8005d01
>>>> x11: ffff8000099bfce0 x10: 00000000fffff000 x9 : ffff8000083401d0
>>>> x14: 0000000000000000 x13: 657a69736b636f6c x12: 6220314620746573
>>>> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000030
>>>> x20: fffffc00002d2ba0 x19: fffffc00002d2b80 x18: 0000000000000000
>>>> x23: ffff00000b4aee00 x22: ffff00000b4aee00 x21: 0000000000000001
>>>> x26: ffff00000b4aee00 x25: ffff0000f7753705 x24: 000000000001288a
>>>> x29: ffff80000a22bbf0 x28: ffff000000401200 x27: 000000008020001a
>>>> sp : ffff80000a22bbf0
>>>> lr : kfree+0x210/0x220
>>>> pc : __slab_free+0x58/0x40c
>>>> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>>>> Workqueue: events brcmf_core_bus_reset [brcmfmac]
>>>> Hardware name: Pine64 Pinebook Pro (DT)
>>>> CPU: 2 PID: 639 Comm: kworker/2:2 Tainted: G         C        5.16.0-0.bpo.4-arm64 #1  Debian 5.16.12-1~bpo11+1
>>>>    nvmem_rockchip_efuse industrialio_triggered_buffer videodev snd_soc_core snd_pcm_dmaengine kfifo_buf snd_pcm io_domain mc industrialio mt>
>>>> Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_device nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reje>
>>>> Internal error: Oops - BUG: 0 [#1] SMP
>>>> kernel BUG at mm/slub.c:379!
>>>>
>>>> Signed-off-by: Danny van Heumen <danny@dannyvanheumen.nl>
>>>
>>> I have to admit that, to me, it looks a bit weird to have one driver
>>> instance managing two different SDIO func devices. On the other hand,
>>> I don't know the HW so there might be good reasons for why.
>>>
>>> In any case, I want to point out a commit [1] for the mwifiex driver,
>>> which could serve as a good inspiration of how to make use of the
>>> mmc_hw_reset(). For example, one may look at the return code from
>>> mmc_hw_reset() to understand whether the reset will be done
>>> synchronous or asynchronous (via device re-registration).
>>
>> Thanks, Uffe
>>
>> Could the API be extended so the caller can request the reset to be
>> asynchronous.
> 
> Yes, that should be fine. The current behaviour is that it will be
> asynchronous if there are more than one SDIO func device bound to a
> driver.

I see. So for brcmfmac we fall into that category. Thanks for the info.

Regards,
Arend
