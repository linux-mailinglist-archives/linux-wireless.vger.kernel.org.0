Return-Path: <linux-wireless+bounces-14336-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A4E1D9AB4B9
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 19:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 56429284F61
	for <lists+linux-wireless@lfdr.de>; Tue, 22 Oct 2024 17:07:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A18681BD01A;
	Tue, 22 Oct 2024 17:07:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="FCqZFx06"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta036.useast.a.cloudfilter.net (omta036.useast.a.cloudfilter.net [44.202.169.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE5851BC9E5
	for <linux-wireless@vger.kernel.org>; Tue, 22 Oct 2024 17:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729616846; cv=none; b=FfqmoxnqgTXU49KoLwCi+CnXvMtvQCSp9tpCAs6riB3UlYDQsBHqWXSd2FhPF/afJUtlOtxBvVum2jWJS7dxERltN2le75NQwjMN5whyWO9+99OCqavngU+QSrVO2A66qg8G+7sAqXUqnxGKauRrTgIayca2CsNs7ZD10cCBXzs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729616846; c=relaxed/simple;
	bh=mp0Jcn5EtOnjMbflgg0F1NYpB+AlS4nk0vTcWOB4BZo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KpbYcntTOs53wOTUTPwSxvISf4RXhbEhhq24fW7jWEYP4GK3EGFDx2xw/fNmqtvhMkeIcaaDqt8h8MkZtY5fa5XFjfL0l53itiX4GN2RVzdwX1Fj8x2NBWyqUHkjnFlsXo5K9Qc/G4UKkc433UNhjIj5us2ET8UfYbZ9T5kNOsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=FCqZFx06; arc=none smtp.client-ip=44.202.169.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id 2vZdtfgVXiA193ILltNCAF; Tue, 22 Oct 2024 17:07:17 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 3ILht2m0L827n3ILht7I5F; Tue, 22 Oct 2024 17:07:13 +0000
X-Authority-Analysis: v=2.4 cv=GeTcnhXL c=1 sm=1 tr=0 ts=6717dbc1
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=OKg9RQrQ6+Y1xAlsUndU0w==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10 a=vggBfdFIAAAA:8
 a=mDV3o1hIAAAA:8 a=Ptn-oV1zd_OeuEQti5AA:9 a=QEXdDO2ut3YA:10 a=SS-iHM-wgvsA:10
 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=nk5LLuWorWhD+hjQc4rS4N1v3XwIncbBTQM7XbjQieM=; b=FCqZFx06ykmZSPSUVaN05zCfak
	yrwfC8pZ50z/TTclPSddJSj3t9Xu+efAFQkz3jNgGnAE5RMuslhh8lBioWzjvocie1ibn75+ot3nt
	4pqXWJy25T6oKIDVOn3NoBEJpghC2yIe10Hwd867a7jQddyavpsHftYo18EmkSqtM9iN+KuTdqO5h
	C3hDAc2ntsUcc9YdnaB04YBQjiiQvMcK2L1wdBj4M71zkB6LIbqahYtvSSPUHwbOEK4DoZbtC4GW4
	grCmxQtu4cPqK+1dMBPvlmFTOdGDncccypqOOHhs9+3WAkZmLDkL1C8ecnAg54HkfrR0VYwW7/i34
	0SelyCYQ==;
Received: from [201.172.173.7] (port=50728 helo=[192.168.15.5])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t3ILb-000j3U-2e;
	Tue, 22 Oct 2024 12:07:07 -0500
Message-ID: <60395da0-5969-4d72-9b90-c60e5473b7a5@embeddedor.com>
Date: Tue, 22 Oct 2024 11:07:02 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/5][next] net: dev: Introduce struct sockaddr_legacy
To: Kuniyuki Iwashima <kuniyu@amazon.com>, gustavoars@kernel.org
Cc: andrew+netdev@lunn.ch, davem@davemloft.net, dsahern@kernel.org,
 edumazet@google.com, johannes@sipsolutions.net, kees@kernel.org,
 kuba@kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, pabeni@redhat.com
References: <1c12601bea3e9c18da6adc106bfcf5b7569e5dfb.1729037131.git.gustavoars@kernel.org>
 <20241016033042.89280-1-kuniyu@amazon.com>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <20241016033042.89280-1-kuniyu@amazon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 201.172.173.7
X-Source-L: No
X-Exim-ID: 1t3ILb-000j3U-2e
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.5]) [201.172.173.7]:50728
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 3
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfJqZvgJQD6600tXAl43dfG14mK7O2tWPrE7ww0coi+2qqmftvjA/u9uhF6lRRDi+6m5TfZ/9PKPTxkO97VlDwY7JIP6TQGKo7ywg9FysJ0vZrCmS1Rgd
 3aBafOqS/XBz94SjDBceByELQORJC0izcQn8wom/GJp07QIYJNtkV91tBlfj94NCq1xc/JlhBV2nAXHiyfvH6IMltHeOFdmfB9/n20BioxuVsoitWFTWTyQg


>>   
>> +/*
>> + * This is the legacy form of `struct sockaddr`. The original `struct sockaddr`
>> + * was modified in commit b5f0de6df6dce ("net: dev: Convert sa_data to flexible
>> + * array in struct sockaddR") due to the fact that "One of the worst offenders
> 
> s/sockaddR/sockaddr/
> 
> The same typo? exists in the cover letter.

Thanks for catching this! :)

--
Gustavo

> 
> With it fixed,
> 
> Reviewed-by: Kuniyuki Iwashima <kuniyu@amazon.com>
> 
> 
>> + * of "fake flexible arrays" is struct sockaddr". This means that the original
>> + * `char sa_data[14]` behaved as a flexible array at runtime, so a proper
>> + * flexible-array member was introduced.
>> + *
>> + * This caused several flexible-array-in-the-middle issues:
>> + * https://gcc.gnu.org/onlinedocs/gcc/Warning-Options.html#index-Wflex-array-member-not-at-end
>> + *
>> + * `struct sockaddr_legacy` replaces `struct sockaddr` in all instances where
>> + * objects of this type do not appear at the end of composite structures.
>> + */
>> +struct sockaddr_legacy {
>> +	sa_family_t	sa_family;	/* address family, AF_xxx	*/
>> +	char 		sa_data[14];	/* 14 bytes of protocol address	*/
>> +};
>> +
>>   struct linger {
>>   	int		l_onoff;	/* Linger active		*/
>>   	int		l_linger;	/* How long to linger for	*/
>> -- 
>> 2.34.1
> 

