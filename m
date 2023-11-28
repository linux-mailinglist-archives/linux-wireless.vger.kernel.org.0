Return-Path: <linux-wireless+bounces-142-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E04B97FB066
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 04:20:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F012F1C20A8B
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Nov 2023 03:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2026FBA;
	Tue, 28 Nov 2023 03:20:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ai7gVoZG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FCF187B;
	Tue, 28 Nov 2023 03:20:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 4BBFDC433C9;
	Tue, 28 Nov 2023 03:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1701141632;
	bh=hLFcusAPWDDcNyFpUGNshiyrvQXqKv7q4HehfdD2jQM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ai7gVoZGmDkTYJ5F20tpXrje+eJ2M/80yzZgggw4FAYyUSVmuZXeryKfj3eG3dhS1
	 sDVTWazj1fiYvQzfnndoyZrRHhPw4hIZrLqfcaECqIEorzsB5QjZYTSgW1M4YYkdG7
	 /zKpDfivJ6fKQBgfgnJrKveWGMbVULDPeOqrfd90xi307RiaXMW7kIzNDhuqAMVCFg
	 Z2d8FPgsOCThxBOY/TZPVCwjxJgHeo56nt1MlCKoQNLrI0l2mXeBML4kNyCpwaz6Go
	 1DS1oDxAMQRnQvpQGImlBgDT7AYbUfMR9+g/d89ba3/jao9Jk8jU2FbhYm8fDLqE6t
	 PGDPmAqLukWBw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 29D6CDFAA82;
	Tue, 28 Nov 2023 03:20:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2023-11-27
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170114163216.7995.7788613798059111481.git-patchwork-notify@kernel.org>
Date: Tue, 28 Nov 2023 03:20:32 +0000
References: <20231127180056.0B48DC433C8@smtp.kernel.org>
In-Reply-To: <20231127180056.0B48DC433C8@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 27 Nov 2023 18:00:55 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2023-11-27
    https://git.kernel.org/netdev/net-next/c/a214724554ae

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



