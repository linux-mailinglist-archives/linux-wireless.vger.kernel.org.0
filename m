Return-Path: <linux-wireless+bounces-9282-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A1C4C91005B
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 11:29:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B3BD51C210DA
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 09:29:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 883241A00C2;
	Thu, 20 Jun 2024 09:29:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="455Y4DfC";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="mdWQu1Wb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA04E39FD7
	for <linux-wireless@vger.kernel.org>; Thu, 20 Jun 2024 09:29:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718875768; cv=none; b=ZRdIz10FIjaOH3Db8dl9PE/AIn9FvPB8Xjx5AdFxtjuBad5rooAnoPya20e5kaVr1BM4xWqHXii5R4YHv7yqTt7b3J55SP3JirruUKMRvYvKFY9nNUgoYv1D316i1C0GJ9iGP3DaxJ6Q+dfyEK1vp1vqV4S69ndO5ST2n2frkJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718875768; c=relaxed/simple;
	bh=zt31FhiMumx3MPxr1BNq1Pgmcm8cxEhtCRrzQu74ALk=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=u0BiL0ciuwXLtvmyvN1VWg3OX30lv0h660WTW5Xm0n6RDxoQPsEA9fAO5TDP54u5ekoDP4gRQtqBd+z8qmGKWrZZ24VYFEzsMg05LqqBNVVp/H4XFALxgl1WT+iR65vpLeh+LEIC4RJI5ndw8NBzzi5BTruyuGFT7Bs3/STWmFs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=455Y4DfC; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=mdWQu1Wb; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <866b5d0f-5c89-4dcc-adeb-8ebb0cc340e2@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718875764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WCCb2gpcdlseiJAeB8VVwI0SdeLz44tD0i1Mpz8Ghs=;
	b=455Y4DfCvcfdk0SxImKhNoCoJmuXkT3x6xQvMiYIjFXtVSmebmC0decrt+y48EjT5Ze09y
	M68clQjOa/V9u1LU6y0JidbHzug6SMbJB80YNPkOWH7dcZLbPQQDbvQlr70SYkCfVCJLuM
	TOTHif6wMuz0yyUN8ZdkkHB1aG+KoeUn6CPtj9j9JSxBL8fSYEaCaW6DvlF1nn7JtgLOrd
	oRCMa7aDSReZ+kflv6wZZsjMryY4VFnvfSmMGkt8+2lFzrH8pLErL4IZcOq4Sv85O0glcA
	EfNs9oqOtIUCVfJmSYGi9rFe0CfzBRS1PbWiBH1I13oBf0y797/BJk/lqTSgYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718875764;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=0WCCb2gpcdlseiJAeB8VVwI0SdeLz44tD0i1Mpz8Ghs=;
	b=mdWQu1Wbx4Tm+XO4hnBqOak3PAtBxpuwnTJvQRZe/IwCSAkYXPrSCj6JaAQzE+btOMMdCX
	14myfGMY3/co+jCQ==
Date: Thu, 20 Jun 2024 11:29:24 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: ETIMEDOUT with rtl8xxxu
From: Martin Kaistra <martin.kaistra@linutronix.de>
To: Ping-Ke Shih <pkshih@realtek.com>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>
Cc: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
References: <ee08c815-9389-4277-be6d-197511636892@linutronix.de>
 <1385519564244924a1101770344544a0@realtek.com>
 <8581983e-714b-4173-9150-061f57516ab8@linutronix.de>
Content-Language: de-DE
In-Reply-To: <8581983e-714b-4173-9150-061f57516ab8@linutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 12.06.24 um 14:20 schrieb Martin Kaistra:
> Am 12.06.24 um 03:47 schrieb Ping-Ke Shih:
>> Martin Kaistra <martin.kaistra@linutronix.de> wrote:
>>> Hi Ping-Ke, hi Bitterblue,
>>>
>>> I have a problem with the rtl8xxxu driver and 8188f, but only on some boards.
>>> More specifically, I can see that during the second channel switch (which
>>> happens when I do "iw dev wlan0 scan"),  the rtl8xxxu_read32(0e08) returns -110
>>> (ETIMEDOUT) and after that no reads or writes work anymore until I unload and
>>> reload the driver.
>>
>> If this symptom is 100% reproducible, I would add many rtl8xxxu_read32(0xe08)
>> somewhere to bisect the cause resulting from writing IO or certain H2C commands.
> 
> Thanks to your suggestion, I found out that
> 1) the timeouts start occuring right after the first frame is sent (rtl8xxxu_tx)
> 2) the adress doesn't matter, rtl8xxxu_read8(0x100) also gets a timeout
> 

After doing more debugging, I saw that the values that are written to the 
txpower registers are different between vendor and mainline driver.

The efuse for the problematic boards has no txpower values set, but reads instead

00000010: ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff ff  ................

I guess, they haven't gone through the calibration stage yet..

The vendor driver seems to have a check for invalid values and uses some default 
values instead. rtl8xxxu just uses 0xff, sets the power to max and then once a 
frame is sent, the USB power supply is not enough and the chip goes into reset?!

When I either comment out the calls to .set_tx_power() or add some defaults in 
case of 0xff in parse_efuse() the chip works and I don't see any timeout problems.

I will prepare a patch to fix at least rtl8188fu_parse_efuse() and then we can 
see how to implement it for all supported chips.

