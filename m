Return-Path: <linux-wireless+bounces-16010-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C9199E8A43
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 05:25:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5B4B0162FAA
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 04:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CBA4E15854A;
	Mon,  9 Dec 2024 04:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TDVG8F4F"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44F2158534
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 04:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733718353; cv=none; b=Ev94+oey+YawhRhCRR0uCtvgazZi0w8EKRxHYhi/yWQeojZW99Bh4102r/opOhEt3s5uw5wueizH9CsBj+ZBNnzXT9GEePi1YhlYYdwxhoXv1IhtHdcpAWOy7MX8NeeimE939mlEBIUzoL2dxrMvho0z746zNDqh5wdRDONDf9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733718353; c=relaxed/simple;
	bh=a18/zr79HLAx1u5NzZIqONZGjEbLZ5sSxTYmHPBdcfc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u4LCTFFwZ+w032Z7LuqdWntFXlmXfnDdG1piDejyaOp/zUEmL2qBvTAg/r0ql4ovhMyk81UKhiymNkU5gFobQbj8/Pd50Vd+oucbvuHv4MKFUxav/XWWeUq+gR1mjzerbC8ztWBnUmLmZCNO1QuaM7OHoCHpzayaKo0QpYlIZxk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TDVG8F4F; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2BABAC4CEE1
	for <linux-wireless@vger.kernel.org>; Mon,  9 Dec 2024 04:25:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733718353;
	bh=a18/zr79HLAx1u5NzZIqONZGjEbLZ5sSxTYmHPBdcfc=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=TDVG8F4FqKrrg5K783w7xGjwPMcEzVxAck4sdCQxsYsL5ogPGJ/OuIjVXgA0ym9ry
	 ygLntVcw+0jhkTNNF9jBNueD1RVEmkJ+hHcjgzbseGJuRGaPEHnjRGYOqxh1cyizi/
	 2/qxcv6otkDvyOSHPjxZXsNCqt/d74Qj3jwGOvq/V0V4AyVZQztQrv0h0MoxRtiRn1
	 iGRP9Fv2yubhpS7OrMepDyB01HuWcWBFD0Nag0y0wpLSwUeRB6zWhAdBPUvg5P1Zsx
	 fSvyH2aI2RwA7h1OlJ5F0wPBS9+dB56TW7Cjz0geeDbkAVHP5kkvdT3TlAJ2pCHvY1
	 vPV3J4DUd+n9Q==
Received: by mail-lj1-f172.google.com with SMTP id 38308e7fff4ca-300479ca5c6so13115101fa.3
        for <linux-wireless@vger.kernel.org>; Sun, 08 Dec 2024 20:25:53 -0800 (PST)
X-Gm-Message-State: AOJu0YwXFHuktZ+20C5aQTpz+SGTrBe6F+O7NAHgs4x6LH65RiPH+Yb5
	+THVnTpNft/OChzxxRYUnPnK+WAFewUwHQElCBvxMbmnQECvKEnj+JQsicmPY92M9D+OVnFAWdn
	03AAhTPdMTa5b8yLTlJyMgG3rM9g=
X-Google-Smtp-Source: AGHT+IHdpR2l0npUPKmdgIdV6DrHnNxRjk8qhI9t4NhcTZazwelWM1wvRaUH1avO7WQdBxZucD2IYUYEql6TUCcneSA=
X-Received: by 2002:a05:651c:1a0c:b0:2ff:d3c6:9cf4 with SMTP id
 38308e7fff4ca-3002f7957fbmr29487591fa.1.1733718351466; Sun, 08 Dec 2024
 20:25:51 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241021071506.24320-1-pkshih@gmail.com>
In-Reply-To: <20241021071506.24320-1-pkshih@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 9 Dec 2024 12:25:38 +0800
X-Gmail-Original-Message-ID: <CAGb2v64FojDNF+9fhdE5LhMJRYr0Tk9s+uPkVYD=pYsdHLggrA@mail.gmail.com>
Message-ID: <CAGb2v64FojDNF+9fhdE5LhMJRYr0Tk9s+uPkVYD=pYsdHLggrA@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Oman (OM)
To: Ping-Ke Shih <pkshih@gmail.com>, Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 21, 2024 at 3:15=E2=80=AFPM Ping-Ke Shih <pkshih@gmail.com> wro=
te:
>
> From: Ping-Ke Shih <pkshih@realtek.com>
>
> Sultanate of Oman, Telecommunications Regulatory Authority released
> Technical Specifications for Wideband and Broadband Data Transmission
> Systems [1].
>
> * 2400-2483.5 MHz
>   - 100 mW max. mean EIRP
>   - indoor use only
> * 5150-5250 MHz
>   - 200 mW max. mean EIRP
> * 5250-5350 MHz
>   - 200 mW max. mean EIRP
>   - TPC: if TPC is not used, then the maximum permitted mean EIRP and the
>          corresponding mean EIRP density limits shall be reduced by 3 dB.
>          (20 dBm is adopted)
>   - DFS
> * 5470-5725 MHz
>   - 1 W max. mean EIRP
>   - TPC: if TPC is not used, then the maximum permitted mean EIRP and the
>          corresponding mean EIRP density limits shall be reduced by 3 dB.
>          (27 dBm is adopted)
>   - DFS
> * 5725-5850 MHz
>   - 2 W max. mean EIRP
>   - TPC: FWA systems operating in frequency band 5725-5850 MHz shall
>          employ TPC with a range of at least 5 dB.
>          (28 dBm Is adopted)
>   - Outdoor use only
>     (Since NO-INDOOR flag is not supported by current format, don't add
>      this entry.)

That's one requirement I haven't seen before.

Johannes, should the kernel have a "NO-INDOOR" flag? Or maybe fixed
wireless access devices are special enough that they are locked down
and we don't care?

>   - DFS
> * 5925-6425 MHz
>   - 200 mW max. mean EIRP
>   - Indoor use only
> * 57-66 GHz
>   - 40 dBm max. mean EIRP
>   - Indoor use only
>
> [1] https://tra.gov.om/DownloadFile.jsp?type=3DDocumentList&code=3D474
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index a9a9ba48f42d..32b533e800f5 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1463,10 +1463,12 @@ country NZ: DFS-ETSI
>         (57000 - 71000 @ 2160), (40)
>
>  country OM: DFS-ETSI
> -       (2402 - 2482 @ 40), (20)
> -       (5170 - 5250 @ 80), (20), AUTO-BW
> -       (5250 - 5330 @ 80), (20), DFS, AUTO-BW
> -       (5490 - 5710 @ 160), (27), DFS
> +       (2400 - 2483.5 @ 40), (100 mW), NO-OUTDOOR
> +       (5170 - 5250 @ 80), (200 mW), AUTO-BW
> +       (5250 - 5350 @ 80), (20), DFS, AUTO-BW
> +       (5490 - 5725 @ 160), (27), DFS
             ^
           typo? It says 5470 above.

I can fix it when applying.

ChenYu

> +       (5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
> +       (57000 - 66000 @ 2160), (40), NO-OUTDOOR
>
>  # Source:
>  # http://www.asep.gob.pa/images/telecomunicaciones/Anexos/PNAF-dic2015.p=
df
> --
> 2.25.1
>

