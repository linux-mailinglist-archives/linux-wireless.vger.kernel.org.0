Return-Path: <linux-wireless+bounces-6394-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id ADCFC8A6A08
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 13:58:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 66DEF2822F9
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 11:58:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 91314129A8D;
	Tue, 16 Apr 2024 11:58:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UOweeuly"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8B43129A67
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 11:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713268693; cv=none; b=RZxftKYV+Gppm/zHGPYJNpaFG/k23X7sbJH9dK3szpe7cmjmU5V+O3825qUZcfUXjjZa0L1nireUJtcAi1Lld3GfK+WxAkImhbIjLJXacE2uXP4XYygvVMv19PBTo/SancGEqcEPzTAapzyR84Yqf5VefelDnJvnQ1ve1shug9c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713268693; c=relaxed/simple;
	bh=C3XT9eXRV1Z6J7fMbS/qxvbNmWLGfupP5GGV4KW0k8A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=lhExmm9mUpX/f07yay21T3okhQYkJwFFtZ5FOf7M/k9g1DQYy5CttlXOPnRfFtppQ2ptEDK4RaXt2txTpQR1DOztOYmnM/m/hIvvJzkj9aQqMRLpkuEBmIxMIQjN3vFmeaO4FksT2AEzTKK941M1XgbwN9ZW2hJ/r2Qd26uAt70=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UOweeuly; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4155819f710so29531275e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 04:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713268690; x=1713873490; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LKhStIM1l5ZF5ewGFOL15TR0r7oTKTp2UvmXNBROPuc=;
        b=UOweeulyZpB7JZBstHnCgCYVJeWWeFvvKQOJEX1eLgiGzV8/Cy0ExPIMIUpwuCqxjU
         o6rkkdkIHEuCmDYjYbBM1F/FOr31qSpMGPWIuhyAnm0ZpOD/Bd5tMvjx0AbqYrLQHzLH
         wFkmvjCyawcSbgrE49jvl+WoAsIqO8IIdImAusT69l86JxrC9U9gwVHjEIkV1SjAr0O5
         RvoaIu5ucUiDzPbCibOQOupkDxmVMEkEONgCVy2bXtUlg7QTNnD7L2OsMbheUxFqRM02
         cN5zmxLk/1Ji6ySljKg11yp5l0qlGuJkMrWyucVGZb2UnDo4f9NgReRVzijY573d5Hmd
         SSWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713268690; x=1713873490;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LKhStIM1l5ZF5ewGFOL15TR0r7oTKTp2UvmXNBROPuc=;
        b=cwyBVMcBjJJ0FB+khjJ2gvpkF7b8GuyMvXSzVjxDVJZTZpq4y+7LiAR21XtsbPm4lo
         zqwx6DZixoSWhgaz8uRXbViNZt5rUDNDsAEKU5LHak1Kcnl+J44vqoESoDMi88wXjy34
         VXc8BhgTSc1RcrIMux5IUSPY+LNrMbfUeaodM6pt3x8PWFY8uaYhQDcecxkAZxOovqdQ
         Ws/9bFoXKguGnsZR8oJXX314rFqwaKTa7bxZv+IvZuWPmHqZrv9jiqy2u4BmsIjrFkla
         Sodz5Ikp1JMAPYMvvSJvmbMR7uY6BXkkVgs+humF/nFDmwpB30BgM+EDokUw26bRPOsy
         De5Q==
X-Forwarded-Encrypted: i=1; AJvYcCVIKPHxrVHyrNtBZ1co4+j9pN64V7gLIWyUj+qjADKmMem+jw/TIov8MMwGjwirIMu49a2UXJUktfkE2oqk/j9yXOCzMWcgFXH6KYNQNw4=
X-Gm-Message-State: AOJu0YyKqQFLrqJ3+y/ZVOF76FHnTW84nuHlPFJixu1+GgsQ9K20ZiGj
	YqudbUPf0Wgl5gYgyDWibYWiOL/w1FH25GjlqPzTpOdxJltZST7yRWpyzZon
X-Google-Smtp-Source: AGHT+IG55eeNc9zlNw1eikyumz8XEKuH44qiZ6my992gzdsSsHATTPEktYVGboEYRsPD73vx6oaUag==
X-Received: by 2002:a05:600c:46cd:b0:416:9cf8:f901 with SMTP id q13-20020a05600c46cd00b004169cf8f901mr8906714wmo.17.1713268689912;
        Tue, 16 Apr 2024 04:58:09 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id ay8-20020a05600c1e0800b004181c91d1dcsm13843601wmb.18.2024.04.16.04.58.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 16 Apr 2024 04:58:09 -0700 (PDT)
Message-ID: <db30ab81-af51-4ab2-8a11-dc28e758bff2@gmail.com>
Date: Tue, 16 Apr 2024 14:58:08 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtl8xxxu: Fix gen1 rate mask command
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>
References: <3068a7f8-0178-4ea7-bd18-4e377db07e76@gmail.com>
 <12bae50933084d9f8646a33daad036a7@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <12bae50933084d9f8646a33daad036a7@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 16/04/2024 07:01, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>
>> The H2C (host to card) command which tells the firmware which TX rates
>> it can use is slightly wrong. Fix the order of the bytes.
>>
>> Also put the macid in the command (relevant for AP mode).
>>
>> This was tested with RTL8192CU. It also affects the RTL8723AU.
> 
> Can you add test results before/after this patch?
> 
> I wonder if RTL8192CU and RTL8723AU use different command format, because
> vendor driver of RTL8192CU seems use different command ID (w/o BIT(7)), see below.
> 

They use the same format, the vendor drivers just add BIT(7)
in rtl8192c_FillH2CCmd function:

https://github.com/lwfinger/rtl8192cu/blob/52b20929a8f68d5fbae38e6e253f75b713258487/hal/rtl8192c_cmd.c#L114

Please ignore this patch. I made a mistake: the order of the
bytes in the struct is weird, but it is correct for rtl8xxxu.
rtl8xxxu_gen1_h2c_cmd is aware of the changed order.

>>
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>>  .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   | 10 +++++++---
>>  .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 18 +++++++++++-------
>>  2 files changed, 18 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> index fd92d23c43d9..ca44d82cb5aa 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu.h
>> @@ -1430,10 +1430,14 @@ struct h2c_cmd {
>>                         u8 data;
>>                 } __packed joinbss;
>>                 struct {
>> +#define RAID_MASK              GENMASK(31, 28)
>> +#define RATE_MASK_MASK         GENMASK(27, 0)
>> +#define MACID_MASK             GENMASK(4, 0)
>> +#define SHORT_GI_MASK          BIT(5)
>> +
>>                         u8 cmd;
>> -                       __le16 mask_hi;
>> -                       u8 arg;
>> -                       __le16 mask_lo;
>> +                       __le32 rate_mask_and_raid;
>> +                       u8 macid_and_short_gi;
>>                 } __packed ramask;
>>                 struct {
>>                         u8 cmd;
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index fac7824ae727..acbafc25c6e0 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -4641,15 +4641,19 @@ void rtl8xxxu_update_rate_mask(struct rtl8xxxu_priv *priv,
>>         memset(&h2c, 0, sizeof(struct h2c_cmd));
>>
>>         h2c.ramask.cmd = H2C_SET_RATE_MASK;
> 
> rtl8xxxu: H2C_SET_RATE_MASK = (6 | H2C_EXT)
> vendor driver of 8192cu: MACID_CONFIG_EID=6
> 
> Can you confirm if command "(6 | BIT(7))" works on 8192cu?
> Maybe, it only works on 8723au? (this chip is too old, I don't have more info about it)
> 
> 
>> -       h2c.ramask.mask_lo = cpu_to_le16(ramask & 0xffff);
>> -       h2c.ramask.mask_hi = cpu_to_le16(ramask >> 16);
>>
>> -       h2c.ramask.arg = 0x80;
>> -       if (sgi)
>> -               h2c.ramask.arg |= 0x20;
>> +       le32p_replace_bits(&h2c.ramask.rate_mask_and_raid, rateid, RAID_MASK);
>> +       le32p_replace_bits(&h2c.ramask.rate_mask_and_raid, ramask, RATE_MASK_MASK);
>> +
>> +       u8p_replace_bits(&h2c.ramask.macid_and_short_gi, macid, MACID_MASK);
>> +       u8p_replace_bits(&h2c.ramask.macid_and_short_gi, sgi, SHORT_GI_MASK);
>> +       u8p_replace_bits(&h2c.ramask.macid_and_short_gi, 1, BIT(7));
>> +
>> +       dev_dbg(&priv->udev->dev,
>> +               "%s: rate mask %08x, rate id %02x, arg %02x, size %zi\n",
>> +               __func__, ramask, rateid, h2c.ramask.macid_and_short_gi,
>> +               sizeof(h2c.ramask));
>>
>> -       dev_dbg(&priv->udev->dev, "%s: rate mask %08x, arg %02x, size %zi\n",
>> -               __func__, ramask, h2c.ramask.arg, sizeof(h2c.ramask));
>>         rtl8xxxu_gen1_h2c_cmd(priv, &h2c, sizeof(h2c.ramask));
>>  }
>>
>> --
>> 2.44.0
> 


