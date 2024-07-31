Return-Path: <linux-wireless+bounces-10759-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AB61694348D
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 18:58:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF8A21C23A73
	for <lists+linux-wireless@lfdr.de>; Wed, 31 Jul 2024 16:58:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A52B934CDE;
	Wed, 31 Jul 2024 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fR6W1XDH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7BA612B93
	for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 16:58:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722445108; cv=none; b=j5b2zpt7DGKhtLQXpIO6J4gXn9Qp14XU6jdBC6sguU+zuLrrEl2OFLCcYUoFm0ff/XOV9thMSakc2T9HhCuTmUTPEzEkQtJ/2hElOywxiXu0LKmdYpcsrb5J/3JypM5vKpaTSeXDgd66CmZn4y1RfPYTg3ptItNNjpIZtlhueV4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722445108; c=relaxed/simple;
	bh=GNfHDc8RvSoXeee1TZx6e4RQx2X78IpzTQh9invsXIg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=mXa+kYY5tw4CpRDPq7yD3aUON3RHg1UMS48z9oPVRx5fLSd3ANTpwXxY59ppssyPikAtmmWh++hbRYOYrsZ3XC+qW4eBCXUMHSuY/nuZTiIZ2Cg/kTcvnHS56uVO98dziCHfgis7daSWY44soSfy+b3vz3qjLUjvJ1HBjHbOPcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fR6W1XDH; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-5af6a1afa63so6405834a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 31 Jul 2024 09:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1722445104; x=1723049904; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=9Ms5SpcWI2npDSdAaEsj0yu4OvFyJZuVX5mxy8yfWmQ=;
        b=fR6W1XDHBIbOib9CQAxwM/PUObcboq/VjQz1zLNHxYFCNuHGUlGaEYL9E2l2e1bDmP
         nAOu+/lURdsNy4AGc6CX8pp89oDJD/AkLfgr3ntJQUdd4LrmkcLG40WHzxf6dYmp801w
         WAIL59VysjBESHTbZK0J1fD9y4ETm62xtry4EoPSK77e2UeaQCQxx7lvEuyhEzr8DWbm
         WlmKlBtgavyWNKBUVnVnCDBQ8MB7ppIwI0qn6XAUyxH7wT8VAl5QcEr0PSVuZYExFQXP
         LdYsH5+14FFHMwu9VYNn35XaehfQdF+0a3ObxMslVX8IYTFkTDE5jAU6Hj4DElLWcgZs
         sucw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722445104; x=1723049904;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9Ms5SpcWI2npDSdAaEsj0yu4OvFyJZuVX5mxy8yfWmQ=;
        b=OFWi1dwpu4pkYsTDYWcIdM6n5sq1vVUHQ4PM6G179vq2P0OgFHcUISGWKDbjdJ6SXN
         le9G+47YnBEcx9itbR9CRKOpcMeKbX7deH6m2buLX+ujnuaYpYxDe8aoDUfDo3MV0Wkn
         vOMHuF7Ct+eQEg+ob8eHc6BG6w/Iz8iqmrwwMUnrMXFHNinJhRryCWR7pozL9RrtDmjb
         fKdBXxHygsPS2EJL9NxUFV+JFrvGg8f2xTjD9RbertqXKCkq/S4D/TVDeg27N5x6ElXm
         kYW1r6EOqZXueWjghSacO3qpvSmDCOIcQcGkcTIZcVfYSDiVmWXBH4zS04eZxJLm8+PC
         kNtg==
X-Gm-Message-State: AOJu0YzAtmgDJXBQaw67ukq2VjIqlTJFyUa2rC9ToxyZww+IVqERT6YL
	Q7513E+bAVyf2J7Sn1xn8f5LVi886kfDx02Enbn4uyguaedSAMJqbgMpSw==
X-Google-Smtp-Source: AGHT+IFy4FXWn4pBChYnedbV7uCu+5USF/zA9Kqdjudx5n0tP1nvfL7re1g9m+T7wXMc7zx330T8EQ==
X-Received: by 2002:a05:6402:1e93:b0:57d:5c96:72aa with SMTP id 4fb4d7f45d1cf-5b01d84addcmr10783574a12.0.1722445104178;
        Wed, 31 Jul 2024 09:58:24 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5ac631b033fsm8953541a12.1.2024.07.31.09.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 Jul 2024 09:58:23 -0700 (PDT)
Message-ID: <94e7ec04-94f2-4e7c-ae7f-81027ae11484@gmail.com>
Date: Wed, 31 Jul 2024 19:58:21 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH 3/4] wifi: rtw88: usb: Support RX aggregation
To: Sascha Hauer <sha@pengutronix.de>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Ping-Ke Shih <pkshih@realtek.com>
References: <c03390ce-34c2-42dd-9bd6-b231bb1f2fae@gmail.com>
 <a549707a-09f4-4787-8111-65cc266675d6@gmail.com>
 <ZqiKuUI_9Pk4ktXk@pengutronix.de>
Content-Language: en-US
In-Reply-To: <ZqiKuUI_9Pk4ktXk@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 30/07/2024 09:39, Sascha Hauer wrote:
> On Sun, Jul 28, 2024 at 10:42:32PM +0300, Bitterblue Smith wrote:
>> The chips can be configured to aggregate several frames into a single
>> USB transfer. Modify rtw_usb_rx_handler() to support this case.
>>
>> RX aggregation improves the RX speed on certain ARM systems, like the
>> NanoPi NEO Core2.
>>
>> Currently none of the chips are configured to aggregate frames.
>>
>> Tested with RTL8811CU and RTL8723DU.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  drivers/net/wireless/realtek/rtw88/usb.c | 57 +++++++++++++++---------
>>  1 file changed, 37 insertions(+), 20 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
>> index 73948078068f..d61be1029a7b 100644
>> --- a/drivers/net/wireless/realtek/rtw88/usb.c
>> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
>> @@ -546,11 +546,12 @@ static void rtw_usb_rx_handler(struct work_struct *work)
>>  	struct rtw_usb *rtwusb = container_of(work, struct rtw_usb, rx_work);
>>  	struct rtw_dev *rtwdev = rtwusb->rtwdev;
>>  	const struct rtw_chip_info *chip = rtwdev->chip;
>> -	struct rtw_rx_pkt_stat pkt_stat;
>> +	u32 pkt_desc_sz = chip->rx_pkt_desc_sz;
>>  	struct ieee80211_rx_status rx_status;
>> +	u32 pkt_offset, next_pkt, urb_len;
>> +	struct rtw_rx_pkt_stat pkt_stat;
>> +	struct sk_buff *next_skb = NULL;
>>  	struct sk_buff *skb;
>> -	u32 pkt_desc_sz = chip->rx_pkt_desc_sz;
>> -	u32 pkt_offset;
>>  	u8 *rx_desc;
>>  	int limit;
>>  
>> @@ -559,29 +560,44 @@ static void rtw_usb_rx_handler(struct work_struct *work)
>>  		if (!skb)
>>  			break;
>>  
>> -		rx_desc = skb->data;
>> -		chip->ops->query_rx_desc(rtwdev, rx_desc, &pkt_stat,
>> -					 &rx_status);
>> -		pkt_offset = pkt_desc_sz + pkt_stat.drv_info_sz +
>> -			     pkt_stat.shift;
>> -
>> -		if (pkt_stat.is_c2h) {
>> -			skb_put(skb, pkt_stat.pkt_len + pkt_offset);
>> -			rtw_fw_c2h_cmd_rx_irqsafe(rtwdev, pkt_offset, skb);
>> -			continue;
>> -		}
>> -
>>  		if (skb_queue_len(&rtwusb->rx_queue) >= RTW_USB_MAX_RXQ_LEN) {
>>  			dev_dbg_ratelimited(rtwdev->dev, "failed to get rx_queue, overflow\n");
>>  			dev_kfree_skb_any(skb);
>>  			continue;
>>  		}
>>  
>> -		skb_put(skb, pkt_stat.pkt_len);
>> -		skb_reserve(skb, pkt_offset);
>> -		rtw_rx_stats(rtwdev, pkt_stat.vif, skb);
>> -		memcpy(skb->cb, &rx_status, sizeof(rx_status));
>> -		ieee80211_rx_irqsafe(rtwdev->hw, skb);
>> +		urb_len = skb->len;
>> +
>> +		do {
>> +			rx_desc = skb->data;
>> +			chip->ops->query_rx_desc(rtwdev, rx_desc, &pkt_stat,
>> +						 &rx_status);
>> +			pkt_offset = pkt_desc_sz + pkt_stat.drv_info_sz +
>> +				     pkt_stat.shift;
>> +
>> +			next_pkt = round_up(pkt_stat.pkt_len + pkt_offset, 8);
>> +
>> +			if (urb_len >= next_pkt + pkt_desc_sz)
>> +				next_skb = skb_clone(skb, GFP_KERNEL);
> 
> You could add a:
> 			else
> 				next_skb = NULL;
> 
> here and drop the next_skb = NULL from the end of the loop. No
> functional change, but easier to read.
> 
>> +
>> +			if (pkt_stat.is_c2h) {
>> +				skb_trim(skb, pkt_stat.pkt_len + pkt_offset);
>> +				rtw_fw_c2h_cmd_rx_irqsafe(rtwdev, pkt_offset, skb);
>> +			} else {
>> +				skb_pull(skb, pkt_offset);
>> +				skb_trim(skb, pkt_stat.pkt_len);
>> +				rtw_rx_stats(rtwdev, pkt_stat.vif, skb);
>> +				memcpy(skb->cb, &rx_status, sizeof(rx_status));
>> +				ieee80211_rx_irqsafe(rtwdev->hw, skb);
>> +			}
>> +
>> +			skb = next_skb;
>> +			if (skb)
>> +				skb_pull(next_skb, next_pkt);
> 
> You could use skb instead of next_skb here. Both are the same, so no
> functional change, just makes it a bit easier to read when you use the
> same variable that you just tested for validity.
> 
>> +
>> +			urb_len -= next_pkt;
>> +			next_skb = NULL;
>> +		} while (skb && urb_len >= pkt_desc_sz);
> 
> You can drop the urb_len >= pkt_desc_sz check. It will be exactly true
> when skb is non NULL as well.
> 
> Sascha
> 

That all sounds correct, thank you.

