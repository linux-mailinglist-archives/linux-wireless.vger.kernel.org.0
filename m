Return-Path: <linux-wireless+bounces-37634-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id M/b8HO6BKWrfYAMAu9opvQ
	(envelope-from <linux-wireless+bounces-37634-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 17:25:34 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id B7DBC66AB98
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 17:25:33 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=gN7WIDPt;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37634-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 2600:3c0a:e001:db::12fc:5321 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37634-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id D98763507586
	for <lists+linux-wireless@lfdr.de>; Wed, 10 Jun 2026 15:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B9723DF00B;
	Wed, 10 Jun 2026 15:13:35 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 439243BA23A;
	Wed, 10 Jun 2026 15:13:34 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781104415; cv=none; b=W11VaOnZqEUWOOaryE/lWmJbuyP36TwXRXO0GsMf/rkeW76tv0QzJJFinxkz5JFbeBjcaCmjT9VHuY9Fy4CUHpYStQ/ADw36Mk01A37iAwNgvKxAqcleyCeCg9oNvKMDhl3Fx+V+tFcpw817pnsSTdlnCCNOAnX0nPfAKdLxpHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781104415; c=relaxed/simple;
	bh=zUOpqkRYY5NB6Ww3f4SPFwVRAv2IpLaM7Tpk+Ut1zVY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=NsiN+DaWlfi2wdOQVdRiTZegMlwY7Rznf9imWaQgEAmFiDpove7E6OgSOq6bQ30S2wKSvN1GkWitkRq35K+8Wc7TxLT2/veE2ViygCOmJt89xVAr0fCBnr+iO8ML6TZa9ohbMqTkRahFqGsxK8OhW+BLjwR9pZT9lO1kd+xobf4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gN7WIDPt; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DAE431F00893;
	Wed, 10 Jun 2026 15:13:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781104413;
	bh=PHKfes4v8KNvDYJAPgeKqEirYXH9lAofN2epi6z8oMk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=gN7WIDPt+6Zjmf4g7DaLWkUVjcJBIfimxqO69wQ05p3s6gvRRdMr3kRidgeF+jLzh
	 3Y3zp5B4Vt/qBzG1wY8iMB78Zg5cErDAHSCjSDUuscrfjnohbxGVjF7AnNwOcKsF8i
	 UIc6Y77ZcBiDPrCyVmkUqf7m1vhjisou+a00077sh/ABXnQ81OjOfKZEI2eXE3KbTW
	 rVKJx1zTYZDfXr3g4jYm56F+hxWhk9cMr5/PbjRqc74x3ZVDxKAsHlIifuh+QFdJip
	 wsREX7lAnnSxPC/macxH3bqqxQ6M84o+Gg7TgUHyFfXtSgwWnMw82sY6dXEZrX9eGn
	 Ku/KZv6Swwwtw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id F08DD3930D5F;
	Wed, 10 Jun 2026 15:13:32 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-next-2026-06-10
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178110441164.3082243.15047843183218775795.git-patchwork-notify@kernel.org>
Date: Wed, 10 Jun 2026 15:13:31 +0000
References: <20260610103637.179340-3-johannes@sipsolutions.net>
In-Reply-To: <20260610103637.179340-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37634-lists,linux-wireless=lfdr.de,netdevbpf];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	FROM_NO_DN(0.00)[];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B7DBC66AB98

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 10 Jun 2026 12:35:39 +0200 you wrote:
> Hi,
> 
> This should be the last PR. Quite a few more driver things came
> (see the tag message) but otherwise it feels fairly simple.
> 
> Please pull and let us know if there's any problem.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-next-2026-06-10
    https://git.kernel.org/netdev/net-next/c/972c4dd19cb9

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



