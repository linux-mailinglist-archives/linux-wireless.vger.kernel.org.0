Return-Path: <linux-wireless+bounces-25186-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 24069B005F7
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 17:08:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 606E017D84A
	for <lists+linux-wireless@lfdr.de>; Thu, 10 Jul 2025 15:08:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04ABE2741D3;
	Thu, 10 Jul 2025 15:08:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b="bEdYrqdJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A02E154BF5;
	Thu, 10 Jul 2025 15:08:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752160129; cv=pass; b=s+eOmi1aEJgg840C6bLkLLnRHtOn3d8DvFVNtYiE3YK0CQ1fdIovf/hr4NkiS4tthc/J54Od0wGGyITZEyLy4DH1wDQtSdskX93b8B8E0uzwbd5pDld2rLaPdtmXS6cGDiC/qVU4SHQm6UH2+i9T6iaZkeS5CSbbVGwc23WGRtE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752160129; c=relaxed/simple;
	bh=0PpOzP35oubhU2Vis79WCDYNRmloUDZPCANXbEPXYAM=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=pRQJLfavKRZEyKeaC3hc4B4AKAixe0dEl4qKxpuj5QkDdqeof3lnwOfi9FD88+iJhHYU5CALqlJercMWIfJu+iwY9USeIBU7IP8U+SWllJOrvVHS1goWC2zBSOSmdF2ESka1lffaOsFL60u5EypD07TjYJ4HUWhRJH1WMbGcFvg=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=usama.anjum@collabora.com header.b=bEdYrqdJ; arc=pass smtp.client-ip=136.143.188.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
ARC-Seal: i=1; a=rsa-sha256; t=1752160063; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=Ey677D7vp5EHx9o22NhmGckpctpPOXMgkwrKyeE0GtEQnaMxWYzFFc4EmKX/B0i5bTYfNacI+XlqFl1CS9iAJu99gP7ycpTJ1MtaeVoRVgoA1FeimGjv1SO87DpcuVzyZQU8YuNuBTDDY8Azaj48abGEbWLt6sANpkVN5vRzSzw=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1752160063; h=Content-Type:Content-Transfer-Encoding:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=E3Zohc0nzj3FVWgHmXsuojr1RG8LeIWFa1m+NDG2dEk=; 
	b=IBv+vEKMEXET51NPwsWAZW0/tlx01+cFffz/UkspLw/IWquTYzKHnJddAszExQFr97VZ+HpU1WAbJlgXJ5YIJ08TYBANiYx2S+GwOaSaIISPJR1gwHbpXKi9wQNCFLp5YDCdyKkPBXBk2Dqugz5bFptPKLEgvE6tZj8NjaGK5Sw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=usama.anjum@collabora.com;
	dmarc=pass header.from=<usama.anjum@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1752160063;
	s=zohomail; d=collabora.com; i=usama.anjum@collabora.com;
	h=Message-ID:Date:Date:MIME-Version:Subject:Subject:To:To:Cc:Cc:References:From:From:In-Reply-To:Content-Type:Content-Transfer-Encoding:Message-Id:Reply-To;
	bh=E3Zohc0nzj3FVWgHmXsuojr1RG8LeIWFa1m+NDG2dEk=;
	b=bEdYrqdJwiD1Hvw4frXuTi3fB/DJJPLsmxLTjS1MxJLXWsTb1VJKICpjzCXZqiFl
	KKBWUX045NEgZPlAfUEReYADODGYuwyyFdfXL1vteRkFYr24orL9vciBHgPe87/sKf9
	zBi5hvJaMbf7rWSH8gQS3IZAN6hdXrFht43SDSQQ=
Received: by mx.zohomail.com with SMTPS id 1752160060955259.8992334590108;
	Thu, 10 Jul 2025 08:07:40 -0700 (PDT)
Message-ID: <c40f13e8-7420-4046-880d-7c72620fc021@collabora.com>
Date: Thu, 10 Jul 2025 20:07:25 +0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/3] bus: mhi: keep device context through suspend cycles
To: Krishna Chaitanya Chundru <krishna.chundru@oss.qualcomm.com>,
 Manivannan Sadhasivam <mani@kernel.org>, Jeff Johnson <jjohnson@kernel.org>,
 Jeff Hugo <jeff.hugo@oss.qualcomm.com>,
 Youssef Samir <quic_yabdulra@quicinc.com>,
 Matthew Leung <quic_mattleun@quicinc.com>, Yan Zhen <yanzhen@vivo.com>,
 Alexander Wilhelm <alexander.wilhelm@westermo.com>,
 Alex Elder <elder@kernel.org>, Kunwu Chan <chentao@kylinos.cn>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 Siddartha Mohanadoss <smohanad@codeaurora.org>,
 Sujeev Dias <sdias@codeaurora.org>, Julia Lawall <julia.lawall@lip6.fr>,
 John Crispin <john@phrozen.org>, Muna Sinada <quic_msinada@quicinc.com>,
 Venkateswara Naralasetty <quic_vnaralas@quicinc.com>,
 Maharaja Kennadyrajan <quic_mkenna@quicinc.com>, mhi@lists.linux.dev,
 linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Cc: kernel@collabora.com
References: <20250630074330.253867-1-usama.anjum@collabora.com>
 <20250630074330.253867-4-usama.anjum@collabora.com>
 <b72b3635-1c09-444f-98f5-30fcc219b297@oss.qualcomm.com>
Content-Language: en-US
From: Muhammad Usama Anjum <usama.anjum@collabora.com>
In-Reply-To: <b72b3635-1c09-444f-98f5-30fcc219b297@oss.qualcomm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External

On 7/8/25 3:15 PM, Krishna Chaitanya Chundru wrote:
> 
> 
> On 6/30/2025 1:13 PM, Muhammad Usama Anjum wrote:
>> Don't deinitialize the device context while going into suspend or
>> hibernation cycles. Otherwise the resume may fail if at resume time, the
>> memory pressure is high and no dma memory is available.
>>
>> Tested-on: WCN6855 WLAN.HSP.1.1-03926.13-QCAHSPSWPL_V2_SILICONZ_CE-2.52297.6
>>
>> Fixes: 3000f85b8f47 ("bus: mhi: core: Add support for basic PM operations")
>> Signed-off-by: Muhammad Usama Anjum <usama.anjum@collabora.com>
>> ---
>>   drivers/bus/mhi/host/init.c | 11 ++++++-----
>>   1 file changed, 6 insertions(+), 5 deletions(-)
>>
>> diff --git a/drivers/bus/mhi/host/init.c b/drivers/bus/mhi/host/init.c
>> index 2e0f18c939e68..8f56e73fdc42e 100644
>> --- a/drivers/bus/mhi/host/init.c
>> +++ b/drivers/bus/mhi/host/init.c
>> @@ -1133,9 +1133,11 @@ int mhi_prepare_for_power_up(struct mhi_controller *mhi_cntrl)
>>         mutex_lock(&mhi_cntrl->pm_mutex);
>>   -    ret = mhi_init_dev_ctxt(mhi_cntrl);
> mhi init dev ctxt also initializes the ring pointers to base value,
> I think we should take care of them also ?
Are you referring to mhi_rings? They are getting initialized inside
mhi_init_dev_ctxt() and de-initialized in __mhi_deinit_dev_ctxt(). That's
why I've not handled them separately.

> 
> - Krishna Chaitanya.
>> -    if (ret)
>> -        goto error_dev_ctxt;
>> +    if (!mhi_cntrl->mhi_ctxt) {
>> +        ret = mhi_init_dev_ctxt(mhi_cntrl);
>> +        if (ret)
>> +            goto error_dev_ctxt;
>> +    }
>>         ret = mhi_read_reg(mhi_cntrl, mhi_cntrl->regs, BHIOFF, &bhi_off);
>>       if (ret) {
>> @@ -1212,8 +1214,6 @@ void mhi_deinit_dev_ctxt(struct mhi_controller *mhi_cntrl)
>>   {
>>       mhi_cntrl->bhi = NULL;
>>       mhi_cntrl->bhie = NULL;
>> -
>> -    __mhi_deinit_dev_ctxt(mhi_cntrl);
>>   }
>>     void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
>> @@ -1234,6 +1234,7 @@ void mhi_unprepare_after_power_down(struct mhi_controller *mhi_cntrl)
>>       }
>>         mhi_deinit_dev_ctxt(mhi_cntrl);
>> +    __mhi_deinit_dev_ctxt(mhi_cntrl);
>>   }
>>   EXPORT_SYMBOL_GPL(mhi_unprepare_after_power_down);
>>   


