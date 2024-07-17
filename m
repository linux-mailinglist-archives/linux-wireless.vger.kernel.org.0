Return-Path: <linux-wireless+bounces-10305-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 787D6933F93
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 17:26:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F07541F23D2B
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Jul 2024 15:26:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CEF74ED8;
	Wed, 17 Jul 2024 15:26:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="cs77jfze"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEE59381DE
	for <linux-wireless@vger.kernel.org>; Wed, 17 Jul 2024 15:26:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721229970; cv=none; b=nvovwRJwpXRt9D5UbhN4jK2R5O0Ob7b0e9xHk7EqosRiI81mCnV/2SJ7cSeFEzKnx7lACobDj3XFRPR4cT5/6dkoAxpXZUh1S6ayODk/raAYDd1RNDf4O3I5TpgyJHvvzirtW81S/OdlyRwhhYKqaZN1QJV50EW0/pzONloidnk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721229970; c=relaxed/simple;
	bh=Srow5iOXnytNxwJPJdJDSlGqm1Wl6m3U9fZgFZYmAuc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DseveoTK+8eGVJACkKAbQDHjS7THCoTsU7N9A9KwAO7IlymeRxu4tS4hPwQt0PX11gxmloeTe6kkkxtnyy77BpsjtlEhwBimwFPhO1sG06mr2fd7KjPymbiPTbyfyR8zDXf6CTJ4h3qkh2pn/LXFnUW38c3XgT6Rli5IVm13Fa8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=cs77jfze; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=FiOun6x1iC6l5j5+Ox2pwXNVZiuOFB7a72cfTkX8a5Y=; b=cs77jfzeKQeE67N1rpmd6/mdmv
	aBB5m41sPKD+zStEoOLRBwJBf4yywUZ9Y0wuBKu/ZvxVlPO5TTgITZDnJLZVK94itqmupsKfBbYvj
	ctGYc8oc1U5ou/M77PHFUsmp8bZQRNxQwlZUXtg4gwr8wSLpiLsC7cJKEO/iHR8bKMec=;
Received: from p4ff1339c.dip0.t-ipconnect.de ([79.241.51.156] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sU6XS-0087IF-26;
	Wed, 17 Jul 2024 17:25:54 +0200
Message-ID: <2599b886-9c63-4989-a08a-7feab28f7c49@nbd.name>
Date: Wed, 17 Jul 2024 17:25:54 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: patch 46/47 causes NULL pointer deref on mt7921
To: Bert Karwatzki <spasswolf@web.de>, Sean Wang <sean.wang@kernel.org>
Cc: deren.wu@mediatek.com, linux-mediatek@lists.infradead.org,
 linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
 mingyen.hsieh@mediatek.com, sean.wang@mediatek.com
References: <20240711175156.4465-1-spasswolf@web.de>
 <CAGp9LzoXMoAW6dVZjTf-JcD_wiU4yXpGwkLaVyWXTkaV2MOKwg@mail.gmail.com>
 <adb192a59c44aa8708e80df30a6a47816a03e50f.camel@web.de>
 <4e943a62736f955af5d9cd1aff7e2b9c084c8885.camel@web.de>
From: Felix Fietkau <nbd@nbd.name>
Content-Language: en-US
Autocrypt: addr=nbd@nbd.name; keydata=
 xsDiBEah5CcRBADIY7pu4LIv3jBlyQ/2u87iIZGe6f0f8pyB4UjzfJNXhJb8JylYYRzIOSxh
 ExKsdLCnJqsG1PY1mqTtoG8sONpwsHr2oJ4itjcGHfn5NJSUGTbtbbxLro13tHkGFCoCr4Z5
 Pv+XRgiANSpYlIigiMbOkide6wbggQK32tC20QxUIwCg4k6dtV/4kwEeiOUfErq00TVqIiEE
 AKcUi4taOuh/PQWx/Ujjl/P1LfJXqLKRPa8PwD4j2yjoc9l+7LptSxJThL9KSu6gtXQjcoR2
 vCK0OeYJhgO4kYMI78h1TSaxmtImEAnjFPYJYVsxrhay92jisYc7z5R/76AaELfF6RCjjGeP
 wdalulG+erWju710Bif7E1yjYVWeA/9Wd1lsOmx6uwwYgNqoFtcAunDaMKi9xVQW18FsUusM
 TdRvTZLBpoUAy+MajAL+R73TwLq3LnKpIcCwftyQXK5pEDKq57OhxJVv1Q8XkA9Dn1SBOjNB
 l25vJDFAT9ntp9THeDD2fv15yk4EKpWhu4H00/YX8KkhFsrtUs69+vZQwc0cRmVsaXggRmll
 dGthdSA8bmJkQG5iZC5uYW1lPsJgBBMRAgAgBQJGoeQnAhsjBgsJCAcDAgQVAggDBBYCAwEC
 HgECF4AACgkQ130UHQKnbvXsvgCgjsAIIOsY7xZ8VcSm7NABpi91yTMAniMMmH7FRenEAYMa
 VrwYTIThkTlQzsFNBEah5FQQCACMIep/hTzgPZ9HbCTKm9xN4bZX0JjrqjFem1Nxf3MBM5vN
 CYGBn8F4sGIzPmLhl4xFeq3k5irVg/YvxSDbQN6NJv8o+tP6zsMeWX2JjtV0P4aDIN1pK2/w
 VxcicArw0VYdv2ZCarccFBgH2a6GjswqlCqVM3gNIMI8ikzenKcso8YErGGiKYeMEZLwHaxE
 Y7mTPuOTrWL8uWWRL5mVjhZEVvDez6em/OYvzBwbkhImrryF29e3Po2cfY2n7EKjjr3/141K
 DHBBdgXlPNfDwROnA5ugjjEBjwkwBQqPpDA7AYPvpHh5vLbZnVGu5CwG7NAsrb2isRmjYoqk
 wu++3117AAMFB/9S0Sj7qFFQcD4laADVsabTpNNpaV4wAgVTRHKV/kC9luItzwDnUcsZUPdQ
 f3MueRJ3jIHU0UmRBG3uQftqbZJj3ikhnfvyLmkCNe+/hXhPu9sGvXyi2D4vszICvc1KL4RD
 aLSrOsROx22eZ26KqcW4ny7+va2FnvjsZgI8h4sDmaLzKczVRIiLITiMpLFEU/VoSv0m1F4B
 FtRgoiyjFzigWG0MsTdAN6FJzGh4mWWGIlE7o5JraNhnTd+yTUIPtw3ym6l8P+gbvfoZida0
 TspgwBWLnXQvP5EDvlZnNaKa/3oBes6z0QdaSOwZCRA3QSLHBwtgUsrT6RxRSweLrcabwkkE
 GBECAAkFAkah5FQCGwwACgkQ130UHQKnbvW2GgCeMncXpbbWNT2AtoAYICrKyX5R3iMAoMhw
 cL98efvrjdstUfTCP2pfetyN
In-Reply-To: <4e943a62736f955af5d9cd1aff7e2b9c084c8885.camel@web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 17.07.24 16:38, Bert Karwatzki wrote:
> Am Freitag, dem 12.07.2024 um 13:06 +0200 schrieb Bert Karwatzki:
>> Am Donnerstag, dem 11.07.2024 um 18:40 -0500 schrieb Sean Wang:
>> > Hi Bert,
>> >
>> > Thanks for the detailed debug log. I've quickly made a change to fix
>> > the issue. Right now, I can't access the test environment, but I'll
>> > test it and send it out as soon as possible. Here's the patch.
>> >
>> > diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
>> > b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
>> > index 2e6268cb06c0..1bab93d049df 100644
>> > --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
>> > +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
>> > @@ -303,6 +303,7 @@ mt7921_add_interface(struct ieee80211_hw *hw,
>> > struct ieee80211_vif *vif)
>> >
>> >         mvif->bss_conf.mt76.omac_idx = mvif->bss_conf.mt76.idx;
>> >         mvif->phy = phy;
>> > +       mvif->bss_conf.vif = mvif;
>> >         mvif->bss_conf.mt76.band_idx = 0;
>> >         mvif->bss_conf.mt76.wmm_idx = mvif->bss_conf.mt76.idx %
>> > MT76_CONNAC_MAX_WMM_SETS;
>> >
>>
>> I wrote earlier that this patch works fine with linux-next-20240711 and at first
>> it did, but then another NULL pointer error occured. I'm not sure if I can
>> bisect this as it does not trigger automatically it seems. Also I'm currently
>> bisecting the problem with linux-20240712
>>
>> Bert Karwatzki
> 
> Now the above mentioned NULL pointer dereference has happended again, this time
> on linux-next-20240716. It cann be triggered by repeatedly turning the Wifi off
> and on again. For further investigation I created this patch:
> 
> diff --git a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> index 2e6268cb06c0..3ecedf7bc9f3 100644
> --- a/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> +++ b/drivers/net/wireless/mediatek/mt76/mt7921/main.c
> @@ -303,6 +303,8 @@ mt7921_add_interface(struct ieee80211_hw *hw, struct
> ieee80211_vif *vif)
> 
>   	mvif->bss_conf.mt76.omac_idx = mvif->bss_conf.mt76.idx;
>   	mvif->phy = phy;
> +	WARN(!phy, "%s: phy = NULL\n", __func__);
> +	mvif->bss_conf.vif = mvif;
>   	mvif->bss_conf.mt76.band_idx = 0;
>   	mvif->bss_conf.mt76.wmm_idx = mvif->bss_conf.mt76.idx %
> MT76_CONNAC_MAX_WMM_SETS;
> 
> @@ -1182,6 +1184,12 @@ static void mt7921_ipv6_addr_change(struct ieee80211_hw
> *hw,
>   				    struct inet6_dev *idev)
>   {
>   	struct mt792x_vif *mvif = (struct mt792x_vif *)vif->drv_priv;
> +	printk(KERN_INFO "%s: mvif = %px\n", __func__, mvif);
> +	printk(KERN_INFO "%s: mvif->phy = %px\n", __func__, mvif->phy);
> +	if (!mvif->phy) {
> +		printk(KERN_INFO "%s: mvif->phy = NULL\n", __func__);
> +		return;
> +	}
>   	struct mt792x_dev *dev = mvif->phy->dev;
>   	struct inet6_ifaddr *ifa;
>   	struct in6_addr ns_addrs[IEEE80211_BSS_ARP_ADDR_LIST_LEN];
> 
> And the result is this (the WARN in mt7921_add_interface did not trigger):
> 
> [  367.121740] [    T861] wlp4s0: deauthenticating from 54:67:51:3d:a2:d2 by
> local choice (Reason: 3=DEAUTH_LEAVING)
> [  367.209603] [    T861] mt7921_ipv6_addr_change: mvif = ffff954e7500de40
> [  367.209615] [    T861] mt7921_ipv6_addr_change: mvif->phy = 0000000000000000
> [  367.209621] [    T861] mt7921_ipv6_addr_change: mvif->phy = NULL
> [  367.250026] [    T861] mt7921_ipv6_addr_change: mvif = ffff954e7500de40
> [  367.250034] [    T861] mt7921_ipv6_addr_change: mvif->phy = ffff954e44427768
> [  367.251537] [    T861] mt7921_ipv6_addr_change: mvif = ffff954e7500de40
> [  367.251542] [    T861] mt7921_ipv6_addr_change: mvif->phy = ffff954e44427768
> [  369.977123] [    T862] wlp4s0: authenticate with 54:67:51:3d:a2:d2 (local
> address=c8:94:02:c1:bd:69)
> [  369.984864] [    T862] wlp4s0: send auth to 54:67:51:3d:a2:d2 (try 1/3)
> [  370.006199] [    T104] wlp4s0: authenticated
> [  370.006680] [    T104] wlp4s0: associate with 54:67:51:3d:a2:d2 (try 1/3)
> [  370.059080] [     T98] wlp4s0: RX AssocResp from 54:67:51:3d:a2:d2
> (capab=0x511 status=0 aid=2)
> [  370.064067] [     T98] wlp4s0: associated
> 
> So mvif->phy can be NULL at the start of mt7921_ipv6_addr_change. The early
> return in that case avoids the NULL pointer and mvif->phy has its usual value
> again on the next call to mt7921_ipv6_addr_change so Wifi is working again. I
> don't know how this could happen but perhaps you have an idea.

This change should fix it: https://nbd.name/p/0747f54f
Please test.

Thanks,

- Felix


