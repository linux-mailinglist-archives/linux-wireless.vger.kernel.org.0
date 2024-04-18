Return-Path: <linux-wireless+bounces-6537-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 2C46F8AA0BB
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 19:07:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D6EB02819D5
	for <lists+linux-wireless@lfdr.de>; Thu, 18 Apr 2024 17:07:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF8BA17164F;
	Thu, 18 Apr 2024 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JuusGYyp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 935DF6A8D8;
	Thu, 18 Apr 2024 17:07:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713460024; cv=none; b=ixM1702WCnkmgR9zG5fa45nRu4grij8rGGYd7Wx9z3XavTXTdLNHOqyRmzl9bpxFOI6MedX7hCwD1Ef9GXcpmmdTj8L+Dbdzh3u5w2hwfGo/85ePHY6FqziC/gl6gAPeduC7YIFVqlO0st8wDmJ2AO3mzA6w+SaD+J5pZWGZK3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713460024; c=relaxed/simple;
	bh=BYwYkxm+zpYZ0DpwReyWESpX1gDBOjXLammM1+gjBc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=n0KXLd1ck5Brk1DEPnoAKSv9lSrBCJ/kRqjkpsgaCP6D7DI0w6unPbavNbY9h9ibpOTmA13SOSi7U/U45n58+Ksziaz/SuiW3nqL/WbCspE2Xtl7f3+g0W+mDRPYqGA9nFguK/4T8VTP2zVwtbOzsgpwIDZ6z9uDdRmV5ozvdcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JuusGYyp; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25CAAC113CC;
	Thu, 18 Apr 2024 17:07:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1713460024;
	bh=BYwYkxm+zpYZ0DpwReyWESpX1gDBOjXLammM1+gjBc0=;
	h=Date:Subject:To:References:From:In-Reply-To:From;
	b=JuusGYypz/r6yjrmmlRYIhsOHg5osz8Ds+a9L6Dl+CAdna5u5/YemuE+C9SMFPbVi
	 FxutFG72eDG+ybKhe1787CiiUlnyFL0op/OaHS8A8SkHWbqQ5bOhu+PeiFE0Mge359
	 wBZkM+7pnah2zcxUk+9L7VeU3I9W96uRFJZXITVXEEaczBl6Bjqx992Gp18Q/dac3g
	 Q6SlU4noTRi7nn4SvbmVs2yKPgJpEQBKpDgcYtU2kFd+3EPDp+/uR2QeZ6XLHQiPh1
	 MXnem0qsKRRdpzCtiFwQRcLBpZNnTvwcouYNMgAf3LWPDeytUHC5AAus3bmNbJLEXQ
	 wvKFnAPXE4lEg==
Message-ID: <6ce928fa-0a86-4d9a-8f48-d31d95fc1978@kernel.org>
Date: Thu, 18 Apr 2024 19:07:01 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NFC: trf7970a: disable all regulators on removal
To: Paul Geurts <paul_geurts@live.nl>, mgreer@animalcreek.com,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <AM0PR09MB2675EDFD44EC82B6BCBB430F95082@AM0PR09MB2675.eurprd09.prod.outlook.com>
 <64ca6d41-8173-4e0e-9467-4fa32db812ec@kernel.org>
 <AM0PR09MB2675C3D6432177B4CABAD49A950E2@AM0PR09MB2675.eurprd09.prod.outlook.com>
Content-Language: en-US
From: Krzysztof Kozlowski <krzk@kernel.org>
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <AM0PR09MB2675C3D6432177B4CABAD49A950E2@AM0PR09MB2675.eurprd09.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 18/04/2024 10:12, Paul Geurts wrote:
> On 17-04-2024 15:15, Krzysztof Kozlowski wrote:
>> On 16/04/2024 22:28, Paul Geurts wrote:
>>> During module probe, regulator 'vin' and 'vdd-io' are used and enabled,
>>> but the vdd-io regulator overwrites the 'vin' regulator pointer. During
>>> remove, only the vdd-io is disabled, as the vin regulator pointer is not
>>> available anymore. When regulator_put() is called during resource
>>> cleanup a kernel warning is given, as the regulator is still enabled.
>>>
>>> Store the two regulators in separate pointers and disable both the
>>> regulators on module remove.
>>>
>>> Fixes: 49d22c70aaf0 ("NFC: trf7970a: Add device tree option of 1.8 Volt IO voltage")
>>>
>>> Signed-off-by: Paul Geurts <paul_geurts@live.nl>
>> No blank lines between tags. Please look at existing commits (git log).
> Will fix this, thanks
>>
>>> ---
>>>  drivers/nfc/trf7970a.c | 42 +++++++++++++++++++++++-------------------
>>>  1 file changed, 23 insertions(+), 19 deletions(-)
>>>
>>> diff --git a/drivers/nfc/trf7970a.c b/drivers/nfc/trf7970a.c
>>> index 7eb17f46a815..9e1a34e23af2 100644
>>> --- a/drivers/nfc/trf7970a.c
>>> +++ b/drivers/nfc/trf7970a.c
>>> @@ -424,7 +424,8 @@ struct trf7970a {
>>>  	enum trf7970a_state		state;
>>>  	struct device			*dev;
>>>  	struct spi_device		*spi;
>>> -	struct regulator		*regulator;
>>> +	struct regulator		*vin_regulator;
>>> +	struct regulator		*vddio_regulator;
>>>  	struct nfc_digital_dev		*ddev;
>>>  	u32				quirks;
>>>  	bool				is_initiator;
>>> @@ -1883,7 +1884,7 @@ static int trf7970a_power_up(struct trf7970a *trf)
>>>  	if (trf->state != TRF7970A_ST_PWR_OFF)
>>>  		return 0;
>>>  
>>> -	ret = regulator_enable(trf->regulator);
>>> +	ret = regulator_enable(trf->vin_regulator);
>> That does not look like equivalent code. Previously this was vddio, right?
> This is part of the original issue created by 49d22c70aaf0. This should be the VIN regulator, but the pointer override made it VDD-IO.

True, good point.


Reviewed-by: Krzysztof Kozlowski <krzk@kernel.org>

Best regards,
Krzysztof


