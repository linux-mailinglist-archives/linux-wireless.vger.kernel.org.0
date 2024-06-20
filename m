Return-Path: <linux-wireless+bounces-9334-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BA8EB91117C
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 20:55:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6F8D21F2300E
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Jun 2024 18:55:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F2D921B5821;
	Thu, 20 Jun 2024 18:53:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b="Qbj4GV+q"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.smtpout.orange.fr (smtp-14.smtpout.orange.fr [80.12.242.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 702463A28D;
	Thu, 20 Jun 2024 18:53:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=80.12.242.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718909639; cv=none; b=TOczIeHG+SUYgyPeXiEV/8XUrLEO4uHDn7016DMuLlsmJXKyPhwlEuUCKOpq5UKUpc8KT1EhNVJEnjzAQhInF67INtsvtp42XmbSa2jdPzWHuaiWs+apR5ihLtiqC4JxkVk2aoylHaPYrGq+Zk5VNz1EZ9WX/ibelbWKBGfswmY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718909639; c=relaxed/simple;
	bh=8ekOjxpDwoydqkKkGhUeAltxKkAKYn/wprrJm0PBnH0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=J/LFJrXPxmTeP2rR/Z45bPK23Yi6FoqOosZbLflV8xFxjHf8l+1uFiNF/S/4R11EKTFPsH21IuSVcDYrPLRp4p2T+1PlgQIGJQa7ZA21SV5WZOQgfbO+MDusslTiEoJSik2Pm4j2d9bi9w4Z7uE2fOH+f72M1ccd+6VMj96p+Zk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr; spf=pass smtp.mailfrom=wanadoo.fr; dkim=pass (2048-bit key) header.d=wanadoo.fr header.i=@wanadoo.fr header.b=Qbj4GV+q; arc=none smtp.client-ip=80.12.242.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=wanadoo.fr
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wanadoo.fr
Received: from [192.168.1.37] ([86.243.222.230])
	by smtp.orange.fr with ESMTPA
	id KMunsiGfm6xnbKMunswaYn; Thu, 20 Jun 2024 20:53:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wanadoo.fr;
	s=t20230301; t=1718909628;
	bh=N+NxqUOjBTvWdh5BEIOxUcci2t45xosej7QdIMTxSQ0=;
	h=Message-ID:Date:MIME-Version:Subject:To:From;
	b=Qbj4GV+qj/zI8L7RfLJjt42AOIvF2lq8j9oaEcNUT1gXcbCWCaDsRaEPtwIBwtB0T
	 1jTY0RwQhEytflWlF+tE1V/ZJDiiulsy33MA2JT+U3cMEOTW0ilqNlPWxrM2fbrCrq
	 u4iPz3vcYkThTK52cQEg9lLLpq1Y6O/Ya4aFJdjHYnwQzOA1OniSePIpahCovsOA9n
	 u6KYTKfrpniZuBUNH4kWp6es6CNGPa6TuDXqLo+Lfs0Y10kNwtUG1JQorkKzb94xim
	 +yCtwpoarmQUibXpoFQGz1WdIDrFOsDtafCSW60wkOj+K7vcXgkCAGhAi8vJUCYlxD
	 eyC5L9O0REMbg==
X-ME-Helo: [192.168.1.37]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Thu, 20 Jun 2024 20:53:48 +0200
X-ME-IP: 86.243.222.230
Message-ID: <0f7d2d25-5c7c-4a19-8af7-ce38ee630d4d@wanadoo.fr>
Date: Thu, 20 Jun 2024 20:53:45 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] wifi: iwlwifi: mvm: Fix __counted_by usage in
 cfg80211_wowlan_nd_*
To: "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
 Kees Cook <kees@kernel.org>
Cc: benjamin.berg@intel.com, dmantipov@yandex.ru, gregory.greenman@intel.com,
 gustavoars@kernel.org, haim.dreyfuss@intel.com, johannes.berg@intel.com,
 kvalo@kernel.org, linux-hardening@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 luciano.coelho@intel.com, miriam.rachel.korenblit@intel.com,
 shaul.triebitz@intel.com, yedidya.ben.shimol@intel.com
References: <20240619211233.work.355-kees@kernel.org>
 <d9bdb9c1-689e-4b3f-8325-8ee813257d8f@wanadoo.fr>
 <c8404725-e4c4-453b-b72d-19ab0761da70@embeddedor.com>
 <47a71c03-0306-4239-b77c-cb63a1760d19@embeddedor.com>
Content-Language: en-MW
From: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <47a71c03-0306-4239-b77c-cb63a1760d19@embeddedor.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Le 20/06/2024 à 20:08, Gustavo A. R. Silva a écrit :
> 
> 
> On 6/20/24 12:02, Gustavo A. R. Silva wrote:
>>
>>> My understanding is that 'match', is allocated by :
>>>      match = kzalloc(struct_size(match, channels, n_channels), 
>>> GFP_KERNEL);
>>>
>>> So match->n_channels is *0* when iwl_mvm_query_set_freqs() is called.
>>
>> n_channels is updated in the line before calling kzalloc():
>>
>> n_channels = iwl_mvm_query_num_match_chans(mvm, d3_data->nd_results, i);
>>
>> match = kzalloc(struct_size(match, channels, n_channels), GFP_KERNEL);
> 
> then match->n_channels updated here:
> 
>           if (!match)
>               goto out_report_nd;
> +        match->n_channels = n_channels;

Thanks for the explanation.
This is what I was looking for, and I missed this line.

Sorry for the noise.

CJ

> 
> Sorry about the split response, finger failure ugghh
> 
> -- 
> Gustavo
> 
> 


