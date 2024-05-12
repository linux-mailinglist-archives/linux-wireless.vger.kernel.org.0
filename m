Return-Path: <linux-wireless+bounces-7551-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id BF00B8C36D6
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 16:35:07 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EB62B1C20A51
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 14:35:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29E44134A9;
	Sun, 12 May 2024 14:35:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Jla4XvEH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68BAD81E
	for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 14:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715524504; cv=none; b=s+BxbIzNpONpbIT+Ds8ZjaZw/vI0vryDOCz1HeYuDHuJGLUZAG3m0j78351s3OG4DWS5elQu6+4dhw6Z7YjC63S5cLZuAbWXDsMUGFDX1yKyXSBNAyOeUD4qwRUo+wHhRuS4rkgRLLYWifdZo1p9aeSnB9GGdJXwJcj28Puhw4w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715524504; c=relaxed/simple;
	bh=vFo/WHJUpcDJYbY56AHislEeWBXvTJ9iqlUoNOqUul8=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Cc:References:
	 In-Reply-To:Content-Type; b=N17L7tncaSN02hRRvJiT5R2z1XPvIkzxEkff26Mfs6i8mAdYr4eURQlkytycUoN+x39nqUw0/68V6KsyzCOAb4TckjdYpQaaFkwCpljU44PL6AqZ4wzOX4a4cStbp0hh2wBEBG5wEOO8zMNM0KtpGZcmcHDUDbOMHMG8pgQ/5f0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Jla4XvEH; arc=none smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-51f40b5e059so3925833e87.0
        for <linux-wireless@vger.kernel.org>; Sun, 12 May 2024 07:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1715524500; x=1716129300; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=niaysg7B7xEWomnDf71NtODzsnVk4Nu2wzRETW00zcI=;
        b=Jla4XvEHnnZ4F9NEoFZRfle4hCgGwNDo+LkF/W8PhDGIFoHNK+X27S4g7maGH/MYlQ
         F6wLIHoRClsrsak1Iyfm9ii8leYJw6v7B5D5hCLUz5sWpBvDGtPS36OpQqgmdmsD8Shm
         WCAnzN/AlgQaIswBMSJx+ao84EVNzvoEgIDbfW8lD2wsBlOK3Fm7E+jGU3lneGtMQwLH
         GnMQVuto/cyQm3a8aV8P5ws3BEKLNvMMx7QxKY/MqUkPFQ6ze3Hgt1pRdTA0gQJyWLIg
         DJAtSJEa/iqCIsfY///2sLfCU+/+XEjrMHSNZOKMsFAFeEnht4V31iK0xJ08zpAN/0Ep
         DetQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1715524500; x=1716129300;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=niaysg7B7xEWomnDf71NtODzsnVk4Nu2wzRETW00zcI=;
        b=pff1mFAzZpDKGzz8QmGRTBgBdmvYgqm6QHQDveezO3lG9zElg4zDwZ+q5gyQaRxpyI
         I9xlgaC3MZaXnBgv9XLL1M1dn0jgIbdBE2UDhXDIan3vUt50pIIaQ74Fm+3ElMDMaasg
         mHeyDn3aKiiE9nbfcs02krJC29lmVA8lmMzZMPB5fUdnrL+Udvhg4cXE41B9mVA1mbaP
         Z66Lg8Fh3irsCGL06Jly2F9b94oOzfY8kZ6Ktuw5zDJBv2ssb4E0DjnuYp+dl+KKjRdQ
         jms1n03bJNr6bn9FDknReEK2ABJ52vhUakF2QG5g/Mb0fwL75BUu36p+e7Mat9dBTydu
         gqxg==
X-Forwarded-Encrypted: i=1; AJvYcCVUrZKcFb2DirjVg91jp6CUWNy6Uxg/LdIAN5wZ6p8dMmy9lNJLF96Goj90DxxIrBNPGQvTQZ5vL2cHZxgUmhiD0bn+hks+vRHpR5Laqtw=
X-Gm-Message-State: AOJu0YxOd1YEzL81GVlD3FT49BFY/Q4SgjRia1cEp9uOsPD/WyeQrry5
	IMD2EwsexPFNrbyABdBgJdTD4Ms3eZ1bGm/bHIT9NL1K6/IZ9ZKu
X-Google-Smtp-Source: AGHT+IEWGLwbkhAJ5QnIqpTVTs/ZuR9yv9/WsEFL+L+dqj9QaAifwfTtM9/3yddsWhxLyDsA/7g6aQ==
X-Received: by 2002:ac2:4db1:0:b0:51b:ebe0:a91a with SMTP id 2adb3069b0e04-5220fc73566mr4577331e87.36.1715524499970;
        Sun, 12 May 2024 07:34:59 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5733bea65edsm4833460a12.7.2024.05.12.07.34.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 12 May 2024 07:34:59 -0700 (PDT)
Message-ID: <d104ea7f-5a88-4081-a651-c25a88a2acf7@gmail.com>
Date: Sun, 12 May 2024 17:34:58 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH v5 03/11] wifi: rtlwifi: Add rtl8192du/hw.{c,h}
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Larry Finger <Larry.Finger@lwfinger.net>,
 Stefan Lippers-Hollmann <s.l-h@gmx.de>,
 Christian Hewitt <chewitt@libreelec.tv>
References: <254558da-ea8b-40ea-bd5a-83d13796744f@gmail.com>
 <d5d52f8d-585d-43a6-a5e6-076f24ba8410@gmail.com>
 <31f28650173d40cf85fb57f87949eef7@realtek.com>
Content-Language: en-US
In-Reply-To: <31f28650173d40cf85fb57f87949eef7@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 10/05/2024 06:04, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
> 
>> +
>> +int rtl92du_hw_init(struct ieee80211_hw *hw)
>> +{
>> +       struct rtl_usb_priv *usb_priv = rtl_usbpriv(hw);
>> +       struct rtl_usb *rtlusb = rtl_usbdev(usb_priv);
>> +       struct rtl_priv *rtlpriv = rtl_priv(hw);
>> +       struct rtl_ps_ctl *ppsc = rtl_psc(rtlpriv);
>> +       struct rtl_hal *rtlhal = rtl_hal(rtlpriv);
>> +       struct rtl_mac *mac = rtl_mac(rtlpriv);
>> +       struct rtl_phy *rtlphy = &rtlpriv->phy;
>> +       u8 val8, txpktbuf_bndy;
>> +       unsigned long flags;
>> +       int err, i;
>> +       u32 val32;
>> +       u16 val16;
>> +
>> +       /* As this function can take a very long time
>> +        * and can be called with irqs disabled, reenable the irqs
>> +        * to let the other devices continue being serviced.
>> +        *
>> +        * It is safe doing so since our own interrupts will only be enabled
>> +        * in a subsequent step.
>> +        */
>> +       local_save_flags(flags);
>> +       local_irq_enable();
> 
> I think you just copy and paste this chunk. I wonder if USB has the same behavior?
> Driver force to enable IRQ is weird to me. Please check I this is really called
> with irq disabled? If not, we can remove them.
> 

Yes, I copied that. Removing it from rtl8192du makes no
difference for me. I'm not sure how to check if the function
is called with irq disabled. Is it raw_irqs_disabled() ?
It returns 0 for me.

> [...]
> 
>> +       local_irq_disable();
>> +       local_irq_restore(flags);
>> +
>> +       return err;
>> +}
>> +
> 
> 


