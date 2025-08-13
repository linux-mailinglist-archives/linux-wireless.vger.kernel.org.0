Return-Path: <linux-wireless+bounces-26378-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D7785B2572F
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Aug 2025 01:04:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FDDD72845F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 23:04:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1422D2F3C27;
	Wed, 13 Aug 2025 23:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkpyQYqp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f177.google.com (mail-yb1-f177.google.com [209.85.219.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 046E02D46A2;
	Wed, 13 Aug 2025 23:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755126283; cv=none; b=VPiFuMqBXFz20W3AU+MZobmoks1r53/+yroUxP0eiIULvDRe6mMxl870GB7pxkjd2mF7rMNqAdyuBm5O6tQy8fFmi41E5+lbNRrb5OI8yYOZLdpLwbiR3Niqprwb0xqoXOthJC3QljY9PHZ+f2+hYuQ0NwdZefISXsIlo/v7lLY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755126283; c=relaxed/simple;
	bh=u77HgcnqZUI0DyTMAuYCiDcC5lkLJPB0fBe76X83Ga0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iB7W8v9U/fUqrhqVWmI6oMhca0e9iDOSu5Twjww+55se32Xi03gi8GfTB/GxqKyQm4fnpE8d4gJhFDfz1EOCfYTP1OZIOgqvL60MugY7V+dObieUYTCSaoquJ2UPOc8b7cwU/KXDJwiNw4w6WBCOKlNdUGxg7Lb+HTV/EZ2CEtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkpyQYqp; arc=none smtp.client-ip=209.85.219.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f177.google.com with SMTP id 3f1490d57ef6-e931cddb0e2so328261276.3;
        Wed, 13 Aug 2025 16:04:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755126279; x=1755731079; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Pr9Kj1G07sBFKVdkwu1EeIztDNfpAGMBwPb2yvwQO3w=;
        b=KkpyQYqp/ltXTtI0h0sg4NA5oLpKj4Bja8frcNEWptyVSBGwU2FcHuk4fleLIbcxW7
         hILs/4UdlHHIyXVqzPLplE6YZ9YSD55szEd4tebLYD2cUSpWWRTswIRNcKMN36AZltoq
         IwAFWCipMYr4pbTbIdB/ka/bZNsdqOLXtxnlNgQ6r2E/dVRIfYo8b0PpaAV1Zo4NmuXD
         wCjR5d3GMc/MyUkrePh8YFL1su4NjCnecxukHPbSKMgw7wFotlQzeTc/6buPb9xn6Uk/
         rxkaIt61xTVlaLOH9nFppnTOUjA5X0bzwYkTxpi1vtTZO6oaH1U9VEMwk237p40wCoW/
         bQDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755126279; x=1755731079;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Pr9Kj1G07sBFKVdkwu1EeIztDNfpAGMBwPb2yvwQO3w=;
        b=oHy0H8HycN9vF5jeoIYcQ6kKK094jPZ92/tRCfTV1yFhtimx86M9L+2UzTpqbqDjXU
         HLNbmONMFaVJdZpLoZ4y3QlN4+jZ+XlNQitGlYDcFI7hRGZEAVhYTTACktLGJDbfbsuV
         KpjUOvq5oRjUltKlGbEGm0/pVZZHf5MBzgb7RO9GAk10VQIboYe7/LfRyVJLELqmac8E
         2GKdnPQQnCKAejLU3PKcBYC1UBdSm6KWfzyp+c6LLYpZ0QWAD2GyKS/DQmDVUMMYD5b8
         WQu/4EOIIm5IlzyKL1sApAKSuO4s1oGAYMs/3IEcJEK2sAXD0s9E1a9qjSoyZgqyFnff
         s6TQ==
X-Forwarded-Encrypted: i=1; AJvYcCUxm89yjjEsz76S9uwHglaYwkFpApYGmPY4OcufF3YrxoLDeiA9A7d2tk6ZeGXdAS8pimJZ3QA9tZR2N8T8@vger.kernel.org, AJvYcCWcrIaz+oCLKmbF8DRkEKx2rEpnhdV6A1AaTMWUsomtwy3s5rHTU16XkJ5W70+Mbz6z6UJsbs/xMtyfdQ==@vger.kernel.org, AJvYcCXO6tz7l1mQ1p2a+OlyICkeLBRiMz4K5ma64bmoTyB7NKnLdttWGSrBB+JEKtQQdrFBO5x8bWiVLc8z@vger.kernel.org
X-Gm-Message-State: AOJu0YyIVhr+4ZGBq4183R0Il32cTIY3eMQdslnZ80gkRGyjGsLN6wAH
	tTa1I5mOf2TD/6b5zKynLGeo4tcBiX68uLXGAd+O4KWW/22Q/+U2laCNNzZwnTNhe5CornQ6/Q+
	9gfv9W7QnmdBbA+3OtqOspeAPnJH48ik=
X-Gm-Gg: ASbGnctYKP4ZRhY7sGhOkYqz8FAlIqZTS5DvLrYRW7/IVcFS6BbQDruAJsXG7suIgjK
	OeNaI0uv3uRMlGAa/IPxakmyDdebRyMA8UBW61vpE7YwlkGa3nUtjHf+rmZ1HdvGgzobSwBc/V6
	eiznqGfco7Wt28xnUfk1a+Kdx1KmuomqIcMTXOJh6n41WAypYaqP4L46tNJBNs/st01LtyKwiWi
	Tvap8SO+W5bCtpsQoH9
X-Google-Smtp-Source: AGHT+IG7lFQGkxo260R40BXsMXP2dO7WlFpphAJUK3E5r/amKiJyMYB2CNZKh93w2y97cKZYxB75AvRAwHVMH60IMsc=
X-Received: by 2002:a05:6902:26ca:b0:e90:6a88:eac0 with SMTP id
 3f1490d57ef6-e931e24f7eamr1050134276.38.1755126279152; Wed, 13 Aug 2025
 16:04:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812192334.11651-1-rosenp@gmail.com> <20250812192334.11651-2-rosenp@gmail.com>
 <14f0cb76-1694-4330-899a-7565af0dfdfc@kernel.org>
In-Reply-To: <14f0cb76-1694-4330-899a-7565af0dfdfc@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 13 Aug 2025 16:04:27 -0700
X-Gm-Features: Ac12FXyys9GBy4gP4fGG0TS-5bObcQEdpHAmr6F9oGDkOu-nkxxKBO0SLtnWMho
Message-ID: <CAKxU2N_vo9NThjGaiX1Fq5jet0vdw390ZYpVct4=XPa5gwj-Kg@mail.gmail.com>
Subject: Re: [PATCHv2 1/3] dt-bindings: net: wireless: ath9k: add led bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-wireless@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 1:16=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 12/08/2025 21:23, Rosen Penev wrote:
> > The ath9k driver has various pin GPIO numbers for different chipsets
> > which are not always correct for every device.
> >
> > Add bindings to specify the correct number and if it should be
> > active-low.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  .../bindings/net/wireless/qca,ath9k.yaml           | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.y=
aml b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > index d16ca8e0a25d..e701046146f2 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > +++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > @@ -50,6 +50,17 @@ properties:
> >
> >    ieee80211-freq-limit: true
> >
> > +  led:
> > +    type: object
>
> Each node must end with additional/unevaluatedProperties: false. See
> example schema and writing schema.
>
> That will probably lead you to missing LED common binding.

>
> > +    properties:
> > +      reg:
> > +        maxItems: 1
> > +
> > +      led-active-low:
> > +        description:
> > +          LED is enabled with ground signal.
>
> Aren't you redefining existing properties?
I don't think led-active-low is specified in any central location:

Documentation/devicetree/bindings/leds/irled/ir-spi-led.yaml:  led-active-l=
ow:
Documentation/devicetree/bindings/leds/irled/ir-spi-led.yaml:
  led-active-low;
Documentation/devicetree/bindings/net/wireless/mediatek,mt76.yaml:
 led-active-low:
Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml:
led-active-low:
Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml:
 led-active-low;
>
> > +        type: boolean
> > +
> >    qca,no-eeprom:
> >      $ref: /schemas/types.yaml#/definitions/flag
> >      description:
> > @@ -102,5 +113,8 @@ examples:
> >          compatible =3D "qca,ar9130-wifi";
> >          reg =3D <0x180c0000 0x230000>;
> >          interrupts =3D <2>;
> > +        led {
> > +          led-sources =3D <0>;
>
> Totally confusing with schema. active-low in one place, different
> property in the example and no source for that property at all :/
Ah right. Will fix.
>
>
> Best regards,
> Krzysztof

