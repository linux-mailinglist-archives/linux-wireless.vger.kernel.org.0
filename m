Return-Path: <linux-wireless+bounces-26843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3CAC0B3B096
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 03:48:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F09BD468665
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 01:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 376F319F43A;
	Fri, 29 Aug 2025 01:48:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DTdTT8xX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAB3282F1;
	Fri, 29 Aug 2025 01:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756432083; cv=none; b=N10EwUuMwY/k019pKNRNDnEiXCoziFLbn8FyLlcXPxqyqf06zUbGHXwSiwedPClNNJtG64k/xbODqVaqPQ+XOnNba/7+LhAkTPWQ2UVi97Cit6J6TyZyY5Nzv4ZTa0EO7T6Jz7ny0EyBrJhzNQq91Hop1PKZN9W3r9xztAnpZx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756432083; c=relaxed/simple;
	bh=m+73NuZ98uHxV1ACn3ixYRd/uju6S+4m7HnGvSX2Rl4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YNKhv6zil2D3scYr3etxPAdjRiSHjwnip6Iaqde8gwhdyMhYNlgmuZv8uXJJc+PNiQnNQr/DecZK/pNmrvqjK/CC1peca/92XX1004GvSSH1DOmhwfe3DjwYtnC4NUVg/g0SoRrx52cF5ITpGIhPbEO6ZvoTlbpAkDuB/QolOWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DTdTT8xX; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-71d5fb5e34cso15501257b3.0;
        Thu, 28 Aug 2025 18:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756432080; x=1757036880; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eAbrzldm0WGdVoskxN34NZRa6TWzFG46zDfioa5p624=;
        b=DTdTT8xXgCrBmev0bUW3bPaAODnzX9ULBUf6QIa7fE4wpoCXYzhBTt3wtXdG38b6MZ
         exFoyf/sBHezP81FTr4TDU4ASE26j4l2tfMSCDGQ4k5vQ6CpdRe+h8e57v0zlbWkx2Ay
         lCY+B8z1WQEpVVa1MK+TeXr5E9FvoFj0CTW6/e+ptOXZCv7zuUS3YG80+C0pRGR6bDL6
         MeXmUk+WmtcFQk/mhPR6MnK9DuhibcenL5/FRUb4l1xliQ3v/v1KGDSkLVSDrilwDMGg
         Am91jcnVTks0BFKGUcXCXHMkp/bg8GENBT8Iz+lpqJa+9Fv5ukC4QQzaBO6C8K+d17l/
         KFBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756432080; x=1757036880;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eAbrzldm0WGdVoskxN34NZRa6TWzFG46zDfioa5p624=;
        b=CNex3/qA+7edoq9iTbb0z7asylIUXAvZAZfeaflQs9gxprgx3iTR4RQhXXYdR2UGbz
         1/JGFwZ4rb3nzY/Fp3D3fZu5tuDfZnASZaBx1hWUy9BSFIosvGTod3YrFIDp4RT+MxWC
         sQfG1TArfcOcdTNcDVPzt8KZ0LBXbW4RXFeOfd7yZck3LRIzNuLEdWM+BkkXXkCRBqvk
         Ddj8NoJY2Xh3Hs9+Oo0RLK4Dm4i/qsEm4+9loROEkI4VgptsmrAiWP8RYIwYLadxsV4N
         89mHx7wSfBF13/0JxHuc8NmkNpnQPQWNVu9w4/GE/zNoZjVjaIT2oDommsg1wftgZlNE
         o/jA==
X-Forwarded-Encrypted: i=1; AJvYcCUPQHpPUu8CDJ7Nd6a/BS6x72F9mWdBBQXHKo/HHykUwPVI7OAHh7/95f7OmW7U5JvjbRmmdnRNgkxwyF59@vger.kernel.org, AJvYcCVHgSTtKEGZPh8ZiRZGmuVlOnNJosUOKqBnUnemf7bKY+6zClRLRktIA2fV3k3UwEr4RqwsilbIAVKJ+Z4qJaM=@vger.kernel.org, AJvYcCVZzwGU1lq3zQMBuydHtXQpMKDMVN7UyzX2q7qkq58BjXHl6iUK94othnucdjgDLNf3V5lL9C+Qx2hJ@vger.kernel.org, AJvYcCXj7vus1OgE44sAoCB8Nk52EjyrfHMsR4ND9PTClx6t7MkgvikzzUzZ/GRe0mAFRA95gsxMxFsBOMVTgQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YxsqrNBAjRg8FbRGc87gZ53FiEguCAgw2ItthYYAGsz8TK69+vB
	L4P/rrMWL7vSkptaevbYl4/pl7CJ1eg8OGgdlVAGaTkk3b6tWSOqoXALcU9TD3rEZmTCtBb+PG/
	cGrtGJegC4QxKIKA6h/TUJmM2/+OgGuu24g==
X-Gm-Gg: ASbGnctGSn5v/ZyvThxuQw57fDIK4y7ua+p9ijvnxUqPtOKrkjV4RSo/nyBraQ5MaXE
	HaLUz/KXzqEuZifWGjl7iwo1I4WGMZu+XdIqKHq1vU2YFbhykR9zf5UG6EtTGRcuTM4YSbfPwi/
	CznFrOBaHvvia9+L4DFVakYd0ZJz8tJ6gPvotjxbX9QuxK4tqzB/StUchmqAz78Xmctu0aCcT1r
	EVAOGs9THHBmqnai3Fsb8WK7Ahoi+EOer41Nmx4LlJx2bsbMejCAZN2GsIECimw+2NNrHJxLq8s
	HaizbUKpEzGZeB5e
X-Google-Smtp-Source: AGHT+IGMTIxu4kuEAWCsjAG+nc++zNM6b7g28X8nqakbNWRy0uEGr3uqKYuDslHnMVWeT5ZH0ZAgF0UrA4MuoRiCKLw=
X-Received: by 2002:a05:690c:91:b0:71f:9a36:d330 with SMTP id
 00721157ae682-72132cd7b92mr157296177b3.25.1756432080506; Thu, 28 Aug 2025
 18:48:00 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827005658.3464-1-rosenp@gmail.com> <20250827005658.3464-2-rosenp@gmail.com>
 <175638709817.1370637.10754263567298002001.robh@kernel.org>
In-Reply-To: <175638709817.1370637.10754263567298002001.robh@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 28 Aug 2025 18:47:49 -0700
X-Gm-Features: Ac12FXz7dQN4Xh9ONcujdNNl25kFFY4GR9Z_8gx4a4ibzUsLaZYZWLH9f8kDwiI
Message-ID: <CAKxU2N-Zfme=84rqxQ=uJro1YMeFGorveT-uRhx6_HpJmB-fxA@mail.gmail.com>
Subject: Re: [PATCHv4 1/3] dt-bindings: net: wireless: ath9k: add led bindings
To: "Rob Herring (Arm)" <robh@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, devicetree@vger.kernel.org, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>, 
	linux-mips@vger.kernel.org, linux-wireless@vger.kernel.org, 
	=?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 6:30=E2=80=AFAM Rob Herring (Arm) <robh@kernel.org>=
 wrote:
>
>
> On Tue, 26 Aug 2025 17:56:56 -0700, Rosen Penev wrote:
> > The ath9k driver has various pin GPIO numbers for different chipsets
> > which are not always correct for every device.
> >
> > Add bindings to specify the correct number and if it should be
> > active-high.
> >
> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
> > ---
> >  .../bindings/net/wireless/qca,ath9k.yaml        | 17 +++++++++++++++++
> >  1 file changed, 17 insertions(+)
> >
>
> My bot found errors running 'make dt_binding_check' on your patch:
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts:92.1=
5-25: Warning (reg_format): /example-2/ahb/wifi@180c0000/led:reg: property =
has invalid length (4 bytes) (#address-cells =3D=3D 2, #size-cells =3D=3D 1=
)
> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts:91.1=
7-94.15: Warning (unit_address_vs_reg): /example-2/ahb/wifi@180c0000/led: n=
ode has a reg or ranges property, but no unit name
> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: War=
ning (pci_device_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: War=
ning (pci_device_bus_num): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: War=
ning (simple_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: War=
ning (i2c_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: War=
ning (spi_bus_reg): Failed prerequisite 'reg_format'
> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts:91.1=
7-94.15: Warning (avoid_default_addr_size): /example-2/ahb/wifi@180c0000/le=
d: Relying on default #address-cells value
> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts:91.1=
7-94.15: Warning (avoid_default_addr_size): /example-2/ahb/wifi@180c0000/le=
d: Relying on default #size-cells value
> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: War=
ning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_a=
ddr_size'
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202508=
27005658.3464-2-rosenp@gmail.com
FFS. These reviews were garbage. The next series will effectively be
the same as the initial.
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>

