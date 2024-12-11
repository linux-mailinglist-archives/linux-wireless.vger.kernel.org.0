Return-Path: <linux-wireless+bounces-16231-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9293F9EC273
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 03:50:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3FFF9168121
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Dec 2024 02:50:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ECE4315ADB4;
	Wed, 11 Dec 2024 02:50:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FMjz+NMp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49262451CD;
	Wed, 11 Dec 2024 02:50:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733885419; cv=none; b=GGQ+aHlISlfdZbMfs4ZZhGLoB3KiIrwt1YvoZf2ArQX1bM26j2NBsK9w74psGU35naosX4XZMpeuAt7wcLj41q5gsu4QmHT4iw2yDW4KES3PHlJW7CnsDBt2VCei7sNddhhpwOILUm3R13XiXYoNZmfZGpOa6pPcCipeyN/PsUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733885419; c=relaxed/simple;
	bh=AH6eukqGjqiGBdw5Sghmn5I87md5cP3h0q2B8+lgnu8=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=r5a+uzdwVpr3AcDRcFCLcLL2rKlaTMPLQvUZ5zEZRFEdOSjz8M7jeE2kb8ByNHSolyHp4OQ0lVeEAH8fB8evPnM4l+9kWj3dC6PSZeReOPZwbyanzJDCK41bK9Uyy0zt+b+aTugCLJ0R6ZaYUinjyFHkuyEnC35uPJcPX7xwlY8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FMjz+NMp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 616A7C4CEDD;
	Wed, 11 Dec 2024 02:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733885416;
	bh=AH6eukqGjqiGBdw5Sghmn5I87md5cP3h0q2B8+lgnu8=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FMjz+NMpIX7OBZBZ3r7xMosl4HmIT0mrL+NQW7JiN3gHGK2sO1TiqpgnERqW3B3/d
	 DT56va9veOpqxSCUu01BozHJcZKsClLfE/i1oOYcoO59LP9yd4T7iUv+Ei73gsdNS5
	 k+UJB30tf4oPn56cA77mC058Mhc9ow7LT3JrMAwcReSr9TakDkwmwPTRs/u5mxYnEP
	 rJRRySeWENpqQJOrgYlyHT/P2cXJTVWaiHwLIXstTcRD19k6obw8YbE1luhcYLHtDr
	 +XkSRew8wPVq185a+tl/LGTy2OasTBtfYdIkPkTFX7QrGFHLdnoCI9Ww4GmxZnrz/h
	 1ZICsGozStlZg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70E3A380A954;
	Wed, 11 Dec 2024 02:50:33 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2024-12-10
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173388543226.1096205.5836225261523879218.git-patchwork-notify@kernel.org>
Date: Wed, 11 Dec 2024 02:50:32 +0000
References: <20241210130145.28618-3-johannes@sipsolutions.net>
In-Reply-To: <20241210130145.28618-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue, 10 Dec 2024 14:01:04 +0100 you wrote:
> Hi,
> 
> For now, we have a reasonably small number of fixes :)
> FWIW our tree was based on -rc1 but net only pulled it
> later, but it should now pull only wireless into net.
> 
> Please pull and let us know if there's any problem.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2024-12-10
    https://git.kernel.org/netdev/net/c/d02af27fa2e8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



