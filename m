Return-Path: <linux-wireless+bounces-23092-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4271CABA313
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 20:43:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 020791BC7887
	for <lists+linux-wireless@lfdr.de>; Fri, 16 May 2025 18:43:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B614E278766;
	Fri, 16 May 2025 18:43:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="DDyMzMFq"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC7131A0BF1;
	Fri, 16 May 2025 18:43:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747420993; cv=pass; b=jiqWumT/zXKp5614m+0dAAGoj2n/bnarKxJywKzZ/5BrRqE/huqeZ19atqJS9mxmfGSRexYmCLH6E7hNxNLH+aa4kiqWi/cDCz5sSRluMVYqVzQOlOifu+YC7eCwZ0SYvtYkA7fHJeP5Lpi/nKx6G1zNJt7tSKITxweyuPHNQb4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747420993; c=relaxed/simple;
	bh=zBZfFiPZUzPpPv3FClLAoIyveXSca1TLINgJk/0B2s0=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ATd+zC+w5lqLUmFSAFDR7RJdUbBJ4zJx1u1k8AByElzxDW2/kX7eRZHyCF98xu63jV+CedYCAr2vIooLhdk/GePwRGYornW0R6TVJiv9z6jLoEfpBItmEdWZ5BITliX5A/ItP3p6hsZ1T04xr7cgCEu7/aKo83kW4P6zDqd6CSo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=DDyMzMFq; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1747420952; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=UB58WcAzPfmeQxe/5HlsaQ5qwCCfD3VwmFuzrSEowItxfPOF5c3Q2xLQQNXim4CWyY/t2tGz7TA0digxQxndyRoFUiCbuvsz90gQJR2hBB6QetgDJdSO2yavqNdkbtvowdFwQzig8zgTOslXFazXQApQd9TdwdVuyYpsrVMjt/c=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1747420952; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=MzzkSiZrg4oJeY3DBEUNx4n2bS19YxHxGP5sLJRKfY8=; 
	b=MDf3bxyMFRUmfvwUSN8BfhmOcz5TC5subx1VSeD/d3+mEQR475vYKDlIiAbNMUlY9MVfp75dWp5TbwYtJ4lmhsPRjEKqIttwy/QpXSfUB+/ogf4uFsDc/5oZxjYllJsjzwrBZA4CsMdPv/quI4fKmHerHrGy3qjTevFWALK37So=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1747420952;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=MzzkSiZrg4oJeY3DBEUNx4n2bS19YxHxGP5sLJRKfY8=;
	b=DDyMzMFqhCtktAIbag3MZAEfhMX2KogDJacB8zTo/0Ctr7PTYEvaLiHmFt44rQtI
	x8jrfeV3A04XflvyyemEfVEa2J8laJZOKUJg/ojNjePSC9OWS6zcvHvkYK2dm+6z5mZ
	BcVokWCp3hz5UmDeuY+VDrMYm2egk1Y8T6MKMGfo=
Received: by mx.zohomail.com with SMTPS id 17474209503341.7831844100325043;
	Fri, 16 May 2025 11:42:30 -0700 (PDT)
Message-ID: <0e21b693-e03e-4a76-aada-0c48aeae6eec@collabora.com>
Date: Fri, 16 May 2025 23:42:21 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com, kernel@collabora.com,
 sebastian.reichel@collabora.com, Jeff Johnson
 <jeff.johnson@oss.qualcomm.com>, Baochen Qiang <quic_bqiang@quicinc.com>,
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org
Subject: Re: [PATCH v5] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
To: Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jeff Johnson <jjohnson@kernel.org>, Youssef Samir
 <quic_yabdulra@quicinc.com>, Matthew Leung <quic_mattleun@quicinc.com>,
 Yan Zhen <yanzhen@vivo.com>, Alex Elder <elder@kernel.org>,
 Kunwu Chan <chentao@kylinos.cn>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>
References: <20250514081447.279981-1-usama.anjum@collabora.com>
 <f6eac84d-3d67-4f99-a9c5-a9f03d748010@oss.qualcomm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <f6eac84d-3d67-4f99-a9c5-a9f03d748010@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 5/16/25 7:59 PM, Jeff Hugo wrote:
> On 5/14/2025 2:14 AM, Muhammad Usama Anjum wrote:
>> Fix dma_direct_alloc() failure at resume time during bhie_table
>> allocation because of memory pressure. There is a report where at
>> resume time, the memory from the dma doesn't get allocated and MHI
>> fails to re-initialize.
>>
>> To fix it, don't free the memory at power down during suspend /
>> hibernation. Instead, use the same allocated memory again after every
>> resume / hibernation. This patch has been tested with resume and
>> hibernation both.
>>
>> There are two allocations of bhie; rddm and fbc. Optimize both of those
> 
> There are 3, but you touch 2.  I just commented on this in v4.  Only
> touching two is fine (the device for the 3rd one doesn't need this), but
> the documentation must be accurate.
Yeah, for 3rd one in mhi_load_image_bhie(), this optimization isn't
needed. Let me rephrase and resent v6.

> 
>> allocations. The rddm is of constant size for a given hardware. While
>> the fbc_image size depends on the firmware. If the firmware changes,
>> we'll free and allocate new memory for it. This patch is moticated from
> 
> moticated?  Motivated maybe?
I'm using checkpatch --strict --codespell and hopping that it'll catch
typos. But it misses some of them. Do you use any such tool?

> 
>> the ath12k [1] and ath11k [2] patches. They don't free the memory and
>> reuse the same memory if new size is same. The firmware caching hasn't
>> been implemented for the drivers other than the nouveau. (The changing
>> of firmware isn't tested/supported for wireless drivers. But let's
>> follow the example patches here.)
>>
>> [1] https://lore.kernel.org/all/20240419034034.2842-1-
>> quic_bqiang@quicinc.com/
>> [2] https://lore.kernel.org/all/20220506141448.10340-1-
>> quic_akolli@quicinc.com/
>>
>> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-
>> QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
>> Tested-on: WCN7850 hw2.0 WLAN.HMT.1.1.c5-00284-
>> QCAHMTSWPL_V1.0_V2.0_SILICONZ-3
>>
>> Acked-by: Jeff Johnson <jeff.johnson@oss.qualcomm.com>
>> Tested-by: Baochen Qiang <quic_bqiang@quicinc.com>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>> Changes since v1:
>> - Don't free bhie tables during suspend/hibernation only
>> - Handle fbc_image changed size correctly
>> - Remove fbc_image getting set to NULL in *free_bhie_table()
>>
>> Changes since v2:
>> - Remove the new mhi_partial_unprepare_after_power_down() and instead
>>    update mhi_power_down_keep_dev() to use
>>    mhi_power_down_unprepare_keep_dev() as suggested by Mani
>> - Update all users of this API such as ath12k (previously only ath11k
>>    was updated)
>> - Define prev_fw_sz in docs
>> - Do better alignment of comments
>>
>> Changes since v3:
>> - Fix state machine of ath12k by setting ATH12K_MHI_DEINIT with
>>    ATH12K_MHI_POWER_OFF_KEEP_DEV state (Thanks Sebastian for testing and
>>    finding the problem)
>> - Use static with mhi_power_down_unprepare_keep_dev()
>> - Remove crash log as it was showing that kworker wasn't able to
>>    allocate memory.
>>
>> Changes since v4:
>> - Update desctiption
> 
> While I'm commenting on spelling, "description"
> 
> 
> Code looks ok to me. I think we just need to hash out some of the
> documentation and this will be good to go.
Thanks

> 


-- 
Regards,
Usama

