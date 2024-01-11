Return-Path: <linux-wireless+bounces-1703-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DB43982AAD0
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 10:23:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 734ED282827
	for <lists+linux-wireless@lfdr.de>; Thu, 11 Jan 2024 09:23:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B765112E4B;
	Thu, 11 Jan 2024 09:23:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="e1Rk4M+P";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WITZKnaM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1905912E47
	for <linux-wireless@vger.kernel.org>; Thu, 11 Jan 2024 09:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <a89202a3-0dc8-4206-82eb-eddb8b59e729@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1704965011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+3pe2xjf0v67zJLczdI2/SCnnxVdkH2AKbVv4woPaI=;
	b=e1Rk4M+PEOB5ic03awNYyDlSx+nP7UbvzR2JaX82bBrudMDikzp7uvpcDp99Y5xKf+zOzM
	lQUOa/gcgIgC3c9/yl2ZOI9VWrky35VQyb+tJS/D1dB9prmWcZDt9NUEKKArgt9VHrd1Ud
	svW7NSUNvwFNaKnVB5tmcMdmvjXAFtoZAr3DhrfJ0BNaSyiMxdQtI+dstxLDSUwdnIZUgt
	tWmqn0mCxxImJGMY2KToFqe85c4KQ+s1TL7COYbr7b2P00KlrFPuzHL+0QsnYlDloPFJ4M
	meoEMSB++Ze0adrqG8hkRyyCU9vamivVbRFn2+GHx19wdK1cjIWhkleQ/AeaCQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1704965011;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l+3pe2xjf0v67zJLczdI2/SCnnxVdkH2AKbVv4woPaI=;
	b=WITZKnaMwsvb8ipQeZtCfOLzkL+Ss/lBkLoDZQn4sPW5GWonxaqsWR4Kgv6iVubt+BAE2E
	YEtBuxvCaT4zIhCw==
Date: Thu, 11 Jan 2024 10:23:31 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2] wifi: rtl8xxxu: enable channel switch support
Content-Language: de-DE
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20240110103909.240514-1-martin.kaistra@linutronix.de>
 <cf31e4c5e1a04230891e5bbbff5d24ff@realtek.com>
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <cf31e4c5e1a04230891e5bbbff5d24ff@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 11.01.24 um 02:21 schrieb Ping-Ke Shih:
> 
> 
>> -----Original Message-----
>> From: Martin Kaistra <martin.kaistra@linutronix.de>
>> Sent: Wednesday, January 10, 2024 6:39 PM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
>> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de>
>> Subject: [PATCH v2] wifi: rtl8xxxu: enable channel switch support
>>
>> The CSA countdown in the beacon frames, which are sent out by firmware,
>> needs to get updated by the driver. To achieve this, convert
>> update_beacon_work to delayed_work and schedule it with the beacon
>> interval in case CSA is active and the countdown is not complete.
>>
>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
>> ---
>> changes v1->v2: use delayed_work instead of usleep_range
>> v1: https://lore.kernel.org/linux-wireless/20240108111103.121378-1-martin.kaistra@linutronix.de/
>>   .../net/wireless/realtek/rtl8xxxu/rtl8xxxu.h   |  2 +-
>>   .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c  | 18 ++++++++++++++----
>>   2 files changed, 15 insertions(+), 5 deletions(-)
>>
> 
> [...]
> 
>> @@ -7764,7 +7772,7 @@ static int rtl8xxxu_probe(struct usb_interface *interface,
>>          spin_lock_init(&priv->rx_urb_lock);
>>          INIT_WORK(&priv->rx_urb_wq, rtl8xxxu_rx_urb_work);
>>          INIT_DELAYED_WORK(&priv->ra_watchdog, rtl8xxxu_watchdog_callback);
>> -       INIT_WORK(&priv->update_beacon_work, rtl8xxxu_update_beacon_work_callback);
>> +       INIT_DELAYED_WORK(&priv->update_beacon_work, rtl8xxxu_update_beacon_work_callback);
> 
> It seems like we missed cancel priv->update_beacon_work work at rtl8xxxu_stop().
> Because that isn't introduced by this patch, you can decide to do it in this
> patch or not. Also, 'struct work_struct c2hcmd_work;' has similar problem.

Makes sense to me, I will add cancel_delayed_work_sync() for a v3 of this patch. 
Should I send a second patch for cancelling c2hcmd_work?


> 
> This could be a problem theoretically, but not easy to see the problem though.
> 
> 
>>          skb_queue_head_init(&priv->c2hcmd_queue);
>>
>>          usb_set_intfdata(interface, hw);
> 
> [...]
> 



