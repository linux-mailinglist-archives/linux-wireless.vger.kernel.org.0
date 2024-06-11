Return-Path: <linux-wireless+bounces-8768-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1196902DCE
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 03:00:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF87C1C21944
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2024 01:00:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5190B4C8D;
	Tue, 11 Jun 2024 01:00:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l/Fvisrq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28D63A934;
	Tue, 11 Jun 2024 01:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718067642; cv=none; b=RM+GZ5vjnYVHbgjGtSG0k58v0LktAGJSnYrxjSX6JVLcfJpm7827KPNpgxqMYZrQE1MljBa1LoFanIPr39wH8wexuPgjkSZJ6zeJ4NuyVWs0ahaieO4zXOpdg/QdZ29Pa4p9kbvrTfklfPvvr6F83uGxGOJ9ghfGps/fNYw8WfY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718067642; c=relaxed/simple;
	bh=9pnZz3GjeOWVNl3ezAnbXvds+TY9JRbi79eQXLmcNyY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=fPl5mUdLrHqA3fHmV8cb8ou4V7dHSUxLaICB3AZhDaz3/9VkLcw8jw8EnnxP+9kkO6lwDNiRq5aBTLYosODWUgFI5dO+ZFJZZUgiw6QfoR5B/+tsAUMr2h6oRylUIadEbU14IZzh3Zk8hxROQ16odwUr3HpjAe0lqlZwhDxmqxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l/Fvisrq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 95AAEC4AF1C;
	Tue, 11 Jun 2024 01:00:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718067641;
	bh=9pnZz3GjeOWVNl3ezAnbXvds+TY9JRbi79eQXLmcNyY=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=l/FvisrqTz52VlWuD3vVcPfhVW9JnjmPyYvDiUmBEM11qcpdbcEDy9bV8gk0LI1ro
	 qJSUPSmR280MxSa/yv5jAXWZxJz8h+sZrWvAOca0X0CrrBv5r9TygpeVUWCO3R8y1y
	 jD1/uhR33i+tjVW9frLB94kbxKVy2J8kR04K0u69bSkTfO2YIBgCR2oCAu6dk0cDud
	 T+CVy1KGoTI8jKgheDsjc72wjK4tVgPhYjoq68t/cjqn+UXuI2441/iwfia70W642D
	 pAIFSgYEHTJBWV4jTd2TGhw9DLHMA18ZRsmKM7SCUafmzs3JJeYBADz3jpIBYFU4sq
	 P4aQrTQO5L9jw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7B5AAC54BB3;
	Tue, 11 Jun 2024 01:00:41 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2024-06-07
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171806764150.26535.12191712907196102676.git-patchwork-notify@kernel.org>
Date: Tue, 11 Jun 2024 01:00:41 +0000
References: <20240607093517.41394C2BBFC@smtp.kernel.org>
In-Reply-To: <20240607093517.41394C2BBFC@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Jun 2024 09:35:17 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2024-06-07
    https://git.kernel.org/netdev/net-next/c/93d4e8bb3f13

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



