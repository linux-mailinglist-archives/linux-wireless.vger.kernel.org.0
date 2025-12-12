Return-Path: <linux-wireless+bounces-29720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id 5033ACB9DE5
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 22:18:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id EC6C93015436
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 21:18:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1B7CC22B8CB;
	Fri, 12 Dec 2025 21:18:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="OE3fP7qM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532B2AD24;
	Fri, 12 Dec 2025 21:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765574300; cv=none; b=tS1ei3iHYmu10dZwvUaJ91edwenteoBvoCkfE6A8gTgPkx14yfnTeJadwA8sCDijkiwPlseTipEvTrLxpQE4c1kRPqc0w94O7XVL7YD7z9cTp34SMJyOpyaeHMctNFflpvfKzOhq52kx6trwKqobPtx/s2FimtHsnL0hIWFFdqs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765574300; c=relaxed/simple;
	bh=x3CNFs0hLuWUM+gyOO6MyVKcgZ7XrZR6ET7W0thCckA=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:To:From:
	 References:In-Reply-To; b=QgQ9vbmcq+EEpJmrMXRaZQk+kK0cjCJX1743NLtRxNQwPxbLuCwAqvpzT6zdY8EpN4yvO3UCLt6gc19N+UZLNvImuKLrHcMZO8XMxm4HEA0xv45ReJRvXRw8U5kfzin6zpjrmSO/c4lINMj+ddAAV1TR2x6n6oARWP2bFgdAyyI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=OE3fP7qM; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560+5C/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1765574234; x=1766874234;
	bh=SgUfumfpK8IIvCsoZJdwGQ9G22gqg60C4Us0iM2ajKk=; h=From;
	b=OE3fP7qMrQ9bg3lfj4OuqwhlpebxqbREJxoAPnzCEMv2XNlSmscAXITSuUS9Qd9b3
	 o9xqJOBix4IP2TR5FssIj/ZFEzre6naHZTyCPKZOEkb1Q2YtsCfgK8/FaTAqdDkGnU
	 kxr2EqCPeEV2I6v75dloTs0VeXUPgeJWHKYW1/RACH8LWWT4TUz5CSaTfnXgGQ+2W8
	 9Ey9CUeMRCCeT7jq+n3KRat6PaXdT2BklyyLYT8WJ/SXYCJ1R3Q97Rl8fQTJo+b6P6
	 3jIdjYNq60x9NsHOLkt5L0KIOrkbjUYuC/VOyJmunZKUEpeBAI0y/u6cua/XdpHv3G
	 U7R0QdmL7vr2g==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.18.1/8.18.1) with ESMTPS id 5BCLHCKs025210
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 12 Dec 2025 22:17:13 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Dec 2025 22:17:12 +0100
Message-Id: <DEWJTWZ6Q51B.13HQYMDJZRFWA@matfyz.cz>
Cc: "Johannes Berg" <johannes@sipsolutions.net>,
        "Rob Herring"
 <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>, "Andrew Lunn" <andrew@lunn.ch>,
        "Gregory
 Clement" <gregory.clement@bootlin.com>,
        "Sebastian Hesselbarth"
 <sebastian.hesselbarth@gmail.com>,
        "Francesco Dolcini"
 <francesco@dolcini.it>,
        "Ulf Hansson" <ulf.hansson@linaro.org>, "Frank Li"
 <Frank.Li@nxp.com>,
        <linux-wireless@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-mmc@vger.kernel.org>, <~postmarketos/upstreaming@lists.sr.ht>,
        <phone-devel@vger.kernel.org>, "Jeff Chen" <jeff.chen_1@nxp.com>,
        "Peng Fan" <peng.fan@nxp.com>
Subject: Re: [DONOTAPPLY RFC PATCH v2 4/4] arm64: dts:
 samsung,coreprimevelte: add wifi node
To: =?utf-8?q?Duje_Mihanovi=C4=87?= <duje@dujemihanovic.xyz>,
        "Brian Norris"
 <briannorris@chromium.org>
From: "Karel Balej" <balejk@matfyz.cz>
References: <20251026182602.26464-1-balejk@matfyz.cz>
 <20251026182602.26464-5-balejk@matfyz.cz> <aTCv75hjdX5XvgCh@google.com>
 <DEW3NQVZ84JU.22G38WMULFZJG@matfyz.cz>
 <b92172f3-10f4-470f-b90a-121ff7fea988@dujemihanovic.xyz>
In-Reply-To: <b92172f3-10f4-470f-b90a-121ff7fea988@dujemihanovic.xyz>
X-Spam-Level: ****

Duje Mihanovi=C4=87, 2025-12-12T15:55:48+01:00:
> On 12/12/25 09:36, Karel Balej wrote:
>>>> +			};
>>>>   		};
>>>>   	};
>>>>   };
>>>> @@ -523,6 +531,13 @@ &sdh1 {
>>>>   	pinctrl-1 =3D <&sdh1_fast_pins_0 &sdh1_fast_pins_1 &sdh1_pins_2>;
>>>>   	bus-width =3D <4>;
>>>>   	non-removable;
>>>> +	#address-cells =3D <1>;
>>>> +	#size-cells =3D <0>;
>>>
>>> I wonder if this should have:
>>>
>>> 	vmmc-supply =3D <&ldo16>;
>>>
>>> rather than regulator-always-on above.
>>=20
>> You mean ldo15 right?
>>=20
>> Not having any board schematics, I don't really know what exactly the
>> regulator's purpose is. As I mentioned in the commit message, the
>> communication with the chipset seems to work even if this is disabled
>> (e. g. FW loads, networks can be scanned for,...) which doesn't seem
>> like it should be the case if this was a main power supply for the bus,
>> only actual connecting to networks doesn't work (gives
>> CONNECT_ERR_ASSOC_ERR_TIMEOUT errors).
>
> To me, this strongly suggests that the regulator powers the WiFi=20
> transmitter or at least a part of it (such as the RF amp).

Something like this occurred to me too but would the chip even see the
networks if this was the case? Although you are right that it could only
power some specific part of the radio.

>> So this didn't seem too fitting for either vmmc nor vqmmc as far as I
>> understand their semantics, so I went with the regulator-always-on
>> approach to be safe.
>
> Considering the above, I'd reckon it'd be good to have the option to=20
> toggle it for rfkill if anything. I'm however not sure what would be the=
=20
> right way to do so, nor how rfkill even works, if at all, with mwifiex=20
> (from what I see, the driver does not use the API).

I have experimented with rfkill here before. The chip has a specific pin
for this so I don't think handling the regulator alone would suffice.
But yes, it should certainly be associated with the rfkill if possible
so that it could be turned off to save power when the radio is disabled.

Brian, is it possible to attach the rfkill pin (and ideally this
regulator) to the wireless device solely through the device tree in some
generic way or must this be implemented in the driver? I have
experimented with the rfkill-gpio driver in the past but it appeared as
a separate rfkill device with its own controls independent of the
mwifiex device and I could only soft block both (soft blocking the
rfkill-gpio device of course had effect on the wifi though).

Regards,
K. B.

