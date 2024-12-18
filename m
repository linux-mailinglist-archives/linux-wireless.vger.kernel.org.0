Return-Path: <linux-wireless+bounces-16550-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 517C09F6CD8
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 19:04:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31BD118872A2
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Dec 2024 18:04:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7AB011FA270;
	Wed, 18 Dec 2024 18:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fUow7olC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4923B1494BB;
	Wed, 18 Dec 2024 18:04:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734545074; cv=none; b=rQQ+l07ginXMz+82I1DWqE3v0DfKxKot73WmP+BjI225TngENuHzGsZcl06zt/2JTZNsfR5Y76D8jSRP+O6AQTF3z9e8xqLUw2G8vpq2l5KCH9SQdS4LzwE4eepnYlO28B0W0M5QrqFa721LkR6byYyO/lE6hVj9zJe11LwpSnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734545074; c=relaxed/simple;
	bh=fE9hOwrzM/WSj4niXI0l1yWqwXDQdzc8MKYs7fJBzXY=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=CM2TieN00VgtjMrfaaF+i1denGxR4NY91jet7Z2thrqNNh5HQuxzq7OdBuKrTEpJKrBQr40eHzd00TMrgkdCxEiY+1Cnd47Vkaz4QAZMzijTgrARJjCi9ABYcFKq76mwQHOQ4Xi9nTCdknJxl9m36pmqfJJvqcU4dfKRJaiEa8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fUow7olC; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15741C4CECD;
	Wed, 18 Dec 2024 18:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734545073;
	bh=fE9hOwrzM/WSj4niXI0l1yWqwXDQdzc8MKYs7fJBzXY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=fUow7olCJUE170nN+8BWex56ROzpGi5iWlo8JjA3/Oo1GmyCBNvH4TrKgHlLbG+Rj
	 4Ctc5mPML+Q5FEheFhdXOk1+lpGoDMwLuuQjptRibN+i4d/G/14JLJ5c2WByn6CtE8
	 XDKABiAm6sWu5Fzz2XpMzG+eg6ksYxXLsCc1Q6aukabWDdtNQ2dTXVqIJEiIUo7QO4
	 qOG/imQAOuNOrUUmCNKcKIgjonXZtZt8WzVf4gBcdqAZEa+MOoq79aob8p/t/sUUmc
	 vGSKb/bPXNGeRyVJWBxZiW+RiN5ZaQdN5EQLHzj5/ELJzrTHnVkkJcJRMtvmq28hA5
	 OnoE7fWsRPOUQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: brcmfmac: clarify unmodifiable headroom log
 message
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20241213081402.625003-1-alexthreed@gmail.com>
References: <20241213081402.625003-1-alexthreed@gmail.com>
To: Alex Shumsky <alexthreed@gmail.com>
Cc: linux-wireless@vger.kernel.org, Alex Shumsky <alexthreed@gmail.com>,
 Al Viro <viro@zeniv.linux.org.uk>,
 Arend van Spriel <arend.vanspriel@broadcom.com>,
 brcm80211-dev-list.pdl@broadcom.com, brcm80211@lists.linux.dev,
 linux-kernel@vger.kernel.org
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <173454507036.1439980.9653301743382955086.kvalo@kernel.org>
Date: Wed, 18 Dec 2024 18:04:31 +0000 (UTC)

Alex Shumsky <alexthreed@gmail.com> wrote:

> Replace misleading log "insufficient headroom (0)" with more clear
> "unmodifiable headroom".
> 
> Signed-off-by: Alex Shumsky <alexthreed@gmail.com>
> Acked-by: Arend van Spriel <arend.vanspriel@broadcom.com>

Patch applied to wireless-next.git, thanks.

aeda9245c7ce wifi: brcmfmac: clarify unmodifiable headroom log message

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20241213081402.625003-1-alexthreed@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


