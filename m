Return-Path: <linux-wireless+bounces-29721-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AE78CB9FAA
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 23:45:01 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id D6AA53009C3D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 22:44:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A7B412DCF70;
	Fri, 12 Dec 2025 22:44:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="WbJJCdHM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAA0B2874FB;
	Fri, 12 Dec 2025 22:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765579498; cv=none; b=RDVGJuvtwWnB50OLfFa2KgXmtmZzNE1VYmYsWlf+v9QZxA1rVHykk1kGhZ3YvSPe+nBx2m+wEcboRfVuEpGzckw1SwaP7SXvCHEL4rs1IdLFCikqaYJtcSYl8y9p6fjHqi9gqDEW+nH2fDL8BwWXElt95SCxKk3O3wwtldtVXiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765579498; c=relaxed/simple;
	bh=OIyVM6E2jjnCI4e64mE50nhFMC8YY4mZA0yBwdNNHOc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=FNnpXr6mOyRy6EOC5TvCaDtN7ChnXzwhVyPyaWsJTp+LBlGUlMQTyWWLljboXaialN8HqKUbv733XsMcwI+vO9ofcwSUXksgqJztnydlC+Qwuj+JCjXasffYA0mEErq/pg+faHezixUTNfzk97c0roFdWDD33xnDGBs54Pnevsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=WbJJCdHM; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=OIyVM6E2jjnCI4e64mE50nhFMC8YY4mZA0yBwdNNHOc=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1765579474; v=1; x=1766011474;
 b=WbJJCdHMhCtEBqknfMmY9TjyDu897IeEWZqEGa/stAH3HmI5/tfv0itmwSExzYNagE4GNg1U
 ZxUlNxN9Yii8R2LnBm0frkGyj/FOJNLlapSmBlLlvOuFJgq7U+iioQ+xYJIZ6hsm//6m2fJLI3T
 0Am7Kwixs/rDWXPgM6pOSqBBsGWcTqSv2f4AcYIwOztzuPJ/D6ccc0BCci05j2bHyWRshz1wGQY
 NaWUVl4mYnzjUmWzSF0eUgPXoHu6we5QxAcAO6B+TZcsFTnx+d+aLkp9DS3ntJEwntr3tGrxfMY
 mQ1l8nPzPkVlFs81ZzO7cizmtHGPueIKENEIJMi8929Rg==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 8bfa23d1; Fri, 12 Dec 2025 23:44:34 +0100
From: Duje =?UTF-8?B?TWloYW5vdmnEhw==?= <duje@dujemihanovic.xyz>
To: Brian Norris <briannorris@chromium.org>, Karel Balej <balejk@matfyz.cz>
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Andrew Lunn <andrew@lunn.ch>, Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
 linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mmc@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Jeff Chen <jeff.chen_1@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
Subject:
 Re: [DONOTAPPLY RFC PATCH v2 4/4] arm64: dts: samsung,coreprimevelte: add
 wifi node
Date: Fri, 12 Dec 2025 23:44:33 +0100
Message-ID: <5962754.DvuYhMxLoT@radijator>
In-Reply-To: <DEWJTWZ6Q51B.13HQYMDJZRFWA@matfyz.cz>
References:
 <20251026182602.26464-1-balejk@matfyz.cz>
 <b92172f3-10f4-470f-b90a-121ff7fea988@dujemihanovic.xyz>
 <DEWJTWZ6Q51B.13HQYMDJZRFWA@matfyz.cz>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Autocrypt: addr=duje@dujemihanovic.xyz;
 keydata=
 mDMEZokhzhYJKwYBBAHaRw8BAQdAWJZ0hsI/ytTqHGFV8x6tzd5sB596cTeeDB4CQsTf+wC0KUR
 1amUgTWloYW5vdmnEhyA8ZHVqZS5taWhhbm92aWNAc2tvbGUuaHI+iJkEMBYKAEEWIQRt/0HWDf
 MUtbdrpjCtMZNSRY+tAwUCaJ5XkSMdIEFkZHJlc3MgYm91bmNlcyBhcyBvZiB+MzEvMDgvMjAyN
 QAKCRCtMZNSRY+tA/N/AQDth3Xl3wNcETvWPqqfYfyw4BFqbOD05A/W0/G0ZIjFzgD+PZVts3sN
 p5WuEwIxUrWxwavWJQBJwhXeWdru5ol82gmImQQTFgoAQRYhBG3/QdYN8xS1t2umMK0xk1JFj60
 DBQJmiSH/AhsDBQkJZgGABQsJCAcCAiICBhUKCQgLAgQWAgMBAh4HAheAAAoJEK0xk1JFj60Dlw
 8A/i4lPOL7NaYoYePDql8MaJaR9qoUi+D+HtD3t0Koi7ztAQCdizXbuqP3AVNxy5Gpb1ozgp9Xq
 h2MRcNmJCHA1YhWAbQoRHVqZSBNaWhhbm92acSHIDxkdWplQGR1amVtaWhhbm92aWMueHl6PoiZ
 BBMWCgBBFiEEbf9B1g3zFLW3a6YwrTGTUkWPrQMFAmaJIc4CGwMFCQlmAYAFCwkIBwICIgIGFQo
 JCAsCBBYCAwECHgcCF4AACgkQrTGTUkWPrQPUYAEAlVKitl0w6Wun+hC0JIf8bnc0TnrH8kcDxV
 f5lAF38fcA/j8RxR/p558NTFUyHZt2Sa5AqxVkaA4aJekySytWe1YGuDgEZokhzhIKKwYBBAGXV
 QEFAQEHQMRz0l4Dnk6Vl9YqC+ZGDDpr8SkFDyYOXqdBMGad3VccAwEIB4h+BBgWCgAmFiEEbf9B
 1g3zFLW3a6YwrTGTUkWPrQMFAmaJIc4CGwwFCQlmAYAACgkQrTGTUkWPrQMbkwD+K6jiXYYMRnV
 l/5dpL//wXB1cM72ceR9tXYweMXg1lfABAOugzMF0xypW9zwYAEWVNOAaPsqtEPPYfBY3IXxl6m
 sB
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Friday, 12 December 2025 22:17:12 Central European Standard Time Karel=20
Balej wrote:
> Duje Mihanovi=C4=87, 2025-12-12T15:55:48+01:00:
> > On 12/12/25 09:36, Karel Balej wrote:
> >> Not having any board schematics, I don't really know what exactly the
> >> regulator's purpose is. As I mentioned in the commit message, the
> >> communication with the chipset seems to work even if this is disabled
> >> (e. g. FW loads, networks can be scanned for,...) which doesn't seem
> >> like it should be the case if this was a main power supply for the bus,
> >> only actual connecting to networks doesn't work (gives
> >> CONNECT_ERR_ASSOC_ERR_TIMEOUT errors).
> >=20
> > To me, this strongly suggests that the regulator powers the WiFi
> > transmitter or at least a part of it (such as the RF amp).
>=20
> Something like this occurred to me too but would the chip even see the
> networks if this was the case? Although you are right that it could only
> power some specific part of the radio.

AFAIK you don't need the transmitter to capture and parse beacon frames. Of=
=20
course, connecting to networks is a completely different story.

Regards,
=2D-
Duje




