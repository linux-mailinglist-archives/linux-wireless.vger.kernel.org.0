Return-Path: <linux-wireless+bounces-10203-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D8E3892F6B3
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 10:08:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 92178282AD1
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Jul 2024 08:08:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3136F3EA71;
	Fri, 12 Jul 2024 08:08:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="seffB5Di"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7044B1C2E
	for <linux-wireless@vger.kernel.org>; Fri, 12 Jul 2024 08:08:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720771696; cv=none; b=VENTpjmI5QtDRdOH2GA/il6oNbQIjdTWzMv2bjM3fReMwhAc6CJLeMuIXGX3YICRCAgAQeeD+Y8GpPkYICS22dn0XCJ2nuRay2QK6GlketiW6OL7ijp/IIgE5KxpycqJTy0KIJNcrgXwoyAplSvUQq/mp1aRFftr8NunTsG7UQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720771696; c=relaxed/simple;
	bh=BmA7vCAWYw6bUgxqhHzPuNp0MhFSZ8ACUtZ6582tL0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=X2PDywbaJDdQWHYnYZhfqMrGJZ48nH0xZBjfXxuggOHX0PqdpkXU3ZjXOLsCaTDyidP5mZ+uT20kPo9xxQKTGofM+mq2GQAAKs0BTRwRjklnMcrkdtsYK+Brk8lpBO2/lqxx4ynKUGu/W5CQ55dps+vQliIJYC1HIRiQt0oPHqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=seffB5Di; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=lNdwKoOTKXOlt1ukDSjeUdr7nsC1ocojNWmFClFGV8Q=; b=seffB5Di/CPW5Uw23/L1jJv9XI
	Fu9JJJyJUtxFvrN9IJuVlATBqMZVAo9htYdEMzYzhDfyTMkcB7r8B4b68PqNE6PzWpr3XOVds2Cm4
	JykDByaZJPh2HC0/P4mnUPQ1/J2qeML8Jz0Gf+1CcpYcg760pgBWrLSXPafNhwSJKGCE=;
Received: from [2a01:599:113:53fc:e4:139f:ce36:fd98] (helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sSBK7-0066v2-1A;
	Fri, 12 Jul 2024 10:08:11 +0200
Message-ID: <1df0c5cc-ce58-450e-9f91-7f8f599cb11d@nbd.name>
Date: Fri, 12 Jul 2024 10:08:10 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [REGRESSION] ath10k: failed to flush transmit queue
To: Cedric Veilleux <veilleux.cedric@gmail.com>,
 linux-wireless@vger.kernel.org
References: <CA+Xfe4FjUmzM5mvPxGbpJsF3SvSdE5_wgxvgFJ0bsdrKODVXCQ@mail.gmail.com>
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
In-Reply-To: <CA+Xfe4FjUmzM5mvPxGbpJsF3SvSdE5_wgxvgFJ0bsdrKODVXCQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.07.24 04:23, Cedric Veilleux wrote:
> AP mode.
> Both 2.4 and 5ghz channels.
> 
> Using WLE600VX (QCA986x/988x), we are seeing the following errors in
> kernel logs:
> 
> [12978.022077] ath10k_pci 0000:04:00.0: failed to flush transmit queue
> (skip 0 ar-state 1): 0
> [13343.069189] ath10k_pci 0000:04:00.0: failed to flush transmit queue
> (skip 0 ar-state 1): 0
> 
> They are somewhat random but frequent. Can happen once a day or many
> times per hour.
> 
> They are associated with 3-4 seconds of radio silence. Full packet
> loss. Then everything resumes normally, STA are still associated and
> traffic resumes.
> 
> I have tested with major kernel versions:
> 
> 6.1.97: stable (tested for many days on 10+ access points)
> 6.2.16: stable (tested for few hours single machine)
> 6.3.13: stable (tested for few hours single machine)
> 
> 6.4.16: unstable  (we have errors within an hour)
> 6.5.13: unstable  (we have errors within an hour)
> 6.6.39: unstable  (we have errors within an hour)
> 6.7.12: unstable  (we have errors within an hour)
> 6.8.10: unstable  (we have errors within an hour)
> 6.9.7: unstable  (we have errors within an hour)
> 
>  From these tests I believe something changed in 6.4 series causing
> instabilities and the dreaded "failed to flush transmit queue" error.
> 
> This is a custom linux distribution. Only change is the kernel. All
> other packages are same versions. Everything rebuilt from source using
> bitbake/yocto. Same linux-firmware files.

I'm pretty sure it's caused by this commit:

commit 0b75a1b1e42e07ae84e3a11d2368b418546e2bec
Author: Johannes Berg <johannes.berg@intel.com>
Date:   Fri Mar 31 16:59:16 2023 +0200

     wifi: mac80211: flush queues on STA removal

I guess somebody needs to look into making the queue flush on ath10k 
more reliable (or even better, implement a more lightweight .flush_sta op).

I don't have time to do the work myself, but hopefully this information 
could help somebody else take care of it.

- Felix

