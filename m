Return-Path: <linux-wireless+bounces-10332-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 9EDC4934737
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 06:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 450751F212FB
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Jul 2024 04:42:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F3C333A1BF;
	Thu, 18 Jul 2024 04:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JESp2OyC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE8F61B86FB
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 04:42:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721277721; cv=none; b=QgWRUp/Ul2XcB5zGlUVFnTitigW6JaBjNpY7bmcn/e7Aq2H4edY2QbuUzAOjl8HbLV6DX3Wy8FeUQPWOGDFr5Aa5+s/PSppBv9IvfO4VesxVfLwxXdn+F7oWO7sq5gV0OECnEJZ+r6Xa8ROV2Xt2XIPWkv1TLz2E79HeqM7mJYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721277721; c=relaxed/simple;
	bh=4rCkh4Y5tFWEKxjdy2NSfbu6yS8Qfl9dSLmQRD51zCM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kvGM11Su/C8DJeTHxY9pIBv9BdQCgpyEFCnSZdKBr7RsXr1BCFzf5/uK1Rd1vXHyc81Vqh31v6RDa3ufErdZTZRtzGXw3ev81cY7SkPFJ4uXj9KVps/Rv4LRJw1/8yj7bVQPV7QId/gxvtpQXQEWB+HJX3a0yurFCbse+tXd8HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JESp2OyC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 957C1C4AF0A
	for <linux-wireless@vger.kernel.org>; Thu, 18 Jul 2024 04:42:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1721277721;
	bh=4rCkh4Y5tFWEKxjdy2NSfbu6yS8Qfl9dSLmQRD51zCM=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=JESp2OyC3LD2Xjl4Bs82IyJjqSqT0OBDcQVM9JZbtgMiDHU15poYEusbuunCdibej
	 Q001JTrw28miMZe2IA6YMB4SxjP008N57WdvcYarAHHmn//fHNM2NtN/C8RMXiysmJ
	 vfZTUaXR4acw4loMmXBmkgwXvaxsRq/i5Ed2xMnz3VEhFouU7mikd6Bwu+iH6MDbDf
	 rUWRT8DDtsfalRKwcxG4Is4w2IMm1kUcURC7VESjzwfEMvchIl0iBl+ZbB12AICxE4
	 R4ulJPmFCRjHDcrmJGPfYDr7+AV+1rqoAXx4NkMI5NebWDE/KJUfLpSmYwdqtDxmqB
	 A2QAr5naKFEZw==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2eedec7fbc4so4792881fa.0
        for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 21:42:01 -0700 (PDT)
X-Gm-Message-State: AOJu0YypZsAVijKWJ4R1qpxxHvvy9/GlbRpZ23kTXxk3UmY29e8FH6on
	d/47W4kfa+QtmiwOKGDTBeuz8kEKmLYTmZN7a1UbHgrE9a4snY+qnxAmdRcDx/B3QHGMIJxQAQA
	5pZ1zIK9a3LQsX/BnWJ7StmFD8Zg=
X-Google-Smtp-Source: AGHT+IGnu+6eqtqrXqcfw3BIcpmlRagcob58rqe6uZr+Jqmpq7ct9P7VbWUf3lX2MeHg7XWG8rk6Zc7KqzpmVSkClEg=
X-Received: by 2002:a2e:888a:0:b0:2ec:18e5:e686 with SMTP id
 38308e7fff4ca-2ef05d4384emr8194621fa.33.1721277719979; Wed, 17 Jul 2024
 21:41:59 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240705060613.28909-1-pkshih@gmail.com> <20240705060613.28909-2-pkshih@gmail.com>
In-Reply-To: <20240705060613.28909-2-pkshih@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Thu, 18 Jul 2024 12:41:47 +0800
X-Gmail-Original-Message-ID: <CAGb2v67QC3_L740rctZeJTagF888_5jhQinPNVkfEy_pEgvKNg@mail.gmail.com>
Message-ID: <CAGb2v67QC3_L740rctZeJTagF888_5jhQinPNVkfEy_pEgvKNg@mail.gmail.com>
Subject: Re: [PATCH 2/5] wireless-regdb: Update regulatory info for Peru (PE)
 on 6GHz
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 5, 2024 at 2:06=E2=80=AFPM Ping-Ke Shih <pkshih@gmail.com> wrot=
e:
>
> From: Ping-Ke Shih <pkshih@realtek.com>
>
> Ministerial Resolution -2021-MTC/01 decided
>
> For the band 5925-7125 MHz, low power indoor case of use.
>  - access point
>    maximum EIRP: 30 dBm
>    Limited power spectral density: 5 dBm / MHz
>  - user devices
>    maximum EIRP: 24 dBm
>    Limited power spectral density: -1 dBm / MHz

Please explicitly mention that the PSD limits the rule to 12 dBm.

Otherwise this looks good.

ChenYu

> [1] https://cdn.www.gob.pe/uploads/document/file/1861732/Resoluci%C3%B3n%=
20Ministerial%20nro%20373-2021-MTC/01.pdf
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/db.txt b/db.txt
> index 266ba2d48731..2e862b322f13 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1443,12 +1443,15 @@ country PA: DFS-FCC
>         (5725 - 5850 @ 80), (36)
>         (57000 - 64000 @ 2160), (43)
>
> +# Source:
> +# https://cdn.www.gob.pe/uploads/document/file/1861732/Resoluci%C3%B3n%2=
0Ministerial%20nro%20373-2021-MTC/01.pdf
>  country PE: DFS-FCC
>         (2402 - 2482 @ 40), (20)
>         (5170 - 5250 @ 80), (17), AUTO-BW
>         (5250 - 5330 @ 80), (24), DFS, AUTO-BW
>         (5490 - 5730 @ 160), (24), DFS
>         (5735 - 5835 @ 80), (30)
> +       (5925 - 7125 @ 320), (12), NO-OUTDOOR
>
>  country PF: DFS-ETSI
>         (2402 - 2482 @ 40), (20)
> --
> 2.25.1
>

