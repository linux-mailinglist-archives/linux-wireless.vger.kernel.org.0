Return-Path: <linux-wireless+bounces-5699-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DCEE1893573
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Mar 2024 20:48:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 133E61C208F1
	for <lists+linux-wireless@lfdr.de>; Sun, 31 Mar 2024 18:48:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2968A146D49;
	Sun, 31 Mar 2024 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CKhaZbuK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C8D09463
	for <linux-wireless@vger.kernel.org>; Sun, 31 Mar 2024 18:48:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711910925; cv=none; b=jz2VhvuqYxkDkoreqMZkcfmh/5T5c/MdtyyKHdY99tqIKRslGgB+df9n0lrrOLF8f+Fw7IDe+ZcJGItMarVAaoLx2myZW2yGGr8b+MfxcUSOSq7mwqhrq1XZxQKLWctjm8NAOK8sfu+il5de5CwnB2t8USKPYnnDArWoEJ/6BxY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711910925; c=relaxed/simple;
	bh=Gb7sXm2MsBMSxKdQ0Kf9C9GZhgexge/O8FdnBekhwSo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=a1qWsN38hfeR/kUToUK6wKT2sibMKCyx6WaQ7wVWLRYCilrgsq4rrpW+0xTx3LUKhZG6NHdIOHPizNKE/cjiggJjlxIcriLN/Rav/YiHN9o1sIuG/XDz0UQ0PSy3YizqB/EsRA6IJIPD2CJsA/rF3umypXINiqVTk8gLfr704uA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CKhaZbuK; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-a466fc8fcccso437618666b.1
        for <linux-wireless@vger.kernel.org>; Sun, 31 Mar 2024 11:48:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711910922; x=1712515722; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7+jd0HWCGhmQGRPw/UKc/3Qct8Sux+/XrhVbE630lYg=;
        b=CKhaZbuKdhvrDw3MVzRV9WNYNfZ++OZpqlGxxWx6C9A+Ca5OjjZ8QeWW6oCALtprca
         F3vlQ35fGO5V2yUpg4aTVMTU/lPIbUqml1BLX8fIjmD7BSeYQMVAZal3YpJSnu7LAB6b
         Tk5kHdNqpQJn2iJpIW+58I6FwWTlmZHtseULM/emGffCGvYC8s8TBsvri6H90BEeih5C
         QsvlFJ1EZ3hU9i5rRLUIZK859cPhUe1TITWSMVuzABezhbUbuMhqr8AHHP7BzZ+UJRva
         1d9P8dwWng6vFwBTpPwroVyjJmU8D+Jhntc7M+8ljeRsINCZ5jLxsykevw/QMj8CVvtJ
         sQVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711910922; x=1712515722;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7+jd0HWCGhmQGRPw/UKc/3Qct8Sux+/XrhVbE630lYg=;
        b=dwGPDiLDhMMC7dAqeMAUxICVJZTz2lVCIxyYHIUkVeJYuYMLrZZg9i09ucS95muH9x
         +avJyiVZl8oq2A9uD6QRH0c1ZfdwGUW/mx36YF8dkbj8dtAu6zzb/+qB93wvggG+AYQy
         Hntuy3COUI8kyjUOxPfg/U9jNBCGMpKyUv2N/y1jAnmkVh6IKx5+K2GoSRCu0R5G+SA+
         7GR/yHNEssorJDNDcHfSCzV84WAzN7cM07/yMZxva/PpJFyGBi4eQomtYXW2GYD6ns+6
         m0nI+lMIRYeEFyLK3PA7CffSpAScUbA+V4Zf5MkzrEgA1gpB3JeIc+bhnU4rVuSaOM2O
         C89w==
X-Gm-Message-State: AOJu0Yz6xP3OarX0MO74jktJGfpaTQaPV2EzyPNYEkbaA2Cgi/EhHmVD
	hcTXY1YL2aYaNQ4CSx+oN57CwYCcKu0a7BUntSatbbbJMHRU49+P
X-Google-Smtp-Source: AGHT+IFLq4cOor2q2fj5ecW4DejMgk6VZF2n9lXBqNRJ5esa5ysmvRoD3ZVmlUdWff8/9xrw78wdzQ==
X-Received: by 2002:a17:906:358a:b0:a46:a3bc:b343 with SMTP id o10-20020a170906358a00b00a46a3bcb343mr4474620ejb.21.1711910921659;
        Sun, 31 Mar 2024 11:48:41 -0700 (PDT)
Received: from [192.168.1.50] ([79.119.240.188])
        by smtp.gmail.com with ESMTPSA id wz4-20020a170906fe4400b00a4e253c8735sm4184617ejb.52.2024.03.31.11.48.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 31 Mar 2024 11:48:41 -0700 (PDT)
Message-ID: <ff3b97d0-118c-42b3-be0b-47cfcf06ab74@gmail.com>
Date: Sun, 31 Mar 2024 21:48:39 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 11/12] wifi: rtlwifi: Add rtl8192du/sw.{c,h}
To: Ping-Ke Shih <pkshih@realtek.com>, "kvalo@kernel.org" <kvalo@kernel.org>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
 "s.l-h@gmx.de" <s.l-h@gmx.de>, "chewitt@libreelec.tv" <chewitt@libreelec.tv>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
 <2eb79c8c-cf2c-4696-b958-e8d961628e17@gmail.com>
 <f86a40493745a53ff73083f87b3e8fae215eac77.camel@realtek.com>
 <66565618-3638-47e5-afe5-3530214da0c9@gmail.com> <87ttkrzf1m.fsf@kernel.org>
 <5696990a-4450-4d92-bbda-1d9ca3a9a619@gmail.com>
 <4672072ef782ae1200886a190c740e0f3ccec2c8.camel@realtek.com>
 <7873dee1-46a8-48a7-9059-bc300ac98c23@gmail.com>
 <1f8ebed6a04a4fbebf33b0a3edc2f50b@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <1f8ebed6a04a4fbebf33b0a3edc2f50b@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/03/2024 02:34, Ping-Ke Shih wrote:
> 
>> I got another idea: if we have a guarantee that the two USB
>> interfaces are probed one at a time, then we can move the global
>> things into struct rtl_priv. The first probe call will allocate
>> the arrays and initialise the mutexes. The second probe call
>> will obtain those from the first struct rtl_priv:
>>
>> int rtl_usb_probe(struct usb_interface *intf, ...) {
>>         udev = interface_to_usbdev(intf);
>>         struct ieee80211_hw *first_hw = usb_get_intfdata(udev->actconfig->interface[0]);
>>         struct rtl_priv *first_rtlpriv = rtl_priv(first_hw);
>>
> 
> Could it have racing when obtaining mutexes from second probe? 
> Should we need a lock to ensure the sequence? 
> 
> When driver is going to down, how can mutexes get free safely?
> 
> It seems like we still need another global lock to ensure that. 
> 

I asked linux-usb and they said the two interfaces are probed
and disconnected one at a time, so it should be fine without
another mutex:

https://lore.kernel.org/linux-usb/2024032907-smokeless-imperial-f3f9@gregkh/

