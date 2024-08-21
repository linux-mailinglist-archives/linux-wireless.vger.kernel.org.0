Return-Path: <linux-wireless+bounces-11740-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 07F5D959A6C
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 13:44:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3AFFF1C2249B
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 11:44:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53E3D1A7AF5;
	Wed, 21 Aug 2024 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YL0+e7fz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB69419ABA9
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 11:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724239069; cv=none; b=HYNPPHPZ0vyF6UM8ZxcJq8SLvZTc2uL4FliLKpKvRAnWUjug1Zk0BOZwYGxngvZDZo+gm+1ZMzNvlhYSSnszpmCpi2zqQIhn68TygxRlL/ZDHSCdDwKlI1wrQS7d7Jk8iVcRVzr8kh3F2K2eslac/DGFHjslxQrUr+r2y+jHw/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724239069; c=relaxed/simple;
	bh=WqFHf4+/Cf1WM/QNzGi40bQgqXPINJf/3ByJRSt2Rj4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uWJYsEnHyoxzAClH3un2PMNg3ybro9UoaLA3SDdpjOsBRL12NIV8kWT5+4mxl89sdKmR5X4TKpyM2Q/y53gYyCynVDq4pyBMpSoqbIhln4SWPZkjqR2CY4YErZTNFjPP4espKVfvsNFQmYIOXOXBResxRIJSFaznKO/XTCLtgqk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YL0+e7fz; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-5bef295a2b4so1104333a12.0
        for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 04:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1724239066; x=1724843866; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ucyJ+lLqv3H0cF+mteELaEiVXkuRUIvIDk+lHZfUqh4=;
        b=YL0+e7fzTVgpRdp+fwXJV+xRAKC/thr+TU8TmwpcWLIhOEz4iX+iYv7BadRVxkktfr
         +cuDRnkYlO1g/s5jZF8yP4koKiynpeHjAluwiILrk7vIkDiBWTFJgNricmA4soLmmf+6
         5IygWlhFf6yOxneJ3Ad0rIuWaJPfofs1wR0P4hn2PpqKnyp/9SMbAtD2AQbCwxE2BQxn
         UPHPLz8IZo0Ie3uIbOOuxxYVf0ehWCalqQ2adLEFj2EXkZVgBBT4aZ/qxj+92AQqGYlX
         X5yYtiVRUyPOO819Kh7PoNprt/j+RyBXnTl4EYqkub7SZyFZLPMpq9msjY1YYfKaeNEc
         Ij3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724239066; x=1724843866;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ucyJ+lLqv3H0cF+mteELaEiVXkuRUIvIDk+lHZfUqh4=;
        b=OaFtmikJJj7ZAD6klU4CzYNhcKMNbSSTmcuNE45z7wPU+MLWLst0W9zJ1L5qUAHkf7
         dFnbUIawLAD3R+YU+2pDrqEWOWxGzGhQDQHqdyY6rMKvcCZ9oURn5yHU99XE/rImdLJ/
         ldI4XLa6LxDasMP1E3o4aArVJm6fYrTuN92Gw36tpiT3oWRUIYHkRgaOo5dGbf4O2Sw/
         bStjhPBoFA53uKpr9+gk7tgY63fWfp/vEyt525OZX3qu4MD06DGm96b/wrKzrroLpokV
         9rHVejDYAr/4x6894xGMK3C6X1dVONLXKgZXcFks4FkqHq3FbmjM1RE/VLlYkSGj4w7z
         pSww==
X-Forwarded-Encrypted: i=1; AJvYcCUgHWirvnBOZiOMUdpCg4aBbyxopiqCpVJtXApD+qdUMYfkpXTa8DCrwYNRC+46VQumm0roK8lVnWyQNQw3Mw==@vger.kernel.org
X-Gm-Message-State: AOJu0Yw8eQIgL0l15fK8ytwwR+IIn+aNRMP5P12ZtZrxWGHLj3DNeKbY
	KZjXu9KNvYla8leDjiN5lYyr+88Z7tjW3XTJcPPfz9jLEQ/MMO0M
X-Google-Smtp-Source: AGHT+IF3CH4oiNydWp1VhGequRPv3hNx4TzZZ1BlyJ1XAWOkW8IsZKHOZ6lFd8Ai/iKa4IJcG5HmmA==
X-Received: by 2002:a05:6402:35cc:b0:5be:c2c8:8631 with SMTP id 4fb4d7f45d1cf-5bf1e6e5c1amr1963545a12.8.1724239065530;
        Wed, 21 Aug 2024 04:17:45 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.114])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-5bec850895fsm7087399a12.20.2024.08.21.04.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Aug 2024 04:17:45 -0700 (PDT)
Message-ID: <f9a79598-2d1a-4135-bb2a-ae9a97b221c3@gmail.com>
Date: Wed, 21 Aug 2024 14:17:44 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] wifi: rtw88: Fix USB devices not transmitting beacons
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Sascha Hauer <sha@pengutronix.de>,
 Martin Blumenstingl <martin.blumenstingl@googlemail.com>
References: <9174a776-4771-4351-85fa-476e240d8ace@gmail.com>
 <b6fccaa0143a414a8513bc7c9276038b@realtek.com>
Content-Language: en-US
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
In-Reply-To: <b6fccaa0143a414a8513bc7c9276038b@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 21/08/2024 09:25, Ping-Ke Shih wrote:
> Bitterblue Smith <rtl8821cerfe2@gmail.com> wrote:
>> I'm not sure if SDIO devices have the same problem.
> 
> A SDIO user has confirmed this change can make SDIO devices send out beacon,
> but still have other problems though. 
> 
> By v2, I will take this patch and change condition 
>     if (rtw_hci_type(rtwdev) != RTW_HCI_TYPE_USB)
> to
>     if (rtw_hci_type(rtwdev) == RTW_HCI_TYPE_PCIE)
> 

That's great! I will send v2.

