Return-Path: <linux-wireless+bounces-1603-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17942827844
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 20:16:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2F5181C23D2C
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 19:16:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D0DE54F94;
	Mon,  8 Jan 2024 19:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MUJ/EarL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56A8F4122F;
	Mon,  8 Jan 2024 19:16:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so2555292a12.2;
        Mon, 08 Jan 2024 11:16:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704741371; x=1705346171; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=V2+hZm0MaHSwqVI2yvf7lr17Wbh0R7QsKUw0eeM77J4=;
        b=MUJ/EarLCn0h4sv6gITBZufsd3cwbECFphbFr0TYJS+0toar9lByvo9++OkLSbC8Om
         rYZiQ7JW9lAa6bpHsYBcfzfi93wGOAvwoHGIG59ZPM39hKYnh3HWSfi4lA4F3QElyBF4
         yECBvQOTVpG7TFhVQkHh30txOio61NaDiNp8BcH9a6nuI2mdjMCAEhG/DYEyH6dCTjkI
         MLKbhf7UHZUgqk226Qml9yn5e+9He1U3nEO7GNJ5uYuS5TLMPeqOC13O2uIkRcoT0L25
         pxbQ0ZernxBZbQfyEtrWBZ9bPqwcNOek8u8kT3dVIdKHAvQJUbu+cQgGVXDlth2UgqU4
         2m8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704741371; x=1705346171;
        h=content-transfer-encoding:mime-version:message-id:references
         :in-reply-to:user-agent:subject:cc:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V2+hZm0MaHSwqVI2yvf7lr17Wbh0R7QsKUw0eeM77J4=;
        b=kVfO7pGaH+C1fm6ujBB2iiOnvliiXedESTyHHpUwLxoOTXspnljQ1gGawg96rulF6F
         HzTrw/VePulIiVWmQhJyK0xFNv7IEcTs8TF3qJuXiFTrr/ODHpfOX9Xx8d78A3xja+Bk
         13TMh4pPRuKFH+sDfFqxrF+xkHvbLUx2B7lPDCxmbOiSje9tUfUNMsJ6zGC4P6E/IcVP
         b3d2F52ExRc1TdrXMSwoWWsHAFoSZp46zpXYMg+mfsWEKRmSI7tqhCNpeDMY6r5EBPDe
         VyqLsFTR7ZL/NlZ+xi+502gBiV2baxX9FLoTS+RpUEOL6/y357VVKG3rdjw0FzpK1IAp
         vSCw==
X-Gm-Message-State: AOJu0Yz0iGz3ytNSjNmtNc+tw27ZVC2/o5VItfaETQ+9QlTc8MZhbnuY
	972kAWsNaOPviD4HLA8YKEo=
X-Google-Smtp-Source: AGHT+IFPvIFjdhz64vLG9bABAaY8OMMCwSJDDHeIRYiD4YiJZvGJhv7fhpJzYjb47ld4X5tSGLqZkw==
X-Received: by 2002:a17:906:28d2:b0:a27:ee21:5be with SMTP id p18-20020a17090628d200b00a27ee2105bemr1149879ejd.178.1704741371348;
        Mon, 08 Jan 2024 11:16:11 -0800 (PST)
Received: from [127.0.0.1] ([46.211.247.159])
        by smtp.gmail.com with ESMTPSA id z26-20020a170906271a00b00a2b10e20292sm168356ejc.215.2024.01.08.11.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jan 2024 11:16:11 -0800 (PST)
Date: Mon, 08 Jan 2024 21:16:10 +0200
From: Svyatoslav <clamor95@gmail.com>
To: Arend Van Spriel <aspriel@gmail.com>,
 Arend Van Spriel <arend.vanspriel@broadcom.com>
CC: linux-wireless@vger.kernel.org, linux-firmware@kernel.org,
 linux-bluetooth@vger.kernel.org, Marcel Holtmann <marcel@holtmann.org>
Subject: Re: License of old broadcom BT firmwares and WiFi calibration files
User-Agent: K-9 Mail for Android
In-Reply-To: <a1a3683b-9d47-41e8-a527-17bdca1607ba@gmail.com>
References: <CAPVz0n2Ky350xhOv6WvE0YhFJ9QBe59LnWvKiafs2tjFnptP+g@mail.gmail.com> <22115037-3a81-4a52-8e64-bc85c2be4212@broadcom.com> <CAPVz0n2Dah1b45c0yUjMZNph5AVJjneLsc2LOQ-dkXNRTv6y+Q@mail.gmail.com> <18cce9a7818.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <18ccea1d6d0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <BFE6B9E5-CAF5-4E30-A4A2-A2489423C961@gmail.com> <18cd08e83d0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <CAPVz0n347PVv28H2wswmO3N63dpfPZ0d3VrdxmQHXMoo9LS69g@mail.gmail.com> <18ce9be5470.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <CAPVz0n3BxJjaudDnC=QLHa-0NsE9JSs1ezFpwK2yb=9ySyr2cw@mail.gmail.com> <18cea3af2c8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com> <CAPVz0n3-nirqD9XW+-R_Uh8Ehkm2WKcxa3ZTp8TiOUf7gz+wKA@mail.gmail.com> <a1a3683b-9d47-41e8-a527-17bdca1607ba@gmail.com>
Message-ID: <397291D1-1657-4560-9E7C-57C890BD84FB@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable



8 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024=E2=80=AF=D1=80=2E 21:03:09 GMT+02:00=
, Arend Van Spriel <aspriel@gmail=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=
=B0=D0=B2(-=D0=BB=D0=B0):
>+ linux-bluetooth
>+ Marcel
>
>On 1/8/2024 7:21 PM, Svyatoslav Ryhel wrote:
>> =D0=BF=D0=BD, 8 =D1=81=D1=96=D1=87=2E 2024=E2=80=AF=D1=80=2E =D0=BE 19:=
59 Arend Van Spriel <arend=2Evanspriel@broadcom=2Ecom> =D0=BF=D0=B8=D1=88=
=D0=B5:
>>>=20
>>> On January 8, 2024 5:48:37 PM Svyatoslav Ryhel <clamor95@gmail=2Ecom> =
wrote:
>>>=20
>>>> =D0=BF=D0=BD, 8 =D1=81=D1=96=D1=87=2E 2024=E2=80=AF=D1=80=2E =D0=BE 1=
7:43 Arend Van Spriel <arend=2Evanspriel@broadcom=2Ecom>
>>>> =D0=BF=D0=B8=D1=88=D0=B5:
>>>>>=20
>>>>> On January 4, 2024 10:08:04 AM Svyatoslav Ryhel <clamor95@gmail=2Eco=
m> wrote:
>>>>>=20
>>>>>> =D1=81=D1=80, 3 =D1=81=D1=96=D1=87=2E 2024=E2=80=AF=D1=80=2E =D0=BE=
 20:20 Arend Van Spriel <arend=2Evanspriel@broadcom=2Ecom>
>>>>>> =D0=BF=D0=B8=D1=88=D0=B5:
>>>>>>>=20
>>>>>>> On January 3, 2024 6:28:33 PM Svyatoslav Ryhel <clamor95@gmail=2Ec=
om> wrote:
>>>>>>>=20
>>>>>>>> 3 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024 =D1=80=2E 11:22:42 GMT+02:0=
0, Arend Van Spriel
>>>>>>>> <arend=2Evanspriel@broadcom=2Ecom> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=
=D0=B0=D0=B2(-=D0=BB=D0=B0):
>>>>>>>>> On January 3, 2024 10:14:42 AM Arend Van Spriel
>>>>>>>>> <arend=2Evanspriel@broadcom=2Ecom> wrote:
>>>>>>>>>=20
>>>>>>>>>> + linux-wireless
>>>>>>>>>> + Hans de Goede
>>>>>>>>>>=20
>>>>>>>>>>=20
>>>>>>>>>> On December 16, 2023 9:14:48 PM Svyatoslav Ryhel <clamor95@gmai=
l=2Ecom> wrote:
>>>>>>>>>>=20
>>>>>>>>>>> =D1=81=D0=B1, 16 =D0=B3=D1=80=D1=83=D0=B4=2E 2023=E2=80=AF=D1=
=80=2E =D0=BE 21:57 Arend van Spriel
>>>>>>>>>>> <arend=2Evanspriel@broadcom=2Ecom> =D0=BF=D0=B8=D1=88=D0=B5:
>>>>>>>>>>>>=20
>>>>>>>>>>>> On 12/16/2023 6:45 PM, Svyatoslav Ryhel wrote:
>>>>>>>>>>>>> Greetings!
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> I am trying to submit bluetooth firmwares (BCM4329B1=2E*,*=
=2Ehcd and
>>>>>>>>>>>>> BCM4330B1=2E*,*=2Ehcd) and wifi calibration files
>>>>>>>>>>>>> (brcmfmac4329-sdio=2E*,*=2Etxt and brcmfmac4329-sdio=2E*,*=
=2Etxt) from a few
>>>>>>>>>>>>> Tegra 2 and Tegra 3 based devices into linux-fimware=2E
>>>>>>>>>>>>>=20
>>>>>>>>>>>>> I have faced ambiguous license issue since those files were =
part of
>>>>>>>>>>>>> Android Images of different vendors=2E Those vendors did not=
 provide a
>>>>>>>>>>>>> license nor for android images, not for these files=2E
>>>>>>>>>=20
>>>>>>>>> Does this mean you extracted them from the android image? That p=
robably
>>>>>>>>> never get accepted without any license information=2E
>>>>>>>>=20
>>>>>>>> Can Broadcom re-grant license to these files?
>>>>>>>>=20
>>>>>>>> This license is for bcm4329 in crespo
>>>>>>>> <https://android=2Egooglesource=2Ecom/device/samsung/crespo/+/ref=
s/heads/main/self-extractors/broadcom/LICENSE>
>>>>>>>=20
>>>>>>> Actually checked this link:
>>>>>>>=20
>>>>>>> https://android=2Egooglesource=2Ecom/device/samsung/crespo/+/refs/=
heads/main/proprietary-blobs=2Etxt
>>>>>>>=20
>>>>>>> It lists the bcm4329=2Ehcd file as falling under Apache-2=2E0 lice=
nse=2E Same for
>>>>>>> asus/grouper=2E
>>>>>>>=20
>>>>>>> Regards,
>>>>>>> Arend
>>>>>>=20
>>>>>> So this actually resolves ambiguity=2E Thanks
>>>>>=20
>>>>> Yes, but =2E=2E=2E you should add them to linux-firmware under the s=
ame license=2E
>>>>> That means you need to mark them as such in the WHENCE file=2E Feel =
free to
>>>>> cc: me for the patch so I can have a look at it=2E
>>>>>=20
>>>>> Regards,
>>>>> Arend
>>>>=20
>>>> Thank you for your assistance, it is really appreciated and valued bu=
t
>>>> it was rejected
>>>>=20
>>>> https://gitlab=2Ecom/kernel-firmware/linux-firmware/-/merge_requests/=
114
>>>>=20
>>>> I have referred to our conversation=2E
>>>=20
>>> I see and it seems they were correct=2E My bad=2E Clearly should not t=
ry a
>>> career as lawyer=2E
>>>=20
>>> I can try to publish them to linux-firmware, but I have to ask interna=
lly=2E
>>>=20
>>> Regards,
>>> Arend
>>>=20
>>=20
>> Thank you, looking forward to your answer=2E But keep in mind that
>> generic firmware for bluetooth might not be an option=2E I have tried t=
o
>> shuffle them and bluetooth failed=2E
>
>Okay=2E I guess there is a naming scheme that btbcm=2Eko uses=2E Will loo=
k in the source file how it loads firmware/patch=2E Actually your merge req=
uest would also tell me=2E That involves a whole lot more firmware files th=
an what we discussed earlier=2E
>
>Regards,
>Arend

Uh, yes, I am terribly sorry about that=2E I was looking for analogies wit=
h existing publishes of firmwares since bt firmware occurred to be not inte=
rchangeable=2E I have no hopes that any of them will be accepted, so if any=
 passes then good=2E

