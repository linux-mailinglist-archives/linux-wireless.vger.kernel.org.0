Return-Path: <linux-wireless+bounces-2509-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 911DF83D1E5
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 02:10:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4586B28B393
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Jan 2024 01:10:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91003629;
	Fri, 26 Jan 2024 01:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jRVwij46"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C60399;
	Fri, 26 Jan 2024 01:10:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706231436; cv=none; b=TdOnoY39ALTKIwWVua4DeVSAthq0rUCyEsKg1iQ3rZYEvvE0rhLBKoTa+aON4e6cRsIu/E12GjOe2Uib/OVYMCTsQ9Y+LvWhl6IHnzfzY4LxJnfkfFhQo0nsUbeCcKnCI5IzFncuYpVb7JXPyvMNEKD1VoUZz8fBiiMhO5abBTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706231436; c=relaxed/simple;
	bh=UtZZQvws/MkjPDhMY+kb4qtn6ATaFigrvNJEFylyc9E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=pN+nsyuJfI91HpgsOoAW0xLJLeTYw05g6Wrj1O7qw9VB5JGYwfkyw4QbpddyI65oq4kDDhZ+LE3BDA6QRDPe12U23mGPELBXH0uGX0/1SCEMpNNLiyh0zDbiypJalY6S0nXPdtq5q7yA/LYTJcXtxvrtIgy065ZcPPW/Io+AXzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jRVwij46; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id F2452C433C7;
	Fri, 26 Jan 2024 01:10:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706231436;
	bh=UtZZQvws/MkjPDhMY+kb4qtn6ATaFigrvNJEFylyc9E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=jRVwij46wStyHoJrDxVZT+euZcXTa/UG5IeDJwPrt8Dydub4XBTfhiEC0hqvawsgD
	 eAhaXTCj/OwxMbmMdStUwy9FN7fOa/+q0DHTJ9CsWlV23iMAlGpRjJN4VgE/U6WGUF
	 tu0QXCW7IXrSMyhraHVcdDif9BOybT1P8joqcm31ELns8hflk2TjIi8K+z0n8wvBTm
	 KOx1X/HqI+Woe8ZWAmZnVKq/fZuk27ODysT68rJE3tQzC4C7BPd2LL92XCMYYvTcRp
	 Fxl9jnZRM+t8Tu8Tjsio2JBjxubwiNqrDteQOFueqTTTw6s+L+ImHwYJYc5CoAyDNJ
	 4ksUXHdpsTngg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id DC228DFF767;
	Fri, 26 Jan 2024 01:10:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2024-01-25
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170623143589.29940.9604146187451622617.git-patchwork-notify@kernel.org>
Date: Fri, 26 Jan 2024 01:10:35 +0000
References: <20240125104030.B6CA6C433C7@smtp.kernel.org>
In-Reply-To: <20240125104030.B6CA6C433C7@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 25 Jan 2024 10:40:30 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2024-01-25
    https://git.kernel.org/netdev/net-next/c/b54846da4594

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



