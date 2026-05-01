Return-Path: <linux-wireless+bounces-35737-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id Z7YhB1j082nD9AEAu9opvQ
	(envelope-from <linux-wireless+bounces-35737-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 02:31:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 64C0B4A9379
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 02:31:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7DA77300E73D
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2026 00:31:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0211A6831;
	Fri,  1 May 2026 00:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/upA23v"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4F392836F;
	Fri,  1 May 2026 00:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777595476; cv=none; b=B/ggyeKbXfhQPE5CQd1eTqNXp/yQdXvFmArJm+KorI0UeBsLCB6xuMXTBBvD+1/s/d8u3LAnhYSNJ3nD+qEKaOCq3YsaLDJ2J0qjTBjOt0673r6VhHrccwDRqm39Bha//gsb70xCFc2QiMmvkgWIV1RZcF6syD3qZeGkPyg5Mzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777595476; c=relaxed/simple;
	bh=dy5qHfpnvYwonOtrENQRDaRCbvUF8kE2NpOmmu0G83g=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=TqdHLQdC+Q/6YyFswrC67XB58EDeXePYtq62vhpzpFmW4Lm4nld+LYwoDog4iWK3pCnqSmtg9W2rJqN4aWj6hyyPyyNQ90iCj78H+IWNIgduJcyrwrnPOMGNqv7CClxDKTowfQYb+e1nScqR+v94b/LEoL/+M3i/YIfSVT0BXNQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/upA23v; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CD85C2BCB3;
	Fri,  1 May 2026 00:31:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777595476;
	bh=dy5qHfpnvYwonOtrENQRDaRCbvUF8kE2NpOmmu0G83g=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=V/upA23vPG0s3wJ1FXXR9PioQvkhljGTlWv/Fx1Dz56ogLIJsgx2d2bpWJVo0hxuw
	 Agykm85X+Jo60qkZUJCAshzH4wpAMr1GB5g5QL5vpghIaH1hBs4wwC6loMrdUYE53/
	 XdX60OmbINuvAfc4eAE2f9ufrHEpinZJBiQ8oAoZYaTIjs9KqWwsDcUIoJirFfB/Xc
	 b2Lo9bOm58aTyAxb1ApgrSNcSA2KjHYUHsh70GHbOIt3CVd+YMJHL9CeLEdaNeHspb
	 Fuv8Dq0vZfNrSaKnBW8LF98sABcoscBTGIQlxZiS+JmWm8ZoQWHLSdK9cVTTcvoySj
	 ajiGq87RWinQQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9EC7380CEC4;
	Fri,  1 May 2026 00:30:31 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-next-2026-04-30
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177759543055.3262440.9704401213217328329.git-patchwork-notify@kernel.org>
Date: Fri, 01 May 2026 00:30:30 +0000
References: <20260430120304.249081-3-johannes@sipsolutions.net>
In-Reply-To: <20260430120304.249081-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
X-Rspamd-Queue-Id: 64C0B4A9379
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-35737-lists,linux-wireless=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[kernel.org:+];
	MIME_TRACE(0.00)[0:+];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FUZZY_RATELIMITED(0.00)[rspamd.com];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 30 Apr 2026 14:02:12 +0200 you wrote:
> Hi,
> 
> Looks like 7.2 is going to be interesting with NAN and UHR
> both getting major work, but for now we have some (relatively)
> minor things - the biggest is the station bandwidth rework,
> which is needed en route to UHR.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-next-2026-04-30
    https://git.kernel.org/netdev/net-next/c/6855a52318b3

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



