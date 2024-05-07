Return-Path: <linux-wireless+bounces-7313-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FD6C8BF32E
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 02:07:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4A60D2888C1
	for <lists+linux-wireless@lfdr.de>; Wed,  8 May 2024 00:07:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90BD61369B1;
	Tue,  7 May 2024 23:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W/iZRA1d"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66DB47EF0C;
	Tue,  7 May 2024 23:50:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715125831; cv=none; b=gBA8ifRfXyOMvnL5unzoVpZrcPf2cpaPeKAi+zOuuKULcJ2rh5qjz0AFarh9NQEmE4PpoTnhEyMWMSZh8vb4acmb6X1R+PPgyJuRj4KOiu1lJu+1ZsxEVj5KJ+vqDm7YknSumiisE3l3v0ckKheAwYG7YgLAWmv6xKGkl3ZdDbc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715125831; c=relaxed/simple;
	bh=AuNMNu8cR7OOK42j3E5iQrR8P6Yee/2/ItRdzr5XcYc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=OR1p4/isMOJqclxwPNtf8xU8ZJvZ/jjTBjhZKwU+7h/mARAsoWG1be4mb9dXTcMDqWzJ28mW/GEA3Qi817EqssIB+uY5NSK3C2YnpsJ7Aw6jtlSWh4ftUaRzxQ/8sNNQ8Gzy1tkvbQ0mRognUpCbB7V71/KHUJAh/Pi6i/RnRRI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W/iZRA1d; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPS id 8A340C3277B;
	Tue,  7 May 2024 23:50:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1715125830;
	bh=AuNMNu8cR7OOK42j3E5iQrR8P6Yee/2/ItRdzr5XcYc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=W/iZRA1dENP1WHj6QOzzQEnw7Yh7qMhAfrEzD9WvMeVYx2DfhlmdPNXGlzpz8i0pz
	 4I1aBqn1phD+71TPf3ca1gNn+fylZi7m+G2XKLa4+EWPrkZ5pQNyTl9gYjBlyok1xU
	 yJoqCm86EXkOQnYJbim/Jg9QRKKoOc49OWlBxPr2pQ4cATObwgxAytdvyDUpYdG6di
	 ug8KbtAizq1shZM+TllEO+YJq7Mk52W6M769gIREvJxNUWBX70eUGHOnavY4gni4Ky
	 BsqsXedP/7drNDDhRCu7DZJAORyZdE3zoGNODNK80aeR5Nf69QJEhXPWc3OEXDJO7Z
	 JTaAsCOZNFRSQ==
Received: from aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (localhost.localdomain [127.0.0.1])
	by aws-us-west-2-korg-oddjob-1.ci.codeaurora.org (Postfix) with ESMTP id 78662C43617;
	Tue,  7 May 2024 23:50:30 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] nfc: nci: Fix kcov check in nci_rx_work()
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <171512583048.28510.14119936834012020359.git-patchwork-notify@kernel.org>
Date: Tue, 07 May 2024 23:50:30 +0000
References: <6d10f829-5a0c-405a-b39a-d7266f3a1a0b@I-love.SAKURA.ne.jp>
In-Reply-To: <6d10f829-5a0c-405a-b39a-d7266f3a1a0b@I-love.SAKURA.ne.jp>
To: Tetsuo Handa <penguin-kernel@I-love.SAKURA.ne.jp>
Cc: ryasuoka@redhat.com, jeremy@jcline.org, krzysztof.kozlowski@linaro.org,
 davem@davemloft.net, syzbot+0438378d6f157baae1a2@syzkaller.appspotmail.com,
 edumazet@google.com, kuba@kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org, pabeni@redhat.com,
 syzkaller-bugs@googlegroups.com, nogikh@google.com, andreyknvl@gmail.com,
 johannes@sipsolutions.net, dvyukov@google.com

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Sun, 5 May 2024 19:36:49 +0900 you wrote:
> Commit 7e8cdc97148c ("nfc: Add KCOV annotations") added
> kcov_remote_start_common()/kcov_remote_stop() pair into nci_rx_work(),
> with an assumption that kcov_remote_stop() is called upon continue of
> the for loop. But commit d24b03535e5e ("nfc: nci: Fix uninit-value in
> nci_dev_up and nci_ntf_packet") forgot to call kcov_remote_stop() before
> break of the for loop.
> 
> [...]

Here is the summary with links:
  - nfc: nci: Fix kcov check in nci_rx_work()
    https://git.kernel.org/netdev/net/c/19e35f24750d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



