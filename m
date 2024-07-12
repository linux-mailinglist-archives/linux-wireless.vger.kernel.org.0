Return-Path: <linux-wireless+bounces-10198-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 792AE92F309
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 02:31:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 22E891F23427
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 00:31:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 447D8184E;
	Fri, 12 Jul 2024 00:31:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UyKz/dEe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CCC8138E;
	Fri, 12 Jul 2024 00:31:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720744279; cv=none; b=EAR2wu7NlRiEuxVnSUt/2WWJY9aPkcJk1e4m+bBPi9MJ+LUqQfUvjS3KMh/Nf0ql37y3plPcVkpO6NJzzlupf3WERaeWAXD5/YU88rYpjoyZr6YfC2UJolB6X8mKjUxQFiXcctFfGZpEM7xwL7xkRvITQ8pAmDYdlCaQt+MkmTk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720744279; c=relaxed/simple;
	bh=6bELtlIvZKBwaF4ixKB1y7qsmRkv8yo9zM25QDS8mV8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Z/KgCugsA5KLJwIFCHI17OmXCKjyOEpoDwZ12TjMOJ6p3iYTSf+zF1D3j2+Lr5RLU5OWk3lRTwRyiEixahAL/cJoAAX8/UUuKe7UQrz5MHXcZF4+BqoDag1/XAgqXR+tpbnjmDW/MZm1/630t9BS5EfbL0dFVp+MNwULsoGK910=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UyKz/dEe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id AE046C4AF0C;
	Fri, 12 Jul 2024 00:31:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720744278;
	bh=6bELtlIvZKBwaF4ixKB1y7qsmRkv8yo9zM25QDS8mV8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=UyKz/dEeEXw51AURKdV59surVs12upR7CeXRhNEKn4I3TIpm+p5/PIjN9flu9DG8l
	 xeoQ3/eGHbtd3uR/W/5K61zJuV8GqG8lzedHAOv+Z6xMEQ4IWkV5TpzUEvRX7dexFb
	 k8luzgmS7EMUAmQcbZWFohUjtDITjiNjUn0LI4wUH19J7Mx5IehySvNs/e6Nn+ArrT
	 9N1804DzYX/atruLpR3p8gIrb7QqnR8guUOckZ51WbRLX2Sw19+NC3T3pxTEADyroR
	 hSEMEB69T39UMgemDic1PBp2GhhmmLDEPK50Ef398srZBJeg3ctjVkHVCz7FqMamz+
	 xX8ARG1cIF58Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 9111BC4333B;
	Fri, 12 Jul 2024 00:31:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2024-07-11
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172074427859.19437.10166361420632271719.git-patchwork-notify@kernel.org>
Date: Fri, 12 Jul 2024 00:31:18 +0000
References: <20240711102353.0C849C116B1@smtp.kernel.org>
In-Reply-To: <20240711102353.0C849C116B1@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 11 Jul 2024 10:23:52 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2024-07-11
    https://git.kernel.org/netdev/net-next/c/80ab5445da62

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



