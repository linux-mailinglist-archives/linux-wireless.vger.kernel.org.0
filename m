Return-Path: <linux-wireless+bounces-12134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CD329962263
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 10:40:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id F0C9EB23C42
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 08:40:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8E8C15AD9C;
	Wed, 28 Aug 2024 08:40:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="YvfKY8zJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay9-d.mail.gandi.net (relay9-d.mail.gandi.net [217.70.183.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899E48288F;
	Wed, 28 Aug 2024 08:40:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724834403; cv=none; b=cxFdTn4MncM4vLbgMaraHy7hkNIhpqI9gh3mA9OwtBojAie5Q3QDUlWtDSoxe3ppVixbUwXOUhT+IwQGP2AecjYBw9JY8Y8umqhge7OwUGJ9r1X/PiBkSTggOh2RfFdCdR+fFcmBcOIVlTXMCGQr4DMW4bmeziDC3e17OSwTBU8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724834403; c=relaxed/simple;
	bh=0HWRfDd54b3BuG2cpFuZ6yg3/1DHi4Ybs0PZ1T+lW4I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CR4FkRpEWrhgGKfZmyEzlV/FtTbnFngYQdXhPL0kGiGiQ77Td2TGcqh+vrP7MqkupFmOA2JktZMrnMqr99lOTaRLBqvD5mf8AhLAT9+1Ir5ok8csgW8VFAd9v13fLu56qaXN6IcPqS4NraFjWYygW4RKUAPxWchE4jKeMlW1prY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=YvfKY8zJ; arc=none smtp.client-ip=217.70.183.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 86532FF807;
	Wed, 28 Aug 2024 08:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724834398;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9up7nYUE/ukYG/OGlmxgbSAen/k79vZIafVGFfUrJxw=;
	b=YvfKY8zJz5jH0xMZ+nT1CKEokyf2Uk2CbMNpPd49TXCDJQk6KDt2jspQp6hwM2kS7P0fjV
	4YU5U2S9AGrepKntyUG/t43Bzz7zePQ5J8lEykewh/jIpa5y1XZ/RHEfbnmK2zc8k6RdmZ
	vD/PDpaxs7AvF45+I35iUf0ODaizY6rQrvNvrqFozRtFmB842OPQJ0Qp+JfVLP37rRA9jE
	2owUW+aWIUwMaz6+zbapZYXDrX7WAnnxgg7EOfK+jNsAqpzTeKVJM0ssLVehL7ffX5/40s
	NYX9k1CUzSKyb1RfiFxzGU5wcmM3Y/kowOqTgSz+p0DoWtPbA0ZEeDxXdv/THQ==
Message-ID: <e2130ebe-1c17-412a-a8ca-ac7c1f5b5bb4@bootlin.com>
Date: Wed, 28 Aug 2024 10:39:57 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/5] wifi: wilc1000: Fold wilc_get_chipid() into wlan.c
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
References: <20240827164042.53698-1-marex@denx.de>
 <20240827164042.53698-2-marex@denx.de>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20240827164042.53698-2-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 8/27/24 18:37, Marek Vasut wrote:
> Do not use wilc_get_chipid() outside of wlan.c . Instead, call
> wilc_get_chipid() right after the SDIO/SPI interface has been
> initialized to cache the device chipid, and then use the cached
> chipid throughout the driver. Make wilc_get_chipid() static and
> remove its prototype from wlan.h . Make wilc_get_chipid() return
> a proper return value instead of a chipid.
> 
> Signed-off-by: Marek Vasut <marex@denx.de>
> ---
> Cc: "David S. Miller" <davem@davemloft.net>
> Cc: Adham Abozaeid <adham.abozaeid@microchip.com>
> Cc: Ajay Singh <ajay.kathat@microchip.com>
> Cc: Alexis Lothoré <alexis.lothore@bootlin.com>
> Cc: Claudiu Beznea <claudiu.beznea@tuxon.dev>
> Cc: Conor Dooley <conor+dt@kernel.org>
> Cc: Eric Dumazet <edumazet@google.com>
> Cc: Jakub Kicinski <kuba@kernel.org>
> Cc: Kalle Valo <kvalo@kernel.org>
> Cc: Krzysztof Kozlowski <krzk+dt@kernel.org>
> Cc: Marek Vasut <marex@denx.de>
> Cc: Paolo Abeni <pabeni@redhat.com>
> Cc: Rob Herring <robh@kernel.org>
> Cc: devicetree@vger.kernel.org
> Cc: linux-wireless@vger.kernel.org
> Cc: netdev@vger.kernel.org

nit: The remaining wilc_getchipid() call in netdev.c should have been removed in
this very same commit (it is removed in a later patch in this series, but it
makes this commit depend on the last one).

Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


