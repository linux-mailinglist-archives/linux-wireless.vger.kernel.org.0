Return-Path: <linux-wireless+bounces-13266-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id DDD3D988EB6
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 11:13:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 983A61F21804
	for <lists+linux-wireless@lfdr.de>; Sat, 28 Sep 2024 09:13:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 538AF19AD85;
	Sat, 28 Sep 2024 09:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="T+7YhzVQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DB3114D2B1
	for <linux-wireless@vger.kernel.org>; Sat, 28 Sep 2024 09:13:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727514786; cv=none; b=itvzlCPfKPBoYjB5sgGzHyI38Ck3IcqQ07Gooe2g7qwF7np81ZtcDFaKdv4Rgz4uFj/UICf+X79Cv3+bDm90eAU0GWzp2c8yo/Xko5aUlECf3773c5ysWE+/P9ofwqZypGUwPoecwLI76mgrx5N2myYvsPPzJvcnQ/KTNGzHl1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727514786; c=relaxed/simple;
	bh=8/JQT2MYezwnANraA78P+Yt1ozUwaArcy0dZ2wd0BVA=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=BYACSMMM/6oY02f0MkKt2M6p7PQAtEtEAHgm+c9SxYbvwkDgdpXxA7GdyAY7gvwZ9kU42v7DWA20PstF/JqJkKpVaVP09ix5KaFXrNSREhI0cNnvfWs8noOa9+BO2BQa1YUA7KSRaOxPVObX1wB0ESXFzGXhQiEGFBaS/MM3mbM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=T+7YhzVQ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 95B98C4CEC3;
	Sat, 28 Sep 2024 09:13:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1727514785;
	bh=8/JQT2MYezwnANraA78P+Yt1ozUwaArcy0dZ2wd0BVA=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=T+7YhzVQfpd4PHcgySsM0szy4kzfqD3nJ3bvIVHNCywWo71Wtd9dj/+aHWDcRqHXW
	 a+hMuDjK7/BMeBI8hhSe7nI7rKjFypQkdrxRBURBVIbj7Xi/NTxFD9v5INzf1eoM0X
	 AUdHK18lY3QedQDLakOSLOTnmbVkBNaN3K3uS8WWQWK9ZCqzAKEISRKBJX0li1YLm+
	 EuoDlsl53V7TdxEFbao3+lCoYomoQkOgMpTNjjoLDNPo+X7difhU0P4SK1fCeWPegy
	 Wz+bwSeX+bFQEvQfJVueCr8hcvtZQffImUQKvOPCuJtCBbBm6bFa/5UphTz4+VXr8a
	 PlfTI8bhzii+Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH] wifi: ath10k: fix the stack frame size warning in
 ath10k_remain_on_channel
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240830015349.1083226-1-quic_miaoqing@quicinc.com>
References: <20240830015349.1083226-1-quic_miaoqing@quicinc.com>
To: Miaoqing Pan <quic_miaoqing@quicinc.com>
Cc: <quic_jjohnson@quicinc.com>, <ath10k@lists.infradead.org>,
 <linux-wireless@vger.kernel.org>, Miaoqing Pan <quic_miaoqing@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <172751478271.2249584.10843872161726973254.kvalo@kernel.org>
Date: Sat, 28 Sep 2024 09:13:04 +0000 (UTC)

Miaoqing Pan <quic_miaoqing@quicinc.com> wrote:

> Fix the following W=1 kernel build warning:
> 
> drivers/net/wireless/ath/ath10k/mac.c: In function ‘ath10k_remain_on_channel’:
> drivers/net/wireless/ath/ath10k/mac.c:7980:1: warning: the frame size of 1064 bytes is larger than 1024 bytes [-Wframe-larger-than=]
> 
> Compile tested only.
> 
> Signed-off-by: Miaoqing Pan <quic_miaoqing@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

c4c074d3fddc wifi: ath10k: fix the stack frame size warning in ath10k_remain_on_channel

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240830015349.1083226-1-quic_miaoqing@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches
https://docs.kernel.org/process/submitting-patches.html


