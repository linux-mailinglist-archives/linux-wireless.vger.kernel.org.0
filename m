Return-Path: <linux-wireless+bounces-7368-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 615F28C09B6
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 04:20:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 92D801C210F8
	for <lists+linux-wireless@lfdr.de>; Thu,  9 May 2024 02:20:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3811113C9D9;
	Thu,  9 May 2024 02:20:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DSAw5lqJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B89513C9C8;
	Thu,  9 May 2024 02:20:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715221247; cv=none; b=tq/vye/lO/rdGYrxtneikSYeSZsy1aMeDSBApSaz3936faWT3ZiD63VKatmWDVVolNUETazZinK4pwIU7DPhh/8Xk0V9B4PnXEVwdAtMGCOK4/BS2DyH0TeeWzqdQkHk7hekWRfrsBD4rMgwQCoMnr/Rq7UobVIPl9LHs0zAWQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715221247; c=relaxed/simple;
	bh=A5R9N6suF2say+DC+2OqoLEof2TmNGWj0P0OCAE1IA4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HAbwL4eCCc+Ca8svIqYcyXNfdMm5xP9j4naM4n6q2LlQX2rEihvHSZ7XduI5Olspf3WqJqQNJ7iAccqEJ7qychMSnz/sAqopFuvq3RfZxHqD18ttTtMOGZ+XKuCYNhkgcizWCcyliXdVnh27V1vYiB03QNXuZXr19KPz9w5wqaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DSAw5lqJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 88E6DC2BD11;
	Thu,  9 May 2024 02:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715221246;
	bh=A5R9N6suF2say+DC+2OqoLEof2TmNGWj0P0OCAE1IA4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=DSAw5lqJcHKTEvDpjH2wSxDU/8MXELnzBcwyOP1fwgtX1AmaTfh7m4utdBebGicZ3
	 DxgX5GsLMkjU0cfM8Bzyx0U/rYeMHxUcH/Yw6YUcD7g24PsOK1osw9j4JUj45wlA6q
	 rdqqAFdy1hT5+JQ4dG5KQudyFL6fnoypk+3LEhO0g8pPhchSTXMMBlsUwwLLyyvaYx
	 dTScO2+nGzMTU5G0tqPNOuCb71NErmuAFvqf32Nc88WFjKbNhchR4m+JYhXn9GbGj1
	 qKPCiaQF9YI1qJUGdFtdmOQrLRCXLfVrx6L6tV3dEpCgCqisE7ZKFlb2RagxJztsyZ
	 RxMJzFEWt1m9Q==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 73991C43331;
	Thu,  9 May 2024 02:20:46 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2024-05-08
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171522124646.11537.1340312844004646287.git-patchwork-notify@kernel.org>
Date: Thu, 09 May 2024 02:20:46 +0000
References: <20240508120726.85A10C113CC@smtp.kernel.org>
In-Reply-To: <20240508120726.85A10C113CC@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 May 2024 12:07:26 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2024-05-08
    https://git.kernel.org/netdev/net-next/c/83127ecada25

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



