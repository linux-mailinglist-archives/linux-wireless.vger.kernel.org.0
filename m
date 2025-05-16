Return-Path: <linux-wireless+bounces-23062-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 145D3AB974B
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 10:17:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E3A15A05434
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 08:16:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0798B22CBFD;
	Fri, 16 May 2025 08:15:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VY6EHgDd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6A1622CBE8
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 08:15:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747383354; cv=none; b=EwHDPprGeTmeDqqC8YWY6TsxRFEXq8IqkEqLmg0uWgBiviB1FOTQpXpUAt8E8YKD20FRtyoH2anu2BUsIflUyRv+I3H3IdMG8CjqBQU+BlErCkLmSRyoYjwq8y86RG/xlqWCdKDJKRdLgdPyo3h4NIyypDc4/Z/ZM9+WpWXYw2g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747383354; c=relaxed/simple;
	bh=sbofOfQ8qYoR6VnvhpGlReJGNeE++W4mzbqm6wxsDoo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ODGnCtCe16jGOw8i+B45wv+6XYvFQ4UmxJVr3/4TT9wFKFUfMqnN5EboK5NW2XieVEsVnRViXFXnILEL6OWJq6/GcD0HgGIqFxryp9v6ff6+UJuXCQbc1DMjCKDeG92Ds/abqaNuPdI7GoVVwONBs7Vl1KtXGWO0I8721wHvxsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VY6EHgDd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 44804C4AF09
	for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 08:15:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747383354;
	bh=sbofOfQ8qYoR6VnvhpGlReJGNeE++W4mzbqm6wxsDoo=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=VY6EHgDdaRNFBn+q3R9xGUZEHvhxD21280YJPL+//FoQWz8p7v5dWN2XdsYyLoGCY
	 ipVuadhNfmdfAe4KHumc1av90X0Lju6+cnkQ9scS+VqGBHmN6V4fVNMmQagqJcX+1D
	 mHoPSVuD0bTu/LGkffTqGVHnHce2s0U9sO5uWtr9zx8KbyhmHI5+pm9ZBYaGB7BRBc
	 jGt8EfMUQ8sd7t19xeHxxgR5rFXd8qhYQfXRbp5Mf1JwQVxh6cmJuj9s8Ng4zlFIPJ
	 tSG68Em9wEI47OuhjlI2duA2Gz1/fyY8QYqiv+F5pQzJnFRF+6x0UHwBFt5n7fAkHG
	 nloB6ahuEzttQ==
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-30ddad694c1so20005981fa.2
        for <linux-wireless@vger.kernel.org>; Fri, 16 May 2025 01:15:54 -0700 (PDT)
X-Gm-Message-State: AOJu0YyAg8bI66VNsLowenmWoHNKX5Yv1sqiROuYaxKt2TGN4En9SwrX
	JW7vZNQlGzSWYN2QXhZC82rnzYhgh+Y3ptzCYeKFNHn4mEUs4KSnRxhXuanwovHCqt+fHFoz/2l
	lfNeNzVDEEHTdCbGfJ19dGJ03oL8zaFQ=
X-Google-Smtp-Source: AGHT+IHvoE8TOTQ64vdjGwNqqK1uzPtuktATwgcYMidtFPO15Yh9BoKOYwe2lTpOlV8zU11DST5EQsTW1o2Boi28HRw=
X-Received: by 2002:a05:651c:31c1:b0:30c:111d:d7b8 with SMTP id
 38308e7fff4ca-328076fca1cmr6434061fa.10.1747383352619; Fri, 16 May 2025
 01:15:52 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aBoK6p1+F5ve1rC6@FUE-ALEWI-WINX>
In-Reply-To: <aBoK6p1+F5ve1rC6@FUE-ALEWI-WINX>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Fri, 16 May 2025 16:15:40 +0800
X-Gmail-Original-Message-ID: <CAGb2v676sXN_eC9s6_2a6k2ACzf3n5jBgY_id22ruoz+Zb-Jaw@mail.gmail.com>
X-Gm-Features: AX0GCFsRs10QpUGqpJqwT4TPV9Q9e-KLoXLHjEASJXFTgAjmKW5xYikSy036M6s
Message-ID: <CAGb2v676sXN_eC9s6_2a6k2ACzf3n5jBgY_id22ruoz+Zb-Jaw@mail.gmail.com>
Subject: Re: wireless-regdb: Wrong ETSI tranmit power without TPC
To: Alexander Wilhelm <alexander.wilhelm@westermo.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org, 
	Johannes Berg <johannes@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 8, 2025 at 1:25=E2=80=AFAM Alexander Wilhelm
<alexander.wilhelm@westermo.com> wrote:
>
> Hello devs,
>
> please correct me if I'm wrong. Since TPC is not used, the EU Rules dicta=
tes to
> decrease the transmit power by 3 dBm on some sub-bands. For the most of t=
he EU
> countries the mW instead of dBm is used. Therefore they are halved (e.g f=
or
> Germany (DE) in commit 81d251dda3985e1088bd89f5d9f565e63ba5a30f). The pro=
blem is
> that the values are then converted to dBm and rounded down and result in =
a wrong
> supported value. Take a look at example (Germany again):
>
> country DE: DFS-ETSI
>     (2400 - 2483.5 @ 40), (100 mW)
>     (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW, wmmrule=3DETSI
>     (5250 - 5350 @ 80), (100 mW), NO-OUTDOOR, DFS, AUTO-BW, wmmrule=3DETS=
I
>     (5470 - 5725 @ 160), (500 mW), DFS, wmmrule=3DETSI
>     # short range devices (ETSI EN 300 440-1)
>     (5725 - 5875 @ 80), (25 mW)
>     # WiFi 6E
>     (5945 - 6425 @ 320), (23), NO-OUTDOOR, wmmrule=3DETSI
>     # 60 GHz band channels 1-4 (ETSI EN 302 567)
>     (57000 - 66000 @ 2160), (40)
>
> For the frequencies 5250 - 5350 the power of 100 mW results it 20 dBm. Co=
rrect.
> The frequencies 5470 - 5725 have a power of 500 mW. It results in 26 dBm.=
 But I
> believe 27 dBm are allowed. For the frequncies 5725 - 5875 the value of 2=
5 mW is
> also dictated. I'm not sure if I should expect 14 dBm, but I get 13 dBm.

Are you reading the converted numbers from the system, not the database
text file?

> Is there inconsistencies between dBm/mW conversions? Please give me a fee=
dback.

The conversions don't always produce round numbers, and since we can't let
the system exceed the _actual_ limit, the values can only be rounded down.
For example, 500 mW converts to roughly 26.9897 dBm. We can't use 27 dBm,
since if the system outputs at 26.999 dBm, it would be in violation of
the rules.

Or, if we understand 3 dBm reduction to be halving the power, we could
fix up any rules that "have their base limit in mW and were converted to
dBm to apply the reduction" be rewritten in mW with the numbers halved.
That would require someone to go through the entries though. But if
the rules are already written in mW, and what you observe is the kernel
rounding down the numbers, then perhaps the kernel may need to support
both units.


Thanks
ChenYu

