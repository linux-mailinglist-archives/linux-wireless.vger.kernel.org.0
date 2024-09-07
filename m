Return-Path: <linux-wireless+bounces-12619-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 5A6D996FF4A
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Sep 2024 04:55:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0A8861F2369E
	for <lists+linux-wireless@lfdr.de>; Sat,  7 Sep 2024 02:55:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 65A9A17BD3;
	Sat,  7 Sep 2024 02:55:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga05-in.huawei.com (szxga05-in.huawei.com [45.249.212.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1CA712B73;
	Sat,  7 Sep 2024 02:55:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725677744; cv=none; b=MrXGgDuncxP4Jwm9UqTtdEicQokdI4AJD65UFe/43d+F6CJZ+6jpoa6XGsIK+h55ij/u/9O1WwrhtNjretwcprNPD7OzghPkUJtEp+x/4bCLUS/XFJ3k2Lf9E1gjIK/OmAWgHjLTVm+2HjY1ELwRpUpCiFKwsUB1q1ibrUgC+Z4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725677744; c=relaxed/simple;
	bh=Mo7blfwgnaSNUonyuigBgsERMg7JbT1BgA+At6QtAq8=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=JmPvvpEkeNwZSetRRqa+bhK4LvzhEgsi3YvQvsIcknzwtIZByRfDUBdXFYxRJYJL66NtsvwrycrVNyFuQJH5egtcjUXJkBALAE0YpPw30Ja0wfWqY9uE4qZKREO1uGK/BszyYSUhc6jbl7DuvOkYMcg57hVVYKJyCmrW1yvU9mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.234])
	by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4X0yPv1pjQz1j80V;
	Sat,  7 Sep 2024 10:55:15 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id CDF491400CF;
	Sat,  7 Sep 2024 10:55:38 +0800 (CST)
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemd500012.china.huawei.com (7.221.188.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Sat, 7 Sep 2024 10:55:37 +0800
Message-ID: <852686ba-7578-4a1c-ae65-df7162e4e8bc@huawei.com>
Date: Sat, 7 Sep 2024 10:55:36 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 00/12] net: Convert using
 devm_clk_get_enabled()/devm_clk_get_optional_enabled()
To: Jeff Johnson <quic_jjohnson@quicinc.com>, <florian.fainelli@broadcom.com>,
	<andrew@lunn.ch>, <olteanv@gmail.com>, <davem@davemloft.net>,
	<edumazet@google.com>, <kuba@kernel.org>, <pabeni@redhat.com>,
	<wens@csie.org>, <jernej.skrabec@gmail.com>, <samuel@sholland.org>,
	<heiko@sntech.de>, <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<hauke@hauke-m.de>, <alexandre.torgue@foss.st.com>, <joabreu@synopsys.com>,
	<mcoquelin.stm32@gmail.com>, <wellslutw@gmail.com>,
	<radhey.shyam.pandey@amd.com>, <michal.simek@amd.com>,
	<ajay.kathat@microchip.com>, <claudiu.beznea@tuxon.dev>, <kvalo@kernel.org>,
	<u.kleine-koenig@pengutronix.de>, <jacky_chou@aspeedtech.com>
CC: <netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-rockchip@lists.infradead.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <linux-wireless@vger.kernel.org>
References: <20240831021334.1907921-1-lizetao1@huawei.com>
 <6f3f79f2-5755-4286-98f6-9950e7e994c8@quicinc.com>
From: Li Zetao <lizetao1@huawei.com>
In-Reply-To: <6f3f79f2-5755-4286-98f6-9950e7e994c8@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml500004.china.huawei.com (7.185.36.140) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Hi,

在 2024/9/7 7:17, Jeff Johnson 写道:
> On 8/30/2024 7:13 PM, Li Zetao wrote:
>> There are many examples[1][2] of clk resource leakage in LTS. The
>> reason is that developers need to maintain the allocation and release
>> of clk resources themselves, but this will increase the burden on
>> developers. Using the API related to devm_clk_get_*_enable ensures
>> that the life cycle of clk is consistent with that of the device,
>> reducing the risk of unreleased resources like clk.
>>
>> Several other developers are also working on converting to more
>> secure interfaces, and this patch set is in principle the same as
>> theirs.
> 
> ...
> 
>>   drivers/net/dsa/bcm_sf2.c                     | 28 ++----
>>   drivers/net/ethernet/allwinner/sun4i-emac.c   | 13 +--
>>   drivers/net/ethernet/arc/emac_rockchip.c      | 34 ++-----
>>   drivers/net/ethernet/ethoc.c                  | 18 ++--
>>   drivers/net/ethernet/faraday/ftgmac100.c      | 27 ++---
>>   drivers/net/ethernet/hisilicon/hisi_femac.c   | 17 +---
>>   drivers/net/ethernet/lantiq_xrx200.c          | 17 +---
>>   .../stmicro/stmmac/dwmac-dwc-qos-eth.c        | 98 ++++---------------
>>   drivers/net/ethernet/sunplus/spl2sw_driver.c  | 18 +---
>>   .../net/ethernet/xilinx/xilinx_axienet_main.c | 15 +--
>>   .../net/wireless/microchip/wilc1000/sdio.c    | 10 +-
>>   drivers/net/wireless/microchip/wilc1000/spi.c |  5 +-
> 
> note the wifi driver changes go through the wireless tree and not the net tree
> so those should be split out separately

I have separated the wifi related patches and sent them to the community:
https://lore.kernel.org/all/20240903110205.4127706-1-lizetao1@huawei.com/
> 
> 
Thanks,
Li Zetao.

