Return-Path: <linux-wireless+bounces-18883-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 73DE1A3363B
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 04:40:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 06C8A18898B3
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 03:40:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C100204F7F;
	Thu, 13 Feb 2025 03:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TVen+tNM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71B222046A0;
	Thu, 13 Feb 2025 03:40:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739418007; cv=none; b=RZH1e7cq+V/62vv/GkQO+0+PpdbMpsILXMACVm+91gJDE93RtpgL/vxVglsuYP9z+2JiixehVghNAnqMy3hwc9KTqNk3XKXozf4AmmINuX23LbBl0psYb2EcAVe87YxXQix65lwF58x9bjbAZ2WEwpJnn68E96FJI6bX6bDgA2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739418007; c=relaxed/simple;
	bh=zbQfDjz9x8GoIRjnfH2IOxeL/N7DsJgRXp+x3xAgqyw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=atKCM9dNgnf3qlHK5aqz/Bx3gFYJ02QwRC37nhx73LXoJCagVi2pBzOgljwhlPDVfNgf1MpiopVlVJsE7rqXD5J4nJ1yPU0WGfZUHl19oMS7Vq9DNT/PirG2+ops0vcbF603uG7IOS+QGwZbkcsHzqe9xl5fEdZO5ndxHqCFe68=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TVen+tNM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB41AC4CED1;
	Thu, 13 Feb 2025 03:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739418006;
	bh=zbQfDjz9x8GoIRjnfH2IOxeL/N7DsJgRXp+x3xAgqyw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TVen+tNMWDy97ECGdSVMDIzBeOuqr+WRZhSHpd+bRSoyOWO+Lp3Ee2aFMoJ9BjpvD
	 6Wa53bLedSiftjZG4HKe/8ePYcNuAxN4pWDRxYgWwkIIvFag26pZKqXSuOn7z8LtDF
	 k5W07N0/ZrPe7E15sOcZdz1yzTl4l/DochVN4gqAw6h7pQRpoSFApix3iGRN/tJ03+
	 6mNxhWTeyp12JZcRWx4JAfWr7VZ7HicmhT5WPUAAp+GUmAobddJUkx0fOUWTzEOpYQ
	 AW5vsLdthkG3uhLO5l38V4Nm3o/StLD5nnBDb61n8uHEw/1lQLUPhQkajOoHEv1/im
	 79vZPQqp7IHlQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 34593380CEDC;
	Thu, 13 Feb 2025 03:40:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v5 00/10] netlink: specs: add a spec for nl80211
 wiphy
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173941803600.748910.8256772828348973152.git-patchwork-notify@kernel.org>
Date: Thu, 13 Feb 2025 03:40:36 +0000
References: <20250211120127.84858-1-donald.hunter@gmail.com>
In-Reply-To: <20250211120127.84858-1-donald.hunter@gmail.com>
To: Donald Hunter <donald.hunter@gmail.com>
Cc: netdev@vger.kernel.org, kuba@kernel.org, davem@davemloft.net,
 edumazet@google.com, pabeni@redhat.com, horms@kernel.org,
 johannes@sipsolutions.net, linux-wireless@vger.kernel.org,
 donald.hunter@redhat.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 11 Feb 2025 12:01:17 +0000 you wrote:
> Add a rudimentary YNL spec for nl80211 that includes get-wiphy and
> get-interface, along with some required enhancements to YNL and the
> netlink schemas.
> 
> Patch 1 is a minor cleanup to prepare for patch 2
> Patches 2-4 are new features for YNL
> Patches 5-7 are updates to ynl_gen_c
> Patches 8-9 are schema updates for feature parity
> Patch 10 is the new nl80211 spec
> 
> [...]

Here is the summary with links:
  - [net-next,v5,01/10] tools/net/ynl: remove extraneous plural from variable names
    https://git.kernel.org/netdev/net-next/c/2151003e773c
  - [net-next,v5,02/10] tools/net/ynl: support decoding indexed arrays as enums
    https://git.kernel.org/netdev/net-next/c/678d8ddd0087
  - [net-next,v5,03/10] tools/net/ynl: support rendering C array members to strings
    https://git.kernel.org/netdev/net-next/c/569a5d63fd1b
  - [net-next,v5,04/10] tools/net/ynl: accept IP string inputs
    https://git.kernel.org/netdev/net-next/c/c578bc3a00f1
  - [net-next,v5,05/10] tools/net/ynl: add s8, s16 to valid scalars in ynl-gen-c
    https://git.kernel.org/netdev/net-next/c/8798892b800f
  - [net-next,v5,06/10] tools/net/ynl: sanitise enums with leading digits in ynl-gen-c
    https://git.kernel.org/netdev/net-next/c/16cd1a5299ee
  - [net-next,v5,07/10] tools/net/ynl: add indexed-array scalar support to ynl-gen-c
    https://git.kernel.org/netdev/net-next/c/9fcfc1e210a6
  - [net-next,v5,08/10] netlink: specs: support nested structs in genetlink legacy
    https://git.kernel.org/netdev/net-next/c/718a8360719b
  - [net-next,v5,09/10] netlink: specs: add s8, s16 to genetlink schemas
    https://git.kernel.org/netdev/net-next/c/fdb8050e1a87
  - [net-next,v5,10/10] netlink: specs: wireless: add a spec for nl80211
    https://git.kernel.org/netdev/net-next/c/31438709ecdb

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



