Return-Path: <linux-wireless+bounces-33487-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iLXfAEENvGkArgIAu9opvQ
	(envelope-from <linux-wireless+bounces-33487-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 15:50:41 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AB742CD2A4
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 15:50:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 96BCE3013CB0
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Mar 2026 14:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D48BE37D11C;
	Thu, 19 Mar 2026 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f5tDCM35"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B12F4303A01;
	Thu, 19 Mar 2026 14:40:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773931233; cv=none; b=ZdaXOMt/gmOlYnJAbIP76dvp1dqFwHYNNbJ9stIqWBzmJAiWswV6A8K3zfCHE/uoTXros7bgOcd/3MXZm1yGm04OIPd+YwOfNZMZ1CpOcOiwaGEk+5eWESomHXTIAFNng4NklPoPp/DwXMq5GrFIZdWFF1tRqP0ReBLLk6Aen0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773931233; c=relaxed/simple;
	bh=entk2Kqlpy+zvek6XmeMjH+TrEK68X8rw+DbJ5/8yJ4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ANmN47w72Cy7yS/Sx3B1hLjk5g+t+hf2NPUqi5v+zFxaubNvOVUUaq+Ocn6V1EBEaUkOlnemeT9eG/gz0dw2+6GM6a1vnL03J56Asy9rjuLP3jZzaBwCblp6Hm9/37lYd2gu29JDEqOadTiV3AckipEZBWUKULTH+jZE9QJESdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f5tDCM35; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F32FC19424;
	Thu, 19 Mar 2026 14:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1773931233;
	bh=entk2Kqlpy+zvek6XmeMjH+TrEK68X8rw+DbJ5/8yJ4=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f5tDCM35zZ4lPfo7RdwH7uZYWKG2w177EF/uR5f3fPdVszNE3Vnhfeuton+slNHH2
	 VarLH/HYAtPdg0vAUI4hmJXAHiXnUzWSQSgQfsYVJ1C9BoD0CCbdcgjvbYS9ApXt0k
	 iCX67YY/ocNTX7l/ebVWauiZjZ5tq/INaxK3tJoxjLbGYumtx75pTRoF9L8C70aM8A
	 50n2xgV52Dn4ktm38nwGS/1e4hnlq9y0WThJ7hqyXzEWsmh2TXORASUj5FDlralGpV
	 6vpfx4xMlSxnMEI2aWSL3lc5J0uY74NmRXvA4j/ycAlFWAqMYahWJ4fgN+pIas+AGA
	 GbqNGsM7Fo9Og==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CE5D380692A;
	Thu, 19 Mar 2026 14:40:25 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-next-2026-03-19
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177393122429.1233771.4629826839858224748.git-patchwork-notify@kernel.org>
Date: Thu, 19 Mar 2026 14:40:24 +0000
References: <20260319082439.79875-3-johannes@sipsolutions.net>
In-Reply-To: <20260319082439.79875-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-33487-lists,linux-wireless=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-0.996];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 0AB742CD2A4
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This pull request was applied to netdev/net-next.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu, 19 Mar 2026 09:22:16 +0100 you wrote:
> Hi,
> 
> We have only a couple of things for -next right now, though I think
> we'll have a bigger pull request soon with NAN and ranging APIs and
> likely driver work. But I want to be able to get the cross-merge in
> since the ranging will depend on that, so here is this for now.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-next-2026-03-19
    https://git.kernel.org/netdev/net-next/c/9ac76f3d0bb2

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



