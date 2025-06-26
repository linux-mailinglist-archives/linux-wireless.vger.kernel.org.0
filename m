Return-Path: <linux-wireless+bounces-24538-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1C8C9AE9AC5
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 12:07:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 225F84E023C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 10:06:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A04E221CC44;
	Thu, 26 Jun 2025 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DnVHWrrW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C15621C16B
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 10:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750932330; cv=none; b=Tp0gsKYRlOoUg+epqD+HWT8mMTHzYC+OwEypC0DKgUHNAL+fa5moQjNASYol1rKeIgyoRpt5hy+C/H9sRvptP/4U5c4mzUARIJjyFlW8YMWPyU+8tlS3Raz06J9IXRRZpkntsnJYX5oJ2u9bWzGBn4OiRb3NhbGyO5KZO4X/1HE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750932330; c=relaxed/simple;
	bh=CjgXRCU/Rbibmkvl1yLMk7fKpvVXpjtAqlFLkimKgJk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BXNgWMGWINaQjlvPntDjXZKhHsllCSQyUssfJaCy4EhbN16KNMyrjlQjrfjTxM9VnGA2hlx06xVxBYEzEV+h6mFJM5OrxsuaqH4nQWWHd76Ac5kAJlbzR5bQT978wo493dRJilRMwt/gxVQDesoi0mqW33lITU7nRviLd9yeAr4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DnVHWrrW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3AC2C4CEEB
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 10:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750932329;
	bh=CjgXRCU/Rbibmkvl1yLMk7fKpvVXpjtAqlFLkimKgJk=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=DnVHWrrWNWSmkzXM5d+40wRAkk7S2whfv2NvdZpZsMCI+nV2VS9wlgMkMwXOfLmmB
	 t4Lbq88c0j/A/e14+1DClEmatI5H4/h6CuUC6ExsoT5eUI0ou7L6qlfb+autbl9hmV
	 rtNO+c4u8+HaeZurh3KvDDNorqR9dWhMEEKx0eU8bMRysNobivy6t+T2PHy+Z2UGYp
	 EHVBtrRSA1MHPdCXiqqH+jYuG0VgHcicY6Uqi8LS3y8q64W6achxy9eE2vtZo1J3fG
	 UdQDjTFC/nvvptM0fas71bVhZNP8iBMtYBkapaWtbMSJ8NvD8RQi1Mp7QSC88iQ3lj
	 CPtsObdOdXBTA==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-32addf54a01so8261271fa.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 03:05:29 -0700 (PDT)
X-Gm-Message-State: AOJu0YwXB+WbRoWxrfBniqPfSzfhzZv5YiiL//kbTWEh8Movn1l2Ro9J
	UPoz2GoClXBlp4fad+wKNPTu0WlEO/5j4fFFzX8wj+laoLOy7nKYxsDzg0qNCZhrSNQ9BwhPRv7
	z1ON4jaYBi5TbPz9TfpPsCq4wzJCWLkc=
X-Google-Smtp-Source: AGHT+IGX4/27FaRhdes53FjY7kdtzZpy9CsFIpmXv5clQ1XBXWCcFIeBdmroWYKFvZgSoROE7fUJNwdwtm9Bu3eYkxo=
X-Received: by 2002:a05:651c:40d5:b0:32b:2fba:8b90 with SMTP id
 38308e7fff4ca-32ccf9cd24fmr7116291fa.14.1750932328302; Thu, 26 Jun 2025
 03:05:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <8bc290d6-5687-495d-b5d5-a8ca94cf2f7a@gmail.com>
 <CAGb2v64z3Yv_MNxJDTMcDR5ajD_L0zpsea2aBcrCLKfw3HUmiQ@mail.gmail.com>
 <ee7a2587-3e4c-4bb2-8eeb-961dbbb9ca97@gmail.com> <CAGb2v640p2zfD9T6PnmfOwJY8nMeSyY5CJNhtdW9B-+ZPNSW4Q@mail.gmail.com>
 <46ab2a6b-82ff-4330-819e-99a67280409a@gmail.com>
In-Reply-To: <46ab2a6b-82ff-4330-819e-99a67280409a@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 26 Jun 2025 18:05:15 +0800
X-Gmail-Original-Message-ID: <CAGb2v65BO=EV+HxwOV7it94q2wNQA5_8AtjuHkLdV_2R33T_NA@mail.gmail.com>
X-Gm-Features: Ac12FXx5qpGD_MGqFhkkid2RjLUjLex2hJPAgrBldzv1enpypMcT_D72Yyt-yVo
Message-ID: <CAGb2v65BO=EV+HxwOV7it94q2wNQA5_8AtjuHkLdV_2R33T_NA@mail.gmail.com>
Subject: Re: wireless-regdb: Update regulatory rules for Brazil (BR) on 6GHz
To: Marcos Alano <marcoshalano@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 5:56=E2=80=AFPM Marcos Alano <marcoshalano@gmail.co=
m> wrote:
>
>
>
> On 26/06/2025 06:23, Chen-Yu Tsai wrote:
> > Hi,
> >
> > On Thu, Jun 26, 2025 at 4:37=E2=80=AFPM Marcos Alano <marcoshalano@gmai=
l.com> wrote:
> >>
> >> On 26/06/2025 05:15, Chen-Yu Tsai wrote:
> >>> On Mon, Jun 2, 2025 at 9:23=E2=80=AFAM Marcos Alano <marcoshalano@gma=
il.com> wrote:
> >>>>
> >>>> Hi,
> >>>>
> >>>> The rules for Brazil were based on this normative
> >>>> https://informacoes.anatel.gov.br/legislacao/resolucoes/2017/936-res=
olucao-680,
> >>>> as mentioned in the comments of the entry.
> >>>>
> >>>> This January came out a newer normative
> >>>> https://informacoes.anatel.gov.br/legislacao/resolucoes/2025/2001-re=
solucao-772,
> >>>>
> >>>> It allows 6GHz frequencies, so the line:
> >>>> (5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
> >>>> Should change for, at least:
> >>>> (5925 - 7125 @ 320), (12), NO-OUTDOOR
> >>>> The removal of NO-IR is important, since routers Wi-Fi 6E and 7 don'=
t
> >>>> work because of this outdated rule based on an outdated normative.
> >>>
> >>> Those are very large documents. Could you help point out which sectio=
ns
> >>> or comments apply to your argument?
> >>
> >> https://informacoes.anatel.gov.br/legislacao/atos-de-requisitos-tecnic=
os-de-gestao-do-espectro/2024/1920-ato-915:
> >> in the items IX.4 and IX.5 mentions the 6GHz frequency.
> >
> > This only covers point-to-point usage. You would need to modify the rul=
es
> > and add the PTP flag. Likely not what you actually want.
> >
> >> https://informacoes.anatel.gov.br/legislacao/resolucoes/2025/2001-reso=
lucao-772:
> >> You can search for "5925-6700" to check how the allocation is done.
> >> It mentions satellites, so that's why I set indoors, but maybe you
> >> understand that is not necessary.
> >
> > This only gives the band allocation, not the requirements for each use.
> > Also, satellite communication is a different use category. We should lo=
ok
> > for WiFi or RLAN, or perhaps "comunica=C3=A7=C3=A3o multim=C3=ADdia".
> >
> > The requirements I were able to find are:
> >
> > https://informacoes.anatel.gov.br/legislacao/atos-de-certificacao-de-pr=
odutos/2021/1510-ato-1306
> >
> > ChenYu
>
> I created a v3 patch that updates the comments with the new normative
> you found, removes the NO-IR so a AP can work correctly, and changed the
> maximum power from 12 to 27, since for APs it seems to mention 30dBm,
> but I considered TPC like the other frequencies.

You failed to consider the power spectral density requirement. As I
mentioned in a previous reply, the requirement for clients is -1 dBm/MHz,
which at the smallest channel width, translates to a power limit of around
12 dBm. The original value is correct.

The database in its current form simply does not have the capability to
model things like PSD or AP vs client device specificity.

If the regulations require NO-IR for clients, then we cannot remove it
just so that APs can work. See [1] for the same discussion for US 6 GHz.

Sorry.

ChenYu

[1] https://lore.kernel.org/wireless-regdb/14ab2a58e7603047354a17b2c980c143=
992a6782.camel@sipsolutions.net/

> >
> >> Marcos.
> >>
> >>
> >>>
> >>> Thanks
> >>> ChenYu
> >>>
> >>>> I'm no lawyer, so please if you see something different, like more
> >>>> granular control in the allowed frequencies, please let us know.
> >>>>
> >>>> Thanks,
> >>>> --
> >>>> Marcos Alano
> >>>>
> >>>>
> >>
> >> --
> >> Marcos Alano
> >>
>
> --
> Marcos Alano
>

