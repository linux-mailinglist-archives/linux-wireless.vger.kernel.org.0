Return-Path: <linux-wireless+bounces-12759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 22405973727
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 14:25:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C09231F254BE
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 12:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1C9419004E;
	Tue, 10 Sep 2024 12:25:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="eaiUbQ1C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [217.70.183.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FC91E493;
	Tue, 10 Sep 2024 12:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725971141; cv=none; b=CUzdDYNkjKZ9dZIU4u6HUAZ6RYRqFUa+koVmNfzdBfj5BYe+RkJHTe9g2QN6bpyhCr4sT4us4bclGi98bhvJf1ndMpjY3wBXff6td3uDIEFLt/dqozCpBJ9SYHCnyysiNhlvKdQzPfn1An0YkWer2Z2UJtQly9w7NIpEKXTjX88=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725971141; c=relaxed/simple;
	bh=OMDSp5/Scq6iGEBLf6P33nmQuXTYma1nRerLRIhRCu0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=erTi0JJLeLrsNSaIBEm06XKi8HJMGaBFjAUEO7Aii3Nk1BWh/I5noZHTYbI7Czmivq4XbEmJuolcHPuyeFj6t938ShOmH36xjG1/Jy1g/Q+RvuF3htA91vE2OlnixllwGXA3nZfug7eA1ecb13RXK8dZCVcYW0GuE3oliWOoBaM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=eaiUbQ1C; arc=none smtp.client-ip=217.70.183.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id A8C6DE0003;
	Tue, 10 Sep 2024 12:25:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1725971130;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=d+7aZSAX39l5tdqwbylF7EfYeuJBz04pb9137b2agq0=;
	b=eaiUbQ1CClsBDHx3q7LpzGyghHC3cKwfdsdBYasHfAc1aM89VC+pKbHnk9oSdYCaR2Xkdd
	+R+dfE8d/CYsrVxCjShCKYWcPAYf/puARsiXzUfFCqB69UvKnLCwDBy4CZY1D4nR2xWjeH
	ChshwGvdyo2eQrKyOJsz1/fhe1+XkOji7eu24bHJhbpsYK5ffZEuICCrnYCPrwn/cUaVRw
	Oxy4UTAHOaMq7HmvJUyrZfJvvvhkFnLWIZRUKZuKXi43oijar5fl7BxngMUuhWrgMeV9pL
	/pz4FepFSS6LMBMl5SxGQXB5exX4/OGgpIkS6xDLFpIvTJYMSEqg5ZV7VCr6Mg==
Message-ID: <02f856ea-3d5d-48e5-a0f7-fdac2de30ddd@bootlin.com>
Date: Tue, 10 Sep 2024 14:25:29 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 5/9] wifi: wilc1000: Fold wilc_create_wiphy() into
 cfg80211.c
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
 <20240909193035.69823-5-marex@denx.de>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <20240909193035.69823-5-marex@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 9/9/24 21:29, Marek Vasut wrote:
> The wilc_create_wiphy() is not used outside of cfg80211.c .
> Make the function static and remove its entry from cfg80211.h
> 
> Signed-off-by: Marek Vasut <marex@denx.de>

It looks like I messed up my r-b on previous email, so in case it could have
confused some scripts or automation:

Reviewed-by: Alexis Lothoré <alexis.lothore@bootlin.com>

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


