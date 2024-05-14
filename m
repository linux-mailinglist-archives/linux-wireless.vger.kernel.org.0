Return-Path: <linux-wireless+bounces-7636-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8266D8C5626
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 14:46:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 96D6D284DA7
	for <lists+linux-wireless@lfdr.de>; Tue, 14 May 2024 12:45:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2A24E55C08;
	Tue, 14 May 2024 12:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OhlRL33X"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F262B47F5D;
	Tue, 14 May 2024 12:45:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715690750; cv=none; b=Zw3njXyTG56/3USY2WaUqN7AFUXhY01M6Bcw46pfarIx78Fenl5EzmlhdXZSGcn5ZRLqy6HrSfZwOnZPTLWkzLDGqGC1XTDBvKZOzvH5+0vYlVl+kmLKjYwDnmt9ZNXQpeHQvMEXZGGCQSVgpR5urfh7chg9gBVDmFWAYSCyUnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715690750; c=relaxed/simple;
	bh=wYe+IcdZ5sAPvomkLeOMajQNaay/H+daZsNnHYswfPw=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=B6QYAtYbvWnO7cL0p5vI4JmyEuaiG5ji7YR1R0aHwebD7DVdCg+yDzVjCinovR0ztAUEU0x+L4q8HpChbVUxH+plgPp6NDFKzt6z9HGulRxKBDd8fe5VGlEoZUZvJtFbZ7NXA8raU27WgbLNeJDXcsccGpvv/maS8bdN4jLfAHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OhlRL33X; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07C93C2BD10;
	Tue, 14 May 2024 12:45:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715690749;
	bh=wYe+IcdZ5sAPvomkLeOMajQNaay/H+daZsNnHYswfPw=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=OhlRL33X47dxZOmzQKr1jHTao8pWiTIsxT6CuVBAIy41IePXpyOV35qN2xZOsKA6T
	 OTQVcNnSKAZJBWQ+vJkm5g8qclRctWA4rY7KMVFDHx0u5GmUzVqkw5GbFhHcHRc6pq
	 veh2dHUQ1XNK79xiWmv2KNjbkpmGUiDbEQn4ZTBi6kBE1zwRX0uPx466F1FKfY/AVF
	 JzfDRnpf57wQ3ZJ/Y5cPhx+8DOQNP5C1hDuFAWn1nd+8VAAVen9PJv9GGU0lyncZIr
	 TUN9zKrkxU5CapT5zPKVCm8fQl1xMiFWeRZbjivHQyqcS3zwhfi61/sBT6SEPTj98K
	 TBgHlkOHv5fTQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH 1/6] wifi: wilc1000: set net device registration as last
 step during interface creation
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240417-mac_addr_at_probe-v1-1-67d6c9b3bc2b@bootlin.com>
References: <20240417-mac_addr_at_probe-v1-1-67d6c9b3bc2b@bootlin.com>
To: =?utf-8?q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>,
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org, =?utf-8?q?Al?=
	=?utf-8?q?exis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171569074600.2017278.13914732662896657638.kvalo@kernel.org>
Date: Tue, 14 May 2024 12:45:47 +0000 (UTC)

Alexis Lothoré <alexis.lothore@bootlin.com> wrote:

> net device registration is currently done in wilc_netdev_ifc_init but
> other initialization operations are still done after this registration.
> Since net device is assumed to be usable right after registration, it
> should be the very last step of initialization.
> 
> Move netdev registration at the very end of wilc_netdev_ifc_init to let
> this function completely initialize netdevice before registering it.
> 
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>

I see errors:

ERROR: modpost: "wilc_load_mac_from_nv" [drivers/net/wireless/microchip/wilc1000/wilc1000-sdio.ko] undefined!
ERROR: modpost: "wilc_netdev_ifc_init" [drivers/net/wireless/microchip/wilc1000/wilc1000-sdio.ko] undefined!
ERROR: modpost: "wilc_load_mac_from_nv" [drivers/net/wireless/microchip/wilc1000/wilc1000-spi.ko] undefined!
ERROR: modpost: "wilc_netdev_ifc_init" [drivers/net/wireless/microchip/wilc1000/wilc1000-spi.ko] undefined!
make[2]: *** [scripts/Makefile.modpost:145: Module.symvers] Error 1
make[1]: *** [/home/kvalo/projects/personal/wireless-drivers/src/wireless-next/Makefile:1871: modpost] Error 2
make: *** [Makefile:240: __sub-make] Error 2

6 patches set to Changes Requested.

13633102 [1/6] wifi: wilc1000: set net device registration as last step during interface creation
13633103 [2/6] wifi: wilc1000: register net device only after bus being fully initialized
13633104 [3/6] wifi: wilc1000: set wilc_set_mac_address parameter as const
13633105 [4/6] wifi: wilc1000: add function to read mac address from eFuse
13633106 [5/6] wifi: wilc1000: make sdio deinit function really deinit the sdio card
13633107 [6/6] wifi: wilc1000: read MAC address from fuse at probe

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240417-mac_addr_at_probe-v1-1-67d6c9b3bc2b@bootlin.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


