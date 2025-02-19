Return-Path: <linux-wireless+bounces-19107-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA5FDA3AD0A
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 01:25:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B75413AB834
	for <lists+linux-wireless@lfdr.de>; Wed, 19 Feb 2025 00:25:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEA7BA45;
	Wed, 19 Feb 2025 00:25:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kfS4clM4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AC3717BA5
	for <linux-wireless@vger.kernel.org>; Wed, 19 Feb 2025 00:25:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739924713; cv=none; b=fQMVlAVlrTpxSCbolBy8Egeq/gJsx4kqncDnki6t5dscRiCJ5Fk4I0x0370/xNdFN6536W/TN2SGaT4nA6+CNp4HIedOOaZriC/IF8uh0xvwn39pVcBwuzN1d+EPSZQIIVUg1OhDOThp6eIBtog3eOuJKrRS4krgNiRzAfy0u8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739924713; c=relaxed/simple;
	bh=YvYq41GiwCVlJ3YpydlzY6jjMypg864VlNF6gGimVAM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pPl+mIJhopFu9KnPQgIVrwWbil+DTqJE54Xk4D6wcYCibIAzAbkUpOrq+7sx5p6vVSCjHE388ArNw1AlqHTUG0hsfIDmpfxLzDqdUh/YslOOW/FccgMaOxUq6RZf7IKC0AoIuiitnGS3uMCiKlOlOJyvnkH2II75nUVyB9j2BzM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kfS4clM4; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-aba868c6e88so748049666b.2
        for <linux-wireless@vger.kernel.org>; Tue, 18 Feb 2025 16:25:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739924709; x=1740529509; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=65jUrLBN/LLKjwx7RNV0Qdqfa/uMv6KZrrsG3GDWlyQ=;
        b=kfS4clM4iIfel/X+8n9D4/FmvxOYv0q6LFoPGbItzuU9kreB/LE2l32tgHb6Wi6HCc
         PmXdli/NiV/Cne3IbW9pPEhl54Un4avr4IOPjVR1bS12MqMMH+78U8xYMeW7M8XLovOo
         zAzr2Iy+W5aYUz/sNNB/Q5pJVmkJxhlIuFy7mHgrS4jtSaS4y2VxI/5xQxXySw+U5tKs
         YxVoWjdfOa+3B09yhGUBrSuTpNhWqMAFrxphaNUtI9JWQ/n+yl8J4+tS2qyPAevBrmDN
         dnXaXbZfzfTHnPbIjAeMWR/xeefW4J8RV9Hr64oEATVycOhfe/JhRYRW0fwcBRcjaKAE
         IQPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739924709; x=1740529509;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=65jUrLBN/LLKjwx7RNV0Qdqfa/uMv6KZrrsG3GDWlyQ=;
        b=u0S2Uld957mnP/y9/4aIsKFNuSTN2JNELgzMEzWVFOEEJ2ipTByV58x2Ky60k5bWNx
         31elkC+ZxZiRxHyQkeDT5mPnV8+fsojvwX3gQdHfz3No2T6GQqK2Rx6LOSj8vp+/VHaT
         xmnCYhe1owVcY3Qg7gAAuEagYsB09rcddx2+Y2HssrjbNoaB/ws599z4rlZxcOrTPBmP
         F83bJZq/Plsy+QyVZ6yMymLN1Kk+aswCMkLt7x/8QnbChjJxt5t3FCvh6LaBb4/eeYhh
         7sz/fnwiFAF5Lzg8bVi+u58djFh7+TkHop9JHuFkUNgkszgXoJOo4JddbGp/HSMcKjIC
         D7JA==
X-Forwarded-Encrypted: i=1; AJvYcCWUQTm2qVloWOekpZvh1BnL5rimLQbKUAe4zKvOkL9Cdk2YDjQVi3PpJpZzwANnpodRVSPj5ACNxcyaYdSytQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx1F2lZu318vRHVxjxAQ8XpWB5i+vryED+6cUhTkZ1uk6F/S0YX
	L0z+rXHKr6tuYJcVfYvXMjQ/kvH/lekKdWftvuCC91V30jdN3uDjfa9FkfJpW2WZdwXNOrw2X7h
	c2swyaRXJhWBEuwAcoeVaxWdYpt4=
X-Gm-Gg: ASbGncsMY1DqU+03tX3kcUPFq/Enhnsu9BFevEWctTWPOqYfiX2ruVIMQK5Y8/RN6pD
	cP5LL+sUVb4KB6iLz9n9ZtrRryCRt4D52MnFckNxPGm0lNvGD19Pn5uUwOerfTQoZ8kFfD10B
X-Google-Smtp-Source: AGHT+IH/eRR+jHwglhsHt7CzzanpkgEslZqXG2/Nd6MIcEZbE9Rc6okmt7/3o1ZBvkjMnyoEp1P+NF9j/633VosvxnA=
X-Received: by 2002:a17:907:7b8b:b0:aa6:7737:199c with SMTP id
 a640c23a62f3a-abb70b1f29bmr1591523566b.15.1739924709310; Tue, 18 Feb 2025
 16:25:09 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250218025957.13818-1-pkshih@gmail.com> <7c909df2-2651-497c-91c2-624a7e3db43f@mobintestserver.ir>
In-Reply-To: <7c909df2-2651-497c-91c2-624a7e3db43f@mobintestserver.ir>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Wed, 19 Feb 2025 08:24:58 +0800
X-Gm-Features: AWEUYZlVZBxj6AnTShq8nRpf9OMSgEmG2Ug6PpgLVdF15aiALjJJO9rGTHrKMhg
Message-ID: <CAHrRpu=kD7TdyKfD+MNFjFv2jRqfOS5wPzCsKa2O4hFnu8n80w@mail.gmail.com>
Subject: =?UTF-8?Q?Re=3A_=D9=BE=D8=A7=D8=B3=D8=AE=3A_=5BPATCH=5D_wireless=2Dregdb=3A_Update_regulat?=
	=?UTF-8?Q?ory_rules_for_Iran_=28IR=29_on_both_2=2E4_and_5Ghz_for_2019?=
To: Mobin Aydinfar <mobin@mobintestserver.ir>
Cc: wens@kernel.org, linux-wireless@vger.kernel.org, 
	wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Mobin Aydinfar <mobin@mobintestserver.ir> wrote:
>
> =DB=B1=DB=B8 =D9=81=D9=88=D8=B1=DB=8C=D9=87 =DB=B2=DB=B0=DB=B2=DB=B5 =DB=
=B0=DB=B6:=DB=B3=DB=B0:=DB=B3=DB=B8 Ping-Ke Shih <pkshih@gmail.com>:
>
> > From: Ping-Ke Shih <pkshih@realtek.com>
> >
> > Decision No. 4004-01DEC-CRA, 8th Edition - February 2019,
> > Radiocommunications and Regulatory Organization.
> > General radio license for the use of parts of the frequency bands
> > 2400-2483.5 MHz, 5150-5250 MHz, 5350-5250 MHz, 5470-5725 MHz, and
> > 5850-5725 MHz in radio access networks. [1]
> >
> > * 2400 - 2483.5
> >   - 100 mW e.i.r.p
> >   - 10dBm in every 1Mhz
> > * 5150 - 5250
> >   - 200 mW e.i.r.p
> >   - 10dBm/MHz per 1MHz bandwidth or -6dBm/25kHz per 25kHz bandwidth
> > * 5250 - 5350
> >   - 200 mW e.i.r.p
> >   - 10dBm/MHz per 1MHz bandwidth
> >   - DFS
> > * 5470 - 5725
> >   - 1000 mW e.i.r.p
> >   - 17dBm/MHz per 1MHz bandwidth
> >   - DFS
> >   - If TPC is not used, the maximum radiated e.i.r.p. must be reduced
> >     by 3dB.
> >   - Outdoor use only
> >     (Since NO-INDOOR flag is not supported by current format, don't add
> >      this entry.)
> > * 5725 - 5850
> >   - 4000 mW e.i.r.p
> >   - 36dBm in every 500 kHz
> >   - DFS
> >   - Outdoor use only
> >     (Since NO-INDOOR flag is not supported by current format, don't add
> >      this entry.)
> >
> > These information is from [4], Mobin Aydinfar shared the official link
> > [1]
> > (inaccessible from outside of Iran), a mirror version [2] and
> > translated
> > version [3].
> >
> > [1]
> > https://asnad.cra.ir/fa/Public/Documents/Details/73af8590-f065-eb11-968=
f-0050569b0899
> > [2] https://mobintestserver.ir/Iran-2.4Ghz-5Ghz-cra-official-doc.pdf
> > [3] https://mobintestserver.ir/Iran-2.4Ghz-5Ghz-cra-official-table.ods
> > [4]
> > https://lore.kernel.org/linux-wireless/c9ccf5ba-c091-45c4-9283-970bfa4f=
1afe@mobintestserver.ir/T/#u
> >
> > Cc: Mobin Aydinfar <mobin@mobintestserver.ir>
> > Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> > ---
> > db.txt | 9 ++++++---
> > 1 file changed, 6 insertions(+), 3 deletions(-)
> >
> > diff --git a/db.txt b/db.txt
> > index d56ad32d31c9..0189355dff17 100644
> > --- a/db.txt
> > +++ b/db.txt
> > @@ -934,9 +934,12 @@ country IN:
> >     (5470 - 5725 @ 160), (24), DFS
> >     (5725 - 5875 @ 80), (30)
> >
> > -country IR: DFS-JP
> > -   (2402 - 2482 @ 40), (20)
> > -   (5735 - 5835 @ 80), (30)
> > +# Source:
> > +#
> > https://asnad.cra.ir/fa/Public/Documents/Details/73af8590-f065-eb11-968=
f-0050569b0899
> > +country IR: DFS-ETSI
> > +   (2400 - 2483.5 @ 40), (100 mW)
> > +   (5150 - 5250 @ 80), (200 mW)
> > +   (5250 - 5350 @ 80), (200 mW), DFS
> >
> > # IS as part of CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 301
> > 893)
> > # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300
> > 440)
> > --
> > 2.25.1
>
> Thanks for the patch, I should mention the document date is February
> 2021, Not 2019.
>

I did copy and paste from Google translation. I will correct the by v3. Tha=
nks.

