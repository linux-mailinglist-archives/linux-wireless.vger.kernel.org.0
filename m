Return-Path: <linux-wireless+bounces-11304-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D27A94EBD2
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 13:31:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6E1CC1C21028
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Aug 2024 11:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06C48170A04;
	Mon, 12 Aug 2024 11:31:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LNFdpf1W"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D19AB3C0B;
	Mon, 12 Aug 2024 11:30:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723462259; cv=none; b=SI8yx18SzO2RghQ8+tGja1MvFD+4VPCHDijs9B702PzBmm/s+7+9rhhcfQ3wKBmZfmGdCZLm4zop3JsAaBJxbQUYyM2gBvmkvqlrN4yfFBB3DdQW4aPNnDlykzvxed4Qu7X1kazg3t8PyH/FwaEYHuuZcjT+XMz1C1zPADTmZXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723462259; c=relaxed/simple;
	bh=KqbuYjVKAwBokFKAy/lvQSRnx3nUBagrATlyS/atdkc=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=C/LQiUhZUcIopHvrwkuV04wqGAtphldhzCmtV9q7Lug9BtYSIo6+qtorhXrUmFMW2EGmyyf3PujlZhFyuhzUmTa59pY1Il9Gg19sSXzB8vl0F+xlk2DcXg01RmWldwWt3UwnLm+QYOQQTgOdN+FRWmziThq22sOvb4vN5JDzgg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LNFdpf1W; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0D79C32782;
	Mon, 12 Aug 2024 11:30:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1723462259;
	bh=KqbuYjVKAwBokFKAy/lvQSRnx3nUBagrATlyS/atdkc=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=LNFdpf1W91rtB/grMvyJSCSAPJpQoGyJoCG36F5o5oAuQCCvhCMsK+0ECs+VGfSnh
	 lu/BmJZ65u+EQFKY/ZemGjNHVHSILVvh5AHZIuKkT0cOifwdEs5j/6PTQnpOe+ouYb
	 nehLK6fB3uKmc0gN/MGiHsZsXKf3JCrSGNCgRbYtaan6ugnGeqjnubAXxNAMI1HPHE
	 ApakdJ8gK2J9WUvAcJKCBvyVbueAWDfcGHzVs/ILgxh0gSEPF+x7crwPISalmtOAKG
	 OwVDBAtUmWlQkfYAR79EVqh3xhJLfYlyUdoWlV73hy7uE/pTIrX4ZGUmCXGMdjCnrF
	 YqqWUQQYiY42g==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: iwlwifi: correctly lookup DMA address in SG table
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240808172948.303258-1-benjamin@sipsolutions.net>
References: <20240808172948.303258-1-benjamin@sipsolutions.net>
To: Benjamin Berg <benjamin@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, benjamin.berg@intel.com,
 miriam.rachel.korenblit@intel.com, regressions@lists.linux.dev,
 johannes@sipsolutions.net, Chris Bainbridge <chris.bainbridge@gmail.com>,
 Ben Greear <greearb@candelatech.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172346225593.632971.15310170952433244795.kvalo@kernel.org>
Date: Mon, 12 Aug 2024 11:30:57 +0000 (UTC)

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

v2:

https://patchwork.kernel.org/project/linux-wireless/patch/20240812110640.460514-1-benjamin@sipsolutions.net/

Patch set to Superseded.

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240808172948.303258-1-benjamin@sipsolutions.net/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


