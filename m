Return-Path: <linux-wireless+bounces-11293-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C4EB394E7E1
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 09:32:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 82AB72811BD
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 07:32:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47F2114C5BD;
	Mon, 12 Aug 2024 07:32:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VK69YRfm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 21A84136328
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 07:32:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723447963; cv=none; b=ocQuf5f1m3JYcwxeIy/Ekz7d8yLXnRlIwL5bxOlBdqthBg4ZuedMdxxlszI2qh4u63VpwMbQHEgiFeq9MlFp0zdbl17crncKU+u3qXw43Ofdhh7/ndL8NOmjZFOnekmQ2AkKlfO7yJ2VSeyODEC6MvIvN3kC033HWstY73GYjBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723447963; c=relaxed/simple;
	bh=Ju1FGjM6mz3LNrXveCN++QOdMRmYgYgVkZVwCsHwak8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FLBa+Mo087ShfSCxW9b9afVzy+AgizOznE7Ynt0wsDBMTzP3p47NL53hBEHrQPKzE0i+gXObBmrcHN69Zz114FL8zkKJ/k4NqSrLHsHJcQvej0GJ+ow+bBCCCGkS1/zVznkYIap1iekY2ua3RLkx37JcFL/ei3ODhWxeP9C4eV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VK69YRfm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91D4BC32782
	for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 07:32:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723447962;
	bh=Ju1FGjM6mz3LNrXveCN++QOdMRmYgYgVkZVwCsHwak8=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=VK69YRfmilND8LwolMZcZgdTcvF1dsHbL5u/ngBlLIbrrqIK7zQs5CIaYzoLXSPMv
	 shiZCytRib9pBoUOA1Kv5w47oxMCHULhaKStQgDR1PcmYLgKijtjDgFxykHR2phpNH
	 DBaps2xvHnRLyQJL5pxHLGJoJEtHZFK/5u4F09stSWEGEN0smoeNoFTtX9T9hFrKOb
	 WEsPwNg+dwyrY0FuxSl5FVComisN43nHUYkQ2/NKTLdma0QjXvud5Ga42YHoRq/NYO
	 r2U8mPJz0EVL8hmRfXe96A43R59WjjEBhSmmZtuLWeFPyOAj33m6NpxgyryZhfdhIS
	 69eXD4qQ/d8OQ==
Received: by mail-lj1-f170.google.com with SMTP id 38308e7fff4ca-2f15e48f35bso39629141fa.0
        for <linux-wireless@vger.kernel.org>; Mon, 12 Aug 2024 00:32:42 -0700 (PDT)
X-Gm-Message-State: AOJu0Yyy6P62p0EXusysTzT0qe+DhXxMu/iUa3gOlkaZJn27k9Q2jp/u
	VZoNN0UugX+X8OnyQx1Z5TxcMaz+gqHBrmfDU9fOMCUcLQ0GrkPBSxpXVouLJ2vppb2z4Z+eCzL
	bMPotNKS7/c6rEMrTb5UsX82FUv8=
X-Google-Smtp-Source: AGHT+IFqkjG6Ys+8GTIUaiER0bjHiehOt1U7JVGVOev4e5lA8T293MoltHVl90ehDHXSQVwIywogC2bb9vLL638q11I=
X-Received: by 2002:a2e:a98b:0:b0:2ef:2bb4:45d with SMTP id
 38308e7fff4ca-2f1a6d0027bmr58956981fa.9.1723447960788; Mon, 12 Aug 2024
 00:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240806061203.1839-3-gcperfinian@up.edu.ph>
In-Reply-To: <20240806061203.1839-3-gcperfinian@up.edu.ph>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 12 Aug 2024 15:32:26 +0800
X-Gmail-Original-Message-ID: <CAGb2v67fQiYAq7C-eT98L-tx4DoS5AN0UyfaB+hFkpOQy4Z3vQ@mail.gmail.com>
Message-ID: <CAGb2v67fQiYAq7C-eT98L-tx4DoS5AN0UyfaB+hFkpOQy4Z3vQ@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Update regulatory info for Philippines
 (PH) on 6GHz
To: Gacel Perfinian <gcperfinian@up.edu.ph>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 6, 2024 at 2:39=E2=80=AFPM Gacel Perfinian <gcperfinian@up.edu.=
ph> wrote:
>
> The Philippine National Telecommunications Commission has issued
> Memorandum Circular 002-07-2024 [1] on 05 July 2024, amending
> the allowed frequencies for HIPERLANs and RLANs specified in Section 2
> of Memorandum Circular No. 03-05-2007 [2]. The amendment has been in
> force since 22 July, 15 days after publication in The Philippine Star
> and copies furnished to the UP Law Center as mandated by law.
>
> The amended frequency table allows HIPERLAN and RLAN devices to operate
> on 5925 - 6425 MHz band for up to 25 mW (14 dBm) eirp for indoor and
> outdoor use (excluding UAV/drone use) and 250 mW (24 dBm) eirp for
> indoor use only.
>
> [1] https://ntc.gov.ph/wp-content/uploads/2024/MEMORANDUM%20CIRCULAR/NTC%=
20MC%20No.%20002-07-2024.pdf
> [2] https://ntc.gov.ph/wp-content/uploads/2015/10/LawsRulesRegulations/Me=
moCirculars/MC2007/MC-03-05-2007.pdf
>
> Signed-off-by: Gacel Perfinian <gcperfinian@up.edu.ph>
> ---
>  db.txt | 3 +++
>  1 file changed, 3 insertions(+)
>
> diff --git a/db.txt b/db.txt
> index 4eaeaae..27f1e43 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1481,9 +1481,11 @@ country PG: DFS-FCC
>  # NTC MC 03-05-2007 https://ntc.gov.ph/wp-content/uploads/2015/10/LawsRu=
lesRegulations/MemoCirculars/MC2007/MC-03-05-2007.pdf
>  # NTC MC 03-08-2013 https://region7.ntc.gov.ph/images/LawsRulesAndRegula=
tions/MC/WDN/MC_03-08-2013.pdf
>  # NTC MC 01-01-2016 https://ntc.gov.ph/wp-content/uploads/2016/MC/Explan=
atory-MC-No-01-01-2016.pdf
> +# NTC MC 002-07-2024 https://ntc.gov.ph/wp-content/uploads/2024/MEMORAND=
UM%20CIRCULAR/NTC%20MC%20No.%20002-07-2024.pdf
>  # 2400 - 2483.5 MHz: NTC MC 09-09-2003, Section 3.1; NTC MC 03-08-2013, =
Section 3.1; NTC MC 03-05-2007, Section 2
>  # 5150 - 5350 MHz: NTC MC 09-09-2003, Section 3.1; NTC MC 03-08-2013, Se=
ction 3.1; NTC MC 03-05-2007, Section 2
>  # 5470 - 5850 MHz: NTC MC 09-09-2003, Section 3.1; NTC MC 03-08-2013, Se=
ction 3.1 NTC MC 03-05-2007, Section 2
> +# 5925 - 6425 MHz: NTC MC 002-07-2024, Section 1; NTC MC 03-05-2007, Sec=
tion 2
>  # 57000 - 66000 MHz: NTC MC 01-01-2016, Section 1
>
>  country PH: DFS-FCC
> @@ -1492,6 +1494,7 @@ country PH: DFS-FCC
>         (5250 - 5350 @ 80), (23), DFS, AUTO-BW
>         (5470 - 5725 @ 160), (24), DFS
>         (5725 - 5850 @ 80), (24)
> +       (5925 - 6425 @ 320), (24), NO-OUTDOOR

Could you use the value and unit directly given in the referenced
document? So 250 mW.

The database takes both. You don't need to convert the other ones.


Thanks
ChenYu

>         (57000 - 66000 @ 2160), (24)
>
>  country PK: DFS-JP
> --
> 2.45.2.windows.1
>
>

