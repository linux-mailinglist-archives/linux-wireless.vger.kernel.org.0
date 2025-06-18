Return-Path: <linux-wireless+bounces-24242-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2202CADE766
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 11:45:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 78F703A7927
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Jun 2025 09:43:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B9231DDC28;
	Wed, 18 Jun 2025 09:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="neEXwqZZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 33D96BA27;
	Wed, 18 Jun 2025 09:44:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750239848; cv=none; b=fI4aqP4i6IgEu6zx7uR/R/f2jl7OkRYvZZO9Xgn91CscKiysKvAKcNrNSIwCBivx8dAWbX1jbLecp6Ir1AK6SCk2BzmVejx3sZbSb7fQ+0oaFCIvHP+vreic5SZfKpnT/bqVU18QBsk6vogfpQcKVw1N8jGm6Vr8DYjV4QY4JX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750239848; c=relaxed/simple;
	bh=QkcnRg0iy50X+xX4AMzHouOiJ6kRpTXVHmHLRfKjhc4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Kj7+4NxK19WCzQtymasM50uMA2C+97ddxjGO+ye3VKTYFFQzquSjK7oGKmjTtLJH9nmXU7e2ydv2a4SBky/9Ll6ZWqBOBkJpBoPNO9J0CM5DDmmaz1lFmmRBqxezYiPMrUaJMhe73xMmXEdPQYOyziJaPSZdhK4P7KtJkgSsQvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=neEXwqZZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB960C4CEE7;
	Wed, 18 Jun 2025 09:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1750239847;
	bh=QkcnRg0iy50X+xX4AMzHouOiJ6kRpTXVHmHLRfKjhc4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=neEXwqZZmVh67q5zkgde9c29BEJCb6tH8Qua3s0TA+XrUU6VKIuH85vY6PNJdFof5
	 maQ//bBvXXqPemj4unlMGPULXfDmcvhSS257cQPK8cH27faQpTNluK4f/hhDCFLl8N
	 vaC2lV37WhMxyzToyowtD2tLl/+qNr7eqOPObJJHfBWqfPDhd0MHPFsBR7pPBfzBUB
	 Eje+IxB4j3kf0YCnzsGde+xzbz+S18GRuLiTIwCJP62Zsr82bQvl/OwtlkOm6G0JHZ
	 JTm7sdspl7ZhrjjdBecfrhVe/qT/kVY95XBTq2nd+DC4ICHjHdoAedo2Gq7diglOKN
	 Hf4L9l47vunpg==
Received: from johan by xi.lan with local (Exim 4.97.1)
	(envelope-from <johan@kernel.org>)
	id 1uRpKw-000000005Yg-2Obb;
	Wed, 18 Jun 2025 11:44:06 +0200
Date: Wed, 18 Jun 2025 11:44:06 +0200
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
Message-ID: <aFKKZtbTIesVYgJK@hovoldconsulting.com>
References: <20250328-ath11k-bring-hibernation-back-v3-0-23405ae23431@quicinc.com>
 <20250328-ath11k-bring-hibernation-back-v3-5-23405ae23431@quicinc.com>
 <d0cd065c-1cd1-4e56-8c57-60777b1f3664@oss.qualcomm.com>
 <aFJ-SwT1g500h3kC@hovoldconsulting.com>
 <db65c9f0-334f-43fb-bddf-316bf883a848@oss.qualcomm.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db65c9f0-334f-43fb-bddf-316bf883a848@oss.qualcomm.com>

On Wed, Jun 18, 2025 at 11:18:14AM +0200, Konrad Dybcio wrote:
> On 6/18/25 10:52 AM, Johan Hovold wrote:
> > On Wed, Jun 18, 2025 at 02:15:04AM +0200, Konrad Dybcio wrote:
> >> On 3/28/25 6:32 AM, Baochen Qiang wrote:
> >>> Now WoWLAN mode is chosen for those machines listed in the quirk table.
> >>> This works for suspend (S3) but breaks for hibernation (S4), because
> >>> WoWLAN mode requires WLAN power to be sustained, which is not the case
> >>> during hibernation. For hibernation, the default mode should be used.
> >>>
> >>> Register a PM notifier with which kernel can notify us of the actual PM
> >>> operation: if system is going to suspend, the original PM policy is
> >>> honored; while if it is hibernation, overwrite it with default policy.
> >>>
> >>> To summarize: for suspend (S3), WoWLAN mode is chosen for machines listed
> >>> in the quirk table, non-WoWLAN mode for others; for hibernation (S4),
> >>> non-WoWLAN mode is chosen for all.
> >>>
> >>> Tested-on: WCN6855 hw2.0 PCI WLAN.HSP.1.1-03125-QCAHSPSWPL_V1_V2_SILICONZ_LITE-3.6510.30
> >>>
> >>> Tested-by: Takashi Iwai <tiwai@suse.de>
> >>> Signed-off-by: Baochen Qiang <quic_bqiang@quicinc.com>
> >>> ---
> >>
> >> I've bisected the following splat to this patch, still happening on
> >> linux-next/master, WCN6855 + SC8280XP CRD, 100% reproducibility 
> > 
> > WFIW, I'm not seeing this with 6.16-rc2 (which has this patch) on either
> > the X13s or sc8280xp-crd (ath11k now fails to resume on the latter
> > because of missing regulatory data, but that appears to be a separate
> > regression).
> 
> Do you have CONFIG_DEBUG_NOTIFIERS?

Nope. Would have been useful to mention in your report.

But I'm not seeing the warning with 6.16-rc2 with that option enabled
either.

> >> [root@sc8280xp-crd ~]# echo mem > /sys/power/state 
> >> [   20.267830] fb0: Framebuffer is not in virtual address space.
> >> [   39.863070] PM: suspend entry (s2idle)
> >> [   39.908067] Filesystems sync: 0.035 seconds
> >> [   39.934453] ------------[ cut here ]------------
> >> [   39.939259] Invalid notifier called!
> >> [   39.939268] WARNING: CPU: 5 PID: 513 at kernel/notifier.c:79 notifier_call_chain+0x84/0x1a4
> >> [   39.951566] Modules linked in:
> >> [   39.954732] CPU: 5 UID: 0 PID: 513 Comm: bash Not tainted 6.14.0-rc4longbois-01215-g32d93b51bc7e #12177
> > 
> > 6.14?
> 
> g show 32d93b51bc7e2e557771abe4a88da69c609e3d52:Makefile | head
> 
> # SPDX-License-Identifier: GPL-2.0
> VERSION = 6
> PATCHLEVEL = 14
> SUBLEVEL = 0
> EXTRAVERSION = -rc4
> 
> it's been in the tree for a while

Ah, maybe in linux-next, it was only merged to mainline for 6.16-rc1.

Johan

