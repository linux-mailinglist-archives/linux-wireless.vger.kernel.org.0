Return-Path: <linux-wireless+bounces-28102-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 8ADC6BF1AE7
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 15:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id D348B4F5B7A
	for <lists+linux-wireless@lfdr.de>; Mon, 20 Oct 2025 13:52:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02843315D52;
	Mon, 20 Oct 2025 13:52:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QF+OL2Fv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3451A3126DA
	for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 13:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760968353; cv=none; b=DXqwd/rlTDt+Iuv3k7XjsU3ycE9oTcDggzg87ze55ItmmZ6rH8GGvawKJc9WzrR1NjecYFhJ5GUkJ9NrY8s7+0tZjFwMnqVcmoodCniblPKNWYw7trG7n8HnY6gxZIExVpiAUsvwf3uVFzM7J35sZ4fRrtWD0u7AT1L1WExLeMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760968353; c=relaxed/simple;
	bh=L9VvExNQMFPQzv9ufxn0S7G6OEJEHpE+ly+MsEQ8nFk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=oU1UGZFrD/0RNWPQZmaEJsksEp9GJFYbil5IPCkHmc/MUlqkvPc6fPRs50A8W26KoxWS1OcteeMznOG2NKJQDXz69rm2G3mrGxdGg812J9i3c/K40fmhWClDo0nUwUTwtBmAOpsgVM0h94tA0BMikbtZ7E7OBEJesWaNMRVLAPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QF+OL2Fv; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-63bad3cd668so8348066a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 20 Oct 2025 06:52:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760968350; x=1761573150; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=1UGdKvZUTvD1HC9bV9xmz6SaDGhGxaZdI9Atn8JmXDI=;
        b=QF+OL2Fv/FFyzoFj3K2yPwuMpSZidCXDWsLH/Uomi52I252JGnhdW6XRy493MwDQTB
         pK2fmBv6H0LZFlaszkl/7acHQPHCRcwakdEzNElkKlw4WYMySbH/Dm04V7wHmpF/0B+1
         K7HyteF+g5f+ItwWTwPJE54JDRou5AlCnYvAsSfJGYgxa0cCsEOYM3gtFvXpRI3OnuKJ
         gY92vB1vLo5vtfbqaF0lBS33KfwuIGMz3JpMNVQjX5sJSblEgzTNdb/CREWtesJexRau
         oZZ+4L1Th9/KxnZgU5D2bXKG7ZrJuGwDLvHXVTP5nE8+6OUawAJRJrMQj1iR6EQLikwo
         cCLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760968350; x=1761573150;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=1UGdKvZUTvD1HC9bV9xmz6SaDGhGxaZdI9Atn8JmXDI=;
        b=dU0y5RgO+GWvCI6ZNrPoR9iT5FLZERLxODqf06vcDpze8cvd7H+NKPWcbstIz2ae9Y
         x2R7E245oZjhqqmb69DOBEfw4OzntTmbvyw7k241xRw63RhYbUMkQ30976S5PH9u2zYV
         E57OvhbjWmmIjv//020agNi8EicD1JY1FMlrhYdQ7REwI8E69rFzkWqjaPUKtMzKHA8h
         CvKhNk9W/MJqwWUjKqHGwVz7s1qGviHD8d8is/LGlkbhkekUbNLmaBSdfZrEs7LJUmLL
         8Nnz3Mf8rQ5Eyd2mO2ghKNc0hCos+nXUwn/JuiPCy9ppRyVziC0THTszIlCSxntofYEx
         Sz6w==
X-Forwarded-Encrypted: i=1; AJvYcCWm+vYd+FDjE1nYTVN5GwVjO/2qa9CiJIkwZqn1daz9DPPlupTmA2js5Tj5kUCCP47aLq+FXmQgxmiCVNnBmA==@vger.kernel.org
X-Gm-Message-State: AOJu0Yz7NompgHe+czkcC0J0vdbSPCXqVXAuWv2gKUI1J1aam0STDNIH
	kbvY802vOlqw9j0YsLsJxWbfFeGKcOBTogGOEjeu4FLcT1Zeb5viVKNy
X-Gm-Gg: ASbGncu8AIzVeNcZqimXBT6mbPC2nbiMabl+f/POQ33If4oZwZeJFvfyp6WagbrlP0T
	8xXD5HOfcxAl1/8ntkq4kzvonhMCbLmXkLFM6anG6/yc0dZrPhqMX2ewVcWSaBsLiceTdg1YMQq
	VvRRvoL1SJ0hw95k51EWD/EtQHNnYAMW4sjmG/xEI6RPEPnufbDLlh9AOBvtY0VPtdPZB4HZ7KH
	T1axXfMwpvguYUitObMcbITREGPYzQ4kFmNoGUsTRqsaDKx1+2zevntdDAkoYGi6QTPX3XQ2ViI
	df/Rh5Kvy+/P2kIs4+qif7AKPIdtND5V+2/j1c2/1P9Mo1EnOsidXFcrvm4oYCgtxIKyVi3wsnd
	y1Uw21ezV9LfW8Y9kvcW34iR9gnbHXKRRodRE1SNLUcP7CBdHMuzao+OhmDZfnfTRrdEDgXl6mg
	r+bp8oYRWCmSIGiEto9MA=
X-Google-Smtp-Source: AGHT+IGN9Ml+OP2NvHjesJEq5dF5EGJ7a6HBrdQ+6tbmakoJkB810olLr3jHQQV8/X9lmDdR0PGzeg==
X-Received: by 2002:a17:907:86ab:b0:b45:8370:ef08 with SMTP id a640c23a62f3a-b6473243f2dmr1566956366b.17.1760968350263;
        Mon, 20 Oct 2025 06:52:30 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b65e83960e6sm790452766b.33.2025.10.20.06.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Oct 2025 06:52:29 -0700 (PDT)
Message-ID: <20f1dc07-2762-4f18-876d-f763eb414d3d@gmail.com>
Date: Mon, 20 Oct 2025 16:52:27 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH rtw-next v2 0/7] wifi: rtw89: improvements for USB part
To: Fedor Pchelkin <pchelkin@ispras.ru>
Cc: Ping-Ke Shih <pkshih@realtek.com>, Zong-Zhe Yang
 <kevin_yang@realtek.com>, Po-Hao Huang <phhuang@realtek.com>,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 lvc-project@linuxtesting.org
References: <20251002200857.657747-1-pchelkin@ispras.ru>
 <88f30433-98fa-4f9a-bbe3-9d630b72c2e4@gmail.com>
 <20251011171303-6e37619c4071ee0bae4f9675-pchelkin@ispras>
 <ebc5ede8-cf00-47a3-8a78-d9475f42cf97@gmail.com>
 <20251015002601-e7a307b2e8320369124054bc-pchelkin@ispras>
Content-Language: en-US
In-Reply-To: <20251015002601-e7a307b2e8320369124054bc-pchelkin@ispras>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/10/2025 00:33, Fedor Pchelkin wrote:
> On Sun, 12. Oct 01:49, Bitterblue Smith wrote:
>> On 11/10/2025 17:57, Fedor Pchelkin wrote:
>>> On Sat, 04. Oct 20:37, Bitterblue Smith wrote:
>>>> I tested these patches with RTL8851BU, RTL8832AU, RTL8832BU, RTL8832CU, and
>>>> RTL8912AU. They all work, with a few additions.
>>>>
>>>> Before these patches RTL8851BU and RTL8832AU would remain "connected" when
>>>> I power off the router. That's because they don't have beacon filtering in
>>>> the firmware and the null frames sent by mac80211 were always marked with
>>>> IEEE80211_TX_STAT_ACK. With these patches they disconnect immediately when
>>>> I power off the router. So that works nicely.
>>>>
>>>
>>> Glad to hear, thanks for the insight.
>>>
>>>> What doesn't work is TX reports for management frames. Currently rtw89
>>>> doesn't configure the firmware to provide TX reports for the management
>>>> queue. That can be enabled with SET_CMC_TBL_MGQ_RPT_EN for the wifi 6 chips
>>>> and with CCTLINFO_G7_W0_MGQ_RPT_EN for RTL8922AU.
>>>
>>> I'll investigate. Looks like the enabling of the management part should go
>>> to rtw89_fw_h2c_default_cmac_tbl().
>>>
>>
>> Yes, and rtw89_fw_h2c_default_cmac_tbl_g7().
>>
>>> Btw, could you give a quick hint please on how I can check during testing
>>> that the reporting facility works properly for all cases needed?  By far
>>> I've dealt with iw utility and debugging printks incorporated into rtw89
>>> but it doesn't look sufficient anymore..
>>>
>>
>> I enabled RTW89_DBG_TXRX, which let me see that no TX reports appeared
>> during authentication and association. I also added a printk where the
>> IEEE80211_TX_CTL_REQ_TX_STATUS flag is checked. Then I just use the
>> driver normally, with wpa_supplicant and NetworkManager.
> 
> Thanks, Bitterblue!
> 
> By the way, do you see lots of "parse phy sts failed\n" messages printed
> when RTW89_DBG_TXRX is enabled?  (it's with RTL8851BU in my case)
> 
> I wonder whether this is kind of a normal failure case or an indicator of
> a firmware bug.
> 

Yes, I see that with RTL8851BU, RTL8832BU, RTL8832AU. I didn't
investigate.

> Just to point out, I've activated your workarounds from [1], otherwise
> the device is unusable due to firmware unresponding during scan and
> crashing eventually.
> 
> [1]: https://lore.kernel.org/linux-wireless/0abbda91-c5c2-4007-84c8-215679e652e1@gmail.com/
> 

Maybe I should send a patch for that. I thought it was an easy problem
and the firmware will be fixed before 6.17. Then I forgot about it.

>>
>>>>
>>>> The other thing that doesn't work is the TX reports are different for
>>>> RTL8852CU and RTL8922AU. It's only a small difference for RTL8852CU:
>>>>
>>>> #define RTW89_C2H_MAC_TX_RPT_W5_DATA_TX_CNT_V1 GENMASK(15, 10)
>>>>
>>>> RTL8922AU is more strange. It needs something like this:
>>>>
>>>> #define RTW89_C2H_MAC_TX_RPT_W12_TX_STATE_V2 GENMASK(9, 8)
>>>> #define RTW89_C2H_MAC_TX_RPT_W12_SW_DEFINE_V2 GENMASK(15, 12)
>>>> #define RTW89_C2H_MAC_TX_RPT_W14_DATA_TX_CNT_V2 GENMASK(15, 10)
>>>>
>>>> The C2H is 80 bytes here (header included).
>>>
>>> rtw89_mac_c2h_tx_rpt() needs to account for different types of C2H report
>>> formats, bah.  Will add this missing part.
>>


