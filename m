Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3EACC3C324
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Jun 2019 06:56:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390229AbfFKE4J (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Tue, 11 Jun 2019 00:56:09 -0400
Received: from smtp.knology.net ([64.8.71.112]:25323 "EHLO smtp.knology.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388934AbfFKE4J (ORCPT <rfc822;linux-wireless@vger.kernel.org>);
        Tue, 11 Jun 2019 00:56:09 -0400
X-CTCH-AV-ThreatsCount: 
X-CTCH-VOD: Unknown
X-CTCH-Spam: Unknown
X-CTCH-RefID: str=0001.0A15020D.5CFF3467.006E,ss=1,re=0.000,recu=0.000,reip=0.000,cl=1,cld=1,fgs=0
X_CMAE_Category: , ,
X-CNFS-Analysis: v=2.3 cv=OZ/m8SbY c=1 sm=1 tr=0 a=TJn/bo6x+BmUhJ5QWj0rSA==:117 a=TJn/bo6x+BmUhJ5QWj0rSA==:17 a=jpOVt7BSZ2e4Z31A5e1TngXxSK0=:19 a=KGjhK52YXX0A:10 a=IkcTkHD0fZMA:10 a=t3LY3UrxeVQA:10 a=dq6fvYVFJ5YA:10 a=pO7Hyq7_a4YA:10 a=5Pr6cp1LAAAA:8 a=yQdBAQUQAAAA:8 a=AWIfEAA3_sFtwlGCmbEA:9 a=QEXdDO2ut3YA:10 a=0Hlou4YPydrkO5duKyP1:22 a=SzazLyfi1tnkUD6oumHU:22
X-CM-Score: 0
X-Scanned-by: Cloudmark Authority Engine
X-Authed-Username: YnV1c0B3b3d3YXkuY29t
X_CMAE_Category: , ,
X-CNFS-Analysis: 
X-CM-Score: 
X-Scanned-by: Cloudmark Authority Engine
Authentication-Results:  smtp02.wow.cmh.synacor.com smtp.user=buus@wowway.com; auth=pass (LOGIN)
Received: from [96.27.15.54] ([96.27.15.54:54875] helo=[192.168.1.245])
        by smtp.mail.wowway.com (envelope-from <ubuntu@hbuus.com>)
        (ecelerity 3.6.25.56547 r(Core:3.6.25.0)) with ESMTPSA (cipher=AES128-SHA) 
        id D0/48-27040-6643FFC5; Tue, 11 Jun 2019 00:56:07 -0400
Subject: Re: [PATCH] ssb/gpio: Remove unnecessary WARN_ON from driver_gpio
To:     Larry Finger <Larry.Finger@lwfinger.net>,
        =?UTF-8?Q?Michael_B=c3=bcsch?= <m@bues.ch>,
        Kalle Valo <kvalo@codeaurora.org>
Cc:     linux-wireless <linux-wireless@vger.kernel.org>
References: <946c86bf-7e90-a981-b9fc-757adb98adfa@hbuus.com>
 <20190610204927.2de21c9a@wiggum>
 <de857b70-fbc2-9c29-b31e-d544a33c8ced@lwfinger.net>
From:   H Buus <ubuntu@hbuus.com>
Message-ID: <5731d6fb-c63d-9ecb-d27b-afd07a55587a@hbuus.com>
Date:   Tue, 11 Jun 2019 00:56:07 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <de857b70-fbc2-9c29-b31e-d544a33c8ced@lwfinger.net>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-wireless-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 6/10/2019 3:16 PM, Larry Finger wrote:
> On 6/10/19 1:49 PM, Michael Büsch wrote:
>> The WARN_ON triggers on older BCM4401-B0 100Base-TX ethernet controllers.
>> The warning serves no purpose. So let's just remove it.
>>
>> Reported-by: H Buus <ubuntu@hbuus.com>
>> Signed-off-by: Michael Büsch <m@bues.ch>
>>
>> ---
> 
> Acked-by: Larry Finger <Larry.Finger@lwfinger.net>
> 
> Larry

Works for me. Thanks!

>>
>> diff --git a/drivers/ssb/driver_gpio.c b/drivers/ssb/driver_gpio.c
>> index e809dae4c470..66a76fd83248 100644
>> --- a/drivers/ssb/driver_gpio.c
>> +++ b/drivers/ssb/driver_gpio.c
>> @@ -460,9 +460,6 @@ int ssb_gpio_init(struct ssb_bus *bus)
>>           return ssb_gpio_chipco_init(bus);
>>       else if (ssb_extif_available(&bus->extif))
>>           return ssb_gpio_extif_init(bus);
>> -    else
>> -        WARN_ON(1);
>> -
>>       return -1;
>>   }
>>   @@ -472,9 +469,6 @@ int ssb_gpio_unregister(struct ssb_bus *bus)
>>           ssb_extif_available(&bus->extif)) {
>>           gpiochip_remove(&bus->gpio);
>>           return 0;
>> -    } else {
>> -        WARN_ON(1);
>>       }
>> -
>>       return -1;
>>   }
>>
> 
