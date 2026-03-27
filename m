Return-Path: <linux-wireless+bounces-34025-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id MJ2rE0bexWk9CgUAu9opvQ
	(envelope-from <linux-wireless+bounces-34025-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 02:32:54 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id C125733DDC0
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 02:32:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id 9751D3034A1B
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Mar 2026 01:32:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DF4725E469;
	Fri, 27 Mar 2026 01:32:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XQKyc0tf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDAE022F01;
	Fri, 27 Mar 2026 01:32:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774575169; cv=none; b=hbtKHwDkgWtB24ImAII7zyXYBBpkj7lP92Ek2flLuphZgImIqHqzsP5PtnS19yI4DkT+Itv6IG/5dwVXUtRt/fr+07OvNMAS0K+nRrSwl4GZ+f+9tsS4R0p8xA0TBwhmIcaedYL8+Pcf7Ew+CMHXVZintCN2jpX5IWK1n2QfS18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774575169; c=relaxed/simple;
	bh=/cuVu2NodYsVtnWIWSwIrAf9sKqb4BaLpH0c4SVEQPA=;
	h=Content-Type:MIME-Version:Subject:From:Message-Id:Date:References:
	 In-Reply-To:To:Cc; b=mgs3nmob/vmobr3+O1A50pKOJ4c3RrEcHkYYopH/9ussSDuUR87Px7HN2l7y8pA8cM3TT1eJlar9rPgVIT8BfYSXl2aNHJAbHiaZzDs4xYrkZHt3MgFeBLgxOm74wZ8N2rEb9nhdxlKzR4gAPdXk299LZlw7HVkUVqD/WVvIEig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XQKyc0tf; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357A3C116C6;
	Fri, 27 Mar 2026 01:32:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774575168;
	bh=/cuVu2NodYsVtnWIWSwIrAf9sKqb4BaLpH0c4SVEQPA=;
	h=Subject:From:Date:References:In-Reply-To:To:Cc:From;
	b=XQKyc0tfbEVnRkj1hJzhrvpRO9YKjrggurbhW7R2+eZo6cHP6jq8mnm4Gw+WV0gRv
	 0eUBv3OqGBYLs9mLKx30gNalfrEis+VjWtLkJkG6mBmJX6h9kHklWAZ7SG4keH7gYM
	 IZ6QQIDYU9Pa9pz0cSUPzHhjmeUM6zwf5EVIByVe2RSv/iZpRMv+eQnsn7jTT6LEGK
	 hAIyS5JfkFaIov4S36wZO8e24FVytQSs4z+7dswvwKvVEIiLrdl9auynjHK16ZtU15
	 /ksEJg5c5liIjxRTLY+VhLYK1+kDIqBkl17rVop8+Myla1YLrC5H4JHwG7z8dbibyc
	 1ntqqNrzwNQGA==
Received: from [10.30.226.235] (localhost [IPv6:::1])
	by aws-us-west-2-korg-oddjob-rhel9-1.codeaurora.org (Postfix) with ESMTP id BA0443809A07;
	Fri, 27 Mar 2026 01:32:35 +0000 (UTC)
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [GIT PULL] wireless-next-2026-03-26
From: patchwork-bot+netdevbpf@kernel.org
Message-Id: 
 <177457515454.3250412.17111005644273633001.git-patchwork-notify@kernel.org>
Date: Fri, 27 Mar 2026 01:32:34 +0000
References: <20260326152021.305959-3-johannes@sipsolutions.net>
In-Reply-To: <20260326152021.305959-3-johannes@sipsolutions.net>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: netdev@vger.kernel.org, linux-wireless@vger.kernel.org
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[kernel.org,quarantine];
	R_DKIM_ALLOW(-0.20)[kernel.org:s=k20201202];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[patchwork-bot@kernel.org,linux-wireless@vger.kernel.org];
	RCVD_TLS_LAST(0.00)[];
	DKIM_TRACE(0.00)[kernel.org:+];
	TAGGED_FROM(0.00)[bounces-34025-lists,linux-wireless=lfdr.de,netdevbpf];
	MIME_TRACE(0.00)[0:+];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_THREE(0.00)[3];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	FROM_NO_DN(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	MISSING_XM_UA(0.00)[];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	TO_DN_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: C125733DDC0
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Hello:

This pull request was applied to netdev/net-next.git (main)
by Jakub Kicinski <kuba@kernel.org>:

On Thu, 26 Mar 2026 16:18:02 +0100 you wrote:
> Hi,
> 
> So couple more things for now, including the NAN (Neighbor
> Awareness Networking) APIs that we spent a lot of time on
> trying to get right :) Other than that changes all over.
> 
> We'll surely have more changes for NAN and also ranging
> (for proximity detection) is coming, it's looking to be
> a big 7.1 from a wifi perspective, but we'll see how it
> all comes together.
> 
> [...]

Here is the summary with links:
  - [GIT,PULL] wireless-next-2026-03-26
    https://git.kernel.org/netdev/net-next/c/dbd94b9831bc

You are awesome, thank you!
-- 
Deet-doot-dot, I am a bot.
https://korg.docs.kernel.org/patchwork/pwbot.html



