Return-Path: <linux-wireless+bounces-14218-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A0089A43FA
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 18:41:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFFFA283114
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 16:41:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3EDB4202F60;
	Fri, 18 Oct 2024 16:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="aJSclLJA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31C1D56B81
	for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 16:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729269684; cv=none; b=sP5nrzbAN/PqHBRkX/nrdi72lYNM5JPd89ztuvKFXhkH6mjr57E0s9RyM6DRrLNzOP2QwhmWmBHlFTYKS0f1ibrBGWaEmsU5TDhPLA5LMr1mwX0n4Xk//BWRtD7Is332sU1BC+5I3xddYe9XIPsXBuNZdJHozfhNlXIEA4vSqng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729269684; c=relaxed/simple;
	bh=GPxd0J/qUIYywV3MLHm12jNYNsR8QRrvOK/haoMHxPE=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=iVhaI5yzzO73qC6X4AaOycueCfTRmLFAMnyxj56sktLdX+K2Zdkird5Rrh2jZNa8W9YwC0mPKMq/9lADClaZrd2XWj8Oc698RGdC7pWbbsgoBIcZCgBNt+dWo9nNzYT2g7nw6tq5ggOn0u/JaZsWc98o7MdKEEM+uXZ6voOJ9W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=aJSclLJA; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4315e62afe0so17190995e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 09:41:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729269680; x=1729874480; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5nWnVCsbojvl5xNYgOr6VnbmAAKUmi+TTvu0ki073WM=;
        b=aJSclLJAo+PIlVRgw4Cwg7NPJuiEW6ldvmAgUj7mgGy5UYKgmLrLU2qgE5n9CuAKYV
         arM5zqTGr8IyODMpD35JPss5zrG+/YvIaH/Awj7Mn+KKJHIvVgHD8ekC7zQZtEEgY2uT
         4kK254jAAefLcswitw+7RvOl9fmdQj5uBiHRTWR4JGjKQUrOeI8ZZvDt8s7gTyym4cXY
         iXcpq4GcAVSuaf21nIIkdTaXsyn4N62tsDaAuh4FkKHG0abIfg9ZgOozx0kTJnbDvrw+
         4PHLLfw38b4+8h4KDFTqyPlBTbbKn4xiyE28vaFYDRpZDo1seoPF7fS4d77OzZR7uqYQ
         nWIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729269680; x=1729874480;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5nWnVCsbojvl5xNYgOr6VnbmAAKUmi+TTvu0ki073WM=;
        b=bD0ZDdcA/vfbJuWC6ngyN5bp1tL0boa7U/fJYNy/xOU6K6AIbuSldxwQlTI3rHM7ur
         qWmzm9lij5lzgbYq5AzxPmnML85RD7hVYEqZm4iDJhtTQq7B8YH16KJ4lfoSNxRafth3
         qDeBQBGDF20mdCfYkteBPRg4hEDey/oMINzOiw+vQw0q6ZebL4MOhPvEiWo0WwylhAfO
         /HbFvfHcF4Qjk4f2Zb/VHh+LjCoaPOQtjQsPEq6D2riKwri9xpfiqWWVgu+kYYSxvD84
         cmKiLgr5bsvaVna613yfCPHrJoY9YeBYhlS+vSbMQ6oT5NvXdneWDcwugHwUhHDFnWPX
         Cp5Q==
X-Forwarded-Encrypted: i=1; AJvYcCW5A6ZtnUELPTRNUqssmNOIe7sbVNet0hZgirEw4jYgI5XyYZKk4E5MyAAHj4QFq2ori6LEPEEDvoJZQhNQEg==@vger.kernel.org
X-Gm-Message-State: AOJu0YxAzDHKwIpJi8CzU6FXOh+bndukDHqQCD+PaK0rUWVcNqReh8Lu
	5T/2d6E081bAuJZztjs+BN6mHrc5hn1cHp7wT8fg6zT7kmQF6gNN
X-Google-Smtp-Source: AGHT+IEj4i7rTjuOlEF9IPl+mNVtXovv8d6c5STNEgnnNxOkRdlP8pAalZS1rYawR98KfHZLqs26zA==
X-Received: by 2002:a05:600c:3d9b:b0:431:5bae:c600 with SMTP id 5b1f17b1804b1-431616a1d3amr24211675e9.34.1729269680003;
        Fri, 18 Oct 2024 09:41:20 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-37ecf04969fsm2343614f8f.30.2024.10.18.09.41.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 18 Oct 2024 09:41:19 -0700 (PDT)
Message-ID: <b6454331-d2d0-4eea-bfb7-85551b05ef0d@gmail.com>
Date: Fri, 18 Oct 2024 19:41:18 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH v2 03/22] wifi: rtw88: Allow different C2H RA report sizes
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
 <9bbe0502-dabb-4a95-b201-505dfc9ab688@gmail.com>
 <ba1f00c4fb1d4780ab85048ca6f4e02f@realtek.com>
Content-Language: en-US
In-Reply-To: <ba1f00c4fb1d4780ab85048ca6f4e02f@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/10/2024 09:11, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>
>> +struct rtw_c2h_ra_rpt {
>> +       u8 rate_sgi;
>> +       u8 mac_id;
>> +       u8 byte2;
>> +       u8 status;
>> +       u8 byte4;
>> +       u8 ra_ratio;
>> +       u8 bw;
>> +       u8 txcls_rate;
>> +} __packed;
>> +
> 
> The 'c2h_ra_report_size' is 7, but struct size is 8. Why?
> Have you ever seen size of RA report is larger than 7?
> 

txcls_rate appears in https://github.com/morrownr/88x2bu-20210702.
But RTL8822B doesn't use it. I figured it can be included in case
some future chips use it. Well, even in that driver, txcls_rate
is just printed in a debug message.

I haven't seen RA report larger than 7 so far.

