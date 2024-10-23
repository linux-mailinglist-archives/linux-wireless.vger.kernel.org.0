Return-Path: <linux-wireless+bounces-14379-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 339009ACAEB
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 15:16:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A10E5B23A7A
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Oct 2024 13:16:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A6311AB521;
	Wed, 23 Oct 2024 13:16:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j7fQ6CJZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88BCF1AC45F
	for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 13:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729689372; cv=none; b=dGoEn1TkIXhaV2AMtQY4xxHyRr5zdlWfdy2AFN7R6L1yw7BtSM7AwT1uPUPxfkHO2SRqYDZxK9FoXOOSGabQq4C9mdi1bXTmTYR1rkeE8Y0tQgCADreZw2wpgbSlN+bCsOJ+ttGxoz2dNyQQGbj/ovgXWOymGcv99CqpPMtvl8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729689372; c=relaxed/simple;
	bh=kgZgpf2R4Zoz7FE1KaxBGiZ1CP++AndqebuagTK/PzU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=V8zYRcfwSlOoSqUO+DmR3lSj95Y+ZTRNQBjRTh2itosjJPzfJgp2mG+DZwmFja5z9UqhnvsZfFblZcl3VbVgxVR2mGs9UVusIhKpTkn0MWLn+3uqUEVky8KfzPUIDafKA0RlerEh/VFXvS3nn9e948T1+IDGGrE2tiZ2Ec5h6tE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=j7fQ6CJZ; arc=none smtp.client-ip=209.85.208.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f44.google.com with SMTP id 4fb4d7f45d1cf-5cb74434bc5so3430732a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 23 Oct 2024 06:16:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1729689369; x=1730294169; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=KdcMzQO/UQGeSUZ5oqAGC0ET7Vfr8C+WKWZVYo/7A8I=;
        b=j7fQ6CJZYir+8wcPaGNiMF43I4ayFAsjxR1MQ2zgVgUCCb/X+Jxd6GOuLfPVc0bFL8
         NJRQ4OWxJBm1AvImrfpRUpma8H5/nEB4nrnbYHD4Q2TB2PmJ7W0wHfnjk6ybLTe3+jd9
         ykSHmzb3WV4WbCVDBMsRsEFcQ/Jn+kUWOaAoaOuO16fjv2HqgGlL6coK5ZQsZx5H690n
         TfVcd/Zul9NMhwkD1bf20vV15xFkwQy8kMqnztYd/6yQn5E8de2EaHxjkLfk9+EpKQlI
         v5fetGqqP0gKWE1NKvVakErYOfsC9QRRq1fVexvba2FArvB6VwW2p6GhAoL9psMPvpv0
         qkOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729689369; x=1730294169;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KdcMzQO/UQGeSUZ5oqAGC0ET7Vfr8C+WKWZVYo/7A8I=;
        b=VZyXm8mc+y2zZCXXIjDTsJR7bdMaZH0UJH+koxstWfmJ0v1HK1SzwUyz4dLOcUfJpu
         OD9M+QjaMlnJ5GO4YMqsOawj3KE/qpThu1UzTUBIHGyaFXbd+y10rsX5XTYahqGQeMun
         6nk/Ltk94hEQIFmRLRpZwB3XWSSyjiNWoTgyryebYys7qoqOHX5hGn6NY4Ii+1C1tn2s
         /MoFKJmvaM1qgKzEPGbQMXkwn5SGOQdDG0fCuJkLODazQqWrs+pHk1/bZ4HJz1yDS4iI
         C/9I73H5t4SCnsZPT/hovEf+G0v/h7U+4XSGLlWTugvZd8R9ZX60EG0IVy/B4jn+osBu
         8h/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVwlz6mqaOkof5rRpR5Ot14aJEJxP9L2LM/CBT0i1VOMUekeOEHld1wiFQ67hlVLd6aDm0wfBf9gX6kgsNbFQ==@vger.kernel.org
X-Gm-Message-State: AOJu0Yxd03JfaE5SXkYaq2PqdKqbbzwe4XWEEXzYyiUVgxdd2tplm0/8
	TYTj5C/yd5LNKkJk04+Nc9ga0S4WSX8D/1gRzshrOL8PVszQZJw3j0gLRw==
X-Google-Smtp-Source: AGHT+IERrDLcrMU5kbpZ0xHRdwgZ8B4SU0d2AQfzwk2Vc6RrNy1DMJAwUKdVutqTfjA+kFOGCzeL/A==
X-Received: by 2002:a05:6402:40d2:b0:5cb:68cf:c730 with SMTP id 4fb4d7f45d1cf-5cb8af7dde3mr2361288a12.5.1729689368412;
        Wed, 23 Oct 2024 06:16:08 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.150.231])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5cb8b957fdasm989059a12.89.2024.10.23.06.16.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Oct 2024 06:16:07 -0700 (PDT)
Message-ID: <016475e4-3d9f-4bbc-b6dd-bfdb1733d2e7@gmail.com>
Date: Wed, 23 Oct 2024 16:16:05 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtw88: Report the signal strength only if it's
 known
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <f7e1e448-2c9b-498f-b8b1-a14dd967d7d3@gmail.com>
 <6d378ad2796f42d88fe80461b8618694@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <6d378ad2796f42d88fe80461b8618694@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 23/10/2024 04:57, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>
>> RTL8811CU doesn't report the signal strength for many (any?) data
>> frames. When the signal strength is not known, set
>> RX_FLAG_NO_SIGNAL_VAL in order to avoid reporting a signal
>> strength of 0.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 
>> ---
>>  drivers/net/wireless/realtek/rtw88/rx.c | 12 ++++++++----
>>  1 file changed, 8 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtw88/rx.c b/drivers/net/wireless/realtek/rtw88/rx.c
>> index 1de93fc9efe9..90fc8a5fa89e 100644
>> --- a/drivers/net/wireless/realtek/rtw88/rx.c
>> +++ b/drivers/net/wireless/realtek/rtw88/rx.c
>> @@ -234,10 +234,14 @@ static void rtw_rx_fill_rx_status(struct rtw_dev *rtwdev,
>>         else
>>                 rx_status->bw = RATE_INFO_BW_20;
>>
>> -       rx_status->signal = pkt_stat->signal_power;
>> -       for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
>> -               rx_status->chains |= BIT(path);
>> -               rx_status->chain_signal[path] = pkt_stat->rx_power[path];
>> +       if (pkt_stat->phy_status) {
> 
> When only pkt_stat->phy_status is set, driver calls rtwdev->chip->ops->query_phy_status()
> to get PHY status. Have you reviewed all places accessing PHY fields 
> also check pkt_stat->phy_status? 
> 

Yes, I think this was the only place that didn't check pkt_stat->phy_status.

> 
>> +               rx_status->signal = pkt_stat->signal_power;
>> +               for (path = 0; path < rtwdev->hal.rf_path_num; path++) {
>> +                       rx_status->chains |= BIT(path);
>> +                       rx_status->chain_signal[path] = pkt_stat->rx_power[path];
>> +               }
>> +       } else {
>> +               rx_status->flag |= RX_FLAG_NO_SIGNAL_VAL;
>>         }
>>
>>         rtw_rx_addr_match(rtwdev, pkt_stat, hdr);
>> --
>> 2.46.0
> 


