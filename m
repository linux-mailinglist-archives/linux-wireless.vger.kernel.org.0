Return-Path: <linux-wireless+bounces-17679-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 86881A15FE6
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 03:00:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3F96E165D98
	for <lists+linux-wireless@lfdr.de>; Sun, 19 Jan 2025 02:00:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A81CB286A1;
	Sun, 19 Jan 2025 02:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HYqR8brI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80118EAF1;
	Sun, 19 Jan 2025 02:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737252042; cv=none; b=mkVjxgL9LOrJAF+TM++hGXzLoIxN9wOhex3gSdTvNuAVzwyhfZZdbQ73U2QKzyo6tf3NtQrSqReU+Re6fxFBCUBYGMcLmgOinPX/1oTsG21DYhBu9TZHyZpStW3aqEo+L7epsimHD7Dyi8+EsYwDrm24NPLpuZWuaEhbkUy5pXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737252042; c=relaxed/simple;
	bh=GEe33fQfPWHSHm6H3hVYWS6UiIpcce0SVjzrjcCOBLI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=saZz0DQLtRq5WuOY4zgt0VUoAVGs3EOcE4Dqq69M0qE1GMC2ml03A414oQy82otxp5SmadnGFVY2ja8Np7DCfJt6CbzqssNXpX7Zg5dyk0B7I696QJEGSSj1+dF/b/Np3BzXTIVx/jSJnhFumMY3nu3zWh+7YQ18d6UMBaQErtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HYqR8brI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FC53C4CED1;
	Sun, 19 Jan 2025 02:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1737252041;
	bh=GEe33fQfPWHSHm6H3hVYWS6UiIpcce0SVjzrjcCOBLI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=HYqR8brI1PaxHtM3nnu+QeNQSvKzgHziaSsTP5vo6uZxR8RmRrW95a+ugiwyrbTz8
	 k4r3IANjqdvPxPE/UjWtSZGmxuTCbYjl7LmUHHRXDGSWZ7EogU30gs1WzjByap64vr
	 md0lqlngUfk0u5K1bi/XvPlaqv6aTHUq96ADINzK4HfmBOscEDnPvuYc6CYDdVyFtl
	 9v7Ikjd74b5nPaY3qejA3knnHQ/dEg49LUKWrgEcy48r/Vq1tHsrXC+MJc8uDDUSA8
	 rJUZiy6T6IIdr3EE9vNbT1QNfkgs0+vWsSp9DMmb6v6j0kIT9OCr1ADuDzuKWp3hF+
	 r06sJ6P925rCA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD1D380AA62;
	Sun, 19 Jan 2025 02:01:05 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2025-01-17
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173725206473.2534672.11238438170847318371.git-patchwork-notify@kernel.org>
Date: Sun, 19 Jan 2025 02:01:04 +0000
References: <20250117203529.72D45C4CEDD@smtp.kernel.org>
In-Reply-To: <20250117203529.72D45C4CEDD@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 17 Jan 2025 20:35:29 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2025-01-17
    https://git.kernel.org/netdev/net-next/c/66cc61a25c7d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



