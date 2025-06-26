Return-Path: <linux-wireless+bounces-24569-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65D0BAEA485
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 19:40:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 19CAB17FE47
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 17:40:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E25AA2E5424;
	Thu, 26 Jun 2025 17:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="AX6ZuC3D"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D49631F5828;
	Thu, 26 Jun 2025 17:40:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750959626; cv=pass; b=cGbJZCib+ZI3lADW10euarzztp5Qz7uPLTefYdnwPXP6f6k/j2AhkLr1uwO9yONyP8NwczQU3uwZKPID0tu8Iw6PbMGKGgA17QUDrF0c5sWavDPU6jUvHHnc+A8en1j98RVgVGol1+N28KfaU67xJAmsiUJS76Q5+kRcj8srByk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750959626; c=relaxed/simple;
	bh=D+OrFF0y2Fir+Ix0NvFJdJwyQB6g9qXrFBDGSEHHH90=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=cKU0nP17n0OG2TbMzab7Ej7FjCthMOiqOlPbvbRBWdyWChsEjus58Q2cw7omU73/+NXjb356u4tnx6lV0R8VVsDdPaKXFsbsHLxOGoWOmiihphJp4F7Q/nAqPz02lrDvaDHMeNgKNcM+8NV1GYotLM02v6g9PWrjRXNIOUgbSgs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=AX6ZuC3D; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1750959595; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Mmb+f4ZWCUo9GBSmRldzmeJLMUdYDwzTZhy2HScX/XjewpqkPiL02caw56hcIiETnOBZLx6FOzC9T1vID61RI4AqMHVhtYDJ3P8XjZCDKl9EUBj4HUcYGSNgrsCNkgPhcA4Mia42ZYtrNcy/6cDihYuAAKS1MVdoQ+HNTwYNmfc=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1750959595; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=ecYgXEsH7M5ZozoPfYHUQqxlKMweMDt5KaU45qVQwDM=; 
	b=jZdljkBNAfewjMdXoSWqevLj/i6uKXJSK54w03Tg4EeFaJKeqFi3X/6Z+zJmhJ82LrvigWBOq484OzwVscMPhY34NLkjcMM0UCwEgCYPKhkCctNp0h/LSJC7xZwSuqFAhd+MDluIK9XqxaDlu25geR6vFEsVKDyy1HYVTmPe02c=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1750959595;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:From:From:To:To:Cc:Cc:References:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=ecYgXEsH7M5ZozoPfYHUQqxlKMweMDt5KaU45qVQwDM=;
	b=AX6ZuC3DutekJ1wSPD0J63Ol97yR27H6irJ3YO2TxLQA7WAlj3H1AuLOHfNnz6s8
	pF/dXI3D+2iH9X19XUZfs72AyIKOjEciS1IX2Kc9We4oCrC2cOC9ej4lwG3mZTJDRYr
	Bd2FjheyVRpD8uB/pdbfNNUU2ganW23lBaGui3Ic=
Received: by mx.zohomail.com with SMTPS id 1750959592998994.6843598636191;
	Thu, 26 Jun 2025 10:39:52 -0700 (PDT)
Message-ID: <63fee713-34f0-4c76-bd38-8f2fc095849f@collabora.com>
Date: Thu, 26 Jun 2025 22:39:45 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [Bug Report] mhi: ath11k: dma_alloc_coherent() failures during
 resume
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
To: Manivannan Sadhasivam <mani@kernel.org>,
 Jeff Johnson <jjohnson@kernel.org>, quic_bqiang@quicinc.com,
 jeff.hugo@oss.qualcomm.com
Cc: mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, ath11k@lists.infradead.org,
 linux-wireless@vger.kernel.org, ath12k@lists.infradead.org,
 sumit.garg@kernel.org
References: <ead32f5b-730a-4b81-b38f-93d822f990c6@collabora.com>
Content-Language: en-US
In-Reply-To: <ead32f5b-730a-4b81-b38f-93d822f990c6@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi,

I'm trying to understand ath11k_core_reconfigure_on_crash(). It seems after
every suspend/hibernate cycle, the hal and dp specifically are de-initialized
and initialized again to have clean state again to start working with firmware.
When there's memory pressure, driver isn't able to get the free-ed dma memory
area again.

The name of the function, ath11k_core_reconfigure_on_crash() suggests that we
are recovering from crash and that's why all of the states of different
components are being allocated cleanly from the start. But we aren't resuming
from crash, instead we are resuming from suspend which was handled by the driver
itself. So this state cleanup must have been done by the suspend handler.

Any pointers on how to avoid going through deinit-init cycle of whole objects
every time?

Thanks,
Usama

On 6/19/25 3:27 PM, Muhammad Usama Anjum wrote:
> Hi,
> 
> When there is memory pressure during resume and no DMA memory is available,
> the ath11k driver fails to resume. The driver currently frees its DMA memory
> during suspend or hibernate, and attempts to re-allocate it during resume.
> However, if the DMA memory has been consumed by other software in the
> meantime, these allocations can fail, leading to critical failures in the WiFi
> driver.
> 
> Although I have recently fixed several instances to ensure DMA memory is not
> freed once allocated, we continue to receive reports of failures. I was
> preparing to submit a patch for the another case, but this issue cannot be
> fully resolved as long as even one DMA allocation remains in the resume path.
> 
> The following functions are allocating dma memory in resume path:
> 
> <function> <size> <index>
> mhi_init_dev_ctxt dma_alloc_coherent(5632)
> mhi_init_dev_ctxt dma_alloc_coherent(88)
> mhi_alloc_aligned_ring dma_alloc_coherent(1023)
> mhi_alloc_aligned_ring dma_alloc_coherent(8191)
> mhi_init_dev_ctxt dma_alloc_coherent(44)
> mhi_alloc_aligned_ring dma_alloc_coherent(4095)
> mhi_alloc_aligned_ring dma_alloc_coherent(2047)
> mhi_alloc_aligned_ring dma_alloc_coherent(2047)
> ath11k_hal_alloc_cont_rdp dma_alloc_coherent(688)
> [ath11k_hal_alloc_cont_wrp dma_alloc_coherent(180)
> ath11k_dp_srng_setup dma_alloc_coherent(262143)
> ath11k_dp_link_desc_bank_alloc dma_alloc_coherent(2097152) 0
> ath11k_dp_link_desc_bank_alloc dma_alloc_coherent(2097152) 1
> ath11k_dp_link_desc_bank_alloc dma_alloc_coherent(384) 2
> ath11k_dp_srng_setup dma_alloc_coherent(2055)
> ath11k_dp_srng_setup dma_alloc_coherent(1031)
> ath11k_dp_srng_setup dma_alloc_coherent(1159)
> ath11k_dp_srng_setup dma_alloc_coherent(16391)
> ath11k_dp_srng_setup dma_alloc_coherent(1048583)
> ath11k_dp_srng_setup dma_alloc_coherent(1031)
> ath11k_dp_srng_setup dma_alloc_coherent(32775)
> ath11k_dp_srng_setup dma_alloc_coherent(8199)
> ath11k_dp_srng_setup dma_alloc_coherent(10247)
> ath11k_dp_srng_setup dma_alloc_coherent(212999)
> ath11k_dp_srng_setup dma_alloc_coherent(131079)
> ath11k_dp_srng_setup dma_alloc_coherent(131079)
> ath11k_dp_srng_setup dma_alloc_coherent(131079)
> ath11k_dp_srng_setup dma_alloc_coherent(131079)
> ath11k_dp_srng_setup dma_alloc_coherent(32775)
> ath11k_dp_srng_setup dma_alloc_coherent(8199)
> ath11k_dp_srng_setup dma_alloc_coherent(8199)
> ath11k_dp_srng_setup dma_alloc_coherent(32775)
> ath11k_dp_srng_setup dma_alloc_coherent(32775)
> ath11k_dp_srng_setup dma_alloc_coherent(8199)
> ath11k_dp_srng_setup dma_alloc_coherent(8199)
> 
> Let's discuss the general possible solution for this. I'm sure a lot
> of other drivers would be facing the same kind of issues. What can be
> general approach to solve this problem.
> 
> Regards,
> Muhammad Usama Anjum


