Return-Path: <linux-wireless+bounces-1204-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 631ED81C5EE
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 08:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BDCA285E70
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 07:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEF48BE47;
	Fri, 22 Dec 2023 07:49:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="AmCJ9Vdl";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="pH1/A28N"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60330BE48
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 07:49:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <6aaae1a4-5d34-476e-b64b-2c19b7a15473@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703231363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1zBruhU6Y4w8/ki7Ulq65ZHtZq9GY0LM2gc43GbT+M=;
	b=AmCJ9VdlE/Gj+DyeEsD7psapz78otYKc/rtio+qsClSjp8vfD9zSqwTtvyQm1kEAkKn9lN
	dehWLq1MUagyIXOMQC3/DmgA/9j6fh09uLTdgHPrXg3gz7moJaodkJvsfIB1nWw5Fnq4pB
	DezVlK19EGxR+IdDftgfd+fdFnLjZ0gPIaaDhehiiATCgv9/z7Fp/D8wzD2z9pJs1s6F8b
	kf/UqHRx4HY+dHkBUDDAOu36mPvexhI06wfaJwbd+Gvm3/86HTwioV732q6q7fn1O3ZAdg
	8Lwl4Kd0dR7aWl+HWJuWa4cdZGOMt/mAEzaGph3Dteyf2VMH2p+BBCxeCNzVLg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703231363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j1zBruhU6Y4w8/ki7Ulq65ZHtZq9GY0LM2gc43GbT+M=;
	b=pH1/A28NOZHTrm52QQTfUGtgIFaFuyO1fqkHJylSJf6duSrPAv0sKvfgVNpfR2zJSgGQie
	1GwJzekiihlBWSAw==
Date: Fri, 22 Dec 2023 08:49:23 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 20/21] wifi: rtl8xxxu: make supporting AP mode only on
 port 0 transparent
Content-Language: de-DE
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20231221164353.603258-1-martin.kaistra@linutronix.de>
 <20231221164353.603258-21-martin.kaistra@linutronix.de>
 <7bbb0d0b803d49088957b47ad716e99b@realtek.com>
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <7bbb0d0b803d49088957b47ad716e99b@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 22.12.23 um 02:54 schrieb Ping-Ke Shih:
> 
> 
>> -----Original Message-----
>> From: Martin Kaistra <martin.kaistra@linutronix.de>
>> Sent: Friday, December 22, 2023 12:44 AM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
>> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de>
>> Subject: [PATCH v2 20/21] wifi: rtl8xxxu: make supporting AP mode only on port 0 transparent
>>
> 
> [...]
> 
>> +
>> +       /*
>> +        * priv->vifs[0] is NULL here, based on how this function is currently
>> +        * called from rtl8xxxu_add_interface().
>> +        * When this function will be used in the future for a different
>> +        * scenario, please check whether vifs[0] or vifs[1] can be NULL and if
>> +        * necessary add code to set port_num = 1.
>> +        */
> 
> Did you run scripts/checkpatch.pl to this patch? Initial line of comment block
> for networking code should not empty, so it should be below:
> 
> +       /* priv->vifs[0] is NULL here, based on how this function is currently
> +        * called from rtl8xxxu_add_interface().
> +        * When this function will be used in the future for a different
> +        * scenario, please check whether vifs[0] or vifs[1] can be NULL and if
> +        * necessary add code to set port_num = 1.
> +        */
> 

I did run checkpatch.pl and chose to ignore this warning because all other 
multiline comments in the rtl8xxxu driver also have this initial empty line.

Do you still want me to change it?

