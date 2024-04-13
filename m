Return-Path: <linux-wireless+bounces-6275-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AC4D68A3CD4
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Apr 2024 15:31:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4B4DA1F21AB3
	for <lists+linux-wireless@lfdr.de>; Sat, 13 Apr 2024 13:31:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 581623F8F1;
	Sat, 13 Apr 2024 13:30:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="TjbvUSN5"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E4C021106
	for <linux-wireless@vger.kernel.org>; Sat, 13 Apr 2024 13:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713015056; cv=none; b=OmXQsKcJzgAld/O+fUZb2Cu9nXmtR2lQ5caYXF43Kb6DNjIveCu5Oz2pXkqiSpC4Fnhp+98W2xFk3A4PhUQlnYspu3T5IpuRpOY7Yj1VBk2WlhFiSv+rBVQKsI9iKJR9p1TnwfZ19DrBXZ7bEdb8Fzzvwm3vJk1ogdCEht1PqNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713015056; c=relaxed/simple;
	bh=6fVqm6ch0ZRi8cAZ8KB3Zeakc+HO9hVxyxicu2RSjP0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=Br1Q/V6rVMfzpLhmoyvQge455tGLrSkOE4tP1hiC/peneAIxHaEG3+bccGIZZAWCW1WScRHV7ny1JZgBLcVhIKwp+O+E/ovoIdbrJit0bOdQzOdlTgH+F0NjnQOpJyYTsc6N4PT5QmaTkT6vH8jOwQZQGUnFaYM/CxYN4czfqM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=TjbvUSN5; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ybCElKF7KK0pi3m+XyzKV37DtqEUOxr9SgqR3vFroYs=; b=TjbvUSN5+JunAseer6HgZQBcKI
	minR5lxRQVKP8tCHyFNNn6vqGEYqJ23NhQRyx34A8Y0T/vSrfKTB7WP+pO3xq1zOSxT6UjFxlCMAb
	KcE589UGa1g8deF70aYHYepGqw39n4J+1KXmMIM7YkMXF5HYGKFwxR3u98XIh2/lK1Us=;
Received: from p54ae9c93.dip0.t-ipconnect.de ([84.174.156.147] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1rvdSv-000UdL-0I;
	Sat, 13 Apr 2024 15:30:45 +0200
Message-ID: <76c40516-3959-4564-a51d-3d387d3eaf4c@nbd.name>
Date: Sat, 13 Apr 2024 15:30:44 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: split mesh fast tx cache into
 local/proxied/forwarded
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20240412120634.88972-1-nbd@nbd.name>
 <893ca115e668c6778344bcbd30168fe37bd5c80d.camel@sipsolutions.net>
Content-Language: en-US
From: Felix Fietkau <nbd@nbd.name>
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
In-Reply-To: <893ca115e668c6778344bcbd30168fe37bd5c80d.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.04.24 14:55, Johannes Berg wrote:
> On Fri, 2024-04-12 at 14:06 +0200, Felix Fietkau wrote:
>> 
>> +struct ieee80211_mesh_fast_tx_key {
>> +	u8 addr[ETH_ALEN] __aligned(2);
>> +	enum ieee80211_mesh_fast_tx_type type;
>> +};
> 
> Does it make sense to hash a bunch of zeroes there if the compiler
> allocates more than a single byte for "type"? It's uglier, but maybe
> makes more sense to not do that? There's also padding in there in that
> case.

Good point. I will change the type to u16 to make the size explicit and 
make the struct size a multiple of 4 for faster hashing.

>> @@ -646,12 +653,18 @@ void mesh_fast_tx_flush_addr(struct ieee80211_sub_if_data *sdata,
>>  			     const u8 *addr)
>>  {
>>  	struct mesh_tx_cache *cache = &sdata->u.mesh.tx_cache;
>> +	struct ieee80211_mesh_fast_tx_key key = {};
>>  	struct ieee80211_mesh_fast_tx *entry;
>> +	int i;
>>  
>> +	ether_addr_copy(key.addr, addr);
>>  	spin_lock_bh(&cache->walk_lock);
>> -	entry = rhashtable_lookup_fast(&cache->rht, addr, fast_tx_rht_params);
>> -	if (entry)
>> -		mesh_fast_tx_entry_free(cache, entry);
>> +	for (i = MESH_FAST_TX_TYPE_LOCAL; i < MESH_FAST_TX_TYPE_FORWARDED; i++) {
> 
> Seems that should be "i <= ...FORWARDED".
> 
> Maybe better then to add a NUM_MESH_FAST_TX_TYPES or so to the enum and
> then use "i < NUM_MESH_FAST_TX_TYPES", so new additions won't have to
> update this, if they ever happen.

Will do, thanks.

- Felix


