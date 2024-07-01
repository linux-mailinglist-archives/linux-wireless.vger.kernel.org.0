Return-Path: <linux-wireless+bounces-9755-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2DBE91DB4A
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 11:17:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8E369283667
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 09:17:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C2213FB30;
	Mon,  1 Jul 2024 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TWcHt3h9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3745725622
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 09:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719825458; cv=none; b=daxraG8xFPuYudw9Yni3s2EvBImIkdzXnQ6P5CpBTcHFGAFbsUFNeoS1ZgsXMnTya2jR30RHJ9m93k0dkLIRii4TirkGnbs94Z7strThEaW+ZWzl0YnTVlSYkS746EqmJ+a//7uC1gbMt9Vgr40T+MeSVHDLJmvDh1/H6GK3xCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719825458; c=relaxed/simple;
	bh=BRj5TyyN/MhwYou5SO7UHZe2yy9s3hsj6dSrEl4jloA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NShMDfma48d4oOSdp1etw2Tev0vfv1F/CdlmWLWMT7XkY5nSG18Tihg7hUNJ/gLs3iBfaYrNhz2UcxxrJpJ+MSE0jJcHxDtc3Ah8DFge/X2bPxJBly4E5vY7F5NdzEsePwphzqpWJy7TnMgbOmMxFpeRyFKjZ0U7Nr69dlOZBxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TWcHt3h9; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1645BC116B1
	for <linux-wireless@vger.kernel.org>; Mon,  1 Jul 2024 09:17:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719825458;
	bh=BRj5TyyN/MhwYou5SO7UHZe2yy9s3hsj6dSrEl4jloA=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=TWcHt3h9QF4+YYUDl+GqBTr0DZoWum5R3CnwrWAH92sNKIBi/S/W7qERGeXb+8WfN
	 4wYQkYi6X3LUfay5iwGvCAT9FePLJnIDPEVqR1sW2fWdN3tcQgznnzsAzM6rd46nYW
	 INgQ4CQLDRaIs7wjqWzgm/47oCOyL19tZLnkCeyGN+W7gvmM1AF6WYnOqkcGBfriLC
	 lyRyevAhUMLpbBij/eEHL4EF6GBHebR72aZQ5v8YG8nZER0sa4lE9BwIBqhu5p0dSi
	 74Rz9YZ8caLDg5kbdxeEEhmBtSCkyu2kPPDpE0FrJnmR9BGFoJBi2ENrK7K8cGES+E
	 ob2PgjeZb2/Zg==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2ec5779b423so25770301fa.0
        for <linux-wireless@vger.kernel.org>; Mon, 01 Jul 2024 02:17:38 -0700 (PDT)
X-Gm-Message-State: AOJu0YyXnoo8xZaBO+tEzxmW7dY3h50K4PB1G6CcGcCxUdapXfkK09ZA
	jGfRvELPOdCe97BzzTRph5TTA6JfmZxv859zf/8CyLiYE5unfQb7ATT1mJJF0SLVI9kMs/HRZyx
	JiYstdq6t+uSOzk+8zfq5UfR+qI4=
X-Google-Smtp-Source: AGHT+IG0YPZx+f/bXw9vPiret5Oj94L29UlMcCJrk2yJVP6Q0mn51uJgy5d6Jr56c3dl3YGtiNR36PQ/RbHjfyAlgE8=
X-Received: by 2002:a2e:b8c6:0:b0:2ec:5502:b2de with SMTP id
 38308e7fff4ca-2ee5e70742cmr41219631fa.51.1719825456436; Mon, 01 Jul 2024
 02:17:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240624025623.6021-1-pkshih@realtek.com> <20240624025623.6021-4-pkshih@realtek.com>
In-Reply-To: <20240624025623.6021-4-pkshih@realtek.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 1 Jul 2024 17:17:24 +0800
X-Gmail-Original-Message-ID: <CAGb2v64Mnu9kOjTttonyacv5wFyhC3=2=9ZUimDSRuEwaerZ4g@mail.gmail.com>
Message-ID: <CAGb2v64Mnu9kOjTttonyacv5wFyhC3=2=9ZUimDSRuEwaerZ4g@mail.gmail.com>
Subject: Re: [PATCH v2 4/4] wireless-regdb: Update regulatory info for Macao
 (MO) for 2024
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 24, 2024 at 10:56=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> =
wrote:
>
> MACAU SPECIAL ADMINISTRATIVE REGION OFFICE OF THE CHIEF EXECUTIVE release=
d
> Order from the Chief Executive No. 64/2024, which wireless data
> communications equipment defined as
>
>  - 2400-2483.5MHz 200mW
>  - 5150-5350MHz   200mW
>  - 5470-5725MHz   1W
>  - 5725-5850MHz   1W
>  - 5925-6425MHz   250 mW (for indoor use)
>                   25 mW (for use in outdoor spaces)

Could you also add 60 GHz, since the new Order lists it? That would be
57 GHz - 66 GHz at 10 W.

Thanks
ChenYu

> [1] https://bo.io.gov.mo/bo/i/2024/16/despce.asp#64
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> v2:
>    - change 5470-5725MHz to 5470-5730MHz to have 160Mhz bandwidth
>    - keep DFS flag for original ranges since it defined DFS-FCC
> ---
>  db.txt | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index 648530192b75..c26174cb6a74 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1256,12 +1256,15 @@ country MN: DFS-FCC
>         (5735 - 5835 @ 80), (30)
>         (5925 - 6425 @ 320), (100mW)
>
> +# Source:
> +# https://bo.io.gov.mo/bo/i/2024/16/despce.asp#64
>  country MO: DFS-FCC
> -       (2402 - 2482 @ 40), (23)
> -       (5170 - 5250 @ 80), (23), AUTO-BW
> -       (5250 - 5330 @ 80), (23), DFS, AUTO-BW
> -       (5490 - 5730 @ 160), (30), DFS
> -       (5735 - 5835 @ 80), (30)
> +       (2400 - 2483.5 @ 40), (200 mW)
> +       (5150 - 5250 @ 80), (200 mW), AUTO-BW
> +       (5250 - 5350 @ 80), (200 mW), DFS, AUTO-BW
> +       (5470 - 5730 @ 160), (1000 mW), DFS
> +       (5725 - 5850 @ 80), (1000 mW)
> +       (5925 - 6425 @ 320), (250mW), NO-OUTDOOR
>
>  country MP: DFS-FCC
>         (2402 - 2472 @ 40), (30)
> --
> 2.25.1
>

