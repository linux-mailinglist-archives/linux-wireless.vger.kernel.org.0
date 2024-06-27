Return-Path: <linux-wireless+bounces-9676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6FBCD91B12F
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 23:10:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0EC311F235B4
	for <lists+linux-wireless@lfdr.de>; Thu, 27 Jun 2024 21:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B04C219DF9D;
	Thu, 27 Jun 2024 21:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wu9U4xZG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85879A3D;
	Thu, 27 Jun 2024 21:10:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719522642; cv=none; b=Dy7Nrzj3vRKr9ZPf6uMOieHaeYP/4FkZA3qhqWJjwkFJFc1vAeeUFVftHgjrK11egbhK0543IXxkXdb7ULyB5f9PXHNQfLJwhj9YHuUmMs8fCC9L6sZtwowAEno6HUglTnDSnPT2kbDUpAxDslfzFpgTYUnwNFawMYShM/vdyO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719522642; c=relaxed/simple;
	bh=gByuGdSlkxpg7/6g2jwjmnxkbuR7iaNGArP+X01skvE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tWRzPZZgY6UVx/eguBVHZukLqCIKcENa0rCjjQQJqde1QV1gkbd8Em4FADQE2V83ugcnmWtOEf/QERQikK+fzbssj6soOAOuBYamgOH2doFPNRM8loWK4kjm612a+Hv8wlKBd9H946QYEVCc+0JCKwRK7+pZoYYQ0qXn9jKwA+k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wu9U4xZG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 1930DC2BD10;
	Thu, 27 Jun 2024 21:10:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719522642;
	bh=gByuGdSlkxpg7/6g2jwjmnxkbuR7iaNGArP+X01skvE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Wu9U4xZGJHIx+o8tKGqJVeV6mRhi9jDyXRz/NyJ6YRP06A+AFMsBU8FLdBaWGmw70
	 gLE2OUca6RbhyRRLuS62cF3LgbcWGPfeSNxqMqZJJo5clsIW4zEAvtvhrP3wDo5IHs
	 OkllPe54Oh2WdHQSb+yoUup2wpPV1sUs4sI76WL0z+2HjanGpF1rs6JYElDw6vvYS2
	 H0TGH1cboZhQbe0n5iJj982f9En/X7F/6ryEesDSY/UMUud4TTvqnaIpm2vh2Cei0v
	 HjI/X5EpqVVyzB7/Za2sMETK3C/oVtwSvdLqw/AZZZ1aXSQT+yT8q9g7P7zja9o4/M
	 IruuxObxfBZQg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 075F5C43335;
	Thu, 27 Jun 2024 21:10:42 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2024-06-27
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171952264202.5075.14777248969126123309.git-patchwork-notify@kernel.org>
Date: Thu, 27 Jun 2024 21:10:42 +0000
References: <20240627114135.28507-3-johannes@sipsolutions.net>
In-Reply-To: <20240627114135.28507-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 27 Jun 2024 13:40:53 +0200 you wrote:
> Hi,
> 
> For net-next we have quite a bit of contents, highlights
> in the tag message below. No known merge conflicts at this
> time.
> 
> Please pull and let us know if there's any problem.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2024-06-27
    https://git.kernel.org/netdev/net-next/c/56bf02c26a36

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



