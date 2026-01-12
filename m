Return-Path: <linux-wireless+bounces-30706-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id E1E25D13D0A
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 16:53:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id E95EA3013388
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Jan 2026 15:51:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4930B30BF5C;
	Mon, 12 Jan 2026 15:51:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="QVEQnoNL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8DF2331A55;
	Mon, 12 Jan 2026 15:51:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768233096; cv=none; b=Yz3meGLO1pD9RuqXw8nzGcEufkQyZQApAOSobFBbw4dgAdozhjrtXbs+vFGsjyXQnBK6ScApnTnqbTV9Xc7swDFG+QONsjwQqt7TnAiS1SMg+i7kkqmBgcWn3q8T6oK+u0T6oNvmG4aaKNRmhjQ/eGkgU0gjadtLXr8+g9ClUAU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768233096; c=relaxed/simple;
	bh=d+t0Ya7YKjtvqo2/rcK0JAPM21xHfRvwx8fXazupykw=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=MxWQ/Dsp+MTAXXjSDJkGXfnWQ8VKZCIBSrEqVYsDOkww0tSxnkj9Dd3p+w4240ZKSjoo9HCkl5fA2pY4WtucuJK5zWKQHEwwrwinWKxDTwKD33SMRDJ1pNmFjNCbEJygS33068DrkGEY3nui6nkc6Slwn10J2aoBZ1Oy2tQu31E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=QVEQnoNL; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=0ACvZkLrk2c0QjtWMPwJ7obXttzH4Cm/ei1r84NM5zg=;
	t=1768233095; x=1769442695; b=QVEQnoNLBOVm7IbP7UxoHaaxayi5FmteC9WYgdjvDKBi8YB
	kEaDC6+fhKcSvSWXx21v/1QhJ/zirnZZaehifnGV8fUrFJnCHkzWvvgSmgGPPFWICrGUwDS4ylKOT
	n2MBWLKcyeJ6EGDV63K1UTrPQZ72Xt0d5bP/rQ7fVzja4NJc8TN0255Qj9RwBHq30YA3tsu+zxSCe
	KSeq5joBYYLPTHpE72Q5ftNmV/KYrKiPlMLGXx4sxwT8J99YS9wpyvWMcWkyQfTH+K6V/aItsWjZc
	LMDriAaifrfWxIlgVkJM6ZCyjRXBax3lhoZ+6G0KfDAnrPBPprsN0mLkDB2vmLDQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1vfKCa-00000009x0w-1GUG;
	Mon, 12 Jan 2026 16:51:32 +0100
Message-ID: <dc096cdc77d42bd90f3e3e3f420912bf365793ad.camel@sipsolutions.net>
Subject: Re: [PATCH v2 0/3] sdio: Use bus type function for shutdown
From: Johannes Berg <johannes@sipsolutions.net>
To: Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@baylibre.com>, 
 Ulf Hansson <ulf.hansson@linaro.org>, Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org, linux-mmc@vger.kernel.org
Date: Mon, 12 Jan 2026 16:51:31 +0100
In-Reply-To: <cover.1768232321.git.u.kleine-koenig@baylibre.com> (sfid-20260112_164712_157423_ABC1CD8C)
References: <cover.1768232321.git.u.kleine-koenig@baylibre.com>
	 (sfid-20260112_164712_157423_ABC1CD8C)
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2026-01-12 at 16:46 +0100, Uwe Kleine-K=C3=B6nig wrote:
> Hello,
>=20
> this series is part of an effort to get rid of the .shutdown() callback
> (and .probe() and .remove()) in struct device_driver. Preparing that,
> all sdio drivers that up to now use this callback are converted to a new
> sdio specific shutdown callback.
>=20
> v1 is available at https://lore.kernel.org/all/cover.1765968841.git.uklei=
nek@kernel.org.
>=20
> Changes since v1:
>  - Drop patch 2/4 which resulted in a build failure with CONFIG_PM=3Dn
>=20
> Patches #2 and #3 depend on the first patch, and with just the first
> patch applied there is a runtime warning (emitted by the driver core in
> driver_register()) for each unconverted driver. So it would be nice to
> get the whole series in during a single merge window to not let users
> face the warning.
>=20
> Given that all drivers are in drivers/net/wireless I suggest to apply
> the whole series via the wireless tree.
>=20

Sounds good, thanks for the heads-up.

I guess I should get Ulf's ack for the MMC part, and Ping-Ke's for the
rtw part, and nobody cares about rsi :)

johannes

