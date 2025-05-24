Return-Path: <linux-wireless+bounces-23371-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 56CF0AC2D55
	for <lists+linux-wireless@lfdr.de>; Sat, 24 May 2025 06:18:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 985BF7A2B5A
	for <lists+linux-wireless@lfdr.de>; Sat, 24 May 2025 04:17:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4D2DB17A31E;
	Sat, 24 May 2025 04:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UxOU02Aj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f180.google.com (mail-yw1-f180.google.com [209.85.128.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828B21459F7;
	Sat, 24 May 2025 04:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748060315; cv=none; b=Q2e0lXT1Tzp1lG/KpC1tM9d5/5fybG3AQGQh5rCPz33i2zV9aOKyyUJS+KWD5wKXrIXEeLeMoADjZDeJIGsM4/qHiT60eB4llZsbv3l7Y2WniSFMxBOmWa/P8fkrtoUS4mF12A/hs0Uoypq44JsdxNGUElhwkiK8tPJeOGTXAJc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748060315; c=relaxed/simple;
	bh=cfXmE2pc2gDI2tlS9y8yO19okkSub+/4UOnWj3rW+DQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=lcLrJ0TxPxQnFPcwlODt9QIEOBOAdiZgbGlvgAbkS2XuhxFRzuqltPVERI+eSIkxzo9pFy+GoOSXpEHO531h/D2U1hMtcuJflDyNnzSDPlL3JYpZUr8P5F6b1UCtax/mwosRu2ABqYfjVLJTffV5HRSagyszKBcEFj9FPWAOXpU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UxOU02Aj; arc=none smtp.client-ip=209.85.128.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f180.google.com with SMTP id 00721157ae682-70dec158cc1so5648427b3.0;
        Fri, 23 May 2025 21:18:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748060312; x=1748665112; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=i/bjQmjwtohthdugt6eowqJarB465LHeHvHrhFq0nio=;
        b=UxOU02AjzqbWkPHAQFakyNTzSpkwqTkj9WL3QZnk+BhafzKbz7CV57+pJBlhqrUeAs
         F3xyQoPr4NeeCElLMoWDGKpSXWbHBEFzs7WV5N0zATEZ4OFhEQiObvAl/pp1AQkRxzfO
         hhZ9TI79E14OphMoOoWjUG5kuKZDsayoltWp7iynL2r/FMIcUxniUUjHFPKdy5vdkKXc
         WTnMIun1bbHLmyXgC0io0HzLnAOK1zkjlwhr3pgitz5XUsNlZv4no6GqRkJPn0gTPht5
         xOa1Ce252LAWqWTY48Dyt8wo6Rq9eaERKzAxCmYNoGgqgfzFB8M0m0EDzKo3bLwZ2OPG
         5VyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748060312; x=1748665112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=i/bjQmjwtohthdugt6eowqJarB465LHeHvHrhFq0nio=;
        b=ssaaY/tDQnXOCmtLlJAGSt8WE7wJQYQZfCJVj63lRuwOryY33gnGUXDixxsESnph21
         FN9bNrId6N+STEEQ0Z3rd6O7OVvx+D97benNYyaLFJW4hZslrwpMdo4NtpjDupoZZBbP
         zgkievPOoUg1pThPpqnog7Z4wyHBXbtMG0XfFyhfdqoAuijOGyaCfOMN1H6D+WWV1UvQ
         UU5EISvAOYRSn7txjSCL313CUy1qmEg1Btt6ocrvcfNohs8dIokeEarTpb1k+11XBpQd
         VwmqTtmNQxj1fP/laOVjjyhLCduyEX7ceh4tHxJwTyh3ukqhAhBmrDWjy4iSUwbNXfop
         k8aA==
X-Forwarded-Encrypted: i=1; AJvYcCUETAi+2DsU8Q5rYv4KiYBBl8fgx4RMKQG0U3FfM7xB/E2DNY6Jt14jdP6+F8EdBMZrIamr2+LdyV+/5VcS@vger.kernel.org, AJvYcCUPJtLQww2yYtpdw7onwX0o1OJtxBqwBg7n5T0YuTXBBi+Q7YptirPqXbEUSSHOcmo8gewCHJ14CoEE@vger.kernel.org, AJvYcCVOr7UUGVof1LVAHLSd5t/GvI/AMDJKyuJLQU4XRlpIHkCi9YfOYuL53ZPENrn4GqKP0jPf0sBPZOklmg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxDlomG7b65yXi83iatKFgeLafhM53bwWz51Ug/UHyZJQTy7wbx
	CmcD6UhMQtt/s8rKHW8+lxXk9pQXtdinFCQjRgqlen7cpIlxmhKCUaFJny49REt7cThd5nOHu6g
	ZZ+qhAMEMn0vo2oAL4PObH4NdIAHiEnc=
X-Gm-Gg: ASbGncs4GmrVFH7TTuy7DJFy5LC/7GzY7OvVwHVbyGAHWkU+vYBBsPCDVa/P8cnDSgx
	c8pwE6H7vUb1UfnIr30MmlmyW9qU8paxAxq4rKwhyogvy2LWqAZ1zXxjbIlo7hPeHS0Du/ido1i
	TlXyDpwIfISClMpRRaJGsfvpmiq2hkC5oMFAVwBgoLWDZDuw==
X-Google-Smtp-Source: AGHT+IFg5h998sEp+caqpNiReRUAD9Rb4THGYBdIE463bb4Wx9PXVjAuDagWJZCWi5jhq7C8t1WEEwZRae+ucF/3i2o=
X-Received: by 2002:a05:690c:6888:b0:70c:d977:b154 with SMTP id
 00721157ae682-70e184f055dmr72960587b3.4.1748060312370; Fri, 23 May 2025
 21:18:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250523063207.10040-1-rosenp@gmail.com> <20250523063207.10040-4-rosenp@gmail.com>
 <574cd2c2-8201-4182-b372-da518a9b1972@kernel.org>
In-Reply-To: <574cd2c2-8201-4182-b372-da518a9b1972@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Fri, 23 May 2025 21:18:21 -0700
X-Gm-Features: AX0GCFuq4AddLSsQedtAvLI-0HgSKsrcTrueAoZj3qwNaJ-bWn8b9Cxa82DU61s
Message-ID: <CAKxU2N_Ce_O0_xPaZESFoX1SNAs4GNsZfpdw3EXm12d+RBe6Cw@mail.gmail.com>
Subject: Re: [PATCHv3 3/5] dt-bindings: net: wireless: ath9k: add WIFI bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-wireless@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	nbd@ndb.name, Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 11:43=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 23/05/2025 08:32, Rosen Penev wrote:
> >    reg:
> >      maxItems: 1
> > @@ -88,3 +94,15 @@ examples:
> >          nvmem-cell-names =3D "mac-address", "calibration";
> >        };
> >      };
> > +  - |
> > +    ahb {
> > +      compatible =3D "simple-bus";
> > +      ranges;
>
> Not much improved... Code is now actually wrong. Remember to notice
> where the comments appear. We are using here mailing list style of
> communication.
Will fix. I ran make dt_binding_check just to make sure. The example's
compatible is also wrong. Will fix as well.
>
> In any case: 1 patchset per 24h.
Ah right. Apologies.
>
>
>
> Best regards,
> Krzysztof

