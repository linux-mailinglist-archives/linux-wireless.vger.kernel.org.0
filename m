Return-Path: <linux-wireless+bounces-20174-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B8A14A5C326
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 15:01:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5C8AF3B1215
	for <lists+linux-wireless@lfdr.de>; Tue, 11 Mar 2025 14:01:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AA8D31D5CCD;
	Tue, 11 Mar 2025 14:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b="AeVNu12C"
X-Original-To: linux-wireless@vger.kernel.org
Received: from nbd.name (nbd.name [46.4.11.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04DC017C9F1
	for <linux-wireless@vger.kernel.org>; Tue, 11 Mar 2025 14:01:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=46.4.11.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741701710; cv=none; b=mqUoakz597lTYIXHI5y0ckvItHiR6lXnNqlNuNluZxftVA3eSQk4ZjdTPyCi0SPV+T7pL95Nv9QZ7hhSUFdWB+kqApGfZgViv0ZqCAMd/xA9VACf3mWAN0qgMucBpYIg5qsrP50v6pmPxYQBcyRnsW3QJ9ijXqnww2A6S5IDP3g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741701710; c=relaxed/simple;
	bh=Qw4CoRviiYKOZOO9khZDIWIans0Dfgf9j0X4b0na5O0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=gK1/fzdftPrDXlFAwB2gkZZBRl0IGN4YG5b2Gi5DbkH70vn5m0btyYC6HINVSHkpyjIyDvlGGgz8WBWHhC2CdGkZXBjF/nsUWnBxTditQ7JhcuGmg9JxEs7zeIuK6DbJyoPF+HP1aZUW/J5mZt9GGcWn+OiK/wAdecJV5Svg9k0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name; spf=none smtp.mailfrom=nbd.name; dkim=pass (1024-bit key) header.d=nbd.name header.i=@nbd.name header.b=AeVNu12C; arc=none smtp.client-ip=46.4.11.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=nbd.name
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=nbd.name
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=nbd.name;
	s=20160729; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
	References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
	List-Subscribe:List-Post:List-Owner:List-Archive;
	bh=011AR5qv0LtJJXBnerso791Njw9MF3nJpAB/9bqMG68=; b=AeVNu12CtIuiF4OUjuIexl3VPA
	yFxWON3xU5VRvvVhteyXjIRlSbcd1/WhEgRKD/85aQQEAJDMAkhNzLOPSnn49vViiAQjzh3nQOzm0
	ZoRVff9wx4HLGc6a8KTy/HKfK1lcEOopc0O9xTPVnESBUQ5XytrLiRMKZqAt+Yx/ncTo=;
Received: from p5b206ef1.dip0.t-ipconnect.de ([91.32.110.241] helo=nf.local)
	by ds12 with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
	(Exim 4.96)
	(envelope-from <nbd@nbd.name>)
	id 1ts0Ax-00FwUn-1d;
	Tue, 11 Mar 2025 15:01:43 +0100
Message-ID: <5f23f3a1-afa3-4c68-bb42-fafc0c54d6d8@nbd.name>
Date: Tue, 11 Mar 2025 15:01:43 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 7/8] wifi: mt76: mt7996: implement driver specific
 get_txpower function
To: Lorenzo Bianconi <lorenzo@kernel.org>
Cc: linux-wireless@vger.kernel.org
References: <20250311103646.43346-1-nbd@nbd.name>
 <20250311103646.43346-7-nbd@nbd.name> <Z9BAyuc6SLkS25NY@lore-desk>
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
In-Reply-To: <Z9BAyuc6SLkS25NY@lore-desk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11.03.25 14:55, Lorenzo Bianconi wrote:
> On Mar 11, Felix Fietkau wrote:
>> Fixes reporting tx power for vifs that don't have a channel context
>> assigned. Report the tx power of a phy that is covered by the vif's
>> radio mask.
>> 
>> Signed-off-by: Felix Fietkau <nbd@nbd.name>
>> ---
>>  .../net/wireless/mediatek/mt76/mt7996/main.c  | 27 ++++++++++++++++++-
>>  1 file changed, 26 insertions(+), 1 deletion(-)
>> 
>> diff --git a/drivers/net/wireless/mediatek/mt76/mt7996/main.c b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
>> index 886b6ef3462b..89fc3f102555 100644
>> --- a/drivers/net/wireless/mediatek/mt76/mt7996/main.c
>> +++ b/drivers/net/wireless/mediatek/mt76/mt7996/main.c
>> @@ -602,6 +602,31 @@ static void mt7996_configure_filter(struct ieee80211_hw *hw,
>>  	mutex_unlock(&dev->mt76.mutex);
>>  }
>>  
>> +static int
>> +mt7996_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif, int *dbm)
> 
> I guess the signature here should be:
> 
> static int
> mt7996_get_txpower(struct ieee80211_hw *hw, struct ieee80211_vif *vif,
> 		   unsigned int link_id, int *dbm)
> {
> }

Will fix, thanks.

- Felix

