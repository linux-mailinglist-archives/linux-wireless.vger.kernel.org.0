Return-Path: <linux-wireless+bounces-16740-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 56A439FB4B5
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 20:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CD532165B6D
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Dec 2024 19:35:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D81391AF0C2;
	Mon, 23 Dec 2024 19:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="IE68FGZf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.denx.de (mx.denx.de [89.58.32.78])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA85F28DA1;
	Mon, 23 Dec 2024 19:35:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=89.58.32.78
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734982518; cv=none; b=NPW4R0e6Xz/tad1Io05pKh0Cn82RG267ZsRByxRPwGyPFkwAChCnKduIqoGEPXU70FRRZzMghyulCBfdpZ9jFLqbYziojt+evpmUWpAsJhfgQNFU/VsjqLNzSsfgRCwX2+dLqGWFWYwFxV1HkZrfJHNbsFHeThobRswK7+WUe3o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734982518; c=relaxed/simple;
	bh=Tsn1m5ywEzXvBJ6UNgZ4dbd5ZmgJuAvlLtvIOx4S2S8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QYBGf+OEnOkmmVFN5R8TQakBFIxa6cXIlzldh4n8p8VGAotHOzfMLpwpZVbZEkP9GAJjb2aqj39UFQ6+z5rGCTuHIwuQXxNRemFRkUdlvNd82IAuXGSZUBfUD9QQio8XO0qNtjB9OOJO+Fi2WHT2bkYcGBJUPlf+VZ3OaCAtV7s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=IE68FGZf; arc=none smtp.client-ip=89.58.32.78
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 727D71048588C;
	Mon, 23 Dec 2024 20:35:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de; s=mx-20241105;
	t=1734982514;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Xm0Ik8769Z7PxV+QPZ/CDNASXKO2C+1xCfZ8ziHTxy8=;
	b=IE68FGZf4UMTwvoLQFfBK568CLW9HDck822WnpzASOUgLCManLKfXNiFPSy7De+Atpwrux
	klAS2dEVA+0FgEjMk9cjl73iMei8qyJHEANmtHLUfLoD3CRXpnlcMqbEE3PeoqFTTmu6EY
	u81rEaK1hBNQkmfBLdmNWHLa3EwufqAojfzq9Xb5EL9raG5m3jrDKn1nqYlK/yEXhoh2A0
	IRLZ7jjjGNzfGf5YDFBbVWjR7HDdQJtBtAf5DCpN0k2mP2WAMcWURZ6Fe8rdH8Ul3W2E2W
	K2sjUZ8Hcw5u1dkD9okS6gMsmRLrnWFSnqhs8gl083wMkQMcBLp0JcCwXdFEsg==
Message-ID: <81554a5e-5b86-4944-9565-4e2aed5fd0ef@denx.de>
Date: Mon, 23 Dec 2024 20:19:10 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless] wifi: wilc1000: unregister wiphy only if it has
 been registered
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20241223-wilc_fix_probe_error_path-v1-1-91fa7bd8e5b6@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <20241223-wilc_fix_probe_error_path-v1-1-91fa7bd8e5b6@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Last-TLS-Session-Version: TLSv1.3

On 12/23/24 4:46 PM, Alexis Lothoré wrote:
> There is a specific error path in probe functions in wilc drivers (both
> sdio and spi) which can lead to kernel panic, as this one for example
> when using SPI:
> 
> Unable to handle kernel paging request at virtual address 9f000000 when read
> [9f000000] *pgd=00000000
> Internal error: Oops: 5 [#1] ARM
> Modules linked in: wilc1000_spi(+) crc_itu_t crc7 wilc1000 cfg80211 bluetooth ecdh_generic ecc
> CPU: 0 UID: 0 PID: 106 Comm: modprobe Not tainted 6.13.0-rc3+ #22
> Hardware name: Atmel SAMA5
> PC is at wiphy_unregister+0x244/0xc40 [cfg80211]
> LR is at wiphy_unregister+0x1c0/0xc40 [cfg80211]
> [...]
>   wiphy_unregister [cfg80211] from wilc_netdev_cleanup+0x380/0x494 [wilc1000]
>   wilc_netdev_cleanup [wilc1000] from wilc_bus_probe+0x360/0x834 [wilc1000_spi]
>   wilc_bus_probe [wilc1000_spi] from spi_probe+0x15c/0x1d4
>   spi_probe from really_probe+0x270/0xb2c
>   really_probe from __driver_probe_device+0x1dc/0x4e8
>   __driver_probe_device from driver_probe_device+0x5c/0x140
>   driver_probe_device from __driver_attach+0x220/0x540
>   __driver_attach from bus_for_each_dev+0x13c/0x1a8
>   bus_for_each_dev from bus_add_driver+0x2a0/0x6a4
>   bus_add_driver from driver_register+0x27c/0x51c
>   driver_register from do_one_initcall+0xf8/0x564
>   do_one_initcall from do_init_module+0x2e4/0x82c
>   do_init_module from load_module+0x59a0/0x70c4
>   load_module from init_module_from_file+0x100/0x148
>   init_module_from_file from sys_finit_module+0x2fc/0x924
>   sys_finit_module from ret_fast_syscall+0x0/0x1c
> 
> The issue can easily be reproduced, for example by not wiring correctly
> a wilc device through SPI (and so, make it unresponsive to early SPI
> commands). It is due to a recent change decoupling wiphy allocation from
> wiphy registration, however wilc_netdev_cleanup has not been updated
> accordingly, letting it possibly call wiphy unregister on a wiphy which
> has never been registered.
> 
> Fix this crash by moving wiphy_unregister/wiphy_free out of
> wilc_netdev_cleanup, and by adjusting error paths in both drivers
> 
> Fixes: fbdf0c5248dc ("wifi: wilc1000: Register wiphy after reading out chipid")
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>
Nice find, thank you for fixing it.

Reviewed-by: Marek Vasut <marex@denx.de>

Thanks !

