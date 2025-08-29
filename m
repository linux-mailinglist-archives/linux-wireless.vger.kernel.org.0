Return-Path: <linux-wireless+bounces-26853-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 839B1B3B30E
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 08:13:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FA45460BF2
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 06:13:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 594711FF1A0;
	Fri, 29 Aug 2025 06:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="emcXEQNb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yb1-f180.google.com (mail-yb1-f180.google.com [209.85.219.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA1A98BEC;
	Fri, 29 Aug 2025 06:13:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756447985; cv=none; b=GT2lnwzzC5D+ArPKglQQ9d7oLkdeNwBlfRl0JySQ8VGF7mfaxX9Pc8o/pSzdrTKqya50FIz61Vt7jsKwvkG6QeLCRjL4MkFF8aLOhsvi/ymGub/MW6fQNQCFb9IAgKtagytrNtd6mjtpXhv6ldcrmbXoG1KRhbuejV0gEJAs8ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756447985; c=relaxed/simple;
	bh=l91ux3+Pvhq5FZeurV7FijYDFgWSVXtEaVgdjXVEbi8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Mvw9DV/lF6jSB8UVZe9rcKclBId7mOVYZFK7BxXupzCG360v8nG3zO5d7OTdqySxrAKk1dx7s+ha1bfmq5Qt9MfVwULafY0v/46cye7B7efPrBSA8NgcvYFzgglM1r70uOVGuFwppBfV3MRZ2/pEfbnPn938Gr5NQa74XGGqkuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=emcXEQNb; arc=none smtp.client-ip=209.85.219.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f180.google.com with SMTP id 3f1490d57ef6-e96ff518c08so1395538276.1;
        Thu, 28 Aug 2025 23:13:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756447982; x=1757052782; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=l91ux3+Pvhq5FZeurV7FijYDFgWSVXtEaVgdjXVEbi8=;
        b=emcXEQNb/JtYGK2kcrITfMRPnm/o2/qJiDvJBtadV4lmOBWLbS6LF+29cLBHOtlPqU
         xLui0GAdHIpWpqupCMdmp3PHRH0H5StO0SK3BBZGM6dvfQDn0NE+xh4rrURL+u9Ladw7
         iJMHVnG4mW8akxWLTgNL9KhcDUQoj6qN4gjtN2ws9TEkduQA6h/hbH2ICt2C2q4j+pLi
         kGYbA2v8+RU7flY67p+QXrTZ/nai1fAi4DqT7gFq0EQP51sWE86pyRn0tB0jQ+sZBAx6
         bxyHB9+tpYY6UdBb7ABd7kV2QUbPcIXxmdI2IVOkiYGQ8uGS9zeZKHEEwPHixJyCu/dT
         GV3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756447982; x=1757052782;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l91ux3+Pvhq5FZeurV7FijYDFgWSVXtEaVgdjXVEbi8=;
        b=fTyKOJJRzif+DxRQ5KQEU4u+oEVaqi7CvOX8dfOY1JxnQNYosXiPn/IoFXZeNpFdG/
         FtDn0LxwlDHNIJe12Vou7RjINr6pM7NMSeVWDrUNdmeJZfKgabDlkU/bLzuIygGcXZiy
         ttWC7tz/p8UO9MkMXm4eVosNHgaeMctzZI+2GA/KmhNjOPHGCIzdBxqFFpBc7YZphLsj
         4/hgxAzd0Vvf5cafRHFAEeLmimAnop3xpismZ73Xsvy0X49JaXkLMWl/Bi5ru8Wv4Wqb
         kVLplYGU7t6R92RLOpg6bUn0TzcGwYd8Yb8GxgurXKvZEvZPEGtOlSWikFBCKXOHaQQH
         lTKg==
X-Forwarded-Encrypted: i=1; AJvYcCU9iAVcBRbI9bER2r62JRunuk21/RXwCSUGVsuLYoY4rjA5QD+YRtokLjy0a3CI7SVWIApeSOKZgnWjRA==@vger.kernel.org, AJvYcCVGzizzLIdCpscDRyAgU3UycoCY97BiPjMq+ciBgNAy1XEIRGFWSFW35WcS7/QOlQgDfe6IY8zlVWH5OKkXUHI=@vger.kernel.org, AJvYcCVZUXf9TL22SUf8ImqcfMpXT7YxEXJnuJmQ/x1HqOdM/zJ6SOSBdEx5iDgnT7xCeWcbUJcvEpobvrx99Uqi@vger.kernel.org, AJvYcCWNnwsaCsUbg5G9vN9JMn6f6wnjzl3faKEtGLc/FRy9HBJsKKky77KFJ0fllhSPA5P8hitcb4RS/5n3@vger.kernel.org
X-Gm-Message-State: AOJu0YzXnUIcWk3E8CdFZfyZlHZ2lYZbdhtstFcFIecVaVVQZexzCB6b
	6ZcMb1YzgSHmwtI+ZEGYp7m5EMvZcqTh0/yyXUJxtyz3hPzi2UhJB9rNPjbsVfubqhq32D5uCTL
	s0FqTavP5tE0SrivVH1KTD/KGMSb0B2A=
X-Gm-Gg: ASbGncs96v8u32NBadLTvMjNVuhbfzgJ/dpQ0Joi2fqlzXzGGlxFri7K8JKFMLo2EoI
	kKu9UJiT4iK8QAbXg5nsfCfq2blPKO5AX5jrI8GOnY9IVlZK6xD6PlYoLcPqMKZufCDorMutjlX
	EIwEZHpoD+6Mu/8UX4uJihzhQZVYPi0OEhFQU6NaDbsDMb99L51f5IwCPWu7PAUetDdTGib05Tg
	m+j3q9ybC+mMYPv8Bcr7hBiuhkjlOVB5AWZvGfFurYPSQIvjIyaQEpzW3iNyomsuzo7og==
X-Google-Smtp-Source: AGHT+IHSy/2BbuT5BBnMMeA82aFWaW+gHIBMJGQ0IfV06xy4CtgRumYMAtG4iaoPpvDBRT6Pc0nC8zl6L8hnzFloH+0=
X-Received: by 2002:a05:690c:892:b0:71f:b871:da32 with SMTP id
 00721157ae682-71fdc2d938amr354421277b3.12.1756447982321; Thu, 28 Aug 2025
 23:13:02 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250827005658.3464-1-rosenp@gmail.com> <20250827005658.3464-2-rosenp@gmail.com>
 <175638709817.1370637.10754263567298002001.robh@kernel.org>
 <CAKxU2N-Zfme=84rqxQ=uJro1YMeFGorveT-uRhx6_HpJmB-fxA@mail.gmail.com> <9208c440-f9e3-4289-9c33-81bb35383d53@kernel.org>
In-Reply-To: <9208c440-f9e3-4289-9c33-81bb35383d53@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 28 Aug 2025 23:12:51 -0700
X-Gm-Features: Ac12FXwKbnby6LF69ay3A5pTgzG023i-hm7L-4gqEAYIyg35KbPDvm5j_vKU5Rs
Message-ID: <CAKxU2N9o_jJd7mfVQE2yab5xX+-gKa8qB8hLkKJPqZq+YmzE4Q@mail.gmail.com>
Subject: Re: [PATCHv4 1/3] dt-bindings: net: wireless: ath9k: add led bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: "Rob Herring (Arm)" <robh@kernel.org>, Johannes Berg <johannes@sipsolutions.net>, 
	devicetree@vger.kernel.org, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, linux-kernel@vger.kernel.org, 
	Conor Dooley <conor+dt@kernel.org>, linux-mips@vger.kernel.org, 
	linux-wireless@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Aug 28, 2025 at 11:02=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 29/08/2025 03:47, Rosen Penev wrote:
> >> dtschema/dtc warnings/errors:
> >> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts:9=
2.15-25: Warning (reg_format): /example-2/ahb/wifi@180c0000/led:reg: proper=
ty has invalid length (4 bytes) (#address-cells =3D=3D 2, #size-cells =3D=
=3D 1)
> >> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts:9=
1.17-94.15: Warning (unit_address_vs_reg): /example-2/ahb/wifi@180c0000/led=
: node has a reg or ranges property, but no unit name
> >> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: =
Warning (pci_device_reg): Failed prerequisite 'reg_format'
> >> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: =
Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
> >> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: =
Warning (simple_bus_reg): Failed prerequisite 'reg_format'
> >> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: =
Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
> >> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: =
Warning (spi_bus_reg): Failed prerequisite 'reg_format'
> >> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts:9=
1.17-94.15: Warning (avoid_default_addr_size): /example-2/ahb/wifi@180c0000=
/led: Relying on default #address-cells value
> >> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts:9=
1.17-94.15: Warning (avoid_default_addr_size): /example-2/ahb/wifi@180c0000=
/led: Relying on default #size-cells value
> >> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: =
Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_defaul=
t_addr_size'
> >>
> >> doc reference errors (make refcheckdocs):
> >>
> >> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202=
50827005658.3464-2-rosenp@gmail.com
> > FFS. These reviews were garbage. The next series will effectively be
>
> What? My and Conor reviews were garbage?
I was specifically referring to replacing led-sources with reg. The
latter needs address and size-cells specified which is verbose for no
good reason.

Meaning the initial patchset was almost ideal. Just
of_device_is_available needed to be fixed.

I'm irritated as this will be up to v5 when it should have been up to v2.

>
> It is your patches which never got tested, code was completely messed up
> (see v2 mixing two different things).
>
> I am not going to review your patches.
>
> Best regards,
> Krzysztof

