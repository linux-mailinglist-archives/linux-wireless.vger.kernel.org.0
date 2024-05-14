Return-Path: <linux-wireless+bounces-7638-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 114138C569B
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 15:10:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A48EEB21AB0
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 13:10:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B30991422D6;
	Tue, 14 May 2024 13:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="ABow6UCU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 548EA1411DB;
	Tue, 14 May 2024 13:09:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715692174; cv=none; b=TS0Pf91AeGNvQnxOj18J1+tqUG9NM0sVLvL0R3/3HtqFnsJYkfCv7G49e4H7GGFVuosNvCt7zHtwq5tRC+mwXVrksIWY/vWvFG87KO2d86fqZiOd+nkWtzMGsr8EjDFgkrBVMPLusfIbClZO911NBFR6Ukz9y0doe3XMopgstxU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715692174; c=relaxed/simple;
	bh=WQXVJuUter3IICEpN6ZuyqFUO2+Lf+4sBc8m7CrrHX4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DfP/tlyKV4rj59YLfE7zj2tnhu+MvuhHBmN8cw3B2yn5RJxPeQKt94Ps65iMDAw/nQrrKq773dMbKmTMNtcwPaMUQGdJ8Hlk192ZEuVCmb1RpbnvL2ss6zDoMFNLt1n/WnN2EHruKDJyA6wAxHoKJ8h1kWA1wYN2bEYEsYJUYSw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=ABow6UCU; arc=none smtp.client-ip=217.70.183.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 00FA460002;
	Tue, 14 May 2024 13:09:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1715692170;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8DZyeKSJbCNjlJ0OhBvh+xCLA4DX/WKG0IiWWke/Gaw=;
	b=ABow6UCUzEaSrG6RDTBUxcVxPwxR3TBoKZBWQgHbrrBf6a3kbHe9gPb5iGw6/3gpXsrupF
	Tj0FOKo7c5YdKngbhBP7+NpnowjMBUefBZ4zWtd5zyj9mhbvItswDc6nQWCvzfS9rje85Y
	HJ+hXCmz6v0xkKXDxmrngU+/6kfmUw9r9fMxp5pbIRPu4lJ5urFMuXzh6jaP7mNngnTU06
	8nvwaasRbPmqryaxUj3kJ5uvlO0VA/goUP9/bWD6+ypJgMiEhh7cD2BVfh/13sjm+7kxuQ
	EeVt2XYbKcRzK6uKUCyJx4xUtJZKMbjqsUvmc1mnBIs/b1uwWx4ayo6VO1k/0A==
Message-ID: <3f53441d-b8b0-448a-aaaa-fb7e64aa86c0@bootlin.com>
Date: Tue, 14 May 2024 15:09:29 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/6] wifi: wilc1000: set net device registration as last
 step during interface creation
To: Kalle Valo <kvalo@kernel.org>
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20240417-mac_addr_at_probe-v1-1-67d6c9b3bc2b@bootlin.com>
 <171569074600.2017278.13914732662896657638.kvalo@kernel.org>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <171569074600.2017278.13914732662896657638.kvalo@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

Hello Kalle,

On 5/14/24 14:45, Kalle Valo wrote:
> Alexis Lothoré <alexis.lothore@bootlin.com> wrote:
> 
>> net device registration is currently done in wilc_netdev_ifc_init but
>> other initialization operations are still done after this registration.
>> Since net device is assumed to be usable right after registration, it
>> should be the very last step of initialization.
>>
>> Move netdev registration at the very end of wilc_netdev_ifc_init to let
>> this function completely initialize netdevice before registering it.
>>
>> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> I see errors:
> 
> ERROR: modpost: "wilc_load_mac_from_nv" [drivers/net/wireless/microchip/wilc1000/wilc1000-sdio.ko] undefined!
> ERROR: modpost: "wilc_netdev_ifc_init" [drivers/net/wireless/microchip/wilc1000/wilc1000-sdio.ko] undefined!
> ERROR: modpost: "wilc_load_mac_from_nv" [drivers/net/wireless/microchip/wilc1000/wilc1000-spi.ko] undefined!
> ERROR: modpost: "wilc_netdev_ifc_init" [drivers/net/wireless/microchip/wilc1000/wilc1000-spi.ko] undefined!
> make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
> make[1]: *** [/home/kvalo/projects/personal/wireless-drivers/src/wireless-next/Makefile:1871: modpost] Error 2
> make: *** [Makefile:240: __sub-make] Error 2
> 
> 6 patches set to Changes Requested.
> 
> 13633102 [1/6] wifi: wilc1000: set net device registration as last step during interface creation
> 13633103 [2/6] wifi: wilc1000: register net device only after bus being fully initialized
> 13633104 [3/6] wifi: wilc1000: set wilc_set_mac_address parameter as const
> 13633105 [4/6] wifi: wilc1000: add function to read mac address from eFuse
> 13633106 [5/6] wifi: wilc1000: make sdio deinit function really deinit the sdio card
> 13633107 [6/6] wifi: wilc1000: read MAC address from fuse at probe

Shame on me, I missed those basic errors since I worked with drivers as built-in
instead of modules. I'll update my workflow and send a v2.

Thanks,

Alexis
-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


