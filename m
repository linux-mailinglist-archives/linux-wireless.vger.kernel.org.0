Return-Path: <linux-wireless+bounces-1710-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7275882AD33
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 12:19:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0BD1F282F67
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 11:19:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF9661549B;
	Thu, 11 Jan 2024 11:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d1s59qoE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C67FD15496
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 11:18:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EF51C433F1;
	Thu, 11 Jan 2024 11:18:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1704971938;
	bh=5Cix56vFM6aAxtW3khDlrq6pP687nQKFNumsJmKbMYY=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=d1s59qoECwgrm6ZwVOwT2yWKfAPFlbPs2RlqLtly+eh9VLMhj0djZQfdeTNNprcX+
	 7jiFdqzGYx1Clmtp9dg+4cI3//xlpQASap+IeZBSmfriMYos5uJDkaDpd4HENUQadr
	 Nt3SBGpQ6Tyc7E/PH3mjXgkIbNF4FsS2RaXi0IXY7CFQVYwgR9mtt+uL3aJIwKLiiU
	 6Mo3OMuok+ORxOn/1g02YWDVMrCMT/Dd44Qe3EyhNenEo1g42AG6bljsIE6L0OzOZq
	 u2wqrVJVmWH68w8pQ8rXYnrwxB2NBl8WlSqhlcyMIIF1nrp5RdqfOtYBG0AlNTNAuv
	 U5GrRaQppYikg==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH v2] wifi: ath11k: fix IOMMU errors on buffer rings
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20231212031914.47339-1-imguzh@gmail.com>
References: <20231212031914.47339-1-imguzh@gmail.com>
To: Zhenghao Gu <imguzh@gmail.com>
Cc: ath11k@lists.infradead.org, linux-wireless@vger.kernel.org,
 Zhenghao Gu <imguzh@gmail.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170497193566.659902.18362636200509021901.kvalo@kernel.org>
Date: Thu, 11 Jan 2024 11:18:57 +0000 (UTC)

Zhenghao Gu <imguzh@gmail.com> wrote:

> virt_to_phys() doesn't work on systems with IOMMU enabled, which have
> non-identity physical-to-IOVA mappings.  It leads to IO_PAGE_FAULTs like this:
> 
> [IO_PAGE_FAULT domain=0x0023 address=0x1cce00000 flags=0x0020]
> 
> And no association to the AP can be established.
> 
> This patch changes that to dma_map_single(), which works correctly. Even
> virt_to_phys() documentation says device drivers should not use it:
> 
>     This function does not give bus mappings for DMA transfers. In
>     almost all conceivable cases a device driver should not be using
>     this function
> 
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Zhenghao Gu <imguzh@gmail.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

aaf244141ed7 wifi: ath11k: fix IOMMU errors on buffer rings

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20231212031914.47339-1-imguzh@gmail.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


