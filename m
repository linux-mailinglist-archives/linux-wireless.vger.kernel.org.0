Return-Path: <linux-wireless+bounces-28212-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6A098C03F3D
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 02:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 603FB1A40A38
	for <lists+linux-wireless@lfdr.de>; Fri, 24 Oct 2025 00:21:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31AD935971;
	Fri, 24 Oct 2025 00:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YVt8eGVt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07D4C13957E;
	Fri, 24 Oct 2025 00:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761265232; cv=none; b=YxGbXcH7KTXWK8S9JPz1ZjAOc2o5/zwGZpmMD4LPSBOhGAJX8NlFw5PNFjm2HpqpA1pC8RElh31oDJc0o3e4Wr636ScDrGAET16OL+WT3rmL1VbdSyx0sR7HhSxRXmVdUumN6l7QFK9ClZRgYsUAfqg8bOmonKgvZiQQ1sU6Bfo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761265232; c=relaxed/simple;
	bh=X0IqLZJz1hOoSPzrNuIREWT+bJjOZL5QWeaowQihK3U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Y7RBpu0FPOyvTNaAaVKqJyMUv9tPL0px2cOPYtpVQ+xLPeGg+4lktr6L8lYRRudMBSJQ3fm9cvzR89E/Y/AkmoW+RuyXrTvGdxLwFprviV+wG9jX+eE4GPlx9nOsMFdMD22xALTCUVmVSp5IfMYePE8mCiOf3lMrdEOvrXLv97A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YVt8eGVt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BE08C4CEE7;
	Fri, 24 Oct 2025 00:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1761265231;
	bh=X0IqLZJz1hOoSPzrNuIREWT+bJjOZL5QWeaowQihK3U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=YVt8eGVtim9C3d+1k+mTvO8Z4+ZGwRm+Kl1SRQ6VnKiBTIE1ia6eQ5Qr+D5kAptaC
	 77neq1CIOlGXqCbDMdRXAGLdkmMYmwb7cqERqYrkXphqBnz1J7xrJQgSEpqauJtITx
	 yiveVPXLrk0m7qc3C3f5Mk2Fn9bsVSGz/46IxQ8eoZfykot8Z6c4AVia46oFGdCnnx
	 uFg8ZWrX8zHDRjU4zKlv8LH8ithKSP+v6UfRzb4EGKrgc4PWdOBpehSab12i0YIS+v
	 rfjqgLL+ViuQmvYvDaQsO4ocHT22JUwXWH6slvKsr5XwDFG2jQIn93BB8taU9d0i3r
	 zK2jzR/zDh0Pg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAF593809A38;
	Fri, 24 Oct 2025 00:20:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2025-10-23
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176126521175.3299299.4457170622726305895.git-patchwork-notify@kernel.org>
Date: Fri, 24 Oct 2025 00:20:11 +0000
References: <20251023180604.626946-3-johannes@sipsolutions.net>
In-Reply-To: <20251023180604.626946-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 23 Oct 2025 20:05:04 +0200 you wrote:
> Hi,
> 
> Sorry, I meant to send this earlier, but ... I guess other
> things happened. Luckily none of the below seems really all
> that urgent, most issues have been around for a while and
> I'm not currently aware of anyone being affected too badly.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2025-10-23
    https://git.kernel.org/netdev/net/c/a83155cc4ec5

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



