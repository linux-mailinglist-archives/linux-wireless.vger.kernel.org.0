Return-Path: <linux-wireless+bounces-24818-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 45734AF8F39
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 11:54:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFF444A2478
	for <lists+linux-wireless@lfdr.de>; Fri,  4 Jul 2025 09:53:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AB0E2EAD11;
	Fri,  4 Jul 2025 09:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kY/EH/fV"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B3728689A
	for <linux-wireless@vger.kernel.org>; Fri,  4 Jul 2025 09:54:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1751622845; cv=none; b=pd66IbzuXsgbjZL9CWQ4cs8aD8KkBJwwu4/ftvYOgLemTQEx+LkMZTUwAVcXXzXE9psfPdba+l+jFvRq+hcV7vPG62F9TYyLBnW8Ivtlf0Qvx/sClz7wuRYwrs5aqnWWCM+9mq5HeUnFPOJUGnHnoPRgspMwjkXQ1t0jn4z+FVg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1751622845; c=relaxed/simple;
	bh=7tofie9Z+QIqWJE/gxd4Qq7/YWCs23ub0OH8ynlX3gE=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Qm60hTVgtF434M+JNb4NpihygjCKiV8kyoXyIix/bDqHzt85I5G2uXDC2E7YW894hRChwdbwmKUP1YY+1CSDuEm1m9OoSoDzGCjMWhtLnc+jWsQXKiTX/O3dKo/KYrhuZgdnI7elB7NXGO42XWciQ6o4dnHHkujXNGErx3+tlDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kY/EH/fV; arc=none smtp.client-ip=209.85.128.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-4530921461aso5173555e9.0
        for <linux-wireless@vger.kernel.org>; Fri, 04 Jul 2025 02:54:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1751622842; x=1752227642; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B9KVe91w703mNefwUBfD3/84oRiZ024EdtbQhOcD4Bc=;
        b=kY/EH/fVAEjWmNnrfxowV4+rfHSvgFnW1/f2ZobElTfYRLV885z6GIXZa++mWN1C3+
         lwhLcpM/T1SQ+5cvpxDsT4x/OwI9bPDMD7GJZnpR6H7MLGC5TpN5O2v750i076RDE6jc
         B2VbqS0FFA1DDbpzOeZoQo315ZrPjWX+g310HUVVqlOTVTTWEMce/yGX1JWV8GI0puVU
         xU9JzH4x5so+pAPMWam96RIf4pGSc26UIZ75U0ZBZ1o2KC0FamdCsaSvN7mA+y0u+UHE
         vUEBueDL/0C7IHGV/30VhJF906j9S70nVkzHviJP/eNu5+ekcEnv7WSbZnLqS1ffQAgl
         MxRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1751622842; x=1752227642;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B9KVe91w703mNefwUBfD3/84oRiZ024EdtbQhOcD4Bc=;
        b=O06WwkHab85awC6fAAe7Mky5dJG/H7vaVp/7THfu/OMMvorBHkMzyBO7UmFLtVC4ev
         aS0UMdsw5eaYZwx3TS8c7Auo94hOfj9tcgjolHe4WuJ/87FiX2+a5v+9iArz0uj39xQc
         CTdypu4LNgPFSG4jxODdj7BMZAoJarTbwT7imTmftzSLhqCmmtEsQk+e3VDB7MS+Ztcn
         wLNkq2P9oqD+te7LoESdn9cgvD7yVYg5dt+SMdSGsxzX0e7C64Xk+dkkyAy7i+T+AlAZ
         xFPTjgQ2MXUmqcJdwWMfLTHfvZeMucVygPqorobFDInle1B0gkCNokRmlrr5YQbkS2Xo
         xpLg==
X-Forwarded-Encrypted: i=1; AJvYcCVhkyGXslvr0eRs/b7mUFOKuz88objQqkX9IqtFHl83MfViOeWUH5TQqimNzkUijU5vsSnIYJ91wY+Pjzyf+w==@vger.kernel.org
X-Gm-Message-State: AOJu0YzrD1z41ZzUvfZYw4AXQn3rNIWZ1hy/yMQVwYf+Tk6BVu+cp+Oz
	yD04TeAxfGKh44Wue8Kira3xVZpQmuhvnFs6yhYKCD5zdhpAS8ha1bRL
X-Gm-Gg: ASbGncv7xASEFYeJj2uqBnW2aBnTZsAikqf1r+S0TR73fZXBTOhsOk4Usm2X7TZixtX
	yfy72tYOXiC9dMRl9Xm4h6JMRWFYKLiqQ9voNAtDobE0Mp/cMW20qbR56kcmGoIRECVzXJWBFvP
	BP7dqnoGct/6cqeVa7mKR87o9aUI48vxbIlv9S0iWoB6XlH8bKso0spdDXrumFKDVYnNpquW20I
	us7j3lYbA7BqnBvGA8uYh0z73nqgZlK68RHXIxFivjoAws/geFpd4zV1EKzRfe3itSHJEfGopWu
	RMwQKEBeMrpXrSNx8gtEwUCeWAn1NieVPf74N2sY9vVZmkiccF0S6CnwnTj8C7w3GYVcoQ==
X-Google-Smtp-Source: AGHT+IHjh9Wuiwk+Utg9B3miPDJZruZhMqKtNZJarrSvQnqYFHu9WZ1KzyVIwKUtNxbb/Inq2I1jDA==
X-Received: by 2002:adf:e18d:0:b0:3a9:16d5:cacc with SMTP id ffacd0b85a97d-3b4966023b6mr1360907f8f.49.1751622841565;
        Fri, 04 Jul 2025 02:54:01 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.43])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-454a9bcececsm50900175e9.23.2025.07.04.02.54.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Jul 2025 02:54:01 -0700 (PDT)
Message-ID: <727d5933-7b6f-4c6b-a7d6-9a5c0606fd46@gmail.com>
Date: Fri, 4 Jul 2025 12:53:59 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH rtw-next v4 01/14] wifi: rtw89: 8851b: Accept USB devices
 and load their MAC address
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <7880bca2-17de-4d55-93a1-16977dd6502e@gmail.com>
 <6b2a1382-3be4-4038-8005-cf96922e4332@gmail.com>
 <69ad0a30-b5f6-4312-b4f4-317d715d5a25@RTEXMBS04.realtek.com.tw>
 <dde8077adb654294901a42ac078e5751@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <dde8077adb654294901a42ac078e5751@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 04/07/2025 06:36, Ping-Ke Shih wrote:
> Ping-Ke Shih <pkshih@realtek.com> wrote:
>> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>>
>>> Make rtw8851b_read_efuse() accept USB devices and load the MAC address
>>> from the correct offset.
>>>
>>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>>> Acked-by: Ping-Ke Shih <pkshih@realtek.com>
>>
>> 14 patch(es) applied to rtw-next branch of rtw.git, thanks.
>>
>> 4b6ea5a38197 wifi: rtw89: 8851b: Accept USB devices and load their MAC address
>> ee47816f24a1 wifi: rtw89: Make dle_mem in rtw89_chip_info an array
>> 82870ba25f32 wifi: rtw89: Make hfc_param_ini in rtw89_chip_info an array
>> 3c63450c8723 wifi: rtw89: Add rtw8851b_dle_mem_usb{2,3}
>> 02a44c263031 wifi: rtw89: Add rtw8851b_hfc_param_ini_usb
>> a3b871a0f7c0 wifi: rtw89: Disable deep power saving for USB/SDIO
>> ec542d5e4bf6 wifi: rtw89: Add extra TX headroom for USB
>> 0740c6beefae wifi: rtw89: Hide some errors when the device is unplugged
>> e906a11753c9 wifi: rtw89: 8851b: Modify rtw8851b_pwr_{on,off}_func() for USB
>> e2b71603333a wifi: rtw89: Fix rtw89_mac_power_switch() for USB
>> ed88640ea1ac wifi: rtw89: Add some definitions for USB
>> bd569751baff wifi: rtw89: Add usb.{c,h}
> 
> My work flow missed to build newly added usb.c, causing sparse warning.
> 
> Fixed by:
> 
> diff --git a/drivers/net/wireless/realtek/rtw89/usb.c b/drivers/net/wireless/realtek/rtw89/usb.c
> index 72870a80f801..6cf89aee252e 100644
> --- a/drivers/net/wireless/realtek/rtw89/usb.c
> +++ b/drivers/net/wireless/realtek/rtw89/usb.c
> @@ -210,7 +210,7 @@ static void rtw89_usb_write_port_complete(struct urb *urb)
>                 txdesc = (struct rtw89_txwd_body *)skb->data;
> 
>                 txdesc_size = rtwdev->chip->txwd_body_size;
> -               if (u32_get_bits(txdesc->dword0, RTW89_TXWD_BODY0_WD_INFO_EN))
> +               if (le32_get_bits(txdesc->dword0, RTW89_TXWD_BODY0_WD_INFO_EN))
>                         txdesc_size += rtwdev->chip->txwd_info_size;
> 
>                 skb_pull(skb, txdesc_size);
> 
> And push out (force update):
> 
> ed88640ea1ac wifi: rtw89: Add some definitions for USB
> 2135c28be6a8 wifi: rtw89: Add usb.{c,h}
> 52cf44323785 wifi: rtw89: Add rtw8851bu.c
> 0030088148d5 wifi: rtw89: Enable the new USB modules
> 

Thank you for fixing that. I ran sparse on v3, but I must have forgotten
to run it on v4.

