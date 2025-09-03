Return-Path: <linux-wireless+bounces-26980-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A460DB42C6F
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Sep 2025 00:00:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75280162038
	for <lists+linux-wireless@lfdr.de>; Wed,  3 Sep 2025 22:00:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 782872ED151;
	Wed,  3 Sep 2025 22:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N1ktGG9/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5070A2ECE85;
	Wed,  3 Sep 2025 22:00:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756936805; cv=none; b=FSIz/OKGkrekFeO8AqXjG3hirjg4Ngm00p2hdmBdXPJvIGDEK11NYvax9fcaU5BkUZNEhvNyHAgkb92dTcG4E5qiyKEjU7EPDQWCx99KhcXf1rwVpHDfq8ymAn5h/R/vJiH39V3lpjVtKT2/q4wqRp4xU/ABw7ReVbnO524MvEA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756936805; c=relaxed/simple;
	bh=j2uz/uBc95ntK406fyB0Vzgd7wrrK7lbbgNWWZf4d8M=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OBRj6UZbNVDsnve5GUHkCRn7tmDJuDb6IdYsRosqp1e5/BDG0ZI/DaLgUJLbthQqw5zuFvvbZ/Wq3xI4FP9hJIRHUV2/utjGwytN/NKtT3r96qSFfygU9P1VqD7e1bj5aIItKbXgZW3I6+dBbJ7uFXNZrzfcfS/Rs5R5b52/mjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N1ktGG9/; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D6212C4CEE7;
	Wed,  3 Sep 2025 22:00:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756936804;
	bh=j2uz/uBc95ntK406fyB0Vzgd7wrrK7lbbgNWWZf4d8M=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=N1ktGG9/wrP7GMvTulUqibncIHIs8Yc9OUcSgRQaa6j6yV7b77l26AAB1Ip94OLz2
	 ElAHI3NVG0z7y01ALkf2TG/bZZiBmkR/O362ru41Vq3dy82x3HoAN1hgMeAs9hzeqa
	 q+DjmY31FgG83GclqoDnt5liBbtkLPuSqkGR8LUPr2wVtYXngM8LMwB6HJJaD/hTzo
	 51f94L3GK99qSuIanJ9LgqUFA8b5lQa3m5v75EkCJeeKXpAZYCbw9WkDQqUEH+MKux
	 Em6u2Hq2/8bmCmLYX/PqJSc8m6hgaq6Cmaj17P7AItfs8E16SEKhQm0QzSMx/621cE
	 mR8y7vqfO39aQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 33CFD383C259;
	Wed,  3 Sep 2025 22:00:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2025-09-03
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <175693681001.1214607.6796099697795000995.git-patchwork-notify@kernel.org>
Date: Wed, 03 Sep 2025 22:00:10 +0000
References: <20250903075602.30263-4-johannes@sipsolutions.net>
In-Reply-To: <20250903075602.30263-4-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Sep 2025 09:55:25 +0200 you wrote:
> Hi,
> 
> Just a few fixes this time, mostly buffer overflows and two
> Qualcomm driver fixes. I know there's some more stuff coming
> for iwlwifi, but I didn't have it yet.
> 
> Please pull and let us know if there's any problem.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2025-09-03
    https://git.kernel.org/netdev/net/c/c5142df58d5a

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



