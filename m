Return-Path: <linux-wireless+bounces-8482-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 65C8B8FAFE2
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 12:34:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1C66A1F21357
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 10:34:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9D5836FC3;
	Tue,  4 Jun 2024 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RjajuyNI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78ADF2566
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 10:34:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717497257; cv=none; b=gDO+uwrBOmfSujd82q59o34bdjn5dArX03DpSyUwv5gtwmXcpjDfYVUdWj4ogx/y3WC/fgaT9Eo1hW+bDcMWCBqLJKsexGKn51JqKHMwcH0PIvC9XcdDBf/RtdruEdEAsNe0JtrHaZolquWFXnl8zT0pTKB+V0LSA2sbathmxvY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717497257; c=relaxed/simple;
	bh=9GgOpvGxYDUQvRk2dz2h8+S96DHn0UNYXByGGEqR0KM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=R36zHIWzzMkfH7wV4HGd19SwbajCMMZ54EduxrYyr6fEse4sPItgoWxnChZWeQEAm5h/S59HbLolfyc2Mk6V1fyQikvTRvohyudxk1K1wd6hxkIwo7BAZUnqS8FqSojXNVNIlYTQUA5JL+DFApZ601zc3yPncwMQ7xvKRetA99E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RjajuyNI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2617C4AF07
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 10:34:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717497256;
	bh=9GgOpvGxYDUQvRk2dz2h8+S96DHn0UNYXByGGEqR0KM=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=RjajuyNITjn0nEH9szk+ytn0lOA4XhcBp8dTCsRyDe5rawBBMZjH8XSzTY9gQd1Ja
	 X2dMMSeGoTVaTAojEFEJVH3LjpGXUz9DLsH6L9tL8sSlWK34oiyCANufWULSXpQUCp
	 2uWbySXCL1ixgRqTMA1T3xm8dqCcIgL1FjXYqFw8ZmlU79mPvcU7oeCflSb1v0NcwV
	 DGrGy68XQH8rXp67wxr5OZPOlPq7rEeHwFt7I99qQTKl84xDWEhEupBClgsaBtRDWZ
	 QecZ+1mJ1yEpIs0Gjr/KLg6qN0WjsSHCKsfeZKfs/pC3bXF1S3YL9v67tEhGGc0vxD
	 AxhGWCl4Xms2Q==
Received: by mail-lj1-f171.google.com with SMTP id 38308e7fff4ca-2eabd22d404so8045321fa.2
        for <linux-wireless@vger.kernel.org>; Tue, 04 Jun 2024 03:34:16 -0700 (PDT)
X-Gm-Message-State: AOJu0Yzxcx09pwdAMbcZfEnBdR5iu9Ku4XZY/5bze+M3DX0WfZ9t7CcS
	obWRePQN9k0NmKg22tth1s8emied8RSLrF85j65XjYivpsJKZ1bWA08L5h3Dz8ToXOZEdyDRPVw
	llu9feOETWKbl+0/+qdRLA9m9qNI=
X-Google-Smtp-Source: AGHT+IGkWdVPUwr4veTKgVpiXGzwfCP09G943Ef4PdcKMdFHLqf1mPyYFcBACPA9Mw09nr2dI0fAOKCwytrE5CRBJvY=
X-Received: by 2002:a05:651c:2117:b0:2e5:685a:cd24 with SMTP id
 38308e7fff4ca-2ea950fd7demr83020111fa.6.1717497255061; Tue, 04 Jun 2024
 03:34:15 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603060558.98791-1-pkshih@realtek.com> <20240603060948.99147-1-pkshih@realtek.com>
In-Reply-To: <20240603060948.99147-1-pkshih@realtek.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Jun 2024 18:34:02 +0800
X-Gmail-Original-Message-ID: <CAGb2v65j604KUiVDiXSAbpJQQetGagFj53E8zuk6JqwaDdBk3w@mail.gmail.com>
Message-ID: <CAGb2v65j604KUiVDiXSAbpJQQetGagFj53E8zuk6JqwaDdBk3w@mail.gmail.com>
Subject: Re: [PATCH 4/4] wireless-regdb: Update regulatory info for Mexico
 (MX) on 6GHz
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 3, 2024 at 2:10=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> wr=
ote:
>
> The Plenary Session of the Federal Telecommunications Institute (IFT)
> determined, in its IV ordinary session of 2023, to classify the
> 5925 - 6425 MHz frequency segment as free spectrum and issued the
> technical operating conditions that allow coexistence with the existing
> services in the country [2].
>
> Within the operating conditions of this band as free spectrum, its use wa=
s
> determined for low power indoor and very low power indoor and outdoor
> systems.
>
> According to WBA Response to the Mexico IFT 6 GHz Consultation [3]. The
> Low Power Indoor is
>         33 dBm Max Tx Power (EIRP) & 8dBm/MHz PSD (EIRP) for Access Point=
s
> and
>         27 dBm Max Tx Power (EIRP) & 2dBm/MHz PSD (EIRP) for Clients
>
> The Very Low Power is 4 dBm Max Tx Power (EIRP)
>
> [1] https://www.ift.org.mx/comunicacion-y-medios/comunicados-ift/es/el-pl=
eno-del-ift-clasifica-la-banda-de-5925-6425-mhz-como-espectro-libre-comunic=
ado-132023-16-de

Not sure what this reference is for?

> [2] https://www.ift.org.mx/sites/default/files/comunicacion-y-medios/comu=
nicados-ift/comunicado13ift_1.pdf
> [3] https://www.ift.org.mx/sites/default/files/industria/temasrelevantes/=
consultaspublicas/documentos/20210119-cpi6ghz2020-162.pdf

[2] does not say what limits were adopted, nor that the WBA's
recommendations [3] were adopted in its entirety. Without such
wording, [3] is just a recommendation, not the final rule. This
needs some more information.

>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/db.txt b/db.txt
> index 1999086d4694..970f47a87247 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1293,12 +1293,16 @@ country MW: DFS-ETSI
>         (5250 - 5330 @ 80), (20), DFS, AUTO-BW
>         (5490 - 5710 @ 160), (27), DFS
>
> +# Source:
> +# https://www.ift.org.mx/sites/default/files/comunicacion-y-medios/comun=
icados-ift/comunicado13ift_1.pdf
> +# https://www.ift.org.mx/sites/default/files/industria/temasrelevantes/c=
onsultaspublicas/documentos/20210119-cpi6ghz2020-162.pdf
>  country MX: DFS-FCC
>         (2402 - 2482 @ 40), (20)
>         (5170 - 5250 @ 80), (17), AUTO-BW
>         (5250 - 5330 @ 80), (24), DFS, AUTO-BW
>         (5490 - 5730 @ 160), (24), DFS
>         (5735 - 5835 @ 80), (30)
> +       (5925 - 6425 @ 320), (33), NO-OUTDOOR

We consider Linux systems as client devices, thus the lower limit would
apply.


Thanks
ChenYu

>
>  # Source:
>  # https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-signe=
d_19012022.pdf
> --
> 2.25.1
>

