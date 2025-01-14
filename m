Return-Path: <linux-wireless+bounces-17485-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E562A1067C
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 13:21:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CE3773A5FB5
	for <lists+linux-wireless@lfdr.de>; Tue, 14 Jan 2025 12:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28036236ED6;
	Tue, 14 Jan 2025 12:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AdLWgM3m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F027A236EAE;
	Tue, 14 Jan 2025 12:21:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736857263; cv=none; b=NQ0eEo8BWbbtoy0EUJsAsh4oU/Cltdu1/Lx94D5LYhAHh+8M0IVCWLVqRNJwpggk3SDp/TvzYli+b2B9uJuDOCKC8DTPhqE5+6/cKcLyRcGMvGj3o47PpDN1Ms9a5mechoxWO2Wm1MlFzAxqYfNuNBQW2eFgl1pwjyAgJqIo3ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736857263; c=relaxed/simple;
	bh=UpmEPjGuMoTeKTvRtIlhEPisQ0/ZMZs2Vy07BTTPpjI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=FudOKwNC0QxwH7WA8+lKYpV3quAZOb3P8n9NwaewdMgkPTcJWDhzudeQuCpZ/MfYPL+bJujGCQVuOrdkbm+VDwKFyk6wD2QO3h+hKQxi4wTMfxtrdoyTvGJ5BXKq/W7aaqQGLq2uRqrHXxdOFFA+nYnyaj24sDggBzPOtl+dvi4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AdLWgM3m; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1F378C4CEDD;
	Tue, 14 Jan 2025 12:21:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1736857262;
	bh=UpmEPjGuMoTeKTvRtIlhEPisQ0/ZMZs2Vy07BTTPpjI=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=AdLWgM3mjaEHlxSJGJSnLtJpgA9ZwlZi4BtCg+KzpV+ECSEfVy37SusBRCxlaJyiK
	 aKgBHvZfrPHPqcyMz8vEbPe6YfAWbrIzPNo7jUbNzhd5yCtgxWcloTe9siH1wChaJt
	 0scAF5MD6dX5MQjeole8MLAMmRBAA/4W7HJxQ8kBrXFPBG8qBgE7lPYvuKTl7Qmfbm
	 DJQR76ZvVmRWey2cm3sOSGTuH/Z4HP3SwJhkT5FRL3TVqFr0N4fBPm2nd0uudRuFr8
	 RS9Qh7cHBheAY0yx15QTMcYeXFLF9wZc9EE0tX2qfMoefjL4RT+GjCZGL9NwQrdxpZ
	 oDubOzPiUBHyA==
From: Kalle Valo <kvalo@kernel.org>
To: Alexis =?utf-8?Q?Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>,  Claudiu Beznea
 <claudiu.beznea@tuxon.dev>,  Marek Vasut <marex@denx.de>,  Thomas
 Petazzoni <thomas.petazzoni@bootlin.com>,  linux-wireless@vger.kernel.org,
  linux-kernel@vger.kernel.org
Subject: Re: [PATCH] wifi: wilc1000: unregister wiphy only after netdev
 registration
References: <20250114-wilc1000_modprobe-v1-1-ad19d46f0c07@bootlin.com>
Date: Tue, 14 Jan 2025 14:20:58 +0200
In-Reply-To: <20250114-wilc1000_modprobe-v1-1-ad19d46f0c07@bootlin.com>
	("Alexis =?utf-8?Q?Lothor=C3=A9=22's?= message of "Tue, 14 Jan 2025
 11:45:34 +0100")
Message-ID: <87frllr3h1.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com> writes:

> wiphy_unregister/wiphy_free has been recently decoupled from
> wilc_netdev_cleanup to fix a faulty error path in sdio/spi probe
> functions. However this change introduced a new failure when simply
> loading then unloading the driver:
>   $ modprobe wilc1000-sdio; modprobe -r wilc1000-sdio
>   WARNING: CPU: 0 PID: 115 at net/wireless/core.c:1145 wiphy_unregister+0=
x904/0xc40 [cfg80211]
>   Modules linked in: wilc1000_sdio(-) wilc1000 cfg80211 bluetooth ecdh_ge=
neric ecc
>   CPU: 0 UID: 0 PID: 115 Comm: modprobe Not tainted 6.13.0-rc6+ #45
>   Hardware name: Atmel SAMA5
>   Call trace:
>    unwind_backtrace from show_stack+0x18/0x1c
>    show_stack from dump_stack_lvl+0x44/0x70
>    dump_stack_lvl from __warn+0x118/0x27c
>    __warn from warn_slowpath_fmt+0xcc/0x140
>    warn_slowpath_fmt from wiphy_unregister+0x904/0xc40 [cfg80211]
>    wiphy_unregister [cfg80211] from wilc_sdio_remove+0xb0/0x15c [wilc1000=
_sdio]
>    wilc_sdio_remove [wilc1000_sdio] from sdio_bus_remove+0x104/0x3f0
>    sdio_bus_remove from device_release_driver_internal+0x424/0x5dc
>    device_release_driver_internal from driver_detach+0x120/0x224
>    driver_detach from bus_remove_driver+0x17c/0x314
>    bus_remove_driver from sys_delete_module+0x310/0x46c
>    sys_delete_module from ret_fast_syscall+0x0/0x1c
>   Exception stack(0xd0acbfa8 to 0xd0acbff0)
>   bfa0:                   0044b210 0044b210 0044b24c 00000800 00000000 00=
000000
>   bfc0: 0044b210 0044b210 00000000 00000081 00000000 0044b210 00000000 00=
000000
>   bfe0: 00448e24 b6af99c4 0043ea0d aea2e12c
>   irq event stamp: 0
>   hardirqs last  enabled at (0): [<00000000>] 0x0
>   hardirqs last disabled at (0): [<c01588f0>] copy_process+0x1c4c/0x7bec
>   softirqs last  enabled at (0): [<c0158944>] copy_process+0x1ca0/0x7bec
>   softirqs last disabled at (0): [<00000000>] 0x0
>
> The warning is triggered by the fact that there is still a
> wireless_device linked to the wiphy we are unregistering, due to
> wiphy_unregister now being called after net device unregister (performed
> in wilc_netdev_cleanup). Fix this warning by moving wiphy_unregister
> after wilc_netdev_cleanup is nominal paths (ie: driver removal).
> wilc_netdev_cleanup ordering is left untouched in error paths in probe
> function because net device is not registered in those paths (so the
> warning can not trigger), yet the wiphy can still be registered, and we
> still some cleanup steps from wilc_netdev_cleanup.
>
> Signed-off-by: Alexis Lothor=C3=A9 <alexis.lothore@bootlin.com>
> ---
> I clearly overlooked this simple scenario/misunderstood expected
> unregistration order when fixing some spi probe error path, my bad (see
> commit 89a7616e1715 ("ARM: dts: at91-sama5d27_wlsom1: update bluetooth
> chip description") in wireless-next)

No worries, bugs are business as usual.

> @Kalle: 89a7616e1715 (the faulty commit) is only in wireless-next for
> now IIUC, so I did not provide any Fixes: tag to prevent any faulty SHA1
> if those commits end up being picked in stable tree (however, the faulty
> commit _has_ a Fixes tag). Please let me know if we should proceed
> differently.

Hmm, I don't really follow you here. I feel that always adding the Fixes
tag is the safest option, that way it's clear for everyone what commit
we are fixing. So if it's ok for you, I would like to add the Fixes tag
but I can't find commit 89a7616e1715 anywhere.

--=20
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatc=
hes

