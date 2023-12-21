Return-Path: <linux-wireless+bounces-1138-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F43E81B03E
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 09:24:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 992AAB226E0
	for <lists+linux-wireless@lfdr.de>; Thu, 21 Dec 2023 08:24:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B7F016420;
	Thu, 21 Dec 2023 08:24:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="NBSzFjnA";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="7o2IdVWi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FADD16401
	for <linux-wireless@vger.kernel.org>; Thu, 21 Dec 2023 08:24:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <6cd6ff5b-3308-444b-bc68-62b85cfabd4b@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703147051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CiFBnrL6KnGT6743ssQHaFK9cmfzOm3UwNDaHRlRR+E=;
	b=NBSzFjnAu+xtDvr/ja+WivFKHVX1S2ax/Dt4z01MYAiJXzZZcb0TZl8Ub6EfeozfneYosG
	aF+GkMVFGJ/2KvqaXVsA/lYQGbbZFGYKFaykaG0tsO42oe2o6OGtNJMmGofLdAyXt7LLPH
	LnqmRU6h0Fbgve1NagCIlY8qLEUypSsv1ud9bcykeGozEvd2hkY39E7g2L67m1Xe9j9DsS
	ssY/LB+yvl1Waz9DqgkgQdaLCuPqt4mO5eJriByaYIcKRvEiiVyEIjZ/k1r/rJ+MgKD75v
	dnlQudFBAfBYAOPSDqqOPVkKGR/WK+SYlGCX+XAAFuaHR+fgDIJDqWZH2tUCmA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703147051;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CiFBnrL6KnGT6743ssQHaFK9cmfzOm3UwNDaHRlRR+E=;
	b=7o2IdVWilLVRdedgwHsvHgAjY4I65tMY6NPaZvfzXNalmobbuITC6pwckgDRXGUIMDs3v0
	X0E2yYo9p8kWlrBA==
Date: Thu, 21 Dec 2023 09:24:11 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH 14/20] wifi: rtl8xxxu: support multiple interfaces in
 bss_info_changed()
Content-Language: de-DE
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
 Bitterblue Smith <rtl8821cerfe2@gmail.com>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>
References: <20231218143645.433356-1-martin.kaistra@linutronix.de>
 <20231218143645.433356-15-martin.kaistra@linutronix.de>
 <32b2f2efe2834578809303c9960fba6d@realtek.com>
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <32b2f2efe2834578809303c9960fba6d@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

Am 20.12.23 um 07:09 schrieb Ping-Ke Shih:
> 
> 
>> -----Original Message-----
>> From: Martin Kaistra <martin.kaistra@linutronix.de>
>> Sent: Monday, December 18, 2023 10:37 PM
>> To: linux-wireless@vger.kernel.org
>> Cc: Jes Sorensen <Jes.Sorensen@gmail.com>; Kalle Valo <kvalo@kernel.org>; Ping-Ke Shih
>> <pkshih@realtek.com>; Bitterblue Smith <rtl8821cerfe2@gmail.com>; Sebastian Andrzej Siewior
>> <bigeasy@linutronix.de>
>> Subject: [PATCH 14/20] wifi: rtl8xxxu: support multiple interfaces in bss_info_changed()
>>
>> Call set_linktype now with correct port_num. Only react to beacon
>> changes if port_num == 0, as we only support AP mode on this port.
>>
>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
>> ---
>>   .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 26 +++++++++++--------
>>   1 file changed, 15 insertions(+), 11 deletions(-)
>>
>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> index 59dd50844f1ae..f929b01615d00 100644
>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
> 
> [...]
> 
>> @@ -5090,16 +5092,18 @@ rtl8xxxu_bss_info_changed(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
>>                  rtl8xxxu_set_basic_rates(priv, bss_conf->basic_rates);
>>          }
>>
>> -       if (changed & BSS_CHANGED_BEACON_ENABLED) {
>> -               if (bss_conf->enable_beacon)
>> -                       rtl8xxxu_start_tx_beacon(priv);
>> -               else
>> -                       rtl8xxxu_stop_tx_beacon(priv);
>> +       /* beacon only supported for port_num = 0 */
>> +       if (rtlvif->port_num == 0) {
> 
> As your design, AP mode must play on port 0. Could mac80211 notify driver BEACON
> changed on port 1?

Looking at mac80211 code, there is an explicit check for vif.type when changed 
contains BSS_CHANGED_BEACON or BSS_CHANGED_BEACON_ENABLED. As rtl8xxxu driver 
only allows to add NL80211_IFTYPE_AP on port_num = 0, a notification on port 1 
will never happen. I will remove this check for v2.


> 
>> +               if (changed & BSS_CHANGED_BEACON_ENABLED) {
>> +                       if (bss_conf->enable_beacon)
>> +                               rtl8xxxu_start_tx_beacon(priv);
>> +                       else
>> +                               rtl8xxxu_stop_tx_beacon(priv);
>> +               }
>> +               if (changed & BSS_CHANGED_BEACON)
>> +                       schedule_work(&priv->update_beacon_work);
>>          }
>>
>> -       if (changed & BSS_CHANGED_BEACON)
>> -               schedule_work(&priv->update_beacon_work);
>> -
>>   error:
>>          return;
>>   }
> 
> Ping-Ke
> 

