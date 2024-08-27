Return-Path: <linux-wireless+bounces-12012-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A21695FF70
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 04:57:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 487922835B1
	for <lists+linux-wireless@lfdr.de>; Tue, 27 Aug 2024 02:57:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1028617557;
	Tue, 27 Aug 2024 02:57:12 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A2031854;
	Tue, 27 Aug 2024 02:57:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724727432; cv=none; b=TRkmiThGlPBxCEEsteHft3Wq5iMax/mecUu0pg20YlZOZtc3zJ+7SFivgPY3kP+lsHqDxdYA9pWah6DIDPTMv3v/QGls1hnN67+jJjr8edQCIHyi7RMuDs/dTQk6UeyltA8KV8gZGbmyiLUE479Ymjj5ICnY18xTt9hgVjcSPt4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724727432; c=relaxed/simple;
	bh=VP5jQVZScWJwGt7yDpFbs3p1qV4NI6oB+QQ5/y+MDEQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=XpOr9ZE2IRHz9uYsJq6XL/reKB2iQAaVnQzHEKQE3tgJHd3NJxcRj5Q7H/r8JcdjUtKSfNA9+mRWX1ui8psjC9jMhvEIhUeIZJE1KvqzRt92MmFgWm1bzZrnSWgFWDUsDkDiWkCq16D4OCrhcwZoYUMzYWn3gpe9ZruaCgwyQt0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4WtByZ3wDtzyRD0;
	Tue, 27 Aug 2024 10:56:38 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 6889B18007C;
	Tue, 27 Aug 2024 10:57:07 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 27 Aug 2024 10:57:07 +0800
Message-ID: <4a92bb68-7fe7-4bf2-885f-e07b06ea82aa@huawei.com>
Date: Tue, 27 Aug 2024 10:57:06 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 0/8] Use max/min to simplify the code
Content-Language: en-US
To: Jakub Kicinski <kuba@kernel.org>
CC: <johannes@sipsolutions.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<pabeni@redhat.com>, <allison.henderson@oracle.com>, <dsahern@kernel.org>,
	<pshelar@ovn.org>, <linux-wireless@vger.kernel.org>,
	<netdev@vger.kernel.org>, <rds-devel@oss.oracle.com>, <dccp@vger.kernel.org>,
	<dev@openvswitch.org>, <linux-afs@lists.infradead.org>
References: <20240824074033.2134514-1-lihongbo22@huawei.com>
 <20240826144404.03fce39c@kernel.org>
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <20240826144404.03fce39c@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/8/27 5:44, Jakub Kicinski wrote:
> On Sat, 24 Aug 2024 15:40:25 +0800 Hongbo Li wrote:
>> Many Coccinelle/coccicheck warning reported by minmax.cocci
>> in net module, such as:
>>          WARNING opportunity for max()
>>          WARNING opportunity for min()
>>
>> Let's use max/min to simplify the code and fix these warnings.
>> These patch have passed compilation test.
> 
> This set does not build.
> 
Do you mean some patches will go to other branches (such as mac80211)?

Thanks,
Hongbo
> 

