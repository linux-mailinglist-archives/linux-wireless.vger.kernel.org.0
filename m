Return-Path: <linux-wireless+bounces-1593-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 424F98275B8
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 17:48:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 688AA1C219B1
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jan 2024 16:48:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 315B754664;
	Mon,  8 Jan 2024 16:48:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DnoJq9Xw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9647954661
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jan 2024 16:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3373bc6d625so2011604f8f.3
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jan 2024 08:48:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1704732517; x=1705337317; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TDbtiLbA1iRT2Xe0QDhUmpbL4hjpDHQ12hK+fzVUvx8=;
        b=DnoJq9XwZd1/dy3nSj9XrFNHvs0+Prhk7DZ/HSugJOZ7MezMBbvXvBEapC9XIaYr4V
         +EGb5gkL4vKu+jIOB/O792xDpbfvbigvPKhD+2EuFQUPumv3m79PFTPdotnL85MbtFs+
         iFnF53NvAAhEU91+WDW46nLkCgV3vm18JWYG2/QNNKAdkU2B//gp8CSpqHdOwl53ueLv
         xvw2IpLhojA42/8rYSm5g2PF4srh1g/7W6eQYdpgc1KGgJcpTzk0rWo0CwY+9WO2TnG4
         LOuFz7KuVNFnKZWX0z3ijH0jpAWMfsCC+3rVmNKLORzA8TPPBys/T+RQmYCrq1zBJTlf
         IEdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704732517; x=1705337317;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TDbtiLbA1iRT2Xe0QDhUmpbL4hjpDHQ12hK+fzVUvx8=;
        b=h/gcMxRFxh/Me5xaEEiSizlfa1QgxgWQ8Fn1Qnq8N0JWmop65PkIUHwL0P/6Ctd3m1
         R7ER2UeSgKyXAjL3zxR3/ziBOHdeQNTtWnQZ4inQCH7oQboOp5FncbB9e0HxTgluNEoe
         BBqnw+VwN78pbbbImJ/Wtcpe07FX0eM3jcmtwqUr/Pwll6WDwVCIzEaf5YhS8JuML6zo
         IPTP1uFfFUKimpa5RisIkTIHrfxoXV/ckK494q1+kkFb9DTJwXgL5kD2UnQgZ083KboO
         MjPYm9cHbm+zUE3MP3QQ0aONqEPxG/IIT3IsPYuBrbPVNbMP5df87mvguFgycmsr8SpU
         tn1w==
X-Gm-Message-State: AOJu0YyGmO2eYRj43NG0al82Ei2T98Cfdb3W3/wOlMFo4blHX06rlvJr
	kSGl80w59WO72ufxVPX/yXVos31pCQDRhooEH50T+QYgYQw1tyyX
X-Google-Smtp-Source: AGHT+IG/wdGcIK9K0Z2aUS74RQ+7EAINO4ZCISdXTiC4gH6o5gnkLilU2B6Gdf9NRsWD5A/eb/o3uI3mAe38nV8suJc=
X-Received: by 2002:a5d:440e:0:b0:337:3efd:37a2 with SMTP id
 z14-20020a5d440e000000b003373efd37a2mr2210153wrq.111.1704732516589; Mon, 08
 Jan 2024 08:48:36 -0800 (PST)
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
 <CAPVz0n347PVv28H2wswmO3N63dpfPZ0d3VrdxmQHXMoo9LS69g@mail.gmail.com> <18ce9be5470.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
In-Reply-To: <18ce9be5470.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: Svyatoslav Ryhel <clamor95@gmail.com>
Date: Mon, 8 Jan 2024 18:48:25 +0200
Message-ID: <CAPVz0n3BxJjaudDnC=QLHa-0NsE9JSs1ezFpwK2yb=9ySyr2cw@mail.gmail.com>
Subject: Re: License of old broadcom BT firmwares and WiFi calibration files
To: Arend Van Spriel <arend.vanspriel@broadcom.com>
Cc: linux-wireless@vger.kernel.org, linux-firmware@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

=D0=BF=D0=BD, 8 =D1=81=D1=96=D1=87. 2024=E2=80=AF=D1=80. =D0=BE 17:43 Arend=
 Van Spriel <arend.vanspriel@broadcom.com> =D0=BF=D0=B8=D1=88=D0=B5:
>
> On January 4, 2024 10:08:04 AM Svyatoslav Ryhel <clamor95@gmail.com> wrot=
e:
>
> > =D1=81=D1=80, 3 =D1=81=D1=96=D1=87. 2024=E2=80=AF=D1=80. =D0=BE 20:20 A=
rend Van Spriel <arend.vanspriel@broadcom.com>
> > =D0=BF=D0=B8=D1=88=D0=B5:
> >>
> >> On January 3, 2024 6:28:33 PM Svyatoslav Ryhel <clamor95@gmail.com> wr=
ote:
> >>
> >>> 3 =D1=81=D1=96=D1=87=D0=BD=D1=8F 2024 =D1=80. 11:22:42 GMT+02:00, Are=
nd Van Spriel
> >>> <arend.vanspriel@broadcom.com> =D0=BD=D0=B0=D0=BF=D0=B8=D1=81=D0=B0=
=D0=B2(-=D0=BB=D0=B0):
> >>>> On January 3, 2024 10:14:42 AM Arend Van Spriel
> >>>> <arend.vanspriel@broadcom.com> wrote:
> >>>>
> >>>>> + linux-wireless
> >>>>> + Hans de Goede
> >>>>>
> >>>>>
> >>>>> On December 16, 2023 9:14:48 PM Svyatoslav Ryhel <clamor95@gmail.co=
m> wrote:
> >>>>>
> >>>>>> =D1=81=D0=B1, 16 =D0=B3=D1=80=D1=83=D0=B4. 2023=E2=80=AF=D1=80. =
=D0=BE 21:57 Arend van Spriel
> >>>>>> <arend.vanspriel@broadcom.com> =D0=BF=D0=B8=D1=88=D0=B5:
> >>>>>>>
> >>>>>>> On 12/16/2023 6:45 PM, Svyatoslav Ryhel wrote:
> >>>>>>>> Greetings!
> >>>>>>>>
> >>>>>>>> I am trying to submit bluetooth firmwares (BCM4329B1.*,*.hcd and
> >>>>>>>> BCM4330B1.*,*.hcd) and wifi calibration files
> >>>>>>>> (brcmfmac4329-sdio.*,*.txt and brcmfmac4329-sdio.*,*.txt) from a=
 few
> >>>>>>>> Tegra 2 and Tegra 3 based devices into linux-fimware.
> >>>>>>>>
> >>>>>>>> I have faced ambiguous license issue since those files were part=
 of
> >>>>>>>> Android Images of different vendors. Those vendors did not provi=
de a
> >>>>>>>> license nor for android images, not for these files.
> >>>>
> >>>> Does this mean you extracted them from the android image? That proba=
bly
> >>>> never get accepted without any license information.
> >>>
> >>> Can Broadcom re-grant license to these files?
> >>>
> >>> This license is for bcm4329 in crespo
> >>> <https://android.googlesource.com/device/samsung/crespo/+/refs/heads/=
main/self-extractors/broadcom/LICENSE>
> >>
> >> Actually checked this link:
> >>
> >> https://android.googlesource.com/device/samsung/crespo/+/refs/heads/ma=
in/proprietary-blobs.txt
> >>
> >> It lists the bcm4329.hcd file as falling under Apache-2.0 license. Sam=
e for
> >> asus/grouper.
> >>
> >> Regards,
> >> Arend
> >
> > So this actually resolves ambiguity. Thanks
>
> Yes, but ... you should add them to linux-firmware under the same license=
.
> That means you need to mark them as such in the WHENCE file. Feel free to
> cc: me for the patch so I can have a look at it.
>
> Regards,
> Arend

Thank you for your assistance, it is really appreciated and valued but
it was rejected

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/114

I have referred to our conversation.

