Return-Path: <linux-wireless+bounces-37370-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id cE+YDXfhIGpQ8wAAu9opvQ
	(envelope-from <linux-wireless+bounces-37370-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 04:22:47 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 97A6B63C7A0
	for <lists+linux-wireless@lfdr.de>; Thu, 04 Jun 2026 04:22:46 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b="mUA9/UHC";
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-37370-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.105.105.114 as permitted sender) smtp.mailfrom="linux-wireless+bounces-37370-lists+linux-wireless=lfdr.de@vger.kernel.org";
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 795423009035
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jun 2026 02:20:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 471862DF152;
	Thu,  4 Jun 2026 02:20:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 562E4343890;
	Thu,  4 Jun 2026 02:20:19 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780539622; cv=none; b=Wh4k0Jo1sYpxuMou5+awQy+mnC1weRBfw4oKSTE/aldYtVPnPYrgW1Pog/8D3sB7IwA3Rh9RXAqoVlQoRMXpaINWTlnqPvNasC7TqFKofgAEBJBAtDHVzeldO2pkT4L6qPR3lhPc9NPWX4NNugOqjTxj4Pyj4djuC3oYtYiPZxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780539622; c=relaxed/simple;
	bh=nt/HwTmCow5dv42xI1a8K/9JYxpd7JpspAR656fkpH4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=a5o5if479E56zSSmzbb/SHr2BYUhDJyTjXfLp8LJLtFappY+VRWuq5ARZRd79fB3tWCpuKlpZODw/0WSzBoVcUjklBNlTMooLbA3cldfHaS3cT7KFnsnF/KjZ1MTVKBaamFPWgqIOYW+DaIYPjYPn5jd1NhSoc1HAvpIv0D/J+A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mUA9/UHC; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4481F00893;
	Thu,  4 Jun 2026 02:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780539618;
	bh=+hmXS4U34AH1Xpy67XuolNkGjHnQ6n/VI1Ap1gmPo7Q=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=mUA9/UHCljUdNiLjLXa76IH79eZrU1iCCE+mzL/pQElQNZCPIRwGxrHfuNNkgcaXj
	 Iwgf9/h9SGC8hO+g3MWxbyzpyRm7EwH2iWsoEAGLzKIv+89yUoxc+Iw3fEkTbvw5Dp
	 abE6HWo/ZKixWBAEOXOdwyHR2zuPwhQ22P++29MOQrQcjdXnfS09cJdrq7C/ptsMMt
	 KCjHWPGtW10/j3/o67huJBOPGW6w6PV34R8eVoafQBPavyWk/YGuJLDvZfx4x0R0/W
	 9RyZbGIgcWNJ4cUAHGy6oeMkUesXf0l4F6TwcGWZXKF16UW56CRp6EYLzwMreDJeds
	 5WD04Q8OiPm8A==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 199E439308E1;
	Thu,  4 Jun 2026 02:20:21 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2026-06-03
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178053961964.2207566.7336189080547624467.git-patchwork-notify@kernel.org>
Date: Thu, 04 Jun 2026 02:20:19 +0000
References: <20260603113208.171874-3-johannes@sipsolutions.net>
In-Reply-To: <20260603113208.171874-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-wireless@vger.kernel.org];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-37370-lists,linux-wireless=lfdr.de,netdevbpf];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS(0.00)[m:johannes@sipsolutions.net,m:netdev@vger.kernel.org,m:linux-wireless@vger.kernel.org,s:lists@lfdr.de];
	FORGED_SENDER(0.00)[patchwork-bot@kernel.org,linux-wireless@vger.kernel.org];
	MIME_TRACE(0.00)[0:+];
	DKIM_TRACE(0.00)[kernel.org:+];
	FORWARDED(0.00)[lists@lfdr.de];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	FROM_NO_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	ALIAS_RESOLVED(0.00)[];
	FORGED_SENDER_FORWARDING(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	FORGED_RECIPIENTS_FORWARDING(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[vger.kernel.org:from_smtp,tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: 97A6B63C7A0

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  3 Jun 2026 13:31:24 +0200 you wrote:
> Hi,
> 
> And yet more things ... I'm going to defer a number of driver
> things to wireless-next though, e.g. a PCIe device IRQ race.
> 
> Please pull and let us know if there's any problem.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2026-06-03
    https://git.kernel.org/netdev/net/c/ac056099822e

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



