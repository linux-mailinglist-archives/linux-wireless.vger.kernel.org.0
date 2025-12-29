Return-Path: <linux-wireless+bounces-30163-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B5082CE74EA
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 17:13:33 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 62CF73010FDD
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Dec 2025 16:13:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 13ABC32ED34;
	Mon, 29 Dec 2025 16:13:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LtiLcenL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE1C832E750;
	Mon, 29 Dec 2025 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1767024811; cv=none; b=tMVMrH+5TdbesGdoNQ+JEw0GQxRcvMqADx7xd5dgISQxmdBNQyW1n2agvgGlB6fNOLWbyjHO461zfVyarTsyI20OxEyu4D0AbXFeRVyXCqEot34EHHTTU5Qe+Cutf7gOJiLabL8Q3lBawwvYoKz4/5+Yfu9vYt/MRapu93fVfAM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1767024811; c=relaxed/simple;
	bh=KvvIUZMqRvhgusL0SexTKBmx/xATApomYnBE6m6MIgQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=FDznsJ4EXxZ1MxqiQzggudIBkBMzqjvmhVzQRkupMwI0ElQjVjHzwvDVKLq8jLygULAOMc04bgFJS7Xupvp11nAIadCqRzR0XnhCK9M9qC4mKd2R2VEcleRQOrstu7b903Mg55m54L6P0uS9wtF8dIX6+a7/wlx60UWwP/PHmxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LtiLcenL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6734EC4CEF7;
	Mon, 29 Dec 2025 16:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1767024810;
	bh=KvvIUZMqRvhgusL0SexTKBmx/xATApomYnBE6m6MIgQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LtiLcenLSiAly2vUb9s+FkEklgwbP9kdoskQqhbTzrurWlaQJEE0Ek3ATkElXoFEF
	 OQdcuG135kad0fKeOh4ESOoi5MskXuE1VWpj5M7A4U7zWKpLYORWEW2fB9/wxA9LrA
	 LXDF4aVZCX6JZ7iahZcHofZjv5j4DHjDEFHZufOukHYWWjvAgG/rhNuBs3KQ5u18yX
	 XVENIbQtRqNOEaGrxtgObr7kc2cd6e7uQo4YIq57+8g9OLEGuCVNd6gFAr9wPvUd6l
	 X1MkqSQcqu77vRmt+WD9P/RP9nvxEbLOjn61X8G7DVOWRjhRybiC0JyJozaycBCNK4
	 m533Lsfd96/5A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3B7B43808200;
	Mon, 29 Dec 2025 16:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2025-12-17
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176702461304.2997313.8145325048246369890.git-patchwork-notify@kernel.org>
Date: Mon, 29 Dec 2025 16:10:13 +0000
References: <20251217201441.59876-3-johannes@sipsolutions.net>
In-Reply-To: <20251217201441.59876-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Wed, 17 Dec 2025 21:12:20 +0100 you wrote:
> Hi,
> 
> First set of changes for -rc, and then I'm pretty much ready
> to sign off for vacations for a bit, I hope nothing critical
> comes up.
> 
> The tag message is almost bigger than the code changes which
> I'd say isn't a bad sign :)
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2025-12-17
    https://git.kernel.org/netdev/net/c/a6694b7e39b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



