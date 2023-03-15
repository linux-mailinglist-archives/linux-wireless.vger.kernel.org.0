Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CCF26BAAD3
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Mar 2023 09:33:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229769AbjCOIdp (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Wed, 15 Mar 2023 04:33:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231504AbjCOIdn (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Wed, 15 Mar 2023 04:33:43 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B392311E1
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 01:33:39 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id h8so28514287ede.8
        for <linux-wireless@vger.kernel.org>; Wed, 15 Mar 2023 01:33:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1678869218;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HgVW49H7L1SP7q+YahOO2WtVHU80WlRkmDam7qKhu8I=;
        b=Tc7mEzu66k30B8Sq1W2FyHn2mNKBMmoJRy5kdfSmz7YvU0LlqbhoYId7mxK7fb08Ec
         t0VWRwQQR+pAjRnoVt/5k74pIn2eDAYcI1dJnq6mpEh8MClSW1PW+T7FHoreBt0K+K15
         GbJEHrGu8bSy1vh7N+yk6AwNq6EM7HSzONyyw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678869218;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HgVW49H7L1SP7q+YahOO2WtVHU80WlRkmDam7qKhu8I=;
        b=Ylvuu/YleM/QpbYaUBdCBo6Gw+qBQbM8FS4VGAoA5BToaEIxz0n85o0l3xGK8Xl4c+
         kVdkWpuaVVedjHvysAMcJ+s+Wv/3TUvOyh5CAWeWd6QoGHQ621HTCmcQovu8RvKsOlm3
         Xezc86Wf1G9cYa5RszA+0O7EEqNXdCAI4U9lEwqrtiaymm2sksyk1zik5eNBpzny8uuM
         o8KNGtSXiX/aDkfW6NB+NUpLglOlbOWmOqrigSEuaLtRsQfykT043zZI4XVtX9CjNe/X
         yKUJNqHAnAoqpyxh+mANcQOxsqD9Uvv+SrU+MDMvIM44NkCBVdrwW7YsoR8Z18M7uoxY
         2QDQ==
X-Gm-Message-State: AO0yUKXkA1a8d6ip2hFPpDZCyjTLaD0Nujv3neCl3DOZHb9EctmTOtYo
        kG6m3LeAMx6oDAekiqPBZSRvxQ==
X-Google-Smtp-Source: AK7set8vgVL4XEP5WRczvUEO6lB/wb0c8EwNVZP6htuWmuwqcqUUCk1XDqUzUPTLb388eA5Wl1vPGA==
X-Received: by 2002:a17:906:4fd0:b0:8dd:5710:a017 with SMTP id i16-20020a1709064fd000b008dd5710a017mr6897241ejw.4.1678869217875;
        Wed, 15 Mar 2023 01:33:37 -0700 (PDT)
Received: from [10.194.183.67] ([109.37.149.36])
        by smtp.gmail.com with ESMTPSA id z9-20020a170906074900b008eaf99be56esm2194636ejb.170.2023.03.15.01.33.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Mar 2023 01:33:37 -0700 (PDT)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Michael Stapelberg <michael+lkml@stapelberg.ch>
CC:     Kalle Valo <kvalo@kernel.org>,
        Franky Lin <franky.lin@broadcom.com>,
        "Pieter-Paul Giesberts" <pieter-paul.giesberts@broadcom.com>,
        Hante Meuleman <hante.meuleman@broadcom.com>,
        <linux-wireless@vger.kernel.org>
Date:   Wed, 15 Mar 2023 09:33:36 +0100
Message-ID: <186e4673718.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CANnVG6n-eqKUQnX_6wncmjG1kyVfhxqs2L82xYQpDmGq89eVAQ@mail.gmail.com>
References: <CANnVG6=a3etRagG+RaSEH-b4_nfzxpEKffQtuMWrttrbgjunZQ@mail.gmail.com>
 <186e23b5668.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CANnVG6kjWj02eEFv_OeLiRtjrJ6yn4EsELz_BtrzFHH15GNMLw@mail.gmail.com>
 <186e26dc0a8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CANnVG6n-eqKUQnX_6wncmjG1kyVfhxqs2L82xYQpDmGq89eVAQ@mail.gmail.com>
User-Agent: AquaMail/1.43.0 (build: 104300275)
Subject: Re: wifi breakage due to commit "wifi: brcmfmac: add support for vendor-specific firmware api"
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000005f55b705f6ec3369"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--0000000000005f55b705f6ec3369
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On March 15, 2023 8:58:43 AM Michael Stapelberg 
<michael+lkml@stapelberg.ch> wrote:

> Hey Arend
>
> Thanks for taking a look.
>
> The brcmfmac-wcc module is present on my installation, but I’m not
> currently loading it.
> (I only load brcmutil, then brcmfmac.)
>
> But, even if I load it, the wlan0 interface still doesn’t show up.
>
> In the modules.dep, I see that brcmfmac-wcc should be loaded after
> brcmutil and brcmfmac.
> Is that accurate?

Yes. Actually brcmfmac loads brcmfmac-wcc by itself.

> My installation is somewhat unusual in that I use a custom userland
> (see https://gokrazy.org/).

Bit tricky choice of name :-p I will check it out.

Regards,
Arend

>
> Thanks
> Best regards
> Michael
>
>
> On Wed, 15 Mar 2023 at 00:21, Arend Van Spriel
> <arend.vanspriel@broadcom.com> wrote:
>>
>> On March 14, 2023 11:49:05 PM Michael Stapelberg
>> <michael+lkml@stapelberg.ch> wrote:
>>
>>> Of course, find it attached. Thanks.
>>
>> Strange. Could it be there is some build config needed to install the
>> additional kernel modules (brcmfmac-wcc.ko, etc.) on RPi image?
>>
>> Regards,
>> Arend
>>
>>>
>>> On Tue, 14 Mar 2023 at 23:26, Arend Van Spriel
>>> <arend.vanspriel@broadcom.com> wrote:
>>>>
>>>> On March 14, 2023 8:39:05 PM Michael Stapelberg
>>>> <michael+lkml@stapelberg.ch> wrote:
>>>>
>>>>> Hey Arend
>>>>>
>>>>> I recently bisected a user-reported WiFi breakage on the Raspberry Pi
>>>>> 3B+ to your commit
>>>>> https://github.com/torvalds/linux/commit/d6a5c562214f26e442c8ec3ff1e28e16675d1bcf
>>>>> https://lore.kernel.org/r/20221129135446.151065-4-arend.vanspriel@broadcom.com
>>>>>
>>>>> On our end, the issue was reported here:
>>>>> https://github.com/gokrazy/wifi/issues/3
>>>>>
>>>>> As of Linux 6.2.6, this seems to still be unfixed, so I wanted to
>>>>> check in and see if you could take a look please?
>>>>
>>>> I have a suspicion, but can you provide the kernel .config file so I can
>>>> see if I am on the right track.
>>>>
>>>>> + brcmfmac: brcmf_fwvid_request_module: mod=wcc: failed -2
>>>>> + ieee80211 phy0: brcmf_attach: brcmf_fwvid_attach failed
>>>>> + brcmfmac: brcmf_sdio_firmware_callback: brcmf_attach failed
>>>>
>>>> Regards,
>>>> Arend




--0000000000005f55b705f6ec3369
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCCJpFV4yYc7wP6UbVp6
15muEp3lcohNUb0zkOGAr9XC2jAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMzAzMTUwODMzMzhaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAJNS0OLRb3xIGXwz8mrYKn9jDBpsIwvVFgRQf
hHH0KpbbY+Qt8ML+/VS231nC3HQdVM3acn6yFo0PDpoGsQKUwgGclR1HTwX9D4XVZnm7ZO7H5KvZ
NRaRTcSQDY+ZHSnXgwo7E+Xk3Uu6sJ8OJrM9B2Jrt1zvptegrbs9+5WMNl3ZSZTtF1WRnnhJe7Cf
IzxceOCPWeSYLp745jA3dv+Pm//n6dXO+Xm5Ekmu216WkZc8f+Ay57GhSdyELYAx9DlJ8BbqDLrI
oHomw32Iz9rdIRezmVr8lP1tQwXvTu+HFfgLwiLNhKtnOkNZHl93an00OlO4mCPlFIIhscE1e9FI
Gw==
--0000000000005f55b705f6ec3369--
