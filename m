Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5728E6BABCD
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 10:12:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231808AbjCOJMs (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 05:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbjCOJMR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 05:12:17 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1395427D72
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 02:12:15 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id r11so21036109edd.5
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 02:12:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1678871533;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=1p9BKQFT3p0Gc4x3pp/GnkSwuxWFgXmimeRkfxJHlaE=;
        b=GbMoDdOr1SFxKkr1AnKd0G523uPUttrQ1Q/OUgeT9aklbNmzCHFvFMHYRnncnUy5r7
         7MF0EfWBtDPlktG2e7bvicqcPHofiyMwJ7GNmJjJeGIdUvfI6BXEnqhTH81TIesm37zm
         JT/w3G9Xz1SECgpxZDM2mFYZ4+uaFeoDHqusM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678871533;
        h=in-reply-to:from:references:cc:to:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1p9BKQFT3p0Gc4x3pp/GnkSwuxWFgXmimeRkfxJHlaE=;
        b=rNHUe9gTYgG6plmynB3fRfN9/NySm7Yk9b00EUFUVMU3MeC2ADpMy3bPf+WTGO4rcI
         lTsJJzK+ShFbWUgEnIESfNM5UzKRcsTybZz1Lz/3w1liwxGc2rw4d+/DXpQG+0N+6lBc
         XFfswizKnko7UwNL1OGLa2tTW7sNJtG3748ialeporQibuNhV1/pGXxmcnp0JPb9XCkL
         yk5MKEcVbYv9ICVfEwNVznpTjFyVtAouh9bTX7aMxgXZyWKaEEMH74F4tslwDnKQGAj6
         UKlZUgIZla0Xc0byGYk6GGocGYge0WYG7fj2/1iQHhrTaaUJcRWIKbunEfVg8jxP3LXn
         5kcQ==
X-Gm-Message-State: AO0yUKWFK43Xdc+z1OS50+fS/TX5/KupjfsQms9oH05WTSvfQw6gh0qN
        HGUQtcmdDXtWAJpWdM3STibWzg==
X-Google-Smtp-Source: AK7set9vmVUTPa3wUxhxzxh+XCk7SVFgXTF/g3hGktkei2CWtssA4CpEhlDUM1SfxbXhDYWM9qETAA==
X-Received: by 2002:a17:906:4ac2:b0:92b:7e6a:bca1 with SMTP id u2-20020a1709064ac200b0092b7e6abca1mr6374718ejt.20.1678871533496;
        Wed, 15 Mar 2023 02:12:13 -0700 (PDT)
Received: from [192.168.178.136] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id k10-20020a170906680a00b008d044ede804sm2193368ejr.163.2023.03.15.02.12.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 02:12:13 -0700 (PDT)
Message-ID: <89262772-7358-77e8-8913-c459819d544a@broadcom.com>
Date:   Wed, 15 Mar 2023 10:12:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: wifi breakage due to commit "wifi: brcmfmac: add support for
 vendor-specific firmware api"
To:     Michael Stapelberg <michael+lkml@stapelberg.ch>
Cc:     Kalle Valo <kvalo@kernel.org>,
        Franky Lin <franky.lin@broadcom.com>,
        Pieter-Paul Giesberts <pieter-paul.giesberts@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        linux-wireless@vger.kernel.org
References: <CANnVG6=a3etRagG+RaSEH-b4_nfzxpEKffQtuMWrttrbgjunZQ@mail.gmail.com>
 <186e23b5668.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CANnVG6kjWj02eEFv_OeLiRtjrJ6yn4EsELz_BtrzFHH15GNMLw@mail.gmail.com>
 <186e26dc0a8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CANnVG6n-eqKUQnX_6wncmjG1kyVfhxqs2L82xYQpDmGq89eVAQ@mail.gmail.com>
 <186e4673718.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CANnVG6kaGj1SVCqf2y3=Xj_N2G9j+-VhLDN4_WY_ywDswNkO3g@mail.gmail.com>
From:   Arend van Spriel <arend.vanspriel@broadcom.com>
In-Reply-To: <CANnVG6kaGj1SVCqf2y3=Xj_N2G9j+-VhLDN4_WY_ywDswNkO3g@mail.gmail.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000065aaa505f6ecbdc5"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--00000000000065aaa505f6ecbdc5
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/15/2023 9:53 AM, Michael Stapelberg wrote:
> Hey Arend
> 
> On Wed, 15 Mar 2023 at 09:33, Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>>
>> On March 15, 2023 8:58:43 AM Michael Stapelberg
>> <michael+lkml@stapelberg.ch> wrote:
>>
>>> Hey Arend
>>>
>>> Thanks for taking a look.
>>>
>>> The brcmfmac-wcc module is present on my installation, but I’m not
>>> currently loading it.
>>> (I only load brcmutil, then brcmfmac.)
>>>
>>> But, even if I load it, the wlan0 interface still doesn’t show up.
>>>
>>> In the modules.dep, I see that brcmfmac-wcc should be loaded after
>>> brcmutil and brcmfmac.
>>> Is that accurate?
>>
>> Yes. Actually brcmfmac loads brcmfmac-wcc by itself.
> 
> Hmm, when I run lsmod after booting, I don’t see it:
> 
> /tmp/breakglass1452371198 # lsmod
> hci_uart 61440 0 - Live 0xffffba314a2cd000
> btbcm 24576 1 hci_uart, Live 0xffffba314a2c6000
> bluetooth 786432 3 hci_uart,btbcm, Live 0xffffba314a205000
> brcmfmac 258048 0 - Live 0xffffba314a1c5000
> brcmutil 20480 1 brcmfmac, Live 0xffffba314a1bf000
> ecdh_generic 16384 1 bluetooth, Live 0xffffba314a1ba000
> ecc 36864 1 ecdh_generic, Live 0xffffba314a1b0000
> /tmp/breakglass1452371198 #

That is expected as the log shows:

 >>>>>>> + brcmfmac: brcmf_fwvid_request_module: mod=wcc: failed -2
 >>>>>>> + ieee80211 phy0: brcmf_attach: brcmf_fwvid_attach failed

So in brcmf_fwvid_request_module it tries to load brcmfmac-wcc, but for 
some reason it fails.

> How does the “load by itself” mechanism work?
> Maybe I’m missing a userspace component for it.

I think it works pretty similar to firmware loading. These days firmware 
loading does not rely on a user-space helper and I assumed the same is 
true for module loading. Will look into it.

Regards,
Arend

> Thanks
> 
>>
>>
>>> My installation is somewhat unusual in that I use a custom userland
>>> (see https://gokrazy.org/).
>>
>> Bit tricky choice of name :-p I will check it out.
>>
>> Regards,
>> Arend
>>
>>>
>>> Thanks
>>> Best regards
>>> Michael
>>>
>>>
>>> On Wed, 15 Mar 2023 at 00:21, Arend Van Spriel
>>> <arend.vanspriel@broadcom.com> wrote:
>>>>
>>>> On March 14, 2023 11:49:05 PM Michael Stapelberg
>>>> <michael+lkml@stapelberg.ch> wrote:
>>>>
>>>>> Of course, find it attached. Thanks.
>>>>
>>>> Strange. Could it be there is some build config needed to install the
>>>> additional kernel modules (brcmfmac-wcc.ko, etc.) on RPi image?
>>>>
>>>> Regards,
>>>> Arend
>>>>
>>>>>
>>>>> On Tue, 14 Mar 2023 at 23:26, Arend Van Spriel
>>>>> <arend.vanspriel@broadcom.com> wrote:
>>>>>>
>>>>>> On March 14, 2023 8:39:05 PM Michael Stapelberg
>>>>>> <michael+lkml@stapelberg.ch> wrote:
>>>>>>
>>>>>>> Hey Arend
>>>>>>>
>>>>>>> I recently bisected a user-reported WiFi breakage on the Raspberry Pi
>>>>>>> 3B+ to your commit
>>>>>>> https://github.com/torvalds/linux/commit/d6a5c562214f26e442c8ec3ff1e28e16675d1bcf
>>>>>>> https://lore.kernel.org/r/20221129135446.151065-4-arend.vanspriel@broadcom.com
>>>>>>>
>>>>>>> On our end, the issue was reported here:
>>>>>>> https://github.com/gokrazy/wifi/issues/3
>>>>>>>
>>>>>>> As of Linux 6.2.6, this seems to still be unfixed, so I wanted to
>>>>>>> check in and see if you could take a look please?
>>>>>>
>>>>>> I have a suspicion, but can you provide the kernel .config file so I can
>>>>>> see if I am on the right track.
>>>>>>
>>>>>>> + brcmfmac: brcmf_fwvid_request_module: mod=wcc: failed -2
>>>>>>> + ieee80211 phy0: brcmf_attach: brcmf_fwvid_attach failed
>>>>>>> + brcmfmac: brcmf_sdio_firmware_callback: brcmf_attach failed
>>>>>>
>>>>>> Regards,
>>>>>> Arend
>>
>>
>>

--00000000000065aaa505f6ecbdc5
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
2Gzj3QNJRLsZu1TLyOyBBIr/BE7UiY3RabgRzknBGAPmzhS+fmyM8OtM5BYBsFBrSUFtZZO2p/tf
Nbc24J2zf2peoZ8MK+7WQqummYlOnz+FyDkA9EybeNMcS5C+xi/PAgMBAAGjggHdMIIB2TAOBgNV
HQ8BAf8EBAMCBaAwgaMGCCsGAQUFBwEBBIGWMIGTME4GCCsGAQUFBzAChkJodHRwOi8vc2VjdXJl
Lmdsb2JhbHNpZ24uY29tL2NhY2VydC9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAyMC5jcnQwQQYI
KwYBBQUHMAGGNWh0dHA6Ly9vY3NwLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24y
Y2EyMDIwME0GA1UdIARGMEQwQgYKKwYBBAGgMgEoCjA0MDIGCCsGAQUFBwIBFiZodHRwczovL3d3
dy5nbG9iYWxzaWduLmNvbS9yZXBvc2l0b3J5LzAJBgNVHRMEAjAAMEkGA1UdHwRCMEAwPqA8oDqG
OGh0dHA6Ly9jcmwuZ2xvYmFsc2lnbi5jb20vZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3Js
MCcGA1UdEQQgMB6BHGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20wEwYDVR0lBAwwCgYIKwYB
BQUHAwQwHwYDVR0jBBgwFoAUljPR5lgXWzR1ioFWZNW+SN6hj88wHQYDVR0OBBYEFIikAXd8CEtv
ZbDflDRnf3tuStPuMA0GCSqGSIb3DQEBCwUAA4IBAQCdS5XCYx6k2GGZui9DlFsFm75khkqAU7rT
zBX04sJU1+B1wtgmWTVIzW7ugdtDZ4gzaV0S9xRhpDErjJaltxPbCylb1DEsLj+AIvBR34caW6ZG
sQk444t0HPb29HnWYj+OllIGMbdJWr0/P95ZrKk2bP24ub3ZP/8SyzrohfIba9WZKMq6g2nTLZE3
BtkeSGJx/8dy0h8YmRn+adOrxKXHxhSL8BNn8wsmIZyYWe6fRcBtO3Ks2DOLyHCdkoFlN8x9VUQF
N2ulEgqCbRKkx+qNirW86eF138lr1gRxzclu/38ko//MmkAYR/+hP3WnBll7zbpIt0jc9wyFkSqH
p8a1MYICbTCCAmkCAQEwazBbMQswCQYDVQQGEwJCRTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1z
YTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMgUGVyc29uYWxTaWduIDIgQ0EgMjAyMAIMTv1t
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCB9FmtlCFEoJkE3h28w
pl++QF1RmwZHZnosM05l7Dt5tzAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzAzMTUwOTEyMTNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAX3qhu0UkoV7t0RK0wuqf04anZgfpVyWJ751M
H0ANDg9LWFhHVdux6xS0smqqv3E3yzJfYK2ZPCUUeV7f+8Ymu52JqdUPCRFlsvIXg4QKU7lOdP+M
AtSRFQj44ykl1VAMDaFG6ZWzfI8DkRyzt21Ajt6/NG8dFMTk6Bbfqv2SGP8qfGZI3EUZqAbwqspK
VqaGMqkJGM7DyCBb8NNdYvrWDMZbRQ2xydb0piaLm7+OiED0n19o1W0/QJlwl4jCmJijIPvLxQf/
fn7mTqJVEQh+4OxPXUzPp2tyCDX4Z/xBNMwc2km9ILjS0kp0tFHfwwUbzUUe0s6BdIQIb9XGm4/3
Uw==
--00000000000065aaa505f6ecbdc5--
