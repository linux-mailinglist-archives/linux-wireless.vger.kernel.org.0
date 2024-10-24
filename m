Return-Path: <linux-wireless+bounces-14443-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 688799AD94A
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 03:30:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9871E1C211D3
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Oct 2024 01:30:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7E2136A;
	Thu, 24 Oct 2024 01:30:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F3484690
	for <linux-wireless@vger.kernel.org>; Thu, 24 Oct 2024 01:30:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729733422; cv=none; b=BlnqtI6E4qmZBHSHgh5jqIfw5+8LKclTi6vWFkhlozUYSIDqwDFaNNY+IPYsrOsbCWI6RHpq12zrfKcDZcK+/hDaFupI5HtJCeIKbC01/EpB4g91qqOkyWmj+4NcohVmpPWDiY6cCJG+pXE054WMsoTsTuEyi/m0wvJ2bW2KnRk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729733422; c=relaxed/simple;
	bh=0nuTdFN0DKoDGcIE3naZfK7hUOKE0Tcp/xRoAN0gdhc=;
	h=Subject:To:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=YODxH+9ufAO46j//lIo91Bv84BP+t1RWX5Db9QiQFeOKOuHKxKdBygKFHa0bCeNFMHoW8BZKUZ9YffAIK+7/n2FmIBjFaqRrAyEv276vK0z8E9iKCitMaj5/1TyPg0I48UbFGS5FRRtUqElYFMQ2T5SJHFmp3a1FRJcqFeeAHYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.163])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4XYpJG6F8wz1yndS;
	Thu, 24 Oct 2024 09:30:22 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id 7A6BC180019;
	Thu, 24 Oct 2024 09:30:15 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Oct 2024 09:30:15 +0800
Subject: Re: [PATCH 1/1] ath11k: fix return value check in
 ath11k_spectral_debug_register()
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>,
	Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
	<ath11k@lists.infradead.org>
References: <20241023074051.309-1-thunder.leizhen@huawei.com>
 <f8e6901a-0f68-44e1-81e6-729539693fa4@quicinc.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <f4d17e48-6a25-75c5-976a-4d0c14743276@huawei.com>
Date: Thu, 24 Oct 2024 09:30:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <f8e6901a-0f68-44e1-81e6-729539693fa4@quicinc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/23 22:02, Jeff Johnson wrote:
> On 10/23/2024 12:40 AM, Zhen Lei wrote:
>> Fix the incorrect return value check for debugfs_create_file(), which
>> returns ERR_PTR(-ERROR) instead of NULL when it fails.
> 
> Based upon the commit text this change is incorrect.
> 
>  * NOTE: it's expected that most callers should _ignore_ the errors returned
>  * by this function. Other debugfs functions handle the fact that the "dentry"
>  * passed to them could be an error and they don't crash in that case.
>  * Drivers should generally work fine even if debugfs fails to init anyway.
> 
> So ath11k should not be checking the return value at all, and definitely
> should not be returning -EINVAL since the driver should still operate even if
> creating a debugfs file fails.

OK, so that members such as scan_ctl in struct ath11k_spectral can be removed.
I will update accordingly in v2.

> 
>>
>> Fixes: 9d11b7bff950 ("ath11k: add support for spectral scan")
>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>> ---
>>  drivers/net/wireless/ath/ath11k/spectral.c | 6 +++---
>>  1 file changed, 3 insertions(+), 3 deletions(-)
>>
>> diff --git a/drivers/net/wireless/ath/ath11k/spectral.c b/drivers/net/wireless/ath/ath11k/spectral.c
>> index 79e091134515b43..4c545231292142a 100644
>> --- a/drivers/net/wireless/ath/ath11k/spectral.c
>> +++ b/drivers/net/wireless/ath/ath11k/spectral.c
>> @@ -942,7 +942,7 @@ static inline int ath11k_spectral_debug_register(struct ath11k *ar)
>>  						    0600,
>>  						    ar->debug.debugfs_pdev, ar,
>>  						    &fops_scan_ctl);
>> -	if (!ar->spectral.scan_ctl) {
>> +	if (IS_ERR(ar->spectral.scan_ctl)) {
>>  		ath11k_warn(ar->ab, "failed to open debugfs in pdev %d\n",
>>  			    ar->pdev_idx);
>>  		ret = -EINVAL;
>> @@ -953,7 +953,7 @@ static inline int ath11k_spectral_debug_register(struct ath11k *ar)
>>  						      0600,
>>  						      ar->debug.debugfs_pdev, ar,
>>  						      &fops_scan_count);
>> -	if (!ar->spectral.scan_count) {
>> +	if (IS_ERR(ar->spectral.scan_count)) {
>>  		ath11k_warn(ar->ab, "failed to open debugfs in pdev %d\n",
>>  			    ar->pdev_idx);
>>  		ret = -EINVAL;
>> @@ -964,7 +964,7 @@ static inline int ath11k_spectral_debug_register(struct ath11k *ar)
>>  						     0600,
>>  						     ar->debug.debugfs_pdev, ar,
>>  						     &fops_scan_bins);
>> -	if (!ar->spectral.scan_bins) {
>> +	if (IS_ERR(ar->spectral.scan_bins)) {
>>  		ath11k_warn(ar->ab, "failed to open debugfs in pdev %d\n",
>>  			    ar->pdev_idx);
>>  		ret = -EINVAL;
> 
> 
> .
> 

-- 
Regards,
  Zhen Lei

