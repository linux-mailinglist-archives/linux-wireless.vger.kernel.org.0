Return-Path: <linux-wireless+bounces-6352-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1EECE8A5D1C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 23:42:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CABE5286730
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 21:42:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C3EF7156978;
	Mon, 15 Apr 2024 21:42:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Hz2wl366"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD952823CE
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 21:42:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713217357; cv=none; b=EmlC9V7C/RUHpLCVif+UY2GaB1OgMx2FZ+0cuQfo5Tnr4oLXC1VZ3KPpbznMIONU4pQHN5XGpBoGBkFoQ47yxTJNRzN8+xgSok+S/c0cAQVs2cOnip14RssRhRmaM1/4ZCZqKk8TuKc5L8CW+/kkDKZPb7gHIcYF82CTpjoiSuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713217357; c=relaxed/simple;
	bh=cjJx4kKWwXLdkZlJU7E3iG0oMkSAvCWk3O8EXkZC8a8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=CKxeGU63wRnGtcUHFP9O+adCKlPLX1Ug24uPY5cvqXP1SvFBScXojbLICcyAp9Y+GL3f6MrIlV834MpO1XgoE/EtECXSOxJZtaNillYMWeYQ/0iLbdvN5sfsrIhZsltp3/uLYjdZTnoQYlPKdGWmqIY686Jpk6PMqwwrbCAk7Vs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Hz2wl366; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-6ea2ac4607aso1987546a34.3
        for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 14:42:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713217355; x=1713822155; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=tLFlYmRQINVpQrqB98XR8U9qQVHIlIfOs4oR7DoNE5I=;
        b=Hz2wl366EP8bmy0q26RqA5qtA/Jrm2ja/GWJ61vTgCYmPRNn+OJj5DHs+9+sG+Ur4B
         eGb9rA5XAX+tAwh7cDs5Wh11/cl6nukt0GrdNVxRVnSJe5koq2KKBpZj8lXJ8DjZrNnb
         +9yI47Hu6q8gAnA5tq8u8fYUdMk4z+qkBLsd8v13LqX6j8ETLsjEGTv9c3ZMkwa5oKYR
         D1sIYkgK67Bp0izPA6vevR4LMxL9RAdVdzlhUsObrgjZ3uTgmFliTHjYRAxLsYqWH2KP
         Cl8RMx47kcR694qi2S1jGWz9fwfwJK5g9Z/eBkhT1yn/3ZimqPIZPWUwV3A4Wv1HlAec
         WdMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713217355; x=1713822155;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tLFlYmRQINVpQrqB98XR8U9qQVHIlIfOs4oR7DoNE5I=;
        b=bkMkjP8f+8YyhbqGPjHhDHKoRJmQlXbnjaI9H45g7C5Ic5vpj33TMAdcSTMxUSKoYy
         wIcQ0rMIX3kILm7OmPswXjxiQ9/xPKO1sKabeUEp5/YGNpc36lyIcmBUEWi70fuRBfEj
         WCAl0b/u+h2LcHSt4PaIiHQYoD8gyoGnMlIAzOZHmGGz2UtXUadh5aWdB6KOIzm46a8V
         SJSlDfSojeGANkhe2GyCgcYP1d5aZDHDREv1YPGd7CfUWpg5cEdsgz3W6BkjWAJPfEYs
         EVIjL2VCWzZxsj6uTJXlnRFdzkoV7JEosq7zreUzbccg8zrpmt6WfpxQ4rKQFQCUg0Yl
         dbyA==
X-Forwarded-Encrypted: i=1; AJvYcCX7qyPL0p9/RPS/F8NPpgJ6wuWcf85772fo78w2b13CFQ+AWgxQVhOhaNds3WfCWpaR73VlP6CkGC4s5GfwOSOSASaT3GP8QV05Z2kI8n8=
X-Gm-Message-State: AOJu0Yzur7qky1IEMOGExF9v5obMqzwwdaFxH/jEJbBcPAXoBrRbCl1n
	HHagRlKz+d73cTOOmfMNKEC0jsKXCWSwCxcEnJZJ7wMYhfdA0oAMim09KJNw
X-Google-Smtp-Source: AGHT+IFPq6wePgXld23uo7h3VRFFINq2I2Lu37sKaGG1OcHeuc1EtmgCW+0yFZcfbkQrgNUJlBfxrQ==
X-Received: by 2002:a05:6830:108e:b0:6eb:7d98:d638 with SMTP id y14-20020a056830108e00b006eb7d98d638mr3998975oto.2.1713217354826;
        Mon, 15 Apr 2024 14:42:34 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id f19-20020a9d6c13000000b006eb811b68dbsm502378otq.39.2024.04.15.14.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Apr 2024 14:42:34 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <fe9d13fd-bf13-4c59-98a7-68fd20d97978@lwfinger.net>
Date: Mon, 15 Apr 2024 16:42:32 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rtw88: rtw8822cu (LM842) on Raspi4 -> driver get stucked while
 sending data
To: Gabriel Tisan <gabriel.tisan@gmail.com>, Ping-Ke Shih <pkshih@realtek.com>
Cc: Nick Morrow <morrownr@gmail.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <CAD9ZU8Coc0r3AiWz+rA4eoXuDQBBCAMY0J4w5x-Pa1JEpbmdWA@mail.gmail.com>
 <CAFktD2cp5eXJufdQibxDPGvN2iMfMZKDOunFzxv0TBNLqcMAQg@mail.gmail.com>
 <c68a406361524b6888d973a1e428118b@realtek.com>
 <CAD9ZU8A8f-aJuH54e+93cZGTckOSu+rYKcnQr0mkc8eq56zedg@mail.gmail.com>
Content-Language: en-US
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <CAD9ZU8A8f-aJuH54e+93cZGTckOSu+rYKcnQr0mkc8eq56zedg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 4/15/24 3:53 AM, Gabriel Tisan wrote:
> I am a little bit confused.
> 
> My LM842 USB stick uses a RTL8822CU chipset(idVendor=0bda, idProduct=c82c)
> 
> The repo https://github.com/morrownr/8821cu-20210916
> allow to use for idVendor=0bda, idProduct=c82c both RTL8821C or RTL8822C driver.
> 
> Should I use then CONFIG_RTL8822C for my case ?

No, that would not work. The vendor drivers tend to have the USB device 
identifier section for every device in the family and pick then with the 
appropriate CONFIG command, but that does not mean that the rest of the driver 
would work with that CONFIG_RTL8822C.
> 
> To be sure, does anyone tested this driver in AP mode for 8822cu ?

I have no idea if AP mode works for the rtw8822bu. The vendor driver for this 
device is available at https://github.com/RinCat/RTL88x2BU-Linux-Driver or 
https://github.com/morrownr/88x2bu-20210702.

There is a problem with the wireless-next kernel and my rtw88 github repo in 
that device 0bda:c82c is listed as active for both rtw8822cu and rtw8821cu - 
certainly a mistake.

Larry



