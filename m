Return-Path: <linux-wireless+bounces-15149-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC04C9C25AB
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 20:40:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 671201F213B6
	for <lists+linux-wireless@lfdr.de>; Fri,  8 Nov 2024 19:40:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C26831AA1E0;
	Fri,  8 Nov 2024 19:40:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EDFWM0b4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f53.google.com (mail-ed1-f53.google.com [209.85.208.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 141A41AA1EF;
	Fri,  8 Nov 2024 19:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731094802; cv=none; b=NRxRdc2E0t3EGZyUPLVVWrGpTk4MLPN/OKYhb8bYU7yG89t87Q5nsckYVhCbShUq1bedhunOfA2CbuLOZtaFYP9y1Kjq/gn/X6wXeO8QitFgmPTsIR/z3Zvonrz7elhruY92TZLc4vOimqkL+TJVqqq3ywnpEenFlzYfuZc+KQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731094802; c=relaxed/simple;
	bh=1NLTe76swh5AGV5tzwgpkAKMOgKGsa/SijxcncDbQUs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=dL5LVqOb9I9lWzeT/AFCLpoR8AoqKh1Ijj+pX8OFozYP8f12WQUgj287Vt535t7lpxHgSfutzVGG37/Jdq7o1IYArKlWlgaUX2wbI6ZpHEdQ5cJqENVj0J2irqVu3sj5snYJ/e0Fu+6F05ECBM76BoPDh3UIBPVG49stQyLxBoU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EDFWM0b4; arc=none smtp.client-ip=209.85.208.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f53.google.com with SMTP id 4fb4d7f45d1cf-5c9c28c1e63so3072830a12.0;
        Fri, 08 Nov 2024 11:40:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731094799; x=1731699599; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=853KUZ8Dj0DGzjFqpwaFczZ9tX7evR6TG4RoMElhOW4=;
        b=EDFWM0b4+2ROfUKjxy5Nk9HgMODJ3cdP5kSIiV/hL//e6Cgan3gkcqvN0lLELaxV6+
         BllYE3X5QziiTldAO8R6td91383iIgUDYmcTQ4JkeyyLHft+RV21nQ5nnBdsPRZ7JESh
         Xk1slspCx53HsUZf7+HBJo2DFTAfHmf1LKLibYCwkBByFYwBwla9VNm3vm6xmsgwW9C0
         jWmYw8WWzze0OUy4XYWtPD1DRn0GaNfBsbFamRyfO8Prbhf+eIapDrAyfOS1ral0w8w7
         MIMxuL37tspCRWOYeaxldCMkv9n3so8YZzVGmvH6Ovp2MaWI0QERcGGMuf+fITAHE5HS
         TcQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731094799; x=1731699599;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=853KUZ8Dj0DGzjFqpwaFczZ9tX7evR6TG4RoMElhOW4=;
        b=vnNDHHT1jBLddYt4GfRnwrFrUx5dboIlo3WxUIuzG89JLkKBqYBg6EUmx/St0E00Ro
         XyEX03Aci4mvlMZ7hYkX4eihkj/FL1mROZ1K5DArCPRx97AxpWIT0Ewlt+2/fseSIBRc
         fHkciqPkymezAKb2n7dvrTMxI7Z6uK9Yw8RCcm3sHOo6FpMGj90lMXGGFx5Y1K8y8bkE
         lJ0x47XGfShkbfVO3JixVul8pMLdkDJDK56WFuG/D52OBvLGVZXpwLZG5E/xRr8ovQF1
         933pHTLr3Pe3rUNf+sgnEPy2ncNEuYCohSqEs1RDB8HOIBvesq2FKWJAO85fA85dy1gZ
         +vuQ==
X-Forwarded-Encrypted: i=1; AJvYcCVUAlIv9RKd6Vls4zarOH4Au7VzC/xqzqph62oiv378PvJ5FUDdyrJMSe1zL5hz/9vpJHjgmr/EvLZNy2n9bCY=@vger.kernel.org, AJvYcCWBq0FsQyP7QLbrBVEvxSurzGQXFfGBjiykT/QnRdTuidhB80goekziVqzlwHh3kgpkt89Y3uOcuN0QBmQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwI6HLOIZFvylR26qZ10L3QELkOdrv6qgtuknKlhF7gR0enVC46
	kjHAxxn3bPNvYEyi+tam6ROfORmlHoIG3DeA9fLkkfMI8PVczUMrUHi5cAds8G0fUQ/9/pHSMHj
	TFpmg+skP9fOaudCcQjSUQSgVjtE=
X-Google-Smtp-Source: AGHT+IHfyiKMOejHvMRZO/zyz+qflgSFoDwj1FsOF7d4WVd4pk8vMUzCFg05i04c74H48+3Tc//fkteIZK7hEvN1E5A=
X-Received: by 2002:a05:6402:34cc:b0:5ce:de0f:e4f6 with SMTP id
 4fb4d7f45d1cf-5cf0a30af57mr2539131a12.1.1731094799072; Fri, 08 Nov 2024
 11:39:59 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241107222043.1414437-1-zmw12306@gmail.com> <f1a0801e4ce55cdccfa809a6e49d839aabf1a0ae.camel@sipsolutions.net>
In-Reply-To: <f1a0801e4ce55cdccfa809a6e49d839aabf1a0ae.camel@sipsolutions.net>
From: Mingwei Zheng <zmw12306@gmail.com>
Date: Fri, 8 Nov 2024 14:39:47 -0500
Message-ID: <CAN4iqtS8GG4AMuAzi4jssqZBqyOUgwV21MP8FQeefGznhgcY9A@mail.gmail.com>
Subject: Re: [PATCH v2] net: rfkill: gpio: Add check for clk_enable()
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linville@tuxdriver.com, rklein@nvidia.com, linux-wireless@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Jiasheng Jiang <jiashengjiangcool@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Nov 8, 2024 at 2:47=E2=80=AFAM Johannes Berg <johannes@sipsolutions=
.net> wrote:
>
> On Thu, 2024-11-07 at 17:20 -0500, Mingwei Zheng wrote:
> > Add check for the return value of clk_enable() to catch the potential
> > error.
>
> Wait ... is someone running an experiment again? ;-)
> >
> > diff --git a/net/rfkill/rfkill-gpio.c b/net/rfkill/rfkill-gpio.c
> > index c268c2b011f4..a87bb99231a6 100644
> > --- a/net/rfkill/rfkill-gpio.c
> > +++ b/net/rfkill/rfkill-gpio.c
> > @@ -31,9 +31,13 @@ struct rfkill_gpio_data {
> >  static int rfkill_gpio_set_power(void *data, bool blocked)
> >  {
> >       struct rfkill_gpio_data *rfkill =3D data;
> > +     int ret;
>
> You could move that into the if.
>
> > -     if (!blocked && !IS_ERR(rfkill->clk) && !rfkill->clk_enabled)
> > -             clk_enable(rfkill->clk);
> > +     if (!blocked && !IS_ERR(rfkill->clk) && !rfkill->clk_enabled) {
> > +             ret =3D clk_enable(rfkill->clk);
> > +             if (!ret)
> > +                     return ret;
> > +     }
> >
>
> but this is obviously wrong anyway.
>
> johannes

Thank you for your suggestion. I=E2=80=99ll make the corrections and send a=
 v3 patch.

Best,
Mingwei

