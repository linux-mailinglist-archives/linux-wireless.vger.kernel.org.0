Return-Path: <linux-wireless+bounces-8859-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 22186905230
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:14:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 21DAD1C21B6E
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:14:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6E16C16F0E4;
	Wed, 12 Jun 2024 12:14:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="TX/k7pYG";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WElpAgrt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA9C538F83
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 12:14:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.142.43.55
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194448; cv=none; b=mqY6ytTGrRQgXEic9rVVFE6G/cLN5nu8oDi3/ekasrcU3Gg0NmvIFEvk/WCbOBxXi58tBr1ClHxxCiIJPVNfUmLoGLORAkzGJzNJRcpuHKiOaiVSFnd0wWE7ARaQI6ymLpRTIISTnbfTfEDeC7ej5o2dUZkiDAZgEl/hUWFTM0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194448; c=relaxed/simple;
	bh=qXZLIqICJNwmkl8ZW/gkmNOQvenhDGAMd5JRdma0hwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=PblL0MThI+xzoqcxfRzZ9TDgPOUOkByPBOIWSnWO81oNTXNr2XHmGHaAxBFyDtBdFQDgBLpYhjl3c2J4nIo/dbfqZelz6fp5jwskcU025vUdnWrqbRNOdJuMS97gfkr7yzo9stFOSErOw6Hoosw1FpHpk/GQAeFnFxA5PLgjXM0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; spf=pass smtp.mailfrom=linutronix.de; dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=TX/k7pYG; dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b=WElpAgrt; arc=none smtp.client-ip=193.142.43.55
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <0cbed427-e772-416d-ba40-32cbb59c8083@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1718194444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BGk/1iMmRrfE1DIf5sik0hU4QcQc0eVeNmC9n/fpms0=;
	b=TX/k7pYGno3XXfndXH7deEYnC8GCjb6ygs9QLIucuQMoDlRmZIAejURl5e7CUNso7M7t/D
	6TWvKOWUphqBhg2qLPVGQSLgQxpnpKyUkN7cc3kUP4uZElAC90bitNZXAmRLLMpMY+uhKa
	7Pd7jawdqo55gIUOIRadTbaeleBcFeSWOSElLxuq2ICFI+aogatdZwJ9IJmzFliu7c9SFk
	ldE48rtVqszDOJCMCJO4vWJtTtELz+CT5zF5pfYy0b4ZqBEYRA7gYm35C8qcXXNMad0Jmj
	yFV55ZPw8VFv7FPTUWTXPgrw2NJbGTOPz9r17eq/b1r3cb3XgmmAGsr5kJWa7Q==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1718194444;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=BGk/1iMmRrfE1DIf5sik0hU4QcQc0eVeNmC9n/fpms0=;
	b=WElpAgrtP/TSx1rZlz/Zwr2HyDMNPZoawkLB9yzgS/FWFhv/DlX1LPpXVPwFXnJJ42p0RR
	cwX1qaUYHgLzPyBg==
Date: Wed, 12 Jun 2024 14:14:03 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: ETIMEDOUT with rtl8xxxu
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Ping-Ke Shih <pkshih@realtek.com>
Cc: linux-wireless@vger.kernel.org
References: <ee08c815-9389-4277-be6d-197511636892@linutronix.de>
 <e46407b3-3531-4935-a0a5-5132d5baa722@gmail.com>
Content-Language: de-DE
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <e46407b3-3531-4935-a0a5-5132d5baa722@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 11.06.24 um 22:15 schrieb Bitterblue Smith:
> On 11/06/2024 18:54, Martin Kaistra wrote:
>> Hi Ping-Ke, hi Bitterblue,
>>
>> I have a problem with the rtl8xxxu driver and 8188f, but only on some boards. More specifically, I can see that during the second channel switch (which happens when I do "iw dev wlan0 scan"),  the rtl8xxxu_read32(0e08) returns -110 (ETIMEDOUT) and after that no reads or writes work anymore until I unload and reload the driver.
>>
>> The strange thing now is, that even though it seems to be hardware dependent the vendor driver does not have this problem.
>>
>> I tried to change the probe and start functions, so that they behaved exactly as their vendor driver equivalents, but so far I don't see any improvement.
>>
>> I was hoping, that one of you maybe has an idea, what could be causing such an issue and how to avoid it.
>>
>> Martin
> 
> Does it still die if you do a passive scan?

no, the problem seems to appear after the first sent frame. So, if I don't send 
any frames, the channel switching works fine.

> 
> I wonder what vendor driver you are using? Is it loading the
> same v4.0 firmware as rtl8xxxu?

using the firmware from the vendor driver or the firmware from rtl8xxxu made no 
difference.

> 
> Why reloading rtl8xxxu makes it work again? A USB reset?
> Or something in the disconnect function?
> 
> To avoid the problem, obviously you have to make rtl8xxxu
> even more like the vendor driver. :)


