Return-Path: <linux-wireless+bounces-6557-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7B9298AA7AF
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 06:38:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 31019287362
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Apr 2024 04:38:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8FCF22F29;
	Fri, 19 Apr 2024 04:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="a69O2TQy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69B6464F
	for <linux-wireless@vger.kernel.org>; Fri, 19 Apr 2024 04:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713501496; cv=none; b=NMNDgnqEXoVXSHZaSEtPwZzz38QLaB5888R1bB7Rupz/0orhnQD3un2jM/ozWzg7afdEohqlV1rvJUHhsRqkQoQWpATCVDKJYVHKeuOycbCP3V9eUxsYWSSBxsCIYH72PhCBnWQpTbQchqe4KQ3cnWDkuFyaO1hoXabVvQteBgw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713501496; c=relaxed/simple;
	bh=oN18J2DU6Hqp6cJkmQ5aDnAYJ+tq1Th27S8Iarum1kA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:Message-ID:
	 MIME-Version:Content-Type; b=aCmqbPNKgJmd7S2CoqfTIcYqDloy5z0ENkn8gK+uN02sMciKUo/4YKyp+RAAhqA1PPayElmUqfSrogbXJEkrOjDCvtcyVONVpDHdB+scBFOTBgh3KRlRwuA00eAUu0+09rqHx9D11mR8xMEN74ftdIhiTyAG6XQa2RTbfRgQJ4A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=a69O2TQy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 08906C072AA;
	Fri, 19 Apr 2024 04:38:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713501495;
	bh=oN18J2DU6Hqp6cJkmQ5aDnAYJ+tq1Th27S8Iarum1kA=;
	h=From:To:Cc:Subject:References:Date:In-Reply-To:From;
	b=a69O2TQyXevQmUquepZSH/u/broFRWFUXWSPKGRYQIFAzI4bEAQtCuQUvJr58t/29
	 kZ8irE2R0HXXpgfnJ6fgZDj3cIwWv6mNWo4ldZ4cypLFNZzcwVsWumV7mFerNzmSld
	 LIyYujirby5TVs45dwiHe6A9zonWX5tFP21Ue08g32AleLYy6YkLSZ4TplCAk+4C8s
	 gIc3ty6dva4pjHh9naVG///Mrtcnsew/icNCeaFBjV96gpKt4x5+8HJHUra9iRmJOT
	 pB+tpWreY2ybhaz4zEwUEq5jUHaIXVKRXPLTTj6IC5Seh0w8mSgzFlXvxBrdGa0/mb
	 SnY3WT4PsWPLg==
From: Kalle Valo <kvalo@kernel.org>
To: Baochen Qiang <quic_bqiang@quicinc.com>
Cc: <ath12k@lists.infradead.org>,  <linux-wireless@vger.kernel.org>
Subject: Re: [PATCH] wifi: ath12k: fix kernel crash during resume
References: <20240419034034.2842-1-quic_bqiang@quicinc.com>
	<87cyqmhtoi.fsf@kernel.org>
Date: Fri, 19 Apr 2024 07:38:11 +0300
In-Reply-To: <87cyqmhtoi.fsf@kernel.org> (Kalle Valo's message of "Fri, 19 Apr
	2024 07:18:05 +0300")
Message-ID: <87frvivufg.fsf@kernel.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Kalle Valo <kvalo@kernel.org> writes:

> Baochen Qiang <quic_bqiang@quicinc.com> writes:
>
>> Currently during resume, QMI target memory is not properly handled, resulting
>> in kernel crash in case DMA remap is not supported:
>>
>> BUG: Bad page state in process kworker/u16:54  pfn:36e80
>> page: refcount:1 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0x36e80
>> page dumped because: nonzero _refcount
>> Call Trace:
>>  bad_page
>>  free_page_is_bad_report
>>  __free_pages_ok
>>  __free_pages
>>  dma_direct_free
>>  dma_free_attrs
>>  ath12k_qmi_free_target_mem_chunk
>>  ath12k_qmi_msg_mem_request_cb
>>
>> The reason is:
>> Once ath12k module is loaded, firmware sends memory request to host. In case
>> DMA remap not supported, ath12k refuses the first request due to failure in
>> allocating with large segment size:
>>
>> ath12k_pci 0000:04:00.0: qmi firmware request memory request
>> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 7077888
>> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 8454144
>> ath12k_pci 0000:04:00.0: qmi dma allocation failed (7077888 B type 1), will try later with small size
>> ath12k_pci 0000:04:00.0: qmi delays mem_request 2
>> ath12k_pci 0000:04:00.0: qmi firmware request memory request
>>
>> Later firmware comes back with more but small segments and allocation
>> succeeds:
>>
>> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 262144
>> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 524288
>> ath12k_pci 0000:04:00.0: qmi mem seg type 4 size 65536
>> ath12k_pci 0000:04:00.0: qmi mem seg type 1 size 524288
>>
>> Now ath12k is working. If suspend is triggered, firmware will be reloaded
>> during resume. As same as before, firmware requests two large segments at
>> first. In ath12k_qmi_msg_mem_request_cb() segment count and size are
>> assigned:
>>
>> 	ab->qmi.mem_seg_count == 2
>> 	ab->qmi.target_mem[0].size == 7077888
>> 	ab->qmi.target_mem[1].size == 8454144
>>
>> Then allocation failed like before and ath12k_qmi_free_target_mem_chunk()
>> is called to free all allocated segments. Note the first segment is skipped
>> because its v.addr is cleared due to allocation failure:
>>
>> 	chunk->v.addr = dma_alloc_coherent()
>>
>> Also note that this leaks that segment because it has not been freed.
>>
>> While freeing the second segment, a size of 8454144 is passed to
>> dma_free_coherent(). However remember that this segment is allocated at
>> the first time firmware is loaded, before suspend. So its real size is
>> 524288, much smaller than 8454144. As a result kernel found we are freeing
>> some memory which is in use and thus crashed.
>>
>> So one possible fix would be to free those segments during suspend. This
>> works because with them freed, ath12k_qmi_free_target_mem_chunk() does
>> nothing: all segment addresses are NULL so dma_free_coherent() is not called.
>>
>> But note that ath11k has similar logic but never hits this issue. Reviewing
>> code there shows the luck comes from QMI memory reuse logic. So the decision
>> is to port it to ath12k. Like in ath11k, the crash is avoided by adding
>> prev_size to target_mem_chunk structure and caching real segment size in it,
>> then prev_size instead of current size is passed to dma_free_coherent(),
>> no unexpected memory is freed now.
>>
>> Also reuse m3 buffer.
>>
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0-03427-QCAHMTSWPL_V1.0_V2.0_SILICONZ-1.15378.4
>> Tested-on: WCN7850 hw2.0 PCI WLAN.HMT.1.0.c5-00481-QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Fixes: 64430ddfb132 ("wifi: ath12k: support suspend/resume")

ERROR: Commit id not found from current branch: Fixes: 64430ddfb132 ("wifi: ath12k: support suspend/resume")

Do note that commit ids in the pending branch are not stable so fixes
tags cannot be used for those commits.

>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
>
> To keep git bisect clean should this patch be applied before applying
> the suspend patchset? No need resend or anything, just checking what
> should be the correct order.

Ah, I just checked and it looks like this patch depends on the suspend
patchset. I now applied this patch to pendign branch
(ath-pending-202404190433).

-- 
https://patchwork.kernel.org/project/linux-wireless/list/

https://wireless.wiki.kernel.org/en/developers/documentation/submittingpatches

