Return-Path: <linux-wireless+bounces-24870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 6428DAFAAA0
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 06:49:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8772B17AB9B
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 04:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69AFA262FC2;
	Mon,  7 Jul 2025 04:49:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fWP30Kw7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B17ED3C2F
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 04:49:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751863742; cv=none; b=G6A06IT+MBRqBPhiE17giOHUfOo6CsRZyI//Fyqa984fBEB8uUvLaBgW5Vc5EpbHwanux6vJBq2VLkMdFP2HhDl6H+WG8Too/1qky5344bpeyNzJkEfqHxUMxE2ZL6tIDutFLFgh+2Z9Z3zYCnvPeC92kdpYZ+zg6RyZwdraFIw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751863742; c=relaxed/simple;
	bh=s9eh5bX02SqmnDUG0v+iQdsxDWHld6KYbv4zGtnAkLc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Z+5T/ar+6hfdLLuA96nXt8GgdNvq3ylMB3fZ89rA7fW7VOl/M1IRuM0QmhhrlZrUAstUlfnEaPzSczLanKv9WfbUuKMGMlqCsCjo5cCm3pIvUAob4HofU8rpgSOKir6rhSLIBKX7TAtnhcwpA9OjaNG1h+BDfiVWYAe+EdhFDcA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fWP30Kw7; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-ae3cd8fdd77so575629966b.1
        for <linux-wireless@vger.kernel.org>; Sun, 06 Jul 2025 21:49:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751863739; x=1752468539; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=s9eh5bX02SqmnDUG0v+iQdsxDWHld6KYbv4zGtnAkLc=;
        b=fWP30Kw7h71b3joVqazX+10K7KuYeRy0ZV0P9MCaOARVgqscaCDZy1XvAawTUY1XbJ
         cNvTYBmEdODpXVcKGppuuyXU1zHZHKOZa1HXIQPPdUL0OPbga4A7uvTNkAbwMGwctSCo
         uAJh2S5Zz6NUxdZPU/1e3PSLOAeDHm6S2slKzYm3cgChmMqPvdzA/Cb4sKC8gQcrpDxT
         Jj69+q6TOzQRhsBJ5rQvvpvboVtRWGVDM6IOplAJ1PG4ppwPH2nTVUd7ffXp0lbNjajT
         HMVaSUKq9bo7IOtwHack/LlOS/6332Yne+VT37KMrbTpe+LQk+jBTKoIu8x65WkJ0spN
         Bonw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751863739; x=1752468539;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=s9eh5bX02SqmnDUG0v+iQdsxDWHld6KYbv4zGtnAkLc=;
        b=Q60t7rsYgKE3hRPTJRHNScxjPzHr8lkp4nfcLB75gD0yZs9QWjqpspqLBi9tc5lf9q
         Fvqy9sWUHN0Rww/hcP9quAufBbaqJlmtStI9kzwYD99Nhp5zg2+a3Dwn8s2zCH7kDP2Y
         aF2MsJgACpIkZ40PGH8AqpguA5IqKPATtewSknlAoKFNjM/DGP3rCDjep24e3Nnz9QCv
         dahqQ3dmNWBWHD47W90aPFxSg4tauqaVyDrABtVieD84ZFSPZWpWAqP5Rx4HyJQj6Fgy
         E/FxlCHRpxWXhg8IXuZdn6zbWLfoIssVB3y/fGVGcT3KQhht1VnTnTJCfd8gDcjfcXwU
         n+iw==
X-Gm-Message-State: AOJu0YyGaT773UgxrO87dW4N/c4ss9MMWPt/nPVSZsHPQwyIcN7fwYJ8
	umBj0CkIwWz+d5u/6MZ/xDEldqfqXdrcyq9T7ZMiP9+LZlmcGExI9diPeVUUxloPhlLV+fRqNfH
	mo5kG3yK6+cAAWi7Ww2dBu98SMvgtRLWd5nVC
X-Gm-Gg: ASbGncs4dkzXI7qTusJYj+aGiMK09d/ITIQ/iTfJEEd8U2IjUSE6jWru/n6PErIf5wa
	nMJVPcHX8RqlykO64gpejchjvPSJDGqnU0zDUTlORGNN7SwXcjJ1mFh7Yt6l3f9B4czKeLi+Zaf
	TZjnyKOGticgLt2PVtC1Ous9CKSZ15mA1IsujaMdkCN0PrCg==
X-Google-Smtp-Source: AGHT+IFHMSMk9DCNGgxatFS40Qp2NCPKKf5rvgN7Cebzd0ZQh3MQvcrYYWGQlODn0fQQHJdD9dMOB1GEzxLuIRCK6BY=
X-Received: by 2002:a17:907:9444:b0:ae3:b371:e7d4 with SMTP id
 a640c23a62f3a-ae3fe596317mr1106723766b.12.1751863738655; Sun, 06 Jul 2025
 21:48:58 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707024615.38507-1-pkshih@gmail.com> <CAGb2v64uB7-4yNCxQiU0bXEk0Px=vF+Oh5+fYevzdPUhcsXLWg@mail.gmail.com>
 <CAHrRpum2QD9GnHiWz3Exf140g-Y9p86Q7HD_Awg-wiWON3LEjQ@mail.gmail.com> <CAGb2v65HLghihGpHebiYcqaaLoetY__0j5wSOdgXpQVDHaUi2w@mail.gmail.com>
In-Reply-To: <CAGb2v65HLghihGpHebiYcqaaLoetY__0j5wSOdgXpQVDHaUi2w@mail.gmail.com>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Mon, 7 Jul 2025 12:48:40 +0800
X-Gm-Features: Ac12FXyMKFGdL34tJPYf023jI_CaJU95LntkTLMP97JgPBwFU0mv0v15cNGYnTY
Message-ID: <CAHrRpuknCcfOoRQYURbL_HwH_yQiSgU+EWrM83EPbu5krRCeXQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] wireless-regdb: Update regulatory info for CEPT
 countries for 6GHz listed by WiFi Alliance
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"

> > > > Add 6 GHz frequency entry if not being added yet.
> > >
> > > Please add the links to [2][3] to all of them. And could you also add
> > > the link to the other countries that already have a 6 GHz entry? Just
> > > so we know that they are harmonized.
> >
> > Did you want me filling all CEPT countries with 6 GHz entry or only
> > listed countries in this commit message?
> > I'd prefer latter one. Please let me know your thinking. Thank you.
>
> Only listed ones then. However, if you do notice any of the other CEPT
> countries already have 6 GHz enabled, please add it as well.

I will do it.

Usually our RF team tell me they get certificated from lab (e.g. SGS)
for certain
countries, which should have defined regulation rules, but they don't share a
internet public link as references, so I can't make a patch right away
until I find
an official reference.

