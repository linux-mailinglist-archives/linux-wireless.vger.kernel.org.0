Return-Path: <linux-wireless+bounces-1509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 52CA5824C60
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 02:10:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C39CE1F22D77
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jan 2024 01:10:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AF563810;
	Fri,  5 Jan 2024 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DJMqLoeh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80A0D1845;
	Fri,  5 Jan 2024 01:10:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 087D6C433C8;
	Fri,  5 Jan 2024 01:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704417026;
	bh=X1uYVuZ7Fv1PsBspMsczLutj65fKRwv7ndeFJS0h+Ng=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DJMqLoehtf45VpXRDuO4gWaXzoyFEPZW2E+Q1k5CuYLUkFb9TDoSEzvDtmIAMCzcx
	 eX4uvt2x5KzFYYCbaqm44Vw6r7V/pvg9PuWoOP5Lz7/FDlI5NTMUC+QAj+uncZi9Pw
	 o1xWitG/BHUhVpB8m5L997itWit+hpwN8cCXjmCKB5tjRIisjC7t354jkkVeMjzIZ6
	 dSTEzSzKROYor6A3QCDtBzA0Zs4D8QYbLkJ3mvy7sxb6hxw1i/TaYyTgS+NMi6LAzs
	 WMjgNHLpTnKd3MT9ewPUsUsfZcD+QBVQpOQcGVhC/POH/O6F9nLJiDd69z3JWIvM3F
	 DtnpbaxDvt2+w==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DDCA3C3959F;
	Fri,  5 Jan 2024 01:10:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2024-01-03
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170441702590.30208.11390813358912311218.git-patchwork-notify@kernel.org>
Date: Fri, 05 Jan 2024 01:10:25 +0000
References: <20240103144423.52269-3-johannes@sipsolutions.net>
In-Reply-To: <20240103144423.52269-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jan 2024 15:43:39 +0100 you wrote:
> Hi,
> 
> So ... since we were discussing and wrapping up the kunit stuff,
> I decided to put together another pull request with a few things,
> notably the first kunit tests for wifi.
> 
> Please pull and let us know if there's any problem.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2024-01-03
    https://git.kernel.org/netdev/net-next/c/a180b0b1a6c4

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



