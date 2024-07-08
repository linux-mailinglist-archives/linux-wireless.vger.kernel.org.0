Return-Path: <linux-wireless+bounces-10075-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 88B3792A2C7
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 14:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B993F1C21517
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 12:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B0CC811E6;
	Mon,  8 Jul 2024 12:25:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lMbElQzW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8141680624
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jul 2024 12:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720441551; cv=none; b=OHTgf2mroWnRxtxB0oVHdPzf4NPIHdtOQpn42a6v9v3QWW9AV9EUbJ47l0+KuPAj46ML8R1ckwmqTUK90DqVxTulm4Y1164zRC/j0KpgLpco+JZ9wgIA5BemYZTl1Pws/iff21IZ4FrC7MgCeL5/C7///u5tgSWlEVppenlJdRg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720441551; c=relaxed/simple;
	bh=evazjV3TjwJ8LhIWf5vQtfn8uLAqnOCsu689EbhoAgg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=fcQF+aiRz8NaaG315qpthqUIJCWiE3XqAbiwvWCsHqqbaWn022Nh/k6ea+zcwvzf+IkxGsV0hkXsV0zvUKUWPpIBpz/lrxlxFNS6jdohsJTX6aZwF4+BOg+jlf8NDqANBza2hdzHCYitkCd5w2y/nWL+7Sg0WcuNMGqnFiSpQP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lMbElQzW; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-a77dc08db60so290477066b.1
        for <linux-wireless@vger.kernel.org>; Mon, 08 Jul 2024 05:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720441548; x=1721046348; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SmWkVDLUJRNwpOuIitPKwJHj7L8QDU1XG7/+2VG0TY0=;
        b=lMbElQzWWBb2L2XmD0hgCfy4KT1PTLB2v6auoL1neiD1U0GMZWm4c/YRYmT7QBzagj
         Tc/LEhPsdzSLmtrLREK88cvCmmfeBbyCTX4fNXSDaw3ZE/YTKzEzfH9Rm7yAfEnd0VYJ
         6Z1Cq1crrs7kW2PZAeBEODgxwe0MjscIL5+UJhvTTeT/QNNwErqSWy1Ei9XB/MC/L5jG
         A0wot411wRaFnI+2mlaQe4HcQqevgR1rulCoSf5ljztt+iLH0xoYq7+z7pk8JQlTzR4j
         cy9mKlKSCuMZ8vZEdOVoARz1yOdUYPGfZOGzmp4n+7o9xD3JBRVuJaJgIEdQ1ENtbbXM
         +alg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720441548; x=1721046348;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SmWkVDLUJRNwpOuIitPKwJHj7L8QDU1XG7/+2VG0TY0=;
        b=WDSzTjlES3morMVKK1KO9nkTxAPjNYv3566cS3vjoNDmDgbw4Cw2I+OfY5FcMTktmd
         dUpI8drSleRnXb6zxVm3j6X0uN+p5oBaE4gd8+Bp2+uMMOc/Kfb/IdIHMfKD70LUMxy7
         qDG+yvt05FVABCnG2Qw+FJFNGzTUEK3k566A2MBhqlo5kvcE0Sl4y60VoPv7t7I7sxQK
         7OdpM5Ax8tQjLWLY5CUzAjLi19jhcPKNyhN9oVFrn8RPPEAWag/JL/NRLp/wiWsLDKMH
         DfBxbWP7XngwhQ/Nowx75I/PFLEPCsive1cnnmkQ4nN687MvhPiOzWwx2awGvGz4FUai
         JDoQ==
X-Forwarded-Encrypted: i=1; AJvYcCUBt9SWlYVNy8sktuCZkiDaT7n7/q8s/ic5zknRGw658oxcT5h5kJUH74O53MQzWTSBV/8SDVmXO0umFsS7xu3UG5hke+irgWKl+q7VU1I=
X-Gm-Message-State: AOJu0YxOPVX00Yh43Op5TCmGiKiNREuvR4OVFMTu94ul2QXmvvY73br3
	Xl9cgMj00rMtXpBImC4ilpbWPkzmCHj0MUy6RIp6e+3FKrKl16AMvJojLw==
X-Google-Smtp-Source: AGHT+IFLnV0H4NNmqGUyNQRdgjuZ1XkuOgBi3ZMOAUvunN4SE23JBZlcbYZf5La4wxVfET9mqHXbAQ==
X-Received: by 2002:a17:907:724e:b0:a72:aeff:dfed with SMTP id a640c23a62f3a-a77ba70d7fcmr1083704866b.53.1720441547467;
        Mon, 08 Jul 2024 05:25:47 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.1])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a72ab08d138sm923937566b.158.2024.07.08.05.25.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 08 Jul 2024 05:25:47 -0700 (PDT)
Message-ID: <3f2900e7-9a98-4bc9-bc0d-631dd9de7da0@gmail.com>
Date: Mon, 8 Jul 2024 15:25:45 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH] wifi: rtw88: usb: Support USB 3 with RTL8822CU/RTL8822BU
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Kalle Valo <kvalo@kernel.org>
References: <2378105e-041a-4973-937f-e3efdc9ce0e8@gmail.com>
 <a60a7a6d0ab04b3ab1690a2c473b8e69@realtek.com>
Content-Language: en-US
In-Reply-To: <a60a7a6d0ab04b3ab1690a2c473b8e69@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 08/07/2024 12:19, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> The Realtek wifi 5 devices which support USB 3 are weird: when first
>> plugged in, they pretend to be USB 2. The driver needs to send some
>> commands to the device, which make it disappear and come back as a
>> USB 3 device.
>>
>> Implement the required commands in rtw88.
>>
>> When a USB 3 device is plugged into a USB 2 port, rtw88 will try to
>> switch it to USB 3 mode only once. The device will disappear and come
>> back still in USB 2 mode, of course.
>>
>> Some people experience heavy interference in the 2.4 GHz band in
>> USB 3 mode, so add a module parameter switch_usb_mode with the
>> default value 1 to let people disable the switching.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
>> A later patch will add the function rtw_usb_switch_mode_old() for the
>> older chips RTL8812AU and RTL8814AU.
> 
> [...]
> 
>> diff --git a/drivers/net/wireless/realtek/rtw88/usb.c b/drivers/net/wireless/realtek/rtw88/usb.c
>> index a55ca5a24227..a59e52a0da10 100644
>> --- a/drivers/net/wireless/realtek/rtw88/usb.c
>> +++ b/drivers/net/wireless/realtek/rtw88/usb.c
>> @@ -14,6 +14,11 @@
>>  #include "ps.h"
>>  #include "usb.h"
>>
>> +static bool rtw_switch_usb_mode = true;
>> +module_param_named(switch_usb_mode, rtw_switch_usb_mode, bool, 0644);
>> +MODULE_PARM_DESC(switch_usb_mode,
>> +                "Set to Y to switch to USB 3 mode (default: Y)");
>> +
> 
> I feel we should say "Set to N to disable switching USB 3 mode to avoid
> potential interference in the 2.4 GHz" like your commit message. That could
> be helpful to users.
> 

Sounds good.

>>  #define RTW_USB_MAX_RXQ_LEN    512
>>
>>  struct rtw_usb_txcb {
> 
> [...]
> 
>> @@ -896,6 +972,14 @@ int rtw_usb_probe(struct usb_interface *intf, const struct usb_device_id *id)
>>                 goto err_destroy_rxwq;
>>         }
>>
>> +       ret = rtw_usb_switch_mode(rtwdev);
>> +       if (ret) {
>> +               /* Not a fail, but we do need to skip rtw_register_hw. */
>> +               rtw_info(rtwdev, "switching to USB 3 mode\n");
> 
> All logs in this patches should be rtw_dbg(), because these messages are not
> important to users.
> 

Okay, I will add RTW_DBG_USB to enum rtw_debug_mask.

> 
>> +               ret = 0;
>> +               goto err_destroy_rxwq;
>> +       }
>> +
>>         ret = rtw_register_hw(rtwdev, rtwdev->hw);
>>         if (ret) {
>>                 rtw_err(rtwdev, "failed to register hw\n");
>> --
>> 2.45.1
> 


