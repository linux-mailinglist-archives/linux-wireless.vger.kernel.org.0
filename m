Return-Path: <linux-wireless+bounces-1106-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37A2881A53A
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 17:34:40 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B58E11F24B38
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 16:34:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2AADF3E477;
	Wed, 20 Dec 2023 16:34:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="c0MQywCI";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ksfdwTXA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 812562BB0C
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 16:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <797e4962-2ff3-4ae5-a1a7-d4d964fb768d@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703090070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8vI3SMn+F4CvpUEkd9qs/NQGLMpxsSEtKPBCudnJFao=;
	b=c0MQywCIfZRB9c3QLsyiOKvRVFxTX6Sa14IvkXURLgC3ghePSzb34TaZ90LWu/LnkuB7kW
	uJmRclWOILd33LWaH6PLQYFKGnp7MnSHkf4fM6ttgUOFk1c1PvAXCwCdalG2TJ5gEmxb1M
	hXUFwl/eap8j4+yWMBazxjCgy+J0TW8qojXLkuifpGJnqyomyA2gZH/0IP/dRc3y3Zb6V3
	pvWKojxyLTb9PGrtWrJY+D7GJWW5gbEnItBZ822b07Gcyw5yoQRsuoouylNdNBLrIGOsGD
	/mHIZ8849nqFtdw0w53f86KYHJDPboX3y6uKmb43vaj3muTFJVcka65M0mVShA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703090070;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=8vI3SMn+F4CvpUEkd9qs/NQGLMpxsSEtKPBCudnJFao=;
	b=ksfdwTXADXfao5Xws+9C5cV7KiwVxGfKHT0yB7qtduUH9oNPuhsVKgplvuhfY0rA5eydVw
	xEhVh/sIK6Sag7Bw==
Date: Wed, 20 Dec 2023 17:34:29 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 19/20] wifi: rtl8xxxu: make supporting AP mode only on
 port 0 transparent
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
 <20231218143645.433356-20-martin.kaistra@linutronix.de>
 <56eed6a3e237435f9d21082ca12eeaec@realtek.com>
Content-Language: de-DE
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <56eed6a3e237435f9d21082ca12eeaec@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 20.12.23 um 07:28 schrieb Ping-Ke Shih:
> 
> 
>> -----Original Message-----
>> From: Martin Kaistra <martin.kaistra@linutronix.de>
>> Sent: Monday, December 18, 2023 10:37 PM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
>> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de>
>> Subject: [PATCH 19/20] wifi: rtl8xxxu: make supporting AP mode only on port 0 transparent
>>
>> When the driver is used for concurrent mode, both virtual interfaces can
>> be set to station or AP mode, though only one can be in AP mode at the
>> same time.
>>
>> In order to keep the code simple, use only hw port 0 for AP mode. When
>> an interface is added in AP mode which would be assigned to port 1, use
>> a switch_port function to transparently swap the mapping between virtual
>> interface and hw port.
>>
>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
>> ---
>>   .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 84 ++++++++++++++++++-
>>   1 file changed, 82 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index 88730791091a7..595f447874f4d 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -6613,6 +6613,84 @@ static int rtl8xxxu_submit_int_urb(struct ieee80211_hw *hw)
>>          return ret;
>>   }
>>
>> +static void rtl8xxxu_switch_ports(struct rtl8xxxu_priv *priv)
>> +{
> 
> [...]
> 
>> +
>> +       vif = priv->vifs[0];
>> +       priv->vifs[0] = priv->vifs[1];
>> +       priv->vifs[1] = vif;
>> +       rtlvif = (struct rtl8xxxu_vif *)priv->vifs[1]->drv_priv;
>> +       rtlvif->port_num = 1;
> 
> nit: Would it be better to swap port_num as well? Currently, port_num of vifs[0]
> will be set to 0 by caller, but not sure if further people could misuse this
> function.

the main reason, I did not include setting port_num for priv->vifs[0], is that 
priv->vifs[0] is a NULL pointer in the current way this function is called from 
rtl8xxxu_add_interface().

do you think it makes sense to add

if (priv->vifs[0])
        rtlvif = (struct rtl8xxxu_vif *)priv->vifs[0]->drv_priv;
        rtlvif->port_num = 0;

just for completeness sake, even though this code path will currently never get 
executed?

> 
> 
>> +}
>> +
>>   static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
>>                                    struct ieee80211_vif *vif)
>>   {
>> @@ -6640,8 +6718,10 @@ static int rtl8xxxu_add_interface(struct ieee80211_hw *hw,
>>                  }
>>                  break;
>>          case NL80211_IFTYPE_AP:
>> -               if (port_num == 1)
>> -                       return -EOPNOTSUPP;
>> +               if (port_num == 1) {
>> +                       rtl8xxxu_switch_ports(priv);
>> +                       port_num = 0;
>> +               }
>>
>>                  rtl8xxxu_write8(priv, REG_BEACON_CTRL,
>>                                  BEACON_DISABLE_TSF_UPDATE | BEACON_CTRL_MBSSID);
>> --
>> 2.39.2
> 


