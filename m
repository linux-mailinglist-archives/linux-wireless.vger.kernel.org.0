Return-Path: <linux-wireless+bounces-30847-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id F0B38D27423
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 19:15:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id F08973160D9D
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Jan 2026 17:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 615142D94A7;
	Thu, 15 Jan 2026 17:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b="Rn0jJQKn"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx.nabladev.com (mx.nabladev.com [178.251.229.89])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173563D3014
	for <linux-wireless@vger.kernel.org>; Thu, 15 Jan 2026 17:27:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.251.229.89
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768498042; cv=none; b=MymetQfnDgEYg+r4bg99rpMPKruEvqMyG/SvjNuKBNg0oBeuWujIB/wwQcPxwqRo8B0BJSRqR0fw2FMsApHkAzXT26oFPGWP2EPfFKyGxvYLevrMqJFrS7YszqWwrNkcwq6t6PNFPISnQ2WMcA06gkPbTYaUFkLzhJIiaudne3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768498042; c=relaxed/simple;
	bh=8z5xayW9b9AZjmtqnU8Ak5nx29qez9AFDn5x04HI7uI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=STiCE3c05JTmGWl1mOLhZTBk3pqA6uouxlISp83jBxk8kvfHFNrxrQfz9n4NCfEu9keUR+wZ8dNwKzLatH3oOzTPsral2bm2rUzdmPPuMMWtdJLewviwMj+AAfJMYWsoQADEBjbDcKmsjc631uhTA5HkV4QOwFol48b+AjnA2to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com; spf=pass smtp.mailfrom=nabladev.com; dkim=pass (2048-bit key) header.d=nabladev.com header.i=@nabladev.com header.b=Rn0jJQKn; arc=none smtp.client-ip=178.251.229.89
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nabladev.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nabladev.com
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id DD24110A34B;
	Thu, 15 Jan 2026 18:27:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nabladev.com;
	s=dkim; t=1768498031;
	h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:content-language:in-reply-to:references;
	bh=5/BV4/reyF7KoWnKM9Wy5jPWkAsGrLOyrSr7J7CWU1Y=;
	b=Rn0jJQKnnxSfuz3WOozAKQChGdHqtc3LV6eM90sgQzS/eUnB6cG8qc4l0HiUSOK6IHmMHK
	0hQr5JJouISraYKcHSchqBcsIKI4xFPSmscIZILg6a0kGpYIXttnBsn0SXy9ZJjkj8owp+
	3NHTOAqhoNG747/GYRgE5K5Qr1NnNHY3kEY7egTq5Q/A5NGsWNFJ4pnSab8Nj/BJ4YNp7f
	n+/0/YYciVX+0EdJ07UUh9o+zrPvV4FbhmPUZUeA/vaSnRrG9BS9/iPsOYMGQxAVcma0B1
	UzCjqPgUeGHhcBqgEfWys1g2aBdak7LmdTJYjB2JVkD75rT1SHH+A74ajNDYuQ==
Message-ID: <66e4ddb8-47ac-4b2a-8c4b-6f407aa1d8eb@nabladev.com>
Date: Thu, 15 Jan 2026 18:27:10 +0100
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH wireless-next v2 00/34] wifi: inffmac: introducing a
 driver for Infineon's new generation chipsets
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
Cc: linux-wireless@vger.kernel.org, Johannes Berg
 <johannes@sipsolutions.net>, Arend van Spriel
 <arend.vanspriel@broadcom.com>, wlan-kernel-dev-list@infineon.com
References: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
 <43acfb38-9dbc-4544-b429-dfd43afbf2b6@nabladev.com>
 <aWdP6chPOS0PV-Nc@ISCN5CG14747PP.infineon.com>
Content-Language: en-US
From: Marek Vasut <marex@nabladev.com>
In-Reply-To: <aWdP6chPOS0PV-Nc@ISCN5CG14747PP.infineon.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Last-TLS-Session-Version: TLSv1.3

On 1/14/26 9:12 AM, Gokul Sivakumar wrote:
> On 01/14, Marek Vasut wrote:
>> On 1/13/26 9:33 PM, Gokul Sivakumar wrote:
>>> Infineon(Cypress) is introducing a new INFFMAC (WLAN FULLMAC) Linux driver
>>> specifically for its new-generation AIROC family of Wi-Fi Connectivity
>>> Processor (CP) chipsets (CYW5591x), Wi-Fi + Bluetooth combo chipsets
>>> (CYW5557x, CYW5551x, CYW5591x, CYW43022), and also for all future chipsets.
>> Support for the CYW55572 can be easily added into the existing brcmfmac
>> driver, I already posted a patch over a year ago [1], but it was blocked
>> by an off-list email.
> 
>> Frankly, I do not see any good reason why the brcmfmac driver shouldn't
>> be extended when it is clearly easily doable. Adding new fork of the
>> brcmfmac would only increase maintenance burden and prevent bugfixes
>> from reaching the brcmfmac.
>>
>> [1] https://lore.kernel.org/all/20240909203133.74777-2-marex@denx.de/
> 
> There are multiple reasons behind Infineon's proposal for this new INFFMAC
> driver for its new-generation chips. Sharing a few here, and more info
> is available in the v1 cover-letter [1]. For Example, the CYW5591x family
> chipsets that is currently supported in this INFFMAC driver has a unique
> Connected-MCU / Connectivtiy Processor (CP) Architecture [2], primarly
> intended for IoT applications and it is completely different from any of
> the legacy Broadcom architecture chipsets of Infineon supported currently
> in upstream BRCMFMAC.

This does not prevent them from being integrated in brcmfmac like many 
of the other already supported chips, there seems to be no technical 
reason here.

> The CYW5591x family chipsets has dedicated MCU Core
> in addition to the WLAN core and an onboard FLASH memory for the Firmware.

It seems all brcmfmac devices have a cortex-M core in them since a long 
time.

> And with respect to the support for the new-generation CYW5557x family of
> Secure chipsets, that requires a Secure boot handshake with the Bootloader.

It seems like the TRX firmware loading is trivial to add, and parts of 
it are already in the Linux kernel for other brcm components. It seems 
this TRX was used since old broadcom MIPS SoCs.

> Even if the enumeration and firmware download support for the CYW55572 is
> somehow retro-fitted into the existing upstream BRCMFMAC driver, there are
> multiple other features and aspects of the Driver-Device communication that
> are unique to each WLAN vendor, which are not always practically feasible
> to support in the same upstream driver.

Why ?

> Because currently BRCMFMAC driver
> has a shared ownership with more than 3 WLAN vendor organizations and this
> approach has its limitations.

Yes, this means it is necessary to cooperate and coordinate with other 
people, on the mailing list.

> For Example, the version of the PCIe and SDIO
> BUS specific shared info in Device Memory is expected same from chipsets
> from all vendors. There would be a complex need to maintain vendor specifc
> as well as BUS specific Shared info version, vendor specific BUS Protocol
> layers, vendor specific firmware event header OUIs (currently always expects
> BRCM OUI even from other vendor chips) and even more.

This sounds like code refactoring is necessary.

> Confining different architecture chips from different WLAN vendors into the
> same legacy BRCMFMAC driver codebase, may not be sustainable and could
> potentially increase the maintainence effort and codebase complexity.
> And not practically feasible to continue splitting this driver with more
> vendor specific checks in the longer run. Since being different vendors,
> each will only naturally diverge even more in the future with their chipset
> Architecture, Driver-Device communication flow, etc. Infineon will continue
> to support its legacy chipsets, already supported in the upstream BRCMFMAC.
Maybe all the extra functionality can be added later, and the driver can 
be forked later, when it becomes clear that refactoring is not an option 
and it is becoming too difficult to maintain ?

So far, it seems the current generation chips can be easily added to 
brcmfmac, even if the feature set would be limited. Adding them would 
allow the maintainers to review such a smaller patchset and get at least 
some hardware support in, step by step, instead of this mega-patchset.

