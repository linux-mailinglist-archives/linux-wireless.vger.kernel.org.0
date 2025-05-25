Return-Path: <linux-wireless+bounces-23390-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 06C5BAC3726
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 23:55:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9649D7A87BE
	for <lists+linux-wireless@lfdr.de>; Sun, 25 May 2025 21:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3DF2019938D;
	Sun, 25 May 2025 21:55:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HtocyvVL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com [209.85.208.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7621B163
	for <linux-wireless@vger.kernel.org>; Sun, 25 May 2025 21:55:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748210129; cv=none; b=H+FmQCdgso4vOcuRdCqm3GFzVeF4naSeipN2lJ0vuCdfCnixrheJAcOqq4rpb+c5IVZfe+j7JwR8KSfLhuqzOzRXPH+dTSTEZV9EzdsbfZeDb7spKkY7BzQgnMwUrITAmzpC3IOBgbpj0XkwhRgzd5NmiflMr3/+0Ht1mPnj+ak=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748210129; c=relaxed/simple;
	bh=rr8qnR9abk8U3HP7nH13Z1O2TxAXjlgqV4H0eSsmAyk=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=T6Hcnp0xOdtHQw3ni02fzwy+qiRQWO3C6i6jhSlTbJqSH9HF2j3gR4vFe4zd8uNTyGS1rZHsFCz8LGmzOHDT0Gz/E4HQdSO5+xai4rLaaclDuziRlAlxmGhtbFXbOolt4SkZKchbI9ntWQVRU/BPvFbiKSXPrRZjY3LvE+rBuwk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HtocyvVL; arc=none smtp.client-ip=209.85.208.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f46.google.com with SMTP id 4fb4d7f45d1cf-6045e69c9a8so1392920a12.3
        for <linux-wireless@vger.kernel.org>; Sun, 25 May 2025 14:55:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1748210126; x=1748814926; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7r63N0zjCFJKnbBxpiK8nHPb8ydI0uw8YeSGC+YqSUU=;
        b=HtocyvVLQItx+0Jur20RQ11MSes4aiptC9p/7wREDJ+m/0qsh/BiittnAEOm5NodLr
         FdbQ1fuVcT11f/R5+0gY20sKMzLxxxQWRTFbQFMnMPoAhLYKs2Mt16YLNt1uFpJpjfOg
         NOrBa/38/wteCPtODf33sBz5ZmTdCgvEyCFzdHihVxKuCDend7My4nppsotRiBPZtSMC
         rfpy61L3RD9YyCUlCsqe1e3vBTfkPeLtIpRm6C98J5RTy5e39T0h5arVlvXNrDQ/QupA
         RJmTeQQZ1ueaWZHEZexKOPVZW8FnAXLxXIHaBhPxGa2mLBbCcVQzAcdLjQrl4nKceY34
         gFmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748210126; x=1748814926;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7r63N0zjCFJKnbBxpiK8nHPb8ydI0uw8YeSGC+YqSUU=;
        b=TvVl5UskVoPFZTdNhznYbcgDVvQyNTki7KkSqNLt9acp5Or3ckZT7EZWHeFjlmhPD7
         O5WucVJ9wLDe6AXvx/TbuRdyPXVhW5yyY2DXFWNWh9dBGDR3/7nc8Ka14dk8gU5WS+OR
         sur9e3kAJA29wXMSHHeiNwtUOEYdi44nO13XG/wesBG4e8Y/Ud/izat5Uj9XfxnDJoTj
         2JjC5bLOg8DaecKrWPPUWsKEeElLr9+bscn6fo9KW6JRL9f1pHJbIxEw8jrug+heb41H
         yKreiovMCsn/WPlcALqyHVfauvqr/ctIKhmQjyGXvbwdB8SAi5VbFedbujyCDwtdaEaj
         2Zxg==
X-Forwarded-Encrypted: i=1; AJvYcCWhXrybJ1l2AAbcOqVeTyjexIXUFLp03azR8Adr+/q5V666PfJz7vblP2h2/t+IaHBSkJi+NHah7BaHtODJQg==@vger.kernel.org
X-Gm-Message-State: AOJu0YyI6rTv9dUXuesJBEnWbUFXcwr/TfbRyP3Wvt6X25Z0YiLO/VNn
	+s4m+/BVJDf5yYdk9+cEzwhgA+wfw/OnlN8dvtrGg8UMvVJHSfxGofW7iOKH/w==
X-Gm-Gg: ASbGnctIOQy3s3Kc3+tBvgtebiqEkDKmN2XGM0svjUNmgJEBvAS609T1qzMkAcEV3E+
	T/Hf1MG/KG1qPY00xqW7fn2rPaUPsjiRpdsGBMNlSP4rxLrG/Zl1SanLtBTsqnlCBJqQ5iyYUlQ
	32E+e9hSTaQqZYqTNR+pRzOkeN2mRmbwMQ5OT3/rlwHRgYEJGHs8e9e4PZIVzlIep5sAjvIVDxN
	N0BJcm18O5O4F8hsquF3PAFVXOTc115Xe/NlOdO+BYP7b3ak5MDIdlWBH0hHe1VRUFI8HSiBZEH
	XGYsmulOQaQjmlhLNSqJaSGlNZLlGTxIrAP7Xv8TxlRJZCMF5KjWBzkKvIw=
X-Google-Smtp-Source: AGHT+IHCUIZtr+7TLpLQzbPeQ/gsmCYoavJxLo2DQBx0mJzNBMNl8eA1DpVWtMEg1lNl72F7CyziPQ==
X-Received: by 2002:a05:6402:4404:b0:602:1b8b:2902 with SMTP id 4fb4d7f45d1cf-602d9bf086amr5067080a12.15.1748210125527;
        Sun, 25 May 2025 14:55:25 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.16])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-6046d5229fasm1166351a12.53.2025.05.25.14.55.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 May 2025 14:55:25 -0700 (PDT)
Message-ID: <9c3980f3-c22e-4213-bab3-15d25bdc1b59@gmail.com>
Date: Mon, 26 May 2025 00:55:24 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: [PATCH rtw-next v1 05/13] wifi: rtw89: Add hfc_param_ini_usb
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <348b0c94-2db6-4ae9-819c-6fa7f9c3ac56@gmail.com>
 <54b050dc237e46fcb96576e19451ae97@realtek.com>
Content-Language: en-US
In-Reply-To: <54b050dc237e46fcb96576e19451ae97@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 13/05/2025 06:12, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> Add hfc_param_ini_usb to struct rtw89_chip_info. For now initialise it
>> only for RTL8851B.
>>
>> Signed-off-by: Bitterblue Smith <rtl8821cerfe2@gmail.com>
>> ---
> 
> [...]
> 
> 
>> +
>> +static const struct rtw89_hfc_param_ini rtw8851b_hfc_param_ini_usb[] = {
>> +       [RTW89_QTA_SCC] = {rtw8851b_hfc_chcfg_usb, &rtw8851b_hfc_pubcfg_usb,
>> +                          &rtw8851b_hfc_preccfg_usb, RTW89_HCIFC_STF},
> 
> [RTW89_QTA_WOW] is missing. I'm not sure if current can handle this correctly.
> Could you try to do WoWLAN with USB? At least, it shouldn't crash. 
> 

RTW89_QTA_WOW is missing because I didn't find an equivalent in
enum mac_ax_qta_mode in the vendor driver.

I enabled WOWLAN with this command:

iw phy0 wowlan enable disconnect

Then I put the computer to sleep (suspend to RAM). There was no crash,
just some error messages. The computer went to sleep and woke up without
any other problems. Of course it didn't stay connected to the access
point during sleep.

May 23 20:19:46 ideapad2 kernel: rtw89_8851bu 1-2:1.2: qta mode unmatch!
May 23 20:19:47 ideapad2 kernel: rtw89_8851bu 1-2:1.2: [ERR]get_dle_mem_cfg
May 23 20:19:47 ideapad2 kernel: rtw89_8851bu 1-2:1.2: [ERR]patch rx qta -22
May 23 20:19:47 ideapad2 kernel: rtw89_8851bu 1-2:1.2: failed to config mac
May 23 20:19:47 ideapad2 kernel: rtw89_8851bu 1-2:1.2: wow: failed to enable trx_post
May 23 20:19:47 ideapad2 kernel: rtw89_8851bu 1-2:1.2: failed to enable wow
May 23 20:19:47 ideapad2 kernel: rtw89_8851bu 1-2:1.2: failed to suspend for wow -22

That was without RTW89_QTA_WOW.

Then I tried to copy RTW89_QTA_SCC in rtw8851b_hfc_param_ini_usb and
rtw8851b_dle_mem_usb2. With that I think it was able to upload the WOW
firmware and it stayed connected to the access point, but something
didn't let the computer go to sleep. It sat there for several minutes
with a black screen, the power LED on, and connected to the access
point (but without an IP address), until I clicked the "Disconnect"
button in the access point's web interface to disconnect this station.
That's when the computer finally went to sleep.

So WOWLAN with RTL8851BU needs more work.

> 
>> +       [RTW89_QTA_DLFW] = {NULL, NULL,
>> +                          &rtw8851b_hfc_preccfg_usb, RTW89_HCIFC_STF},
>> +       [RTW89_QTA_INVALID] = {NULL},
>> +};
>> +
>>  static const struct rtw89_dle_mem rtw8851b_dle_mem_pcie[] = {
>>         [RTW89_QTA_SCC] = {RTW89_QTA_SCC, &rtw89_mac_size.wde_size6,
>>                            &rtw89_mac_size.ple_size6, &rtw89_mac_size.wde_qt6,
> 
> [...]
> 


