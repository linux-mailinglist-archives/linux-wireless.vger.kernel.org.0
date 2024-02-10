Return-Path: <linux-wireless+bounces-3415-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 36C75850516
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Feb 2024 17:18:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAC3F1F21EC8
	for <lists+linux-wireless@lfdr.de>; Sat, 10 Feb 2024 16:18:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1C5955C04C;
	Sat, 10 Feb 2024 16:18:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="rt+3Kli1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84E5C5B5D8
	for <linux-wireless@vger.kernel.org>; Sat, 10 Feb 2024 16:18:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707581906; cv=none; b=o6Ilth972/67P9cMEnqSSeZARUeLcnIwzkSW7rghXOThXKeKfE/jR8az7/snzv+MK+sNKeWhIR+TtELIByk/OicpPajYBV47JiWy2Kivb2Ut5GRRztn++Tk7/6BTV64pj8YArcaaTxmgh72uT+RTALycrkgBuHpWn//cFzG3Pek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707581906; c=relaxed/simple;
	bh=3nILwbegccCzudaxwLW5nBZliQxLkQgKxY4XTh3hcJ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=fql3PzXe0u4YUE7Ibzp5+/wylQbTQFlEbL5JSaOO+Kh1cT92JVjYnZlkHWUFAA+wfeQzk1hBQ5MVY3qMZI4iXx58QfPZyKjXS7PXQ/aDCOIfj65PNFjZBctMxDcQDNfunhPFbwamcJhTMiBx7ohGpf3gby414etsO2gE6e0WKaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=rt+3Kli1; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=z0ToS+U6W9r46yIShlsfKuoEeHzne29FXtkIEF+0k3E=; b=rt+3Kli1QnJH27MnjTqR/llOYc
	oILjPZj06kjUzCIDdVcEzBHZp2uy46qeipMlGpV2eoLGRs/xo1W2/xzV5n/2ik/nz/dQrWdymDqEZ
	R8XHrmBdkoEnHg3n+Ms+4bDYty28LZSCxluABprDWWOVi8dwyqi+fqo2klaSWGRzXFOE=;
Received: from p54ae9e7b.dip0.t-ipconnect.de ([84.174.158.123] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rYq3X-00Cj6b-3n; Sat, 10 Feb 2024 17:18:19 +0100
Message-ID: <960efcac-0995-4a42-b90c-3e66c0f56762@nbd.name>
Date: Sat, 10 Feb 2024 17:18:18 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] mac80211: add AQL support for broadcast packets
Content-Language: en-US
To: =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@kernel.org>,
 linux-wireless@vger.kernel.org
Cc: johannes@sipsolutions.net
References: <20240209184730.69589-1-nbd@nbd.name> <87plx4s71y.fsf@toke.dk>
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
In-Reply-To: <87plx4s71y.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 10.02.24 15:55, Toke Høiland-Jørgensen wrote:
> Felix Fietkau <nbd@nbd.name> writes:
> 
>> Excessive broadcast traffic with little competing unicast traffic can easily
>> flood hardware queues, leading to throughput issues. Additionally, filling
>> the hardware queues with too many packets breaks FQ for broadcast data.
>> Fix this by enabling AQL for broadcast packets.
>>
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>  include/net/cfg80211.h     |  1 +
>>  net/mac80211/debugfs.c     | 19 +++++++++++++++----
>>  net/mac80211/ieee80211_i.h |  2 ++
>>  net/mac80211/main.c        |  1 +
>>  net/mac80211/sta_info.c    | 21 ++++++++++-----------
>>  net/mac80211/tx.c          | 14 +++++++-------
>>  6 files changed, 36 insertions(+), 22 deletions(-)
>>
>> diff --git a/include/net/cfg80211.h b/include/net/cfg80211.h
>> index a499bd7e1def..2f280c629aea 100644
>> --- a/include/net/cfg80211.h
>> +++ b/include/net/cfg80211.h
>> @@ -3385,6 +3385,7 @@ enum wiphy_params_flags {
>>  /* The per TXQ device queue limit in airtime */
>>  #define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L	5000
>>  #define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H	12000
>> +#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_BC	50000
> 
> How did you arrive at the 50 ms figure for the limit on broadcast
> traffic? Seems like quite a lot? Did you experiment with different
> values?

Whenever a client is connected and in powersave mode, all multicast 
packets are buffered and sent after the beacon. Because of that I 
decided to use half of a default beacon interval.

- Felix

