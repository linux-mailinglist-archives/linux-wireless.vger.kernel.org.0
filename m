Return-Path: <linux-wireless+bounces-4916-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C669288024E
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 17:29:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3CCA3B23A09
	for <lists+linux-wireless@lfdr.de>; Tue, 19 Mar 2024 16:29:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A71A2E62A;
	Tue, 19 Mar 2024 16:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QaoTIUYg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lj1-f179.google.com (mail-lj1-f179.google.com [209.85.208.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66D0C657CC
	for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 16:28:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710865729; cv=none; b=hWi/uNxjKmRohXYQWAYaSV98YZQam/LAJkVNDdMLhRxs36QfjCPH7pzPCFvr6X52Qy06gsChR+vY1x5aU6VOFbcSj6HvN2aHXo/VF/DYYUEQtKKGj1UJibVmr/E21QdpiC+h64gqRT1R4NnMVtUAA1et+2qrK4e51t/DlLwBWXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710865729; c=relaxed/simple;
	bh=Y6DOV5/wfCqa/pECqjs+gqc1PtsSle6MTtpi/Znvaqk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=Dkqhwm1HLYh9StDZCdQh7BJVoPdkUzMBiLVqhSP9caQApsdvWrAyHLeJRmCw6Nx8NyhT2hjI55LoNo8RMDJoS8TFstqcQUczfZI9vqcxhlZf2sdkcPBsDQFX1AjmiCVbXKothgjDMDry5s4xXDIzo0/MhI7aiqqkNqtvWUPkJtE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QaoTIUYg; arc=none smtp.client-ip=209.85.208.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lj1-f179.google.com with SMTP id 38308e7fff4ca-2d41d1bedc9so101764991fa.3
        for <linux-wireless@vger.kernel.org>; Tue, 19 Mar 2024 09:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710865724; x=1711470524; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bZPNpc9mOi/aLEZkQnveHGtETHmlESkKOyB7eJHOdCk=;
        b=QaoTIUYg1JaXZOyOZWWoWZZHg45OL0wlu/ClYIrLIyQObTmsoE5DMafpHekiRLfVgY
         e8MXkl2XbMXs+VFeCyhyrIO9MRy/Ot5OL5fu8EhGZJOIfmcA3rz+XGP5tZVCBMXyc8ln
         V0Hc2jgDsYW5zwsVx2OZafnL3SijluVUwrU2ksQvTDYamopLFuNgS3nN7dY3GYJlRLIT
         W+/un9OJK6xANsuYCkmht9QCQ5w3KoIrBizDoMzEwoIHCkS87wrihdWK7RhSAD/wTdQ7
         Nh8QTD0z61iRDF5Is0xibWQluLLwv0hHPb4iMhgpDuBoUsOShJSkdpVzQpPQv5xtYsuJ
         ZLIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710865724; x=1711470524;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZPNpc9mOi/aLEZkQnveHGtETHmlESkKOyB7eJHOdCk=;
        b=pibOEkFEPsmNJ9F9M0RCsZR+cSGsZAQWrR6It2WMCvII5syZ9Boh9hlEnUoiip5DYv
         U1YGyTkm9FjzLS+BciOU5hVvtk93mzXB0yLVkN6BWjr4faq2Hf8+zEBSGGf1GG8/mkqO
         CXWzzXaFo3Yth4yayvqwjqVaE1lJDDcMDAO64OHojXyDb+kkIKNiYP/wigv0EBDWsq1R
         Rwd4K0D9yKS8Zq1nuuojSYXFm0Lvn7TlkauyDoH3mQpKBnrvy5XrNOSCuTbBw84WIpxI
         kmnnOKE/mP9kyO9xyvPhpAV5AA8o4GwkAPJfahSjX77Zv34f8jZz7Z9vNcHU4/eZlgJ/
         E36w==
X-Forwarded-Encrypted: i=1; AJvYcCVB003SpeMzcJff8J2k/yRqNX0GHjgbb4cIlc9npw5lesOpuEj1FEtFxcsiQnkmbytC2p3aOudfy6iJRRIdKR9ZNwBzaAkZ2LHTN014EaM=
X-Gm-Message-State: AOJu0YyjihNvJ8aOvJFyh9YYYqNCjk6nUdmb/wdoNQS+VIbqbX9DLTeV
	mT7qrXR3wwj66xHbUiy6lD2C4WNC/onP3Yx2o4nzDkUlqNoUVb5g
X-Google-Smtp-Source: AGHT+IFkuOm1rWUMUA7T9K+BWEx6TKaYz8X/DiwA7NUfHb6KXfr6W4GCR0Ud8iodCP6mr47l6eAjtA==
X-Received: by 2002:a2e:8e99:0:b0:2d6:84a4:99b4 with SMTP id z25-20020a2e8e99000000b002d684a499b4mr2055735ljk.20.1710865724177;
        Tue, 19 Mar 2024 09:28:44 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.211])
        by smtp.gmail.com with ESMTPSA id be5-20020a1709070a4500b00a46a9425fe5sm3977139ejc.212.2024.03.19.09.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Mar 2024 09:28:43 -0700 (PDT)
Message-ID: <f19a1e6c-fd56-45b7-9936-a1a72d1988ad@gmail.com>
Date: Tue, 19 Mar 2024 18:28:41 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 00/12] wifi: rtlwifi: Add new rtl8192du driver
Content-Language: en-US
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
 "s.l-h@gmx.de" <s.l-h@gmx.de>, "chewitt@libreelec.tv" <chewitt@libreelec.tv>
References: <5c23149c-1487-438d-bb37-69e2dd8173dc@gmail.com>
 <2280b6c991fa09e66506088441f63790d092e343.camel@realtek.com>
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <2280b6c991fa09e66506088441f63790d092e343.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/03/2024 11:18, Ping-Ke Shih wrote:
> On Sun, 2024-03-17 at 20:44 +0200, Bitterblue Smith wrote:
>>
>> v2:
>>  - Add cover letter.
>>  - Implement feedback.
>>  - Fix more problems reported by checkpatch.
>>  - Split the new driver into several patches (4-12) for easier
>>    reviewing.
>>  - More details about the changes can be found in each patch.
>>
>>
> 
> I have not started reviewing yet, but compiler reports errors/warnings:
> 
>   drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.c: In function 'rtl92d_phy_set_poweron':
>   drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.c:3055:1: error: expected declaration or 
> statement at end of input
>    3055 | }
>         | ^
>   At top level:
> 

Ahh, that's embarrassing. checkpatch said "else" after "break"
is not useful, so I removed the else. I didn't notice the open
brace after the if... and forgot to compile again before
format-patch. Sorry about that.

> And, sparse/smatch report 
> 

I installed sparse and smatch now.

>   drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h:30:17: warning: 'channel_all' defined
> but not used [-Wunused-const-variable=]
>   drivers/net/wireless/realtek/rtlwifi/rtl8192de/../rtl8192d/phy_common.h:30:17: warning:
> 'channel_all' defined but not used [-Wunused-const-variable=]

I see now that channel_all is only used in phy_common.c.
I will move it there.

>   drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h:60:39: warning: context imbalance in
> 'rtl92d_bandtype_2_4G' - unexpected unlock
>   drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h:60:39: warning: context imbalance in
> 'rtl92d_dm_false_alarm_counter_statistics' - unexpected unlock
>   drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h:60:39: warning: context imbalance in
> 'rtl92d_dm_cck_packet_detection_thresh' - unexpected unlock

These look like false positives. Every unlock is preceded by
a lock. I found a suggestion to annotate the functions with
"__acquires(...)" and "__releases(...)" to quiet these warnings,
but that didn't do anything. I can only fix it by copying the
contents of rtl92d_acquire_cckandrw_pagea_ctl() and
rtl92d_release_cckandrw_pagea_ctl() to the eight places where
they are called, and duplicating the code that needs locking:

	if (rtlpriv->rtlhal.interfaceindex == 1 &&
	    rtlpriv->rtlhal.interface == INTF_PCI) {
		spin_lock_irqsave(&rtlpriv->locks.cck_and_rw_pagea_lock, flag);
		temp_cck = rtl_get_bbreg(hw, RCCK0_TXFILTER2,
					 MASKDWORD) & MASKCCK;
		spin_unlock_irqrestore(&rtlpriv->locks.cck_and_rw_pagea_lock, flag);
	} else {
		temp_cck = rtl_get_bbreg(hw, RCCK0_TXFILTER2,
					 MASKDWORD) & MASKCCK;
	}

>   drivers/net/wireless/realtek/rtlwifi/rtl8192de/../rtl8192d/phy_common.h:30:17: warning:
> 'channel_all' defined but not used [-Wunused-const-variable=]
>   drivers/net/wireless/realtek/rtlwifi/rtl8192du/../rtl8192d/phy_common.h:30:17: warning:
> 'channel_all' defined but not used [-Wunused-const-variable=]
>   drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.h:30:17: warning: 'channel_all' defined
> but not used [-Wunused-const-variable=]
>   drivers/net/wireless/realtek/rtlwifi/rtl8192de/../rtl8192d/phy_common.h:30:17: warning:
> 'channel_all' defined but not used [-Wunused-const-variable=]
>   drivers/net/wireless/realtek/rtlwifi/rtl8192de/../rtl8192d/phy_common.h:60:39: warning: context
> imbalance in 'rtl92d_phy_set_bw_mode' - unexpected unlock
>   drivers/net/wireless/realtek/rtlwifi/rtl8192de/../rtl8192d/phy_common.h:60:39: warning: context
> imbalance in '_rtl92d_phy_reload_imr_setting' - unexpected unlock
>   drivers/net/wireless/realtek/rtlwifi/rtl8192de/../rtl8192d/phy_common.h:60:39: warning: context
> imbalance in 'rtl92d_phy_iq_calibrate' - unexpected unlock
>   drivers/net/wireless/realtek/rtlwifi/rtl8192du/../rtl8192d/phy_common.h:30:17: warning:
> 'channel_all' defined but not used [-Wunused-const-variable=]
>   drivers/net/wireless/realtek/rtlwifi/rtl8192de/../rtl8192d/phy_common.h:30:17: warning:
> 'channel_all' defined but not used [-Wunused-const-variable=]
>   drivers/net/wireless/realtek/rtlwifi/rtl8192de/../rtl8192d/phy_common.h:30:17: warning:
> 'channel_all' defined but not used [-Wunused-const-variable=]

>   drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c:91:16: warning: context imbalance in
> 'rtl92d_phy_query_rf_reg' - different lock contexts for basic block
>   drivers/net/wireless/realtek/rtlwifi/rtl8192d/phy_common.c:98:6: warning: context imbalance in
> 'rtl92d_phy_set_rf_reg' - different lock contexts for basic block

This looks like sparse is getting confused. I fixed it
by putting both lock and unlock inside the same if,
like above.

>   drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.c:8:6: warning: no previous prototype for
> 'rtl92d_phy_rf6052_set_bandwidth' [-Wmissing-prototypes]
>   drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.c:46:6: warning: no previous prototype for
> 'rtl92d_phy_rf6052_set_cck_txpower' [-Wmissing-prototypes]
>   drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.c:362:6: warning: no previous prototype
> for 'rtl92d_phy_rf6052_set_ofdm_txpower' [-Wmissing-prototypes]

It was missing #include "rf_common.h".

>   drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.c:3055:1: error: expected declaration or
> statement at end of input
>   drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.c:2957:6: warning: 'rtl92du_phy_init_pa_bias'
> defined but not used [-Wunused-function]
>   drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.c:2923:6: warning: 'rtl92d_phy_check_poweroff'
> defined but not used [-Wunused-function]
>   drivers/net/wireless/realtek/rtlwifi/rtl8192du/phy.c:2694:6: warning:
> 'rtl92d_update_bbrf_configuration' defined but not used [-Wunused-function]

These warnings seem to be caused by that stray open brace I mentioned.

>   drivers/net/wireless/realtek/rtlwifi/rtl8192du/../rtl8192d/phy_common.h:30:17: warning:
> 'channel_all' defined but not used [-Wunused-const-variable=]
>   drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.c:8:6: warning: symbol
> 'rtl92d_phy_rf6052_set_bandwidth' was not declared. Should it be static?
>   drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.c:46:6: warning: symbol
> 'rtl92d_phy_rf6052_set_cck_txpower' was not declared. Should it be static?
>   drivers/net/wireless/realtek/rtlwifi/rtl8192d/rf_common.c:362:6: warning: symbol
> 'rtl92d_phy_rf6052_set_ofdm_txpower' was not declared. Should it be static?
>   drivers/net/wireless/realtek/rtlwifi/rtl8192de/../rtl8192d/phy_common.h:30:17: warning:
> 'channel_all' defined but not used [-Wunused-const-variable=]
> 
> Please correct them. I will wait for your v3. 
> 
> Ping-Ke 
> 
> 


