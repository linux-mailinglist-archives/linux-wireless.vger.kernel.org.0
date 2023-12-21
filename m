Return-Path: <linux-wireless+bounces-1142-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E247A81B475
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 11:54:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 82F9E1F21DB8
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 10:54:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74AA06A017;
	Thu, 21 Dec 2023 10:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="wjdWIW00";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="y1ycMfMe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0F6569799
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 10:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <2c444230-bf30-427e-a498-877ed6d3e7cd@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703156070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LxOp/EW/Vd1mXSk+y8EUFCpOxUF5Y2f3JGiVPDsGrQ=;
	b=wjdWIW00ku1ahfwljgzGC6uVZn8kmR1lD8T4aJJ8258Lq9vcQo5JH53PsxzV/BpnWHmDMs
	B3dw0J/bj6jGKZSWPOqiGLEGwig9JVBjuj/lPZmkzkSgi3+SEd45TbX3eWxS5732JveVNm
	f3pAi5MhR7vm4yhPrpDh+yW3lMbLmaudvE/tHpkzV8bsE3wzs11ThBCsTvt2mzKMk73hiv
	Gr1IHrWfZfF2RCcpOoXDpJtR+xidNvzfKTiOU9kQ1SfDCNQ/WWlVpitF4ePoFeLhA20l2A
	ODPPGWywfAXSyjPTTjn7zpTpDXwK0RbI1ZoS6BIEWqWe2hzY8vZ9y5cM6KLHgQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703156070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5LxOp/EW/Vd1mXSk+y8EUFCpOxUF5Y2f3JGiVPDsGrQ=;
	b=y1ycMfMew5qTmuDsylW+B9rzMZ4sufF5TW7uKhol1vZ64qJURgf48ShcjmIKrK47WPBqN4
	GvyfHTecP9UL4SDw==
Date: Thu, 21 Dec 2023 11:54:29 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 19/20] wifi: rtl8xxxu: make supporting AP mode only on
 port 0 transparent
Content-Language: de-DE
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
 "kvalo@kernel.org" <kvalo@kernel.org>,
 "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
 "bigeasy@linutronix.de" <bigeasy@linutronix.de>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
 <20231218143645.433356-20-martin.kaistra@linutronix.de>
 <56eed6a3e237435f9d21082ca12eeaec@realtek.com>
 <797e4962-2ff3-4ae5-a1a7-d4d964fb768d@linutronix.de>
 <97e91ccfa2d8118b15166a9f2f25a56f84b460c8.camel@realtek.com>
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <97e91ccfa2d8118b15166a9f2f25a56f84b460c8.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 21.12.23 um 09:25 schrieb Ping-Ke Shih:
> On Wed, 2023-12-20 at 17:34 +0100, Martin Kaistra wrote:
>> External mail.
>>
>>
>>
>> Am 20.12.23 um 07:28 schrieb Ping-Ke Shih:
>>>
>>>> -----Original Message-----
>>>> From: Martin Kaistra <martin.kaistra@linutronix.de>
>>>> Sent: Monday, December 18, 2023 10:37 PM
>>>> To: linux-wireless@vger.kernel.org
>>>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
>>>> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebastian Andrzej Siewior
>>>> <bigeasy@linutronix.de>
>>>> Subject: [PATCH 19/20] wifi: rtl8xxxu: make supporting AP mode only on port 0 transparent
>>>>
>>>> +
>>>> +       vif = priv->vifs[0];
>>>> +       priv->vifs[0] = priv->vifs[1];
>>>> +       priv->vifs[1] = vif;
>>>> +       rtlvif = (struct rtl8xxxu_vif *)priv->vifs[1]->drv_priv;
>>>> +       rtlvif->port_num = 1;
>>>
>>> nit: Would it be better to swap port_num as well? Currently, port_num of vifs[0]
>>> will be set to 0 by caller, but not sure if further people could misuse this
>>> function.
>>
>> the main reason, I did not include setting port_num for priv->vifs[0], is that
>> priv->vifs[0] is a NULL pointer in the current way this function is called from
>> rtl8xxxu_add_interface().
>>
>> do you think it makes sense to add
>>
>> if (priv->vifs[0])
>>          rtlvif = (struct rtl8xxxu_vif *)priv->vifs[0]->drv_priv;
>>          rtlvif->port_num = 0;
>>
>> just for completeness sake, even though this code path will currently never get
>> executed?
>>
> 
> I missed that point. I just did focus on "switch", but actually this is
> "move" from port 0 to 1, right?

Yes, currently, the function is only used to move the STA mode interface from 0 
to 1 in order to make room for AP on 0.

I will leave this patch as is for v2. When the function is used in the future 
for a different scenario, the possibility of vifs[0] or vifs[1] being NULL needs 
to be thought through anyway and if necessary the setting of port_num = 0 can be 
added then as well.

> 
> As I know, two cases only work on port 0. One is AP mode that you are
> doing, and the other is PS in STA mode that isn't implemented by rtl8xxxxu.
> For AP mode, current implement moving port 0 to 1 is fine.
> 
> In the future, PS in STA mode could need to move port 1 to 0, because
> we may disconnect port 0 first and we want STA on port 1 entering PS.
> 
> But, I think we can defer this until we really need it.
> 
> 


