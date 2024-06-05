Return-Path: <linux-wireless+bounces-8526-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C5FD8FC899
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 12:04:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 83529B2408F
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Jun 2024 10:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10FBB18FC9B;
	Wed,  5 Jun 2024 10:04:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qIEPWhPz"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8CBB18FC94;
	Wed,  5 Jun 2024 10:04:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717581874; cv=none; b=MuSQNVpALNW990IbrMCIXU3kB55rwOjXs0GeT0U+asDpJ2DESZh8DS/WgNx1CyqPWTQmceR6Vo0aKokrfJhq+yunBDE7AR0a5t9+SWkLq3x74qMManYRj2tI0qUZN9edKIduBRPjjl5rXnbSmkEbcRxL2Sh8jMuU4EyLaJQJuTs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717581874; c=relaxed/simple;
	bh=Cn73GF3ysEs/8M4g6qhMBufC206zVPlSS64vbWQZY0E=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=M+QEMIcIX9e/PvdOZeLZaYMFep3NsRKbrI6fcysKArPhZMsD+2iLa5VFPESwyL7W3ETcmZFhi6f9RPQFMI/6Kvrc+N9vBdCseCAab126fLb8ZkREj+wBDO8imB26STObwSRWNg2UKQXReoSqFDeskWfTZdpQzGqfXf7/mK8CbcU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qIEPWhPz; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B6C5C3277B;
	Wed,  5 Jun 2024 10:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1717581874;
	bh=Cn73GF3ysEs/8M4g6qhMBufC206zVPlSS64vbWQZY0E=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=qIEPWhPzEggn60Ixv7bxJ8ZVsgHPKWYmTGt6EfxJLjk2Sv+39F8Bh3zcBeJ2qqJU4
	 4/KFWYNo6wCSXC1M6juhK2POrxJsudVNepz1obkVG1AkxyHCXVHIEqW8OdUmNxuffF
	 R6aDNOXAFV0NN8fCDuKGWsxOpv7Ydwk/pwgCnsT66mZ6Pva1yFrSmuH3hJ3ROVYOyh
	 SBwn5BTWrOhh/txn6M4JRwe+zzkF5px+Cb4X4COwqHrkmrgmBtpKBiGfw7AGeltUXg
	 n0Kc+bGDceRVpn1fFK9I/V78YJT8E2zMBevCPPnOAljUFseJ1xcvTQB0enTEi96Q9w
	 /2YFTCTChbC8Q==
Message-ID: <2c4283be-0369-4be3-ba07-987b9fb41476@kernel.org>
Date: Wed, 5 Jun 2024 12:04:29 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 08/17] Add main.c
To: "Nemanov, Michael" <michael.nemanov@ti.com>, Kalle Valo
 <kvalo@kernel.org>, Johannes Berg <johannes.berg@intel.com>,
 Breno Leitao <leitao@debian.org>, Justin Stitt <justinstitt@google.com>,
 Kees Cook <keescook@chromium.org>, linux-wireless@vger.kernel.org,
 linux-kernel@vger.kernel.org
Cc: Sabeeh Khan <sabeeh-khan@ti.com>
References: <20240521171841.884576-1-michael.nemanov@ti.com>
 <20240521171841.884576-9-michael.nemanov@ti.com>
 <cfe33bf1-9df3-4d02-b4ed-e29a430b106d@kernel.org>
 <456c8076-1e3a-4cc9-895c-e707e68fe610@ti.com>
 <97d8acf9-6cb3-4da7-ad4e-0f2d0a63c172@kernel.org>
 <2e2ec1ba-0c24-4173-af60-ea51004f2e10@ti.com>
 <eea16e12-6e9d-4630-87e6-f44071ab1c4e@ti.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <eea16e12-6e9d-4630-87e6-f44071ab1c4e@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 05/06/2024 11:55, Nemanov, Michael wrote:
> On 5/31/2024 4:50 PM, Nemanov, Michael wrote:
>> On 5/22/2024 12:46 PM, Krzysztof Kozlowski wrote:>
>>>> +
>>>> +static int cc33xx_probe(struct platform_device *pdev)
>>>> +{
>>>> +	struct cc33xx *cc;
>>>> +	struct ieee80211_hw *hw;
>>>> +	struct cc33xx_platdev_data *pdev_data = dev_get_platdata(&pdev->dev);
>>>> +	const char *nvs_name;
>>>> +	int ret;
>>>> +
>>>> +	cc33xx_debug(DEBUG_CC33xx, "Wireless Driver Version %s", DRV_VERSION);
>>>
>>> Drop
>>>
>>>> +
>>>> +	if (!pdev_data) {
>>>> +		cc33xx_error("can't access platform data");
>>>
>>> Do not use your own print code. Use standard dev_() calls. This applies
>>> *everywhere*.
>>>
>>> [...]
>>>
>>>> +	cc33xx_debug(DEBUG_CC33xx, "WLAN CC33xx platform device probe done");
>>>
>>> Drop, tracing/sysfs gices you this. Do not print simple
>>> success/entry/exit messages.
>>>
>>> [...]
>>>
>>>> +};
>>>> +MODULE_DEVICE_TABLE(platform, cc33xx_id_table);
>>>> +
>>>> +static struct platform_driver cc33xx_driver = {
>>>> +	.probe		= cc33xx_probe,
>>>> +	.remove		= cc33xx_remove,
>>>> +	.id_table	= cc33xx_id_table,
>>>> +	.driver = {
>>>> +		.name	= "cc33xx_driver",
>>>> +	}
>>>> +};
>>>> +
>>>> +u32 cc33xx_debug_level = DEBUG_NO_DATAPATH;
>>>>
>>> Why this is global? Why u32? Why global variable is defined at the end
>>> of the file?!?!
>>  
>> cc33xx_debug_level together with cc33xx_debug/info/error() macros is how
>> all traces were done in drivers/net/wireless/ti/wlcore/ (originally was
>> wl1271_debug/info etc.)
>> It enables / disables traces without rebuilding or even reloading which
>> is very helpful for remote support. These macros map to dynamic_pr_debug
>> / pr_debug. I saw similar wrappers in other wireless drivers (ath12k).
>> This is also why there are plenty of cc33xx_debug() all over the code,
>> most are silent by default.
> 
> Any more thoughts on debug traces? I'll remove all trivial function 
> entry / exit traces as Krzysztof requested. Is it OK to keep other 
> cc33xx_debug() calls which will be off by default?

Sorry, I don't see the point. Dynamic debug gives you debug control. You
just added orthogonal code to existing debug infrastructure, so as far
as I am concerned, this should be dropped in favor of standard debugging
calls.

Best regards,
Krzysztof


