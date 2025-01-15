Return-Path: <linux-wireless+bounces-17561-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A3CE6A128A3
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 17:25:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5D4741885B1A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Jan 2025 16:25:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 995571922F9;
	Wed, 15 Jan 2025 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OtESLIfp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D29A191F75;
	Wed, 15 Jan 2025 16:24:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736958295; cv=none; b=dPb4BXLJIUuV75xZOrbkR6B5D7f/cSKF/LcxQ+ZNnefNTaZZUfWbd/dBVvCdmlz03/g1yooTt15gNtRsqOAa9/e9qhipySzNBydgdGpCdoQ/Ai105jkWSO5xItF3qLLke7OPPrJgvpwHTrR+IXrfPnZD8uhjohWEPGzhWPbSaAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736958295; c=relaxed/simple;
	bh=afSNcLfMS0ew1AIgZhttDpHHZr821mh3JUeKVmsq8ZE=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=bg/yNDyXz/u89pOtmtn8u1o0RvMOkC5sVaKJQ9PE5vOOv6H82Zc2W9qbTPokz+PNIUjot5Emsw9m8fB+CBqDQf40TTfMfcboHwNnFRFw/atASHbeasjmpF0SasaY9ooKmKYye/nZE0cDC0o0BStmsfA/9Uw3DpxF6hJKsA/gGLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OtESLIfp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2DCCCC4CEE1;
	Wed, 15 Jan 2025 16:24:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736958294;
	bh=afSNcLfMS0ew1AIgZhttDpHHZr821mh3JUeKVmsq8ZE=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=OtESLIfpTvapyCg6YMv80LaVFJ3XPUogAcHMk0jzzv+4zA6MBwxC6+OaA+Qj8jxSq
	 KrR51zRU7XRZaqGA7qQkieAQyL0nVLOLhuyMzm9RbCeq5Xkf4DF51UsTXPA61NAeu8
	 TKnN0N4YwfoYEnBqIH/YV3ajnPDo+7Umf+YNGAHM/mRb+RQQgSV4LInwgUAIiIXcmz
	 mCv5ka2fvmFfZsAMKEfq3Nr8Qk2B/liS3PGnS1+UIN0uzelSgh7gkhM9NWx0pNRdBE
	 xBzY60ALwN2IDXgYoNAwlE82u5Rc8rZZKQU+OdIHSxQPQuqZLMjilY3J5yzACPt7it
	 ePGJ9ZYxSPaeQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: wifi: wilc1000: unregister wiphy only after netdev registration
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20250114-wilc1000_modprobe-v1-1-ad19d46f0c07@bootlin.com>
References: <20250114-wilc1000_modprobe-v1-1-ad19d46f0c07@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Marek Vasut <marex@denx.de>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?q?Al?=
	=?utf-8?q?exis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173695829158.512722.7214845701917001049.kvalo@kernel.org>
Date: Wed, 15 Jan 2025 16:24:52 +0000 (UTC)

Alexis Lothoré <alexis.lothore@bootlin.com> wrote:

> wiphy_unregister()/wiphy_free() has been recently decoupled from
> wilc_netdev_cleanup() to fix a faulty error path in sdio/spi probe
> functions. However this change introduced a new failure when simply
> loading then unloading the driver:
> 
>   $ modprobe wilc1000-sdio; modprobe -r wilc1000-sdio
>   WARNING: CPU: 0 PID: 115 at net/wireless/core.c:1145 wiphy_unregister+0x904/0xc40 [cfg80211]
>   Modules linked in: wilc1000_sdio(-) wilc1000 cfg80211 bluetooth ecdh_generic ecc
>   CPU: 0 UID: 0 PID: 115 Comm: modprobe Not tainted 6.13.0-rc6+ #45
>   Hardware name: Atmel SAMA5
>   Call trace:
>    unwind_backtrace from show_stack+0x18/0x1c
>    show_stack from dump_stack_lvl+0x44/0x70
>    dump_stack_lvl from __warn+0x118/0x27c
>    __warn from warn_slowpath_fmt+0xcc/0x140
>    warn_slowpath_fmt from wiphy_unregister+0x904/0xc40 [cfg80211]
>    wiphy_unregister [cfg80211] from wilc_sdio_remove+0xb0/0x15c [wilc1000_sdio]
>    wilc_sdio_remove [wilc1000_sdio] from sdio_bus_remove+0x104/0x3f0
>    sdio_bus_remove from device_release_driver_internal+0x424/0x5dc
>    device_release_driver_internal from driver_detach+0x120/0x224
>    driver_detach from bus_remove_driver+0x17c/0x314
>    bus_remove_driver from sys_delete_module+0x310/0x46c
>    sys_delete_module from ret_fast_syscall+0x0/0x1c
>   Exception stack(0xd0acbfa8 to 0xd0acbff0)
>   bfa0:                   0044b210 0044b210 0044b24c 00000800 00000000 00000000
>   bfc0: 0044b210 0044b210 00000000 00000081 00000000 0044b210 00000000 00000000
>   bfe0: 00448e24 b6af99c4 0043ea0d aea2e12c
>   irq event stamp: 0
>   hardirqs last  enabled at (0): [<00000000>] 0x0
>   hardirqs last disabled at (0): [<c01588f0>] copy_process+0x1c4c/0x7bec
>   softirqs last  enabled at (0): [<c0158944>] copy_process+0x1ca0/0x7bec
>   softirqs last disabled at (0): [<00000000>] 0x0
> 
> The warning is triggered by the fact that there is still a
> wireless_device linked to the wiphy we are unregistering, due to
> wiphy_unregister() now being called after net device unregister (performed
> in wilc_netdev_cleanup()). Fix this warning by moving wiphy_unregister()
> after wilc_netdev_cleanup() is nominal paths (ie: driver removal).
> wilc_netdev_cleanup() ordering is left untouched in error paths in probe
> function because net device is not registered in those paths (so the
> warning can not trigger), yet the wiphy can still be registered, and we
> still some cleanup steps from wilc_netdev_cleanup().
> 
> Fixes: 1be94490b6b8 ("wifi: wilc1000: unregister wiphy only if it has been registered")
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>

Patch applied to wireless-next.git, thanks.

208dea9107e8 wifi: wilc1000: unregister wiphy only after netdev registration

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20250114-wilc1000_modprobe-v1-1-ad19d46f0c07@bootlin.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


