Return-Path: <linux-wireless+bounces-12229-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A42C79656C9
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 07:15:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4E5941F24930
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 05:15:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B01E54778E;
	Fri, 30 Aug 2024 05:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tNKxLCyM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C4A6EEB7
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 05:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724994942; cv=none; b=OYcZyy4GkwNF9TH4U2BGuk2Kcdge7xBrQhQjSlHXdPtPiXaygEFZVY7c4h6clGbEo+9xELME/Y4ZbEqlVfqwXFX/ncit+/ww6Rag/clE/M81Qw/CYq4nn9fo8EBXgnTMNODJo882kc47eskf9QqCxcYAItXbmtTTequhitpo+E0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724994942; c=relaxed/simple;
	bh=+pW4npmgHZ7HhUSNXMFuqUeZXAiYuN1a7e8Ats7zJgQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hveg5z64IRDVU/aMq2A6COGQrKbS3NsSLlpRy0A/dZu/SDtHmLUbaJZDRH58j2t0nj82ar1qZ0M2RLAjZyeM9FHnaoXOrf9W4DBHjdR7f74oTimP+VtBCVWET+FsxJnv9yaq6/y8aqovujCip36YmAeP/++GprJfKTD+/aYVZEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tNKxLCyM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21076C4CEC5
	for <linux-wireless@vger.kernel.org>; Fri, 30 Aug 2024 05:15:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724994942;
	bh=+pW4npmgHZ7HhUSNXMFuqUeZXAiYuN1a7e8Ats7zJgQ=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=tNKxLCyMQL5BN2f85EcYe/2OvEkxqqzdpz+xUtyNZgalQoOPQn+uTlHzAK3f4CxGT
	 BFFMi1kGnQ/jioirTfFHP4qbjsPDIvk5/tXkd2ELddrzv/aUtZvvtYbYR+RzaOn1I1
	 k/Lye3LF8+48VoGLeAAiQtO78a0G/yg5pGWxqUKR5yLPcJ5owBoLsBsvzDd9RIH/PE
	 qh49np/Yv/AtEDwE6qVbRkI2IzTjqHjbsdBlCic9A0cYuzROCHWOiOqaBipn2cylzc
	 WBjq9Isc5kCwDwRExNBKZthT8S/AxXnmFZUeIy1MWY88WowdG2cHD5zO48xu8DVhx5
	 L4bMPoaZWvdVQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f4f505118fso16285951fa.3
        for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2024 22:15:42 -0700 (PDT)
X-Gm-Message-State: AOJu0YwAG8+zVFZxrNBNJ2o4YzTb0DyvS2sqldJzc/RHhC/8wddreeiE
	/052oejP/csg8CrDQA3oQhm4BrlTdEqLvrY2E0ZQUl4p9SX4kpai02pwMRx1lT4tZAL+h2VnlxT
	ARlMvvv6D4GG46qG0NTnWS+ypBPc=
X-Google-Smtp-Source: AGHT+IEK56QqD2GNkXMwc6ZSS+3rXima7Ww8Lpp87qbdv4LAozfh7ujF7zuej5bFX2Maqr211774UiDXqEF/gswT1L8=
X-Received: by 2002:a2e:71a:0:b0:2f3:cbc3:b093 with SMTP id
 38308e7fff4ca-2f6105559dfmr30825841fa.43.1724994940435; Thu, 29 Aug 2024
 22:15:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828084706.12257-1-pkshih@gmail.com> <20240828084706.12257-4-pkshih@gmail.com>
In-Reply-To: <20240828084706.12257-4-pkshih@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 30 Aug 2024 14:15:27 +0900
X-Gmail-Original-Message-ID: <CAGb2v67Zgs3=ZECp8WcXGhTj1R+OxDKbhqBEOdLnEVsc6ksw9g@mail.gmail.com>
Message-ID: <CAGb2v67Zgs3=ZECp8WcXGhTj1R+OxDKbhqBEOdLnEVsc6ksw9g@mail.gmail.com>
Subject: Re: [PATCH 4/4] wireless-regdb: Update regulatory info for Honduras
 (HN) for 2023
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 6:32=E2=80=AFPM Ping-Ke Shih <pkshih@gmail.com> wro=
te:
>
> From: Ping-Ke Shih <pkshih@realtek.com>
>
> Honduras, Telecommunication Commission (CONATEL) modified national note
> HND40A on 2023 [1], which Wireless Access System/Radio Local Area Network
> (WAS/RLAN) have a general license to operate in frequency ranges:
>
>  * 902 - 928 MHz
>  * 2400 - 2483.5 MHz
>  * 5150 - 5250 MHz
>  * 5250 - 5350 MHz
>  * 5470 - 5725 MHz
>  * 5725 - 5850 MHz
>  * 5925 - 6425 MHz (*)
>  * 24.05 - 24.25 GHz
>  * 57 - 71 GHz (*)

Can you mark the individual sources for each band? Otherwise it is really
hard to verify.


Thanks
ChenYu

> Article 5 of resolution NR006/23 [2] mentioned Recognition of Standards a=
nd
> International Standards including FCC, which limits and ranges of FCC are
> used due to lack of limits [1], but only newly add freqnecy ranges marked
> by asterisk (*).
>
> [1] https://www.conatel.gob.hn/doc/Regulacion/resoluciones/2023/NR05-23.p=
df
> [2] https://www.conatel.gob.hn/doc/Regulacion/resoluciones/2023/NR006-23.=
pdf
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 4 ++++
>  1 file changed, 4 insertions(+)
>
> diff --git a/db.txt b/db.txt
> index 0bc40db2d9b5..d4ca8d43a41d 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -819,12 +819,16 @@ country HK: DFS-ETSI
>         (5730 - 5850 @ 80), (36)
>         (5925 - 6425 @ 160), (14)
>
> +# Source:
> +# https://www.conatel.gob.hn/doc/Regulacion/resoluciones/2023/NR05-23.pd=
f
>  country HN: DFS-FCC
>         (2402 - 2482 @ 40), (20)
>         (5170 - 5250 @ 80), (17), AUTO-BW
>         (5250 - 5330 @ 80), (24), DFS, AUTO-BW
>         (5490 - 5730 @ 160), (24), DFS
>         (5735 - 5835 @ 80), (30)
> +       (5925 - 6425 @ 320), (12), NO-OUTDOOR, NO-IR
> +       (57240 - 71000 @ 2160), (40)
>
>  country HR: DFS-ETSI
>  # HR as part of EU/CEPT accepted decisions 2005/513/EC (5GHz RLAN, EN 30=
1 893)
> --
> 2.25.1
>
>

