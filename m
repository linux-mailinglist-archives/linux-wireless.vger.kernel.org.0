Return-Path: <linux-wireless+bounces-36778-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGbkIwWUD2pQNgYAu9opvQ
	(envelope-from <linux-wireless+bounces-36778-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 01:23:49 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 17ED95ACA4A
	for <lists+linux-wireless@lfdr.de>; Fri, 22 May 2026 01:23:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 68F18304047E
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 23:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 97D493803F3;
	Thu, 21 May 2026 23:17:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FX+wtth4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59AF5345CDD;
	Thu, 21 May 2026 23:17:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779405458; cv=none; b=i0/Zyx74DO8Pf6WNt3EInSLZ2RimuBLM6+JJFJrxP0i9teXBpChLWFWRg+fj7A9QckXpJ04aMisemAlpe+OcG9GjvzePcWjlCbnt+7OrqsT7JeT9yQil9DFL7XGc3/4zLZrZHiD1pl7vye4Lh7yh3F1sZnH5OBQie+RpbjvZeG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779405458; c=relaxed/simple;
	bh=a1huhdR3wAE1Ti940BRS1+5Rjvi33M94Lzu7AKstwg4=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=IZkJaRTvdQYaIRJl8E4v/LFOt1MVU6kdcHpLOxH947NVGxKgy38jM0b34Qu7gyVqrwJbwB7wzzNyirIoKeulLXL35/QYmCoVExrV48PdvF3E1b0HY89ywHh922D7ti4/wRRxTvdDDkg+22OOrC2VnrBbCbil4sIBXeHzRss0Gsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FX+wtth4; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F2AFA1F00ADF;
	Thu, 21 May 2026 23:17:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779405455;
	bh=csTF7Jhkg7NvGhaJfRSWBwUixA2BfQZBvY7deFSKqWk=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc;
	b=FX+wtth4w6iNiPglTnEizk6F2xbPNdK9OyIrwhv88F2JyJhJtUt9dsd0kUNFyxZ+d
	 8hTexSAKcOLxnCUato2f/HvK6WNeenerH+1u9R4KUrpib9syWDYAc23M91g+oViMnL
	 dljjyPNN2pwIuCBPNQQXnw7zFq4sNtDNkh8mGM6IAFi5uS3OibGoVqZn6Tjcj0zQaE
	 K2mDp1Tk8SDRVCnrhtSIHn71vhEfE8/ODsjOKCnlBmhtK2ke2U9JJI6KFgXzf3t9Rd
	 tnAnLhZwZQQmg6BY1ClnJ/Mym+FZfUQ1CvaXMlm4DA4scVgx+t0Loiqk7qltkk03Vi
	 31mpaym6fL0BA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id D0C333930E3C;
	Thu, 21 May 2026 23:17:45 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-next-2026-05-21
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177940546442.547004.13599026291051114380.git-patchwork-notify@kernel.org>
Date: Thu, 21 May 2026 23:17:44 +0000
References: <20260521153519.380276-3-johannes@sipsolutions.net>
In-Reply-To: <20260521153519.380276-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20260515];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-36778-lists,linux-wireless=lfdr.de,netdevbpf];
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
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo]
X-Rspamd-Queue-Id: 17ED95ACA4A
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 21 May 2026 17:34:34 +0200 you wrote:
> Hi,
> 
> OK this one's pretty sparse, but I'll send it anyway so we
> can sync up with wireless content etc. later. I guess I'll
> get more driver pull requests for -next as we get to later
> RCs.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-next-2026-05-21
    https://git.kernel.org/netdev/net-next/c/1a1f055318d8

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



