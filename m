Return-Path: <linux-wireless+bounces-1596-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7DC438276E7
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 19:06:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC8C31C21636
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 18:05:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50EDB54BDA;
	Mon,  8 Jan 2024 17:59:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=broadcom.com header.i=@broadcom.com header.b="OnDMfbL4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 76BFC524BA
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 17:59:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=broadcom.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=broadcom.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a26f73732c5so220117266b.3
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jan 2024 09:59:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1704736783; x=1705341583; darn=vger.kernel.org;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=p9Jmk3M8+HuqAQmZk2cggAhcJV3fe4240NYp/vW4raM=;
        b=OnDMfbL4/d72yx1oD+DEu+K/8er0FfBkBJ8d+t4SaT1Z8RwNHJiwQzv8XQGtp/u0Nh
         rzFiOuO2nyHN531WzC25i7lSEQPPtHSDRzNobKZgv1ZsZH3I4K+UtI+rqhmUBAMwFd5q
         IW91pkjA2I64ngJr4lkLtO0oynH3LB2Eyvsi4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704736783; x=1705341583;
        h=mime-version:subject:user-agent:references:in-reply-to:message-id
         :date:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p9Jmk3M8+HuqAQmZk2cggAhcJV3fe4240NYp/vW4raM=;
        b=ufPxGFtv2z/qQm+pKAn8FI8HofoWwK9tPX8q9PkNFBZco/DJGHIR9hNojGQYODCGcj
         YHAc/6IsiugW9Hd9ybAeXxS4W4tBl7PjebZcBXGKLdukOD6IT51kNFU8SDJcUhDFr08p
         7qjY06yy+0IcLUUyUlh+YODNohUkMv3rUBbj+un6Mw4FWQR5Ycvt6r6dOjeJU/IZ8z02
         hecJbHzoXztgEoVjjHT7XTIbJ6i0u3nCTQatrce0pVYH6hP9Vl0qoWo1A47q4oXzMd3P
         lkqRzk1P+OqmEGd3CsIrq4Y6aaiZBSj5ct3xjmXz9uZecAByzsEHrB1/cIRhOVyKy9BS
         CJpQ==
X-Gm-Message-State: AOJu0Yy8FW/FBV+7KW22svIyoa4N1MgwreFwOQlYRmxZnFH9p3SJWOkq
	rkuF5E65mg+xBYqC4csltMqgvTLLFlmH
X-Google-Smtp-Source: AGHT+IHru5YvfZSYFEC8D9XqrjowonfKHr4D+uoqluls1ma8YPc6ph+unlZTuY5oYKaQX3vzVpCrmQ==
X-Received: by 2002:a17:906:ca52:b0:a27:e711:8b7e with SMTP id jx18-20020a170906ca5200b00a27e7118b7emr1533404ejb.106.1704736783681;
        Mon, 08 Jan 2024 09:59:43 -0800 (PST)
Received: from [192.168.178.38] (f215227.upc-f.chello.nl. [80.56.215.227])
        by smtp.gmail.com with ESMTPSA id l25-20020a1709066b9900b00a28ff7b8049sm112790ejr.224.2024.01.08.09.59.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 08 Jan 2024 09:59:42 -0800 (PST)
From: Arend Van Spriel <arend.vanspriel@broadcom.com>
To: Svyatoslav Ryhel <clamor95@gmail.com>
CC: <linux-wireless@vger.kernel.org>, <linux-firmware@kernel.org>
Date: Mon, 08 Jan 2024 18:59:41 +0100
Message-ID: <18cea3af2c8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <CAPVz0n3BxJjaudDnC=QLHa-0NsE9JSs1ezFpwK2yb=9ySyr2cw@mail.gmail.com>
References: <CAPVz0n2Ky350xhOv6WvE0YhFJ9QBe59LnWvKiafs2tjFnptP+g@mail.gmail.com>
 <22115037-3a81-4a52-8e64-bc85c2be4212@broadcom.com>
 <CAPVz0n2Dah1b45c0yUjMZNph5AVJjneLsc2LOQ-dkXNRTv6y+Q@mail.gmail.com>
 <18cce9a7818.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <18ccea1d6d0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <BFE6B9E5-CAF5-4E30-A4A2-A2489423C961@gmail.com>
 <18cd08e83d0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAPVz0n347PVv28H2wswmO3N63dpfPZ0d3VrdxmQHXMoo9LS69g@mail.gmail.com>
 <18ce9be5470.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAPVz0n3BxJjaudDnC=QLHa-0NsE9JSs1ezFpwK2yb=9ySyr2cw@mail.gmail.com>
User-Agent: AquaMail/1.49.0 (build: 104900403)
Subject: Re: License of old broadcom BT firmwares and WiFi calibration files
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
	boundary="00000000000071d677060e72f674"

--00000000000071d677060e72f674
Content-Type: text/plain; format=flowed; charset="UTF-8"
Content-Transfer-Encoding: 8bit

On January 8, 2024 5:48:37 PM Svyatoslav Ryhel <clamor95@gmail.com> wrote:

> пн, 8 січ. 2024 р. о 17:43 Arend Van Spriel <arend.vanspriel@broadcom.com> 
> пише:
>>
>> On January 4, 2024 10:08:04 AM Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>>
>>> ср, 3 січ. 2024 р. о 20:20 Arend Van Spriel <arend.vanspriel@broadcom.com>
>>> пише:
>>>>
>>>> On January 3, 2024 6:28:33 PM Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>>>>
>>>>> 3 січня 2024 р. 11:22:42 GMT+02:00, Arend Van Spriel
>>>>> <arend.vanspriel@broadcom.com> написав(-ла):
>>>>>> On January 3, 2024 10:14:42 AM Arend Van Spriel
>>>>>> <arend.vanspriel@broadcom.com> wrote:
>>>>>>
>>>>>>> + linux-wireless
>>>>>>> + Hans de Goede
>>>>>>>
>>>>>>>
>>>>>>> On December 16, 2023 9:14:48 PM Svyatoslav Ryhel <clamor95@gmail.com> wrote:
>>>>>>>
>>>>>>>> сб, 16 груд. 2023 р. о 21:57 Arend van Spriel
>>>>>>>> <arend.vanspriel@broadcom.com> пише:
>>>>>>>>>
>>>>>>>>> On 12/16/2023 6:45 PM, Svyatoslav Ryhel wrote:
>>>>>>>>>> Greetings!
>>>>>>>>>>
>>>>>>>>>> I am trying to submit bluetooth firmwares (BCM4329B1.*,*.hcd and
>>>>>>>>>> BCM4330B1.*,*.hcd) and wifi calibration files
>>>>>>>>>> (brcmfmac4329-sdio.*,*.txt and brcmfmac4329-sdio.*,*.txt) from a few
>>>>>>>>>> Tegra 2 and Tegra 3 based devices into linux-fimware.
>>>>>>>>>>
>>>>>>>>>> I have faced ambiguous license issue since those files were part of
>>>>>>>>>> Android Images of different vendors. Those vendors did not provide a
>>>>>>>>>> license nor for android images, not for these files.
>>>>>>
>>>>>> Does this mean you extracted them from the android image? That probably
>>>>>> never get accepted without any license information.
>>>>>
>>>>> Can Broadcom re-grant license to these files?
>>>>>
>>>>> This license is for bcm4329 in crespo
>>>>> <https://android.googlesource.com/device/samsung/crespo/+/refs/heads/main/self-extractors/broadcom/LICENSE>
>>>>
>>>> Actually checked this link:
>>>>
>>>> https://android.googlesource.com/device/samsung/crespo/+/refs/heads/main/proprietary-blobs.txt
>>>>
>>>> It lists the bcm4329.hcd file as falling under Apache-2.0 license. Same for
>>>> asus/grouper.
>>>>
>>>> Regards,
>>>> Arend
>>>
>>> So this actually resolves ambiguity. Thanks
>>
>> Yes, but ... you should add them to linux-firmware under the same license.
>> That means you need to mark them as such in the WHENCE file. Feel free to
>> cc: me for the patch so I can have a look at it.
>>
>> Regards,
>> Arend
>
> Thank you for your assistance, it is really appreciated and valued but
> it was rejected
>
> https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/114
>
> I have referred to our conversation.

I see and it seems they were correct. My bad. Clearly should not try a 
career as lawyer.

I can try to publish them to linux-firmware, but I have to ask internally.

Regards,
Arend




--00000000000071d677060e72f674
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
bpIzNUky46LXMA0GCWCGSAFlAwQCAQUAoIHUMC8GCSqGSIb3DQEJBDEiBCAui9Dgh1CiXJw08H5w
fjCVMrGYLD50Ic3wvJ8UsCDrhjAYBgkqhkiG9w0BCQMxCwYJKoZIhvcNAQcBMBwGCSqGSIb3DQEJ
BTEPFw0yNDAxMDgxNzU5NDNaMGkGCSqGSIb3DQEJDzFcMFowCwYJYIZIAWUDBAEqMAsGCWCGSAFl
AwQBFjALBglghkgBZQMEAQIwCgYIKoZIhvcNAwcwCwYJKoZIhvcNAQEKMAsGCSqGSIb3DQEBBzAL
BglghkgBZQMEAgEwDQYJKoZIhvcNAQEBBQAEggEAPaBqBP+9497H3c+g2JQqXR6TMpy13eU4f/km
ySi6HXistQ3zInpjugvb3hd2ZPoK1tb7acrlqUw6iJ5ewnQxq1S8FjoFWF8zevYoJADe5z++PeWI
RMh/S7bFErQnih8o9O9YX4LZfwUUwK8hwi+uFbs9zx/MdSiHLu2Rl3046TQCfuES6Qaue5AktJ75
ycH9maF1XGug/iRtxweJYr7U5LY8P1E6v/zL2t0AoL73VuzNjuPGPrZvDwFm1njDagpzUFT8sfjz
wVlKRqsXBC+JFbIoVmN0eiTqJx+vSXX9A4Qokk6z9ywFKpmxxHY8sfpeQV1xary5qZKYQokNEcZd
dA==
--00000000000071d677060e72f674--

