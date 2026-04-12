Return-Path: <linux-wireless+bounces-34674-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id G9t6Af3I22nzGgkAu9opvQ
	(envelope-from <linux-wireless+bounces-34674-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 18:31:57 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E1343E4CBB
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 18:31:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D3D623014114
	for <lists+linux-wireless@lfdr.de>; Sun, 12 Apr 2026 16:31:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0B8D319D8AC;
	Sun, 12 Apr 2026 16:31:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hQQxHeQZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCD6D4A21;
	Sun, 12 Apr 2026 16:31:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776011513; cv=none; b=DFMEC/qGI1NSe8kIB/TaYWP+m+mXrsVqdYl7VObDYgJdng7N3FVSQn1IiPo0L95SoxcLeWreQmTnnD646wUt+WWjozkD0gJ3RdxBXPT0vse2YJkqyQ5/UXn2Orx/uduNZjpPyy5kK1ycBeySp+1bm3Q8TwjOavMhZ372KtK2FWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776011513; c=relaxed/simple;
	bh=Z1T5e2LeaeWbVdC7NDlNtoAk1VKnYFuzWOOSW3UYC4U=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=qmSTViLTupCXJ6DV17D+iOXeo/tFeZ37lCTw/P+zWunkl+tuIpLzLzpMkr6T/YOpUgm2U7hvQHUM43otBpiMg+tsE9m9C019uUVRuaIBzegEVJzAwl9n6rKcQbPFaurbA53fEobZkEDh1Clx1N+YsGRHHzDtDEcwOV8AGFzF80c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hQQxHeQZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 814CDC19424;
	Sun, 12 Apr 2026 16:31:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776011513;
	bh=Z1T5e2LeaeWbVdC7NDlNtoAk1VKnYFuzWOOSW3UYC4U=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=hQQxHeQZIOLMslDACaTiJK2sE+BkYdN45AHjVxtpA+xqJN5Mi3S7ez9oYCughA5G+
	 x6r2ONCOEGyqMowl5xbXi2aTr1LqrDZLYIunBalLxTMIMhNRdBs7Y1rlQyA6xWEhtO
	 GoJsT4p738B5yLvD8czyYAOx7uwNHt5FfZ7ZwMIfWDI26vKOJHqLFMOD4P7Y2c1AIY
	 pQHOF5oDqvzrBPGutIlDVGg2NdMEWdTLcrFluiqcUxxTLCCcKF4PyQ5W/32XNI1va5
	 ERZOdWEa3ZRRaD1Mk/ux4RG71bw7qbmhgqZ6ZZ32KkseYi5VEF3QbqZCrLQ/jZ/y6o
	 Ze7urnqfw5eyw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 3FCE03809A8B;
	Sun, 12 Apr 2026 16:31:27 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-next-2026-04-10
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177601148605.3334175.8158848184311005775.git-patchwork-notify@kernel.org>
Date: Sun, 12 Apr 2026 16:31:26 +0000
References: <20260410064703.735099-3-johannes@sipsolutions.net>
In-Reply-To: <20260410064703.735099-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-wireless@vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-34674-lists,linux-wireless=lfdr.de,netdevbpf];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MIME_TRACE(0.00)[0:+];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: 3E1343E4CBB
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Fri, 10 Apr 2026 08:44:33 +0200 you wrote:
> Hi,
> 
> Final (obviously) pull request for now, the only thing to
> note is the crypto changes, FWIW the change touching crypto
> was acked by Herbert and he asked me to take it:
> https://lore.kernel.org/r/adYNVB3n358xm_s8@gondor.apana.org.au/
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-next-2026-04-10
    https://git.kernel.org/netdev/net-next/c/118cbd428e43

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



