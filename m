Return-Path: <linux-wireless+bounces-37083-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id uOLAHNfZGGpDoAgAu9opvQ
	(envelope-from <linux-wireless+bounces-37083-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 02:12:07 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 784455FBA0F
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 02:12:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 47CD330046A9
	for <lists+linux-wireless@lfdr.de>; Fri, 29 May 2026 00:12:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F1F558834;
	Fri, 29 May 2026 00:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="TjgtBvlk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DE6DF59;
	Fri, 29 May 2026 00:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780013518; cv=none; b=p+re4HiFRlPoz/tCREW1BcJNzxri/tduChd7WyiuJ69r8Jof/4KF3WCH6xiIyMExFmn3BLbJ54PHWFFVTe9TQtkavNuzn5Bi+zyLYREU7MI1lAbbGOx5L5itibr/3KNj3p4KEaedIsZry2GNf+YiKvnZtfd8G+EX+HAFkwJgKBU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780013518; c=relaxed/simple;
	bh=ceAOd84t3yp9huEL/bSjY33EFu+RYAbJJ0Q68GnEesw=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ttssrFliwZOBdNIYFXGPRxsmDIrmq60YYzZ8ikbUKHGXhk+UKA2SZ0bpqArN09UDM3DBizb7rYQTG6Eb1yGS8NsCkLqF8vRM22XdzV41cIO1XTtlnzjD/cLYiZvjawq2mTnd6/j3Zjl8G88/Yi7o9QTh91+BOB8WQwPgnDhpFr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=TjgtBvlk; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B72C01F000E9;
	Fri, 29 May 2026 00:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780013517;
	bh=bpADtKUVdLn6vRP8SiV7WtMqeN752lhTIWs+k4+ws6w=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=TjgtBvlkzzr9IX/PNUNu3u87zei4GceK7GTAnV44TinXBP7GNmgSh9q8lqdnvbzOz
	 15yg0KAXD7brGCvZsIqAKKfIId0Ftbrpsd0rBbhtQjdtuFH7YRRB9Fe4QYZPZj/zYz
	 PLUolQDETdE+HG0LYzAKtzlPQTaP7Wkf6AWUBOzhDjE/yvTpnQYWOVmRX+3MjcBUEm
	 ucUnqdNhrNqABS44Q0at2PklEVVOQtTTg3Zw7c2kOQgn+Su6iXF0QVARubiCNIbapg
	 TOn4g+4fKm30GFnIWeLFoVwxGzyz2ri3aOFJxIg5eYzEp5AZjKNBkiqOMQpUPi/rgy
	 YPJPDEIlaAqjg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 198843811979;
	Fri, 29 May 2026 00:12:03 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-next-2026-05-28
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178001352190.1565998.2039430206651171575.git-patchwork-notify@kernel.org>
Date: Fri, 29 May 2026 00:12:01 +0000
References: <20260528123911.284536-26-johannes@sipsolutions.net>
In-Reply-To: <20260528123911.284536-26-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-37083-lists,linux-wireless=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 784455FBA0F
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 28 May 2026 14:37:26 +0200 you wrote:
> Hi,
> 
> Here's a new set of changes, mostly ath and iwlwifi
> drivers this time.
> 
> I have a few more things pending, and I expect a few
> more drivers will have pull requests later too.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-next-2026-05-28
    https://git.kernel.org/netdev/net-next/c/e7d6bd24e883

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



