Return-Path: <linux-wireless+bounces-35743-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +IyhGlNx9GmKBQIAu9opvQ
	(envelope-from <linux-wireless+bounces-35743-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 11:24:35 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0D9204AB511
	for <lists+linux-wireless@lfdr.de>; Fri, 01 May 2026 11:24:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id B646F305B0BF
	for <lists+linux-wireless@lfdr.de>; Fri,  1 May 2026 09:20:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0C8633803CF;
	Fri,  1 May 2026 09:20:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b="4cducM1g"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com [209.85.221.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05B753806C6
	for <linux-wireless@vger.kernel.org>; Fri,  1 May 2026 09:20:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1777627253; cv=none; b=pQstW1Q1qzSABBGBTRl/w/+XYnyvgMelMF0nvohq7LqWtkmOSOXMIB6gxZI2Lb3Bc4+EtNiSPVqDPwTzle/iEK/d5rkibRSRMWYRgojZObUikRQeSQdqIiJAkQo1C7IrsHYhHhyfdtuTm+QP7WN5JzqvMYgiT+FOBvQqJC0fl3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1777627253; c=relaxed/simple;
	bh=t3nxPYsn/+uIJrb9cvX2Su+SoURhZtwc/pGiLCniQoM=;
	h=Mime-Version:Content-Type:Date:Message-Id:Cc:Subject:From:To:
	 References:In-Reply-To; b=h8k+aP2yarShGWc3o+UXLn04YcvAUtd7hQOd+1p51Ayh5kjF7hevmhcGYhmq0fy353xZmirrtevDhYJTig1d1ROu1KX7me4BUJ3wD45gngf0Z0cNFBSZh4KESUkkPUYZJKq7kPhbsKh57waAllDxGIgT15J1Ah/TBMpYIUhcjro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com; spf=pass smtp.mailfrom=fairphone.com; dkim=pass (2048-bit key) header.d=fairphone.com header.i=@fairphone.com header.b=4cducM1g; arc=none smtp.client-ip=209.85.221.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=fairphone.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=fairphone.com
Received: by mail-wr1-f42.google.com with SMTP id ffacd0b85a97d-44a786a9a35so322711f8f.3
        for <linux-wireless@vger.kernel.org>; Fri, 01 May 2026 02:20:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1777627250; x=1778232050; darn=vger.kernel.org;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0bfYkGp++VX2XGf/8Df8kQnMjnWB1zask25dl4NteK4=;
        b=4cducM1goAgbmhRjB7BIeqVv4bhmvt/VGodszsfyXX9V+Y/WIx7CWBq3zq/e2LHY6v
         oyxMrxfTKFkxp3Df6OIh7TXYpy5bkqrY9bWuoRADiTOVWKfVLpOp2nlyWdVm/NilvQt/
         JeeHmwJiATC3bAGy/cvOYDsBxvMDA520LZnu3JNVxn3a7SZeB3zWHrgJFTgno9dL5XSq
         39dVjZ/mzBqa+w9vf2fSkgec+ROGW1wPzHu8COQdnu5tVXASYxMAdDQmucxVlXla+46w
         sd9xPL+p5rgFxJJZ2GuaYJlW0o5AzoTqx6A5qHlSh2qgcx7eO4vPrZfJ+AD33bB/taul
         ZG3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777627250; x=1778232050;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0bfYkGp++VX2XGf/8Df8kQnMjnWB1zask25dl4NteK4=;
        b=U762xVt16jYs5p/zBOdkZoME4gKTJe14zTgDn1EwdP5TxlwEXpm0VOvLBv80lCpRXQ
         sLQjBhlUdfjBEf6VDg7dqr22WYvyrOe987aUA9M6LRuJD3pti7erEovfgsPanVQfRREV
         7UhtlmB7kxi/rnKzKYAXA1GupVyWw6AmeeIFoQs/Xbto+DF8lXqZDaP1AaxcAC+8IVnP
         JZ+SUlCcCeRGA3ahSJBgRPewErqwuPQ44qmkuTpXpPO6PbYQnKqQCcBMG5ccSOYaYPqD
         X1mkqSR3SVG9r0/rBMo85qDolpe7uM4gC8MNcCsCPbWCUr7ebmcXusPoqG22LM/m5CSw
         u80g==
X-Forwarded-Encrypted: i=1; AFNElJ+re4M6sGXIxUOWjgTz/CAipxzuH30KGc1zOmgC6jKF3ZdIPlq5p1Hrp5B1GV6LPJTQchu4yO3yX8RXP34rwQ==@vger.kernel.org
X-Gm-Message-State: AOJu0YwEgmBjrLNsZaJIxLmraoD6jklVUb4ZhvPAI8RLZP6VlEuA52aq
	NC0XsHLxR6NZnbyZnVVoXT5xGU4JZb8LohimxTDO+yoleVF8+eQ5gJ3jZT6sVX17Z+0=
X-Gm-Gg: AeBDievg+olT5f1F6HxQkiKfhDkUIjKxlyJuIVH5KYPosmd0wBqmM28Pwz7XCxGwmmY
	L8hFGoXATxi1eIHOsQBNK7hlqlxjlbTThYbkT7qEMBMUVMK8TtPWGSQO+ih7foIrvTWzj9LW9tf
	Qxel3pYq9QfiWwHTQrCb+FrIuDioHEqUwQs+dK9CPkvSdZi/8XFLdRgDoNF1EEsXrZOdT8bD4Uh
	GZJmdreSh94UUqEwGtCWAHFdtsUbKhdl4L8ZcmNjvh7p238CcqqfOYuOzlt4soFSfCZymnxrgHr
	qbhDNPTAxI53UmRDUGS4ZhmGu1ChwaVs6tdCOoJwtL869kfHAm9cl8KGHqtQt/cJadJfWDHc9Ne
	YgbHFlATISkX52WFrGj9xYK0kKwG+whvTm1ke88qc5swJHEvXN4jJi85j+aY3Lb23iyxccdUfSm
	SIJGs2QXNmO/ol2ksxxwcUnr5+FUX3EGpi8hUVHS0TyEzTJi4Oq6W/UUlI20pO9T1DjZTv5vt94
	4gkF8ZDLw==
X-Received: by 2002:a05:6000:240c:b0:43f:e43a:f4a6 with SMTP id ffacd0b85a97d-44a857c10e8mr3084632f8f.6.1777627250496;
        Fri, 01 May 2026 02:20:50 -0700 (PDT)
Received: from localhost (046124199213.public.t-mobile.at. [46.124.199.213])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-44a98b768fdsm3583191f8f.33.2026.05.01.02.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 01 May 2026 02:20:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Fri, 01 May 2026 11:20:47 +0200
Message-Id: <DI789NOBWJHK.1V3SFQLCFLS4P@fairphone.com>
Cc: "Bjorn Andersson" <andersson@kernel.org>, "Konrad Dybcio"
 <konradybcio@kernel.org>, "Rob Herring" <robh@kernel.org>, "Krzysztof
 Kozlowski" <krzk+dt@kernel.org>, "Conor Dooley" <conor+dt@kernel.org>,
 "Alexander Koskovich" <AKoskovich@pm.me>, "Liam Girdwood"
 <lgirdwood@gmail.com>, "Mark Brown" <broonie@kernel.org>, "Bartosz
 Golaszewski" <brgl@kernel.org>, "Marcel Holtmann" <marcel@holtmann.org>,
 "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>, "Balakrishna Godavarthi"
 <quic_bgodavar@quicinc.com>, "Rocky Liao" <quic_rjliao@quicinc.com>,
 "Johannes Berg" <johannes@sipsolutions.net>, "Jeff Johnson"
 <jjohnson@kernel.org>, <~postmarketos/upstreaming@lists.sr.ht>,
 <phone-devel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
 <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
 <linux-bluetooth@vger.kernel.org>, <linux-wireless@vger.kernel.org>,
 <ath11k@lists.infradead.org>
Subject: Re: [PATCH v2 7/7] arm64: dts: qcom: milos-fairphone-fp6: Enable
 WiFi
From: "Luca Weiss" <luca.weiss@fairphone.com>
To: "Konrad Dybcio" <konrad.dybcio@oss.qualcomm.com>, "Dmitry Baryshkov"
 <dmitry.baryshkov@oss.qualcomm.com>, "Luca Weiss"
 <luca.weiss@fairphone.com>, "Jeff Johnson" <jeff.johnson@oss.qualcomm.com>,
 "Baochen Qiang" <baochen.qiang@oss.qualcomm.com>
X-Mailer: aerc 0.21.0-0-g5549850facc2
References: <20260403-milos-fp6-bt-wifi-v2-0-393322b27c5f@fairphone.com>
 <20260403-milos-fp6-bt-wifi-v2-7-393322b27c5f@fairphone.com>
 <4fbs4arx6sez6fffy75ctmzecfvitr6aocau3cczlr2ps2ptld@v7wpa2irsihl>
 <2514523f-a43f-4470-a69b-3d5175d10385@oss.qualcomm.com>
In-Reply-To: <2514523f-a43f-4470-a69b-3d5175d10385@oss.qualcomm.com>
X-Rspamd-Queue-Id: 0D9204AB511
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-0.16 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[fairphone.com,quarantine];
	MV_CASE(0.50)[];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[fairphone.com:s=fair];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-35743-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	RECEIVED_HELO_LOCALHOST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	FREEMAIL_CC(0.00)[kernel.org,pm.me,gmail.com,holtmann.org,quicinc.com,sipsolutions.net,lists.sr.ht,vger.kernel.org,lists.infradead.org];
	RCPT_COUNT_TWELVE(0.00)[28];
	MIME_TRACE(0.00)[0:+];
	FROM_HAS_DN(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[luca.weiss@fairphone.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[fairphone.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless,dt];
	NEURAL_HAM(-0.00)[-1.000];
	TO_DN_SOME(0.00)[];
	RCVD_VIA_SMTP_AUTH(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns,qualcomm.com:email,fairphone.com:email,fairphone.com:dkim,fairphone.com:mid]

Hi Konrad,

On Tue Apr 7, 2026 at 3:16 PM CEST, Konrad Dybcio wrote:
> On 4/3/26 9:35 PM, Dmitry Baryshkov wrote:
>> On Fri, Apr 03, 2026 at 03:52:53PM +0200, Luca Weiss wrote:
>>> Configure and enable the WiFi node, and add the required pinctrl to
>>> provide the sleep clock from the PMK8550 (PMK7635) to WCN6755.
>>>
>>> Thanks to Alexander Koskovich for helping with the bringup, adding
>>> the missing pinctrl to make the WPSS stop crashing.
>>>
>>> Link: https://lore.kernel.org/linux-arm-msm/DBF7OWAWQ94M.FSCP4DPF8ZJY@f=
airphone.com/
>>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
>>> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
>>> ---
>>>  arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts | 19 ++++++++++++++++=
++-
>>>  1 file changed, 18 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts b/arch/ar=
m64/boot/dts/qcom/milos-fairphone-fp6.dts
>>> index db72418b7195..d8ac495ca7c8 100644
>>> --- a/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>>> +++ b/arch/arm64/boot/dts/qcom/milos-fairphone-fp6.dts
>>> @@ -242,7 +242,7 @@ wcn6750-pmu {
>>> =20
>>>  		clocks =3D <&rpmhcc RPMH_RF_CLK1>;
>>> =20
>>> -		pinctrl-0 =3D <&bluetooth_enable_default>;
>>> +		pinctrl-0 =3D <&bluetooth_enable_default>, <&pmk8550_sleep_clk_defau=
lt>;
>>>  		pinctrl-names =3D "default";
>>> =20
>>>  		regulators {
>>> @@ -766,6 +766,17 @@ &pmiv0104_eusb2_repeater {
>>>  	qcom,tune-usb2-preem =3D /bits/ 8 <0x6>;
>>>  };
>>> =20
>>> +&pmk8550_gpios {
>>> +	pmk8550_sleep_clk_default: sleep-clk-default-state {
>>> +		pins =3D "gpio5";
>>> +		function =3D "func1";
>>> +		input-disable;
>>> +		output-enable;
>>=20
>> Hmm, if it's a sleep_clk, should it not be handled via the power
>> sequencer?
>
> If you mean that it may be needed to toggle it with specific timings,
> possibly..  seems that WCN6855 has a "xo-clk" GPIO defined. I requested
> access to some docs that I think should have the answer, hopefully should
> get it soon.

Did you manage to get anything there yet?

Regards
Luca

> Or maybe +Jeff/Baochen could answer faster?
>
> Konrad


