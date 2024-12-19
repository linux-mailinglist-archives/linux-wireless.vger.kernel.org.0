Return-Path: <linux-wireless+bounces-16591-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A89909F7A1E
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 12:15:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A27301893DD6
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 11:15:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50802223708;
	Thu, 19 Dec 2024 11:15:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C5FFNSn7"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com [209.85.218.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D0B2223702
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 11:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734606921; cv=none; b=n/A4fthNfM153Vz5BUGMdsiWVwjPfo6LKPGsRjaIl//PycjYDwXfRLxTVM4vna+PzyyO5sFIAhWGcM7aJX7eQHcnIrdYTQupUE0JybCJY6WTSai8/1+gOFQv3apP/4bwXBAzbVPdFvFj42KuqzVA7SuADpS1+ktkhXZMsA6WKOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734606921; c=relaxed/simple;
	bh=CqHdHsRTuntbYGss6CdjvxO0E+FgZooQFSVjXw1wphc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=hyQgNm5Ct8SF36smMn8NCXO0AGe09w0+Wx1EwWaYpbcdP8aOuVjubhcAwTQ/CX+sUg2WrE5oa3SGd4+Q7tkn7TUN1fJ7or99LIGBDTg9LwHb9ZCZy5V6vWqwipHhokQ50ygVY3GsN4BvNhGHaobcs5hJdTB0MZLxz5Bu3rsPqPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C5FFNSn7; arc=none smtp.client-ip=209.85.218.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-aa684b6d9c7so112067666b.2
        for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 03:15:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734606917; x=1735211717; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0DXNoogNf2Ix9nVFg89988iaDxnUYUjNYIk6pp6AUVc=;
        b=C5FFNSn7UrA9sYSVb3briuCjcPY2jEhsEpIG1N8AyRAs/k0BzeYmc0p9YRRRibs64z
         3YmU0D/OJnQGSY392dD5GjKbKldGB5a7G5fc7aUl2/s0dBFSX8aNM1COXOj21Ze/6Zax
         ZHov4HBNOumvvkL8NIe9i05c0Yg7YmMviyJV5tGjranio/aE2j069mCuNTYLiM2EO0oK
         Mkr1yLmunK6kxkByJ5abN91F2Qjx140rDWA2Nk//GsbWjNet8DXsc91enVcS1Mftvtal
         fAO+gXDIK42DUQ+yYqFwDEv5igLJSaW1yeNt7qVo24RWYBri3G7hLl1mCiFl1LldBMaa
         xpGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734606917; x=1735211717;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0DXNoogNf2Ix9nVFg89988iaDxnUYUjNYIk6pp6AUVc=;
        b=CwzLq7mxGA94zz1hRZdcimChHEUdYQkyERGPbQxAg+uMhxqZrpWUaMP5fevTfIVHhu
         2TfK7B2p5B2GrvjfQY3Gk7lRGDeAJFYUWftF6Mbt188F9sglMV+d8vQH6OzEzOMLzygE
         3plwwBNXFw5HafS7TEuELXeLL+FzSR97qMV8ZuZRy+hSHSWw2U8fUpy9b7KP76B9oPXZ
         jBdyCDTKvjpTPfeSyZ0ZqUrvuY3/oatcq2/7LaMrZByaIHUl1iVuobudqjXJ2g0cioEh
         lGsagHtRldCN5u87K98ibVlFhHWhTYdS/9x6QhZwXCrch+3Q4v9CfSxb8wDBlJxiMueK
         CoXw==
X-Forwarded-Encrypted: i=1; AJvYcCWOEjAUgZzvML+YRaDE713UmgjNrlabLJeonBgMIaMdCSdV/sgo4ulbNR++E5QvphfV3EdQ58UcIa9dPJm0rQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwafkF6vS6qS6c+Jz8sKZ7WZdUOtMuyPqz/TlKM9DPIY/fuy6+u
	zMBSyViRzGbAqugQ6yyzycZROsyAn6ylF26iYQl8wu8xomaEFYmh
X-Gm-Gg: ASbGncsjWFdaqIpGdAOVHr22Q7N9kdgf4Syel9AqTIopNa2K+TYnAzl6+2hMqaolaNL
	P0Kgofdp/2xFxpsprSPz443j2KN1n/Tdwg41PUHkgmz9xk4tObcAvDuwfbZpBIXG1QqOfsswWGs
	VkIM3OmPcjaffYkx76SCRoL72yGGXVL5OoFzVAALfgY73sW/uoAnOqiVLuhRLF6kwkwDz5Mbb7q
	FkC9nSrJYl0kreygjWFMAXJ9+agAjxK0zfr5oBhFyYQReO+cEvRDDR7sox6a+Lj
X-Google-Smtp-Source: AGHT+IGXalIPn2urvcKc7kE8dChY8MPpkqlA/83tI3tF2HNsqfmWKeP/iediFoNsr+JH4nSL/afrWA==
X-Received: by 2002:a17:907:1c0b:b0:aa6:5d30:d974 with SMTP id a640c23a62f3a-aabf47b43b7mr567071266b.28.1734606916373;
        Thu, 19 Dec 2024 03:15:16 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0efe49d7sm54281866b.92.2024.12.19.03.15.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 03:15:16 -0800 (PST)
Message-ID: <d7adb319-8840-47a3-b17c-87d9dd45f32f@gmail.com>
Date: Thu, 19 Dec 2024 13:15:13 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/3] wifi: rtw88: usb: Copy instead of cloning the RX
 skb
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Sascha Hauer <sha@pengutronix.de>
References: <8c9d4f9d-ebd8-4dc0-a0c4-9ebe430521dd@gmail.com>
 <7c4a0c905cec4bf4ba8c3bab78342196@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <7c4a0c905cec4bf4ba8c3bab78342196@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/12/2024 08:17, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
> 
>> +                       skb = alloc_skb(skb_len, GFP_KERNEL);
>> +                       if (!skb) {
>> +                               rtw_dbg(rtwdev, RTW_DBG_USB,
>> +                                       "failed to allocate RX skb of size %u\n",
>> +                                       skb_len);
> 
> checkpatch warns this is unnecessary. 
> 
> WARNING: Possible unnecessary 'out of memory' message
> #94: FILE: drivers/net/wireless/realtek/rtw88/usb.c:591:
> +                       if (!skb) {
> +                               rtw_dbg(rtwdev, RTW_DBG_USB,
> 
> 
> 

checkpatch is wrong about this one. alloc_skb doesn't say
anything when it fails.

