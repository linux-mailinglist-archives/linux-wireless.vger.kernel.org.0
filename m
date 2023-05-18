Return-Path: <linux-wireless-owner@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA187089FC
	for <lists+linux-wireless@lfdr.de>; Thu, 18 May 2023 23:01:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbjERVBS (ORCPT <rfc822;lists+linux-wireless@lfdr.de>);
        Thu, 18 May 2023 17:01:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjERVBR (ORCPT
        <rfc822;linux-wireless@vger.kernel.org>);
        Thu, 18 May 2023 17:01:17 -0400
Received: from dispatch1-us1.ppe-hosted.com (dispatch1-us1.ppe-hosted.com [148.163.129.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4754EE
        for <linux-wireless@vger.kernel.org>; Thu, 18 May 2023 14:01:15 -0700 (PDT)
X-Virus-Scanned: Proofpoint Essentials engine
Received: from mail3.candelatech.com (mail2.candelatech.com [208.74.158.173])
        by mx1-us1.ppe-hosted.com (PPE Hosted ESMTP Server) with ESMTP id E25A3C4008E;
        Thu, 18 May 2023 21:01:13 +0000 (UTC)
Received: from [192.168.100.159] (50-251-239-81-static.hfc.comcastbusiness.net [50.251.239.81])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail3.candelatech.com (Postfix) with ESMTPSA id 5D9A213C2B0;
        Thu, 18 May 2023 14:01:11 -0700 (PDT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail3.candelatech.com 5D9A213C2B0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=candelatech.com;
        s=default; t=1684443671;
        bh=f7UVOeajqZxAbdDvUIeocPHQUDJcwEflHXkitMYSEDw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=KGBL4VCjJL+V41jky79OVvHe7L3ho5XpGiDLZFRBKE4IDkc4K/WUaRg2d1/bGcHjh
         7+hYvXBubAQkmqsi1AAe1lAJrhQ++FQQl9R6fcWc0nmnYLiOpDk9rvkWD40XEQDUdU
         BB5HowQUmRgqgKTg0SHx3TDog7Xm1JOmQd4VwjPY=
Message-ID: <43d01aa8-b594-2770-59d0-13e6388c5758@candelatech.com>
Date:   Thu, 18 May 2023 14:01:11 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] wifi: mt76: mt7921: Support temp sensor.
Content-Language: en-US
To:     Lorenzo Bianconi <lorenzo@kernel.org>
Cc:     linux-wireless@vger.kernel.org
References: <20230518200718.1367381-1-greearb@candelatech.com>
 <ZGaNm8mMfbqdtWa0@lore-desk>
From:   Ben Greear <greearb@candelatech.com>
Organization: Candela Technologies
In-Reply-To: <ZGaNm8mMfbqdtWa0@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-MDID: 1684443674-JpsseWCM7R4p
X-MDID-O: us5;ut7;1684443674;JpsseWCM7R4p;<greearb@candelatech.com>;0161bc757c83381a5b931166ef547186
X-Spam-Status: No, score=-5.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-wireless.vger.kernel.org>
X-Mailing-List: linux-wireless@vger.kernel.org

On 5/18/23 13:42, Lorenzo Bianconi wrote:
>> From: Ben Greear <greearb@candelatech.com>
>>
>> Allow sensors tool to read radio's temperature, example:
>>
>> mt7921_phy17-pci-1800
>> Adapter: PCI adapter
>> temp1:        +72.0°C
>>
>> Signed-off-by: Ben Greear <greearb@candelatech.com>
>> ---
>>   .../net/wireless/mediatek/mt76/mt7921/init.c  | 53 +++++++++++++++++++
>>   .../net/wireless/mediatek/mt76/mt7921/mcu.c   | 17 ++++++
>>   .../wireless/mediatek/mt76/mt7921/mt7921.h    |  1 +
>>   3 files changed, 71 insertions(+)
>>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/init.c b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
>> index c15ce1a19000..18f0f2dfbbcf 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7921/init.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/init.c
>> @@ -2,6 +2,9 @@
>>   /* Copyright (C) 2020 MediaTek Inc. */
>>   
>>   #include <linux/etherdevice.h>
>> +#include <linux/hwmon.h>
>> +#include <linux/hwmon-sysfs.h>
>> +#include <linux/thermal.h>
>>   #include <linux/firmware.h>
>>   #include "mt7921.h"
>>   #include "../mt76_connac2_mac.h"
>> @@ -58,6 +61,50 @@ static const struct ieee80211_iface_combination if_comb_chanctx[] = {
>>   	}
>>   };
>>   
>> +static ssize_t mt7921_thermal_temp_show(struct device *dev,
>> +					struct device_attribute *attr,
>> +					char *buf)
>> +{
>> +	struct mt7921_phy *phy = dev_get_drvdata(dev);
>> +	int i = to_sensor_dev_attr(attr)->index;
>> +	int temperature;
>> +
>> +	switch (i) {
> 
> nit: you can drop i and just use to_sensor_dev_attr(attr)->index
> 
>> +	case 0:
> 
> I think you need to wake the device up here running mt7921_mutex_acquire
> before sending the mcu command.

I need to wake it up and acquire a mutex, or does acquiring the mutex wake it
automatically?

And, mt7915 has some other logic in this area.  I left the switch logic in
to match that, thinking maybe later we can add the other options to 7921?

Do you know if 7921 supports the other options like 7915?

Thanks,
Ben


-- 
Ben Greear <greearb@candelatech.com>
Candela Technologies Inc  http://www.candelatech.com


