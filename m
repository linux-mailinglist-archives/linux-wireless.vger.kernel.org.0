Return-Path: <linux-wireless+bounces-3942-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CE8038606E6
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Feb 2024 00:27:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2C365287DD2
	for <lists+linux-wireless@lfdr.de>; Thu, 22 Feb 2024 23:27:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 28D1B1BDE5;
	Thu, 22 Feb 2024 23:20:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYHoG7es"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2ABC1B7EB;
	Thu, 22 Feb 2024 23:20:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708644037; cv=none; b=MFDYDqFxiRzY2fw5vgv7pN3B/ch4reGRUxFb8+yZ5br+6Hah61P4ow3dYI/13q17ElpMe8HQJwmhw9rN8E2P0DmmMgQyziyDx/QpubmfXf0eQ+QZmTYx9c5rKpJFBTNreAXiwsyPtplle3myqz34Q+wWHZUPJyNMLyy82cCR0go=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708644037; c=relaxed/simple;
	bh=tupfOaPlLKD46f7Cxqwyln3VBqnWjtH5zRO0L8itNtA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Oy+09Dc4MgUEAFDZzMdLIwtBfBH7mcIr2f4W4zZe0CciGG5IXe92+g2wTsEqtp6ddTSdMVUN8tA9RZwCDL4/i2E/FiNTkSsOPfLWi+R3zqxvmoGpbb7Vmzcqtdxim8/xqGshNnFPSWWHPNS9UxvH6TBAGeC9AEyJGhA3GQYVY48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYHoG7es; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 7E4FAC433C7;
	Thu, 22 Feb 2024 23:20:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708644036;
	bh=tupfOaPlLKD46f7Cxqwyln3VBqnWjtH5zRO0L8itNtA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=IYHoG7eszn7rtTPo5L+D0aaoLv3ZpVPwETGoTvi3t7ItRwrvGcxWO8HMVRHON6z9y
	 N24gcwxnDqt+fMjOryEv86fw4XdeFCEPcxKaY4ANbhfMT2g2d75malRveHO1HYVauj
	 gwVpBrmwgssIFd6uxWxlz/OWYsleYpjzVyXrOECcblCFt18dv35GnkLA0abcza0YsL
	 pKCVc9X1p0cwC71fxxNF1rWM8fUMU12h9O7G14yqLxht62ftGKw+XgeI6cyhzCjkww
	 hyoKr0R99SvN4Etza8HG0/Rxb4bEtEraunm+FJ+DDowpEEmoWheJ3XBYczsvIbGVEv
	 ogMACPlGGOuqQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 63220D84BB8;
	Thu, 22 Feb 2024 23:20:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2024-02-22
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170864403639.27768.3348497206454416990.git-patchwork-notify@kernel.org>
Date: Thu, 22 Feb 2024 23:20:36 +0000
References: <20240222105205.CEC54C433F1@smtp.kernel.org>
In-Reply-To: <20240222105205.CEC54C433F1@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 22 Feb 2024 10:52:05 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2024-02-22
    https://git.kernel.org/netdev/net-next/c/0fb848d1a41e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



