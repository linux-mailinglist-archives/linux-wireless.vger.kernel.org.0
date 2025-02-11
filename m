Return-Path: <linux-wireless+bounces-18735-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EBADA30166
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 03:20:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C6EF27A18B5
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Feb 2025 02:19:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 44BB52AE6A;
	Tue, 11 Feb 2025 02:20:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TEeKJRlj"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18B0622087;
	Tue, 11 Feb 2025 02:20:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739240408; cv=none; b=kNPiPnsnop3jUdSdPw6hGpmH8oEPVbA2GEPX8NCNrV5cz4V7g9G44Q3soSGGYjKv/lszWsOYIdFSnvG7KShS6i8LRIM4mw5yMBrGUeChjdSBW5XHrzwtqZeRFV4RbgWOS8exkrs2jtvB5ReQ2jp2W0SEgrmmZBrvZOqLbPPO7aw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739240408; c=relaxed/simple;
	bh=VY+/8ionxKmfwjQxsDXYmmBDjQzQPrPKcY7WRlFwnjo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mIlkZLjkul6mUgOX5AM46vZEy22i2ZR+Z3MRBHEt6RPRj+YB8KImPOHHiwMc7aUO8cq79r/4wC86FOx/8vyOXurQn4KNsKwAd8P4t2Xt8XDdW45VtHQBgfR9QlXbK8ZHUyiX7QjXtgJ3hM76V5hH2ieoa6WORGZxy6fJmmMmiO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TEeKJRlj; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9062FC4CEDF;
	Tue, 11 Feb 2025 02:20:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739240407;
	bh=VY+/8ionxKmfwjQxsDXYmmBDjQzQPrPKcY7WRlFwnjo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=TEeKJRljgA6FLMCQ8FzM5xdzc4Of4tRmtNjqw0zN64ab1nI+J05Dmk+1mIDlegX7s
	 q+qbII7/VKR7Z91PKpLt6RiLKZtMSb25hVl0gYR2b70nr1aP7Tahdg3ITJC2sa7fO5
	 dzGvrbFEeTn2X8tRsjVeiNH7NsQtlspnaLBuHps3Vo2yI62yhJC4jWN29LZgnfLDwu
	 01WWKmd3ksBFInw/jYxycxmXV8C1vpMjI+DPxi5CBtvnP2OYnHwlO5HUA5XAke+NAl
	 0Kl8wsjpLnqvmBPmUsjC3TMvg86xZ5WBRXgqhhXjHQuYSG/lNsFnRlJhydkOKcD4w5
	 +ftthsMP/roAg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 70EC0380AA7A;
	Tue, 11 Feb 2025 02:20:37 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2025-02-07
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <173924043599.3915440.14928432497399020410.git-patchwork-notify@kernel.org>
Date: Tue, 11 Feb 2025 02:20:35 +0000
References: <20250207182957.23315C4CED1@smtp.kernel.org>
In-Reply-To: <20250207182957.23315C4CED1@smtp.kernel.org>
To: Kalle Valo <kvalo@kernel.org>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri,  7 Feb 2025 18:29:56 +0000 (UTC) you wrote:
> Hi,
> 
> here's a pull request to net tree, more info below. Please let me know if there
> are any problems.
> 
> Kalle
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2025-02-07
    https://git.kernel.org/netdev/net/c/17847ea6ced8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



