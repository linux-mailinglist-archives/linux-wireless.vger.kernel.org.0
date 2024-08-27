Return-Path: <linux-wireless+bounces-12022-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2271996030E
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 09:29:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53D621C21335
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 07:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2F72515359A;
	Tue, 27 Aug 2024 07:29:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 563691386C6;
	Tue, 27 Aug 2024 07:29:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724743792; cv=none; b=EmdpggUSGf3hmDOdZlFfB3VMVRAemESsvqL9Gji0oC0OrQXlywluHDz/ctCVol3lpVswOvPJMCtLwdzpu0qxNdu1VyYDH0zB8ibcdfCatok5DT0uiR5ZExNA9a8YPEipAYvrZk8Dh937V+t8o+7AtXixuOGyCatV0+KuDZoUQoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724743792; c=relaxed/simple;
	bh=z4Cgu75ZnfXDsF48FF7zsHAZLhDoBnZPHR2EgFqKzi8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Z6a1ztKm6JeOgGWunE2DbHC11Kphrq1yealLjaIpXA0jhe99pzTQRZmp41QfFB0/BCgMqkTE89K2nyiFg+KncTD+VsOqS1HP7waVAVAtjxogiEuswVb/uMfFuIy7Xp1RBFFYXdU0jwLkEDtTaIgItg9WnJ9SaNDxwobuwc9mvNA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4WtK0s132Jz16PW1;
	Tue, 27 Aug 2024 15:29:01 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id CC1C4180064;
	Tue, 27 Aug 2024 15:29:47 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 15:29:47 +0800
Message-ID: <82523993-61c8-4c03-8826-61da9081d3ba@huawei.com>
Date: Tue, 27 Aug 2024 15:29:47 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH -next v2] wifi: mac80211: use max to simplify the code
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<kvalo@kernel.org>
CC: <linux-wireless@vger.kernel.org>, <netdev@vger.kernel.org>
References: <20240827030302.1006179-1-lihongbo22@huawei.com>
 <d5f495b67fe6bf128e7a51b9fcfe11f70c9b66ae.camel@sipsolutions.net>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <d5f495b67fe6bf128e7a51b9fcfe11f70c9b66ae.camel@sipsolutions.net>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/8/27 15:25, Johannes Berg wrote:
> On Tue, 2024-08-27 at 11:03 +0800, Hongbo Li wrote:
>> The following Coccinelle/coccicheck warning reported by
>> minmax.cocci:
>>      WARNING opportunity for max()
> 
> Yeah well, maybe sometimes we shouldn't blindly follow tools ...
> 
>> Let's use max() to simplify the code and fix the warning.
> 
> You should explain why.
> 
> I think only one out of four changes in this patch is correct,
> semantically.
> 
You mean sometimes we should keep the variable type in comparison?

Thanks,
Hongbo

> johannes
> 

