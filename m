Return-Path: <linux-wireless+bounces-27844-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4DA57BC0748
	for <lists+linux-wireless@lfdr.de>; Tue, 07 Oct 2025 09:03:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AF73B189F400
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Oct 2025 07:03:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 92C9322D4D3;
	Tue,  7 Oct 2025 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MldDXylu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DAAF227EA7
	for <linux-wireless@vger.kernel.org>; Tue,  7 Oct 2025 07:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759820560; cv=none; b=MtZnn6qI4IEvxCVHsomg37kvD8vEjcIkKUUJVSdmJnwxmvhGYdBZzaM/mVOglsZeVTLHy9YCm8HS91vMQT1jo7WfNr9+JTJMYxVfaUz3FkrecaVyAfXOTJOHSHzUxpT0BWMRIgaKpCZ7vJQpjiIP/WfQvmnDV+IzNAU5+l0jRb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759820560; c=relaxed/simple;
	bh=UrN3vx1XY+v1dt7JieobaD7W+sJkHyMsFeNF/yrJ5cI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hxbFTQv6Q6LHDcuPiPCWnsWwl3WPGMvHFGoO495XjYPPSmd3tOSXRGUpgOtL2U0xHQn/o8kdo5snMURr6XDCQSbJy6RjD5AkIZ4Nf7ClUe17yv9kL/j3Ce6GYvQwk6bT2oh3LOi3VYjK2OKN+Ckf5yk+iDm+MubRagJb2EmuQ90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MldDXylu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09CF3C113D0
	for <linux-wireless@vger.kernel.org>; Tue,  7 Oct 2025 07:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1759820560;
	bh=UrN3vx1XY+v1dt7JieobaD7W+sJkHyMsFeNF/yrJ5cI=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=MldDXylu3Fxj1wqihMMEBKYW9R5dAQ5iJ2UXVmj02psJjCdMrPZRUVaA8vcghG0MQ
	 AM4a+b+1LhLkM8v9k+BLP/fZz6k48ioDEkhiTWwuw//mzNGtFrqhorkDoalk4bitS0
	 YH8n95C0QEEJukXE3FbajxIbzmvwHv5EaBluhg6leNItg2F0DhR7rmiuzVTapIS4dl
	 jnhi7zmo52wqZ7o7s7mx53qBBZ/dxYMh/QdyCTHob5S/YmFudxsH8GXJ5EngednxvG
	 Y7O1pHVAZj0Sm9+MaOw156hC5Mv0khTonWLK8IdnJ95q2L1edJhGAtZ3ZQviB5grjH
	 XYsEIfYeinz/Q==
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-373ac916b35so51206981fa.0
        for <linux-wireless@vger.kernel.org>; Tue, 07 Oct 2025 00:02:39 -0700 (PDT)
X-Gm-Message-State: AOJu0YwwT5/YMt9RdjWvVxC5BMxed/QWJe+AnEZwMG3x7TV5YXddxtgR
	p6HBPkQauhcLchIh+meOZG0z2UGCQTQcRG4UzzUHnkHnx6GIo3gNvFB+lGjN8dOWe2DsiPQ3Mw9
	avUs1/+5vRcIGIiF/sDfoj4k0ASVX5Kk=
X-Google-Smtp-Source: AGHT+IEE7sDyrARuMhRAXHauI3ei2K1FS+oIheb0yE3+D6pkAMxXyAFZ02jdknoXnfH3wq1Unm0ri/1aRI0mBJHP+oY=
X-Received: by 2002:a2e:a9a4:0:b0:372:91d2:f659 with SMTP id
 38308e7fff4ca-375f50dcaa9mr7854911fa.3.1759820558298; Tue, 07 Oct 2025
 00:02:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250924022156.8435-1-pkshih@gmail.com>
In-Reply-To: <20250924022156.8435-1-pkshih@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 7 Oct 2025 15:02:25 +0800
X-Gmail-Original-Message-ID: <CAGb2v66MZpd8QWYptLrh5O5qf-DWAnqxf3d692JWZoF3jCRj0g@mail.gmail.com>
X-Gm-Features: AS18NWDMdV6VxFUtJ_wtaE4Bei6WwIca5zSi-uM_HMLDfwtnx1zXZm-fjY0kkMg
Message-ID: <CAGb2v66MZpd8QWYptLrh5O5qf-DWAnqxf3d692JWZoF3jCRj0g@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info including
 bandwidth for Trinidad and Tobago (TT) for 2025
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, Sep 24, 2025 at 10:22=E2=80=AFAM Ping-Ke Shih <pkshih@gmail.com> wr=
ote:
>
> From: Ping-Ke Shih <pkshih@realtek.com>
>
> The Telecommunications Authority of Trinidad and Tobago [1] provides
> Schedule of Devices Eligible for Use under a Class Licence [2]. The
> type 1 (End-user devices or customer premise equipment) with Schedule B.1
> and B.2 shows
>
>  - 2400 - 2483.5 MHz
>    * 30 dBm
>  - 5150 - 5250 MHz
>    * 24 dBm
>  - 5250 - 5350 MHz
>    * 24 dBm
>  - 5470 - 5725 MHz
>    * 24 dBm

For these bands, the rules specify ERP, or effective radiated power.
However it states "Maximum Effective Radiated Power ERP (from RF
transmitter)", so I think it is meant to "maximum conducted output
power" as seen in FCC rules?

This is not the same as EIRP, or effective isotropic radiated power.
AFAIK the latter is what is supposed to be used in the database. This
discrepancy is found in many rules originating from the FCC rules. The
FCC rules specify maximum conducted power (TX power) plus max antenna
gain in dBi.

So there is some conversion involved. I think the values should be
"max conducted power" + "max gain in dBi". This assumes no cable loss.

I think we would also need to revisit the US rules.

>    * extend 5 MHz to 5730 MHz for channel 144
>  - 5725 - 5850 MHz
>    * 30 dBm
>  - 5925 - 6425 MHz
>    * 24 dBm

These two bands have 0 dBi for max antenna gain, so max TX power =3D=3D
max EIRP.


ChenYu

> [1] https://tatt.org.tt/licensing/class-license/
> [2] https://tatt.org.tt/wp-content/uploads/2025/07/Schedule-B_Schedule-of=
-Devices-Eligible-for-Use-under-a-Class-Licence-25th-July-2025.pdf
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> Hints to find these entries: by searching "Wi-Fi" with type 1 in [2].
> ---
>  db.txt | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index 6e1ad30222a4..90ffa4e0d5d7 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1946,12 +1946,15 @@ country TR: DFS-ETSI
>         # 60 GHz band channels 1-4, ref: Etsi En 302 567
>         (57000 - 66000 @ 2160), (40)
>
> +# Source:
> +# https://tatt.org.tt/wp-content/uploads/2025/07/Schedule-B_Schedule-of-=
Devices-Eligible-for-Use-under-a-Class-Licence-25th-July-2025.pdf
>  country TT: DFS-FCC
> -       (2402 - 2482 @ 40), (20)
> -       (5170 - 5250 @ 80), (17), AUTO-BW
> -       (5250 - 5330 @ 80), (24), DFS, AUTO-BW
> -       (5490 - 5730 @ 160), (24), DFS
> -       (5735 - 5835 @ 80), (30)
> +       (2400 - 2483.5 @ 40), (30)
> +       (5150 - 5250 @ 80), (24), AUTO-BW
> +       (5250 - 5350 @ 80), (24), DFS, AUTO-BW
> +       (5470 - 5730 @ 160), (24), DFS
> +       (5730 - 5850 @ 80), (30)
> +       (5925 - 6425 @ 320), (24)
>
>  # Source:
>  # Table of Frequency Allocations of Republic of China (Taiwan) / Feb 201=
7:
> --
> 2.25.1
>

