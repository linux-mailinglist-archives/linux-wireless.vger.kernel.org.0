Return-Path: <linux-wireless+bounces-255-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 748927FFB18
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 20:21:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 63AC9B20E42
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Nov 2023 19:21:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E61522063;
	Thu, 30 Nov 2023 19:21:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="evZYHgvK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4D25FEED;
	Thu, 30 Nov 2023 19:21:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 47A20C433C7;
	Thu, 30 Nov 2023 19:21:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701372062;
	bh=/nNbmxvYk4PeLj0IKIcflNHFfHDHygDe5UG7/BtZX4I=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=evZYHgvKxtZnJ6tt6nMpok91Q3GDWFWPRI9wFkU6HApfzdy/66JaQUjWZeqJfa8ak
	 qA6ariFYlPv/LzTjFU7LXv9liNM31hJmSYDZqmi5O6uXUa/le4IHlJFv5nFWS3MZcU
	 x3okcbNxvsSjX+cA9FlYfsfnbRcADNPj6Lf9uKta6BIE4JHnGTBZOu90t4l4xlYFT0
	 Nulb8Bzil/jIuUEKcT3HGyXVmh8Eq9s+mrYbrGUDIPjZO4Bf/A7Uhzvw+JntIbqD4h
	 pMu7r6Xf+J1UehZeJ6JiAX7rGy5VEAWcUU3q+gHJhbgg05ChHM9lcUUvbB1/t4tXFr
	 6RHCyJmwDwV/g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: libertas: fix config name in dependency for SDIO
 support
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231122083047.12774-1-lukas.bulwahn@gmail.com>
References: <20231122083047.12774-1-lukas.bulwahn@gmail.com>
To: Lukas Bulwahn <lukas.bulwahn@gmail.com>
Cc: Arnd Bergmann <arnd@arndb.de>, libertas-dev@lists.infradead.org,
 linux-wireless@vger.kernel.org, kernel-janitors@vger.kernel.org,
 linux-kernel@vger.kernel.org, Lukas Bulwahn <lukas.bulwahn@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170137205913.1963309.7623759233878146525.kvalo@kernel.org>
Date: Thu, 30 Nov 2023 19:21:01 +0000 (UTC)

Lukas Bulwahn <lukas.bulwahn@gmail.com> wrote:

> Commit 4b478bf6bdd8 ("wifi: libertas: drop 16-bit PCMCIA support") reworks
> the dependencies for config LIBERTAS, and adds alternative dependencies for
> USB, SDIO and SPI.
> 
> The config option SDIO however does not exist in the kernel tree. It was
> probably intended to refer to the config option MMC, which represents
> "MMC/SD/SDIO card support" and is used as dependency by various other
> drivers that use SDIO.
> 
> Fix the dependency to the config option MMC for declaring the requirement
> on provision of SDIO support.
> 
> Fixes: 4b478bf6bdd8 ("wifi: libertas: drop 16-bit PCMCIA support")
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> Reviewed-by: Arnd Bergmann <arnd@arndb.de>

Patch applied to wireless-next.git, thanks.

18814f723f92 wifi: libertas: fix config name in dependency for SDIO support

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231122083047.12774-1-lukas.bulwahn@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


