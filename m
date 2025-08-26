Return-Path: <linux-wireless+bounces-26604-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CACC3B35148
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 03:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7AC6C3BC327
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 01:58:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D83501FDE19;
	Tue, 26 Aug 2025 01:57:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="TzKbUsYx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451F2BA34;
	Tue, 26 Aug 2025 01:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756173478; cv=none; b=Xw4/AiNVXDEKjkPKaVzKBm5A0Or/FBFOoU7tvSuqDbN788nUsy0WmIm4vEOjyonUH8wqb/aSAvQhkPRhvxNLkspF+ucFbGI/BFmgrrAfEk3sn3KaseW15jrowZeMb4bY3cZAKImj7drVr2H7nSW14FJem1Vp+c4CHarexSpztfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756173478; c=relaxed/simple;
	bh=KOSGvM2wr2KyAD8w0lLgrFelRa0BX8NcqdyrgZ4XNjs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rLNvY6nfXsRW/ucLw4kc0vDeYaBzNAF0+TOZpV6APO0xiGXM4U16LzDs/YdfcZAatsPgQW7Zi02PiJXvVlLOr4DMvbXFBEFpmiUrHKy7Qcnz71bSVHvd3DKV6+PxBzRI6qquzZ+HuwGst3BChTDI3jSHYBU6A/vCWttx3fav7DE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=TzKbUsYx; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e96c77b8dc1so1194695276.1;
        Mon, 25 Aug 2025 18:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756173476; x=1756778276; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=WGzUuOtgiIDZGYqyc4niKfZa1KTffiDbn6vc4yrAiuI=;
        b=TzKbUsYxt/rSc/TjsMcJDD4zjheF0q+Xmhiw9GpDUeIyiRDkFAvg2ZUOPeh0980QvR
         2ZXBLGfPtbioil6eVNvT1T9LMAm41aJ0gpRfu8gcMAqLlI2CpODHGnds6211rtr7pLzp
         KtVa5qR4UA4mbrkywdv7NMEfmHkkV/VABEuTyTjAsNC2gWIVZvI/kIa6htGvU+d7ryhX
         ROv2vYpg8q41oLvyzXwdPH8qUH7Y+W2uN9AIeCiZTkjR8m1wItcledvSS75LUnMR5UAV
         dsItDqWdRdJppRucbd9ERPzSPVC/TSz2DgCMr5v+UGlX2ZAxoOFYvcslfU88cCHDSKzD
         sZpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756173476; x=1756778276;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WGzUuOtgiIDZGYqyc4niKfZa1KTffiDbn6vc4yrAiuI=;
        b=jD8Q9P+veIGN1xwrw+P+knkuHmKO+dHQs2+mWjSM4gvYaRT29xY1MyWBLdwRpKGrUE
         DLg4FxMPzXIsZwvpek88MxepC/MclE6T3bpCe//B0y2ENUYNNN/Thnh6KuNLjaBkz8DJ
         x42fkjDh7mnU9yO+9289sCiaJ4HTn/kP+OraLhbzjWuxKi/W7g4k7S6qt/Utdm7Kh8wX
         yZ6P7z1q2rMy3P4SZA7YHkC9j1+1MXB+6OVzoUXAxwULRljV8sPwdXINRJPiiEuNv0+r
         A71QVtLWXEmEt8+5L2qzqxLYLLCpcUUrh7VYvZnCCWi3bRWVfxcgHGOn8aZfh1hjGzd8
         hpnA==
X-Forwarded-Encrypted: i=1; AJvYcCWDIAiDHd95k8UuaN8mGq6UGWdlahCCxIIX4wXEoFioUwABsU9/oWHI7BVCC3UQrMchasIlVw7bci63SiPZ@vger.kernel.org, AJvYcCWP49lS6IesarWV3friy/dInzvsMJFDfZjCDDaZYE6vye3tNu3K2FeuDkhpzOaI9H5RxZZ3Bn2g38RJcA==@vger.kernel.org, AJvYcCXWOjU1NGTDIXpSyy22jY1luaBW+3NbEmRHOhb3k0X0yNz6PrFGQmNaBuW2R8dJif57pgAyvjWUBMgF@vger.kernel.org
X-Gm-Message-State: AOJu0Yz0sqyGYUcNpCGhP4Ob97HPAlIksgUxh5j2fl91TWJLQSqNZNu7
	+6lkvR+k/oFxxCE9nazezJVwrASktvGGDKwLpy562UGdUY6cn8jWm3LX/w928ghzBOwJ3hrO015
	0Gk5P8vFqd7EXdGCXKLaBLtKD7v9no3hVWg==
X-Gm-Gg: ASbGncvqWA6nSRGke12DQdF1aBQfo/f1LXtQurRLFOgfWeOTbICxf2Sa0e/K7uWkNAZ
	F9UjaHUaCa+I31aqRIs5RiaTOG41HoMbhpruwPa3kIPVNOVe6LJKQfYfcNoDyX/4zOfF0tuxC4V
	JAM7nCx67WhTsp5soACJJisnn3YN1A9ZO+rxkIEKVcrqYVi1Cw1OBLSg8kz7F/fSBKHsWcz2nGL
	UolNyxyvG4Hmwi3ZPbUzvDfSOLFU2/ENbc51bXJ++qFNcV4CKYxCppqQtm2F2cNhVZhonI19EZ/
	4Aeisg==
X-Google-Smtp-Source: AGHT+IFfyuSfKOrinrXKhXAscdQLNk2jhywIHMg8w6Be6P0uEmW6nfWxCJ0lVEYWuVzh3vDojbOberGKMV91mQSrLXo=
X-Received: by 2002:a05:6902:600b:b0:e95:2d88:513a with SMTP id
 3f1490d57ef6-e952d8852fcmr9666163276.36.1756173476124; Mon, 25 Aug 2025
 18:57:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250825044812.1575524-1-rosenp@gmail.com> <20250825044812.1575524-2-rosenp@gmail.com>
 <20250825-clobber-disdain-9e50d85ab1df@spud>
In-Reply-To: <20250825-clobber-disdain-9e50d85ab1df@spud>
From: Rosen Penev <rosenp@gmail.com>
Date: Mon, 25 Aug 2025 18:57:38 -0700
X-Gm-Features: Ac12FXyRhTW5a8l2A5nZHymS4qhy8hJOYEjTo51J0bZ-dMOqKSbdtxy2kV2Vc_o
Message-ID: <CAKxU2N9y-2eG2nz-ng9afuv-rT=agBt3rE7P3dFfybcHzhndWQ@mail.gmail.com>
Subject: Re: [PATCHv3 1/3] dt-bindings: net: wireless: ath9k: add led bindings
To: Conor Dooley <conor@kernel.org>
Cc: linux-wireless@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Aug 25, 2025 at 9:38=E2=80=AFAM Conor Dooley <conor@kernel.org> wro=
te:
>
> On Sun, Aug 24, 2025 at 09:48:10PM -0700, Rosen Penev wrote:
> > The ath9k driver has various pin GPIO numbers for different chipsets
> > which are not always correct for every device.
> >
> > Add bindings to specify the correct number and if it should be
> > active-low.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  .../bindings/net/wireless/qca,ath9k.yaml         | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.y=
aml b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > index d16ca8e0a25d..bbac017d34d0 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > +++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > @@ -50,6 +50,18 @@ properties:
> >
> >    ieee80211-freq-limit: true
> >
> > +  led:
> > +    type: object
> > +    additionalProperties: false
> > +    properties:
> > +      reg:
> > +        maxItems: 1
> > +
> > +      led-active-low:
>
> How come you are not including leds/common.yaml and making use of the
> active-low property defined there? Seems to be in use by mediatek,mt76.ya=
ml
Probably makes more sense to use active-high instead. Will do so in next se=
ries.
>
> > +        description:
> > +          LED is enabled with ground signal.
> > +        type: boolean
> > +
> >    qca,no-eeprom:
> >      $ref: /schemas/types.yaml#/definitions/flag
> >      description:
> > @@ -102,5 +114,9 @@ examples:
> >          compatible =3D "qca,ar9130-wifi";
> >          reg =3D <0x180c0000 0x230000>;
> >          interrupts =3D <2>;
> > +        led {
> > +          reg =3D <0>;
> > +          led-active-low;
> > +        };
> >        };
> >      };
> > --
> > 2.50.1
> >

