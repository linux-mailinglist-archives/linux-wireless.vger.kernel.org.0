Return-Path: <linux-wireless+bounces-12126-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7BD219621A6
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 09:48:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 37BE6282668
	for <lists+linux-wireless@lfdr.de>; Wed, 28 Aug 2024 07:48:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 74B1C15921B;
	Wed, 28 Aug 2024 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="FYonrL2P"
X-Original-To: linux-wireless@vger.kernel.org
Received: from relay7-d.mail.gandi.net (relay7-d.mail.gandi.net [217.70.183.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06751157A67;
	Wed, 28 Aug 2024 07:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.70.183.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724831288; cv=none; b=fxMdDrK3ODa0NCWRYfePzuZVkim+kU5TgJ8atJsrTx2wjdq/Hmt6wbzsHwRfx1G/DPv2oMeR1qsOuxj4O57wBs8Fri1hon+kua1l4uATYizJAxLmaoMKeWZYfMBhek1ZZ9uCzIn4xgbyvvCeh93wUc3AYoB36lqnu5xddlN/f34=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724831288; c=relaxed/simple;
	bh=SYYKQg9vKwBUvAgFk2eRCRQpOKTBGlmxBEfLcYlU4UA=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=k/j2KZcPdMPusrf1HLfHFj1EIjVZluDQMBr+YKqcbcBsZxDwjiyjwqUY5ONyDy8a0naZscPlU0xtzoJ1XH6eHmEXAlCmYimTs1VENKnUeJtw+aWRU4qcm5BFTXaw0qKugeBz4k6A5d3AKEZ25bYerkO6kC5Ck3gHOI5/uP2E5xE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=FYonrL2P; arc=none smtp.client-ip=217.70.183.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id 2136F20008;
	Wed, 28 Aug 2024 07:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
	t=1724831284;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6r+JuDb9XhBus5ZFw2eCxv7bB0sqq0Ha2zLM/04HK34=;
	b=FYonrL2Px47cjelbzY0drB6IAR72KbFgQ0CfRB4xg1AZrKCgR1b3Fu+ESpfaymsGaMIG2l
	TMLsQZfVaYBY8gptVsK1fiRCv8C4hSxkZIwjd9IT/lpsxms5grv8A1LiPB+OtoZgaPFa66
	2G4sp4G5GXhvTDdFoMWNR+G4jdT4luttSex6C45+TAmpxpraI5uLus9vj/CiclRptLnKSz
	mk4cmggeJCbkHYQnbf6VlfgggYRvr+yvD3BjIDulTrLL+uWRYDHMnUaUYuXip4KtdDfaYT
	Rw1durvT07zKEINfBHseCSUpn5d3cdvSbFriyO5O2jAZQZla9E+z0SdzwY6ncQ==
Message-ID: <2f84827c-bbe9-419a-a3f4-71a8889e99d0@bootlin.com>
Date: Wed, 28 Aug 2024 09:48:02 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 2/4] wifi: wilc1000: Fold wilc_get_chipid() into wlan.c
To: Marek Vasut <marex@denx.de>, linux-wireless@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240823161131.94305-1-marex@denx.de>
 <20240823161131.94305-2-marex@denx.de>
 <2b167618-473a-4da1-9c10-cba2b9051381@bootlin.com>
 <182e449a-3e6d-4727-a538-6fd518ae75f8@denx.de>
From: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>
Content-Language: en-US
In-Reply-To: <182e449a-3e6d-4727-a538-6fd518ae75f8@denx.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-GND-Sasl: alexis.lothore@bootlin.com

On 8/27/24 17:34, Marek Vasut wrote:
> On 8/27/24 9:51 AM, Alexis Lothoré wrote:
> 
> Hi,
> 
>>> +static u32 wilc_get_chipid(struct wilc *wilc)
>>> +{
>>> +    u32 chipid = 0;
>>> +    u32 rfrevid = 0;
>>> +
>>> +    if (wilc->chipid == 0) {
>>> +        wilc->hif_func->hif_read_reg(wilc, WILC_CHIPID, &chipid);
>> If we search for WILC_CHIPID in the whole driver, there are still two places
>> manually reading this register. Shouldn't those places also benefit from
>> wilc_get_chipid ?
> 
> Both the one in wilc_wlan_start() and wilc_validate_chipid() look more like some
> sort of communication check attempt, rather than reading out the chipid for any
> sort of actual chip identification purpose. I could simply remove those ?

Agree about the purpose of this reading in wilc_wlan_start and wilc_validate_chipid.
And about removing those: I would say why not. wilc_validate_chipid has proven
to be quite useful to diagnose some early communication failure, but I guess
there are enough communications attempts around
(wilc_spi_configure_bus_protocol, wilc_load_mac_from_nv) to still validate than
we are able to communicate with the chip at probe time.
> 
>>> +        wilc->hif_func->hif_read_reg(wilc, WILC_RF_REVISION_ID,
>>> +                         &rfrevid);
>>> +        if (!is_wilc1000(chipid)) {
>>> +            wilc->chipid = 0;
>>
>> While at it, since you have trimmed the update parameter, it would be nice to
>> also fix this return value (ie make wilc_getchipid() not return 0 but a real
>> error code if we can not read the chip id.
> 
> Fixed in V3, thanks .

Great, thanks

Alexis

-- 
Alexis Lothoré, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com


