Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F14F56ACA6
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Jul 2022 22:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236490AbiGGUZc (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 7 Jul 2022 16:25:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235961AbiGGUZb (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 7 Jul 2022 16:25:31 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E494A2409E
        for <linux-wireless@vger.kernel.org>; Thu,  7 Jul 2022 13:25:30 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id 145so20504281pga.12
        for <linux-wireless@vger.kernel.org>; Thu, 07 Jul 2022 13:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=HCIhiEWrrWv5gytCfyosFNVfRE3JQpuH+0MV10miPMg=;
        b=JIewL6TNLn/zpubBKTpE6oSuD5Kecpqa2mjDcmIRz05vJiflo59AunCnCq+nYEQU4o
         gxRQyGaxpHlNbXU7u2lr24ovwli7jZkFfv7lIPBlDRCGxJzVTXe4LaccXMOvzaaAgLPV
         Pax3HcUfW/D8XVeKhBnG4crnAXkt8HXAeB6wfkh85sGRifeBSHRdbRRVjw48bvrYOA5L
         TTTMW/W/tWVA+EJCjT7SYl/v0ynf4kQ4MjPb9mUNts/ccThIY1AlldmZ/fBWMAQvKYnv
         d1/rKUhBcG5cPG4AnWofzNIHSxdiyZhLzhB/Z7ZcQZDDht1l9AVJ3tMyrCKB7TdS7AjS
         HNBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=HCIhiEWrrWv5gytCfyosFNVfRE3JQpuH+0MV10miPMg=;
        b=2ARN+r3C+Wr98zjNvRxo1aVHW7udsQfoh575fo8656dwzqEw5AdEh6iEtA4EqluenZ
         quGv3znwoYYkgAFPUwNjwcl5bxhNUgUJWzpgiqW8WTPq42+yXdfYVrDc3Xwh5kKoH3UY
         kDGxisRxxvN+k72xjtn5fkiBpKYP/Dpvk1Rt2C2oh9K04B/7mym/JfIj3N2eyGa+cNt1
         q8F37vzbVw9nEdnQ5ur+jO5PqWopVCjDh11Tx93AFxCFuxD3bTXP6VbRDMhfMaC8KLch
         f+Fp7ekeT+GAF/2Ef1wo3jIPZV3lpN0n+FNtqnL9JTqeCwRuKnmLdR43oPC6y7aSa7ME
         t7xQ==
X-Gm-Message-State: AJIora913PVsekQcMhc6LnDLnpIHffLW+X4//WO0x+vugAScSf6E0Z8S
        06HQsqm+li3+WVkFOk/F2gWwxRK1k57V560SJBY=
X-Google-Smtp-Source: AGRyM1tl1kWft6KKB8pnxLDzq5acn26u+xrmd86s6hLvZ/P1rh0WTHGbclEQOXAcCgRxord3gxW87Q==
X-Received: by 2002:a63:2c0d:0:b0:411:4fd7:ecba with SMTP id s13-20020a632c0d000000b004114fd7ecbamr39677639pgs.64.1657225530335;
        Thu, 07 Jul 2022 13:25:30 -0700 (PDT)
Received: from [192.168.178.136] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id g16-20020a63e610000000b0041264dec901sm6504438pgh.21.2022.07.07.13.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Jul 2022 13:25:29 -0700 (PDT)
Message-ID: <768ee7d7-bbc1-b466-480d-de6390d26051@gmail.com>
Date:   Thu, 7 Jul 2022 22:25:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] brcmfmac: prevent double-free on hardware-reset
Content-Language: en-US
To:     Danny van Heumen <danny@dannyvanheumen.nl>,
        Arend van Spriel <arend.vanspriel@broadcom.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
References: <g_Py6bM1lfcJOWWmHwKU8x4tCFrTRdgFtoM13qYHeN441F392j_6etJnEJ8gHJMRZ6OEKxpJYuP45x3iziHqY6HNXnVwIiyvJLYjvzxT0Xk=@dannyvanheumen.nl>
 <a2d63d48-74bf-06e5-0b90-d046dd0966bd@gmail.com>
 <SpNFVBNIoAMOViIfL2pA_NfZkIX1ldRs865SC5DNvEzTfnDVAQALh3ugJVVMnWZ6XZDQI9L85yb0TEhzjKMTt8CjZuXW8mE-FY6GMSoWCs4=@dannyvanheumen.nl>
 <b9af59ff-d218-69d6-35b6-eedbd8a7eb6b@gmail.com>
 <aK4oYk4CE84W9CQcWokt10umUlVCVt4DUEHbuT1e6euFshQ5CC4Hu5svEL0qhPF6W-LYeu8-EUNMfc4odaYa-LyxofrBZt_6KhkiE0sfwp8=@dannyvanheumen.nl>
 <48f31e63-f4de-faf9-3c8c-eb2bdd8a2b04@broadcom.com>
 <Ev2sGFWgWlkty5T3AbZMd-KmLY_PJiasOdrKka6OuNmLFBSOet2lSDVUj8_x3lKuJ-lNLkAdDKwzkeS9rEIGLXb3RwDhrkBMyESbuTRcu90=@dannyvanheumen.nl>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <Ev2sGFWgWlkty5T3AbZMd-KmLY_PJiasOdrKka6OuNmLFBSOet2lSDVUj8_x3lKuJ-lNLkAdDKwzkeS9rEIGLXb3RwDhrkBMyESbuTRcu90=@dannyvanheumen.nl>
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

On 7/5/2022 3:12 PM, Danny van Heumen wrote:
> Hi,
> 
> ------- Original Message -------
> On Tuesday, July 5th, 2022 at 10:50, Arend van Spriel <arend.vanspriel@broadcom.com> wrote:
> 
>> [..]
>>>
>>> The SDIODEV struct is hard-coded for 2 functions. The function
>>> `brcmf_sdiod_intr_unregister` unregisters for the whole devices, i.e.
>>> two functions simultaneously. The OOB interrupt handling is
>>> function-independent. It takes a sdiodev pointer to work with. In
>>> addition, the code facilitates the request of a single OOB interrupt,
>>> i.e. a single one for the device as a whole.
>>
>> Okay. Forgot the internals of brcmf_sdiod_intr_unregister(). My elephant
>> brain is failing ;-)
> 
> Okay.
> 
> 
>>> Regarding the sdio-irq-claim/release, these are function-bound.
>>> However, as mentioned before, `brcmf_sdiod_intr_unregister` handles
>>> both functions at once. This code does not handle `func` for the function
>>> currently being iterated on. Only a whole device.
>>>
>>>  From how I read the code, this logic is scoped to SDIO-based devices.
>>> Plz correct if this is interpretation is wrong.
>>
>>
>> I stand corrected in this.
> 
> Okay.
> 
> 
>>>> So your change does
>>>> not add anything for devices/platforms employing the SDIO interrupt, but
>>>> it does break those using OOB interrupt.
>>>
>>> It adds for SDIO-based interrupt handling that the interrupt gets released
>>> for the function that is being iterated on for removal. Therefore, it
>>> satisfies the expectations of the SDIO subsystem which otherwise emits a
>>> warning about an irq not having been freed.
>>>
>>> AFAICT OOB handling does not change: it still executes once. After that,
>>> the flag `oob_irq_requested` is false. The benefit we create, is that
>>> `brcmf_sdiod_intr_unregister` now only executes for func1, instead of
>>> either func1 or func2 depending on iteration order.
>>
>> But does that matter. brcmf_sdiod_intr_unregister() will do any real
>> stuff only once, right? Regardless which func comes first it will
>> release both func1 and func2 irq. Does it matter? I don't see enough
>> benefit to add code for it.
> 
> Does it? You can probably judge this better than I can.
> 
> What I read, is that the interrupt release logic is processed twice. And
> you have recently put a lot of emphasis on potential ordering problems.
> So, this is my proposal to somewhat stream-line the logic to per-func
> behavior, instead of doing everything at func1 and func2 is or isn't
> processed at all. I do not have a strong opinion.
> 
>>> [..]
>>>
>>> That is correct, but in `brcmf_ops_sdio_remove`:
>>>
>>> `dev_set_drvdata(&sdiodev->func1->dev, NULL); dev_set_drvdata(&sdiodev->func2->dev, NULL);`
>>>
>>> set those pointers to NULL. So, in the use case where we process functions
>>> in increasing order, `func1` will result in full device clean-up. `func2`
>>> will result in `bus_if` (func->dev) being NULL, therefore exits immediately.
>>
>> That's a relieve.
>>
>>> So, I see two use cases:
>>>
>>> 1.) we iterate in decreasing order: release irq for func2 first, then do
>>> full clean-up in func1.
>>> 2.) we iterate in increasing order: do full clean-up in func1, then skip
>>> clean-up for func2 due to NULL bus_if.
>>>
>>>> In the portion above you have:
>>>>
>>>> sdio_claim_host(sdiodev->func1);
>>>>
>>>> When brcmf_ops_sdio_remove is called for func 2 (and even func 3) [..]
>>>
>>> `func3` does not exist from what I read in the code. Can you point me to
>>> the logic that I have missed?
>>
>> We don't use/claim func3, but some devices report a func3 and the
>> mmc/sdio subsystem will probe the driver with a func3. However, as we
>> never claim it we will not be called for func3 so please ignore my
>> blabbering about that.
> 
> Okay, so what I understand from the response right now, is that we mostly
> agree on the implementation except maybe for the interrupt clean up.
> 
> For the interrupt clean-up, I guess it may be determined by how strongly you
> want to tie the clean-up logic to func1 vs. the first func to be iterated on.

Right. I prefer dropping the interrupt clean-up and rest of the patch is 
fine by me.

Thanks,
Arend
