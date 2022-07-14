Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B847574E54
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Jul 2022 14:50:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbiGNMuX (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 14 Jul 2022 08:50:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239654AbiGNMuI (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 14 Jul 2022 08:50:08 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56EA92A270
        for <linux-wireless@vger.kernel.org>; Thu, 14 Jul 2022 05:49:06 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 84so631480pgb.6
        for <linux-wireless@vger.kernel.org>; Thu, 14 Jul 2022 05:49:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Y5Ql3uvUvMjIksk4XXIwDARd98X015/wooju2fU+9kM=;
        b=aNyFNirVjFc5tEUd2EtnL8k0/nyLR7UXVqfcJ8hUW3gjOL17NREWO8782YR3Co7LHQ
         hUxvcoyt10esGNLA0MvfwAkAaz/GlnZGibPx5CHArq4CYf8yrdoi7uMmaO93W0pJ1MPF
         Dk8mzX4OWnLbv8YUl2jzgsTqGZwwVjg/GzDhMjigKWbr87ceTN8Kd6Vhsqw5UOh1nGtR
         +yXTaxAXiDKepT909ZAf+CwC4aFMbZTUzdhfeD8jILW4vExFCiM9ul91E+rSGpczrZrr
         AuyGYSPBq0xPeKSeU4osHtvO2NtILiCo2PdSL4jpsx2pf4XamjIlgQj6Oae5/+hlG1Ew
         K+yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Y5Ql3uvUvMjIksk4XXIwDARd98X015/wooju2fU+9kM=;
        b=Bra++wj9ha/YjSm2vYKQigG8W6fgsdU01+jxp8eP/1EFeN2fnNZg501fJRm4ANI3nK
         paWCxXS+fdLx9v/K712wgFDPexIY0kuu+73UPC3mFayrn+zu0FkiU36cxOhZiOistSMZ
         +dH7P+eYdyawgZ3ifvdJeHWMDJkdsEb3b+w6RYsRKhH0RnUJSYdBcUKbbvLP0nubxx+h
         tBaSfW9WD6lVym4Jxk0y5VmZTfGO6ApCExK8br1eIt+uPjFrQT8wewqsMEW5Qbcg7AG6
         mdSGau8llEl0kery9q5Q2N6KIYjGP+HKzhW3J0oblbxdoW6L7dAYIhibZt4dAM/4rG44
         91EA==
X-Gm-Message-State: AJIora+1vKYT/u3NfJIHti/TMMYvCF1CHDXgPAAGlUcBFDi91R+llu/N
        bjKeMe619xY9Id2XOgvPR68=
X-Google-Smtp-Source: AGRyM1u73SzftOO6ZiW+6c08yAxJ1hn+7odLpsCOXC/YmQx7LQslqIfXrLhX89e0ggiTXtCx8CRblA==
X-Received: by 2002:a63:88c1:0:b0:419:9526:680 with SMTP id l184-20020a6388c1000000b0041995260680mr6663277pgd.130.1657802945496;
        Thu, 14 Jul 2022 05:49:05 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id s11-20020a170902ea0b00b0016c433f7c12sm1364252plg.271.2022.07.14.05.49.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Jul 2022 05:49:04 -0700 (PDT)
Message-ID: <fa052de7-31ca-2657-858f-651b97908ba7@gmail.com>
Date:   Thu, 14 Jul 2022 14:49:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v5] brcmfmac: prevent double-free on hardware-reset
Content-Language: en-US
To:     Ulf Hansson <ulf.hansson@linaro.org>,
        Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>
References: <id1HN6qCMAirApBzTA6fT7ZFWBBGCJhULpflxQ7NT6cgCboVnn3RHpiOFjA9SbRqzBRFLk9ES0C4FNvO6fUQsNg7pqF6ZSNAYUo99nHy8PY=@dannyvanheumen.nl>
 <CAPDyKFpa6Z0Uhb0OnhMJ-KTQg5CQW93KMz1j1cQJS-Ho8FVhmQ@mail.gmail.com>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <CAPDyKFpa6Z0Uhb0OnhMJ-KTQg5CQW93KMz1j1cQJS-Ho8FVhmQ@mail.gmail.com>
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

On 7/14/2022 12:04 PM, Ulf Hansson wrote:
> On Tue, 12 Jul 2022 at 01:22, Danny van Heumen <danny@dannyvanheumen.nl> wrote:
>>
>> In case of buggy firmware, brcmfmac may perform a hardware reset. If during
>> reset and subsequent probing an early failure occurs, a memory region is
>> accidentally double-freed. With hardened memory allocation enabled, this error
>> will be detected.
>>
>> - return early where appropriate to skip unnecessary clean-up.
>> - set '.freezer' pointer to NULL to prevent double-freeing under possible
>>    other circumstances and to re-align result under various different
>>    behaviors of memory allocation freeing.
>> - correctly claim host on func1 for disabling func2.
>> - after reset, do not initiate probing immediately, but rely on events.
>>
>> Given a firmware crash, function 'brcmf_sdio_bus_reset' is called. It calls
>> 'brcmf_sdiod_remove', then follows up with 'brcmf_sdiod_probe' to reinitialize
>> the hardware. If 'brcmf_sdiod_probe' fails to "set F1 blocksize", it exits
>> early, which includes calling 'brcmf_sdiod_remove'. In both cases
>> 'brcmf_sdiod_freezer_detach' is called to free allocated '.freezer', which
>> has not yet been re-allocated the second time.
>>
>> Stacktrace of (failing) hardware reset after firmware-crash:
>>
>> Code: b9402b82 8b0202c0 eb1a02df 54000041 (d4210000)
>>   ret_from_fork+0x10/0x20
>>   kthread+0x154/0x160
>>   worker_thread+0x188/0x504
>>   process_one_work+0x1f4/0x490
>>   brcmf_core_bus_reset+0x34/0x44 [brcmfmac]
>>   brcmf_sdio_bus_reset+0x68/0xc0 [brcmfmac]
>>   brcmf_sdiod_probe+0x170/0x21c [brcmfmac]
>>   brcmf_sdiod_remove+0x48/0xc0 [brcmfmac]
>>   kfree+0x210/0x220
>>   __slab_free+0x58/0x40c
>> Call trace:
>> x2 : 0000000000000040 x1 : fffffc00002d2b80 x0 : ffff00000b4aee40
>> x5 : ffff8000013fa728 x4 : 0000000000000001 x3 : ffff00000b4aee00
>> x8 : ffff800009967ce0 x7 : ffff8000099bfce0 x6 : 00000006f8005d01
>> x11: ffff8000099bfce0 x10: 00000000fffff000 x9 : ffff8000083401d0
>> x14: 0000000000000000 x13: 657a69736b636f6c x12: 6220314620746573
>> x17: 0000000000000000 x16: 0000000000000000 x15: 0000000000000030
>> x20: fffffc00002d2ba0 x19: fffffc00002d2b80 x18: 0000000000000000
>> x23: ffff00000b4aee00 x22: ffff00000b4aee00 x21: 0000000000000001
>> x26: ffff00000b4aee00 x25: ffff0000f7753705 x24: 000000000001288a
>> x29: ffff80000a22bbf0 x28: ffff000000401200 x27: 000000008020001a
>> sp : ffff80000a22bbf0
>> lr : kfree+0x210/0x220
>> pc : __slab_free+0x58/0x40c
>> pstate: 60000005 (nZCv daif -PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>> Workqueue: events brcmf_core_bus_reset [brcmfmac]
>> Hardware name: Pine64 Pinebook Pro (DT)
>> CPU: 2 PID: 639 Comm: kworker/2:2 Tainted: G         C        5.16.0-0.bpo.4-arm64 #1  Debian 5.16.12-1~bpo11+1
>>   nvmem_rockchip_efuse industrialio_triggered_buffer videodev snd_soc_core snd_pcm_dmaengine kfifo_buf snd_pcm io_domain mc industrialio mt>
>> Modules linked in: snd_seq_dummy snd_hrtimer snd_seq snd_seq_device nft_fib_inet nft_fib_ipv4 nft_fib_ipv6 nft_fib nft_reject_inet nf_reje>
>> Internal error: Oops - BUG: 0 [#1] SMP
>> kernel BUG at mm/slub.c:379!
>>
>> Signed-off-by: Danny van Heumen <danny@dannyvanheumen.nl>
> 
> I have to admit that, to me, it looks a bit weird to have one driver
> instance managing two different SDIO func devices. On the other hand,
> I don't know the HW so there might be good reasons for why.
> 
> In any case, I want to point out a commit [1] for the mwifiex driver,
> which could serve as a good inspiration of how to make use of the
> mmc_hw_reset(). For example, one may look at the return code from
> mmc_hw_reset() to understand whether the reset will be done
> synchronous or asynchronous (via device re-registration).

Thanks, Uffe

Could the API be extended so the caller can request the reset to be 
asynchronous.

Regards,
Arend
