Return-Path: <linux-wireless+bounces-12505-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6529296C5FC
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 20:08:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0DE731F22EFE
	for <lists+linux-wireless@lfdr.de>; Wed,  4 Sep 2024 18:08:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639201E1324;
	Wed,  4 Sep 2024 18:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="MHnz3neW"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9ED7E2AE9F;
	Wed,  4 Sep 2024 18:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725473311; cv=none; b=ZbXh5O89hZ3UbPeNoO12Voj94T9u4Kz//K3s3f+saOxysghbByIxsBN051Im4K6AUNx9sZ7jh4l9rwnG4yY4U0FnbQ5GS/x4ALTbWTjcYv0c/0v5ap5lpdqWTB5KG4xvPTocnbYwgsHA4QF1NGG9lYvflMYrWvMRsvdsy3YSlVU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725473311; c=relaxed/simple;
	bh=Crs52THU8yXegVqfzdcrWE1nNmneQ2UQDe+hTPfQh1M=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=I1o9OTQgGCzekxklsn+F4b7P8Xnt0BBP15urEEfG50b1hJka36MelPzpnBUzmJvevqPPYtCSgh7J3KINcrLO6wqLU3sIh/epa9lm8ml7T/c5gdS7+TbZyNTYY/8gBC8DaxLUw6Mr3i2B5i+uq0mCK9knpUjM59Z88xdL6mgKyiA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=MHnz3neW; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id B9D0888B67;
	Wed,  4 Sep 2024 20:08:20 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725473302;
	bh=L18sf0D+NFLPea49QaTj6x+Tw7vEHatae6RqHf4EagU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=MHnz3neWlfnxeOV9Xw46uLobn1Bnc104W0Lm3DX6ZnWYVpzABX3kAHuZImk+2b3mD
	 5vI7fINA0tVbwvBDXhv+uDstOAWHRNgTfOK6Gc1KwVbvZcDEsBXpZEWZgUoAud70xp
	 1/Tkbe7c0VN5REww/K9yNTDfdMzdZ8eZg3BndE3YCvTqoU7tJq279jST1vLddsKeqG
	 32NVIBcDJKVohxmnysYHYnv9HdzLy4HmdeblUs9FkSaGUvTHTdW+kVdu7p9q/jZ6Br
	 KWYZb0iR17gvRWSXgspu/l0++2rS9UN3pn911TSkHsJZSk9AfIw0teFTeT8ZehaFLk
	 g9Jyd+54WjCuQ==
Message-ID: <6d73f3da-315b-485c-a1d5-03d5ea378922@denx.de>
Date: Wed, 4 Sep 2024 19:45:44 +0200
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 1/5] dt-bindings: wireless: wilc1000: Document WILC3000
 compatible string
To: =?UTF-8?Q?Alexis_Lothor=C3=A9?= <alexis.lothore@bootlin.com>,
 linux-wireless@vger.kernel.org
Cc: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
 "David S. Miller" <davem@davemloft.net>,
 Adham Abozaeid <adham.abozaeid@microchip.com>,
 Ajay Singh <ajay.kathat@microchip.com>,
 Claudiu Beznea <claudiu.beznea@tuxon.dev>, Conor Dooley
 <conor+dt@kernel.org>, Eric Dumazet <edumazet@google.com>,
 Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Paolo Abeni <pabeni@redhat.com>,
 Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
 netdev@vger.kernel.org
References: <20240829004510.178016-1-marex@denx.de>
 <52e7b6d2-5d31-4ae1-bf1d-44e63a22774d@bootlin.com>
 <57a7eac4-23c7-42ac-ade5-233c24a288c6@denx.de>
 <95ae0eb6-72ec-4261-b9e1-8ee3e831452e@bootlin.com>
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <95ae0eb6-72ec-4261-b9e1-8ee3e831452e@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/4/24 4:50 PM, Alexis Lothoré wrote:
> Hello Marek,

Hi,

>>> It is only after those 3 steps that the chip can be used with standard hci
>>> commands over serial port. IMHO 1 is the biggest point, because it means that
>>> **a bluetooth driver for wilc3000 needs access to the bus used by wlan part**
>>> (so only describing the bluetooth part of the chip as a child node of an uart
>>> controller is not enough). Aside from bus access, I also expect some
>>> interactions between bluetooth and wifi (eg: power management, sleep/wakeup)
>>
>> Just a quick idea -- what about having a phandle to the BT UART node in the
>> wilc3000 node ? Then the wilc driver can check if the phandle is available and
>> valid, and attach the BT part to the UART, while also doing all the necessary
>> power sequencing and bus accesses via SDIO/SPI.
>>
>> Like this:
>>
>> &uart10 {
>>    status = "okay";
>> };
>>
>> &mmc20 {
>>    ...
>>    wifi@0 {
>>      compatible = "microchip,wilc1000";
>>      microchip,bt-uart = <&uart10>; // OPTIONAL
>>      ...
>>    };
>> };
> 
> I thought about something like this too, indeed (but somehow inverted, a
> reference to wilc node in the bt node under uart, to allow the bluetooth part to
> ask wilc to perform operations over sdio/spi). The design would likely be
> simpler in this case, but some internal discussions with colleagues raised some
> concerns, for example with power management (but Krzysztof's suggestion about
> power sequencing may help with this).

Maybe switching the current WILC power management to runtime PM would 
simplify things greatly ?

