Return-Path: <linux-wireless+bounces-1292-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2685881EF1A
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Dec 2023 14:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB8561F220C2
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Dec 2023 13:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AA8D44C7D;
	Wed, 27 Dec 2023 13:10:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gWuNE2hD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09D51446C6;
	Wed, 27 Dec 2023 13:10:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 69029C433C9;
	Wed, 27 Dec 2023 13:10:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1703682623;
	bh=lW2vlwL5kbNeD89dDzyGv8dgNeqvg05mKbI50T2JKk8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=gWuNE2hDIwOpXBt3f6Wx/9RdbI5okDGAEQci0xaY+jM47MSaUfMCD0gj6QWtnls3b
	 C0Byj1VMLxI/VqnO3aBUHQwSJ6vN0h6ebouqlCa9BkusJ5SArylWOZjFFEhOBMucbK
	 V35EwW3pcUJp1Q3hC0XPU118HCteMkGSul0VB9UqNObYDSjNe5spj+w5xqk9+kYhdn
	 4zCCbQUBO1T2es+N+jReT1rZ2rvzri4Bkqx80/DDe53bIMaMh3Cyd5a/GjRPjZK1SD
	 e0RTYNFaCdFvEc0dIrjLHQpsw20cJn4Xub816Bn5WQiag/jZ4+JJFP9bjRaRmxm82O
	 wQ/CnmPbW+8/Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 4E991E333D9;
	Wed, 27 Dec 2023 13:10:23 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2023-12-19
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170368262331.3726.8214220872504350917.git-patchwork-notify@kernel.org>
Date: Wed, 27 Dec 2023 13:10:23 +0000
References: <20231219223233.189152-3-johannes@sipsolutions.net>
In-Reply-To: <20231219223233.189152-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 19 Dec 2023 23:32:14 +0100 you wrote:
> Hi,
> 
> Here are a couple of more fixes, the most important
> one really being the iwlwifi rfkill fix.
> 
> Please pull and let us know if there's any problem.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2023-12-19
    https://git.kernel.org/netdev/net/c/49fcf34ac908

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



