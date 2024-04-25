Return-Path: <linux-wireless+bounces-6832-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BBB9F8B2018
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 13:20:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E28E6B21D46
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Apr 2024 11:20:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8D5E84E1E;
	Thu, 25 Apr 2024 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tXcuZaUr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9EDD422616;
	Thu, 25 Apr 2024 11:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714044031; cv=none; b=OxTBpFxRgdgV3Lu8IKeUSpVjlxUxJszLzClWAx82bArftW13JUMUeEIGdRV+Lp1BnCWFMRt39OMV1fYsxGO9bSQaM53rbv9608koJyr2v7J3Msa4DPhV18fLxWKOJNw+kwdqu9En6VyqeOWuBhdEKq1tEN3znhIl4wPYcTPDbKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714044031; c=relaxed/simple;
	bh=U7N/F+ZlTKnsd2pAByfZUzfbS4YByQ4z+sByjuyxYHk=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TTpvGQ5W2OhVzsHJzNIPnsy9MTYgwwad/LUN4gc3b/T0rXzX3BcmlCwC+2hP5JUPYZaixIWA0zeJM+Q8NOYgnP/C0ThM3Ndyn9iHY1tSEHXKMzSnGa1PTznI7jalh2XKW85Pl2429vp9MjflnS9BkHsy3T41jfAVGoD47qS6cts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tXcuZaUr; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 47E7CC113CE;
	Thu, 25 Apr 2024 11:20:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1714044031;
	bh=U7N/F+ZlTKnsd2pAByfZUzfbS4YByQ4z+sByjuyxYHk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=tXcuZaUrXAFVTxIWa/9CyxNnudR/CBSNkwwhUz65mTUOLBOasULeG6wyZ5nqzAjRz
	 fT/mHPggPfOmALHgXlN83HOMLr/Em4n1v1FmjqG8z/6L+PYHF2n6C6sh3LK6ZVJKDv
	 PfRM0Y4zWmxiQf+wL3NrmQ1q1TU/Ek3NjlXX5pXPeJTpp5XmtEKp010VFfOvy8C3DA
	 YIlEJUTALwEtYKQ7RCjDP7utMByRiiqp4fo64lwkylFB5lN67SmcFOIdygkz85mIqj
	 n4ipMd9ISHLXu2sjsBN1/efMTA/lbr1rrq4riKbb3fcd9LijANbvlh9fSd3+BWyIj1
	 1AKv8R3UT3WNw==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 35DF3C43140;
	Thu, 25 Apr 2024 11:20:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: pull-request: wireless-2024-04-23
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171404403121.25442.5300393610522024563.git-patchwork-notify@kernel.org>
Date: Thu, 25 Apr 2024 11:20:31 +0000
References: <20240423095910.11779-3-johannes@sipsolutions.net>
In-Reply-To: <20240423095910.11779-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net.git (main)
by David S. Miller <davem@davemloft.net>:

On Tue, 23 Apr 2024 11:57:37 +0200 you wrote:
> Hi,
> 
> Probably should've sent some of this earlier, but here we are
> now. Mostly stack fixes, but one important (link ID management)
> fix for iwlwifi as well, where older devices were completely
> broken.
> 
> [...]

Here is the summary with links:
  - pull-request: wireless-2024-04-23
    https://git.kernel.org/netdev/net/c/46bf0c9ab794

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



