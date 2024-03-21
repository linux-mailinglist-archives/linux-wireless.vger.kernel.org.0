Return-Path: <linux-wireless+bounces-5107-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 476BA885FD7
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 18:35:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F18F0283C02
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 17:35:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 87DEF8613B;
	Thu, 21 Mar 2024 17:34:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VepOP08B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CD0616410
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 17:34:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711042491; cv=none; b=mzNzH6Hg8j5NAH1a3KfbvFb15MNS0hen6QRxnz2VPWBYykUfoxJULJS2mIvZ31zCVgzb/VNOaCGAv/YFNNDs9lxZtDeTJJX4fNP+9EieEKbpw9q160OFxf1Rsds9SlmJxSX/mO5NkLevh3M9CBIr+RbiX5n4tMRUGlKET7zQr/s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711042491; c=relaxed/simple;
	bh=jhTO/ydPX9g5g4rtol/vb/2RSldjnALTVWw51QIPEXw=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:References:
	 In-Reply-To:Content-Type; b=pvabJJZjPPwTb2U9ZAAE9ekGMX2cKHEgv3bzNvx3dqpJD29jnpr/poufcOqmYGFLf9wivRq+heXae5waEB/29vxvqa3fDjPCGSHwWCFSb9khWOyD2MselWO1kPXEVHGOZwafZU6OlGb+cuj4D7hEWUCM5p2FMnvdeE0mTb2Tg+4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VepOP08B; arc=none smtp.client-ip=209.85.160.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-2228c3ffcbdso486365fac.2
        for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 10:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711042488; x=1711647288; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:sender:from
         :to:cc:subject:date:message-id:reply-to;
        bh=M0aol3cRXW5mVZMGjY/LDj6dprEBJSsM3MjsNvXaPAs=;
        b=VepOP08BNSodvPMezvsIa64DGO56iqwnik2Oy+hdfJYpPgFVcGEfiwG2cMZaKyHsFe
         yAIu+OOkSPHaAez3hEJJTkFT9tbZd1PH3Xlt4pZ3XR26C+B3n+vpACjHu9a0gEmbYwaF
         W73rVCF3bRWXlBXS2PGCJ3dskRYTAhE4jNR9g8nCopexqeWsFa8W88nU4dkNKRskmCzT
         N1AyLsAmHf9Q+UlISVuUq6tA8w55nxOf08pr6LA1QaVIeh/bT5OAXkneQxo1Ic9+D/3+
         +9SwTdIQmyU/LpwnfTj0kAP91rodcjZxnd7nI2Io0aZQL1X++C10mFMOSWSArSN/Oh4q
         qUrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711042488; x=1711647288;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:from:user-agent:mime-version:date:message-id:sender
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M0aol3cRXW5mVZMGjY/LDj6dprEBJSsM3MjsNvXaPAs=;
        b=ZFLQWPury1zPZ3StbA0c/JpvpWm0nY93wD/wfcBzcfyjJwRL0mbMBi4s5ZiOBFYe/Z
         4Rpy1foHNGbMUKjIohzzvEUyMwOvj67xGBFS7quYO14bQnH13w3n2iZ8ZCP6U/ky2uGK
         YGuQjZ6otOvIzi+Dwgt+jBoxfWaODoGtMKEQXaYouc0jWruX4t+nBZ2SoqvB8CYaCRHg
         LBoXEKngVzOXNIcKDqVOMp8+zVLD9Hhv689N/fR/61sbyG7URbMY0RGjy52h/6r42vr+
         wlR9481BBuTg1WgCm94zm1Ne9A1ugDKfS5OOGNP42bJxqlUBuKFEGzO9V/a9mrT36pjn
         Bl2g==
X-Forwarded-Encrypted: i=1; AJvYcCWb1Auyo3dbxeMcWF86Yy8cwsDIiLtavyp48El+Tqi7FdGo4nn0v/ai1xYvKgnBon0H+avZxdrmhUS7pefbD4Jfr2tHI3v4EFzmeDw/2+I=
X-Gm-Message-State: AOJu0YzzIA+dB64dP8nCGdcA/TudEMShNbFCj4oxpzAA/vTdl9FQ9lT2
	yfV3NiK4ZHZjM0z9FW03aM92whqy+EzZVmjWslZMvZ/DKt90RvlJaAyPuhj6
X-Google-Smtp-Source: AGHT+IEVNmX5UN7e0TrGWz+UUBqJOqlKuMjqs04nMjbKtSgKalkNbqNE951F+DclzDbxwydgfg3EkQ==
X-Received: by 2002:a05:6870:e984:b0:229:9e7e:7d50 with SMTP id r4-20020a056870e98400b002299e7e7d50mr6082735oao.9.1711042488488;
        Thu, 21 Mar 2024 10:34:48 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id sa23-20020a056871211700b002201144306csm60953oab.53.2024.03.21.10.34.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 10:34:48 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <f9206f84-554f-42af-8bd1-22e3ce087900@lwfinger.net>
Date: Thu, 21 Mar 2024 12:34:46 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Larry Finger <Larry.Finger@lwfinger.net>
Subject: Re: Is RTL8822CE with Kernel 6.1 for imx6
To: =?UTF-8?B?5pa95bCP5LiwKOWMu+eUqOWItuWTgeS6p+S4mumbhuWboi3ljLvnlKjliLY=?=
 =?UTF-8?B?5ZOB6ZuG5Zui5pys6YOoKQ==?= <shixiaofeng@weigaogroup.com>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <AF*AOABLHt4n7diA--9SIKqg.1.1711026798731.Hmail.shixiaofeng@weigaogroup.com>
Content-Language: en-US
In-Reply-To: <AF*AOABLHt4n7diA--9SIKqg.1.1711026798731.Hmail.shixiaofeng@weigaogroup.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 3/21/24 08:13, 施小丰(医用制品产业集团-医用制品集团本部) wrote:
> 
> Dear linux wireless team:
>     This is Danny, a embedded software engineer
> 
>     I have successfully run the 8822CE module in Linux kernel 5.4 with imx6 
> hardware platform.
>     But it doesnt work in Kernel 6.1 though i have put many efforts to this issue.
>    So, we'd like to check with you whether the RTL8822CE chip is compatible with 
> Linux Kernel 6.1.
>     My usage is as below:
> 
>  1. imx6 board
>  2. build RTL8822CE as M in kernel 6.1 menuconfig
>  3. Each time after the board startup, i run four commands 
> 
>      insmod rtw88_core.ko
>      insmod rtw88_pci.ko
>      insmod rtw88_8822c.ko
>      insmod rtw88_8822ce.ko
> 4.  When run  insmod rtw88_8822ce.ko, in most cases, the error will show as 
> below. (few times can work)
>   Detail error log is attached.
>    Same step (1) -(4) works very well with kernel 5.4 in same hadrware platform.
> ================
> root@imx6solosabresd:~/8822CE# ./insmod.sh
> [   60.541840] rtw_8822ce 0000:01:00.0: enabling device (0000 -> 0003)
> [   60.558145] rtw_8822ce 0000:01:00.0: Firmware version 9.9.4, H2C version 15
> [   60.567135] rtw_8822ce 0000:01:00.0: Firmware version 9.9.15, H2C version 15
> [   60.706697] 8<--- cut here ---
> [   60.709775] Unhandled fault: imprecise external abort (0x1406) at 0x01b77740
> [   60.716832] [01b77740] *pgd=00000000
> [   60.720421] Internal error: : 1406 [#1] PREEMPT SMP ARM
> [   60.725653] Modules linked in: rtw88_8822ce(+) rtw88_8822c rtw88_pci rtw88_core
> [   60.732991] CPU: 0 PID: 796 Comm: insmod Not tainted 6.1.22-g9c59b15a9e72 #1
> [   60.740049] Hardware name: Freescale i.MX6 Quad/DualLite (Device Tree)
> [   60.746580] PC is at rtw_pci_read32+0x14/0x18 [rtw88_pci]
> [   60.752015] LR is at rtw_chip_info_setup+0x48/0x588 [rtw88_core]
> [   60.758170] pc : [<7f026048>]    lr : [<7f0001c0>]    psr: 60010013
> [   60.764442] sp : c1d0dd28  ip : 00000201  fp : 89344040
> [   60.769670] r10: 88b397a0  r9 : 88b3f890  r8 : 00000200
> [   60.774897] r7 : 000003da  r6 : 000003d9  r5 : 7f03a2c8  r4 : 88b397a0
> [   60.781428] r3 : c09200f0  r2 : 00000000  r1 : 000000f0  r0 : 00000000
> [   60.787959] Flags: nZCv  IRQs on  FIQs on  Mode SVC_32  ISA ARM  Segment none
> [   60.795100] Control: 10c5387d  Table: 15d10059  DAC: 00000051
> [   60.800848] Register r0 information: NULL pointer
> [   60.805564] Register r1 information: non-paged memory
> [   60.810620] Register r2 information: NULL pointer

Danny,

Sorry, the previous message was sent too early and incomplete.

The RTL8822CE certainly works with kernel 6.1 on X86_64 hardware. Routine 
rtw_pci_read32() where the unhandled fault happens has not been changed since 
kernel 5.2.

That "imprecise external abort" is ARM specific. I have not yet found the reason 
for it, nor what the value 0x1406 means.

The range of kernels (5.4 to 6.1) is pretty broad. Are there any intermediate 
kernels for you to test?

Larry






