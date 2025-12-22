Return-Path: <linux-wireless+bounces-30044-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 0E42DCD595C
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 11:27:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id DFB643015AB2
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Dec 2025 10:23:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9352D32AAA5;
	Mon, 22 Dec 2025 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6sC2Icn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60269329E65;
	Mon, 22 Dec 2025 10:23:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766399005; cv=none; b=gmpR8UYaEMq9iEt3qn4jB0+xiLWNr89z9Xef6cFDdsUrZk04gQ02sCSZwWshD51GnKoRhiKV7OPDaH+M3qnsA1sVb5EVmrxOzl4P0BluEx+D+oecuWKQ/UjVVfUTln77fAyP77JQJ5MwTom5C2c33lEGgH066WECEEvS7uQpfBc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766399005; c=relaxed/simple;
	bh=FWAzzIL1x1PVb5pw3WRq7KOwgjGFCl6UQKfwo1uVKc0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=cdrR8MQlK9c/ECFCElPXdu7TTJH1qanbDLGmcE56ktnwWURBkYZgaUUqtU+0+4iW7lSfzrUPGXlKJ5IZhUMUBfBrm3zXQrjh0glW0tlZzCxPB2HXymv0e6shjL5wFkkWCHUQC82naNJubwKfgla5g3Xv6A6+RUJnBLW63qSZRKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6sC2Icn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 06207C4CEF1;
	Mon, 22 Dec 2025 10:23:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766399005;
	bh=FWAzzIL1x1PVb5pw3WRq7KOwgjGFCl6UQKfwo1uVKc0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=W6sC2IcnGt71ZuEzFn7MTJ1rEEbh9mKgXHqAPPCWUdldtNqvlcVWixNcjVm5Eik0F
	 eSXvXLLEciWBV8hJYFtCVePMBiFkkhYWC/bkDYyeW7RghoZH0nJBsWTISXH4VNAOYF
	 yOTYfti6RyDab3wgQwkyy4SIMNB5MJeZseAuvsyM3rZoh5UIVlgTCjqSxFHkmRt+gH
	 G93m47K3btiYtzavzG0INPh7iU7fGO9XMazOuYPMQW8ZEzzxkEmA54utKlvC19keww
	 oAXOZ3ILDjmAimwFm7PiFfqFVAE3gQ3v0ox4gy50qkWFWHzlV3ru5gXR+2Ui9k/7Gi
	 POjGFbhai9UPA==
Message-ID: <c29de60c-c7c6-45d7-8d90-616df23df01c@kernel.org>
Date: Mon, 22 Dec 2025 11:23:18 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v5 2/7] dt-bindings: wireless: ieee80211: Add
 disable-rfkill property
To: Bryan O'Donoghue <bod.linux@nxsw.ie>, jerome.debretagne@gmail.com,
 Bjorn Andersson <andersson@kernel.org>,
 Konrad Dybcio <konradybcio@kernel.org>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>, Conor Dooley
 <conor+dt@kernel.org>, Johannes Berg <johannes@sipsolutions.net>,
 Lorenzo Bianconi <lorenzo@kernel.org>,
 Maximilian Luz <luzmaximilian@gmail.com>,
 =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
 Jeff Johnson <jjohnson@kernel.org>, Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
 platform-driver-x86@vger.kernel.org, ath12k@lists.infradead.org,
 Jeff Johnson <jeff.johnson@oss.qualcomm.com>, Dale Whinham <daleyo@gmail.com>
References: <20251220-surface-sp11-for-next-v5-0-16065bef8ef3@gmail.com>
 <M7kfFb5fz-WB43U_xCUwgxpmBJ4TNdp4jE6yFu6HmemIcDx5tXO6H4xnW_pEQz6DMkKm-3POdB9hIdB092zhGQ==@protonmail.internalid>
 <20251220-surface-sp11-for-next-v5-2-16065bef8ef3@gmail.com>
 <e0e9e690-c56e-4b56-90f9-2af46a7feaf3@nxsw.ie>
From: Hans de Goede <hansg@kernel.org>
Content-Language: en-US, nl
In-Reply-To: <e0e9e690-c56e-4b56-90f9-2af46a7feaf3@nxsw.ie>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

+Cc Mani

Hi,

On 20-Dec-25 07:04, Bryan O'Donoghue wrote:
> On 20/12/2025 00:21, Jérôme de Bretagne via B4 Relay wrote:
>> From: Jérôme de Bretagne <jerome.debretagne@gmail.com>
>>
>> For some devices, Wi-Fi is entirely hard blocked by default making
>> the Wi-Fi radio unusable, except if rfkill is disabled as expected
>> on those models.
>>
>> Commit c6a7c0b09d5f ("wifi: ath12k: Add Support for enabling or
>> disabling specific features based on ACPI bitflag") added a way to
>> support features set via ACPI, including the DISABLE_RFKILL bit.
>>
>> Add a disable-rfkill property to expose the DISABLE_RFKILL bit
>> equivalent for devices described by a Devicetree instead of ACPI.
>>
>> Signed-off-by: Jérôme de Bretagne <jerome.debretagne@gmail.com>
>> ---
>>   Documentation/devicetree/bindings/net/wireless/ieee80211.yaml | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
>> index d89f7a3f88a71d45d6f4ab2ae909eae09cbcaf9a..c10a4675640be947cd0b5eaec2c7ff367fd93945 100644
>> --- a/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
>> +++ b/Documentation/devicetree/bindings/net/wireless/ieee80211.yaml
>> @@ -29,6 +29,12 @@ properties:
>>         different 5 GHz subbands. Using them incorrectly could not work or
>>         decrease performance noticeably
>>
>> +  disable-rfkill:
>> +    type: boolean
>> +    description:
>> +      Disable rfkill for some devices on which Wi-Fi would be entirely hard
>> +      blocked by default otherwise
>> +
>>   additionalProperties: true
>>
>>   examples:
>>
>> -- 
>> 2.47.3
>>
>>
>>
> 
> Is this really a hardware description though ?

I would say yes it is. The wifi chip has an rfkill input pin and
things will be broken when that pin is hardwired to a fixed value
rather then being actually connected to a GPIO from say
the embedded controller.

So I think that we would need here is not a disable-rfkill property
but some way to indicate in the DT-node that the rfkill input pin
is not connected and thus should be ignored.

This (the rfkill input pin being not-connected) IMHO very much
is hw-description.

Also see the
"[PATCH 0/9] Add support for handling PCIe M.2 Key E connectors in devicetree"
series and then specifically:

https://lore.kernel.org/platform-driver-x86/20251112-pci-m2-e-v1-7-97413d6bf824@oss.qualcomm.com/

Which adds:

+  w_disable1-gpios:
+    description: GPIO controlled connection to W_DISABLE1# signal. This signal
+      is used by the system to disable WiFi radio in the M.2 card. Refer, PCI
+      Express M.2 Specification r4.0, sec 3.1.12.3 for more details.
+    maxItems: 1

What if there is no such GPIO, because the W_DISABLE1# signal is hardwired
in a specific implementation of the M.2 slot ?

In that case we will also need some way to propagate that info to the wifi
driver, having some sort of generic devicetree property for wifi-cards
which can be injected as a software-node property in the PCI-device being
instantiated for the WIFI card to let the driver no not to honor to
W_DISABLE1# signal will be useful here too and this is as hardware-description
as hardware-description can get.

So how about: "w_disable1-not-connected" + "w_disable2-not-connected" boolean
properties in a generic WIFI devicetree binding and also use that here?

> I think this logic belongs in drivers/net/wireless/ath/ath12k/ triggering on a compat string.

See above, I do not believe that abusing compat-strings for this is the way
to go.

Regards,

Hans



