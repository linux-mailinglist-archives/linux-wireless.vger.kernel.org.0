Return-Path: <linux-wireless+bounces-12383-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3615969AD3
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 12:53:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 027BE1C239AD
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 10:53:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 605011C62A6;
	Tue,  3 Sep 2024 10:52:55 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9B921C768B;
	Tue,  3 Sep 2024 10:52:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725360775; cv=none; b=JfjEeeDLa5qvkv4WAyETaKCRL4MGx1tudY2gxpoOEKa8t+ExhUBUpdyH3E+bRbrCvZE3v+UorL47DDKPNHNsG9cL56EjW4dzqMXiDeAnUynM6+GzNYN7V3zhzFsRRmXoIWqsjmf+i4Sko3zrJ7xsw65PathJtr48JOA+3mveXXI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725360775; c=relaxed/simple;
	bh=TCa9XECvj6a95ytuCJ/rfxMfMjBBJHeKZNA431XrJLI=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=Kz6e6P1ZqtitgvrOXZjbbNeDv9SA/PYNRaOHTEj4CyRU4Vn/b57tKG21vifQPgzIDi5FmGWgM5kyUaFnoBUFYR9g7c7W3lCE3tHe4Mfai08655O0oBbD7WNQtyOQKk3WHPJU+z/owuNGlM2Fyj8mWunAtXeT4RMtty1F3hGMHOo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Wyj9k0Zx5z145xm;
	Tue,  3 Sep 2024 18:51:54 +0800 (CST)
Received: from kwepemd500012.china.huawei.com (unknown [7.221.188.25])
	by mail.maildlp.com (Postfix) with ESMTPS id 262C31800FE;
	Tue,  3 Sep 2024 18:52:50 +0800 (CST)
Received: from [10.67.111.176] (10.67.111.176) by
 kwepemd500012.china.huawei.com (7.221.188.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Tue, 3 Sep 2024 18:52:49 +0800
Message-ID: <021d4b46-a559-4047-a6ca-98e30fd3e6b3@huawei.com>
Date: Tue, 3 Sep 2024 18:52:48 +0800
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH net-next 11/12] wifi: wilc1000: Convert using
 devm_clk_get_optional_enabled() in wilc_sdio_probe()
To: Kalle Valo <kvalo@kernel.org>
CC: <florian.fainelli@broadcom.com>, <andrew@lunn.ch>, <olteanv@gmail.com>,
	<davem@davemloft.net>, <edumazet@google.com>, <kuba@kernel.org>,
	<pabeni@redhat.com>, <wens@csie.org>, <jernej.skrabec@gmail.com>,
	<samuel@sholland.org>, <heiko@sntech.de>, <yisen.zhuang@huawei.com>,
	<salil.mehta@huawei.com>, <hauke@hauke-m.de>, <alexandre.torgue@foss.st.com>,
	<joabreu@synopsys.com>, <mcoquelin.stm32@gmail.com>, <wellslutw@gmail.com>,
	<radhey.shyam.pandey@amd.com>, <michal.simek@amd.com>,
	<ajay.kathat@microchip.com>, <claudiu.beznea@tuxon.dev>,
	<u.kleine-koenig@pengutronix.de>, <jacky_chou@aspeedtech.com>,
	<netdev@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-sunxi@lists.linux.dev>, <linux-rockchip@lists.infradead.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <linux-wireless@vger.kernel.org>
References: <20240831021334.1907921-1-lizetao1@huawei.com>
 <20240831021334.1907921-12-lizetao1@huawei.com> <87a5gqko2q.fsf@kernel.org>
From: Li Zetao <lizetao1@huawei.com>
In-Reply-To: <87a5gqko2q.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: dggpeml500005.china.huawei.com (7.185.36.59) To
 kwepemd500012.china.huawei.com (7.221.188.25)

Hi,

在 2024/9/3 0:38, Kalle Valo 写道:
> Li Zetao <lizetao1@huawei.com> writes:
> 
>> Use devm_clk_get_optional_enabled() instead of devm_clk_get_optional() +
>> clk_prepare_enable(), which can make the clk consistent with the device
>> life cycle and reduce the risk of unreleased clk resources. Since the
>> device framework has automatically released the clk resource, there is
>> no need to execute clk_disable_unprepare(clk) on the error path, drop
>> the clk_disable_unprepare label, and the original error process can change
>> to dispose_irq.
>>
>> Signed-off-by: Li Zetao <lizetao1@huawei.com>
>> ---
>>   drivers/net/wireless/microchip/wilc1000/sdio.c | 10 +++-------
>>   1 file changed, 3 insertions(+), 7 deletions(-)
> 
> wifi patches (patches 11 and 12) go via wireless-next, please submit
> those separately.
Ok, I will resend those separately.
> 

Thanks,
Li Zetao.

