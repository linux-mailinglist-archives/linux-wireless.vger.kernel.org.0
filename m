Return-Path: <linux-wireless+bounces-10223-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0902D93130C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 13:26:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B9E31C20893
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Jul 2024 11:26:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C36813A26F;
	Mon, 15 Jul 2024 11:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="bLzzpsJf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95EE9446DB
	for <linux-wireless@vger.kernel.org>; Mon, 15 Jul 2024 11:26:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721042795; cv=none; b=sGArGyMPfFkLG+mT8vb+YyOgeaLpIJqCDG4flVrtPAJ4luJIlZGyEfTXbLymBdNUgg3u8rM8rPyhRNvB0ZaRW7/aOawmPsWhLfpAs8QKN3OPxtZWsdbsmKCaeLQlaWgvQqOvIvXFY//LcQuXrAieyA+pXp6LblcNcY/r6n21o/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721042795; c=relaxed/simple;
	bh=TuJjtxGe5O8N5xhMULjQTMcxQVTa3H3rLEG2epPMO7w=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LKbtU2kLONfMz4fwCT3U5YQadRp582uPeninunm55jQowKoLMgITmhODo0O9l5GTRyQxdhuWDdE0A1fX36lBRoAm1/eGEl9xE6mJsc8xm5iADg4KRgN59hn58Jkvl6rgXJqR5Ueq1j8quWtii271+m40BE91KH5CQm5c2cHzWp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=bLzzpsJf; arc=none smtp.client-ip=209.85.208.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-58b3fee65d8so4879160a12.3
        for <linux-wireless@vger.kernel.org>; Mon, 15 Jul 2024 04:26:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1721042790; x=1721647590; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hIJF89OU8Boh9miYMEqCB9Kf6T0TbcLRnNDn2/3ItjQ=;
        b=bLzzpsJfeCnIf6JMZvTNCvgh6fSbwEOMTp+KzTMOWpycCtDY/mfJSdQuemCtvo3v3c
         z7vXOwETN0P1FITb5Wj/u+DsNrDnyqOolFkGi7nzmuEiXNvpIBJRB7IVHqiwsIPvfUmO
         k3kZuj+6r/w8AxU2RPgk05rklLAlCLcFo8GPrVmpZbI7etDNqyC9OE3bbHQwwNS3VfEK
         bXhZfNzUFTLf4B9xIabfjx9r2pq99kYAAmlHD2ZbI46YeEdaX2ibSV5XAc+BCmk+mJHj
         qwX4tJwgmyf2Cu3bpy3rNvr7i2Ow5Lzi6pur9nDKCAzmRE/fkk+uMdhttAGzX7ck0v4s
         xcEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1721042790; x=1721647590;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:from:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hIJF89OU8Boh9miYMEqCB9Kf6T0TbcLRnNDn2/3ItjQ=;
        b=Ufrg4PtwWlpHC2z0d6xynHO00JRSjm+wMt2wQTzFuBEqqh7sHxOfCMt0GkrKjF/rQk
         dTP9OK1gxWAQ8e4Zh2bcsJW6txxpLSPcGyT+I2yFWVwV5T2wZhlUBOnY8pNjWmXWv6ux
         zE/ZkErieKWUumLbciPzoKzRz5FVe2ERajBQX7hNmriQ6z1jOfQTZeCqS2tF5fJHtxvV
         TlvsUUuCYhQhcKb5YPjJ2TKQAZYcKr1Rms+4wHILPlPZcgwnWdSLtWmtDnRD+K3MBfJJ
         Ywhj7ffzEj+L/k5lrIgXomBF5F/AYvv66v1YQUhvmOKzF4A1W6CvtfFPrdz+qrBKHh3u
         cx6g==
X-Gm-Message-State: AOJu0Yw5/+5EcKS/QGDLuv9FRIoe65VBPb5ssYw9TGCsdXner94Xef00
	TLvt0Btw00hgEhAaB9jY/mD4rjV+4a6cCQ8uB17TWJw1VglvSt8L4EqEBg==
X-Google-Smtp-Source: AGHT+IHDdMI80FcSZgsrG5yTJFuEMeIm4Xa1RxBz/tp1IcZhQPzF7ixJubtLqg94JHoWKCbdDNX6pA==
X-Received: by 2002:a50:fa83:0:b0:57d:3791:e8e4 with SMTP id 4fb4d7f45d1cf-594bc7c82a4mr10680598a12.32.1721042789557;
        Mon, 15 Jul 2024 04:26:29 -0700 (PDT)
Received: from [192.168.0.50] ([79.119.240.95])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-59b25528cd4sm3248777a12.57.2024.07.15.04.26.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jul 2024 04:26:29 -0700 (PDT)
Message-ID: <77b8adc4-daa9-4869-8773-c5de9eb84299@gmail.com>
Date: Mon, 15 Jul 2024 14:26:28 +0300
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: rtw88: The debugfs interface reads registers from the wrong
 device
From: Bitterblue Smith <rtl8821cerfe2@gmail.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Ping-Ke Shih <pkshih@realtek.com>
References: <e28bbf72-678a-438b-b5dc-d4ae8b8f71f0@gmail.com>
Content-Language: en-US
In-Reply-To: <e28bbf72-678a-438b-b5dc-d4ae8b8f71f0@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 15/07/2024 14:05, Bitterblue Smith wrote:
> Hi,
> 
> To reproduce the problem, you need a computer with two wifi
> devices supported by rtw88. It's especially easy to notice
> the problem if one of the devices is USB and the other is PCI,
> because the PCI device will have various values in the
> registers 0x300..0x3ff, but the USB device will have all
> 0xeaeaeaea there.
> 
> 1. Let's assume the driver for the PCI device is already loaded.
>    I have RTL8822CE.
> 
> 2. Mount debugfs:
> 
>    # mount -t debugfs none /sys/kernel/debug
> 
> 3. Check page 0x300:
> 
>    # cat /sys/kernel/debug/ieee80211/phy0/rtw88/mac_3
>      00000300  f7138000    33330000    ffffb000    00000000
>      .....
> 
> 4. Plug the USB device. I used RTL8811CU.
> 
> 5. Check page 0x300 again:
> 
>    # cat /sys/kernel/debug/ieee80211/phy0/rtw88/mac_3
>      00000300  eaeaeaea    eaeaeaea    eaeaeaea    eaeaeaea
>      .....
> 
> 6. Bonus: unload rtw88_8821cu and check page 0x300 again to get
>    a null pointer dereference:
> 
>    # rmmod rtw88_8821cu
>    # cat /sys/kernel/debug/ieee80211/phy0/rtw88/mac_3

I forgot to say: my kernel is 6.9.8-arch1-1 from Arch Linux.
The problem also happens with kernel 6.9.8 plus rtw88 from
rtw-next.

