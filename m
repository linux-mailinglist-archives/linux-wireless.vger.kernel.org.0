Return-Path: <linux-wireless+bounces-12795-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B0FE99757C1
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 17:59:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D59751C20C22
	for <lists+linux-wireless@lfdr.de>; Wed, 11 Sep 2024 15:59:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 29EE219CC19;
	Wed, 11 Sep 2024 15:58:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="p2LqdTVE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19C0E187336
	for <linux-wireless@vger.kernel.org>; Wed, 11 Sep 2024 15:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726070339; cv=none; b=b11e3RBUsa/74umH+mIn9LMqk4Eh07kDTPZsI3E3sMtcTA/2hTmln/RtXo/ok8dwTAuBNpO+75BWiz6t2tdO265mR36OPZ37B/I9LBizIIS11aJ88VMvjxVXtH+EsLiEOmNZD+g5c1Kt4GJbn9NzgmeYWj4qCEWsdOr8KSuOcsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726070339; c=relaxed/simple;
	bh=NnJD86Sqc7lYWMH46bwTTTcoqr8vUSxhYUgZtrkXzyo=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=uIJmTH9hNQ4SHoUfwubu/zUtexq86+SIpwxhiR3jk0XlK8zuuuXBHy5F8mp7Mud2d/sA8Ac+Vg64/pSYuvHsZkJgE4Bo1CkmhYRl6Q74GBBmYjYTG4nkWt5xe1qMbCjHgn46GIcnEi0zDnCIDTcAhqmYdV9sKieoXPjwyAKWR9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=p2LqdTVE; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=TVieC2MG+ST9+nRpSQY/zbulurvtIQCUzuKx99+LG70=; b=p2LqdTVERzs/WxH9Navr+BZvHR
	Ec4Yg6ZTAZovMOFoEFeRRFny1lbujdboH62Atooo74KoO4W9rwxWsvKNQ2U9uOsm4hwd1DYXuHmpj
	3S3ZFZRB2vMUv8JP/MHj4r+ppw9uAmro0BYJ3LKWXevMGlV855JeLdPDC6WoedNf+bSw=;
Received: from p4ff1376f.dip0.t-ipconnect.de ([79.241.55.111] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1soPjw-00BrJi-1i;
	Wed, 11 Sep 2024 17:58:44 +0200
Message-ID: <3d2d9a9e-43ee-46f5-bf66-6227ce6bdfd7@nbd.name>
Date: Wed, 11 Sep 2024 17:58:42 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3] wifi: cfg80211: check radio iface combination for
 multi radio per wiphy
To: Johannes Berg <johannes@sipsolutions.net>,
 Karthikeyan Periyasamy <quic_periyasa@quicinc.com>
Cc: linux-wireless@vger.kernel.org
References: <20240904112928.2924508-1-quic_periyasa@quicinc.com>
 <e77b379d48db796d199030ce904f8ed44ed679e5.camel@sipsolutions.net>
 <b7769f15-b0ef-fb61-8622-fc8bdc7339cc@quicinc.com>
 <dfd252e8c553c5501eb97042325d9009be14faed.camel@sipsolutions.net>
 <0d800949-d43a-2172-6aa7-5d0069d3b88a@quicinc.com>
 <36d111a1118349a86946bfdbc55e8fcbf3720fbc.camel@sipsolutions.net>
 <a588beba-ddeb-445a-abff-cfb3f6a41a63@quicinc.com>
 <7ddb082fc1a1886f343e4c0233a24221932edb64.camel@sipsolutions.net>
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
In-Reply-To: <7ddb082fc1a1886f343e4c0233a24221932edb64.camel@sipsolutions.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.09.24 17:25, Johannes Berg wrote:
> On Wed, 2024-09-11 at 20:51 +0530, Karthikeyan Periyasamy wrote:
>> 
>> ieee80211_link_reserve_chanctx() calls 
>> ieee80211_can_create_new_chanctx() with radio_idx (-1) to calculate the 
>> max channel (ieee80211_max_num_channels) after the iface combination 
>> check (cfg80211_iter_combinations) passed for the global iface 
>> combination. Here the expectation is number of channel context is less 
>> than the number of different channel. So in multi-radio advertisement, 
>> each radio support atleast one channel, so totally multiple different 
>> channels advertised in the global iface combination to pass this 
>> ieee80211_max_num_channels().
> 
> So maybe that's broken then, I dunno. You should figure it out with
> Felix I guess.
> 
> The intent was, and clearly it has to be, that the global combinations
> are something that can be handled regardless of radio information, to be
> backward compatible with existing uses. Therefore, it cannot be
> something where you say two channels and radar detection on both because
> that would imply being able to use channels 36 and 40 with 20 MHz at the
> same time with radar detection, which isn't actually possible.
> In this case, the "two channels" is only possible with also two radios,
> which has to rely on the per-radio advertisement, and the global one has
> to be just one channel for radar detection.
> 
> We still need the part of the patch that calls the validation on each
> radio, but it shouldn't be different from the global one. If you could
> make that patch I'd appreciate it.

It's implemented the way we discussed it back when this topic came up. 
Legacy user space gets the ifcomb data from the first radio for 
compatibility. The actual global ifcomb data is reported in a new attribute.

- Felix

