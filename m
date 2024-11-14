Return-Path: <linux-wireless+bounces-15286-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1AA129C810B
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 03:51:15 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BA2FF1F20F12
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 02:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 294A51E7669;
	Thu, 14 Nov 2024 02:50:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sl/mookw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001CF3D9E;
	Thu, 14 Nov 2024 02:50:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731552633; cv=none; b=Ccti4VjVKrJr8RXFYRYHojdGQ108jKpsm3hh3d0+UzvDM6X0wZ78Jy97Dn2L7ZYkZvKTdkNFBigfBbdcXaLp4rwEvunr28VdAMw94+wBLWKonK6fZ2im+k6FDnLqaC7j2a5NITBv9XsMvzE2AhlDQf7nZF7XIncscwqx/pq/gl0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731552633; c=relaxed/simple;
	bh=hswveWmOn1ILcD3sGtLYSI2+IVS1SCRcISUYOIeSWbU=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Bq/7IaA8Hzo4XaRaO+bmL5rk5MFSjiRAxstjoIuMXN768/2c0nTxcITi48+wCmTAPEnJpiDj0BJ3AWtKzOfyKS8+reYF6n52PaQUqA38MnXiKozot7457rk29wgq6VMLQdvVWQ4ulixO0BGJxAQjr0ngdQRPMLsD7qpYe/Ibfy8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sl/mookw; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B48AC4CEC3;
	Thu, 14 Nov 2024 02:50:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731552632;
	bh=hswveWmOn1ILcD3sGtLYSI2+IVS1SCRcISUYOIeSWbU=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sl/mookwghF6v6myOUoaDiAdRMiQj3L7UU466ruKKk4LVrcv/IzjfHZqFNDnsuIQx
	 TSYqcnYzPB9UK/hHFjUecUvWzY3+Omzk051uoVbTKHvSib5T2j8wI/7OJOmfcYbt+I
	 +H9t5AM9E+d94CUUO24xrNZThn3xSLcyjSGR9/TTTdkGL/kCJaR0wHo4Yq/99+K3h/
	 RpXWZT/MQ/Q2rxkrnmJNTRPNKt+K9Q4nJGxJUsuEXRfZ7sYyGJMMrccZJUBlS+CM2T
	 alSOG4wYyidCO30+48NwUpj/1PNBgDbjfrEO2gNhC5PpKXoKOCGunaIsKdi5oumBFg
	 aV9mQUkWoX7HQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33C173809A80;
	Thu, 14 Nov 2024 02:50:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2024-11-13
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173155264301.1461768.10210286103772756212.git-patchwork-notify@kernel.org>
Date: Thu, 14 Nov 2024 02:50:43 +0000
References: <20241113172918.A8A11C4CEC3@smtp.kernel.org>
In-Reply-To: <20241113172918.A8A11C4CEC3@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 13 Nov 2024 17:29:18 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2024-11-13
    https://git.kernel.org/netdev/net-next/c/5c46638540f0

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



