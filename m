Return-Path: <linux-wireless+bounces-11303-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 52D9894EBC7
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 13:27:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7E9141C20D49
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 11:27:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0A2B9171066;
	Mon, 12 Aug 2024 11:27:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZjUFVZwY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4D83130495;
	Mon, 12 Aug 2024 11:27:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462051; cv=none; b=h+IY9xBrAreWJ4wnOOYfg+fJK/T2p4/WgFMTwCmTIchabEhdAXY8/EsIS7VS5CthhqwAqfuT4woB8at3YOHU4XqiJnGCdf3Zg54iOGkkggJKiDKa7m/kpZeULN5YwtWcoCO/Fzrx6sFIvC1Dd5l/ZFhI9lDoLvqmUY5hVWqtqdg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462051; c=relaxed/simple;
	bh=lwg8c5WCMec9KytX/bVBcZpO1dEPlR0fmrnbbVlaHcQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=YXYpj7CEcXw9JoZKNG1OztR1QztTjMBN96sw7WE8vuPastWSHbCjt0nfB+bFXljb+mCkaAP//11yFGtB5uGe4w5C5d75FBB1CFHoUr9lKWtMM8EfQUuiDBtTal/UvaDrYN0m+rj6Qm6s/4mhtwM2999wDXptqTV8r3rQoW30QCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZjUFVZwY; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC99C32782;
	Mon, 12 Aug 2024 11:27:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723462050;
	bh=lwg8c5WCMec9KytX/bVBcZpO1dEPlR0fmrnbbVlaHcQ=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=ZjUFVZwYdklYuznX3aTWhBDgAoo5ZQqDW5sIM14NrnYMXU0SE8IMJnXPmM+AAiJej
	 N93jc/zNDJTi8rmI0xT1nnVXeASOm2gAw0sQ90vI4zNMkgvEYhRaaFTPdAtLako4pX
	 jMFhxF8VfyDg2qYG60UTMCYJO/VcwLDQKp0M8E6PgOKnze2JVER5g9tQ2VyxsF8jl7
	 BMiPNfKbSU4YCdR53Z74BDeYYwWGqx22VCHfz3bbmuReeVbWkseWPA6n9fGJRveLZC
	 1IXh3J4gvGwEfHtWup9h1SdvYGhjg5kObQVtqp0VtsuStMPyd4bAsHvscQ0E1Stjbh
	 nDVR/SRJQEsQg==
From: Kalle Valo <kvalo@kernel.org>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org,  benjamin.berg@intel.com,
  miriam.rachel.korenblit@intel.com,  regressions@lists.linux.dev,
  johannes@sipsolutions.net,  Chris Bainbridge
 <chris.bainbridge@gmail.com>,  Ben Greear <greearb@candelatech.com>
Subject: Re: [PATCH v2] wifi: iwlwifi: correctly lookup DMA address in SG table
References: <20240812110640.460514-1-benjamin@sipsolutions.net>
Date: Mon, 12 Aug 2024 14:27:24 +0300
In-Reply-To: <20240812110640.460514-1-benjamin@sipsolutions.net> (Benjamin
	Berg's message of "Mon, 12 Aug 2024 13:06:40 +0200")
Message-ID: <87ttfq0yn7.fsf@kernel.org>
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
>
> ---
>
> We also verified the (previous) patch internally and it is working well
> there now.
>
> v2: Add proper bounds checking by verifying the length

Excellent, thank you Benjamin for working on this. Miri, can I have your
ack? I would like to apply this tomorrow so that it makes it still this
week's wireless pull request.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

