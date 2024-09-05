Return-Path: <linux-wireless+bounces-12510-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F02A796CBBE
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 02:30:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AE7DB1F2738C
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Sep 2024 00:30:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 365A51EBFF4;
	Thu,  5 Sep 2024 00:30:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BUiZxAu7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EA5E38C;
	Thu,  5 Sep 2024 00:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725496230; cv=none; b=krPrGmiLVkzcmXIkymDDg3f/MEgnJICvBOLaRz1r8PjMhSFMtlvKGJPbDr+MEs6JTb1WHtaq18T9Q1SaVxQp5RLPubcKNZexQvJudAReh1OKOZJLNEyHr1fIPZkMd7zahEjNyoe+ioz+5ZYJwOV6vvstaPYav2TIIOQO0PCX3ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725496230; c=relaxed/simple;
	bh=V7JTR33MLtLdXBOdA2sH6Qmk65T8ru9KLAYwRE45Ywg=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=QGNUzmocaWBJ9kaJ+Qw6EiTBUe70HWuwO/XbMABgAagVCSDALQm9SApSgEzEZlp5PJoOAHpsB/LPmx8FEgEQUVlEFhklWD4OK42UIz392UBQr7cx8iZ6S1VzOO9MlaFR485GjcGF6Eo0H2m1QA/na6bpJ4x/VjMCqqOmxt8tfBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BUiZxAu7; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75CC3C4CEC2;
	Thu,  5 Sep 2024 00:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1725496229;
	bh=V7JTR33MLtLdXBOdA2sH6Qmk65T8ru9KLAYwRE45Ywg=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=BUiZxAu7tU8bwLo2TERTVF8bt1MOS3SSJW3vnJ4DisLPYywcnEk/Zpnf4FVTOY4q5
	 C/kzCO70a8+/oOoaPyPAIA8W0hFetQa0ocqWMKvv1wMfK4YyfougBsPluwYVt59Wcf
	 nNMJpondOBMRDWQApj3jZbxEvERwrMfXmluB85sqOurKXGkBK9ei+NQOj2P5go8jlu
	 YfRGKqDDRLewkWEvJ8l1KwMG2lNH/CpfrJVNxNXZfuO2R1MDJi2VHf1ac02fg6G0Z4
	 m60jSomp4p6gxfPFngQn7UIIt0dvJcRMbzJmORhHrnP6jn7A8yI+pz8cUKSUZyVZ8W
	 x0lV609Hrizzg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70CA23822D30;
	Thu,  5 Sep 2024 00:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2024-09-04
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <172549623027.1210487.572565359570819348.git-patchwork-notify@kernel.org>
Date: Thu, 05 Sep 2024 00:30:30 +0000
References: <20240904135906.5986EC4CECA@smtp.kernel.org>
In-Reply-To: <20240904135906.5986EC4CECA@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  4 Sep 2024 13:59:06 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net tree, more info below. Please let me know if there
> are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2024-09-04
    https://git.kernel.org/netdev/net/c/2603d3152b1f

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



