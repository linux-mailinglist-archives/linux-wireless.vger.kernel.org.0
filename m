Return-Path: <linux-wireless+bounces-3441-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C82C78511E8
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 12:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 1C99DB2528B
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 11:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B79F3985A;
	Mon, 12 Feb 2024 11:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="XPzILHIK"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC6BA39843
	for <linux-wireless@vger.kernel.org>; Mon, 12 Feb 2024 11:10:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707736249; cv=none; b=eWsg5Ia5cy+M/C9cA7rjxRmwJBGu1OSCaeJYpHZvmg77P1RNMhPbA20hwJjm0/blqQeZIHBM9TlTqEeb0DCUCpbhfwneVp+B8r/gd9TchP7aW+JyylallOwHbRWEKztzoKA0T1D//eDUcbnaPLpkyG3u+F5c4aGbhVVbVRZ3ZhU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707736249; c=relaxed/simple;
	bh=NGnWiwxhpjpfmyVRMJZNjp3jBbDxcuF+uFBIZUnJ158=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=crrO+CH+CK34NyhUAaPe+9PlIifdDXe4V+odlElXLJlSgdvGg57TGyvdPnvRyXkVvDoCLO20h0YykS9iMrMAob4teMrFgtbAF5FrXbOR8/KtCif6pgTd9JbIDaQaYuhPQnOMdSTfu/YkiH1pB8d/u1q9hDcxQdiyzvMaWyFtVKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=XPzILHIK; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=jNorjfFOVrUo7QcHjI5HGT4DEOOwCwecd8bxfvHWMZI=; b=XPzILHIKub3UuFpYDO1GPWxjcN
	CN6sZ9ieiG7aH1a0/9vXLtDZH04T9UIzEgmaGlHHn8veJV3C+j6ER9e6+2tBWqwDD1IhMnn/R2ENI
	jxvp/SjKpK+/KNDn57udLx5dEC8heiwZcR57HGTKEZT6tuODZnIc/EjyeAitWCE7gGPg=;
Received: from p54ae9e7b.dip0.t-ipconnect.de ([84.174.158.123] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rZUCr-00D5iK-AX; Mon, 12 Feb 2024 12:10:37 +0100
Message-ID: <9922ecf9-d243-40a1-809b-9739d3269177@nbd.name>
Date: Mon, 12 Feb 2024 12:10:36 +0100
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
 Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <20240209184730.69589-1-nbd@nbd.name> <87plx4s71y.fsf@toke.dk>
 <960efcac-0995-4a42-b90c-3e66c0f56762@nbd.name>
 <66bddf2f6362c9f39f06e06c0c35b6900917b9bf.camel@sipsolutions.net>
 <87sf1yymr2.fsf@toke.dk>
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
In-Reply-To: <87sf1yymr2.fsf@toke.dk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 12.02.24 11:56, Toke Høiland-Jørgensen wrote:
> Johannes Berg <johannes@sipsolutions.net> writes:
> 
>> On Sat, 2024-02-10 at 17:18 +0100, Felix Fietkau wrote:
>>> 
>>> > > +++ b/include/net/cfg80211.h
>>> > > @@ -3385,6 +3385,7 @@ enum wiphy_params_flags {
>>> > >  /* The per TXQ device queue limit in airtime */
>>> > >  #define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_L	5000
>>> > >  #define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_H	12000
>>> > > +#define IEEE80211_DEFAULT_AQL_TXQ_LIMIT_BC	50000
>>> > 
>>> > How did you arrive at the 50 ms figure for the limit on broadcast
>>> > traffic? Seems like quite a lot? Did you experiment with different
>>> > values?
>>> 
>>> Whenever a client is connected and in powersave mode, all multicast 
>>> packets are buffered and sent after the beacon. Because of that I 
>>> decided to use half of a default beacon interval.
>>
>> That makes some sense, I guess.
> 
> This implies that we will allow enough data to be queued up in the
> hardware to spend half the next beacon interval just sending that
> broadcast data? Isn't that a bit much if the goal is to prevent
> broadcast from killing the network? What effect did you measure of this
> patch? :)

I didn't do any real measurements with this patch yet. How much 
broadcast data is actually sent after the beacon is still up to the 
driver/hardware, so depending on that, the limit might even be less than 
50ms. I also wanted to be conservative in limiting buffering in order to 
avoid potential regressions. While 50ms may seem like much, I believe it 
is still a significant improvement over the current state, which is 
unlimited.

> Also, as soon as something is actually transmitted, the kernel will
> start pushing more data into the HW from the queue in the host. So the
> HW queue limit shouldn't be set as "this is the maximum that should be
> transmitted in one go", but rather "this is the minimum time we need for
> the software stack to catch up and refill the queue before it runs
> empty". So from that perspective 50ms also seems a bit high?

When broadcast buffering is enabled, the driver/hardware typically 
prepares the set of packets to be transmitted before the beacon is sent. 
Any packet not ready by then will be sent in the next round.
I added the 50ms limit based on that assumption.

>> It does have me wondering though if we should also consider multicast
>> for airtime fairness in some way?
> 
> Yeah, that would make sense. The virtual time-based scheduler that we
> ended up reverting actually included airtime accounting for the
> multicast queue as well. I don't recall if there was any problem with
> that particular part of the change, or if it's just incidental that we
> got rid of it as part of the revert. But it may be worth revisiting and
> adding a similar mechanism to the round-robin scheduler...

The round-robin scheduler already has some consideration of multicast - 
it always puts the multicast queues last in the active_txqs list.

- Felix

