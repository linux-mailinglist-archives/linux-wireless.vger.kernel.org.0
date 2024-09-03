Return-Path: <linux-wireless+bounces-12382-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6208D969A86
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 12:47:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1FE96285586
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 10:47:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF85D1AD24D;
	Tue,  3 Sep 2024 10:46:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga04-in.huawei.com (szxga04-in.huawei.com [45.249.212.190])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B7B1B9829;
	Tue,  3 Sep 2024 10:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.190
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360416; cv=none; b=clwYEHmncS2fAr8JhZ16m6UEbBU4lTE0uJhXApibDx0ST4B/F8xNyNfelY1Uv4YdCImIvsbzrtJYHADpSk8LqhRdauu3UIzTtK8NU3V+pq1EQYU8dW86HUsoe8cY0YvhPamTo7CTFwvxo5W6Ct/MLblGBvvYF9RcmCogNUPZhs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360416; c=relaxed/simple;
	bh=NdRXoTy+cvSsqe8qf2Zk+1dLnubKdBEvzMSoRUu2M/w=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=tOC5jL08dE2q1v7Yp3p5QYNfnT6IhQPoBukNZ84inb/SNdE2uFV3G4UZUUILuYm4l38WggklQ86DB9c1wUghPYGKcw0RLht/JVpsr0LnDCDPMUFZON/l8uONUCBpNnFbrY6wtFxCGpo31XzmFpH1kgYGio1u1pl/7wJwCW9lbA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.190
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.17])
	by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4WyhyB0mDhz20nQp;
	Tue,  3 Sep 2024 18:41:54 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 131561A0188;
	Tue,  3 Sep 2024 18:46:50 +0800 (CST)
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemd500012.china.huawei.com (7.221.188.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 3 Sep 2024 18:46:48 +0800
Message-ID: <0becf4e0-2f66-4c26-b0b3-59ee232eaaef@huawei.com>
Date: Tue, 3 Sep 2024 18:46:48 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 05/12] net: ftgmac100: Convert using
 devm_clk_get_enabled() in ftgmac100_setup_clk()
To: =?UTF-8?Q?Uwe_Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
CC: <florian.fainelli@broadcom.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <wens@csie.org>, <jernej.skrabec@gmail.com>,
	<samuel@sholland.org>, <heiko@sntech.de>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <hauke@hauke-m.de>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <wellslutw@gmail.com>,
	<radhey.shyam.pandey@amd.com>, <michal.simek@amd.com>,
	<ajay.kathat@microchip.com>, <claudiu.beznea@tuxon.dev>, <kvalo@kernel.org>,
	<jacky_chou@aspeedtech.com>, <netdev@vger.kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-sunxi@lists.linux.dev>,
	<linux-rockchip@lists.infradead.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <linux-wireless@vger.kernel.org>
References: <20240831021334.1907921-1-lizetao1@huawei.com>
 <20240831021334.1907921-6-lizetao1@huawei.com>
 <nyfm5mxrrvfeu7s25qzjxbatvgnppq7exmca3sccmm6lz7nxan@xxsdgcrueoen>
From: Li Zetao <lizetao1@huawei.com>
In-Reply-To: <nyfm5mxrrvfeu7s25qzjxbatvgnppq7exmca3sccmm6lz7nxan@xxsdgcrueoen>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml500005.china.huawei.com (7.185.36.59) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Hi,

在 2024/9/3 16:09, Uwe Kleine-König 写道:
> Hello,
> 
> On Sat, Aug 31, 2024 at 10:13:27AM +0800, Li Zetao wrote:
>> Use devm_clk_get_enabled() instead of devm_clk_get() +
>> clk_prepare_enable(), which can make the clk consistent with the device
>> life cycle and reduce the risk of unreleased clk resources. Since the
>> device framework has automatically released the clk resource, there is
>> no need to execute clk_disable_unprepare(clk) on the error path, drop
>> the cleanup_clk label, and the original error process can return directly.
>>
>> Signed-off-by: Li Zetao <lizetao1@huawei.com>
>> ---
>>   drivers/net/ethernet/faraday/ftgmac100.c | 27 ++++++------------------
>>   1 file changed, 7 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/net/ethernet/faraday/ftgmac100.c b/drivers/net/ethernet/faraday/ftgmac100.c
>> index 4c546c3aef0f..eb57c822c5ac 100644
>> --- a/drivers/net/ethernet/faraday/ftgmac100.c
>> +++ b/drivers/net/ethernet/faraday/ftgmac100.c
>> @@ -1752,13 +1752,10 @@ static int ftgmac100_setup_clk(struct ftgmac100 *priv)
>>   	struct clk *clk;
>>   	int rc;
>>   
>> -	clk = devm_clk_get(priv->dev, NULL /* MACCLK */);
>> +	clk = devm_clk_get_enabled(priv->dev, NULL /* MACCLK */);
>>   	if (IS_ERR(clk))
>>   		return PTR_ERR(clk);
>>   	priv->clk = clk;
>> -	rc = clk_prepare_enable(priv->clk);
>> -	if (rc)
>> -		return rc;
>>   
>>   	/* Aspeed specifies a 100MHz clock is required for up to
>>   	 * 1000Mbit link speeds. As NCSI is limited to 100Mbit, 25MHz
>> @@ -1767,21 +1764,17 @@ static int ftgmac100_setup_clk(struct ftgmac100 *priv)
>>   	rc = clk_set_rate(priv->clk, priv->use_ncsi ? FTGMAC_25MHZ :
>>   			  FTGMAC_100MHZ);
>>   	if (rc)
>> -		goto cleanup_clk;
>> +		return rc;
>>   
>>   	/* RCLK is for RMII, typically used for NCSI. Optional because it's not
>>   	 * necessary if it's the AST2400 MAC, or the MAC is configured for
>>   	 * RGMII, or the controller is not an ASPEED-based controller.
>>   	 */
>> -	priv->rclk = devm_clk_get_optional(priv->dev, "RCLK");
>> -	rc = clk_prepare_enable(priv->rclk);
>> -	if (!rc)
>> -		return 0;
>> +	priv->rclk = devm_clk_get_optional_enabled(priv->dev, "RCLK");
>> +	if (IS_ERR(priv->rclk))
>> +		return PTR_ERR(priv->rclk);
>>   
>> -cleanup_clk:
>> -	clk_disable_unprepare(priv->clk);
>> -
>> -	return rc;
>> +	return 0;
> 
> You're changing semantics here. Before your patch ftgmac100_setup_clk()
> was left with priv->clk disabled; now you keep it enabled.
Before my patch, ftgmac100_setup_clk() was only left with priv->clk 
disabled when error occurs, and was left with priv->clk enabled when no 
error occurs because when enabling priv->rclk successfully, it will 
return 0 directly, and when enabling priv->rclk failed, it will disable 
priv->clk.

It turns out that the code logic is a bit counter-intuitive, but the 
readability has been improved after adjustments.
> 
> Further note that there is a bug here, because in ftgmac100_probe()
> (i.e. the caller of ftgmac100_setup_clk())
> clk_disable_unprepare(priv->clk) is called in the error path.
> (I only looked quickly, so I might have missed a detail.)
I have considered the case that clk_disable_unprepare will not be 
executed on the wrong path in ftgmac100_probe(). So I understand that 
the problem you mentioned should not exist.
> 
> So while your patch is an improvement for clock enable/disable
> balancing, it might regress on power consumption.
> 
>>   }
>>   
>>   static bool ftgmac100_has_child_node(struct device_node *np, const char *name)
>> @@ -1996,16 +1989,13 @@ static int ftgmac100_probe(struct platform_device *pdev)
>>   	err = register_netdev(netdev);
>>   	if (err) {
>>   		dev_err(&pdev->dev, "Failed to register netdev\n");
>> -		goto err_register_netdev;
>> +		goto err_phy_connect;
>>   	}
>>   
>>   	netdev_info(netdev, "irq %d, mapped at %p\n", netdev->irq, priv->base);
>>   
>>   	return 0;
>>   
>> -err_register_netdev:
>> -	clk_disable_unprepare(priv->rclk);
>> -	clk_disable_unprepare(priv->clk);
>>   err_phy_connect:
>>   	ftgmac100_phy_disconnect(netdev);
>>   err_ncsi_dev:
>> @@ -2034,9 +2024,6 @@ static void ftgmac100_remove(struct platform_device *pdev)
>>   		ncsi_unregister_dev(priv->ndev);
>>   	unregister_netdev(netdev);
>>   
>> -	clk_disable_unprepare(priv->rclk);
>> -	clk_disable_unprepare(priv->clk);
>> -
>>   	/* There's a small chance the reset task will have been re-queued,
>>   	 * during stop, make sure it's gone before we free the structure.
>>   	 */
> 
> Best regards
> Uwe

Thanks,
Li Zetao.

