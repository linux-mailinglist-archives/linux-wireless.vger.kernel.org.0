Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC62641DA4
	for <lists+linux-wireless@lfdr.de>; Sun,  4 Dec 2022 16:29:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230024AbiLDP3e (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Sun, 4 Dec 2022 10:29:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230035AbiLDP3c (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Sun, 4 Dec 2022 10:29:32 -0500
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBFE115A15
        for <linux-wireless@vger.kernel.org>; Sun,  4 Dec 2022 07:29:30 -0800 (PST)
Received: by mail-ej1-x635.google.com with SMTP id b2so22356879eja.7
        for <linux-wireless@vger.kernel.org>; Sun, 04 Dec 2022 07:29:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uFfa/f+pWaj14YQO/KyvmkYjX0VNB9FUlFHFUISAV7w=;
        b=b3KlY5TKbQfZpfsbsFfeYpNW3s2sI2RJSsL+KAdB0ZvvAxSiA3CqZm5v4mTV0WOaaw
         gNoCwKvE4Qd2so+z/h7tqOR9u//+RpqZklTczYc5NLn42C/j2KmVK+Rf+efSv7bQzCdX
         DiQL+LotCJGLaXH8weRDDBTEr+pS8GZ/7+ShA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uFfa/f+pWaj14YQO/KyvmkYjX0VNB9FUlFHFUISAV7w=;
        b=1XenTcN8+A3sgyBVAX72Lfa+beTN72f+zDS4ZhkuQdKv2gcsvjjGk5sZg7S9Oge3VT
         RjWB04euoQEipRO8P+u7qN+WVPNlbKc+1CGYT6adeS3qWwhS+CORDfYw876syrgaB/3d
         KC3WPjEGv21oIb1iEjB7Twiyx9cl6K3ATZz7jwEXOrl4eUnJNKDA6hd2thChmGG11gO2
         5x0wvLFU3fGFBieyEUKiHdmOdejRfs8gIcLdo6NwKn/UxTx0yzuwtUX6ztNAKH+Na1ku
         n1/6iL9jYTR4tps/QR2nh0Ist+JO/Q150sbJQzXLplhvdgi9Qr/B64HLv7vNi7D2Nq4P
         OWKw==
X-Gm-Message-State: ANoB5pkkXNEejRYK1S3B1x4n1AR1nv1PLyKzF8bnEPnyItmVl0Gtot57
        TUrIhPpi5aDxTHYLld4PkJXKXA==
X-Google-Smtp-Source: AA0mqf5/DFjjOif8CCE9oUP5SfwTZdRtZWL7qRauryxDWNIbBWgUGoqFldHQL41gkue17XIcc7W8tA==
X-Received: by 2002:a17:906:c303:b0:7ad:95d2:9df2 with SMTP id s3-20020a170906c30300b007ad95d29df2mr19859617ejz.607.1670167769406;
        Sun, 04 Dec 2022 07:29:29 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id fe17-20020a1709072a5100b0077a8fa8ba55sm5244342ejc.210.2022.12.04.07.29.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 04 Dec 2022 07:29:27 -0800 (PST)
From:   Arend Van Spriel <arend.vanspriel@broadcom.com>
To:     Angus Ainslie <angus@akkea.ca>
CC:     Andy Green <andy@warmcat.com>, Shengyu Qu <wiagn233@outlook.com>,
        <franky.lin@broadcom.com>, <linux-wireless@vger.kernel.org>
Date:   Sun, 04 Dec 2022 16:29:26 +0100
Message-ID: <184ddc1a3f0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <fc54e142e34a56fdafa149e8d7829dc0@akkea.ca>
References: <TY3P286MB26114DD461F50814980453E598029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <08416710-655a-c87c-a599-3fe2563f7de4@warmcat.com>
 <18470a1e910.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <TY3P286MB26115A58795F264893CCB40198029@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <184720fc920.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <TY3P286MB26118BD94839F752CADCCF5298079@TY3P286MB2611.JPNP286.PROD.OUTLOOK.COM>
 <625f1d5d-e137-7ad7-96b9-92035e87df8b@broadcom.com>
 <638afa8e-a393-410c-3182-0d8e9b6da17d@warmcat.com>
 <7bf5884906b1abc30adebd3c915a3259@akkea.ca>
 <18486ca8490.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <a25fbe81f6f5615a2cfb7fda80d6db9b@akkea.ca>
 <3163e341-bcfc-a2c3-f0e1-5b62c9da2f43@broadcom.com>
 <852dcabac6bd70a7d55b5ea3f6b0df20@akkea.ca>
 <184d89525a0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <c33d42d546aa6755acc00b8b2e3a4b36@akkea.ca>
 <184d8f5fab0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <fc54e142e34a56fdafa149e8d7829dc0@akkea.ca>
User-Agent: AquaMail/1.40.1 (build: 104001224)
Subject: Re: AP6275 / bcm43752 pcie on mainline brcmf
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000a091b505ef023c3c"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

--000000000000a091b505ef023c3c
Content-Type: text/plain; format=flowed; charset="us-ascii"
Content-Transfer-Encoding: 8bit

On December 4, 2022 3:33:02 PM Angus Ainslie <angus@akkea.ca> wrote:

> On 2022-12-03 09:08, Arend Van Spriel wrote:
>> On December 3, 2022 4:37:19 PM Angus Ainslie <angus@akkea.ca> wrote:
>>
>>> On 2022-12-03 07:22, Arend Van Spriel wrote:
>>>> On December 3, 2022 2:56:39 PM Angus Ainslie <angus@akkea.ca> wrote:
>>>>
>>>>> On 2022-11-29 11:48, Arend van Spriel wrote:
>>>>>> On 11/17/2022 7:36 PM, Angus Ainslie wrote:
>>>>>>> On 2022-11-17 10:12, Arend Van Spriel wrote:
>>>>>>>> On November 17, 2022 5:06:25 PM Angus Ainslie <angus@akkea.ca>
>>>>>>>> wrote:
>>>>>>>>
>>>>>>>>> On 2022-11-17 04:01, Andy Green wrote:
>>>>>>>>>> On 11/17/22 09:23, Arend van Spriel wrote:
>>>>>>>>>>> On 11/16/2022 1:25 PM, Shengyu Qu wrote:
>>>>>>>>>>>> Got a new version of downstream driver and firmware here:
>>>>>>>>>>>> https://gitlab.com/rk3588_linux/linux/external/rkwifibt/-/tree/linux-5.10-gen-rkr3.4
>>>>>>>>>>>
>>>>>>>>>>> Thanks for that. The firmware indeed seems to originate from
>>>>>>>>>>> Synaptics
>>>>>>>>>>> and this module can be found on wifi-alliance product finder:
>>>>>>>>>>>
>>>>>>>>>>> https://www.wi-fi.org/product-finder-results?sort_by=certified&sort_order=desc&keywords=ap6275
>>>>>>>>>>>
>>>>>>>>>>> We have no known contacts there and they do not seem to have
>>>>>>>>>>> much
>>>>>>>>>>> interest in open-source. In that gitlab repo I see they are
>>>>>>>>>>> providing
>>>>>>>>>>> bcmdhd driver and I assume they consider that sufficient.
>>>>>>>>>>>
>>>>>>>>>>> Will see what I can do. First have to think on how to approach
>>>>>>>>>>> this
>>>>>>>>>>> failure to get most out of a debug effort. I do not have the
>>>>>>>>>>> module
>>>>>>>>>>> over here so we would need to go back and forth. The fact that
>>>>>>>>>>> the
>>>>>>>>>>> issue is seen on both SDIO and PCIe is somewhat encouraging.
>>>>>>>>>>
>>>>>>>>>> Yes it seems that at some point with some firmware, SDIO has
>>>>>>>>>> worked
>>>>>>>>>> for, eg, Angus.  And, it should work well with bchdhd (but that
>>>>>>>>>> does
>>>>>>>>>> not seem to work for scan for me on v6.1-rc5 uplevel with the
>>>>>>>>>> firmware
>>>>>>>>>> load changed to use kernel apis; but the firmware has no
>>>>>>>>>> timeout
>>>>>>>>>> on
>>>>>>>>>> bcmdhd). So it doesn't feel a million miles away.
>>>>>>>>>
>>>>>>>>> This is the firmware we have been using for SDIO. It was sent to
>>>>>>>>> us
>>>>>>>>> directly by SparkLAN so not sure how it compares to other
>>>>>>>>> variants.
>>>>>>>>>
>>>>>>>>> https://source.puri.sm/Librem5/firmware-brcm43752-nonfree/-/tree/master/firmware/brcm
>>>>>>>>
>>>>>>>> It is a tad bit older:
>>>>>>>>
>>>>>>>> $ strings brcmfmac43752-sdio.bin | grep FW-TAG
>>>>>>>> <FW-TAG>4362a2-roml/config_sdio_ampak_release_he
>>>>>>>> Version=18.35.387.23.7 (b328500@shgit) (wlan=r880297)
>>>>>>>> Date=2020-07-13T10:34:00Z FWID=01-f50fdff0
>>>>>>>
>>>>>>> Currently it's broken for hotspot mode but I haven't had the
>>>>>>> chance
>>>>>>> to
>>>>>>> see if that is FW or something further up the stack.
>>>>>>
>>>>>> Hi Angus,
>>>>>>
>>>>>> When you added support for this device in brcmfmac you marked it as
>>>>>> a
>>>>>> Cypress device. Are you sure about that? AFAICT this device is
>>>>>> coming
>>>>>> from Synaptics.
>>>>>
>>>>> Hi Arend,
>>>>>
>>>>> I assumed Cypress based on the fact that it most closely resembled
>>>>> the
>>>>> 4373 from the driver side.
>>>>
>>>> Right. Both are based on the same chip architecture that they brought
>>>> from Broadcom so the similarities are not surprising.
>>>>
>>>>> How would I figure out whether it's Cypress or Synaptics ?
>>>>>
>>>>> When I search the web for it I only find SparkLAN or "AMPAK
>>>>> technology"
>>>>> references.
>>>>
>>>> Earlier my colleague Franky found this link to WFA certificate:
>>>>
>>>> https://api.cert.wi-fi.org/api/certificate/download/public?variantId=103641
>>>>
>>>> WFA and FCC are usually good sources of info. Also the product pages
>>>> of the vendors are worth checking. I have them bookmarked out of
>>>> professional interest ;-)
>>>
>>> I did find FCC references but those seemed ambiguous as well. Thanks
>>> for
>>> the wi-fi.org link.
>>>
>>> Should I send a patch renaming SDIO_DEVICE_ID_BROADCOM_CYPRESS_43752
>>> ->
>>> SDIO_DEVICE_ID_BROADCOM_43752 ?
>>
>> Feel free to do so. I have some cleanup work queued up so I can also
>> take care of it.
>
> If you're already going to be in there it would be great if you could
> clean it up.

Sure. No problem.

Regards,
Arend



--000000000000a091b505ef023c3c
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCDFhxogkGmW7LyPh6iG
34ZNDIHexJKIWNw56WgkHFtZrTAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yMjEyMDQxNTI5MjlaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAUcmGCFsRTBnWqOkOSyR5s96Xn7tsBiq7ocXH
eIUGTCOy0ex0BHWI/nVkStS5a+lTmf8gH5/xSg8/jzmb8B45riEYN/rJeVMRsN4hH1fDH+1A7eOA
LRGF2JuVWTLK/jhXZnIxE9fweyyh4e4QihbhZ6YXfjlPjHKeFAZ6CV5fnIgMewldd/Qj2a8stAvk
XUKyO9Kh8IK6v8gJvZC5qhExkU2Qp1FaUN9xW/wTZDihMGC1vY9nz2rChy4tx4FtcLvavolaZXm0
FDbHKgYzrJs0+saQZb4W6FFo3Jj8DJv9eGXqUx2R+wcSQkDhTOgDihcIXqYuXT5wJ+LUfTymKMrv
Mg==
--000000000000a091b505ef023c3c--
