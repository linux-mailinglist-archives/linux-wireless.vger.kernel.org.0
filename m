Return-Path: <linux-wireless+bounces-11103-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BC9494B11B
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 22:17:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0C18B28111F
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 20:17:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8CEA18286A;
	Wed,  7 Aug 2024 20:17:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OCvN1uOi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com [209.85.218.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCAA2B9C6
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 20:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061842; cv=none; b=q4uvxfZGXCA5kVBhA1lUHqUtOnLExlLsily7OxxBSRPxvKADFbjRndOEzDPhSiUFwQtwFXCqqaDbbHbsQczZsUfU/b7TIoPZKQ2S/Xa77KA+8vmcYxYWUUtQxhYxOHNhLXzv6ihKaX2BZmzjn58MGgeur25lMtDJVk5TVIT41sA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061842; c=relaxed/simple;
	bh=UuZ2f6IWHZQHV7yV7aYk9fIupZa52Zt6pmXyUDYP6JA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=r6lll18Zq7wMGY26ZSjHtUqv3uw8/bNVRAKGgudaSlTtJhy4JkEGQCbKCm51zNHxZGJ4KJNJFPBW97+9EUcp1embAx8ZIphuRphFj7a9tT6Rl0rlHLXHYPTj/B2NPNah7jVRnuuHj1wYcYDAs/VZLZgB744Ix/Mnt4m0H0pTS4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OCvN1uOi; arc=none smtp.client-ip=209.85.218.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f42.google.com with SMTP id a640c23a62f3a-a7ad02501c3so27428466b.2
        for <linux-wireless@vger.kernel.org>; Wed, 07 Aug 2024 13:17:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1723061839; x=1723666639; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DDFXcM0AQln08y/HqaDv9i1t4wfrxc5yWfl2VQERkQ4=;
        b=OCvN1uOinK81ySGDn/UbN1TJ+NNQdWLlyQGfqyOpoSAokw2aopiKkh0h1WVfwwcEmd
         ZLfhlpnx1DPik9ZUev5iigTO9km3zySI9bYnDxvFYdBKAlPLI/L/lMsTdnGfRt1pYhvp
         QMudMBmSHpK5Izufk33W2/QnaeQ9Xb4XPzCj8W1q2GsykF8e4rEVAMZf2d6z163V/zki
         zEI/F+h3E1tZet+L8kA23Azv7ra8J6JTOy5Xp45udvpMH9y7RqDSrTiaWe6rgA65RES+
         Wd78wnDfYmLzkX5CWhVQuuYHkTGViILdT9fiyrMBwUCQwL41FsC98kQiuo1I6zCJAGWD
         jMKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723061839; x=1723666639;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DDFXcM0AQln08y/HqaDv9i1t4wfrxc5yWfl2VQERkQ4=;
        b=tNkpUT/DjnaTS06rIjJKrDFTFxMnxH5shAy57mUDciPYP1YF4B3KGGE9cjQsMUO1Ef
         3/z+kszc3p/Lu89QcwxAttcPCEXbqBuenwM9lVp0FRqUWjZAVYxM89K3L428Gds6cOPL
         MgD2ZLW+zztn5PINrX5zUvmXW2/OaKo6T4Q9JbGWsNNCC7CP1wb8FcQj5er2actsG8BH
         NmCNoJD6/gowfdgalwisn89GY7pyFs4Bu2hv0kgZ4epQ5yAHxWEGFiXgKUdcYbz15J8+
         cynXuRZqlgJt4I08QJG5eHKqUE1dWyDsYafix1mTpJUISMlOsir+RFJY9V3VTlMqUIXW
         KuSg==
X-Forwarded-Encrypted: i=1; AJvYcCX/8d78UHxKPYvnBXYScw0BEkLnX/Lv8krZTSi+7MzY0megAu4l9BBCbVMT7wbOfkjzp5yhCFfEtfH/H1C14IVTkdl7N6oJFp2Wr7fiFjY=
X-Gm-Message-State: AOJu0YzspvI56rXDATjMWfWQVApj4Ipf2pDlMc3vMli9evWDy5/uPrck
	mg3AJhQR4tg5zhZeK+9zPNdC5WsnCpoQpJ25YflAAs9MeANQn98U
X-Google-Smtp-Source: AGHT+IFqmilCxuVIz8T186lJGWJ8QDI2oCgrPSxeY3/wCi4LeERf4O2NyFnegPs4r7HJn3WYSiKvRA==
X-Received: by 2002:a17:907:6ea3:b0:a7a:a4be:2f95 with SMTP id a640c23a62f3a-a7dc4fdf818mr1415659966b.5.1723061838745;
        Wed, 07 Aug 2024 13:17:18 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9c0c557sm666092066b.53.2024.08.07.13.17.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Aug 2024 13:17:18 -0700 (PDT)
Message-ID: <0ff637e5-1d85-4e3a-a105-e41cd5be4172@gmail.com>
Date: Wed, 7 Aug 2024 23:17:14 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/4] wifi: rtw88: Enable USB RX aggregation for
 8822c/8822b/8821c
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Sascha Hauer <sha@pengutronix.de>
References: <acc5ccc7-e573-472f-96d2-582716046aa6@gmail.com>
 <3b7b3655-9ec5-4277-b0ff-5535b1fdf281@gmail.com>
 <8218e3aeb62b463d9562ae02213e29ee@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <8218e3aeb62b463d9562ae02213e29ee@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 07/08/2024 03:37, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> @@ -236,13 +237,17 @@ static void rtw_watch_dog_work(struct work_struct *work)
>>         else
>>                 ps_active = false;
>>
>> -       ewma_tp_add(&stats->tx_ewma_tp,
>> -                   (u32)(stats->tx_unicast >> RTW_TP_SHIFT));
>> -       ewma_tp_add(&stats->rx_ewma_tp,
>> -                   (u32)(stats->rx_unicast >> RTW_TP_SHIFT));
>> +       tx_unicast_mbps = stats->tx_unicast >> RTW_TP_SHIFT;
>> +       rx_unicast_mbps = stats->rx_unicast >> RTW_TP_SHIFT;
>> +
>> +       ewma_tp_add(&stats->tx_ewma_tp, tx_unicast_mbps);
>> +       ewma_tp_add(&stats->rx_ewma_tp, rx_unicast_mbps);
>>         stats->tx_throughput = ewma_tp_read(&stats->tx_ewma_tp);
>>         stats->rx_throughput = ewma_tp_read(&stats->rx_ewma_tp);
>>
>> +       rtw_hci_dynamic_rx_agg(rtwdev,
>> +                              tx_unicast_mbps >= 1 || rx_unicast_mbps >= 1);
>> +
> 
> Not sure if you have tried RTL8822CU with this dynamic_rx_agg? 
> I suspect RTL8822CU can't access IO before rtw_leave_lps(), at least RTL8822CE can't.
> Let's move rtw_hci_dynamic_rx_agg() right after rtw_phy_dynamic_mechanism() below.
> 
> Sorry to forget this point on v2 review. 
> 
>>         /* reset tx/rx statictics */
>>         stats->tx_unicast = 0;
>>         stats->rx_unicast = 0;
> 
> 
> 

I received RTL8822CU (LM842) two days ago and tested these
patches with it, but I was too lazy to update the commit
messages. I didn't notice any problems. The RX speed measured
with iperf3 before was ~200 Mbps, after it's ~300 Mbps on my
x86_64 laptop.

I will move the function call.

