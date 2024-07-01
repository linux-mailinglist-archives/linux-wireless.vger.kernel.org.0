Return-Path: <linux-wireless+bounces-9750-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 09B3191DA3C
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 10:42:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 59089B21DB9
	for <lists+linux-wireless@lfdr.de>; Mon,  1 Jul 2024 08:42:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E743D83A18;
	Mon,  1 Jul 2024 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UkoFlXfJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3131824B1;
	Mon,  1 Jul 2024 08:41:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719823299; cv=none; b=dEQlXb0QS68aqNhhjm4gep5AwF8hm9T2qqbvI+OaNPEJneTbR7Adl9Rvs8v+mTVEsHaRCiyFOMciXUMWUD26ugnKdmQKxnulNpG4Ma4O3QzaEwCgogCmOv8dbm6CoKf5dLrmpjL9nCO2FKX5TL4Wy4F7Ua+A8E70Li+AiU0ZwOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719823299; c=relaxed/simple;
	bh=hg+g7DiLnSzkTsvXjpWJRV2heN5XuuVLmYBc59TNCUg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=eH6X42MPFze4Wc7MrBSH2AwFXHwYwfZaG4r6lywHE0zTMHizDo/9htARk0jtdUoXJ2CgfaHU6no7YC6iyB4DTlYLuuYLv+oI0TNzXcyT1K4VPDm+5oxWF+JFuMdfQSplPgIuozm1BXXuxSLKJtoTZgz1cuJow3rqVxHiKBAO3rQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UkoFlXfJ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5590C116B1;
	Mon,  1 Jul 2024 08:41:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719823299;
	bh=hg+g7DiLnSzkTsvXjpWJRV2heN5XuuVLmYBc59TNCUg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=UkoFlXfJsZhhnKX24BRkCiNKND2UWpXS+xqQonjFz3XLkR2/9BMFdGS3e8wdZAWOo
	 0XB+jbnH85jecYk9bhvMNOCFQ8C00l1fV6D3izX8vOCFvhnKR+vAmcelDVOd5q2Nu2
	 ydZ5yqd0PiJ2PyzAA55nwTiKAs2uchDveGeBlhgDXptedtSsNJh7yMobx53X+/OD4G
	 mUW4pM2OJzeHsSSq82mAdy5s+5Yw5c6KSz9dPrmsyi4Gg9k3ApexKHgO4OqTQOLzax
	 RvUCc+ZNtc0K95iaRnksSBJ7fZ9E77n9OGKOAGIXuL35lHUvLHGvnaf6oSWUpeCe1r
	 LQYq+T7Bzxs4A==
Message-ID: <3fe026a2-a8d6-4688-863f-1237e71945ea@kernel.org>
Date: Mon, 1 Jul 2024 10:41:30 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/5] arm64: dts: rockchip: Add AP6275P wireless support
 to Khadas Edge 2
To: Jacobe Zang <jacobe.zang@wesion.com>,
 "arend.vanspriel@broadcom.com" <arend.vanspriel@broadcom.com>
Cc: "kvalo@kernel.org" <kvalo@kernel.org>,
 "duoming@zju.edu.cn" <duoming@zju.edu.cn>,
 "bhelgaas@google.com" <bhelgaas@google.com>,
 "minipli@grsecurity.net" <minipli@grsecurity.net>,
 "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
 "brcm80211@lists.linux.dev" <brcm80211@lists.linux.dev>,
 "brcm80211-dev-list.pdl@broadcom.com" <brcm80211-dev-list.pdl@broadcom.com>,
 "megi@xff.cz" <megi@xff.cz>, "robh@kernel.org" <robh@kernel.org>,
 "efectn@protonmail.com" <efectn@protonmail.com>,
 "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
 "conor+dt@kernel.org" <conor+dt@kernel.org>,
 "heiko@sntech.de" <heiko@sntech.de>, Nick Xie <nick@khadas.com>,
 "jagan@edgeble.ai" <jagan@edgeble.ai>,
 "dsimic@manjaro.org" <dsimic@manjaro.org>,
 "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
 "linux-arm-kernel@lists.infradead.org"
 <linux-arm-kernel@lists.infradead.org>,
 "linux-rockchip@lists.infradead.org" <linux-rockchip@lists.infradead.org>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <20240624081906.1399447-1-jacobe.zang@wesion.com>
 <20240624081906.1399447-2-jacobe.zang@wesion.com>
 <258459b8-549b-4a63-8d33-76c9631483f1@kernel.org>
 <TYZPR03MB7001D4DE507C919802B2F7F380D52@TYZPR03MB7001.apcprd03.prod.outlook.com>
From: Krzysztof Kozlowski <krzk@kernel.org>
Content-Language: en-US
Autocrypt: addr=krzk@kernel.org; keydata=
 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 fv0=
In-Reply-To: <TYZPR03MB7001D4DE507C919802B2F7F380D52@TYZPR03MB7001.apcprd03.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

On 25/06/2024 10:04, Jacobe Zang wrote:
>>> diff --git a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
>>> index 3b6286461a746..f674deb6f7da8 100644
>>> --- a/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
>>> +++ b/arch/arm64/boot/dts/rockchip/rk3588s-khadas-edge2.dts
>>> @@ -356,6 +356,22 @@ &pcie2x1l2 {
>>>         reset-gpios = <&gpio3 RK_PD1 GPIO_ACTIVE_HIGH>;
>>>         vpcie3v3-supply = <&vcc3v3_pcie_wl>;
>>>         status = "okay";
>>> +
>>> +     pcie@0,0 {
>>> +             reg = <0x400000 0 0 0 0>;
>>> +             #address-cells = <3>;
>>> +             #size-cells = <2>;
>>> +             ranges;
>>> +             device_type = "pci";
>>> +             bus-range = <0x40 0x4f>;
>>
>> Isn't bus-range a property of PCI host bridge, so the parent? This is a
>> PCI device, right?
>>
>>> +
>>> +             wifi: wifi@0,0 {
>>
>> Binding does not say anything about this. Rockchip PCI controller is the
>> PCI host bridge, isn't it? Then the pci@0,0 is the child, so what is this?
> 
> The host bridge is the parent of pcie@0,0. And pcie@0,0 is Bridge1, so the

Do you want to say Rockchip PCI is PCI-PCI bridge? Bindings do not allow it.

> wifi@0,0 as a device under the Bridge1.
> 
>>
>>> +                     reg = <0x410000 0 0 0 0>;
>>> +                     clocks = <&hym8563>;
>>> +                     clock-names = "32k";
>>
>> 1. Bindings are before the users.
>> 2. Where is the compatible? Are you sure this validates?
> 
> Before, the compatible is "pci14e4,449d", but when I checkpatch the warning
> said that "pci14e4" was not documented, so I remove the compatible which 
> doesn't affect the Wi-Fi function. I have tried to add "pci14e4" to 
> vendor-prefixes.yaml but was refused. So whether should I add the compatible 
> with warning? 

I talk about dtbs_check, not checkpatch. That checkpatch warning does
not matter, obviously.

Best regards,
Krzysztof


