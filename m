Return-Path: <linux-wireless+bounces-11921-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 85EAA95E665
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 03:41:27 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2A4881F21246
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 01:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 809C84A33;
	Mon, 26 Aug 2024 01:41:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29256944E;
	Mon, 26 Aug 2024 01:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724636483; cv=none; b=RcBYvMETJH3FyFiX6DM3CaZ/w6HeZgcWlo4qdYXiyWJQJWoKX+Aec+BwXgVY5D/3J9S0dEwGK2Hm5D6gsBA5/H2ZZ6OnvbsSc9roIb2bv1m0pVchFruqlitm/sr5t9aZMjb40EO+Aszrz17oduUGUeLJWqTwuWD1F1aQiZgBOIg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724636483; c=relaxed/simple;
	bh=8zbjCEgdV6fhEoaaYvHPaRiZ+yjWio9aoO+Kg7FTDyU=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NmpFijVN8t4RVWccxkKErfd5lyiugBOcUglQqU6YrlrQZWujzPkHiXtmvJ4iMqfW3KMfauFoLDGGOZRtOSMcH7+FiJN2GUAZ0NN70xPByWk3HEmAPTQmjE7VDhnG8LWACsz1acenlQsLspXqJm3ZPAX1e7WEwqIzfckgQPPumps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.44])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4WsYGK1DcQz1HHJn;
	Mon, 26 Aug 2024 09:38:01 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 4FB1A140135;
	Mon, 26 Aug 2024 09:41:18 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 09:41:18 +0800
Message-ID: <e81473b2-174a-4ca1-ad66-2da98a513fcf@huawei.com>
Date: Mon, 26 Aug 2024 09:41:17 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 7/8] net/rxrpc: Use min() to simplify the code
To: David Howells <dhowells@redhat.com>
CC: <johannes@sipsolutions.net>, <davem@davemloft.net>, <edumazet@google.com>,
	<kuba@kernel.org>, <pabeni@redhat.com>, <allison.henderson@oracle.com>,
	<dsahern@kernel.org>, <pshelar@ovn.org>, <linux-wireless@vger.kernel.org>,
	<netdev@vger.kernel.org>, <rds-devel@oss.oracle.com>, <dccp@vger.kernel.org>,
	<dev@openvswitch.org>, <linux-afs@lists.infradead.org>
References: <20240824074033.2134514-8-lihongbo22@huawei.com>
 <20240824074033.2134514-1-lihongbo22@huawei.com>
 <563923.1724501215@warthog.procyon.org.uk>
Content-Language: en-US
From: Hongbo Li <lihongbo22@huawei.com>
In-Reply-To: <563923.1724501215@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpeml500022.china.huawei.com (7.185.36.66)



On 2024/8/24 20:06, David Howells wrote:
> Hongbo Li <lihongbo22@huawei.com> wrote:
> 
>> -	summary.ack_reason = (sp->ack.reason < RXRPC_ACK__INVALID ?
>> -			      sp->ack.reason : RXRPC_ACK__INVALID);
>> +	summary.ack_reason = min(sp->ack.reason, RXRPC_ACK__INVALID);
> 
> Can you use umin() rather than min(), please?
> I see reason is u8, may I use min_t(u8, sp->ack.reason, RXRPC_ACK__INVALID);

Thanks,
Hongbo

> Thanks,
> David
> 
> 

