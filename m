Return-Path: <linux-wireless+bounces-11344-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5BD7995018D
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 11:50:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0728B1F2167D
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Aug 2024 09:50:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 958D317D340;
	Tue, 13 Aug 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LY1EVnr5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D19216BE01;
	Tue, 13 Aug 2024 09:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723542631; cv=none; b=LVStdKEqAwvYiykmmXhsok0s2RUmC7Ld5oYvHcEWxIksHiC2HScZFETX1L7/8V9YbzXCMdaYLOZhnNoIlijU2byJYKjmJqxnE23zh4HaC6tbVpcPhG40SVUhFW9aWNUjhG0YLU5riRN/MbXZ63wwdSurFGFstlmLpDz1m6nTprE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723542631; c=relaxed/simple;
	bh=7GqRI65VYmhchyuElnOc2Sl+ZiTVyE1M7EOnSBcgQRc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=AteQFFppt5apnTp2e18fWLB+eQvUR0ErAeuLi5zBqVrmt9KkkPxQFaVix+bhZxC2wvdIS3zIjaLt6gnTqASWy0ueSaNMbTfgk5QlU8QTYh2ZXqM820Bp3UOIFpBnGkO/qwWCp92zwJpCD3HRy+5leU5A/58GA6ZbRc/FXPTEip4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LY1EVnr5; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C11FC4AF09;
	Tue, 13 Aug 2024 09:50:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723542631;
	bh=7GqRI65VYmhchyuElnOc2Sl+ZiTVyE1M7EOnSBcgQRc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=LY1EVnr54qEz3prwx6nkOOR60VWv3zwOJHK+Jx3GwryZJFcYSXK39UzndWhxUxriO
	 cSfX5jbYpSNEkfbAFUP73C4nlSsHnIFNmFAhk5DxMd4njhQ/0J+osiDust2y0Hnazo
	 9MbsGv6pBVn03GZlFKBE3BMz30ulZxXnVNflNViz8iWerFF7UllichUpVE4kGC5d4A
	 wAKk31npzYwAz33khYRRJbB0rOSyppwkRGMVMQy9u+JECS10Uo2if/RcnKX8hfZYZ2
	 eKKWT+uQA3R3OmGbdS+NpXoloLpXnIoXvARrx9SCZwerAleMY4EJHwGwcISZcpH3Tf
	 QZL21gqQLRzVw==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: iwlwifi: correctly lookup DMA address in SG
 table
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240812110640.460514-1-benjamin@sipsolutions.net>
References: <20240812110640.460514-1-benjamin@sipsolutions.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, benjamin.berg@intel.com,
 miriam.rachel.korenblit@intel.com, regressions@lists.linux.dev,
 johannes@sipsolutions.net, Chris Bainbridge <chris.bainbridge@gmail.com>,
 Ben Greear <greearb@candelatech.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172354262732.696913.9750571464757847853.kvalo@kernel.org>
Date: Tue, 13 Aug 2024 09:50:29 +0000 (UTC)

Benjamin Berg <benjamin@sipsolutions.net> wrote:

> From: Benjamin Berg <benjamin.berg@intel.com>
> 
> The code to lookup the scatter gather table entry assumed that it was
> possible to use sg_virt() in order to lookup the DMA address in a mapped
> scatter gather table. However, this assumption is incorrect as the DMA
> mapping code may merge multiple entries into one. In that case, the DMA
> address space may have e.g. two consecutive pages which is correctly
> represented by the scatter gather list entry, however the virtual
> addresses for these two pages may differ and the relationship cannot be
> resolved anymore.
> 
> Avoid this problem entirely by working with the offset into the mapped
> area instead of using virtual addresses. With that we only use the DMA
> length and DMA address from the scatter gather list entries. The
> underlying DMA/IOMMU code is therefore free to merge two entries into
> one even if the virtual addresses space for the area is not continuous.
> 
> Fixes: 90db50755228 ("wifi: iwlwifi: use already mapped data when TXing an AMSDU")
> Reported-by: Chris Bainbridge <chris.bainbridge@gmail.com>
> Closes: https://lore.kernel.org/r/ZrNRoEbdkxkKFMBi@debian.local
> Signed-off-by: Benjamin Berg <benjamin.berg@intel.com>
> Tested-by: Chris Bainbridge <chris.bainbridge@gmail.com>

Patch applied to wireless.git, thanks.

38c8d02501c0 wifi: iwlwifi: correctly lookup DMA address in SG table

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240812110640.460514-1-benjamin@sipsolutions.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


