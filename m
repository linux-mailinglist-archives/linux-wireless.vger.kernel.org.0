Return-Path: <linux-wireless+bounces-26377-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B79EDB25721
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Aug 2025 01:00:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 03F9D9A583F
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Aug 2025 23:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5DE1A30148B;
	Wed, 13 Aug 2025 22:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HfteWLM6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com [209.85.219.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B99B4301482;
	Wed, 13 Aug 2025 22:59:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755125984; cv=none; b=RrYXg9XC6jUNWPr8xVqQuR8nFZLW9tA8LdPkPOIfrIYyIxbo56dMxYiDXl/6kzUR6BuIn7XHrSgzTYmAQZdQEA5i/JRSr8hMiTFqV6HsXmAhna4y6bv1EZ0jbI0sI3Za01+CyJQX3GZtGTaMFbhtu3C5AzxkZ9BEIhYBIV/vuQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755125984; c=relaxed/simple;
	bh=TdSADy9WSIwy8LeBdw/Py9AwRdV3n6oC1LxiSY3ePo0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NlpngHJvxyB8r/mgw1HBQTwr4/xXGqFGQmLg2673KXn+9gN61ygXhWwRapGZac0xHCbpdhWg5g/+QvAgfLX4dzOmVnYsyF3q5ynvhr1LqFOdOM9dImyufRMzfyS7/WzPgCJJCSGc5JaMayEtyJrDzuHIMIpJnaMerOiXpCEO82w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HfteWLM6; arc=none smtp.client-ip=209.85.219.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f178.google.com with SMTP id 3f1490d57ef6-e931cad1fd8so411912276.1;
        Wed, 13 Aug 2025 15:59:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755125981; x=1755730781; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QtTnM1+CJ+t+7tyle0R4QX3bifvSoN3Opl9NJd4e/Wc=;
        b=HfteWLM6QHCmK6WApONAYYNSUsFWXq46t36QlpZokvUecDyT6Asda92xdGc3NeHMVJ
         Bzhly+WdgkMqxRTjYWR3FDxKxTcClGCsugl2eh/8iKswpwjvnmOOeI8gQ/2cVWbrJs/b
         l1Lf3isWhnFEM7VuhfLqIjOBLogxaoTzWF8YZR94Tdfl7+TtdfqQ68TRZORpYdFioSUz
         foDyUSuTra7nOc7GlS4qbFGi6saCRllw5nvBLCygewua2gz1eeQHKZ9Uruw8qEDnDbJT
         qBkB86GnEDMYBNOZDuUtDOYnTA2YEngmtqv3OpxWdf39ANMIN26IMsZlZH7GlMkjvXXa
         X1xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755125981; x=1755730781;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QtTnM1+CJ+t+7tyle0R4QX3bifvSoN3Opl9NJd4e/Wc=;
        b=ViPyCuX8CK68YjdMZhZVIpsFf5D2caAiyZaoeTnQSQiLpJsujokvsmmzys+K6KK2AG
         iEZVBMFw9OFP1Z7OCLlZH8gPwLU5aWwSuw0tQZhpfD5Qn696mKJ3HC0wT+js2UAITZuz
         97ABZvIWB0hfCeJHkpvc36FJ3Z9DuIPp6b4vJSfTXShQwqpQ0/z31ZiWASpA3JI+A1xP
         fOA8pJvaeBYz86t2+PuCvZ2pFlgaKCKn9UDLdOqaRhZkjDOa1pW+UU/3cgl/YSESSu8S
         EFzTzHgU4n2NeEG3TURT7X75GVMlMYbGGsZsTtTAMg16tczqVH3QkzYS4CWpFf+RUxMi
         5IbA==
X-Forwarded-Encrypted: i=1; AJvYcCUFLrvjrQCYmbf04auJA/K8fvG/FgOpKbXemvdd5DEmtCYwruNNFSMBaoL0uw5tK8mt+UaJuhEz/NDn@vger.kernel.org, AJvYcCW2iWypR+68983sQVtusp+a8PHzhDd2KZa95cO4fs/tdL0nWKqskw0T0rQsW73ofbsG2QyaOS30V2tzsokQ@vger.kernel.org, AJvYcCXJcHAm8tgKQbxQrvpiRmBNWpoDcTUnJLruiQLWUVTw6XIGaWFc6cKuqY8Avro0llD/pJwXpnoAXDz0VA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwJyZbexxDrYIULeQ0LhO5+lk9bFVzf85PVBXmFNt0m/PHarGOI
	rP+cQHuj/jY/AHUdjDouf1IYuvmweA7O+aK8ZSk6cxS2744Hxc3R2IxcSk25ak+beWUbuVdq4dM
	sJwwmikBG7NsUEFtvn2GUN45XJCfBBA0=
X-Gm-Gg: ASbGnctwFVBOQYln6Z+aL9T8EKHgEGeoIMTGVl+P4weFrltVVPiwmnVLwLELjyfJr2A
	gp8X4IH8qTpKsoWb1OsCgOSv+KDoWJyOptQZGfwcbgsjTZqpDE9YKs48PJkzv1FRBU/y0vHDGvK
	UHhP2A8HnlZMfTqKUSh0vg/0NGM+RWEog6PTsRILUReYdi5e7iviQOTNUqQsJwkj0iaVCTM8zJV
	d2t/AILMczq4PmNKHjb
X-Google-Smtp-Source: AGHT+IHz6cMdKoBKos1cjzDtvv0n4P3nLNY03qBHg5Te/w/fGQ2cqg9xOl/zHfAh47QzVnBW5MfyXVGk2B8a5Jg+1qU=
X-Received: by 2002:a05:6902:1147:b0:e93:cbf:d6a3 with SMTP id
 3f1490d57ef6-e931e29a974mr1068859276.45.1755125981503; Wed, 13 Aug 2025
 15:59:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250812192334.11651-1-rosenp@gmail.com> <20250812192334.11651-3-rosenp@gmail.com>
 <74d5ccda-89f7-4ddc-9574-ba7e8d4a2488@kernel.org>
In-Reply-To: <74d5ccda-89f7-4ddc-9574-ba7e8d4a2488@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Wed, 13 Aug 2025 15:59:30 -0700
X-Gm-Features: Ac12FXwuaGBEmons1V4bomDQpdmTS3Bsmn8qcg9GPzJP08kaQ7GBvYpHfCMDzn0
Message-ID: <CAKxU2N91q=d_c===x=AL+pwXkz8K1B8eXj8ePfm6dK_4cAk9Gg@mail.gmail.com>
Subject: Re: [PATCHv2 2/3] wifi: ath9k: ahb: add led pin OF support
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-wireless@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 13, 2025 at 1:20=E2=80=AFAM Krzysztof Kozlowski <krzk@kernel.or=
g> wrote:
>
> On 12/08/2025 21:23, Rosen Penev wrote:
> > The old and removed platform code had support for assigning a value for
> > the LED pin for when the default is not correct. Effectively a fix for =
a
> > non working LED.
> >
> > For setting an LED to active high, a negation of led-active-low is used=
,
> > as two drivers currently use that and no drivers use led-active-high or
> > something similar.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  drivers/net/wireless/ath/ath9k/init.c | 11 +++++++++++
> >  1 file changed, 11 insertions(+)
> >
> > diff --git a/drivers/net/wireless/ath/ath9k/init.c b/drivers/net/wirele=
ss/ath/ath9k/init.c
> > index c911b178dcc2..7826b113235d 100644
> > --- a/drivers/net/wireless/ath/ath9k/init.c
> > +++ b/drivers/net/wireless/ath/ath9k/init.c
> > @@ -662,6 +662,17 @@ static int ath9k_of_init(struct ath_softc *sc)
> >       if (ret =3D=3D -EPROBE_DEFER)
> >               return ret;
> >
> > +     np =3D of_get_child_by_name(np, "led");
> > +     if (np && of_device_is_available(np)) {
>
> You are open-coding of_get_available_child_by_name().
Will fix.
>
> > +             u32 led_pin;
> > +
> > +             if (!of_property_read_u32(np, "reg", &led_pin))
> > +                     ah->led_pin =3D led_pin;
> > +
> > +             ah->config.led_active_high =3D !of_property_read_bool(np,=
 "led-active-low");
> > +             of_node_put(np);
> > +     }
>
> Leaking OF node.

Not following here.
>
> > +
> >       return 0;
> >  }
> >
>
>
> Best regards,
> Krzysztof

