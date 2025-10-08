Return-Path: <linux-wireless+bounces-27870-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B534BC33D0
	for <lists+linux-wireless@lfdr.de>; Wed, 08 Oct 2025 05:32:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 0F6254E2131
	for <lists+linux-wireless@lfdr.de>; Wed,  8 Oct 2025 03:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CAD2D1F3B9E;
	Wed,  8 Oct 2025 03:32:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P+mLPI7a"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFEBD1E47B7
	for <linux-wireless@vger.kernel.org>; Wed,  8 Oct 2025 03:32:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759894356; cv=none; b=gO5Bu+jXNuunr7mj0uXW3nzzhSMHk99EVfdidTXr80hN6RBdq+jDQS/3CwAiT/ASBzesmsO+NMZr2MHaMeTev4x3rsmVDrAyQhIbsI6jTxbM3xqAysAFTM3nFecid8Zx9cX6bhNT3bfgA7F9yaxqCkjj6tXtp0Hoqj5ILkti0/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759894356; c=relaxed/simple;
	bh=YrokMqaxOBm1goEhA4a+EtJD7pOTFXPHjnKktJv8+NM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qPDLl2+4RJGFHoVsidmnMxhbi/pjIGcYn/jdgMajKV5ZU3b0p6NgxVqP+cLoUuG4OiB8Uy0hZt8ETCC+kYOGgIDSLvDGZ90BcSLo5OBDdQ0bm1xrqEL+DArgXUlkiZSZxYLDihJq1y20AjGlQ2U2AbqulsUb/8ciWzW5xA1+UQM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=P+mLPI7a; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-6399328ff1fso5530423a12.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Oct 2025 20:32:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759894353; x=1760499153; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XVtbU06OwyLC0jr5JiAhopuYtCoxnhI1Lx98zt/ULbY=;
        b=P+mLPI7aHrqMgVjRgLRrWBDmPqAxV8PwVvqyDD1+v0b8a5qGMy1YTRlPc9tRguxuCN
         /hPJntpkcpcQZl/1T/8/kFmZzJFWSRpnBAVVnCe+JsziwDiD4Xff8fXXiyEu2bHZhOUl
         QbApEYpSYhoLnxTRz3ZuF7EBAJo81T2VxSQmjkI34eMXxgjxAwcFJ/xP505gwLndP8x2
         Gic7xoKCiO6GbQc6ZFwH8qcbrEb30MDongD6fjTLAHhzwKbD7Wyi9nLS/H9z3WiS6XsQ
         XRTbnxzSQSjPd7c/XqX/3LOK3At982f0egA8aa6IBmQ0aNiURdnUg002puyPVE4l2OcV
         idgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759894353; x=1760499153;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XVtbU06OwyLC0jr5JiAhopuYtCoxnhI1Lx98zt/ULbY=;
        b=hHwYs2OIaXO3WnK3sMxZPVt47OpxCNG7iXtKs1OIn1q/uE35mrLjnxX4zfByEox6+M
         y1T06H7ySFJM/1y4PrwzL9dP6vr57ilJc63AMex8Xmv5PEVczh1Jwm12b0Tzb/fpR0wF
         iK3EUOhLLVMS9uuF+3p4mRnrFdSU4Q+hefNUGWmXmJUGILWdBBLH1NEKRnKvnbLlQ94D
         7YDHPBUagX4gkKHLtbjBDxC9U1NmETpflGC0GWkW43Ke7ZD6FxUHMf+Ye/m8OHAFDD4n
         oC5GY+SHbxawgLoRp+Vp1lQYCzWyFGbYSx0I9OE2rUayRhMYL5rnnug13G4MqU8YksxX
         7Hbw==
X-Gm-Message-State: AOJu0YzLcqb3kC6xuw87dzQxFVXEi+Gw+bAH7lM5tLkrFhR2ruKIeSsh
	TwaDR2TOOAlmeIL2FbAEmERs+GJ9XUwz488FbKaVa1LLGkZjcsMtmkzdiUpmGY7lX8fxe8jcg75
	1YFXRJF1HUNTpNN0WjXpYqka9J9ko5et0l+WH
X-Gm-Gg: ASbGncsLpdd9Mw4QYCNvDBCZmg+5hdof5QEAexxkzQQuH7woSgS8GPvv9WmEz2e3qDo
	4YAnXveREJBBTnXk8JbXhzDXZgSj8ZlbHotI+hAPHaW2TJ44uUlCHQjq0NU2eMBmGP4Ro569oat
	BZf2vCIWfG0IRCy/2HuxHq+6qU1o5UnMotWPdoaZsKmYaI4dUyK8DIrV4l8Mb9u/5Z/NlHsxVGz
	1F71XA2seaAKJmC+bbKgoj3MF9NI58=
X-Google-Smtp-Source: AGHT+IGDA4Abifp0w5BmEaUtMt7hdS7tcWSKJB7TRkW6Mg8zA4ebEw9eKSFqKcda03CIA/OPyIZXiPIFbHPb8w0wveI=
X-Received: by 2002:a17:906:6a22:b0:b37:4f78:55b2 with SMTP id
 a640c23a62f3a-b50ac1cba08mr191722666b.34.1759894352826; Tue, 07 Oct 2025
 20:32:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924022156.8435-1-pkshih@gmail.com> <CAGb2v66MZpd8QWYptLrh5O5qf-DWAnqxf3d692JWZoF3jCRj0g@mail.gmail.com>
In-Reply-To: <CAGb2v66MZpd8QWYptLrh5O5qf-DWAnqxf3d692JWZoF3jCRj0g@mail.gmail.com>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Wed, 8 Oct 2025 11:32:21 +0800
X-Gm-Features: AS18NWALd6DUHPpzrSv7YsfTr8EYXeFtkEbTMcH2t9iVUBXgFXf6dYgI15FkH6U
Message-ID: <CAHrRpuknX-Ptz990dqKpPAN71k_fNdJT5aX3CcmckyeOgC9MJA@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info including
 bandwidth for Trinidad and Tobago (TT) for 2025
To: wens@kernel.org
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Chen-Yu Tsai <wens@kernel.org> wrote:
>
> Hi,
>
> On Wed, Sep 24, 2025 at 10:22=E2=80=AFAM Ping-Ke Shih <pkshih@gmail.com> =
wrote:
> >
> > From: Ping-Ke Shih <pkshih@realtek.com>
> >
> > The Telecommunications Authority of Trinidad and Tobago [1] provides
> > Schedule of Devices Eligible for Use under a Class Licence [2]. The
> > type 1 (End-user devices or customer premise equipment) with Schedule B=
.1
> > and B.2 shows
> >
> >  - 2400 - 2483.5 MHz
> >    * 30 dBm
> >  - 5150 - 5250 MHz
> >    * 24 dBm
> >  - 5250 - 5350 MHz
> >    * 24 dBm
> >  - 5470 - 5725 MHz
> >    * 24 dBm
>
> For these bands, the rules specify ERP, or effective radiated power.
> However it states "Maximum Effective Radiated Power ERP (from RF
> transmitter)", so I think it is meant to "maximum conducted output
> power" as seen in FCC rules?
>
> This is not the same as EIRP, or effective isotropic radiated power.
> AFAIK the latter is what is supposed to be used in the database. This
> discrepancy is found in many rules originating from the FCC rules. The
> FCC rules specify maximum conducted power (TX power) plus max antenna
> gain in dBi.
>
> So there is some conversion involved. I think the values should be
> "max conducted power" + "max gain in dBi". This assumes no cable loss.
>
> I think we would also need to revisit the US rules.

Thanks for the detail, but I still not clear if I should use ERP +
antenna gain as
EIRP, or should I apply FCC requirements as hard power limit?

By [1], it also mentioned limits of maximum power spectral density, if we a=
lso
apply the limits, the values will be almost what I wrote, which are also al=
most
the same as US country in db.txt.

[1] https://www.law.cornell.edu/cfr/text/47/15.407

>
> >    * extend 5 MHz to 5730 MHz for channel 144
> >  - 5725 - 5850 MHz
> >    * 30 dBm
> >  - 5925 - 6425 MHz
> >    * 24 dBm
>
> These two bands have 0 dBi for max antenna gain, so max TX power =3D=3D
> max EIRP.
>
>
> ChenYu
>
> > [1] https://tatt.org.tt/licensing/class-license/
> > [2] https://tatt.org.tt/wp-content/uploads/2025/07/Schedule-B_Schedule-=
of-Devices-Eligible-for-Use-under-a-Class-Licence-25th-July-2025.pdf
> >
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> > ---
> > Hints to find these entries: by searching "Wi-Fi" with type 1 in [2].
> > ---
> >  db.txt | 13 ++++++++-----
> >  1 file changed, 8 insertions(+), 5 deletions(-)
> >
> > diff --git a/db.txt b/db.txt
> > index 6e1ad30222a4..90ffa4e0d5d7 100644
> > --- a/db.txt
> > +++ b/db.txt
> > @@ -1946,12 +1946,15 @@ country TR: DFS-ETSI
> >         # 60 GHz band channels 1-4, ref: Etsi En 302 567
> >         (57000 - 66000 @ 2160), (40)
> >
> > +# Source:
> > +# https://tatt.org.tt/wp-content/uploads/2025/07/Schedule-B_Schedule-o=
f-Devices-Eligible-for-Use-under-a-Class-Licence-25th-July-2025.pdf
> >  country TT: DFS-FCC
> > -       (2402 - 2482 @ 40), (20)
> > -       (5170 - 5250 @ 80), (17), AUTO-BW
> > -       (5250 - 5330 @ 80), (24), DFS, AUTO-BW
> > -       (5490 - 5730 @ 160), (24), DFS
> > -       (5735 - 5835 @ 80), (30)
> > +       (2400 - 2483.5 @ 40), (30)
> > +       (5150 - 5250 @ 80), (24), AUTO-BW
> > +       (5250 - 5350 @ 80), (24), DFS, AUTO-BW
> > +       (5470 - 5730 @ 160), (24), DFS
> > +       (5730 - 5850 @ 80), (30)
> > +       (5925 - 6425 @ 320), (24)
> >
> >  # Source:
> >  # Table of Frequency Allocations of Republic of China (Taiwan) / Feb 2=
017:
> > --
> > 2.25.1
> >

