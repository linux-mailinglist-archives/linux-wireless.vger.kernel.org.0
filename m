Return-Path: <linux-wireless+bounces-24865-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8D3E8AFAA60
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 05:50:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2F7601897A1F
	for <lists+linux-wireless@lfdr.de>; Mon,  7 Jul 2025 03:51:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CF5182E36F7;
	Mon,  7 Jul 2025 03:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bcORkvBC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAC283FC2
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 03:50:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751860249; cv=none; b=cUH5F/zhzPS0h6x4AWt2ljSTAoX7Z2KrjbtYuetHaRwL1EbQ0ehXKiBTipTH4pV+hgg9ILBqTVX/2nLccg1fu8qeqZKZ4CKzaSOttTkvKuRGRnTkg3Me1xGuhINPISqhfiRpVXAoW5cDM3S1+Xbgg/W8XeIyUOSROr91LgP6VuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751860249; c=relaxed/simple;
	bh=zBrk3gr3EMuJgfva1axAChNlDapiw+6JIlHReWfneOc=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=odoiFjghBMzJilFKoQebWgBYSrJQXPsAv858XGWNZTGS0kwCI4421axdCoiWtU9gXhFB0WjWZyYKaZeH3tbvK8jqSVykBA1+hDtpP1YTQ0vUO1EtgCUzfodV1XXqlyqrEnID4VdfF3MCA5sawvxj3YUwcXnBA289BOx2WnhGSwA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bcORkvBC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F58CC4CEE3
	for <linux-wireless@vger.kernel.org>; Mon,  7 Jul 2025 03:50:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751860249;
	bh=zBrk3gr3EMuJgfva1axAChNlDapiw+6JIlHReWfneOc=;
	h=References:In-Reply-To:Reply-To:From:Date:Subject:To:Cc:From;
	b=bcORkvBC5WZTwDMBu1qM7LHgbR0dsPhf/ePzLnsBQzNlmNsr5MOvWwFtAzoj3wQNd
	 /rSr3jQKWo95ViZARiLIqBYSZbQbBtbikYxYEqcYneaROdCJNZ40yXOm5AeX8bqC5n
	 fRN52OLghFm7lK0U+Nc+eY09zdc3ViWhf1offRFf22wSUYm8/8MGAamKSjOQ7g4uZQ
	 Wp1bdWmrgDo6JrkLog0xFm201Fp19YiV9k0cm6NIuZ0+KjrlBx/CLoY0KfpZBiYZIW
	 G91jCnKDUTVk01TJ4shkIY3swKZHklCGz/Il2Q5b7+LiM1aBkQ+NJIvZ+QxMcNUnaS
	 lv5h4ID//CmFQ==
Received: by mail-il1-f169.google.com with SMTP id e9e14a558f8ab-3de2b02c69eso15981655ab.1
        for <linux-wireless@vger.kernel.org>; Sun, 06 Jul 2025 20:50:49 -0700 (PDT)
X-Gm-Message-State: AOJu0YxcRZkyZkkwIaTHRW4QbTXQSGsjjmWevU7K3bDyF154pmu6SbKj
	CHmRW+0iwIMtm23YJzDeMep2ZM+8fSOF3l3TR6iR+OsU7ti00BDr0PPOFaGNxtXc0Rv+XuisKxI
	6KgarqmNLMz6PSEJvf6RCEGziN9T4+ss=
X-Google-Smtp-Source: AGHT+IEUkm2SryigzV7PfUI3YFthXtIPKU6oz/EVxJ07bo9LaMZ7K+I7Qt9bnzASO2rLNeWJF4CeRP1Gpizv1dJopL4=
X-Received: by 2002:a05:6e02:144b:b0:3df:4783:e37 with SMTP id
 e9e14a558f8ab-3e1371e863dmr83898855ab.17.1751860248614; Sun, 06 Jul 2025
 20:50:48 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250707024615.38507-1-pkshih@gmail.com>
In-Reply-To: <20250707024615.38507-1-pkshih@gmail.com>
Reply-To: wens@kernel.org
From: Chen-Yu Tsai <wens@kernel.org>
Date: Mon, 7 Jul 2025 11:50:33 +0800
X-Gmail-Original-Message-ID: <CAGb2v64uB7-4yNCxQiU0bXEk0Px=vF+Oh5+fYevzdPUhcsXLWg@mail.gmail.com>
X-Gm-Features: Ac12FXxwmUR4IaMMnSps7nefgiamAl7vvO7Cl1tuJLedRJ9_m1VwxYMUPZrwPS0
Message-ID: <CAGb2v64uB7-4yNCxQiU0bXEk0Px=vF+Oh5+fYevzdPUhcsXLWg@mail.gmail.com>
Subject: Re: [PATCH 1/3] wireless-regdb: Update regulatory info for CEPT
 countries for 6GHz listed by WiFi Alliance
To: Ping-Ke Shih <pkshih@gmail.com>
Cc: linux-wireless@vger.kernel.org, wireless-regdb@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 7, 2025 at 10:46=E2=80=AFAM Ping-Ke Shih <pkshih@gmail.com> wro=
te:
>
> From: Ping-Ke Shih <pkshih@realtek.com>
>
> The regulations enabling 6GHz WiFi [1] of WiFi Alliance lists CEPT
> countries including
>  - Albania (AL)
>  - Andorra (AD)
>  - Austria (AT)
>  - Belarus (BY)
>  - Belgium (BE)
>  - Georgia (GE)
>  - Iceland (IS)
>  - Liechtenstein (LI)
>  - Macedonia, The Former Yugoslav Republic of (MK)
>  - Moldova, Republic of (MD)
>  - Monaco (MC)
>  - Montenegro (ME)
>  - Norway (NO)
>  - Russian Federation (RU)
>  - Switzerland (CH)
>  - T=C3=BCrky (TR)
>  - Ukraine (UA)

This is slightly confusing because the CEPT document lists 46 countries.

> Add 6 GHz frequency entry if not being added yet.

Please add the links to [2][3] to all of them. And could you also add
the link to the other countries that already have a 6 GHz entry? Just
so we know that they are harmonized.

> But being pending to add rules to below entires because countries are not
                                          ^ entries
> existing yet:

As in, no entry in the database exists?

Probably rewrite this as:

The following are skipped as they do not have corresponding entries in
the database yet. Adding an entry just for 6 GHz would cause 2.4 GHz and
5 GHz bands from the world domain to stop working.


Thanks
ChenYu

>  - Faroe Islands (FO)
>  - Gibraltar (GI)
>  - Isle of Man (IM)
>  - San Marino (SM)
>  - Holy See (Vatican City State) (VA)
>
> Links of all these countries are to point to ECC/DEC/(20)01 [2] [3], whic=
h
> decision enters into force on 8 November 2024; preferred date for
> implementation of this Decision shall be 8 May 2025.
>
>  * LPI devices
>    - 5945-6425 MHz
>    - Restricted to indoor use only
>    - Maximum mean e.i.r.p.: 23 dBm
>    - Maximum mean e.i.r.p. density: 10 dBm/MHz
>  * VLP devices
>    - 5945-6425 MHz
>    - Indoors and outdoors
>    - Maximum mean e.i.r.p.: 14 dBm
>    - Maximum mean e.i.r.p. density: 1 dBm/MHz
>
> [1] https://www.wi-fi.org/regulations-enabling-6-ghz-wi-fi
> [2] https://docdb.cept.org/implementation/16737
> [3] https://docdb.cept.org/download/4685
>
> Signed-off-by: Ping-Ke Shih <pkshih@realtek.com>
> ---
>  db.txt | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/db.txt b/db.txt
> index acfbcbf29887..b5b1308460cc 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -41,6 +41,7 @@ country AD: DFS-ETSI
>         (5470 - 5725 @ 160), (500 mW), DFS, wmmrule=3DETSI
>         # short range devices (ETSI EN 300 440-1)
>         (5725 - 5875 @ 80), (25 mW)
> +       (5945 - 6425 @ 320), (23), NO-OUTDOOR
>         # 60 GHz band channels 1-4, ref: Etsi En 302 567
>         (57000 - 66000 @ 2160), (40)
>
> @@ -80,6 +81,7 @@ country AL: DFS-ETSI
>         (5470 - 5725 @ 160), (500 mW), DFS, wmmrule=3DETSI
>         # short range devices (ETSI EN 300 440-1)
>         (5725 - 5875 @ 80), (25 mW)
> +       (5945 - 6425 @ 320), (23), NO-OUTDOOR
>
>  # Source:
>  # 2.4 GHz https://www.psrc.am/contents/document/4749
> @@ -355,6 +357,7 @@ country BY: DFS-ETSI
>         (5170 - 5250 @ 80), (20), AUTO-BW
>         (5250 - 5330 @ 80), (20), DFS, AUTO-BW
>         (5490 - 5710 @ 160), (27), DFS
> +       (5945 - 6425 @ 320), (23), NO-OUTDOOR
>
>  country BZ: DFS-JP
>         (2402 - 2482 @ 40), (30)
> @@ -742,6 +745,7 @@ country GE: DFS-ETSI
>         (2402 - 2482 @ 40), (20)
>         (5170 - 5250 @ 80), (18), AUTO-BW
>         (5250 - 5330 @ 80), (18), DFS, AUTO-BW
> +       (5945 - 6425 @ 320), (23), NO-OUTDOOR
>         # 60 GHz band channels 1-4, ref: Etsi En 302 567
>         (57000 - 66000 @ 2160), (40)
>
> @@ -1234,6 +1238,7 @@ country MC: DFS-ETSI
>         (5470 - 5725 @ 160), (500 mW), DFS, wmmrule=3DETSI
>         # short range devices (ETSI EN 300 440-1)
>         (5725 - 5875 @ 80), (25 mW)
> +       (5945 - 6425 @ 320), (23), NO-OUTDOOR
>
>  # Source:
>  # http://www.cnfr.md/index.php?pag=3Dsec&id=3D117&l=3Den
> @@ -1266,6 +1271,7 @@ country ME: DFS-ETSI
>         (5470 - 5725 @ 160), (500 mW), DFS, wmmrule=3DETSI
>         # short range devices (ETSI EN 300 440-1)
>         (5725 - 5875 @ 80), (25 mW)
> +       (5945 - 6425 @ 320), (23), NO-OUTDOOR
>
>  country MF: DFS-ETSI
>         (2402 - 2482 @ 40), (20)
> @@ -1292,6 +1298,7 @@ country MK: DFS-ETSI
>         (5470 - 5725 @ 160), (500 mW), DFS, wmmrule=3DETSI
>         # short range devices (ETSI EN 300 440-1)
>         (5725 - 5875 @ 80), (25 mW)
> +       (5945 - 6425 @ 320), (23), NO-OUTDOOR
>         # 60 GHz band channels 1-4, ref: Etsi En 302 567
>         (57000 - 66000 @ 2160), (40)
>
> @@ -1924,6 +1931,7 @@ country UA: DFS-ETSI
>         (5250 - 5350 @ 80), (100 mW), DFS, NO-OUTDOOR, AUTO-BW, wmmrule=
=3DETSI
>         (5470 - 5725 @ 160), (100 mW), DFS, NO-OUTDOOR, wmmrule=3DETSI
>         (5725 - 5850 @ 80), (100 mW), NO-OUTDOOR
> +       (5945 - 6425 @ 320), (23), NO-OUTDOOR
>         # 60 GHz band channels 1-4, ref: Etsi En 302 567
>         (57000 - 66000 @ 2160), (40 mW), NO-OUTDOOR
>
> --
> 2.25.1
>

