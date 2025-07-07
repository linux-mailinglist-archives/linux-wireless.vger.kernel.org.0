Return-Path: <linux-wireless+bounces-24872-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 61615AFAC03
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 08:40:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21C441897E6A
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 06:40:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8D0279DD1;
	Mon,  7 Jul 2025 06:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JO0BYan0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 946CA279DCC
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 06:39:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751870399; cv=none; b=lu1JnppxvKOjyWl2+TZXF7c8IDmhFeDLLk2ih7zI30eYV8T76b+lVRaSggLwy7hwtgMfNYJvIf2Ea95dk+oRrrV5J/N36DD5HH3qfSwV+QNQPghd2UJIU96QXoo7D7XuTK+MMS8dcnkVSuvOtCjsZPzlP/ILKyiAgM7G1fmHnpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751870399; c=relaxed/simple;
	bh=pa37MRgFopLPC5/czcZntVKjkXGRHANGZPzJpeVSYZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q2yliQlvl42LL9UXc1hXDALXGlsh3pyMG+Zd2JbDKyqO6eDK7ue2buv4diUMPXra30ldjyfOu2aLRlw1NbqnZjfDDMlrY7D8/JAhmbjd4YNJTsv6z2AxHnNbJ9RbU0rGMUjixRDj4s3Yx/5aYti0foENvt7XIrf49p0dlhWHzyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JO0BYan0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F915C4CEE3
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 06:39:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751870399;
	bh=pa37MRgFopLPC5/czcZntVKjkXGRHANGZPzJpeVSYZ8=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=JO0BYan06BfOGoDiHx3o1JF8f9nCqw6rwLOgbZvH0NPZPbBzjdXu+Aly9A80k0iI5
	 USNBfyLvzzqcnyp/60eiY60/d43lhE83RRJeBGw1YmxZQFaZJHQv0mMlDuclQ00RpM
	 6t1PqBvIpdb8fQBO8/mnDPHcwrlkk9AJtxCRgJrQDHG76odhfSTH/0FFrmqz/GWaZP
	 7z7LI1XDGDimqJYNYW1NOLMBZ8hYMEW+KW1LDf5TO6gNZFie/7UMb345QmAFa8atIV
	 sB5HAztbFBRxYy/l0rb/bWiOTYAbAnP2cCqafbYGYQi7WMs/JdWRdp2sw4ak1wqGEN
	 Y7OI8sRkWdYuQ==
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-553dceb342aso2417265e87.1
        for <linux-wireless@vger.kernel.org>; Sun, 06 Jul 2025 23:39:59 -0700 (PDT)
X-Gm-Message-State: AOJu0YzxrPocws2ke5ihf7Ay9101cYVIzKUQiraOmAvWBTzRhr18uoJ+
	GorRP6faa5y/ZHPhLbOnhvjlOy22gFYVwnfwOOuq9Cffrbkr3d5T7p8X515Us5FlcxGuU3zZwAy
	N+hlBZR4z+k/LCfsC52Wop7RPSRfGdhY=
X-Google-Smtp-Source: AGHT+IFbt/BLURiPiqK9mcy2At7J1A2G3DxO0U8KnVSJji4Or67mF8koQURbrLssoXPc6HDt98DtYFpZDI87VG1mgcs=
X-Received: by 2002:a05:6512:3984:b0:553:3486:1d9b with SMTP id
 2adb3069b0e04-556e8950db5mr3590098e87.30.1751870397472; Sun, 06 Jul 2025
 23:39:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707024615.38507-1-pkshih@gmail.com> <20250707024615.38507-2-pkshih@gmail.com>
 <1B25D881-49C4-4805-9EF8-76E3A9D9A64C@nic.in>
In-Reply-To: <1B25D881-49C4-4805-9EF8-76E3A9D9A64C@nic.in>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 7 Jul 2025 14:39:45 +0800
X-Gmail-Original-Message-ID: <CAGb2v64ZKoUzQoihvPZMu4e7a+8=BxYBX_U4ZfMW_qvZhx1ZfA@mail.gmail.com>
X-Gm-Features: Ac12FXwbXa5hLHuT_ZcPi7thPIx5kp7I8sycvEJYBnfvNztUMfLZcWpjawyjg9Q
Message-ID: <CAGb2v64ZKoUzQoihvPZMu4e7a+8=BxYBX_U4ZfMW_qvZhx1ZfA@mail.gmail.com>
Subject: Re: [PATCH 2/3] wireless-regdb: update regulatory rules for India
 (IN) on 6 GHz for 2025
To: Gaurav Kansal <gaurav.kansal@nic.in>, pkshih@gmail.com
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

I see.

I will drop this for now then, unless Ping-Ke has any more information
on this?


Thanks
ChenYu

On Mon, Jul 7, 2025 at 12:18=E2=80=AFPM Gaurav Kansal <gaurav.kansal@nic.in=
> wrote:
>
> Hi,
>
> I think these are only draft rules and we shall have the separate notific=
ation from Government of India when the rules will be finalised.
> you can read on page 6 - "G.S.R. 316 (E).=E2=80=93=E2=80=93 The following=
 draft rules, =E2=80=9C
>
> So, ideally we should wait before adding these in the database as demands=
 are there for increasing the power and other requirements.
>
> Regards,
> Gaurav Kansal
>
>
> On Jul 7, 2025, at 08:16, pkshih@gmail.com wrote:
>
> From: Ping-Ke Shih <pkshih@realtek.com>
>
> Ministry of communications, India released 6 GHz [1] on the 16th May 2025=
.
> Technical parameters are listed on page 7:
>
> * Lower power indoor
>   - Indoor
>   - Max. PSD e.i.r.p: 5 dBm/MHz
>     (Since minimum bandwidth is 20 MHz for WiFi, e.i.r.p limit is 18 dBm)
>   - Max. e.i.r.p: 30 dBm
>   - Max. Emission Bandwidth: 320 MHz
> * Very lower power outdoor
>   - Outdoor
>   - Max. PSD e.i.r.p: -5 dBm/MHz
>   - Max. e.i.r.p: 14 dBm
>   - Max. Emission Bandwidth: 320 MHz
>
> [1] https://www.legalitysimplified.com/wp-content/uploads/2025/05/Exempti=
on-from-Licensing-Requirement-Rules-2025.pdf
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> db.txt | 2 ++
> 1 file changed, 2 insertions(+)
>
> diff --git a/db.txt b/db.txt
> index b5b1308460cc..224edfcd90a9 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -940,12 +940,14 @@ country IL: DFS-ETSI
> # Source:
> # https://dot.gov.in/spectrummanagement/delicensing-24-24835-ghz-band-gsr=
-45-e-5150-5350-ghz-gsr-46-e-and-5725-5875-ghz
> # https://dot.gov.in/spectrummanagement/license-exemption-5-ghz-gsr-1048e=
-dated-22102018
> +# https://www.legalitysimplified.com/wp-content/uploads/2025/05/Exemptio=
n-from-Licensing-Requirement-Rules-2025.pdf
> country IN:
> (2402 - 2482 @ 40), (30)
> (5150 - 5250 @ 80), (30)
> (5250 - 5350 @ 80), (24), DFS
> (5470 - 5725 @ 160), (24), DFS
> (5725 - 5875 @ 80), (30)
> + (5925 - 6425 @ 320), (18), NO-OUTDOOR
>
> # Source:
> # https://asnad.cra.ir/fa/Public/Documents/Details/73af8590-f065-eb11-968=
f-0050569b0899
> --
> 2.25.1
>
>
>

