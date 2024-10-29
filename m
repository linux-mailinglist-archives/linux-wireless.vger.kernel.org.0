Return-Path: <linux-wireless+bounces-14622-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DE189B401E
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 03:06:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 52BD7283540
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 02:06:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 537DE8172A;
	Tue, 29 Oct 2024 02:06:18 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga06-in.huawei.com (szxga06-in.huawei.com [45.249.212.32])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05481863F
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 02:06:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.32
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730167578; cv=none; b=pGkFJbkBXzSyDlnKW0ThvDIoKt5Io9yw7UI0RJb7eIE4vPIene+4nZmhCBD1/yKC8h/WrWKBZNfCW2ku2zSVOGPT1g9T7AtuBFLiwz/t/YxdXsRK1YkGFWZ6Hf3gTB5ueoeYqpCQxEFSzfPGYX3kOeNRvmuYjBqMWWsHqbyopZw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730167578; c=relaxed/simple;
	bh=yMUSHQwUHHdwnTDnpqN3Q1M1JGcSWeuCWn2ogsWAjHA=;
	h=Subject:To:CC:References:From:Message-ID:Date:MIME-Version:
	 In-Reply-To:Content-Type; b=hlhHiKpcYPid68/KSpahh38PSKapiVF5uzsstdss2Mj4QNgYVXiyh0qdUVNH6uoUSavipjLccWzSC6uYexH72usowpIY7jTcNeK2ZtSkAjrurBHnM4/DesseDv9DDy6GmQvl3qGXKjlnw+9yubxC4HaWgv9wx/ouV7Lhzvnbj30=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.32
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4Xctrx1hTNz1ynqm;
	Tue, 29 Oct 2024 10:05:53 +0800 (CST)
Received: from dggpemf100006.china.huawei.com (unknown [7.185.36.228])
	by mail.maildlp.com (Postfix) with ESMTPS id CE5FA1A0188;
	Tue, 29 Oct 2024 10:05:44 +0800 (CST)
Received: from [10.174.178.55] (10.174.178.55) by
 dggpemf100006.china.huawei.com (7.185.36.228) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 29 Oct 2024 10:05:44 +0800
Subject: Re: [PATCH v2] ath11k: remove error checking for
 debugfs_create_file()
To: Jeff Johnson <quic_jjohnson@quicinc.com>, Kalle Valo <kvalo@kernel.org>
CC: Jeff Johnson <jjohnson@kernel.org>, <linux-wireless@vger.kernel.org>,
	<ath11k@lists.infradead.org>
References: <20241025064235.382-1-thunder.leizhen@huawei.com>
 <87v7xcgwb0.fsf@kernel.org>
 <ff8c3443-3651-480e-956e-81c7d592099d@quicinc.com>
From: "Leizhen (ThunderTown)" <thunder.leizhen@huawei.com>
Message-ID: <2baeba2a-9a77-2bde-1dee-b520069df635@huawei.com>
Date: Tue, 29 Oct 2024 10:05:43 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.7.0
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <ff8c3443-3651-480e-956e-81c7d592099d@quicinc.com>
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemf100006.china.huawei.com (7.185.36.228)



On 2024/10/28 22:30, Jeff Johnson wrote:
> On 10/28/2024 7:02 AM, Kalle Valo wrote:
>> Zhen Lei <thunder.leizhen@huawei.com> writes:
>>
>>> Driver ath11k can work fine even if the debugfs files fail to be created.
>>> Therefore, the return value check of debugfs_create_file() should be
>>> ignored, as it says.
>>>
>>> Suggested-by: Jeff Johnson <quic_jjohnson@quicinc.com>
>>> Signed-off-by: Zhen Lei <thunder.leizhen@huawei.com>
>>
>> Are you just guessing or did you confirm on a real device that ath11k
>> spectral really works without debugfs?

Let's be honest, the only thing I know for sure is that debugfs_create_file()
returns an error code when it fails, not NULL. When I was locating a problem,
I found that a call to debugfs_create_file() did not process the return value
correctly. So I searched for other drivers, including ath11k. I'm not familiar
with ath11k. How to modify requires your help and decision.

> 
> The debugfs_create_file() documentation tells us:
>  * NOTE: it's expected that most callers should _ignore_ the errors returned
>  * by this function. Other debugfs functions handle the fact that the "dentry"
>  * passed to them could be an error and they don't crash in that case.
>  * Drivers should generally work fine even if debugfs fails to init anyway.
> 
> The caveat is that any driver functionality that relies upon debugfs obviously
> won't work if the underlying file isn't created. Hence the language that the
> driver "should generally work fine" since all functionality that isn't tied to
> debugfs will still be available.
> 
> Since the relayfs functionality that spectral scan uses is dependent upon
> debugfs, this functionality won't work if the debugfs operation fails. So the
> question is, if that fails, do you continue running the driver that generally
> works fine supporting all other wifi operations, or do you return an error,
> and as part of the error handling, not init the driver and hence have no wifi
> operation?

Maybe Kalle just pointed out that my description was incorrect.

Hi Kalle:
  Can you give me a clear instruction?
  1) Rollback to v1
     https://www.spinics.net/lists/linux-wireless/msg257219.html
  2) Update commit message, I think I can borrow the description above.

> 
> The one thing I didn't check is that although the documentation tells us that
> debugfs functions handle an "error" dentry, I didn't check if relayfs handles it.
> 
> /jeff
> 
> .
> 

-- 
Regards,
  Zhen Lei

