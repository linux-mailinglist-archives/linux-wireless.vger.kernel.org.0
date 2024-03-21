Return-Path: <linux-wireless+bounces-5105-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 93092885F2C
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 18:07:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B70A41C23913
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Mar 2024 17:07:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76CE0135A44;
	Thu, 21 Mar 2024 17:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ezp+lh00"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36C9F20B00
	for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 17:00:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711040460; cv=none; b=ZzFG/UMI4283OxpVrD4VnevPAKB6n7nBelMxFbtRem/9BZBZ6ZX2DEGM1rg8MmX2DVtbJdnnUg1cx0pv4YAHJas/lnT71Pcznj8aFVu/TJ6yCxzASgSHFsdb3PbbglGgFXrv9KxRI8AQXQjWTzHCvkvNIcetREFuz2ANFAR/Xik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711040460; c=relaxed/simple;
	bh=kxA6j/sLvfHtIDVuxrpB+oAzL8fWSGAx5/Ktcuh0LIM=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=SsvDoN/qexogB5YN8aLcTaojQMCbo0pfuSz/srOjMY7I0R+TlcFrqysVDy+f/eR+0UEHTdJiVUENEpu4RacpT9GVOOV9nB1zpUft+0FTSm7u6iGoiD5GiBb3VYTy9c2NyIxQoZS3w6mAUAyrwQ5rgy2I2OF9nL1k1k2j4WDUW4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ezp+lh00; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=lwfinger.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5a4859178f1so655878eaf.0
        for <linux-wireless@vger.kernel.org>; Thu, 21 Mar 2024 10:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1711040457; x=1711645257; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=Bi6qne34obTziw7kIdkMOgaA9asBzv9Y6LU9ez0EgFs=;
        b=Ezp+lh00VcD6TsSHkkDiOx4GK6XVX64JpscHjYYlmSSkn5W2JdVSUF4wArUAYKiZj1
         L3KPw2LKhyLV0ED0xINa30HFZKgP7NsWTjFefhqIRE2z5qvcIlV+OnmRZ0I/dUcQooIA
         G7sv7EflxcFpA/vbR2oHLOKa5NJmjqV3L4kUl+SbqGDH9pv5wA8KCgVfVUhxcftbHa28
         q5k2FwhsXyE6WToDE9dijZkadKH+KVjPnd3skhx6G9IlTSsVJw82mrGqr/7Lb1BEX9qj
         ORLrPRdYCp0tOMRHXSvapb+OPjWm5joGhYQ0oB+r0tGf88QezqWW/DlMQcbaJRmyuQIX
         WIUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711040457; x=1711645257;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bi6qne34obTziw7kIdkMOgaA9asBzv9Y6LU9ez0EgFs=;
        b=HNuhkp+Ytbh8M2Oz/iwcxu4adPB9RcNCMUZ6Uk417ZspRq2Lr3vwL1+mJ+jIvu9rMB
         Zs6YdFvQsJVJrVDyNaprSi3A0Y9aOBmxITOAW/dvs6/TDOdPXEEFj1I+U5VhV1HC+3JM
         mEf4JdAFxum+i1vYn0yx8rzhQTJWgmZpuKatsp4sF/gCEFr7qD4iX6FOjA5KloL7teh0
         fzlftqwKn1B578UxJvsEc2dbVEjvMzo+86UOAgsG+jCszXMBXG4FNfMUbesDub7uqQa5
         s/5sAPB+y/nGzm66gDb/ciEGy5MmjHScUmVzhGfc1fPzuMI+yOmNZF0s2dEZKFWf4B3c
         jbHA==
X-Forwarded-Encrypted: i=1; AJvYcCVLoq0R6Uzb7TVSpJPsiAx5AKrb3sxKpsPs1dYquvRMW93vipdEVvjgOaxB2vyI1+GbO5XL0LcOXyNrsn7Kygl3+GlD7SNGKjYUBsg1gXg=
X-Gm-Message-State: AOJu0Yy6h7zR6CD8Yf3I4oRumiqRGXysYkh+2JZje461WuQKkyyW+Q4p
	TjqDAGWYemSgIxa+pC/DaX5v64GjZXUQzWTScnR0IR1M2peqGr7r1qOHBzcg
X-Google-Smtp-Source: AGHT+IH8k8YfiVHopGEl+fkeE/XB/Yjd27qzT7txviammJ+lWhJHZW54V+obzs+MsBJEoAbmQdMrew==
X-Received: by 2002:a05:6820:2982:b0:5a4:6af7:5504 with SMTP id dq2-20020a056820298200b005a46af75504mr162704oob.0.1711040457143;
        Thu, 21 Mar 2024 10:00:57 -0700 (PDT)
Received: from [192.168.1.119] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id by12-20020a056820200c00b005a0fc5a89dfsm3322107oob.5.2024.03.21.10.00.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Mar 2024 10:00:56 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Message-ID: <6830a20c-462d-425a-9c0d-0f76de270877@lwfinger.net>
Date: Thu, 21 Mar 2024 12:00:53 -0500
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: Is RTL8822CE with Kernel 6.1 for imx6
To: =?UTF-8?B?5pa95bCP5LiwKOWMu+eUqOWItuWTgeS6p+S4mumbhuWboi3ljLvnlKjliLY=?=
 =?UTF-8?B?5ZOB6ZuG5Zui5pys6YOoKQ==?= <shixiaofeng@weigaogroup.com>,
 linux-wireless <linux-wireless@vger.kernel.org>
References: <AF*AOABLHt4n7diA--9SIKqg.1.1711026798731.Hmail.shixiaofeng@weigaogroup.com>
Content-Language: en-US
From: Larry Finger <Larry.Finger@lwfinger.net>
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

The RTL8822CE certainly works with kernel 6.1 on X86_64 hardware. Routine 
rtw_pci_read32() where the unhandled fault happens has not been changed since 
kernel 5.2.


