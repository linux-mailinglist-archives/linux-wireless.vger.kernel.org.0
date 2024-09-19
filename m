Return-Path: <linux-wireless+bounces-13015-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 496C797C7C5
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 12:08:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EA23C1F29C07
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 10:08:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8E36C198E74;
	Thu, 19 Sep 2024 10:08:13 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.126.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61CB198A3F
	for <linux-wireless@vger.kernel.org>; Thu, 19 Sep 2024 10:08:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.227.126.134
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726740493; cv=none; b=HN/qWRXJ+YFpV7WpCc7H0NwZ7wKKmX4firBbFCS3h2UPp12fDf27g7T5KeyegZu3ydNTOhX9HP8L4LrDhZT1HvawDiAC8sCh5XgPl9enJKbOJIgirlziCprrAiGMGAjcscyzewKaYdorCBL2nvjoV5Ark7bgsPiMYPejmvxbSik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726740493; c=relaxed/simple;
	bh=l7wYkU49uswLZV7lsndi01SaEtn3jd8ia7Tfrtu8tFc=;
	h=Message-ID:Date:MIME-Version:To:References:From:Subject:
	 In-Reply-To:Content-Type; b=mqELG04Ss5EQBUcZ29kVJWEsum5ASALklycT8zKQwXKy7vq/tGz+8NvTjBFh+fomj7yUgrw3Q4HBDzx6FI3lh3osrWyzgAHsYxUnmF7SZZrf4HXGmljjvhxZEf7uoYGrUHn2XugLfNID0kNAwi12lo3bovwGkYXNZl+7HlwGMrQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr; spf=pass smtp.mailfrom=green-communications.fr; arc=none smtp.client-ip=212.227.126.134
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=green-communications.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=green-communications.fr
Received: from [192.168.0.66] ([88.171.60.104]) by mrelayeu.kundenserver.de
 (mreue012 [213.165.67.103]) with ESMTPSA (Nemesis) id
 1N0Zfg-1s5hQA3H6q-00zaYL; Thu, 19 Sep 2024 12:02:54 +0200
Message-ID: <b9d5550c-8ac1-41d7-9abb-caa11f484064@green-communications.fr>
Date: Thu, 19 Sep 2024 12:02:54 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nicolas Escande <nescande@freebox.fr>, linux-wireless@vger.kernel.org
References: <D4A40Q44OAY2.W3SIF6UEPBUN@freebox.fr>
Content-Language: en-US
From: Nicolas Cavallari <Nicolas.Cavallari@green-communications.fr>
Autocrypt: addr=Nicolas.Cavallari@green-communications.fr; keydata=
 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
Subject: Re: Missing wiphy lock in ieee80211_color_collision_detection_work
In-Reply-To: <D4A40Q44OAY2.W3SIF6UEPBUN@freebox.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Provags-ID: V03:K1:m2NnxYiF75yy5gyvCeMqU94Cdt+2n2RDCedImGCO3Um0DCdr15/
 ydSaTmQsjWbQSZrMkzweOPo+wvI0BbYPaGFKBAUX+WjXh1xVDtijSfecjVbnBR5Y3enZUrW
 gcPl5PAn5kkjyewBudRRfHcLsnRv3P6FN6BRRo4r5q4SUvtE4UBH13dsyjZskFC1hsE7lOC
 SryFKY0n48SIM1tgmt1ZQ==
X-Spam-Flag: NO
UI-OutboundReport: notjunk:1;M01:P0:U/npkC346W4=;Fr+0cOs2UmnuqlzG++BR8dowHGR
 cOvHUG6LOfItUwwLXg7SSuqAxr6ntTS2VMIhbaWm7A6Ba1BMO+5GrzonBQ6/s7k0m7HQHE1M/
 7RMCnPngs40P6X5CswOMwRUsI6bl+QMf33jjfv48gRpov3MopP7VJDgk+b6SqCr0TE+eC6MDg
 mwlYkL8STMUnK1z52vYlIvNSr6gzxoB0VPsiPAZmiNkmV7dW/7ESl0dgSF+vY9ZGAP/cp/Jp+
 1RkzBLJBJBMu/2WvRzssWUy/lB4uD6ldOdW0qT+uy9tr9DxUcw6H8iptAUCpIYhLg8TrCV1cY
 LPV5TBU3NK80W6upbsOcb6Lllk+1MnNmcnf3g9tEcH9r9OhigJcqMosr60TZATMyhJ5VLseZq
 MkEzmmz3boPcnRprif2defIdMonakayWajYpvnA8H3EUqfh+2zv+AE6GGthr3jY6zKwCMcBaM
 KBhDGL1xP/MxIBoHpiWTxwZwDtlXqhroL9HS8tkEJ4/JeWXRFKU6DaXNvuSI2BDtezLAuOD14
 0w9LDnGIlXMPwyZ2FWDJDOTCKpMAZeb6ZqdNYJYZ8DBVGQBXubEfWDjJb2GTj10ts4OYURx/D
 pz6x2aibQrFxXmDtmea00MkA0aHI2iXJHeQMwdyFSsIU6qll3qbxDub4jF0EvqmMrXBWhulI5
 uhciwSqIIztjF04XdN8FrDvrMMSVd2L4wZnDOBY8r8ivtOlj+CUXnewYhgZv2TH46BWIuMdJb
 J27hbi61ScEmrGcCB5fjE8LZtbx4+2adQ==

On 19/09/2024 10:15, Nicolas Escande wrote:
> Hi guys,
> 
> Running a pretty hacked up kernel under lockdep, I've had a few splats like this
> 
> 	[   75.453180] Call trace:
> 	[   75.455595]  cfg80211_bss_color_notify+0x220/0x260
> 	[   75.460341]  ieee80211_color_collision_detection_work+0x4c/0x5c
> 	[   75.466205]  process_one_work+0x434/0x6ec
> 	[   75.470169]  worker_thread+0x9c/0x624
> 	[   75.473794]  kthread+0x1a4/0x1ac
> 	[   75.476987]  ret_from_fork+0x10/0x20
> 
> Which shows we are calling cfg80211_obss_color_collision_notify and thus
> cfg80211_bss_color_notify from ieee80211_color_collision_detection_work without
> holding the wiphy's mtx.
> 
> It seems that we should either explicitely lock the phy using something like
> 
> diff --git a/net/mac80211/cfg.c b/net/mac80211/cfg.c
> index 847304a3a29a..481e1550cb21 100644
> --- a/net/mac80211/cfg.c
> +++ b/net/mac80211/cfg.c
> @@ -4833,9 +4833,12 @@ void ieee80211_color_collision_detection_work(struct work_struct *work)
>   		container_of(delayed_work, struct ieee80211_link_data,
>   			     color_collision_detect_work);
>   	struct ieee80211_sub_if_data *sdata = link->sdata;
> +	struct ieee80211_local *local = sdata->local;
>   
> +	wiphy_lock(local->hw.wiphy);
>   	cfg80211_obss_color_collision_notify(sdata->dev, link->color_bitmap,
>   					     link->link_id);
> +	wiphy_unlock(local->hw.wiphy);
>   }
>   
>   void ieee80211_color_change_finish(struct ieee80211_vif *vif, u8 link_id)
> 
> Or switch to using the wiphy_work_queue infrastructure.
> 
> Did I miss something ? Which one should we do ? I'm not sure of all the
> implications of switching to the wiphy work queue and why it did not get
> converted like the color_change_finalize_work stuff ?

ieee80211_color_collision_detection_work() used to lock the wdev mutex, now it 
does not hold anything since 076fc8775da("wifi: cfg80211: remove wdev mutex")

Also the rate limiting uses delayed_work_pending(), There is no wiphy work queue 
equivalent AFAIK, so the explicit lock is probably the way to go.

