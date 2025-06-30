Return-Path: <linux-wireless+bounces-24663-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E189AAEDAC5
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 13:23:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B02A03B99AC
	for <lists+linux-wireless@lfdr.de>; Mon, 30 Jun 2025 11:22:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4163248866;
	Mon, 30 Jun 2025 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dImza1iu"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF98D245029
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 11:22:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751282550; cv=none; b=n7oMgs9+gzyyZwTaLHGK2eh8iL9OPyWowkkuD5+4JcN3Gvpqh5Or+AJjY7/BvmMttFkZuIIc5x7zx35AJv1OQpoBqIOV4VCsvT2EVrRfxkNPhDKUjMuzTEDEmJAuFMWjgPbA1NYX5oeL9NpMwxGujd4T8h0POoAgs7AApgaPgiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751282550; c=relaxed/simple;
	bh=FJ6GAZQNRg2ID8Zlzu8aJJH8OHBkqqBWyBnq7Gm+1A8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=WZkY76hw93emXbwoPhGoMcDH5/QgK0uqa3gCV4sAYnO5zlJzfaGVvyzgFcwgwEb033ix5ykXz8H5ui4nbgUwOVRu8HBz53vc+Xd7BWDPunoh/CgfAztXnp2n51n8IfZ/o3/hgnEKSnCmILj383rDuAXqEwP1+mRzKEnI+ziIqkc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dImza1iu; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 49243C4CEE3
	for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 11:22:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1751282550;
	bh=FJ6GAZQNRg2ID8Zlzu8aJJH8OHBkqqBWyBnq7Gm+1A8=;
	h=References:In-Reply-To:From:Date:Subject:To:List-Id:Cc:From;
	b=dImza1iuayG0VvT1YTAnYV98fKq3thVx7c/9dQmvAn4DRC9m1Wq3T6VxnD1AaT9cn
	 eJktI9wV15IFFmgl2nbPaQUayZVDB4/ZdNpmE6lINYWGFLfwgl3VBOPYz4adcgoKdH
	 WaOLWEPdf6mmxeHHhICinGCbJujPnmRhtL5TkMHrhNY/OzRvlQq88PKjP7x+n46fGh
	 ktcLmaM6ZCyF6CTXl1Grx3/uQFJdhPMtAjFFF+a/Z5SV6426qSEucY332zEcarlUtk
	 1XJWStl/bKwiiT21L39sL10p9vk7fjNgDQKUXWPHVerHcPqaOgonK1ZCdtwt0ZXYe2
	 yi8UXkEWs9itw==
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-710bbd7a9e2so18862747b3.0
        for <linux-wireless@vger.kernel.org>; Mon, 30 Jun 2025 04:22:30 -0700 (PDT)
X-Forwarded-Encrypted: i=1; AJvYcCX+9g1UumaTOwb5PUrRngzGd1EybNgItUgUIUzwezSunx1IYqkqKT+g/wo/xUzsVqo0sMF/w/alLw0rkIfI3w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxGxg/cdZZ5n/X/ArR0wZVuEdE7LS6EbAGRkItaxzbgHuLtB5uJ
	94tXrLJmgTKAbpacq77J8zLQdYHjmYdZg0C0+84PiaKHeHlNiCGIYaWlJ9DmoHIta6QYpjAlDT0
	rdc7gna46j9mY87sa5sDTf7Bq3Vvomuo=
X-Google-Smtp-Source: AGHT+IF2EK6kNLxQd+7KEiZUv65dPoK+WTb0weXLnqPtewC7SoPSeosH2KCXUYCLUMAxIsVvT/ykL8kae9IlQyrUas0=
X-Received: by 2002:a05:690c:f07:b0:714:21c:5553 with SMTP id
 00721157ae682-7151713840fmr184044707b3.3.1751282549604; Mon, 30 Jun 2025
 04:22:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <eb81e590-2a34-4578-a9e4-e83b8bd6819d@RTEXMBS04.realtek.com.tw>
In-Reply-To: <eb81e590-2a34-4578-a9e4-e83b8bd6819d@RTEXMBS04.realtek.com.tw>
From: Josh Boyer <jwboyer@kernel.org>
Date: Mon, 30 Jun 2025 07:22:18 -0400
X-Gmail-Original-Message-ID: <CA+5PVA7KeA_fpsa=QpjfFk90Rmzh6kH16PCQfJZ8YFAS=18uBQ@mail.gmail.com>
X-Gm-Features: Ac12FXzLfKfTWwh9WU6ZNrhvSGGlqiJVv3U8VG7Ktv05i8sL3RKtBa2iHULCWdk
Message-ID: <CA+5PVA7KeA_fpsa=QpjfFk90Rmzh6kH16PCQfJZ8YFAS=18uBQ@mail.gmail.com>
Subject: Re: pull-request: update rtw firmware rtw-fw-2025-06-30
To: Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-firmware@kernel.org, linux-wireless@vger.kernel.org, 
	timlee@realtek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jun 30, 2025 at 1:28=E2=80=AFAM Ping-Ke Shih <pkshih@realtek.com> w=
rote:
>
> Hi,
>
> Update firmware of RTL8852C and RTL8922A for rtw89 WiFi driver.
>
> Thank you
> Ping-Ke
>
> ---
>
> The following changes since commit f40eafe216833d083f4e5598b7f45e894c373a=
d1:
>
>   Merge branch 'license' into 'main' (2025-06-27 11:45:29 +0000)
>
> are available in the Git repository at:
>
>   https://github.com/pkshih/linux-firmware.git tags/rtw-fw-2025-06-30

Merged and pushed out.

https://gitlab.com/kernel-firmware/linux-firmware/-/merge_requests/602

josh

>
> for you to fetch changes up to 78478bfc44319c14eeb35d4098c3a84f55fc6bb5:
>
>   rtw89: 8922a: update fw to v0.35.80.0 (2025-06-30 13:26:58 +0800)
>
> ----------------------------------------------------------------
> Chin-Yen Lee (1):
>       rtw89: 8852c: update fw to v0.27.128.0
>
> Ping-Ke Shih (2):
>       rtw89: 8852c: update fw to v0.27.129.1
>       rtw89: 8922a: update fw to v0.35.80.0
>
>  WHENCE                  |   1 +
>  rtw89/rtw8852c_fw-2.bin | Bin 2444568 -> 2461176 bytes
>  rtw89/rtw8922a_fw-4.bin | Bin 0 -> 1259006 bytes
>  3 files changed, 1 insertion(+)
>  create mode 100644 rtw89/rtw8922a_fw-4.bin

