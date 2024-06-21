Return-Path: <linux-wireless+bounces-9408-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0366E911E33
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 10:13:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A02A91F23FBF
	for <lists+linux-wireless@lfdr.de>; Fri, 21 Jun 2024 08:13:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CA5916EB5C;
	Fri, 21 Jun 2024 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8K8HIsW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37D1116EB51
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 08:02:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718956972; cv=none; b=ATu7IIT8mlCH52dOfCnwJg7wdZkAwix1itFdoX2pbhvSgPpa+igIhZlCwUgA9tLoR9yf/SqmZjesStwhB11c8znJ8KmROPac2kPag76HiWOBVZgJsWHQXxsnIQL6xhx5rBcTUH5bXaLsPgKQb5nu2aDknm91b2Ho7Eqbvd9MIZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718956972; c=relaxed/simple;
	bh=TX9PT3dsdR3Ku8elxbSi4dnTMBFv0/L4MzW3NGz2bXg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XR2mCQm8GOZupfOF4qXbrlgnqCJNt9IHuGIGYYzZQWGF0uoXrzh1gFaxjT16O80VoB4+M+39qvVWbvnv5MevWI+cZOxmcc+0aEV/adkvSPT4AwDjTHG3tng/VW/Ym2hHQzHCekkGpO9mv8/Hdt0URovUo7yuFKaP+Hra/yuzmpM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8K8HIsW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BFBC2BBFC
	for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 08:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718956972;
	bh=TX9PT3dsdR3Ku8elxbSi4dnTMBFv0/L4MzW3NGz2bXg=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=k8K8HIsWt0T6gKeTduGlnl2KjdOUJ9yvtOHPB0BWUSUqq1yrN/HroTl1Uaw4CJdxf
	 W8MYsuF3ZC8ysO8V8joVXdWGii7Sf2rGoudUAJ3wZPJIrbZXzoJIrU4pZaEsRCvw4m
	 mWMtyRYrv5Qaevb5PExV8AOzW7N78I7+/9jgpwv67cydB3Ipwow/4E5609/psMSgnu
	 2PoyxzcMiQ/qWBKkA0C0k7lBVr24Yss9s3TXP/0TvIgaLE0bMVcFX3yZSWIdG91y6Y
	 +Fy/je7gFSQhJeIM52TxD/L0wksaLSIyHePw/1ULzfw4GlF2Sqg8KHXCKZv9uFbkVD
	 /51fscQBAWFlw==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ebe40673e8so17034511fa.3
        for <linux-wireless@vger.kernel.org>; Fri, 21 Jun 2024 01:02:52 -0700 (PDT)
X-Gm-Message-State: AOJu0Yxxnz1Lb9vWBzbj+0WpiAe7easpMqJlZBP0QPyF1ZA4a1+1esEw
	HkODt4/n6vD/Fxe+58Hi3XOVSZMjKhEF/LQ+oeeGzgkR7lsdv8RO0VNvN/GKorJ0LwxRaDYTQj+
	m1fYQPtRqvTxmoMclzwa2F/Q+8a4=
X-Google-Smtp-Source: AGHT+IHseXUlpZIsK55F8Aen+KcX6porKdvFtnDLk+gH5XoMQOoPBuigKYNjgP/iMCgpPYpH/Puhid+/wyIUQn8Mepw=
X-Received: by 2002:a2e:80c9:0:b0:2eb:1ac4:c9cc with SMTP id
 38308e7fff4ca-2ec3cfe1c38mr44297271fa.52.1718956970433; Fri, 21 Jun 2024
 01:02:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621052205.28925-1-pkshih@realtek.com> <20240621052205.28925-3-pkshih@realtek.com>
In-Reply-To: <20240621052205.28925-3-pkshih@realtek.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 21 Jun 2024 16:02:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v66D19xhJhq_=w49Q2t4JdB+_718DsRrT4AF24DT+zD=Aw@mail.gmail.com>
Message-ID: <CAGb2v66D19xhJhq_=w49Q2t4JdB+_718DsRrT4AF24DT+zD=Aw@mail.gmail.com>
Subject: Re: [PATCH 3/6] wireless-regdb: Update regulatory info for Jordan
 (JO) for 2022
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jun 21, 2024 at 1:22=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
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
>  - 5150-5350 MHz: 200 milliwatts (23 dBm)
>  - 5470-5725 MHz: 1 watt (30 dBm)

The reference also says to follow ESTI EN 301 893 for this range,
especially in regards to transmit power control. EN 301 893 specifies
reduced power limit of 27 dBm for devices that don't implement TPC.

And for the 5250 - 5350 range, TX power for devices without TPC are
limited to 20 dBm.

>  - 5725-5875 MHz: 200 mW (23 dBm)

The reference classifies the 5470 - 5725 MHz and 5725 - 5875 MHz ranges
as indoor use only.

>  - 5925-6425 MHz:
>    * 25 milliwatts (14 dBm) (for outdoor and portable devices)
>    * 200 milliwatts (23 dBm) (for devices operated indoors only)

Please also add the 60 GHz range: 57 - 71 GHz @ 10 W (40 dBm).

Last, the (translated) reference specifies that "All possible standards
and measures must be taken by activating interference reduction techniques"=
,
including DFS and TPC, and "Devices that do not support interference reduct=
ion
techniques are dealt with according to the technical standards issued by
European Standardization Institute ETSI".

I take it to mean that DFS is required for bands 5250 - 5350 and 5470 - 572=
5.

Thanks
ChenYu


> [1] https://trc.gov.jo/EchoBusV3.0/SystemAssets/PDF/RSMD/cb9f9a83-43a6-4e=
66-8432-6e02ecaf465b_RLAN%20Arabic%20%20Final%20-%20clean%20with%2057-71%20=
GHz.pdf
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index e10c3fc752e9..a742498c1116 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -957,10 +957,14 @@ country JM: DFS-FCC
>         (5490 - 5730 @ 160), (24), DFS
>         (5735 - 5835 @ 80), (30)
>
> +# Source:
> +# https://trc.gov.jo/EchoBusV3.0/SystemAssets/PDF/RSMD/cb9f9a83-43a6-4e6=
6-8432-6e02ecaf465b_RLAN%20Arabic%20%20Final%20-%20clean%20with%2057-71%20G=
Hz.pdf
>  country JO: DFS-JP
> -       (2402 - 2482 @ 40), (20)
> -       (5170 - 5250 @ 80), (23)
> -       (5735 - 5835 @ 80), (23)
> +       (2400 - 2483.5 @ 40), (20)
> +       (5150 - 5350 @ 80), (23)
> +       (5470 - 5725 @ 80), (30)
> +       (5725 - 5875 @ 80), (23)
> +       (5925 - 6425 @ 320), (23), NO-OUTDOOR
>
>  # Source:
>  # https://www.soumu.go.jp/main_content/000635492.pdf
> --
> 2.25.1
>

