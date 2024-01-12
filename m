Return-Path: <linux-wireless+bounces-1774-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1ECBE82B9DC
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 04:05:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5C99287587
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 03:05:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4822D15B9;
	Fri, 12 Jan 2024 03:05:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ndoo.sg header.i=@ndoo.sg header.b="ZgGnN2xK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-yw1-f175.google.com (mail-yw1-f175.google.com [209.85.128.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BCCA805
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 03:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ndoo.sg
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ndoo.sg
Received: by mail-yw1-f175.google.com with SMTP id 00721157ae682-5e7409797a1so58905217b3.0
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 19:05:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ndoo.sg; s=google; t=1705028745; x=1705633545; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9knKDtRrI8UltEJ2z5qWDZ2baxy+kchSQYItq5ySR04=;
        b=ZgGnN2xKKpDZYSKq+IRegL+43Uu6mhCHAgXpMXJaMInROwv6+D2emLYscDaI4gxP+z
         EaNtatMYdFwIQTlxBPm9ulZOg419t6a16yKAFOOSeNEBDjCDgbfhdsxkpsdMjqA6rQkn
         fd3cQG/7wCsxem8SNj1AlimS1eyFCkij0mpCA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1705028745; x=1705633545;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9knKDtRrI8UltEJ2z5qWDZ2baxy+kchSQYItq5ySR04=;
        b=l9Dklu6DxaYK6tfyDAKj6XBAQ+DKSUS8Woke4eXbLg/rA5e5kR6VMamC3nVP3DjZ8E
         5moZxORwQpCPEhQ8YJuugmtszldjakXJe3U8elT6v++01vI3R9m6jwwAECDD4mxejvCG
         b3Y0ptnqPTSjMzQADVHzXwj5X8teifnOAOLEpcd36s8pPZ+idtRtJwyd2VtfC6irG/YO
         DR7zA+/R9G0WjBg8idecaD+h3w3OKD6d/FTIPwuYL2Lfjem42OmbP4q/1qkfBzRIaakC
         7/rVgQCFf8nr5dkhDl72IOoNx1bRKrTHKZ8jGTzka6MVwxbYxDfs2SLCf/nhF0m5om0T
         5mwA==
X-Gm-Message-State: AOJu0Ywbk93jf5o4d4E5faiRZL/3YUHpvqJg7HMLxzrp/mRkaP4wqry8
	Pa40chsDgLtxotwjjiAfx9XZDMIbTQFO/K9qwrU2gqix8JJ8
X-Google-Smtp-Source: AGHT+IHZCs79hVBCria2hmD+rqwczAvYxhoto4hPZfNDPZRUFCXYeYYNHXuk5RXUXcmPt4CeCqM+dxqBVacU7RUFVIM=
X-Received: by 2002:a81:f10c:0:b0:5fa:5312:743c with SMTP id
 h12-20020a81f10c000000b005fa5312743cmr676766ywm.63.1705028745200; Thu, 11 Jan
 2024 19:05:45 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230903102022.11186-1-me@ndoo.sg> <CAGb2v65uD9TQuMzrMo8JoWEMp8WbVrKAf92tn17tA98GXdPWZQ@mail.gmail.com>
In-Reply-To: <CAGb2v65uD9TQuMzrMo8JoWEMp8WbVrKAf92tn17tA98GXdPWZQ@mail.gmail.com>
From: Andrew Yong <me@ndoo.sg>
Date: Fri, 12 Jan 2024 11:05:29 +0800
Message-ID: <CA+yTfBBUymdYxiO2wFUzVvDX6+nkq9mhx-MWEEi4jEw3WqGgcg@mail.gmail.com>
Subject: Re: [wireless-regdb] [PATCH] wireless-regdb: Update regulatory rules
 for Singapore (SG) for September 2023
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi there Chen-Yu,

On Fri, Dec 22, 2023 at 12:35=E2=80=AFPM Chen-Yu Tsai <wens@kernel.org> wro=
te:
>
> On Sun, Sep 3, 2023 at 9:25=E2=80=AFPM Andrew Yong <me@ndoo.sg> wrote:
> >
> >  - Update regulatory rules for September 2023 IMDA TS SRD [1]
> >  - Enable 5945 - 6425 MHz (Wi-Fi 6E) band per legislation
> >  - Switch units from dBm to mW to match values listed in legislation
> >  - Allow AUTO-BW between 5470 - 5850 MHz to permit additional 160 MHz B=
W options
> >
> > [1] https://www.imda.gov.sg/-/media/imda/files/regulation-licensing-and=
-consultations/ict-standards/telecommunication-standards/radio-comms/imdats=
srd.pdf
>
> Thanks for the patch!
>
> > Signed-off-by: Andrew Yong <me@ndoo.sg>
> > ---
> >  db.txt | 34 ++++++++++++++++++----------------
> >  1 file changed, 18 insertions(+), 16 deletions(-)
> >
> > diff --git a/db.txt b/db.txt
> > index fdc2c13..cbe1a88 100644
> > --- a/db.txt
> > +++ b/db.txt
> > @@ -1584,25 +1584,27 @@ country SE: DFS-ETSI
> >         # 60 GHz band channels 1-4 (ETSI EN 302 567)
> >         (57000 - 66000 @ 2160), (40)
> >
> > -# https://www.imda.gov.sg/-/media/Imda/Files/Regulation-Licensing-and-=
Consultations/ICT-Standards/Telecommunication-Standards/Radio-Comms/IMDATSS=
RD.pdf
> > -# IMDA TS SRD, Issue 1 Revision 1, April 2019, subsequently "IMDA TS S=
RD"
> > -# 2400 - 2483.5 MHz: IMDA TS SRD, Table 1 (25); ANSI C63.10-2013 and F=
CC Part 15 Section 15.247 or EN 300 328
> > -# 5150 - 5350 MHz: IMDA TS SRD, Table 1 (29); FCC Part 15 Section 15.4=
07 (1) 5.15-5.25 GHz (2) 5.25-5.35 GHz; EN 301 893
> > -# 5470 - 5725 MHz: IMDA TS SRD, Table 1 (30); FCC Part 15 Section 15.4=
07 (2) 5.47-5.725 GHz; EN 301 893
> > -# 5725 - 5850 MHz: IMDA TS SRD, Table 1 (27); FCC Part 15 Section 15.2=
47; FCC Part 15 Section 15.407 (3) 5.725-5.85 GHz
> > -# 57000 - 66000 MHz: IMDA TS SRD, Table 1 (31); ETSI EN 302 567
> > -# Note: 27dBm for 5470-5725MHz bands is 3dBm reduction per FCC Part 15=
 Section 15.407 (2) 5.47-5.725 GHz; EN 301 893 as referenced by IMDA TS SRD
> > +# https://www.imda.gov.sg/-/media/imda/files/regulation-licensing-and-=
consultations/ict-standards/telecommunication-standards/radio-comms/imdatss=
rd.pdf
> > +# IMDA TS SRD, Issue 1 Revision 3, Sep 2023, subsequently "IMDA TS SRD=
"
> > +# 2400 - 2483.5 MHz: IMDA TS SRD, Table 1 Sub-band 32e
> > +# 5150 - 5350 MHz: IMDA TS SRD, Table 1 Sub-band 33a
> > +# 5470 - 5725 MHz: IMDA TS SRD, Table 1 Sub-band 34
> > +# 5725 - 5850 MHz: IMDA TS SRD, Table 1 Sub-band 35
> > +# 5945 - 6425 MHz: IMDA TS SRD, Table 1 Sub-band 45b
> > +# 57000 - 66000 MHz: IMDA TS SRD, Table 1 Sub-band 40
> > +# Note: 500mW for 5470-5725MHz bands per FCC Part 15 Section 15.407 (2=
) 5.47-5.725 GHz as referenced by IMDA TS SRD
> >  #  AU and BG regulatory domains use the same interpretation of cited F=
CC and ETSI standards
> > -# Note: The transmit power for 5250-5350MHz bands can be raised by 3dB=
m when TPC is implemented: IMDA TS SRD Table 1 (29)
> > -# Note: The transmit power for 5470-5725MHz bands can be raised by 3dB=
m when TPC is implemented: IMDA TS SRD Table 1 (30)
> > +# Note: The transmit power for 5250-5350MHz bands can be raised by 3dB=
m when TPC is implemented: IMDA TS SRD, Table 1 Sub-band 33a
> > +# Note: The transmit power for 5470-5725MHz bands can be raised by 3dB=
m when TPC is implemented: IMDA TS SRD Table 1 Sub-band 34
>
> "... raised by 100 mW ..." given the new units?

Ack, will amend in v2.

>
> Also, such a provision is not given for 5470-5725MHz in the spec. My
> interpretation of the text is that a "reference" is referencing other
> regulations for "reference" when designing the local rules, not that it
> allows following those references directly, unless explicitly noted.

From the parallel discussion at [1], it sounds like this has been the
interpretation used for multiple regdomains, e.g. AU.

IMHO, it would be outside of the scope of this patch which implements
changes since the last Singapore regulation release. I would prefer a
separate patch to comment out 5470-5725MHz, which can later be
reverted/uncommented once a decision is reached.

Though my opinion would be that a separate patchset that universally
addresses all the interpreted/grey-area TPC offsets, would be more
appropriate, once that decision is reached.

Anyway, I'll defer to your decision as the maintainer; I'll keep this
band in my patchv2 meanwhile and do a v3 if I'm not in time for your
decision.

>
> >  country SG: DFS-FCC
> > -       (2400 - 2483.5 @ 40), (23)
> > -       (5150 - 5250 @ 80), (23), AUTO-BW
> > -       (5250 - 5350 @ 80), (20), DFS, AUTO-BW
> > -       (5470 - 5725 @ 160), (27), DFS
> > -       (5725 - 5850 @ 80), (30)
> > -       (57000 - 66000 @ 2160), (40)
> > +       (2400 - 2483.5 @ 40), (200 mW)
> > +       (5150 - 5250 @ 80), (200 mW), AUTO-BW
> > +       (5250 - 5350 @ 80), (100 mW), DFS, AUTO-BW
> > +       (5470 - 5725 @ 160), (500 mW), DFS, AUTO-BW
>
> This needs more justification. Unlike for the 5.15 ~ 5.35 GHz range,
> the standard does _not_ give an option without TPC for this band.
>
> > +       (5725 - 5850 @ 80), (1000 mW), AUTO-BW

As above.

>
> Instead of AUTO-BW here, can you follow the examples from TW and US of
> expanding the previous band by 5 MHz? That should cover the 160 MHz
> channel.

Ack, will amend in v2.

Thanks for reviewing.
Andrew

[1] https://lists.infradead.org/pipermail/wireless-regdb/2024-January/00149=
0.html

>
>
> ChenYu
>
> > +       (5945 - 6425 @ 320), (250 mW), NO-OUTDOOR
> > +       (57000 - 66000 @ 2160), (10000 mW)
> >
> >  # SI as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN =
301 893)
> >  # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300=
 440)
> > --
> > 2.41.0
> >
> >
> > _______________________________________________
> > wireless-regdb mailing list
> > wireless-regdb@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/wireless-regdb

