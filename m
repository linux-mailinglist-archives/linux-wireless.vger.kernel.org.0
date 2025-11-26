Return-Path: <linux-wireless+bounces-29360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 41D14C8AF8C
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 17:30:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id EF5273A4BF8
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Nov 2025 16:30:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2A9230E0D2;
	Wed, 26 Nov 2025 16:30:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="NpI2lGp8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 40D8F30BBB3
	for <linux-wireless@vger.kernel.org>; Wed, 26 Nov 2025 16:30:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764174622; cv=none; b=YeYNjYLuthi3yk7ByI/Ru6nptzwZTcz/xDRoSkfFbK/3ZYcOgJPFfWdQ5gh1PTllMaszV0hPxZDka9lImGYGhPeiZUn+QwTrHi8DDpFX6NvnetXAsFSoobniPHJY7kq8sfFAb7haUXGeRlLePOAgQv7EW2shhw3ofDdFEnYUHtU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764174622; c=relaxed/simple;
	bh=3U2BG8VKQWmYCrsIDDAbWVJdkw87J80xC1UDSZz1lYo=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qG1han3iihJKS0iQG5HRJ6RkSnPwEvFDDeavJf+b7lct0tH5c+JEDheylAydBotenSV3JvhAjAhreovBZHI4iYBp1QPxFUje7uJEs7U6rD8ZXEvJ8P6brmYa+V2DeeUCnRYPdThRKL2fnrwRPb88k3X7Lux62SgWprkdRVl28xw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=NpI2lGp8; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1764174621; x=1795710621;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3U2BG8VKQWmYCrsIDDAbWVJdkw87J80xC1UDSZz1lYo=;
  b=NpI2lGp8V12Lf2oKdsCqRuOVEMbs1v8pHoPh67aeaCzUfAGLy4If/5bM
   YBGy19Tt5pAtKxmOvShkXvO2QDPcclvHGNAFMkaB1X2MtOmpie9Iy/n2K
   Vyv11qbyDY+7KXiIaEquRlwfTdlHPCv4Ok+9YuXOJbS15RUfAozvTGQ47
   k=;
X-CSE-ConnectionGUID: TzNOCFjWR9eVfwE+BqmURA==
X-CSE-MsgGUID: n3wDxSIkScCf4dJTylEN5A==
X-IronPort-AV: E=McAfee;i="6800,10657,11625"; a="133838969"
X-IronPort-AV: E=Sophos;i="6.20,228,1758578400"; 
   d="scan'208";a="133838969"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Nov 2025 17:29:10 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 26 Nov
 2025 17:29:09 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 26 Nov 2025 17:29:06 +0100
Date: Wed, 26 Nov 2025 21:58:57 +0530
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Arend van Spriel <arend.vanspriel@broadcom.com>
CC: Johannes Berg <johannes@sipsolutions.net>,
	<linux-wireless@vger.kernel.org>, <wlan-kernel-dev-list@infineon.com>,
	"Carter Chen" <Carter.Chen@infineon.com>, Owen Huang
	<Owen.Huang@infineon.com>, "Ian Lin" <Ian.Lin@infineon.com>, JasonHuang
	<Jason.Huang2@infineon.com>, "Shelley Yang" <Shelley.Yang@infineon.com>,
	avishad verma <avishad.verma@infineon.com>
Subject: Re: [PATCH wireless-next 00/57] wifi: inffmac: introducing a driver
 for Infineon's new generation chipsets
Message-ID: <aScqyVvRzbthAaiJ@ISCN5CG14747PP.infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
 <4d46dfb13927a878f5684e9e8cfc51673e8df4b8.camel@sipsolutions.net>
 <aMqm-soAc5tzHQFf@ISCN5CG14747PP.infineon.com>
 <3cb0e7a95fdba1ee1003c10606fd58e7b9071c58.camel@sipsolutions.net>
 <dc5017d0e4eed59905597f000a11887e9e264eb9.camel@sipsolutions.net>
 <aQr1eO-5Gmg7JSf2@ISCN5CG14747PP.infineon.com>
 <640ed685-3c83-4ca8-bbf3-51ddec5b6d5d@broadcom.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <640ed685-3c83-4ca8-bbf3-51ddec5b6d5d@broadcom.com>
X-ClientProxiedBy: MUCSE819.infineon.com (172.23.29.45) To
 MUCSE827.infineon.com (172.23.29.20)

On 11/25, Arend van Spriel wrote:
> On 11/5/2025 7:58 AM, Gokul Sivakumar wrote:
> > As you would be aware that, currently brcmfmac is retrofitted to support chipsets
> > from more than 3 WLAN chip vendor organizations (CYW from Infineon/Cypress,
> > BCA from Broadcom, WCC from Broadcom, etc). One of the major issue with this
> > WLAN driver model is, it is not practically feasible for each vendor to ensure
> > that their new chipset architecture specific driver changes do not cause any
> > regressions on the chipsets supported by other vendors in the same driver.
> > This has an impact for the end users. In a way, this severely hinders each
> > WLAN vendor from fully supporting their chipsets in upstream kernel with new
> > features for their chipsets. And currently brcmfmac uses fwvid (Firmware Vendor ID)
> > param in a vendor agnostic wrapper function brcmf_fwvid_*() to decide which command
> > to be sent to the vendor's firmware for doing a particular operation. For Example,
> > brcmf_fwvid_set_sae_password() for setting SAE password. This only handles the case
> > where two different vendor firmwares expecting two different commands for the same
> > operation. However, this does not solve the problem when each vendor firmware
> > expects commands in a different sequence. Also fwvid check is currently being used
> > only for sending commands/events to & from firmware, and for invoking cfg80211
> > callbacks. But other operations are also different across WLAN vendors with the
> > new generation chipsets, but they are currently handled in the same way for the
> > old generation chipsets in brcmfmac.
> 
> Hi Gokul,
> 
> When I worked on the multi-vendor support changes the main goal was to
> separate the firmware API as that was diverging or going to be rather
> sooner than later. I was tempted to duplicate cfg80211.c as well so each
> vendor could do its own. However, the concrete scenario for WPA3-SAE
> could be done on a lower granularity reusing common functionality. So
> for these new chips you could add "inf" vendor and completely split off.
> Not sure what you mean by "other operations" in the above paragraph.
> Maybe you can elaborate?

Hi Arend, 

I can elaborate. Apart from Firmware API control cmds, there are few
more aspects of the chip that are still vendor specific, but currently
brcmfmac treats it as same for all the chips from all the vendors.

For example, PCIe/SDIO Shared info version that the driver reads from
the Device Memory is currently being treated as same, irrespective of
the vendor of the chip. When a vendor makes any changes to the Device
shared memory structure or communication protocol structure, need to
update the Shared Info Version Number to maintain the compatibility
across different firmware versions of the same vendor in the driver.
In such cases, there is an additional complexity of need to maintain a
compatibility for Shared Info Version and communication protocol
changes across different firmware versions across different firmware
vendors. i.e, two chipsets from different vendors having same PCIE
shared version number X does not always imply that both chipsets are
to be communicated with in the same way. Also currently brcmfmac
expects the SW header in the firmare event packet from chipset to be
having the Broadcom OUI (00:10:18) always irrespective of the vendor.

Like these, there are other aspects of the driver that are ideally
needs to be made vendor specific. Among them only for few, it would be
feasible to add some vendor specific checks. And since each vendor's
chipsets only going to diverge even more eventually in the future,
IMHO, confining the chipsets from multiple vendors in the same driver
source code could lead to regressions and maintainance complexities.
So while continuing the bcmcfmac support for existing Infineon/Cypress
chipsets, Infineon is proposing this new inffmac driver for the newer
Secure Chipset Architechture based Infineon chipsets in the kernel.
We will continue to refine this inffmac driver codebase, to improve it
in the upcoming patchset revisions with more focus on IOT Devices.

> But I understand it is easier to work on your own driver if the chip
> architecture and programming is getting fundamentally different. Not
> seeing that in the current set of patches though. The bus and protocol
> layers look pretty much the same. Agree with Johannes that it would be
> better to start with a driver which provides basic wifi functionality or
> even just firmware initialization instead of throwing in everything and
> more off the bat.

We intentionally didn't include all of Infineon's changes in this
patchset to avoid overwhelming the reviewers, but will make sure some
of those critical changes are available in our next version patchset.
And we also acknowledge that this patchset turned out be quite big.
In the upcoming revisions, will remove some of the functionalities,
to shrink the driver codebase.

Kindly help with reviewing the upcoming inffmac patchset revisions,
as you have a very thorough knowledge on the linux FMAC WLAN Drivers.

> Anyway. I am glad to hear that Infineon intends to keep supporting
> brcmfmac for the older chipsets. I will store your contact info in my
> address book ;-)

Sure Arend, you can contact me. Also we have an Infineon mailing list
wlan-kernel-dev-list@infineon.com, through which you can reach out to
our team for support regarding our Infineon/Cypress chipsets in the
upstream kernel. Last year, we have tried to add this Infineon list
to brcm80211, as a replacement for the obsolete list that got removed
SHA-cyfmac-dev-list@infineon.com. That patch didn'get accepted.

Infineon will continue to upstream more patches to brcmfmac driver,
kindly help with reviewing them as well.
 
Regards,
Gokul

