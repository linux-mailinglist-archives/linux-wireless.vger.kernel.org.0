Return-Path: <linux-wireless+bounces-17137-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B1AC4A03C3D
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 11:24:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id C68427A2B3B
	for <lists+linux-wireless@lfdr.de>; Tue,  7 Jan 2025 10:23:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 388E61E47CC;
	Tue,  7 Jan 2025 10:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b="EZ8Bk5yi"
X-Original-To: linux-wireless@vger.kernel.org
Received: from mx4.wp.pl (mx4.wp.pl [212.77.101.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBD861E3DD1
	for <linux-wireless@vger.kernel.org>; Tue,  7 Jan 2025 10:23:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=212.77.101.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736245430; cv=none; b=B3f4GaFhrYq8zT33CagoIx8YX0ey7b+JzyJKkeo72FOiwBIRTRVGQxHdfJcFBINcnbKkBAn7pFUMDUT49VQjhpv4D+vHKDv+vpEF2sAw66R2eBuqoYXhbm/AyIfDAiW4PmPyggy7cw85+75osLqng+FpWHbg2XZT80mub1UjmJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736245430; c=relaxed/simple;
	bh=ENRZw0wrSlkHL51Eir0SOb6OZkmHuS6753Sg+wvQmdc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=X7lgp07bqZT0z7S23InXxVEoj1IdckckCoHRbYYUqDnW6NDF6oKgEEko6cUrxG0/Hl3IiItOj7+t3Ce3xrilyGVsihICDiaKAASWTPjYNnDrC+WHtC3jbTDMxYxOfJgL00S38Bk0DpLOgrtOZRVF0l0LlMJGNPOOHQlGOqj9vfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl; spf=pass smtp.mailfrom=wp.pl; dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.b=EZ8Bk5yi; arc=none smtp.client-ip=212.77.101.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Received: (wp-smtpd smtp.wp.pl 30304 invoked from network); 7 Jan 2025 11:23:35 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=20241105;
          t=1736245415; bh=ae3iHmFyFKfPB1ihSnkhLzujkbnClLYu78pfaVBQOSw=;
          h=From:To:Cc:Subject;
          b=EZ8Bk5yikdhrnF1LQb7Ml1mycW6e7ULMPKyICAmLrP/4+m83yV9/pCdW4Ip0pArwy
           7D5VBVrNHYbBTLciuG5rJwTbPOk3M9DMTqOLdqfi70VjjbM9yHhYD1T9gpVqYtopEV
           9RYFWNv/uD1UxvzWFMmVmr7Jy4AUKMDJJrI4f1Q+XL4hBTu489ij4o/5J41hBII/rl
           u3OEl3XXQGsa6WkdCwPVXMf83ZQSXjU7O/iGbaoCsgYyxH6EppYRfECPUNIi27LYUm
           aFW/H722LR7iegEkW0J6rV1CRip4P37ykE4XA6U6B4Nsuz5naRdjCHuYULM8XKT6/T
           jrYHPr5FyKVQw==
Received: from 89-64-6-19.dynamic.chello.pl (HELO localhost) (stf_xl@wp.pl@[89.64.6.19])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with ECDHE-RSA-AES256-GCM-SHA384 encrypted SMTP
          for <Ariel.Otilibili-Anieli@eurecom.fr>; 7 Jan 2025 11:23:35 +0100
Date: Tue, 7 Jan 2025 11:23:35 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: Ariel Otilibili-Anieli <Ariel.Otilibili-Anieli@eurecom.fr>
Cc: Daniel Golle <daniel@makrotopia.org>,
	Shiji Yang <yangshiji66@outlook.com>,
	linux-wireless@vger.kernel.org, netdev@vger.kernel.org,
	Kalle Valo <kvalo@kernel.org>,
	Tomislav =?utf-8?Q?Po=C5=BEega?= <pozega.tomislav@gmail.com>,
	Linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] rt2x00: Remove unusued value
Message-ID: <20250107102335.GA2355@wp.pl>
References: <20241221124445.1094460-1-ariel.otilibili-anieli@eurecom.fr>
 <20241221124445.1094460-2-ariel.otilibili-anieli@eurecom.fr>
 <20250103085540.GA94204@wp.pl>
 <Z3fMxD2mAVsVl58h@pidgin.makrotopia.org>
 <20250103131002.GA100011@wp.pl>
 <2f7a83-6777e880-a451-5cf12280@99910178>
 <20250104103753.GA2228@wp.pl>
 <2f7a8b-67792f00-52db-be99fc0@193911177>
 <Z3r3vxy8cRRH6w1m@pidgin.makrotopia.org>
 <2f7a84-677b8500-5061-4ac1e700@152950135>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2f7a84-677b8500-5061-4ac1e700@152950135>
X-WP-MailID: 4a31331c3305ef66d84a20dc653f4b86
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 0000000 [cZNU]                               

Hi Ariel,

On Mon, Jan 06, 2025 at 08:23:34AM +0100, Ariel Otilibili-Anieli wrote:
> Hi Daniel, hi Shiji, hi Stanislaw,
> 
> On Sunday, January 05, 2025 22:21 CET, Daniel Golle <daniel@makrotopia.org> wrote:
> 
> > H again,
> > 
> > 
> > On Sat, Jan 04, 2025 at 01:51:25PM +0100, Ariel Otilibili-Anieli wrote:
> > > Great, then; thanks for having acked the patch as such.
> > 
> > I just noticed that Shiji Yang had posted a series of patches for
> > OpenWrt which also addresses the same issue, however, instead of
> > removing the augmented assignment, it fixes it to the supposedly
> > originally intended way.
> > 
> > See
> > https://git.openwrt.org/?p=openwrt/openwrt.git;a=blob;f=package/kernel/mac80211/patches/rt2x00/621-04-rt2x00-fix-register-operation-on-RXIQ-calibration.patch;h=aa6f9c437c6447831490588b2cead6919accda58;hb=5d583901657bdfbbf9fad77d9247872427aa5c99
> > 
> > I suppose this was tested together with the other changes of the same
> > series, so we may want to pick that instead.
> 
> Thanks for having put some time into the research, Daniel; I looked into the openwrt archives for 2024, none of Shiji’s messages mentions that patch.
> 
> Though, if you three agree, I will push a new series, modelled on that patch, and you as Suggested-by.

Please post that change. But to not mix it with
patches against other drivers in the same series.
(multiple rt2x00 patches in one patchset are ok).

And please use "wifi: rt2x00:" as subject prefix.

Thanks
Stanislaw

