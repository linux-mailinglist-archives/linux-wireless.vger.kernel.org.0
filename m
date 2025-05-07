Return-Path: <linux-wireless+bounces-22702-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 368A6AAD349
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 04:31:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4890E98452F
	for <lists+linux-wireless@lfdr.de>; Wed,  7 May 2025 02:31:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F98670824;
	Wed,  7 May 2025 02:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LCCKdfD+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35A3863A9;
	Wed,  7 May 2025 02:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746585088; cv=none; b=W/grJAH8MDDGf5UvXL6EGzu5/PLvrdcPdLu8buAXLhB4Un5jQ0HL8uCJpSHBIsFrELHnX5/4emxnGjZYLggVuiWMSKvq6CMJKX809xuzIlWRiQ7gswYkVSg3anXcDmy2nPTyeAw4m7tQwkKGJvPNQnG4hRcj/JP+yzrFv9FhQ4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746585088; c=relaxed/simple;
	bh=DyTEPxWntaFNxHGgzuHtcAtkriRPOMAT85xAE+UHzbQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=WKPhfwU24WnyyFsNislUOJkHOP2V/21sSKRR9paLA2iDYlJbRHLOntXX3o5RpslhDi7+949EL7aqa5Ygap+psZAt8dMLh4z9BSTOOc3znEedHoO4Uf6abDW13nGMa73nshW/zD48uK5cgNo9tSz1arz8gpUPBioJXLNL8ktVpKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LCCKdfD+; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A63F7C4CEE4;
	Wed,  7 May 2025 02:31:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1746585087;
	bh=DyTEPxWntaFNxHGgzuHtcAtkriRPOMAT85xAE+UHzbQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=LCCKdfD+dWnLWYAL4oC9IxGEDnfHI+kO2uowBvr7y7jqknkZiZ3YUEdhF6sFXdiyd
	 y7vSBYj/lSAhDd/BUf5vXWeLijoMHu0BuK04eDJNtypKPA7qcDf01VHqYRsozsNiAQ
	 uA6cGER4FB2+ukxY97Egat3mzbmP+i1fTZsmacNf9aoKVpkJldEnhcYiQqs0+tC+fR
	 fyXmKsc99NCf56GBLYjuW/dgURD9mcM1V0FcB//dABk+/n5WYCBQeIoTyVbLAJ0s1L
	 wgUx1XJWNnJMdbsJtxIGpKIeKx7grVIBrluUhfxYGTCqNUtQP82qs7ETepUyh3slmd
	 m0/Emu/7V8LmQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id EAD67380664B;
	Wed,  7 May 2025 02:32:07 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-next-2025-05-06
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <174658512675.1714803.1604876921547589955.git-patchwork-notify@kernel.org>
Date: Wed, 07 May 2025 02:32:06 +0000
References: <20250506174656.119970-3-johannes@sipsolutions.net>
In-Reply-To: <20250506174656.119970-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Tue,  6 May 2025 19:45:31 +0200 you wrote:
> Hi,
> 
> Here's another set of patches for -next, but I know there's
> more coming, especially from iwlwifi.
> 
> There are some conflicts here in iwlwifi, please just take
> the wireless-next version for them.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-next-2025-05-06
    https://git.kernel.org/netdev/net-next/c/9daaf1978600

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



