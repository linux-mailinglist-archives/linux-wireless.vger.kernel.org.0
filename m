Return-Path: <linux-wireless+bounces-28672-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0A743C3D3A4
	for <lists+linux-wireless@lfdr.de>; Thu, 06 Nov 2025 20:24:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AFCD63AB544
	for <lists+linux-wireless@lfdr.de>; Thu,  6 Nov 2025 19:24:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF889337B99;
	Thu,  6 Nov 2025 19:24:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b="JgMs1toH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp2.infineon.com (smtp2.infineon.com [217.10.52.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28F7B757EA
	for <linux-wireless@vger.kernel.org>; Thu,  6 Nov 2025 19:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.10.52.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762457047; cv=none; b=Arkkr72r+5rIQcjGdBTJmp2iSTN/cPUztK8jXEoHWjjOx4RxakdNq67KpX7ic7u8IwsOw4eO+ZiRzxRMg4/bdsHj5VF564DAzmyOkaK5G8K6CEXCu58LIkWltckgv/N+Z1gT7fGosmOoW/pIDT+dEs4Gi86mt3spFgjtyl/Ic/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762457047; c=relaxed/simple;
	bh=7qZYSYhfSN1+qhGofitUTrLN6Ax0HIah9z0gC2b7hcc=;
	h=Date:From:To:CC:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=M079yVoGfF8+yfK6XhTM6XblhSanawPpxIcFh5fVzsm9T+N1PzwFzES0oeH8e3kaJ89Wk7D+gRiuIcdHzHvzv7ekBDm7LfKX13F8RMRGMbCTxng1xl9vAYPMlEMUZ4ZAFgJiZPRA0auGZB2C1w6zWOnK5ENKmATfBasjU/LY5D0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com; spf=pass smtp.mailfrom=infineon.com; dkim=pass (1024-bit key) header.d=infineon.com header.i=@infineon.com header.b=JgMs1toH; arc=none smtp.client-ip=217.10.52.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=infineon.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=infineon.com
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=infineon.com; i=@infineon.com; q=dns/txt; s=IFXMAIL;
  t=1762457046; x=1793993046;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=7qZYSYhfSN1+qhGofitUTrLN6Ax0HIah9z0gC2b7hcc=;
  b=JgMs1toHv6lKeHFpvhD0l+mJ3Unhjw4TOiKDaD2NVVfNbmrMGxl/nwEJ
   ml1/Y4pNPlARqxYUQMfuCJthZu2XRBvcGPL2dHRhrZX9Hmjh4de4V3KD9
   y5d6HbguA+W5hLUk5TahJshsed0JkPwEXBSYRkAJdX/ZR2Lq5E+exwlpS
   I=;
X-CSE-ConnectionGUID: wiGP3YewRd+bzxLFBpwKDw==
X-CSE-MsgGUID: WGNET0WkS9eXxmGh+06pog==
X-IronPort-AV: E=McAfee;i="6800,10657,11605"; a="131388838"
X-IronPort-AV: E=Sophos;i="6.19,284,1754949600"; 
   d="scan'208";a="131388838"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO MUCSE812.infineon.com) ([172.23.29.38])
  by smtp2.infineon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Nov 2025 20:22:53 +0100
Received: from MUCSE827.infineon.com (172.23.29.20) by MUCSE812.infineon.com
 (172.23.29.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.29; Thu, 6 Nov
 2025 20:22:52 +0100
Received: from ISCN5CG14747PP.infineon.com (10.161.6.196) by
 MUCSE827.infineon.com (172.23.29.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.29; Thu, 6 Nov 2025 20:22:50 +0100
Date: Fri, 7 Nov 2025 00:52:38 +0530
From: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>
To: Johannes Berg <johannes@sipsolutions.net>
CC: <linux-wireless@vger.kernel.org>, <wlan-kernel-dev-list@infineon.com>,
	Carter Chen <Carter.Chen@infineon.com>, Owen Huang <Owen.Huang@infineon.com>,
	Ian Lin <Ian.Lin@infineon.com>, JasonHuang <Jason.Huang2@infineon.com>,
	Shelley Yang <Shelley.Yang@infineon.com>, avishad verma
	<avishad.verma@infineon.com>
Subject: Re: [PATCH wireless-next 00/57] wifi: inffmac: introducing a driver
 for Infineon's new generation chipsets
Message-ID: <aQz1fiYQW2BsKi6Z@ISCN5CG14747PP.infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
 <4d46dfb13927a878f5684e9e8cfc51673e8df4b8.camel@sipsolutions.net>
 <aMqm-soAc5tzHQFf@ISCN5CG14747PP.infineon.com>
 <3cb0e7a95fdba1ee1003c10606fd58e7b9071c58.camel@sipsolutions.net>
 <dc5017d0e4eed59905597f000a11887e9e264eb9.camel@sipsolutions.net>
 <aQr1eO-5Gmg7JSf2@ISCN5CG14747PP.infineon.com>
 <e10958bc500acbf514ef664387d1df61a065a70d.camel@sipsolutions.net>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <e10958bc500acbf514ef664387d1df61a065a70d.camel@sipsolutions.net>
X-ClientProxiedBy: MUCSE815.infineon.com (172.23.29.41) To
 MUCSE827.infineon.com (172.23.29.20)

On 11/05, Johannes Berg wrote:
> On Wed, 2025-11-05 at 12:28 +0530, Gokul Sivakumar wrote:
> >
> > In V1 INFFMAC patchset, we already skipped including few other Infineon changes,
> > to avoid overwhelming the reviewers. Even still V1 turned out to be bigger
> > than the expected size for code review.
> 
> Well, the patchset isn't even self-contained, with random cfg80211
> changes thrown in. You cannot bury such changes in "this is my new
> driver" patchsets, I'm not sure why you even considered this acceptable
> before posting it. If this was the first time you're showing up to the
> list I'd simply ignore it _completely_ (like the weird new Android
> driver that showed up recently.)

We understand. Perhaps, if the first version patchset was submitted
with an RFC label, it would have been more appropriate. As you suggested,
we are now skipping those cfg80211 changes in the upcoming V2 patchset.
Later, when needed, we will submit them for review as a separate series.

> > Not including those other Infineon
> > changes in V1, would have given a misleading impression that both brcmfmac and
> > inffmac are similar.
> 
> I'm not sure I'd call it "misleading" when it's >50% identical code?

We agree that there are some identical code, we will refine the patchset
further and also remove the less important changes among them with more
cleanups.

> > But they are quite different and it is not feasible to
> > add all the Infineon new generation chipset specific changes to the existing
> > brcmfmac driver without severly impacting the existing users.
> 
> Sorry, but no. You don't get to give us the spiel about users. _That_
> problem is entirely of your own making, because you decided to go out-
> of-tree for a significant amount of time and not discuss with the
> community about how to approach this. Then you gave that non-upstream
> version to the users and now you think somehow that entitles you to dump
> it on the community as well. No. I have no sympathy for that all, you
> don't get to make that upstream's problem, own it like the problem of
> your own making that it is.
> 
> But look, I get it, you don't want to be tied to the "Broadcom legacy"
> forever. And that even makes sense. But from what I can tell you've
> basically taken brcmfmac and bolted on random changes. And you worry
> doing that to brcmfmac would break others, that's not too far-fetched -
> welcome to working with the community I guess?

We acknowledge that, in the past, Infineon did maintain some patches in
the downstream. We are now committed to address this issue. Going forward,
Infineon's intent is to closely work with the community and make a proper
upstream support available for its chipsets.

> And while I'm sympathetic to that, just like NXP with mwifiex/nxpwifi
> you don't get to pretend that an ancient brcmfmac driver with bolted on
> Infineon changes is "state of the art" in any way. You'd need to show
> that you've actually done some homework on this new driver.

Understood your concerns. We are working to improve the quality of the
new inffmac driver in the upcoming versions. Bringup of native XDP support
for PCIe in inffmac was an initiative to provide more programmability to
the users. But ofcourse as you commented earlier, this needs to be properly
reviewed by the folks in BPF list too. So we are skipping this as well in V2.
But will incorporate other changes that are helpful in the new driver like,
allocating memory from the Page Pool instead of allocating an SKB before
doing PCIe DMA from Device, etc. In addition, we will try to cleanup the
legacy designs wherever feasible.

> We know from the long discussion about the p2p device crash for example
> that the way brcmfmac grew did definitely _not_ end up with a well-
> designed system. With a new driver you should be able to re-architect
> things to fix these issues more cleanly, such as improving the dynamic
> vif handling etc., but ... it doesn't even look like you ported *your
> own* bugfix for that to inffmac!

Well, the fix for the AP mode crash during Action Frame TX is infact already
available in V1 inffmac patchset. The changes might not look exactly similar
due to the order of the function arguments in p2p.c. But the logic of the fix
is the same, ie, for sending "actframe" cmd to the firmware, driver utilizes
the vif corresponding to the wdev on which Action frame TX was initiated by
userspace. Whereas crash happens only if there is a driver dependency on the
uninitialized P2P Device vif for Action frame TX in AP mode. Further cleanup
is definitely needed here to separate out P2P from the Action frame TX logic.
We will cleanup this in V2.

> And as we discussed with NXP, things have changed since all of these old
> drivers like mwifiex or brcmfmac were integrated - their current state
> is definitely not something reasonable today any more, just nobody has
> really maintained them and we keep them (vaguely) alive. Your code feels
> to me like you think copying brcmfmac makes a good driver, but in case
> it wasn't clear yet: it doesn't. There's a lot of new infrastructure
> like wiphy locking and wiphy work in particular that I think a new
> driver should be using or have very good, documented, reasons for not
> doing so. Copying an old driver doesn't really cut it in that respect.
> 
> > We are currently working on V2 INFFMAC patchset to remove some more features
> > to reduce the codebase size for easier review, as you suggested earlier.
> 
> And then the next step is to take a close look at the architecture, I'm
> especially interested in the locking architecture, as I mentioned above.

Noted, we will try to utilize the newly available infrastructure as much as
possible for the new driver to improve its quality in the upcoming versions.
Kindly let us know if you have any other suggestions.

Gokul

