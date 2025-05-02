Return-Path: <linux-wireless+bounces-22317-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 87818AA69B7
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 06:16:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DCB3B4A31E0
	for <lists+linux-wireless@lfdr.de>; Fri,  2 May 2025 04:16:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 89E121922F6;
	Fri,  2 May 2025 04:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="XzYiNSWd"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9472A18CBFC;
	Fri,  2 May 2025 04:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746159372; cv=pass; b=dKQTZz5IvIcwSRgMIGGsZQo3ggAGwEdUgoch6AtVMfnFRrK8mwgRvddRkA7+Pp2grF4Tn9A/clEiStqvSWRNZnccuCsN6C/SEpaqGBOByafnIzKrcAkaNo/x+NUStEbnE4669HYDDGUx5pyhoTQW3xvOTKlD8y0ImeLBJqMeB6A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746159372; c=relaxed/simple;
	bh=zxU9482IXgMGBnaOsdctpat0CqazridftFpM0BE5b3k=;
	h=Message-ID:Date:MIME-Version:Cc:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=UmtXv3ml4wBAxbvs3fnher81myoRCr97Qp0EnUlkHD+78sCrwe5C3Mb7Am5vQnAWvtgPo7DHI9XxA64u0pF+gPV8BOuVUHsX21LzVGHS9ch5rgBIfWyQKCyLskP08x6xOslahK0MB06L47eOBzoKu2/ciFY6mPq98nFJOLaJpeA=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=XzYiNSWd; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1746159322; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=ER8AlXySUpnr6vDpzDd0slMHfE70fKr81s3q7pnsRWa0brvMAxQuaS9k+5BWNCcbMdAnQH5tAq2lkQ13KP1/qaml2Xv++uEi8ZS72ox2BTcPtnHfG2TVpweC8DFWF1RvK8UDkbBdZVQr7TRGhomgqlGHco9zXjnN0z5ktOfc0Ok=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1746159322; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=slniCBieFi8ALosAy7gsKHxe+RnIiRTt/8ka8YLXg+A=; 
	b=ljCD8+Wnk+dpM+d+npXOlXrlrMDobFO3t6g0D1kf/cXlt7ymu7/7yXn7UpQ/L6kqZuwV8E2fy9eUUsz2Y189q4NC0rCkDzvfqHPXQ0ZFeZwl7Iwrnz/xTG/c62hvlCdcctBGqNfD8tXK9G7q1dP2bJOPqILYwONOqT5aqRHJp30=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1746159322;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Cc:Cc:Subject:Subject:To:To:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=slniCBieFi8ALosAy7gsKHxe+RnIiRTt/8ka8YLXg+A=;
	b=XzYiNSWdT5bolXnmG2GHdgaUr4k8ZzrDE0DpyIxeBOWZt6At8w0q8Ji18NHbwE6s
	ehqOIryEakQ9dwxn8ciyZJnCu7BzoUebWnks1IUJviPdm0j37bta8O+UrqyCUIcozCa
	DKxFkvNQMkWXQMaCMukOPtuvJZN8j0q3nxcE0dZ0=
Received: by mx.zohomail.com with SMTPS id 1746159320663980.4307609300157;
	Thu, 1 May 2025 21:15:20 -0700 (PDT)
Message-ID: <bdc89d09-ce50-43a4-9043-3ca6a9245eb4@collabora.com>
Date: Fri, 2 May 2025 09:15:10 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Cc: usama.anjum@collabora.com,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Jeff Johnson <jjohnson@kernel.org>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Youssef Samir <quic_yabdulra@quicinc.com>,
 Matthew Leung <quic_mattleun@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
 Alex Elder <elder@kernel.org>,
 Jacek Lawrynowicz <jacek.lawrynowicz@linux.intel.com>,
 Kunwu Chan <chentao@kylinos.cn>, Troy Hanson <quic_thanson@quicinc.com>,
 "Dr. David Alan Gilbert" <linux@treblig.org>, kernel@collabora.com,
 mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org, ath12k@lists.infradead.org
Subject: Re: [PATCH v3] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20250429122112.104472-1-usama.anjum@collabora.com>
 <2025050110-unpeeled-spur-e4af@gregkh>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <2025050110-unpeeled-spur-e4af@gregkh>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

Hi Greg,

On 5/1/25 9:00 PM, Greg Kroah-Hartman wrote:
> On Tue, Apr 29, 2025 at 05:20:56PM +0500, Muhammad Usama Anjum wrote:
>> Fix dma_direct_alloc() failure at resume time during bhie_table
>> allocation. There is a crash report where at resume time, the memory
>> from the dma doesn't get allocated and MHI fails to re-initialize.
>> There is fragmentation/memory pressure.
>>
>> To fix it, don't free the memory at power down during suspend /
>> hibernation. Instead, use the same allocated memory again after every
>> resume / hibernation. This patch has been tested with resume and
>> hibernation both.
>>
>> The rddm is of constant size for a given hardware. While the fbc_image
>> size depends on the firmware. If the firmware changes, we'll free and
>> allocate new memory for it.
>>
>> Here are the crash logs:
>>
>> [ 3029.338587] mhi mhi0: Requested to power ON
>> [ 3029.338621] mhi mhi0: Power on setup success
>> [ 3029.668654] kworker/u33:8: page allocation failure: order:7, mode:0xc04(GFP_NOIO|GFP_DMA32), nodemask=(null),cpuset=/,mems_allowed=0
>> [ 3029.668682] CPU: 4 UID: 0 PID: 2744 Comm: kworker/u33:8 Not tainted 6.11.11-valve10-1-neptune-611-gb69e902b4338 #1ed779c892334112fb968aaa3facf9686b5ff0bd7
>> [ 3029.668690] Hardware name: Valve Galileo/Galileo, BIOS F7G0112 08/01/2024
>> [ 3029.668694] Workqueue: mhi_hiprio_wq mhi_pm_st_worker [mhi]
>> [ 3029.668717] Call Trace:
>> [ 3029.668722]  <TASK>
>> [ 3029.668728]  dump_stack_lvl+0x4e/0x70
>> [ 3029.668738]  warn_alloc+0x164/0x190
>> [ 3029.668747]  ? srso_return_thunk+0x5/0x5f
>> [ 3029.668754]  ? __alloc_pages_direct_compact+0xaf/0x360
>> [ 3029.668761]  __alloc_pages_slowpath.constprop.0+0xc75/0xd70
>> [ 3029.668774]  __alloc_pages_noprof+0x321/0x350
>> [ 3029.668782]  __dma_direct_alloc_pages.isra.0+0x14a/0x290
>> [ 3029.668790]  dma_direct_alloc+0x70/0x270
>> [ 3029.668796]  mhi_alloc_bhie_table+0xe8/0x190 [mhi faa917c5aa23a5f5b12d6a2c597067e16d2fedc0]
>> [ 3029.668814]  mhi_fw_load_handler+0x1bc/0x310 [mhi faa917c5aa23a5f5b12d6a2c597067e16d2fedc0]
>> [ 3029.668830]  mhi_pm_st_worker+0x5c8/0xaa0 [mhi faa917c5aa23a5f5b12d6a2c597067e16d2fedc0]
>> [ 3029.668844]  ? srso_return_thunk+0x5/0x5f
>> [ 3029.668853]  process_one_work+0x17e/0x330
>> [ 3029.668861]  worker_thread+0x2ce/0x3f0
>> [ 3029.668868]  ? __pfx_worker_thread+0x10/0x10
>> [ 3029.668873]  kthread+0xd2/0x100
>> [ 3029.668879]  ? __pfx_kthread+0x10/0x10
>> [ 3029.668885]  ret_from_fork+0x34/0x50
>> [ 3029.668892]  ? __pfx_kthread+0x10/0x10
>> [ 3029.668898]  ret_from_fork_asm+0x1a/0x30
>> [ 3029.668910]  </TASK>
>>
>> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
>>
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
> 
> What commit id does this fix?  Should it go to stable kernel(s)?  If so,
> how far back?
This patch is fixing the dma_coherent_alloc() failure when there is
memory pressure and its unable to allocate memory. Its not a bug in
allocation API or the driver. I think it should be considered an
improvement instead of the fix. Please correct me if I'm wrong.

-- 
Regards,
Usama

