Return-Path: <linux-wireless+bounces-30914-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 7F4B9D33851
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 17:34:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id A0D80301412D
	for <lists+linux-wireless@lfdr.de>; Fri, 16 Jan 2026 16:33:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4407F33A6F1;
	Fri, 16 Jan 2026 16:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="Rvfyc2fR"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82466338902
	for <linux-wireless@vger.kernel.org>; Fri, 16 Jan 2026 16:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768581210; cv=none; b=PRC/UdsHpV+BXwIB0YoOu1sbdnW2F9AlHIPwu+s9yf8Cng/juXDR2qFdrAAOAEbLJ15ZoSZnUJ0/+RIlAeVGwrtJBBOik0HCbYPMPlRqAP+xwu85AkUvVGJou5uizvdQ2y1gv/qALG0TXJ9zC8crSGPxu92a1wRUzJnX9FbkcPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768581210; c=relaxed/simple;
	bh=Kcx2VyKELC+E6j8z6CUXb7Ka0dZ0uqH9PcNkUIXO9N8=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=adk5xzLpfzUBRrXjpHR6J6mb2EXKfAz6ekq4pgAAW+AnZVyo8YI06JpL9H4NF3hUuyJGv7xvijBHPNCezPaZDRVSnDLpPED3kAUtApfJN5xxw98FX76Q6UQx/WvoLn27sjg3/cV6WVy6bRu+H8IuJT3Z2pwibeRWk8s3luzTlY4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=Rvfyc2fR; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768581208; x=1800117208;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=Kcx2VyKELC+E6j8z6CUXb7Ka0dZ0uqH9PcNkUIXO9N8=;
  b=Rvfyc2fRFpk6jM/iJoIfy9kQcCU6DiNClGlUa9jRc5jR22iuhWKlgqIO
   JUREknVq9VlV69FWGVnqI0x+qU91UClbQESR5Mmec+rij2rH2helRo/P0
   7PVNjPIUBL3niL7myohjZPG8WxRkTTYCbLMHAect5KDTSxp9Us0CNQIvR
   E=;
X-CSE-ConnectionGUID: zXXF4hBJSFGcZCvK5xzpAA==
X-CSE-MsgGUID: yKJj4WcbQ8Os7B8g+EcGHw==
X-IronPort-AV: E=McAfee;i="6800,10657,11673"; a="127045672"
X-IronPort-AV: E=Sophos;i="6.21,231,1763420400"; 
   d="scan'208";a="127045672"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE819.infineon.com) ([172.23.29.45])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Jan 2026 17:33:21 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE819.infineon.com
 (172.23.29.45) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 16 Jan
 2026 17:33:20 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 16 Jan 2026 17:33:18 +0100
Date: Fri, 16 Jan 2026 22:03:06 +0530
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Marek Vasut <marex@nabladev.com>
CC: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>, Arend van Spriel <arend.vanspriel@broadcom.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: Re: [PATCH wireless-next v2 00/34] wifi: inffmac: introducing a
 driver for Infineon's new generation chipsets
Message-ID: <aWpoQs8rzqGUCsPO@ISCN5CG14747PP.infineon.com>
References: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
 <43acfb38-9dbc-4544-b429-dfd43afbf2b6@nabladev.com>
 <aWdP6chPOS0PV-Nc@ISCN5CG14747PP.infineon.com>
 <66e4ddb8-47ac-4b2a-8c4b-6f407aa1d8eb@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <66e4ddb8-47ac-4b2a-8c4b-6f407aa1d8eb@nabladev.com>
X-ClientProxiedBy: MUCSE806.infineon.com (172.23.29.32) To
 MUCSE827.infineon.com (172.23.29.20)

On 01/15, Marek Vasut wrote:
> On 1/14/26 9:12 AM, Gokul Sivakumar wrote:
> > On 01/14, Marek Vasut wrote:
> > > On 1/13/26 9:33 PM, Gokul Sivakumar wrote:
> > > > Infineon(Cypress) is introducing a new INFFMAC (WLAN FULLMAC) Linux driver
> > > > specifically for its new-generation AIROC family of Wi-Fi Connectivity
> > > > Processor (CP) chipsets (CYW5591x), Wi-Fi + Bluetooth combo chipsets
> > > > (CYW5557x, CYW5551x, CYW5591x, CYW43022), and also for all future chipsets.
> > > Support for the CYW55572 can be easily added into the existing brcmfmac
> > > driver, I already posted a patch over a year ago [1], but it was blocked
> > > by an off-list email.
> > 
> > > Frankly, I do not see any good reason why the brcmfmac driver shouldn't
> > > be extended when it is clearly easily doable. Adding new fork of the
> > > brcmfmac would only increase maintenance burden and prevent bugfixes
> > > from reaching the brcmfmac.
> > > 
> > > [1] https://lore.kernel.org/all/20240909203133.74777-2-marex@denx.de/
> > 
> > There are multiple reasons behind Infineon's proposal for this new INFFMAC
> > driver for its new-generation chips. Sharing a few here, and more info
> > is available in the v1 cover-letter [1]. For Example, the CYW5591x family
> > chipsets that is currently supported in this INFFMAC driver has a unique
> > Connected-MCU / Connectivtiy Processor (CP) Architecture [2], primarly
> > intended for IoT applications and it is completely different from any of
> > the legacy Broadcom architecture chipsets of Infineon supported currently
> > in upstream BRCMFMAC.
> 
> This does not prevent them from being integrated in brcmfmac like many
> of the other already supported chips, there seems to be no technical
> reason here.

I hope you would have got a chance to look into the elaborate info provided
in v1 cover-letter about the challenges that we faced with that approach.
In Infineon's new architecture CYW5591x family of chipsets coming with an
onboard FLASH Memory, it does not follow the traditional Device firmware
download sequence used by any of the legacy Broadcom chipsets and it would
be appropriate to use a dedicated driver for Infineon's chipsets which were
developed and intended mainly for IoT use-cases. 

Here it requires a Boot firmware download, and a host handshake with the
downloaded RAM boot firmware, followed by a CP Firmware image Download and
validation. Sharing here the sequence for coldboot image download to FLASH.

      Host Driver                                       Device
      ___________                                     ____________
         |                                                 |
         |                                 Power UP and execute CP Firmware
         |                                  from FLASH if available
 Attempt to enable SDIO F2                                 |
 if fails, FLASH is empty,                                 |
 Need to Download Firmware                                 |
         |                                                 |
        Wait for                                           |
DFU_CP_D2H_MSG_BL_READY                                    |
         |<<======== DFU_CP_D2H_MSG_BL_READY <<============|
         |                                                 |
Fetch Boot Firmware                                        |
from Filesystem                                            |
         |======>> DFU_CP_H2D_MSG_BOOT_FWLOAD_START =====>>|
         |						   |
         |======>> Transfer Boot Firmware over SDIO =====>>|
         |                in multiple chunks               |
         |						   |
         |======>> DFU_CP_H2D_MSG_BOOT_FWLOAD_DONE ======>>|
         |                                       Execute the downloaded
         |                                           RAM Bootloader
       Wait for                                            |
DFU_CP_D2H_MSG_BOOTFW_READY                                |
         |<<========= DFU_CP_D2H_MSG_BOOTFW_READY <<=======|
         |                                                 |
Fetch CP Firmware                                          |
from Filesystem                                            |
         |=======>> Transfer CP Firmware over SDIO ======>>|
         |            in multiple chunks                   |
	 |                                       Download CP Firmware
         |                                        to FLASH Memory
         |                                                 |
         |=======>> DFU_CP_H2D_MSG_BOOTFW_DATA_LOADED ====>|
         |                                                 |
         |=======>> DFU_CP_D2H_MSG_FW_VALIDAT_START ======>|
         |                                                 |
    Wait for                                    Validate the CP Firmware
DFU_CP_D2H_MSG_FW_VALIDAT_DONE                             |
         |<<======= DFU_CP_D2H_MSG_FW_VALIDAT_DONE <<======|
     	 |                                                 |
         |                                      Execute the CP Firmware
  Proceed with                                             |
ctrl cmds to Device                                        |
     	 |                                                 |

Here there is no need to redownload the Device Firmware from the Host
filesystem everyime the Host or Device goes through a power cycle. Also the
device is capable of fully operating in an offloaded mode even when the
host is in suspended state or even if fully powered off. This is critical
to save power for extended durations in IoT use cases which are often
battery operated.
 
> > The CYW5591x family chipsets has dedicated MCU Core
> > in addition to the WLAN core and an onboard FLASH memory for the Firmware.
> 
> It seems all brcmfmac devices have a cortex-M core in them since a long
> time.

We were intending to mention that CYW5591x Cortex-M33 core is dedicated to
function as a Co-Processor to the Host CPU/MCU and offload multiple wifi
and network operations if configured by the user before host goes to sleep.
You can refer the chipset block diagram in CYW55913/2/1 Product Brief [1]
The CYW5591x SoC Backplane interconnects are also different from any of the
legacy Broadcom chipsets.
 
> > And with respect to the support for the new-generation CYW5557x family of
> > Secure chipsets, that requires a Secure boot handshake with the Bootloader.
> 
> It seems like the TRX firmware loading is trivial to add, and parts of
> it are already in the Linux kernel for other brcm components. It seems
> this TRX was used since old broadcom MIPS SoCs.

No, your understanding needs a correction. Infineon's TRXSE and TRXS Device
Bootloader handshake and Firmware formats are quite different from the old
Broadcom TRX formats that you are mentioning here. Being two individual
WLAN vendors, the chipset internals, firmware formats, Device Bootloader
handshake cannot be expected to be the same. Yet another reason why it is
not practically feasible to use upstream BRCMFMAC for the new-generation
chipsets and new firmware releases from Infineon.
 
> > Even if the enumeration and firmware download support for the CYW55572 is
> > somehow retro-fitted into the existing upstream BRCMFMAC driver, there are
> > multiple other features and aspects of the Driver-Device communication that
> > are unique to each WLAN vendor, which are not always practically feasible
> > to support in the same upstream driver.
> 
> Why ?

As mentioned before, various aspects of the Driver-Device communication are
unique to each WLAN vendor. And it is not practically feasible to confine
them into a common upstream driver, also not sustainable to maintain it that
way througout the lifetime of the hardware.
 
> > Because currently BRCMFMAC driver
> > has a shared ownership with more than 3 WLAN vendor organizations and this
> > approach has its limitations.
> 
> Yes, this means it is necessary to cooperate and coordinate with other
> people, on the mailing list.

Infineon is committed to coordinate with other vendors in managing upstream
BRCMFMAC driver and continuing the support for its legacy chipsets that
still follows the legacy Broadcom architecture. Like for example, we have
added support for CYW54591-PCIe in upstream BRCMFMAC few months back [2],
because it has many things in common with other legacy Broadcom chips.
But the same does not applies for all the new-generation Infineon chipsets.

> > For Example, the version of the PCIe and SDIO
> > BUS specific shared info in Device Memory is expected same from chipsets
> > from all vendors. There would be a complex need to maintain vendor specifc
> > as well as BUS specific Shared info version, vendor specific BUS Protocol
> > layers, vendor specific firmware event header OUIs (currently always expects
> > BRCM OUI even from other vendor chips) and even more.
> 
> This sounds like code refactoring is necessary.
> 
> > Confining different architecture chips from different WLAN vendors into the
> > same legacy BRCMFMAC driver codebase, may not be sustainable and could
> > potentially increase the maintainence effort and codebase complexity.
> > And not practically feasible to continue splitting this driver with more
> > vendor specific checks in the longer run. Since being different vendors,
> > each will only naturally diverge even more in the future with their chipset
> > Architecture, Driver-Device communication flow, etc. Infineon will continue
> > to support its legacy chipsets, already supported in the upstream BRCMFMAC.
> Maybe all the extra functionality can be added later, and the driver can
> be forked later, when it becomes clear that refactoring is not an option
> and it is becoming too difficult to maintain ?

Refactoring the existing upstream BRCMFMAC driver for the new-architecture
chipsets developed by Infineon is not a practical option now because these
devices are fairly new. In the lifetime of these devices, the functionality
of the Devices and Driver interaction are only going to evolve even more.
Eventually, it would become more cumbersome to maintain as well as to avoid
regressions for different architecture chips from different WLAN vendors
if same upstream driver is used.

We strongly believe that this is an appropriate time for thinking about a
proposal to proceed with a dedicated driver for the new-generation chips
developed individually by Infineon.

> So far, it seems the current generation chips can be easily added to
> brcmfmac, even if the feature set would be limited. Adding them would

We are not in the same page here. As mentioned earlier and as you might
know, there is infact much more to it than adding enumeration support for a
chip in a driver. Certainly not easy when eventually Infineon is required
to enable the end users with the actual capabilities of the chipset, also
Infineon has the responsibility to ensure driver compatibility with all the
newly shipped Device firmwares.

> allow the maintainers to review such a smaller patchset and get at least
> some hardware support in, step by step, instead of this mega-patchset.

We understood that review bandwidth is limited and have taken the feedback
received on v1 very seriously, so multiple features were already stripped
off in v2. Willing to skip even more functionality in the upcoming versions
and also ready to provide more information as needed to make the INFFMAC
driver review as much easy as possible.

[1] https://www.infineon.com/assets/row/public/documents/30/45/infineon-airoc-tm-cyw55913-2-1-connected-mcu-with-wi-fi-bluetooth-r-low-energy-5-productbrief-en.pdf
[2] https://lore.kernel.org/linux-wireless/20250624093453.7264-1-ian.lin@infineon.com/

Gokul

