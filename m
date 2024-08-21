Return-Path: <linux-wireless+bounces-11721-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CDE9C9594EC
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 08:43:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8B12928909C
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 06:43:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42C831C8FC9;
	Wed, 21 Aug 2024 06:43:47 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBBF41C8FC6;
	Wed, 21 Aug 2024 06:43:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724222627; cv=none; b=EAzBAR/Nr9sPqq4aulK513llPphTwRAi7h9FeFAYn1IKD0L8+NiqXp4nGq5151k1GH2Knx2AUZvR0Kz5YjqI1QbGY+g340AD0bV2S2OitkNevSEUE0mRZv28dJcfWyzrhE0iYL6Dpkc33U4Snsu9YPFUmZVQF5wT49tggl/jZ6Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724222627; c=relaxed/simple;
	bh=blDMBT/ZDzXhVOBCRW9BnF9p6bNMznlQt4wycFrEMR8=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=RO4IDwUxA6m+uI3Kla1CNLmDmm6Utw8ncldp84GmaiyId7+uDiHZ6zXr9dIfn/AeAxeaJU7e1DjpvUlE8zFe+G515VSgijm5YpV2i1G2+kzTgrt+DafXiryzhv3FzmA7axcL0t9fupmMsFuw6Ys7/vy/0+OClQVQzAIGHuaa2ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4Wpc9x0Hj3z20mCX;
	Wed, 21 Aug 2024 14:39:01 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 7EDDD1401E9;
	Wed, 21 Aug 2024 14:43:42 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 21 Aug 2024 14:43:41 +0800
Message-ID: <232f5fe4-661a-501c-4a54-d3d45822b5fc@huawei.com>
Date: Wed, 21 Aug 2024 14:43:40 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH -next] wifi: mac80211: Use kvmemdup to simplify the code
Content-Language: en-US
To: Arend Van Spriel <arend.vanspriel@broadcom.com>, <kvalo@kernel.org>,
	<johannes.berg@intel.com>, <emmanuel.grumbach@intel.com>,
	<erick.archer@outlook.com>, <linux-wireless@vger.kernel.org>,
	<brcm80211@lists.linux.dev>, <brcm80211-dev-list.pdl@broadcom.com>,
	<linux-kernel@vger.kernel.org>
References: <20240821023325.2077399-1-ruanjinjie@huawei.com>
 <191737a8900.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <191737a8900.279b.9b12b7fc0a3841636cfb5e919b41b954@broadcom.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/8/21 13:48, Arend Van Spriel wrote:
> On August 21, 2024 4:26:17 AM Jinjie Ruan <ruanjinjie@huawei.com> wrote:
> 
>> Use kvmemdup instead of kvmalloc() + memcpy() to simplify the code.
>>
>> No functional change.
> 
> Comment below...
> 
>> Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
>> ---
>> drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c | 3 +--
>> 1 file changed, 1 insertion(+), 2 deletions(-)
>>
>> diff --git
>> a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
>> b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
>> index d86f28b8bc60..7717d7764d2d 100644
>> --- a/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
>> +++ b/drivers/net/wireless/broadcom/brcm80211/brcmsmac/mac80211_if.c
>> @@ -1611,10 +1611,9 @@ int brcms_ucode_init_buf(struct brcms_info *wl,
>> void **pbuf, u32 idx)
>>  if (le32_to_cpu(hdr->idx) == idx) {
>>  pdata = wl->fw.fw_bin[i]->data +
>>  le32_to_cpu(hdr->offset);
>> - *pbuf = kvmalloc(len, GFP_KERNEL);
>> + *pbuf = kvmemdup(pdata, len, GFP_KERNEL);
>>  if (*pbuf == NULL)
>>  goto fail;
> 
> This is the only jump to fail: so instead simply return here with
> -ENOMEM and remove the fail: label.

Right. Thank you!

> 
> Regards,
> Arend
> 
>> - memcpy(*pbuf, pdata, len);
>>  return 0;
>>  }
>>  }
>> -- 
>> 2.34.1
> 
> 
> 

