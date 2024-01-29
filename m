Return-Path: <linux-wireless+bounces-2669-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BD9C84057E
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 13:51:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CF0491C224EF
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 12:51:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE5BB62813;
	Mon, 29 Jan 2024 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="u8wP8fSe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BA00266B21;
	Mon, 29 Jan 2024 12:47:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706532446; cv=none; b=affxeuEbj7mCHYvfZRH3eavQaV4+rHlMi6wgnHR4GSpaPgkwU1yAP2ZGvWLUR3lRisJM7pvZd9CKI1EwZ1VqViK1y2pClTpRFZD39Fb66qSkXEuZy4uNAqyxgXCIlLiAyOxW84fHyzpCRKXPgmYO4vAvc0dGPnNF1g4b7zwOIbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706532446; c=relaxed/simple;
	bh=3JzJSW2pU8i2DuptDPIdT+UpVU1FI/nRHQavuMC8qRI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DFgfbBPVy2AnPFKw8Uf7tvjMWQkh4rVsqEKW65+FK+UedfrmMwzeiuYBrO1S8LJ9E8ccRjWDF/kmSkwmcrcwwtQ77F97gfwqBP/R04OQb4g96Q2Ut163J8TnIDbuvWWg/XymfZFIT0xCQUWbMxTFqR9DV6JdI+OKIkkFDMUKjkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=u8wP8fSe; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3407FC433C7;
	Mon, 29 Jan 2024 12:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706532446;
	bh=3JzJSW2pU8i2DuptDPIdT+UpVU1FI/nRHQavuMC8qRI=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=u8wP8fSedPwAXPkhD3w3QMyjhrHeiH+rOpFcbj6CvcZvISYU9ug5e0jfx8yBU2a8i
	 dYn+qzm8t3oDCoKTbx7aSAyUxItXDwLJQsvP5c8hI5oTvIRBgdRT+cKlW648kDK4rW
	 ellVr9c9HY3XhHiQbOZ60AY1sUklblmfzsO81cRoWcGgPBbA8zD75DWOJoezuVBCAk
	 U7IOrkElbac7VgWq0E2+neSqS22lWGDf8IIPk0HtXBV6A6zE/wSAMQv5LkNMOL25wz
	 XKhFL6oUMR4cpnQ40A+5dihDeSly9zvgLCKQmzCpM1d/D96IbkmZij0I2pMmwHl0i3
	 Crw9IxmzAZYlQ==
Date: Mon, 29 Jan 2024 18:17:11 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Baochen Qiang <quic_bqiang@quicinc.com>, pavel@ucw.cz,
	"Kalle Valo (QUIC)" <quic_kvalo@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>, linux-pm@vger.kernel.org,
	"kernel@quicinc.com" <kernel@quicinc.com>,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: ath11k resume fails due to kernel blocks probing MHI virtual
 devices
Message-ID: <20240129124711.GC22617@thinkpad>
References: <21cd2098-97e1-4947-a5bb-a97582902ead@quicinc.com>
 <CAJZ5v0inw7pZR3-fNz9H4BdAXtVawN8m7dsDi6CeBxK2tnNGVg@mail.gmail.com>
 <20240129123112.GA22617@thinkpad>
 <CAJZ5v0jQOgK==fpYjoQ3+=1oOzPHCasYeTyKW9NniwYUpXZE=Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0jQOgK==fpYjoQ3+=1oOzPHCasYeTyKW9NniwYUpXZE=Q@mail.gmail.com>

On Mon, Jan 29, 2024 at 01:37:41PM +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 29, 2024 at 1:31 PM Manivannan Sadhasivam <mani@kernel.org> wrote:
> >
> > On Mon, Jan 29, 2024 at 01:22:27PM +0100, Rafael J. Wysocki wrote:
> > > On Mon, Jan 29, 2024 at 11:10 AM Baochen Qiang <quic_bqiang@quicinc.com> wrote:
> > > >
> > > > Hi Rafael and Pavel,
> > > >
> > > > Currently I am facing an ath11k (a kernel WLAN driver) resume issue
> > > > related with kernel PM framework and MHI module.
> > > >
> > > > Before introducing the issue details, I'd like to summarize how ath11k
> > > > interacts with MHI stack to download WLAN firmware to hardware target:
> > > > 1. when booting/restarting, ath11k powers on MHI module and waits for
> > > > MHI channels to be ready.
> > > > 2. When power on, MHI stack creates some virtual MHI devices, which
> > > > represents MHI hardware channels, and adds them to MHI bus. This
> > > > triggers MHI client driver, named QRTR, to get matched and probe those
> > > > MHI devices. In probe, QRTR initializes MHI channels and finally move
> > > > them to ready state.
> > > > 3. Once MHI channels ready, ath11k downloads WLAN firmware to hardware
> > > > target, then WLAN is working.
> > > >
> > > > Such an flow works well in general, but introduces issues in hibernation
> > > > cycle: when preparing for hibernation, ath11k powers down MHI, this
> > > > results in MHI devices being destroyed thus QRTR resets MHI channels.
> > > > When resuming back from hibernation, ath11k powers on MHI and waits for
> > > > MHI channels to be ready in its resume callback. As said above, MHI
> > > > creates and adds MHI devices to MHI bus, but they can't be probed at
> > > > that time because device probe is prohibited in device_block_probing(),
> > > > finally this results in ath11k resume timeout.
> > > >
> > > > Now there is an potential fix to this issue which would needs changes in
> > > > MHI stack, i.e., don't destroy MHI devices while hibernating.
> > >
> > > Exactly.
> > >
> >
> > During hibernation, the power to ath11k could be lost and in that case, there
> > will be no channels available from the device. So keeping the "struct dev" when
> > there is no real device attached to the system, goes against the driver model
> > IMO since we would be messing with the refcount.
> 
> But this is system hibernation or suspend and the reason for the power
> loss is quite different from device removal at run time.
> 
> The device is going to be back during resume (or at least it is not
> expected to go away in the meantime), so it is pointless to destroy
> its representation in memory.
> 
> > For instance in the case of USB, if the device get's unplugged, would it make
> > sense to keep the "struct dev" for the device in kernel in a hope that it would
> > come back again?
> 
> At run time - no, during system suspend - yes.
> 
> It is not even recommended to free IRQs during system suspend.
> 

Hmm, okay. Thanks for clearing it up.

> > The driver model as I understood is, once the actual physical device gets
> > removed, the refcount for "struct dev" should be decremented and it should be
> > destroyed.
> 
> Not really.
> 

Okay. My undestanding seem to be wrong then. I will move forward with the
proposal to keep the devices.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

