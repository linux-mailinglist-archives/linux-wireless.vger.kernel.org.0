Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B881A56656B
	for <lists+linux-wireless@lfdr.de>; Tue,  5 Jul 2022 10:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229896AbiGEIvE (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 5 Jul 2022 04:51:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiGEIvD (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 5 Jul 2022 04:51:03 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C564DF3F
        for <linux-wireless@vger.kernel.org>; Tue,  5 Jul 2022 01:51:02 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id z12so6908418wrq.7
        for <linux-wireless@vger.kernel.org>; Tue, 05 Jul 2022 01:51:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to;
        bh=3+CPWbrYBOGCOltgcNVO8X37QZ/7UUHg+kh66VpW38A=;
        b=EfZlw/rK8tO/UpJyT/LHWTMs1pc8CCaCysOiKnVlwIOgSZXr9aW3ND2lUYLbghGByp
         f1uaf3Nd/9m8geWbA2td1pNa3LAbyBfUJad1GfheahoLbZz4egy+EjbcV/jMcSJEAPuR
         plLsfZ8h+Pg+AHzV6asIDB+qjIFscJVq7J5n4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to;
        bh=3+CPWbrYBOGCOltgcNVO8X37QZ/7UUHg+kh66VpW38A=;
        b=a0beOYRzXzrR8TotuGCa/YQH7E6fQ24oKueQvf87fmJZ54mfcMlxWcMWqZ9jVUZ0Vk
         fcHcG/Ndou3dZ/5ikHXyfpuoxV1c04vtJI9rf3vwlnm3aFWoaljFHGSfP4HTRHQ7o6Um
         3RwGu1wE9rdSUqdOnnmHAAed+qYbsBSGW8yv3RG7W0xcggSEXGdp86XaGNVeEc54gi/p
         TrRFBP+k+rm+cd9Owyl/rOUHKVLEm/NyyLT1k9obTjyaT2a1yTOg7bXfgBKFp5lwm0Wb
         T0/aWQ4obotlh3g/8pHrP63aDDI1SQMiXFKnzZSdmYspFmqeo2aqSNUQAkDc5cUJlhbu
         dMcQ==
X-Gm-Message-State: AJIora9/FM0yADufw7drJpa+OFS0QLPv1vCWh3A26VmXLjuB3hEDOSCU
        ZEJQB58R9jK1LEMgJLmSKv4CI9hkQc26BF8T
X-Google-Smtp-Source: AGRyM1tfNm/uBTyMqW7F9cs9KQ7WVrryoGxTZG+AYZRFMaLXdYP185QugWbbPcuC2zr1S+t7fL6+Ag==
X-Received: by 2002:a5d:59a6:0:b0:21b:a234:8314 with SMTP id p6-20020a5d59a6000000b0021ba2348314mr30532100wrr.316.1657011060432;
        Tue, 05 Jul 2022 01:51:00 -0700 (PDT)
Received: from [10.176.68.61] ([192.19.148.250])
        by smtp.gmail.com with ESMTPSA id u18-20020adfdd52000000b002185d79dc7fsm8822736wrm.75.2022.07.05.01.50.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 Jul 2022 01:50:58 -0700 (PDT)
Message-ID: <48f31e63-f4de-faf9-3c8c-eb2bdd8a2b04@broadcom.com>
Date:   Tue, 5 Jul 2022 10:50:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v4] brcmfmac: prevent double-free on hardware-reset
To:     Danny van Heumen <danny@dannyvanheumen.nl>,
        Arend Van Spriel <aspriel@gmail.com>
Cc:     "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>
References: <g_Py6bM1lfcJOWWmHwKU8x4tCFrTRdgFtoM13qYHeN441F392j_6etJnEJ8gHJMRZ6OEKxpJYuP45x3iziHqY6HNXnVwIiyvJLYjvzxT0Xk=@dannyvanheumen.nl>
 <a2d63d48-74bf-06e5-0b90-d046dd0966bd@gmail.com>
 <SpNFVBNIoAMOViIfL2pA_NfZkIX1ldRs865SC5DNvEzTfnDVAQALh3ugJVVMnWZ6XZDQI9L85yb0TEhzjKMTt8CjZuXW8mE-FY6GMSoWCs4=@dannyvanheumen.nl>
 <b9af59ff-d218-69d6-35b6-eedbd8a7eb6b@gmail.com>
 <aK4oYk4CE84W9CQcWokt10umUlVCVt4DUEHbuT1e6euFshQ5CC4Hu5svEL0qhPF6W-LYeu8-EUNMfc4odaYa-LyxofrBZt_6KhkiE0sfwp8=@dannyvanheumen.nl>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <aK4oYk4CE84W9CQcWokt10umUlVCVt4DUEHbuT1e6euFshQ5CC4Hu5svEL0qhPF6W-LYeu8-EUNMfc4odaYa-LyxofrBZt_6KhkiE0sfwp8=@dannyvanheumen.nl>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000aa6c0305e30af361"
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000aa6c0305e30af361
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 7/4/2022 10:43 PM, Danny van Heumen wrote:
> Hi,
> 
> I'll respond to your comments one-by-one. I will include some of my
> reasoning to help clarify.
> 
> ------- Original Message -------
> On Monday, July 4th, 2022 at 20:52, Arend Van Spriel <aspriel@gmail.com> wrote:
> 
>> On 7/4/2022 4:49 PM, Danny van Heumen wrote:
>>
>>> Hi Arend,
>>>
>>> ------- Original Message -------
>>> On Monday, July 4th, 2022 at 11:43, Arend Van Spriel aspriel@gmail.com wrote:
>>>
>>>> [..]
>>>>
>>>> It is good practice to throw in a changelog here so people know what has
>>>> changed since earlier version of the patch.
>>>
>>> That's fair enough. The commit message is updated.
>>> Changes compared to v3:
>>>
>>> - brcmf_sdiod_remove(..) disables functions in reverse order. It also claims
>>> 'func2' when disabling 'func2'. However, operations on 'func2' are always
>>> performed after claiming 'func1'. So this corrects mistake that deviates
>>> from convention.
>>> - furthermore, following feedback from the kernel, irq is released for each
>>> individual function, but only func1 performs removal operations. This
>>> prevents the ordering issue from occurring.
>>>
>>>> ---
>>>>
>>>>> .../broadcom/brcm80211/brcmfmac/bcmsdh.c | 31 ++++++++++++-------
>>>>> .../broadcom/brcm80211/brcmfmac/sdio.c | 10 +-----
>>>>> 2 files changed, 21 insertions(+), 20 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>>>> index ac02244a6fdf..dd634edaa0b3 100644
>>>>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>>>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmfmac/bcmsdh.c
>>>>
>>>> [...]
>>>>
>>>>> @@ -1096,12 +1093,24 @@ static void brcmf_ops_sdio_remove(struct sdio_func *func)
>>>>> if (bus_if) {
>>>>> sdiodev = bus_if->bus_priv.sdio;
>>>>>
>>>>> + if (func->num != 1) {
>>>>> + /* Satisfy kernel expectation that the irq is released once the
>>>>> + * '.remove' callback has executed, while respecting the design
>>>>> + * that removal is executed for 'sdiodev', instead of individual
>>>>> + * function.
>>>>> + /
>>>>> + brcmf_dbg(SDIO, "Only release irq for function %d", func->num);
>>>>> + sdio_claim_host(sdiodev->func1);
>>>>> + sdio_release_irq(func);
>>>>> + sdio_release_host(sdiodev->func1);
>>>>> + return;
>>
>>
>> Actually this is wrong. Before the function
>> brcmf_sdiod_intr_unregister() was called for every sdio function
>> instance.
> 
> 
> We are in agreement here.
> 
> 
>> That function does exactly the same as the above and more. On
>> some platforms the device does not used the SDIO interrupt, but instead
>> it uses what we call an OOB interrupt (out-of-band).
> 
> The SDIODEV struct is hard-coded for 2 functions. The function
> `brcmf_sdiod_intr_unregister` unregisters for the whole devices, i.e.
> two functions simultaneously. The OOB interrupt handling is
> function-independent. It takes a sdiodev pointer to work with. In
> addition, the code facilitates the request of a single OOB interrupt,
> i.e. a single one for the device as a whole.

Okay. Forgot the internals of brcmf_sdiod_intr_unregister(). My elephant 
brain is failing ;-)

> Regarding the sdio-irq-claim/release, these are function-bound.
> However, as mentioned before, `brcmf_sdiod_intr_unregister` handles
> both functions at once. This code does not handle `func` for the function
> currently being iterated on. Only a whole device.
> 
>  From how I read the code, this logic is scoped to SDIO-based devices.
> Plz correct if this is interpretation is wrong.

I stand corrected in this.

>> So your change does
>> not add anything for devices/platforms employing the SDIO interrupt, but
>> it does break those using OOB interrupt.
> 
> It adds for SDIO-based interrupt handling that the interrupt gets released
> for the function that is being iterated on for removal. Therefore, it
> satisfies the expectations of the SDIO subsystem which otherwise emits a
> warning about an irq not having been freed.
> 
> AFAICT OOB handling does not change: it still executes once. After that,
> the flag `oob_irq_requested` is false. The benefit we create, is that
> `brcmf_sdiod_intr_unregister` now only executes for func1, instead of
> either func1 or func2 depending on iteration order.

But does that matter. brcmf_sdiod_intr_unregister() will do any real 
stuff only once, right? Regardless which func comes first it will 
release both func1 and func2 irq. Does it matter? I don't see enough 
benefit to add code for it.

>>>>> + }
>>>>> +
>>>>> + / func 1: so do full clean-up and removal */
>>>>> +
>>>>
>>>> The problem is that upon driver unload we get remove for function 2 and
>>>> then for function 1. Upon mmc_hw_reset() we get a remove for function 1
>>>> and then for function 2. So in the scenario of mmc_hw_reset() we free
>>>> sdiodev upon func 1 removal and then for func 2 removal we have a
>>>> use-after-free of sdiodev.
>>>
>>> I understood this. I recognize the different orders. However, there is a
>>> false assumption regarding double-freeing. The removal logic in
>>> 'brcmf_ops_sdio_remove' is conditional on function number. Little is done
>>> for any function that is not `func->num == 1`. The proposed patch V4 fine-
>>> tunes this behavior slightly. In this fine-tuning it mostly (completely)
>>> negates order differences.
>>>
>>>> The code currently relies on the order in
>>>> which remove callback is done. To make it more robust we could throw in
>>>> a refcount for sdiodev and only do the full clean-up when refcount hits
>>>> zero.
>>>
>>> Am I missing something else, maybe? If not, I think I have your concerns
>>> covered.
>>
>>
>> I think you are. The function brcmf_sdiod_remove() does end-up freeing
>> the sdiodev instance. brcmf_sdiod_remove() for func 1, but in
>> brcmf_ops_sdio_remove() we do dereference sdiodev instance for all
>> functions.
> 
> That is correct, but in `brcmf_ops_sdio_remove`:
> 
> ```
> dev_set_drvdata(&sdiodev->func1->dev, NULL);
> dev_set_drvdata(&sdiodev->func2->dev, NULL);
> ```
> 
> set those pointers to NULL. So, in the use case where we process functions
> in increasing order, `func1` will result in full device clean-up. `func2`
> will result in `bus_if` (func->dev) being NULL, therefore exits immediately.

That's a relieve.

> So, I see two use cases:
> 
> 1.) we iterate in decreasing order: release irq for func2 first, then do
>      full clean-up in func1.
> 2.) we iterate in increasing order: do full clean-up in func1, then skip
>      clean-up for func2 due to NULL bus_if.
> 
> 
>> In the portion above you have:
>>
>> sdio_claim_host(sdiodev->func1);
>>
>> When brcmf_ops_sdio_remove is called for func 2 (and even func 3) [..]
> 
> `func3` does not exist from what I read in the code. Can you point me to
> the logic that I have missed?

We don't use/claim func3, but some devices report a func3 and the 
mmc/sdio subsystem will probe the driver with a func3. However, as we 
never claim it we will not be called for func3 so please ignore my 
blabbering about that.

Regards,
Arend

--000000000000aa6c0305e30af361
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
XSlOP9s1dqWlRRnnNxV7BVC87lkKKy0+1M2DOF6qRYQlnW4EfOyCToYLAG5zeV+AjepMoX6J9bUz
yj4BlDtwH4HFjaRIlPPbdLshUA54/tV84x8woATuLGBq+hTZEpkZAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFKb+3b9pz8zo
0QsCHGb/p0UrBlU+MA0GCSqGSIb3DQEBCwUAA4IBAQCHisuRNqP0NfYfG3U3XF+bocf//aGLOCGj
NvbnSbaUDT/ZkRFb9dQfDRVnZUJ7eDZWHfC+kukEzFwiSK1irDPZQAG9diwy4p9dM0xw5RXSAC1w
FzQ0ClJvhK8PsjXF2yzITFmZsEhYEToTn2owD613HvBNijAnDDLV8D0K5gtDnVqkVB9TUAGjHsmo
aAwIDFKdqL0O19Kui0WI1qNsu1tE2wAZk0XE9FG0OKyY2a2oFwJ85c5IO0q53U7+YePIwv4/J5aP
OGM6lFPJCVnfKc3H76g/FyPyaE4AL/hfdNP8ObvCB6N/BVCccjNdglRsL2ewttAG3GM06LkvrLhv
UCvjMYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMMSnY
h9J/RI6gsHbuMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDdPc3Y8K1xyOJ4xDMU
D7jLhDcgU7PqBjVkQqK04Q0mxzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjA3MDUwODUxMDBaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAdIhDYYdgZiZAdRW7h4pXukRINKlmqpl7MLfB
FHuyF2JVIR+cb8FhrbPkJcuRgOBkq7fwjsVp9iaD/zADYxF+OdyUbnq8jwq0+u0OJIUnkTTeEOme
3tbqRIESgfU74nI44yD2Pc+oA34FIBco+6RAiooyWfTt6Xt8VUS9gwRN/HlUQQ96rAts9lLueBq9
IUcggU7QJUftB9o02wddQ2wB19YAxA2s4Yw4FxwQGbl6/tDXaQydknCSOrGxYt8TBsX22qtCDKli
kAjUTwBfTdvtjrGsQOd3KReRDLcfA9pkkgcBm9HrLd/W0dW8pfCGmd23/+Ji/whf13bAQftdTwHk
Pg==
--000000000000aa6c0305e30af361--
