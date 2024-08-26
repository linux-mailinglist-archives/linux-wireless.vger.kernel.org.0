Return-Path: <linux-wireless+bounces-11929-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EEAD895E70B
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 04:50:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9AE80282B66
	for <lists+linux-wireless@lfdr.de>; Mon, 26 Aug 2024 02:50:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6D776C121;
	Mon, 26 Aug 2024 02:50:15 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 180BA10A0D;
	Mon, 26 Aug 2024 02:50:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724640615; cv=none; b=fwK0O6cEM6gOl1O4RFv4exVROoE/8CP1m3+RAHcyZjdZklLCm2Vf1jeFsCeRyQqQSngh/wJNPLWN71l+ahRovwaeNPeguxh1PnaezL5QCfVKP4zioVWZ7s/LNGo223lXwBmrElwB6XuC7rI9wPrOCoePDxX6Q57RnbNJ0laleOA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724640615; c=relaxed/simple;
	bh=GqGFZQDcvL+2MIMaoRg+JuCYCCKes0U3X6Wfu2zhcxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=lQw3+CBb8GdvgPbnPn2vJI/hyLvZyBmv0WLfzqWKR+8yCQjNjzO6aLtg3mLA1dWheR3YdvwaZEUcEddbIBEX+9uocIsHRiL4D6BE5vxw1T/O6Ayp6cP52J/U5bbWNLI7oz4UPGd+QmjIxg5G9KDvmGkrXEN5rk79xKlFfGMqVEU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WsZlx63blz20mfg;
	Mon, 26 Aug 2024 10:45:17 +0800 (CST)
Received: from dggpeml500022.china.huawei.com (unknown [7.185.36.66])
	by mail.maildlp.com (Postfix) with ESMTPS id 9FC2D14022F;
	Mon, 26 Aug 2024 10:50:04 +0800 (CST)
Received: from [10.67.111.104] (10.67.111.104) by
 dggpeml500022.china.huawei.com (7.185.36.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 Aug 2024 10:50:04 +0800
Message-ID: <1b1ee6e6-ff2e-45d6-bfe2-1f8efaba7b38@huawei.com>
Date: Mon, 26 Aug 2024 10:50:03 +0800
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
> 

I see reason is u8, so may I use min_t(u8, sp->ack.reason, 
RXRPC_ACK__INVALID)?

Thanks,
Hongbo


> Thanks,
> David
> 
> 

