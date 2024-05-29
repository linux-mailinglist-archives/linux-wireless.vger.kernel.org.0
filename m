Return-Path: <linux-wireless+bounces-8246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A1468D2B87
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 05:38:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A6498B21F06
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 03:38:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7CD4B15AAB1;
	Wed, 29 May 2024 03:37:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmzo0Z14"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58C6B273DC
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 03:37:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716953877; cv=none; b=RAPuXpGf5hrwFBv4T0TDU2x++v4OzUPurtEH/5KfEPcc3/8fEA65Vdrs075jg/U8lYA2KMSUXmZBLWaRBYYQ4li5MiPR0yV4126i0Tj/UfL6RiHiANxyRxoPVGH25iKq7mtT5Uqk/XqVaTV/Iw2jNpfVL6WizkKEAT+xC5X6BBM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716953877; c=relaxed/simple;
	bh=DC8eXP+DlwMXtkc0J5OVcMqHEXYcaa355A6WyBQfdVg=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=fHwJfwDqAy6nDxSZTUnLIh/XvB1GmtDHgdL4yFiBGL6y3gSBcJCVH97f/898NubP0WJpoUibAsHQMZWm1znAbF97gVhxNSuiL/bVFpu8LIZmNItoeSVhuhGBeQo30UIOLVsI/WQpEgyLrh7gB6KGAhix6wIrKEsx2viKokVCVbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmzo0Z14; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9C8DC2BD10
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 03:37:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716953876;
	bh=DC8eXP+DlwMXtkc0J5OVcMqHEXYcaa355A6WyBQfdVg=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=bmzo0Z14ZafXBo4m057NNmNg5A8p3PjRA/c9VjgmVktWisZqlMX5dF7icikxd7E0P
	 +XsmNJasfZiI3eJv3sDKbP5MXR098hE9p2rRWE6U5Yj2zICbzS+OY3XHhFjqyoE4L4
	 g4oOaLFFyF1HVTH8r0TM0HlL6oyTDIwyFsNOfnBYfuwOljwhxhkKDb0ywqBBHB20mI
	 Pvscm1D0FB+bnAgF9Lbc7ggnn39NGbNlMwWjdGvE/X/8VSTJUsuvvymJiD+/W1ewLi
	 IcKhiX60o7N8nIJGtiP4OW0n+Y4iUsaQ9pCUc4JiyzTw7z9pYxoSG6zbXbOrewUI4W
	 fpWZdLKDwLhWg==
Received: by mail-lj1-f169.google.com with SMTP id 38308e7fff4ca-2e95a883101so18522671fa.3
        for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 20:37:56 -0700 (PDT)
X-Gm-Message-State: AOJu0YwAzJE3vnD9RlvAfJIDO2rdaJIftr0XLW3Tm4uBwTr8AVXD/tqA
	TWH2h8BvwI0y2Hd62AK0RvuYmWFpOgkiPexPBte87SRY0YsayuOAWioEw6jOsqyiTf3QaR5W9Dt
	iw0ljs3dWCbIKR/rqfepjeYeUsX8=
X-Google-Smtp-Source: AGHT+IEEGG1cUR9/0eERHvKSPPqwEXzmmuAL/3UoTc0jAcDv3PcLhr2Dce3K71GgzOlCvno1Da6LT/EnQuUoRNvusss=
X-Received: by 2002:a2e:8743:0:b0:2ea:7c98:8d5d with SMTP id
 38308e7fff4ca-2ea7c9890a6mr1552221fa.19.1716953875150; Tue, 28 May 2024
 20:37:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240529003843.4285-1-pkshih@realtek.com>
In-Reply-To: <20240529003843.4285-1-pkshih@realtek.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 29 May 2024 11:37:41 +0800
X-Gmail-Original-Message-ID: <CAGb2v65+scSTuK5Q-m8kAfbXKFgfpSB3k0BNFAsCeXAF4EO0qg@mail.gmail.com>
Message-ID: <CAGb2v65+scSTuK5Q-m8kAfbXKFgfpSB3k0BNFAsCeXAF4EO0qg@mail.gmail.com>
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory info for Thailand
 (TH) on 6GHz
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, May 29, 2024 at 8:38=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> The Broadcasting Commission Television business and the National
> Telecommunications Commission announced Technical standards for
> telecommunications equipment and equipment for radiocommunication equipme=
nt
> that uses the frequency 5.925 - 6.425 GHz [2], which section 2.1 describe=
s
> e.i.r.p. (Equivalent Isotropically Radiated Power) is 250mW and 25mW for
> indoor and indoor/outdoor respectively.
>
> [1] https://ratchakitcha.soc.go.th/documents/140D100S0000000004000.pdf
> [2] https://ratchakitcha.soc.go.th/documents/140D100S0000000004200.pdf
> [3] https://ratchakitcha.soc.go.th/documents/140D100S0000000004300.pdf
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
> v2: adopt indoor power 250mW instead.

Can you resend with the wireless-regdb mailing list CC-ed?

ChenYu

> ---
>  db.txt | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/db.txt b/db.txt
> index 022ecb3719b6..f27dd5214630 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1702,12 +1702,17 @@ country TG: DFS-ETSI
>         (5250 - 5330 @ 40), (20), DFS
>         (5490 - 5710 @ 40), (27), DFS
>
> +# Source:
> +# https://ratchakitcha.soc.go.th/documents/140D100S0000000004000.pdf
> +# https://ratchakitcha.soc.go.th/documents/140D100S0000000004200.pdf
> +# https://ratchakitcha.soc.go.th/documents/140D100S0000000004300.pdf
>  country TH: DFS-FCC
>         (2402 - 2482 @ 40), (20)
>         (5170 - 5250 @ 80), (17), AUTO-BW
>         (5250 - 5330 @ 80), (24), DFS, AUTO-BW
>         (5490 - 5730 @ 160), (24), DFS
>         (5735 - 5835 @ 80), (30)
> +       (5925 - 6425 @ 320), (250 mW), NO-OUTDOOR
>
>  country TN: DFS-ETSI
>         (2402 - 2482 @ 40), (20)
> --
> 2.25.1
>

