Return-Path: <linux-wireless+bounces-11134-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E78694C489
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 20:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 385DA288BF3
	for <lists+linux-wireless@lfdr.de>; Thu,  8 Aug 2024 18:39:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCFB813DDD9;
	Thu,  8 Aug 2024 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RELpqUmz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A12949479;
	Thu,  8 Aug 2024 18:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723142357; cv=none; b=N1MI3MBeVZGP0NuxwmYvD+1rTrEwTpysiOzsSurMmQ+yYLHiCfofh2ZRJKoxn6iQpcXL5S0796lvSkgYSY1t0yxC8+F0eStvZkdIFL2wYFlXiDXgX1RanYxffvk2W+88shVHBvXTx1knGKmMvWJ5nmlHlnD7QloD5L+sheU7w0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723142357; c=relaxed/simple;
	bh=OD5QFyd3js9Q8D/CbcwQSOoSYA5oX+Ue/b6PWIfIdSk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=oIXNS5cTumWc9J5Hxbi4IpUPKgFBD3edrMqFpcjjDU5/+0IIJ73ZhrFuns04bxkBedip7vZqApENYCw7zCF50BvuacX8bkE7fAaxTE2E/I7SYWg/EdKX9A8IChefnWO8dhkVuhs7Ej/XNvf3U2YIXyQAlc4nufKRP+/gG7yhzHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RELpqUmz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CCDAC32782;
	Thu,  8 Aug 2024 18:39:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723142357;
	bh=OD5QFyd3js9Q8D/CbcwQSOoSYA5oX+Ue/b6PWIfIdSk=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=RELpqUmzh26C6qc/6F5dKzm1eowqq3EG8AMPJF3ZR274dk2jgO2XqJhH84mJCpaRX
	 Ja9+NfDKIH+GwidKw1H120gTpMJctBw1+pf9h5pe1YybhqEWttpohhDoTSEqU8+dG1
	 AyK/7qBE1McJ+8M7C/YatXrdnSjgKUojTeoQE46aFSpCqrl+Jo3kiok5MJG1Msvx3J
	 0hfwqVrnjlDyTtFElRKoOKzcdYXFmldl20StsaXA4NDzw6L0lAvYypGCdsqyURzbkN
	 ZP8jC8CiaRSrd1tGJdjfLKNEubW1nOoMLSzJn9iT+52OcfgxCjz+Ca3hiRi0bgGSAK
	 fjOzqgnUBiEqQ==
From: Kalle Valo <kvalo@kernel.org>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,  benjamin.berg@intel.com,
  miriam.rachel.korenblit@intel.com,  regressions@lists.linux.dev,
  johannes@sipsolutions.net,  Chris Bainbridge
 <chris.bainbridge@gmail.com>,  Ben Greear <greearb@candelatech.com>
Subject: Re: [PATCH] wifi: iwlwifi: correctly lookup DMA address in SG table
References: <20240808172948.303258-1-benjamin@sipsolutions.net>
Date: Thu, 08 Aug 2024 21:39:13 +0300
In-Reply-To: <20240808172948.303258-1-benjamin@sipsolutions.net> (Benjamin
	Berg's message of "Thu, 8 Aug 2024 19:29:48 +0200")
Message-ID: <87jzgq3lm6.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Benjamin Berg <benjamin@sipsolutions.net> writes:

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

Reminder to myself: if this passes the tests it should go to wireless
tree. Assigned the patch to me on patchwork.

Miri, if you agree please give an Acked-by.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

