Return-Path: <linux-wireless+bounces-13509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 78F2999026D
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 13:48:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4156328159A
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Oct 2024 11:48:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2729D15B56E;
	Fri,  4 Oct 2024 11:47:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="iY/jynM6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93354146A63;
	Fri,  4 Oct 2024 11:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728042423; cv=none; b=Q1yZccx4p6E3J5B3MbA007xjBpdZQ2aA4tGS4frotihj7oTLm9qDMJj8FA4y3hMFf4nYb87taBgSdxscEZZMLrLTwoY0sp1gTG+OG5zTTpnLCpofhWjVSw8vUj3qKAim9dApvLYPyfiaqgkPk7PrXTcfhynxRQenKxDg+OHqJmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728042423; c=relaxed/simple;
	bh=fNomv74+MMs3OOhe1I+2XGyxeAWZaBagLDg4xS45uvo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=JgXuzPgLi0q97Jd4Q4j7gT+5kFapOPoOdgb/XvgeUjY28lYQEeXAXo6HtTr3Pk7JFc4eSpoKgR07X8pOYw9ldQDpPdb7xebsLO/IYO83VbQHwD62jwaemOIcTgfGrs8bRpPWqUYmtYw0w/8M6a9GNayaZXRXWbMlFZwX1YKghbU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=iY/jynM6; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 3390088B63;
	Fri,  4 Oct 2024 13:46:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1728042420;
	bh=3Ja09wpbBxa1NtiRC6tfKDerDwaf10x8kXLxoP0+/xI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=iY/jynM6Zj230DcG0ZOi+BSbGYCBSs6wS3U1ZYKfaRrbA7uVco7y2NGHH303MRDuL
	 LMaUam8rVgaxMpO5EBVV3b5BFCYj7qnqFcLqJAU0X2ANJPleqNYQg6bOLoc1tyg2cS
	 05eMXZ351YQfvEIYAt+wAuogPK+9rH5VlIgRurv7yZFLzeWWb0tOeGecsDytBbCriU
	 /nP1jOM/Z0gz5aitsttxDfDKlZ8H0rvuCWcJXZdIhEMM0z8t6kSMfv/au6EJ0GtWgi
	 Ne74ZbvFM7L3R5+kbTgf47T7GXElTE5vX2G9A5YkEOXqtyqIQrf3e29AdJHfg2t6Qz
	 XJQL2g0b1gNQA==
Message-ID: <31c7dd86-ff8f-4745-8d33-07f8f8037d44@denx.de>
Date: Fri, 4 Oct 2024 13:42:03 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 7/7] wifi: wilc1000: Add WILC3000 support
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 linux-wireless@vger.kernel.org
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20241003111529.41232-1-marex@denx.de>
 <20241003111529.41232-7-marex@denx.de>
 <206e5a5a-25ad-43d1-b8d3-53ecbfecb755@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <206e5a5a-25ad-43d1-b8d3-53ecbfecb755@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 10/4/24 10:46 AM, Alexis Lothoré wrote:
> On 10/3/24 13:14, Marek Vasut wrote:
>> From: Ajay Singh <ajay.kathat@microchip.com>
>>
>> Add support for the WILC3000 chip. The chip is similar to WILC1000,
>> except that the register layout is slightly different and it does
>> not support WPA3/SAE.
>>
>> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> 
> Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> And for the basic feature set (basic sta scenario, basic ap scenario):
> 
> Tested-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> Tested-on: WILC1000SD 07 SDIO WILC_WIFI_FW_REL_16_1_2
> Tested-on: WILC1000SD 07 SPI WILC_WIFI_FW_REL_16_1_2
> Tested-on: WILC3000 A SDIO WILC_WIFI_FW_REL_16_1_1
> Tested-on: WILC3000 A SPI WILC_WIFI_FW_REL_16_1_1
Thank you

