Return-Path: <linux-wireless+bounces-822-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E57814098
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 04:20:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C465A1F2106B
	for <lists+linux-wireless@lfdr.de>; Fri, 15 Dec 2023 03:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 812B253BA;
	Fri, 15 Dec 2023 03:20:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jJmhegX9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6208A7492;
	Fri, 15 Dec 2023 03:20:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8E0CBC433CC;
	Fri, 15 Dec 2023 03:20:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1702610425;
	bh=A0SmXHAcm8gwLAGCl29PtarxvKADCdCHoxik2JrtxaE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jJmhegX9dQGKBMrrhbQBRparADTcrOjaZjsrM3W/+CdzjuupuihTH3++0imDNXX1Y
	 NFDdk8lOAVs8DPAvwWK72SP2aeTiSPJiaYHkqoMCk793DcWY3ChQoz/8CBmyC4YLqv
	 0Lxn6Ui6GN5zad5shEMAXbQwzn+DmstiyDIwhrE3hGftGAFyxFqzugAKErLK7L+eHb
	 x1FcEg18EqU5DrSCkWxviRtYsQ2AsrSxg+26IFBQp+dMJ+AmvCeeyJnxETKH79TfYJ
	 l2OZRMCutBAIlXDYSxyMyOaB7RqIhbUE89QESQzmNua3QVpz7T0sijEh2crR4a1HYJ
	 K6iJV0ZDqm/nw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 7CA24DD4EF9;
	Fri, 15 Dec 2023 03:20:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2023-12-14
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170261042550.8096.16344665402526181503.git-patchwork-notify@kernel.org>
Date: Fri, 15 Dec 2023 03:20:25 +0000
References: <20231214111515.60626-3-johannes@sipsolutions.net>
In-Reply-To: <20231214111515.60626-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 14 Dec 2023 12:13:56 +0100 you wrote:
> Hi,
> 
> So more stragglers than I'd like, perhaps, but here we are.
> A bunch of these escaped Intel's vault late though, and we're
> now rewriting our tooling so should get better at that...
> 
> Please pull and let us know if there's any problem.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2023-12-14
    https://git.kernel.org/netdev/net/c/0225191a7695

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



