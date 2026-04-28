Return-Path: <linux-wireless+bounces-35428-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id 0B37G3QJ8GkINgEAu9opvQ
	(envelope-from <linux-wireless+bounces-35428-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 03:12:20 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id C525947C54E
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 03:12:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 5294B3044F3F
	for <lists+linux-wireless@lfdr.de>; Tue, 28 Apr 2026 01:10:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8592BE02C;
	Tue, 28 Apr 2026 01:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="pL7L3ixh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BD6B29D291;
	Tue, 28 Apr 2026 01:10:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777338653; cv=none; b=MUNcNHh5ZMFQYoD5jjws3bH7b0WhjL20kddLxOh9zFzpjfBPabr7aXipIsrlenfG505HXEAo4fZib3Nkp4iBTBR7I9+jzYv2wyD/w04n1LyzpL+m7vmDHCLpQug2Np22NapX+nlRQjQIH7sjqWoIf9V4dMNIW+3xNe9R7GpBbws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777338653; c=relaxed/simple;
	bh=P9Zm/m6HL8f3IaLXWKwjtb/tNyMjo9cG2vYJA4gUBJQ=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=d7MntMzaMvg6e7uf9tFNhSqCZca0fu28zblZ+jT807pIzUQzS3Ipo27NbOdYZdnNsPjUUu8ZISAVmfBaLiYDp6sUDraR1gG9n5Kp6P30mSNXi3+N71ncsNgvQKkyPtDd8kmGpFW+Ra+zqj2b3fRVYPkFYDmADpnN5tGK9SAh58s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=pL7L3ixh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C167C2BCB7;
	Tue, 28 Apr 2026 01:10:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1777338653;
	bh=P9Zm/m6HL8f3IaLXWKwjtb/tNyMjo9cG2vYJA4gUBJQ=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=pL7L3ixhJMFRT4mbZ8uiQZgmci2eRcSoLcW6R7L/w2WPhplSpEIsWkGFEX8S2YSmo
	 l9pidy6A02Dg199UxtNZ6wgm8+7zfLYaUGfzwfcNW78jtPum7UQNs9fU4bCVOlTZ3B
	 yGeU3xn4rW5IHT9E8O/eAhC/6GOi2FMHFC2QR2C94+Yqqw4Qv2DV7Nfo7+z8aR/cfE
	 xnhs7Wzh1KCriEK74ICL/pDymB23Y4HTqZJKFIXyhzFFs7Qyu3zkgvy+Z4/KR082Jl
	 GXVz8dhBBxzYPHqF6/B9tLNsiHz6suU3bJi9U1WX/o3TOpqkUP23jAaFhsyHtpfqO3
	 wouSMgop8/mSQ==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id B9DF4392FFDE;
	Tue, 28 Apr 2026 01:10:11 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] NFC: trf7970a: Ignore antenna noise when checking for RF
 field
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177733861029.182819.1799958429533601186.git-patchwork-notify@kernel.org>
Date: Tue, 28 Apr 2026 01:10:10 +0000
References: <20260422100930.581237-1-paul.geurts@prodrive-technologies.com>
In-Reply-To: <20260422100930.581237-1-paul.geurts@prodrive-technologies.com>
To: Paul Geurts <paul.geurts@prodrive-technologies.com>
Cc: mgreer@animalcreek.com, sameo@linux.intel.com,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org, martijn.de.gouw@prodrive-technologies.com
X-Rspamd-Queue-Id: C525947C54E
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	RCVD_TLS_LAST(0.00)[];
	MISSING_XM_UA(0.00)[];
	TAGGED_FROM(0.00)[bounces-35428-lists,linux-wireless=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	FROM_NO_DN(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-wireless@vger.kernel.org];
	TO_DN_SOME(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[7];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]

Hello:

This patch was applied to netdev/net.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Wed, 22 Apr 2026 12:09:30 +0200 you wrote:
> The main channel Received Signal Strength Indicator (RSSI) measurement
> is used to determine whether an RF field is present or not. RSSI != 0
> is interpreted as an RF Field is present. This does not take RF noise
> and measurement inaccuracy into account, and results in false positives
> in the field.
> 
> Define a noise level and make sure the RF field is only interpreted as
> present when the RSSI is above the noise level.
> 
> [...]

Here is the summary with links:
  - NFC: trf7970a: Ignore antenna noise when checking for RF field
    https://git.kernel.org/netdev/net/c/a9bc28aa4e64

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



