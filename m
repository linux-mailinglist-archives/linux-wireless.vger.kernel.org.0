Return-Path: <linux-wireless+bounces-10331-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0232E934732
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 06:38:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 77ED21F221EA
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 04:38:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1526E433DC;
	Thu, 18 Jul 2024 04:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oji9FfcW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A9C433CE
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 04:37:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721277467; cv=none; b=VOSezU33hZvkwuaeaYWf9LnFH6jwigk0Qx5dO7qAlpOyiGnPFy03+hJsEJnTH/xyyc06QaUmtlTR72XVgvGipSS2O76FwtszwKUTmXS3a5G2WejrSjhmTeabAuWiyWqlANcVvYTyJO6lCqOW93q9Z+dxaOxZ+psqk+aP0cHc9NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721277467; c=relaxed/simple;
	bh=yN46Bqq7WVjBLS9FdRpFuge+w7G4HIK0MMs93hR/uho=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NXN85YaZmG3uXULMrlqQEFsRAMrwstsphO/eB72htR+62iGrAGbgBVn4b/IEICHT747C3/eTlttMUjN14SqJE9gKV+3zvB/Zx0FrHxIhlnkpJMaW2pPW216I19o29gM91k7CWV02D6aEbipJ/knUOIXJ3FYfFXw4wfA88bqXtw8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oji9FfcW; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59735C116B1
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 04:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721277466;
	bh=yN46Bqq7WVjBLS9FdRpFuge+w7G4HIK0MMs93hR/uho=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=Oji9FfcWG8qSySvMfVmgJG+LfrslBaAiYFi9ZCHTYsAjz2RvPGkbHkIfY2BxFNaKj
	 Y6E/3ALOITBB4QJ8niJCI/AKdTs7xfNmOTv1XhXxWwalCDlPO8jH0cVcQfsMMbDEbI
	 rVmrswRzH+QZtJPeUnQtNzPLroaEe6ylSaG5PevGSELdMIPTZdJYPYDI0b/PdzMi/M
	 aKLF7qsOtiHCYRZj9MOLUkGaDRfxAxVieUbP5HogvBQs5iWlBIyXh/7EuV4prAGSvJ
	 B90n/N0XuMByzuB0bv8Li41IjeN1GoS+1mfnGn4/zy8wjmsOjDwLfgdbl2ZT9rCkgw
	 OKYWjc+yypX4A==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eedec7fbc4so4764571fa.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 21:37:46 -0700 (PDT)
X-Gm-Message-State: AOJu0Yw4dHk/aFsgo+N5YAnBoJEMB+RYiJv04l9Tfb+nlPOUusArwbUO
	ABCRcjLdA2oFMf4ReRLL0BeXGdkaGLtrJ85Pt+gwzEMIElCxPFYftdJqScOEtM6Ifnu+lXHdA73
	HDFBvRE28KNHf3+tlQVzunBTvqdA=
X-Google-Smtp-Source: AGHT+IESV2kX6bMZhIjIoRckYtKifhPDdXNl75SNi9U8SzMIDPDA/rWyozK+RhYN2T9TqU28hIWdFzAcrksFpuCWmxg=
X-Received: by 2002:a2e:3a13:0:b0:2ee:db2c:5753 with SMTP id
 38308e7fff4ca-2ef05d7e037mr7855961fa.42.1721277464680; Wed, 17 Jul 2024
 21:37:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705060613.28909-1-pkshih@gmail.com>
In-Reply-To: <20240705060613.28909-1-pkshih@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 18 Jul 2024 12:37:32 +0800
X-Gmail-Original-Message-ID: <CAGb2v67hWYHebORsjHuOw2mA+mwpmoCUF4vhAHE7Xt81VvZrtQ@mail.gmail.com>
Message-ID: <CAGb2v67hWYHebORsjHuOw2mA+mwpmoCUF4vhAHE7Xt81VvZrtQ@mail.gmail.com>
Subject: Re: [PATCH 1/5] wireless-regdb: Update regulatory info for New
 Zealand (NZ) for 2022
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 2:06=E2=80=AFPM Ping-Ke Shih <pkshih@gmail.com> wrot=
e:
>
> From: Ping-Ke Shih <pkshih@realtek.com>
>
> Radiocommunications Regulations (General User Radio Licence for Short Ran=
ge
> Devices) Notice 2022 listed spectrum:
>
> 2400.0000 - 2483.5000
>   * e.i.r.p. 0 dBW (1 W)

13. Transmitters using e.i.r.p. greater than 0 dBW (1 W) must employ
    frequency hopping or digital modulation techniques.

AFAIK WiFi uses digital modulation techniques. So this could be
raised up to 6 dBW?

> 5150.0000 - 5350.0000
>  * the maximum power is 0 dBW (1 W) e.i.r.p. and
>    the maximum permitted power spectral density is -13 dBW/MHz
>    (17 dBm/Hz, 50 mW/MHz) e.i.r.p.
>  * 5250 - 5350 MHz, If Transmitter Power Control is not used, then the
>    maximum power (e.i.r.p.) value shall be reduced by 3 dB.
>
> 5470.0000 - 5725.0000
>  * 5470 - 5725 MHz, transmitter peak power must not exceed -6 dBW (250 mW=
)
>    If Transmitter Power Control is not used, then the maximum power
>    (e.i.r.p.) value must be reduced by 3 dB.

We use e.i.r.p. value in the database. The limit is 1W, then minus 3 dB
due to lack of TPC.

> 5725.0000 - 5850.0000
>  * 5725 - 5850 MHz, the transmitter peak power must not exceed 0 dBW (1 W=
)
>    and the power spectral density must not exceed 17 dBm/MHz.

13. Transmitters using e.i.r.p. greater than 0 dBW (1 W) must employ
    frequency hopping or digital modulation techniques.

AFAIK WiFi uses digital modulation techniques. So this could be
raised up to 6 dBW?


Thanks
ChenYu

> 5925.0000 - 6425.0000
>  * the maximum power is -6 dBW (24 dBm, 250 mW ) e.i.r.p. and
>    the maximum permitted power spectral density is -19 dBW/MHz
>    (11 dBm/MHz, 12.6 mW/MHz) e.i.r.p. for low power devices.
>    Only be used indoors.
>  * the maximum power is -16 dBW (14 dBm, 25 mW ) e.i.r.p. and
>    the maximum permitted power spectral density is -29 dBW/MHz
>    (1 dBm/MHz, 1.26 mW/MHz) e.i.r.p. for very low power devices.
>    Very Low Power applications.
>
> 57000.0000 - 71000.0000
>  * for devices transmitting at 10 dBW e.i.r.p or less,
>    the power spectral density must not exceed -7 dBW/MHz e.i.r.p. and
>    the maximum transmit power must not exceed -3 dBW at the antenna port
>    or ports.
>  * for devices transmitting greater than 10 dBW e.i.r.p., the power
>    spectral density shall not exceed 8 dBW/MHz e.i.r.p and antennas with
>    a gain greater than 30 dBi shall be used.
>
> [1] https://gazette.govt.nz/notice/id/2022-go3100
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 14 +++++++++-----
>  1 file changed, 9 insertions(+), 5 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index d7592c299c62..266ba2d48731 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1416,12 +1416,16 @@ country NP: DFS-JP
>         (5250 - 5330 @ 80), (20), DFS, AUTO-BW
>         (5735 - 5835 @ 80), (20)
>
> +# Source:
> +# https://gazette.govt.nz/notice/id/2022-go3100
>  country NZ: DFS-ETSI
> -       (2402 - 2482 @ 40), (30)
> -       (5170 - 5250 @ 80), (17), AUTO-BW
> -       (5250 - 5330 @ 80), (24), DFS, AUTO-BW
> -       (5490 - 5730 @ 160), (24), DFS
> -       (5735 - 5835 @ 80), (30)
> +       (2400 - 2483.5 @ 40), (30)
> +       (5150 - 5250 @ 80), (30), AUTO-BW
> +       (5250 - 5350 @ 80), (27), DFS, AUTO-BW
> +       (5470 - 5730 @ 160), (21), DFS
> +       (5725 - 5850 @ 80), (30)
> +       (5925 - 6425 @ 320), (24), NO-OUTDOOR
> +       (57000 - 71000 @ 2160), (40)
>
>  country OM: DFS-ETSI
>         (2402 - 2482 @ 40), (20)
> --
> 2.25.1
>

