Return-Path: <linux-wireless+bounces-16592-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 35A569F7A28
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 12:16:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 315CB7A1266
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Dec 2024 11:16:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DB8B0221D8F;
	Thu, 19 Dec 2024 11:16:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Qrcebhlk"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 175741CD15
	for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 11:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734606997; cv=none; b=YP++w72s8i3mSzbSw2bXfK4PRBkty2YV1Nhqa0psSBBnOI5j2z9rCU0GhjBNxSsWC0bxkcW23LUnM4n9qi+588UnMIiQ6V7LMQVTjfQnYGBkwKIw8wsiNG2FVC5lICqwizPHEqJVIjvlrh2LVZdn1LnGDQLWVMVqIkN2x+PS0F0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734606997; c=relaxed/simple;
	bh=5uzMARilmWrNCF97T/5NRG9FAHu967VBDMKGG9EjM9M=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=a947Brw4bdijJ0PbJNvO4M20cMGEZIQKA4SR4hkhLQFVhXNp56dh+u5QG9DxAtL/mKrPKaByXJy6sFuinaRO4bVrh5XHumfCf/4vUe9S2e/lraJXPbUQ73LBe128zToiV6hzeeAAfu/qArZD0iYvm2eR/rtlM2PntrLe9A5xP0Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Qrcebhlk; arc=none smtp.client-ip=209.85.208.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-5d3f28a4fccso871568a12.2
        for <linux-wireless@vger.kernel.org>; Thu, 19 Dec 2024 03:16:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1734606994; x=1735211794; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=e8d7189BQn6Vdz9x31FUzfsOF1AjRTD99pu20NkPK6M=;
        b=Qrcebhlk8R1cSFyqEzfGJXbM9O9TDrE8GnRDkMTqCHB/iwYXxRbwBeVl3TIwRpEALT
         wftrX8UpKbk9TloONxX2bL6SYJp6rmSlYHPtVGXEpltXjsdcAWExlJsAihBQoNxHhGf+
         s28/3BDTwIDxb1OuhuLe4UhIjwWGBKPhBDtD9u9+MTRI/bsRzCKssA6uiSx46WF/HMIS
         6yu9hRBmEwfZerv/fiVXCQRcLIg+ugp+s6mOHjMw/cy1JZKJETh/EITungkKLclMJrQF
         VpO/uRRWRDLr+tUzwLnsWBlm8/rYbp6oZCYnItzIYim5FPJtXKB065ew6Ok0UshR+ERV
         uQRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1734606994; x=1735211794;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e8d7189BQn6Vdz9x31FUzfsOF1AjRTD99pu20NkPK6M=;
        b=RE4Olh8iYO0T1LAXTxLUVwgKbpEHsrfeKEqRMZZFCcawDivkTSN6Se9gc78HGCAJS0
         jXJYJO0jj1ZkdjQBDnLKIjL2pKobQ8C3003NSAtj+/ijKe16X/cKV3pzSMc7uJcoBA61
         WUG20ja4vpQ/FNcF+UNSQ9AEpevdY+EGshBD8vTilySG80B9yjiJZxl1dKDCVH4aXClt
         QbQ3HFA5gU5pbdcPBM2gsfSpRix/iOq1xsQTngrltrN9sqvslqXgp3RvTObLwe6hqPd6
         p0tYwiIBH8GsiHFoNNGyNTIj9iZHvHfMqWyT4M5JAFmW/X71RMe5eQUxtlK4g+0YeTcC
         AY8g==
X-Forwarded-Encrypted: i=1; AJvYcCUSRD2/8qeiSRpwf1tXCd8N5FL4LNOPexHqmHnfOmIQ0rakYXLuQDA+4yehSwneeCpqIRSHWdxRxdaGiw6Pqg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyaiHh7wqWyZEAR0e8bmSI1UJiCZgPylypLuwP98tku0QdlgtN2
	AN7mfq+HLv55l+/JOSxEjK9QvVrCTe46Z0RMyD0MChe8oJDS5L8iFfIYOQ==
X-Gm-Gg: ASbGncviSU60UtgGEV+V3YBTWRPkZPIxk5CSZiZLpwIkrxIh8/ZEZuq//Swn73edwwX
	3Qs525P7Foyc7gDSvLYGEeBCdbdmz/ZsIupXclAxsX8tdPeiQZ2fLivXq2rNYBWAihlYlS3fvEy
	zkEAtmtfqx1hRL62OMjeR6yJq4DnGToVD4kbdrcrBMxuEO//y5LY4kn6A9zURhx/sGnQt9F2yP6
	Hwmw5t7AhUDV/74QKhOn0IjPYZYnJChHOqFFCYBz+BFCJxGQsHtaXqtJxa1SqsA
X-Google-Smtp-Source: AGHT+IFTW67wsctoE4rNWcvlaYWOukGYULjacgiSDx60SU2Ma3AQ6LbUc/nScM9YYi2k672lkQsAWg==
X-Received: by 2002:a17:906:801:b0:aac:180e:b1d4 with SMTP id a640c23a62f3a-aac180eb4a4mr62245866b.27.1734606993977;
        Thu, 19 Dec 2024 03:16:33 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.80])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-aac0e895080sm54227066b.47.2024.12.19.03.16.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Dec 2024 03:16:33 -0800 (PST)
Message-ID: <df141018-9981-44b3-bc40-29fd7898c809@gmail.com>
Date: Thu, 19 Dec 2024 13:16:31 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: rtlwifi: rtl8821ae: Fix media status report
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <754785b3-8a78-4554-b80d-de5f603b410b@gmail.com>
 <c4fdab007c15450dbd37f4570095d157@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <c4fdab007c15450dbd37f4570095d157@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/12/2024 05:47, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>
>> RTL8821AE is stuck transmitting at the lowest rate allowed by the rate
>> mask. This is because the firmware doesn't know the device is connected
>> to a network.
>>
>> Fix the macros SET_H2CCMD_MSRRPT_PARM_OPMODE and
>> SET_H2CCMD_MSRRPT_PARM_MACID_IND to work on the first byte of __cmd,
>> not the second. Now the firmware is correctly notified when the device
>> is connected to a network and it activates the rate control.
>>
>> Before (MCS3):
>>
>> [  5]   0.00-1.00   sec  12.5 MBytes   105 Mbits/sec    0    339 KBytes
>> [  5]   1.00-2.00   sec  10.6 MBytes  89.1 Mbits/sec    0    339 KBytes
>> [  5]   2.00-3.00   sec  10.6 MBytes  89.1 Mbits/sec    0    386 KBytes
>> [  5]   3.00-4.00   sec  10.6 MBytes  89.1 Mbits/sec    0    386 KBytes
>> [  5]   4.00-5.00   sec  10.2 MBytes  86.0 Mbits/sec    0    427 KBytes
>>
>> After (MCS9):
>>
>> [  5]   0.00-1.00   sec  33.9 MBytes   284 Mbits/sec    0    771 KBytes
>> [  5]   1.00-2.00   sec  31.6 MBytes   265 Mbits/sec    0    865 KBytes
>> [  5]   2.00-3.00   sec  29.9 MBytes   251 Mbits/sec    0    963 KBytes
>> [  5]   3.00-4.00   sec  28.2 MBytes   237 Mbits/sec    0    963 KBytes
>> [  5]   4.00-5.00   sec  26.8 MBytes   224 Mbits/sec    0    963 KBytes
>>
>> Fixes: 39f40710d0b5 ("rtlwifi: rtl88821ae: Remove usage of private bit manipulation macros")
>> Cc: stable@vger.kernel.org
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
> 
> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
> 
> Is this an urgent patch? or it's fine to go via rtw-next?
> 
> 

It's not urgent for me, rtw-next is fine.

