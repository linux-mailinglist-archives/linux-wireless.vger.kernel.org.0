Return-Path: <linux-wireless+bounces-29126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 236C6C6D767
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 09:37:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 27645387F78
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Nov 2025 08:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A2BC3303A19;
	Wed, 19 Nov 2025 08:35:51 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D4931ED96
	for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 08:35:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763541350; cv=none; b=doCriFx/I2fuO8gK8UeVTLEM3o1Qqp5Gua8irLxaUPVwvTFztaRWj/SUJYXEJnqwGdnjpHUGvhmev7OGHgndpWwCuzgAVPl1I3VeMZMnWrYAWIhSgEo7Gbhk/qBv8BRXIbgw3+HR0+zVBWdXjGOb3OiUic3TqhLxCcy3iueIEn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763541350; c=relaxed/simple;
	bh=/AAYc9gvf+ThL6ux8VgRdaoW34DWJYT2SRPZxEzT58I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Y7OdF2/dMSQ/NVsT41TqsI90Eu5cyzDKwsqIyeNjAWG5ZsxcNpAQYDgslzticHa6A1QEAa9AdlnHRlEze6Q6lnYsxXUApT4gY327StOOro+qEpoc000WuY/nbu7ApTB97vm4LoRqtQ2V3DJ3HeeJl8a22Hp6wazVfXqprEPD9+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=linux-m68k.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-55999cc2a87so888001e0c.0
        for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 00:35:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763541346; x=1764146146;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EqOkox6RKDqNU5aWyID9eT/MiXeLwVM1IpXj/iNrSjc=;
        b=PrexJATxm+sreY+AntTmNSHwn1lQ90CVwhIgZsRpNoG46F8A7+jebBnMSKUbIq3SzA
         ShA0t0e9swKbLXEjOiVQ/JSf7Md/8XGTd7XuR1oxxdj3MO0KET2lRjLMdmyFMNE2Kpze
         6bW2yupoyWdFaF78Uq+NwmBadw05rENDafDi9lXK8uTfN1GCjIAyZCjA1G3wiS4s/xk4
         XNEp7BP/aoWCr/YZnvf8aoiQCNKc6Te1PBcItVZuU2ogwGrfFbFB+uoG6aZjXsC3pqUy
         18a6c7bEkHJbGmGa60H0HFZCs59wHO1mHVwNpERm0yH8SQrYejUZ34V3k9u6dSSDE5Ng
         jviA==
X-Gm-Message-State: AOJu0Yy252+qRPt3UPwXDiiluV7tIh9zEkvc8geJFOYND5eB2Kbc/pIY
	U+KKBYV3H38QonxpfGLecejKyVICbB62RIVqbOkdSevWczwffDwT3DHWes4a8J0L
X-Gm-Gg: ASbGncs3OSjFW2C9L+un/li70lOCR30F/9RA/Y9KXlw7LbDe6PHWYAmRZRibTWCGwkj
	nra4C5YzFKcqreaVMZS3/5kHN1uCW2nhcFBlcVQMqxaizjbAoQRj3BvWa07iDRG4yfkO25fNpRw
	+lhtg5CjfiknNs0EeSke1j6RGDrTlGskuWIyWT+bQc8szBmBcpr9tr+sVF+r8UmlTWuU9a5xY46
	cgag3y5tldsTuj4o3HQljwu4j0WGM0qDf+TgDS5cMeb2dvgFx3oXifAivlzdea4AyjFoMe/lVPq
	uUBtKrwa0XuFPdr1IJ1BONZ4TRSvHsUOmMCvAWcdm+4hmZou8qovrcSgE3GboExypZlu+nc5cPw
	6vcj51YTrcCkHmcbgpqRsAjVBnZOqvmFW6RVTDMl1siIlZZlRtKz0c2clRWr4E5/YjNDav3LBQx
	XubnkyyKdhEMry0U9QI5MMaFrGTnEq7ut3/KW6g0aXQPZ/ZbAe3QtQkUCFxOc=
X-Google-Smtp-Source: AGHT+IFk0zEqJBadtlNgRDG/kdZM7aJwhyiksSgjjrxBeLrHKtO/lm4AQdcYyVF0j0YOzYNRmcHoow==
X-Received: by 2002:a05:6102:b0b:b0:5df:c34a:5a00 with SMTP id ada2fe7eead31-5dfc554b51bmr7020476137.11.1763541345904;
        Wed, 19 Nov 2025 00:35:45 -0800 (PST)
Received: from mail-ua1-f54.google.com (mail-ua1-f54.google.com. [209.85.222.54])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-937611bf6fdsm5865822241.12.2025.11.19.00.35.45
        for <linux-wireless@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Nov 2025 00:35:45 -0800 (PST)
Received: by mail-ua1-f54.google.com with SMTP id a1e0cc1a2514c-93723104137so1829411241.3
        for <linux-wireless@vger.kernel.org>; Wed, 19 Nov 2025 00:35:45 -0800 (PST)
X-Received: by 2002:a05:6102:5808:b0:5dd:b288:e780 with SMTP id
 ada2fe7eead31-5dfc533e040mr6950370137.0.1763541345498; Wed, 19 Nov 2025
 00:35:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251117032910.11224-1-pkshih@realtek.com> <20251117032910.11224-2-pkshih@realtek.com>
 <CAMuHMdVuThcAyVuAU=N0FM+vd1xNyk9p4bcDWJUEpsYcmh2J7A@mail.gmail.com> <6268b32ba19b4a1690a944d6093b01e9@realtek.com>
In-Reply-To: <6268b32ba19b4a1690a944d6093b01e9@realtek.com>
From: Geert Uytterhoeven <geert@linux-m68k.org>
Date: Wed, 19 Nov 2025 09:35:32 +0100
X-Gmail-Original-Message-ID: <CAMuHMdX31GZBUK1dwPNSbfjBK0GHvh3CdCLp145FK=mcgsjqug@mail.gmail.com>
X-Gm-Features: AWmQ_bm_g4G_ZTJQXeVrux_dle8DBi8_3V131dJp1c7755qw-e02mLKWc_BYCSI
Message-ID: <CAMuHMdX31GZBUK1dwPNSbfjBK0GHvh3CdCLp145FK=mcgsjqug@mail.gmail.com>
Subject: Re: [PATCH rtw-next 1/2] wifi: rtw89: 8852a: correct field mask of
 reset DAC/ADC FIFO
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"

Hi Ping-Ke,

On Wed, 19 Nov 2025 at 01:44, Ping-Ke Shih <pkshih@realtek.com> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > On Mon, 17 Nov 2025 at 04:29, Ping-Ke Shih <pkshih@realtek.com> wrote:
> > > The field mask should be bits 16-31, but suddenly use wrong bits 24-31,
> > > rarely causing a little performance degraded if DAC/DAC FIFO stays on
> > > an unexpected state.
> > >
> > > Found this by Geert who works on bit field functions.
> > >
> > > Cc: Geert Uytterhoeven <geert@linux-m68k.org>
> > > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> >
> > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
>
> I suppose you meant Reviewed-by, but you also the reporter. I will add
> these tags by v2.

I did mean Reported-by.
I cannot review the actual values, as I do not have hardware documentation.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds

