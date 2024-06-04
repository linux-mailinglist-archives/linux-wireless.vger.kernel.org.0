Return-Path: <linux-wireless+bounces-8456-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C90C8FA801
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 04:00:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 05D3F28EB0A
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Jun 2024 02:00:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 264B113D2B7;
	Tue,  4 Jun 2024 02:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NDlrlJA0"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEA232B2CC;
	Tue,  4 Jun 2024 02:00:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717466433; cv=none; b=XU17FVOYjxA8BXnCjGT5tP7kCrLd/KQjGFD1uyI9zXsLnYkeviyY6awcMlopYabwRJpr6m4fsw1OgVzXkbxHz/lf9fjv+XU4YuYBi/hmP9oHqifOJ6gbbhVr5Dkk6q3IEbXNrAf7tJGXA0T3r0PKC2RQw7JHStY9ytgCFCd/Ah8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717466433; c=relaxed/simple;
	bh=MGgbn5kZ14rxYP4A7MCIr+5MRhw1ldFzVJyvs/xPLE8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Ky0YATC1kXVtobUklwKTIFQYoqJb6cwZoTT1RotqOIEyLJZYF8S+exsqiLNidA4zLMlEvJnPE0t8K9KeRxqqsvg/uCbmzjAazuueCsjpPJx3L6KTS9g1/LQe3WJC6Xlv0ZxMwneyuNQsDrqNv0ixlvaxLwTredjCVR4KhbTrU7U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NDlrlJA0; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A8029C4AF0B;
	Tue,  4 Jun 2024 02:00:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717466432;
	bh=MGgbn5kZ14rxYP4A7MCIr+5MRhw1ldFzVJyvs/xPLE8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=NDlrlJA0+JHOAewKlpILdy2lq+0xBQlLanc6DHILClp4JqqSR3xqwxjEsgxM4FpLt
	 9HGXFTPYhpt5/n1/X5qqnyTF1iyYQW6NVY/M7HA7+aIfMSqP8xARQtyi7xDUAu579n
	 8QjmEhA0UsYei4z0p6PP8dq0ziZDb93C2N5dovOlrpBmeGfcCU2FZwXM7mX3TUCdRC
	 AjqnF0utPWAgRAXUZUrcu8EHbtnSgLuch3Fvy0A7kD3Pq2iBBz7Crz6clQPmALhfy3
	 rb7gYkHNSZNZdzV3T+YmlyVGPpguJ6W3vgA2K+XQ6zsINdZILevxLBZCihZvJ11p4p
	 Q6SOJKVcd5eyQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 956AED40160;
	Tue,  4 Jun 2024 02:00:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2024-06-03
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171746643260.10384.9149617340863719251.git-patchwork-notify@kernel.org>
Date: Tue, 04 Jun 2024 02:00:32 +0000
References: <20240603115129.9494CC2BD10@smtp.kernel.org>
In-Reply-To: <20240603115129.9494CC2BD10@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  3 Jun 2024 11:51:29 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net tree, more info below. Please let me know if there
> are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2024-06-03
    https://git.kernel.org/netdev/net/c/d6301802607b

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



