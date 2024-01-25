Return-Path: <linux-wireless+bounces-2495-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B803883C83A
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 17:38:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 46F37B2540E
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 16:38:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DCEB512FF8C;
	Thu, 25 Jan 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qKeRe6Lt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B815812FF8A
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 16:38:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200692; cv=none; b=qapUft7F3ySNcz9uFILelY2OSgq+XexSyrOHIrtaRjmu+xpbwcJKDdpnFYY+zQzDYCElUyN0q4YAD0A8EW8JDkeBv1xJp5gdXBn8JuPyUGW6CKiP4M+zwOA4j88QmWjb0uWasgde4ju8PTrFJwF0KyvYniz2hnDwdCepd84vSDs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200692; c=relaxed/simple;
	bh=1k/fOt1ptdKUqxoEp0Ten5ndypjM0YAoefKa2pgGH3w=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=RhVnibn0xxw3Nc1MByGDKX6p439arpPrjdO8BJ7esZWbEabGHXdM+9tBPcXqtrd7lHQgHwZygG4JYnBp5mcuyRkkbuwPF8VwLRQ6PKtJRzwSGUiXTUfLl5q4DcuE8L+3sXJ/06ceTIMEs0ZQeulVugLijsl6o9/fvT4KnLSi/Js=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qKeRe6Lt; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41482C43390;
	Thu, 25 Jan 2024 16:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706200692;
	bh=1k/fOt1ptdKUqxoEp0Ten5ndypjM0YAoefKa2pgGH3w=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=qKeRe6LtfgZJvDxbAqW8UF+UB/zyDAW2TlnRuF6N0oHJSEez8m0DeJsRCkBO9dunV
	 mAZjUiZbDz3nbMWAzceSffz6zlf63vMwKEMZhmmM/B7lKky3ILlDLkc/C3IMnS2fiQ
	 G/4+j/nSGAnH/Jm9FX6tkBNBh7i9R53vcNsxQYnpmd6W7r+mxGiwnodG0shB0+Jdnd
	 2qe0qslG7ksAjw2fA9xuK6MZRlDO14LaLtPSzO2XOVW6iPo+5kAd035GkJcnq3Pqlj
	 0cwaqtY/FMy4BeaCC51Rdv9pzC3ffTMCeDmCvQE0KbpfJty4cp/HT5Pwmpx7IVLUYM
	 wV4zuk3t3DB3Q==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath11k: enable 36 bit mask for stream DMA
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240123015201.28939-1-quic_bqiang@quicinc.com>
References: <20240123015201.28939-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath11k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <170620068905.500647.8187957964143425904.kvalo@kernel.org>
Date: Thu, 25 Jan 2024 16:38:11 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Currently 32 bit DMA mask is used, telling kernel to get us an DMA
> address under 4GB when mapping a buffer. This results in a very high
> CPU overhead in the case where IOMMU is disabled and more than 4GB
> system memory is installed. The reason is, with more than 4GB memory
> installed, kernel is likely to allocate a buffer whose physical
> address is above 4GB. While with IOMMU disabled, kernel has to involve
> SWIOTLB to map/unmap that buffer, which consumes lots of CPU cycles.
> 
> We did hit an issue caused by the reason mentioned above: in a system
> that disables IOMMU and gets 8GB memory installed, a total of 40.5%
> CPU usage is observed in throughput test. CPU profiling shows nearly
> 60% of CPU cycles are consumed by SWIOTLB.
> 
> By enabling 36 bit DMA mask, we can bypass SWIOTLB for any buffer
> whose physical address is below 64GB. There are two types of DMA mask
> within struct device, named dma_mask and coherent_dma_mask. Here we
> only enable 36 bit for dma_mask, because firmware crashes if
> coherent_dma_mask is also enabled, due to some unknown hardware
> limitations. This is acceptable because coherent_dma_mask is used for
> mapping a consistent DMA buffer, which generally does not happen in
> a hot path.
> 
> With this change, the total CPU usage mentioned in above issue drops
> to 18.9%.
> 
> Tested-on: WCN6855 hw2.1 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Acked-by: Jeff Johnson <quic_jjohnson@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

dbd73acb22d8 wifi: ath11k: enable 36 bit mask for stream DMA

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240123015201.28939-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


