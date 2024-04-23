Return-Path: <linux-wireless+bounces-6706-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B67C8AE0F5
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 11:26:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A7331C2112C
	for <lists+linux-wireless@lfdr.de>; Tue, 23 Apr 2024 09:25:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67CD05730D;
	Tue, 23 Apr 2024 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="s6W0330S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442CB5579F
	for <linux-wireless@vger.kernel.org>; Tue, 23 Apr 2024 09:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713864356; cv=none; b=OMG3r7mbWyioN25hQ2Qm/F4dTzgjdu+7UVTzoPxvNsolZvynR/cMeT3VWTg7LtN3RL8CsDfJgQFiPOf82GteQ0H0hgPD9TPjpEA2bB1oyiaT2dGht5CXQqcBAitShRN707PAzRgAAgpniIAF/ybJQ/q54NvEgpDoicxStJ9VNi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713864356; c=relaxed/simple;
	bh=ekQvMuoP+FI4HKCJLTmh2Zxtz/9KBDu2KiYpCcBi/gM=;
	h=Content-Type:MIME-Version:Subject:From:In-Reply-To:References:To:
	 Cc:Message-ID:Date; b=uDCPoKMUXTK9YSoXFfEhcjPlv281CTAb2Fp2f1QPznhkkT7pyJbIU3rjzZtGT/MMLwTv4mAK+NRlu18/Vp1gchtCV2hkwkk0qzxYqOVvKU+I0cqJ2tGYhYpEfdC5znlKjT4bS3p7H2gniW8Tv4Icr98c9P6c55YbwW+LEmB2nYI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=s6W0330S; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7BB3C116B1;
	Tue, 23 Apr 2024 09:25:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713864355;
	bh=ekQvMuoP+FI4HKCJLTmh2Zxtz/9KBDu2KiYpCcBi/gM=;
	h=Subject:From:In-Reply-To:References:To:Cc:Date:From;
	b=s6W0330SW+5Wv+eMWP+BFLVrF5f5awpw6FgM6wjP6q0q3gCCSvo+ONdIXpVScEtF6
	 Z8G8KK117kfW3m9BOPEHIcyFWK+nNevp4kedaEVJy5Hacpc6L3in4ea6UmoAMzqw1N
	 /Nj6Bgz5QPg4SYEBf2dokjpM0++zrSTn1hDio0mZcelJLXRcuOq1ro2/57T+1ziJnk
	 bBxkYFgleWMWY5qmEhtTysNlyn0RhTUztqnJ1aB2g3lKayFgdCiVt4oORPqvj31SGC
	 8OOnPwXEUll/ve/FkDM2l7AckhM42KgQ0EyYN6wIjbOPnpGB+r/CDTfQV63Gok6IwM
	 6G7sqmyAUuLow==
Content-Type: text/plain; charset="utf-8"
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: Re: [PATCH] wifi: ath12k: fix kernel crash during resume
From: Kalle Valo <kvalo@kernel.org>
In-Reply-To: <20240419034034.2842-1-quic_bqiang@quicinc.com>
References: <20240419034034.2842-1-quic_bqiang@quicinc.com>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>, <linux-wireless@vger.kernel.org>,
 <quic_bqiang@quicinc.com>
User-Agent: pwcli/0.1.1-git (https://github.com/kvalo/pwcli/) Python/3.11.2
Message-ID: <171386435297.1790113.16571141452789513648.kvalo@kernel.org>
Date: Tue, 23 Apr 2024 09:25:54 +0000 (UTC)

Baochen Qiang <quic_bqiang@quicinc.com> wrote:

> Currently during resume, QMI target memory is not properly handled, resulting
> in kernel crash in case DMA remap is not supported:
> 
> BUG: Bad page state in process kworker/u16:54  pfn:36e80
> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x36e80
> page dumped because: nonzero _refcount
> Call Trace:
>  bad_page
>  free_page_is_bad_report
>  __free_pages_ok
>  __free_pages
>  dma_direct_free
>  dma_free_attrs
>  ath12k_qmi_free_target_mem_chunk
>  ath12k_qmi_msg_mem_request_cb
> 
> The reason is:
> Once ath12k module is loaded, firmware sends memory request to host. In case
> DMA remap not supported, ath12k refuses the first request due to failure in
> allocating with large segment size:
> 
> ath12k_pci 0000:04:00.0: qmi firmware request memory request
> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 7077888
> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 8454144
> ath12k_pci 0000:04:00.0: qmi dma allocation failed (7077888 B type 1), will try later with small size
> ath12k_pci 0000:04:00.0: qmi delays mem_request 2
> ath12k_pci 0000:04:00.0: qmi firmware request memory request
> 
> Later firmware comes back with more but small segments and allocation
> succeeds:
> 
> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 262144
> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 65536
> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
> 
> Now ath12k is working. If suspend is triggered, firmware will be reloaded
> during resume. As same as before, firmware requests two large segments at
> first. In ath12k_qmi_msg_mem_request_cb() segment count and size are
> assigned:
> 
>         ab->qmi.mem_seg_count == 2
>         ab->qmi.target_mem[0].size == 7077888
>         ab->qmi.target_mem[1].size == 8454144
> 
> Then allocation failed like before and ath12k_qmi_free_target_mem_chunk()
> is called to free all allocated segments. Note the first segment is skipped
> because its v.addr is cleared due to allocation failure:
> 
>         chunk->v.addr = dma_alloc_coherent()
> 
> Also note that this leaks that segment because it has not been freed.
> 
> While freeing the second segment, a size of 8454144 is passed to
> dma_free_coherent(). However remember that this segment is allocated at
> the first time firmware is loaded, before suspend. So its real size is
> 524288, much smaller than 8454144. As a result kernel found we are freeing
> some memory which is in use and thus crashed.
> 
> So one possible fix would be to free those segments during suspend. This
> works because with them freed, ath12k_qmi_free_target_mem_chunk() does
> nothing: all segment addresses are NULL so dma_free_coherent() is not called.
> 
> But note that ath11k has similar logic but never hits this issue. Reviewing
> code there shows the luck comes from QMI memory reuse logic. So the decision
> is to port it to ath12k. Like in ath11k, the crash is avoided by adding
> prev_size to target_mem_chunk structure and caching real segment size in it,
> then prev_size instead of current size is passed to dma_free_coherent(),
> no unexpected memory is freed now.
> 
> Also reuse m3 buffer.
> 
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
> 
> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> Signed-off-by: Kalle Valo <quic_kvalo@quicinc.com>

Patch applied to ath-next branch of ath.git, thanks.

303c017821d8 wifi: ath12k: fix kernel crash during resume

-- 
https://patchwork.kernel.org/project/linux-wireless/patch/20240419034034.2842-1-quic_bqiang@quicinc.com/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches


