Return-Path: <linux-wireless+bounces-31792-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id iKZhC2yRjmlADAEAu9opvQ
	(envelope-from <linux-wireless+bounces-31792-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 03:50:20 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id AC6CB132768
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 03:50:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 4FFC630480A2
	for <lists+linux-wireless@lfdr.de>; Fri, 13 Feb 2026 02:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 757EC13D891;
	Fri, 13 Feb 2026 02:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="sP5clzyU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518B5347C7;
	Fri, 13 Feb 2026 02:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770951017; cv=none; b=hScETK+7RXJfwihHFmcyJwk6Dvy+jMdW42TNk/ZK5Hmk5zsBsf5CZHzsEXJRPuO45+usmICBDyQfVEGsQheFXoPHg1Y3WY2oxNr6DSHlqOiRIxljkmsjCo3iKZfgI9H5B0NiHV5RDLl7InkLAk++MJOmK2U8phbc9X3IA078wz4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770951017; c=relaxed/simple;
	bh=PSoYpgktMr2kPyyW6kN6DHkVUHcW1oSCm7yoEDrJDQc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=tBx4s8Ef+KuwwS72/tu6QVNjYYFm0ol2Jq8xnkTFLZ5kKXKobrzRSOz8OncpR1UiD8q017O7B9qUDKy7o4g9MwEOmR81eYnyW6OENjCPiguGlannAf2BbFz4SfGjlA+So5MZDAxmZ9+Qfqv6T99wGpkfwvc2P3J3H7B2TMgZgfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=sP5clzyU; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E39E0C4CEF7;
	Fri, 13 Feb 2026 02:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1770951017;
	bh=PSoYpgktMr2kPyyW6kN6DHkVUHcW1oSCm7yoEDrJDQc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=sP5clzyU1WXXXGwWQhOybCJiIMWjSC77JoZZt4LXV2YxCrUw2dVDiXhdDxeVjYwNv
	 Gma1tr9RVlAM3B5s8ZFMRuSNdzRtES7D/govQNV+QhshwLsMxM+4T4/E7fUmUjb6J8
	 GH2Lo7fz6jQRlclvc5z2OX+rjpawuudzfxmZwklIuC1xK7uzR+7Sms3bhwh4iJdfgg
	 VIIQAfyMODaeUmoureXnf0wJ14q2Vp/3kiqJAq4ty/We4eZ80/tBt7qztx/F5RtgxL
	 TwFiF6pw8RzKPZNtXaCnQR7NggT/T3JYc+XpU12MHFtW3NNFgV26aERlUADi+Tr9pC
	 zNh6OFrS5GZIw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 482B03931093;
	Fri, 13 Feb 2026 02:50:12 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v2] net: intel: fix PCI device ID conflict between i40e
 and
 ipw2200
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177095101108.1819996.12996932585198035260.git-patchwork-notify@kernel.org>
Date: Fri, 13 Feb 2026 02:50:11 +0000
References: <20260210021235.16315-1-enelsonmoore@gmail.com>
In-Reply-To: <20260210021235.16315-1-enelsonmoore@gmail.com>
To: Ethan Nelson-Moore <enelsonmoore@gmail.com>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org,
 stable@vger.kernel.org, johannes@sipsolutions.net,
 anthony.l.nguyen@intel.com, przemyslaw.kitszel@intel.com,
 andrew+netdev@lunn.ch, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, stas.yakovlev@gmail.com,
 aleksandr.loktionov@intel.com, alice.michael@intel.com
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.66 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-31792-lists,linux-wireless=lfdr.de,netdevbpf];
	FREEMAIL_CC(0.00)[vger.kernel.org,sipsolutions.net,intel.com,lunn.ch,davemloft.net,google.com,kernel.org,redhat.com,gmail.com];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-wireless@vger.kernel.org];
	FREEMAIL_TO(0.00)[gmail.com];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	MISSING_XM_UA(0.00)[];
	RCPT_COUNT_TWELVE(0.00)[15];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,netdev];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[]
X-Rspamd-Queue-Id: AC6CB132768
X-Rspamd-Action: no action

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Mon,  9 Feb 2026 18:12:34 -0800 you wrote:
> The ID 8086:104f is matched by both i40e and ipw2200. The same device
> ID should not be in more than one driver, because in that case, which
> driver is used is unpredictable. Fix this by taking advantage of the
> fact that i40e devices use PCI_CLASS_NETWORK_ETHERNET and ipw2200
> devices use PCI_CLASS_NETWORK_OTHER to differentiate the devices.
> 
> Fixes: 2e45d3f4677a ("i40e: Add support for X710 B/P & SFP+ cards")
> Cc: stable@vger.kernel.org
> Acked-by: Johannes Berg <johannes@sipsolutions.net>
> Signed-off-by: Ethan Nelson-Moore <enelsonmoore@gmail.com>
> 
> [...]

Here is the summary with links:
  - [v2] net: intel: fix PCI device ID conflict between i40e and ipw2200
    https://git.kernel.org/netdev/net/c/d03e094473ec

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



