Return-Path: <linux-wireless+bounces-25098-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 07B48AFEB33
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 16:07:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB7051C845CC
	for <lists+linux-wireless@lfdr.de>; Wed,  9 Jul 2025 14:03:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 838C32E8DE9;
	Wed,  9 Jul 2025 13:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="KZZ5YRcI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8BB32E613A;
	Wed,  9 Jul 2025 13:58:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752069493; cv=none; b=oEEV6gYoWlzDs7AMbxQtHsJWaRNhWVNn+6OdTh7OyPMLADw7o3f3Cltoq0fZVPIJeTBaUUsAMyvyMAe5elk61YawreVUkJXObuay7By+2LBqMb9hyac29wc6p2EwXZ0tGzK2Cpuccxh1ADDiny943mOnDNVfgzO+Qq3CqVikPg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752069493; c=relaxed/simple;
	bh=NVvIf7BA+8Ypu2l7BcQ/wzXzv6n0iOiBv4S0JuQ6nhI=;
	h=Mime-Version:Content-Type:Date:Message-Id:Subject:From:To:
	 References:In-Reply-To; b=c52unOMaM+b1wwZM/zl+tDJOVRAUk/V3RMmRYQ3c1MV7ybdaf8FQ1ciWAQFkE8Ya7Wixa49I5NiWx3h+Sk698nnREuaLuKLcODAME0r7Y8/qIamhUSXTOa8gPtU1HIbhFV3fNDefWTcFxC48RiHPbXdRXnCiOE2B2upjFWu9fhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=KZZ5YRcI; arc=none smtp.client-ip=217.70.183.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 7597144304;
	Wed,  9 Jul 2025 13:58:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1752069483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NVvIf7BA+8Ypu2l7BcQ/wzXzv6n0iOiBv4S0JuQ6nhI=;
	b=KZZ5YRcI4rugggC3oNX8cQJ6CqQVVW/XdceOdkZpApDHWpZj0R0NTALPkSr5tk4KoXbnIF
	58Ip1dO1C+gLaMZPB35xSTfKsqt+emBF1UdCOWQ7e2tmitK3sMiuNdRmOkuyFBm6LF+r9A
	vPGTk/cbuuki1t1xEpbToabBWhMUhxag0c6AXBQd2SlmCdypCL/xOTzYj5GmGGvM57He/u
	XjNpRx4tClb3ADNQyz0ACcXQQlSlPBKbsrfLR8U8t6NpKSlonC2oB2YurSa+dmxLmrley2
	oGue34ZJ4uljePhq96XSrMMTtr9IPWPOdaG+gC2tx/ZBAroGpkqNcBBR162L5A==
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 09 Jul 2025 15:58:02 +0200
Message-Id: <DB7KSOGOXKMI.3357Z37QAUKQ7@bootlin.com>
Subject: Re: [PATCH 11/12] wifi: wilc1000: Use min() to improve code
From: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
To: "Qianfeng Rong" <rongqianfeng@vivo.com>, "Ajay Singh"
 <ajay.kathat@microchip.com>, "Claudiu Beznea" <claudiu.beznea@tuxon.dev>,
 "Kalle Valo" <kvalo@kernel.org>, "Marek Vasut" <marex@denx.de>, "open
 list:MICROCHIP WILC1000 WIFI DRIVER" <linux-wireless@vger.kernel.org>,
 "open list" <linux-kernel@vger.kernel.org>
X-Mailer: aerc 0.20.1-0-g2ecb8770224a-dirty
References: <20250709022210.304030-1-rongqianfeng@vivo.com>
 <20250709022210.304030-12-rongqianfeng@vivo.com>
In-Reply-To: <20250709022210.304030-12-rongqianfeng@vivo.com>
X-GND-State: clean
X-GND-Score: -100
X-GND-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefjeejgecutefuodetggdotefrodftvfcurfhrohhfihhlvgemucfitefpfffkpdcuggftfghnshhusghstghrihgsvgenuceurghilhhouhhtmecufedtudenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurhepggfgtgffkffuhffvofhfjgesthhqredtredtjeenucfhrhhomheptehlvgigihhsucfnohhthhhorhoruceorghlvgigihhsrdhlohhthhhorhgvsegsohhothhlihhnrdgtohhmqeenucggtffrrghtthgvrhhnpedtieektdegtdeijeehjedvvdffveeiueehfeekhffgjefhfeefiedvueelvdeuffenucffohhmrghinhepsghoohhtlhhinhdrtghomhenucfkphepvdgrtddvmeekgedvkeemhegvsgeimeduvddtudemrghfugeimeeffhgssgemrggutdekmeekfhelieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpedvrgdtvdemkeegvdekmeehvggsieemuddvtddumegrfhguieemfehfsggsmegrugdtkeemkehfleeipdhhvghloheplhhotggrlhhhohhsthdpmhgrihhlfhhrohhmpegrlhgvgihishdrlhhothhhohhrvgessghoohhtlhhinhdrtghomhdpnhgspghrtghpthhtohepjedprhgtphhtthhopehrohhnghhqihgrnhhfvghnghesvhhivhhordgtohhmpdhrtghpthhtoheprghjrgihrdhkrghthhgrthesmhhitghrohgthhhiphdrtghomhdprhgtphhtthhopegtlhgruhguihhur
 dgsvgiinhgvrgesthhugihonhdruggvvhdprhgtphhtthhopehkvhgrlhhosehkvghrnhgvlhdrohhrghdprhgtphhtthhopehmrghrvgigseguvghngidruggvpdhrtghpthhtoheplhhinhhugidqfihirhgvlhgvshhssehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheplhhinhhugidqkhgvrhhnvghlsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-GND-Sasl: alexis.lothore@bootlin.com

On Wed Jul 9, 2025 at 4:21 AM CEST, Qianfeng Rong wrote:
> Use min() to reduce the code and improve its readability.
>
> Signed-off-by: Qianfeng Rong <rongqianfeng@vivo.com>

Reviewed-by: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>

Thanks,

Alexis


--=20
Alexis Lothor=C3=A9, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


