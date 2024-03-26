Return-Path: <linux-wireless+bounces-5280-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5D3E488C2DF
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 14:02:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9826C1C3063E
	for <lists+linux-wireless@lfdr.de>; Tue, 26 Mar 2024 13:02:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1E7086FE1A;
	Tue, 26 Mar 2024 13:02:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Xn4eUJAR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 754BE6D1D7
	for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 13:02:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711458134; cv=none; b=tUqUZ5Ty9JdNrp9DtgbxY2rBbpzSOcVpkEeRrP2EBNmZ0YARKfFa9X/4H8vM+EGIZzRA7lwVt8ZiPEobDfK/G6/yZgEBkwHqaYdcm8MVIgox6aSWp7f8A24QGLXwo6f18zJwPSrdA8yDdl/qRJORT8e00Y+dGlACbhVNE2C8X3s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711458134; c=relaxed/simple;
	bh=W5U67z/9OLz+vzYP09HHlAqsips/AZv7NdmA8aHFnAQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=XuFpxiWXPv9PqOP8Gk4TomJQ7yLMKxCHsgdUaHuI4N/JhHz8DM9Y6T0+RHl+7lpbUKlcYoF3UVxQ9wMv+d2RFh3GgxWA4zLe8iKXLXUtm/FQeBhJuypN4onWQ7AJNeFU7koyK7bBqJrmBCWd0iLxUUJgDBIPhWJcoZ9t/RbTrsM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Xn4eUJAR; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-4148e20fb7eso6479135e9.2
        for <linux-wireless@vger.kernel.org>; Tue, 26 Mar 2024 06:02:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711458131; x=1712062931; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=a5svgeeLefqQJ31XwUlmLpwyXpdXdVTxLziCnreAsN4=;
        b=Xn4eUJARwgG94z4/nlqlbvgqGn08cUebyVSeV7BPHPCci/P3BDEqz3VeS2g3OLEYT9
         aGLOu6ouTWRFYb8cTdRBzQhTWyHC6fdNpLhCBzXl1hKiM8ruY2I7UQOknD7PRG7gxnpm
         7b26pBndxnOmz9lgo0wnAyeugjzonQ4m0xXYR5cZiSe/rgWQJUhZHTsWaN2ivrrZjIL7
         KxHTsWyPhStTUnc9PZZNBP7cpZQi3NVrPMkOB5pafnAIa/azOO+FtrBagjqBcSuO0nQw
         4OVY2+mNC6T+ai26kiIt9UZGeRodXbY5FSir+LB+F5lnBQ9g2usiHssPTFcl6UDH69eA
         qpBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711458131; x=1712062931;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=a5svgeeLefqQJ31XwUlmLpwyXpdXdVTxLziCnreAsN4=;
        b=V+GCP5vwea1FfkIacPZ++sXbB+U+xBcRvrX9XdH50r/kYJelFEJPrQQpQTMDqki2UM
         YV6oghNhtow9DR+N7LhvvCsXyrPSRn4cLItd+iCw46z1nwHNidDSTbdrYNwXbOQZm5/A
         IPt9XNMWjehpz0W76+bLrx048GvE+ytlKcWyGPAZHRqGcNPCfnlXwCDe6TpgQEW5saMe
         m4m/SjQsZJYEtZQVhXVGIqE4tfwoMfB2PnIUKD4G1adSmySZmlYNz3Rl/yswx8Pq4juP
         yVuWzdarm9yH6vzEszRdMYbscZkymhNn9Oh34bazBw7lpLvOpS/yVJREvtOAresjPpXC
         sf3A==
X-Forwarded-Encrypted: i=1; AJvYcCVTsmoBA2pilYR7RqasGNKkD7xpiPzkPVARSEeF/BV5NdrRMa0QWhXZAvB7ukup+Zn+hkjAFWnlbGgMDZP4WlR45na7XewwQdMTNtasWqE=
X-Gm-Message-State: AOJu0YzhIGZx6ePgtBG4KWHr0JSL6eGUeOwwLCdDfwt9LuwU4u4t/t83
	ti92SoyJsuPOdBBkCFXrqSTkRGQDLbJOwV4meKXwFkzrSDBqFOXlF4EHx2xF
X-Google-Smtp-Source: AGHT+IHaE2upbTgeriZLgjm7D0KUOYkAzc2kPUOnqVDKnsQy5R9pnEFgvfyxU/QgB/e4sz4sga7b4g==
X-Received: by 2002:a7b:c055:0:b0:414:5cec:a9dd with SMTP id u21-20020a7bc055000000b004145ceca9ddmr9641241wmc.38.1711458130630;
        Tue, 26 Mar 2024 06:02:10 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.19])
        by smtp.gmail.com with ESMTPSA id bq28-20020a5d5a1c000000b00341d84f641asm1436198wrb.8.2024.03.26.06.02.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 26 Mar 2024 06:02:10 -0700 (PDT)
Message-ID: <cf330e75-8b5e-492e-a54a-5a7bbce687e2@gmail.com>
Date: Tue, 26 Mar 2024 15:02:08 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 02/12] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
 "s.l-h@gmx.de" <s.l-h@gmx.de>, "chewitt@libreelec.tv" <chewitt@libreelec.tv>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
 <c83c2d67-d476-43c3-86e2-48bacc7d5ba2@gmail.com>
 <04c3ea92c4456641f5dd7198db4906428f2610e3.camel@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <04c3ea92c4456641f5dd7198db4906428f2610e3.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 22/03/2024 04:14, Ping-Ke Shih wrote:
[...]
>> +
>> +void rtl92d_get_hw_reg(struct ieee80211_hw *hw, u8 variable, u8 *val)
>> +{
>> +       struct rtl_priv *rtlpriv = rtl_priv(hw);
>> +       struct rtl_ps_ctl *ppsc = rtl_psc(rtl_priv(hw));
>> +
>> +       switch (variable) {
>> +       case HW_VAR_RF_STATE:
>> +               *((enum rf_pwrstate *)(val)) = ppsc->rfpwr_state;
> 
> The casting of these set/get_hw_reg looks not good. If you have good ideas
> to avoid them, welcome to adjust them afterward 
> 

My idea is more of a dream: to replace the get_hw_reg and set_hw_reg
functions with many small functions, one for each HW_VAR. Most of the
drivers have very similar code in these, so they could share.

> 
>> +               break;
>> +       case HW_VAR_FWLPS_RF_ON:{
>> +               enum rf_pwrstate rfstate;
>> +               u32 val_rcr;
>> +
>> +               rtlpriv->cfg->ops->get_hw_reg(hw, HW_VAR_RF_STATE,
>> +                                             (u8 *)(&rfstate));
>> +               if (rfstate == ERFOFF) {
>> +                       *((bool *)(val)) = true;
>> +               } else {
>> +                       val_rcr = rtl_read_dword(rtlpriv, REG_RCR);
>> +                       val_rcr &= 0x00070000;
>> +                       if (val_rcr)
>> +                               *((bool *)(val)) = false;
>> +                       else
>> +                               *((bool *)(val)) = true;
>> +               }
>> +               break;
>> +       }
>>
> 

