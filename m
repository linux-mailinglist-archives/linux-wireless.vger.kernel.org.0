Return-Path: <linux-wireless+bounces-18832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 052F2A32190
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 09:56:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7BEE11887CD3
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Feb 2025 08:56:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FAF71D86DC;
	Wed, 12 Feb 2025 08:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F/m2G+Wd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48632271828
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 08:56:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739350596; cv=none; b=Rq+4d9g/VdVkSFW2Bb6anLleuJEDEnUsuYR5JnB1Chk5OfjTeAoeyvIIsGDbgM161/bv79cexauOsKbNJhSEc56UAfLZb5MZnmOfETXEqqJ8gUW4LLzaI73GoBItkWT0Ddd6h5klt+qAssp5W5UYARejHIJzLDBRD6hQu5G2xAA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739350596; c=relaxed/simple;
	bh=9iY0bTPEiF6cgKBOM/MVgOB4IJr80XFYsNHuBio+2Y4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pvR04z1VECLNc57omtCH3jwNNCqpjyyoonB1KkrZe2fzW/nep1KBdZU+oFNNLGd0mKq3oCTxc7cij6zoZL2VIA1gmyWmN3hs7zugtrn9yJprQlSBtYbEqGaQbqhCE2tEwihUoPG4AyCYyrGTVogxCcd3EdEaznSHbgffAJcQHSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F/m2G+Wd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A631BC4CEDF
	for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 08:56:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739350594;
	bh=9iY0bTPEiF6cgKBOM/MVgOB4IJr80XFYsNHuBio+2Y4=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=F/m2G+WdqLfqEQQ6StrAfP77Dw2q85o7IEQrG46gme/yFirCnty0XTr/okfr72e4W
	 z6GyAuoFQFeWM4bjU7lNWHkY5XZvcdY22hP5YhTNFWWmj7EWPy8N+y5Jk6hOcnSUqq
	 /AKW3fSRiR1ewC0tJrhdHCnPFJlJQVFFNT7c7muz+K8H+NKbK+eEGl7FFekHl0mSX5
	 JiuI01PqtqgDjtEwVaN8X/Mb40CnMF5M6CYVmCexcN/BXoDJd85m56V8a0MUdcIrQP
	 DKx6udUrTnSfo902X4mRjM3f9F1otRcfX+GszCKukxEzxWxV4/t3T3jeZ9eXh4jIvw
	 8Xt4+cSvZx5CA==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-308e92c3779so5847131fa.0
        for <linux-wireless@vger.kernel.org>; Wed, 12 Feb 2025 00:56:34 -0800 (PST)
X-Gm-Message-State: AOJu0YzzS9o9uvBvE+h7ZxDOJmeZCtqwSGaO5sIO4ZcbyyOwp6SlZ223
	XrxKRHBxOTzOhMtDohe53C4kkNB7x97tJkrvaYUr7/Q1CU1I9TEUaHgcqt1GWW28G6gaD5f/F9P
	H3QSYznoHZnpJKv1jUgH1ayMexbA=
X-Google-Smtp-Source: AGHT+IEPaeahhI9AP0YU7LtJNx1HreZhGiSsK7NEuLN3kYoKO5diqb9wNh5cPHYYg986jwNFMJmgi505lY4XRpsuti8=
X-Received: by 2002:a05:651c:2101:b0:302:251a:bcfe with SMTP id
 38308e7fff4ca-30904592604mr6901811fa.6.1739350593019; Wed, 12 Feb 2025
 00:56:33 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250129112554.27296-2-jakob.riepler@paranoidlabs.org>
In-Reply-To: <20250129112554.27296-2-jakob.riepler@paranoidlabs.org>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 12 Feb 2025 16:56:20 +0800
X-Gmail-Original-Message-ID: <CAGb2v67SbKbci+1MQH=ebVcf2oFUg6n0NxZB9jjcwMxsS2sJqg@mail.gmail.com>
X-Gm-Features: AWEUYZnat1IPN8e4uzhrgq_hXC3ByJc5btgg0RyctcTJDpVG4xtEfKmwQ2UBeHc
Message-ID: <CAGb2v67SbKbci+1MQH=ebVcf2oFUg6n0NxZB9jjcwMxsS2sJqg@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for Austria (AT)
To: Jakob Riepler <jakob.riepler@paranoidlabs.org>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 29, 2025 at 10:06=E2=80=AFPM Jakob Riepler
<jakob.riepler@paranoidlabs.org> wrote:
>
> According to the Austrian "Frequenznutzungsverordnung" Attachement 2
> page 404
> (https://www.ris.bka.gv.at/Dokumente/Bundesnormen/NOR40251378/II_61_2023_=
Anlage_2.pdf),
> Austria extended the usable range according to the EU SRD Band 75a (Imple=
menting
> decision 2019/1345, current consolidated version:
> https://eur-lex.europa.eu/legal-content/EN/TXT/?uri=3DCELEX%3A02006D0771%=
2801%29-20220210&qid=3D1738145465756)
>
> This probably applies to most other countries that are part of CEPT
> and/or EU but I'm not good enough with international law to be sure
> about others.
> It might be worth checking and updating this for many more countries.

Thank you for the information. Based on previous review, I believe each
country still publishes their own rules, even though they are based on
the EU's harmonized rules. Given that most countries publish them under
their official language, I think we would have to rely on local users
to provide updates, instead of me digging through websites in foreign
languages.

ChenYu

> This also updates two outdated links (the RTR one was a 404, the CEPT
> one redirects with a warning that this link wil stop working).
> Specifically the CEPT one might need updating for all other countries as
> well (also the link now seems to refer to a newer version of the document
> than the originally referenced one. v2.2.1 is from 2021 and was updated
> to include the 66-71GHz range as well).
>
> Signed-off-by: Jakob Riepler <jakob.riepler@paranoidlabs.org>
> ---
>  db.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index e282e3b..8a5c0bd 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -114,8 +114,8 @@ country AS: DFS-FCC
>  #  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/T=
XT/?uri=3DCELEX:02005D0513-20070213
>  #  EU decision 2006/771/EC: https://eur-lex.europa.eu/legal-content/EN/T=
XT/?uri=3DCELEX:02008D0432-20080611
>  #  EU decision 2021/1067/EC: https://eur-lex.europa.eu/legal-content/EN/=
TXT/PDF/?uri=3DCELEX:32021D1067&from=3DEN
> -# Harmonized CEPT countries (July 2019): https://www.ecodocdb.dk/downloa=
d/25c41779-cd6e/Rec7003e.pdf
> -# AT: https://www.rtr.at/en/tk/Spektrum5GHz/1997_bmvit-info-052010en.pdf
> +# Harmonized CEPT countries (February 2021): https://docdb.cept.org/down=
load/25c41779-cd6e/Rec7003e.pdf
> +# AT: https://www.rtr.at/TKP/was_wir_tun/telekommunikation/spectrum/band=
s/1997_bmvit-info-052010en.pdf
>  # AT: acceptance https://www.ris.bka.gv.at/Dokumente/BgblAuth/BGBLA_2014=
_II_63/BGBLA_2014_II_63.pdfsig
>  country AT: DFS-ETSI
>         (2400 - 2483.5 @ 40), (100 mW)
> @@ -126,8 +126,8 @@ country AT: DFS-ETSI
>         (5725 - 5875 @ 80), (25 mW)
>         # 6 GHz band
>         (5945 - 6425 @ 160), (23), NO-OUTDOOR, wmmrule=3DETSI
> -       # 60 GHz band channels 1-4 (ETSI EN 302 567)
> -       (57000 - 66000 @ 2160), (40)
> +       # 60 GHz band channels 1-6 (ETSI EN 302 567)
> +       (57000 - 71000 @ 2160), (40)
>
>  # Source:
>  # 'Item' in the comments below refers to each numbered rule found at:
> --
> 2.47.1
>
>

