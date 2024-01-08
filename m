Return-Path: <linux-wireless+bounces-1600-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 378D682774A
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 19:23:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AF5F1C22D84
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 18:23:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8ACC654BE0;
	Mon,  8 Jan 2024 18:21:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hsp2l8vx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com [209.85.128.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDFD555787
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 18:21:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f50.google.com with SMTP id 5b1f17b1804b1-40e4582ed74so14110265e9.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jan 2024 10:21:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704738091; x=1705342891; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oh00BWPDA3TEwCHwjUiWs+woCjiFdSbxvzeNpEaiT/Y=;
        b=hsp2l8vxkwpUX8yp54m0IJFHeaiHIGbbtNfyn2qNW4WqsT43ixM1u1sJoYZwDALxK0
         AYlFobvp9FR0goLcWml9w5su3sL3y2kyzfp7UsecN8gNIvZQbarDDyL0P0p1CfVtuJN8
         EwPQZaRBUbkSHoZ+6oVVAdIi/g4jLeYpxkOLRM8P1Zo2Sk0Ul5AvpZSMedo21WXCDRC7
         9RnQeE+096/49S+W5TFswMrVTSBnCFTwPeGvYjOQXKjlMaTJN0pTzhfKmUOMJ+2JYOSV
         zXdcMfu3Wmx0JmGxd0tv9qZEcjmT+6TXyYv0J3xRwm8ig1EamTkTkaCWfbWe4jQD3RFT
         rKpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704738091; x=1705342891;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oh00BWPDA3TEwCHwjUiWs+woCjiFdSbxvzeNpEaiT/Y=;
        b=MPLhtf7V4rPz8tZeLvSOocBTcKSdtU0Dx0RmkwvOQga8IqTaqFMWzVHC5udzR/rHQe
         D5+V8Wj14HySpWwn0Af7vOtIBS3tvDsJb8WovzUxc9sf0rxookZFgqw55hjc54seyCHU
         AH34B5QCrBgv3aqIcK7pc9M5FjAEWZRhmj4vy2E5x/+XybNzVORXHkmTp9MI2cQQwiq7
         iw5aRNosmKKtwu6RdkLfRlI2uYRBGtjK5BCtyuK3n7gFmnaq2dY8UF8Fy4ELSrupgJod
         gLClb8CGgQEWZaGLsyYMJjf2hBB/exhs0gUswcDERnRtglBVdFhgcgF0NdVeSjO//TQm
         Ch5Q==
X-Gm-Message-State: AOJu0Yx0Uu/+jWOWD5R2/HY6nBxz3S9tlDCv5Q6eu3jGjpmqa7OGjObe
	exPgZ1EceCuN6RE0MVDruwUzbKMPF9/tvfIS9Dc=
X-Google-Smtp-Source: AGHT+IFMc5sSolGG94JasR0VkKxFaTccBO4+BdnRvmjhdhiuHD3WRFK2jRWFLlhyx9bYYP/8DXqoj3hNthwY8k+8rCU=
X-Received: by 2002:a5d:6606:0:b0:336:c434:5c20 with SMTP id
 n6-20020a5d6606000000b00336c4345c20mr1216259wru.149.1704738090826; Mon, 08
 Jan 2024 10:21:30 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAPVz0n2Ky350xhOv6WvE0YhFJ9QBe59LnWvKiafs2tjFnptP+g@mail.gmail.com>
 <22115037-3a81-4a52-8e64-bc85c2be4212@broadcom.com> <CAPVz0n2Dah1b45c0yUjMZNph5AVJjneLsc2LOQ-dkXNRTv6y+Q@mail.gmail.com>
 <18cce9a7818.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <18ccea1d6d0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <BFE6B9E5-CAF5-4E30-A4A2-A2489423C961@gmail.com> <18cd08e83d0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAPVz0n347PVv28H2wswmO3N63dpfPZ0d3VrdxmQHXMoo9LS69g@mail.gmail.com>
 <18ce9be5470.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
 <CAPVz0n3BxJjaudDnC=QLHa-0NsE9JSs1ezFpwK2yb=9ySyr2cw@mail.gmail.com> <18cea3af2c8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <18cea3af2c8.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 8 Jan 2024 20:21:19 +0200
Message-ID: <CAPVz0n3-nirqD9XW+-R_Uh8Ehkm2WKcxa3ZTp8TiOUf7gz+wKA@mail.gmail.com>
Subject: Re: License of old broadcom BT firmwares and WiFi calibration files
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, linux-firmware@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 8 =D1=81=D1=96=D1=87. 2024=E2=80=AF=D1=80. =D0=BE 19:59 Arend=
 Van Spriel <arend.vanspriel@broadcom.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On January 8, 2024 5:48:37 PM Svyatoslav Ryhel <clamor95@gmail.com> wrote=
:
>
> > =D0=BF=D0=BD, 8 =D1=81=D1=96=D1=87. 2024=E2=80=AF=D1=80. =D0=BE 17:43 A=
rend Van Spriel <arend.vanspriel@broadcom.com>
> > =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> On January 4, 2024 10:08:04 AM Svyatoslav Ryhel <clamor95@gmail.com> w=
rote:
> >>
> >>> =D1=81=D1=80, 3 =D1=81=D1=96=D1=87. 2024=E2=80=AF=D1=80. =D0=BE 20:20=
 Arend Van Spriel <arend.vanspriel@broadcom.com>
> >>> =D0=BF=D0=B8=D1=88=D0=B5:
> >>>>
> >>>> On January 3, 2024 6:28:33 PM Svyatoslav Ryhel <clamor95@gmail.com> =
wrote:
> >>>>
> >>>>> 3 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024 =D1=80. 11:22:42 GMT+02:00, A=
rend Van Spriel
> >>>>> <arend.vanspriel@broadcom.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=B2(-=D0=BB=D0=B0):
> >>>>>> On January 3, 2024 10:14:42 AM Arend Van Spriel
> >>>>>> <arend.vanspriel@broadcom.com> wrote:
> >>>>>>
> >>>>>>> + linux-wireless
> >>>>>>> + Hans de Goede
> >>>>>>>
> >>>>>>>
> >>>>>>> On December 16, 2023 9:14:48 PM Svyatoslav Ryhel <clamor95@gmail.=
com> wrote:
> >>>>>>>
> >>>>>>>> =D1=81=D0=B1, 16 =D0=B3=D1=80=D1=83=D0=B4. 2023=E2=80=AF=D1=80. =
=D0=BE 21:57 Arend van Spriel
> >>>>>>>> <arend.vanspriel@broadcom.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >>>>>>>>>
> >>>>>>>>> On 12/16/2023 6:45 PM, Svyatoslav Ryhel wrote:
> >>>>>>>>>> Greetings!
> >>>>>>>>>>
> >>>>>>>>>> I am trying to submit bluetooth firmwares (BCM4329B1.*,*.hcd a=
nd
> >>>>>>>>>> BCM4330B1.*,*.hcd) and wifi calibration files
> >>>>>>>>>> (brcmfmac4329-sdio.*,*.txt and brcmfmac4329-sdio.*,*.txt) from=
 a few
> >>>>>>>>>> Tegra 2 and Tegra 3 based devices into linux-fimware.
> >>>>>>>>>>
> >>>>>>>>>> I have faced ambiguous license issue since those files were pa=
rt of
> >>>>>>>>>> Android Images of different vendors. Those vendors did not pro=
vide a
> >>>>>>>>>> license nor for android images, not for these files.
> >>>>>>
> >>>>>> Does this mean you extracted them from the android image? That pro=
bably
> >>>>>> never get accepted without any license information.
> >>>>>
> >>>>> Can Broadcom re-grant license to these files?
> >>>>>
> >>>>> This license is for bcm4329 in crespo
> >>>>> <https://android.googlesource.com/device/samsung/crespo/+/refs/head=
s/main/self-extractors/broadcom/LICENSE>
> >>>>
> >>>> Actually checked this link:
> >>>>
> >>>> https://android.googlesource.com/device/samsung/crespo/+/refs/heads/=
main/proprietary-blobs.txt
> >>>>
> >>>> It lists the bcm4329.hcd file as falling under Apache-2.0 license. S=
ame for
> >>>> asus/grouper.
> >>>>
> >>>> Regards,
> >>>> Arend
> >>>
> >>> So this actually resolves ambiguity. Thanks
> >>
> >> Yes, but ... you should add them to linux-firmware under the same lice=
nse.
> >> That means you need to mark them as such in the WHENCE file. Feel free=
 to
> >> cc: me for the patch so I can have a look at it.
> >>
> >> Regards,
> >> Arend
> >
> > Thank you for your assistance, it is really appreciated and valued but
> > it was rejected
> >
> > https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/114
> >
> > I have referred to our conversation.
>
> I see and it seems they were correct. My bad. Clearly should not try a
> career as lawyer.
>
> I can try to publish them to linux-firmware, but I have to ask internally=
.
>
> Regards,
> Arend
>

Thank you, looking forward to your answer. But keep in mind that
generic firmware for bluetooth might not be an option. I have tried to
shuffle them and bluetooth failed.

Best regards,
Svyatoslav R.

