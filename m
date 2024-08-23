Return-Path: <linux-wireless+bounces-11871-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EAA9295D558
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 20:35:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 960DA1F23430
	for <lists+linux-wireless@lfdr.de>; Fri, 23 Aug 2024 18:35:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D2FFD1891AE;
	Fri, 23 Aug 2024 18:35:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="rLRmLlWL"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 601FB757F3
	for <linux-wireless@vger.kernel.org>; Fri, 23 Aug 2024 18:35:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724438135; cv=none; b=gnDTOS/75H/1ga4kdKOfzkY/KG4UrZyTqwrnrPkZzU2+VmKTOdsyionIBsPIpUz6F5stT/CHtjlbNEjHtk1yoJ6t5DNermJb85oouL/YMz5Qdiz38xdxXotic56MOSsHpP2R+xD4qJdX43QdP5pkk0k372Ep7G74OHIm5Knb9II=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724438135; c=relaxed/simple;
	bh=XTCpNrJwI/fhD3G8ivAEDw00jJJSBHLO71RHDfhAlXU=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=R/23Uq1vLIoQq8ddBv8TFyrn4xU9JnBjMwZT/QE4kuRqj56mMLEQ983URYsb7aLatgj3CCaihAfTZjhASkyNqFVUPCZKPTAMRdzjd+yzjRjvk4KcoHV+ybZsbVij+Gjc6xYROd30pXDda/ohaYbmBiGHfNVm7V2DvZPfB6/Qrss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=rLRmLlWL; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=EvHG7re4eP7BoVseew6M6ICc4f9rp7q5q2uK+euPKuQ=; b=rLRmLlWL7bVarfMoINe8rVjbgy
	743oIRwk7jz2YVJFnkX6U3wbCdsc/G/SpI/NILLUZSTzSkywT3rySI5KqbajY1CeY9GtGAaK6hm0a
	SOv+tQEPgKhyqcM8+kXziwwpWMGGjpvW0KS/8mhgd3n4vjy3NZYuXT9JOpLdge9h2Yxs=;
Received: from p4ff13de3.dip0.t-ipconnect.de ([79.241.61.227] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1shZ8E-00328G-2B;
	Fri, 23 Aug 2024 20:35:30 +0200
Message-ID: <2bd95a7e-c963-4991-ac22-8c9a62dcddf6@nbd.name>
Date: Fri, 23 Aug 2024 20:35:30 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 15/16] wifi: mt76: mt7915: reset the device after MCU
 timeout
To: Ben Greear <greearb@candelatech.com>, linux-wireless@vger.kernel.org
References: <20240816173529.17873-1-nbd@nbd.name>
 <20240816173529.17873-15-nbd@nbd.name>
 <5d8f8702-4804-6fd0-76bf-6d5d0fa5d312@candelatech.com>
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
In-Reply-To: <5d8f8702-4804-6fd0-76bf-6d5d0fa5d312@candelatech.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 23.08.24 20:32, Ben Greear wrote:
> On 8/16/24 10:35, Felix Fietkau wrote:
>> On MT7915, MCU hangs do not trigger watchdog interrupts, so they can only
>> be detected through MCU message timeouts. Ensure that the hardware gets
>> restarted when that happens in order to prevent a permanent stuck state.
> 
> We applied this to our hacked upon 6.10 kernel, and this patch appears
> to cause NPE down in debugfs file removal during radio restart.  We didn't investigate this
> closely, but removing this patch fixes the problem.
> 
> Also of note, we see the radio have a timeout, but then recover, often
> (without this patch).
> 
> Did you force/fake this situation to happen and see it actually work?

I found some issues in a few patches of this series in the last few days 
and will send v2 soon.

- Felix

