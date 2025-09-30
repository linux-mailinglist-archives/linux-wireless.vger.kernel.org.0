Return-Path: <linux-wireless+bounces-27736-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 906C0BAC0D3
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 10:29:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F9BA1C27B7
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 08:29:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CED472F49FE;
	Tue, 30 Sep 2025 08:29:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hmbMB4Ei"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1B672F3C2D
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 08:29:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759220989; cv=none; b=CNUJuuiegv1HW19MfMOdMHlef3gYHZMatRgdNejcnc1deNJw841rC7x94nOFABME92uYnHVzI+L2vGdepI5im272qzpw2OfAhIuYgEJ6CbyRDixqkArHOUEHiEzw34PEUnZtwbmRMU6W4QVkJfsQf4S3vzwUEGy1BhebZ2cxYrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759220989; c=relaxed/simple;
	bh=6aSVEqmot5ETN73n2AYoeHUpFp25qXy9tDjovnVF954=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XduVfcj+kvNO+Vzd2M5dWPNAx7hZYXUGnZXzpp/ehZlYYgoDsjdmtybIcVWqzlfeyhJ1ETSsNY4ipGDaRYd77TyzA5PwkGmV+E9owO/QL0omptAu1SXN4OFXjNBTjAwuMG5fTvQB1tlYHd1wfVuIN0dblG/9DkCCNaP1G/9il8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hmbMB4Ei; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-6364eb32535so2747570a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 01:29:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759220986; x=1759825786; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6SlLvvJinaAuYlVS2t7jvPR1UWeQSmp1JYog8PUyqAk=;
        b=hmbMB4Ei4a4VbVTf7FT1pjEj3Jq5R2IUPDodd+HvWbVmqryvQss+aT13LgL2ySrDRM
         kL7SpH0ChT0FcxoGFEw783Iq3jDNNL3SWhMvUtQjKKnFh6uhPWD2QDGiRrSl8GsmdxDi
         kLS8C9hwh39dEaywsQPNUKZLx1LMtyIWsEMv3RKHRt5dMartdNXMz0L1dGXg5DTWp9xp
         nnP256WU02xyuuyS18LOVRMN+cl861eYT5FdaR5NBdVv1aSU3J1P/bNZGJbsgpjque7m
         eY/CzGrG3fAjOIAl4uzjGKn22c8ZglRTbDjyNtD5dKD79WjltgnnTocTAhezAwiiYcN2
         gcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759220986; x=1759825786;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6SlLvvJinaAuYlVS2t7jvPR1UWeQSmp1JYog8PUyqAk=;
        b=w1WzKNN7ZpNIy4QIZ9+gGoFX+c3WQwdf1ooiINv3nIdRiWFBkPzbJ44Dx1XfvNWneg
         D8P3jLPU9kfUmJf6xnAI3249U+tFryKGgIr2IGjPxf4Q/fgkCL5m7wgS1bYeqjqowDmE
         TlqPzczAWqKWApBp8wvGiKgyZ86YXdqphcpNg1of6aprnIrQ7yWVAoD34gA+5JNDYlkD
         vut2FJzq6Sb42puU98WdxJoZSWkkrV2MAj/zAiTOtG4rSSuVBSOnO7BxyrG6dgZCX08k
         0zfWBBgpU7VicAVUOY7iUkCHwkM218vEuIeHPRSZ0uTnN1lIbVOx4sq7Ywi9Sz3IxPMz
         a/kA==
X-Forwarded-Encrypted: i=1; AJvYcCWI3TkmRRUe9cjnR5kiGZ9ZHIKj4TB7N5hYj5Y5O89dJvc69fv8ob43lXhJxsVbevTCpEzXpnqjr4q2oCTi4w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yy2RqajgVBTqTvgZiWThcmOk7FJre9yFturmyE0mCZcW9F5JEDW
	kllxtRG0u3oDunqOaSQmlR6fiypWb5WcqYV/o4eFdUL4hRTCyHi48kTEffYOPzXdVx/Cg33xjVL
	rkVDLaWY4ziExcnwlOp1XuK1KIlmDPss=
X-Gm-Gg: ASbGncu7fqCXtX0/EOuauwmcDUUUGCphmNecc55qfjggB3MOipyemL1t4tm4Q5ENIOz
	+HV8NsezugzwNB4HZCFkp2CeQatJ72zdzyt34/s/Y3wMcrOlTJFuTAtbqewCF1zuy4R1xlPt3Fg
	zS56DJOAX/quZZU+TmWmfC4N2IKVZ+w+1/9eA0VPvMlgGi3Rk8gBydRvp6RNqhRwYexxjY22I=
X-Google-Smtp-Source: AGHT+IH5YekqQgFJjUFrO0jzbtWB4khK1HL08YXCjPWwgh1Ae++V5Ftuu/LEstsULtasxSzfjfU1Vvotict2ReA0BHg=
X-Received: by 2002:a05:6402:268f:b0:634:a85c:8c9c with SMTP id
 4fb4d7f45d1cf-634a85c8e1dmr16501864a12.12.1759220984180; Tue, 30 Sep 2025
 01:29:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930042948.427154-1-wens@kernel.org> <CAHrRpunr+hbWiO1jY=jGZOiqGWcXFGYBSJi17+r-AgOMwssaXg@mail.gmail.com>
 <CAGb2v65wSPCeW=qgrjX1cBUfbYj55U9HUOdPw3n0zHm0PJpNNA@mail.gmail.com> <CAHrRpum=kos=b+h=dPvQ2YaoXqPCEudjuU9-VNGQYRg928x=Ug@mail.gmail.com>
In-Reply-To: <CAHrRpum=kos=b+h=dPvQ2YaoXqPCEudjuU9-VNGQYRg928x=Ug@mail.gmail.com>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Tue, 30 Sep 2025 16:29:33 +0800
X-Gm-Features: AS18NWCvK9jeI-jDeBFE1mrfn99Y7wy_1Q3dZLIBSV48e5aWfewnb74h57EdySs
Message-ID: <CAHrRpumYJ8T4E1__Gmiq_W7BCjURp7N-4F=+O+LQA8UTcyc6gA@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Permit lower 6 GHz band for Kazakhstan (KZ)
To: wens@kernel.org
Cc: Ping-Ke Shih <pkshih@realtek.com>, Pavel Starosek <starosekpd@gmail.com>, 
	wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Ping-Ke Shih <pkshih@gmail.com> wrote:
>
> Chen-Yu Tsai <wens@kernel.org> wrote:
> >
> > On Tue, Sep 30, 2025 at 3:25=E2=80=AFPM Ping-Ke Shih <pkshih@gmail.com>=
 wrote:
> > >
> > > Chen-Yu Tsai <wens@kernel.org> wrote:
> > > >
> > > > By Order of the Minister of Digital Development No. 564/NK dated
> > > > September 19, 2024 [1], an amendment was made to the assignment of
> > > > frequency bands, opening up the lower part of the 6 GHz band (5,945=
 MHz
> > > > to 6,425 MHz) was opened up to "SRD (wideband data transmission sys=
tems)
> > > > WAS/RLAN Data transmission systems/radio local area networks".
> > > >
> > > > The power is limited to 200 mW e.i.r.p. with a spectral density of =
10
> > > > mW/MHz. Only indoor use is permitted.
> > > >
> > > > While at it, also change the power limits to use mW units to match =
the
> > > > official documents.
> > > >
> > > > Initial information was provided by the Wi-Fi Alliance website, whi=
ch
> > > > has a map [2] showing all countries that have enabled 6 GHz WiFi, a=
nd
> > > > links to official documents. This document was not sufficient as it=
 did
> > > > not include power limits or other restrictions.
> > > >
> > > > A subsequent search found a blog post [3] providing details and tit=
les
> > > > of the official documents in English. An AI agent was used to searc=
h
> > > > for the original text of said order [1] after rummaging through
> > > > government websites in Russian and Kazakh failed to find anything.
> > > >
> > > > [1] https://adilet.zan.kz/rus/docs/V2400035100
> > > > [2] https://www.wi-fi.org/regulations-enabling-6-ghz-wi-fi
> > > > [3] https://www.onewindow.pro/blog-posts/6-ghz-band-regulation-in-t=
he-republic-of-kazakhstan
> > > >
> > > > Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
> > > > ---
> > > > If you received this patch, please help review it. The changes are
> > > > based on translations of the original text / tables, so a second se=
t
> > > > of eyes would be appreciated.
> > > >
> > > >  db.txt | 9 +++++----
> > > >  1 file changed, 5 insertions(+), 4 deletions(-)
> > > >
> > > > diff --git a/db.txt b/db.txt
> > > > index 6e1ad30..16bcb32 100644
> > > > --- a/db.txt
> > > > +++ b/db.txt
> > > > @@ -1136,11 +1136,12 @@ country KY: DFS-FCC
> > > >  # http://adilet.zan.kz/rus/docs/V1500010730
> > > >  # http://adilet.zan.kz/rus/docs/V1500010375
> > > >  country KZ: DFS-ETSI
> > > > -       (2400 - 2483.5 @ 40), (20)
> > > > -       (5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW
> > > > +       (2400 - 2483.5 @ 40), (100 mW)
> > > > +       (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
> > > >         (5250 - 5350 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW
> > >
> > > The power limit of 5150-5350 MHz is 200 mW, maximum spectral density
> > > e.i.r.p. 10 mW/MHz.
> > >
> > > So, 5250 - 5350 should be 23 dBm or 200 mW.
> >
> > I had this question as well. Looking at the original submission history=
,
> > it seems that the limit for 5250-5350 MHz was halved to cover TPC
> > requirements. See [1]. I'd like to follow the existing values unless
> > someone can point to documents stating otherwise.
>
> Thanks for the info. Would you like to add the reference to commit messag=
e?
> Anyway, it is fine to me.
>
> Reviewed-by: Ping-Ke Shih <pkshih@gmail.com>

Ah. Sorry. Please apply my company e-mail.

Reviewed-by: Ping-Ke Shih <pkshih@realtek.com>

>
> >
> > Thanks
> > ChenYu
> >
> > [1] https://lore.kernel.org/wireless-regdb/20191029144815.GR30813@ubunt=
u-xps13/
> >
> > > > -       (5470 - 5725 @ 160), (20), NO-OUTDOOR, DFS
> > > > -       (5725 - 5850 @ 80), (20), NO-OUTDOOR
> > > > +       (5470 - 5725 @ 160), (100 mW), NO-OUTDOOR, DFS
> > > > +       (5725 - 5850 @ 80), (100 mW), NO-OUTDOOR
> > > > +       (5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
> > > >         (57000 - 66000 @ 2160), (40)
> > > >
> > > >  country LB: DFS-FCC
> > > > --
> > > > 2.47.3
> > > >
> > > >

