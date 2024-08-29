Return-Path: <linux-wireless+bounces-12217-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 13548965362
	for <lists+linux-wireless@lfdr.de>; Fri, 30 Aug 2024 01:24:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AB5E11F23747
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Aug 2024 23:24:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3361618C004;
	Thu, 29 Aug 2024 23:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU6bxqmv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D7EF189F5B
	for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2024 23:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724973844; cv=none; b=lrO1oXKXnxbAuHu3TjkhRt/1+xC4SapvqxDIXzgy4qSP6cNAVRowE/c6j8shEH5Of6nHHd9WXme2zBqnDLSjFS91ufMKdY86qMJsTF7mFzRPq+CiGxnnKCGh+ubofPfSD5ARf4wr1b7fHVekSG44vF3PI8rtCbZMQwXaa/Voo9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724973844; c=relaxed/simple;
	bh=70/i6xXaX7zIxGBlnQGm09WdEQpWrIFuRhYm9gGAbYI=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PboqDrMzVYROWGSacKB/dtkpHGzJBUTwWX3TbsLLyoBlDhKNKL5SiZgJaTltQXdKRjlLr7cL1uP6aZ+3bVckjn+9edew9EVOpm8/BFlU28QyIcnlZqtOWmT3xC0HglxvKfgSnV4pSvwx9AZSPpQT5TBt0yx3JN/FGJ6XqvBcHXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU6bxqmv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A2273C4CEC3
	for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2024 23:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1724973843;
	bh=70/i6xXaX7zIxGBlnQGm09WdEQpWrIFuRhYm9gGAbYI=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=LU6bxqmvOron9gHidDVntL5KS7wMP7sF5gYYyTynvKmubxw7rfAI7PXjTNu8Ksj/6
	 Iunnwt26AYLPRmxtyMfu3U/SHKMC8bqt9q2izPhd/spqvpyPgZ7TPPzWrGTcgJfeRP
	 3UmrNO5bJuEFazSXrEb+H4BJwgLNVi2oAR1h7RJEVdudB6YmB8D5cKfLZ7+CETDt7I
	 qWHd5iBCAqRfJYg6dcQ/s8bXRzJG3ksBUSScIPiI1ZiGcW14y0ZTBrgfQN7J2TJaZ8
	 cWHaK7R44q57lq3zm0pzI5WosOKvTeK6S3u3z40ZW4MTgKCRRvES0uNm9YbTUxck1y
	 IeLlHTxYKYTSQ==
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-2f4f505118fso14294561fa.3
        for <linux-wireless@vger.kernel.org>; Thu, 29 Aug 2024 16:24:03 -0700 (PDT)
X-Gm-Message-State: AOJu0YzIGwAGClyv9LjcFZZrlswJiJl+fjhh/Zja4Mou+7TFehMo2fwz
	MPkoQwpqlAU/oFQacWY2OiUXcF7oEQmCSSZkV+NLCFrpwoSTq3JsdoeK70Zvp0p6e9RCckZskJB
	EJGsQX40ssiMwC0yKhypSf45Db+s=
X-Google-Smtp-Source: AGHT+IHPIaMgDBTqCLGJCPr0CU/LVNAQ/DalYXOgE5VL4oYKTzknViNSFSOgx8rZgNmEklILCQRvjHiZ2iv2yWWR37c=
X-Received: by 2002:a2e:4612:0:b0:2ef:2061:8bf5 with SMTP id
 38308e7fff4ca-2f610552732mr31125121fa.40.1724973841960; Thu, 29 Aug 2024
 16:24:01 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240828084706.12257-1-pkshih@gmail.com>
In-Reply-To: <20240828084706.12257-1-pkshih@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 30 Aug 2024 08:23:49 +0900
X-Gmail-Original-Message-ID: <CAGb2v67ajRNxCQ-tHJoksA1PrneU+AsJxRNHoN3+eWmS1NudPQ@mail.gmail.com>
Message-ID: <CAGb2v67ajRNxCQ-tHJoksA1PrneU+AsJxRNHoN3+eWmS1NudPQ@mail.gmail.com>
Subject: Re: [PATCH 1/4] wireless-regdb: Update regulatory info for Serbia
 (SR) for 2024
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 28, 2024 at 5:52=E2=80=AFPM Ping-Ke Shih <pkshih@gmail.com> wro=
te:
>
> From: Ping-Ke Shih <pkshih@realtek.com>
>
> Serbia government released radio frequency range on February 5, 2024 [1].
> Based on Article 100, paragraph 5 of the Law on Electronic Communications
> and Article 17, paragraph 1 and Article 42, paragraph 1 of the Law on
> Government.
>
>  * 2400 - 2483.5 MHz
>    - 20 dBm
>    - EN 302 328
>  * 5150 - 5350 MHz
>    - 23 dBM (Without TPC)
>    - 5250 - 5350 MHz, DFS
>    - EN 301 893
>  * 5470 - 5725 MHz
>    - 27 dBm (Without TPC)
>    - 5470 - 5725 MHz, DFS
>    - EN 301 893
>  * 5925 - 6425 MHz
>    - 23 dBm, LPI
>    - EN 303 687

Please list out each section / line within [1] that each rule above
refers to. Otherwise it is impossible to verify.

ChenYu

>
> [1] https://www.ratel.rs/uploads/documents/empire_plugin/Uredba%20o%20utv=
rdjivanju%20Plana%20namene%20radiofrekvencijskih%20opsega.pdf
> [2] EN 302 328 https://www.etsi.org/deliver/etsi_en/300300_300399/300328/=
02.02.02_60/en_300328v020202p.pdf
> [3] EN 302 066 https://www.etsi.org/deliver/etsi_en/302000_302099/302066/=
02.02.00_20/en_302066v020200a.pdf
> [4] EN 301 893 https://www.etsi.org/deliver/etsi_en/301800_301899/301893/=
02.01.01_60/en_301893v020101p.pdf
> [5] EN 303 687 https://www.etsi.org/deliver/etsi_en/303600_303699/303687/=
01.01.01_60/en_303687v010101p.pdf
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 11 +++++++----
>  1 file changed, 7 insertions(+), 4 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index 9a55f6b8cc98..ad8dddc9c800 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1758,11 +1758,14 @@ country SN: DFS-FCC
>         (5490 - 5730 @ 160), (24), DFS
>         (5735 - 5835 @ 80), (30)
>
> +# Source:
> +# https://www.ratel.rs/uploads/documents/empire_plugin/Uredba%20o%20utvr=
djivanju%20Plana%20namene%20radiofrekvencijskih%20opsega.pdf
>  country SR: DFS-ETSI
> -       (2402 - 2482 @ 40), (20)
> -       (5170 - 5250 @ 80), (20), AUTO-BW
> -       (5250 - 5330 @ 80), (20), DFS, AUTO-BW
> -       (5490 - 5710 @ 160), (27), DFS
> +       (2400 - 2483.5 @ 40), (20)
> +       (5150 - 5250 @ 80), (23), AUTO-BW
> +       (5250 - 5350 @ 80), (23), DFS, AUTO-BW
> +       (5470 - 5725 @ 160), (27), DFS
> +       (5925 - 6425 @ 320), (23), NO-OUTDOOR
>
>  # Source:
>  # https://www.siget.gob.sv/actualizacion-de-cuadro-nacional-de-atribucio=
n-de-frecuencias-t-0408-2023/
> --
> 2.25.1
>

