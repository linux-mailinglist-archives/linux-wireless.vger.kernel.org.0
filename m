Return-Path: <linux-wireless+bounces-1475-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1BA9D823E4A
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 10:10:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A3C911F24E98
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 09:10:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 21A7920303;
	Thu,  4 Jan 2024 09:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XsaPiFhM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8568D2033C
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jan 2024 09:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-33723ad790cso223052f8f.1
        for <linux-wireless@vger.kernel.org>; Thu, 04 Jan 2024 01:08:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704359284; x=1704964084; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Vu69+F4VLRlaBCdU/TQtcQNi2BkTn42ySbPdCve9vZE=;
        b=XsaPiFhM34qdKAqUZqPvyFrZUAjCPklhN9CqZ9sRhDLIN/UXoLL32+cPqpdz5X26aw
         /ZoysWRypTdVSxhNrtO+5NnwlmU2HM+usuZ1fdJZJUc+jUHc704gjitbRpwG+6zZ5vp7
         8o5FvH5r+ZLZ83vXNYugZ1hdEWntrfm3isFOYExmLwhkBEmcWbsHbTMnzzOntaWwE0Mi
         8jzT+R3uIL284h+TTJWP8GYxbRdDQyiwh4KAUd32UfEQ7v+OiQwljb9fc8YvcIwXVdf0
         kYTpXC9i1vFsJN0bSV+l9ITaoQNRnH3SWpjAlH6PYq36X4oaZQn6pbvnB0zNJ0K9p6LC
         iF6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704359284; x=1704964084;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Vu69+F4VLRlaBCdU/TQtcQNi2BkTn42ySbPdCve9vZE=;
        b=AjVzsTMSVNkuS0b3qmYHka+FOiCQzmAltgiOyAQ3EX/WCGr2QQE8usWZnBw/VNkN8/
         329chLvtuJAjH+rDTWQDCgS9YqnxV3c4kw2cwjMHpSpA1zEy3pJG/KqDCQQ1vtuoVt4q
         OmNV+fcRscq9VY8aZeyGCyacXFyd4marFksWTkYbrdWVR7wwptCzjFOdYEAMUqcpqSFQ
         mN3j2X7Rh3I1B3KGq0dNgrjm9g4sqyUHhjxfe3jkZ5EVZ/u+Y1SPE4U2gwBIX8yvtUks
         qKqx9TJAFKW3U2tw/C6pwZ5UIMsWLWV2N0BL0Mp+ci1g3wJI00XW6MxMDY/ht3Xd8IU+
         3L/g==
X-Gm-Message-State: AOJu0YwG8T1bJJF4HU3ghANgV/xcxzT6XkfoMXoxnNo7nVz4BV3SryDx
	/sGs+yt9JnXhuGikL5GYcrDZPuoWj1I5W8RCLQ0=
X-Google-Smtp-Source: AGHT+IFnLkTxcruD7Hp1LV4wDr6+30vNm48XHdgQUg4VzXCoYkEGYb5bRjLqoDMIRwbBgeRfzf13lL8tY47F3kq0esI=
X-Received: by 2002:adf:e601:0:b0:336:4308:28df with SMTP id
 p1-20020adfe601000000b00336430828dfmr120570wrm.204.1704359283391; Thu, 04 Jan
 2024 01:08:03 -0800 (PST)
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
In-Reply-To: <18cd08e83d0.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Thu, 4 Jan 2024 11:07:52 +0200
Message-ID: <CAPVz0n347PVv28H2wswmO3N63dpfPZ0d3VrdxmQHXMoo9LS69g@mail.gmail.com>
Subject: Re: License of old broadcom BT firmwares and WiFi calibration files
To: Arend Van Spriel <arend.vanspriel@broadcom.com>, linux-wireless@vger.kernel.org, 
	linux-firmware@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D1=81=D1=80, 3 =D1=81=D1=96=D1=87. 2024=E2=80=AF=D1=80. =D0=BE 20:20 Arend=
 Van Spriel <arend.vanspriel@broadcom.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On January 3, 2024 6:28:33 PM Svyatoslav Ryhel <clamor95@gmail.com> wrote=
:
>
> > 3 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024 =D1=80. 11:22:42 GMT+02:00, Arend=
 Van Spriel
> > <arend.vanspriel@broadcom.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=D0=
=B2(-=D0=BB=D0=B0):
> >> On January 3, 2024 10:14:42 AM Arend Van Spriel
> >> <arend.vanspriel@broadcom.com> wrote:
> >>
> >>> + linux-wireless
> >>> + Hans de Goede
> >>>
> >>>
> >>> On December 16, 2023 9:14:48 PM Svyatoslav Ryhel <clamor95@gmail.com>=
 wrote:
> >>>
> >>>> =D1=81=D0=B1, 16 =D0=B3=D1=80=D1=83=D0=B4. 2023=E2=80=AF=D1=80. =D0=
=BE 21:57 Arend van Spriel
> >>>> <arend.vanspriel@broadcom.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >>>>>
> >>>>> On 12/16/2023 6:45 PM, Svyatoslav Ryhel wrote:
> >>>>>> Greetings!
> >>>>>>
> >>>>>> I am trying to submit bluetooth firmwares (BCM4329B1.*,*.hcd and
> >>>>>> BCM4330B1.*,*.hcd) and wifi calibration files
> >>>>>> (brcmfmac4329-sdio.*,*.txt and brcmfmac4329-sdio.*,*.txt) from a f=
ew
> >>>>>> Tegra 2 and Tegra 3 based devices into linux-fimware.
> >>>>>>
> >>>>>> I have faced ambiguous license issue since those files were part o=
f
> >>>>>> Android Images of different vendors. Those vendors did not provide=
 a
> >>>>>> license nor for android images, not for these files.
> >>
> >> Does this mean you extracted them from the android image? That probabl=
y
> >> never get accepted without any license information.
> >
> > Can Broadcom re-grant license to these files?
> >
> > This license is for bcm4329 in crespo
> > <https://android.googlesource.com/device/samsung/crespo/+/refs/heads/ma=
in/self-extractors/broadcom/LICENSE>
>
> Actually checked this link:
>
> https://android.googlesource.com/device/samsung/crespo/+/refs/heads/main/=
proprietary-blobs.txt
>
> It lists the bcm4329.hcd file as falling under Apache-2.0 license. Same f=
or
> asus/grouper.
>
> Regards,
> Arend

So this actually resolves ambiguity. Thanks

Best regards,
Svyatoslav R.

