Return-Path: <linux-wireless+bounces-26654-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BF51B370A4
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 18:39:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F09917DFA9
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Aug 2025 16:39:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 254FE2D1F72;
	Tue, 26 Aug 2025 16:38:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCYe+u1q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F6531A578
	for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 16:38:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756226321; cv=none; b=aDmFGJXAQVUzP/NY6cByli2zuLscX1za9JBuCKWV01btzxWDS4thyFHhQxjdlf5gSbLgCto8t5+BJVyctcfbbhAqxhSAQKL6jcSiBQ72N6uPFiQ9Vty1o1LvLUEmo/8RkEGbOcCDmzegfFfdoICX/+c5DP1QQRhPNedaIyJcNoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756226321; c=relaxed/simple;
	bh=L+xoK2PJecbnNWKj4Lfk2DjxrPVGXAKzyeZz2tlkoh4=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=u2/WsMXkNFqD+/2HqI9Tje0IPbwISwXdz1cEBCDGooYBj6A52PSZ8uTtKnyNid4qgyzIo9xzFd+A0X4J8aXBuaSQ+D7BacEl9sdfhSX4r0FaOu3CgzjiUfemU8P9EMmf/HlxJbRRbJoB411NwFu2Tu7fcZyfsRmuvsGrD+L2cA4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCYe+u1q; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-3c7edd71bbfso3146869f8f.0
        for <linux-wireless@vger.kernel.org>; Tue, 26 Aug 2025 09:38:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756226318; x=1756831118; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=VwpHDjTylI9V8p0qKMa+tVz57PA/udqM2gso1kls55g=;
        b=mCYe+u1qjqfPU5rYyZu6WvTCgTmYBAXJNCkBYatBW2j0so0iaraVSwiyQzDe6b6uyC
         v+0JSc9+0Cyd6AmXLMsqFzYZvOmDSjtu2QQmNmoDDZYS8bqj0sxaQeb7ae+SLvjiCp6T
         jx5Q7pmrZ5h7Xi+1bKSN374WP4g5UJazVX2+jqaxZSIc9dHQh4zgssNzn/ehpbTJbFEb
         FN3oAJ8DzsGdX8k3vsfUeD7OFHRMRnQ9d4OVAvaRJy99kHL7l15+U6klUei7aBQw7hEI
         HpRq3LvKhyv/BfSjwI6RLWreTmmYCyVKMfAjIlDq3lztS1LK7EGzCQOUTdGHZfAHBd1j
         q4rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756226318; x=1756831118;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VwpHDjTylI9V8p0qKMa+tVz57PA/udqM2gso1kls55g=;
        b=tMAAX4cthKqlkQzT+oZpJ6kId3WF3S0FZwD8W/dvgGj/lWUyD4VdYfwlqqMCJmz5OQ
         xah4XHOG5d4fKFPFqebiPjrYbGAXmlJalzWJHsEe2IW15H6yJ+mzBAvOq+rfZnp6yV/4
         L/FILeCZcMkvKvSQYQW2pAbi9nkcSmbUfYcABMgEPgPwuGhFxOLJp5yv4Nj7f8J+BdUN
         /7rv8nTAKfD4ORr9Ajvx4Xf+IpAlbLpiyLCOb/8celrtl8Wjkrfvp6WyNkPjl0tqcdIV
         ZFCfcWHpz1BdZQD6WA6wCXKU7Fi4+aGw2o0iJxppkMuLGNpFwBXeLTnBCgyuHjCmWK1S
         YNMA==
X-Forwarded-Encrypted: i=1; AJvYcCV70xazuuqrq4MjkZvr4hTXekvTxSWidUqqXFdhG9KLoPEg+ZS5kkB4LGMWUVDsmcJ/5QN19HbXCwnD3w0WPA==@vger.kernel.org
X-Gm-Message-State: AOJu0YwWR3vGh5zenUyyrdqHc7xk75h8Q7hoDi8oBzlS63KDWuw82knX
	f0qQto+xGQKfAbYHftA/MmFIhNBeb7MvnkYmutW4xG5j78dsm0w3hYk9M3kdUA==
X-Gm-Gg: ASbGnctqoqmOdfRQMB3omrmbrOZZH+alk5gxuvKTBfLuo5/2QgsYAcjEYgG3Jp4qEQB
	ah/7KwMWESOep5CEcvLfZRx1pTdFt4bfOErpklOWhN29itceh8G4/xgzrzc5IW9bELBC6ttTmjz
	tbc/dlcDjx+QOTVZgV3byPpR+Qmtfe3ECZm7THg0CMLwpENcDIQetN6Arbh8Q4X3Fbxh3wNcqSf
	ze99NV1vWHTcQxNBVXFkQUYi4T4Y+1+PphBlNp/GlLF0rOLQRoj7pdReA7KuCbNgO7HJFs5Rkhm
	LI+I7u8Flno+uvd5xExD48ZlLnfoZlC/fpPAl8QyLgFEWEuuZDolzVxNCi4rwhylOHcJDBhCBSp
	nx2Sf7ITBWSzDW2FFhjB0lXLQQp7yrA==
X-Google-Smtp-Source: AGHT+IGmpVaM7V9gp1CAjrI8uXyXgRKuIPrvyDHqomaUNl1CiLV1luyHwyVKXQPHsqsKMuulkAFDew==
X-Received: by 2002:a05:6000:2482:b0:3c8:d063:de6d with SMTP id ffacd0b85a97d-3c8d063e64emr7017734f8f.0.1756226317469;
        Tue, 26 Aug 2025 09:38:37 -0700 (PDT)
Received: from [192.168.1.50] ([81.196.40.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-45b6b1bb9fbsm2293865e9.1.2025.08.26.09.38.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Aug 2025 09:38:37 -0700 (PDT)
Message-ID: <19e4debd-589c-43b6-95ac-1b6e94ad8c90@gmail.com>
Date: Tue, 26 Aug 2025 19:38:35 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v2 01/11] wifi: rtw89: Fix
 rtw89_core_get_ch_dma() for RTL8852CU
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <f4a7a1c4-3d64-4af3-bc77-b12d7c1320e7@gmail.com>
 <5b1210f3-499d-44d8-9433-7beac2a2800d@gmail.com>
 <11f3e864-7509-4e5f-86ed-997f8a9b63e9@gmail.com>
 <4203c4ab09df4975be85e341f5e24264@realtek.com>
 <de899380-fe3c-4b9e-86cf-3677fb0b4f92@gmail.com>
 <3ae0e8e7efbc4b6189ce9416c3a890eb@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <3ae0e8e7efbc4b6189ce9416c3a890eb@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 26/08/2025 12:00, Ping-Ke Shih wrote:
>>>
>>> +static inline
>>> +u8 rtw89_chip_get_ch_dma(struct rtw89_dev *rtwdev, u8 qsel)
>>> +{
>>> +       const struct rtw89_chip_info *chip = rtwdev->chip;
>>> +
>>> +       return chip->ops->get_ch_dma(rtwdev, qsel);
>>> +}
>>> +
>>>  static inline
>>>  void rtw89_chip_mac_cfg_gnt(struct rtw89_dev *rtwdev,
>>>                             const struct rtw89_mac_ax_coex_gnt *gnt_cfg)
>>>
>>> Also the rtw89_core_get_ch_dma() is moved to core.c, and add
>>> rtw89_core_get_ch_dma_v1() for RTL8922DE.
>>>
>>> However, USB can use different mapping rule, so we should extend the size
>>> to RTW89_HCI_TYPE_NUM. Then,
>>>
>>>   return chip->ops->get_ch_dma[rtwdev->hci.type](rtwdev, qsel);
>>>
>>> If you want my patch as first patch of this patchset, I can share it as RFC.
>>>
>>
>> Yes, that would be good.
> 
> Finally, I decide to send a formal patch within patchset for coming WiFi 7 chip.
> "[PATCH rtw-next 09/10] wifi: rtw89: abstract getting function of DMA channel"
> 
> [1] https://lore.kernel.org/linux-wireless/20250826085339.28512-1-pkshih@realtek.com/T/#u
> 
> 

That's great, I will prepare v3 then.

