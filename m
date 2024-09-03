Return-Path: <linux-wireless+bounces-12359-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C71F96916C
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 04:28:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 269C71F2236B
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 02:28:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 105A71CDA18;
	Tue,  3 Sep 2024 02:28:00 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 588501CDA00;
	Tue,  3 Sep 2024 02:27:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725330480; cv=none; b=mgwkeeUo2yZp5M/EuShxjiIpkcT1zMeiUbrQx41ILxcXuLXPUY4KOmMx6euUXuguxDrWf4ZjW06JqqX9XnMRiJGHvwYhayBbRnV29II5lYtlNoxYmx//pg2jJ6RYxFvhp9qRXVKl4/oMzSd+HefKwWLhSLhRLkftwANGGJ1tFco=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725330480; c=relaxed/simple;
	bh=d6CeH9FZXCDGHQBf1C3j1Iz7qG85kQbtB7iEZcAR2Ps=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=EkUWPTLDdWaHaMnHPMpTcVt/2M3yXUkX7734poiSLJ+yM4PbtGGSkgigOdSbTYIULXe5B2v+mrepuPtDjSvx1Yh96eZkvfpQWI7Ja0X62y7qBjtf9xEJgjmgQS8mui3NqFXPY3Ntrl+rwhZIBKSU1832V571HY9JgUjF3ayJUz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4WyTxl6gknzgYtl;
	Tue,  3 Sep 2024 10:25:47 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 7E3E21800FE;
	Tue,  3 Sep 2024 10:27:54 +0800 (CST)
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemd500012.china.huawei.com (7.221.188.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 3 Sep 2024 10:27:53 +0800
Message-ID: <73e02ee9-6631-4473-8219-d75253aaf0fc@huawei.com>
Date: Tue, 3 Sep 2024 10:27:52 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 10/12] net: xilinx: axienet: Convert using
 devm_clk_get_optional_enabled() in axienet_probe()
To: "Pandey, Radhey Shyam" <radhey.shyam.pandey@amd.com>,
	"florian.fainelli@broadcom.com" <florian.fainelli@broadcom.com>,
	"andrew@lunn.ch" <andrew@lunn.ch>, "olteanv@gmail.com" <olteanv@gmail.com>,
	"davem@davemloft.net" <davem@davemloft.net>, "edumazet@google.com"
	<edumazet@google.com>, "kuba@kernel.org" <kuba@kernel.org>,
	"pabeni@redhat.com" <pabeni@redhat.com>, "wens@csie.org" <wens@csie.org>,
	"jernej.skrabec@gmail.com" <jernej.skrabec@gmail.com>, "samuel@sholland.org"
	<samuel@sholland.org>, "heiko@sntech.de" <heiko@sntech.de>,
	"yisen.zhuang@huawei.com" <yisen.zhuang@huawei.com>, "salil.mehta@huawei.com"
	<salil.mehta@huawei.com>, "hauke@hauke-m.de" <hauke@hauke-m.de>,
	"alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
	"joabreu@synopsys.com" <joabreu@synopsys.com>, "mcoquelin.stm32@gmail.com"
	<mcoquelin.stm32@gmail.com>, "wellslutw@gmail.com" <wellslutw@gmail.com>,
	"Simek, Michal" <michal.simek@amd.com>, "ajay.kathat@microchip.com"
	<ajay.kathat@microchip.com>, "claudiu.beznea@tuxon.dev"
	<claudiu.beznea@tuxon.dev>, "kvalo@kernel.org" <kvalo@kernel.org>,
	"u.kleine-koenig@pengutronix.de" <u.kleine-koenig@pengutronix.de>,
	"jacky_chou@aspeedtech.com" <jacky_chou@aspeedtech.com>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
	"linux-arm-kernel@lists.infradead.org"
	<linux-arm-kernel@lists.infradead.org>, "linux-sunxi@lists.linux.dev"
	<linux-sunxi@lists.linux.dev>, "linux-rockchip@lists.infradead.org"
	<linux-rockchip@lists.infradead.org>,
	"linux-stm32@st-md-mailman.stormreply.com"
	<linux-stm32@st-md-mailman.stormreply.com>, "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
References: <20240831021334.1907921-1-lizetao1@huawei.com>
 <20240831021334.1907921-11-lizetao1@huawei.com>
 <MN0PR12MB595396074210F8390ACE409DB7912@MN0PR12MB5953.namprd12.prod.outlook.com>
From: Li Zetao <lizetao1@huawei.com>
In-Reply-To: <MN0PR12MB595396074210F8390ACE409DB7912@MN0PR12MB5953.namprd12.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml100004.china.huawei.com (7.185.36.247) To
 kwepemd500012.china.huawei.com (7.221.188.25)



在 2024/9/1 20:28, Pandey, Radhey Shyam 写道:
>> -----Original Message-----
>> From: Li Zetao <lizetao1@huawei.com>
>> Sent: Saturday, August 31, 2024 7:44 AM
>> To: florian.fainelli@broadcom.com; andrew@lunn.ch; olteanv@gmail.com;
>> davem@davemloft.net; edumazet@google.com; kuba@kernel.org;
>> pabeni@redhat.com; wens@csie.org; jernej.skrabec@gmail.com;
>> samuel@sholland.org; heiko@sntech.de; yisen.zhuang@huawei.com;
>> salil.mehta@huawei.com; hauke@hauke-m.de;
>> alexandre.torgue@foss.st.com; joabreu@synopsys.com;
>> mcoquelin.stm32@gmail.com; wellslutw@gmail.com; Pandey, Radhey
>> Shyam <radhey.shyam.pandey@amd.com>; Simek, Michal
>> <michal.simek@amd.com>; ajay.kathat@microchip.com;
>> claudiu.beznea@tuxon.dev; kvalo@kernel.org; lizetao1@huawei.com;
>> u.kleine-koenig@pengutronix.de; jacky_chou@aspeedtech.com
>> Cc: netdev@vger.kernel.org; linux-arm-kernel@lists.infradead.org; linux-
>> sunxi@lists.linux.dev; linux-rockchip@lists.infradead.org; linux-stm32@st-
>> md-mailman.stormreply.com; linux-wireless@vger.kernel.org
>> Subject: [PATCH net-next 10/12] net: xilinx: axienet: Convert using
>> devm_clk_get_optional_enabled() in axienet_probe()
>>
>> Use devm_clk_get_optional_enabled() instead of devm_clk_get_optional() +
>> clk_prepare_enable(), which can make the clk consistent with the device life
>> cycle and reduce the risk of unreleased clk resources. Since the device
>> framework has automatically released the clk resource, there is no need to
>> execute clk_disable_unprepare(clk) on the error path.
>>
>> Signed-off-by: Li Zetao <lizetao1@huawei.com>
> 
> Reviewed-by: Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>
> Thanks!
> 
>> ---
>>   drivers/net/ethernet/xilinx/xilinx_axienet_main.c | 15 ++++-----------
>>   1 file changed, 4 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> index fe6a0e2e463f..48b41e95aa74 100644
>> --- a/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> +++ b/drivers/net/ethernet/xilinx/xilinx_axienet_main.c
>> @@ -2584,22 +2584,17 @@ static int axienet_probe(struct platform_device
>> *pdev)
>>   	seqcount_mutex_init(&lp->hw_stats_seqcount, &lp->stats_lock);
>>   	INIT_DEFERRABLE_WORK(&lp->stats_work, axienet_refresh_stats);
>>
>> -	lp->axi_clk = devm_clk_get_optional(&pdev->dev, "s_axi_lite_clk");
>> -	if (!lp->axi_clk) {
>> +	lp->axi_clk = devm_clk_get_optional_enabled(&pdev->dev,
>> "s_axi_lite_clk");
>> +	if (!lp->axi_clk)
>>   		/* For backward compatibility, if named AXI clock is not
>> present,
>>   		 * treat the first clock specified as the AXI clock.
>>   		 */
>> -		lp->axi_clk = devm_clk_get_optional(&pdev->dev, NULL);
>> -	}
>> +		lp->axi_clk = devm_clk_get_optional_enabled(&pdev->dev,
>> NULL);
>> +
>>   	if (IS_ERR(lp->axi_clk)) {
>>   		ret = PTR_ERR(lp->axi_clk);
>>   		goto free_netdev;
>>   	}
>> -	ret = clk_prepare_enable(lp->axi_clk);
>> -	if (ret) {
>> -		dev_err(&pdev->dev, "Unable to enable AXI clock: %d\n",
>> ret);
>> -		goto free_netdev;
>> -	}
>>
>>   	lp->misc_clks[0].id = "axis_clk";
>>   	lp->misc_clks[1].id = "ref_clk";
>> @@ -2915,7 +2910,6 @@ static int axienet_probe(struct platform_device
>> *pdev)
>>   		axienet_mdio_teardown(lp);
>>   cleanup_clk:
> 
> I also find that there is goto to cleanup_clk when devm_clk_bulk_get_optional/
> clk_bulk_prepare_enable fails which is not correct but as it is existing bug it
> can go a separate patch.
Thanks for the reminder, I considered solving this problem by using 
devm_add_action_or_reset

Thanks,
Li Zetao.
> 
>>   	clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, lp-
>>> misc_clks);
>> -	clk_disable_unprepare(lp->axi_clk);
>>
>>   free_netdev:
>>   	free_netdev(ndev);
>> @@ -2939,7 +2933,6 @@ static void axienet_remove(struct platform_device
>> *pdev)
>>   	axienet_mdio_teardown(lp);
>>
>>   	clk_bulk_disable_unprepare(XAE_NUM_MISC_CLOCKS, lp-
>>> misc_clks);
>> -	clk_disable_unprepare(lp->axi_clk);
>>
>>   	free_netdev(ndev);
>>   }
>> --
>> 2.34.1
> 

