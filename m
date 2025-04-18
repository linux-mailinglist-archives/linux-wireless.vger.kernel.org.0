Return-Path: <linux-wireless+bounces-21721-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A30B3A93804
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 15:36:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4AEE3AA407
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Apr 2025 13:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5573820767E;
	Fri, 18 Apr 2025 13:36:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WhuEuyXa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74F46278156
	for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 13:36:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744983375; cv=none; b=Oy2Z9dNQF91a3fiTf/ezlkEUHAWCv0E1yH7CyArZZEeSNB3bRUVms21hMVYphjJ8o0R7SPKOaSj+9IHD9yBxtqypXYXclLXeeOTKcJr9McXjicDp54dhMn+FOAOiiWcm65AKuJPIr+cJdKBIbH/KADh6qQJmXJb2/8ScvWZyK4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744983375; c=relaxed/simple;
	bh=ZxcOpr6RZlTxqQIVVGCqG8e2ZH52NwvX4RJ+ZtHXCyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fIFoZaUcWH7Gr4wC+a0TzGQMLpJYIckNN+kGpu/W1Tp2S/Go2yLdXquNthSij3mJC7RdmDNZSAufFrd6FeiGX7+p+UXHFUK3gzjfuvHTndJU+njUVWqBJxnEJHjzsUeewHargqdwlrQjzAgrOqoePZ8wfzKKXIeeJ/dfF14OHdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WhuEuyXa; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5efe8d9eb1eso112635a12.0
        for <linux-wireless@vger.kernel.org>; Fri, 18 Apr 2025 06:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1744983372; x=1745588172; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EvwfvrttS05j7L4Ua84nI6To9F6lY0klbw5ICZPuZik=;
        b=WhuEuyXauQncrrSv2CkLzEufUxa824hdeG71oCXnoIeauzMcU8NiSQ+AVzhkDqhfeI
         WYt+RxIdKT1gJzEObsiQ3oCOp/GKrEcmVkNO0gYjWxZxkUpiSdwL9GGkHFoep76vtLQL
         u9IrzpQ28Rx/l+zaX3O+XFLGqtU5/DI6FDUSYUivtyTOTQnHF4hivdnnmYPQwQ03mQxC
         GxEWZ8MrZ9SdLzFTQpkuhMGGp5y0ZHaVhUkmuQIVzBZ9W97lAya2sF1MDdQB3bY9aoce
         5X5/8qQs/gTlUevmWHIa/Xt/y3VHTz+x1Qc5SSrjd5rn3DNQqnbcuZK/nx45t17FhqLZ
         2eIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1744983372; x=1745588172;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EvwfvrttS05j7L4Ua84nI6To9F6lY0klbw5ICZPuZik=;
        b=KEDitD/zwXX/auMt0sBNZ8A4FqKkAYqbNd1TuR49R2Qclce3+EnB6+Jl4c55eLCvBT
         wUxjQjjB+hO/GvUHO02A0ghK7OqZx9qcj+EIqcRGiltD5SqjJPxpmjOGZBSfNFc6cfvi
         Yz0KEOBvc37a8LAVL1WnkICB8lbSHL/kbOMjcV8Sw3Nc8biLY6yb1MnFIQzRke9I6Tmn
         VwqwRjeTa4GwAj2i1FBd5xl9xGzOS3WBmeB4E+Ji+RIfD0GmPP9cV+n9MR+m84VHAX/P
         LMmphPQDLDYinnPsMJhgRCeKKFC73dTZj+fW48O2wylsk4N5r/a6pcC24p2fpxRtsJ+u
         99dw==
X-Gm-Message-State: AOJu0YwdnEn0Qpk6AuUrKnMSR+58EnE9m9ClAvVkGeejHwkb86RRdli9
	+ohZxqXjUQ5Lg3R+W9MFGBao1eC73zSmMY/QfvRmEwUx5W3zq4NXSds8e3wU
X-Gm-Gg: ASbGncuJvEQN+2qB6vTZ1SEA9SLcp9UjqIM1sqmps09J2W4N3fOwcVyXUrNQgHNheR2
	kimVH/UGxSxpYVud4bRtxHHAJcDJ8/P78YvOENMeXdB3WtTjISITUEQfWHBjDWaw4S1neROU0Cy
	J1i56kba9Mh3xVulxVQkRSSsyON2oGGRB26Zh9Ov8lF2HrbGaCS/EggBDMDc07S6t//10KI6VoB
	Vj1QGYxd2lCAwYhGf+QNUGoebcXb0t1b3aU++dyba0zfvyNejO1pesPshBuJ6c7X4q+8C4eGSNP
	+paR0BRpZaPvNfw3dXlfhtjlRyMyv9NSO3l2Y9vsDf+9Z3dOUXuhB+kJpPUaggo1FDrH46ZHfXQ
	PrAl/Ra0ZuRAT0rqWhscrDQ==
X-Google-Smtp-Source: AGHT+IHXm6BSBZjjm6w5bzQjSpdsRQ5VrVD8TwHRtP2w1UDkOFb74MEo3fsG/z9CPb3OL6ISbtXobA==
X-Received: by 2002:a05:6402:3586:b0:5ec:8aeb:812a with SMTP id 4fb4d7f45d1cf-5f628575060mr2699155a12.14.1744983371498;
        Fri, 18 Apr 2025 06:36:11 -0700 (PDT)
Received: from [192.168.1.73] (157-21-254-92.ftth.glasoperator.nl. [92.254.21.157])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5f625596138sm1033679a12.45.2025.04.18.06.36.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Apr 2025 06:36:11 -0700 (PDT)
Message-ID: <84e4f0d3-3829-48f7-add7-4b79fdaefac7@gmail.com>
Date: Fri, 18 Apr 2025 15:36:10 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] mt76: mt76x2: Disable VHT on 0x76320044 ASIC
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Felix Fietkau <nbd@nbd.name>
References: <20250418002827.26806-1-henk.vergonet@gmail.com>
 <20250418002827.26806-2-henk.vergonet@gmail.com> <aAJHqxIcw6J3yWoU@lore-desk>
Content-Language: en-US
From: Henk Vergonet <henk.vergonet@gmail.com>
In-Reply-To: <aAJHqxIcw6J3yWoU@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Hi Lorenzo,

Thank you for the review.

I will rename 'vht_flag' to 'vht', squash the patch and apply your 
suggested corrections.

Also I did search of the "ASIC revision: 76320044" and as far as I can 
tell turned out to be related to the Xbox wireless dongle. It had 
similar issues as I experienced with the LiteOn module when VHT was 
enabled. So I think it is fair to assume this will fix more than it breaks.

But I can't be sure of course, I don't work at Mediatek and this 
information is not publicly available to my knowledge.
The Mediatek girls and guys on this list should be able to step in and 
provide an overview of the different ASIC revisions and their 
capabilities probably ;)

Kind regards,
Henk

On 4/18/25 14:38, Lorenzo Bianconi wrote:
>> From: Henk Vergonet <Henk.Vergonet@gmail.com>
>>
>> VHT is not supported on ASIC revision 0x76320044
>>
>> This fixes the 5G connectibity issue on LiteOn WN4519R module
>> see https://github.com/openwrt/mt76/issues/971
>>
>> And may also fix the 5G issues on the XBox One Wireless Adapter
>> see https://github.com/openwrt/mt76/issues/200
>> ---
>>   drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c | 11 ++++++++++-
>>   1 file changed, 10 insertions(+), 1 deletion(-)
> I think this patch must be squashed with the previous one. Moreover, can you
> please run checkpatch.pl? There are some coding style problems here.
>
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
>> index 33a14365ec9b..fbb337ef6b68 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt76x2/usb_init.c
>> @@ -191,6 +191,7 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
>>   {
>>   	struct ieee80211_hw *hw = mt76_hw(dev);
>>   	struct mt76_usb *usb = &dev->mt76.usb;
>> +	bool vht_flag;
> maybe something more meaningful, like 'is_vht' or even just 'vht'.
>
>>   	int err;
>>   
>>   	INIT_DELAYED_WORK(&dev->cal_work, mt76x2u_phy_calibrate);
>> @@ -217,7 +218,15 @@ int mt76x2u_register_device(struct mt76x02_dev *dev)
>>   
>>   	/* check hw sg support in order to enable AMSDU */
>>   	hw->max_tx_fragments = dev->mt76.usb.sg_en ? MT_TX_SG_MAX_SIZE : 1;
>> -	err = mt76_register_device(&dev->mt76, true, mt76x02_rates,
>> +	switch(dev->mt76.rev ) {
> remove space before ')'
>
>> +		/* these ASIC revisions do not support VHT */
>> +		case 0x76320044:
> are you sure this is true for all '0x76320044' ASICs?
>
>> +			vht_flag = false;
>> +			break;
>> +		default:
>> +			vht_flag = true;
> missing break
>
>> +	}
>> +	err = mt76_register_device(&dev->mt76, vht_flag, mt76x02_rates,
>>   				   ARRAY_SIZE(mt76x02_rates));
>>   	if (err)
>>   		goto fail;
>> -- 
>> 2.45.2
>>

