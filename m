Return-Path: <linux-wireless+bounces-4133-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BC8E286A736
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 04:30:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 707FA2833E9
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 03:30:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28D01F952;
	Wed, 28 Feb 2024 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oWYW/YvM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB2D62F24;
	Wed, 28 Feb 2024 03:30:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709091032; cv=none; b=l/kaMK80PnkK3X8IrH7iczgZeLDsvEcC05YZa9RE/ZalL5oFnKRLmJmuy0HzHuBC2BTRlfHprq06lIvMsprLm87PhQVlsdeVhcUFjEV0PNIXcXpUm6C7KO8GTh1+0jOjU5PWiXlYlIGD9wnMV1eU3CNCk3WfLA+diR2lkp9xE48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709091032; c=relaxed/simple;
	bh=nd/CaMYuwTn+UcDF+3uUxq1gzce4dc+lhHjqIRE/w88=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=byiqwDa3AcZHjPRbJ/TRLCR5F77tEdIETS6XZun8UAL3LPQCyQyr3nFZ7bDA7AY0VAN3SVQC8CM5Byw54bLE62Auxz3S2Ayizn7BqgjQsdl30PAIfIHQ4SxH3BWPbZrqqlkY52yVBa5KewKudjFNX9fg+d1FE5/qJRE1KfIotlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oWYW/YvM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 306D4C43390;
	Wed, 28 Feb 2024 03:30:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709091032;
	bh=nd/CaMYuwTn+UcDF+3uUxq1gzce4dc+lhHjqIRE/w88=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=oWYW/YvMs+poN8WVP3TKYiG8l6UPS1GraPrHxqADQp33b71T3xDwphuRWDr3mEsge
	 mFNmGTVYqGVKqBEZ/KuXcFw/cVN8pDDY49VBryV+2Qi7Tjr1Z4y5Bzs3SaDLhzCLbI
	 ed+ZqSuuuY66HGuAV6YduOJmjBKnU7J5ZGq6AWLrk8y/qz/xMQY43WfAhBm1qIhujm
	 NBiC+JIynrhuq7IJDzudCL8pdK5yS5sLkVCzLVSsgxJ6/RXmfi55PN1gU/JLtDuux1
	 +j7yzN5I4obpPVaDGQXzCmu3svKqbOYZQWafug46ny7QVN+WOfjOR/JfYljJp61Kb9
	 +3Iq6F05DqCmQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 0D495D88FB0;
	Wed, 28 Feb 2024 03:30:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2024-02-27
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170909103204.32106.16533188305242295276.git-patchwork-notify@kernel.org>
Date: Wed, 28 Feb 2024 03:30:32 +0000
References: <20240227135751.C5EC6C43390@smtp.kernel.org>
In-Reply-To: <20240227135751.C5EC6C43390@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 27 Feb 2024 13:57:51 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net tree, more info below. Please let me know if there
> are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2024-02-27
    https://git.kernel.org/netdev/net/c/ed2c0e4cb693

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



