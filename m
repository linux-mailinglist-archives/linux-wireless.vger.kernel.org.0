Return-Path: <linux-wireless+bounces-15050-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4975C9C0137
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 10:35:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 01B961F22166
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 09:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A75D61DFDB4;
	Thu,  7 Nov 2024 09:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b="hMPqC1nq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail.toke.dk (mail.toke.dk [45.145.95.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 655A9C2ED
	for <linux-wireless@vger.kernel.org>; Thu,  7 Nov 2024 09:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.145.95.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730972120; cv=none; b=oSxcTbcZqedis6AV8AEUsjp+DbVKBADcoriMvLXOL/Pn+wPuvlyNbmUzqVXvEva6cSzqIf3ZSDf7cIkd7Cliib70VNzHqIP4qmT92dbWFzjGkDNZRCWBIPghCSysAx6NUuWp1mjK8czbCUizMR7NzhvIeq3S1yDwbqN1p6vcw5I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730972120; c=relaxed/simple;
	bh=A3gBPLxLIFjBUvT/9EO2DO8Lp/H909xwWuUilV/trcc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jXYLUB42N8B0pKd+O5ncpzZZf+n8Eo2ztLntVdjwqxhOfopJLfsNnVroVC2S15pjJwSD2Wdxcbkx3AAWa8OTr4kft5EdUnd7bebwuElCR5K8mgIyNWmfdHYVhDwu0ckqSOyfBhDg4EvBkJuySQ9/UbCeshri9gVv52pkvr8xCfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk; spf=pass smtp.mailfrom=toke.dk; dkim=pass (2048-bit key) header.d=toke.dk header.i=@toke.dk header.b=hMPqC1nq; arc=none smtp.client-ip=45.145.95.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=toke.dk
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=toke.dk
From: Toke =?utf-8?Q?H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=toke.dk; s=20161023;
	t=1730972113; bh=A3gBPLxLIFjBUvT/9EO2DO8Lp/H909xwWuUilV/trcc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=hMPqC1nqdZbu6JIOlIiGh/tEo0XoQaVFqxaQKpTMmrzMTI0Z51JWqX6tb123/ka/Z
	 80RM8u6wubPj8YKnZHy87BTlMuiQEn/UZA1X6A6P1gWo+1AuKpNwcY+68Ig26WP4SI
	 fJI7tyu7vdPYi2nh9oby8Fg1OCPwkc4KKA33CyS/MhmtWHZYQb6mk16iUiwqW7IFA+
	 Gycf+7r3Q4kXbC6UNJb+XZDtNG10TuQcjyRe0f2EA7h6YSbRi7kK0BispM8M0TVPhK
	 f4FjKx4qMWAhVxnVDBkl9psNyyt9lII4mdUthuyxmNP0J+qd8W++L9eMEJrQ+CDUiB
	 jNQwPYfvdD45A==
To: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>, Kalle
 Valo
 <kvalo@kernel.org>
Cc: Jeff Johnson <jjohnson@kernel.org>, Jiri Slaby <jirislaby@kernel.org>,
 Nick Kossifidis <mickflemm@gmail.com>, Luis Chamberlain
 <mcgrof@kernel.org>, Loic Poulain <loic.poulain@linaro.org>, Arend van
 Spriel <arend.vanspriel@broadcom.com>, Felix Fietkau <nbd@nbd.name>,
 Lorenzo Bianconi <lorenzo@kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
 Shayne Chen <shayne.chen@mediatek.com>, Sean Wang
 <sean.wang@mediatek.com>, Matthias Brugger <matthias.bgg@gmail.com>,
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, Andy
 Shevchenko <andriy.shevchenko@linux.intel.com>, Peter Chiu
 <chui-hao.chiu@mediatek.com>, Breno Leitao <leitao@debian.org>, "Russell
 King (Oracle)" <rmk+kernel@armlinux.org.uk>,
 linux-wireless@vger.kernel.org, ath10k@lists.infradead.org,
 ath11k@lists.infradead.org, wcn36xx@lists.infradead.org,
 brcm80211@lists.linux.dev, brcm80211-dev-list.pdl@broadcom.com,
 linux-arm-kernel@lists.infradead.org, linux-mediatek@lists.infradead.org
Subject: Re: [PATCH] wifi: Switch back to struct platform_driver::remove()
In-Reply-To: <20241106170706.38922-2-u.kleine-koenig@baylibre.com>
References: <20241106170706.38922-2-u.kleine-koenig@baylibre.com>
Date: Thu, 07 Nov 2024 10:35:13 +0100
X-Clacks-Overhead: GNU Terry Pratchett
Message-ID: <87fro375f2.fsf@toke.dk>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com> writes:

> After commit 0edb555a65d1 ("platform: Make platform_driver::remove()
> return void") .remove() is (again) the right callback to implement for
> platform drivers.
>
> Convert all platform drivers below drivers/net/wireless to use
> .remove(), with the eventual goal to drop struct
> platform_driver::remove_new(). As .remove() and .remove_new() have the
> same prototypes, conversion is done by just changing the structure
> member name in the driver initializer.
>
> En passant several whitespace changes are done to make indentation
> consistent in the struct initializers.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@baylibre.com>

For ath9k:

Acked-by: Toke H=C3=B8iland-J=C3=B8rgensen <toke@toke.dk>

