Return-Path: <linux-wireless+bounces-18472-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 885DCA27CF5
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 21:58:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 11BFA1634F7
	for <lists+linux-wireless@lfdr.de>; Tue,  4 Feb 2025 20:58:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C839C206F16;
	Tue,  4 Feb 2025 20:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLwTiwX5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCECF19E83E
	for <linux-wireless@vger.kernel.org>; Tue,  4 Feb 2025 20:58:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738702700; cv=none; b=lPc7AS0ra+ZBjiGMMM6gc3w9VJOhpWbDUQGm4RQAoysvYBm3Opx04YOlYJyrqBr4333Jghgoib+Ba7RH08pAJKBDuelX5fTYBrO0p+B3Y6/GnPU6SAdFItpD9VNC+JKlLKlJ6mT3KiLkT3Qmr/0IQyhibMWQyXaKBXsOjeDvVto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738702700; c=relaxed/simple;
	bh=o3CcFq+X2oAFhodFAgqXihMVp6qsp4cfQ5NXZj8uQKo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=qXDEMqSO8i6Wi8bC5iQOSvFq0MoUiCjakJbb2kbjv5OOCZR5xVy0c/5JJDwbV36dQI55DNiG2lc9Tms/yGzQzRc4XZ1zC6jQY6udQdya/M8F8wXiH8XguGI4CfkrrcGU0gjEFTvfanWSiYCoXR9RoNJ9jn9KryBrCMWjwdsNoKA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLwTiwX5; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-ab68a4ab074so736921866b.0
        for <linux-wireless@vger.kernel.org>; Tue, 04 Feb 2025 12:58:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738702697; x=1739307497; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SSEiuUb+aI2nZGeyU8J5T6b/ID0C8enKmRLrZW3Mgqw=;
        b=HLwTiwX5aoGeQ/HCKVjEHj4pYVbOUTqJ6segEW65QSv7FcMyoL5lnjgPL/BZAWJ0nO
         eLVTU1Bja6da9Yooik+WWIWODCvjN3OQlgQQccKjH11XLuTXqMjQHZWC+EhD98FFdskI
         4db58c8YHPdNDbz4OTX/lpU3KaUCg2Ii4CKhz7EDY7YxIJPquWOsxgCeFuWDg/1lkaNc
         LQGI9nsOXnm8zvSLgMAmzrteBGl526B1zf6gw/SYxpAA+qEswZL0OHQ4mUuMk1CMpt/x
         fWdxvNJASNMeWwe8qqlsz/0TUd0hLfK318gVJmdVKmSmTaVlpG/SlUGoWw+1YZ4ptOLu
         HJKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738702697; x=1739307497;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SSEiuUb+aI2nZGeyU8J5T6b/ID0C8enKmRLrZW3Mgqw=;
        b=Ak6gqyCek72AcUwDc6p55FnotQ60FoscGuGop7dq9/3czbHKxnpihcjPn+dE4mGL3/
         1ucxbjHx8gwcGAaqcHHsegB7qTMNgnLGALa3REWmKVuKCxl0AVHu7dS/IejTSY7a/QkJ
         cEBKXZOv+LKWqU3hLXCA6TECqYGf+pbvV9HDz3xDRYGnQCNcjPvCrahTBDlyW6c2loss
         iNYDiXt58Zd+D/T95TBpAvEgOpOISMVIRwwHMqJhuQsaUuINRn/ah1bfCcIrhQXo92U9
         fktpEj3UW2yYc5eU7SbYRHRsBjDUCI1cGB7iyeT2KVHMNpws9oYOyqobAs7/HPPPJZoQ
         aUVw==
X-Forwarded-Encrypted: i=1; AJvYcCWORC3vhSTwD33AuU8615N9pe4XwOSHwJ9HdHu5jJlyHDjcjvFbyP+/0rFACImywCnNRlkab5UEzBuZlWURjQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YzsYNxq7/1KYrpwHjgSDKY9fV33GOpngakQLj3OVIZbIrtCtGIc
	P1DnJK69qQareRHvWt2oKqRs+0b5y7rra53HDZHR8u5R7swDXdbs
X-Gm-Gg: ASbGncuEqKP+P6UmF/GJYk0TPC/DtUpBHzmCRt+UloDngAQFffdhDOZnhkJp+iiWp5P
	CG7I4U2XXW8FzSs8+3J5/JJ3ug3Cgb87WUggR3aVD13XnwYhLHDdF8grkCDdJ9d0YFbXt5TC+3Z
	vW3KBgNGFzXR/p3VnHX8GuDLktgS4P6h5Esj2wKSHIWJArhkbyt0+zAmUg1TnsbF9RURgYtrFwU
	xwvip+T1vy4FcQdigaPckqCU3v+tgvfED9Dd6KWm6VtySg5IiA6U6SIcCTRnNgDujyRhjG5qT3z
	go9ijioa/2G0e7PbrzfkYBzA
X-Google-Smtp-Source: AGHT+IGGIRA4fyknsx8xOVNdF+2w0xS2bZuUcbG/woqbV8pL4YwVnTr6Wre58PVk+WTenVpckGNoJg==
X-Received: by 2002:a05:6402:3205:b0:5dc:5ada:e0c7 with SMTP id 4fb4d7f45d1cf-5dcdb762c7bmr1282110a12.26.1738702696668;
        Tue, 04 Feb 2025 12:58:16 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5dccfc236a3sm1204395a12.18.2025.02.04.12.58.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Feb 2025 12:58:16 -0800 (PST)
Message-ID: <abfb985a-50c8-4c85-8a11-9648d106c2c9@gmail.com>
Date: Tue, 4 Feb 2025 22:58:14 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: rtl8xxxu: Enable AP mode for RTL8192CU
 (RTL8188CUS)
To: Ezra Buehler <ezra@easyb.ch>, Ping-Ke Shih <pkshih@realtek.com>
Cc: Martin Kaistra <martin.kaistra@linutronix.de>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Johannes Berg <johannes.berg@intel.com>,
 Reto Schneider <reto.schneider@husqvarnagroup.com>,
 Ezra Buehler <ezra.buehler@husqvarnagroup.com>
References: <20250122071512.10165-1-ezra@easyb.ch>
 <393aa422-3ac8-40e7-aa2f-62956a844005@RTEXMBS04.realtek.com.tw>
 <19b8059a-c5f6-4467-8b42-31e70b9fe1f3@linutronix.de>
 <93fe56295aba4bf0bc1af603bd992f47@realtek.com>
 <CAM1KZSkPNQ=6VzuoiF7qALq=UVjoT_SF2YgO5oRwuraQACqeQA@mail.gmail.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <CAM1KZSkPNQ=6VzuoiF7qALq=UVjoT_SF2YgO5oRwuraQACqeQA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 04/02/2025 21:59, Ezra Buehler wrote:
> On Mon, Feb 3, 2025 at 9:51 AM Ping-Ke Shih <pkshih@realtek.com> wrote:
>>
>> Martin Kaistra <martin.kaistra@linutronix.de> wrote:
>>>
>>> Is there a reason for not setting macid in rtl8xxxu_fill_txdesc_v1() and
>>> rtl8xxxu_update_rate_mask() like it was done for the gen2 case?
>>
>> rtl8xxxu_fill_txdesc_v3() doesn't fill macid neither. Quickly search for
>> the code filling tx desc [1]. I think we can have a
>>    #define TXDESC32_MACID_MASK GENMASK(4, 0)
>>
>> The h2c command format of rtl8xxxu_update_rate_mask() seemingly should be
>> equal to rtl8192c_set_raid_cmd() [2], but not.
>>
>> Can anyone help to spin patches and test if it works?
> 
> The suggested changes seem to help. A quick test shows TX rates of
> around 20 Mbits/sec. I will prepare the patches soon.
> 
>>
>> [1] https://github.com/lwfinger/rtl8192cu/blob/master/hal/rtl8192cu_xmit.c#L257
>> [2] https://github.com/lwfinger/rtl8192cu/blob/master/hal/rtl8192c_cmd.c#L201
>>
> 
> I've also noticed that the TX rate is not reported correctly. "iw
> station dump" shows "tx bitrate: (unknown)" and "hostapd_cli all_sta"
> displays "tx_rate_info=0".
> 
> Any ideas why that could be?
> 
> Cheers,
> Ezra.

Looks like rtl8xxxu_sta_statistics() was not updated for AP mode.
See rtw_ops_sta_statistics() and rtw_fw_ra_report_iter() in rtw88
for inspiration.

But this chip doesn't report the TX rate, so rtl8xxxu can only
report the theoretical maximum. It does this already for station
mode in rtl8xxxu_bss_info_changed(). I guess you can do the same
for AP mode in rtl8xxxu_sta_add().

