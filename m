Return-Path: <linux-wireless+bounces-15281-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0056F9C7EF0
	for <lists+linux-wireless@lfdr.de>; Thu, 14 Nov 2024 00:49:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 803071F23133
	for <lists+linux-wireless@lfdr.de>; Wed, 13 Nov 2024 23:49:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98C6E18C021;
	Wed, 13 Nov 2024 23:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RRmw6zXR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1BEA18C01A
	for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 23:48:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731541741; cv=none; b=b3nybjTdIZQND2CjTTLvwO+amvoeQhf4RiKZu5sXRtMYjawyIiXewYk9qdYm7CX61T978UlWObnQwBBYhNYs1YMqB5ktYzqGT7RIgJ06Y0gP8Lthk0zmQ96zraeKqjTHCfpHkHIP52ZvkGQ8qFdpHtsZZRvCNOMS/+LVH4V5BN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731541741; c=relaxed/simple;
	bh=gktAPHHjQP1VfVTQyo0B1hHTyD9McjMFGiTjcHtsw/k=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Tiwhh7X+C7ijl9TKi7mhSQKKR6wKiPDJJA336GcnAQFjAUDz3hfmWWkcLe1tHDATPsJCPyAhDKshSbGL1nJBec7XvIuiRuCUuafuz4pGc2ABdMWCcUHSbVW2nFPRkucXjKqsym5bd9AsW/bPib3Uml4EZCgYzJ4pXGfGydXCI64=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RRmw6zXR; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a9a4031f69fso1230266b.0
        for <linux-wireless@vger.kernel.org>; Wed, 13 Nov 2024 15:48:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731541738; x=1732146538; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=06VXFwLRA5HSLFcWS4yo52fx3f3ugUd94RQXnn2CYTY=;
        b=RRmw6zXRJhFFLr5cpYvZUraBL3DjQ4CJsPMqUeSSf3ADhBFJ6YdsZRK04PCrQBYAGT
         dbaVPaMybepLzKM90aH/cV4aelJu9bhxuD0NvhPHv2NQKQKV+jD4FXsHYx8YkXgekWFS
         1voc3bCyql+9eDiXn7D0/2pBokZ65sWtEi071+TyqQiUMcQXLlwkEdDTSivwiYknmzu0
         e/7ZrRMqCZf8OdIhPjVfoQRnlCa6vUGYRQossdbqf16BMas+3QMab1JFCquaH6YYCcxC
         klPYzVKEN0eZ9Nf7pONofSVAA2lVmdR+G/512tAWgqS8IyIlEpprkADYcSXfUUpqFwLB
         beTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731541738; x=1732146538;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=06VXFwLRA5HSLFcWS4yo52fx3f3ugUd94RQXnn2CYTY=;
        b=vitqvmHvGuFRIi3a3vI01ROB+J6BK2FJoDJfpmv130E6EeWQA/bqQrcqyBzfEVh6MB
         QLIbNSYejJL2zF3jy5YMl8QgxjIG5rFsk+Lk2nQB56xJRNXEmNXLqt6gEPQROZW4lwSh
         8riFm/u/Zh6PYWOFly/wuBvuvehsMlUoANYXZcfZueA5UgkicZ3HfQOH4DyjtpdmUBz6
         vH5FXDSezUc1vNNSH4WnTVa18DtIQZGt+B8RFBzJU7gn3fPAQ/r5eq7lB/KgaKwyviAx
         EW2oFK3XV7AWWllwJxcWk92Eu18gyzcLuluL6Je6KSppfCn0iM06HaczmO10jgxhNGoI
         216A==
X-Forwarded-Encrypted: i=1; AJvYcCXe5/NlHpmFwKxSgkidu3WW3TQUo7y3zcYuMZ2QPYKTJWSYO/mgazW9yae5wC/4d/upYqTV2I/v6+d0Y8L46w==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz9l7nFYid/0RZT7UINtoWxZ2V/Pn+YZb7keVlMyapEoAtCz5hW
	zcO9Z86/84XIz7/pp87wwvPY+/2ORd70CBkgYFQ7pmIBh20AeePK
X-Google-Smtp-Source: AGHT+IFN9rvpGGLN8mDjhAzWiY7cSNLN+2Zoo5pm+lE71RtJGXeZAMewlUQArIObqy9i+FKP8iKMbw==
X-Received: by 2002:a17:907:7d8e:b0:a9a:14fc:44a2 with SMTP id a640c23a62f3a-a9eeff44f6emr2251416866b.30.1731541738181;
        Wed, 13 Nov 2024 15:48:58 -0800 (PST)
Received: from [192.168.0.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a9ee0dc531csm926988166b.117.2024.11.13.15.48.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Nov 2024 15:48:57 -0800 (PST)
Message-ID: <0b28edbf-6a62-4400-a58f-d6ed1a198c71@gmail.com>
Date: Thu, 14 Nov 2024 01:48:54 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: rtw88: usb: Support USB 3 with RTL8812AU
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <78ca9bcb-cd48-4c53-8514-7967bad6dfcf@gmail.com>
 <c053ea160bd1469e8b076247f3641193@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <c053ea160bd1469e8b076247f3641193@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/11/2024 04:36, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Add the function to automatically switch the RTL8812AU into USB 3 mode.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw88/usb.c | 34 ++++++++++++++++++++++--
>>  1 file changed, 32 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
>> index 6fa3c37205f5..752bca05b9af 100644
>> --- a/drivers/net/wireless/realtek/rtw88/usb.c
>> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
>> @@ -931,6 +931,32 @@ static void rtw_usb_intf_deinit(struct rtw_dev *rtwdev,
>>         usb_set_intfdata(intf, NULL);
>>  }
>>
>> +static int rtw_usb_switch_mode_old(struct rtw_dev *rtwdev)
>> +{
>> +       struct rtw_usb *rtwusb = rtw_get_usb_priv(rtwdev);
>> +       enum usb_device_speed cur_speed = rtwusb->udev->speed;
>> +       u8 hci_opt;
>> +
>> +       if (cur_speed == USB_SPEED_HIGH) {
>> +               hci_opt = rtw_read8(rtwdev, REG_HCI_OPT_CTRL);
>> +
>> +               if ((hci_opt & (BIT(2) | BIT(3))) != BIT(3)) {
>> +                       rtw_write8(rtwdev, REG_HCI_OPT_CTRL, 0x8);
>> +                       rtw_write8(rtwdev, REG_SYS_SDIO_CTRL, 0x2);
>> +                       rtw_write8(rtwdev, REG_ACLK_MON, 0x1);
>> +                       rtw_write8(rtwdev, 0x3d, 0x3);
>> +                       /* usb disconnect */
>> +                       rtw_write8(rtwdev, REG_SYS_PW_CTRL + 1, 0x80);
>> +                       return 1;
>> +               }
>> +       } else if (cur_speed == USB_SPEED_SUPER) {
>> +               rtw_write8_clr(rtwdev, REG_SYS_SDIO_CTRL, BIT(1));
>> +               rtw_write8_clr(rtwdev, REG_ACLK_MON, BIT(0));
>> +       }
>> +
>> +       return 0;
>> +}
>> +
>>  static int rtw_usb_switch_mode_new(struct rtw_dev *rtwdev)
>>  {
>>         enum usb_device_speed cur_speed;
>> @@ -984,7 +1010,8 @@ static int rtw_usb_switch_mode(struct rtw_dev *rtwdev)
>>  {
>>         u8 id = rtwdev->chip->id;
>>
>> -       if (id != RTW_CHIP_TYPE_8822C && id != RTW_CHIP_TYPE_8822B)
>> +       if (id != RTW_CHIP_TYPE_8822C && id != RTW_CHIP_TYPE_8822B &&
>> +           id != RTW_CHIP_TYPE_8812A)
> 
> Would it be clear to list positive chips in a function? and return new/old type
> chip is using for latter condition. 
> 

That sounds good.

>>                 return 0;
>>
>>         if (!rtwdev->efuse.usb_mode_switch) {
>> @@ -999,7 +1026,10 @@ static int rtw_usb_switch_mode(struct rtw_dev *rtwdev)
>>                 return 0;
>>         }
>>
>> -       return rtw_usb_switch_mode_new(rtwdev);
>> +       if (id == RTW_CHIP_TYPE_8812A)
>> +               return rtw_usb_switch_mode_old(rtwdev);
>> +       else /* RTL8822CU, RTL8822BU */
>> +               return rtw_usb_switch_mode_new(rtwdev);
>>  }
> 
> 
> 


