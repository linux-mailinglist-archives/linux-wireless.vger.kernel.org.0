Return-Path: <linux-wireless+bounces-21116-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id ABA5EA79D1E
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 09:38:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6DD047A2ADE
	for <lists+linux-wireless@lfdr.de>; Thu,  3 Apr 2025 07:37:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1367324113A;
	Thu,  3 Apr 2025 07:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b="jSOnHL0P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com [209.85.208.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E1422405F2
	for <linux-wireless@vger.kernel.org>; Thu,  3 Apr 2025 07:38:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743665919; cv=none; b=WgqmBu1W0hed7sBIZJ4JqG9+vs1Kjmf0FWl9MCaNg7zwNKl1qHwoNbDCOfbvaRuzVw86Lt+G2DojlVybIcev/IlsyWtD+v37/t3ihYUVtvFXr7SZFOzo43v0oIH+GCMLDhu9CAVofLEsBMYSkfX5ExqBeyM/cXKQLPqKd6kBo+Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743665919; c=relaxed/simple;
	bh=r1+85w+l8mYkuW5ZQ70d0+EsyEP9qhZP9Q1yJFSdZLA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nlIha3aj7hO0fLpaUjmyoTkY/LL9AAUlKnqDmVSOM5zXDHmG4ncgyKm35TbKEpsRL0NgbHSNcnvB3VcV6VJPGukWDI2lXv0dcLyMY6/1DzBnU8nkUjAeRopeeXlDHrvYMaj5NUnS3M1T1ZhveSIrYCYE+GXnlFUT/DGrgYoBVPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl; spf=none smtp.mailfrom=bgdev.pl; dkim=pass (2048-bit key) header.d=bgdev-pl.20230601.gappssmtp.com header.i=@bgdev-pl.20230601.gappssmtp.com header.b=jSOnHL0P; arc=none smtp.client-ip=209.85.208.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=bgdev.pl
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=bgdev.pl
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-30bfd4d4c63so5344901fa.2
        for <linux-wireless@vger.kernel.org>; Thu, 03 Apr 2025 00:38:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20230601.gappssmtp.com; s=20230601; t=1743665915; x=1744270715; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=r1+85w+l8mYkuW5ZQ70d0+EsyEP9qhZP9Q1yJFSdZLA=;
        b=jSOnHL0P6rxBH3daRFVWc0mGrRQ1uwVoxMTC4Wlvzx9cz1tQPKc6ojaSDg8NQNsDtI
         i8+8MJv0fSOU98YTGMdQFEzT7Aab/Qe0UJYhMQwiU2ubt4jPXw1FtVcg/SNmOUl3H94V
         rFgzks4TE9PgWsc1M/Rkv8KbwHNQpCFXRvCZT2O2mJCm7Epud5O6pE/hcW9TdWw9tYON
         Yln7qTkOm8FUeHmzS5LUIJ1xgfs0tNw0gWiuqymy+1P0hatXAazO9NFNXgHTmZrFu6uA
         GmHRbei4iGTJS9UrawVq51hxKrmeZC64Y3XKvuyr435LLeNte1cLEuIwZpMu7AFGkH0t
         BKAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743665915; x=1744270715;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=r1+85w+l8mYkuW5ZQ70d0+EsyEP9qhZP9Q1yJFSdZLA=;
        b=Cs4PXiXIlp3rQ6mzFCm2tCXILKtbqXsvbxOSW9UoC//w51JwGIwE3/ZX5o1dDayHe8
         kSIzOiDNEJ8kO7hdWGGWdRvhHjF8k4mA/UoHQWGlLeMGd4ugACi96Vz5TSNJHwcKwTeX
         HBAJ0AVKpSOeeQH/2eJOT5BXxr/ERIZI5ycIfxbzYFKKaUimPpYZyZOoLusRwiTlBTKo
         u3feKSMp7wUKoxwOwaK0DNdtcBy789W/frPocL5Km8yAyjkr5U7yUrva5tWw9Z6Bb27f
         8JC9BPfpY71p/4pKWxDEMZPIQX8NYP2wxCLyWabmB6DAD54F/wZjUY7uMNn00CheK7Vs
         ORdA==
X-Forwarded-Encrypted: i=1; AJvYcCWTnWXYTEEsUq2lYzBMu4Qw55O0338dJDPGsfgl8A0LAEnRJjYZ0O2bjplyWNneMuRm7/ZJI4tGQj9dYhx8UA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxg08mtvCr5BfyBbOClXrVdiO4h7j5wStkjrjyRnvgODB5AOe0Z
	YqVUi+N0gZOHgjZ/Nz86QDstH9MyeUGu67KzUWDfz1rwWMoslV04qmTA+PgTTEBMR/sJ6So2qUz
	qhWKx8OvIsFBactE8D4rYI4J26eSaylCSFUuDCw==
X-Gm-Gg: ASbGncv8+J9eMClZWGM6p1gzkJCT9w0Eqer4BNxdDxh79IehwHCqpvbFDdez3hvYISP
	8o86Gop8+TugPKvVtjQrjQbgsGR1o646zl2FXNZhdWD9EAWBO9I7o+l4YUdGsl1s50XM3Jd52tp
	rTkRiI389m0wW2P+vKv4F41L2rLxFvs9DNh+67gIFoJscB5asqddZtqcvB
X-Google-Smtp-Source: AGHT+IE+efI2xX/8yZlFAe4Vm/Cxzz+Nax11lqQy3zdclZUZJJhpwXV7c7fhUqN3JwjPrbPY+ZyZGS0ljljrKBqXCe4=
X-Received: by 2002:a2e:be14:0:b0:30b:8f60:cdb7 with SMTP id
 38308e7fff4ca-30f02b985a2mr4363601fa.24.1743665915290; Thu, 03 Apr 2025
 00:38:35 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250402132634.18065-1-johan+linaro@kernel.org>
 <CAMRc=Mfpm8=q1mkfNfjPtogbh1S9PKU+w_2yMP+oE_Gj7-qemQ@mail.gmail.com> <Z-42nVkEZeWHdwAm@hovoldconsulting.com>
In-Reply-To: <Z-42nVkEZeWHdwAm@hovoldconsulting.com>
From: Bartosz Golaszewski <brgl@bgdev.pl>
Date: Thu, 3 Apr 2025 09:38:24 +0200
X-Gm-Features: AQ5f1JoaECCB4Ig-OQoVaRV_IJbeuDbZtSRj286KtUBGCZkrM4_HeX7c4fhC4-E
Message-ID: <CAMRc=Mf3on3TpiPDhtPnp1-3b0ika2GHy6h-NJqcgvYpWMHpoQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] PCI/arm64/ath11k/ath12k: Rename pwrctrl Kconfig symbols
To: Johan Hovold <johan@kernel.org>
Cc: Johan Hovold <johan+linaro@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Jeff Johnson <jjohnson@kernel.org>, 
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, Jonas Gorski <jonas.gorski@gmail.com>, 
	linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
	ath11k@lists.infradead.org, ath12k@lists.infradead.org, 
	linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Apr 3, 2025 at 9:19=E2=80=AFAM Johan Hovold <johan@kernel.org> wrot=
e:
>
> On Thu, Apr 03, 2025 at 09:11:07AM +0200, Bartosz Golaszewski wrote:
> > On Wed, Apr 2, 2025 at 3:27=E2=80=AFPM Johan Hovold <johan+linaro@kerne=
l.org> wrote:
> > >
> > > The PCI pwrctrl framework was renamed after being merged, but the
> > > Kconfig symbols still reflect the old name ("pwrctl" without an "r").
> > >
> > > This leads to people not knowing how to refer to the framework in
> > > writing, inconsistencies in module naming, etc.
> > >
> > > Let's rename also the Kconfig symbols before this gets any worse.
> > >
> >
> > Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >
> > I'm re-adding the tag here as otherwise b4 will only pick it up for
> > patch 4/4 on v2 of the series.
>
> I had already added it to the first three patches so it was only
> missing on the last one.
>
> Johan

Indeed, sorry for the noise, I saw b4 only applying it for the last
one and didn't check git log.

Bartosz

