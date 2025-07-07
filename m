Return-Path: <linux-wireless+bounces-24868-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 63D46AFAA90
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 06:22:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B3D5B3B80FC
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 04:22:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EA45F256C6C;
	Mon,  7 Jul 2025 04:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LZmKJXcK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4B1D17D7
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 04:22:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751862146; cv=none; b=HXiJSMq62GxLCqNUmE/vMFvLMG29Qb/zWmyx9MC5dqNd1QurrhyQC+aurb/+lfqeDX74Vqnb2qqImsGWAKNO4B6jm9SUJbtp6XpFZ3BKL056MWIkO3TuQJddwxeQgb6qo0FJD6demXTS4+nrTYOT72B8oe5A/WCcferV3adHugc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751862146; c=relaxed/simple;
	bh=5+93ssUC6VKJl35DtySJ/SkhoGSoUVTaXmFY1tVnaDo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H6XgtHeKH+Kq7Mx8iGO1CsoFywuVZrwkWhJEbWz2BwA9ArXz76AAIX1UCB9Q59KVXbsLfD0SsnNWG+ztIbaNnZcbv7aWPF7P1eGTNR3/OTBfNZJxsaNvvyJESqaQcz9+1h3EnbLb+DWFfy3/dqtRLo1ceSqv3AEQLZ43ON0wTYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LZmKJXcK; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CDFAC4CEEE
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 04:22:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751862146;
	bh=5+93ssUC6VKJl35DtySJ/SkhoGSoUVTaXmFY1tVnaDo=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=LZmKJXcKC/72Zmvfoba8Slk6fyThp9QFFUAgG+hnegyPGKqZTZVkoGzJmLJueq295
	 0PIpBZs2aMHiy7huk2IAhl7wHELPKmkHbHkY+DmLo/y4mvv8n+myXzQw0KQQAIJe4K
	 z/MBRSAvxFbRZ8/IBW64xj9aWPTczI/hc5uf3qO4ZaA6RhmPrGo9V5+YVfIGWABxgP
	 c1OfYrCaJ6ptXwT/8OEal6X/SQM3lFpVw1GjAZyAa+wPxKpaw8Wy60wC1UuWZLtVve
	 hy2dOMHdWrBOhntsf4jnFYfyiKh0DjLM7o1bohBuBYBFI02y6DwMoJMygHDpmp9je8
	 8I/9LHHb58NJg==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-32b3a3a8201so22631841fa.0
        for <linux-wireless@vger.kernel.org>; Sun, 06 Jul 2025 21:22:26 -0700 (PDT)
X-Gm-Message-State: AOJu0YxXLfL93jTY2cgXP9Gj5fRhXPLZwyKlr8fpB+s8yn1TxJ5VKfXt
	/coMahm1iGovnl3DlYMcdEcMKAirbiYQi7pT2X9KtnhRh6+Yhv1g+EMW2C9nfU5KiIUnDhOUQVU
	3ICutOgwqJIMiulc1FaIVkD+T6e4laMc=
X-Google-Smtp-Source: AGHT+IEzY/XDR/2Pipln24Dnn+raZilYwmg6/6daROMXtMIAVacErtwSQuUikWganuovogXTZII8E6s2ySZqZO8Aiyw=
X-Received: by 2002:a05:651c:10a1:b0:32b:387b:de0e with SMTP id
 38308e7fff4ca-32e5f568d0fmr26839451fa.7.1751862144666; Sun, 06 Jul 2025
 21:22:24 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707024615.38507-1-pkshih@gmail.com> <CAGb2v64uB7-4yNCxQiU0bXEk0Px=vF+Oh5+fYevzdPUhcsXLWg@mail.gmail.com>
 <CAHrRpum2QD9GnHiWz3Exf140g-Y9p86Q7HD_Awg-wiWON3LEjQ@mail.gmail.com>
In-Reply-To: <CAHrRpum2QD9GnHiWz3Exf140g-Y9p86Q7HD_Awg-wiWON3LEjQ@mail.gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 7 Jul 2025 12:22:10 +0800
X-Gmail-Original-Message-ID: <CAGb2v65HLghihGpHebiYcqaaLoetY__0j5wSOdgXpQVDHaUi2w@mail.gmail.com>
X-Gm-Features: Ac12FXxGDPVMCv0GcvdaiAj3bzKMR1NneFpe_l9Zs9Zpi2XjaGAvLWECyYI38aE
Message-ID: <CAGb2v65HLghihGpHebiYcqaaLoetY__0j5wSOdgXpQVDHaUi2w@mail.gmail.com>
Subject: Re: [PATCH 1/3] wireless-regdb: Update regulatory info for CEPT
 countries for 6GHz listed by WiFi Alliance
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 12:15=E2=80=AFPM Ping-Ke Shih <pkshih@gmail.com> wro=
te:
>
> Chen-Yu Tsai <wens@kernel.org> wrote=EF=BC=9A
> >
> > On Mon, Jul 7, 2025 at 10:46=E2=80=AFAM Ping-Ke Shih <pkshih@gmail.com>=
 wrote:
> > >
> > > From: Ping-Ke Shih <pkshih@realtek.com>
> > >
> > > The regulations enabling 6GHz WiFi [1] of WiFi Alliance lists CEPT
> > > countries including
> > >  - Albania (AL)
> > >  - Andorra (AD)
> > >  - Austria (AT)
> > >  - Belarus (BY)
> > >  - Belgium (BE)
> > >  - Georgia (GE)
> > >  - Iceland (IS)
> > >  - Liechtenstein (LI)
> > >  - Macedonia, The Former Yugoslav Republic of (MK)
> > >  - Moldova, Republic of (MD)
> > >  - Monaco (MC)
> > >  - Montenegro (ME)
> > >  - Norway (NO)
> > >  - Russian Federation (RU)
> > >  - Switzerland (CH)
> > >  - T=C3=BCrky (TR)
> > >  - Ukraine (UA)
> >
> > This is slightly confusing because the CEPT document lists 46 countries=
.
>
> As the (force/preferred) date mentioned in ECC/DEC/(20)01, I think
> CEPT countries should
> implement  6 GHz regulation, but to be conservative, I only add
> countries listed in
> Wi-Fi Alliance.

I see.

> >
> > > Add 6 GHz frequency entry if not being added yet.
> >
> > Please add the links to [2][3] to all of them. And could you also add
> > the link to the other countries that already have a 6 GHz entry? Just
> > so we know that they are harmonized.
>
> Did you want me filling all CEPT countries with 6 GHz entry or only
> listed countries in this commit message?
> I'd prefer latter one. Please let me know your thinking. Thank you.

Only listed ones then. However, if you do notice any of the other CEPT
countries already have 6 GHz enabled, please add it as well.

ChenYu


> >
> > > But being pending to add rules to below entires because countries are=
 not
> >                                           ^ entries
> > > existing yet:
> >
> > As in, no entry in the database exists?
> >
> > Probably rewrite this as:
> >
> > The following are skipped as they do not have corresponding entries in
> > the database yet. Adding an entry just for 6 GHz would cause 2.4 GHz an=
d
> > 5 GHz bands from the world domain to stop working.
>
> Thanks for the advice.

