Return-Path: <linux-wireless+bounces-9990-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4975927903
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 16:41:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C2F328F4EF
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jul 2024 14:41:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CA261B1215;
	Thu,  4 Jul 2024 14:40:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Q9VEdPc1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA8741B010F;
	Thu,  4 Jul 2024 14:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720104029; cv=none; b=MkXuDdTwzNYRvWXd/6/CucU9PQUNl9b3/wGvh3uwnZxoeHkz7smNqpXZ0tHJ0nFvk0HFefATNCTI8CUKVqa7Mhc9ztZMAuplnHJ3OI73AVJfS/0ztmEV1+4LzMLBAOrdVazAdKwmTZk5dzcwuZsBY2F3vu1GOVa9If07zh755vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720104029; c=relaxed/simple;
	bh=idtjlhu+OxRXuGY6EviahykOMhgRuwW/izqhcJHRqP8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=GfbZKlFExuP6BOlGmDwk6Lymmwt4enH2e4oOXzVAzwPOOXJJiPwajA1tMIi4C48ssubyhMGGYIROllnxh7BJfvORMrCNJXtlYO3vvsL2JlL/4kuruxzmTTQj1M3yRPajt4m6VrvuPAt7FL6toJeADgpy8cevOuPyBVqCWDmX3eQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Q9VEdPc1; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7D78CC4AF0A;
	Thu,  4 Jul 2024 14:40:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1720104029;
	bh=idtjlhu+OxRXuGY6EviahykOMhgRuwW/izqhcJHRqP8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Q9VEdPc1yu39sQwm6V+sYVs5ZVfGyK3SsGj6HyOzNHSBsRVDG24wiGDuITj+0lB7y
	 dSNLE3aQBS/PKxX/xbJAQ/bJnNcChS86aC/NG6PwsnzjF4aC3+2kZyAfKOcKl2uArk
	 K5ObFvIrrh6q3+KMxExKcQUh3oAQony4HnjFBFjH6Peyc6mS0/NiUZIjJE8HqkjV8a
	 PT1RRaJbc2snlCnplo1SHBmLph0izJNWMyfmBwji50vww2+YjeFGRXhchtrer45+6L
	 7Z2ilcM6/Hxkb6KFw15WTVBFJ9+DdZk/MHXUqSb3MOy6lysQ6+cZaFIspNV4nIBsE4
	 XUlhxaZXmdpuA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6560EC43331;
	Thu,  4 Jul 2024 14:40:29 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2024-07-04
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172010402941.7153.7597210587036338690.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jul 2024 14:40:29 +0000
References: <20240704111431.11DEDC3277B@smtp.kernel.org>
In-Reply-To: <20240704111431.11DEDC3277B@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu,  4 Jul 2024 11:14:30 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net tree, more info below. Please let me know if there
> are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2024-07-04
    https://git.kernel.org/netdev/net/c/eec5969cc304

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



