Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 263A538BB07
	for <lists+linux-wireless@lfdr.de>; Fri, 21 May 2021 02:49:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235562AbhEUAvH (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 20 May 2021 20:51:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:3634 "EHLO
        szxga06-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235556AbhEUAvH (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 20 May 2021 20:51:07 -0400
Received: from dggems706-chm.china.huawei.com (unknown [172.30.72.60])
        by szxga06-in.huawei.com (SkyGuard) with ESMTP id 4FmScZ5Hk2zmWjv;
        Fri, 21 May 2021 08:47:26 +0800 (CST)
Received: from dggeme759-chm.china.huawei.com (10.3.19.105) by
 dggems706-chm.china.huawei.com (10.3.19.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id
 15.1.2176.2; Fri, 21 May 2021 08:49:43 +0800
Received: from [127.0.0.1] (10.40.188.144) by dggeme759-chm.china.huawei.com
 (10.3.19.105) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2176.2; Fri, 21
 May 2021 08:49:43 +0800
Subject: Re: [PATCH] ssb: remove unreachable code
To:     =?UTF-8?Q?Michael_B=c3=bcsch?= <m@bues.ch>,
        Tian Tao <tiantao6@hisilicon.com>
CC:     <linux-wireless@vger.kernel.org>, Kalle Valo <kvalo@codeaurora.org>
References: <1621306352-3632-1-git-send-email-tiantao6@hisilicon.com>
 <20210520185136.2cc3b32b@wiggum>
From:   "tiantao (H)" <tiantao6@huawei.com>
Message-ID: <0a40049b-691c-c75f-ece2-a669842bedaf@huawei.com>
Date:   Fri, 21 May 2021 08:49:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <20210520185136.2cc3b32b@wiggum>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.40.188.144]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggeme759-chm.china.huawei.com (10.3.19.105)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org


在 2021/5/21 0:51, Michael Büsch 写道:
> On Tue, 18 May 2021 10:52:32 +0800
> Tian Tao <tiantao6@hisilicon.com> wrote:
>
>> The return value of ssb_bus_unregister can only be 0 or 1, so this
>> condition if (err == -EBUSY) will not hold, so delete it.
>> @@ -431,9 +431,7 @@ void ssb_bus_unregister(struct ssb_bus *bus)
>>   	int err;
>>   
>>   	err = ssb_gpio_unregister(bus);
>> -	if (err == -EBUSY)
>> -		pr_debug("Some GPIOs are still in use\n");
>> -	else if (err)
>> +	if (err)
>>   		pr_debug("Can not unregister GPIO driver: %i\n", err);
>>   
>>   	ssb_buses_lock();
> Good catch.
> Minor correction: The return value can be 0 or -1.
yes, you are right. thanks again.:-)
>
> Acked-by: Michael Büsch <m@bues.ch>
>

