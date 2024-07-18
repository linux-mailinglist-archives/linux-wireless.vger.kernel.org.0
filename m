Return-Path: <linux-wireless+bounces-10333-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B766493473F
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 06:44:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6CCAB2830E1
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 04:44:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25A0A3A1BF;
	Thu, 18 Jul 2024 04:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mz70H359"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00B981B86FB
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 04:44:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721277842; cv=none; b=dpcHNCsrNOrliCZNs2Yim1vw8BwDaRLKHz9HmNc1w14ZYi9kYELVVgNVpq8UdksWYPDl8Epn45S4ToH5sIeoSuJgmz0aUu18+z26+yPf5d5MBqOLdbSyDnnsn0Hz5Dmz5ACdMA8rdtevVS9YJBzu+i+Q4Dc3QewZObN4+GwvqrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721277842; c=relaxed/simple;
	bh=ZRDC4dHcF/WcX8gCYsuspFUop2dQtRDN/rE9HjjCRSU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eKW0xnoL7lT/2faX+RbcwLnPCTG1dfsuBhzFmK9Y4NWd9Gi5OKj8c72PfzqDB4ZPzpA68LOuuo1yjB/fdaB2u5vy7UoKm4lmStgQZKnSly4/ZKxiTPLNs9Xyvk1Gr++gSQXtFFNIybAgFEeQklIQsxXkOmuYuV4L/9jSNAvhctI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mz70H359; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83FC8C116B1
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 04:44:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721277841;
	bh=ZRDC4dHcF/WcX8gCYsuspFUop2dQtRDN/rE9HjjCRSU=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=Mz70H359F7LVtlyY8SeAvdc8Ybv7HBH6O8ge0qYVI1r5OecjQ+OdjMwd5uDQJNuEU
	 eM+LHOFp0GmQWzTbm/L9JTEMgd518QSQXMSyy+kRLjEuaEgbI5/urjmaq/XTZlpcJ9
	 ipLnbuNLrgPgptOVV06jlUf36rn4l+ggAd+OtSnSa7nSLuLWcwKkeRLxhbskVjedU1
	 3HYUAIH1jhlXfRfGt6AyL/qNclrhFpDGjLtpBXP+HCft4ZyrZl0AyKN8lJdkoGcuZW
	 1hPyXvzHwh7Ks7i/h6yK/Eibb5wfWllzo4ZlUyMljuM37weq3ghx9KNePM4V9KeJB9
	 rLFGmkvEw8Hvg==
Received: by mail-lj1-f178.google.com with SMTP id 38308e7fff4ca-2ebe3fb5d4dso3487631fa.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 21:44:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YyPklrdrSQs4wDZc7MTaFTRTwWRU5jzSRRsjaUIj+y90DIPqToC
	u6ChQB2xdLqtWxElvFTJw3N4oVPuvMECdDMSKz1zRTbFjEFVzKr9fAsYjHU34kQRCblMpORHVub
	R+g2QJVLYmt25vqaTnekE1bid82g=
X-Google-Smtp-Source: AGHT+IFvQlfoJbyn8/5uIxJdMdaYOBwoIliZ2UEO1YIkhUi565xheTeo35Xejr4Vn0ydaiHQnIgf/baFvGmOBkd/Ark=
X-Received: by 2002:a2e:9ed9:0:b0:2ee:daf3:5d30 with SMTP id
 38308e7fff4ca-2ef0649b2b2mr3327151fa.0.1721277839845; Wed, 17 Jul 2024
 21:43:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705060613.28909-1-pkshih@gmail.com> <20240705060613.28909-4-pkshih@gmail.com>
In-Reply-To: <20240705060613.28909-4-pkshih@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 18 Jul 2024 12:43:47 +0800
X-Gmail-Original-Message-ID: <CAGb2v66Xga1j_VELV1XXzOVxr_i6YdmFCSDRYmxOtq9rj3GfBQ@mail.gmail.com>
Message-ID: <CAGb2v66Xga1j_VELV1XXzOVxr_i6YdmFCSDRYmxOtq9rj3GfBQ@mail.gmail.com>
Subject: Re: [PATCH 4/5] wireless-regdb: Update regulatory info for El
 Salvador (SV) on 6GHz
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 2:06=E2=80=AFPM Ping-Ke Shih <pkshih@gmail.com> wrot=
e:
>
> From: Ping-Ke Shih <pkshih@realtek.com>
>
> The General Superintendency of Electricity and Telecommunications Makes
> Knowledge to the General issued resolution No. T-0408-2023.
>
> Free use within the entire band for WLAN (WiFi) application, from
> 5925 MHz to 7125 MHz, must have following technical and operation
> conditions:
>  - access point
>    * P.I.R.E 30 dBm
>    * spectral density of P.I.R.E. 5 dBm/Mhz
>  - client
>    * P.I.R.E 24 dBm
>    * spectral density of P.I.R.E. -1 dBm/Mhz
>  - Indoor use only permitted

Please explicitly mention that the PSD limits the rule to 12 dBm.

ChenYu

> [1] https://www.siget.gob.sv/actualizacion-de-cuadro-nacional-de-atribuci=
on-de-frecuencias-t-0408-2023/
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/db.txt b/db.txt
> index d6b14c055afb..2a4f1ed524c1 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1736,11 +1736,14 @@ country SR: DFS-ETSI
>         (5250 - 5330 @ 80), (20), DFS, AUTO-BW
>         (5490 - 5710 @ 160), (27), DFS
>
> +# Source:
> +# https://www.siget.gob.sv/actualizacion-de-cuadro-nacional-de-atribucio=
n-de-frecuencias-t-0408-2023/
>  country SV: DFS-FCC
>         (2402 - 2482 @ 40), (20)
>         (5170 - 5250 @ 20), (17)
>         (5250 - 5330 @ 20), (23), DFS
>         (5735 - 5835 @ 20), (30)
> +       (5925 - 7125 @ 320), (12), NO-OUTDOOR
>
>  country SY:
>         (2402 - 2482 @ 40), (20)
> --
> 2.25.1
>

