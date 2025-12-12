Return-Path: <linux-wireless+bounces-29703-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [104.64.211.4])
	by mail.lfdr.de (Postfix) with ESMTPS id E4C17CB84CB
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 09:38:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 8BF803008BF5
	for <lists+linux-wireless@lfdr.de>; Fri, 12 Dec 2025 08:38:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5F9C630FC01;
	Fri, 12 Dec 2025 08:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b="ZqFAjb2B"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp1.ms.mff.cuni.cz (smtp-in1.ms.mff.cuni.cz [195.113.20.234])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76AB30B519;
	Fri, 12 Dec 2025 08:38:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=195.113.20.234
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765528696; cv=none; b=g+o55kCbnTfowiVxVT3MVJ9kePFME1g+yuYV5pEvHAwbdopquDDo1/Fb8Ti7LIf85SSUgMkAUpfdcIcC0WMMlya/89+/fVmMYDtGTz+COogFrK94s07UFL6gTc/jtT9jOtEJ8uYBX9jKqkGXUDDKe5AfaCzdpT4BFj/KyIZzIgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765528696; c=relaxed/simple;
	bh=72HAfi72SmDJb0OCeKnVGaHwhyYFhkB1nePjitPZwis=;
	h=Mime-Version:Content-Type:Date:Message-Id:To:From:Cc:Subject:
	 References:In-Reply-To; b=bzylXo146vWHFsB/5Eo2ogBEkx3Cc1+1JenOyF9HYah1PBafkw5MxsODwbE4Ik/B0qkhU9zk4XzoDUba8opqGvOa3Kx8H7/b3ZENU9yM20Fg2RBCo/cd443m5ZWBb72TFL+gMEJGU1kQKI+BS0WrZ/qNLnXzlbV05TmSYvF5FLU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz; spf=pass smtp.mailfrom=matfyz.cz; dkim=pass (2048-bit key) header.d=mff.cuni.cz header.i=@mff.cuni.cz header.b=ZqFAjb2B; arc=none smtp.client-ip=195.113.20.234
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=matfyz.cz
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=matfyz.cz
X-SubmittedBy: id balejk@matfyz.cz subject /postalCode=110+2000/O=Univerzita+20Karlova/street=Ovocn+5CxC3+5CxBD+20trh+20560+5C/5/ST=Praha,+20Hlavn+5CxC3+5CxAD+20m+5CxC4+5Cx9Bsto/C=CZ/CN=Karel+20Balej/emailAddress=balejk@matfyz.cz
	serial F5FD910E8FE2121B897F7E55B84E351D
	issued by /C=NL/O=GEANT+20Vereniging/CN=GEANT+20Personal+20CA+204
	auth type TLS.CUNI
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=mff.cuni.cz;
	s=submission; t=1765528615; x=1766828615;
	bh=06iQT5wqSAV80e9jTa3YiqvCIEHPGGapBLMjVJZ1Eh4=; h=From;
	b=ZqFAjb2Bbbp+1UwXi0Wbfe5kzx7wqzGs83QToiBgrE2Fb/3IhUbCiT4Ch2+lF75X2
	 YBK2mwHgWEGasLCNid+gcaQQ8Qc3AKidt5XUibcZpsbjSkrTMt+LCKJMftGplpnFw4
	 hd5C63q+A2z9LsqiODZF3WpZ21qQYA+noUHwbbIH130PyLv6lzJjzABXESuzbuGUfm
	 ohiRDD7S8o4BTJL9Rf8FyrdaogG/imcGXGcSQX5/3rQeruL+LE1XZYj19gWIyXiTjL
	 6T+o0ICVAvwTk4sPIgDCh3O39Ls8gevvvkvhgN2uyXKT9JaC8oBHbENnrP4Sf+FM9Z
	 SIqaMJ1DtAgqg==
Received: from localhost (internet5.mraknet.com [185.200.108.250])
	(authenticated)
	by smtp1.ms.mff.cuni.cz (8.18.1/8.18.1) with ESMTPS id 5BC8apRt091034
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=OK);
	Fri, 12 Dec 2025 09:36:52 +0100 (CET)
	(envelope-from balejk@matfyz.cz)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 12 Dec 2025 09:36:50 +0100
Message-Id: <DEW3NQVZ84JU.22G38WMULFZJG@matfyz.cz>
To: "Brian Norris" <briannorris@chromium.org>
From: "Karel Balej" <balejk@matfyz.cz>
Cc: "Johannes Berg" <johannes@sipsolutions.net>,
        "Rob Herring"
 <robh@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        "Conor
 Dooley" <conor+dt@kernel.org>,
        =?utf-8?q?Duje_Mihanovi=C4=87?=
 <duje@dujemihanovic.xyz>,
        "Andrew Lunn" <andrew@lunn.ch>,
        "Gregory Clement"
 <gregory.clement@bootlin.com>,
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
References: <20251026182602.26464-1-balejk@matfyz.cz>
 <20251026182602.26464-5-balejk@matfyz.cz> <aTCv75hjdX5XvgCh@google.com>
In-Reply-To: <aTCv75hjdX5XvgCh@google.com>
X-Spam-Level: ****

Brian Norris, 2025-12-03T13:47:27-08:00:
> On Sun, Oct 26, 2025 at 07:20:41PM +0100, Karel Balej wrote:
>> Add a node for the phone's WiFi serviced by the Marvell SD8777 chip a
>> communication with which happens over the SDIO. Also enable a regulator
>> without which it is not possible to connect to networks although they
>> are discovered properly.
>>=20
>> Signed-off-by: Karel Balej <balejk@matfyz.cz>
>> ---
>>  .../mmp/pxa1908-samsung-coreprimevelte.dts        | 15 +++++++++++++++
>>  1 file changed, 15 insertions(+)
>>=20
>> diff --git a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimeve=
lte.dts b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dt=
s
>> index b2ce5edd9c6a..36d6ae4e902e 100644
>> --- a/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
>> +++ b/arch/arm64/boot/dts/marvell/mmp/pxa1908-samsung-coreprimevelte.dts
>> @@ -475,6 +475,14 @@ ldo14: ldo14 {
>>  				regulator-min-microvolt =3D <1200000>;
>>  				regulator-max-microvolt =3D <3300000>;
>>  			};
>> +
>> +			/*
>> +			 * Needs to be enabled in order for the WiFi to be able
>> +			 * to connect to networks.
>> +			 */
>> +			ldo15 {
>> +				regulator-always-on;
>
> Do we have a min/max voltage for this regulator?

The downstream node is defined with the same values as the above ldo14,
they however are however only defined in the PMIC dtsi and correspond to
the actual physical limits of the regulator specified also in the
driver, so this doesn't really give any specific constraints for the
board itself.

The downstream code enabling WiFi seems to force it to 3300000 (which
also seems to be the startup value) unconditionally, so I suppose I will
just set the both limits to this value?

>
>> +			};
>>  		};
>>  	};
>>  };
>> @@ -523,6 +531,13 @@ &sdh1 {
>>  	pinctrl-1 =3D <&sdh1_fast_pins_0 &sdh1_fast_pins_1 &sdh1_pins_2>;
>>  	bus-width =3D <4>;
>>  	non-removable;
>> +	#address-cells =3D <1>;
>> +	#size-cells =3D <0>;
>
> I wonder if this should have:
>
> 	vmmc-supply =3D <&ldo16>;
>
> rather than regulator-always-on above.

You mean ldo15 right?

Not having any board schematics, I don't really know what exactly the
regulator's purpose is. As I mentioned in the commit message, the
communication with the chipset seems to work even if this is disabled
(e. g. FW loads, networks can be scanned for,...) which doesn't seem
like it should be the case if this was a main power supply for the bus,
only actual connecting to networks doesn't work (gives
CONNECT_ERR_ASSOC_ERR_TIMEOUT errors).

So this didn't seem too fitting for either vmmc nor vqmmc as far as I
understand their semantics, so I went with the regulator-always-on
approach to be safe.

Thank you for the comments,
K. B.

