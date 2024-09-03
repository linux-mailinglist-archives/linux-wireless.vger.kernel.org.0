Return-Path: <linux-wireless+bounces-12408-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id AF84796A765
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 21:32:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6C54328400E
	for <lists+linux-wireless@lfdr.de>; Tue,  3 Sep 2024 19:32:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7FAD11D7E4E;
	Tue,  3 Sep 2024 19:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b="lZ77E8Fx"
X-Original-To: linux-wireless@vger.kernel.org
Received: from phobos.denx.de (phobos.denx.de [85.214.62.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8CC41D7E48;
	Tue,  3 Sep 2024 19:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=85.214.62.61
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725391933; cv=none; b=jI9pF7NHtJvFLqRtmgvCqK3lJJOoMkroJTk3auWep6YXbaXgJNPyL11TmbsrzHxNR57DIt1U8IcokdkT2iK0otnYSoglCnrxdJ9nxBleJIaX2P3B5o2JIGY2JtMbevDzQSBBOUh8GlatiWCSaunxeHVcC26EZJCHU3ieWTmEays=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725391933; c=relaxed/simple;
	bh=8MLINbjMjqhdCMB4oHAJTmm2kpqKjua9hh+xhjX/6rY=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=WWBXOOdykD5Q3ZT/VXn8L7wxYZ9EU0TbBNitYxKsFy0ZB2KT/ySB8XLqMbtCzMW7xJDEM633UH/AfDwVeNpFRZuUDxu6MMY+mK+BlihVd1mhp5I4F35XLqbQf91HIYbSeIvlHJ0St6pdzLEOC2qu3/PQKhFO/oJ5WLI73olU0Ik=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de; spf=pass smtp.mailfrom=denx.de; dkim=pass (2048-bit key) header.d=denx.de header.i=@denx.de header.b=lZ77E8Fx; arc=none smtp.client-ip=85.214.62.61
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=denx.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=denx.de
Received: from [127.0.0.1] (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits))
	(No client certificate requested)
	(Authenticated sender: marex@denx.de)
	by phobos.denx.de (Postfix) with ESMTPSA id 77B8B88327;
	Tue,  3 Sep 2024 21:32:07 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
	s=phobos-20191101; t=1725391928;
	bh=wAAGGYTcJTdpi12h28wfzT/1+6+AXdlZu8G4suh51LQ=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=lZ77E8FxWp7XsQ0t0sCuLVsNCo3zYdstE9SpyH/codX9JZWniDiVYtPiIxzdleJ1V
	 0aEf+eWlKzRyREzdSCP/PbeKbC0jt+WpQs5y4k8e1OON17VkVnUp+1d9hLgwsiqIQB
	 yF7GaK0/8lf9mO/vXonSX+KEimur/Wp2a8iLSOVorOS34p8VpqqCCMxcc9Fbq0CUUm
	 OEhcJ9g0DiGaqXRz04D3QFyQwrbeouqtZ2wFI/SJjPj53AFLLZ55PVvDzB3RHcpn+d
	 zWoxvEbb2KDw2XGThEwssXIaYu/lnNxWaalB2idUR91RsCnBTsNCaYDG1Z0xsNlsol
	 LN+mKzFkRJFjw==
Message-ID: <57a7eac4-23c7-42ac-ade5-233c24a288c6@denx.de>
Date: Tue, 3 Sep 2024 21:30:28 +0200
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
Content-Language: en-US
From: Marek Vasut <marex@denx.de>
In-Reply-To: <52e7b6d2-5d31-4ae1-bf1d-44e63a22774d@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: clamav-milter 0.103.8 at phobos.denx.de
X-Virus-Status: Clean

On 9/3/24 6:09 PM, Alexis Lothoré wrote:
> Hello everyone,

Hi,

> On 8/29/24 02:44, Marek Vasut wrote:
>> Document compatible string for the WILC3000 chip. The chip is similar
>> to WILC1000, except that the register layout is slightly different and
>> it does not support WPA3/SAE.
>>
>> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Signed-off-by: Marek Vasut <marex@denx.de>
> 
> [...]
> 
>>   .../bindings/net/wireless/microchip,wilc1000.yaml           | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
>> index 2460ccc082371..5d40f22765bb6 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
>> +++ b/Documentation/devicetree/bindings/net/wireless/microchip,wilc1000.yaml
>> @@ -16,7 +16,11 @@ description:
>>   
>>   properties:
>>     compatible:
>> -    const: microchip,wilc1000
>> +    oneOf:
>> +      - items:
>> +          - const: microchip,wilc3000
>> +          - const: microchip,wilc1000
>> +      - const: microchip,wilc1000
>>   
>>     reg: true
> 
> Following this series first revision, I have been taking a look at how to
> implement bluetooth feature for wilc3000 (the chip supports Bluetooth LE through
> a separated UART, see [1]), and I am facing some constraints. I feel like the
> possible solutions would conflict with this new binding, so even if I am a bit
> late to the party, I would like to expose the issue before the binding is merged
> in case we can find something which would allow to add bluetooth support without
> too much pain after the wlan part.
> 
> Downstream driver currently does not implement bluetooth as a standard bluetooth
> driver (module in drivers/bluetooth, registering a HCI device) but only performs
> a minimal set of operations directly in the wlan part ([2]). Getting a version
> valid for upstream would need the following points to be addressed:
> 1. despite being controlled from a serial port for nominal operations, the
> bluetooth part also depends on the "wlan" bus (spi or sdio) for initialization
> 2. yet init steps are not performed on any kind of subsystem ops but through
> writes to a custom chardev
> 3. the driver does not register itself a hci interface, it is expected to be
> done by userspace (hciattach).
> 
> It is only after those 3 steps that the chip can be used with standard hci
> commands over serial port. IMHO 1 is the biggest point, because it means that
> **a bluetooth driver for wilc3000 needs access to the bus used by wlan part**
> (so only describing the bluetooth part of the chip as a child node of an uart
> controller is not enough). Aside from bus access, I also expect some
> interactions between bluetooth and wifi (eg: power management, sleep/wakeup)

Just a quick idea -- what about having a phandle to the BT UART node in 
the wilc3000 node ? Then the wilc driver can check if the phandle is 
available and valid, and attach the BT part to the UART, while also 
doing all the necessary power sequencing and bus accesses via SDIO/SPI.

Like this:

&uart10 {
   status = "okay";
};

&mmc20 {
   ...
   wifi@0 {
     compatible = "microchip,wilc1000";
     microchip,bt-uart = <&uart10>; // OPTIONAL
     ...
   };
};

