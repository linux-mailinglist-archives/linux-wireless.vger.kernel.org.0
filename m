Return-Path: <linux-wireless+bounces-12228-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FBE49656C1
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 07:11:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 98522B22456
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 05:11:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76F651487F1;
	Fri, 30 Aug 2024 05:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BMzSeeIR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5243B145B21
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 05:11:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724994701; cv=none; b=eeliDTva56dz8J6MEKkEFV3788NmLqFU1P9m8KuYOuwW/z62OUCzQpTjvTnAHchJliyM3s/m3nqb8DuzoPCB257GLZNErqATn+aF9UVHPkcm2lIG8HiKehfyqOmen0vmr7GahGaozQJ2/pV4nxm6WciwJXdqWOow2Zm7Bc8fWzg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724994701; c=relaxed/simple;
	bh=lUVTzlqIl1gRgb48cDT9zmapdJGJAG5HEb76hLGHF18=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=g5iuKbihISwgWetJBkckF2WsmIqQwIhikHtAZYo8l0WuDo9FkM1L/pUQThVJEFBF1N3mH5fMzpxUBKxw3F9iOqsJhaiVmhfl+1++DWdTKXGnzfRUjbPq0VxGVc4JQ10nGYpfLWIGrqBEFX+mZFrnIJ9oO7E76R4eBhSfnjbX5es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BMzSeeIR; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7336C4CEC5
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 05:11:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724994700;
	bh=lUVTzlqIl1gRgb48cDT9zmapdJGJAG5HEb76hLGHF18=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=BMzSeeIRuTb3yLiul3yBhBlB+eQ9BAf6mSwJ80qsKJiUqNIk4MbzQ3o+/u41eNCwA
	 ip7DCcvwFl4EY5eS08ERD0e7tmL4GBy9mWS9SC8H7kZwD0v4N9F7LPGgKGM1a71oEG
	 l1lGiaISv280iyyLW3OAvuDXqSL8lvHjXW1Gy5VEIwc8HCua/gT5OQHZuWON7o9Awd
	 X9vONfBC6edkzqC9UV0+rJkhAbJ6mTaAZlddaMDlM24xjHPSC2okW65JS9ogkNCKYG
	 258fK3UWAVnNjYcD/Kd+BK54RU3DvvjdrNs4bKTouzvysHr9viMfVkgaQ6zXTwkGlK
	 lUIhsieGJlF7Q==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2f50f1d864fso15425181fa.1
        for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2024 22:11:40 -0700 (PDT)
X-Gm-Message-State: AOJu0YwqguPovF8Z+MPtM7S0ne5PnUiu6tUAhJIGc9q29/Dh5CNwRJhc
	A8SIVN21hUU522EEKq9aEZ+rv0akdfERfjsM7r2rzX8ZwqisCSyYwFc/4Ry1gVAufTpXbUBVE9o
	IY33MQF7gMryIJUwRDTFt84rrjX4=
X-Google-Smtp-Source: AGHT+IFDlrCbObFWC1YfVOWK8MLL0QcnU/O1cKtjCCOqW8niklN+iAadyLU61BXNgCphUfQUjd9mMBrcIeWcDE3jpwA=
X-Received: by 2002:a05:651c:502:b0:2f5:136d:89ef with SMTP id
 38308e7fff4ca-2f6103e391amr40331661fa.22.1724994699196; Thu, 29 Aug 2024
 22:11:39 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828084706.12257-1-pkshih@gmail.com> <20240828084706.12257-2-pkshih@gmail.com>
In-Reply-To: <20240828084706.12257-2-pkshih@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 30 Aug 2024 14:11:25 +0900
X-Gmail-Original-Message-ID: <CAGb2v653gw3FvUmZtYt_sOZa+cxLJo=_cRGBr=gAjuF8eBx1pw@mail.gmail.com>
Message-ID: <CAGb2v653gw3FvUmZtYt_sOZa+cxLJo=_cRGBr=gAjuF8eBx1pw@mail.gmail.com>
Subject: Re: [PATCH 2/4] wireless-regdb: Update regulatory info for Kuwait
 (KW) for 2022
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 5:52=E2=80=AFPM Ping-Ke Shih <pkshih@gmail.com> wro=
te:
>
> From: Ping-Ke Shih <pkshih@realtek.com>
>
> Kuwait, CITRA (Communication & Information Technology Regulatory Authorit=
y)
> released Regulations for Wi-Fi service on 2022 [1] via page [2].
>
>  * 2400 - 2483.5 MHz
>    - upper limit 100 mW; 10 mW/MHz (adopt 100 mW)
>  * 5150 - 5250 MHz
>    - upper limit 200 mW; 10 mW/MHz (adopt 200 mW)


>  * 5250 - 5350 MHz
>    - upper limit 100 mW; 10 mW/MHz (adopt 100 mW)
>    - DFS
>  * 5470 - 5725 MHz
>    - upper limit 500 mW; 50 mW/MHz (adopt 500 mW)
>    - DFS
>  * 5725 - 5825 MHz
>    - upper limit 500 mW; 50 mW/MHz (adopt 500 mW)
>    - DFS

TPC is required for the three bands above. If we follow the referenced
ESTI standard EN 301 893, then operating without TPC requires to drop
the power limit by 3 dBm. However that standard does not conver the
5.8 GHz range.

On the other hand, EN 302 502, the standard covering 5.8 GHz, does not
give a separate limit for systems without TPC.


ChenYu

>  * 5925 - 6425 MHz
>    - 200 mW
>    - indoor only
>
> [1] https://citra.gov.kw/sites/ar/Lists/CITRALaws/Attachments/14/%D8%A7%D=
9%84%D9%84%D8%A7%D8%A6%D8%AD%D8%A9%20%D8%A7%D9%84%D8%AA%D9%86%D8%B8%D9%8A%D=
9%85%D9%8A%D8%A9%20%D9%84%D8%AE%D8%AF%D9%85%D8%A9%20%D8%A7%D9%84%D9%88%D8%A=
7%D9%8A%20%D9%81%D8%A7%D9%8A.pdf
> [2] https://citra.gov.kw/sites/ar/Pages/CITRALaws.aspx
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index ad8dddc9c800..50ebd50becbd 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1050,10 +1050,14 @@ country KR: DFS-JP
>         # 60 GHz band channels 1-4
>         (57000 - 66000 @ 2160), (43)
>
> +# Source:
> +# https://citra.gov.kw/sites/ar/Lists/CITRALaws/Attachments/14/%D8%A7%D9=
%84%D9%84%D8%A7%D8%A6%D8%AD%D8%A9%20%D8%A7%D9%84%D8%AA%D9%86%D8%B8%D9%8A%D9=
%85%D9%8A%D8%A9%20%D9%84%D8%AE%D8%AF%D9%85%D8%A9%20%D8%A7%D9%84%D9%88%D8%A7=
%D9%8A%20%D9%81%D8%A7%D9%8A.pdf
>  country KW: DFS-ETSI
> -       (2402 - 2482 @ 40), (20)
> -       (5170 - 5250 @ 80), (20), AUTO-BW
> -       (5250 - 5330 @ 80), (20), DFS, AUTO-BW
> +       (2400 - 2483.5 @ 40), (100 mW)
> +       (5170 - 5250 @ 80), (200 mW), AUTO-BW
> +       (5250 - 5350 @ 80), (100 mW), DFS, AUTO-BW
> +       (5470 - 5825 @ 160), (500 mW), DFS
> +       (5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
>
>  country KY: DFS-FCC
>         (2402 - 2482 @ 40), (20)
> --
> 2.25.1
>

