Return-Path: <linux-wireless+bounces-23165-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 02083ABCDCD
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 05:20:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBBC63BD827
	for <lists+linux-wireless@lfdr.de>; Tue, 20 May 2025 03:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69E6E25A2C0;
	Tue, 20 May 2025 03:20:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="coNO+kDv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 350D410785;
	Tue, 20 May 2025 03:20:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747711215; cv=none; b=LKw6kisjIkkNrbsigMhm4eMh98fgw2LQD0iRn8QOWLT0/AMccAa39pcWul79r25ZAmi2r+XMiXFvWc/edVAzsvjTnaG12R2YCXChf4Kz1y8w9u1DTNx09x6Rtuxf2uvc1YM9hbRlbp8aPvNCBxMMUAkBv28iDWEPcYybFBGHGlY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747711215; c=relaxed/simple;
	bh=RMJrHFiATeA39B8b7uhnBtX8MFwRT0uz+UNsjco2Tu4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=t0+y1xr14hRPwDPIfvNwklFmt7aBXBrUipX4FTFJ63IrdlRbxcO6GNLcaxmhPcKS/z+Fn2p03caFSm1NfLiEqZut2moBP2KxZ1s9ItjhR1k3D7AocgCt8+UacvRqP/xKm+GcdUcvT8eTEFcEslBdJr+am+ZlT4zgL/LoELpdx/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=coNO+kDv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A86FDC4CEE4;
	Tue, 20 May 2025 03:20:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1747711214;
	bh=RMJrHFiATeA39B8b7uhnBtX8MFwRT0uz+UNsjco2Tu4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=coNO+kDvAC9SLYoZn7Mj6LVj/pxfiLniEF3pxwUH/WqqqXc9mzKjATdwhu1iKBEWa
	 Fl0j8h0qFyO74XWefQkn5PLESkFNfvWrGrmZispITB8H2wz4XcPqiqlHx8gGz382IC
	 5RzMpJk4U81lLYSKuEUiAz1vXGfzfH3Dsm9N+YHd3qzdWxoom0jgNC407dRhR6V949
	 nPLckOOU1YoCOGxZKPVyix0yvKYABBLtrs5dxHlKbIxc0NECopzYgtXfbTNDeY/U8u
	 lcY9T0E4bLlxn23Q26AU5QvuloP589h3fMV3D2av1YlrkCzLzezPgdyPW2+LxoXasO
	 25IBdMup3lolA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD82380AA70;
	Tue, 20 May 2025 03:20:51 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next] net: netlink: reduce extack cookie size
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174771125074.1146050.1563363556948881268.git-patchwork-notify@kernel.org>
Date: Tue, 20 May 2025 03:20:50 +0000
References: <20250516115927.38209-2-johannes@sipsolutions.net>
In-Reply-To: <20250516115927.38209-2-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 johannes.berg@intel.com

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 16 May 2025 13:59:27 +0200 you wrote:
> From: Johannes Berg <johannes.berg@intel.com>
> 
> Seems like the extack cookie hasn't found any users outside
> of wireless, which always uses nl_set_extack_cookie_u64().
> Thus, allocating 20 bytes for it is pointless, reduce that
> to 8 bytes, and add a BUILD_BUG_ON() to ensure it's enough
> (obviously it is, for a u64, but in case it changes again.)
> 
> [...]

Here is the summary with links:
  - [net-next] net: netlink: reduce extack cookie size
    https://git.kernel.org/netdev/net-next/c/a462903fa225

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



