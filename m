Return-Path: <linux-wireless+bounces-29903-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [172.232.135.74])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F8C9CCCD4B
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 17:42:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9D738304F687
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Dec 2025 16:42:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A25434F46D;
	Thu, 18 Dec 2025 16:35:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fS8M2XgM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-qv1-f53.google.com (mail-qv1-f53.google.com [209.85.219.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B325134F26F
	for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 16:35:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766075744; cv=none; b=cnv39v+m04GKTCaDCx5aooBKLhKHpB/ImsmYZVFGXY6RcRokx55lsO9ctNanuHyDli82ErS1jQpZZdbHIVlUXdKXpu6pjwj/K1PaJ708+d/Abq+skS5b3dvMHRHvpEOBgEA9wjXIfdUAZl7j1oy0n9OHFiVagzzp3YPl8gO9YDg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766075744; c=relaxed/simple;
	bh=Qxt65n4062GAtyCItZG91W6WkPx1gldCA6LORPhoKy4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=olDyTqQAZ7e2rzjamQarv/VZnuapDcdtEm3pf80KjJ0pn771Xt0b5X87QOT14QzkBxuppZ8TJNS1L5vsadTWaYE+V+2olelgQQsWD12+OlqdwVr8/YOlHnZMINb+5tZnUxiO9mosnShN2sNPG8Kq1xtCjWRqGJT0b97DVaWn/lc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fS8M2XgM; arc=none smtp.client-ip=209.85.219.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f53.google.com with SMTP id 6a1803df08f44-8885aae52b1so7067106d6.0
        for <linux-wireless@vger.kernel.org>; Thu, 18 Dec 2025 08:35:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766075738; x=1766680538; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vthX8EZ69SmXta9bEKt82uOMLThl45XqVhRz116/j3k=;
        b=fS8M2XgM7KnCat7J5+hkeiZHM2H5asJJOL1xpI9tNyAodAFqTCrDUBjEfo4pDvJxwS
         lplvz3Wdnh+EujNVeIRLOO/zDL4eGe8kLsOw+uY/skCW/l3T7sDumyN2NPpdvvip7YP0
         asY5aN0vS859pTDX9xwTv9nnmsaL6qFCkWHhQ1Nde+tcjr+Bx/WycZQ7vxNV8xPnaGYV
         9EfbnqEqpmxhDiHaRvNsiIqTw8bRfUTSHMaycVRM1NAgJeIv1wVhVFOdWjz8bzLeYR2H
         n6z47w7xJde5v81fkDYvfu9PIfrN7nN1fKCBPK9m/CLIZoMxgzEOWPlsgogprWW4Hk1G
         GmkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766075738; x=1766680538;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=vthX8EZ69SmXta9bEKt82uOMLThl45XqVhRz116/j3k=;
        b=Wxsoo9S6GGu8+9WUfTCIs4P9NXzS08QeTRs0ur7928sMEtK8hs+lvY3BOKdXTSmOVR
         5uGNxv4jl/SdBEhuPxi5cCzXjTbMaB0kajY5EXgqrJPvgJgWpI/2On02CMr6bv9Y7nGz
         E5L47djV8Mrp7nHSYtxUk4M2rS+oF+0YDA6T+dH7R/hyT+bgG+PTa9b57Masw3L100gw
         zYwgn4O/c9ZnmcM6r9sQ+GMw/VC0DgqjJ2qeuIjmXI5wZpM7ufu/jmJkHLa4YoiSxAmu
         7IVQohQa5I/Ta5QcQmWqPhjq0ScLEEr9tqOtOGKxe4IdhORBUSwg2Cu0747YM4yfG1c2
         XniQ==
X-Forwarded-Encrypted: i=1; AJvYcCXopAHYPCP4o1Qf6w4IG+BwBCUgGurQMu8JqU60y9wtYMsBc+8BnvUYNNE11rwLsQBHaxLZhaijir7lXxs60g==@vger.kernel.org
X-Gm-Message-State: AOJu0YwmOSbJ7OOW+qxt0y2rCrOLyYC5DLUWsociAmHADJ0z1zRtSQ7Z
	rXtCs6/PEW/7hXkVTTu0baeo63VkSJ2xQ+41O5JItGPjC40rnGeIMYvdJK+x0Rsgf/soQ1/ZZPQ
	EMGJ0a+WrNRdfaJSR5OQfeLRow+mzZw==
X-Gm-Gg: AY/fxX7ZsgdihO1D63hay9uC3iHN8BGl7ff4W65DSK8RgZzb5qtmPaslrzyAYTuFcg3
	s4lkzojOXHNhwIKGBjOjGQbW2AMlf6ALgtD5KiZBBHXod+rYUABs4co68l4xF8jdnvjJEF4NmIA
	08ShiLQ1/e7TmLItFrez+3UsO/N9zCmJZZHkC9vpR5qGkH5kyEtP/nbZkHrp3LFN3KCBLFzNITG
	gQbobfgEQvhRnPCyhuitZ3xStEVVswWlDZnRfFo84D/KCGGYOLE8b13dR5a4/kIlvZ60OUYhyjc
	THDGud5gUh+johvrk+f8bEHefR4=
X-Google-Smtp-Source: AGHT+IE9/ZCMCiyjrmPyCIsxYsQHia6PO/5OA2ZJrCLu8tQ8JQjcXci/gveKRp2q1MLBH7jp/9tKHDC2qJ1c5+HtAN0=
X-Received: by 2002:a05:6214:598e:b0:888:7e41:a9a with SMTP id
 6a1803df08f44-88d87be8db8mr2888306d6.46.1766075738235; Thu, 18 Dec 2025
 08:35:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251218-surface-sp11-for-next-v3-0-875afc7bd3b7@gmail.com>
 <20251218-surface-sp11-for-next-v3-1-875afc7bd3b7@gmail.com> <438a352e-5174-4361-b6e5-6ff5fe1ce0c0@oss.qualcomm.com>
In-Reply-To: <438a352e-5174-4361-b6e5-6ff5fe1ce0c0@oss.qualcomm.com>
From: =?UTF-8?B?SsOpcsO0bWUgZGUgQnJldGFnbmU=?= <jerome.debretagne@gmail.com>
Date: Thu, 18 Dec 2025 17:35:03 +0100
X-Gm-Features: AQt7F2rTRoXMF5xHMqmkLERUjvS2qI4aUT26N8INWGtmOaD17Y8RxpKD_isxRH0
Message-ID: <CA+kEDGE42HhaWZy1o9DjpwcjPiJcqvq52o-_g+auOkp26ukULg@mail.gmail.com>
Subject: Re: [PATCH v3 1/6] dt-bindings: arm: qcom: Document Microsoft Surface
 Pro 11
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Bjorn Andersson <andersson@kernel.org>, Konrad Dybcio <konradybcio@kernel.org>, 
	Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Johannes Berg <johannes@sipsolutions.net>, Lorenzo Bianconi <lorenzo@kernel.org>, 
	Maximilian Luz <luzmaximilian@gmail.com>, Hans de Goede <hansg@kernel.org>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Jeff Johnson <jjohnson@kernel.org>, linux-arm-msm@vger.kernel.org, 
	devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
	linux-wireless@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	ath12k@lists.infradead.org, Dale Whinham <daleyo@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Le jeu. 18 d=C3=A9c. 2025 =C3=A0 15:15, Konrad Dybcio
<konrad.dybcio@oss.qualcomm.com> a =C3=A9crit :
>
> On 12/18/25 12:56 AM, J=C3=A9r=C3=B4me de Bretagne via B4 Relay wrote:
> > From: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.com>
> >
> > Add the compatibles for the Qualcomm-based Microsoft Surface Pro 11,
> > using its Denali codename.
> >
> > The LCD models are using the Qualcomm Snapdragon X1 Plus (X1P64100),
> > the OLED ones are using the Qualcomm Snapdragon X1 Elite (X1E80100).
> >
> > Due to the difference in how the built-in panel is being handled
> > between the OLED variant and LCD one, it is required to have two
> > separate DTBs, so document the compatible string for both variants.
> >
> > Signed-off-by: J=C3=A9r=C3=B4me de Bretagne <jerome.debretagne@gmail.co=
m>
> > ---
> >  Documentation/devicetree/bindings/arm/qcom.yaml | 8 ++++++++
> >  1 file changed, 8 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Document=
ation/devicetree/bindings/arm/qcom.yaml
> > index d84bd3bca2010508a8225b9549d8c634efa06531..7c99bc0d3aae3dc6e9c08fe=
f0a535e114a3297a8 100644
> > --- a/Documentation/devicetree/bindings/arm/qcom.yaml
> > +++ b/Documentation/devicetree/bindings/arm/qcom.yaml
> > @@ -1067,6 +1067,14 @@ properties:
> >            - const: qcom,x1e78100
> >            - const: qcom,x1e80100
> >
> > +      - items:
> > +          - enum:
> > +              - microsoft,denali-lcd
> > +              - microsoft,denali-oled
> > +          - const: microsoft,denali
> > +          - const: qcom,x1p64100
> > +          - const: qcom,x1e80100
>
> As the bot pointed out, this is valid, but not what you want:
>
> This expects
>
> "microsoft,denali-(lcd/oled)", "microsoft,denali", "qcom,x1p64100",
> "qcom,x1e80100"
>
> whereas you're looking for 2 entries:
>
> - items:
>         const: microsoft,denali-lcd
>         const: microsoft,denali
>         const: qcom,x1p64100
>         const: qcom,x1e80100
>
> - items:
>         const: microsoft,denali-oled
>         const: microsoft,denali
>         const: qcom,x1e80100

I was trying to group the 2 variants together, as they are very much
related. Your description captures the 2 variants way more precisely,
I will switch to 2 distinct entries in v4.

> Konrad

Thanks again for your review,
J=C3=A9r=C3=B4me

