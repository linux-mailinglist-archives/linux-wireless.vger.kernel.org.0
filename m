Return-Path: <linux-wireless+bounces-34534-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id sAmrBG8I12myKggAu9opvQ
	(envelope-from <linux-wireless+bounces-34534-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 04:01:19 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A36B43C56B7
	for <lists+linux-wireless@lfdr.de>; Thu, 09 Apr 2026 04:01:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 85B96300B109
	for <lists+linux-wireless@lfdr.de>; Thu,  9 Apr 2026 02:00:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF4013191A5;
	Thu,  9 Apr 2026 02:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oof0c96x"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BCD642BB13;
	Thu,  9 Apr 2026 02:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775700049; cv=none; b=pOsNgiAc74The6GzY/Xgu2DLjSIGfzpzsxYSj3BdmUV/EnBzklnE3V5n34z8b5tHeUBBGZeSChH80zr0IAkM2mNfOvt6zB3CHZ12TOcZmDkEpAOXZWuYGMO5xIrKe5VB0ax6tdNTU43Pn8mjgy703V4owPjmO5xuEny3jhqkmKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775700049; c=relaxed/simple;
	bh=m/wLbFgll4zk5DQnNiOxj6mu9+msbdskQOCLd4toxqc=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=ALx5IwwMIIqat7szEHKFV7UDj3i6IvbhQU5jqtWN+Is1M5cW/sPFPkSCgCzATPNGC0x81sCleE4w5PGfiVHWvI7BFusguv9pPn2nFL6jIY/Um6Sd5rybay1x65hgX7GnotEexkt+SHcGeYQfnyNrXYK4WK2kuQyM/9198IqftDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oof0c96x; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01D66C19421;
	Thu,  9 Apr 2026 02:00:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1775700049;
	bh=m/wLbFgll4zk5DQnNiOxj6mu9+msbdskQOCLd4toxqc=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=Oof0c96xeCherkQGhtESxOAYVOC9hSfqmfwsfta+J5UeUzaSvZcxQOv1gbAeyULcE
	 xTX6NagzUcNS0z2QIzYoP7lgDT162tmUiPh9EzX0nruHiSIDQw+TvEjcNBYKTnXf+h
	 Dvyvd6lTdjRtod7bduwwdlRBcFXD2uPR0aa5NpgKF38nJhuqfP8re+/krjqFg1JlGG
	 9qwJ6JYCbvgPM3Dro9LOfscgZQdY6CYH0R4LFrxzYnppmMKDX40oWtjMWpNj7kFPcZ
	 OC+E7rO7ZYUJUwQzzQYWHB9oFatfEMg3Sl46d40drrw9S/R49Cv/cP1V/qduwtnaCh
	 TaGJ8X81rO2tw==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id 7CD273930793;
	Thu,  9 Apr 2026 02:00:26 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-2026-04-08
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177570002504.953143.161114630902259878.git-patchwork-notify@kernel.org>
Date: Thu, 09 Apr 2026 02:00:25 +0000
References: <20260408081802.111623-3-johannes@sipsolutions.net>
In-Reply-To: <20260408081802.111623-3-johannes@sipsolutions.net>
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
	TAGGED_FROM(0.00)[bounces-34534-lists,linux-wireless=lfdr.de,netdevbpf];
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
X-Rspamd-Queue-Id: A36B43C56B7
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This pull request was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed,  8 Apr 2026 10:15:25 +0200 you wrote:
> Hi,
> 
> So in a way I'd hoped it wouldn't come to this, but while I
> was out last week a couple of things came in that seemed
> relevant enough to squeeze in now. I guess it wouldn't be
> much of an issue if not, but I figured I'd try anyway :)
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-2026-04-08
    https://git.kernel.org/netdev/net/c/d65b175cfac6

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



