Return-Path: <linux-wireless+bounces-32298-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id QHPIBiqeoWl8ugQAu9opvQ
	(envelope-from <linux-wireless+bounces-32298-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 14:37:46 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 167311B7C0E
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 14:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 63A09315D9BD
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 13:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C6743321D8;
	Fri, 27 Feb 2026 13:33:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b="2F3XIPLw"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81D3B2E0B58
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 13:33:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772199231; cv=none; b=ASNCAtCroAmBKckiIGVUdprRO/4gD8SIfkzMdH2xMD2PVtnere30tNcwZn54lZoofPtjQ/FThVLyiDZL70mnTDlWVNR6fRExSTdfuovoUXLNO1ExfW5CRA8TB6v/wodRUUE+xFR7Sqy17Zf57gscwTXrcg0nzEQ+Sbmt4hxL7dE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772199231; c=relaxed/simple;
	bh=Upp4oMc9/X4AQda5IpHmTaVzbPMwBO3VybWxuThUALo=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=ezjRItttfzbU7HQsX2SIbGKSYFek1DeL9Mvtcv51VeCfZXjH3fsZZhx0Gc+ZtQbjJZP99x+vX1IiFonjID+7zmaBP/t2mjpuo2+iyMUPa2Vfq0JAKv9E3BepIYY1bcjIW1iVSsAZBC2Dnj6gu+iNXeJGGO/NNP+9XRRr+cxfsEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr; spf=pass smtp.mailfrom=freebox.fr; dkim=pass (2048-bit key) header.d=freebox-fr.20230601.gappssmtp.com header.i=@freebox-fr.20230601.gappssmtp.com header.b=2F3XIPLw; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=freebox.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=freebox.fr
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-48371bb515eso28416685e9.1
        for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 05:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=freebox-fr.20230601.gappssmtp.com; s=20230601; t=1772199227; x=1772804027; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=wuIp8kl4kfSc19RxEC0tAEvdFbGo9h2ag1rg+SEyGHk=;
        b=2F3XIPLwkPQk5VOGTweyuPAPbcZwk327fEYDYWO6Ja3CqNgL+CYvKx6NCCD8/vbXTx
         U+1+GtO9cKREDkstnMuenul4jcFaS+75D4rB12r59csXc8+2rG6Q4lHieTa6xU1deC7k
         vy8c+nVhBnvz0z5rxAeZe369bWlx06Iqqr1v/cwSAHeSeLA0iDAYR34tUkHLeYK/V1MQ
         /6F3OlJkpgCeRP6ZrTx2B0KoKG/lMaABaccr4JuV28W+q1VIlmF611vcBCYo7wrfAE+t
         YZCYIHpGGbMqlmtf0o9HcA+X58D2DjxkXNsuZPCA8QHOL8uYNb2xi7GauaRAgjllVnlA
         DQdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772199227; x=1772804027;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wuIp8kl4kfSc19RxEC0tAEvdFbGo9h2ag1rg+SEyGHk=;
        b=cxawXdnznh48p0N1efLyfeN4+kbvVu5QtHGNdNSbSpCjVZogfg+GP1vtzfdTifzMb6
         rIfpK4Wyl7Y71NFqKIK8gdGGh8UxuCXxCzbxB6DhGUFvutXFKdlTpxgaWNsoo95ickOG
         YC1RN1Uf6Ix7TO+ut2ScJvARJpegFnOZA43qnufqns1TqL098X46JGPjAjrFVlxguYxF
         2YFA7vOeMkzgeNckakqsikRQQEeB7JWwG05UswRZKtW9841TFX4XMCo5HN7by+HvpjbF
         P4UdEVh679+4qBbpm63yCAi+yE1VPYxgo6bOYyGieY4jhx2XkOLcDespC5k06W3qH/S1
         05PA==
X-Forwarded-Encrypted: i=1; AJvYcCWeb8h/kDMPX17d4+qSqAvszkMSsZoALdFNdXEFUBTuLYajlN5FxoTGCoKU03uuvK/LQmy5PazzpSdnVpivDg==@vger.kernel.org
X-Gm-Message-State: AOJu0YwPcS5fJinPFM3OXmmqxYFBQOe054QgUuzCky47YfdR1gU81BJ2
	iUScdZOM8wdilwejizKwKvJ6XmYuB2dupO2tRpI+Cb6V1lFB7JkyQt9DmozPNQrxHJI=
X-Gm-Gg: ATEYQzzr+roEhlCq3qjaxDITqvml5gc1iXooMG2/2bP/uqRrePcD+Y7xdfznHpz5gDq
	uhPEW5U3kh7KAbMTTYTksF5OQ8admV4CM9oSWB1wNf9liebeqAvF7T6JnnNZnQeh0m/+Yd53uDL
	1Ax5zWbBcH0+MO4dRWKmDKZf4RWzBbrhjuwN/UR6qxtI9izQHli+/fzTiPO0hHlKHv/JMB/qBoK
	ICmN/1nNzkzVEPe0YNwrvUvKheSppBycSqbpKhZyF6s2ey4zmMorRdABOfBPl7wzAy72ACSZqEy
	q/LFcMQKLtcfVEmratELnVGnR5qp7MugNvHccH+PJOnqN4iquO7ezfDl9rCrltfcGjLR+399fiq
	wO4vAgFqw8IsVAKPoPgMLzFz6f4DBUWxtwOyMmnKMMCqrsp+YD8MGabyEvuFivLs1Zr+ZUmAeyr
	DJfALukFx7MAd5Mu8FGF//65pDO1dBD/22/FQJu8gPMoqP7g7OFavMURN4FHEO+NvN
X-Received: by 2002:a05:600c:1989:b0:483:a2ce:f461 with SMTP id 5b1f17b1804b1-483c9bb8f11mr40911295e9.4.1772199226537;
        Fri, 27 Feb 2026 05:33:46 -0800 (PST)
Received: from [192.168.108.101] (freebox.vlq16.iliad.fr. [213.36.7.13])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-483c3b3d24dsm92087415e9.5.2026.02.27.05.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Feb 2026 05:33:46 -0800 (PST)
Message-ID: <80e01dba-5de5-41c7-a226-cd6d4dbe7222@freebox.fr>
Date: Fri, 27 Feb 2026 14:33:45 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2] wifi: move action code from per-type frame structs
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20260226183607.67e71846b59e.I9a24328e3ffcaae179466a935f1c3345029f9961@changeid>
 <418d3666-6bd2-4ea7-8e1b-4d49dda255a2@freebox.fr>
 <7f71b9df99e286c695b9c159792e68b36a1dd54f.camel@sipsolutions.net>
From: Pablo MARTIN-GOMEZ <pmartin-gomez@freebox.fr>
Content-Language: en-US
In-Reply-To: <7f71b9df99e286c695b9c159792e68b36a1dd54f.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.66 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	R_SPF_ALLOW(-0.20)[+ip4:172.234.253.10:c];
	R_DKIM_ALLOW(-0.20)[freebox-fr.20230601.gappssmtp.com:s=20230601];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	MIME_TRACE(0.00)[0:+];
	TAGGED_FROM(0.00)[bounces-32298-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	DMARC_NA(0.00)[freebox.fr];
	DKIM_TRACE(0.00)[freebox-fr.20230601.gappssmtp.com:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FROM_HAS_DN(0.00)[];
	TO_DN_SOME(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pmartin-gomez@freebox.fr,linux-wireless@vger.kernel.org];
	ASN(0.00)[asn:63949, ipnet:172.234.224.0/19, country:SG];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,freebox.fr:mid]
X-Rspamd-Queue-Id: 167311B7C0E
X-Rspamd-Action: no action

On 27/02/2026 12:45, Johannes Berg wrote:
> On Fri, 2026-02-27 at 12:22 +0100, Pablo MARTIN-GOMEZ wrote:
>>
>>> +++ b/drivers/net/wireless/marvell/mwifiex/tdls.c
>>> @@ -755,16 +755,12 @@ mwifiex_construct_tdls_action_frame(struct mwifiex_private *priv,
>>>  	switch (action_code) {
>>>  	case WLAN_PUB_ACTION_TDLS_DISCOVER_RES:
>>>  		/* See the layout of 'struct ieee80211_mgmt'. */
>>> -		extra = sizeof(mgmt->u.action.u.tdls_discover_resp) +
>>> -			sizeof(mgmt->u.action.category);
>>> +		extra = IEEE80211_MIN_ACTION_SIZE(tdls_discover_resp) - 24;
>> Not sure that is clearer than:
>> ```
>> extra = sizeof(mgmt->u.action.u.tdls_discover_resp) +
>>         sizeof(mgmt->u.action.category) +
>>         sizeof(mgmt->u.action.action_code);
>> ```
> 
> That's a bit of a corner case, but given the above code that uses 24
> explicitly, I tend to think it _is_ clearer, and it's definitely "safer
> to understand" - you know that you didn't miss anything...
> 
> If someone wrote here
> 
> 	extra = sizeof(mgmt->u.action.u.tdls_discover_resp);
> 
> would you really see that it's wrong? I think it's very easy to miss.
> It's correct now, but the "- 24" definitely flags this as something
> special to check the context.
>
Reading the full function, and give that the 24 value is already
hardcoded in the above code, I guess you are right.

>>>  	addba_ext_data =
>>>  		ieee80211_retrieve_addba_ext_data(sta,
>>> -						  mgmt->u.action.u.addba_req.variable,
>>> +						  mgmt->u.action.addba_req.variable,
>>>  						  len -
>>>  						  offsetof(typeof(*mgmt),
>>> -							   u.action.u.addba_req.variable),
>>> +							   u.action.addba_req.variable),
>> `offsetof(typeof(*mgmt), u.action.u.type.variable` is equivalent to
>> `IEEE80211_MIN_ACTION_SIZE(type)`, isn't clearer to use it?
> 
> I guess we could. I was mostly getting it to compile at some point :)
> 
>>> @@ -949,8 +945,8 @@ void mesh_rx_path_sel_frame(struct ieee80211_sub_if_data *sdata,
>>>  	}
>>>  	rcu_read_unlock();
>>>  
>>> -	baselen = (u8 *) mgmt->u.action.u.mesh_action.variable - (u8 *) mgmt;
>>> -	elems = ieee802_11_parse_elems(mgmt->u.action.u.mesh_action.variable,
>>> +	baselen = mgmt->u.action.mesh_action.variable - (u8 *)mgmt;
>> Another equivalent to `IEEE80211_MIN_ACTION_SIZE(type)`
> 
> type?
A copy-paste error, I wanted to say `IEEE80211_MIN_ACTION_SIZE(mesh_action)`
> 
>>> +	elems = ieee802_11_parse_elems(mgmt->u.action.mesh_action.variable,
>>>  				       len - baselen,
> 
>>> -	dialog_token = mgmt->u.action.u.ttlm_req.dialog_token;
>>> -	ies_len  = len - offsetof(struct ieee80211_mgmt,
>>> -				  u.action.u.ttlm_req.variable);
>>> -	elems = ieee802_11_parse_elems(mgmt->u.action.u.ttlm_req.variable,
>>> +	dialog_token = mgmt->u.action.ttlm_req.dialog_token;
>>> +	ies_len  = len - IEEE80211_MIN_ACTION_SIZE(ttlm_req);
>> Here you did it :)
> 
> Guess it didn't really matter that much. Or I stumbled over this one at
> a different time, or something :)
> 
> I don't think any of this is worth changing right now. Feel free to send
> extra patches.
Fair enough. I'll send the extra patches. Otherwise the change looks
good to me.
> 
> johannes

Pablo MG

