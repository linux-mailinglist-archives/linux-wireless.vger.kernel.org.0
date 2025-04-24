Return-Path: <linux-wireless+bounces-22013-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3672EA9B636
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 20:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 70EAF5A00FA
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Apr 2025 18:20:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 290742918DB;
	Thu, 24 Apr 2025 18:20:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FphviHRq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3CFF2918D5;
	Thu, 24 Apr 2025 18:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745518801; cv=none; b=WAdGumuusoKBfu84IpT6A+hl/BGjctxFkN2xO7iwvj9SwJx0g/q6JV5iwufdCCgflFr2cKIe3osQRnH2dTJpMQjaQ/hSqRL/rlEl00vEIvXBGXOw9JX8zKvsV0R2yTgBpwDJWAcOlYOIxb3m/jZOfqkVukrksKSHiI25+PNsODk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745518801; c=relaxed/simple;
	bh=A1MPRpwZUKWu83PMxe2/nf2hv/u+MNTQCN1PJOhMKaE=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IRehSfqsXi3+QZpPmotS75NRe1axDT56t0OzcFP4dRztbC1mcfXTAv3xv+CpIS8OE3odzt+hr+TgJVH04jPRlOHwCwh8juwAauDwpohdDo7UIGQEFdHkrx4YKMrCve0mz8Ebf9irxR2X+dI3HUQTFRSgwc969Kdy65HsoAKuVS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FphviHRq; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4970C4CEE3;
	Thu, 24 Apr 2025 18:20:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1745518800;
	bh=A1MPRpwZUKWu83PMxe2/nf2hv/u+MNTQCN1PJOhMKaE=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=FphviHRqpawxr/+Y+N7BvwwUc+Q6KnfvnpEeQC2QVYMcKnAMF4qYAx2MYmlD01Qpw
	 gU5Plf5Yqj25HPij9+DKVGlUzgSm12Ru/joudps+JdDAWFZsyWE5qXAluH9i5sELmy
	 SoxpB/OE4Nz3uGg+AQ96rhSlQ1Jufio5vUNW/zhh9hFt7UflJJKJrqzMwjKUrt8ohd
	 cVZayo21Dc3HAaEI6vgYDrbsxdryvjn7jIzjM7gVJqSRzJ5L/TNZ6UZ1cTeY/BrEEm
	 fVbNwgDwZHL7ERpins+tKlUIAVGIqx6ndpYHbCJtV3kPzUHyRTzfbpJ8whFEyCekNG
	 FaOajmazMQmhw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADC85380CFD9;
	Thu, 24 Apr 2025 18:20:40 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2025-04-24
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174551883928.3443031.14767697128423802990.git-patchwork-notify@kernel.org>
Date: Thu, 24 Apr 2025 18:20:39 +0000
References: <20250424120535.56499-3-johannes@sipsolutions.net>
In-Reply-To: <20250424120535.56499-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 24 Apr 2025 14:04:57 +0200 you wrote:
> Hi,
> 
> Got a bit late due to holidays/vacations, but here are
> a couple of fixes, including somewhat high profile
> regressions for some devices in iwlwifi.
> 
> Please pull and let us know if there's any problem.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2025-04-24
    https://git.kernel.org/netdev/net/c/30763f1adf69

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



