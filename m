Return-Path: <linux-wireless+bounces-24239-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A3F4ADE618
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 10:52:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 692F83A54AF
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 08:52:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4A627EFFA;
	Wed, 18 Jun 2025 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CTtSWte3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3999277C86;
	Wed, 18 Jun 2025 08:52:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750236749; cv=none; b=tSfbI/VRtFve6loF2WU3/I4/K+vwTUC5VslD08EoVWXn4EiTXYViqTO1ccCASUxNqOfZzX4PHxWG30wAr6AiE942iNp97S6Hadzvbd28S6NDYRKB6TLUZH8ywvazqw45xHopROhKDSXPODeVqLr5bWscDINp6SJ8KMM43iQXkYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750236749; c=relaxed/simple;
	bh=YYAfe+jT3/T+gf0veCVMjarKEBwX7zg9Od2H/Zs/XnI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dMLolhSkaflkYLnQuzVztGp1e32tHPEhd3NJ6tquEJWuC3v1vFz8DT3PRoLfU7pT83NjbslpNIWJXVVkdCJYw0345g7yT9fgRO4HxZbUTxFO75kj92ilZ872PZfNLyy74jCh7L6aFjSpN502xhkTbD5lA92AbFEYeaAXb1sZdlg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CTtSWte3; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DC41C4CEE7;
	Wed, 18 Jun 2025 08:52:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750236749;
	bh=YYAfe+jT3/T+gf0veCVMjarKEBwX7zg9Od2H/Zs/XnI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=CTtSWte3NFoRlUQ6F3z2bCnr1PbOzTYIT77XUyFPDOHzJqlhJRgJC5urhJdO2JgVs
	 3jHkY1Ok/An/4CKTPYFXfUFuph1/E7+f0DdeTaVhRNl4WnxjwwQTwdXDijWjymn+Db
	 nHmCktSwafFX/Hlt9f1z4Eqgbkqzvb8yTChDDoYavpdjx9sYYDZLvzyfQAX1R7imI3
	 jiXvo7eqSQXem3y5J9yPyKB9Tp1AJ8O4fDkPChW346JSSE1WcZ+625RF9UrOR7CKF5
	 cTZyUUZbPJw5KADrS3BSZG3OjIGS4WCm1cFWsHD8kKk1fExAEWRM3BzHyHFKIdWdQ6
	 AHR01Nh9ysFaw==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uRoWx-000000002M1-3fAT;
	Wed, 18 Jun 2025 10:52:27 +0200
Date: Wed, 18 Jun 2025 10:52:27 +0200
From: Johan Hovold <johan@kernel.org>
To: Konrad Dybcio <konrad.dybcio@oss.qualcomm.com>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Jeff Johnson <jjohnson@kernel.org>, linux-wireless@vger.kernel.org,
	ath11k@lists.infradead.org, linux-kernel@vger.kernel.org,
	Takashi Iwai <tiwai@suse.de>,
	Bjorn Andersson <bjorn.andersson@oss.qualcomm.com>,
	Johan Hovold <johan+linaro@kernel.org>
Subject: Re: [PATCH ath-next v3 5/6] wifi: ath11k: choose default PM policy
 for hibernation
Message-ID: <aFJ-SwT1g500h3kC@hovoldconsulting.com>
References: <20250328-ath11k-bring-hibernation-back-v3-0-23405ae23431@quicinc.com>
 <20250328-ath11k-bring-hibernation-back-v3-5-23405ae23431@quicinc.com>
 <d0cd065c-1cd1-4e56-8c57-60777b1f3664@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d0cd065c-1cd1-4e56-8c57-60777b1f3664@oss.qualcomm.com>

On Wed, Jun 18, 2025 at 02:15:04AM +0200, Konrad Dybcio wrote:
> On 3/28/25 6:32 AM, Baochen Qiang wrote:
> > Now WoWLAN mode is chosen for those machines listed in the quirk table.
> > This works for suspend (S3) but breaks for hibernation (S4), because
> > WoWLAN mode requires WLAN power to be sustained, which is not the case
> > during hibernation. For hibernation, the default mode should be used.
> > 
> > Register a PM notifier with which kernel can notify us of the actual PM
> > operation: if system is going to suspend, the original PM policy is
> > honored; while if it is hibernation, overwrite it with default policy.
> > 
> > To summarize: for suspend (S3), WoWLAN mode is chosen for machines listed
> > in the quirk table, non-WoWLAN mode for others; for hibernation (S4),
> > non-WoWLAN mode is chosen for all.
> > 
> > Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> > 
> > Tested-by: Takashi Iwai <tiwai@suse.de>
> > Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> > ---
> 
> I've bisected the following splat to this patch, still happening on
> linux-next/master, WCN6855 + SC8280XP CRD, 100% reproducibility 

WFIW, I'm not seeing this with 6.16-rc2 (which has this patch) on either
the X13s or sc8280xp-crd (ath11k now fails to resume on the latter
because of missing regulatory data, but that appears to be a separate
regression).

> [root@sc8280xp-crd ~]# echo mem > /sys/power/state 
> [   20.267830] fb0: Framebuffer is not in virtual address space.
> [   39.863070] PM: suspend entry (s2idle)
> [   39.908067] Filesystems sync: 0.035 seconds
> [   39.934453] ------------[ cut here ]------------
> [   39.939259] Invalid notifier called!
> [   39.939268] WARNING: CPU: 5 PID: 513 at kernel/notifier.c:79 notifier_call_chain+0x84/0x1a4
> [   39.951566] Modules linked in:
> [   39.954732] CPU: 5 UID: 0 PID: 513 Comm: bash Not tainted 6.14.0-rc4longbois-01215-g32d93b51bc7e #12177

6.14?

> [   39.964396] Hardware name: Qualcomm QRD, BIOS 6.0.230525.BOOT.MXF.1.1.c1-00114-MAKENA-1 05/25/2023

Johan

