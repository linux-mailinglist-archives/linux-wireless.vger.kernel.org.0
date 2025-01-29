Return-Path: <linux-wireless+bounces-18170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C6A62A226C4
	for <lists+linux-wireless@lfdr.de>; Thu, 30 Jan 2025 00:14:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4C3537A2384
	for <lists+linux-wireless@lfdr.de>; Wed, 29 Jan 2025 23:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 66C8B18FDCE;
	Wed, 29 Jan 2025 23:14:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RzkVcS37"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D1AB372
	for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 23:14:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738192469; cv=none; b=dYaWYJPppfRhdpb8ZdZMHURMOm5uSaV1bHK0bccvAFFUFs98Y/u6N/xgbOjNO8k36h+raE3HGso6RDnNDnB4JPcmGFNuZxe9XupRr/d2W2D0WBa6qKLApAAeHvg4tpMyqAmFwDQiK4IpK8HsR9aP0tU2arePFfbyEmyFQP8eQZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738192469; c=relaxed/simple;
	bh=p73vpTc4AKF5/5V0cFoDpRN71BHaXQAaO7Spq+V0LxA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=TWmfUOmuwD2Bz+8YdMIaAH+lXCW+0hDC4+wMO7ZMaxh/hDSrMYYuQLlFC/8riK3gRjDquGKNwryjUR1C88FSdLHK/0i+Ikipo1z9qUkeLLFCaP51rovzO/ao8zU/N8FqzHvIScQ+qYNKFr2ipLvcNEF4OHTw5p3K5e9q9wM/brY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RzkVcS37; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-437a92d7b96so1278695e9.2
        for <linux-wireless@vger.kernel.org>; Wed, 29 Jan 2025 15:14:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1738192466; x=1738797266; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=avf8UP17Z4OTfSlRn6G8MIIGc+As6mWpW3jJ8mbtKZM=;
        b=RzkVcS370o5rUcWnwFbfBSMF8bm54T6TfZGqC1zfXb7EDOOsbl3Ymgwk7CdSvqLUpi
         YtMGgTjdMD54FlQcsjFvkMEN0/1oCWgxgtCBLvaALQNISUoF7Xdd/EVyYIRtzioAJ94k
         fWAjNIjU6pIpj1yq2RDMy4DnX7ZAavVc/C+rh8+u8+FxloXm9HhfE1Nf1imYI7QAcN4y
         BXNZuvaXfspvpptxCIFzPmx1+ZYiTg2v3Tva1y0O8au++nqJIwUMHw6E2fQAYbrDaorM
         xIIynJtHIAXdwk7nc5Rcv0MS3w7C2+OnFXbDtwof2cAgwgE28ZzzDUc3jkcDLh7et1W3
         Mk+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1738192466; x=1738797266;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=avf8UP17Z4OTfSlRn6G8MIIGc+As6mWpW3jJ8mbtKZM=;
        b=i9EJ2aUp36o41Hz5I5gpqYElb4nr/Z5Au/UcGVUdQfFwgZiaMMXwbVPgc85Tkf0iAq
         giwUyfg9dslct9G86Dmi0KCIvZXOS1/sqrdL/fSfb6pMAff/6rX0v2nn7npb9Kx0/yHJ
         gl3aBeMr4mltdvNYG+7fwpSAbu+EdYWpfsHJ6SW86RAFFNKto9fp/8vBKX8rNve5KGHU
         eW/p9jtKS4rSJhdFoNjrUWBuzRnAYsLQePr8N+N/vK3UE3kZQSGuc/7hto/FAp/p/028
         fD70OGpnE/kXQ3ePeMvx4BgCk4j94IUXuY266oBJrgC+5M7jD7dXtLLeIoWIblTRNHRJ
         /63Q==
X-Forwarded-Encrypted: i=1; AJvYcCUxM8nlipD32udtj/vDj6PuuGC9Zn+zf4NCI6bWih3V5sD2ElVVlCdez0Wv0C8fmbci2HEFFyKkm1MDg3iR4g==@vger.kernel.org
X-Gm-Message-State: AOJu0YzvI7Hp+nxFZvhtlQ1aERMFLKFYzDmFCUdN7ax5S+hBgHIiWQN4
	8IGC4j5yVargbU8Ugc+G9RV/yXtcbMPG3ZEYxeEJIglrqkeimdLYBNqPzA==
X-Gm-Gg: ASbGncsigrzFAxH7WItvbpQtJhuf+k1dw53RURRVxvjp1Ngb9odNHGM3PKOHTCLBQ/X
	FVHSTMivDwWY9cA/UCMbO9P8m7eKCD3aQg+Tcz8/fqNf1wMn9xM5ms1vmzjMptj6MQtqsuENnhK
	JI1vbl+tUhPdFp1HGGIzaG+jY3jCKKIbVRFgdxkOSIcSDebLUD/lOHnI2R7yUObwjhlyudyhRzY
	hZSBElQmOMV0K50BXS8LeAcUBuQmo1h+yuy3Vouq+WjYJhZH2p7xo8q56jKeM6alJJd6q/RzVMy
	zO5sf4DsxSFhKFrfiwFSFbjO
X-Google-Smtp-Source: AGHT+IFcU7b4U+aIKdBMA065O6+2LKEoAThIkODsUtBJ2P/gFrWcqfyEBGA1i8xTjVIZQsX0I7n4mg==
X-Received: by 2002:a05:600c:3b23:b0:436:f960:3428 with SMTP id 5b1f17b1804b1-438dc42ff3cmr45467785e9.29.1738192465502;
        Wed, 29 Jan 2025 15:14:25 -0800 (PST)
Received: from [192.168.0.50] ([79.119.240.253])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-438dcc27130sm37396445e9.16.2025.01.29.15.14.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2025 15:14:24 -0800 (PST)
Message-ID: <86aae394-be5d-4fca-a68c-2ee02e5ab6af@gmail.com>
Date: Thu, 30 Jan 2025 01:14:23 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/7] wifi: rtw88: Extend rtw_fw_send_ra_info() for
 RTL8814AU
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <fb2c2ae6-6173-4b4a-9e1f-ff51759cdee6@gmail.com>
 <fa9ff2b4-6e1a-45e4-90de-db6fe0d4f433@gmail.com>
 <ca7380d8560046c4a2a2badde9302691@realtek.com>
 <d05ba9e5-d5e3-4761-bd1e-f7c2b63f5a36@gmail.com>
 <53740c9ec74a4aa0a5a3c51b895eb385@realtek.com>
 <d80fe4e2-1e38-4e84-b169-8c2699d7c764@gmail.com>
 <1f04331c713141c68e6892751611d01e@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <1f04331c713141c68e6892751611d01e@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/01/2025 04:43, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> On 28/01/2025 07:52, Ping-Ke Shih wrote:
>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>> On 27/01/2025 08:36, Ping-Ke Shih wrote:
>>>>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>>>>> The existing code is suitable for chips with up to 2 spatial streams.
>>>>>> Inform the firmware about the rates it's allowed to use when
>>>>>> transmitting 3 spatial streams.
>>>>>>
>>>>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>>>>> ---
>>>>>>  drivers/net/wireless/realtek/rtw88/fw.c | 14 ++++++++++++++
>>>>>>  drivers/net/wireless/realtek/rtw88/fw.h |  1 +
>>>>>>  2 files changed, 15 insertions(+)
>>>>>>
>>>>>> diff --git a/drivers/net/wireless/realtek/rtw88/fw.c b/drivers/net/wireless/realtek/rtw88/fw.c
>>>>>> index 02389b7c6876..0ca1b139110d 100644
>>>>>> --- a/drivers/net/wireless/realtek/rtw88/fw.c
>>>>>> +++ b/drivers/net/wireless/realtek/rtw88/fw.c
>>>>>> @@ -735,6 +735,7 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
>>>>>>  {
>>>>>>         u8 h2c_pkt[H2C_PKT_SIZE] = {0};
>>>>>>         bool disable_pt = true;
>>>>>> +       u32 mask_hi;
>>>>>>
>>>>>>         SET_H2C_CMD_ID_CLASS(h2c_pkt, H2C_CMD_RA_INFO);
>>>>>>
>>>>>> @@ -755,6 +756,19 @@ void rtw_fw_send_ra_info(struct rtw_dev *rtwdev, struct rtw_sta_info *si,
>>>>>>         si->init_ra_lv = 0;
>>>>>>
>>>>>>         rtw_fw_send_h2c_command(rtwdev, h2c_pkt);
>>>>>> +
>>>>>> +       if (rtwdev->chip->rf_tbl[RF_PATH_C]) {
>>>>>
>>>>> Using `efuse->hw_cap.nss >= 3` would be consistent with latter patch.
>>>>>
>>>>
>>>> I would like that, but nss is 2 when RTL8814AU is in USB 2 mode.
>>>> I assume this is to keep the current draw under the 500 mA limit
>>>> of USB 2.
>>>>
>>>> What about rtwdev->hal.rf_path_num >= 3 ? I don't remember why
>>>> I didn't do that.
>>>
>>> I think `rtwdev->hal.rf_path_num >= 3` is suitable to initialize/configure
>>> hardware registers, because no matter USB 2 or 3 mode should be the same.
>>>
>>> For this case (RA info), this is related to protocol, so I feel
>>> `efuse->hw_cap.nss >= 3` is suitable, but I have not seen a patch to declare
>>> supported NSS in register_hw(), or I missed it? Or, without RA_INFO_HI,
>>> it gets abnormal rate to RTL8814AU in your test?
>>>
>>
>> You didn't miss it, that will be in part 3. You can see the code here:
>>
>> https://github.com/lwfinger/rtw88/blob/21a3fa7ec11a0cbb3be14145f45cdca35c3d3217/rtw8814a.c#L82
>>
> 
> I feel we should clearly define the meaning. What I thought for 8814AU are:
>  - hal->rf_type: hardware capability. Should be RF_3T3R no matter USB 2 or 3.
>  - hal->antenna_tx: the antenna for current TX. Can be 2 antenna.
>  - hal->antenna_rx: the antenna for current RX. Can be 2 antenna.
>  - efuse->hw_cap.nss: read from efuse. So this will be 3SS for USB 2/3.
> If you have better defnitiion, please share your ideas. 
> 

If efuse->hw_cap.nss is always 3, how to limit the spatial streams
to 2 in USB 2 mode?

> Also, I would want to point the mcs_map implemented in rtw_init_vht_cap().
> 
> 	if (efuse->hw_cap.nss > 1) {
> 		highest = cpu_to_le16(780);
> 		mcs_map |= IEEE80211_VHT_MCS_SUPPORT_0_9 << 2;
> 	}
> 
> This can only support up to 2SS, and I'm not sure if 'efuse->hw_cap.nss' is
> still sutiable for 8814AU.
> 

rtw_init_vht_cap() will be fixed in the next patch set:

https://github.com/lwfinger/rtw88/blob/21a3fa7ec11a0cbb3be14145f45cdca35c3d3217/main.c#L1718

>>
>> With RA_INFO_HI the first C2H_RA_RPT comes at the normal time,
>> before the first CTRL-EVENT-SIGNAL-CHANGE:
> 
> So, how about sending RA_INFO_HI unconditionally for 8814AU
> (just check chip ID as condition)?
> 

I guess that's fine.

