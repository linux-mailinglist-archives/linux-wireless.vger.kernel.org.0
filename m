Return-Path: <linux-wireless+bounces-11101-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id D35B394B0DE
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 22:05:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 805C31F2243C
	for <lists+linux-wireless@lfdr.de>; Wed,  7 Aug 2024 20:05:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E955140360;
	Wed,  7 Aug 2024 20:05:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="JDa6RM+U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C97682499
	for <linux-wireless@vger.kernel.org>; Wed,  7 Aug 2024 20:05:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723061107; cv=none; b=U7uNB9GSCh0B93oOxCsMAgiCTvX2Xajj5/C1yZ9AxA7vbQA6HMpmz6dcg9a/u9OjMjySWHRMzEMRiVqn3FUWaVZv+uyNqU/WGnEB0FaeKno2EyzYukgvHWwk1hlY75BYz7U8n3YRRMuBG8rYClHziXeIHHHk2yjTXn20OmfPaIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723061107; c=relaxed/simple;
	bh=nKEowuotCuFB7E6gl+Wr20JILyM82UQjHosFm2rwJTg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YrJsu+Pjf6AhBIAA0OyWxfZO62nvRMjQwggDSsMv6m+fo8FDHn/07HZ4JVvsv8MMjLCoharPlCKjvWhV5rLLboA6yeG54/sJcA5A3EVQmN65fLypjr3xxn9GTawydgcdcNcj/I5GpPR259qjGN7UrjLvSqRXwu/CuqWd9G8vwA0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=JDa6RM+U; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=WOIoBEroxHkkqt6CADohIw9Qujlr4yaBxbfPgpuV5x0=; b=JDa6RM+U9KmIjEnD/OXXFlNKhE
	iH83CERZJ9RTYT85zY791CHyBh/Y3KUV5VHVeCk/KHvVRxz2qmyLjXE2eWkqJZ7JVhsV/Q+bpsVIr
	+VMuJnmIwhbrnK/7ZW+emAyNuedI66Dps/lNwfGD2/IRQH36T0APDyeH3HlchVPCs+O4=;
Received: from p54ae9b72.dip0.t-ipconnect.de ([84.174.155.114] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sbmu4-00ErnA-2n;
	Wed, 07 Aug 2024 22:05:00 +0200
Message-ID: <5dfa4b5a-d8eb-42a8-92bb-81e713fe3395@nbd.name>
Date: Wed, 7 Aug 2024 22:05:00 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] net: ath9k: use devm for request_irq
To: Rosen Penev <rosenp@gmail.com>
Cc: linux-wireless@vger.kernel.org
References: <20240731210243.7467-1-rosenp@gmail.com>
 <201f06b6-14f5-41bb-8897-49665cf14b66@nbd.name>
 <CAKxU2N9r3Y=Z+rtPbCteWA8-5fRb2NTy2e4xG+=7JvhtzHPg7A@mail.gmail.com>
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
In-Reply-To: <CAKxU2N9r3Y=Z+rtPbCteWA8-5fRb2NTy2e4xG+=7JvhtzHPg7A@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 07.08.24 20:52, Rosen Penev wrote:
> On Wed, Aug 7, 2024 at 10:47 AM Felix Fietkau <nbd@nbd.name> wrote:
>>
>> On 31.07.24 23:02, Rosen Penev wrote:
>> > Avoids having to manually call free_irq. Simplifies code slightly.
>> >
>> > Signed-off-by: Rosen Penev <rosenp@gmail.com>
>> > ---
>> >   drivers/net/wireless/ath/ath9k/ahb.c | 7 ++-----
>> >   drivers/net/wireless/ath/ath9k/pci.c | 9 +++------
>> >   2 files changed, 5 insertions(+), 11 deletions(-)
>> >
>> > diff --git a/drivers/net/wireless/ath/ath9k/ahb.c b/drivers/net/wireless/ath/ath9k/ahb.c
>> > index 1a6697b6e3b4..29f67ded8fe2 100644
>> > --- a/drivers/net/wireless/ath/ath9k/ahb.c
>> > +++ b/drivers/net/wireless/ath/ath9k/ahb.c
>> > @@ -118,7 +118,7 @@ static int ath_ahb_probe(struct platform_device *pdev)
>> >       sc->mem = mem;
>> >       sc->irq = irq;
>> >
>> > -     ret = request_irq(irq, ath_isr, IRQF_SHARED, "ath9k", sc);
>> > +     ret = devm_request_irq(&pdev->dev, irq, ath_isr, IRQF_SHARED, "ath9k", sc);
>> Sorry for the late response, but I think this patch is wrong any may
>> need to be reverted. If there is an error during probe, and the IRQ
>> fires for some reason, there could be an use-after-free bug when the IRQ
>> handler accesses the data in sc.
>> The explicit freq_irq calls were preventing that from happening.
> How about keeping the devm variant and replacing free_irq with
> devm_free_irq in probe?

If you do that, then using the devm variant is completely pointless.
I think a full revert is the best option.

- Felix

