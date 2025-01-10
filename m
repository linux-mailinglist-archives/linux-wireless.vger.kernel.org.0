Return-Path: <linux-wireless+bounces-17320-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 110A1A0911A
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 13:50:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DC1BD3A04BA
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jan 2025 12:49:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDD3620B7FA;
	Fri, 10 Jan 2025 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UHjq3gBt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C82204F85;
	Fri, 10 Jan 2025 12:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736513394; cv=none; b=Fh2juQ3YeFyJZT8Rebahrq6sqDMMc12KgH6DofXrYRLbQr2JT02xP/Kvg1NQE3VfMNBLweEgOfdHcBtFZeaR9TG5udwN5pQcsuiNP1sTx3V2U/zYIP0ADWYtsKEV2TCLmlBTdgyYcN8qmraV8WzsM4SxxDaAc4rSglVrC5WrOWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736513394; c=relaxed/simple;
	bh=KjIdljMmqLEQ/iQHk2fBtH1ZK71nswsA4ZSjxGY4/+A=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=FoRc5m2xr0eRHLrkZxTjGsKm9J+LSX/cBtwwFilDz2s5MX8QdeV4Alqiu1TrVVGChkA46/s277ytslkLouRNTU4qXxrRvYRqDbbDPnMwP7mVY5D7lq1VkgbmN3OvOTkIXob3uHZV3MqT8LxseNVKZYphhfSelf4Hc/bUkDan8hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UHjq3gBt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EFEABC4CED6;
	Fri, 10 Jan 2025 12:49:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736513394;
	bh=KjIdljMmqLEQ/iQHk2fBtH1ZK71nswsA4ZSjxGY4/+A=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=UHjq3gBtmJJ6UOShyueFhjd8rrE0wVlHzxKRif88SmwV6aGhyvrMv1kmb1CjI/Dpg
	 RoCwDaDRmun1dsTN43dF0G8rM8G6IpbgOkeA727rdutmJdadmizXq6r/CF3GhFi94E
	 T2VyYZ3CAHU9NKUexFxiEYcQdc4imUwiRyz0uI4HrwHeoYIH73pYJIIrDkYm52Ig3t
	 2I9RK6hbDXaD3fQ0/PF7zoExMMl+QA9KH/C19KVPUH7AneD9ynzjXvY2giUoWW28WP
	 kLXJzi2a4aoEnZ72zzWjFS9B/+oWQlAMDFC3Zbg9Ht0QTcLLj157rye6A8fjFhj67s
	 nOH9B/4nO8BuQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH wireless] wifi: wilc1000: unregister wiphy only if it has
 been registered
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20241223-wilc_fix_probe_error_path-v1-1-91fa7bd8e5b6@bootlin.com>
References: <20241223-wilc_fix_probe_error_path-v1-1-91fa7bd8e5b6@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Marek Vasut <marex@denx.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?q?Al?=
	=?utf-8?q?exis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173651339102.72755.4201371086689261159.kvalo@kernel.org>
Date: Fri, 10 Jan 2025 12:49:52 +0000 (UTC)

Alexis Lothoré <alexis.lothore@bootlin.com> wrote:

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
>  wiphy_unregister [cfg80211] from wilc_netdev_cleanup+0x380/0x494 [wilc1000]
>  wilc_netdev_cleanup [wilc1000] from wilc_bus_probe+0x360/0x834 [wilc1000_spi]
>  wilc_bus_probe [wilc1000_spi] from spi_probe+0x15c/0x1d4
>  spi_probe from really_probe+0x270/0xb2c
>  really_probe from __driver_probe_device+0x1dc/0x4e8
>  __driver_probe_device from driver_probe_device+0x5c/0x140
>  driver_probe_device from __driver_attach+0x220/0x540
>  __driver_attach from bus_for_each_dev+0x13c/0x1a8
>  bus_for_each_dev from bus_add_driver+0x2a0/0x6a4
>  bus_add_driver from driver_register+0x27c/0x51c
>  driver_register from do_one_initcall+0xf8/0x564
>  do_one_initcall from do_init_module+0x2e4/0x82c
>  do_init_module from load_module+0x59a0/0x70c4
>  load_module from init_module_from_file+0x100/0x148
>  init_module_from_file from sys_finit_module+0x2fc/0x924
>  sys_finit_module from ret_fast_syscall+0x0/0x1c
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
> Reviewed-by: Marek Vasut <marex@denx.de>

Patch applied to wireless-next.git, thanks.

1be94490b6b8 wifi: wilc1000: unregister wiphy only if it has been registered

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241223-wilc_fix_probe_error_path-v1-1-91fa7bd8e5b6@bootlin.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


