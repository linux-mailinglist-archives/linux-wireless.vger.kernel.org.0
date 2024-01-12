Return-Path: <linux-wireless+bounces-1776-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F15582BA01
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 04:37:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 85287283263
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jan 2024 03:37:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E55391B27F;
	Fri, 12 Jan 2024 03:37:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ohDh+POc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBC4B1B27B
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 03:37:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B226C433C7
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jan 2024 03:37:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1705030644;
	bh=/7paxi9X5+q+hqRVA+v9bOUL/e871sFBXp9OASDSZLk=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=ohDh+POcUSU17zwxpOZUVWspD1pJyZkhwR9n8oaVBrWRbwCXKvdNp74Q3yOL3NSGc
	 WOm1CrbwPmg8rJ1kiuMqand5oSc821O80PRbj7q3nLR/F/Mx8Bgsi378x/VYEQVwpc
	 pYJmo8UmwvrHnBnZBCSYqbUeQfZ6vCD5zCGZE0jPIAYL9CAtdfIOxjUOxcVxhHzY7L
	 XPnvJ2k/25yIdj6F1R50rLOuHEw8ioenYoQ4veTxrKZgYg+ZMJhTCsVrKDjasLHNn9
	 UcNV/mTOw56AiH0fRWjKKcEwFbPT9kUXs+UEtvLkfs5gj626urjsQBcDDG3+xoJ7Vz
	 HK74iibSYvLsQ==
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-5ca29c131ebso4657127a12.0
        for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 19:37:24 -0800 (PST)
X-Gm-Message-State: AOJu0YxJ5j7d0aGaoEVlcHpEtZDHqOeVQQQ0qiBwGLpevzD/YO3v7hJS
	jPQVOcW4C9PmY+wxsyqSab3BQXEezPryoUQCnvw=
X-Google-Smtp-Source: AGHT+IFyL285MNPwUnCrr02lkVdEqaFEGxtPbmIqWVIU8Vrjf70KRz5ICVSVS1W/wfVPlv8HLjzmQ05mBlYU/WJ9Hzk=
X-Received: by 2002:a05:6a20:840d:b0:196:ae4b:e007 with SMTP id
 c13-20020a056a20840d00b00196ae4be007mr428386pzd.116.1705030643819; Thu, 11
 Jan 2024 19:37:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20230903102022.11186-1-me@ndoo.sg> <CAGb2v65uD9TQuMzrMo8JoWEMp8WbVrKAf92tn17tA98GXdPWZQ@mail.gmail.com>
 <CA+yTfBBUymdYxiO2wFUzVvDX6+nkq9mhx-MWEEi4jEw3WqGgcg@mail.gmail.com>
In-Reply-To: <CA+yTfBBUymdYxiO2wFUzVvDX6+nkq9mhx-MWEEi4jEw3WqGgcg@mail.gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 12 Jan 2024 11:37:12 +0800
X-Gmail-Original-Message-ID: <CAGb2v64Vvy5ONktcMRWf_GtWFFG9_R8+sMvn58YWtxPPts6y7A@mail.gmail.com>
Message-ID: <CAGb2v64Vvy5ONktcMRWf_GtWFFG9_R8+sMvn58YWtxPPts6y7A@mail.gmail.com>
Subject: Re: [wireless-regdb] [PATCH] wireless-regdb: Update regulatory rules
 for Singapore (SG) for September 2023
To: Andrew Yong <me@ndoo.sg>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 12, 2024 at 11:05=E2=80=AFAM Andrew Yong <me@ndoo.sg> wrote:
>
> Hi there Chen-Yu,
>
> On Fri, Dec 22, 2023 at 12:35=E2=80=AFPM Chen-Yu Tsai <wens@kernel.org> w=
rote:
> >
> > On Sun, Sep 3, 2023 at 9:25=E2=80=AFPM Andrew Yong <me@ndoo.sg> wrote:
> > >
> > >  - Update regulatory rules for September 2023 IMDA TS SRD [1]
> > >  - Enable 5945 - 6425 MHz (Wi-Fi 6E) band per legislation
> > >  - Switch units from dBm to mW to match values listed in legislation
> > >  - Allow AUTO-BW between 5470 - 5850 MHz to permit additional 160 MHz=
 BW options
> > >
> > > [1] https://www.imda.gov.sg/-/media/imda/files/regulation-licensing-a=
nd-consultations/ict-standards/telecommunication-standards/radio-comms/imda=
tssrd.pdf
> >
> > Thanks for the patch!
> >
> > > Signed-off-by: Andrew Yong <me@ndoo.sg>
> > > ---
> > >  db.txt | 34 ++++++++++++++++++----------------
> > >  1 file changed, 18 insertions(+), 16 deletions(-)
> > >
> > > diff --git a/db.txt b/db.txt
> > > index fdc2c13..cbe1a88 100644
> > > --- a/db.txt
> > > +++ b/db.txt
> > > @@ -1584,25 +1584,27 @@ country SE: DFS-ETSI
> > >         # 60 GHz band channels 1-4 (ETSI EN 302 567)
> > >         (57000 - 66000 @ 2160), (40)
> > >
> > > -# https://www.imda.gov.sg/-/media/Imda/Files/Regulation-Licensing-an=
d-Consultations/ICT-Standards/Telecommunication-Standards/Radio-Comms/IMDAT=
SSRD.pdf
> > > -# IMDA TS SRD, Issue 1 Revision 1, April 2019, subsequently "IMDA TS=
 SRD"
> > > -# 2400 - 2483.5 MHz: IMDA TS SRD, Table 1 (25); ANSI C63.10-2013 and=
 FCC Part 15 Section 15.247 or EN 300 328
> > > -# 5150 - 5350 MHz: IMDA TS SRD, Table 1 (29); FCC Part 15 Section 15=
.407 (1) 5.15-5.25 GHz (2) 5.25-5.35 GHz; EN 301 893
> > > -# 5470 - 5725 MHz: IMDA TS SRD, Table 1 (30); FCC Part 15 Section 15=
.407 (2) 5.47-5.725 GHz; EN 301 893
> > > -# 5725 - 5850 MHz: IMDA TS SRD, Table 1 (27); FCC Part 15 Section 15=
.247; FCC Part 15 Section 15.407 (3) 5.725-5.85 GHz
> > > -# 57000 - 66000 MHz: IMDA TS SRD, Table 1 (31); ETSI EN 302 567
> > > -# Note: 27dBm for 5470-5725MHz bands is 3dBm reduction per FCC Part =
15 Section 15.407 (2) 5.47-5.725 GHz; EN 301 893 as referenced by IMDA TS S=
RD
> > > +# https://www.imda.gov.sg/-/media/imda/files/regulation-licensing-an=
d-consultations/ict-standards/telecommunication-standards/radio-comms/imdat=
ssrd.pdf
> > > +# IMDA TS SRD, Issue 1 Revision 3, Sep 2023, subsequently "IMDA TS S=
RD"
> > > +# 2400 - 2483.5 MHz: IMDA TS SRD, Table 1 Sub-band 32e
> > > +# 5150 - 5350 MHz: IMDA TS SRD, Table 1 Sub-band 33a
> > > +# 5470 - 5725 MHz: IMDA TS SRD, Table 1 Sub-band 34
> > > +# 5725 - 5850 MHz: IMDA TS SRD, Table 1 Sub-band 35
> > > +# 5945 - 6425 MHz: IMDA TS SRD, Table 1 Sub-band 45b
> > > +# 57000 - 66000 MHz: IMDA TS SRD, Table 1 Sub-band 40
> > > +# Note: 500mW for 5470-5725MHz bands per FCC Part 15 Section 15.407 =
(2) 5.47-5.725 GHz as referenced by IMDA TS SRD
> > >  #  AU and BG regulatory domains use the same interpretation of cited=
 FCC and ETSI standards
> > > -# Note: The transmit power for 5250-5350MHz bands can be raised by 3=
dBm when TPC is implemented: IMDA TS SRD Table 1 (29)
> > > -# Note: The transmit power for 5470-5725MHz bands can be raised by 3=
dBm when TPC is implemented: IMDA TS SRD Table 1 (30)
> > > +# Note: The transmit power for 5250-5350MHz bands can be raised by 3=
dBm when TPC is implemented: IMDA TS SRD, Table 1 Sub-band 33a
> > > +# Note: The transmit power for 5470-5725MHz bands can be raised by 3=
dBm when TPC is implemented: IMDA TS SRD Table 1 Sub-band 34
> >
> > "... raised by 100 mW ..." given the new units?
>
> Ack, will amend in v2.
>
> >
> > Also, such a provision is not given for 5470-5725MHz in the spec. My
> > interpretation of the text is that a "reference" is referencing other
> > regulations for "reference" when designing the local rules, not that it
> > allows following those references directly, unless explicitly noted.
>
> From the parallel discussion at [1], it sounds like this has been the
> interpretation used for multiple regdomains, e.g. AU.

For AU, their text explicitly states (for 5250-5350 MHz for example):

    If the maximum EIRP is greater than 100 mW, the transmitter must
    use Transmit Power Control (TPC).

So the rule in our database limits it to 100 mW. It also has a clear
comment stating how high the limit can be raised to if TPC were
implemented.

> IMHO, it would be outside of the scope of this patch which implements
> changes since the last Singapore regulation release. I would prefer a
> separate patch to comment out 5470-5725MHz, which can later be
> reverted/uncommented once a decision is reached.

Yes, that sounds reasonable. Could you send a patch to comment the
band out then? FWIW the Wikipedia writers [1] seem to agree with
my understanding, even though it seems to be based on an older
version.

> Though my opinion would be that a separate patchset that universally
> addresses all the interpreted/grey-area TPC offsets, would be more
> appropriate, once that decision is reached.

That would depend on someone having the time to audit the whole database,
going through all the regulations of all the regions, many of them only
available in the native language. It's a huge task to say the least.

I think it would only happen region by region as they get updated, and
I have references to look at.

> Anyway, I'll defer to your decision as the maintainer; I'll keep this
> band in my patchv2 meanwhile and do a v3 if I'm not in time for your
> decision.

So, please send v2 with the tweaks I asked for, minus removing the
5470-5725 MHz band. And then send another patch for disabling said
band with a comment saying that TPC is required.

> >
> > >  country SG: DFS-FCC
> > > -       (2400 - 2483.5 @ 40), (23)
> > > -       (5150 - 5250 @ 80), (23), AUTO-BW
> > > -       (5250 - 5350 @ 80), (20), DFS, AUTO-BW
> > > -       (5470 - 5725 @ 160), (27), DFS
> > > -       (5725 - 5850 @ 80), (30)
> > > -       (57000 - 66000 @ 2160), (40)
> > > +       (2400 - 2483.5 @ 40), (200 mW)
> > > +       (5150 - 5250 @ 80), (200 mW), AUTO-BW
> > > +       (5250 - 5350 @ 80), (100 mW), DFS, AUTO-BW
> > > +       (5470 - 5725 @ 160), (500 mW), DFS, AUTO-BW
> >
> > This needs more justification. Unlike for the 5.15 ~ 5.35 GHz range,
> > the standard does _not_ give an option without TPC for this band.
> >
> > > +       (5725 - 5850 @ 80), (1000 mW), AUTO-BW
>
> As above.
>
> >
> > Instead of AUTO-BW here, can you follow the examples from TW and US of
> > expanding the previous band by 5 MHz? That should cover the 160 MHz
> > channel.
>
> Ack, will amend in v2.
>
> Thanks for reviewing.
> Andrew

Thank you for the effort!
ChenYu

[1] https://en.wikipedia.org/wiki/List_of_WLAN_channels#Singapore


> [1] https://lists.infradead.org/pipermail/wireless-regdb/2024-January/001=
490.html
>
> >
> >
> > ChenYu
> >
> > > +       (5945 - 6425 @ 320), (250 mW), NO-OUTDOOR
> > > +       (57000 - 66000 @ 2160), (10000 mW)
> > >
> > >  # SI as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, E=
N 301 893)
> > >  # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 3=
00 440)
> > > --
> > > 2.41.0
> > >
> > >
> > > _______________________________________________
> > > wireless-regdb mailing list
> > > wireless-regdb@lists.infradead.org
> > > http://lists.infradead.org/mailman/listinfo/wireless-regdb

