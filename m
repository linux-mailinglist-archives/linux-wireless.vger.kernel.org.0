Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4069565D9C
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Jul 2022 20:52:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229903AbiGDSwz (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Mon, 4 Jul 2022 14:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiGDSwy (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Mon, 4 Jul 2022 14:52:54 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B09B656A
        for <linux-wireless@vger.kernel.org>; Mon,  4 Jul 2022 11:52:53 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id h23so18027664ejj.12
        for <linux-wireless@vger.kernel.org>; Mon, 04 Jul 2022 11:52:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=M5O9kYck+IASq6aP7SpPc5XfNew+Iz9AZFxQL/xKPno=;
        b=HcdfFNxJ9Rr5+IPm58VN9wsuIIlBoYOAD60HrQpr6fhvR/p/2hmYdJPXIOXrgw11AJ
         kf204RoGSUG/GRuc2OYoh5bBCxtE+4XTJg8PxJSHyxVSx4SksFJv/MACzR6YepJAQAOz
         dLCLJMJ5USXz0BhQGE77FRUqtloqf+rnQ0J8mD6MKmEfbMa9VygwaqAd8vHHnipFokhW
         PvX4jo6BE/UTgIuF9fAQ/EbbPLyXr+np5JABznyRzR2ocu22FXGV806wAqANEphT7Sie
         6W8iI6UdcCzREkzi5P9j80qNOaw27DLFE3tw5bqlgrWb0TwPnzbNJg6eFvHOgqBKCFAk
         fY1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=M5O9kYck+IASq6aP7SpPc5XfNew+Iz9AZFxQL/xKPno=;
        b=pl/9H3pa8/z5RayS1bPiosYUadHrIHe5PgaZ1R4bYnifNdfmtHRrrgJcvb6zcF+CJz
         1tw1aRNZ4OY5NaWqIIk1PSTDtpD+/6TgV9vUz4W63ayHwQPBbvVE4dmVTaZiSR3fn2mr
         kkeIcoW9FH41UwLo+cR6ZrONGZkkVT5nAUf0Lo29pf7AENXpKbjQR3WsLlOE48cJVaZQ
         gPxEEe65rM0ButOalbRmJQJsRYQ1aII2mTT7LoFfnKcbNa2lvsRxgydVAJQbfAUn7iyu
         3L7+GpflDFo+52o77U2n9g6TZZO7fvxJk85MGSeY4GynF/bDxPQNgmsdtoUkuAKL/tYu
         8X5Q==
X-Gm-Message-State: AJIora/y6bF8wMHS62oRFeTh1Y8+dd0Ag6kUfJaBFrowtPPeSgrbNaLH
        5uSQBNd7DgeUg+Y7Go00o64=
X-Google-Smtp-Source: AGRyM1thBMntTpuGCGBlX3IGtp7e/hdFLH6UFla4mTxBc3n+7JG1Jv7V5rv+QMRQekvoh0Rzgp61Xg==
X-Received: by 2002:a17:906:cc15:b0:72a:cab3:55b2 with SMTP id ml21-20020a170906cc1500b0072acab355b2mr5705193ejb.180.1656960771754;
        Mon, 04 Jul 2022 11:52:51 -0700 (PDT)
Received: from [192.168.178.136] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id e10-20020a056402148a00b0043a1255bc68sm4461563edv.94.2022.07.04.11.52.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 04 Jul 2022 11:52:50 -0700 (PDT)
Message-ID: <b9af59ff-d218-69d6-35b6-eedbd8a7eb6b@gmail.com>
Date:   Mon, 4 Jul 2022 20:52:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] brcmfmac: prevent double-free on hardware-reset
Content-Language: en-US
To:     Danny van Heumen <danny@dannyvanheumen.nl>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
References: <g_Py6bM1lfcJOWWmHwKU8x4tCFrTRdgFtoM13qYHeN441F392j_6etJnEJ8gHJMRZ6OEKxpJYuP45x3iziHqY6HNXnVwIiyvJLYjvzxT0Xk=@dannyvanheumen.nl>
 <a2d63d48-74bf-06e5-0b90-d046dd0966bd@gmail.com>
 <SpNFVBNIoAMOViIfL2pA_NfZkIX1ldRs865SC5DNvEzTfnDVAQALh3ugJVVMnWZ6XZDQI9L85yb0TEhzjKMTt8CjZuXW8mE-FY6GMSoWCs4=@dannyvanheumen.nl>
From:   Arend Van Spriel <aspriel@gmail.com>
In-Reply-To: <SpNFVBNIoAMOViIfL2pA_NfZkIX1ldRs865SC5DNvEzTfnDVAQALh3ugJVVMnWZ6XZDQI9L85yb0TEhzjKMTt8CjZuXW8mE-FY6GMSoWCs4=@dannyvanheumen.nl>
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



On 7/4/2022 4:49 PM, Danny van Heumen wrote:
> Hi Arend,
> 
> ------- Original Message -------
> On Monday, July 4th, 2022 at 11:43, Arend Van Spriel <aspriel@gmail.com> wrote:
> 
> 
>> [..]
>>
>> It is good practice to throw in a changelog here so people know what has
>> changed since earlier version of the patch.
> 
> That's fair enough. The commit message is updated.
> Changes compared to v3:
> 
> - brcmf_sdiod_remove(..) disables functions in reverse order. It also claims
>    'func2' when disabling 'func2'. However, operations on 'func2' are always
>    performed after claiming 'func1'. So this corrects mistake that deviates
>    from convention.
> - furthermore, following feedback from the kernel, irq is released for each
>    individual function, but only func1 performs removal operations. This
>    prevents the ordering issue from occurring.
> 
>> ---
>>
>>> .../broadcom/brcm80211/brcmfmac/bcmsdh.c | 31 ++++++++++++-------
>>> .../broadcom/brcm80211/brcmfmac/sdio.c | 10 +-----
>>> 2 files changed, 21 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>> index ac02244a6fdf..dd634edaa0b3 100644
>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>
>>
>> [...]
>>
>>> @@ -1096,12 +1093,24 @@ static void brcmf_ops_sdio_remove(struct sdio_func *func)
>>> if (bus_if) {
>>> sdiodev = bus_if->bus_priv.sdio;
>>>
>>> + if (func->num != 1) {
>>> + /* Satisfy kernel expectation that the irq is released once the
>>> + * '.remove' callback has executed, while respecting the design
>>> + * that removal is executed for 'sdiodev', instead of individual
>>> + * function.
>>> + /
>>> + brcmf_dbg(SDIO, "Only release irq for function %d", func->num);
>>> + sdio_claim_host(sdiodev->func1);
>>> + sdio_release_irq(func);
>>> + sdio_release_host(sdiodev->func1);
>>> + return;

Actually this is wrong. Before the function 
brcmf_sdiod_intr_unregister() was called for every sdio function 
instance. That function does exactly the same as the above and more. On 
some platforms the device does not used the SDIO interrupt, but instead 
it uses what we call an OOB interrupt (out-of-band). So your change does 
not add anything for devices/platforms employing the SDIO interrupt, but 
it does break those using OOB interrupt.

>>> + }
>>> +
>>> + / func 1: so do full clean-up and removal */
>>> +
>>
>>
>> The problem is that upon driver unload we get remove for function 2 and
>> then for function 1. Upon mmc_hw_reset() we get a remove for function 1
>> and then for function 2. So in the scenario of mmc_hw_reset() we free
>> sdiodev upon func 1 removal and then for func 2 removal we have a
>> use-after-free of sdiodev.
> 
> I understood this. I recognize the different orders. However, there is a
> false assumption regarding double-freeing. The removal logic in
> 'brcmf_ops_sdio_remove' is conditional on function number. Little is done
> for any function that is not `func->num == 1`. The proposed patch V4 fine-
> tunes this behavior slightly. In this fine-tuning it mostly (completely)
> negates order differences.
> 
>> The code currently relies on the order in
>> which remove callback is done. To make it more robust we could throw in
>> a refcount for sdiodev and only do the full clean-up when refcount hits
>> zero.
> 
> Am I missing something else, maybe? If not, I think I have your concerns
> covered.

I think you are. The function brcmf_sdiod_remove() does end-up freeing 
the sdiodev instance. brcmf_sdiod_remove() for func 1, but in 
brcmf_ops_sdio_remove() we do dereference sdiodev instance for all 
functions.

In the portion above you have:

sdio_claim_host(sdiodev->func1);

When brcmf_ops_sdio_remove is called for func 2 (and even func 3) after 
func 1 has been removed sdiodev points to memory already free.

Regards,
Arend
