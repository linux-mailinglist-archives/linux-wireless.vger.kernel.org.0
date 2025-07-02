Return-Path: <linux-wireless+bounces-24759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C6B5CAF0D26
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 09:50:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A06143AC921
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 07:50:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BC9ED1E47AE;
	Wed,  2 Jul 2025 07:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ku/InvjD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0AD91F0991
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 07:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751442640; cv=none; b=gjtvbWnduchJbkJECXWvvJMdIXGZe5/qOPslkPxCgPIzZqPM1Ecr+TyyNL1T45Lg7LCkn8p56c1wIPLocgHdf61cMURyUra9Nv9jly7gV1xfC4UG7GzvvE/3+JHK75Dl4pA9gDXr1uDz9bpy1GVGWomkrMZ+ihYCUsKW184JNgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751442640; c=relaxed/simple;
	bh=YUmOtwcFAuRMKkQmvHL9mZjZJdXIAtQfqqtA+VchVqs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=omks3iBQEArj3PdidQwxGfX+LYKfI59uodYZrnT0qj03+zT+2DJNZPTRHepWn+RMRZBLlpY0DLQpwWsGcphll0JknHVyYVhRifZ6hPPLg627MqPrtnPThyRRNb3QU8/R7KxNwOZXV3CuCSOmHMgevGyX9rwHavyeFf3gbQw3zlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ku/InvjD; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-ae0ccfd5ca5so578709266b.3
        for <linux-wireless@vger.kernel.org>; Wed, 02 Jul 2025 00:50:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751442635; x=1752047435; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/EmtKNpLV1wuppjdHJcp+jhS0vREUC35ykYwMdMeJCw=;
        b=ku/InvjD7J+DMtGKTj1d82y2SZTVlShQzEHExYXZXVy8ZdGk6Qhbs8w2qllxojTyd+
         yNozejc1hynTdbcvCzQcdSM1EnkwIeVGQ1o/aRC4K0lmOwYv2XwGcsalIKbUseze42dy
         N6KBPIoZOOXhw8GgQ2fiQeHzuSfhEFoNmd1wg1TgiLgyTC00aoVPjJarotvscfXha/Y6
         7sfmPBPsEeQb1a7xCTG7mi+xQq+SnorhavtlkzJzvqjqGV4COJM//4A1Hz4/oeowKVom
         DFX5m/pk4zVhXjILKvKteAKwQPw1qMunE6UZZCz/vVkZxGvCkBQl7PaULP5rauF3oyaw
         3y5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751442635; x=1752047435;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/EmtKNpLV1wuppjdHJcp+jhS0vREUC35ykYwMdMeJCw=;
        b=usYI6BZstKAln514EEUlikd7KEx6AWXwKlQOOuGe2n1lEKADNrbF0T8Rk5oNbQNEm5
         Ag/twViUznyKyRBqbnyfADZSIAFo5DEZNaMTrYnaslMgMPjcfq165OXoZkbhfcm3Oi5U
         1w4qGI5U86uJEX6k4oRQSe7sM8V0ssn0iRZN6PQmFnaL1D6/qXhRbYKUNA49yli5JX5w
         krYXPkFFLS/0JCq9h5Bo1303UtUJP9uejyx01XkBbjLZu6euCDam0DZo8TAAJVfVq8dl
         jTiJv2+fikswuX4uB/eCWVexJYXEfB6IXhJHa6MOnV3wd0rMCZLAZuhh/lCPTGC3bt+Q
         MkLQ==
X-Gm-Message-State: AOJu0YwihZxeK2tFoKdpfQEz1oYE0hiEXBXnS1+KLEIMGypotVlrXv3O
	ISH5fjzbMVyE46nmXp5YCQYx1E8Dtoqnukt8dYZqiHuKKv5sTQj0BEkUXHSkug2F1tKjbh12Hyq
	RF14VutJKOi/M9lgJ1mIKSOEq4YGTnU4=
X-Gm-Gg: ASbGncsRLhEnp/Nvy8cd5+IFXkrd1l4pwG8Dfp2XH4bGIU7jxn59lZJnTCKDMXYrs51
	4VC6yzAGW2f3KYDwo8xpj23ce/5cmbPQkiCjpAPVUintB5yvb8GovzL9OqpnDNXzivXnkt68iyj
	wRyvRDft/rjguhYlCdDAUdx5CVCd69Uw7WYTizNEq7tog=
X-Google-Smtp-Source: AGHT+IE6La0g8qRD8zHQFlQBaAcefxIOZCxxslGrHN5ee1te8a1PXmHq7cRrHwzL2R8sUuiK/uqIjRCvKvEbGhdHyGw=
X-Received: by 2002:a17:907:3cca:b0:add:fb01:c64a with SMTP id
 a640c23a62f3a-ae3c2d95d66mr194213466b.43.1751442634387; Wed, 02 Jul 2025
 00:50:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250618054904.9107-1-pkshih@gmail.com> <CAGb2v65E7K0yRz==OTyBd_LCWwU+0MYWSivgJG4x70gS1Cp93w@mail.gmail.com>
In-Reply-To: <CAGb2v65E7K0yRz==OTyBd_LCWwU+0MYWSivgJG4x70gS1Cp93w@mail.gmail.com>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Wed, 2 Jul 2025 15:50:45 +0800
X-Gm-Features: Ac12FXyxk-hToU5xt0idQY1B-nIjw_nd8QJ-Jbncrdq6C1wI200kwkVNIlHOXew
Message-ID: <CAHrRpumH3DJ2orNksahgri+SjZz=W79EHuUEjRaVjNtwJb6uAw@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Egypt (EG) for 2024
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chen-Yu Tsai <wens@kernel.org> wrote=EF=BC=9A
>
> On Wed, Jun 18, 2025 at 1:49=E2=80=AFPM Ping-Ke Shih <pkshih@gmail.com> w=
rote:
> >
> > From: Ping-Ke Shih <pkshih@realtek.com>
> >
> > National Telecommunications Regulatory Authority (NTRA) released Radio
> > Spectrum Guidelines for Short-range Devices (SRD) on November 2024.
> >
> > As Table 4 Mandatary requirements for Wideband Data Transmission System=
s:
> > Including Wireless LAN (Wi-Fi and Multiple GIGABIT wireless systems for
> > Indoor applications only)
> >
> > * Wi-Fi for indoor applications only, so add NO-OUTDOOR for all entries=
.
> >
> > * 2400 - 2483.5 MHz
> >   - 100 mW e.i.r.p.
> >   - EN 300 328
> > * 5150 - 5350 MHz
> >   - 200 mW e.i.r.p.
> >   - DFS and TPC in 5250 - 5350 MHz
> >     * for devices without TPC, the limit is lowered 3 dBm
> >   - EN 301 893
> > * 5925 - 6425 MHz
> >   - 250 mW e.i.r.p.
> >   - EN 303 687
> > * 57 - 66 GHz
> >   - 40 dBm e.i.r.p.
> >   - EN 302 567
> >
> > [1] https://www.tra.gov.eg/wp-content/uploads/2024/11/EGY-NTRA-November=
-2024-SRD_English-1.pdf
> >
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> > ---
> >  db.txt | 10 ++++++----
> >  1 file changed, 6 insertions(+), 4 deletions(-)
> >
> > diff --git a/db.txt b/db.txt
> > index e331d4f763e3..4a05bdca781e 100644
> > --- a/db.txt
> > +++ b/db.txt
> > @@ -632,11 +632,13 @@ country EE: DFS-ETSI
> >         (57000 - 66000 @ 2160), (40)
> >
> >  # https://www.tra.gov.eg/wp-content/uploads/2022/03/EGY-NTRA-March-202=
2-SRD_English_Final.pdf
> > +# https://www.tra.gov.eg/wp-content/uploads/2024/11/EGY-NTRA-November-=
2024-SRD_English-1.pdf
> >  country EG: DFS-ETSI
> > -       (2402 - 2483.5 @ 40), (20)
> > -       (5150 - 5250 @ 80), (23), AUTO-BW, wmmrule=3DETSI
> > -       (5250 - 5350 @ 80), (20), DFS, AUTO-BW, wmmrule=3DETSI
> > -       (57000 - 66000 @ 2160), (40)
> > +       (2402 - 2483.5 @ 40), (100 mW), NO-OUTDOOR
> > +       (5150 - 5250 @ 80), (200 mW), AUTO-BW, wmmrule=3DETSI, NO-OUTDO=
OR
> > +       (5250 - 5350 @ 80), (100 mW), DFS, AUTO-BW, wmmrule=3DETSI, NO-=
OUTDOOR
>
> The database parser requires the wmmrule flag be the last flag for some
> reason. I fixed it up locally and will force push it out.

Sorry for the mistakes. I forgot to run the parser before sending out patch=
.

>
> ChenYu
>
> > +       (5925 - 6425 @ 320), (250 mW), NO-OUTDOOR
> > +       (57000 - 66000 @ 2160), (40), NO-OUTDOOR
> >
> >  # ES as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN =
301 893)
> >  # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300=
 440)
> > --
> > 2.25.1
> >

