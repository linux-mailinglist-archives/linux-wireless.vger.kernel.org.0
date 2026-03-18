Return-Path: <linux-wireless+bounces-33382-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id cBmkMb1kumklWAIAu9opvQ
	(envelope-from <linux-wireless+bounces-33382-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 09:39:25 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 3374A2B82FC
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 09:39:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 36E5C304483A
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Mar 2026 08:34:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A499536920E;
	Wed, 18 Mar 2026 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9ZDRoRv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D4E2459DC
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 08:34:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773822841; cv=none; b=bc+pyjvY/djLBm6jPqxCQZpZ1HrTUNII47pMfYBoNEpmhzDRuUzk3flT38aYq60YYf9VJBpLhdMei8QcncJAOQXrvUExf1/MGzK6MUZeETOJXmESI8GrsX6H8vyp1j9arUGDQ3Bccz0hFaZyl05EIEgQe50wM+wCDjICjXfmUKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773822841; c=relaxed/simple;
	bh=Rr7V3Tp0SLbeQUYmplQKFnVGM5fyp0F7ROgB9ujybFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=U0n1ODWGh+zVEWlPpBkRHayWeL7ZdYZvD1f8j4Zy9wTQ9mI0w1e0JrJERna35X3mivBZOYbrfrpp8GkUIK+qOzb4xyNIXwn9IQjpcQAyvNjTRmBLFa9OB0jVAp8aBtO5N55A3feHuIGaT4igibWdj1SXknurnN4bqQpfAMUI/h8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9ZDRoRv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B2C9C4AF0B
	for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 08:34:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773822841;
	bh=Rr7V3Tp0SLbeQUYmplQKFnVGM5fyp0F7ROgB9ujybFg=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=Z9ZDRoRv7CSlJOWS76mL8Cf6WqRLE/uKVF6WyzbZ4Mt1Ew8oh/z86LuBJiXt4WlsN
	 kM6e/VUscvGZEB8FwUcO7ceTHZa3hmQIQ+gC2Lk6u2nozTKPye7vHqJKsnXhMGSzVL
	 mgjO/1SCH6R0fvdnIvSrtZ4419cu8nZjkVYoxP+rMAEo8VOGx+57WaeKLUBp718dKt
	 S3QQ4PGNpXtbTwYDyjLmATk5xQvBrcu3ctL65qgm4w5G38N/p3ElyPIi6K6t8liFwO
	 R44mtXkQmdRgaHoFEYPrHoQWjHBs4NWUv0rthXGCwM27iQ1/Z6R+tIjfenFmkGCTt2
	 y2i0GtRjmdsUA==
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-38b50c79f2fso13780331fa.3
        for <linux-wireless@vger.kernel.org>; Wed, 18 Mar 2026 01:34:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YzfaxDlRevYSrel8YLzOv1/MPb3205pCKpDQuaOcCJWNvqieJr4
	6jwS06s5Wd4yVcDsNg8+icsujylWLzN1ocmDRndZqCRwNlmYIXrXXtazFHdBLcEujQBmIpMcG/4
	tuOjTkhS2cYeHA2V2U78hpkwHSNt4gw8=
X-Received: by 2002:a2e:3218:0:b0:38a:56d0:9d24 with SMTP id
 38308e7fff4ca-38bd5850543mr8541301fa.18.1773822839319; Wed, 18 Mar 2026
 01:33:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20260318064834.103731-1-pkshih@gmail.com>
In-Reply-To: <20260318064834.103731-1-pkshih@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 18 Mar 2026 16:33:47 +0800
X-Gmail-Original-Message-ID: <CAGb2v65PcZcBYg7qaeFaVH0=1fowOkW+7gL5wWA0wTMBu74JHg@mail.gmail.com>
X-Gm-Features: AaiRm515ymUQV6NzLLrYHCEkgTiS1JHZNlqKJwthyqKeaiTWpsK5F7tEKWkQZko
Message-ID: <CAGb2v65PcZcBYg7qaeFaVH0=1fowOkW+7gL5wWA0wTMBu74JHg@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Add regulatory info for CEPT countries
 FO, GI, IM, SM and VA listed by WiFi Alliance
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-33382-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com];
	TO_DN_SOME(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	REPLYTO_DOM_NEQ_TO_DOM(0.00)[];
	MISSING_XM_UA(0.00)[];
	HAS_REPLYTO(0.00)[wens@kernel.org];
	RCVD_COUNT_FIVE(0.00)[5];
	REPLYTO_ADDR_EQ_FROM(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[wens@kernel.org,linux-wireless@vger.kernel.org];
	RCPT_COUNT_THREE(0.00)[3];
	PRECEDENCE_BULK(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	NEURAL_HAM(-0.00)[-1.000];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,europa.eu:url,ui.com:url,mail.gmail.com:mid,cept.org:url,realtek.com:email]
X-Rspamd-Queue-Id: 3374A2B82FC
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

On Wed, Mar 18, 2026 at 2:48=E2=80=AFPM Ping-Ke Shih <pkshih@gmail.com> wro=
te:
>
> From: Ping-Ke Shih <pkshih@realtek.com>
>
> In commit 5a8ced5ad313 ("wireless-regdb: Update regulatory info for CEPT
> countries for 6GHz listed by WiFi Alliance"), the following are skipped a=
s
> they do not have corresponding entries in the database yet.
>
>      - Faroe Islands (FO)
>      - Gibraltar (GI)
>      - Isle of Man (IM)
>      - San Marino (SM)
>      - Holy See (Vatican City State) (VA)

Confirmed the list. Also checked against another source [1].

[1] https://help.ui.com/hc/en-us/articles/8691786444567-Regions-Supporting-=
6-GHz

> Look up the CEPT decisions [2], and add entries along with decisions [3],
> [4] and [5] for 2/5/6 GHz regulations.
>
> The 2 GHz band by ECC Decision (11)05 [3], which the adoption of ERC
> Recommendation 70-03 [6], the regulations and the frequency bands to be
> used for Short Range Devices (SRDs) are included in specific annexes to

The 2 GHz band is now governed by ERC Recommendation 70-03 [6] with the
withdrawal of ERC Decision ERC/DEC/(01)07 by ECC Decision (11)05 [3].

> this Recommendation. By ERC Recommendation 70-03 annex 3 (WIDEBAND DATA
> TRANSMISSION SYSTEMS):
>
>  * 2400-2483.5 MHz
>    - 100 mW

Looks correct.

ERC Recommendation 70-03 annex 3 also includes the 60GHz range (57-71 GHz).
Can you check that? We would need some other source of information like
the WiFi Alliance page to verify that the countries have adopted the
decision. I don't think the CEPT decisions are directly binding.

The end of the document also has a table of the implementation status
of some bands in some countries. It is obvious the table is not complete.

> The 5 GHz band by ECC Decision (04)08 [4]:
>
>  * 5150-5250 MHz
>    - 200 mW
>    - Indoor use
>  * 5250-5350 MHz
>    - 200 mW (due to TPC required, -3dBm, 100 mW is adopted)
>    - DFS, TPC
>    - Indoor use
>  * 5470-5725 MHz
>    - 1 W (due to TPC required, -3dBm, 500 mW is adopted)
>    - DFS, TPC
>    - Indoor and outdoor use
>
> The 6 GHz band by ECC Decision (20)01 [5]:
>
>  * LPI devices (adopted)
>    - 5945-6425 MHz
>    - Restricted to indoor use only
>    - Maximum mean e.i.r.p.: 23 dBm
>    - Maximum mean e.i.r.p. density: 10 dBm/MHz
>  * VLP devices
>    - 5945-6425 MHz
>    - Indoors and outdoors
>    - Maximum mean e.i.r.p.: 14 dBm
>    - Maximum mean e.i.r.p. density: 1 dBm/MHz

Looks correct.

> [1] https://www.wi-fi.org/regulations-enabling-6-ghz-wi-fi
> [2] https://docdb.cept.org/document/category/ECC_Decisions?status=3DACTIV=
E
> [3] https://docdb.cept.org/download/1535
> [4] https://docdb.cept.org/download/4501
> [5] https://docdb.cept.org/download/4685
> [6] https://docdb.cept.org/download/3700

This doesn't seem to be the latest version. The online version is here:

    https://docdb.cept.org/document/845

and shows the latest revision was published on Feb 13, 2026.

> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 35 +++++++++++++++++++++++++++++++++++
>  1 file changed, 35 insertions(+)
>
> diff --git a/db.txt b/db.txt
> index d54ef78e0da8..e2afb145ede5 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -731,6 +731,13 @@ country FM: DFS-FCC
>         (5490 - 5730 @ 160), (24), DFS
>         (5735 - 5835 @ 80), (30)
>
> +country FO: DFS-ETSI
> +       (2402 - 2483.5 @ 40), (100 mW)

This should start at 2400 for all the newly added countries.

> +       (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
> +       (5250 - 5350 @ 80), (100 mW), DFS, NO-OUTDOOR, AUTO-BW
> +       (5470 - 5725 @ 160), (500 mW), DFS
> +       (5945 - 6425 @ 320), (23), NO-OUTDOOR
> +
>  # FR as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 30=
1 893)
>  # and 2006/771/EC (amended by 2008/432/EC, Short-Range Devices, EN 300 4=
40)
>  #  EU decision 2005/513/EC: https://eur-lex.europa.eu/legal-content/EN/T=
XT/?uri=3DCELEX:02005D0513-20070213
> @@ -801,6 +808,13 @@ country GH: DFS-FCC
>         (5490 - 5730 @ 160), (24), DFS
>         (5735 - 5835 @ 80), (30)
>
> +country GI: DFS-ETSI
> +       (2402 - 2483.5 @ 40), (100 mW)
> +       (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
> +       (5250 - 5350 @ 80), (100 mW), DFS, NO-OUTDOOR, AUTO-BW
> +       (5470 - 5725 @ 160), (500 mW), DFS
> +       (5945 - 6425 @ 320), (23), NO-OUTDOOR
> +
>  country GL: DFS-ETSI
>         (2402 - 2482 @ 40), (20)
>         (5170 - 5250 @ 80), (20), AUTO-BW, wmmrule=3DETSI
> @@ -976,6 +990,13 @@ country IL: DFS-ETSI
>         (5725 - 5875 @ 80), (25 mW), AUTO-BW
>         (5945 - 6425 @ 320), (200 mW), NO-OUTDOOR
>
> +country IM: DFS-ETSI
> +       (2402 - 2483.5 @ 40), (100 mW)
> +       (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
> +       (5250 - 5350 @ 80), (100 mW), DFS, NO-OUTDOOR, AUTO-BW
> +       (5470 - 5725 @ 160), (500 mW), DFS
> +       (5945 - 6425 @ 320), (23), NO-OUTDOOR
> +
>  # Source:
>  # https://dot.gov.in/spectrummanagement/delicensing-24-24835-ghz-band-gs=
r-45-e-5150-5350-ghz-gsr-46-e-and-5725-5875-ghz
>  # https://dot.gov.in/spectrummanagement/license-exemption-5-ghz-gsr-1048=
e-dated-22102018
> @@ -1855,6 +1876,13 @@ country SK: DFS-ETSI
>         # 60 GHz band channels 1-4 (ETSI EN 302 567)
>         (57000 - 66000 @ 2160), (40)
>
> +country SM: DFS-ETSI
> +       (2402 - 2483.5 @ 40), (100 mW)
> +       (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
> +       (5250 - 5350 @ 80), (100 mW), DFS, NO-OUTDOOR, AUTO-BW
> +       (5470 - 5725 @ 160), (500 mW), DFS
> +       (5945 - 6425 @ 320), (23), NO-OUTDOOR
> +
>  # Source:
>  # Regulation N=C2=B0 2004-005 ART/DG/DRC/D.R=C3=A9g
>  country SN: DFS-FCC
> @@ -2072,6 +2100,13 @@ country UZ: DFS-ETSI
>         (5170 - 5250 @ 80), (20), AUTO-BW
>         (5250 - 5330 @ 80), (20), DFS, AUTO-BW
>
> +country VA: DFS-ETSI
> +       (2402 - 2483.5 @ 40), (100 mW)
> +       (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
> +       (5250 - 5350 @ 80), (100 mW), DFS, NO-OUTDOOR, AUTO-BW
> +       (5470 - 5725 @ 160), (500 mW), DFS
> +       (5945 - 6425 @ 320), (23), NO-OUTDOOR
> +
>  # Source:
>  # http://www.ntrc.vc/regulations/Jun_2006_Spectrum_Managment_Regulations=
.pdf
>  country VC: DFS-ETSI
> --
> 2.25.1
>

