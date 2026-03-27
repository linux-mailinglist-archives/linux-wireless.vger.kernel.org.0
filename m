Return-Path: <linux-wireless+bounces-34023-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id YNHLDAbZxWnQCAUAu9opvQ
	(envelope-from <linux-wireless+bounces-34023-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 02:10:30 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 8297033DBD9
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 02:10:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 00E573003631
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 01:10:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2581F27510E;
	Fri, 27 Mar 2026 01:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f2adW4BT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 018E726B2D2;
	Fri, 27 Mar 2026 01:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774573827; cv=none; b=TAye5o5g71ztrzgihFV26TesHpXdOSaTFpOUV+o26wFkRQGpnXIt/w18IBA8QBw3VbkGVncQrL/GgQD+fkoigC/4hoy6OPnIgVpWO/nq19Q3fPHpfGUcYRX4wcLhnBtdil9vFedh/A68lopJqgCvtb4SxGwU5N39VbQwNkxc8zk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774573827; c=relaxed/simple;
	bh=IDbzudfYZZhq+n67gP5UfbLL6Q6QjuH1n0DaOdgYO4E=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=rdfBVn5NT51xw0ZUHKtC9n7xbibMoqsBzNLpayoMH0ZmWK7tV2wKxBnbdkCHPT/d/xykJXB165BAYS8P2fjCH/o/wYnnI3PU2P62yxfhmPIIxI/kFNjN0wOxk4rFKN8a6l1dXF1BZ+gNHNc/Gl4oo+fiJu/Lh9o2LOXtsfyt74c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f2adW4BT; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 74175C116C6;
	Fri, 27 Mar 2026 01:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774573826;
	bh=IDbzudfYZZhq+n67gP5UfbLL6Q6QjuH1n0DaOdgYO4E=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=f2adW4BTxLO6dCs0rr1KYOvvkQsKYZEer3Zwu/RXRDm8uKK7I6/f4sWV4lk4hj5DB
	 aonQGTfPCDDbJzvCYtf9rr1PN7ELySGOSQxA+Vgn6L3LAar6AHQsMgKyFNTQljG/Ia
	 tF+TXIUUReRrWzrDyx0Qe35ryaFA4rN1FW+cFDyNsKZTgXkWevifbjL7JlVSM8SZOT
	 txd9TvkwBdWyo32MAkRx2GZ8Yy+Pq7USLdC/GIkRM7rWnHa5WsG5SYXeEkk8HZ4Vvr
	 9OXxh7sxDCYgs1gSi/aVtJQyZSu2Gr/73Zp25AELVgZdTVR8GCH1JdOANC6NuYyXeR
	 u7T7s9P8SjULA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 02DA73809A07;
	Fri, 27 Mar 2026 01:10:14 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2026-03-26
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177457381279.3245434.2774089184014115151.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 01:10:12 +0000
References: <20260326093329.77815-3-johannes@sipsolutions.net>
In-Reply-To: <20260326093329.77815-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-34023-lists,linux-wireless=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 8297033DBD9
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Mar 2026 10:31:35 +0100 you wrote:
> Hi,
> 
> And ... more fixes from drivers came in, notably iwlwifi with
> a bunch of things (their maintainer had been on vacation).
> 
> I'm going to be on vacation next week, but I'm also not aware
> of anything missing from drivers etc. right now, so we'll see.
> I doubt this is the _last_ pull request for 7.0, but I think
> not much more will come in.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2026-03-26
    https://git.kernel.org/netdev/net/c/45dbf8fcea4d

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



