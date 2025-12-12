Return-Path: <linux-wireless+bounces-29719-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 0822ECB912D
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 16:12:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id EB86E30076B0
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 15:12:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12DDE3112B0;
	Fri, 12 Dec 2025 15:12:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b="lKqb0Eww"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.olsak.net (mx.olsak.net [37.205.8.231])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D8F8224B15;
	Fri, 12 Dec 2025 15:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=37.205.8.231
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765552371; cv=none; b=HJ2rHESDbgYnmgCpvMfBeEurq4+82KbXP56qYy0h/x+0spQBTuRI9q3tkuzTh1O66I4yeW0S0Yb2AY0+9prmjgqs3lmfOt979fwZCUY3cn4s5tFlINYlcxWMrgDinlg/L6DG0heaNw3yZIhCYw2tvI4wH0KlK+2XCEinIjvvEo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765552371; c=relaxed/simple;
	bh=Au2bq/uT4hQqmVRhmRu0GZSkECIowsydK5IBDoeqVls=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=rh2oYhqq/i4yOZjpwfZRByYo653aQM93GjJWdfXE4bbchnVfIdLMz6zHaIiA23Weh7itv1NgE00qhmogO3BbY9WdckDLSNXfl+yQh1it6SQodnZKuWW5pTA1iJM8IFE25lJhJkeIixQlVG8YfFM7hTdiNSfoyXqDYr+ePY7Jylc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz; spf=pass smtp.mailfrom=dujemihanovic.xyz; dkim=pass (2048-bit key) header.d=dujemihanovic.xyz header.i=@dujemihanovic.xyz header.b=lKqb0Eww; arc=none smtp.client-ip=37.205.8.231
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=dujemihanovic.xyz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dujemihanovic.xyz
DKIM-Signature: a=rsa-sha256; bh=4ws6w/h+ocGHgXoKslH3aTkpzb0iw8aDky8/QSNIKFA=;
 c=relaxed/relaxed; d=dujemihanovic.xyz;
 h=Subject:Subject:Sender:To:To:Cc:Cc:From:From:Date:Date:MIME-Version:MIME-Version:Content-Type:Content-Type:Content-Transfer-Encoding:Content-Transfer-Encoding:Reply-To:In-Reply-To:In-Reply-To:Message-Id:Message-Id:References:References:Autocrypt:Openpgp;
 i=@dujemihanovic.xyz; s=default; t=1765551350; v=1; x=1765983350;
 b=lKqb0Ewwk2P9x7xWmAco6D6Vb4U9a1BhGCwrhdQoau5rmSp1f9sM8gPW/vc/YBZPrrfS275F
 1PD8w92z8zLgtq6cN30ya1uSfWBPLl7CGMJSQQgm0DJ06i/pOtDzo+uAcihfukJZi4o01bpOFi7
 5RzQhGIDEaS/cUlWYnE6tDrFnptw1HL1mJbnEgqPX4WIyqVPwxf0TnF/SxSojUFbIS2ZAlQ3AlB
 CeWMlwkgKY/Ayrd3Nu36IaC+73iA6NKkxCIAJWwD+hvqgrqv5p7QAy48y+tFk3zxLrv8J+RiwOY
 ZzOXpaf34kuaxdLkfUBuVBMDLk10Z28DFPTWFenpUc9PA==
Received: by mx.olsak.net (envelope-sender <duje@dujemihanovic.xyz>) with
 ESMTPS id 97b39aec; Fri, 12 Dec 2025 15:55:50 +0100
Message-ID: <b92172f3-10f4-470f-b90a-121ff7fea988@dujemihanovic.xyz>
Date: Fri, 12 Dec 2025 15:55:48 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [DONOTAPPLY RFC PATCH v2 4/4] arm64: dts: samsung,coreprimevelte:
 add wifi node
To: Karel Balej <balejk@matfyz.cz>, Brian Norris <briannorris@chromium.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Andrew Lunn <andrew@lunn.ch>,
 Gregory Clement <gregory.clement@bootlin.com>,
 Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
 Francesco Dolcini <francesco@dolcini.it>,
 Ulf Hansson <ulf.hansson@linaro.org>, Frank Li <Frank.Li@nxp.com>,
 linux-wireless@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-mmc@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
 phone-devel@vger.kernel.org, Jeff Chen <jeff.chen_1@nxp.com>,
 Peng Fan <peng.fan@nxp.com>
References: <20251026182602.26464-1-balejk@matfyz.cz>
 <20251026182602.26464-5-balejk@matfyz.cz> <aTCv75hjdX5XvgCh@google.com>
 <DEW3NQVZ84JU.22G38WMULFZJG@matfyz.cz>
Content-Language: en-US
From: =?UTF-8?Q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>
In-Reply-To: <DEW3NQVZ84JU.22G38WMULFZJG@matfyz.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 12/12/25 09:36, Karel Balej wrote:
> Brian Norris, 2025-12-03T13:47:27-08:00:
>>
>> Do we have a min/max voltage for this regulator?
> 
> The downstream node is defined with the same values as the above ldo14,
> they however are however only defined in the PMIC dtsi and correspond to
> the actual physical limits of the regulator specified also in the
> driver, so this doesn't really give any specific constraints for the
> board itself.
> 
> The downstream code enabling WiFi seems to force it to 3300000 (which
> also seems to be the startup value) unconditionally, so I suppose I will
> just set the both limits to this value?

This sounds reasonable to me.

>>
>>> +			};
>>>   		};
>>>   	};
>>>   };
>>> @@ -523,6 +531,13 @@ &sdh1 {
>>>   	pinctrl-1 = <&sdh1_fast_pins_0 &sdh1_fast_pins_1 &sdh1_pins_2>;
>>>   	bus-width = <4>;
>>>   	non-removable;
>>> +	#address-cells = <1>;
>>> +	#size-cells = <0>;
>>
>> I wonder if this should have:
>>
>> 	vmmc-supply = <&ldo16>;
>>
>> rather than regulator-always-on above.
> 
> You mean ldo15 right?
> 
> Not having any board schematics, I don't really know what exactly the
> regulator's purpose is. As I mentioned in the commit message, the
> communication with the chipset seems to work even if this is disabled
> (e. g. FW loads, networks can be scanned for,...) which doesn't seem
> like it should be the case if this was a main power supply for the bus,
> only actual connecting to networks doesn't work (gives
> CONNECT_ERR_ASSOC_ERR_TIMEOUT errors).

To me, this strongly suggests that the regulator powers the WiFi 
transmitter or at least a part of it (such as the RF amp).

> So this didn't seem too fitting for either vmmc nor vqmmc as far as I
> understand their semantics, so I went with the regulator-always-on
> approach to be safe.

Considering the above, I'd reckon it'd be good to have the option to 
toggle it for rfkill if anything. I'm however not sure what would be the 
right way to do so, nor how rfkill even works, if at all, with mwifiex 
(from what I see, the driver does not use the API).

Regards,
--
Duje

