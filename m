Return-Path: <linux-wireless+bounces-24993-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E4D2AFD7B2
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 21:56:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6F6913A1829
	for <lists+linux-wireless@lfdr.de>; Tue,  8 Jul 2025 19:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 342D323AB95;
	Tue,  8 Jul 2025 19:56:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I5jVEdBh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A42A18E02A;
	Tue,  8 Jul 2025 19:56:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752004571; cv=none; b=Ft0nQiU6Cz2xtGi/IP6wSJlmbeSzOIAjAbOH8UPQvveKKbqLd8mEWIBPQCjIdWcH6C+DB/vHA3sCoVBtvwBHs/kp8S5I6BdW8IT5BfFdbRF6+t9XCsJEJRLwgLh0BOVg+4erZJwLeS9gz02NfwWDq881hDtf5pDIqNwDAPHk/40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752004571; c=relaxed/simple;
	bh=jUWBRe3iRDoQXRRk311xSOHvhXGde8JAOo6mW5QTuxs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=jnwNJC5IF5AhQNju31eHjmY3CD6p60eOzlpjHBwINIToID4Q5KkqhDR6o6hroH77qYDHuI+zyJYC3zEfJ4Zu/hjwqmYrIL48vPkqg/1K4B8El7uSV/3CoJdFfphhz0jIPZoNR6n3Gs91RjyC+RWy6WCda53crPwe+MxuNXZA3X4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I5jVEdBh; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-714078015edso42891237b3.2;
        Tue, 08 Jul 2025 12:56:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752004568; x=1752609368; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wruTsCuKvKaETBLWdKH4PD/aur092+ZnEJpoT9arrX0=;
        b=I5jVEdBhc3HS1ut2afZ57zOeFUlAxIFZJ8Kdr6pPdvc7QbovstCt6EZqOFEGS7dFkv
         u+I2CFcY7/rRaygejs7vw0ynluxh2yUQsLdFe4dYQTyXP5G3zNyrxrBg1okoEKTzVmxW
         OxLUToRNxxyaml5UOkmXzKRhwrVjcvA6sFjGjtCXTsCnWiOF8s4nHbc4W+jiwa3Ov8Gb
         ByPQ+cafmuYNPF8nb7oO3Vz4GH4M50n7mWLHoe15M1n69ustGBBkvdN+DQTGU54RQqYt
         BKRZahRD3vvwtbl5rwiLeOBDYJqlOkJAayNThuY5vjSaqJO1djTGTINMOmR5H0chRXub
         1N+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752004568; x=1752609368;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wruTsCuKvKaETBLWdKH4PD/aur092+ZnEJpoT9arrX0=;
        b=A7rZN7jmrAz1BD0m5tdvs77NIWyHDFs5zLU1u6N/ZOT06EjExJipJCd72YrA+tZUUp
         sO8AUOGl2QR1iiUaFjIFW1wucUGImIBN3ckvO+UJURBSYgdcXwUGZXYixNXaatHZgkuu
         I39Jd1PL24Igu7Jz3iVrnbup7WgU7qnjtr9vovJbqNya+9XnoHCiX00dUoGca0tl3d4O
         4RmQlZ9aMw2XOM9p69yq9Sff0/BWHcDTsFJL8KcInFXyQVVKtn5gT1pCK46hbXmOCApT
         K3VD6j1yC4ukUhy1Etoabj/nAO6TtWg6ElUKtuq0VVOnvwqkfGq7u2dArdJRkjPjRLtd
         sABw==
X-Forwarded-Encrypted: i=1; AJvYcCW4eQC0BlJdHziw2yAANtqhq095n362o979xt615Joq3D/lEEHkEpplyy4ZNRiKj7Ew/eKHD/r6HTIRdcez@vger.kernel.org, AJvYcCWf4/oFUsniRwH0dTqKThlXJaV4wBwIoLlUI2QaIQDZBzl7Q4bqZ9EtAex5S/KkM3YolvCGa4SDqxx+@vger.kernel.org, AJvYcCWzsevFah6i0E8EO2dGngWOQLPGQnrndDsHwLoeF6p/wPeZwjdjc90pBQ8T3Nj57u8niq5ZmB5F3URkEw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yzd/Rt6ZJPYlgQFn1/3EliKNotVUKIaRY7pZLkPr9vfboV+9Z5x
	qsPpEbv4KfsM3M3l2TvpxqSWObq8op27UpiJ9PWD3sQVqjU0z1eQv2kVJvQB8HSEjwZ9ki7xy2y
	8dklSj0bk0UuhJWGAdCqwTghk7NIE4CjfbIyiXY1A9w==
X-Gm-Gg: ASbGncsMg019DCnaWAJ1nImLPBKtnh6kLttTATFW9TNUKchSDZEgQThXLLHP6pTnDjO
	oqQ1TShaK00vaRT2MoCIXoh73vzBri00JNppka+tNPOM1LseSpsdmlj+oKAF5lktgWA7oaoMEWE
	jqw8dguJI7bQKAULDMflgvv9MvbLa7vK4z3c9c1OVah4ltA+8D8hoR4mJj
X-Google-Smtp-Source: AGHT+IHV3WcRVetEt/pXYpJBPnp7CoKd1YQLzSqdVXAfvRiB3oYyGXRiaCQKdnq4XcQzLIX5Z1zNPpu10KNmNf36jIk=
X-Received: by 2002:a05:690c:9511:b0:70e:143:b82f with SMTP id
 00721157ae682-7166b69ebf6mr206027377b3.32.1752004568588; Tue, 08 Jul 2025
 12:56:08 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250704214219.18796-1-rosenp@gmail.com> <20250704214219.18796-2-rosenp@gmail.com>
 <20250708172617.GA652174-robh@kernel.org>
In-Reply-To: <20250708172617.GA652174-robh@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Tue, 8 Jul 2025 12:55:57 -0700
X-Gm-Features: Ac12FXw8nv5PL1imX1j4h3MXzepe-GV6FqTPsQU6x-MvYBqxDxyGEGW5lREzbCo
Message-ID: <CAKxU2N-KwwFy0No4U4Ssg2e09Bh=xLD+CqvAN-LTET0uHMdNGQ@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: net: wireless: ath9k: add led bindings
To: Rob Herring <robh@kernel.org>
Cc: linux-wireless@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	nbd@nbd.name, jeff.johnson@oss.qualcomm.com, 
	Johannes Berg <johannes@sipsolutions.net>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Conor Dooley <conor+dt@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 8, 2025 at 10:26=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
> On Fri, Jul 04, 2025 at 02:42:17PM -0700, Rosen Penev wrote:
> > This is used to override the various defaults the ath9k driver has for
> > LED pin values.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  .../bindings/net/wireless/qca,ath9k.yaml         | 16 ++++++++++++++++
> >  1 file changed, 16 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.y=
aml b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > index d16ca8e0a25d..58c7b873cecb 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > +++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > @@ -50,6 +50,19 @@ properties:
> >
> >    ieee80211-freq-limit: true
> >
> > +  led:
> > +    type: object
> > +    $ref: /schemas/leds/common.yaml#
> > +    additionalProperties: false
>
> You really don't want any other common properties? Like defining the
> function?
All of this was copy/paste from mediatek,mt76.yaml , where the same
binding is used for mostly the same purpose.
>
> > +    properties:
> > +      led-active-low:
> > +        description:
> > +          LED is enabled with ground signal.
> > +        type: boolean
> > +
> > +      led-sources:
> > +        maxItems: 1
>
> This property is really for cases where the LED source is configurable
> from the LED instance. If that's not the case here just use 'reg' for
> each instance (assuming there's more than 1). I shouldn't be wondering
> what the h/w looks like though. Please describe it in the commit msg
> rather than what some driver does.
>
> If you do need led-sources, you should define some constraints on the
> values, not just the length.
The original downstream version used a u8 for the number. But again,
I'm just copy/pasting.
>
> Rob
>

