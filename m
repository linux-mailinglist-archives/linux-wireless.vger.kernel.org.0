Return-Path: <linux-wireless+bounces-38852-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by mail.lfdr.de with LMTP
	id uppBG58FUWpW+AIAu9opvQ
	(envelope-from <linux-wireless+bounces-38852-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 16:45:51 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id B019373BDE8
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 16:45:50 +0200 (CEST)
Authentication-Results: mail.lfdr.de;
	dkim=pass header.d=kernel.org header.s=k20260515 header.b=IUbGiUxd;
	dmarc=pass (policy=quarantine) header.from=kernel.org;
	spf=pass (mail.lfdr.de: domain of "linux-wireless+bounces-38852-lists+linux-wireless=lfdr.de@vger.kernel.org" designates 172.234.253.10 as permitted sender) smtp.mailfrom="linux-wireless+bounces-38852-lists+linux-wireless=lfdr.de@vger.kernel.org";
	arc=pass ("subspace.kernel.org:s=arc-20240116:i=1")
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 3A21430067B1
	for <lists+linux-wireless@lfdr.de>; Fri, 10 Jul 2026 14:40:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5AAB53B83FC;
	Fri, 10 Jul 2026 14:40:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FC553DCDB5;
	Fri, 10 Jul 2026 14:40:57 +0000 (UTC)
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783694458; cv=none; b=Ptf2Jvo+KNcanVzPERO2WP+gOhhxjW2YtwwNe1yTPJNEpfQFj7QqUyCaByzeeK7sv08QDvB6VIKJFiXR4kOvNdVsE/6KkZkCC0SJCU3da2i6ojI9o9n3ha+esdY4gP+UZ504T/Lnq4jiIG4g3+FPFu8axGlddJTedEQBV/qHm+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783694458; c=relaxed/simple;
	bh=zFaJ+IyWbtAcxsb+8hHCHRf5N5/Rulr6q2RW2+K4cmY=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=HYSb94WCEdcW4fYZWk7vZLnND68SjdQe8iyf1Xfi4x345BDZSXUrzwkFE+WaLJ006MoUuXELeEST/fr4c+hXNxnkHP5bEDOUwfW+kZmRmJ9QRy22P2H+aM0gn2ZeGLpfdgHlxkUMxzY7AG5vq7BAbfm5r1ay3yO/x5qFlCOF6hY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IUbGiUxd; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1105B1F000E9;
	Fri, 10 Jul 2026 14:40:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783694457;
	bh=Ux+CmZMRRr4+801cKNR9wHEU/SAGIcxMzBRQf2BPDXQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=IUbGiUxduFIwDIq4hwvuStI9jNFwX5cszC9bY1vBp8IMKrTRod5MMbzpllLAKPEWr
	 m9GQZj1JFGmHzXW+7m2m05qGvZvk+orrkiDB/od4BimgGco5mxkHffypWYFBKuiwhw
	 GDhtmBcSg4wrkX3d36nGTQIYB6JqMTSGWTB74cr9kB7BnE79990bT6j9yO6CD1tPzs
	 loCRvbHOGKoIqbtGhhfAHM732onc5eCq1hGXnKEInZlZTHhbn8aTLT9FUbK0aR8utG
	 fDdu9rNWk7oFkv/LsZQ2Fg1gDQsZjdCTxwjXsK5mVz8S0Dg5+cZwY1a0rpd3lX0gow
	 cbjwvLBgv0Mwg==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 1995A3924F98;
	Fri, 10 Jul 2026 14:40:36 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2026-07-09
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <178369443465.714934.14339027434959871822.git-patchwork-notify@kernel.org>
Date: Fri, 10 Jul 2026 14:40:34 +0000
References: <20260709115038.243870-3-johannes@sipsolutions.net>
In-Reply-To: <20260709115038.243870-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
X-Rspamd-Action: no action
X-Spamd-Result: default: False [-5.16 / 15.00];
	WHITELIST_SPF_DKIM(-3.00)[kernel.org:d:+,kernel.org:s:+];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	TAGGED_FROM(0.00)[bounces-38852-lists,linux-wireless=lfdr.de,netdevbpf];
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
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,vger.kernel.org:from_smtp]
X-Rspamd-Server: lfdr
X-Rspamd-Queue-Id: B019373BDE8

Hello:

This pull request was applied to netdev/net.git (main)
by Paolo Abeni <pabeni@redhat.com>:

On Thu,  9 Jul 2026 13:49:05 +0200 you wrote:
> Hi,
> 
> Sorry, I meant to send this yesterday, hoping it'd get
> in/out before netdevconf and all that, because it's
> actually really big. Mostly I've now collected many
> random LLM-induced robustness fixes (I can't really
> call most of them security fixes, though there likely
> are a few).
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2026-07-09
    https://git.kernel.org/netdev/net/c/a0d82fb85053

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



