Return-Path: <linux-wireless+bounces-28559-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id DFB5AC341DA
	for <lists+linux-wireless@lfdr.de>; Wed, 05 Nov 2025 07:59:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id CBDC94E1557
	for <lists+linux-wireless@lfdr.de>; Wed,  5 Nov 2025 06:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D87BD1F0991;
	Wed,  5 Nov 2025 06:59:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="NlJ8paW6"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp11.infineon.com (smtp11.infineon.com [217.10.52.105])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88FDD2C2365
	for <linux-wireless@vger.kernel.org>; Wed,  5 Nov 2025 06:59:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.105
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762325963; cv=none; b=RyrqJr0k5GRuPPS/FhXneJ0NiWWlW+P0uJqnd6/1lZSaDYK6NPHy7Fivxq9j3QzTjjZX3rUN+A4T4nDRNTsUcdXDBt7pd73TvHyORIqD15p+ajPh7Lt6BI/lJu/MUxjsnQ0RutNN1ElchXh4PmulnBH936+9VC/9UY/ZU+dlUDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762325963; c=relaxed/simple;
	bh=BUOblaikw86wccr7v9gpRYGUhsL9x6+7yqckIfF69/4=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=eR6i1LbcQMFk+nOJJLfo2DidceXIY/2HKmcEOYur7reLSQwqk8v/ds5TAZCm0NJjSLz4DsBcYDldqcJCqyJRN0D1doyarTLv+id57C9vXdEvZclQG8QzXE5nhH61z/xdKOcxOL5VMNPg1OBfxjCWEcPfQJfE2i16D2xsQy4XoO0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=NlJ8paW6; arc=none smtp.client-ip=217.10.52.105
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1762325962; x=1793861962;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BUOblaikw86wccr7v9gpRYGUhsL9x6+7yqckIfF69/4=;
  b=NlJ8paW6rmBh/+Le0E4p69sMkAM6OBPACoT9b2btM7McV6Ce95qg9XSO
   v/OBO5lSw5ls7bWaKv+u8Q5Yoxw+X0xHvQ7VyGlYw2hUArfZSoIEpDtPD
   NGLJ4z+SWWak9y9b+OVLGDuGeyLM7/tEzFgaKimaXyj0fGh6SOsemGviG
   M=;
X-CSE-ConnectionGUID: 4i1qtKEAQmS3upnzn7Stjw==
X-CSE-MsgGUID: xGLGJFifTpGPWxXyIuHmUg==
X-IronPort-AV: E=McAfee;i="6800,10657,11603"; a="117396066"
X-IronPort-AV: E=Sophos;i="6.19,281,1754949600"; 
   d="scan'208";a="117396066"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE814.infineon.com) ([172.23.29.40])
  by smtp11.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Nov 2025 07:58:11 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE814.infineon.com
 (172.23.29.40) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Wed, 5 Nov
 2025 07:58:10 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Wed, 5 Nov 2025 07:58:07 +0100
Date: Wed, 5 Nov 2025 12:28:00 +0530
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <wlan-kernel-dev-list@infineon.com>,
	Carter Chen <Carter.Chen@infineon.com>, Owen Huang <Owen.Huang@infineon.com>,
	Ian Lin <Ian.Lin@infineon.com>, JasonHuang <Jason.Huang2@infineon.com>,
	Shelley Yang <Shelley.Yang@infineon.com>, avishad verma
	<avishad.verma@infineon.com>
Subject: Re: [PATCH wireless-next 00/57] wifi: inffmac: introducing a driver
 for Infineon's new generation chipsets
Message-ID: <aQr1eO-5Gmg7JSf2@ISCN5CG14747PP.infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
 <4d46dfb13927a878f5684e9e8cfc51673e8df4b8.camel@sipsolutions.net>
 <aMqm-soAc5tzHQFf@ISCN5CG14747PP.infineon.com>
 <3cb0e7a95fdba1ee1003c10606fd58e7b9071c58.camel@sipsolutions.net>
 <dc5017d0e4eed59905597f000a11887e9e264eb9.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dc5017d0e4eed59905597f000a11887e9e264eb9.camel@sipsolutions.net>
X-ClientProxiedBy: MUCSE808.infineon.com (172.23.29.34) To
 MUCSE827.infineon.com (172.23.29.20)

On 11/04, Johannes Berg wrote:
> On Wed, 2025-09-17 at 14:23 +0200, Johannes Berg wrote:
> >
> > It'd be much easier to start with a reduced driver that doesn't have
> > everything, in particular not things that aren't already common and thus
> > need more careful review, perhaps even from experts outside of wifi,
> > such as the sensing part, XDP, offloads, and probably more.
> 
> Actually, it'd be even easier if you just added the necessary features
> to brcmfmac, since >50% of this driver is a straight-up copy of that
> anyway.
> 
> (I estimated 50% by a trivial rename and ignoring whitespace, which
> doesn't take into account further cleanups you've done such as
> firmware.c's renaming of the parser states.

We would like to explain the rationale behind our proposal for a new inffmac
driver, in addition to the information provided in the V1 patchet cover letter.
This could help in clarifying few questions. 

In V1 INFFMAC patchset, we already skipped including few other Infineon changes,
to avoid overwhelming the reviewers. Even still V1 turned out to be bigger
than the expected size for code review. Not including those other Infineon
changes in V1, would have given a misleading impression that both brcmfmac and
inffmac are similar. But they are quite different and it is not feasible to
add all the Infineon new generation chipset specific changes to the existing
brcmfmac driver without severly impacting the existing users.

We are currently working on V2 INFFMAC patchset to remove some more features
to reduce the codebase size for easier review, as you suggested earlier.
Also adding someother critical Infineon specific changes and additional cleanups.
Of course, few commands/events IDs and few functions might look similar
between the two drivers, which is primarily because some of the fundamental aspects
need change very rarely. But the critical aspects of the chipset architecture /
secure chip handshake / firmware update / control-path / data-path are different.

As you would be aware that, currently brcmfmac is retrofitted to support chipsets
from more than 3 WLAN chip vendor organizations (CYW from Infineon/Cypress,
BCA from Broadcom, WCC from Broadcom, etc). One of the major issue with this
WLAN driver model is, it is not practically feasible for each vendor to ensure
that their new chipset architecture specific driver changes do not cause any
regressions on the chipsets supported by other vendors in the same driver.
This has an impact for the end users. In a way, this severely hinders each
WLAN vendor from fully supporting their chipsets in upstream kernel with new
features for their chipsets. And currently brcmfmac uses fwvid (Firmware Vendor ID)
param in a vendor agnostic wrapper function brcmf_fwvid_*() to decide which command
to be sent to the vendor's firmware for doing a particular operation. For Example,
brcmf_fwvid_set_sae_password() for setting SAE password. This only handles the case
where two different vendor firmwares expecting two different commands for the same
operation. However, this does not solve the problem when each vendor firmware
expects commands in a different sequence. Also fwvid check is currently being used
only for sending commands/events to & from firmware, and for invoking cfg80211
callbacks. But other operations are also different across WLAN vendors with the
new generation chipsets, but they are currently handled in the same way for the
old generation chipsets in brcmfmac.

This is a unique situation in the community, where multiple WLAN vendors ended up
using a single driver codebase in the upstream kernel. For the older chipsets which
are already supported in brcmfmac, unfortunately we must continue this model to
avoid breaking support for the existing older chipsets in brcmfmac. And this model
is only feasible with some effort for older chipsets, as the chipset architecture has
more things in common due to Broadcom origin, even if they are currently managed by
a different WLAN vendor with a firmware release. And we are committed to continuing
support for Infineon chipsets that are already recognized by the upstream brcmfmac
driver.

However, this model would not be scalable further for new generation chipsets
developed individually by each WLAN vendor having different chipset architectures /
secure chip handshake / firmware update / control-path / data-path as mentioned
above. To address this, we are proposing this new inffmac driver only for the newer
chipsets originating from Infineon as we have additional focus on Wi-Fi support and
features specifically needed for the IoT products. So kindly requesting to look
into the upcoming V2 INFFMAC patchset.

Gokul

