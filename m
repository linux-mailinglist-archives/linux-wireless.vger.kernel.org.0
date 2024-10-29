Return-Path: <linux-wireless+bounces-14639-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 635709B4AFB
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 14:32:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E76DB1F233A4
	for <lists+linux-wireless@lfdr.de>; Tue, 29 Oct 2024 13:32:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2F07205AD2;
	Tue, 29 Oct 2024 13:32:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d6mJEqD4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6409D205E17
	for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 13:32:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730208743; cv=none; b=Y6myKKqKq7Jyao4ajqJtjT9/j2Bh2k/HnU+5Sf6vXPHe5MF5ELArMHAEDn2h6wHdX3xj/ODO4W2MXiWIfkQFN0/A3gJ9r5iFD4AMLVon141nMerza8T8mvsfmxMup0RyMQ87bpziV25Z/VjqgcqxHG+BLDn285pdYmd/ffIvWKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730208743; c=relaxed/simple;
	bh=xRYPrbqnH8FvUk6RiwLLUP7NtRt7OM+3sqHd6nyUiYQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=bFix1OOb01ZKzIYcfLM5nn3eRzVY4L/uZ1UbCfy89+K9oo1IqIaLimOiHCq+Mtpk6g07+wfpc5r+FJJO9i35gzVM2Ez6zXzYbB0fjXQbOIzPOBL1cJ8tQWohpUAOdaBGuvbd8qkJJsqKcpTr+doeLfDsEEDUuAmyiwQ1mjRjz9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d6mJEqD4; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4316a44d1bbso50093365e9.3
        for <linux-wireless@vger.kernel.org>; Tue, 29 Oct 2024 06:32:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730208739; x=1730813539; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ef2TorUb7iOPDztwWwRI/7rNTUIMCTIe6IoJdvE6OXM=;
        b=d6mJEqD45XDrM2ZRalaG0ULpJBkcw/jnTW657y9cr9vxAlmSZlGDjMpAodgimDVQ2C
         evCxyY7mJlDSj/f5x++zGKF0ayfC20g2PXpZjmwapFQEIt77rIWK+O03TEcC9xXnUNf1
         5wFC6v56s2l1boYrmgxLAkPp8r9wVKl2nz7mGbiFYFANSKLl5aAMtZVRUyN8u/749l5D
         73713wT7tIqrVhirUrDw+3a2s7C3GpxHOB1oopmWsgvnidPEdWTlmlANLBRIt3CPDsU6
         Wt3EyBX7n+IlhOXn6dLAFJPIJPsd3s//iNJrHKar5uPgM+72iU5h5T0RCKCSPhohoP9w
         qs5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730208739; x=1730813539;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ef2TorUb7iOPDztwWwRI/7rNTUIMCTIe6IoJdvE6OXM=;
        b=rSxqD6rqYEe7vqzdhPuf6Q4IKevx7TN+fqsGq5d+CqzkeOYpuuekYg8K522heCa2Lp
         hlWZ9NlbQvyMSmEekqwo27/NpocGUCCn/M4pCDtP7KRLtO1jnRdxfbPUyy8TM/3MSg8v
         qWn3tB1eb91gE92EMAZrSXaKLnVsIjIsOzZo6mW7BQDeEMsDqRkedPO51jpJQ/2q8RQ+
         D1tosM0nArTyUH7ZIM9GUVKxquIK/Ut9c3t+RRmyL6nfMp+3ZtO1/UJCRXqnV3u6Y2sw
         x++7/ReU7a3QAHE4nqdjdao0SYsTd07S6Lotb1euQbSaV2sVpicD5XIvNVYia4gkTHnf
         LsZw==
X-Forwarded-Encrypted: i=1; AJvYcCVRupFq+ZBJxdXPfFJFuRM1mu9iQsgGl4SNnBcByRD4fx0iyzp0K6B923BHyuNmJSbuyw5D4YZlRZAn2fQ+2w==@vger.kernel.org
X-Gm-Message-State: AOJu0YxK1GHK4fZCV+x5Q8ruH/lzxkAB6YzSOriLy6YHoQb6Bpmupq6i
	g6bDAq/r2tBwrs6XnZReKmaGNHVSZ1ugwEJ/AXeF0KwfzJkWBMqNW+Igxg==
X-Google-Smtp-Source: AGHT+IFsQquDeB6VW27u+UbmsnETye7P/JxGnCiD40SLGk6y0xCIHCaPgdn3LRPC6ZpcmNwwPKxmVg==
X-Received: by 2002:a05:600c:3b94:b0:431:4e3f:9dee with SMTP id 5b1f17b1804b1-4319ac7409amr89477765e9.4.1730208738642;
        Tue, 29 Oct 2024 06:32:18 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4318b5707e8sm174712265e9.36.2024.10.29.06.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Oct 2024 06:32:18 -0700 (PDT)
Message-ID: <207adc8d-06db-46cf-a87b-6dc2a1efd6d0@gmail.com>
Date: Tue, 29 Oct 2024 15:32:16 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 01/22] wifi: rtw88: Add some definitions for
 RTL8821AU/RTL8812AU
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <ee6d97b3-0c82-4225-a07f-b0d4043a901a@gmail.com>
 <9279a9cd-6f86-4dc3-a095-7c36cb9b9d06@gmail.com>
 <808c66fa-60a2-4878-b1f8-65d064735692@RTEXMBS04.realtek.com.tw>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <808c66fa-60a2-4878-b1f8-65d064735692@RTEXMBS04.realtek.com.tw>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/10/2024 06:22, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
> 
>> Add 8821A and 8812A chip type enums.
>>
>> Add cck_high_power member to struct rtw_hal. This will be used to
>> calculate the RX signal strength of RTL8812AU.
>>
>> Add various register definitions which will be used by the new drivers.
>>
>> Move some existing register definitions from rtw8821c.h and rtw8822b.h.
>> They were duplicated in those headers and will also be used by the new
>> drivers.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> Smatch warns
> 
>   drivers/net/wireless/realtek/rtw88/rtw8812a.c:619 rtw8812a_iqk() error: uninitialized symbol 'tx_x1'.
>   drivers/net/wireless/realtek/rtw88/rtw8812a.c:621 rtw8812a_iqk() error: uninitialized symbol 'tx_y1'.
> 

These are false positives. The variables are initialised inside
rtw88xxa_iqk_finish(). But I'll initialise them when they are
declared.

> Please respin patches 16-22.
> 
> 15 patch(es) applied to rtw-next branch of rtw.git, thanks.
> 
> d12722830ea4 wifi: rtw88: Add some definitions for RTL8821AU/RTL8812AU
> 87341ca1eac9 wifi: rtw88: Dump the HW features only for some chips
> d9018f437351 wifi: rtw88: Allow different C2H RA report sizes
> 95a772e30b60 wifi: rtw88: Extend the init table parsing for RTL8812AU
> 7c5bbeba7c36 wifi: rtw88: Allow rtw_chip_info.ltecoex_addr to be NULL
> fbb5e1b3637a wifi: rtw88: Let each driver control the power on/off process
> c7706b1173c7 wifi: rtw88: Enable data rate fallback for older chips
> abb0f19492ba wifi: rtw88: Make txagc_remnant_ofdm an array
> 82a617413e85 wifi: rtw88: Support TX page sizes bigger than 128
> 67d915604e69 wifi: rtw88: Move pwr_track_tbl to struct rtw_rfe_def
> 85bf3041a0ea wifi: rtw88: usb: Set pkt_info.ls for the reserved page
> 57289d30cd2a wifi: rtw88: Detect beacon loss with chips other than 8822c
> b19840afc051 wifi: rtw88: coex: Support chips without a scoreboard
> bfcee5ee924f wifi: rtw88: 8821a: Regularly ask for BT info updates
> f9e0189cbc2d wifi: rtw88: 8812a: Mitigate beacon loss
> 
> ---
> https://github.com/pkshih/rtw.git
> 


