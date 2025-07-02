Return-Path: <linux-wireless+bounces-24752-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 318E5AF0A0A
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 06:51:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EBECB482E01
	for <lists+linux-wireless@lfdr.de>; Wed,  2 Jul 2025 04:50:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E9661B9831;
	Wed,  2 Jul 2025 04:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Hux3qMXb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6833C142E73
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 04:51:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751431880; cv=none; b=CUBEg/fJaVhitcOYYZDgh/nl9PpXhsqGIHK23Tw7VZbXeRXjqdf4nkZAl0e1batZGFSrhuMWNyiNdJTCFPFH/bl4pvlf6sbAHJ/ndpgez3uZz6xQIoJFNO1lJ858Zns2eOiObxDY0hRaWvO2O8UQtFq+FkVz7SoeV51vsshH99k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751431880; c=relaxed/simple;
	bh=AbtaAYG2tnL9JYsjzZ1tJ/pWcEGZotHeLArFcWa9pes=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=tY+51o5k4uDyitdSHdBinwiWWQgsQT4r81FIgH0wozpn0XWm9kwI53gwq2W2VdNB3ANcTz7lNBEOWEggXIdUUFuO3Dr2PYbcyk+XbaaDq9MUgyZhxTjgbsRf3UjB9cPcojvHz2PLLqBOo9fB9ueaU+Gc06PJDH6z9qJJwtX4BhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Hux3qMXb; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2C31C4CEEE
	for <linux-wireless@vger.kernel.org>; Wed,  2 Jul 2025 04:51:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751431879;
	bh=AbtaAYG2tnL9JYsjzZ1tJ/pWcEGZotHeLArFcWa9pes=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=Hux3qMXbcOorUN9lSZJvY+81nxnngsvr+WURS1VkvOqM7OhWp6SuIbKTV7Zw3KP2x
	 geBOrcsE6TVEkkU43NVjJTgtIs4tQ+RJoj28OZyzNJSln+u1nPtSeKRQVxnzDUbPwF
	 PbYHGYdB1nVgeUb5jTwfu6QSbE5RIaK7NirkqIrSu6HTFYkekSvvFv1+fpMTDJCMRs
	 pJeJUz39ai8ovYciFILpYLVotpJKVcDXpnaSY4elUh3kriJgxB7a+vcO9skxvwg9au
	 E6m/1y4XJrHW+obqUSVXbHnvcocZFxWEwncBoLOwm7xNMqq7d1wtifzOX1JaMlKh27
	 HRb+gc81+q3TA==
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-32cd499007aso46106831fa.0
        for <linux-wireless@vger.kernel.org>; Tue, 01 Jul 2025 21:51:19 -0700 (PDT)
X-Gm-Message-State: AOJu0YyQiZG5fhP6V3Q34aPQxgyjeW7OIK62B+2tXa+EbjKUgcep5F3I
	X9/pZxJkZYhpUpt/dsGIsaxRm/mF8b3C8emJrwshR0DU1egvRz5iex92iou/CPy86FIZWRHlGLj
	xfxTi628Qg6Km1sMliHpx87WfaEVErSI=
X-Google-Smtp-Source: AGHT+IGFkO/EB2Eand4Hgzq62JCZfNA2JPy4b4ML7CTsU5lKGbO7qu+F/jVaeONePB+bl3UCsq7pU4tEj5Z7hzzplbk=
X-Received: by 2002:a05:651c:41c5:20b0:32c:a006:2a1d with SMTP id
 38308e7fff4ca-32dfff6da90mr2903241fa.4.1751431878315; Tue, 01 Jul 2025
 21:51:18 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <12521651747386138@mail-sendbernar-production-main-36.klg.yp-c.yandex.net>
In-Reply-To: <12521651747386138@mail-sendbernar-production-main-36.klg.yp-c.yandex.net>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Wed, 2 Jul 2025 12:51:06 +0800
X-Gmail-Original-Message-ID: <CAGb2v64669B=aNGfKzgfzUPn1VsLKPsLbar8wRDQXaoVw3mLnw@mail.gmail.com>
X-Gm-Features: Ac12FXwnHsMQdd1ZFym4-FST1PW7b7s2phMRRjAeKWolhhVEyELAdLnyS2pevn4
Message-ID: <CAGb2v64669B=aNGfKzgfzUPn1VsLKPsLbar8wRDQXaoVw3mLnw@mail.gmail.com>
Subject: Re: [PATCH v2] wireless-regdb: Update regulatory info for Vietnam
 (VN) for 2025
To: Duy Hoang <duy@etylix.me>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

Again, sorry for taking so long to respond.

On Fri, May 16, 2025 at 5:02=E2=80=AFPM Duy Hoang <duy@etylix.me> wrote:
>
> According to [1] and [2]:
> - Update frequency range to match with Circular
> - Update units from dBm to mW to match values listed in Circular
> - Add AUTO-BW flags to allow the use of 160 MHz based on other rules
> - Update to allow use of 6 GHz band
>
> Detail:
> * 2400 - 2483.5 MHz
>   - 200 mW (23 dBm)
> * 5150 - 5250 MHz
>   - 200 mW (23 dBm)
>   - Indoor only
> * 5250 - 5350 MHz
>   - 100 mW (20 dBm)
>   - DFS/TPC
> * 5470 - 5725 MHz
>   - 500 mW (27 dBm)
>   - DFS/TPC
> * 5725 - 5850 MHz
>   - 1000 mW (30 dBm)
> * 5925 - 6425 MHz
>   - LPI
>     * 200 mW (23 dBm)
>     * Indoor only
>   - VLP
>     * 25 mW (14 dBm)
>     * Indoor and outdoor
> * 57000 - 66000 MHz
>   - 10000 mW
>
> [1] https://datafiles.chinhphu.vn/cpp/files/vbpq/2021/10/08-btttt.signed.=
pdf
> [2] https://mic.gov.vn/van-ban-phap-luat/25099.htm
>
> Signed-off-by: Hoang Pham Anh Duy <duy@etylix.me>
> ---
> Patch v2:
>   - Since Linux does not support TPC, reduce 5250 - 5350 MHz to 100 mW an=
d 5470 - 5725 MHz to 500mW
>   - Add AUTO-BW for 6GHz band
>   - Add 60GHz
> ---
>  db.txt | 15 ++++++++++-----
>  1 file changed, 10 insertions(+), 5 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index e331d4f..4e9539b 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -2001,12 +2001,17 @@ country VI: DFS-FCC
>         (5490 - 5730 @ 160), (24), DFS
>         (5735 - 5835 @ 80), (30)
>
> +# Source:
> +# https://datafiles.chinhphu.vn/cpp/files/vbpq/2021/10/08-btttt.signed.p=
df
> +# https://mic.gov.vn/van-ban-phap-luat/25099.htm
>  country VN: DFS-FCC
> -       (2402 - 2482 @ 40), (20)
> -       (5170 - 5250 @ 80), (17)
> -       (5250 - 5330 @ 80), (24), DFS
> -       (5490 - 5730 @ 80), (24), DFS
> -       (5735 - 5835 @ 80), (30)
> +       (2400 - 2483.5 @ 40), (200 mW)
> +       (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
> +       (5250 - 5350 @ 80), (100 mW), DFS, AUTO-BW
> +       (5470 - 5725 @ 80), (500 mW), DFS, AUTO-BW

                         ^
I believe this can be set to 160 directly? I didn't see any restrictions
on band width. I will change this when applying.

> +       (5725 - 5850 @ 80), (1000 mW), AUTO-BW
> +       (5925 - 6425 @ 320), (200 mW), NO-OUTDOOR, AUTO-BW
> +       (57000 - 66000 @ 2160), (10000 mW), NO-OUTDOOR
>
>  # Source:
>  # http://www.trr.vu/attachments/category/130/GURL_for_Short-range_Radioc=
ommunication_Devices2.pdf
> --
> 2.46.0.windows.1
>

