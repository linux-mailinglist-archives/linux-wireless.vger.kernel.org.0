Return-Path: <linux-wireless+bounces-4961-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E80D880E6E
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 10:19:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0939B2817B0
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Mar 2024 09:19:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C37A839FEB;
	Wed, 20 Mar 2024 09:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="bSaP2QKG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2615439FD0
	for <linux-wireless@vger.kernel.org>; Wed, 20 Mar 2024 09:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710926352; cv=none; b=rNzSv5FLWhGA8+jGn0eVj9yzaClzYQ9A4ckg0KRx0mpwWj26E8c3x18x1epr/A02WJ2kH6C8XExf0XJWg7rvMUklIfUcV9QGZbgGGLgrQHhDCRX/39IKz+Q7CI2rE66T2I6tjAnP7VhO5HpTXtpSJ/4lSD11fEGFlcGP0rrwRyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710926352; c=relaxed/simple;
	bh=em2RJXHqfyjhgUPTOEsGAvznJ7MyjC3TW3MFgio8ZPk=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=ClmAxB4UKClPR+JrEcjUt4KHN9XtjPt0wF/mq83zRoySkcvAtqlG7cLUyK5VhasufUiNUOEHG/rhnOWtJhabpqBspe7+p1EbKbA3RgSBn4p5HXVGKX93MYAbvWTUoBFw3S6jrecvJbRmX7raSxTIxj9rDBHQYCtvnBoLUIrdv4s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=bSaP2QKG; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=D12QRKshMlk2EQq6CUq3PzchKGk4Pf/Ssh/VBZ69JEI=; b=bSaP2QKGscDYfPl0JQ4TKyG9HM
	KsGLptqsuhrrgqn9FjQira/TdhJE8K7/FXdq9obOVU65wOFxDaQ9EQVFvDqSt7O8B8ERWdVEtgmPh
	85T4fO9Y3/Ygz+0NA0l16SK1aaAFtHApQu12r7uGFRqH4wvc4BGV+zbldruiswVx9ENk=;
Received: from p54ae9e7b.dip0.t-ipconnect.de ([84.174.158.123] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.94.2)
	(envelope-from <nbd@nbd.name>)
	id 1rms66-007cMc-93; Wed, 20 Mar 2024 10:18:58 +0100
Message-ID: <69f0cd9d-79de-4497-a964-07c981ac1a6f@nbd.name>
Date: Wed, 20 Mar 2024 10:18:57 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: mt76: mt7915: workaround too long expansion sparse
 warnings
Content-Language: en-US
To: Lorenzo Bianconi <lorenzo@kernel.org>, Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, lorenzo.bianconi@redhat.com,
 shayne.chen@mediatek.com, ryder.lee@mediatek.com
References: <5457b92e41909dd75ab3db7a0e9ec372b917a386.1710858172.git.lorenzo@kernel.org>
 <87h6h12rrg.fsf@kernel.org> <Zfqo0I3CpWE6tHTh@lore-desk>
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
In-Reply-To: <Zfqo0I3CpWE6tHTh@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 20.03.24 10:13, Lorenzo Bianconi wrote:
>> Lorenzo Bianconi <lorenzo@kernel.org> writes:
>> 
>> > Fix the following sparse warnings:
>> >
>> > drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29: error: too long token expansion
>> > drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29: error: too long token expansion
>> > drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29: error: too long token expansion
>> > drivers/net/wireless/mediatek/mt76/mt7915/debugfs.c:1133:29: error: too long token expansion
>> >
>> > No functional changes, compile tested only.
>> >
>> > Fixes: e3296759f347 ("wifi: mt76: mt7915: enable per bandwidth power limit support")
>> > Signed-off-by: Lorenzo Bianconi <lorenzo@kernel.org>
>> 
>> Thanks Lorenzo! Could I take this directly to wireless-next? We are very
>> close of being sparse clean in the wireless subsystem, there are just
>> few warnings left ath drivers.
> 
> sure, I am fine with it.
> @Felix?
Sure.
Acked-by: Felix Fietkau <nbd@nbd.name>

- Felix


