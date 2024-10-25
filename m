Return-Path: <linux-wireless+bounces-14559-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FBF9B0FBB
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 22:23:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1479B286D6F
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 20:23:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2767214407;
	Fri, 25 Oct 2024 20:23:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="JIHIYnvW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta34.uswest2.a.cloudfilter.net (omta34.uswest2.a.cloudfilter.net [35.89.44.33])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56C2820C319
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 20:23:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.33
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729887791; cv=none; b=hPpsMjlRnNm1hAxFoPJ2tH4qXCR51+C2FQBwLu1LY9uQoNf3irZAhk+auGrGfiHwjmgeI0fRMgmVMkFthjFP2OLCn+DVBlzPDuurL4wdr1CEAeLRKhKyUdgoSx8j1VwBg9X+zSQtuUonlTULlwOpCscfyn/xQSr12lETuTB5z+Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729887791; c=relaxed/simple;
	bh=/DU7ljnmOAu6PpQlgidckqV7GR7CNvehMh5qJOoT5X8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tDOmnTah8xwTamiEbRSGcdELrXheTSRz6LOZIBX6Favb4be5sZFppmkZ+vsD90Uuufzgwa+WLGbIqNojsTGMBNj82wNXXLZVFuaq9HunCC7xARc8ox4SZ5qbs5DNSaV705alKDjpX++E83eMlm1IAomzh3NWWyQFZx4fK/zZGwE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=JIHIYnvW; arc=none smtp.client-ip=35.89.44.33
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id 3pk2te4XSVpzp4QpqtKrg4; Fri, 25 Oct 2024 20:23:02 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 4Qpot0FYQWvXp4Qpptk9Sm; Fri, 25 Oct 2024 20:23:01 +0000
X-Authority-Analysis: v=2.4 cv=LtdZyWdc c=1 sm=1 tr=0 ts=671bfe25
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=OKg9RQrQ6+Y1xAlsUndU0w==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10 a=VwQbUJbxAAAA:8
 a=_NoSb7y0OcS4ETTgVD8A:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=Eupea/4ZNfEmkgEIRJPG6CcWmcMYt4RgMlnirjwYWYM=; b=JIHIYnvWaSEVpfRfVsEmNL1z9r
	A7OqlPQ0D3wguSDnQAXBRS9dLrIo0AJDRdiMXIvtf9kdB98uflLjm5UfYPdO57uMYkk2/hHnH6mMM
	NkHWpH5AEH6pA05znftv0TQgxY2o+J/8WPr7byuWEFdkrey5v46CIo8O06Tt7CgtMdOOe5pRtjYXP
	ZShqRk0cv8GyEPcYsanv5QWujk0KsUnZ0+grmbXtBtPvSS6raMu0e+lbteur0sMA4qCLX/nwUwqNA
	qWopr3iNO5UmaF/wJBLN8D1KWyR1u3GHd7/1fU0fY/eUd0mO16YO9/W6zpPlTBa0eShjRqxPd/DPu
	Gx0uHLzA==;
Received: from [201.172.173.7] (port=46502 helo=[192.168.15.6])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t4Qpo-003HEV-0Q;
	Fri, 25 Oct 2024 15:23:00 -0500
Message-ID: <3471e59f-a414-479f-8fb0-aa1a26aecf16@embeddedor.com>
Date: Fri, 25 Oct 2024 14:22:58 -0600
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH][next] wifi: mac80211: ieee80211_i: Avoid dozens of
 -Wflex-array-member-not-at-end warnings
To: Johannes Berg <johannes@sipsolutions.net>,
 "Gustavo A. R. Silva" <gustavoars@kernel.org>
Cc: linux-wireless@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-hardening@vger.kernel.org, Aditya Kumar Singh <quic_adisi@quicinc.com>
References: <Zxv7KtPEy1kvnTPM@kspp>
 <c90c3c9825e3837bf7c47979acd0075b102576ce.camel@sipsolutions.net>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <c90c3c9825e3837bf7c47979acd0075b102576ce.camel@sipsolutions.net>
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
X-Exim-ID: 1t4Qpo-003HEV-0Q
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.6]) [201.172.173.7]:46502
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfO7n+66Aw3VkP72ZZxzglS/CI1D3vhMTEJiT+vPv01UdKWVojPQ5ac/rhZozCOF4UNe4aI1UbplX55Z03hXru2XaQW0Y1F0LL09qXg2sVhSJiDnopr7H
 BEpIV0Ci5PPAfEKU0koStjkroW5J4eXpIjTXKJ/yEYRo63jd90d+N8YzA3g/Qa2CqG6bDYeiNUj7yzSS93A8udrZREImJq0KVwwZZA4mAAhKXCSRej+wN6RJ



On 25/10/24 14:14, Johannes Berg wrote:
> On Fri, 2024-10-25 at 14:10 -0600, Gustavo A. R. Silva wrote:
>> -Wflex-array-member-not-at-end was introduced in GCC-14, and we are
>> getting ready to enable it, globally.
>>
>> Move the conflicting declaration to the end of the structure and add
>> a code comment. Notice that `struct ieee80211_chanctx_conf` is a
>> flexible structure --a structure that contains a flexible-array member.
>>
>> Fix 50 of the following warnings:
>>
>> net/mac80211/ieee80211_i.h:895:39: warning: structure containing a flexible array member is not at the end of another structure [-Wflex-array-member-not-at-end]
>>
>> Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
>> ---
>>   net/mac80211/ieee80211_i.h | 5 +++--
>>   1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/net/mac80211/ieee80211_i.h b/net/mac80211/ieee80211_i.h
>> index e7815ffeaf30..c65adbdf2166 100644
>> --- a/net/mac80211/ieee80211_i.h
>> +++ b/net/mac80211/ieee80211_i.h
>> @@ -892,9 +892,10 @@ struct ieee80211_chanctx {
>>   	/* temporary data for search algorithm etc. */
>>   	struct ieee80211_chan_req req;
>>   
>> -	struct ieee80211_chanctx_conf conf;
>> -
>>   	bool radar_detected;
>> +
>> +	/* MUST be last - ends in a flexible-array member. */
>> +	struct ieee80211_chanctx_conf conf;
>>   };
> 
> Oi. That's not just a warnings problem, that's actually a pretty stupid
> bug, this will surely get used and radar_detected will alias stuff that
> the driver puts there - at least for drivers using chanctx_data_size,
> which is a couple: ath9k, iwlmvm, mt792x, rwt89 and hwsim.
> 
> Could you resend with a description that this is a bugfix and
> 
> Fixes: bca8bc0399ac ("wifi: mac80211: handle ieee80211_radar_detected() for MLO")

Yeah, I was actually going to mention this commit, as it's the one that introduced
that `bool radar_detected` to the flex struct. However, it wasn't obvious to me
how `struct ieee80211_chanctx_conf conf` could overwrite `radar_detected` as I didn't
see `conf->drv_priv` being accessed through `struct struct ieee80211_chanctx_conf`.

> 
> please? Or I can do it myself I guess, but ...

Sure thing. I can CC stable as well.

> 
> This shouldn't go to next, it should go to 6.12 since that broke it...

OK, in that case I just remove the `[next]` part from the subject line.

Thanks
--
Gustavo

