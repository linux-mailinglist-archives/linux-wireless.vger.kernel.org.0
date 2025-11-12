Return-Path: <linux-wireless+bounces-28875-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id DDC23C54076
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 19:57:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 447A34E2E2E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Nov 2025 18:50:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2266B34404F;
	Wed, 12 Nov 2025 18:50:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JpmRYJ8s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED06A340DA6;
	Wed, 12 Nov 2025 18:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762973441; cv=none; b=tbG4wtaedmN2FxijVvnIavASKfcPw5uFE1bSlkzYibOxztYCS85CmjPDohMOb8ThsuVwFveSh+K170H1AZ1W04AfalDYUyyny0wXQcL5uO9esA+Et8nWXlzVIgsVzdvL9p0Dv99hbS3sHsKN6rzfC6Pl28BhkpKyNB2DmTxKcEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762973441; c=relaxed/simple;
	bh=Jfd1mVVET3zcLvxAAtFYxgyk1WYDK92r7vInQvSuNCI=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Q6qrK+mnBnfgqWGk3sEc02A3OMnCzjgdp51PBVxxZpKeIA7ndTRXlQg6dBF3IR4s7qH7e+0IftG0AOHe9JfJK2A0ptrsurNPP79/eTxKLhwP6Ji3ZMn0McE6ggbl+v+OvRxsgyV46yb8pJQv/pzFMQ54ynQSeX2yKAqUdkUJT2U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JpmRYJ8s; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7DDDC4CEF1;
	Wed, 12 Nov 2025 18:50:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1762973440;
	bh=Jfd1mVVET3zcLvxAAtFYxgyk1WYDK92r7vInQvSuNCI=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=JpmRYJ8sYnXKEKcWaxB+zDp8x5+k9s79i2a4bISrr3cSMTqtjq6/LL4HZHKfCg7Uy
	 hqogJywXABnUGazx4o0lU9IdnavnJOBuBG/Vp3+RMp8Ty4yEkAINoPMUYBamhT/fYs
	 bJsch/kPhOeGndvWVsO2AXP3NfZL23S53JqW6RCunaTdlTQ+w+Wo1f+rdR53t1PJHq
	 ShQYEXazun1b0ytBv30bzeRPFk/S1hDeh5U0QJL/RVVc3eqWqVk+ts4dNoF1wQs1vE
	 4SZUzrwcchOFxUBZu//O6kAnSIJANxZG1lU5DIDLhjxTQol4MNZ3D3k4l674mk6rZJ
	 cBdm71AWEp7rw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id ADEDF39EFA62;
	Wed, 12 Nov 2025 18:50:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2025-11-12
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <176297341051.115734.1094983578101044542.git-patchwork-notify@kernel.org>
Date: Wed, 12 Nov 2025 18:50:10 +0000
References: <20251112114621.15716-5-johannes@sipsolutions.net>
In-Reply-To: <20251112114621.15716-5-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 12 Nov 2025 12:45:38 +0100 you wrote:
> Hi,
> 
> And we have another set for net/rc6. Basically just
> more driver fixes trickling in, various small issues.
> 
> Please pull and let us know if there's any problem.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2025-11-12
    https://git.kernel.org/netdev/net/c/fe82c4f8a228

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



