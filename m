Return-Path: <linux-wireless+bounces-24867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F957AFAA83
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 06:15:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C40B5177DDA
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 04:15:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AC9F9CB;
	Mon,  7 Jul 2025 04:15:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Lb1AJhZV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04EE31373
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 04:14:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751861700; cv=none; b=kpxy1MwkcbpcTjRtVLH/o08R4+Oy4Uf4aruYQO3Gb5MEWWEjBWWojlz6r+P/n1CDhhFSUpC/HhlS09OTPGKhIAwVjgwu4owKx8MyGwHKPYQtGhFJVUrPPpCOqYP3BEpL/RNY3CvbK/TSaTKq34nczH2CkdaKctTSG2pArsoOLb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751861700; c=relaxed/simple;
	bh=UZ7UBvoQ/aGwBhMbJafbG82CpwTDBAQ0gLMVUS1b97o=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UIXuhHAjLNx3mQaFDOJXuiurNgqJ67Z6CB5/V1f0HWi46CBRXPFUWDFWy6jBrYj0Ra5TqVDCssJeS5C4yz6XI3e2qdQtMbm9upW6q0XEISBLvpLs+BPaP3DBDvTtJkDq8o+CGtuzjriSR7MnwhshB5+Qpo2pw70ZIqs2/831NSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Lb1AJhZV; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-60c93c23b08so5133382a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 06 Jul 2025 21:14:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751861697; x=1752466497; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Hh9Fmj65WwGho/6PnecLIqg/0/nl3cmxuMsBMv8BP7U=;
        b=Lb1AJhZVConpp8/nAXy/vn/n7Zw1xx9XcsN4DOFur+VGCvQVr9OHPtmpx+UgHWPCGj
         guFvSD+eAYfY8EPQ9udLkimHPPuIcCTEeb5haVOGEpt0saaN2Zzu1uvjPO1wWvAozbkK
         nekTAEpdRqV6YFJlMibiw/FZmgTJNV/TgIox+YPLDIDGqyzsOkmtJjX1HK/6zlW9/lkq
         BZeIz2V76BsPbXUSMQTejDBjuJIapLi2ci4mqzxagoLBi0YErJ1LPp8soSD7vsHGF/lF
         IJd+kAJYFi3jwg3WGmL42CIzw03aQmh1vXcfFrV0DI96aGWkkRtcahq2DC5vi7xnZQ2X
         CrPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751861697; x=1752466497;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Hh9Fmj65WwGho/6PnecLIqg/0/nl3cmxuMsBMv8BP7U=;
        b=AJYlS7ioeT9R20aL3w3HC4EbpSZFrSBba1YZLYpPlfEWQRBRlEsoo6ZH19Xt3mHfPy
         QygWVEoYn0vleG2Ha4cQQZAlwFWx5Ky2jLSyTi0ko7PnFl9tJizGWAfcLHtIqhEJ0oWv
         33K8Az1yroJrBk38A0aHL8z0MK4cCTXOBqjfqLUxYrk5YG/bWp2hE/ww3MPGBnn/VNdX
         jBI2fbthwwWMgeJ7/uKwCeOZgz3avMDiT40Srdv3OpXJ1a/0LvPGeonUwO50WCxYXqlx
         4WAQPSGKlP+AiPbBzbcmiDxm37eGf/molqJVBGpYumga4eLjEri+B/XUWX6d3BEsuLKx
         M8oQ==
X-Gm-Message-State: AOJu0Yzlpu0S8jmGhJfttqY+clppaUsEogYDr1EhIBB6CqvRZpnT+p4v
	2wtUcwRvckXHs7gH94q8nnU/AXVCP84mJW7vL6kaieM/fKWL79ref+VHZrtQaCfKdekGNi6gs5M
	xgtgvHRDNG2HDcsOPBwQin7SBpK7T4tQSjlfN
X-Gm-Gg: ASbGncu4nXys+Z4Vag/hGk9+SmF9pG2vJDIP3Bsiom3bpRqFZQLT6Ez/tU9EihssU00
	HwD+qF7GZQqtnGwVYSz+36WzDck3UOdfaEgLkJyaIkS5xLURg9WqedL3pVN5FoumcO2yF1RCoo0
	oEcgbCuI+Ym8pt2jBVrA2788gYpWBsgi54r3lOqKSl20j+Iw==
X-Google-Smtp-Source: AGHT+IHDoIPIF+HBXfu4Tik80b+/hGnYplWBqy2mCM5k1GuKUTBjlwmJ2kkxwlrlwIMgMRVBLxgItVEcxstj6/Vl5Jc=
X-Received: by 2002:a17:906:3c43:b0:ae3:6651:58ba with SMTP id
 a640c23a62f3a-ae3fbda2f7cmr920390066b.35.1751861697081; Sun, 06 Jul 2025
 21:14:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707024615.38507-1-pkshih@gmail.com> <CAGb2v64uB7-4yNCxQiU0bXEk0Px=vF+Oh5+fYevzdPUhcsXLWg@mail.gmail.com>
In-Reply-To: <CAGb2v64uB7-4yNCxQiU0bXEk0Px=vF+Oh5+fYevzdPUhcsXLWg@mail.gmail.com>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Mon, 7 Jul 2025 12:14:38 +0800
X-Gm-Features: Ac12FXykxWNRiqghUFX_9brMpcIs7WuI6PLq64NFrIP6eMt-wNB9e2tszJ5vmUk
Message-ID: <CAHrRpum2QD9GnHiWz3Exf140g-Y9p86Q7HD_Awg-wiWON3LEjQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] wireless-regdb: Update regulatory info for CEPT
 countries for 6GHz listed by WiFi Alliance
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chen-Yu Tsai <wens@kernel.org> wrote=EF=BC=9A
>
> On Mon, Jul 7, 2025 at 10:46=E2=80=AFAM Ping-Ke Shih <pkshih@gmail.com> w=
rote:
> >
> > From: Ping-Ke Shih <pkshih@realtek.com>
> >
> > The regulations enabling 6GHz WiFi [1] of WiFi Alliance lists CEPT
> > countries including
> >  - Albania (AL)
> >  - Andorra (AD)
> >  - Austria (AT)
> >  - Belarus (BY)
> >  - Belgium (BE)
> >  - Georgia (GE)
> >  - Iceland (IS)
> >  - Liechtenstein (LI)
> >  - Macedonia, The Former Yugoslav Republic of (MK)
> >  - Moldova, Republic of (MD)
> >  - Monaco (MC)
> >  - Montenegro (ME)
> >  - Norway (NO)
> >  - Russian Federation (RU)
> >  - Switzerland (CH)
> >  - T=C3=BCrky (TR)
> >  - Ukraine (UA)
>
> This is slightly confusing because the CEPT document lists 46 countries.

As the (force/preferred) date mentioned in ECC/DEC/(20)01, I think
CEPT countries should
implement  6 GHz regulation, but to be conservative, I only add
countries listed in
Wi-Fi Alliance.

>
> > Add 6 GHz frequency entry if not being added yet.
>
> Please add the links to [2][3] to all of them. And could you also add
> the link to the other countries that already have a 6 GHz entry? Just
> so we know that they are harmonized.

Did you want me filling all CEPT countries with 6 GHz entry or only
listed countries in this commit message?
I'd prefer latter one. Please let me know your thinking. Thank you.

>
> > But being pending to add rules to below entires because countries are n=
ot
>                                           ^ entries
> > existing yet:
>
> As in, no entry in the database exists?
>
> Probably rewrite this as:
>
> The following are skipped as they do not have corresponding entries in
> the database yet. Adding an entry just for 6 GHz would cause 2.4 GHz and
> 5 GHz bands from the world domain to stop working.

Thanks for the advice.

