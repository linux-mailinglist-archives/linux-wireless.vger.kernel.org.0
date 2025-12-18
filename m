Return-Path: <linux-wireless+bounces-29896-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 421C8CCAC61
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 09:06:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id BD554306291D
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 08:04:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D34CD2EC558;
	Thu, 18 Dec 2025 08:04:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guQfAe+x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADB392E8B66
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 08:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766045088; cv=none; b=Gcg+IGBJiWDUCp3HAoU1VbQqyxEL8UHP9cB/uG7hqHsP9Ceisv2LtUHZmAtfoIDbM43/XM5xTkDigBHd4zcVui/0GuRtE1faf/0e50gqe4STvi/A20R1b6/f78YGkJHdaOFYGlRWkLYhVRGvYGNXLVIkww7B6E7dC7J9JXjuD9Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766045088; c=relaxed/simple;
	bh=EUWA9vBS/8Bj7ML6MIoqvCIK0kHU15G6PnmKBfCoYhk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a6Tsl6JqhQa+oYN+O5qKu46PehCEKG1XuqBaQ6Nu1Aj65ckdSR8q3yVgcM+wf0xcSGuTqfq6KUE9fPWxlKJLHzQeFunENXdw8go6/GU5rtoUOV+N8o48aV3ce76DOjHHF7D3/rujz4qtMisTxh/jlhT775vk/8lgAdQFwlal6MU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guQfAe+x; arc=none smtp.client-ip=209.85.222.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qk1-f179.google.com with SMTP id af79cd13be357-8b21fc25ae1so38021885a.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 00:04:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766045085; x=1766649885; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZFatZ2cHC57MPqYi+kElcilUE7e6ABilLQQM4w6mW4c=;
        b=guQfAe+xdwIYVfnbl2P7NeYl3RvgnZekq458I5TSmauxRj5I+LyEX55C/jdUJ5oWam
         G+MVsWqfq0pBytYwhNN4JP8C2wcMHedfZWuzrxrbbXaM79o/8XK/aFCpk1F9Sag+iOpx
         PYlgzDONeJ4y6ME8qfcl1lln+VevTT+bBe7w+Ei/WAEa36ZrRpSeLJHmeyACAbs2jVJi
         fcnTiLyxZ3k3cC4/pdjhHooxB4S+ZXHre+u8oqtXlWB3JmT4S/mzgP6W2Ra4BIP0b8C/
         pKfiqvsfsBRJ+6BleZ4f4WwL4spYglq9PqfOWqiv08YFkh2sMKdGz+p3jCNSyDKqV7HF
         7zkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766045085; x=1766649885;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ZFatZ2cHC57MPqYi+kElcilUE7e6ABilLQQM4w6mW4c=;
        b=Rji54u1F4O8DS5kUiTRZl+Jt+DLAKnTNclDWaNGB3sp2czDnlTqkmYc7Co3oto12Y/
         7syq1Gr+7Yy10BIUTG7qn8NDLi8Hu7OjFdXLnoFjULHy2bCdfh14pp3J7W+TQmaTH0iU
         n5/dGAipzmvzs7ScnFrXVXUSiXnRcXg4NwWQto0jdeIC2BpM9c/0N59Zu1uzeIEFo9LV
         UkfE/S3pttG6USZkapIV1DfwB4E9zi4iYpO4Zl+OeKNhY6C1E5j0lyb3rfIY2If+XclP
         8nq2PUX6XDmomHbuwyqJCUGNlq679QMeYQHxi0LGKhNC4fmbRx23b3Zj4892GjexmEgb
         Xycg==
X-Forwarded-Encrypted: i=1; AJvYcCWUl/1Qwq2le/KbSSPvmxOeOKmYkWaAtibk6+cfuosUp1jp9M0KY/E4rmoqs/BV58kM1YPQg6321wV/7vZuSA==@vger.kernel.org
X-Gm-Message-State: AOJu0YxuRSNhjJbm7iNzcYvfdYEDXlLPLB8PnAU2Hf0RDhrWr47D5mbw
	BuyWamGD59Kn3oRKqEj+hOxp3ThsmlIwZq5e4aBHhEmlkOoUMJ/gBa/JzxLoWRdTWPIPdWqTRRK
	Qhrh0cqROnDSFdqF8iK1ZBAv7ShbGVg==
X-Gm-Gg: AY/fxX5k/E229rbFVlrKGOg88VFdykmlIzb/tki1OjMXq3LlS+x3ac8nBae78Ir7xgy
	kV2g3BZMB1OJgvIwCTwBAcGkN+Y4WSYQjZpcUcWLBlk0SVH+/f3wL2SdUV2XqemFjgtmjcsK0fr
	P9IuUpWsK5nmYguc3LprVKcQlIQgc8jQeuSSzcV63FyhZEQBNBOdMVZbHxHX0nlszNqc0222cwV
	7VEZl4kBuMk1vPcFWkpl6/40Xr/nXTo0YbxRbvw2Z+F24g0RrNwLNj7I8LC4g+uXSgLWwHf++66
	my0NP2BJ+BtXfvsCjEdR9afM/x+8eSur
X-Google-Smtp-Source: AGHT+IGeR69NlMrzzWAKf9Swns5oCRSmbi6pAM+ySzcMfeKthzzgVomUQBx8U3ObrUEQapivifkUsz3RXTHr8lctfyo=
X-Received: by 2002:a05:620a:460a:b0:8b2:e179:feb7 with SMTP id
 af79cd13be357-8bb3a36d2c1mr2973617185a.49.1766045085533; Thu, 18 Dec 2025
 00:04:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218-surface-sp11-for-next-v3-0-875afc7bd3b7@gmail.com>
 <20251218-surface-sp11-for-next-v3-4-875afc7bd3b7@gmail.com> <s45ki2ckgw7fu25h5wd6mb3mc4kzs6qq5eitv56asqf2suxh6l@s5tbqce7gz3f>
In-Reply-To: <s45ki2ckgw7fu25h5wd6mb3mc4kzs6qq5eitv56asqf2suxh6l@s5tbqce7gz3f>
From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>
Date: Thu, 18 Dec 2025 09:04:09 +0100
X-Gm-Features: AQt7F2rxXLkRo1KdQwBVcMP3Fy3-pCbHAovHIvjCqXVawC_ZHWulzabv7lnj8zk
Message-ID: <CA+kEDGFTh5bG98dtok66A+hC+-QcfSubdr64M7+JZ0nLeqm_tw@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] platform/surface: aggregator_registry: Add Surface
 Pro 11
To: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	ath12k@lists.infradead.org, Dale Whinham <daleyo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 18 d=C3=A9c. 2025 =C3=A0 01:07, Dmitry Baryshkov
<dmitry.baryshkov@oss.qualcomm.com> a =C3=A9crit :
>
> On Thu, Dec 18, 2025 at 12:56:40AM +0100, J=C3=A9r=C3=B4me de Bretagne vi=
a B4 Relay wrote:
> > From: Dale Whinham <daleyo@gmail.com>
> >
> > This enables support for the X1-based Surface Pro 11.
> >
> > Signed-off-by: Dale Whinham <daleyo@gmail.com>
> > Signed-off-by: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.co=
m>
> > Reviewed-by: Maximilian Luz <luzmaximilian@gmail.com>
> > ---
> >  drivers/platform/surface/surface_aggregator_registry.c | 18 ++++++++++=
++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/drivers/platform/surface/surface_aggregator_registry.c b/d=
rivers/platform/surface/surface_aggregator_registry.c
> > index 78ac3a8fbb736384f7e50f1888a71297a892a7c3..c18d991afc8b0a0bbb26966=
351b75b8ea01097a4 100644
> > --- a/drivers/platform/surface/surface_aggregator_registry.c
> > +++ b/drivers/platform/surface/surface_aggregator_registry.c
> > @@ -406,6 +406,22 @@ static const struct software_node *ssam_node_group=
_sp9_5g[] =3D {
> >       NULL,
> >  };
> >
> > +/* Devices for Surface Pro 11 (ARM/QCOM) */
> > +static const struct software_node *ssam_node_group_sp11[] =3D {
> > +     &ssam_node_root,
> > +     &ssam_node_hub_kip,
> > +     &ssam_node_bat_ac,
> > +     &ssam_node_bat_main,
> > +     &ssam_node_tmp_sensors,
> > +     &ssam_node_hid_kip_keyboard,
> > +     &ssam_node_hid_kip_penstash,
> > +     &ssam_node_hid_kip_touchpad,
> > +     &ssam_node_hid_kip_fwupd,
> > +     &ssam_node_hid_sam_sensors,
> > +     &ssam_node_kip_tablet_switch,
> > +     NULL,
> > +};
> > +
> >  /* -- SSAM platform/meta-hub driver. ---------------------------------=
------- */
> >
> >  static const struct acpi_device_id ssam_platform_hub_acpi_match[] =3D =
{
> > @@ -485,6 +501,8 @@ static const struct of_device_id ssam_platform_hub_=
of_match[] __maybe_unused =3D {
> >       /* Surface Laptop 7 */
> >       { .compatible =3D "microsoft,romulus13", (void *)ssam_node_group_=
sl7 },
> >       { .compatible =3D "microsoft,romulus15", (void *)ssam_node_group_=
sl7 },
> > +     /* Surface Pro 11 */
> > +     { .compatible =3D "microsoft,denali", (void *)ssam_node_group_sp1=
1 },
>
> Please keep it sorted. arcata < denali < romulus

Thank you, I will fix this in v4.


> >       { },
> >  };
> >
> >
> > --
> > 2.47.3
> >
> >
>
> --
> With best wishes
> Dmitry

