Return-Path: <linux-wireless+bounces-7529-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 444BA8C3550
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 09:25:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B52AA1F21533
	for <lists+linux-wireless@lfdr.de>; Sun, 12 May 2024 07:25:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3F191078B;
	Sun, 12 May 2024 07:25:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="ltzOaz+m"
X-Original-To: linux-wireless@vger.kernel.org
Received: from out.smtpout.orange.fr (out-18.smtpout.orange.fr [193.252.22.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28240B64B;
	Sun, 12 May 2024 07:25:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=193.252.22.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715498748; cv=none; b=XYEgfe2gvUjqG6DQzNnbo8gjOzqAPruAQIkcNsReoSsU08YkNO5WL/eCdFJvDB6OOPNYFugu5OaNLGW3efaJMwz2uJi4tkLPgH4ZbiTlINBopkNnIbguxis31Ji6cmmuo/Yleu9olaNznoaKDaHahSn4I+FQEBYgvdjyKxuq95c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715498748; c=relaxed/simple;
	bh=PPOMNBV3Glw3iN++/hQQpbxp0F4wKqd1XkP6JbbUKcY=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:Cc:References:
	 In-Reply-To:Content-Type; b=LcBsDFjhGODUZdbw6etwUQtZIlQK/cPxLd+bMtZWwveUMlXpakm8pkoQIebqPkacfx8BCVALpoZgzeT0CArEebPwCE/dL9/Fr/Cg8whUKcT9rEqInNqqpmX1ATFM0wq8reqdVBfQUDNE60yZExQBwDO18cmwpb+cosSjAdPpRPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=ltzOaz+m; arc=none smtp.client-ip=193.252.22.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.17.157])
	by smtp.orange.fr with ESMTPA
	id 63aWscRyh5iYZ63aWsqXbh; Sun, 12 May 2024 09:25:44 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1715498744;
	bh=RtPvSUrEN3BQtMhBvVSB3q+A6lvRVAHJyIYgMiIAyuA=;
	h=Message-ID:Date:MIME-Version:Subject:From:To;
	b=ltzOaz+mHuccNQ8uLvFrW8QIw/2+AI910JD6hnDR0t7mSWSePkhzjJhHCf04FjjDc
	 GB1RxrMy1mk+wtP5VzJ9FR9yLKC5+GiaNtPwm1w52FE09HWTIbgfF7ofgHVIbKS1xa
	 8gZa8zWHMyAo4QV7QfjkYwLYIDAtf/g64Blpoz/uVg1+MD9rzSlJgwZoVUv3v0cUmG
	 opuqrjsWyx1j8lCmRn5BF6ygtl8Vgn6VP8Sqn9Ok7wjDN7jrZI/q1jZiaKTftvNe5t
	 DvlVTDSgycQrNobLKdSOCuzsaOV7vvGFShjShTj3/tKsQxBmQ5j1w3yVNjQ8kjLKPY
	 bXSso4icrIOtg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 12 May 2024 09:25:44 +0200
X-ME-IP: 86.243.17.157
Message-ID: <5dd2eceb-4108-4071-b7b5-1fcac0a9d2ef@wanadoo.fr>
Date: Sun, 12 May 2024 09:25:40 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] lib80211: Handle const struct lib80211_crypto_ops in
 lib80211
From: Marion & Christophe JAILLET <christophe.jaillet@wanadoo.fr>
To: Simon Horman <horms@kernel.org>
Cc: gregkh@linuxfoundation.org, davem@davemloft.net, edumazet@google.com,
 kuba@kernel.org, pabeni@redhat.com, johannes@sipsolutions.net,
 philipp.g.hortmann@gmail.com, tdavies@darkphysics.net,
 garyrookard@fastmail.org, straube.linux@gmail.com,
 linux-staging@lists.linux.dev, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
References: <cover.1715443223.git.christophe.jaillet@wanadoo.fr>
 <d6306f7c76015653e9539ddbcd1ed74d1681a98f.1715443223.git.christophe.jaillet@wanadoo.fr>
 <20240511203104.GW2347895@kernel.org>
 <b6042eae-88cd-4f95-88d8-d1812c2930de@wanadoo.fr>
Content-Language: en-MW
In-Reply-To: <b6042eae-88cd-4f95-88d8-d1812c2930de@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 11/05/2024 à 23:47, Christophe JAILLET a écrit :
> Le 11/05/2024 à 22:31, Simon Horman a écrit :
>> On Sat, May 11, 2024 at 06:32:38PM +0200, Christophe JAILLET wrote:
>>> lib80211_register_crypto_ops() and lib80211_unregister_crypto_ops() 
>>> don't
>>> modify their "struct lib80211_crypto_ops *ops" argument. So, it can be
>>> declared as const.
>>>
>>> Doing so, some adjustments are needed to also constify some date in
>>> "struct lib80211_crypt_data", "struct lib80211_crypto_alg" and the
>>> return value of lib80211_get_crypto_ops().
>>>
>>> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
>>> ---
>>> Compile tested only.
>>
>> Hi Christophe,
>>
>> Unfortunately allmodconfig W=1 build on x86_64 with Clang says:
>>
>> .../libipw_wx.c:587:6: error: assigning to 'struct lib80211_crypto_ops 
>> *' from 'const struct lib80211_crypto_ops *' discards qualifiers 
>> [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>>   587 |         ops = lib80211_get_crypto_ops(alg);
>>       |             ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>> .../libipw_wx.c:590:7: error: assigning to 'struct lib80211_crypto_ops 
>> *' from 'const struct lib80211_crypto_ops *' discards qualifiers 
>> [-Werror,-Wincompatible-pointer-types-discards-qualifiers]
>>   590 |                 ops = lib80211_get_crypto_ops(alg);
>>       |                     ^ ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>
> 
> Hi,
> 
> I'll dig more tomorrow, but I don't see this error (with gcc), even with 
> W=1.
> 
> The following part of the patch is here to avoid the exact compilation 
> error that you see.
> 
> Strange.
> 
> CJ
> 

Ok, got it.
Thanks for the pointer.

I don't know how I missed this one. :(

I'll send a v2.

CJ

