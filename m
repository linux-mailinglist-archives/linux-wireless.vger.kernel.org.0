Return-Path: <linux-wireless+bounces-2494-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99BC283C837
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 17:37:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 509681F2210D
	for <lists+linux-wireless@lfdr.de>; Thu, 25 Jan 2024 16:37:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DC23612FF97;
	Thu, 25 Jan 2024 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V/3myDpc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B8C7CF13
	for <linux-wireless@vger.kernel.org>; Thu, 25 Jan 2024 16:37:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706200668; cv=none; b=W21ybmQudJkL/tjLj5GAe/O+sIa8yjOvjb9TRYkW1J53xNG5zjMviMiEURfN+FdQhLUimWwNTjirCvekF08UwXJdHasQLmhhVWDPWfwfnGr2wBnJsNrZtw6oCWPEaNTidgZvHGYQEPVxo2IknYzRJ59IUhpdEQF5s9nK/+RRs1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706200668; c=relaxed/simple;
	bh=WYw4m0b98hGk2o3P5WPH7ylm5ZY+XZ7CvVVplA0O5gU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=rPlxrISBtlNPnKZzB1mtPJSx+ByNDpA8PgWOzMvXCJY8305u6jGYEJV+KAmlagDXwBrINWNUqWNvXrHUBIksCDI6QwArfxjlvFKESV6a9YElZSEoRbBtCnkH+6+vkeXEDFM5Qi8jq9bSJZV/8CohwIJ74iREGh1O/wSOjgkBSXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V/3myDpc; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D641C433C7;
	Thu, 25 Jan 2024 16:37:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706200668;
	bh=WYw4m0b98hGk2o3P5WPH7ylm5ZY+XZ7CvVVplA0O5gU=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=V/3myDpcdLuUu7jyh3JWj4M3LTcVz9eKetLyfIx7S6w8zw4CojtZSScQntyCZnsmF
	 p4UdtWVl1ACLwJTzBcNC60gGwselRsZBMO5lfhiS/HWWdy9uNA7bQmAjSl4iXzAUw+
	 xDKPKrtGPpp6cOfKCUF7xxGn4fMw+zzTwAoV5vCpEo0QsKhaKpfzlFckAfvIkGatPo
	 g/VDf7XDSpINPB/iXzUsPvmhMEpwsT0lxpBNgpMLOQdPaPGJBMGktOm8Y7ovIf95+p
	 7QPH9wyeWU1bYDaEf0uIkZaGvEAwcF+zaYPBR/91h8iB8zE78yqEfzOTej/T/YrmQC
	 JUY3QDdCeVygQ==
From: Kalle Valo <kvalo@kernel.org>
To: Jeff Johnson <quic_jjohnson@quicinc.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,  <ath11k@lists.infradead.org>,
  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath11k: enable 36 bit mask for stream DMA
References: <20240123015201.28939-1-quic_bqiang@quicinc.com>
	<73e9ddd2-7c0c-4a96-a120-7480ebffc4f0@quicinc.com>
Date: Thu, 25 Jan 2024 18:37:45 +0200
In-Reply-To: <73e9ddd2-7c0c-4a96-a120-7480ebffc4f0@quicinc.com> (Jeff
	Johnson's message of "Tue, 23 Jan 2024 18:35:47 -0800")
Message-ID: <878r4d1i92.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff Johnson <quic_jjohnson@quicinc.com> writes:

> On 1/22/2024 5:52 PM, Baochen Qiang wrote:
>
>> Currently 32 bit DMA mask is used, telling kernel to get us an DMA
>> address under 4GB when mapping a buffer. This results in a very high
>> CPU overhead in the case where IOMMU is disabled and more than 4GB
>> system memory is installed. The reason is, with more than 4GB memory
>> installed, kernel is likely to allocate a buffer whose physical
>> address is above 4GB. While with IOMMU disabled, kernel has to involve
>> SWIOTLB to map/unmap that buffer, which consumes lots of CPU cycles.
>> 
>> We did hit an issue caused by the reason mentioned above: in a system
>> that disables IOMMU and gets 8GB memory installed, a total of 40.5%
>> CPU usage is observed in throughput test. CPU profiling shows nearly
>> 60% of CPU cycles are consumed by SWIOTLB.
>> 
>> By enabling 36 bit DMA mask, we can bypass SWIOTLB for any buffer
>> whose physical address is below 64GB. There are two types of DMA mask
>> within struct device, named dma_mask and coherent_dma_mask. Here we
>> only enable 36 bit for dma_mask, because firmware crashes if
>> coherent_dma_mask is also enabled, due to some unknown hardware
>> limitations. This is acceptable because coherent_dma_mask is used for
>> mapping a consistent DMA buffer, which generally does not happen in
>> a hot path.
>> 
>> With this change, the total CPU usage mentioned in above issue drops
>> to 18.9%.
>> 
>> Tested-on: WCN6855 hw2.1 PCI
>> WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.23
>> Tested-on: QCN9074 hw1.0 PCI WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>> Tested-on: IPQ8074 hw2.0 AHB WLAN.HK.2.7.0.1-01744-QCAHKSWPL_SILICONZ-1
>> 
>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> ---
>>  drivers/net/wireless/ath/ath11k/mhi.c |  2 +-
>>  drivers/net/wireless/ath/ath11k/pci.c | 16 +++++++++++++---
>>  drivers/net/wireless/ath/ath11k/pci.h |  1 +
>>  3 files changed, 15 insertions(+), 4 deletions(-)

> My Qualcomm Innovation Center copyright checker reports:
>
> drivers/net/wireless/ath/ath11k/mhi.c copyright missing 2024
> drivers/net/wireless/ath/ath11k/pci.c copyright missing 2024
> drivers/net/wireless/ath/ath11k/pci.h copyright missing 2024
>
> Kalle can fix this in the pending tree

Yup, added those.

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

