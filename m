Return-Path: <linux-wireless+bounces-3691-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94B6685843A
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 18:36:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C7C0D1C23435
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Feb 2024 17:36:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 301F913172C;
	Fri, 16 Feb 2024 17:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C0Bq/PsT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f41.google.com (mail-oo1-f41.google.com [209.85.161.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6139219ED
	for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 17:36:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708104974; cv=none; b=IxTi20tpjawt4gFIJnwfQsQmk6WaweL/IZZ79FZkTcdoBxYprv5K/Db39/glXprYygn1/ySWaZBhyD9QnHnQQ1+TF+heCcI06+l0uFg/Tn2JBnwG6IrAVy3UhxE1vrjIZ2VkvhYvqb6eFhwaBlpyVSN6gVUXWYOjP4XAFuk818c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708104974; c=relaxed/simple;
	bh=b5udwEJZgnQCGMPWVLAMdaTl4b1vM2hUrKB+SBqGYTQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=C0GXsLNFNJlGqKHCaDMLxZ8xvE2XcyX+9Mw8FJ2s0xpmuN3r240fapYFGV5jQJwVs0qVo73VFaZndgaamEoPMDzjaiYLDwzk4x8Af2USayPFHrpYutNDDrh94kiopmDK2ptpekxiG8tnPQ6LNqbt75d/b1COTjNS+WjZdeY0yzw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C0Bq/PsT; arc=none smtp.client-ip=209.85.161.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f41.google.com with SMTP id 006d021491bc7-59a29a93f38so186079eaf.0
        for <linux-wireless@vger.kernel.org>; Fri, 16 Feb 2024 09:36:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708104971; x=1708709771; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=HYgXTF91o+909RnC5UTLa1FzkTn/x3sNjuf0xMHeZZs=;
        b=C0Bq/PsTJ0pUa0sp7v5/dny/XHk4ps9GFJV1oLKyGG+degKvjkXlaHIY4UXNJvDHkU
         OWuyhQz/HqNMsAaJ37kL6yUpWyToRutQ5qnR2K8QEwAWcV9rgxDXt6QW1F5rvIRMGkfF
         vcgelsDMwndi5iDCkN8bN6dnWR54Iwu5bR37PeMk3q2K5iSPX6JFu3r1KVfE4gzFgsMK
         czGpvX4K4wKDZvtIdVRAHs9L4P4WHmA5vMb6ZAYSQav/CLPXgkQwkIihSlGBNkW3JwFO
         GxIzxJ1ZH1IIIfbN5Qkxw42Shtep9n8RR04EYBGgoACK1leVAH5mRnmQ2F5r4ENF9PPH
         fLJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708104971; x=1708709771;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HYgXTF91o+909RnC5UTLa1FzkTn/x3sNjuf0xMHeZZs=;
        b=q3zH1xZuL5V+NJp9a0gTaJf58TvhExLI344fH4vnfkho1Y0RPELGAEPRCq9ug7qup1
         04w4Jp3xhkHPVxWtRW0srhqpv96mI2BEom7QzqpZGKa4y6GzaoXJXJPMk0s09EOFt1P5
         oxOOGWgQa66ywgTawe4okTNeH7LZiIeatZ4PkwklhLVs2JgoiZRLW9Oq/DXy/N+dA32X
         lorzL36gVxtZpLdU/eN9aKd2VlYT2jQJ+df3cLf8udrMYCi/joI42IHXsHSuG5juZybZ
         Omo8GhkFT7vkGOMXE+uOmbJqIOpa5hGWFgTUmCRXj7xgInxkEeuIQSUWxN07F0CkMMVm
         h39w==
X-Forwarded-Encrypted: i=1; AJvYcCWHseRXiPiR+N8nAemsVyHjm8Zg1prCW6dPIpp2nDSbAUZYiIhMiQo+IGrdDWgIRIv/9RiXViMGfcsYs/D4UiOgodAbjOhb1++cE4YetHc=
X-Gm-Message-State: AOJu0Yw8DYXsNJXCrVP8uWOUJpnDwTVGqpaqNLr5NTswG5geUArQzggE
	FTUKm67BDRsATHjgu9jIk7BV5oJM9gcBIyNREIqSXQN3WHgdVqATw9XILCxI
X-Google-Smtp-Source: AGHT+IFVC7wUKyO2urtVbQibnMxFqudX5j1Q9u4Bvv+IdIs9oQokiBBTYvfH8ulunkFnkZGbLx7E5Q==
X-Received: by 2002:a4a:ead2:0:b0:59f:8465:5405 with SMTP id s18-20020a4aead2000000b0059f84655405mr5259213ooh.0.1708104970738;
        Fri, 16 Feb 2024 09:36:10 -0800 (PST)
Received: from [192.168.0.166] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id w2-20020a4a3542000000b0059c8e7b3da3sm50392oog.19.2024.02.16.09.36.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Feb 2024 09:36:10 -0800 (PST)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <9f7c6005-e9c5-4691-87c2-fee8641f02a4@lwfinger.net>
Date: Fri, 16 Feb 2024 11:36:06 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rtw88 driver support for rtl8723ds does not work on Radxa
 RockPi-S
Content-Language: en-US
To: Brent Roman <brent@mbari.org>, linux-wireless@vger.kernel.org,
 martin.blumenstingl@googlemail.com
References: <9f47e65e-35f1-b090-cad1-4d8333293b00@mbari.org>
From: Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <9f47e65e-35f1-b090-cad1-4d8333293b00@mbari.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 2/15/24 17:55, Brent Roman wrote:
> Originally sent to linux-wireless on Feb 1, 2024:
> 
> The Radxa RockPi-S has a built-in RTL8723DS interfaced to a Rockchip RK3308 A35 
> ARM64 processor on one of its SDIO busses.
> 
> I maintain Armbian's support this board.
> 
> The built-in WiFi works perfectly with RTL's 8723ds.ko driver.
> Recently, the rtw88 driver got support for SDIO.
> https://lwn.net/Articles/925940/
> 
> However, when we attempt to enable the rtw88_8723ds module, WiFi does not work.
> 
> Specifically, the WiFi scan returns only the strongest AP while indicating that 
> AP has a very weak signal.
> No connections can be made.
> 
> Unloading the rtw88_8723ds modules to replace it with 8723ds immediately 
> restores WiFi function without the need to reboot the system.
> 
> Has anyone tested the SDIO variant of this driver?
> If so, on which board(s)?
> 
> I'd very much like to get this working.
> Any tips for debugging, or just getting relevant info from the driver, would be 
> appreciated

Brent,

Yes, there are SDIO cards working with the RTW88 driver.

Is the EFUSE properly encoded on the RockPI-S? If not, then the parameters of 
the chip with respect to gains are not set correctly. You should be able to see 
that condition in the dmesg output. Also, is the driver getting a realistic MAC 
address? That also comes from the EFUSE.

Larry



