Return-Path: <linux-wireless+bounces-23332-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 28785AC18D7
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 02:04:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3368A4682C
	for <lists+linux-wireless@lfdr.de>; Fri, 23 May 2025 00:04:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8688824DCEA;
	Fri, 23 May 2025 00:04:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3k0TdWD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA90819A;
	Fri, 23 May 2025 00:04:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747958664; cv=none; b=K3N9qJoapkqAlquYG+aXOe9ngfpcHVhHd1FEjopsMQgv8htb6csNujwVDuGEyCVMaifra1hmdtldxPKk9WNt8Hu4TMkwpyP1FVq7oa+wfVmSRExtkCz7KPNmgk8Y1HWQeGmkOyQvBVO0wvEDqX2rpM2mItgzDXb1srgfr8Y0y1g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747958664; c=relaxed/simple;
	bh=8RhF6JZexlYdbYojUlf+e9vDQ02xGsmYGEvzlJUi/uI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=SrAK9Pt4+q6Y0USU9kZhIz32wfIrjxL/ebUMVCcFWAgx7Y+gSIoGUKQWJOJ8uWinAxPEB5ey4fx/QeI0xn+du/jhqh3ZerW8rAyxyYD5W+BxmsNo04hHKf5CcefB30/uBd05F0jxweH9lyFd5dkbZNJgx5l53J72rK18YWyzs9A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3k0TdWD; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-70ccf9a4ab3so54334867b3.1;
        Thu, 22 May 2025 17:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747958662; x=1748563462; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3DbirWf9hqjVJS04ntzyt2efU5MTrY9tFTzatS41oes=;
        b=Y3k0TdWDSa6FjkUJyYee1WI+kHgql1SIc0ttdiKn5NjnZ9x7J839Z38l9Dle4W1XGe
         BoTOyjdzljlH4zSS0H1yitOeHWYgfKhT1F0xM7kD72m5NliF+yVNfOIaLW9StRXBx7mM
         f+qpB9G8U6m9NewaYrn1uZk3Nsfr5D9ZPlPR9CHalKBoYQeFQYfQ2NZ61Nhf2pA0UAe1
         udOjtjNrF2KBxzplltcJFUgBUGxFRTmcQ/NtECIwNG4MQqDorrpn7g3zejTkp1XcVc8n
         5sm4MloxJFdv3cM/L8FnLqrxy4YvPeDpR77z+MnKTuhu6agLN3DgRNZAHd/g5NqCtHom
         5D3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747958662; x=1748563462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3DbirWf9hqjVJS04ntzyt2efU5MTrY9tFTzatS41oes=;
        b=elYQVp7q1kAio/REFGwF2RGgvRP4xWwPtYtsF5xt6lb44qt/0BOuuM+sZJ5POneewW
         NmEc5jPly5rRGP4GM+K1kw6v4zEDjeegmzeRad+FUl0NIJZZvn596mTlpnxp8u6eD9Bt
         CmeicN/K6Ij1mhxNXL6R6fbrCxV/wp+PLUE8fxJb4aGaQQxuXTj3F4FK62RpVWaFj4kT
         j3UT4Tn9lMiTsmWUjvW+moCjqqQ+JaqmwAH7hjSEkoqIuMqDMeuSWCYoYCcWRqJNEC8i
         fVryZ1Qxo2WZVRKCEqOOKHbbdU5ZUlGl1Ggd130WZWuo0+tHlW9sRzccQi85VgI0wEWn
         smlA==
X-Forwarded-Encrypted: i=1; AJvYcCWeQe5s0CewUAcVN9xVdxkaJIzZr24HP91YkokkGVKZp3u6FH4azFIQiOm3GzsCxEV5obe0G2Dc96LphQ==@vger.kernel.org, AJvYcCXCROsgtx6eJVy6XLmaZpgNif4qnhgS4Cbs436ButBUXtihlhbEJxgOoJ3TfV8IHX/G+/DHDaSnDUSZRVmI@vger.kernel.org, AJvYcCXdR1N0kZgeirDimQ/QETkY6fMcOkeV96EWGKF+ycSxtVDu18/T7sCEba2VkfAuE8kvDqwZyHPE0WiG@vger.kernel.org
X-Gm-Message-State: AOJu0YxAVWIASOnU9kqDEo6WtCFHICumYh/WRGZ0oXcIxA6lq0vXeWrK
	Txg8ndKteKzUKQOmny3KhHjUzTOP4HvVwL+NB/PyxzgIqcPbHoVgKkuVlp34NxijO/mMfMbm1Z6
	bK/OqhYQoorrOYSFvd7fHT+A1uiMUDbw=
X-Gm-Gg: ASbGnctqYMNtHOBsNQI2JeqJht2mqfswIexmUKaduOErImNYhfK6HzRzPnHVxRPmlWA
	DKNISJEdOgQL2ZJu9Oyqt7bN0YaqZnIXT0UQVXThUFdDJF5WfrFsHe3C30H069z8oZUQJPzIu7z
	2rb5cBZNQKzZCpY5valic3Mpp7vowzxQmm5xbnwSXLw163lw==
X-Google-Smtp-Source: AGHT+IHTXxoSqVb7sbfYhgZx6mT9anQoUuzw2F2mRsAkEI6I/89Y1Cs8fBtoTpZx5IVuzqRXUirhzSQOcfXbUd9vWtw=
X-Received: by 2002:a05:690c:25c3:b0:70a:2675:70b3 with SMTP id
 00721157ae682-70caafc9570mr379086027b3.17.1747958661782; Thu, 22 May 2025
 17:04:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250522184516.13176-1-rosenp@gmail.com> <20250522184516.13176-5-rosenp@gmail.com>
 <871d18ab-a696-4141-bc3a-7b6e968fc649@kernel.org>
In-Reply-To: <871d18ab-a696-4141-bc3a-7b6e968fc649@kernel.org>
From: Rosen Penev <rosenp@gmail.com>
Date: Thu, 22 May 2025 17:04:10 -0700
X-Gm-Features: AX0GCFtCVpL4KFllAHT33tYF2GaAmf7ddZXmxbZuuFhASNob8nA1pyCoyRnyntg
Message-ID: <CAKxU2N8uZ+q1aE42+e65tVMr=ji0RTx5wZssFBnQN29OzsFXVA@mail.gmail.com>
Subject: Re: [PATCHv2 4/5] dt-bindings: net: wireless: ath9k: add OF bindings
To: Krzysztof Kozlowski <krzk@kernel.org>
Cc: linux-wireless@vger.kernel.org, =?UTF-8?B?VG9rZSBIw7hpbGFuZC1Kw7hyZ2Vuc2Vu?= <toke@toke.dk>, 
	Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>, 
	Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	"open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" <devicetree@vger.kernel.org>, open list <linux-kernel@vger.kernel.org>, 
	"open list:MIPS" <linux-mips@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 22, 2025 at 12:54=E2=80=AFPM Krzysztof Kozlowski <krzk@kernel.o=
rg> wrote:
>
> On 22/05/2025 20:45, Rosen Penev wrote:
> > Now that support was added to the driver, document it.
>
> That's not appropriate commit msg. Binding must be before the user (see
> submitting patches in DT directory). Describe the hardware, what are you
> adding here.
>
> Subject: OF bindings is redundant. It duplicates dt-bindings. Instead:
> "Add Atheros AR9-foo-bar on AHB bus" or something similar
At this point I wonder if my approach is wrong. The other ath drivers
use a qcom, prefix and a -wifi suffix. Might make sense to do the same
here to avoid typing qca twice.

>
> Missing SoB.
>
> Please run scripts/checkpatch.pl on the patches and fix reported
> warnings. After that, run also 'scripts/checkpatch.pl --strict' on the
> patches and (probably) fix more warnings. Some warnings can be ignored,
> especially from --strict run, but the code here looks like it needs a
> fix. Feel free to get in touch if the warning is not clear.
>
>
>
> > ---
> >  .../bindings/net/wireless/qca,ath9k.yaml      | 23 ++++++++++++++++++-
> >  1 file changed, 22 insertions(+), 1 deletion(-)
> >
> > diff --git a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.y=
aml b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > index 0e5412cff2bc..81d00f257922 100644
> > --- a/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > +++ b/Documentation/devicetree/bindings/net/wireless/qca,ath9k.yaml
> > @@ -12,7 +12,7 @@ maintainers:
> >  description: |
> >    This node provides properties for configuring the ath9k wireless dev=
ice.
> >    The node is expected to be specified as a child node of the PCI cont=
roller
> > -  to which the wireless chip is connected.
> > +  or AHB bus to which the wireless chip is connected.
> >
> >  allOf:
> >    - $ref: ieee80211.yaml#
> > @@ -35,6 +35,12 @@ properties:
> >        - pci168c,0034  # AR9462
> >        - pci168c,0036  # AR9565
> >        - pci168c,0037  # AR1111 and AR9485
> > +      - qca,ar9130-wmac
> > +      - qca,ar9330-wmac
> > +      - qca,ar9340-wmac
> > +      - qca,qca9530-wmac
> > +      - qca,qca9550-wmac
> > +      - qca,qca9560-wmac
> >
> >    reg:
> >      maxItems: 1
> > @@ -88,3 +94,18 @@ examples:
> >          nvmem-cell-names =3D "mac-address", "calibration";
> >        };
> >      };
> > +  - |
> > +    apb {
> > +      compatible =3D "simple-bus";
> > +      ranges;
> > +
>
> Drop these two.
>
> > +      #address-cells =3D <1>;
> > +      #size-cells =3D <1>;
>
> Best regards,
> Krzysztof

