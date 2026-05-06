Return-Path: <linux-wireless+bounces-36033-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id mIqpLupT+2k5ZgMAu9opvQ
	(envelope-from <linux-wireless+bounces-36033-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 16:44:58 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1B6154DC7DB
	for <lists+linux-wireless@lfdr.de>; Wed, 06 May 2026 16:44:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CFC7F3084A68
	for <lists+linux-wireless@lfdr.de>; Wed,  6 May 2026 14:42:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 433D33FE358;
	Wed,  6 May 2026 14:42:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahwywDD3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 200733ECBDC;
	Wed,  6 May 2026 14:42:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778078528; cv=none; b=hitQHESV0SjbwR2h//S6ny3NQLPVndQfyrL8XjnNzC+odx2nvJ6ZTlQjAdRyw+Rwyz3Ouelnb4gWzT6UlzOWsl4CcbaH3IQnMzzQjWDNR46j6Z05LZtH19ooOrZ9vl3yHxTOD+m5dcoMu6WxUeRPKjs7vJfVKtAkwF2hPu/Rhkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778078528; c=relaxed/simple;
	bh=PN8zm4uir3fPS2YWx1TvRQYrTUmG2exEfMQqFiCUvFo=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=Nxj1rmDVEU+tWXVndRMUqSIVBUq7+0uyOCJ+NV7dn3nqv0FpScoRi97qfPYesqAch4kWGcWTDmAo3CYqMEL5Jq06GFIOJNuH88T1sjytTZwakzJ+8zJ83Jd0fCaR35P5/GzHcFZE7qClE3dfTUN2UY77lHGka9ZhEh/WecSs3Nk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahwywDD3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF241C2BCB0;
	Wed,  6 May 2026 14:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1778078527;
	bh=PN8zm4uir3fPS2YWx1TvRQYrTUmG2exEfMQqFiCUvFo=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=ahwywDD3FNbFbjdn6aFzaw+j1wY8Q4DeSJnUi/nBWvynDYHEn0fi29NaPC5IelzSX
	 u2wYa+CQxxd//kvBS9WdNzJrGgjqtxHh7GcBOu2+JwHfWqw1bOeKWNucjFET2hU1u/
	 l9pRYaX3hI6+Nvcq4HgSorfqLL42LZmxU9/8KFGk4g5G1JINjTn1uQ3K05FMZwFmVr
	 DWsV9SauD9EYjOANjENzBtK8tM8dLqQpAzaxMCXuw6bASSeBpN8h1I6QKZFfoH7CkY
	 sy+yUTsM5n4CFLfI9hHpMkQhTs0/r8rFMrxVtPf+4xfNwK8tTYbWgUnD6gmDn+lnoD
	 kqk9VbXPNL6bg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9D303930888;
	Wed,  6 May 2026 14:41:18 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-next-2026-05-06
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177807847754.3025991.13549540954015052152.git-patchwork-notify@kernel.org>
Date: Wed, 06 May 2026 14:41:17 +0000
References: <20260506111147.224296-3-johannes@sipsolutions.net>
In-Reply-To: <20260506111147.224296-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
X-Rspamd-Queue-Id: 1B6154DC7DB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-36033-lists,linux-wireless=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  6 May 2026 13:10:53 +0200 you wrote:
> Hi,
> 
> More content for next, as below. I'm sending this now
> in hopes that we'll get net merged into net-next after
> it all lands, because I'm annoyed by the use-after-free
> issue that somehow we never noticed and now hits all
> the time.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-next-2026-05-06
    https://git.kernel.org/netdev/net-next/c/2281958e6007

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



