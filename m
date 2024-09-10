Return-Path: <linux-wireless+bounces-12757-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 555EA973665
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 13:46:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E17221F25AD2
	for <lists+linux-wireless@lfdr.de>; Tue, 10 Sep 2024 11:46:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51522189BA4;
	Tue, 10 Sep 2024 11:46:26 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8821B17799F;
	Tue, 10 Sep 2024 11:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725968786; cv=none; b=TpKDmU4k1alZojan5SErDkX9P4ZdLXrGX/8FCoTEeY7qpLp4v41nBEKE523z0iRqdrYDGiNa99A6bShpyWeoCX6j8AZNJqzc+642+xA37yPOx1ZaZtGRtGcuunJghWOX92HQBwg06ZQuyYK3PYNMgmxmLKZ+olc0IaM31SZcl3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725968786; c=relaxed/simple;
	bh=O4bdGN4itFRdrEchX6jrIZMLRZVHhoa0rJ9xkGwid6U=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=cA7+OzN1WYOX2BmUBpQf6iAi0EflB72ohYJOf8vVUu79a4EkTY6oZPuwfh3xjzuH17kBQy4miScrqu+KPzC11mwBFSt0gaPKgS0RuUkJRHTzFBIvfdElXTXvZH9zhtkB3onLmriUF3KY8s5Q743JM+u0FE6PULsy2XWG0J6f7S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4X322m1WsRz2Dbyy;
	Tue, 10 Sep 2024 19:45:52 +0800 (CST)
Received: from kwepemh500013.china.huawei.com (unknown [7.202.181.146])
	by mail.maildlp.com (Postfix) with ESMTPS id 4D2A61A0188;
	Tue, 10 Sep 2024 19:46:20 +0800 (CST)
Received: from [10.67.109.254] (10.67.109.254) by
 kwepemh500013.china.huawei.com (7.202.181.146) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 10 Sep 2024 19:46:19 +0800
Message-ID: <22f16fbc-c370-9ca2-dc6c-5ed0ee4f3007@huawei.com>
Date: Tue, 10 Sep 2024 19:46:18 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 0/7] net: Use IRQF_NO_AUTOEN flag in request_irq()
Content-Language: en-US
To: Kalle Valo <kvalo@kernel.org>
CC: <davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <claudiu.manoil@nxp.com>, <vladimir.oltean@nxp.com>,
	<louis.peens@corigine.com>, <stefan@datenfreihafen.org>,
	<alex.aring@gmail.com>, <miquel.raynal@bootlin.com>,
	<chunkeey@googlemail.com>, <briannorris@chromium.org>,
	<francesco@dolcini.it>, <set_pte_at@outlook.com>,
	<damien.lemoal@opensource.wdc.com>, <mpe@ellerman.id.au>, <horms@kernel.org>,
	<yinjun.zhang@corigine.com>, <fei.qin@corigine.com>,
	<johannes.berg@intel.com>, <ryno.swart@corigine.com>,
	<krzysztof.kozlowski@linaro.org>, <leitao@debian.org>,
	<liuxuenetmail@gmail.com>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <oss-drivers@corigine.com>,
	<linux-wpan@vger.kernel.org>, <linux-wireless@vger.kernel.org>
References: <20240909133034.1296930-1-ruanjinjie@huawei.com>
 <87seu8c2n7.fsf@kernel.org>
From: Jinjie Ruan <ruanjinjie@huawei.com>
In-Reply-To: <87seu8c2n7.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 kwepemh500013.china.huawei.com (7.202.181.146)



On 2024/9/9 22:39, Kalle Valo wrote:
> Jinjie Ruan <ruanjinjie@huawei.com> writes:
> 
>> As commit cbe16f35bee6 ("genirq: Add IRQF_NO_AUTOEN for request_irq/nmi()")
>> said, reqeust_irq() and then disable_irq() is unsafe.
>>
>> And the code below is subobtimal:
>> 	 irq_set_status_flags(irq, IRQ_NOAUTOEN);
>> 	 request_irq(dev, irq...);
>>
>> IRQF_NO_AUTOEN flag can be used by drivers to request_irq(). It prevents
>> the automatic enabling of the requested interrupt in the same safe way.
>> With that the usage can be simplified and corrected.
>>
>> Only compile-tested.
>>
>> Jinjie Ruan (7):
>>   net: apple: bmac: Use IRQF_NO_AUTOEN flag in request_irq()
>>   net: enetc: Use IRQF_NO_AUTOEN flag in request_irq()
>>   nfp: Use IRQF_NO_AUTOEN flag in request_irq()
>>   net: ieee802154: mcr20a: Use IRQF_NO_AUTOEN flag in request_irq()
>>   wifi: p54: Use IRQF_NO_AUTOEN flag in request_irq()
>>   wifi: mwifiex: Use IRQF_NO_AUTOEN flag in request_irq()
>>   wifi: wl1251: Use IRQF_NO_AUTOEN flag in request_irq()
>>
>>  drivers/net/ethernet/apple/bmac.c                   | 3 +--
>>  drivers/net/ethernet/freescale/enetc/enetc.c        | 3 +--
>>  drivers/net/ethernet/netronome/nfp/nfp_net_common.c | 5 ++---
>>  drivers/net/ieee802154/mcr20a.c                     | 5 +----
>>  drivers/net/wireless/intersil/p54/p54spi.c          | 4 +---
>>  drivers/net/wireless/marvell/mwifiex/main.c         | 4 ++--
>>  drivers/net/wireless/ti/wl1251/sdio.c               | 4 ++--
>>  7 files changed, 10 insertions(+), 18 deletions(-)
> 
> Wireless patches go to wireless-next, please submit them in a separate
> patchset.

Thank you very much!

> 

