Return-Path: <linux-wireless+bounces-10344-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 940ED934898
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 09:07:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B71651C210D5
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 07:07:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31F1C41C7F;
	Thu, 18 Jul 2024 07:07:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TxTn59iO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DA208488
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 07:07:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721286467; cv=none; b=syy6oRufQgL7m0dSgx38+54tYo4h8iGQ04m6yd2l3XXXgPo88q59z1zeZregjpZG4lEnIxTv20GHYue30xsrX3HitU7RLtvPRDvcGGqm9JtxbAAZze5IhxL9GoUIBCMYrZvlBBuYICq7VYx2IRoyc98DOaRQTukRbgWYmlX+ENw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721286467; c=relaxed/simple;
	bh=RCeS1dL/bFbXXSZ94eaR+trz+wOufUEu54cfbt9QmE0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=JQnar8p1KjxPn4Mo+cpFVGdyACk63JBxu+onsXw/kck6TlpUbA+oi2NAq9r84da/KgCP8d4/3Xuc6R6Hwxy1jv3vkR/GECCIKnIl0+WQ2aaXU0Hm/8QaLRUEkKjxNUdvV2KgIwlm6bQ1eMHQBV0lrAoEm3HMCo9xTEBwvtnvO5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TxTn59iO; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 980B5C4AF0D
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 07:07:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721286466;
	bh=RCeS1dL/bFbXXSZ94eaR+trz+wOufUEu54cfbt9QmE0=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=TxTn59iOwY4XaRN69XM8ZUOXLiIpPRFSn8MIDqjPV5/eMautxetJ2x+O6r353ZujN
	 lhkpddukuvJWJGpa+NZjZIdd+Gocj96xpgv0dFgq+Eq+19FQYH1FDvaxikPtg045H6
	 +xF2Yc2lJBVciywXVcuOX5jPsdYGb33OUjPA7qHBWEMS7d4dlbzPtPkuCquJ0jLiXo
	 oZWqkh2yUqgySICs2LVQLRXSLNXcggJsnT3BajQytsmFVN2gngeepmnJq/RHB/YnOV
	 IEM7nOjlSGfZKbW2PdHOacX1HewqreoehdKXT7HpU/dGlgtRLlIz49SSR6yEiGSbyD
	 04ZaBmC2HZW/A==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2ee817dac89so4744011fa.1
        for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 00:07:46 -0700 (PDT)
X-Gm-Message-State: AOJu0Yww+ZGQJXmy5J9hSmo11DFDQ2nKHG69eW5etXutRDCMCBJUD4hN
	VXSNypsMPRGLD4QB9zmrpmsWQgrLmyMNDtB1M6lrl8jfnG28+e8SSXdX9PNevIteQ5DoUHxSnLB
	jRgiCq5PTFu6+667Qf1/RxHCh454=
X-Google-Smtp-Source: AGHT+IELI3GPH8ew30Fd6iEiF9QPuwDB/yL26IDXfGyGMZR0/aM3h9S/XMWBiqRDazydkod6z1oCMh0A8v02Q5AySoo=
X-Received: by 2002:a2e:22c4:0:b0:2eb:ec25:b759 with SMTP id
 38308e7fff4ca-2ef0624aad6mr4224211fa.3.1721286464814; Thu, 18 Jul 2024
 00:07:44 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240718031718.19403-1-pkshih@gmail.com>
In-Reply-To: <20240718031718.19403-1-pkshih@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 18 Jul 2024 15:07:31 +0800
X-Gmail-Original-Message-ID: <CAGb2v67CxDRfazXSHEpKDhAYULggf1Jqgd+Aj=JEJyGnZ1Ge=A@mail.gmail.com>
Message-ID: <CAGb2v67CxDRfazXSHEpKDhAYULggf1Jqgd+Aj=JEJyGnZ1Ge=A@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Add regulatory info for Namibia (NA) for 2023
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 18, 2024 at 11:17=E2=80=AFAM Ping-Ke Shih <pkshih@gmail.com> wr=
ote:
>
> From: Ping-Ke Shih <pkshih@realtek.com>
>
> COMMUNICATIONS REGULATORY AUTHORITY OF NAMIBIA released NOTICE IN TERMS O=
F
> THE REGULATIONS REGARDING THE SUBMISSIONS OF INTERCONNECTION AGREEMENTS
> AND TARIFFS on 3 April 2023 [1].
>
> * 2400-2483.5 MHz
>   100 mW e.i.r.p.
>
> * 5150-5350 MHz
>   200 mW mean e.i.r.p.
>   Restricted to indoor use
>   The maximum mean e.i.r.p. density shall be limited to 10 mW/MHz
>   (ETSI [2]: 200mW (23dBm) -6 dBm to be 17 dBm; DFS 5250-5350)

EN 301 893 says for devices without TPC, the limit is lowered 3 dBm only,
as you mentioned below.

I previously requested -6 dBm because that country's regulation said
that "TPC is required".

> * 5470-5725 MHz
>   250 mW e.i.r.p.
>   Indoor as well as outdoor use allowed.
>   The maximum mean e.i.r.p. density shall be limited to 50 mW/MHz
>   (ETSI [2]: 250mW (24dBm) -6 dBm to be 18 dBm; DFS)

Same here, without TPC the limit is lowered by 3 dBm.

>
> * 5725-5 875 MHz

          ^ drop the space

>   PTP/PTMP: max mean e.i.r.p =3D 4 W
>   Mesh/AP-MP: max mean e.i.r.p =3D 2 W
>   (ETSI [3]: The FWA device shall have the capability to reduce the
>    operating mean EIRP level to a level not exceeding 24 dBm for
>    ChS =3D 20 MHz and 21 dBm for ChS =3D 10 MHz. 24 dBm is adopted)

Per ETSI EN 302 502, this range requires DFS.

> * 5925-6425 MHz
>   - 23 dBm (200mW) mean e.i.r.p
>     Restricted to indoor use only.
>     Mean e.i.r.p density for in-band emissions =3D 10 dBM/MHz

         Should be dBm (I know it says dBM in the doc)  ^

>   - 14 dBm (25) e.i.r.p mW
>     Very Low Power (VLP) indoor outdoor use.
>     Maximum meand e.i.r.p. for inband emissions =3D 1 dBm/MHz

                  ^ extra d
>
> * 57-66 GHz
>   40 dBm (10W) mean e.i.r.p
>   23 dBm/MHz e.i.r.p. density
>   Indoor use only

The rest looks good.

ChenYu

> The EN 301 893 [2] specifies reduced power limit of 23 and 27 dBm for
> 5150-5350 MHz and 5470-5725 MHz respectively for devices that don't
> implement TPC. Also reduced TPC requires being able to reduce TX power by
> up to 6 dB. The DFS applicable frequency range are 5250-5350 MHz and
> 5470-5725 MHz.
>
> [1] https://www.cran.na/yglilidy/2023/04/GG-8060-dated-3-April-2023.pdf
> [2] EN 301 893 https://www.etsi.org/deliver/etsi_en/301800_301899/301893/=
02.01.01_60/en_301893v020101p.pdf
> [3] EN 302 502 https://www.etsi.org/deliver/etsi_en/302500_302599/302502/=
02.01.01_60/en_302502v020101p.pdf
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>
> diff --git a/db.txt b/db.txt
> index 6192dafe9715..2a50afb60c06 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1355,6 +1355,17 @@ country MY: DFS-FCC
>         (5735 - 5835 @ 80), (1000 mW)
>         (5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
>
> +# Source:
> +# https://www.cran.na/yglilidy/2023/04/GG-8060-dated-3-April-2023.pdf
> +country NA: DFS-ETSI
> +       (2400 - 2483.5 @ 40), (100 mW)
> +       (5150 - 5250 @ 80), (17), AUTO-BW, NO-OUTDOOR
> +       (5250 - 5350 @ 80), (17), DFS, AUTO-BW, NO-OUTDOOR
> +       (5470 - 5725 @ 160), (18), DFS
> +       (5725 - 5875 @ 80), (24)
> +       (5925 - 6425 @ 320), (23), NO-OUTDOOR
> +       (57000 - 66000 @ 2160), (40), NO-OUTDOOR
> +
>  country NG: DFS-ETSI
>         (2402 - 2482 @ 40), (20)
>         (5250 - 5330 @ 80), (30), DFS
> --
> 2.25.1
>

