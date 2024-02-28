Return-Path: <linux-wireless+bounces-4183-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 049DA86ADD6
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 12:44:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 35E6E1C21C54
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Feb 2024 11:44:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DED6159562;
	Wed, 28 Feb 2024 11:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eDktFgRI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F171615957D
	for <linux-wireless@vger.kernel.org>; Wed, 28 Feb 2024 11:36:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709120162; cv=none; b=UebpRDSjHXoXHGjTW2CjcgXISL9HNyGejEJ2e2g28AuScSthWwKIcd3hE72oiU6MEpmOxT+v/FBu9/l+Ans4gPcGbvlKCe817ra+6aOvIKUHTU0y2BsnTlSpSuWbqRU2efdpyI3rHZOnco95dVbVjL8jhIyKlRS93WSPgqGi7wM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709120162; c=relaxed/simple;
	bh=UV+KW9v+3bRuhunRQchX3s1dWanC2UuOa+Viq1tQe3s=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=loNV3laL/ofAjZO8IGMXvzI11M792u2upZDjhM23h2ZpivEnNUCCZfKe5bMte09HTEw64KhwNFV2jc9dE7mC9V0t3sG4umPaNI7j2LQvrt2QPTO6NQQqF3WVD+W3h4Gj08vkh7S+ak//AIu52CQs+zkNXWxpPvzFNtBt+Hxu5og=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eDktFgRI; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D259C433C7;
	Wed, 28 Feb 2024 11:36:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1709120161;
	bh=UV+KW9v+3bRuhunRQchX3s1dWanC2UuOa+Viq1tQe3s=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=eDktFgRI3SmNswp7jxRSiy3Oob0Bs6Day5nr2BR6BF+tpvXyE42jDTt8TIrj722ju
	 keCfKpcAC7KsaH8W4DA5oLnxOjuU0S0mKfVoZ7b6sliUGysHlIgkc0AgOm0Btx50Sp
	 LRcltevZfAE+8fsHqBacZzgcUipKkNc2SqYp9S6e/ceOWCHY1Jd8vujkleL9t6BrZl
	 Qqf+hxvgDzDVIaa3Ii1G7j++jyMNza4PdJE9Rv8lV+QGyi82Mf+WEAgdoTfyoSw4GO
	 W7P+GNQ0ZsRam8u4uscaVQYTBbA5A0/1wdxB1+Ja9Vvx4IXN6mtuS73B2/IKol84A9
	 2oK/1f6Ld+y+A==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: rsi: fix endian conversions
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: 
 <20240223115214.682fb94159fa.I576bbf9fe7ca2948dbe3e00c0fa0f37594e85046@changeid>
References: 
 <20240223115214.682fb94159fa.I576bbf9fe7ca2948dbe3e00c0fa0f37594e85046@changeid>
To: Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, Siva Rebbagondla <siva8118@gmail.com>,
 Johannes Berg <johannes.berg@intel.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170912015833.3742961.13610436136127981895.kvalo@kernel.org>
Date: Wed, 28 Feb 2024 11:36:00 +0000 (UTC)

Johannes Berg <johannes@sipsolutions.net> wrote:

> From: Johannes Berg <johannes.berg@intel.com>
> 
> This really seems like a bug, endian conversions now happen
> twice in this code.
> 
> Note also that prior to the commit mentioned below, the code
> was putting 16-bit values 0xBBAA as bytes "AA BB 00 00", and
> the commit mentions making it work for 32-bit values and
> makes no mention of fixing endian conversion; however, after
> it, the bytes for 0xBBAA would now be "00 00 BB AA" on big
> endian platforms.
> 
> Remove one conversion to make sparse no longer warn.
> 
> Not sure anyone can, has, or ever will use this on big endian
> platforms though.
> 
> Fixes: 0a60014b76f5 ("rsi: miscallaneous changes for 9116 and common")
> Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Fails to apply, I guess because I had a patch for this warning earlier.

Recorded preimage for 'drivers/net/wireless/rsi/rsi_91x_usb.c'
error: Failed to merge in the changes.
hint: Use 'git am --show-current-patch=diff' to see the failed patch
Applying: wifi: rsi: fix endian conversions
Using index info to reconstruct a base tree...
M	drivers/net/wireless/rsi/rsi_91x_usb.c
Falling back to patching base and 3-way merge...
Auto-merging drivers/net/wireless/rsi/rsi_91x_usb.c
CONFLICT (content): Merge conflict in drivers/net/wireless/rsi/rsi_91x_usb.c
Patch failed at 0001 wifi: rsi: fix endian conversions

Patch set to Changes Requested.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240223115214.682fb94159fa.I576bbf9fe7ca2948dbe3e00c0fa0f37594e85046@changeid/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


