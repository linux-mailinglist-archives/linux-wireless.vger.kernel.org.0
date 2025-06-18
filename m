Return-Path: <linux-wireless+bounces-24240-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 44FCAADE62C
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 10:58:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2AEE17457F
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 08:58:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3BE2D215F42;
	Wed, 18 Jun 2025 08:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Th1bX929"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 149202556E;
	Wed, 18 Jun 2025 08:58:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750237081; cv=none; b=lIxOWiYcfxaGgre+nkt4adGmG8H2/OMwnGgbGjB0yRVnUoR6RfIGV9G0a6gX+TfFTjFi9LZNj/zXeH+MS8Iz5v2W1peWioUbk3GZJm2LGMgFzaJOL/lUEwhTquXCfUbDkUav4zkwAbYWQe93ZfDFpKMcDyNWA5TRB/d9JofeayI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750237081; c=relaxed/simple;
	bh=wqrA8bKqxtN3oLYl0+ONBhmLPe1OSnjffCbLNpdz1kg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oYpiFv4AMdSfu7o3vO4dsiHAEwVQCByld9LkM86jRNhGF0xfpMsnWl7L5M4NBFFREQzkVY46GBLX6fjIWNyac74acLBDajHdio29183ou1DdlD9lVOgMAzQQssmeu2NS2vtkX5t/joBGs2OFClCOoj1fiKOlewtwdNRwXPrxBN8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Th1bX929; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6783DC4CEE7;
	Wed, 18 Jun 2025 08:58:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750237080;
	bh=wqrA8bKqxtN3oLYl0+ONBhmLPe1OSnjffCbLNpdz1kg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Th1bX929khRVUWpVsv5RPOq70HqpzMbAWPN0PsLo7//IZKJRWrBq+Fe3HVWzymrwK
	 hK9f/BQi1o15BjH9kDRRIb37zeNnkzM5o+8ONhM6EfYMXfgh647tIrhZYqoU/IG1qB
	 dP0mL9tuETQEAx4YKjkemIc+afhaLP0HxT0YDkByN+dVXT/upjq4C9A62gjZUwK3ic
	 n0j7st3u4XQ5KfMVaE9seunzMCMmPWWzesgCUAFf21lscBqYYMhoCuMIi9KmhmCJQi
	 ogMKEpFQ02H+zlKYVdKw8ExRS+AVjMc6t/nGrIUPR+cg19J5mh4bMFE4G8PCW1fROb
	 7mxTqxBNPFTuQ==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uRocJ-000000002S6-0sc6;
	Wed, 18 Jun 2025 10:57:59 +0200
Date: Wed, 18 Jun 2025 10:57:59 +0200
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
Message-ID: <aFJ_l_BbjxXDBJDD@hovoldconsulting.com>
References: <20250328-ath11k-bring-hibernation-back-v3-0-23405ae23431@quicinc.com>
 <20250328-ath11k-bring-hibernation-back-v3-5-23405ae23431@quicinc.com>
 <d0cd065c-1cd1-4e56-8c57-60777b1f3664@oss.qualcomm.com>
 <aFJ-SwT1g500h3kC@hovoldconsulting.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <aFJ-SwT1g500h3kC@hovoldconsulting.com>

On Wed, Jun 18, 2025 at 10:52:27AM +0200, Johan Hovold wrote:
> On Wed, Jun 18, 2025 at 02:15:04AM +0200, Konrad Dybcio wrote:
> > On 3/28/25 6:32 AM, Baochen Qiang wrote:
> > > Now WoWLAN mode is chosen for those machines listed in the quirk table.
> > > This works for suspend (S3) but breaks for hibernation (S4), because
> > > WoWLAN mode requires WLAN power to be sustained, which is not the case
> > > during hibernation. For hibernation, the default mode should be used.
> > > 
> > > Register a PM notifier with which kernel can notify us of the actual PM
> > > operation: if system is going to suspend, the original PM policy is
> > > honored; while if it is hibernation, overwrite it with default policy.
> > > 
> > > To summarize: for suspend (S3), WoWLAN mode is chosen for machines listed
> > > in the quirk table, non-WoWLAN mode for others; for hibernation (S4),
> > > non-WoWLAN mode is chosen for all.
> > > 
> > > Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> > > 
> > > Tested-by: Takashi Iwai <tiwai@suse.de>
> > > Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> > > ---
> > 
> > I've bisected the following splat to this patch, still happening on
> > linux-next/master, WCN6855 + SC8280XP CRD, 100% reproducibility 
> 
> WFIW, I'm not seeing this with 6.16-rc2 (which has this patch) on either
> the X13s or sc8280xp-crd (ath11k now fails to resume on the latter
> because of missing regulatory data, but that appears to be a separate
> regression).

Scratch that bit about failing to resume, it's just a warning that's
new.

> > [root@sc8280xp-crd ~]# echo mem > /sys/power/state 
> > [   20.267830] fb0: Framebuffer is not in virtual address space.
> > [   39.863070] PM: suspend entry (s2idle)
> > [   39.908067] Filesystems sync: 0.035 seconds
> > [   39.934453] ------------[ cut here ]------------
> > [   39.939259] Invalid notifier called!
> > [   39.939268] WARNING: CPU: 5 PID: 513 at kernel/notifier.c:79 notifier_call_chain+0x84/0x1a4
> > [   39.951566] Modules linked in:
> > [   39.954732] CPU: 5 UID: 0 PID: 513 Comm: bash Not tainted 6.14.0-rc4longbois-01215-g32d93b51bc7e #12177
> 
> 6.14?
> 
> > [   39.964396] Hardware name: Qualcomm QRD, BIOS 6.0.230525.BOOT.MXF.1.1.c1-00114-MAKENA-1 05/25/2023

Johan

