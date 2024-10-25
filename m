Return-Path: <linux-wireless+bounces-14561-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF949B0FDA
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 22:37:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D86DD284811
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 20:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 99DC020D510;
	Fri, 25 Oct 2024 20:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="YbLWLt2A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta36.uswest2.a.cloudfilter.net (omta36.uswest2.a.cloudfilter.net [35.89.44.35])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BC4220C334
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 20:36:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=35.89.44.35
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729888619; cv=none; b=rS8XBOl/IzUvUtICat05ugTlv78grd6zTG0nMLv6OVYzLrvU3xmo6eiwKkupMkWQHO0Q38hDRbTJGauIkoxqchrr26nV91TRS8qRJuJ07OWha4ylgR5Wt6iubtlnX7CI8hmGrzh+PwTb7CCKbKtcZh38XtWXy8A6/Mt6SKecK6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729888619; c=relaxed/simple;
	bh=VYBMxqwXMgsrg2pZXoCn+GnZFEkdPmox795KfR3wPwU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oF6HQwklwB3/gx0aB3Qi8l34O2Ufu03fJdaSzvHRuArrP5rZL/28+4pXxuUN4Cu22IufXow71bby/oKDMoRfkcilDppUSQVuiVFgw9f20J6ohIwTumxcLcw4dQm6TuFdZUn3Vc1AQi8A9WRi+vX8q8x7M8ODRg1jF1FjKDAWT4M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=YbLWLt2A; arc=none smtp.client-ip=35.89.44.35
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5003a.ext.cloudfilter.net ([10.0.29.159])
	by cmsmtp with ESMTPS
	id 41sPtcakkqvuo4R3DtnL44; Fri, 25 Oct 2024 20:36:51 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 4R3CtG3yu827n4R3CtD3hY; Fri, 25 Oct 2024 20:36:50 +0000
X-Authority-Analysis: v=2.4 cv=GeTcnhXL c=1 sm=1 tr=0 ts=671c0162
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=OKg9RQrQ6+Y1xAlsUndU0w==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10
 a=mKMXtcfHHMa54xGqesAA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=JIXtr/smAzzJVTQu88p4I8Uobao1EUnmCUV2Vs4aLSk=; b=YbLWLt2AcymwsuUAefSHXuVCTB
	vrKsQUqqpC3r06IYYrhm9idH9+9y3q1dxDBNx5nV5fUArPfZg9GyE12pxw6cgy4nabpTpMKeMVde/
	Sr8gunywUdjLKywuR4Xzq9GTjbszGZ+aXkEgjJl2ufZOlTk6qlPGsYfs6EPxBY53LTlQ2JYTbOu9S
	FdIm1HfcxQRebDrYKWPldExzujXPwiMM8W+nNzGIQ7six1ZbQ0jgAaqxZEF8IMXEYcC1OxyODYULx
	BCF/njqB+9Z3B9iWUwqn5C2//LiokLfSxxJwrZwl83HKtXB/Fcf/LIsbh/DUVJYimZJ0AvWcNL7QS
	U30+SN4g==;
Received: from [201.172.173.7] (port=35774 helo=[192.168.15.6])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t4R3B-003Uaa-0P;
	Fri, 25 Oct 2024 15:36:49 -0500
Message-ID: <8152a551-1813-4d44-a203-45d30f2ac671@embeddedor.com>
Date: Fri, 25 Oct 2024 14:36:44 -0600
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
 <3471e59f-a414-479f-8fb0-aa1a26aecf16@embeddedor.com>
 <5c48b4529bf552d5c16b4dcc951c653f37b6a68e.camel@sipsolutions.net>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <5c48b4529bf552d5c16b4dcc951c653f37b6a68e.camel@sipsolutions.net>
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
X-Exim-ID: 1t4R3B-003Uaa-0P
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.6]) [201.172.173.7]:35774
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 10
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfFGHjqAHTiBm512np7Y0iePyMUAmdWCp2Jr6SVHT9YO9PiWp04z1zUUeUuWwl026AzN1q19jD+rLT+J4Kbyu+i95mmFr2OB2O6AYaDpP3HouXNc4/7av
 /WdjpwLPyPTqt5Vs4wd4URZcvhFnKPZ4DCFI9kt6JnSV1eZDRoSb2OWFoMlDBQTRRpBcG+K/h13i1QAsO+0wB5g/NFaC/L40/whx2mPXCQrBjggauViUSpjG



On 25/10/24 14:25, Johannes Berg wrote:
> On Fri, 2024-10-25 at 14:22 -0600, Gustavo A. R. Silva wrote:
>>
>>>> -	struct ieee80211_chanctx_conf conf;
>>>> -
>>>>    	bool radar_detected;
>>>> +
>>>> +	/* MUST be last - ends in a flexible-array member. */
>>>> +	struct ieee80211_chanctx_conf conf;
>>>>    };
>>>
>>> Oi. That's not just a warnings problem, that's actually a pretty stupid
>>> bug, this will surely get used and radar_detected will alias stuff that
>>> the driver puts there - at least for drivers using chanctx_data_size,
>>> which is a couple: ath9k, iwlmvm, mt792x, rwt89 and hwsim.
>>>
>>> Could you resend with a description that this is a bugfix and
>>>
>>> Fixes: bca8bc0399ac ("wifi: mac80211: handle ieee80211_radar_detected() for MLO")
>>
>> Yeah, I was actually going to mention this commit, as it's the one that introduced
>> that `bool radar_detected` to the flex struct. However, it wasn't obvious to me
>> how `struct ieee80211_chanctx_conf conf` could overwrite `radar_detected` as I didn't
>> see `conf->drv_priv` being accessed through `struct struct ieee80211_chanctx_conf`.
> 
> You have to look at the drivers, see hwsim_clear_chanctx_magic() for
> example; I wonder why hwsim_check_chanctx_magic() never caught this.

Sorry, I actually meant through `struct ieee80211_chanctx`. Something like:

struct ieee80211_chanctx *foo;
...

foo->conf.drv_priv[i] = something;

or

struct bar *ptr = (void *)foo->conf->drv_priv;
then write something into *ptr...

In the above cases the code will indeed overwrite `radar_detected`.

> 
>>> please? Or I can do it myself I guess, but ...
>>
>> Sure thing. I can CC stable as well.
> 
> Thanks!
> 
> No need for stable, it got introduced in 6.12-rc1 only.

OK

--
Gustavo

