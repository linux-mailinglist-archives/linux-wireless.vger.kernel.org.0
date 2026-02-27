Return-Path: <linux-wireless+bounces-32299-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id eGVqJk+soWm1vQQAu9opvQ
	(envelope-from <linux-wireless+bounces-32299-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 15:38:07 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 1A07C1B91A6
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 15:38:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 2C8E23020A50
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Feb 2026 14:35:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0245F9C0;
	Fri, 27 Feb 2026 14:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="BPlH+R80"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC96D1D5CD1
	for <linux-wireless@vger.kernel.org>; Fri, 27 Feb 2026 14:35:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772202939; cv=none; b=dJ44jvIFueZloA2JeeMmCmx8Z3Ptk9Osaa1Suswk5yK5P7zhlkGnqiv+ixpUgZgUkGEj8mSlVgvKwNpeNHuLWdiA6RvqgRUXYi+oNWqI/yNAsQuiMpexQ9trcul1HSHxXXG6boWNC2PBFt+Q9BDqKjjdc5KwMowjJPfSRK7yYGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772202939; c=relaxed/simple;
	bh=onfmIPMIRU40qVbpLximrbrvZzPZGM4rsZ8zc4Syg+w=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uER50fBOPFGGALCgMOAeHsMJK1yMGeGlDfbj++4MsnmMfG474BtOlAq7Z203IHWrhXyHxiPZwllBohlE5lDFneReIfm7BHiyGODUPwMffTkJ1805HImOmsdHRQ+W0kfCcIW8QoQa+Nc1XQRTYLhJFQLkDsT6/b1BJpaTch1NnLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=BPlH+R80; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1772202937; x=1803738937;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=onfmIPMIRU40qVbpLximrbrvZzPZGM4rsZ8zc4Syg+w=;
  b=BPlH+R80EYAyMW+rdhV8L0LQD3l5hhzggALTvfwji0SB0ABqCONwwOgA
   CjGgHBMGgpqpNyDcItcQQ709kQxqzFsi+a+shky+CXiPq3o01Tz5V9gS0
   DFludYIpK+ETAGFE9xVzWDT7YeaxoZJkyYYOMOifIl+k44ptCQrNrGN4O
   k=;
X-CSE-ConnectionGUID: k62SMLPpR3C3IY6CmQ377g==
X-CSE-MsgGUID: mnXq0u0jRbKjgg/25xsT7Q==
X-IronPort-AV: E=McAfee;i="6800,10657,11714"; a="145862618"
X-IronPort-AV: E=Sophos;i="6.21,314,1763420400"; 
   d="scan'208";a="145862618"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Feb 2026 15:34:26 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Fri, 27 Feb
 2026 15:34:25 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Fri, 27 Feb 2026 15:34:24 +0100
Date: Fri, 27 Feb 2026 20:04:16 +0530
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Marek Vasut <marex@nabladev.com>
CC: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>, Arend van Spriel <arend.vanspriel@broadcom.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: Re: [PATCH wireless-next v2 00/34] wifi: inffmac: introducing a
 driver for Infineon's new generation chipsets
Message-ID: <aaGraKzdMcyb6QmW@ISCN5CG14747PP.infineon.com>
References: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
 <43acfb38-9dbc-4544-b429-dfd43afbf2b6@nabladev.com>
 <aWdP6chPOS0PV-Nc@ISCN5CG14747PP.infineon.com>
 <66e4ddb8-47ac-4b2a-8c4b-6f407aa1d8eb@nabladev.com>
 <aWpoQs8rzqGUCsPO@ISCN5CG14747PP.infineon.com>
 <6612163e-b933-432c-995c-6daec9c7be29@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6612163e-b933-432c-995c-6daec9c7be29@nabladev.com>
X-ClientProxiedBy: MUCSE819.infineon.com (172.23.29.45) To
 MUCSE827.infineon.com (172.23.29.20)
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-2.16 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[infineon.com,none];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64:c];
	R_DKIM_ALLOW(-0.20)[infineon.com:s=IFXMAIL];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-32299-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	FROM_HAS_DN(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	DKIM_TRACE(0.00)[infineon.com:+];
	TO_DN_SOME(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	RCPT_COUNT_FIVE(0.00)[5];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[gokulkumar.sivakumar@infineon.com,linux-wireless@vger.kernel.org];
	MISSING_XM_UA(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	MID_RHS_MATCH_FROMTLD(0.00)[];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:helo,sea.lore.kernel.org:rdns]
X-Rspamd-Queue-Id: 1A07C1B91A6
X-Rspamd-Action: no action

On 02/27, Marek Vasut wrote:
> On 1/16/26 5:33 PM, Gokul Sivakumar wrote:
> > On 01/15, Marek Vasut wrote:
> > > On 1/14/26 9:12 AM, Gokul Sivakumar wrote:
> > > > On 01/14, Marek Vasut wrote:
> > > > > On 1/13/26 9:33 PM, Gokul Sivakumar wrote:
> > > > > > Infineon(Cypress) is introducing a new INFFMAC (WLAN FULLMAC) Linux driver
> > > > > > specifically for its new-generation AIROC family of Wi-Fi Connectivity
> > > > > > Processor (CP) chipsets (CYW5591x), Wi-Fi + Bluetooth combo chipsets
> > > > > > (CYW5557x, CYW5551x, CYW5591x, CYW43022), and also for all future chipsets.
> > > > > Support for the CYW55572 can be easily added into the existing brcmfmac
> > > > > driver, I already posted a patch over a year ago [1], but it was blocked
> > > > > by an off-list email.
> > > > 
> > > > > Frankly, I do not see any good reason why the brcmfmac driver shouldn't
> > > > > be extended when it is clearly easily doable. Adding new fork of the
> > > > > brcmfmac would only increase maintenance burden and prevent bugfixes
> > > > > from reaching the brcmfmac.
> > > > > 
> > > > > [1] https://lore.kernel.org/all/20240909203133.74777-2-marex@denx.de/
> > > > 
> > > > There are multiple reasons behind Infineon's proposal for this new INFFMAC
> > > > driver for its new-generation chips. Sharing a few here, and more info
> > > > is available in the v1 cover-letter [1]. For Example, the CYW5591x family
> > > > chipsets that is currently supported in this INFFMAC driver has a unique
> > > > Connected-MCU / Connectivtiy Processor (CP) Architecture [2], primarly
> > > > intended for IoT applications and it is completely different from any of
> > > > the legacy Broadcom architecture chipsets of Infineon supported currently
> > > > in upstream BRCMFMAC.
> > > 
> > > This does not prevent them from being integrated in brcmfmac like many
> > > of the other already supported chips, there seems to be no technical
> > > reason here.
> > 
> > I hope you would have got a chance to look into the elaborate info provided
> > in v1 cover-letter about the challenges that we faced with that approach.
> > In Infineon's new architecture CYW5591x family of chipsets coming with an
> > onboard FLASH Memory, it does not follow the traditional Device firmware
> > download sequence used by any of the legacy Broadcom chipsets and it would
> > be appropriate to use a dedicated driver for Infineon's chipsets which were
> > developed and intended mainly for IoT use-cases.
> > 
> > Here it requires a Boot firmware download, and a host handshake with the
> > downloaded RAM boot firmware, followed by a CP Firmware image Download and
> > validation. Sharing here the sequence for coldboot image download to FLASH.
> > 
> >        Host Driver                                       Device
> >        ___________                                     ____________
> >           |                                                 |
> >           |                                 Power UP and execute CP Firmware
> >           |                                  from FLASH if available
> >   Attempt to enable SDIO F2                                 |
> >   if fails, FLASH is empty,                                 |
> >   Need to Download Firmware                                 |
> >           |                                                 |
> >          Wait for                                           |
> > DFU_CP_D2H_MSG_BL_READY                                    |
> >           |<<======== DFU_CP_D2H_MSG_BL_READY <<============|
> >           |                                                 |
> > Fetch Boot Firmware                                        |
> > from Filesystem                                            |
> >           |======>> DFU_CP_H2D_MSG_BOOT_FWLOAD_START =====>>|
> >           |                                              |
> >           |======>> Transfer Boot Firmware over SDIO =====>>|
> >           |                in multiple chunks               |
> >           |                                              |
> >           |======>> DFU_CP_H2D_MSG_BOOT_FWLOAD_DONE ======>>|
> >           |                                       Execute the downloaded
> >           |                                           RAM Bootloader
> >         Wait for                                            |
> > DFU_CP_D2H_MSG_BOOTFW_READY                                |
> >           |<<========= DFU_CP_D2H_MSG_BOOTFW_READY <<=======|
> >           |                                                 |
> > Fetch CP Firmware                                          |
> > from Filesystem                                            |
> >           |=======>> Transfer CP Firmware over SDIO ======>>|
> >           |            in multiple chunks                   |
> >        |                                       Download CP Firmware
> >           |                                        to FLASH Memory
> >           |                                                 |
> >           |=======>> DFU_CP_H2D_MSG_BOOTFW_DATA_LOADED ====>|
> >           |                                                 |
> >           |=======>> DFU_CP_D2H_MSG_FW_VALIDAT_START ======>|
> >           |                                                 |
> >      Wait for                                    Validate the CP Firmware
> > DFU_CP_D2H_MSG_FW_VALIDAT_DONE                             |
> >           |<<======= DFU_CP_D2H_MSG_FW_VALIDAT_DONE <<======|
> >                |                                                 |
> >           |                                      Execute the CP Firmware
> >    Proceed with                                             |
> > ctrl cmds to Device                                        |
> >                |                                                 |
> > 
> > Here there is no need to redownload the Device Firmware from the Host
> > filesystem everyime the Host or Device goes through a power cycle. Also the
> > device is capable of fully operating in an offloaded mode even when the
> > host is in suspended state or even if fully powered off. This is critical
> > to save power for extended durations in IoT use cases which are often
> > battery operated.
> 
> This seems like a technical detail of the firmware loading, which can be
> handled by the driver ?

If this is the base of your argument, then theoritically any vendor driver can
be added with the functionality to manage any other WLAN chip from another vendor.
A single monolithic wireless driver could potentially manage every vendor's chips,
without the need for any hardware specific abstraction. But, clearly this is not
how it is currently in wireless subsystem, because of multiple compelling reasons.

And given that Infineon's new architecture CYW5591x family of chipsets are completely
new, tailor made inhouse for IoT use-cases, with a different chipset architecture, 
different bootflow, etc. it is not practical to add it into another vendor's driver
source which has a different flow for managing its devices.

> > > > The CYW5591x family chipsets has dedicated MCU Core
> > > > in addition to the WLAN core and an onboard FLASH memory for the Firmware.
> > > 
> > > It seems all brcmfmac devices have a cortex-M core in them since a long
> > > time.
> > 
> > We were intending to mention that CYW5591x Cortex-M33 core is dedicated to
> > function as a Co-Processor to the Host CPU/MCU and offload multiple wifi
> > and network operations if configured by the user before host goes to sleep.
> > You can refer the chipset block diagram in CYW55913/2/1 Product Brief [1]
> > The CYW5591x SoC Backplane interconnects are also different from any of the
> > legacy Broadcom chipsets.
> 
> Maybe the driver can be forked when it turns out this functionality
> cannot be easily added into the existing driver ?

Our response remains the same, as given for your exact same question few weeks
back in this thread. We shared our explantion with the rationale behind our proposal.

> > > > And with respect to the support for the new-generation CYW5557x family of
> > > > Secure chipsets, that requires a Secure boot handshake with the Bootloader.
> > > 
> > > It seems like the TRX firmware loading is trivial to add, and parts of
> > > it are already in the Linux kernel for other brcm components. It seems
> > > this TRX was used since old broadcom MIPS SoCs.
> > 
> > No, your understanding needs a correction. Infineon's TRXSE and TRXS Device
> > Bootloader handshake and Firmware formats are quite different from the old
> > Broadcom TRX formats that you are mentioning here. Being two individual
> > WLAN vendors, the chipset internals, firmware formats, Device Bootloader
> > handshake cannot be expected to be the same. Yet another reason why it is
> > not practically feasible to use upstream BRCMFMAC for the new-generation
> > chipsets and new firmware releases from Infineon.
> 
> Surely it is possible to do something like
> 
> if (wlan_id_needs_trxse)
>   load_trxse();
> else
>   load_old_firmware_style();
> 
> ?
> 
> It seems this was already done in the two patches I submitted about a
> year ago, so this is clearly doable.

Along with TRXSE and TRXS firmwares, Infineon also uses a TRX format firmware,
which is also different with the TRX format of Broadcom's firmware. So still
need to differentiate between TRX firmwares because the WLAN vendor is different.
This is not a question about whether it is about doable, more than that, whether
it is practical.

> > > > Even if the enumeration and firmware download support for the CYW55572 is
> > > > somehow retro-fitted into the existing upstream BRCMFMAC driver, there are
> > > > multiple other features and aspects of the Driver-Device communication that
> > > > are unique to each WLAN vendor, which are not always practically feasible
> > > > to support in the same upstream driver.
> > > 
> > > Why ?
> > 
> > As mentioned before, various aspects of the Driver-Device communication are
> > unique to each WLAN vendor. And it is not practically feasible to confine
> > them into a common upstream driver, also not sustainable to maintain it that
> > way througout the lifetime of the hardware.
> 
> The patches I submitted showed this was feasible, so I am not buying
> that argument. Can you give that a try instead ?

Our argument is on practical feasibility of doing so and its implications throughout
the lifetime of this new-generation device, when later tring to add other features and
when Infineon specific Driver-Device communiction flow evolve even more. This is quite
different from feasbility of making brcmfmac just detect the chip and load the firmware.
It is not sustainable to confine the support for a chips from multiple WLAN vendors
into the same upstream Linux driver.

Yes, we are aware of the couple patches that you submitted for upstream review. Before
that, initially those two patches were first released by Infineon downstream, only for
specific end use-cases and not actually intended for upstream.
 
> > > > Because currently BRCMFMAC driver
> > > > has a shared ownership with more than 3 WLAN vendor organizations and this
> > > > approach has its limitations.
> > > 
> > > Yes, this means it is necessary to cooperate and coordinate with other
> > > people, on the mailing list.
> > 
> > Infineon is committed to coordinate with other vendors in managing upstream
> > BRCMFMAC driver and continuing the support for its legacy chipsets that
> > still follows the legacy Broadcom architecture. Like for example, we have
> > added support for CYW54591-PCIe in upstream BRCMFMAC few months back [2],
> > because it has many things in common with other legacy Broadcom chips.
> > But the same does not applies for all the new-generation Infineon chipsets.
> > 
> > > > For Example, the version of the PCIe and SDIO
> > > > BUS specific shared info in Device Memory is expected same from chipsets
> > > > from all vendors. There would be a complex need to maintain vendor specifc
> > > > as well as BUS specific Shared info version, vendor specific BUS Protocol
> > > > layers, vendor specific firmware event header OUIs (currently always expects
> > > > BRCM OUI even from other vendor chips) and even more.
> > > 
> > > This sounds like code refactoring is necessary.
> > > 
> > > > Confining different architecture chips from different WLAN vendors into the
> > > > same legacy BRCMFMAC driver codebase, may not be sustainable and could
> > > > potentially increase the maintainence effort and codebase complexity.
> > > > And not practically feasible to continue splitting this driver with more
> > > > vendor specific checks in the longer run. Since being different vendors,
> > > > each will only naturally diverge even more in the future with their chipset
> > > > Architecture, Driver-Device communication flow, etc. Infineon will continue
> > > > to support its legacy chipsets, already supported in the upstream BRCMFMAC.
> > > Maybe all the extra functionality can be added later, and the driver can
> > > be forked later, when it becomes clear that refactoring is not an option
> > > and it is becoming too difficult to maintain ?
> > 
> > Refactoring the existing upstream BRCMFMAC driver for the new-architecture
> > chipsets developed by Infineon is not a practical option now because these
> > devices are fairly new. In the lifetime of these devices, the functionality
> > of the Devices and Driver interaction are only going to evolve even more.
> > Eventually, it would become more cumbersome to maintain as well as to avoid
> > regressions for different architecture chips from different WLAN vendors
> > if same upstream driver is used.
> > 
> > We strongly believe that this is an appropriate time for thinking about a
> > proposal to proceed with a dedicated driver for the new-generation chips
> > developed individually by Infineon.
> > 
> > > So far, it seems the current generation chips can be easily added to
> > > brcmfmac, even if the feature set would be limited. Adding them would
> > 
> > We are not in the same page here. As mentioned earlier and as you might
> > know, there is infact much more to it than adding enumeration support for a
> > chip in a driver. Certainly not easy when eventually Infineon is required
> > to enable the end users with the actual capabilities of the chipset, also
> > Infineon has the responsibility to ensure driver compatibility with all the
> > newly shipped Device firmwares.
> > 
> > > allow the maintainers to review such a smaller patchset and get at least
> > > some hardware support in, step by step, instead of this mega-patchset.
> > 
> > We understood that review bandwidth is limited and have taken the feedback
> > received on v1 very seriously, so multiple features were already stripped
> > off in v2. Willing to skip even more functionality in the upcoming versions
> > and also ready to provide more information as needed to make the INFFMAC
> > driver review as much easy as possible.
> 
> So, can you try and implement minimal TRXSE firmware loading and support
> for the CYW555xx for brcmfmac as an example, so it would be clear
> whether or not it can be added into the brcmfmac driver ?

No, as we mentioned earlier, just adding the enumeration & FW loading support
for the chipset in the brcmfmac driver and claiming that the device support is
available in the upstream brcmfmac driver would never be enough. Further, Infineon
has the responsibility to eventually add the actual features and capabilities of
this new-generation chip in the same upstream driver, so that the end users can
utilize the chipset to its fullest capability. It would not be practical to do this
later for the new generation Infineon chips, once the DEV ID is added into brcmfmac.
Because chipsets from multiple WLAN vendors are currently being managed by the same
driver, continuing to add more vendor specific checks for every driver functionality
is not sustainable.

The dedicated vendor WLAN drivers existing below the common cfg80211 & mac80211 layers
in the linux WLAN stack, helps to maintain the Device Hardware specific abstraction,
by taking care of the unique Device specific operation, Driver-Device Communication flow.
Confining multiple WLAN Vendor chipsets in same upstream driver, would only weaken the
abstraction even more.

We would like to emphasize that Infineon objective is not to be forever tied to the
existing common BRCMFMAC driver for its new generation chipsets, only because the
then Cypress (now Infineon) acquired few legacy chipsets (supported in brcmfmac) from
Broadcom nearly a decade ago in 2016. 

> Oh ... and I also noticed, that infineon recently fully rewrote the
> history of the firmware repository [1], both the master branch history
> and the tags now point to different commit SHAs.
> 
> [1] https://github.com/Infineon/ifx-linux-firmware

Ok, we will notify the respective folks internally.

Gokul

