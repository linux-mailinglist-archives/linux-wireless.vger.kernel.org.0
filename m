Return-Path: <linux-wireless+bounces-21486-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CFF50A878CD
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 09:33:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AA943AE516
	for <lists+linux-wireless@lfdr.de>; Mon, 14 Apr 2025 07:33:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D51CE258CF2;
	Mon, 14 Apr 2025 07:33:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="dw158rFs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2A9F258CEE;
	Mon, 14 Apr 2025 07:33:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744616005; cv=pass; b=sIKzPKGLy1h+oBaI+xuYKjxifI1NXFJXv9OQwhYfm/VTvHxjIuumM+HECTF+ie1IuSNO+PlsffmCKYc0V9/+36OIUmDBXJgv7hw1FLLBAl6gCOshfJRi/oSByhITpDXP1JNVdiy7+9MFRCpjvPHNDLzZY5nqhTkyiaxmgeOC3SI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744616005; c=relaxed/simple;
	bh=0DM+yECyVKmMRm/otDrf4OIShCY4xBTSKZrpEXD0gBY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=p8K8rpyogwURuzCura6+3juKDZJzmE3Rm1bJp0YV8hClOKlC/k6vK3AAPi5rtd3wGYQeU3GzIFdVjGlt4e3DNeddcaw66DzpCPlQCUPxEM8xrBSJnS7w+fwdMzofESaL3MSPWFuJ8DS+TJdiPE5aY4UGAiAuAVuat25YUxKGtIw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=dw158rFs; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1744615967; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=S0354nrgj9hb6NeQadl1Jgb85f2XZ6MReFCZUBNsZDdDAzQrzRFwGnwr8EweP211SA50Xn4y+hioKW/Bz7wmSJyQzWGG86Adf+RIiSkVsJrAFwnk++2k92Nh+A0bocClaD6qEvMeHhwgCJW3OQZKy63j5AuNqVz9pD0HTHtwTRk=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1744615967; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=r6Hcb7CoSvel25wAUR0OKJ4456sj4HsUlowzVIyObhI=; 
	b=Qqza8kx+/OPX6Vbfz/xlS+1wWb4D/S0YtI/H9orFvcpgSpGFzTD7ZWXicQMorRRfkLY8zw0Zasu2X+LL5lPj0154UKv9ZEh+w1uw3aNmD0SyOa03w9DM4n1pwHykJNqkny8yw6F3vlYRtsis62vfJZSL6b8wVLirN7KXsEnTp8A=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1744615967;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=r6Hcb7CoSvel25wAUR0OKJ4456sj4HsUlowzVIyObhI=;
	b=dw158rFsigQq+3WvSfq3Kgi3Rvj53BgokKnVLW2u3VAHfgNngg/+0puXeBCjJE+y
	/UGjtVvi3ANtObQaDu9BNvu0glsKVKO/GPUw9KS+PaIttwYgkUOw3xT4m8cT96ClSuA
	71V/M5BsqaGYHQ1v/2k7u++MKga8gbd8jKW1CeHc=
Received: by mx.zohomail.com with SMTPS id 1744615966149258.692739802746;
	Mon, 14 Apr 2025 00:32:46 -0700 (PDT)
Message-ID: <7d6b074c-8499-4984-b235-d1285b006ab3@collabora.com>
Date: Mon, 14 Apr 2025 12:32:34 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] bus: mhi: host: don't free bhie tables during
 suspend/hibernation
To: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>,
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
 Johannes Berg <johannes@sipsolutions.net>, Jeff Johnson
 <jjohnson@kernel.org>, Jeffrey Hugo <quic_jhugo@quicinc.com>,
 Yan Zhen <yanzhen@vivo.com>, Youssef Samir <quic_yabdulra@quicinc.com>,
 Qiang Yu <quic_qianyu@quicinc.com>, Alex Elder <elder@kernel.org>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Kunwu Chan <chentao@kylinos.cn>, Jeff Hugo <jeff.hugo@oss.qualcomm.com>
Cc: kernel@collabora.com, mhi@lists.linux.dev, linux-arm-msm@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 ath11k@lists.infradead.org
References: <20250410145704.207969-1-usama.anjum@collabora.com>
 <ba09ae0c-fe8d-8f4e-a1b8-9c7e5913c84e@quicinc.com>
 <fc9ca0da-9f6a-42b5-aa79-abcd43c97043@collabora.com>
 <e0159cb8-fe21-7f71-1ebe-744ed26bd698@quicinc.com>
 <85580a01-289a-461b-b0f1-38fa1b96717c@collabora.com>
 <1c0b2217-49d9-360c-ed60-db517eaf2ccc@quicinc.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <1c0b2217-49d9-360c-ed60-db517eaf2ccc@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ZohoMailClient: External

On 4/12/25 6:22 AM, Krishna Chaitanya Chundru wrote:
> 
> On 4/12/2025 12:02 AM, Muhammad Usama Anjum wrote:
>> On 4/11/25 1:39 PM, Krishna Chaitanya Chundru wrote:
>>>
>>>
>>> On 4/11/2025 12:32 PM, Muhammad Usama Anjum wrote:
>>>> On 4/11/25 8:37 AM, Krishna Chaitanya Chundru wrote:
>>>>>
>>>>>
>>>>> On 4/10/2025 8:26 PM, Muhammad Usama Anjum wrote:
>>>>>> Fix dma_direct_alloc() failure at resume time during bhie_table
>>>>>> allocation. There is a crash report where at resume time, the memory
>>>>>> from the dma doesn't get allocated and MHI fails to re-initialize.
>>>>>> There may be fragmentation of some kind which fails the allocation
>>>>>> call.
>>>>>>
>>>>>> To fix it, don't free the memory at power down during suspend /
>>>>>> hibernation. Instead, use the same allocated memory again after every
>>>>>> resume / hibernation. This patch has been tested with resume and
>>>>>> hibernation both.
>>>>>>
>>>>>> The rddm is of constant size for a given hardware. While the
>>>>>> fbc_image
>>>>>> size depends on the firmware. If the firmware changes, we'll free and
>>>>> If firmware image will change between suspend and resume ?
>>>> Yes, correct.
>>>>
>>> why the firmware image size will change between suspend & resume?
>>> who will update the firmware image after bootup?
>>> It is not expected behaviour.
>> I was trying to research if the firmware can change or not. I've not
>> found any documentation on it.
>>
>> If the firmare is updated in filesystem before suspend/hibernate, would
>> the new firwmare be loaded the next time kernel resumes as the older
>> firmware is no where to be found?
>>
>> What do you think about this?
>>
> I don't think firmware can be updated before suspend/hibernate. I don't
> see any reason why it can be updated. If you think it can be updated
> please quote relevant doc.
I've not found any documentation on it. Let's wait for others to review
and it it cannot be updated, I'll remove this part.

-- 
Regards,
Usama

