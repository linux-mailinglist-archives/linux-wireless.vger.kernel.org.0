Return-Path: <linux-wireless+bounces-6678-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F4008AD32C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 19:13:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BA902811D4
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 17:13:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1077015218D;
	Mon, 22 Apr 2024 17:13:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hGbrb+Du"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FAC22EB11
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 17:13:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713806034; cv=none; b=OdILsTM4Gc1HiF5C2/QBHjBNSdr6kjuhIjTrAK8V1kx+1JwsrI+XQofZl4IBx8XimvTlB9kYCHh/GW7vlh3Kx2Qr8kbctw0IQeaVBbMiaQyi49F6QZ8izwXdzOJMgX6qtMGTZbw48r/g7PawzdjK55wIEM+v7ECl3nKAU/U7dzI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713806034; c=relaxed/simple;
	bh=Xzuprcfd8BuqGOD1b/jfi8Bn72sNv4VrnIwsOi4IY68=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qznPmZ06PatQZlZZ4gDpIUBo+l0UUkB1UDNYYG5rLPXX3Zu0Q2NZ7SN3OgQqH3OLMw62nT/axghw0pA2+MHc7ee6qeMJzszrELwxeQutLrva9/Qcejn2WBVJc2m6ln31t+tCP0JeEBluMIz7j4WrJ4ecbeR72mIO+6Po0iyjGig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hGbrb+Du; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-343b7c015a8so3995108f8f.1
        for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 10:13:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713806031; x=1714410831; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QYnna7lmknvrZBxY80gpqRvL2K75DJ9W5gF4KmJKFw4=;
        b=hGbrb+DuNnPxmhzYXye/o4x2pwss5BS5FWMgAZyG+kq7uQ2+QEBKK9IgSJnfLYMmep
         8FuAlQQnGAnmRHfoe/yR1qDwJH9n+lRalblmuWVeTKY4W+o6dUA8TdTaqRqugsArZd47
         Isea6xAGxvGAQNpdn/u+O3uN225G/uO0yhBItySq/iRchZgUh/RugLDHA/XY53tK26SC
         FpC6wi5waRJeVc1ggIWynUa6ahSBv8i7IfF81rJCPIDkTH/3pvwNNKQFDHzfwKY2RJzT
         6a6AU325PSswgbqb5zxklU4KPUxz8C6k3HaKW2cnPxlT+7g2Tl10YvLSY5pm539S4qQi
         brBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713806031; x=1714410831;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QYnna7lmknvrZBxY80gpqRvL2K75DJ9W5gF4KmJKFw4=;
        b=jL9p7N4h1ZUboBsOWMlrpyTHZZc3/djrEgT3zEYnBekPPqWdCZ8/mnyAwIGd3dMi+K
         5Mlmpo0cUP7hViUR9VXxSTGfc1atBcYe6pD+okQH/pg3BFQJMesKxV0dLQmtNTsdQs1d
         kJ/fp7yJpEyfU/yhX1M9vngvdKVi779yY+Kon8lKXgn/owgfNQ3URcKayhuH2zPy9dLw
         S9fnU4TQJ09iF/kiwEDPognI9rUzTy+CQJ11pApiAD4y40V5LNoewj/5aBNZZ+0FnFIv
         dageflI/2kSDa7bPkwAW3wNNa+NsAjaV09rvUpbaChyjPMx3fKEQmkCHo5+hpeWvcTR/
         PGiA==
X-Forwarded-Encrypted: i=1; AJvYcCWAPF7aUIEsbJ8aAN9qS5v3rh8R5bOfqSinBKIPeslvQeryONbtFck0hWKG49AbRPLsEMzVee1v1GQmYswmj93W7YvMxT59mkLcwyun3Rs=
X-Gm-Message-State: AOJu0Ywh6j2ueChKkp09ROX9bNwwU8V64UR36GecGBUclMvw7YVOEXsW
	9c9Okowd8xLzQ5U9uJgoLEDchQTp606hUhO5GHpu00H9vEhtOVWF
X-Google-Smtp-Source: AGHT+IFfzDPKi9ModWeG9SvD74HyeSAwy2xHjShidoNuYpX/MEC0BpoxX6TI6ATeJUaITHetbsFkRA==
X-Received: by 2002:adf:b199:0:b0:346:65dd:55f1 with SMTP id q25-20020adfb199000000b0034665dd55f1mr6452653wra.31.1713806030572;
        Mon, 22 Apr 2024 10:13:50 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id t18-20020a05600c199200b00417ee784fcasm17314416wmq.45.2024.04.22.10.13.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 22 Apr 2024 10:13:50 -0700 (PDT)
Message-ID: <67e46592-c521-411c-b23c-4fb2da30e3f5@gmail.com>
Date: Mon, 22 Apr 2024 20:13:49 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 6/6] wifi: rtlwifi: Adjust rtl8192d-common for USB
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <9d54a192-d389-4a56-9286-2e7721cbbc27@gmail.com>
 <45848eb2-9c52-4aac-b7b0-b584955e41d7@gmail.com>
 <f080fd27b21147869e8b923891d5dcff@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <f080fd27b21147869e8b923891d5dcff@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/04/2024 06:39, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> A few of the shared functions need small changes for the USB driver:
>>  - firmware loading
>>  - efuse reading
>>  - rate mask updating
>>  - rf register reading
>>  - initial gain for scanning
>>
>> Also, add a few macros to wifi.h and initialise rtlhal.interfaceindex
>> for USB devices.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> [...]
> 
>> @@ -965,12 +983,20 @@ static void rtl92de_update_hal_rate_mask(struct ieee80211_hw *hw,
>>                 break;
>>         }
>>
>> -       value[0] = (ratr_bitmap & 0x0fffffff) | (ratr_index << 28);
>> -       value[1] = macid | (shortgi ? 0x20 : 0x00) | 0x80;
>> +       le32p_replace_bits(&rate_mask.rate_mask_and_raid, ratr_bitmap, RATE_MASK_MASK);
>> +       le32p_replace_bits(&rate_mask.rate_mask_and_raid, ratr_index, RAID_MASK);
>> +       u8p_replace_bits(&rate_mask.macid_and_short_gi, macid, MACID_MASK);
>> +       u8p_replace_bits(&rate_mask.macid_and_short_gi, shortgi, SHORT_GI_MASK);
>> +       u8p_replace_bits(&rate_mask.macid_and_short_gi, 1, BIT(7));
>> +
>>         rtl_dbg(rtlpriv, COMP_RATR, DBG_DMESG,
>> -               "ratr_bitmap :%x value0:%x value1:%x\n",
>> -               ratr_bitmap, value[0], value[1]);
>> -       rtl92d_fill_h2c_cmd(hw, H2C_RA_MASK, 5, (u8 *)value);
>> +               "Rate_index:%x, ratr_val:%x, %5phC\n",
>> +               ratr_index, ratr_bitmap, &rate_mask);
>> +       memcpy(rtlpriv->rate_mask, &rate_mask, sizeof(rtlpriv->rate_mask));
>> +       /* rtl92d_fill_h2c_cmd() does USB I/O and will result in a
>> +        * "scheduled while atomic" if called directly
>> +        */
>> +       schedule_work(&rtlpriv->works.fill_h2c_cmd);
> 
> This function will be used by both PCI and USB, right? But, 
> only USB initialize/cancel rtlpriv->works.fill_h2c_cmd. 
> 

You're right, I didn't notice that. I will fix it the easy way:
call rtl92d_fill_h2c_cmd() for PCI and schedule_work() for USB.

