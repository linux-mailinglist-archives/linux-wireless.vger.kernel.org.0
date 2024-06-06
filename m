Return-Path: <linux-wireless+bounces-8606-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 541148FE3D4
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 12:10:35 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 598E428693B
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Jun 2024 10:10:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9E5B518FC6D;
	Thu,  6 Jun 2024 10:10:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="FgRTtFAL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FD2718FC8A
	for <linux-wireless@vger.kernel.org>; Thu,  6 Jun 2024 10:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717668629; cv=none; b=jBTVd5MWWY3GFkxo4U2mbqe0gIqgV+OZ8ZKmb3h65OPXE/Weao7qgUJoOwMdUdDkPKsfWXrnDiUXVcnUoL68d+apDrM1VK2zFtj67FnBTQEolniHhSOE22sNqdXPASB7HnzmC23x+V2DR2JZY+Wl0MzuDgMMCGimmH00nVlFZNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717668629; c=relaxed/simple;
	bh=wgewpJLzgsrrV+jPaQSPUSE3Khsizs7/74aNQwKMGcw=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=RfLLJFdK34188u1GqvVVXb89VgBUCTcPn11Jzz0Vhaj13OYppMZSZCUNmu9b1n5xEkUzcVKAUnP7CfYD6iVkJ8XBRzpj6Th4oil4kaJjTWAuozKRGK9ZKU/6LuVRuR4uIyLF4hC252c4EBYQVKYmi8uzrhurxwLIM1W0dTWYNRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=FgRTtFAL; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=4g4K7aqmZkHqVsRvmp3gdemhs1JP6f80sDnvzYse/6o=; b=FgRTtFAL4l78vS7WG2f5lVcHHt
	Bza5FfUQEujNNJC7+tt8yYP1Y1u37tB7PuR1AzRaN5HwRjniXXurxkqD+Y4oMLP5bwAda0mXG49Dp
	10cJZ+zoFttYkQcE3x4/oWN+ncEKqb20K6RMu1phnfawAyTzNlmC8Gc9mS9ZxntzqY1c=;
Received: from p4ff130d0.dip0.t-ipconnect.de ([79.241.48.208] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sFA4e-008SeL-2h;
	Thu, 06 Jun 2024 12:10:24 +0200
Message-ID: <7744b5a1-446a-4e80-83a2-1c5b727906d2@nbd.name>
Date: Thu, 6 Jun 2024 12:10:24 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v2 0/7] cfg80211/mac80211: support defining multiple radios
 per wiphy
To: Aditya Kumar Singh <quic_adisi@quicinc.com>,
 linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net, quic_periyasa@quicinc.com,
 ath12k@lists.infradead.org
References: <cover.c104c0bb3a14f4ac26aee71f4979846f6ad87742.1717611760.git-series.nbd@nbd.name>
 <f751d310-4cbb-4562-947b-a0a76edb6b40@quicinc.com>
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
In-Reply-To: <f751d310-4cbb-4562-947b-a0a76edb6b40@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 06.06.24 12:00, Aditya Kumar Singh wrote:
> On 6/6/24 00:01, Felix Fietkau wrote:
>> The prerequisite for MLO support in cfg80211/mac80211 is that all the links
>> participating in MLO must be from the same wiphy/ieee80211_hw. To meet this
>> expectation, some drivers may need to group multiple discrete hardware each
>> acting as a link in MLO under single wiphy.
>> 
>> With this series, the bands and supported frequencies of each individual
>> radio are reported to user space. This allows user space to figure out the
>> limitations of what combination of channels can be used concurrently.
>> 
>> Each mac80211 channel context is assigned to a radio based on radio specific
>> frequency ranges and interface combinations.
>> 
>> This is loosely based on Karthikeyan Periyasamy's series
>> "[PATCH 00/13] wifi: Add multi physical hardware iface combination support"
>> with some differences:
>> 
>>   - a struct wiphy_radio is defined, which holds the frequency ranges and
>>     a full struct ieee80211_iface_combination array
>>   - a channel context is explicitly assigned to a radio when created
>>   - both global and per-radio interface combination limits are checked
>>     and enforced on channel context assignment
>> 
>> Changes since RFC:
>>   - replace static per-radio number of channels limit with full ifcomb
>>     checks
>>   - remove band bitmask in favor of only using freq ranges
> 
> What about handling 2 GHz + 5 GHz issue we discussed in v1 related to
> radar detection width and num chan ctx? Is that taken care?

Seems that I missed that one. I will take care of it in the next version.

Thanks,

- Felix


