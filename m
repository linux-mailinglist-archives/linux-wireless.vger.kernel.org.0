Return-Path: <linux-wireless+bounces-7903-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5FFCE8CB0BD
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 16:50:42 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 021111F244FA
	for <lists+linux-wireless@lfdr.de>; Tue, 21 May 2024 14:50:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E9DE27EEED;
	Tue, 21 May 2024 14:50:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=unstable.cc header.i=a@unstable.cc header.b="g1r8ZGJC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from wilbur.contactoffice.com (wilbur.contactoffice.com [212.3.242.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9BB831E87C;
	Tue, 21 May 2024 14:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.3.242.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716303036; cv=none; b=a/CZXYCqsJBfD0FgqGibQzskUx5XH1HiBkOT4cUOn6qAVlhYHz9w7kVOVGEzYjtbzfRgxicyvodCgVPHkMGldI67cs++AY3BUs62BQelCJWlLmlvYps4azWYHXO9MsnEmwHLeeXl6+/ZR7ZXrw5zEklHp+ivuVwh9l93EJguyr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716303036; c=relaxed/simple;
	bh=m5joeQgS5ScfS+qukuUUac9hQNUzKQ5pTLsn+sKIlt4=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=aKTbxAIU0LD3qqByBpGfEYi1ywAtd70Hylo+MVAjbSDa7PYPdZJSmxWpDqqy+YEVmU07vPuXVyIePwrZOnv/wVwfrLpgXVKKRLL7OBDXFHmkrheP/t6EPWTydPziM5JOPRz91TkivlBuA/zbBi9jXWYG/EOBX9rV9TjCzBtcvnU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unstable.cc; spf=pass smtp.mailfrom=unstable.cc; dkim=pass (2048-bit key) header.d=unstable.cc header.i=a@unstable.cc header.b=g1r8ZGJC; arc=none smtp.client-ip=212.3.242.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=unstable.cc
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=unstable.cc
Received: from smtpauth2.co-bxl (smtpauth2.co-bxl [10.2.0.24])
	by wilbur.contactoffice.com (Postfix) with ESMTP id 085FC8BB;
	Tue, 21 May 2024 16:50:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1716303029;
	s=20220809-q8oc; d=unstable.cc; i=a@unstable.cc;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:In-Reply-To:Content-Type:Content-Transfer-Encoding;
	l=2420; bh=MTWDyIfN1nMlCSjPE8NjqxUc6JP4iiU+F5dmQzZPITE=;
	b=g1r8ZGJCvPKEJVDzNsmbjEr/8t9llqk4+N4hhyd59SoskJ/tnKd4gw9bnZX1W6hg
	cPhrz8+vGFbnC35LOKEaLPQKAWyhQgt7BfFJXtR0KmBaq7gQKcGwni4OWTnc58Apppv
	IbRZkeccQZZNu3+5fcK2mC6sInP0giNjk3KIv03+uwMRRzzZg4lhbFezthDktl4QDXo
	abDSwkVIRsKI0HcfHKtVobpCTvf6QgXBJzR4/XatSr93KNA7NvZduB9/mBvhaN5ps0x
	Deod4iTikmSVuIUxgWdW1A5lTTJxiW9fL6HfHUibzLyWMfGEDJhhORiZRm1LRGW2QgG
	/aLeLJILNQ==
Received: by smtp.mailfence.com with ESMTPSA ; Tue, 21 May 2024 16:50:26 +0200 (CEST)
Message-ID: <e9a67bc5-4abe-4a91-b2ca-26e64e2abac3@unstable.cc>
Date: Tue, 21 May 2024 16:51:52 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: cfg80211: Lock wiphy in cfg80211_get_station
To: Remi Pommarel <repk@triplefau.lt>,
 Johannes Berg <johannes@sipsolutions.net>
Cc: linux-wireless@vger.kernel.org, b.a.t.m.a.n@lists.open-mesh.org,
 linux-kernel@vger.kernel.org
References: <983b24a6a176e0800c01aedcd74480d9b551cb13.1716046653.git.repk@triplefau.lt>
 <cef03d6c-7be8-4527-b38b-eadca2789f9b@unstable.cc> <ZkyQfL6JjJBTHtwN@pilgrim>
Content-Language: en-US
From: Antonio Quartulli <a@unstable.cc>
In-Reply-To: <ZkyQfL6JjJBTHtwN@pilgrim>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Flag: NO
X-ContactOffice-Account: com:375058688

Hi,

On 21/05/2024 14:15, Remi Pommarel wrote:
> On Tue, May 21, 2024 at 09:43:56AM +0200, Antonio Quartulli wrote:
>> Hi,
>>
>> On 18/05/2024 17:50, Remi Pommarel wrote:
>>> Wiphy should be locked before calling rdev_get_station() (see lockdep
>>> assert in ieee80211_get_station()).
>>
>> Adding the lock is fine as nowadays it is taken in pre_doit and released in
>> post_doit (with some exceptions). Therefore when invoking .get_station from
>> a side path the lock should be taken too.
>>
>> It was actually a05829a7222e9d10c416dd2dbbf3929fe6646b89 that introduced
>> this requirement AFAICS.
> 
> IIUC lock requirement was already there before this commit, only it was on
> rtnl lock to be taken instead of wiphy one.

You're right.

> 
>>
>>>
>>> This fixes the following kernel NULL dereference:
>>
>> As already said by Johannes, I am not sure it truly fixes this NULL
>> dereference though.
>>
>> Have you checked where in ath10k_sta_statistics this is exactly happening?
>> Do you think some sta was partly released and thus fields were NULLified?
> 
> ath10k_sta_statistics+0x10 is associated with the arsta->arvif->ar
> statement. It crashes because arsta->arvif is NULL.
> 
> Here is a scenario that explains the crash where the same sta
> disconnects then reconnects quickly (e.g. OPEN network):
> 
> 
> CPU0:                                       CPU1:
> 
> batadv_v_elp_periodic_work()
>   queue_work(batadv_v_elp_get_throughput)
> 
>                                              ieee80211_del_station()
>                                              ieee80211_add_station()
>                                               sta_info_insert()
>                                                list_add_tail_rcu()
>                                                ath10k_sta_state()
>                                                 memset(arsta, 0, sizeof(arsta))
> batadv_v_elp_get_throughput()
>   cfg80211_get_station()
>    ieee80211_get_station() <-- Find sta with its MAC in list
>     ath10k_sta_statistics()
>      arsta->arvif->ar <-- arsta is still zeroed
> 
> 
> In other words if the same sta has enough time to disconnect then
> reconnect before batadv_v_elp_get_throughput get scheduled, sta could be
> partially initialized when ath10k_sta_statistics() is called. Locking
> the wiphy ensure sta is fully initialized if found.
> 

We were just wondering how you could get the arvif being NULL and your 
explanation makes sense.

This said, holding the lock is required when invoking get_station via 
netlink, therefore it's meaningful to hold it even when side invoking it 
from another module.

Acked-by: Antonio Quartulli <a@unstable.cc>


-- 
Antonio Quartulli

