Return-Path: <linux-wireless+bounces-8478-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 060A98FAF2A
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 11:46:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 97A3DB20B54
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 09:46:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 81C31143724;
	Tue,  4 Jun 2024 09:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qq0zReQu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CFE713B58A
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 09:46:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717494361; cv=none; b=nMsFHDzu/7aHPAlVG09lxVp/yFEBnUtuSDxxcuBTj923YjKVA+1HAwryPPxtkpt/kWn8gjBK/Bzz/bJBEb44F7bhBLwVfqSOgQLIzZFZis0RJGg4Q4sfR11L8VYMKsWGCmjYcshu166QLRTuZ4GFuJzHYR0gz6+/K9kiKZVMESQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717494361; c=relaxed/simple;
	bh=fwqiyaGfvmo9qr9IAehcs5O5KSPzFLkU8YehLnmbkn8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7cr1/klfI7NMwBW+3TQcZkdb5PPlXiisXq8Y8i1C3xfLZXEVRUYwrUlrnP9vltI9nOetfJroV6embAW6fBUq2eAAV+wgXlyCke2fMKuCMmsiWP2BQDRyBuIIGrtjB758gmYkYc4mkYs8jbgtFxKFC/+cAU4qW70gvylqNhDOgY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qq0zReQu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EBEEC2BBFC
	for <linux-wireless@vger.kernel.org>; Tue,  4 Jun 2024 09:46:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717494361;
	bh=fwqiyaGfvmo9qr9IAehcs5O5KSPzFLkU8YehLnmbkn8=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=qq0zReQuESiNX5TTRX8oOD0XWq06lrm2rurAU9xKuthoI9D4syjQTGbj29oBLP8uz
	 si8EAQOiO7tHf/PcWNKQxYNrbrmv6mTAX/X4WR2GJVBtFEXXXVyG+Dqc1Q4dwWA3B9
	 Gh8w2KDP5HhwY5Rv3/26RTtoDNcylwYEWnaF0bcSn0UAYjL1bb2FfCBOhc+nMnq9tQ
	 LOj+yyXHHSzjZlltG/Be35nnNX2FHC2+PXxBi4y3+VIkv7T9rnbCH75fFtBO3MosE9
	 7LBkB3lUTiIn+ZQTZ+LZLSoUXa9LD8veh8FRNU6LbZjKoZuzC0/Wkw57v/CoCWGxXZ
	 rPuWOoPwgmNbQ==
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2eaa794eb9fso38859151fa.2
        for <linux-wireless@vger.kernel.org>; Tue, 04 Jun 2024 02:46:00 -0700 (PDT)
X-Gm-Message-State: AOJu0YypuBh7Qlbxo1MvbMOZexeRmTrSTW6tRzZ29Fu8qvxc/lNZaZYq
	5WmhTq65kh3b1YAuzr9mfoFLLj25QkfN77x5REIWU+//Ho9giP2J3kxRp/t3dOcY0bK1MCikFca
	q6Mf0mIzrYWFTmsr07LNEYX051Fs=
X-Google-Smtp-Source: AGHT+IFsVot5ojznU5wD4PY9+fUNtrMnvRTGZMr2ykCru/wKGysdcJGMpd4UMnvjEFbfPMGQvF/UIv2AbTpdLvdSRGc=
X-Received: by 2002:a2e:7a0d:0:b0:2ea:8188:5bdf with SMTP id
 38308e7fff4ca-2ea951acb89mr72037691fa.36.1717494359476; Tue, 04 Jun 2024
 02:45:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240603060558.98791-1-pkshih@realtek.com>
In-Reply-To: <20240603060558.98791-1-pkshih@realtek.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Tue, 4 Jun 2024 17:45:46 +0800
X-Gmail-Original-Message-ID: <CAGb2v64YQ4nxHV0Dk8UGTYZt88pen__bf6Y-uRi5APZTE=sFVg@mail.gmail.com>
Message-ID: <CAGb2v64YQ4nxHV0Dk8UGTYZt88pen__bf6Y-uRi5APZTE=sFVg@mail.gmail.com>
Subject: Re: [PATCH 1/4] wireless-regdb: Update regulatory info for Malaysia
 (MY) on 6GHz
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 3, 2024 at 2:06=E2=80=AFPM Ping-Ke Shih <pkshih@realtek.com> wr=
ote:
>
> Malaysia Communications and Multimedia Commission announced CLASS
> ASSIGNMENT NO. 1 OF 2022, which page 11 describes frequency bands
> 5925-6425 MHz are used with conditions of 25 mW EIRP for indoor and outdo=
or
> use and 200 mW EIRP for indoor use only.
>
> [1] https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-sign=
ed_19012022.pdf
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/db.txt b/db.txt
> index f27dd5214630..adfcce15e3a7 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1294,12 +1294,15 @@ country MX: DFS-FCC
>         (5490 - 5730 @ 160), (24), DFS
>         (5735 - 5835 @ 80), (30)
>
> +# Source:
> +# https://www.mcmc.gov.my/skmmgovmy/media/General/CA-No-1-of-2022_-signe=
d_19012022.pdf

I see some differences compared to the existing rules below.

>  country MY: DFS-FCC
>         (2402 - 2482 @ 40), (20)

Regulations say 2400 - 2500 MHz at 500mW.

>         (5170 - 5250 @ 80), (24), AUTO-BW

Regulations say 5150 - 5250 at 1W.

>         (5250 - 5330 @ 80), (24), DFS, AUTO-BW

Regulations say 5250 - 5350 at 1W with DFS and TPC required.
Since Linux doesn't have TPC support [1], this rule should be removed.

>         (5490 - 5650 @ 160), (24), DFS

Regulations say 5470 - 5650 at 1W with DFS and TPC required.
Since Linux doesn't have TPC support [1], this rule should be removed.

>         (5735 - 5835 @ 80), (24)

Regulations say 5735 - 5875 at 1W.

> +       (5925 - 6425 @ 320), (200 mW), NO-OUTDOOR

This part looks correct.

Could you update your patch to include these changes?
Or send a separate patch following this one to update the existing rules?


Thanks
ChenYu


[1] https://lore.kernel.org/wireless-regdb/a5123274d5a8d80d554ffb786e25bef7=
2d45f69b.camel@sipsolutions.net/


>  country NG: DFS-ETSI
>         (2402 - 2482 @ 40), (20)
> --
> 2.25.1
>

