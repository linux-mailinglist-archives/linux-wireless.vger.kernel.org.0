Return-Path: <linux-wireless+bounces-24523-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EA681AE981C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 10:21:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2396C188AF1E
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 08:19:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB1692797B3;
	Thu, 26 Jun 2025 08:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SxYTPtOp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C7A7627EFFF
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 08:16:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750925785; cv=none; b=bo2YVqOLrAA3/TWjXmYBGwI5IlTtvmMVr0PugCR9/gUg+lf+E51mzG+Z7oz2sbluPe8TcBEPQcbGVLCQsfhXmbhQM6W0GCW3Cr4BrOvhng8mL3E6iSFAEAqHKHlA9Bh332ZcLmyp7HiaPGKkOCn2ALyUq3jgvSThr1MLODZSFTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750925785; c=relaxed/simple;
	bh=ylmaa4qed5WuX/WZpAP430o5cacOBWdVZIgT3Ka/FFg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=UlDaIKEyQuDONYrG/E663HuY7Hd3f3JOZPEBcqNiZe2LmesRj0tlntrCP+bMKKswcSNsSA2N++Vnfjk467DJsqoBPSDvu0bNDF67MIAcx1L1wfsb/Mpe2QnFNNCeSgC5WLgp/k1K/orevtWZfsSfkqyKg2LDzIC8pdPMrlEA9A0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=SxYTPtOp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 450BEC4CEEE
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 08:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750925785;
	bh=ylmaa4qed5WuX/WZpAP430o5cacOBWdVZIgT3Ka/FFg=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=SxYTPtOp7JjyUDOtv9/04FCflk8lGi+U/a03wmaotMvPq96tgOP3yOq+ueiToGYPr
	 mi8C57MAqKlhsiE0TBP6wSNGIMt+JNHp+dnbA+1jSMO0r44DsQl0lifCVMlpMQJO9j
	 +Rn9vkQB/QOyBEvhk4eM7cRgqrq7aj+XOI9KxoEyaJRwtGRjI4lGPD4T+oBc1FHrm2
	 S4kS2VrxoDARlwY2Bb9Vmnz1hOUSy28MgLz0heVeY+RlxBbT+hw9Xhcnq4KIqwbbjj
	 BOBulu5axJUKawvP3FlcxCsUVonLlB4Z8UO9X1gb3f2+se5LYaVewnxAcVQ/mwgWJk
	 mMyZ+f89nF3Hg==
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-553e5df44f8so652543e87.3
        for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 01:16:25 -0700 (PDT)
X-Gm-Message-State: AOJu0YyhnefbNq7t1oLgU6uO6UEzFzYdheJyMWabR/Xqo32hIqdGj/Pf
	5rB/4RoIa8sOdQjI3RQQygJYNFWMalpAYbZspzXlZTx83NwVBJAuQQrjHv47c/jg2ERey5L/Swu
	AzxMpEkcIh4wmLIbsA+9l3LrW6pcI5v0=
X-Google-Smtp-Source: AGHT+IGx3empgvF8hysbs0K4JSBOMz94naAjKhm3x4OHtii9tQpUnac1VIlLY6Q8GQxC58Kc2As53g4se1orz0f24kg=
X-Received: by 2002:a05:6512:1195:b0:553:3178:2928 with SMTP id
 2adb3069b0e04-554fdcd61abmr2469546e87.16.1750925783634; Thu, 26 Jun 2025
 01:16:23 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250602121434.3011282-1-marcoshalano@gmail.com> <CAGb2v645_kB3mNb79ytFb9y2xw6zp1oFvof5NX-FF7eDPNCBFQ@mail.gmail.com>
In-Reply-To: <CAGb2v645_kB3mNb79ytFb9y2xw6zp1oFvof5NX-FF7eDPNCBFQ@mail.gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 26 Jun 2025 16:16:11 +0800
X-Gmail-Original-Message-ID: <CAGb2v67zJ5RSyc-tEw2bXYzeJ2q+rkqbgCNZO3Gm+krRbap-RQ@mail.gmail.com>
X-Gm-Features: Ac12FXzeVUF0o-E2TVEfTmc1f3DsK1NdNa_lFnQ-n4VRhrfGder4uT4BiAGmV7w
Message-ID: <CAGb2v67zJ5RSyc-tEw2bXYzeJ2q+rkqbgCNZO3Gm+krRbap-RQ@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory rules for Brazil (BR)
 on 6GHz
To: Marcos Alano <marcoshalano@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jun 26, 2025 at 4:12=E2=80=AFPM Chen-Yu Tsai <wens@kernel.org> wrot=
e:
>
> On Mon, Jun 2, 2025 at 8:15=E2=80=AFPM Marcos Alano <marcoshalano@gmail.c=
om> wrote:
> >
> > Change rules for 6GHz on Brazil removing `NO-IR` and adding
> > `AUTO-BW` so the 6GHz band can be used.
>
> AUTO-BW is not needed since there are no adjacent bands that can be
> combined.
>
> > Add the relevant normatives in comments.
> >
> > Signed-off-by: Marcos Alano <marcoshalano@gmail.com>
> > ---
> >  db.txt | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> >
> > diff --git a/db.txt b/db.txt
> > index e331d4f..3b0adbb 100644
> > --- a/db.txt
> > +++ b/db.txt
> > @@ -321,8 +321,8 @@ country BO: DFS-JP
> >
> >  # Source:
> >  # https://www.gov.br/anatel/pt-br/regulado/radiofrequencia/radiacao-re=
strita
> > -# https://informacoes.anatel.gov.br/legislacao/resolucoes/2017/936-res=
olucao-680
> > -# https://informacoes.anatel.gov.br/legislacao/atos-de-certificacao-de=
-produtos/2017/1139-ato-14448
> > +# https://informacoes.anatel.gov.br/legislacao/resolucoes/2025/2001-re=
solucao-772
> > +# https://informacoes.anatel.gov.br/legislacao/atos-de-requisitos-tecn=
icos-de-gestao-do-espectro/2024/1920-ato-915
> >  country BR: DFS-FCC
> >         (2400 - 2483.5 @ 40), (30)
> >         # The next three ranges have been reduced by 3dB, could be incr=
eased
> > @@ -331,7 +331,7 @@ country BR: DFS-FCC
> >         (5250 - 5350 @ 80), (27), NO-OUTDOOR, DFS, AUTO-BW
> >         (5470 - 5725 @ 160), (27), DFS, AUTO-BW
> >         (5725 - 5850 @ 80), (30), AUTO-BW
> > -       (5925 - 7125 @ 320), (12), NO-OUTDOOR, NO-IR
> > +       (5925 - 7125 @ 320), (30), NO-OUTDOOR, AUTO-BW

Also, the 12 dBm power limit is warranted by the PSD limit of -1 dBm / MHz.
At the smallest 20 MHz channel width, that converts to around 12 dBm.

ChenYu

> >         # EIRP=3D40dBm (43dBm peak)
> >         (57000 - 71000 @ 2160), (40)
> >
> > --
> > 2.49.0
> >
> >

