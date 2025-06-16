Return-Path: <linux-wireless+bounces-24160-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE1D3ADB768
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 18:55:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5959F165F24
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 16:55:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 11C3127E047;
	Mon, 16 Jun 2025 16:55:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N5f7BT+s"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702581F8676
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 16:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750092907; cv=none; b=JsbIslQ+afRAAD2rxlI0sTpJ96aQZ3062GNnPta8UdjDSz0SHlOsDa07+FbJK5X5Pq8fasRHwdJHZGcgkRdEc0VKs36rEEz6eBPK3QitsdUY2h8Ya599F9LTZw2NlE+eiZs9pb1W7lNKLs6uUQDKfJn6+Uc7pw+jN5NHvuCzPx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750092907; c=relaxed/simple;
	bh=ZqqHHQlNtUO3wEwpfvtwbHHBnxpTVa7aV+UOm82y40A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=KD1DnG+++SLKR5W6wgQssByQ/060L/7eTo2k1yq/B2m+KjYWH1lSkt/zSxeBazk7ayGzXzEPpYpCDyPGtWDrhmV0MzUcxr2HAVEs983Tvc2YHz2wI3MS02S5OFWZTVmYqrT+q8BCLtU/xjlyVUemA48kOZp2xW1BjLRkDP26Jyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N5f7BT+s; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-442fda876a6so42419595e9.0
        for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 09:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1750092904; x=1750697704; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zNuaCaTkXiItuRjhrXpf5B21HF4gq4xFsQPB5shQWaY=;
        b=N5f7BT+sF8OOaQPX+CJPlOt9/0URgZiKvbrjZysttbazRDRHqfnK+YzsxVEIXtsIUF
         oF02DZ0DmwaSHJZSB20LZEAHPrs3c69PYNLOXc5Y0O6t30Ui0wvxb79eAHLC9kKZ2cG+
         8Zfu+OTd1EMe5hHAINmUKgBT1h2ofC0GmJPnlm6v129riI0ptxbH0TwdJo+ivnO4vph+
         ZB8WlhUd8mU7H5ChIdnS2qmdNvaXQ+TgVC4uVWkvZBw8dnUIOhAqq4VGWoPRO9S9wwi3
         0KvUlEAdZAHQvjooS+XfEJGrfZUcUSHZC/3K+iQJ1M0v+QZYiHnmFJ5Ing6PSPjq/Lfc
         c3aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1750092904; x=1750697704;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zNuaCaTkXiItuRjhrXpf5B21HF4gq4xFsQPB5shQWaY=;
        b=sYDQyixUKsRBvcIUsAYiEf2LX5Afd+e25N7yx7HKQjVcg2Yf5lkvybOi9V0d72En15
         u/f93XOCWoZlWsddzD0idu7WAAang88rSzk6c6clRuMl03+I+bnznkTkbukKUTgfIPp+
         PxjbF5w7NjyDkzWUcS29YnJ2854EvnpXo42jaCBpSvb6vRZhTCn/PFh88oHz0gjAmSza
         cd8r7zItREPR6pbQe/YEdPxJ5cmF1seirn8j/hiRVxmobOXTTj4oz9yk8FyKySlOcszl
         SRDrfVBICRnLb/By9FRuo8pTjlsmb7P1EPZpiusDW8St5WMmvMDFyDpQK77W54d9IQwF
         Frog==
X-Forwarded-Encrypted: i=1; AJvYcCXRY1SvXj9zag7ThT1qTNGMTIfOwolZDyR5rCMcvMqKsfqWMZOO2/cMbS1Trggbs8F/LJ7hCz56iZAJ1Q7oiw==@vger.kernel.org
X-Gm-Message-State: AOJu0YxzJ9oHY0BWemOKREL0Y5J9RrR1SG/G0tQsXGtJ3JQGvWEwWTPx
	biheJEM/9p5qoQNIqtUZYpSxvx2Xi9hPQ7g4tkxecoNuFabnKJ3GHp0JehI3yg==
X-Gm-Gg: ASbGnctNETjG4KQQWjPEIfS+ZCct+ynuqqz5kheUKZBWOWhBbcxdpMjIAXOi66k1v9X
	48iegmp2Aq5nwo36URk+Ll6/xOa+dnCxulMuQILXUQd/N0Np8DkeKS/E+spw3IqSq4kuocqwz+6
	s20KB8K+CmmCJRXHJxKhI/9mOwi+46RK0Al+haOeAzC/p7kYT8fNYhy/PnSRQEnzdt2oxtixSKs
	5YuDFcXHWY1iZWMT/zf2WhCxEZUNcFln/Jcn+Cx0cT5olNpz9HKvRx3NP0M4LpzCx47Uzyyf0li
	N5cymd39w2XeJM/7TQW0jQ+BKpGgpcF3BmSTh+2UoVU1QnzqX6VlhL5gIK0/nGy9mZ87aat6Ttu
	ucVNn
X-Google-Smtp-Source: AGHT+IFaxl5zVTU2ntc+ZQF1K6n/5/Q/h5MK5OMTzJklwEwJBT7mIwBNv3BerC4/MykdnGGgeeANsw==
X-Received: by 2002:a05:600c:3587:b0:43c:fda5:41e9 with SMTP id 5b1f17b1804b1-4533cad1aa0mr103890055e9.31.1750092903497;
        Mon, 16 Jun 2025 09:55:03 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4532e13c192sm150584355e9.26.2025.06.16.09.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jun 2025 09:55:03 -0700 (PDT)
Message-ID: <90b1df9c-4cd1-41e5-8d39-d4d9e70ac4d5@gmail.com>
Date: Mon, 16 Jun 2025 19:55:01 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v2 03/14] wifi: rtw89: Make hfc_param_ini in
 rtw89_chip_info an array
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
 <7e05e8a7-d7cd-4cc2-87c5-143ba30e8c54@gmail.com>
 <646f0e43faad458493a3f060e623232d@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <646f0e43faad458493a3f060e623232d@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/06/2025 04:26, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> USB and SDIO will need different sets of values, so make hfc_param_ini
>> in struct rtw89_chip_info an array.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> [...]
> 
> 
>> diff --git a/drivers/net/wireless/realtek/rtw89/mac.c b/drivers/net/wireless/realtek/rtw89/mac.c
>> index 2ee766e37322..0a3603f2e6bf 100644
>> --- a/drivers/net/wireless/realtek/rtw89/mac.c
>> +++ b/drivers/net/wireless/realtek/rtw89/mac.c
>> @@ -881,13 +881,14 @@ static int hfc_reset_param(struct rtw89_dev *rtwdev)
> 
> By the way, please help to remove the initializer of param_ini, which is weird
> and unnecessary:
> 
>    struct rtw89_hfc_param_ini param_ini = {NULL};
> 
>>
>>         switch (rtwdev->hci.type) {
>>         case RTW89_HCI_TYPE_PCIE:
>> -               param_ini = rtwdev->chip->hfc_param_ini[qta_mode];
>> -               param->en = 0;
>>                 break;
>>         default:
>>                 return -EINVAL;
>>         }
>>
>> +       param_ini = rtwdev->chip->hfc_param_ini[rtwdev->hci.type][qta_mode];
> 
> Like patch 02/14, we can remove switch...case above, and check 
> rtwdev->chip->hfc_param_ini[rtwdev->hci.type] to know if we can support
> certain HCI, like
> 
> param_inis = rtwdev->chip->hfc_param_ini[rtwdev->hci.type];
> if (!param_inis)
>     return -EINVAL;
> 
> param_ini = param_inis[qta_mode];
> 
> 

That reminds me, why make a copy? param_ini could be a pointer instead.

>> +       param->en = 0;
>> +
>>         if (param_ini.pub_cfg)
>>                 param->pub_cfg = *param_ini.pub_cfg;
>>
> 
> 



