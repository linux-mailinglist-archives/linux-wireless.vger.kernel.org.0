Return-Path: <linux-wireless+bounces-16119-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 33CF99EA29A
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Dec 2024 00:20:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 505CF282A7C
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Dec 2024 23:20:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C6F4A1F63F9;
	Mon,  9 Dec 2024 23:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kosqyZwz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B1E81F63F3;
	Mon,  9 Dec 2024 23:20:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733786418; cv=none; b=te4PojPfBL2EefKqVrmdBiNc3H7V+ZyS937id0X2qmVPMR0q23fx0miJfzX2yG4jMdrAp7PFE3rB1797/gI1lf/10tnKvYFnR58b54+oxYUdipbByt2Bbgzfs2DUXyNo7Y8okgz6kjMN7yirlEx1IJnmI6Kf5iz0FIuLEw4GHEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733786418; c=relaxed/simple;
	bh=TBdJqxdHtaaKpiy3fWFoHBNIphhOxmho00SyqChErAw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Vd+RrU2oyRq8sYwHNV/oDWmykFh/IYiYZJ9wHjRkytjnpR0vCqHVSEPk4GOnWpwXsTIn13hvoiX1zC90JQB/YtiB8ROPdp0gUv7xOAKGCaIGL7hNYcWUUiZVi3URwSTs7E9wSyy5daFyZWlcAO8BdlP5VbDmfesAHFVCkO8thIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kosqyZwz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62EC5C4CEDD;
	Mon,  9 Dec 2024 23:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733786418;
	bh=TBdJqxdHtaaKpiy3fWFoHBNIphhOxmho00SyqChErAw=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kosqyZwzIyhGlBQyfrUftGKZJ/azSssdJglNFWkveRh9e7XuIKUS2Oy1GsHwWqFvt
	 d4oBT73HbniPM4OHQwqpRZXN0FqkFZL2zGhQRf9P6QHdmXsHkdodewI0KHLIxvavNO
	 6cq3xUL5e4FDfkl2AtuqmnSk14Vn1lywfaLn0zHQtwmRo7964GtbZrWfMRjJm/VVYI
	 N5YriIrQ5792VIoRcTbDXvWnZGhcLe3tH5j9PSsIogUd4/6W7FcOMP+z7orDjQ9+8c
	 rgbz77tA9LG9BR7VKVlDjWFDNcDTWWgXxTcsBWM4lPjpeFD4NHlrRLeXE9RZD8L2az
	 TB8JrO6CgRkyg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 342DC380A95E;
	Mon,  9 Dec 2024 23:20:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v2] net: reformat kdoc return statements
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173378643377.273075.2794294027777185502.git-patchwork-notify@kernel.org>
Date: Mon, 09 Dec 2024 23:20:33 +0000
References: <20241205165914.1071102-1-kuba@kernel.org>
In-Reply-To: <20241205165914.1071102-1-kuba@kernel.org>
To: Jakub Kicinski <kuba@kernel.org>
Cc: davem@davemloft.net, netdev@vger.kernel.org, edumazet@google.com,
 pabeni@redhat.com, johannes@sipsolutions.net, richardcochran@gmail.com,
 ryazanov.s.a@gmail.com, ecree.xilinx@gmail.com, wintera@linux.ibm.com,
 pablo@netfilter.org, loic.poulain@linaro.org, dsahern@kernel.org,
 hawk@kernel.org, ilias.apalodimas@linaro.org, jhs@mojatatu.com,
 jiri@resnulli.us, przemyslaw.kitszel@intel.com,
 netfilter-devel@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This patch was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  5 Dec 2024 08:59:14 -0800 you wrote:
> kernel-doc -Wall warns about missing Return: statement for non-void
> functions. We have a number of kdocs in our headers which are missing
> the colon, IOW they use
>  * Return some value
> or
>  * Returns some value
> 
> [...]

Here is the summary with links:
  - [net-next,v2] net: reformat kdoc return statements
    https://git.kernel.org/netdev/net-next/c/3f330db30638

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



