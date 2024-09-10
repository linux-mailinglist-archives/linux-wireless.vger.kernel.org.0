Return-Path: <linux-wireless+bounces-12739-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BAAB972CBC
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 11:01:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7DFA31C211ED
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 09:01:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7C32E18787A;
	Tue, 10 Sep 2024 09:01:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="jNV//GhI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A966C188000;
	Tue, 10 Sep 2024 09:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725958902; cv=none; b=hXgHR+9a6s99XGof1mVBXunlkWsI4Js02XBC1daUhDFnK5XxlOBZ1rpT4mUhYX2HkeU2Tq5jYOolmEIMOp3u+nRkxIGO3hTteooRWjV81ZK/KsOBM3rswuSlnHSlA+b9o4DZH7loS7uZynsRNfewQTRtr/wxEvAP4sd6oTrCm6M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725958902; c=relaxed/simple;
	bh=Qy6UsxT4blgwzf2T6dtyHj0WaL4CNqUKlG+Da/GhfuE=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Nzg49qWo8FdsZuHkBM32rtqnPDTe7YBgtxzwJkPLQqJdQ9VGGIVBqDt6K8Ke8EJXCYRDdrmdS576HsYZ2YviHZzBUkXN3lpXkOPdQaIcyq2uWOl0UIAbYQFE/7BDlsbxk+lNMloCiM0S2+hEzLAvyM7HqxGAbUg9HLO6Or1VCS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=jNV//GhI; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id CA3D160002;
	Tue, 10 Sep 2024 09:01:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725958898;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=uVBJ52BHHGO1H4inTwLVHqrESUBpxoDXZmwTQjk5738=;
	b=jNV//GhIipTpW4uGL6id2EZHmSkUpglW2NqpviNbWq2Gkn1kfcY0pN0oYv6kGk2r6cu7RT
	subZaLFVhqSFXZl0gHXxKv9SG+CVfTrOrBfdWe41frLXiLYXRpRwWTYH1wXAJZx5ilv1yt
	Dd2F+vQVQ+UPpuqbf0DAqyMhxsIwbR3UGEoUmc/sBBP3Ld7CtaWqx07SVpgwNZAyFe84u/
	CQgb87cyipl7FR7KQepoXQ06CvXKIvNHNYHVvz4JGCmlYPz1n5mBlL44IeB5GDWPZjcQ8Z
	IbZNPtGrbQL2PdneDXz5XyxJevfPvvCr1GIONQMUFydszTHi96juKaNe5Y/7jg==
Message-ID: <bf78598f-15e8-4deb-9230-5f4727197167@bootlin.com>
Date: Tue, 10 Sep 2024 11:01:36 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 7/9] wifi: wilc1000: Get chipid early
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240909193035.69823-1-marex@denx.de>
 <20240909193035.69823-7-marex@denx.de>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20240909193035.69823-7-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Marek,

On 9/9/24 21:29, Marek Vasut wrote:
> Export wilc_get_chipid() again and call it in driver probe to get
> wilc->chipid assigned early on. This is necessary to discern WILC
> 1000 from 3000 to disable WPA3/SAE on the later.

I like the general change (reading chipid early enough so we can enable/disable
NL80211_FEATURE_SAE accordingly before wiphy_register), but then there is no
point in making wilc_get_chipid private in wlan.c in patch 2, to make it public
to the module again in patch 7.

Thanks,
Alexis
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


