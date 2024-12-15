Return-Path: <linux-wireless+bounces-16401-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0F569F268A
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Dec 2024 23:20:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D4DDF7A02C2
	for <lists+linux-wireless@lfdr.de>; Sun, 15 Dec 2024 22:20:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8614A18C34B;
	Sun, 15 Dec 2024 22:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eP5tyUC7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55ED61442E8;
	Sun, 15 Dec 2024 22:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734301211; cv=none; b=JfAjAbRqklKBbLlgaa+qHKKV7toTVp4CKz+/vfms9H/eNFwjt0bIuCFp++H2b6SwYEbwxtQCyjMMIGEUOovYfL6sOKgWqfnSigWzypW0OXNspv2aN3BsKNDh7wx213jMxFUpIOsvNyFl8fy9BR37Tu6t2DQmPquWYPPSRBg9czg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734301211; c=relaxed/simple;
	bh=+f/3R0qpROTHLJvl7CebrBCCFdNqcTYDyYpt0tn2/Os=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=reIEmMBdkoZA/F7OYcA41Lu0m49Z14puCwRcTW1fFZSQUJLZ9Yhe5vA5+eeHuOez8gfPxTsZdMRbG6F0GRuwGvxHF51ZciArHDYf5JeX5wSB4bvpEyMwTuwZiXsRsmnQp8NGZhiSeBzlMwf/u/+A1kylng831VewqVq+l9wMTaQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eP5tyUC7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CE3F5C4CECE;
	Sun, 15 Dec 2024 22:20:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734301210;
	bh=+f/3R0qpROTHLJvl7CebrBCCFdNqcTYDyYpt0tn2/Os=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=eP5tyUC7btHFwOsrjrKhd35N32EClIU1kwyNTnnhW2ngFjKFYGOYs5AhbAyATpfbW
	 4LgOIuSphtDymSbSXz1MMb2/JRwv12LLiBUJS859enf1JamnHfPjecwa11iQxJeE5f
	 bPo7f9ZqjT+y/O27DP4kG9VbrQB34yXLbyae08xOnuJvsYBE+5VJxXOjH18hJRL2D/
	 LR/XpUDWiCx3oB+a7yyJ5k5ZHIDqmhlYTt7aMHoek/vNJqC7t29FxttZqevtLq03yA
	 cZ6z2BZaJpr9qpk12eVNlTijrAaGMlqm8C3rAGeehYeeoDzLH4GVIIjn9/2JsTPveM
	 j7n+kKgyWQ2Tg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EB3893806656;
	Sun, 15 Dec 2024 22:20:28 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH net-next v4 0/2] Converge on using secs_to_jiffies() in netdev
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173430122779.3593151.18169196230893738996.git-patchwork-notify@kernel.org>
Date: Sun, 15 Dec 2024 22:20:27 +0000
References: <20241212-netdev-converge-secs-to-jiffies-v4-0-6dac97a6d6ab@linux.microsoft.com>
In-Reply-To: <20241212-netdev-converge-secs-to-jiffies-v4-0-6dac97a6d6ab@linux.microsoft.com>
To: Easwar Hariharan <eahariha@linux.microsoft.com>
Cc: jeroendb@google.com, pkaligineedi@google.com, shailend@google.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, kvalo@kernel.org, jjohnson@kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
 quic_jjohnson@quicinc.com

Hello:

This series was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 12 Dec 2024 17:33:00 +0000 you wrote:
> These patches are pulled out from v2 [1] and v3 [2] of my series to be sent
> through netdev. The series converts users of msecs_to_jiffies() that need
> seconds-denominated timeouts to the new secs_to_jiffies() API in
> include/linux/jiffies.h to avoid the multiplication with 1000 or MSEC_PER_SEC.
> 
> [1]: https://lore.kernel.org/r/20241115-converge-secs-to-jiffies-v2-0-911fb7595e79@linux.microsoft.com
> [2]: https://lore.kernel.org/r/20241210-converge-secs-to-jiffies-v3-0-ddfefd7e9f2a@linux.microsoft.com
> 
> [...]

Here is the summary with links:
  - [net-next,v4,1/2] gve: Convert timeouts to secs_to_jiffies()
    https://git.kernel.org/netdev/net-next/c/734ff310d38c
  - [net-next,v4,2/2] wifi: ath11k: Convert timeouts to secs_to_jiffies()
    (no matching commit)

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



