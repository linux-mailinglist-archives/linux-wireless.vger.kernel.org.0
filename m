Return-Path: <linux-wireless+bounces-11572-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 37F1895504F
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 19:55:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A48AB1F2681B
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Aug 2024 17:55:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 011681C37A0;
	Fri, 16 Aug 2024 17:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="drtO67jT"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 379771BDABF;
	Fri, 16 Aug 2024 17:54:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723830887; cv=none; b=EkFSRbzX+EezKCzpAjlRnWzueS6ROJQ9RcRyvyEk31+OX0tBY17hfqAqjXZ5Otn25QnLVn9zoxP0HoY21iWT6BwaUS/ELXLzrUXA9ivnzRUHnlXdXigRCXpW7F/nZE7y61pO0xzCQP1MGG0pDgLvUT6Tmtr8T/q61Ec+UhD/xWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723830887; c=relaxed/simple;
	bh=HMB0d+zljnptTuvZ1g8V5KUfYZO4UpuXN546qJSAXp8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=evC2Ab/dGwfTk3Zi1+tLH5iQ4Fg91oAX43qjtXDmrwfIvqbjcEF6ZbW5KRpLpDIB673yRGPOxAiaQyqILxmgiF+VzB/s76Ppy3OiVOr+vqojE8ck4ND3hLVv6zGXTPsIMk3Aw0+kG8Hm/OOdvfEXwlvNe0y7vY1umzyToxYyE2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=drtO67jT; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=ux1Pje6IouuaMV0vQ1FJ2Gn5ipMIE7UWoQgOp5npzjk=; b=drtO67jTe4JWRWo5YsvE0LF9zJ
	xJPioUbqZb8A1vrMJ9br1FZmcWlJJh0aTDsxFIfC6VgA5gDJDwGcb0UmChB4BuQNRR+S1DcZrr82h
	f3EUA4yjstdJX+q2pk08eWOPY/qh/FP2aVhX3LIJl2/Ohxv5CZellCQ8O5t9bTVeJ01U=;
Received: from p54ae95e7.dip0.t-ipconnect.de ([84.174.149.231] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sf19c-000OvR-1u;
	Fri, 16 Aug 2024 19:54:24 +0200
Message-ID: <e7435c73-1d01-40e8-82b3-4e5456fccf2f@nbd.name>
Date: Fri, 16 Aug 2024 19:54:23 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mac80211: Fix ieee80211_convert_to_unicast() logic
To: Jeff Johnson <quic_jjohnson@quicinc.com>,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@redhat.com>,
 Johannes Berg <johannes@sipsolutions.net>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Michael Braun <michael-dev@fami-braun.de>
Cc: Harsh Kumar Bijlani <hbijlani@qti.qualcomm.com>,
 Kalyan Tallapragada <ktallapr@qti.qualcomm.com>,
 Jyothi Chukkapalli <jchukkap@qti.qualcomm.com>,
 Anirban Sirkhell <anirban@qti.qualcomm.com>,
 Johannes Berg <johannes.berg@intel.com>, linux-wireless@vger.kernel.org,
 netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
 ath12k@lists.infradead.org
References: <20240815-ieee80211_convert_to_unicast-v1-1-648f0c195474@quicinc.com>
 <877ccgd7re.fsf@toke.dk> <229bcc37-de76-40ea-a30a-14e54a73265d@quicinc.com>
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
In-Reply-To: <229bcc37-de76-40ea-a30a-14e54a73265d@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 16.08.24 16:30, Jeff Johnson wrote:
> On 8/16/2024 4:31 AM, Toke Høiland-Jørgensen wrote:
>> Jeff Johnson <quic_jjohnson@quicinc.com> writes:
>> 
>>> The current logic in ieee80211_convert_to_unicast() uses skb_clone()
>>> to obtain an skb for each individual destination of a multicast
>>> frame, and then updates the destination address in the cloned skb's
>>> data buffer before placing that skb on the provided queue.
>>>
>>> This logic is flawed since skb_clone() shares the same data buffer
>>> with the original and the cloned skb, and hence each time the
>>> destination address is updated, it overwrites the previous destination
>>> address in this shared buffer. As a result, due to the special handing
>>> of the first valid destination, all of the skbs will eventually be
>>> sent to that first destination.
>> 
>> Did you actually observe this happen in practice? ieee80211_change_da()
>> does an skb_ensure_writable() check on the Ethernet header before
>> writing it, so AFAICT it does not, in fact, overwrite the data of the
>> original frame.
> 
> I'm proxying this change for our internal team, and they have observed that
> unicast frames are not being sent to the separate STAs.
> 
> In response to your reply I went through the code again and it seems the
> manner in which this functionality fails isn't as it was described to me.
> 
> Instead this functionality fails because we'd fail on the first
> ieee80211_change_da() call and hence goto multicast and where only the
> original skb would be queued and transmitted as a multicast frame
> 
> So the original logic is still faulty, only the actual faulty behavior is not
> being described correctly: instead of sending multiple unicast frames to the
> same STA we'd send a single multicast frame.

While I agree with switching over to skb_copy (or maybe pskb_copy to 
reduce realloc on fragmented skbs), it's still not clear to me why 
ieee80211_change_da fails. It should detect that the packet was cloned, 
letting pskb_expand_head reallocate the head of the skb.

Please run some more tests to figure out the exact reason for the 
failure. There might be another hidden bug lurking there, which would 
get papered over by this change.

- Felix

