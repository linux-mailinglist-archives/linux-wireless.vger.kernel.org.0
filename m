Return-Path: <linux-wireless+bounces-12959-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 575BE97BD41
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 15:46:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1DCBB284A5E
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 13:46:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 890BD18952B;
	Wed, 18 Sep 2024 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fRR+TaBJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 64C89184114
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 13:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726667159; cv=none; b=qGxlt8pMd1lEJg6qA/ZAdad1PHy+bdsINXStAdzIlpwF0x6ACys663O7DCVL4jqR9ncfE2giXOsmNbu8XUdckq/4xSO0C5KgU6+r3ZAh9oMtWEd00jxhq/+OprYwWZldLPQBMLO/5wRah6a0AIDeL+gXtIMahg/n0DTdom129Yc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726667159; c=relaxed/simple;
	bh=R1AiKSFu5vuKogy54JUj6mXByNAeMRvZwqXgYIqDAa8=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=GdTdMLVhFCHv59Zu+Cv62k50GCL6Ebn1RXMRYA8D+AuGyB8ONvMvZiu+6r+VUC0y1BpW2eOW+qHAbsvDbjwMzBdM9zpgXzWxG1OFTi/aiZChgjZVt5Ww1MXguK1fvxKMFJs83KMwv55RnOl6+T1rppekLDnPA9kN5KJnespJSvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fRR+TaBJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9D27C4CEC2;
	Wed, 18 Sep 2024 13:45:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1726667158;
	bh=R1AiKSFu5vuKogy54JUj6mXByNAeMRvZwqXgYIqDAa8=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=fRR+TaBJ81vr/JsTOIu6wkIAnbYzZKW0ZaTZHD5QDzj4mVFuY3ClrH7EoUCFTJOMA
	 BMjLC0MgR4jDy974FQ+7LXscKdqssuU5XNnunWVnZJz4HuiYCFgNT+cTkuSe4aNjMd
	 wrnsivs5pYk7fY9a3WmjB6izgvRrrsKJUfshDmHkt5uM0Brl51AHWLKsOpqXuSC2W8
	 CZBCq5MgNdF611FYpoUwsq5RW5i/WeYkHb2zWoUdtF7FmmUOyLXdzGD1r6nqfGpwBJ
	 wHH+FLKZpcuQP+Bao2abEsEOjuRztC6QmtiiMu0+8l3t2DNaqLlJ9DbmhbrL27nSaA
	 nYNmnIK/tgqxQ==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: iwlegacy: Fix "field-spanning write" warning in
 il_enqueue_hcmd()
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <ZuIhQRi/791vlUhE@decadent.org.uk>
References: <ZuIhQRi/791vlUhE@decadent.org.uk>
To: Ben Hutchings <ben@decadent.org.uk>
Cc: linux-wireless@vger.kernel.org, Stanislaw Gruszka <stf_xl@wp.pl>,
 =?iso-8859-1?q?Martin-=C9ric?= Racine <martin-eric.racine@iki.fi>,
 Brandon Nielsen <nielsenb@jetfuse.net>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172666715574.3996465.3960547479597216434.kvalo@kernel.org>
Date: Wed, 18 Sep 2024 13:45:57 +0000 (UTC)

Ben Hutchings <ben@decadent.org.uk> wrote:

> iwlegacy uses command buffers with a payload size of 320
> bytes (default) or 4092 bytes (huge).  The struct il_device_cmd type
> describes the default buffers and there is no separate type describing
> the huge buffers.
> 
> The il_enqueue_hcmd() function works with both default and huge
> buffers, and has a memcpy() to the buffer payload.  The size of
> this copy may exceed 320 bytes when using a huge buffer, which
> now results in a run-time warning:
> 
>     memcpy: detected field-spanning write (size 1014) of single field "&out_cmd->cmd.payload" at drivers/net/wireless/intel/iwlegacy/common.c:3170 (size 320)
> 
> To fix this:
> 
> - Define a new struct type for huge buffers, with a correctly sized
>   payload field
> - When using a huge buffer in il_enqueue_hcmd(), cast the command
>   buffer pointer to that type when looking up the payload field
> 
> Reported-by: Martin-Éric Racine <martin-eric.racine@iki.fi>
> References: https://bugs.debian.org/1062421
> References: https://bugzilla.kernel.org/show_bug.cgi?id=219124
> Signed-off-by: Ben Hutchings <ben@decadent.org.uk>
> Fixes: 54d9469bc515 ("fortify: Add run-time WARN for cross-field memcpy()")
> Tested-by: Martin-Éric Racine <martin-eric.racine@iki.fi>
> Tested-by: Brandon Nielsen <nielsenb@jetfuse.net>
> Acked-by: Stanislaw Gruszka <stf_xl@wp.pl>

Should this patch go wireless tree for v6.12? As this is a regression I think
it should.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/ZuIhQRi/791vlUhE@decadent.org.uk/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


