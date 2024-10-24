Return-Path: <linux-wireless+bounces-14444-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD8D69AD994
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 04:12:58 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 78D001F21E28
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 02:12:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDA631B960;
	Thu, 24 Oct 2024 02:12:53 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EEC8EEA6
	for <linux-wireless@vger.kernel.org>; Thu, 24 Oct 2024 02:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729735973; cv=none; b=C4eFitzlrfpaOlDxLkzPB4U38Vue7yE1u4bT1hD6ieW/nyYUe4wNmP4rwTGjhujYwkvMm9GEcayjVUJv6Sk1po6QKPzo69tu6A0c3xJ0aFyVOpdvCZnhajrH/ECpU3K1Oe++/hfNoeGh2LOfMSixxupSaqH9TtK0+7TZcgSC908=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729735973; c=relaxed/simple;
	bh=jLN8bHn4EHP0WNya0IZuhk5hJ14qkYZuvS+AY4Xu+/w=;
	h=Subject:From:To:References:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=RWmZhyBwEE3wmPEFrtMQUiVXAk3DHP+om6NX5i7Xx1m+YtrVcMmlshOPCNuHLsHBmA3mCA2mgZYh3kbr+62EuVpyP8PnadG4jXSMjyTnRl3DJ4HLwj7IlZKn0kGvaSMacU0qsq/MB4Qr+XBoef0KUY3jD7yiviW9mJSFzgkGROs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4XYqDB4PjMzQs05;
	Thu, 24 Oct 2024 10:11:54 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 4B212180103;
	Thu, 24 Oct 2024 10:12:47 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Oct 2024 10:12:46 +0800
Subject: Re: [PATCH 1/1] ath11k: fix return value check in
 ath11k_spectral_debug_register()
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
	<ath11k@lists.infradead.org>
References: <20241023074051.309-1-thunder.leizhen@huawei.com>
 <f8e6901a-0f68-44e1-81e6-729539693fa4@quicinc.com>
 <f4d17e48-6a25-75c5-976a-4d0c14743276@huawei.com>
Message-ID: <f7a7ad6f-426c-535e-bde4-90f3b036ae2b@huawei.com>
Date: Thu, 24 Oct 2024 10:12:46 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f4d17e48-6a25-75c5-976a-4d0c14743276@huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/24 9:30, Leizhen (ThunderTown) wrote:
> 
> 
> On 2024/10/23 22:02, Jeff Johnson wrote:
>> On 10/23/2024 12:40 AM, Zhen Lei wrote:
>>> Fix the incorrect return value check for debugfs_create_file(), which
>>> returns ERR_PTR(-ERROR) instead of NULL when it fails.
>>
>> Based upon the commit text this change is incorrect.
>>
>>  * NOTE: it's expected that most callers should _ignore_ the errors returned
>>  * by this function. Other debugfs functions handle the fact that the "dentry"
>>  * passed to them could be an error and they don't crash in that case.
>>  * Drivers should generally work fine even if debugfs fails to init anyway.
>>
>> So ath11k should not be checking the return value at all, and definitely
>> should not be returning -EINVAL since the driver should still operate even if
>> creating a debugfs file fails.
> 
> OK, so that members such as scan_ctl in struct ath11k_spectral can be removed.

Sorry, the ath11k driver code is more complex than I think. I just went through
the code, and those members still need to be kept.

> I will update accordingly in v2.>
>>
>>>
>>> Fixes: 9d11b7bff950 ("ath11k: add support for spectral scan")
>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>> ---
>>>  drivers/net/wireless/ath/ath11k/spectral.c | 6 +++---
>>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
>>> index 79e091134515b43..4c545231292142a 100644
>>> --- a/drivers/net/wireless/ath/ath11k/spectral.c
>>> +++ b/drivers/net/wireless/ath/ath11k/spectral.c
>>> @@ -942,7 +942,7 @@ static inline int ath11k_spectral_debug_register(struct ath11k *ar)
>>>  						    0600,
>>>  						    ar->debug.debugfs_pdev, ar,
>>>  						    &fops_scan_ctl);
>>> -	if (!ar->spectral.scan_ctl) {
>>> +	if (IS_ERR(ar->spectral.scan_ctl)) {
>>>  		ath11k_warn(ar->ab, "failed to open debugfs in pdev %d\n",
>>>  			    ar->pdev_idx);
>>>  		ret = -EINVAL;
>>> @@ -953,7 +953,7 @@ static inline int ath11k_spectral_debug_register(struct ath11k *ar)
>>>  						      0600,
>>>  						      ar->debug.debugfs_pdev, ar,
>>>  						      &fops_scan_count);
>>> -	if (!ar->spectral.scan_count) {
>>> +	if (IS_ERR(ar->spectral.scan_count)) {
>>>  		ath11k_warn(ar->ab, "failed to open debugfs in pdev %d\n",
>>>  			    ar->pdev_idx);
>>>  		ret = -EINVAL;
>>> @@ -964,7 +964,7 @@ static inline int ath11k_spectral_debug_register(struct ath11k *ar)
>>>  						     0600,
>>>  						     ar->debug.debugfs_pdev, ar,
>>>  						     &fops_scan_bins);
>>> -	if (!ar->spectral.scan_bins) {
>>> +	if (IS_ERR(ar->spectral.scan_bins)) {
>>>  		ath11k_warn(ar->ab, "failed to open debugfs in pdev %d\n",
>>>  			    ar->pdev_idx);
>>>  		ret = -EINVAL;
>>
>>
>> .
>>
> 

-- 
Regards,
  Zhen Lei

