Return-Path: <linux-wireless+bounces-3410-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 77B4484FD1C
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 20:46:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 38CBC281DDB
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Feb 2024 19:46:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8390D7EF1B;
	Fri,  9 Feb 2024 19:46:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="cxgvsTpf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1AC9384A3D
	for <linux-wireless@vger.kernel.org>; Fri,  9 Feb 2024 19:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707507983; cv=none; b=m9dam+i8pMrtshqjrU1+Utbjw1XjQw+RLTGdPJXownkO3T1Bjae8vDGr8onFsslDtyhS17Sc5u3T1UfQvNbK1I4KwgsuMNKImzPzB0xFrpjuBnHdGOL4BJlfxSIDFZho9c8wD7kCDfUHd98DBik5ImQbtWLrcdd2WqRMB4bEVUw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707507983; c=relaxed/simple;
	bh=AbpyhvEvlwRTPf0BSZ6ddwJ9v3BiJKaEW2U1qCqc+38=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=rMiNOBLH1/7YZFXYpA+I0dA5Hz4/0f8hvkFQbpDAZil4ySxeN+MYXI5VDCGuRYH2CWFaIvuOjQmzhQTR4Y3MR+9ajSUxIJ67Nl1fsJi8H68T/IAMFz8F+mp7MrZs/IGARvm1y5gQVhhDegf1gGq19Uxvdu2l44RA7usPB1nTVqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=cxgvsTpf; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Y36zTgfTtuWKYKdmTfgcULRQT5lPGxSRict1dxDqARs=; b=cxgvsTpfiUYgB/BTXqZTuFAoAq
	8o0WAEKssX6Ya1zmWUcdguo3fJsmfzI9Z7EDhix3htGU7SdigqQpdf0clP1XjD8urA+w+LwwkYR7j
	IctLYaiSLPq2Ae+yxCz0DOiYzQCb7WVdQXvHFdt7gHcNhJdKfsyZeReS0h/G5CxMLNIg=;
Received: from p54ae9e7b.dip0.t-ipconnect.de ([84.174.158.123] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rYWpG-00CYBN-KI; Fri, 09 Feb 2024 20:46:18 +0100
Message-ID: <ab91f85f-0b0d-4537-80fe-2edd8e8f31e3@nbd.name>
Date: Fri, 9 Feb 2024 20:46:18 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] mac80211: add AQL support for broadcast packets
Content-Language: en-US
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20240209184730.69589-1-nbd@nbd.name>
 <d3f6cdef5b05fba8eadedf67129c9c49471a08f0.camel@sipsolutions.net>
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
In-Reply-To: <d3f6cdef5b05fba8eadedf67129c9c49471a08f0.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 09.02.24 20:32, Johannes Berg wrote:
> 
>> -	if (sscanf(buf, "%u %u %u", &ac, &q_limit_low, &q_limit_high) != 3)
>> +	n = sscanf(buf, "%u %u %u", &ac, &q_limit_low, &q_limit_high);
>> +	if (n < 2)
>>  		return -EINVAL;
>>  
>> -	if (ac >= IEEE80211_NUM_ACS)
>> +	if (ac == IEEE80211_NUM_ACS) {
>> +		local->aql_txq_limit_bc = q_limit_low;
>> +		return count;
>> +	}
> 
> If we keep this, it should probably check n == 2?
> 
> But not sure I like it - in other places ac == NUM_ACS means management
> rather than not multicast; could we just check something like
> 
> 	strncmp(buf, "mcast ", 6)
> 
> instead? Or "BC/MC" matching the output? Though we don't match VO on
> input either.

Sure. I will do this:

	if (sscanf(buf, "mcast %u", &q_limit_low) == 1) {
		local->aql_txq_limit_bc = q_limit_low;
		return count;
	}


