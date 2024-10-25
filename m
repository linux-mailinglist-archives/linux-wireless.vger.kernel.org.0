Return-Path: <linux-wireless+bounces-14564-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FA129B1180
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 23:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 59EB2286064
	for <lists+linux-wireless@lfdr.de>; Fri, 25 Oct 2024 21:11:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C14511D14FA;
	Fri, 25 Oct 2024 21:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="q2tRjDhc"
X-Original-To: linux-wireless@vger.kernel.org
Received: from omta040.useast.a.cloudfilter.net (omta040.useast.a.cloudfilter.net [44.202.169.39])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C3B918BB90
	for <linux-wireless@vger.kernel.org>; Fri, 25 Oct 2024 21:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=44.202.169.39
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729890617; cv=none; b=J/gPaW1zFZiSBjldhO7z40+c2wftTrAa9/u7bU9GmCOAIUGSgJsDTG8Nord+2s8jW5OmOmbeYHgMSOzdIIjC0MJFn9AQOx9AX0FAj4PbADlnrUTPVAkubBqfk4c/gUbdKZoaPXOatUVxd9sY5p5DIjRgvtgoQquEXYxHkPw5crc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729890617; c=relaxed/simple;
	bh=TPho4dkS6mrn6hTejdUWmg7ebeatab0pOXP++hksgOA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=KzvZl9f6gYPwvPpxRGpEtacXYtOF0GX1kBUGA42Cvp1dOmn4gFIfZBPONnbwfCIWxIz5+nhHrRm6SdwIGj3T6lH5b8uwYKyD5C6Dn/1nHmkMliPHN3HNmvH1qtdlhmM5aleKhrkpO00V7Ln9qMnmtb4jRFa5aTiVkjugvMA7M5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com; spf=pass smtp.mailfrom=embeddedor.com; dkim=pass (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b=q2tRjDhc; arc=none smtp.client-ip=44.202.169.39
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=embeddedor.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=embeddedor.com
Received: from eig-obgw-5004a.ext.cloudfilter.net ([10.0.29.221])
	by cmsmtp with ESMTPS
	id 4ObStlEolnNFG4RZWt2KLI; Fri, 25 Oct 2024 21:10:14 +0000
Received: from gator4166.hostgator.com ([108.167.133.22])
	by cmsmtp with ESMTPS
	id 4RZVt14EPWvXp4RZWtknSa; Fri, 25 Oct 2024 21:10:14 +0000
X-Authority-Analysis: v=2.4 cv=LtdZyWdc c=1 sm=1 tr=0 ts=671c0936
 a=1YbLdUo/zbTtOZ3uB5T3HA==:117 a=OKg9RQrQ6+Y1xAlsUndU0w==:17
 a=IkcTkHD0fZMA:10 a=DAUX931o1VcA:10 a=7T7KSl7uo7wA:10
 a=XVG_Zt8v1qosKg6nO_oA:9 a=QEXdDO2ut3YA:10 a=Xt_RvD8W3m28Mn_h3AK8:22
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=embeddedor.com; s=default; h=Content-Transfer-Encoding:Content-Type:
	In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
	List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=0isTUBLuyFlo6RiNDsF6WYPY4prLAUENxvha5GaK7rk=; b=q2tRjDhc517w0ph9oN1uUlCjaH
	TeOsyJryyQAhkFGSo9+/WWq2mSMgP8bQAH+Ed7zRcnGHbrJMlLZslK0ylIJDiSgIWAwWZoKkhuCSB
	gbXX5zIi1LvSzjPy2MwPaq7hSMAhO5DkR5n1M2FZOSXrlESrxyJ8CQk7KZtVBnB4hO/0D+V47FD1v
	UG6fd/j/Y4MV2YANPn71ZMdHX4FoJVX4m8V5GapAMEX7AlZLBeX1YYDaCY1Egj1MCfMB2s2kku86a
	6xawpK6Bi4m4birdVJY9oCGvL+RY/+L9Ryf2nev7z/3QBiAeO/Fxchm+wqhcvuG2y9wZw6WLkhg32
	XuKh20Kg==;
Received: from [201.172.173.7] (port=37432 helo=[192.168.15.6])
	by gator4166.hostgator.com with esmtpsa  (TLS1.2) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96.2)
	(envelope-from <gustavo@embeddedor.com>)
	id 1t4RZV-003ykj-07;
	Fri, 25 Oct 2024 16:10:13 -0500
Message-ID: <7e2745d9-f607-4b9b-87c6-0623708747ef@embeddedor.com>
Date: Fri, 25 Oct 2024 15:10:11 -0600
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
 <8152a551-1813-4d44-a203-45d30f2ac671@embeddedor.com>
 <192eb05afffd37bd13ff9bc1fc9b044b347b5dc4.camel@sipsolutions.net>
Content-Language: en-US
From: "Gustavo A. R. Silva" <gustavo@embeddedor.com>
In-Reply-To: <192eb05afffd37bd13ff9bc1fc9b044b347b5dc4.camel@sipsolutions.net>
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
X-Exim-ID: 1t4RZV-003ykj-07
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: ([192.168.15.6]) [201.172.173.7]:37432
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 4
X-Org: HG=hgshared;ORG=hostgator;
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
X-CMAE-Envelope: MS4xfGWlXNYY7IFqUnSgPpLvnDR/hlsPFxkx1T78QWL0VjUz3IRl92mJqnaxNpA7gvw3CMZP/C6smQdgPhuEFvijVzRkPuWGZpePZ95qkCtDExOSNVZKqt69
 T2Cvtwl1dcMvngNy1p3WxTlJeUMA9Zxl4VtR2kQFtFdtCwiQtVs3ejWNHBIn9Tgcw9PJXon4Oyr8E0nYdZfe+MKGtdPuNuHLW7jAybLUXDmGtnjyBc8mgAZ6



On 25/10/24 14:48, Johannes Berg wrote:
> On Fri, 2024-10-25 at 14:36 -0600, Gustavo A. R. Silva wrote:
>>>>
>>>> Yeah, I was actually going to mention this commit, as it's the one that introduced
>>>> that `bool radar_detected` to the flex struct. However, it wasn't obvious to me
>>>> how `struct ieee80211_chanctx_conf conf` could overwrite `radar_detected` as I didn't
>>>> see `conf->drv_priv` being accessed through `struct struct ieee80211_chanctx_conf`.
>>>
>>> You have to look at the drivers, see hwsim_clear_chanctx_magic() for
>>> example; I wonder why hwsim_check_chanctx_magic() never caught this.
>>
>> Sorry, I actually meant through `struct ieee80211_chanctx`. Something like:
>>
>> struct ieee80211_chanctx *foo;
>> ...
>>
>> foo->conf.drv_priv[i] = something;
>>
>> or
>>
>> struct bar *ptr = (void *)foo->conf->drv_priv;
>> then write something into *ptr...
>>
>> In the above cases the code will indeed overwrite `radar_detected`.
> 
> Right, that's what it does though, no? Except it doesn't have, in the
> driver, "foo->conf." because mac80211 only gives it a pointer to conf,
> so it's only "conf->drv_priv" (and it's the "struct bar" example.)

OK, so do you mean that pointer to `conf` is actually coming from
`foo->conf`?

This is probably a dumb question but, where is that pointer to `conf`
coming from exactly?

I'd really like to understand this better so I can determine whether
I'm dealing with a bug when analyzing similar instances in the future. :)

> 
> So yeah, pretty sure it will overwrite that, and I do wonder why it
> wasn't caught. I guess no radar detection tests with MLO yet.
> 

--
Gustavo

