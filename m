Return-Path: <linux-wireless+bounces-7680-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 723A48C6247
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 09:56:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 364E128339A
	for <lists+linux-wireless@lfdr.de>; Wed, 15 May 2024 07:56:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C9B52481D0;
	Wed, 15 May 2024 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wEXcOsbG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC05374D1;
	Wed, 15 May 2024 07:56:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715759772; cv=none; b=Dy/jrASdFAfFvmWCoAi8xmDcHZd6LzAoOnuHrxMUR2siFDllk1Sx8X8sFRG2iw2ihE9UnDcLvRTTYuexM9nEjSpp23pkx/4CpxCp5MrHLJrVMfZ/xYC0sd/rwhVEGoWVr/Y1wvVZEDGPsCRL5bPUPsGP8sJMAznHkH3v3j8iFU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715759772; c=relaxed/simple;
	bh=uKH9u89PoqokIDK4hendehhmL2WZxBfsMlAPWgg6f+8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JvP0oXtq6rGSLtAJEITfEBqbTYDXEVqkJsURPhdZ1h5XBmj1gnq9XUHoYB1Kknw/lYxihS8yu5rA2nCGHQC5OOPCalBPnOfE9T2FjowUWvtFAEiBveD/qegIGhjWf2BnfIziENuX4oT7MbpPrqibAJ8V3rpLyI8LN5BHzqbDxP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wEXcOsbG; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B30B8C116B1;
	Wed, 15 May 2024 07:56:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
	s=korg; t=1715759772;
	bh=uKH9u89PoqokIDK4hendehhmL2WZxBfsMlAPWgg6f+8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=wEXcOsbGtnz+ojx0BNc/2zRSPDwPLyn1XBD2DAkHLe68AEQ/X/y2SnL+dKj7Y46E1
	 yBIzeaVDOPq7VLDeY1++cb4rNPJPw7Pgicdm7fH8mq2Qf25paw6QzwISKsbqtAbsKV
	 YRxlekXHo4KLzY7nL39DZ1OAVSczApONOYRmyP1I=
Date: Wed, 15 May 2024 09:56:09 +0200
From: Greg KH <gregkh@linuxfoundation.org>
To: Linux regressions mailing list <regressions@lists.linux.dev>
Cc: Oleksandr Natalenko <oleksandr@natalenko.name>,
	linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
	Johannes Berg <johannes@sipsolutions.net>,
	linux-mediatek@lists.infradead.org,
	linux-arm-kernel@lists.infradead.org, Felix Fietkau <nbd@nbd.name>,
	Lorenzo Bianconi <lorenzo@kernel.org>,
	Ryder Lee <ryder.lee@mediatek.com>,
	Shayne Chen <shayne.chen@mediatek.com>,
	Sean Wang <sean.wang@mediatek.com>, Kalle Valo <kvalo@kernel.org>,
	Matthias Brugger <matthias.bgg@gmail.com>,
	AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>,
	Peter Chiu <chui-hao.chiu@mediatek.com>,
	StanleyYP Wang <StanleyYP.Wang@mediatek.com>
Subject: Re: [REGRESSION] MT7915E doesn't work any more with v6.9
Message-ID: <2024051552-subatomic-roundup-fccf@gregkh>
References: <6061263.lOV4Wx5bFT@natalenko.name>
 <2341660.ElGaqSPkdT@natalenko.name>
 <60fe8df750a74331b8a54a76d55d5e8349ac46b4.camel@sipsolutions.net>
 <2200096.irdbgypaU6@natalenko.name>
 <a603a67b-6703-4f63-93ee-98a05c605d02@leemhuis.info>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <a603a67b-6703-4f63-93ee-98a05c605d02@leemhuis.info>

On Wed, May 15, 2024 at 09:40:40AM +0200, Linux regression tracking (Thorsten Leemhuis) wrote:
> On 15.05.24 09:15, Oleksandr Natalenko wrote:
> > On středa 15. května 2024 8:23:35, SELČ Johannes Berg wrote:
> >> On Wed, 2024-05-15 at 00:51 +0200, Oleksandr Natalenko wrote:
> >>> Also /cc Johannes because of this commit:
> >>>
> >>> 6092077ad09ce wifi: mac80211: introduce 'channel request'
> >>>
> >>> On středa 15. května 2024 0:43:40, SELČ Oleksandr Natalenko wrote:
> >>>> Hello Felix, Lorenzo et al.
> >>>>
> >>>> With v6.9 kernel the following card:
> >>>>
> >>>> 01:00.0 Unclassified device [0002]: MEDIATEK Corp. MT7915E 802.11ax PCI Express Wireless Network Adapter [14c3:7915]
> >>>> doesn't work any more. Upon mt7915e module insertion the following splat happens:
> >>
> >> 6.9 didn't get commit 2f7cf3b61d85 ("wifi: mt76: mt7915: add missing
> >> chanctx ops")? Huh?
> 
> FWIW, seems there was and earlier report about this that I missed:
> https://lore.kernel.org/all/CAAMvbhGHe4PM5M=JJZRQ2m5_aVZ=4DPG76MT+q5qi3HA+7_wzQ@mail.gmail.com/
> 
> > Yes, you are right, this commit is not present in v6.9, and I can find it in the "next" branch only.
> > 
> > I can also confirm this commit fixes the regression for me.
> 
> So all we need to resolve this is to ask Greg to pick up the patch for
> the next 6.9.y. release? Then I'll take care of that in a few hours,
> unless somebody else does it first or I get some kind of "might be a bad
> idea for now" signal from anyone.

Now picked up for 6.9.y.

greg k-h

