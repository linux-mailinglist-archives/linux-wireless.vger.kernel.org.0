Return-Path: <linux-wireless+bounces-16641-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id DFD1D9F8A59
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 04:00:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id DC415188F1D9
	for <lists+linux-wireless@lfdr.de>; Fri, 20 Dec 2024 03:00:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 69F3A6F073;
	Fri, 20 Dec 2024 03:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fd9sTF37"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 285A355887;
	Fri, 20 Dec 2024 03:00:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734663616; cv=none; b=oqoKyJiJb9YZkHS6G81szcGCyJlStqc8EuRE5UDi6l1sprmS+Tynol4EYYFvNuSJwGZYd0d/cm7tDNIQL+xbUSL/N7fecJBzIsLGf/rrov9XdR/aqVvzgrJinpgtul71FLYptuaHilpVs9DJ+3UAYI8IJomq82ndBqwdBPNeVrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734663616; c=relaxed/simple;
	bh=JEhW8yJEdJMXgTf3USskJCfhwDdfYwhRlRSxy/OkFwc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=oJTtnCTFmO9jsVG8UC4tBXXmTUzaEaiODRgw4CWNEmNLRyC8sz7Zk2HaEDZR7Yd2qo1wFpOH1JgwFfhbyVOdz8B/zpIuT7JVlBV21kgCukpu0XTXRf/SilSW/88nGHroInSgSLxoNQ/OAxKHXw246k3/EgHQwvxqt9BappKOHHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fd9sTF37; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02A02C4CECE;
	Fri, 20 Dec 2024 03:00:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734663616;
	bh=JEhW8yJEdJMXgTf3USskJCfhwDdfYwhRlRSxy/OkFwc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=fd9sTF37qj2tyUgaU6vXgIQPYwi97/W+6KNtUDm3OYKEdbeB+Xq4aAbNACqG2VglI
	 9caTvewd0KHnV15SGvIPFPQneYoOHz4eIxXG1lxWJYzweJ8yeqnL0XoJhTt90KHHmC
	 zYyznngpWRWrEEu4ePjSD04VgW0uY5534tKNDj4+Jc4fgA/WcHOwfMV0FzMzbJdgn3
	 bU8Mh0cO2Z8PRGzfyltK0kB9hgL38F3uLtZQkusmQeg7IXulPZioLcnJENcjT9djhP
	 6lbuJKklQgUCKoRxPB01xK3Ak5NcOlOil+BPJV68td1HZsUjHisZETJI/mvdr9xbCY
	 eSXNurJmAzDWQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EC6D63806656;
	Fri, 20 Dec 2024 03:00:34 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2024-12-19
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173466363379.2457691.7980474877735944949.git-patchwork-notify@kernel.org>
Date: Fri, 20 Dec 2024 03:00:33 +0000
References: <20241219185042.662B6C4CECE@smtp.kernel.org>
In-Reply-To: <20241219185042.662B6C4CECE@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 19 Dec 2024 18:50:42 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net tree, more info below. Please let me know if there
> are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2024-12-19
    https://git.kernel.org/netdev/net/c/b6075c805375

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



