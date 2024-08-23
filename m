Return-Path: <linux-wireless+bounces-11862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 99C9995D346
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 18:27:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 517E11F22D80
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 16:27:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 76EF718A6DA;
	Fri, 23 Aug 2024 16:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="dKECRRz+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B05FC189BB0
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 16:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724430431; cv=none; b=czDZ+tW3tbZi6uhwFgwtSlWZ9BJB9LB2RtVoCXsHf0LZcWfKPjWmPpdXXwkziX+FNCI/4Q/Mez6DX2HEVZu7LfvHRwDH2rjTinrPTrUoWOLdxOdacLh7w7qW893vhmZ843Y/FtNlt2gMFjCIpoxCssGgQ1tynQByIYVDe8qcuVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724430431; c=relaxed/simple;
	bh=7txJCgXr8M8RW1xwXG3tyAyHH++bSs+o00/Uvn2qa9A=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=oHew8w2P9t/UUSHXGIofXRkIHP7w9kZz/L7XqFKxz80EvNMFwTEXR4/y4pN4YdZ7IOuzL1hinYm0nL8DQrGiVMUIS24YmGxHfc/mDxgiV/nvZdLDYl6WdXnoZDJ/xnmT8djG2ZzQ5ni6tRFIuf8abMifs9EJ56FDylysJ6zvz6g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=dKECRRz+; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=KU9BG5EiOh1ZffUAkK+fySmga88MRqIkxbEW6Yt9Gq0=; b=dKECRRz+qO2T2dt5zYqBgltFM4
	BuNgeqMXsbnDXl2sJ74J/dl7jt8WFZgHrcZmzRABIX65goHulARx09eeuoDXEDlCX2k6AEAswhrKf
	hEX3XFj/qtomcQH51ugSJVoMSDJHW73K+eE+YUvV1PrWYc6X+V/u1bLINBGe1EU23i9o=;
Received: from p4ff13de3.dip0.t-ipconnect.de ([79.241.61.227] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1shX7s-002zdM-0M;
	Fri, 23 Aug 2024 18:27:00 +0200
Message-ID: <4193632b-7eca-4dcb-b40a-982b3bf7705d@nbd.name>
Date: Fri, 23 Aug 2024 18:26:59 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC 5/6] wifi: mac80211: support per-radio filter flags
To: Johannes Berg <johannes@sipsolutions.net>, linux-wireless@vger.kernel.org
References: <cover.c32cfe64c671566c111b1b7ea426dbd1e8f2c568.1722885720.git-series.nbd@nbd.name>
 <7a871d4d2ce7adafb14cf971c1fdeb9cd01a4169.1722885720.git-series.nbd@nbd.name>
 <163ebbf7c79d6aece2744be84d88264555f352e9.camel@sipsolutions.net>
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
In-Reply-To: <163ebbf7c79d6aece2744be84d88264555f352e9.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.08.24 12:20, Johannes Berg wrote:
> On Mon, 2024-08-05 at 21:23 +0200, Felix Fietkau wrote:
>> This allows drivers to improve filtering of unwanted packets when using
>> different combinations of filter/monitor settings on radios.
>> 
> 
> Here, it would seem to make more sense to simply give the necessary per-
> interface information to the driver? Drivers likely have more
> restrictions and will need less complex data structures (or just
> iteration) to figure out what's eventually needed for each hw etc.
> 
> Some drivers might anyway even have different filters per interface,
> even if they're operating on the same channel.

I can do that as well. However, I do think it makes sense to have 
per-radio tracking in mac80211 as well, because I'm pretty sure that not 
just mt76, but ath12k would also be able to make use of this.

- Felix

