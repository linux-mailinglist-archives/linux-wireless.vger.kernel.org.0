Return-Path: <linux-wireless+bounces-9014-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F1CF490911A
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 19:10:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4FF6AB20A50
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 17:10:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5042D1802CF;
	Fri, 14 Jun 2024 17:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lW5npmRs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 25EE12B9A5;
	Fri, 14 Jun 2024 17:10:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718385032; cv=none; b=G6uUU3j3v6kqs+DfHmx29GDhYzIpQn6lgc+STfrnuVyetv75w4cqHnch1JGGZTHb+72kQjnNLvIXsH7zCPUkMuRTLObkPDDz/xANJYtnVP2JzMA1LQpk3dLrcZlVv9BrybieclfRnbxYbIGYjWMIzTB9zI8Wj2dSeohC2Qeyu4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718385032; c=relaxed/simple;
	bh=IJNtTxfAXmQvH2M/yWX53Qa5OMUCup/z1Y4Es2Injzc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=dbduBW1Cx93jaGblfrWlOmPAoLLUvz41mY36KGrBYTg69MvXcl8SWHyE5L+2b7wQ9rK9+ZnF3unnqxEpqGTJtY9S2SE7L0y/XV3TYsAcGV+mgnIwhRNYO3zHHgbJmldM0lHFHjE6cGElTU89cIs83cI3qlnawic6k2uoOfY3OoE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lW5npmRs; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id A1A57C32786;
	Fri, 14 Jun 2024 17:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1718385031;
	bh=IJNtTxfAXmQvH2M/yWX53Qa5OMUCup/z1Y4Es2Injzc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=lW5npmRsFXiSu42c8dLIjnbArr/cgbjU06dJhV0k97HviU5bExZI0Kp+qROkKLKZO
	 ZO25vfJv9RQhHlNbE960Gria/oVJPHSdBtn4Yr+7WslOboz8hGr7TLfYCZaeCgFssr
	 WhMfh2JLG59p0Yq5gLk5Q9LbYOGbIBMIkDMCJyeWI6NlmzqE5rtpM98pae/pYc6Vrv
	 B0PhS5cdXSemDkxbSHIuyiLW+P3Vr1OxW/Q7aarqyZkspklBOcZDCKMS8e+bTl+Qit
	 SDbV+wiDNmk2ltSsZ9AaBLLg0+4a3qr+KdenOIR/T3kr+CPXIKwngO7/6lUeKpMDwB
	 L7CHvo8JsfzJg==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 8E120C43616;
	Fri, 14 Jun 2024 17:10:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2024-06-14
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171838503157.5042.16909183523736796439.git-patchwork-notify@kernel.org>
Date: Fri, 14 Jun 2024 17:10:31 +0000
References: <20240614085710.24103-3-johannes@sipsolutions.net>
In-Reply-To: <20240614085710.24103-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 14 Jun 2024 10:56:44 +0200 you wrote:
> Hi,
> 
> Here are a couple of fixes for net, including one for the
> monitor mode regression you'd asked about.
> 
> Please pull and let us know if there's any problem.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2024-06-14
    https://git.kernel.org/netdev/net/c/1afe4a64379f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



