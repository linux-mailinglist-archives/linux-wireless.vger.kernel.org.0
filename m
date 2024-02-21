Return-Path: <linux-wireless+bounces-3854-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id E7FC585D76D
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 12:51:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 206FC1C213B6
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 11:51:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A07FD46B9B;
	Wed, 21 Feb 2024 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCRvdoZm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 765423FB3C;
	Wed, 21 Feb 2024 11:51:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708516262; cv=none; b=ftJRZadkJy5S82MImI/vjjbUNpf2E84BZkJ0kxs39XC43aVz6gdNA0H7VgwBnrfUF4YyuQHx3N44H9+Zs87I7xlmmKjiXjP17KQCEK//8ozmRW/LdEt1zTX928xtaTyzdiXnZrPwpiNYxGNEJFSr50dQ7r7MuQ4hgjtEFQaAcm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708516262; c=relaxed/simple;
	bh=T3IfC7ZxaC5hk27hprc7z7nYY+yW/UU/ZR/tlsxmKsM=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=utT7OiIJQn5/65HswTDtYYfIe12Pm0rT1H0lXrRTY2wkmRQLsrlHTWR5ReJrv5z/nktRuPeC6/WOMOo/r8DDMHP8uLRzMrFyzVAVRywuyBvHoVvmWOmwsJttu7p+cW2mY2tMPDT0WjBSaiCKJmNTpTwp6yaXcyZLya3x0+KDQ28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCRvdoZm; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id DE40DC43390;
	Wed, 21 Feb 2024 11:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1708516261;
	bh=T3IfC7ZxaC5hk27hprc7z7nYY+yW/UU/ZR/tlsxmKsM=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=kCRvdoZmbV9Jfu3gz03eMqmBn7Osfb4T4l6++xLCINWPCwnwyv/9uBFTw9u+CUrTW
	 0V79+NxDhD+t/Ny9iKNy+H0EC/1x0Fz/7+uBVb/OXdxMO84RIa8FpKhR9MS7T7GjRm
	 BegjQQPW8Q+Ek7O2ZM0j+hPVTVQhGDC3Fvm9duPk3L/HSDXUS22Vc/CwD4sbtXT6KG
	 3IwhmBuMclDqCjfN7GAerY+ukZmC0AB5bq3lhbs7ui/3aE3Fi0o7tTgJNqALiZXmQM
	 wJlqZ5/QNYM3W7xDUNqGA7VzA75yeJXeBdxRJWyzl4IRMOSaVRr9hGiXE99Mvxy+0+
	 IO4y1JdarZXhA==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id B888BC04E32;
	Wed, 21 Feb 2024 11:51:01 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-next-2024-02-20
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <170851626175.27414.11082074288996450859.git-patchwork-notify@kernel.org>
Date: Wed, 21 Feb 2024 11:51:01 +0000
References: <20240220165842.917CDC433F1@smtp.kernel.org>
In-Reply-To: <20240220165842.917CDC433F1@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 20 Feb 2024 16:58:42 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net-next tree, more info below. Please let me know if
> there are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-next-2024-02-20
    https://git.kernel.org/netdev/net-next/c/e199c4ba8260

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



