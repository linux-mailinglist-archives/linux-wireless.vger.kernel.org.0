Return-Path: <linux-wireless+bounces-30807-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D5C2D1D084
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 09:12:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id BF177300819D
	for <lists+linux-wireless@lfdr.de>; Wed, 14 Jan 2026 08:12:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4B5AA37A487;
	Wed, 14 Jan 2026 08:12:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="oCBSYeEe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp9.infineon.com (smtp9.infineon.com [217.10.52.204])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701F635F8AF
	for <linux-wireless@vger.kernel.org>; Wed, 14 Jan 2026 08:12:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.204
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768378361; cv=none; b=ZeD8CIDquwXmS4goCsjhvbo9x84NdI+lXPA6yG/65xhAmBePRlHFH4w4i8jXHkf05Y8YW7hZsdvr8S55ZNhwJYwuJ6Va8PUfmccxAXrOR4YshGJA5G2CtitI/jZzY7i/+pRHMFNW6sw97GwqlwR1ECqynp+ND1h7RgtJThvyYqo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768378361; c=relaxed/simple;
	bh=dRo0da8KSJz5kCac7LwEFfMD48ZZ3objhi++HiABwUU=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=d57JWDfWhhtXvixrm3WJRa5mpQ5Ab2r6qssghIX6yYhhyHwYM19BvuGpH+ihtWKNCsB5Qxp/ewhmixiCLpeXWMsfFxQGIs18X2wNtxRobYoSCKF0ekhvL2HuD44Gd4qUNW0vLXmzLBPkDLCuIg83K3Wkk2GpFCpi+6qeit8NEsY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=oCBSYeEe; arc=none smtp.client-ip=217.10.52.204
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1768378359; x=1799914359;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=dRo0da8KSJz5kCac7LwEFfMD48ZZ3objhi++HiABwUU=;
  b=oCBSYeEe+t/naQiAIgXhbE3cw11JABsFCdWgQlwqpUYz3CC+7VVUgFgj
   w+2q8QNisK1cdLSOSwxkP3UhoGeptlZZ78+uC9h220iqE5DDhTvP3IIVH
   7HJ1gO5a0r6vQ866pTApc+0CkCrsGs1492QWnPMUraSVBfIRXi1PDEyRa
   o=;
X-CSE-ConnectionGUID: hvdB53BPSyeV49p+QiQr4w==
X-CSE-MsgGUID: dGG8uXTvQ2O5XG1TuhRwdA==
X-IronPort-AV: E=McAfee;i="6800,10657,11670"; a="78174713"
X-IronPort-AV: E=Sophos;i="6.21,225,1763420400"; 
   d="scan'208";a="78174713"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE803.infineon.com) ([172.23.29.29])
  by smtp9.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jan 2026 09:12:35 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE803.infineon.com
 (172.23.29.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.35; Wed, 14 Jan
 2026 09:12:34 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.35; Wed, 14 Jan 2026 09:12:33 +0100
Date: Wed, 14 Jan 2026 13:42:25 +0530
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Marek Vasut <marex@nabladev.com>
CC: <linux-wireless@vger.kernel.org>, Johannes Berg
	<johannes@sipsolutions.net>, Arend van Spriel <arend.vanspriel@broadcom.com>,
	<wlan-kernel-dev-list@infineon.com>
Subject: Re: [PATCH wireless-next v2 00/34] wifi: inffmac: introducing a
 driver for Infineon's new generation chipsets
Message-ID: <aWdP6chPOS0PV-Nc@ISCN5CG14747PP.infineon.com>
References: <20260113203350.16734-1-gokulkumar.sivakumar@infineon.com>
 <43acfb38-9dbc-4544-b429-dfd43afbf2b6@nabladev.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <43acfb38-9dbc-4544-b429-dfd43afbf2b6@nabladev.com>
X-ClientProxiedBy: MUCSE808.infineon.com (172.23.29.34) To
 MUCSE827.infineon.com (172.23.29.20)

On 01/14, Marek Vasut wrote:
> On 1/13/26 9:33 PM, Gokul Sivakumar wrote:
> > Infineon(Cypress) is introducing a new INFFMAC (WLAN FULLMAC) Linux driver
> > specifically for its new-generation AIROC family of Wi-Fi Connectivity
> > Processor (CP) chipsets (CYW5591x), Wi-Fi + Bluetooth combo chipsets
> > (CYW5557x, CYW5551x, CYW5591x, CYW43022), and also for all future chipsets.
> Support for the CYW55572 can be easily added into the existing brcmfmac
> driver, I already posted a patch over a year ago [1], but it was blocked
> by an off-list email.

> Frankly, I do not see any good reason why the brcmfmac driver shouldn't
> be extended when it is clearly easily doable. Adding new fork of the
> brcmfmac would only increase maintenance burden and prevent bugfixes
> from reaching the brcmfmac.
> 
> [1] https://lore.kernel.org/all/20240909203133.74777-2-marex@denx.de/

There are multiple reasons behind Infineon's proposal for this new INFFMAC
driver for its new-generation chips. Sharing a few here, and more info
is available in the v1 cover-letter [1]. For Example, the CYW5591x family
chipsets that is currently supported in this INFFMAC driver has a unique
Connected-MCU / Connectivtiy Processor (CP) Architecture [2], primarly
intended for IoT applications and it is completely different from any of
the legacy Broadcom architecture chipsets of Infineon supported currently
in upstream BRCMFMAC. The CYW5591x family chipsets has dedicated MCU Core
in addition to the WLAN core and an onboard FLASH memory for the Firmware.

And with respect to the support for the new-generation CYW5557x family of
Secure chipsets, that requires a Secure boot handshake with the Bootloader.
Even if the enumeration and firmware download support for the CYW55572 is
somehow retro-fitted into the existing upstream BRCMFMAC driver, there are
multiple other features and aspects of the Driver-Device communication that
are unique to each WLAN vendor, which are not always practically feasible
to support in the same upstream driver. Because currently BRCMFMAC driver
has a shared ownership with more than 3 WLAN vendor organizations and this
approach has its limitations. For Example, the version of the PCIe and SDIO
BUS specific shared info in Device Memory is expected same from chipsets
from all vendors. There would be a complex need to maintain vendor specifc
as well as BUS specific Shared info version, vendor specific BUS Protocol
layers, vendor specific firmware event header OUIs (currently always expects
BRCM OUI even from other vendor chips) and even more.

Confining different architecture chips from different WLAN vendors into the
same legacy BRCMFMAC driver codebase, may not be sustainable and could
potentially increase the maintainence effort and codebase complexity.
And not practically feasible to continue splitting this driver with more
vendor specific checks in the longer run. Since being different vendors,
each will only naturally diverge even more in the future with their chipset
Architecture, Driver-Device communication flow, etc. Infineon will continue
to support its legacy chipsets, already supported in the upstream BRCMFMAC.

[1] https://lore.kernel.org/linux-wireless/20250916221821.4387-1-gokulkumar.sivakumar@infineon.com/ 
[2] https://www.infineon.com/products/wireless-connectivity/airoc-connected-mcu

Gokul

