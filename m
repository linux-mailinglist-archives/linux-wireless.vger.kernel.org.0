Return-Path: <linux-wireless+bounces-949-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 872FA817EDF
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 01:41:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 272DA1F21DDF
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Dec 2023 00:41:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4982717D5;
	Tue, 19 Dec 2023 00:40:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="SlKvu4tf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22A8217CB;
	Tue, 19 Dec 2023 00:40:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 917F5C43395;
	Tue, 19 Dec 2023 00:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702946444;
	bh=CfLFULyCobbm11Ctyb+YHPSIvzQ3Pji0eKUQGAROm+M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=SlKvu4tfSZ6phtWDJBib5qNJD9JlpfwsZejraqBlrG0zpismyOgUfaHWqFZZYNXwq
	 EX9qGaC5mRJjceP3VxH/FlkBg8DYd6FE/GaQxtT4Vx/CjUyLtEMLPFF+qPlHkXr1Yo
	 BYUqK38WSD8axVCQXzymQx+PVURSjXlobsl2pyrRBquesjH6t5Zc6iw8HICOxp3ErZ
	 CcYVvD4le4QuslpBuuFnda+noa99/NME9q4dlZPSOYDox1x6nYRNiEilVtPSs80aYG
	 Bhy8h6UOn4kCXHnPHjE994qrKMwD3Cv5cYxctYEBY9uKySGCOpXikdMJhb2zJN50kA
	 BdS77fkRRRuww==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 6DC08D8C984;
	Tue, 19 Dec 2023 00:40:44 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2023-12-18
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170294644444.1070.13230618944313891274.git-patchwork-notify@kernel.org>
Date: Tue, 19 Dec 2023 00:40:44 +0000
References: <20231218163900.C031DC433C9@smtp.kernel.org>
In-Reply-To: <20231218163900.C031DC433C9@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon, 18 Dec 2023 16:39:00 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2023-12-18
    https://git.kernel.org/netdev/net-next/c/0ee28c9ae042

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



