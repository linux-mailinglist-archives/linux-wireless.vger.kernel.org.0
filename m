Return-Path: <linux-wireless+bounces-11715-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id F38649590F5
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 01:15:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 56519B21A63
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 23:15:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 41FD21E86E;
	Tue, 20 Aug 2024 23:15:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="miZGLx0q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F553107A0
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 23:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724195745; cv=none; b=BczfjT3Q0XjOG0UyVlzUuHWWvNR/ILOg4FWiaKmaKFiEOkLs+HFsM119+hEg6c7vAqIkA0cJCMQJhVomcdSA5X0/kWPQk7g3IA5fUhRsq7f1x062YsrmbsEC/eOsDFA0eHaRMkgXYfuGA0mvMJozf0Ownjy2LO6+TxEeiMtkYzk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724195745; c=relaxed/simple;
	bh=Qrrwpb7t0tQS5gvx0SWzT2RiMFzDe5hOSHiMF0Tti1I=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=K87PkqQyJbPgOGqeTIqjpUGsX6pXgMSjwW8Vz9kDD1aiET4oEK8Y4g0i/Q30sPoes9hQfc5gqgYj8+bXpmORWt7mBJbj2lS+NlFM+QWuStXatYJTZi75fSsbi1l1J6r1iADNbv4y51HdYZHsv6WHfNCF86zAPmLfgh9hlDHOyFQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=miZGLx0q; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-a7d26c2297eso696865066b.2
        for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 16:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724195741; x=1724800541; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yxRKaNNkg8Y2u8EPYsViDaa3XX2+h5Qdakgju7O2rF4=;
        b=miZGLx0qmLZ/CH8DXTK931ZAfmI6D3trWhzu0awk+ukltlqSgkS9VgG4Rm49WVCP4C
         iwydrHJR1rWCFlm/m4nR3m/UwOmncpZNGBBvWVHlFTDeMJWkLUB7p8OkLbU1XznwvUre
         3SSU1OeeFstBPDneMhewjrEpUMHpVj6sYEgc/GhspTnwaEbsC/u8+Z+KIAXfcwdU/mN7
         zSwmdUvGLC1FyHmdzCq7qIHPkhakWbWanGDFWPJJtZZMYA8L4QYsMnf/7Nx8cFIKiHU4
         FfEDwtTiAjWibxqyf4lUa5+orI9FARDFZnq1LBwSaqoby1UPH4bEsJaRi4v8ty/wxecv
         demw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724195741; x=1724800541;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yxRKaNNkg8Y2u8EPYsViDaa3XX2+h5Qdakgju7O2rF4=;
        b=uNbM+FunO90XLZjXT0Fdujmpb8jNkSZJ/34igCu7IiH9E8AX3B7cYavV0UWO5VLrWR
         I/1MSAXUJk0eG7FYN9wlZBlUmLD00ggsk3I5diwVeSRQDg/WGdFvVwR4TFm1o6tud3YP
         SVFn7N+l7YXhHa0Ra/vGDoA5CiycND2iVuqsXa0ov4nwGwNwZqSap+5E6C73TbOsOfat
         mK59tDIQ0Z/OdNOcn0DRAmfurKHjNhosx5oyjb1gDDomk7vkWSMOePDxPOFypeD5wp1l
         PSLyu8XyfikWT8/FF8nRY7ghudlaj5nIcJ2ZXjir3gI2Tc6LowZ+VRy/+VHg31czbLAm
         eArw==
X-Forwarded-Encrypted: i=1; AJvYcCUMb45LbsmkV5GSiZEcPjrcAfuax7+VSk4vAj4sUhjrlnlQltq3kg6XHX78i/QDOAGGGMGD/lEPNitejFB9dg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwCCMzZGtboeFNwL+Mn62DLEo4b9UHBlE3OcxZ39GICiYVf5RLt
	R00isD3tGJpejBWJH7ix0EfxsWjoIgORDbJxHsM5mkDzwez3bX8b
X-Google-Smtp-Source: AGHT+IG6e9HYpJWTDndHBeYy5tSnf8WdRJ3eT/hcemMSJdEV50RAYS1eMTtdkmytGdTCjlNP8oQpPg==
X-Received: by 2002:a17:907:3ea1:b0:a80:f358:5d55 with SMTP id a640c23a62f3a-a866f3429bbmr31109566b.33.1724195741056;
        Tue, 20 Aug 2024 16:15:41 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a838394652dsm823994366b.149.2024.08.20.16.15.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Aug 2024 16:15:40 -0700 (PDT)
Message-ID: <c7d69a0c-ee74-4186-8d71-526be0d7ef9d@gmail.com>
Date: Wed, 21 Aug 2024 02:15:38 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] wifi: rtw88: Avoid using macid 0 in AP mode
To: Ping-Ke Shih <pkshih@realtek.com>,
 "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>
Cc: Sascha Hauer <sha@pengutronix.de>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <9174a776-4771-4351-85fa-476e240d8ace@gmail.com>
 <e4be0a75-43b2-4ae5-9aab-5c4a88e78097@gmail.com>
 <9356af89520243ccacc0be72b8b03252@realtek.com>
 <4f052989-5fb9-4c5c-950e-a3d34e6499ab@gmail.com>
 <d21bc7a0fac8413b9cc443288924ec7b@realtek.com>
 <91d03fa7-5af0-4ec5-a52c-c2c060e11d4d@gmail.com>
 <6d1667d2-c86f-4b80-bb32-9ba01164480b@maciej.szmigiero.name>
 <e8d3c81a47de44e1ba7df08b9de826ee@realtek.com>
 <1377b2e9-4da2-45cb-86f5-5b80fe5ab025@maciej.szmigiero.name>
 <3e2d32e473204471af1814aa2ce26bcb@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <3e2d32e473204471af1814aa2ce26bcb@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 20/08/2024 03:34, Ping-Ke Shih wrote:
> Hi Bitterblue,
> 
> Maciej S. Szmigiero <mail@maciej.szmigiero.name> wrote:
>> I tested these patches on USB RTL8821CU and can confirm that the AP mode seems to
>> work as good with your patch [2] as it did with the Bitterblue's one.
>>
>> The only issue with either your or Bitterblue's patches is that I occasionally get the
>> following messages in the kernel log in the AP mode:
>>> kernel: [T1234] rtw_8821cu 4-1.2:1.2: error beacon valid
>>> kernel: [T1234] rtw_8821cu 4-1.2:1.2: failed to download drv rsvd page
>>> kernel: [T1234] rtw_8821cu 4-1.2:1.2: failed to download beacon
>>
>> Around the time these messages are logged ping RTT of a connected (battery powered)
>> STA climbs into multiple seconds range so I guess there might be something wrong
>> with beacon DTIM update here.
> 
> Can you also see this in your side? It seems like download beacon for change of DTIM
> might be failed occasionally. 
> 
> Ping-Ke
> 

Yes, I have seen it with RTL8812AU. It only fails sometimes.
I don't know what is wrong.

