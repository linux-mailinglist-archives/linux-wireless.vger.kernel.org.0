Return-Path: <linux-wireless+bounces-8862-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0B26190524D
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 14:22:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 178291C20EA9
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 12:22:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0054716F0E8;
	Wed, 12 Jun 2024 12:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="a46BL3wH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3245374D3
	for <linux-wireless@vger.kernel.org>; Wed, 12 Jun 2024 12:21:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718194905; cv=none; b=FE3+sRzrqfasG9j/XnGx4MFaA4C22sS5cwnJG9qv2i3uxRE/UFuHtveBjGfswEW0Mi9tbvxVYeq3xE6No0R38I0XOZ4PTOGVZqlaTpy0aTCq/7sF47rZu7jKH/huekc9oEeTF5Vt1LAMjASmMKEs8hlU4Ivx3woQNGLfXauxDoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718194905; c=relaxed/simple;
	bh=QaEknUqYgvewQQ7tmkOpWp/HOhIINbM4ayCjXHW5vQo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=F+0q+hmvBe3gV1Xb2/3RRNLhxHaAT55nYTQo0APH7/xfI3OrD4Nv1ChWX0l1p6N2Z3hUcXBLvhV3EPeU9hsRNrSa5VOvGU0us98qSfWD+zhyrmzaPlih42LLlgTQd8ipZ8AQM4+/HDttic7BIZTX/FsuA12KOvu2umwy9pefmEQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=a46BL3wH; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=hzrc9Fovnr22Aow7tfPfZWXbpnrzvkkkMfDm1YahJfY=; b=a46BL3wHuE1TpqRyZ4DzTJWHoa
	WIjArBZ3kTmur14OZpQH4f+GbA6XxUGxgsroBQajBlsrIw4TqEm+rIsQUfCJQHyDraTSN13YnHplM
	ixmG8cIzwgHBPIAH5UxuiiI7nmwyU82Hhdri7yt4yX+YCJzGtEW0q6u3GSHrOuHOwK2Q=;
Received: from p4ff13dca.dip0.t-ipconnect.de ([79.241.61.202] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1sHMys-00Aq6n-0A;
	Wed, 12 Jun 2024 14:21:34 +0200
Message-ID: <91704e4c-b43c-4efc-b78d-e67abc35128d@nbd.name>
Date: Wed, 12 Jun 2024 14:21:24 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC v3 6/8] wifi: mac80211: extend ifcomb check functions for
 multi-radio
To: Johannes Berg <johannes@sipsolutions.net>,
 Karthikeyan Periyasamy <quic_periyasa@quicinc.com>,
 linux-wireless@vger.kernel.org
Cc: quic_adisi@quicinc.com, ath12k@lists.infradead.org
References: <cover.386a66ec6a89750d4890f63f0d28582a52b838b5.1717696995.git-series.nbd@nbd.name>
 <bc603fc671010bb720e75881ef0e22d81ec6e2eb.1717696995.git-series.nbd@nbd.name>
 <a337de2e-fe3e-18ed-b55b-9ea2cd21baed@quicinc.com>
 <1f32cb6c-6be8-4e3d-8e8f-2d3c728875a9@nbd.name>
 <479752f5-221d-746b-7513-ba27ef547ac1@quicinc.com>
 <096940e3-713a-4533-ab0f-e82bd647e205@nbd.name>
 <fa7c2aeef854f89eeb03a01a21a8d511417c92b6.camel@sipsolutions.net>
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
In-Reply-To: <fa7c2aeef854f89eeb03a01a21a8d511417c92b6.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12.06.24 14:05, Johannes Berg wrote:
> On Fri, 2024-06-07 at 13:04 +0200, Felix Fietkau wrote:
>> > > 
>> > > Use the sum of the number of interfaces from each radio instead of the 
>> > > maximum.
>> > 
>> > Oh, then legacy user have misconception of the global interfaces
>> > advertised and try to fail for the allowed limits.
>> 
>> Sure, but that might be an issue either way until user space is updated 
>> and users start looking at the per-radio ifcomb data.
> 
> I'm kind of with Karthikeyan here - this could be understood as a
> regression, since you're now telling userspace something you can't
> actually do.

Well, we can actually do it, just with some extra restrictions - i.e. 
the interfaces we create need to be spread across radios to match the 
per-radio limits.

>> The global data is simply not enough to describe the details of the 
>> radio split.
> 
> Obviously, but that doesn't mean the global data as advertised in the
> existing attributes must be *wrong*. It could be a subset, and the
> superset data is only available to new implementations.
So you'd prefer something like picking one radio and advertising its 
limits instead?

- Felix

