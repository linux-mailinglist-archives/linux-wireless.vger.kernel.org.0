Return-Path: <linux-wireless+bounces-26851-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7E2F7B3B2D4
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 08:02:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0B59C56718E
	for <lists+linux-wireless@lfdr.de>; Fri, 29 Aug 2025 06:02:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2E5042222C2;
	Fri, 29 Aug 2025 06:02:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hRHBBg7U"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECC978BEC;
	Fri, 29 Aug 2025 06:02:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756447339; cv=none; b=ZHy5ANXRTESJUymW2PUu6KPW2md+Siq0cqDBvCN+nF1xiDTzuL+pCpPfJVDw+vyEYBeFfhdad8fTmlbZAY70hY9LkEgIVAJLmeGQRESjnrjsfZwGvJjmmWZ5B0cZnUk1/rB4VBmDtWDiPxYFYWo+vawdnyGezLVzNbe6FKOemsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756447339; c=relaxed/simple;
	bh=CHDqkqR9nbgZKIPxjlF/BFOGfYkYhOwRU6kB1fm7RgI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=tUiIBmNT0xWmWJPTiE02PrXWwynwjXZsjMXfaHIH/OZc4fL3/Js46Kp6Qx058CDo7VdUlrX+8A38Qwqy+IVdWA9ZC6PaCFGE8VW7o1sXk2oZsMAA/bMpx5aY+/G2ZyDcmNPE8rTePGfuyUzggObx50EX/rQZfY3ODYSWwKp37C8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hRHBBg7U; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B0A7FC4CEF0;
	Fri, 29 Aug 2025 06:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1756447337;
	bh=CHDqkqR9nbgZKIPxjlF/BFOGfYkYhOwRU6kB1fm7RgI=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=hRHBBg7UQYDXKjmmMKaBw+xg2MayiKXfEpbiD8pJktAhaDewOHpw3wQ6U+HYKTnQT
	 QnGyObtyYNP8WokwWtiEWLpHcreBZmPcKbNWBtmwGbdG1JOQhfUSwHWWvTltlHsRug
	 QQDRPps772goqfuW9+qaFDffdrYwM4SE7WWrwJLhSwJra85zlxxNIAZrJcraDGeXUC
	 dvkITYtGDmYfyrl/JOXwck4aO6Yy1VubZRW0p2YmbUlm2mvXgqZPqt9v34K4q58Sk5
	 qXBHe4c2lXooNW00q7R+JDmdAe41iHyDvV5Z0XcakOboLPU/M2shx08MqFtpV0KSPd
	 8jzuh8rnp3Aug==
Message-ID: <9208c440-f9e3-4289-9c33-81bb35383d53@kernel.org>
Date: Fri, 29 Aug 2025 08:02:12 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv4 1/3] dt-bindings: net: wireless: ath9k: add led bindings
To: Rosen Penev <rosenp@gmail.com>, "Rob Herring (Arm)" <robh@kernel.org>
Cc: Johannes Berg <johannes@sipsolutions.net>, devicetree@vger.kernel.org,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
 linux-kernel@vger.kernel.org, Conor Dooley <conor+dt@kernel.org>,
 linux-mips@vger.kernel.org, linux-wireless@vger.kernel.org,
 =?UTF-8?Q?Toke_H=C3=B8iland-J=C3=B8rgensen?= <toke@toke.dk>
References: <20250827005658.3464-1-rosenp@gmail.com>
 <20250827005658.3464-2-rosenp@gmail.com>
 <175638709817.1370637.10754263567298002001.robh@kernel.org>
 <CAKxU2N-Zfme=84rqxQ=uJro1YMeFGorveT-uRhx6_HpJmB-fxA@mail.gmail.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 a/A=
In-Reply-To: <CAKxU2N-Zfme=84rqxQ=uJro1YMeFGorveT-uRhx6_HpJmB-fxA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 29/08/2025 03:47, Rosen Penev wrote:
>> dtschema/dtc warnings/errors:
>> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts:92.15-25: Warning (reg_format): /example-2/ahb/wifi@180c0000/led:reg: property has invalid length (4 bytes) (#address-cells == 2, #size-cells == 1)
>> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts:91.17-94.15: Warning (unit_address_vs_reg): /example-2/ahb/wifi@180c0000/led: node has a reg or ranges property, but no unit name
>> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: Warning (pci_device_reg): Failed prerequisite 'reg_format'
>> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: Warning (pci_device_bus_num): Failed prerequisite 'reg_format'
>> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: Warning (simple_bus_reg): Failed prerequisite 'reg_format'
>> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: Warning (i2c_bus_reg): Failed prerequisite 'reg_format'
>> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: Warning (spi_bus_reg): Failed prerequisite 'reg_format'
>> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts:91.17-94.15: Warning (avoid_default_addr_size): /example-2/ahb/wifi@180c0000/led: Relying on default #address-cells value
>> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dts:91.17-94.15: Warning (avoid_default_addr_size): /example-2/ahb/wifi@180c0000/led: Relying on default #size-cells value
>> Documentation/devicetree/bindings/net/wireless/qca,ath9k.example.dtb: Warning (unique_unit_address_if_enabled): Failed prerequisite 'avoid_default_addr_size'
>>
>> doc reference errors (make refcheckdocs):
>>
>> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20250827005658.3464-2-rosenp@gmail.com
> FFS. These reviews were garbage. The next series will effectively be

What? My and Conor reviews were garbage?

It is your patches which never got tested, code was completely messed up
(see v2 mixing two different things).

I am not going to review your patches.

Best regards,
Krzysztof

