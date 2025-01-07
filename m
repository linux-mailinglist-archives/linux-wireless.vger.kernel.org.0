Return-Path: <linux-wireless+bounces-17151-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 79A2EA04424
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 16:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id ABF097A144D
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 15:22:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D99A71F2C44;
	Tue,  7 Jan 2025 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9725PD2"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B136F1E1041;
	Tue,  7 Jan 2025 15:22:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736263347; cv=none; b=dqvViYb9QIRfqB9Dw/SlNZOxQP62mB1lPu2RewFJBZi5dgrGHTD+0N5VUpctX7dIX4Gr2y7/aN6eFAh53Mp/FPU+/GtVe3v59JD5Tzb2bO7v0AEeYk6gNcwjfPMscD4LvaSI7tRK8gwQp9EcibavWa0Je9Qx3izuT/e+a1RvC5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736263347; c=relaxed/simple;
	bh=nvMBc9afwU5AP/J5Qb5ULoGNFaGxP7txNGHvynI+1tM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=JkU34QGGeazjSUiP4FXi8UoGVTvatzkLcNI/PEv9c2J4Cqoy0srU6L/ebEig8DhwaOOE9hE8jGwGu1Ij/LhJGWgUq+ULV8eZ913Wx4Em5V7Ax+GuM8wOEokY3QRyxmV3lhifx84WHk1gIWIS/ExNEPSnJyO9tIeZ2iPb1BoT62A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9725PD2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C16EDC4CEDD;
	Tue,  7 Jan 2025 15:22:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736263347;
	bh=nvMBc9afwU5AP/J5Qb5ULoGNFaGxP7txNGHvynI+1tM=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=Q9725PD2cBcoNoQC+73lxZcSRWElxXUUGY4fNEhSXXOVuNAcGRbY8mjMOjTWozaih
	 stCJ8M1Xzc+ezs5tBlIsk6ryWhITfziW4Qgp8oYKn8myZMpsKgBePfJlZg6AYarJqA
	 Ph4z/JBc8BUCqUPSUv7l/45OLSygad6Zcjd9DXRu5y0AFUmN23FIpceZQieCiELov2
	 MH1ltfVJ6Q5sYl/yU2Z0JF+wvzXtLGG1YQlXTC1tBqO65X+4yZz3NQeJUfAk3L4R9F
	 JyJPFpmY/OuZKK8xy0QKwSj+nwJ0LeOq3E23GGuF+AXsozVdOpWhZ1P87neO0rOt9D
	 VJGz72nQeMZeA==
From: Kalle Valo <kvalo@kernel.org>
To: Marek Vasut <marex@denx.de>
Cc: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>,  Ajay
 Singh
 <ajay.kathat@microchip.com>,  Claudiu Beznea <claudiu.beznea@tuxon.dev>,
  Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
  linux-wireless@vger.kernel.org,  linux-kernel@vger.kernel.org
Subject: Re: [PATCH wireless] wifi: wilc1000: unregister wiphy only if it
 has been registered
References: <20241223-wilc_fix_probe_error_path-v1-1-91fa7bd8e5b6@bootlin.com>
	<81554a5e-5b86-4944-9565-4e2aed5fd0ef@denx.de>
Date: Tue, 07 Jan 2025 17:22:23 +0200
In-Reply-To: <81554a5e-5b86-4944-9565-4e2aed5fd0ef@denx.de> (Marek Vasut's
	message of "Mon, 23 Dec 2024 20:19:10 +0100")
Message-ID: <87sepur6mo.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Marek Vasut <marex@denx.de> writes:

> On 12/23/24 4:46 PM, Alexis Lothor=C3=A9 wrote:
>
>> There is a specific error path in probe functions in wilc drivers (both
>> sdio and spi) which can lead to kernel panic, as this one for example
>> when using SPI:
>> Unable to handle kernel paging request at virtual address 9f000000
>> when read
>> [9f000000] *pgd=3D00000000
>> Internal error: Oops: 5 [#1] ARM
>> Modules linked in: wilc1000_spi(+) crc_itu_t crc7 wilc1000 cfg80211 blue=
tooth ecdh_generic ecc
>> CPU: 0 UID: 0 PID: 106 Comm: modprobe Not tainted 6.13.0-rc3+ #22
>> Hardware name: Atmel SAMA5
>> PC is at wiphy_unregister+0x244/0xc40 [cfg80211]
>> LR is at wiphy_unregister+0x1c0/0xc40 [cfg80211]
>> [...]
>>   wiphy_unregister [cfg80211] from wilc_netdev_cleanup+0x380/0x494 [wilc=
1000]
>>   wilc_netdev_cleanup [wilc1000] from wilc_bus_probe+0x360/0x834 [wilc10=
00_spi]
>>   wilc_bus_probe [wilc1000_spi] from spi_probe+0x15c/0x1d4
>>   spi_probe from really_probe+0x270/0xb2c
>>   really_probe from __driver_probe_device+0x1dc/0x4e8
>>   __driver_probe_device from driver_probe_device+0x5c/0x140
>>   driver_probe_device from __driver_attach+0x220/0x540
>>   __driver_attach from bus_for_each_dev+0x13c/0x1a8
>>   bus_for_each_dev from bus_add_driver+0x2a0/0x6a4
>>   bus_add_driver from driver_register+0x27c/0x51c
>>   driver_register from do_one_initcall+0xf8/0x564
>>   do_one_initcall from do_init_module+0x2e4/0x82c
>>   do_init_module from load_module+0x59a0/0x70c4
>>   load_module from init_module_from_file+0x100/0x148
>>   init_module_from_file from sys_finit_module+0x2fc/0x924
>>   sys_finit_module from ret_fast_syscall+0x0/0x1c
>> The issue can easily be reproduced, for example by not wiring
>> correctly
>> a wilc device through SPI (and so, make it unresponsive to early SPI
>> commands). It is due to a recent change decoupling wiphy allocation from
>> wiphy registration, however wilc_netdev_cleanup has not been updated
>> accordingly, letting it possibly call wiphy unregister on a wiphy which
>> has never been registered.
>> Fix this crash by moving wiphy_unregister/wiphy_free out of
>> wilc_netdev_cleanup, and by adjusting error paths in both drivers
>> Fixes: fbdf0c5248dc ("wifi: wilc1000: Register wiphy after reading
>> out chipid")
>> Signed-off-by: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>
> Nice find, thank you for fixing it.
>
> Reviewed-by: Marek Vasut <marex@denx.de>

We are quite late in the cycle so I think I'll queue this to
wireless-next for v6.14.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

