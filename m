Return-Path: <linux-wireless+bounces-1215-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 51A9781C72C
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 10:11:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0E9DB285E04
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Dec 2023 09:11:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9708A12E67;
	Fri, 22 Dec 2023 09:10:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="qnCY4+X+";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="cIxk8O6S"
X-Original-To: linux-wireless@vger.kernel.org
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57F2FBE5
	for <linux-wireless@vger.kernel.org>; Fri, 22 Dec 2023 09:10:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Message-ID: <1bf08ae7-84bf-432f-93e9-c97c6deca5ba@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1703236255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hd2ZYVGdfr13ahW2IUaUJETFtl5bBuQoXV7zAiwLDx8=;
	b=qnCY4+X+bF0dWNtMlr6gqLPpFshGDVdqeZaMmVbjH2iIuPKS6PV0YpWVDTJDuiD9fCVQtJ
	2KKB3qFI+hbSwnOwQVbdap18OOjMGvYePCB0JZya92k4FpoGCvCOutqKJq24a2j/TbIlFh
	e2YTqIYvin/Y0pPx2k2c7TAYUW87ixQWafMMApwZNlYyi20o8QA+C2wX7fyqrNQfSWhuxW
	vzkmQs+Pq+fIuZ+rgV4yd85xCU8+7a6liGmuPFuox99Cnrq8HeHj+jqgKUF1R7SFFgdICW
	dRDXvYDsU6aThQYcjutxmswjqdiGmfrk8QA4rE4aLu+2sPjOKpIQXZWRRCiuZg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1703236255;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=hd2ZYVGdfr13ahW2IUaUJETFtl5bBuQoXV7zAiwLDx8=;
	b=cIxk8O6SVoFE3cZztImwqVAQMdhynLabs67zknnGbKx1hJcF6vCLpxKDcWXntb+TTFK3E/
	4/7oBoGp31uNB/BA==
Date: Fri, 22 Dec 2023 10:10:54 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Subject: Re: [PATCH v2 13/21] wifi: rtl8xxxu: support multiple interfaces in
 watchdog_callback()
Content-Language: de-DE
To: Ping-Ke Shih <pkshih@realtek.com>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Cc: "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
 "kvalo@kernel.org" <kvalo@kernel.org>,
 "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
 "bigeasy@linutronix.de" <bigeasy@linutronix.de>
References: <20231221164353.603258-1-martin.kaistra@linutronix.de>
 <20231221164353.603258-14-martin.kaistra@linutronix.de>
 <CAKFoaw3o-LkqADNvfE0TXmvr8_LK19mpVQtUZ66CWS=AN5AkJQ@mail.gmail.com>
 <f71b29e17ff14ee9b28dd514a94cf1be@realtek.com>
 <b8764bec-4dc6-4779-a3c3-d22e7d5acce9@linutronix.de>
 <f3949264-c530-43e1-a528-eedcc2b31d0d@linutronix.de>
 <bbe5babe03b7b23c988af9ce8777df0d5302592b.camel@realtek.com>
From: Martin Kaistra <martin.kaistra@linutronix.de>
In-Reply-To: <bbe5babe03b7b23c988af9ce8777df0d5302592b.camel@realtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Am 22.12.23 um 09:59 schrieb Ping-Ke Shih:
> On Fri, 2023-12-22 at 09:25 +0100, Martin Kaistra wrote:
>>
>> Am 22.12.23 um 09:05 schrieb Martin Kaistra:
>>> Am 22.12.23 um 02:45 schrieb Ping-Ke Shih:
>>>> On Fri, Dec 22, 2023 at 12:45 AM Martin Kaistra
>>>> <martin.kaistra@linutronix.de> wrote:
>>>>> Check first whether priv->vifs[0] exists and is of type STATION, then go
>>>>> to priv->vifs[1]. Make sure to call refresh_rate_mask for both
>>>>> interfaces.
>>>>>
>>>>> Signed-off-by: Martin Kaistra <martin.kaistra@linutronix.de>
>>>>> ---
>>>>>    .../wireless/realtek/rtl8xxxu/rtl8xxxu_core.c | 19 +++++++++++--------
>>>>>    1 file changed, 11 insertions(+), 8 deletions(-)
>>>>>
>>>>> diff --git a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>>>>> b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>>>>> index c5b71892369c9..fd0108668bcda 100644
>>>>> --- a/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>>>>> +++ b/drivers/net/wireless/realtek/rtl8xxxu/rtl8xxxu_core.c
>>>>> @@ -7200,11 +7200,15 @@ static void rtl8xxxu_watchdog_callback(struct
>>>>> work_struct *work)
>>>>>    {
>>>>>           struct ieee80211_vif *vif;
>>>>>           struct rtl8xxxu_priv *priv;
>>>>> +       int i;
>>>>>
>>>>>           priv = container_of(work, struct rtl8xxxu_priv, ra_watchdog.work);
>>>>> -       vif = priv->vif;
>>>>> +       for (i = 0; i < ARRAY_SIZE(priv->vifs); i++) {
>>>>> +               vif = priv->vifs[i];
>>>>> +
>>>>> +               if (!vif || vif->type != NL80211_IFTYPE_STATION)
>>>>> +                       continue;
>>>>
>>>> Currently, this loop becomes to get RSSI and update rate mask, but only for
>>>> station mode. That means we don't update them for peer stations in AP mode.
>>>> Maybe, we need ieee80211_iterate_stations_atomic() for all stations, but
>>>> ieee80211_ave_rssi() is only for 'vif', so we need to add a driver level
>>>> RSSI for all stations (macid). Also, we need to extend priv->rssi_level for
>>>> all macid as well.
>>>>
>>>> I suppose _default_ value can work to stations in AP mode, so you can decide
>>>> if you will defer this support temporarily.
>>>>
>>>> (Sorry, I don't dig rtl8xxxu very deeply, so I'm not able to tell you all
>>>> things in one go.)
>>>
>>> It probably makes sense to fix this, however if it's ok for you, I would like to
>>> do it separatly from this series.
> 
> Ok to me. :-)
> 
>>>
>>>
>>>>> -       if (vif && vif->type == NL80211_IFTYPE_STATION) {
>>>>>                   int signal;
>>>>>                   struct ieee80211_sta *sta;
>>>>>
>>>>> @@ -7215,22 +7219,21 @@ static void rtl8xxxu_watchdog_callback(struct
>>>>> work_struct *work)
>>>>>
>>>>>                           dev_dbg(dev, "%s: no sta found\n", __func__);
>>>>>                           rcu_read_unlock();
>>>>> -                       goto out;
>>>>> +                       continue;
>>>>>                   }
>>>>>                   rcu_read_unlock();
>>>>>
>>>>>                   signal = ieee80211_ave_rssi(vif);
>>>>>
>>>>> -               priv->fops->report_rssi(priv, 0,
>>>>> +               priv->fops->report_rssi(priv, rtl8xxxu_get_macid(priv, sta),
>>>>>                                           rtl8xxxu_signal_to_snr(signal));
>>>>>
>>>>> -               if (priv->fops->set_crystal_cap)
>>>>> -                       rtl8xxxu_track_cfo(priv);
>>>>> -
>>>>>                   rtl8xxxu_refresh_rate_mask(priv, signal, sta, false);
>>>>
>>>> It seems like 'sta' isn't protected by RCU read lock.
>>>> (an existing bug, not introduced by this patch)
>>>
>>> I will add a patch which moves the rcu_read_unlock() to fix this.
>>
>> Actually, looking at the code again, rtl8xxxu_refresh_rate_mask() seems to
>> already contain calls to rcu_read_lock(). Just the call to
>> rtl8xxxu_get_macid(priv, sta) in there might need additional protection.
>>
> 
> 
> We must use RCU lock to protect 'sta' from dereference to whole access, but
> it looks like
> 
> rtl8xxxu_watchdog_callback()
> 
> 	rcu_read_lock();
> 	sta = ...
> 	rcu_read_unlock() // after this point, use 'sta' is unsafe..
> 
> 	rtl8xxxu_refresh_rate_mask(sta)
> 		rcu_read_lock();
> 		rate_bitmap = sta->...
> 		rcu_read_unlock();
> 
> 
If it is not an easy fix, does it make sense to you to do this also separately 
from this series?

