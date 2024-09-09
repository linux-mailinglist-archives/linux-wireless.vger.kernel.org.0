Return-Path: <linux-wireless+bounces-12676-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CC700971D04
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 16:47:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5E9CF1F23E5A
	for <lists+linux-wireless@lfdr.de>; Mon,  9 Sep 2024 14:47:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B41611BB6A3;
	Mon,  9 Sep 2024 14:47:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="tnaY9OlZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8EC1BB693;
	Mon,  9 Sep 2024 14:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725893229; cv=none; b=Q+uG+cjFP1RNp+I0VB/w7DKh83EKf5rh8b4hfDulUezB+4oCCsDRBzEKtSOThltAhG1t03B9tXlbkcuPnblBTSKlNN+eRf3g4pAuvAIPyb8s1lXYe0lsYslQcI/LeErm+6qV+YwZhzK2rxggojAAPWKm1AHmM8HwCjURqO8KVh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725893229; c=relaxed/simple;
	bh=9Gzbd2dG7QoWiV64goAdZCW+tIhQU1T6aetWtNSDzOU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rk50gTMluv3u5kbn7bsOsG3EKXZ+aExk2Rx4l0Qb41qltGMvbonMHlhjAi/7skUof+15SBhzUYP9At1Icqk5B1xUZsS5Rb5u0stY1GE9HVhsP6tIQ23So71DxzI/e+BNqV4j5ZVpE9jK26h+voK+2hh9NqzRR7/hIg7EHETIF5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=tnaY9OlZ; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id B465B88D1F;
	Mon,  9 Sep 2024 16:47:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725893226;
	bh=abEgI6y3lahDLU8egHHKB/x2ZmdtIf5ahawR2erK5c4=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=tnaY9OlZF84mOXfmjX4mIubXPW2W+5c9lpc5hwKKWvDd7hUmwsYFAiJNJM4fgSnTY
	 S80+7dRHSZMuLMQVsl4hHIpiSUhltSt2Gl//KdJMB9YD4TEMBT2TCkdr5GbwFu5iev
	 hywxBlrkSDTqQ+ydk7LqVLHRuDv71sw3+/mJ8P3A0f/oJ1isam9mG/ytN7zE/4oOu4
	 d/c6jyRlOjbhPr0ACSxaIX5prfXec+QIVY/6XavzkQKJbeNjzP12dF+RyYmel43XtO
	 roU/tb7JOZAi3VcG3FqemkGLTfhmmmskVgCd82Fa8phyHKRK1+CjLFnY+69DyrJQXZ
	 OB6BoyH6KrunA==
Message-ID: <343a45a8-1891-4e66-a77c-ad6e4d485903@denx.de>
Date: Mon, 9 Sep 2024 16:46:18 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 5/5] wifi: wilc1000: Add WILC3000 support
To: Kalle Valo <kvalo@kernel.org>
Cc: linux-wireless@vger.kernel.org, Ajay Singh <ajay.kathat@microchip.com>,
 "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Paolo Abeni <pabeni@redhat.com>, Rob Herring <robh@kernel.org>,
 devicetree@vger.kernel.org, netdev@vger.kernel.org
References: <20240829004510.178016-1-marex@denx.de>
 <20240829004510.178016-5-marex@denx.de> <87ed5tgofh.fsf@kernel.org>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <87ed5tgofh.fsf@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/9/24 11:35 AM, Kalle Valo wrote:
> Marek Vasut <marex@denx.de> writes:
> 
>> From: Ajay Singh <ajay.kathat@microchip.com>
>>
>> Add support for the WILC3000 chip. The chip is similar to WILC1000,
>> except that the register layout is slightly different and it does
>> not support WPA3/SAE.
>>
>> Signed-off-by: Ajay Singh <ajay.kathat@microchip.com>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> [...]
> 
>> --- a/drivers/net/wireless/microchip/wilc1000/cfg80211.c
>> +++ b/drivers/net/wireless/microchip/wilc1000/cfg80211.c
>> @@ -313,6 +313,13 @@ static int connect(struct wiphy *wiphy, struct net_device *dev,
>>   
>>   	vif->connecting = true;
>>   
>> +	if (sme->auth_type == NL80211_AUTHTYPE_SAE &&
>> +	    is_wilc3000(vif->wilc->chipid)) {
>> +		netdev_err(dev, "WILC3000: WPA3 not supported\n");
>> +		ret = -EOPNOTSUPP;
>> +		goto out_error;
>> +	}
> 
> This looks wrong. If wilc3000 doesn't support SAE you shouldn't
> advertise NL80211_FEATURE_SAE to user space. I think the check for
> wilc3000 should be in wilc_create_wiphy():
> 
> if (!is_wilc3000(vif->wilc->chipid))

It is probably better to do "if (is_wilc1000(wl->chipid))" here. This 
way, fixed in V5, thanks.

> 	wiphy->features |= NL80211_FEATURE_SAE;


