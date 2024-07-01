Return-Path: <linux-wireless+bounces-9749-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FED791D9DE
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 10:23:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F58D1C20F3C
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 08:23:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5180282485;
	Mon,  1 Jul 2024 08:22:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uKGTUtI+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D46078C67
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 08:22:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719822170; cv=none; b=tuWqPpOvf3EpfugLHobZr+abjboCuyObpxB0+OrEa/YlTPW2fIcIFK7HYBYa89I0pb0uwIEPruAb6/lGwo6DXTVIchtB/ggTrBum/Eq5Jmdkgg37ixEoVULbLrL2edPcrawkkqYNkTBhgGfzFlGLwlbWLO4DE5Uc5tdFdQroq44=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719822170; c=relaxed/simple;
	bh=etDKPv7Xh9jyEOTpkdontCfJuNZCwvUVLWArvma6Xnw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=F7J2uUuL4nTGL/724wWFwheeIKyJwNe9lrGfs0oDCp2/y3ofcXiYYrxoV+NniYlQ5AZsamarHiX2J+niUihBXT+kPAeYnlHmk0WBjIl/1Ix29XEb6yart04GdyFk6cIg1XBQU9MEoUjUF/otOEGaQoOioV9KlqJxmevjAOCm6Cg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uKGTUtI+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A9130C32786
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 08:22:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719822169;
	bh=etDKPv7Xh9jyEOTpkdontCfJuNZCwvUVLWArvma6Xnw=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=uKGTUtI+44ZVfmyJhsolXFllv3q23tvQsM3Vj1szw1KMmIBRLNydxu+fmUMAcUWwx
	 X6wfE5fUzlF+c9pGJ4FAV/uDaR5PgL/dRLJJ4bwe/6MqsZNAObt8nCy8F+dvzoq/H1
	 MMCxpD8EGafV2iZpGHwdt3X7PUMZCE5V9U+cIo07P6HhUMezmmX4WlPNyprCV9LN7Y
	 heN8v7Z+weN3nu20hVHOvHcGJ6P49z++CegK9pq84rWDZFOsvJwYOQTYkjjE9EkNcz
	 sPRRa2z2m1TuZ4jmZTnlkgOqNOO6b5M/iBDlhR/zDtELLkJOzM/x3Y1wpZ8Ee1Z2Su
	 xsUV/5QJ/muMg==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2ebe6495aedso27869591fa.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jul 2024 01:22:49 -0700 (PDT)
X-Gm-Message-State: AOJu0Yy+QsB0VSJLruX5doaeiv/VtkFU3Uxij1YF4gjSf1m9tn9aXA3j
	2wY8maiSqGc7WyvcJRJb0+eCyvRRTKQVAuHTVqFIiheWBaNszf4LeKjj+IS+ihJJGwu2Eoaxr18
	47ICfC5jjAhq87tvAn3KAeh/RIEQ=
X-Google-Smtp-Source: AGHT+IG8RbFpu2qiW1h6ieR5fk4bV7qtPVD01aL5AJOdpK06BM0QyhDeHX/bAVd0V7j7qdIDIVZ/loisV06KDGsJlzQ=
X-Received: by 2002:a2e:88ca:0:b0:2ec:529e:6522 with SMTP id
 38308e7fff4ca-2ee5e3b3823mr32033411fa.31.1719822167969; Mon, 01 Jul 2024
 01:22:47 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624025623.6021-1-pkshih@realtek.com> <20240624025623.6021-2-pkshih@realtek.com>
In-Reply-To: <20240624025623.6021-2-pkshih@realtek.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 1 Jul 2024 16:22:35 +0800
X-Gmail-Original-Message-ID: <CAGb2v651jAs9g-UqCeoPgmiigpNDTVY_itvhwq9VBHPuzfdPRg@mail.gmail.com>
Message-ID: <CAGb2v651jAs9g-UqCeoPgmiigpNDTVY_itvhwq9VBHPuzfdPRg@mail.gmail.com>
Subject: Re: [PATCH v2 2/4] wireless-regdb: Update regulatory info for Jordan
 (JO) for 2022
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 24, 2024 at 10:56=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> =
wrote:
>
> The Hashemite Kingdom of Jordan, Telecommunications Regulatory Authority
> issued pursuant to the provisions of Articles (12A) and (22) of the
> Telecommunications Law No. 31 of 1995, as amended. [1]
>
> The effective radiated power (EIRP) of devices used in local radio comput=
er
> networks must not exceed the following values:
>
>  - 2400-2483.5 MHz: 100 milliwatts (20 dBm)
>  - 5150-5350 MHz: 200 milliwatts (23 dBm), (ETSI: 20 dBm, DFS)
>  - 5470-5725 MHz: 1 watt (30 dBm), (ETSI: 27 dBm, indoor only, DFS)
>  - 5725-5875 MHz: 200 mW (23 dBm), (ETSI: indoor only)
>  - 5925-6425 MHz:
>    * 25 milliwatts (14 dBm) (for outdoor and portable devices)
>    * 200 milliwatts (23 dBm) (for devices operated indoors only)
>  - 57-71 GHz: 10 W (40 dBm)
>
> Follow ETSI EN 301 893 [2], which specifies reduced power limit of
> 20 and 27 dBm for the range 5150-5350 and 5470-5725 respectively for
> devices that don't implement TPC; and classifies the 5470 - 5725 MHz and
> 5725 - 5875 MHz ranges as indoor use only; and DFS is required for bands
> 5250 - 5350 Mhz and 5470 - 5725 Mhz. (Add these rules followed rules of
> [1] with "ETSI:" annotation)
>
> [1] https://trc.gov.jo/EchoBusV3.0/SystemAssets/PDF/RSMD/cb9f9a83-43a6-4e=
66-8432-6e02ecaf465b_RLAN%20Arabic%20%20Final%20-%20clean%20with%2057-71%20=
GHz.pdf
> [2] https://www.etsi.org/deliver/etsi_en/301800_301899/301893/02.01.01_60=
/en_301893v020101p.pdf
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> v2:
>   - Follow ETSI EN 301 893 to modify limits, and add description in commi=
t
>     message.
>   - add 57-71 GHz
> ---
>  db.txt | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index 61c46186919e..60343a745ecf 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -957,10 +957,16 @@ country JM: DFS-FCC
>         (5490 - 5730 @ 160), (24), DFS
>         (5735 - 5835 @ 80), (30)
>
> +# Source:
> +# https://trc.gov.jo/EchoBusV3.0/SystemAssets/PDF/RSMD/cb9f9a83-43a6-4e6=
6-8432-6e02ecaf465b_RLAN%20Arabic%20%20Final%20-%20clean%20with%2057-71%20G=
Hz.pdf
> +# ETSI EN 301 893: https://www.etsi.org/deliver/etsi_en/301800_301899/30=
1893/02.01.01_60/en_301893v020101p.pdf
>  country JO: DFS-JP

Change this to DFS-ETSI given that the official regulations just point
to ESTI for details.

> -       (2402 - 2482 @ 40), (20)
> -       (5170 - 5250 @ 80), (23)
> -       (5735 - 5835 @ 80), (23)
> +       (2400 - 2483.5 @ 40), (20)
> +       (5150 - 5350 @ 80), (20), DFS

Per ETSI regulations, DFS is only required for 5250 - 5350. Please split
this into two rules. And please add AUTO-BW to both.

Also, looking at the official regulations again, I believe it is worded
in a way that does not require TPC for 5150 - 5350. So please raise the
limit back up to 32 dBm.


Thanks
ChenYu

> +       (5470 - 5725 @ 80), (27), DFS, NO-OUTDOOR
> +       (5725 - 5875 @ 80), (23), NO-OUTDOOR
> +       (5925 - 6425 @ 320), (23), NO-OUTDOOR
> +       (57000 - 71000 @ 2160), (40)
>
>  # Source:
>  # https://www.soumu.go.jp/main_content/000635492.pdf
> --
> 2.25.1
>

