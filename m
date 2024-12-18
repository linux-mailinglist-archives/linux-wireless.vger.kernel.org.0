Return-Path: <linux-wireless+bounces-16516-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E52A9F5D43
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 04:10:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0F6CB16498D
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 03:10:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5CD0713AD3F;
	Wed, 18 Dec 2024 03:10:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gGF3U4IB"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2899835956;
	Wed, 18 Dec 2024 03:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734491414; cv=none; b=ayV3TFYj1+g8dCd+EiyTg1GiD8Cfmj3a/7btZ80tjEClriS+TQLdoHV7qau3WLoE66SutQ2T8qRWPPdldEYum02nRfDWxATtzfpTU/kO1S671Pdh1rM6lOl1zrcohkvUIJl3n8WcONkUNtwU10evAvYG2kumpxMeC+a9mlrZH54=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734491414; c=relaxed/simple;
	bh=vl1vxVxEi6TKW7aMZclumsaDOCaNBRiyPN4zZU9o4/I=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ojRkW8EpOhOs30TgvNoqD6XCsLXu8v6bxbP6NsYI++3RiUzOcU6Md3wDSKyTfv6kYyXtVxpEUqXUWU3Xo9YtYwOjJ0vfGpnilhwdNURor3HTz6Scp14m4H1/ZgVhat8cCRQz0pEc7gnaOZ8g+RvYFBiK61jMmJgg2LHjPbMTtEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gGF3U4IB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A558BC4CED3;
	Wed, 18 Dec 2024 03:10:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734491413;
	bh=vl1vxVxEi6TKW7aMZclumsaDOCaNBRiyPN4zZU9o4/I=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gGF3U4IBCkkMudaxDml4lhAuEtQAdAR3Nm4+Xmst8l9xxP8us6haQJcdj0Szxu3qG
	 uf2ge87XsOgvJrJLwTn/c+4nMKOyBO7hLMfsWiyZowCdT5U/Z5YpxpHvAgY230W2c3
	 njE5pFM3pLqVf9SDRnKTJDmUNp3X76zwkIUijgm/3wro6ufxsYDu+0sVY6R29+BMM0
	 1B9O4uBxgamKfqW71QtVs1cVGtkc3f2046E/S05WlHnT9ps3MS04/E4kkjAs/VPBLt
	 DqQyevyRjzcEIGwQW0B6p/dJc7ot833nB49bob4nFAEyATy/eE3AzYPm1B82jMq8f8
	 oGlyzbnzamXJA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33D143806657;
	Wed, 18 Dec 2024 03:10:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next 0/5] net: constify 'struct bin_attribute'
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173449143102.1163899.8938848059479285986.git-patchwork-notify@kernel.org>
Date: Wed, 18 Dec 2024 03:10:31 +0000
References: <20241216-sysfs-const-bin_attr-net-v1-0-ec460b91f274@weissschuh.net>
In-Reply-To: <20241216-sysfs-const-bin_attr-net-v1-0-ec460b91f274@weissschuh.net>
To: =?utf-8?q?Thomas_Wei=C3=9Fschuh_=3Clinux=40weissschuh=2Enet=3E?=@codeaurora.org
Cc: roopa@nvidia.com, razor@blackwall.org, davem@davemloft.net,
 edumazet@google.com, kuba@kernel.org, pabeni@redhat.com, horms@kernel.org,
 andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
 kvalo@kernel.org, manishc@marvell.com, rahulv@marvell.com,
 GR-Linux-NIC-Dev@marvell.com, andrew+netdev@lunn.ch, shshaikh@marvell.com,
 bridge@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 16 Dec 2024 12:30:07 +0100 you wrote:
> The sysfs core now allows instances of 'struct bin_attribute' to be
> moved into read-only memory. Make use of that to protect them against
> accidental or malicious modifications.
> 
> Signed-off-by: Thomas Weißschuh <linux@weissschuh.net>
> ---
> Thomas Weißschuh (5):
>       net: bridge: constify 'struct bin_attribute'
>       net: phy: ks8995: constify 'struct bin_attribute'
>       wlcore: sysfs: constify 'struct bin_attribute'
>       netxen_nic: constify 'struct bin_attribute'
>       qlcnic: constify 'struct bin_attribute'
> 
> [...]

Here is the summary with links:
  - [net-next,1/5] net: bridge: constify 'struct bin_attribute'
    https://git.kernel.org/netdev/net-next/c/a2558b410de3
  - [net-next,2/5] net: phy: ks8995: constify 'struct bin_attribute'
    https://git.kernel.org/netdev/net-next/c/2d7b422fa795
  - [net-next,3/5] wlcore: sysfs: constify 'struct bin_attribute'
    (no matching commit)
  - [net-next,4/5] netxen_nic: constify 'struct bin_attribute'
    https://git.kernel.org/netdev/net-next/c/ae026eae08e7
  - [net-next,5/5] qlcnic: constify 'struct bin_attribute'
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



