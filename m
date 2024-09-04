Return-Path: <linux-wireless+bounces-12444-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0681A96ADDA
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 03:27:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 382591C2438B
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 01:27:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5033945A;
	Wed,  4 Sep 2024 01:27:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C06281EBFF0;
	Wed,  4 Sep 2024 01:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725413233; cv=none; b=ak7FqrFOvsIEPeFJMlHBSCzjnvKB/s+zomc9u4MtqpA//L0nvF1AyEJLVK0sKWSvJeUdM1wk4NCvUZNAwqZpEWA36UmRZwp1DiAhUA7ycycRfMaiBZGJKo7p69DChEYHjA9qVk6G0/yy9PfAHaOEOhLAOeOqhMVzp//BWhlGQQM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725413233; c=relaxed/simple;
	bh=iTQTZmGNu7XqhC4rMffYfZH32Fiaq2tQgFElUVMGpTE=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=NmrtB1jBCpgpz9Jd0igmvPdBCpQZp4PmqVLjhhKPtgtgevaVat8x9M8kzwjElhWq6h06KZxUDQnyOTHdg589j89B8ud7XnjELYrH5PnweaKvm0/VxtuX7j8d11RZ7POy+03WX6U4eV9GoIUYNI+aaPO3TnmWSiFtvyJbAvxGLeE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.105])
	by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Wz4Tv11ddz69LX;
	Wed,  4 Sep 2024 09:22:11 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 35A5D140158;
	Wed,  4 Sep 2024 09:27:08 +0800 (CST)
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemd500012.china.huawei.com (7.221.188.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Wed, 4 Sep 2024 09:27:07 +0800
Message-ID: <b4f6e9ae-bda8-4496-82a7-de70004e2f29@huawei.com>
Date: Wed, 4 Sep 2024 09:27:06 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 09/12] net: ethernet: sunplus: Convert using
 devm_clk_get_enabled() in spl2sw_probe()
To: Jakub Kicinski <kuba@kernel.org>
CC: <florian.fainelli@broadcom.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <pabeni@redhat.com>,
	<wens@csie.org>, <jernej.skrabec@gmail.com>, <samuel@sholland.org>,
	<heiko@sntech.de>, <yisen.zhuang@huawei.com>, <salil.mehta@huawei.com>,
	<hauke@hauke-m.de>, <alexandre.torgue@foss.st.com>, <joabreu@synopsys.com>,
	<mcoquelin.stm32@gmail.com>, <wellslutw@gmail.com>,
	<radhey.shyam.pandey@amd.com>, <michal.simek@amd.com>,
	<ajay.kathat@microchip.com>, <claudiu.beznea@tuxon.dev>, <kvalo@kernel.org>,
	<u.kleine-koenig@pengutronix.de>, <jacky_chou@aspeedtech.com>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-rockchip@lists.infradead.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <linux-wireless@vger.kernel.org>
References: <20240831021334.1907921-1-lizetao1@huawei.com>
 <20240831021334.1907921-10-lizetao1@huawei.com>
 <20240903151649.1b466145@kernel.org>
From: Li Zetao <lizetao1@huawei.com>
In-Reply-To: <20240903151649.1b466145@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml100007.china.huawei.com (7.185.36.28) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Hi,

在 2024/9/4 6:16, Jakub Kicinski 写道:
> On Sat, 31 Aug 2024 10:13:31 +0800 Li Zetao wrote:
>> +	comm->clk = devm_clk_get_enabled(&pdev->dev, NULL);
> 
> You can remove clk from the driver struct now.
I don’t quite understand why clk can be removed from the driver struct, 
maybe I missed some important discussion information in the community, 
please let me know, thank you.
> Please check if the same applies to other patches.

Thanks,
Li Zetao.

