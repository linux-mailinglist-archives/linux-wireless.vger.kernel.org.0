Return-Path: <linux-wireless+bounces-27730-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C8052BABCF9
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 09:25:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id B904A4E23BD
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Sep 2025 07:25:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46CC5239E76;
	Tue, 30 Sep 2025 07:25:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iawEnjln"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com [209.85.208.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E466F23182D
	for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 07:25:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759217133; cv=none; b=ARC1xuhHv28cFoAtLNKDfSwHTdVXyyoAL7H21vEQFDlxTHVgv6oVh/+bNevah5Dg0NAD6V0r2OGPFyi4PGMX88+qIDRqOw0z5pxN56cWaujYOGtNhY+0SjQsQZNlUmUC2DxUivjva+bfJGnSY9u8e+2XAjsBlCLaGxuLDCs3xVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759217133; c=relaxed/simple;
	bh=/qY19bwAFqM5QVChj7mGu0N4u7Sre3LNSXSK+ti50T4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=RaSWKQPvFj+CHinKDqAA7WG3wQW6pjau7leVVK9EfiA/Xuy5W2Xvxtuyouge5yCbFgNYYDZ82vuqvrDIDaPOjInOc0zDdB3uh9btbFNje30IiqI5GZL5jvFsBkugA1JnFQX+cNy+SuJhNXMTkawaruwQBl8aBoKDLxrGf9qgREc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iawEnjln; arc=none smtp.client-ip=209.85.208.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f43.google.com with SMTP id 4fb4d7f45d1cf-62fc28843ecso7663228a12.1
        for <linux-wireless@vger.kernel.org>; Tue, 30 Sep 2025 00:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759217129; x=1759821929; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Led2UwPQnyytnl+DzRHCByDRtvZjSP7e5YjaRCfpAKg=;
        b=iawEnjlnZSX2qhU1WoWjaRUgLqpHbqx6bSowoPhZr63KvT7A70JrqPG6+ck/DnpQcw
         vjxTpibWPGBWGvJ7C2+dBWmPL4VS2+OtmdlgQ17R3yXFAgv8y4/qFfqo1GmIdoq711GX
         jvMgT8CfGc4ZoaEYnJEVz0RJUvIdgcToseIrg4TPs2gZxSg005T/8aw2pEG1yFafRYGT
         9CWeEVDzmKinHB9s/t4y+iigCHAqL1dg5kXgULG5eafTg3Lfcs912hZhsjBhyOm7oYvo
         JKTe+tCRRFH2k90Lq3x/k+ORHhSB9R5hcSVX+UxkuyugNd62d+nVWBFJxwMk/Y2L08Sy
         HH/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759217129; x=1759821929;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Led2UwPQnyytnl+DzRHCByDRtvZjSP7e5YjaRCfpAKg=;
        b=bj/RnmpHGXMSGh0Biq0E/vu9rGNqI4vm71v3qhNNZMClfRICqsQaPaZxgP/3KlPE/e
         8dClYq/Frty/cNzyfs8sndbPdLVkHkOqSnVfk6b0YfeJmlQcZKnr5KTDmTtZfLit7MiV
         7/GIYANuYHwLOY+yjkO0diuvmtnooDm4gLZI4VzV9iBd7BsiPYqeY0+QW71ScCx7+Zhe
         g7Bi5isly/VnhaeUVDvh/8+ENzDNmBGkMz+krZrMl6LqFtsav9ivl9e1Migoa7RgeYrr
         fpqHlzf64Dwjv4XoElScCh9I860lvn6ijyf5v2ENraayVvGErQ00OX8RdTRaHEmUtDSS
         IbLQ==
X-Forwarded-Encrypted: i=1; AJvYcCUYjUGPCboP9Re4mt901nnrpxn9ykclrMllL5+uBkMayZpauNg7pH2brx/G6hrPYnp9QEvQmiem/YDdqu7zkw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yx2OrBifvjVhpo7DTcAVh122BjHQ4XjX/UqdKVKWA0QI8Xg5+g0
	JICHJT+Osc8MHmszs2kChHUIWwGRyx8L20XR9i1IXOZ5wA8DA5qdjz2VeKpIC3QeDa8NWLC4FnM
	UIlQscQ8vVwaHM+Hy/7LmzhVHCmtq2GE=
X-Gm-Gg: ASbGncv1Q2b6uhdAESu9zRnWD3+kXB7Nwjp6uNlBxreeP2+aWRM3CVQtbvH7Tsh/8Rk
	ZhV0JfWsqe853jTD7AE56piYLaMm931PnDu0g+0Co1nB8oMeKHqZEzakm2hVWgxAB6BDY5+kCP4
	XRzhbj7ERGEHaZM3lJ/Ap4LYy5B4EqHOqWK1YpiblVHQLVPe4J4Y9yR1cWsFyc3/panbmYIxzWb
	lkMgRA3YS00oITaUgXLEt/K63XBhMA=
X-Google-Smtp-Source: AGHT+IF4t4oQO0H59K5Coad4/8MzQEtuxgT8xWOt07Q8r4oPn0OPKDtCHe6XhgsPz7Ze7htZiZMbsS28x5RpC/AfOIk=
X-Received: by 2002:a17:907:3c8c:b0:b09:c230:12dc with SMTP id
 a640c23a62f3a-b34b7209e46mr2050761566b.8.1759217128969; Tue, 30 Sep 2025
 00:25:28 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250930042948.427154-1-wens@kernel.org>
In-Reply-To: <20250930042948.427154-1-wens@kernel.org>
From: Ping-Ke Shih <pkshih@gmail.com>
Date: Tue, 30 Sep 2025 15:25:17 +0800
X-Gm-Features: AS18NWDi9ciIzyF1qDllkNFnyo0p18giZ057pSnyex9niropTawTNyln0E9z9bI
Message-ID: <CAHrRpunr+hbWiO1jY=jGZOiqGWcXFGYBSJi17+r-AgOMwssaXg@mail.gmail.com>
Subject: Re: [PATCH] wireless-regdb: Permit lower 6 GHz band for Kazakhstan (KZ)
To: Chen-Yu Tsai <wens@kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Pavel Starosek <starosekpd@gmail.com>, 
	wireless-regdb@lists.infradead.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Chen-Yu Tsai <wens@kernel.org> wrote:
>
> By Order of the Minister of Digital Development No. 564/NK dated
> September 19, 2024 [1], an amendment was made to the assignment of
> frequency bands, opening up the lower part of the 6 GHz band (5,945 MHz
> to 6,425 MHz) was opened up to "SRD (wideband data transmission systems)
> WAS/RLAN Data transmission systems/radio local area networks".
>
> The power is limited to 200 mW e.i.r.p. with a spectral density of 10
> mW/MHz. Only indoor use is permitted.
>
> While at it, also change the power limits to use mW units to match the
> official documents.
>
> Initial information was provided by the Wi-Fi Alliance website, which
> has a map [2] showing all countries that have enabled 6 GHz WiFi, and
> links to official documents. This document was not sufficient as it did
> not include power limits or other restrictions.
>
> A subsequent search found a blog post [3] providing details and titles
> of the official documents in English. An AI agent was used to search
> for the original text of said order [1] after rummaging through
> government websites in Russian and Kazakh failed to find anything.
>
> [1] https://adilet.zan.kz/rus/docs/V2400035100
> [2] https://www.wi-fi.org/regulations-enabling-6-ghz-wi-fi
> [3] https://www.onewindow.pro/blog-posts/6-ghz-band-regulation-in-the-republic-of-kazakhstan
>
> Signed-off-by: Chen-Yu Tsai <wens@kernel.org>
> ---
> If you received this patch, please help review it. The changes are
> based on translations of the original text / tables, so a second set
> of eyes would be appreciated.
>
>  db.txt | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
>
> diff --git a/db.txt b/db.txt
> index 6e1ad30..16bcb32 100644
> --- a/db.txt
> +++ b/db.txt
> @@ -1136,11 +1136,12 @@ country KY: DFS-FCC
>  # http://adilet.zan.kz/rus/docs/V1500010730
>  # http://adilet.zan.kz/rus/docs/V1500010375
>  country KZ: DFS-ETSI
> -       (2400 - 2483.5 @ 40), (20)
> -       (5150 - 5250 @ 80), (23), NO-OUTDOOR, AUTO-BW
> +       (2400 - 2483.5 @ 40), (100 mW)
> +       (5150 - 5250 @ 80), (200 mW), NO-OUTDOOR, AUTO-BW
>         (5250 - 5350 @ 80), (20), NO-OUTDOOR, DFS, AUTO-BW

The power limit of 5150-5350 MHz is 200 mW, maximum spectral density
e.i.r.p. 10 mW/MHz.

So, 5250 - 5350 should be 23 dBm or 200 mW.

> -       (5470 - 5725 @ 160), (20), NO-OUTDOOR, DFS
> -       (5725 - 5850 @ 80), (20), NO-OUTDOOR
> +       (5470 - 5725 @ 160), (100 mW), NO-OUTDOOR, DFS
> +       (5725 - 5850 @ 80), (100 mW), NO-OUTDOOR
> +       (5925 - 6425 @ 320), (200 mW), NO-OUTDOOR
>         (57000 - 66000 @ 2160), (40)
>
>  country LB: DFS-FCC
> --
> 2.47.3
>
>

