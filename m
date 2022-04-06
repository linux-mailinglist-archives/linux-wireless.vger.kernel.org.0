Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9CDDE4F6291
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Apr 2022 17:08:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235527AbiDFPHb (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 6 Apr 2022 11:07:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235682AbiDFPHX (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 6 Apr 2022 11:07:23 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8809418855E
        for <linux-wireless@vger.kernel.org>; Wed,  6 Apr 2022 05:01:24 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id f10so1741217plr.6
        for <linux-wireless@vger.kernel.org>; Wed, 06 Apr 2022 05:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to;
        bh=b0e/NzR/fgrKUYPJ8dAIlnX8Yof5zz2DhIM/QqFoIJQ=;
        b=c1QZ6NtO9ASd+qy9loPyDnhwmgNMQsJ+tfAhZu2Le6on3jx3X0pDo/V9XTvDjnst5n
         5AYbYcvIjmuVXheehUbxqTghfwoaKxQvZgsUEBDdh7YYvCvH5Je6vQM/OkW+2Xeb/XMv
         zSDl+3z9k4KTRdLi8eD3HwxM+i9nCioTt76Hw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to;
        bh=b0e/NzR/fgrKUYPJ8dAIlnX8Yof5zz2DhIM/QqFoIJQ=;
        b=axj6+0tBVc/1UAIXGDb0NEU3gExGB4V3gxd35eKdTfJ6pEfk7F6rI/zUh49gyAWkX+
         ptlbjvRbOp+RRO6K+zT8+T+cvEWPMwqgK8Zk23f6sRkLTnPN0TQhSceSfX+pHZYNKrjr
         Yg3xkV1nEW6uXJyz8Uj+OtkBZdTqTHV6Qe/pAUf7zuQjwzbMOmerlXOgydyNyNW/29wA
         vFEuEwSsijapPmH23QcFiDTqLANkYEQB6oM1ngDiLUhHQFSHEtmCAoXrQNV7SwyyKsTc
         z2vfV9pIWwRbPnv1Gf5pLTs1f2wsX/Fd3AezjoEj6ao4E3rS0HFODG3Bf2OscQxyP8rc
         PKUg==
X-Gm-Message-State: AOAM533XRUBDPZvcCl5zT2Ly0vTnmgh2c9NNxmBJn+w7GTMIgHIonYee
        yVQa+5/h8zd3/KgvQUoKcpDAdg==
X-Google-Smtp-Source: ABdhPJz+9+R3GP0TYkpAMpsy0LZ/X793mdOmTBeh5RR0KmKV5i41cfNf3Da34B5WkyRKR5OtyzpEhw==
X-Received: by 2002:a17:90b:350f:b0:1c7:7769:3cc6 with SMTP id ls15-20020a17090b350f00b001c777693cc6mr9363858pjb.120.1649246222408;
        Wed, 06 Apr 2022 04:57:02 -0700 (PDT)
Received: from [192.168.178.136] (f140230.upc-f.chello.nl. [80.56.140.230])
        by smtp.gmail.com with ESMTPSA id q18-20020aa78432000000b004fb0a5aa2c7sm19960047pfn.183.2022.04.06.04.56.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 06 Apr 2022 04:57:00 -0700 (PDT)
Message-ID: <3ce6bc12-736f-cde5-ebd4-0224c5733a9e@broadcom.com>
Date:   Wed, 6 Apr 2022 13:56:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: Support for bcm43364 wireless chipset in brcm80211/brcmfmac
To:     Jupiter <jupiter.hce@gmail.com>
Cc:     "David S. Miller" <davem@davemloft.net>,
        Sean Lanigan <sean@lano.id.au>,
        Kalle Valo <kvalo@codeaurora.org>,
        linux-wireless <linux-wireless@vger.kernel.org>,
        Double.Lo@infineon.com
References: <CAA=hcWQFNOeycXFPhrtHcQG3V8fWSShNRuAi49jtv8h1fPVUuQ@mail.gmail.com>
 <8ef5d73a-6293-a6c5-6bbb-b130266a8f0b@broadcom.com>
 <CAA=hcWQ_FVTVfRe91z1yHXMBLkkhi0eTq-9Lw3Tg=X6OS5Ku-Q@mail.gmail.com>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <CAA=hcWQ_FVTVfRe91z1yHXMBLkkhi0eTq-9Lw3Tg=X6OS5Ku-Q@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000004090fb05dbfb0f1e"
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--0000000000004090fb05dbfb0f1e
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

+ Double Lo

On 4/6/2022 9:36 AM, Jupiter wrote:
> Hi Arend,
> 
> Thanks for your response.
> 
>>> Our design criteria is that it must be supported by mainline Linux.
>>> Searching kernel log file to find that you added bcm43364 wireless
>>> chipset to broadcom/brcm80211/brcmfmac driver, could you please advise
>>> how stable and reliable to run brcm80211/brcmfmac for CYW43364 /
>>> Broadcom BCM43364 Chipset?
>>
>> Is Murata providing you with firmware or just the hardware.
> 
> Good question, we'll buy Murata hardware and we'll use Murata firmware
> in linux-firmware so we can run Yocto to build WiFi to the image using
> mainline Linux, linux-firmware and other open sources.
> 
> I've just checked the firmware, there is no bcm43364 binary in
> linux-firmware, only bcm43362 links to cyfmac43362-sdio.bin, is the
> cyfmac43362-sdio.bin the right firmware for Murata WiFi module
> LBWA1KL1FX (CYW43364 / BCM43364 Chipset)? If not, where is the right
> Murata WiFi module LBWA1KL1FX firmware in linux-firmware?

Indeed. As Sean stated in his commit message "The BCM43364 uses the same 
firmware as the BCM43430 (which is already included), the only 
difference is the omission of Bluetooth".

So for BCM43364 the brcmfmac driver will load brcmfmac43430-sdio.bin. 
Now it can be that the Murata WiFi module would need dedicated firmware 
that Murata provides. If your project/design is device-tree based 
(likely if it is a IMX6 ARM-based SoC) your device-tree will have a 
boardname and brcmfmac would try to find 
brcmfmac43430-sdio-<boardname>.bin or something like that. If not 
present it will fallback to the generic firmware mentioned earlier.

> The Broadcom did very good job to support mainline Linux, Cypress
> acquired Broadcom wireless IoT, Infineon acquired Cypress wireless,
> has anyone known if the Infineon is committed to continually maintain
> and support CYW43364 / BCM43364 Chipset driver and firmware in
> mainline Linux and linux-firmware?

Infineon is listed in the MAINTAINERS file so I suppose they are. Hmm, 
there was a patch stripping Infineon names from it. I added the author 
of that patch to comment.

> There is a wired backward tendency in recent years, large vendors
> acquired wireless sectors then stopped supporting open source and
> mainline Linux, switched its wireless sources to use its proprietary
> Linux and SDK. Our original design was using Marvell Avastar 88W8801
> chipset, the driver mwifiex and wifiex_sdio worked well for kernel 4,
> but after NXP acquired Marvell wireless sector, NXP stopped supporting
> mainline Linux, the kernel 5 mwifiex cannot communicate to 88W8801
> chipset firmware, we were told to use the proprietary Linux driver
> sources which is incompatible to our Yocto / OE build system, we have
> no choice but to change the WiFi module.
> 
>>> In addition to add CONFIG_BRCMFMAC and CONFIG_BRCMFMAC_SDIO, should I
>>> also add   CONFIG_BRCMFMAC_PROTO_MSGBUF, CONFIG_DMI,
>>> CONFIG_BRCMFMAC_PROTO_BCDC and CONFIG_OF?
>>
>> I would suggest using menuconfig as it already answers some if not all
>> of these. CONFIG_DMI and CONFIG_OF are really depending on your platform.
> 
> We'll certainly use the menuconfig that is not the issue, our CPU is
> iMX6ULZ running on kernel 5.10, apologize we are not familiar with the
> CONFIG_DMI and CONFIG_OF, appreciate your advice.

If your using IMX6 you will likely use device-tree as I mentioned 
before. So you probably will have CONFIG_OF enabled. OF stands for 
OpenFirmware and the kernel functionality is also used handling 
flattened device-trees.

Regards,
Arend

--0000000000004090fb05dbfb0f1e
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
h9J/RI6gsHbuMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDe6mLn81WTek6u7zOv
zlsE6PetWF3DFKKs+5f5MNcI/jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjA0MDYxMTU3MDJaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAS5/l2MhKVDKSSXZIKQ/Ui0CxUdteJwyXI7ki
iOsH74z7FC0UJBCl80c3Fmk+uzutMJcv2sbXyVkCQobn3yRrLgrbvGvbTo80L72PL4jcMdx85/KP
lzT4RoCkAWU4ojnT9C0C5b+CxEmHjRUZuJ+OXDXLNVntKSJutEI3EK9/N0yzJUiayBek5AluqBL+
CrbLQhH78HnqlgFZV6Pfw0hdAK14yiZrQkkULnq0Mt4ZdCmZLtllp+Osd1GxF89DcctQGGsZUc3u
y1oulw+Bzkj+9LOKzOdUvON/G4HsALWTiiU0rmUOiEDXZmw7varz8NWGwkQLxZ6VlkLfVkQnsZ4W
ug==
--0000000000004090fb05dbfb0f1e--
