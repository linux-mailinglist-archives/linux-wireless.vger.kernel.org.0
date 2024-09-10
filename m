Return-Path: <linux-wireless+bounces-12745-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 90039972F0D
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 11:48:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C962AB27461
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 09:48:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C9EA190472;
	Tue, 10 Sep 2024 09:47:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="Ktb7iIAH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD65B190068;
	Tue, 10 Sep 2024 09:47:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725961671; cv=none; b=c4F85kKVqX4IFNvFbgHr128DhDDX76AbNGim6qkjJ4kZ+JuQQFqOxY72IDfgJHT90ME9R0oiwwiPe/b51Y5DZrA2HXp/XOT2hTTv1Cqx4fnDwSuRWNb90Yfei9dSIW06QY9SWiw+abhyzVwWDbQqYlD+cj6mK45kbGhqP4G2K7E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725961671; c=relaxed/simple;
	bh=G4YudVrdOjx9owGb6rdcvz1OsnRegA9KY5FIKmTSEQI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=dWSdjJhFPU1gg/eTVPXGeMIQj9bcwok9jmw62nBq9hNmU99IKVBzY9i2dqJZpu1FJ1Q2SMVH2kBn+ND8Wke+9sxbAXIWWq+gEYZh3zATdHR3sQ+oxXsHr6iR4fZVE12jk+apHOxT0ce/KS2XEBFaBygHx6RJV6zuTNHM3aPIEcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=Ktb7iIAH; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 3649C2000D;
	Tue, 10 Sep 2024 09:47:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725961667;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SaZmHtOo0cYiFPDYgxveQkpjWK/uG6Kmxul2xqwIke0=;
	b=Ktb7iIAHe7/xPPrBYj2KWVmRkCURz9ib9DZPYEnCL+1RlbfZ8/MvSjXMCUwgpMLgYIjHlh
	z9eJqVzsZPrrVjd0yVozVjLuzYXgPBAGRsTZ37HoIMC1LyXiCIbSHGPeYPZOI7f1lZOANh
	Ql6aWPenNB2GIm17EqpAKBLRHo6eCYnY75Qz69TE2cSPaCNvXcb2VMa02fzR3o41NYTUUY
	UgjW+qJT7q8sYhDh5PiPdR/o211jNU5aGHe6jSE7HbDUUJAAvPXXbQ2rA/17RuZKweGxtK
	Gjo+10xnnxmdwNnF+TuFImO0KY/9m4NvXHNvLb1HQSqxf5Y2J0bVB5anzMqg/Q==
Message-ID: <9602d2a7-8397-425a-b567-bc06422d89ec@bootlin.com>
Date: Tue, 10 Sep 2024 11:47:45 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 6/9] wifi: wilc1000: Remove cmd53_buf() allocation
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
 <20240909193035.69823-6-marex@denx.de>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20240909193035.69823-6-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 9/9/24 21:29, Marek Vasut wrote:
> The cmd53_buf is a 4 byte buffer, embed it into the struct wilc_sdio.

Is this change really desirable ? I mean, looking at git log, it looks like this
kzalloc is voluntary, for usage with DMA (see [1] as initial fix and [2] as the
final patch which has landed in the driver)

[1]
https://patchwork.kernel.org/project/linux-wireless/patch/20220728152037.386543-1-michael@walle.cc/
[2] https://lore.kernel.org/all/20220809075749.62752-1-ajay.kathat@microchip.com/

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


