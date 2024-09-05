Return-Path: <linux-wireless+bounces-12566-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A17B696E5CD
	for <lists+linux-wireless@lfdr.de>; Fri,  6 Sep 2024 00:39:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2E9591F211B7
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 22:39:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DCED172BDF;
	Thu,  5 Sep 2024 22:39:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Atpx5GmO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B3341482E9
	for <linux-wireless@vger.kernel.org>; Thu,  5 Sep 2024 22:39:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725575952; cv=none; b=D4SkS//P+/AqaMpWebr8VzJ80DKW0lkesAr8D0db3R7eadqc0WFXbzZFGAyR4VchlQywAthv/piRrgv44SxAV4bZsHGJHqiPJshaVUf80XRESQyw1OnrVm/u6kKRGN/E0mnTU+U9xuhJuAGxxAllqqKaIaSOQf6bh+gx2yFp4uU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725575952; c=relaxed/simple;
	bh=rF2wQyt5UWraoIwmGIw4No1N86YRqfWyUeG0X25CYnI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a3eqRBhTreQ+CpdiW9G4xrdmJd1yhtojGFEl4b6MPFHccg3T1/0U4ep5Ui1SCa2y6LPr9enEbno6MH4NpiVEFSIcuwnQYzFABfe2U/i1lkuVLRJ3PEP/MMDQ77VscMsDOvwhzJ1nUglDa4eKq3xEDumREQYUIbtAaXSiFmqCEJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Atpx5GmO; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-6b747f2e2b7so12904577b3.3
        for <linux-wireless@vger.kernel.org>; Thu, 05 Sep 2024 15:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1725575949; x=1726180749; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=b0OAHEq3sv75cS7Lstzjh4q3L/8G89AHDcHIHkaHfi4=;
        b=Atpx5GmOT8MaHRCk5lmK77iu9MWvWbI2Y9rR0qLPuxnv/MQwytXgxZsFiHaF7adwuY
         AhxuTM4xIE7s0yGDU47NSZT8SyaOqJd0dbRjWBR1/nJr2LSWCgsgazC+HhQqf4jKGVdx
         zsWYFtfLh+lnBV2A2EThBqDNLO0LyKorvyw855ddPkRLGv+k0C0XypqJernnj4RqNIjh
         GzCaho/0fEhCRZQv4kCHU5rkY0rbFAJSXR8FVdoENAocSHNvfmAGhn6j1ENUhvj7frMU
         Q8ffkl4CEzgrp9hFaew1Z3xA3bM9hfE+vY0MZaJx1UPaZ02ZENt2fDu/Bjq3sOTLPJWd
         as1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725575949; x=1726180749;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b0OAHEq3sv75cS7Lstzjh4q3L/8G89AHDcHIHkaHfi4=;
        b=pC+w6+cJxluQV/RKJpjHvmO/oz7NN/u0/XmdeX3B+Hr4OOOFk9eqNHpGm+b5ihWyS2
         2U1rUI1N+9tpzATI7dCK0eLnAhOzhTwE53n+mnG+sq992XgtgzLpT+B0c/Xu5z4HJ8wQ
         ZaFjHXOnMOhkTTry8R6o6HDG4BiVu1gMvrH7h/Phky8Sxfg4fHk440NUMuac1ItbgNBa
         8qoZoXFwNfNCxWlKnLWQYrrTYCzLbinAj+AxMSMLRxG5KChIvYiUjdOk8uAFyzS5/yKj
         bSoKwdQcWUkUIe2xw42YfVEDDbthixKj3DStxPgjcwTMSZnvj+9W1oHjDBOPWnKjP0NF
         qHPw==
X-Gm-Message-State: AOJu0Yyl6Kvw5XRLsoEWx2rUty0XxnLMZPTuUYzoP+EDOzVCAZEQMx7Z
	8vazK+rhf8rhw5/YKN8Y70vVUdJqS+YJZT4rz8UOO4asdGbmne78TpDJKBkgmrd+zjAuqrwF9kk
	1+nwJOG5hkJrwoqhGn8zEArb71oE=
X-Google-Smtp-Source: AGHT+IHhoP/gvqgj4l4xozy24+yyUVilL4eTfxbpqPxzO3W0ESHehLVwxgrdMpgIIx8vLgRHvJ6ESYvlqAYkBBq0EUI=
X-Received: by 2002:a05:690c:6202:b0:6ad:9550:7617 with SMTP id
 00721157ae682-6db4516c9c0mr8952127b3.32.1725575949630; Thu, 05 Sep 2024
 15:39:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240905180928.382090-1-rosenp@gmail.com> <20240905180928.382090-5-rosenp@gmail.com>
 <7f37f43b-4728-42e4-848d-b8dbaf1dd13e@kernel.org>
In-Reply-To: <7f37f43b-4728-42e4-848d-b8dbaf1dd13e@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 5 Sep 2024 15:38:58 -0700
Message-ID: <CAKxU2N_3w_m6V=6PXsJpzJz1WJPvQgLtcPDSsenf=_iH0fQtsA@mail.gmail.com>
Subject: Re: [PATCH 4/5] dt-bindings: net: wireless: ath9k: add new options
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-wireless@vger.kernel.org, kvalo@kernel.org, toke@toke.dk, 
	nbd@nbd.name, yangshiji66@outlook.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Sep 5, 2024 at 2:33=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.org=
> wrote:
>
> On 05/09/2024 20:09, Rosen Penev wrote:
> > These platform_data options are now available for OF.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  .../devicetree/bindings/net/wireless/qca,ath9k.yaml  | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.y=
aml b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > index 0e5412cff2bc..5c293d558a94 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > +++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > @@ -44,6 +44,16 @@ properties:
> >
> >    ieee80211-freq-limit: true
> >
> > +  qca,led-active-high:
> > +    $ref: /schemas/types.yaml#/definitions/flag
> > +    description:
> > +      Indicates that the LED pin is active high instead of low
> > +
> > +  qca,led-pin:
>
> So this all looks like re-inventing standard GPIOs, at least for devices
> using GPIOLIB. Your commit msg needs proper rationale.
git grep led_classdev_register drivers/net/wireless/ | wc -l
16

Both old and new drivers register their own GPIO devices to control LEDs.
>
> Best regards,
> Krzysztof
>

