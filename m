Return-Path: <linux-wireless+bounces-19477-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F1000A45A71
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 10:40:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E48B41640AC
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Feb 2025 09:40:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2EBD220CCEA;
	Wed, 26 Feb 2025 09:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ig8xaAZ8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A8DD1E1E18
	for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 09:40:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740562852; cv=none; b=aRx+eq9ZM0d4zHfKlNVfzcfVZNTy85M0I7JXf+hRJSBp+m9QvEZDE4pBhNO7RRsk7LizNP2eTuQXaS7cs2e9+S7WdQ0koz9FDjURTm1cmcC7Dl24RSj5crSNdAGwQ97PO4+vizWzzY32WRnnk4foHnAHUnugRFPhtvDASQpyQhg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740562852; c=relaxed/simple;
	bh=YUJJpJ5/aWlFMGux962pJCUa7AL5cIHhdQA6myu8mHE=;
	h=From:To:Cc:References:In-Reply-To:Subject:Date:Message-ID:
	 MIME-Version:Content-Type; b=V+ZTm+rObT5li5yQGRN6JryoSAqFHvJvuC6I6HHXemTej6773tfPO0lpV19eaysB20b3tNluiIsE8MBLs4Q0r6VOZMcCEtm6yNGCH6WxyiZ82esMz5J3LntNCi6CSOKh5OZUdJrtXA0zcQ5/Xsbmebi9wZ3NVZ6t0J4R06uGxkM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ig8xaAZ8; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-43989226283so44805865e9.1
        for <linux-wireless@vger.kernel.org>; Wed, 26 Feb 2025 01:40:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1740562848; x=1741167648; darn=vger.kernel.org;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Xlx2uT4DE3pUEcJGEI859f4n1olSxyWc3awOxYZ3fLI=;
        b=Ig8xaAZ8wyQoiqczaiS6bdrfH4xha5Td64EVhF25oM7mXjEDTRKf0eGkd6ZUsyhugF
         Xr20gR3H+ZhXerHyu42yJIATSl0fu333DFNP9mnGddb6KObMra0IZr5fjM8GQEApgk89
         uYQ+2uuR3CXyWeaB/aR4pI/k25jn0IXgbDGV1z0NwndaH/ojP2FRvPoP+oTaAhXaHCat
         z+N7j9Hv8xK6nAjE6OpRdj0foj8mWXLyo/XtgmEdtTQjaW3++jqPiW/SPLY35CsqbNRR
         SNNCmxY2mo8IBKob7j/SV7hGSpFcvK1V8pNxEhWQ03iE+ClklPe4m5wmGg4LVN38zhDs
         0zcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740562848; x=1741167648;
        h=content-language:thread-index:content-transfer-encoding
         :mime-version:message-id:date:subject:in-reply-to:references:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Xlx2uT4DE3pUEcJGEI859f4n1olSxyWc3awOxYZ3fLI=;
        b=Vci6R/3H+ghOVp6oTF82rfHxJtvtLF/tdVgQRSTYD+YgBszmeeity1ylzVWwvPzpR8
         ujd3I10C0zlgU6l77bYtgCRC3bnNrH4OQ4kOgUFdfgEZBP9hGufObsDVxR79KrPuTzMO
         Lr9cX5L3fA8oY5dfGrMzr52Tc5u3fAbeK3ZpP8rZzBiXcpZQOYnQgDksnVuU3bSV9jxR
         qn2hV2zn45n6CxBElHMPCe1gFRsPES1t6srsEip5No106SZliI6ppWW18FM7R4g+CRD3
         hPQWv/EWX9/g+i1ocvYyLF4Kt9OYMp5Ss/s98ifZvMIPFKHa5q1Prwm9STG28onDbe/T
         zrZg==
X-Gm-Message-State: AOJu0Yws8HpbGeykQbTvcMR57reh0OKdLDINTQkfZhAPlOrd20uAMoaK
	q/gs5EmC4P1NdjlQ25FoF/+qoeOBYW/uMSsIiugCD0WkTS+P/MrgNhoc
X-Gm-Gg: ASbGncv3yVC8rveAZ58ZxDKrEJvNByLI2Wiv4QQslSeqGZhM2JAMfVzddZktEXjqnwU
	OmcrLNagxmGTmi/64gEFKwUd4NULNMNoLxufCMJ8h1K9i4+G14EvVpg1txEjfyfWHmPzGHHnxeg
	nkwnzcQ2CxQZ4sQkdchKgC0GyfnPa7WaiPK0PultJGHDtEolCPTLN866CHXV3rFnFS2h+ZmfYCJ
	uzukfnCCEBQgVTwxERRi/uH+PM2e5BlDL8pVHr7NjfwSSTOBiCL8Fy5HBpekP4pYfYaa1VbeBqk
	AGLlv00MjM4+gZFEe0hPbxJAm1rpy7RGlWJnwWpYkenrVJQdlqTmLuASNjfsLH6hzzH1+Y3x12T
	4KzVarxKvM+2c
X-Google-Smtp-Source: AGHT+IFCRBFK66HToInMDDQ0ANVk7duqA1/AyY83wgfmnH6uV5aa0JKbAV76OMWZeyd/wn46035+fw==
X-Received: by 2002:a05:600c:458e:b0:439:91dd:cfa3 with SMTP id 5b1f17b1804b1-439ae221d72mr167483875e9.29.1740562848194;
        Wed, 26 Feb 2025 01:40:48 -0800 (PST)
Received: from winhome (cpc112753-pert6-2-0-cust678.16-4.cable.virginm.net. [86.18.22.167])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-43aba57145esm14718615e9.30.2025.02.26.01.40.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 26 Feb 2025 01:40:47 -0800 (PST)
From: <rmandrad@gmail.com>
To: <wens@kernel.org>
Cc: "'linux-wireless'" <linux-wireless@vger.kernel.org>,
	"'wireless-regdb'" <wireless-regdb@lists.infradead.org>
References: <000201db8822$98f28da0$cad7a8e0$@gmail.com> <CAGb2v65490c1m3W_1RkxJ-E7Q=3V_K8xqS2jmd6awcOdzWHXzQ@mail.gmail.com> <000901db882d$8cb13090$a61391b0$@gmail.com> <CAGb2v642utRqjhKth9he-jicA_E5RfYoXTPRyZaVykLNXQCXvg@mail.gmail.com>
In-Reply-To: <CAGb2v642utRqjhKth9he-jicA_E5RfYoXTPRyZaVykLNXQCXvg@mail.gmail.com>
Subject: RE: wireless-regdb: Allow 6ghz in the US
Date: Wed, 26 Feb 2025 09:40:47 -0000
Message-ID: <001e01db8832$844ef130$8cecd390$@gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Mailer: Microsoft Outlook 16.0
Thread-Index: AQMUrzCf8XdNoAU6+fu4ECJnDc0awgHIktuQAWl/dqQCwiE64rC3Ybxg
Content-Language: en-gb

wireless-regdb: Allow 6ghz in the US by removing NO-IR

The Federal Communications Commission on 05/26/2020 allowed for the use =
unlicensed use of the 6GHz band [1]. Currently the settings for US have =
non-IR. In order to comply with this legislation [1], the patch removes =
the NO-IR flag

The power limit is not increased from 12 dBm to 30 dBm to comply with =
the PSD requirements when using a 20 MHz channel

[1] =
https://www.federalregister.gov/documents/2020/05/26/2020-11236/unlicense=
d-use-of-the-6-ghz-band#p-66

Signed-off-by: Rudy Andram <rmandrad@gmail.com>

diff --git a/db.txt b/db.txt
index 803f1bc..ffcb0a6 100644
--- a/db.txt
+++ b/db.txt
@@ -1953,7 +1953,7 @@ country US: DFS-FCC
        (5850 - 5895 @ 40), (27), NO-OUTDOOR, AUTO-BW, NO-IR
        # 6g band
        # =
https://www.federalregister.gov/documents/2020/05/26/2020-11236/unlicense=
d-use-of-the-6ghz-band
-       (5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
+       (5925 - 7125 @ 320), (12), NO-OUTDOOR
        # 60g band
        # reference: section IV-D =
https://docs.fcc.gov/public/attachments/FCC-16-89A1.pdf
        # channels 1-6 EIRP=3D40dBm(43dBm peak)


-----Original Message-----
From: Chen-Yu Tsai <wens@kernel.org>=20
Sent: 26 February 2025 09:16
To: rmandrad@gmail.com
Cc: linux-wireless <linux-wireless@vger.kernel.org>; wireless-regdb =
<wireless-regdb@lists.infradead.org>
Subject: Re: wireless-regdb: Allow 6ghz in the US

(When replying, please reply to all)

On Wed, Feb 26, 2025 at 5:05=E2=80=AFPM <rmandrad@gmail.com> wrote:
>
> Thank you. Apologies this is the first time submitting a kernel patch. =

> The original submission set NO-IR where clearly the document notes it=20
> is allowed as section 59 states hence the patch - with increase usage=20
> of 6Ghz we have now Openwrt users complaining they can't the band in=20
> the US due to NO-IR
>
> Shall I update the patch to only remove NO-IR and increase power to 30 =
dBm ?

As explained, the limit is lowered from 30 dBm to 12 dBm to comply with =
the PSD requirements when using a 20 MHz channel. I suspect no one would =
use such a narrow band, but the requirements exist and the database rule =
should not be written in a way that allows the user to exceed the limit, =
i.e. using 30 dBm on a 20 MHz channel.

So please update the patch to only remove NO-IR. You can look at =
previous commits to see how we put URLs in the commit message.

Thanks
ChenYu

> Thank you again
>
> -----Original Message-----
> From: Chen-Yu Tsai <wens@kernel.org>
> Sent: 26 February 2025 08:58
> To: rmandrad@gmail.com
> Cc: linux-wireless@vger.kernel.org;=20
> wireless-regdb@lists.infradead.org; Dennis Bland=20
> <dennis@dbperformance.com>; Ping-Ke Shih <pkshih@realtek.com>
> Subject: Re: wireless-regdb: Allow 6ghz in the US
>
> CC-ing Dennis, the original submitter, and also Ping-Ke, who has done =
a lot of 6 GHz updates, for more information.
>
> On Wed, Feb 26, 2025 at 4:03=E2=80=AFPM <rmandrad@gmail.com> wrote:
> >
> > Allow 6ghz in the US
> >
> > https://www.federalregister.gov/documents/2020/05/26/2020-11236/unli
> > ce nsed-u se-of-the-6-ghz-band allows the use of 6ghz in the US=20
> > namely section
> > 59 https://www.federalregister.gov/d/2020-11236/p-66 with absolute=20
> > radiated power of 30 dBm for the 320 megahertz channel
>
> Please don't wrap URLs.
>
> Please see the original submission [1], which explains why the power =
limit is so low. Basically, neither the database nor the kernel supports =
specifying power spectral density limits, so we can only take the =
narrowest bandwidth to calculate the applicable power limit.
>
> [1]=20
> https://lore.kernel.org/wireless-regdb/CAPRryQp6j4UKvLZCkMAuQdaxepMBET
> QUJ1eNULJSh3ZWXC0f5Q@mail.gmail.com/
>
> > based on this remove NO-IR flag and allow 30 dBm max power
>
> The original submission mentioned NO-IR requirements, though I did not =
find such wording. Dennis, do you have any ideas?
>
> > Signed-off-by: Rudy Andram <rmandrad@gmail.com>
> >
> > diff --git a/db.txt b/db.txt
> > index 803f1bc..bc2b4fe 100644
> > --- a/db.txt
> > +++ b/db.txt
> > @@ -1953,7 +1953,8 @@ country US: DFS-FCC
> >         (5850 - 5895 @ 40), (27), NO-OUTDOOR, AUTO-BW, NO-IR
> >         # 6g band
> >         #
> > https://www.federalregister.gov/documents/2020/05/26/2020-11236/unli
> > ce
> > nsed-u
> > se-of-the-6ghz-band
> > -       (5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
> > +       (5925 - 6425 @ 320), (30), NO-OUTDOOR
> > +       (6525 - 6875 @ 320), (30), NO-OUTDOOR
>
> The database entry targets LPI usage instead of standard usage, which =
requires the presence of AFC, which is also a requirement that the =
database is unable to represent. And under LPI usage, the full 6GHz band =
(U-NII-5, 6, 7) is available.
>
>
> Thanks
> ChenYu
>
> >         # 60g band
> >         # reference: section IV-D
> > https://docs.fcc.gov/public/attachments/FCC-16-89A1.pdf
> >         # channels 1-6 EIRP=3D40dBm(43dBm peak)
> >
> >
> >
>


