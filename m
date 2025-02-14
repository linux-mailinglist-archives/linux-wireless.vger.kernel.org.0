Return-Path: <linux-wireless+bounces-18953-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C404A35826
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2025 08:47:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AEA833AAD38
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Feb 2025 07:47:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A240021B195;
	Fri, 14 Feb 2025 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="N07Gl9ao"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 653BF21B181;
	Fri, 14 Feb 2025 07:47:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739519252; cv=none; b=A/SdFbHP1oSmQuCZIJHj/bC4bxpqBNOwYOEqZKxtQ2Chn6iQaiWyVRevFe8HMLkqGMPmUKEoft9r3RfOJMO0V6AiUb1CSVhXLgXD1H1gRFccGOAyhoUbHUPKr2KJhIbTCnxQ9ztfV2awNIW0OG1LCu1TyqNuShm/62/C/EKtv5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739519252; c=relaxed/simple;
	bh=EYmxegMfAeOmf9WfPU0zoAyXDFaCcyLf0boT+xp9GzI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=DuVTtaPFBNH2z0zbJOzCD2HMCjoWgvHP8My4nrOXEWzjsGSGLXf+L8dg01Qs7pnCQxadr705o2bzlI8ns6rHkLKbp129H8Z/E7RQA2kz+4mSKpp43/wLRc/PF8DLWhyla6pTrs28kHi/nXWJJ7FZ1u1/6OyjLmD/woGC4duARco=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=N07Gl9ao; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F25D4C4CED1;
	Fri, 14 Feb 2025 07:47:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1739519251;
	bh=EYmxegMfAeOmf9WfPU0zoAyXDFaCcyLf0boT+xp9GzI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=N07Gl9aocIzC5I04HiGdP03Mws1B5tWvZQNa4Hft8/45j5cB4ALd3qcnGufrUYktk
	 artWM/ChcL+6uQrP21lToDMsM7U1LBJdCHQDBr9IuyXbqbPSdYChWrUSgUymQrFRJj
	 mhC2CMfArzPXVjYnx5OiOwK4erS6A1QqkT721cz/08yJPSkfk5T1BDKnwzUwRc0AKg
	 91vpDWQYaxb27HZ7N0Aruobkc1i34nyEeLXFqbdq7m0mozQEscMPbWTAoEU5rSzc7/
	 qOfnKb4GiHGzzOWzBIaXRtHfJldYj6ZKq7m0utxtmr2F69AvYxXKjV9rEspNzXtPTQ
	 th/UIPJNgrw8A==
Message-ID: <826ded05-6ea8-420c-8bd9-97dcf9b18ccc@kernel.org>
Date: Fri, 14 Feb 2025 08:47:23 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 01/12] dt-bindings: bluetooth: describe wilc 3000
 bluetooth chip
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Cc: Marcel Holtmann <marcel@holtmann.org>,
 Luiz Augusto von Dentz <luiz.dentz@gmail.com>, Rob Herring
 <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Kalle Valo <kvalo@kernel.org>,
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Simon Horman <horms@kernel.org>, Nicolas Ferre
 <nicolas.ferre@microchip.com>,
 Alexandre Belloni <alexandre.belloni@bootlin.com>,
 Marek Vasut <marex@denx.de>, Thomas Petazzoni
 <thomas.petazzoni@bootlin.com>, linux-bluetooth@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org
References: <20250212-wilc3000_bt-v1-0-9609b784874e@bootlin.com>
 <20250212-wilc3000_bt-v1-1-9609b784874e@bootlin.com>
 <20250213-chamois-of-unexpected-glory-dd3eab@krzk-bin>
 <99247019-bb41-4fd9-bc0c-d31e5688533b@bootlin.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <99247019-bb41-4fd9-bc0c-d31e5688533b@bootlin.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 13/02/2025 16:25, Alexis Lothoré wrote:
> Hi Krzysztof,
> 
> On 2/13/25 10:25, Krzysztof Kozlowski wrote:
>>> +  wlan:
>>> +    $ref: /schemas/types.yaml#/definitions/phandle
>>> +    description:
>>> +      Phandle to the wlan part of the combo chip
>>
>> No resources here and judging by the driver everything is part of wifi.
>> Either you wrote it to match driver or indeed hardware is like that. In
>> the first case, why this cannot be part of WiFi with phandle to serial
>> bus? In the second case, this needs to be proper hardware description
> 
> First, I'd like to reclarify what the chip exactly is, to make sure that we are
> talking about the same thing. The wilc3000 ([1]) is a single physical device
> packaging two different discrete modules inside (one for 802.11, one for
> bluetooth). The WLAN part has its own binding integrated in upstream kernel
> ([2]) and is based on a similar chip in the same family (wilc1000, which only
> have 802.11, and so only SPI/SDIO, no UART).
> 
> Now that it is said, no, I did not write this binding only aiming to match the
> new driver. I tried to base this description on how similar WLAN/BT combo chips
> are usually described (based on those which have existing bindings), and they
> seem to describe distinctly the two internal parts of those chips as well. For


Yes, because BT part is isolated enough that you datasheet tells which
resources belong to it and DT describes these resources.

You do not have any resources here.

> those who use HCI commands over uart for the bluetooth part, they expose a
> dedicated child node of a serial controller (distinct from the wlan part,
> described as another node on PCI/SDIO/SPI/etc). The hardware architecture for
> wilc3000 is similar to those, so since the serial bus is the primary interface
> to operate the bluetooth part inside the chip, doesn't it makes sense to have it
> under a serial controller node (and then to refer to wlan for the additional
> operations needed on sdio/spi), than the other way around ?


There is little benefit in describing one device in two places. This
even lead to probe ordering issues and power sequencing problems, for
example being explicitly addressed by recent power sequencing work from
Bartosz by creating *third* node...

You have no resources here, so I cannot even imagine inventing something
in that third (PMU) node.

But anyway in case of WCN devices, the reason of power sequencing
patches, BT and WiFi are separate, can be enabled separately, can be
even shipped one without another (I think).

Not your case. Your BT needs WiFi to load firmware.

> 
> About the lack of other resources in the new node: there are indeed additional
> resources that affect bluetooth, but I am not sure how it should be handled:

You sent us then incomplete hardware description. So you got review like
this.

> there are for example a reset input and a chip enable input exposed by this
> chip, which in fact do not only affect the WLAN part but the two parts inside
> the chip. But those are currently described and handled by the WLAN part. I

So everything is already defined in WiFi part and this node is not
really necessary.

> guess that an improvement regarding this point could then be to move those out
> of the wlan binding, and find a way to describe it as shared resources between
> those two parts of the chip, but how should it be handled ? Is it ok to remove
> those from an existing binding (and if so, where to put those ? It is not
> bluetooth specific neither) ? Is the issue rather about current WILC3000 binding
> kind of mixing overall chip description and internal wlan part description ?


Datasheet shows this as one device, not two, not three.

Reset and chip enable, based on datasheet, are not specific to BT. They
reset/enable entire chip, I assume, so it is even better proof that your
HW description is not correct.

How this device is supposed to work if you do not enable WiFi - do not
deassert reset from Wifi driver? BT will stay in reset. Really, and
that's correct hardware representation?

This is exactly the power sequencing problem one more time and you keep
asking exactly the same questions and repeating exactly the same
mistakes. This is incomplete and, IMO, incorrect hardware description.

Read all previous discussions, read/listen/watch the talks about power
sequencing (there were two on LPCs - one with Abel to describe the
problem, year later to solve it).


Best regards,
Krzysztof

