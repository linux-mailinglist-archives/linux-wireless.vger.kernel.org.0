Return-Path: <linux-wireless+bounces-1108-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 60D3481A572
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 17:40:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7C5E81C20ADF
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Dec 2023 16:40:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 501EC41763;
	Wed, 20 Dec 2023 16:40:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="h3U9G0ON";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="2HkWUnEh"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD9F441854
	for <linux-wireless@vger.kernel.org>; Wed, 20 Dec 2023 16:40:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <d78d5a4c-45bf-4938-b5af-96b0ff4e9bfd@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703090427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u92ZxIQJkDos8cFnZ2sX33Ct3mdYCPlQyuWQAoBHKCc=;
	b=h3U9G0ONbnYyJscwA+cKW53llyoexFBaawaL0cVSkSSCODvVgF8UozQLEOEtquVhuKSFLi
	RYHC1w6NxJbC43t/LzYUrwwJ9b+TxdEo2dvzx99e9WpChkOvAkQy2bkN9bV5k1kHKGVOeW
	g09+xaKp1IAPNK+8DjVX+FRmcdfZxeKFIp3BPYNIBTW9si0BX1868VKR9lApr3pUh5Lfdd
	Yrv2VVG9HqjgVnn4WgkWJjg/HbPaM1L2I2VQxjOGj9IGe9YQ4QL/mYSoEDoIF8jjbBqZVC
	MoEJaZE8dXr+W2Z4phQ4TRqkm61Mrk2HgvjaPt2U502BrvIt1hR7Z9K5+PEQ/A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703090427;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u92ZxIQJkDos8cFnZ2sX33Ct3mdYCPlQyuWQAoBHKCc=;
	b=2HkWUnEh62W/IUPTLTz2UxLvysVOjuTVCfHOsi7KkkdI8ugLA89gepcQxf8QHzcNfKrHvj
	Nr4iLe4fFJx63NAg==
Date: Wed, 20 Dec 2023 17:40:27 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 16/20] wifi: rtl8xxxu: support multiple interfaces in
 get_macid()
Content-Language: de-DE
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
 <20231218143645.433356-17-martin.kaistra@linutronix.de>
 <3514e2620c734baaab8dbd8e34aaa5c5@realtek.com>
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <3514e2620c734baaab8dbd8e34aaa5c5@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 20.12.23 um 07:14 schrieb Ping-Ke Shih:
> 
> 
>> -----Original Message-----
>> From: Martin Kaistra <martin.kaistra@linutronix.de>
>> Sent: Monday, December 18, 2023 10:37 PM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
>> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de>
>> Subject: [PATCH 16/20] wifi: rtl8xxxu: support multiple interfaces in get_macid()
>>
>> As sta_info->macid does not get set in station mode, we can simplify
>> this function by directly returning 0 if sta itself or sta_info is not
>> set.
>>
>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
>> ---
>>   drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 5 ++++-
>>   1 file changed, 4 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index 3851fc90339e0..ad76cddef81b2 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> @@ -4053,10 +4053,13 @@ static inline u8 rtl8xxxu_get_macid(struct rtl8xxxu_priv *priv,
>>   {
>>          struct rtl8xxxu_sta_info *sta_info;
>>
>> -       if (!priv->vif || priv->vif->type == NL80211_IFTYPE_STATION || !sta)
>> +       if (!sta)
>>                  return 0;
>>
>>          sta_info = (struct rtl8xxxu_sta_info *)sta->drv_priv;
>> +       if (!sta_info)
>> +               return 0;
>> +
>>          return sta_info->macid;
> 
> I checked where driver assign macid, and only
> 
> 	if (vif->type == NL80211_IFTYPE_AP) {
> 		sta_info->macid = rtl8xxxu_acquire_macid(priv);
> 
> That means STA mode can be macid == 0 always, right?
> This will be a problem. At least TX rate will be incorrect.

Yes, currently macid for STA mode is always 0. Would it be enough to set macid 
in STA mode to either 0 or 1 depending on port_num?

> 
> Ping-Ke
> 


