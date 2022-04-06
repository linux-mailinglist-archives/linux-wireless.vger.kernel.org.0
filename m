Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88354F62B9
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 17:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235540AbiDFPNN (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 11:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235969AbiDFPMl (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 11:12:41 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BD8C51282E
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 05:13:26 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id a16-20020a17090a6d9000b001c7d6c1bb13so2461619pjk.4
        for <linux-wireless@vger.kernel.org>; Wed, 06 Apr 2022 05:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:from:to:cc
         :references:in-reply-to;
        bh=FTBOkBmSodKpGU7K4n1ZTK/MtOegY0xWBJbACNudJqc=;
        b=JMDI8n/T6N1P4YZkhuPOJqnyxa4xs04c0E/sUtnskc87hrutUNfGdiel4L3zxFMb1U
         vxBcp7o4HoFlurclk1tij/3JrkkI/mp82pvXqwwyZZFeNAPb5juPeVwToCZKtj1zspWE
         SgJfEinXcG7op3ZfJridM3gCT7rXFagea4NVI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :from:to:cc:references:in-reply-to;
        bh=FTBOkBmSodKpGU7K4n1ZTK/MtOegY0xWBJbACNudJqc=;
        b=owP8eYsHuyylO2A2Zbaa7PV1TqkwVyppafo1+rCpHIEhTGzH7mVarWMGzKjVv43qsz
         ppTj/V7++J7Y+alSfoD9I0IH5bBS7NdLoIuFffsrOhVG/+UktcqA7QhDn9/aHx3hqf10
         lyDX2Gin4IPEYQUkVVzawko1GjVjJjLXwHRBmwj6SI7kWugPRzqLMSEvPS2uOH+yyRWb
         VNdTGfLY6r9CyW2fQ15Qmmki8yO608E3DHb7v6LNHnxnUTp4FjDXSOLM5YUlNaPepq2S
         n90DKh0cBEY2uXiTDgc9CKKg0ugKc7sqXixJ7twllhVzZfcwIEcQvVKa7zJ4JORKD5/s
         o1bQ==
X-Gm-Message-State: AOAM5330xa9jjPaVz0313wbYHr8jMtp3hFyAsy3Sc1/+/hS30ni9Slcn
        TvceD50BSm9ju31g59Sp7Xq4kg==
X-Google-Smtp-Source: ABdhPJz4sI5zb48BsfyI+lMBIF9yyiZmJWx0Tpt/KqnoiaTW2zmxSuFyxB9cf68TpCViNA++4bqWFQ==
X-Received: by 2002:a17:902:8ec4:b0:156:b8a6:f9d8 with SMTP id x4-20020a1709028ec400b00156b8a6f9d8mr8560078plo.122.1649246871102;
        Wed, 06 Apr 2022 05:07:51 -0700 (PDT)
Received: from [192.168.178.136] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id nl17-20020a17090b385100b001c70883f6ccsm6279772pjb.36.2022.04.06.05.07.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 05:07:49 -0700 (PDT)
Message-ID: <b9e2a3c1-cb18-0016-677f-ae39d24996e3@broadcom.com>
Date:   Wed, 6 Apr 2022 14:07:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Support for bcm43364 wireless chipset in brcm80211/brcmfmac
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
To:     Jupiter <jupiter.hce@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sean Lanigan <sean@lano.id.au>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Double.Lo@infineon.com, Kalle Valo <kvalo@kernel.org>
References: <CAA=hcWQFNOeycXFPhrtHcQG3V8fWSShNRuAi49jtv8h1fPVUuQ@mail.gmail.com>
 <8ef5d73a-6293-a6c5-6bbb-b130266a8f0b@broadcom.com>
 <CAA=hcWQ_FVTVfRe91z1yHXMBLkkhi0eTq-9Lw3Tg=X6OS5Ku-Q@mail.gmail.com>
 <3ce6bc12-736f-cde5-ebd4-0224c5733a9e@broadcom.com>
In-Reply-To: <3ce6bc12-736f-cde5-ebd4-0224c5733a9e@broadcom.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000eb815805dbfb3516"
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000eb815805dbfb3516
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

+ the other Kalle ;-)

On 4/6/2022 1:56 PM, Arend van Spriel wrote:
> + Double Lo
> 
> On 4/6/2022 9:36 AM, Jupiter wrote:
>> Hi Arend,
>>
>> Thanks for your response.
>>
>>>> Our design criteria is that it must be supported by mainline Linux.
>>>> Searching kernel log file to find that you added bcm43364 wireless
>>>> chipset to broadcom/brcm80211/brcmfmac driver, could you please advise
>>>> how stable and reliable to run brcm80211/brcmfmac for CYW43364 /
>>>> Broadcom BCM43364 Chipset?
>>>
>>> Is Murata providing you with firmware or just the hardware.
>>
>> Good question, we'll buy Murata hardware and we'll use Murata firmware
>> in linux-firmware so we can run Yocto to build WiFi to the image using
>> mainline Linux, linux-firmware and other open sources.
>>
>> I've just checked the firmware, there is no bcm43364 binary in
>> linux-firmware, only bcm43362 links to cyfmac43362-sdio.bin, is the
>> cyfmac43362-sdio.bin the right firmware for Murata WiFi module
>> LBWA1KL1FX (CYW43364 / BCM43364 Chipset)? If not, where is the right
>> Murata WiFi module LBWA1KL1FX firmware in linux-firmware?
> 
> Indeed. As Sean stated in his commit message "The BCM43364 uses the same 
> firmware as the BCM43430 (which is already included), the only 
> difference is the omission of Bluetooth".
> 
> So for BCM43364 the brcmfmac driver will load brcmfmac43430-sdio.bin. 
> Now it can be that the Murata WiFi module would need dedicated firmware 
> that Murata provides. If your project/design is device-tree based 
> (likely if it is a IMX6 ARM-based SoC) your device-tree will have a 
> boardname and brcmfmac would try to find 
> brcmfmac43430-sdio-<boardname>.bin or something like that. If not 
> present it will fallback to the generic firmware mentioned earlier.
> 
>> The Broadcom did very good job to support mainline Linux, Cypress
>> acquired Broadcom wireless IoT, Infineon acquired Cypress wireless,
>> has anyone known if the Infineon is committed to continually maintain
>> and support CYW43364 / BCM43364 Chipset driver and firmware in
>> mainline Linux and linux-firmware?
> 
> Infineon is listed in the MAINTAINERS file so I suppose they are. Hmm, 
> there was a patch stripping Infineon names from it. I added the author 
> of that patch to comment.
> 
>> There is a wired backward tendency in recent years, large vendors
>> acquired wireless sectors then stopped supporting open source and
>> mainline Linux, switched its wireless sources to use its proprietary
>> Linux and SDK. Our original design was using Marvell Avastar 88W8801
>> chipset, the driver mwifiex and wifiex_sdio worked well for kernel 4,
>> but after NXP acquired Marvell wireless sector, NXP stopped supporting
>> mainline Linux, the kernel 5 mwifiex cannot communicate to 88W8801
>> chipset firmware, we were told to use the proprietary Linux driver
>> sources which is incompatible to our Yocto / OE build system, we have
>> no choice but to change the WiFi module.
>>
>>>> In addition to add CONFIG_BRCMFMAC and CONFIG_BRCMFMAC_SDIO, should I
>>>> also add   CONFIG_BRCMFMAC_PROTO_MSGBUF, CONFIG_DMI,
>>>> CONFIG_BRCMFMAC_PROTO_BCDC and CONFIG_OF?
>>>
>>> I would suggest using menuconfig as it already answers some if not all
>>> of these. CONFIG_DMI and CONFIG_OF are really depending on your 
>>> platform.
>>
>> We'll certainly use the menuconfig that is not the issue, our CPU is
>> iMX6ULZ running on kernel 5.10, apologize we are not familiar with the
>> CONFIG_DMI and CONFIG_OF, appreciate your advice.
> 
> If your using IMX6 you will likely use device-tree as I mentioned 
> before. So you probably will have CONFIG_OF enabled. OF stands for 
> OpenFirmware and the kernel functionality is also used handling 
> flattened device-trees.
> 
> Regards,
> Arend

--000000000000eb815805dbfb3516
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
h9J/RI6gsHbuMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCBYnj2yOGk5d7Wm5SJf
wJKRaj6uDhkVBjc6F42GH9yPlDAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjA0MDYxMjA3NTFaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAYXIYPMe2CoqvlM2jA27Bsq1tUnjW5Zs0h2CH
w16jA7826+IWuMu2jANrDxc0anWRU0vLBkggqFipcb1wDDHcn5sGXp51Q/Eur+xEtUXIOUPrQXRp
h1431YHwD7hsVin5Kdq7vlWr0VUwH51giC+v3dS13cYc3sUMSvysGPRs5R2I1erDa8zJa8viU0aA
IXuuyuQ+Kzw8UjK3s/ZgZokFUfYGIar6mgrqAkLoeaV+lq/BBRlGVkYBgN8oasS3fIJgA0irl5XO
1sS7UnVN26bVdO5iPDJx5T3dXtozYCZCiWticQeHhTi1T8gQA3ao4iK7T2WBUxMhGAbOwYfDUgIB
PQ==
--000000000000eb815805dbfb3516--
