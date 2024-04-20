Return-Path: <linux-wireless+bounces-6604-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51C488ABCD4
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Apr 2024 20:52:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12A6C281364
	for <lists+linux-wireless@lfdr.de>; Sat, 20 Apr 2024 18:52:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2DAD0168CC;
	Sat, 20 Apr 2024 18:52:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RMq7zgVE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7546D205E16
	for <linux-wireless@vger.kernel.org>; Sat, 20 Apr 2024 18:52:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713639153; cv=none; b=I93esBP6HK/8umFmFx9P9ff3X7XxcHmUVSvTrNXNenbvHykP6T56kYs71433NDc1f4gOmlcZL3aP/xyCSHt3nwL/graBSCpvfHOtW1mc+mCTJMBT+PgRH8YqyJQ/jzsiS7DhrUJ8UUGTqiGaUxK8PLTvR9yQXuGSCZohw1B+P5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713639153; c=relaxed/simple;
	bh=S9ggd7NT2okWKf6R65ZxzHhTyID9ko/w22VpbIXk7A0=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=imdmMQ1q8I29cOrc9NBwTUBJL7dINjIisQg7+f7LOdEy5/nIbR0DDloD2utirvbbVTRM3U92KDrr18JNZFpRGNvfLsT9AS+vC8s1sHrNSc+TMK2Cy0GsThGJyLMeGAnfh+G/Zdr4aHFYICblDjOp4rHtK83mW1jFMJ+H0NfHGis=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RMq7zgVE; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-34a7e47d164so1100619f8f.3
        for <linux-wireless@vger.kernel.org>; Sat, 20 Apr 2024 11:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1713639149; x=1714243949; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=icllaj3GtgRBKNT1A2DiXh1/rtxQ4f7lkqRmyecqcVw=;
        b=RMq7zgVEUn+xsf/LoS0p1T7QFaNAGYxtIr7HpMJVr+edr96uqibzhHrjOrxydL4ZXF
         Xy3f2A7q4ZnedZrykeW5xHEFk5hZ2x/VNpjtW5wg95EHfiOoEg1fbZrhsLpZV4g8rXLH
         /pYq6ykv3DZ0m8uXckuOVySWlAg1Xo7TkE12cP94Bnk6Zo13lBbrHm6cTGpIi77/Dn6O
         Y/J+rlCSazkPH6EZI0crTBXNfDSjKReRuUZXAvR7tBBXBnUv+cdfiyWYjhS/VgXCCKvk
         BJXEiBnRUdcps7yRN4gnr7zEwSpuRLYg/2GxGvP5TNxSo4cykvqX26DPGU63chsaO6+S
         ErTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713639149; x=1714243949;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=icllaj3GtgRBKNT1A2DiXh1/rtxQ4f7lkqRmyecqcVw=;
        b=hpStfs/21rklgcvVucshyMOgFqe+rucyN8uIuWhTmJpbamgHdl98iuht9pZp1mrphW
         mqhgoDwpcF/KATLFyCsagcJFSzrF5RHEWfD0ao7Yxn5dSqxqW9nDSmFyXzjsDWGx79yD
         8VVDVZDDxc5W5FnzjATE0OAxgGHZQMBbaX3pVGg8b1KZmLZBwmT7UCGa3KBpCpkWWTUF
         xrOwnw7AK+h9SN8qeHg7VtK2DDMXboRXxb/jkqC0LL0g9oVVAwCqCf0Hj2ciG+2YaTJe
         Tyghxj/sXtk2E2hpdAhUmMa2hJkY92783o2R8gF23Mw6lh7EHEnAAp989sN8rvIRBYQd
         iEEQ==
X-Forwarded-Encrypted: i=1; AJvYcCU7jfc88U6r2JRtoEmzvl67kA2hXFwmuqCyQCVdCR4jeuf9LezUqV1Lzv5L+aeKcyU8xGWDXCNbdE3D/NmDlsR3tr0WVcdqynIP3ENdcp0=
X-Gm-Message-State: AOJu0Yy7XtXFW9YdR9YNmM76kzeBkZbfIxxD7a0W/4Z89j33asHvEuns
	xYkP67mL0EWiI4Q+Al2ZaCGIu3pAvWVLmp9ZANaCRhXzEyOI/KYiAHQMrv2J
X-Google-Smtp-Source: AGHT+IHsDQecoAGl/3fM3STKSTX0uqard8NDVcQutV+5Uf7jaTf3OU9eLIwMUqzcAAItAUmCqjfL+Q==
X-Received: by 2002:a5d:554e:0:b0:346:b778:eaa7 with SMTP id g14-20020a5d554e000000b00346b778eaa7mr4362948wrw.18.1713639148718;
        Sat, 20 Apr 2024 11:52:28 -0700 (PDT)
Received: from [192.168.1.50] ([79.113.154.240])
        by smtp.gmail.com with ESMTPSA id cd19-20020a170906b35300b00a4673706b4dsm3685168ejb.78.2024.04.20.11.52.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 20 Apr 2024 11:52:28 -0700 (PDT)
Message-ID: <195b36bc-adbe-4b83-adf6-2ea2d6b7cd9d@gmail.com>
Date: Sat, 20 Apr 2024 21:52:27 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
Subject: Re: RTL8188EU driver for Illumos
To: Carsten Grzemba <grzemba@contac-dt.de>, linux-wireless@vger.kernel.org
References: <bf57fa6d629f.6622e8c3@contac-dt.de>
Content-Language: en-US
In-Reply-To: <bf57fa6d629f.6622e8c3@contac-dt.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 19/04/2024 22:57, Carsten Grzemba wrote:
> Currently I try to create a driver for RL8188EU chip for Illumos.   As template serves    the RTWN driver of freeBSD   .   The starting base is the URTWN driver for RTL8192CU for Solaris from http://freenicdrivers.la.coocan.jp  . 

Hi! Good luck, haha.

> The driver works so far that WiFi scan and the registration to an AP works.   I see data packages arriving on the interface.  
>  
> However, no data package go outside, so that no IP connecting can be built up.    
>    
> It is strange to me that communication with the AP works, but not to other stations.    I suspect that the problem lies in the configuration of the TX descriptor.   However, I lack the knowledge of the meaning of the individual bits.   Is there a developer documentation for the TRL8188E chip public available?   

The official driver is probably the only documentation you
will find. This is the newest version I know of:
https://github.com/ivanovborislav/rtl8188eu/

This one is older but it's updated for the latest kernel:
https://github.com/lwfinger/rtl8188eu/tree/v5.2.2.4

> It s possible to check if the firmware can not interpret the TX descriptor properly?  
>  
> When comparing the descriptor with FreeBSD, different settings are noticed in DWORD5 (OFFSET 20) (data rate, RTS rate).   Can these be the cause of not sending the data packet?    

If it can transmit management frames but not data frames,
you may be using the wrong TX queue (bits 0x1f00 in dword1
of the TX descriptor), or the wrong USB endpoint.

>    
> The current state of my work is avail at: https://github.com/cgrzemba/illumos-gate/tree/15014-urtwn-8188-3
>    
> I would be very happy if you could help me.   
> 

Some things I noticed are missing from your driver:

https://github.com/ivanovborislav/rtl8188eu/blob/163badb4564be50ce11aa3e6fdd2e18f3e4c4b90/hal/rtl8188e/usb/usb_halinit.c#L1335

https://github.com/ivanovborislav/rtl8188eu/blob/163badb4564be50ce11aa3e6fdd2e18f3e4c4b90/hal/rtl8188e/rtl8188e_hal_init.c#L2764

I think it will save you a lot of headaches if you make your
driver perform exactly the same register writes as the
official driver does in the chip init/deinit functions. (You
can probably delete "#define CONFIG_IOL" and use the official
driver as reference without that stuff. rtl8xxxu works without
that.)

>    
> Kind regards
>    


