Return-Path: <linux-wireless+bounces-2667-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3DEB084050C
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 13:31:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E6C2F1F2108D
	for <lists+linux-wireless@lfdr.de>; Mon, 29 Jan 2024 12:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3D17A60860;
	Mon, 29 Jan 2024 12:31:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e5iPd9+p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1618F2E3E1;
	Mon, 29 Jan 2024 12:31:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706531487; cv=none; b=dSAkh1pz1H0jA2nOwkOYZsa/oGpA7kHbO3VwYE0DxwOO3DbQpMk1sfS07b7uCD4Tnn27DJz7uZ++8tq2LtlT/XqkR6QdiXlSxTBV2Ul0ueYHSKfKdCWJbrOw9GWZztDGUnS6pgDRU1NrBHQCg3r9UZRIKO/naHE23UH1jW8wm4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706531487; c=relaxed/simple;
	bh=tVQ5qaT9uy6sOSFMA/0IQv7M4Iyl2ka4MNiJs1OuVy4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bOPr18eIkROyS9tz0k+rK0EnnN9coFkquJhtBzc1mv/yxjqj4rOOFpNENeg3yai57X0VI6k47xorw/YdqFgPozQ7982Kpy5YS+K+alS+jveCtGkh8YeZ9Zx1zEYXMg9eI3SN5ZtZFVAG7wnJvPp8pVa/ZOPZtXL2xviOFaFaGzk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e5iPd9+p; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD0F1C433F1;
	Mon, 29 Jan 2024 12:31:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1706531486;
	bh=tVQ5qaT9uy6sOSFMA/0IQv7M4Iyl2ka4MNiJs1OuVy4=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=e5iPd9+pGha8Rc6MyJhx9PuKtk+gM2CZkDtpQbBvfLOLaeavRMYSgYknG37JMIP8T
	 bL0Y0SBIbWea6DRJrOMckBJsFFv1GY8KqxG2WAuqTd6da0SCu1n3gexllaGZod0gVn
	 3ykV3PjCRVgGnwqKTPZonufxmvk6/Gv0RbJjsIs1Y64ZI1A5BTo1IC3oZ758RFcFWm
	 DG5RLmga31dEB2aQZWREz4poW10CaQmFh8qPrt+IvVqebp2EkCOKJt/r74WewD/JeL
	 k6qK/LjXQxLrgxL2226U7uN3abfXzoxNwcCWoSz7S6K9qK5v+Cr9pDUKMHplGf1J/n
	 SXCI8zRKj+BQQ==
Date: Mon, 29 Jan 2024 18:01:12 +0530
From: Manivannan Sadhasivam <mani@kernel.org>
To: "Rafael J. Wysocki" <rafael@kernel.org>
Cc: Baochen Qiang <quic_bqiang@quicinc.com>, pavel@ucw.cz,
	Manivannan Sadhasivam <mani@kernel.org>,
	"Kalle Valo (QUIC)" <quic_kvalo@quicinc.com>,
	Jeff Johnson <quic_jjohnson@quicinc.com>, linux-pm@vger.kernel.org,
	"kernel@quicinc.com" <kernel@quicinc.com>,
	linux-wireless@vger.kernel.org, ath11k@lists.infradead.org
Subject: Re: ath11k resume fails due to kernel blocks probing MHI virtual
 devices
Message-ID: <20240129123112.GA22617@thinkpad>
References: <21cd2098-97e1-4947-a5bb-a97582902ead@quicinc.com>
 <CAJZ5v0inw7pZR3-fNz9H4BdAXtVawN8m7dsDi6CeBxK2tnNGVg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJZ5v0inw7pZR3-fNz9H4BdAXtVawN8m7dsDi6CeBxK2tnNGVg@mail.gmail.com>

On Mon, Jan 29, 2024 at 01:22:27PM +0100, Rafael J. Wysocki wrote:
> On Mon, Jan 29, 2024 at 11:10 AM Baochen Qiang <quic_bqiang@quicinc.com> wrote:
> >
> > Hi Rafael and Pavel,
> >
> > Currently I am facing an ath11k (a kernel WLAN driver) resume issue
> > related with kernel PM framework and MHI module.
> >
> > Before introducing the issue details, I'd like to summarize how ath11k
> > interacts with MHI stack to download WLAN firmware to hardware target:
> > 1. when booting/restarting, ath11k powers on MHI module and waits for
> > MHI channels to be ready.
> > 2. When power on, MHI stack creates some virtual MHI devices, which
> > represents MHI hardware channels, and adds them to MHI bus. This
> > triggers MHI client driver, named QRTR, to get matched and probe those
> > MHI devices. In probe, QRTR initializes MHI channels and finally move
> > them to ready state.
> > 3. Once MHI channels ready, ath11k downloads WLAN firmware to hardware
> > target, then WLAN is working.
> >
> > Such an flow works well in general, but introduces issues in hibernation
> > cycle: when preparing for hibernation, ath11k powers down MHI, this
> > results in MHI devices being destroyed thus QRTR resets MHI channels.
> > When resuming back from hibernation, ath11k powers on MHI and waits for
> > MHI channels to be ready in its resume callback. As said above, MHI
> > creates and adds MHI devices to MHI bus, but they can't be probed at
> > that time because device probe is prohibited in device_block_probing(),
> > finally this results in ath11k resume timeout.
> >
> > Now there is an potential fix to this issue which would needs changes in
> > MHI stack, i.e., don't destroy MHI devices while hibernating.
> 
> Exactly.
> 

During hibernation, the power to ath11k could be lost and in that case, there
will be no channels available from the device. So keeping the "struct dev" when
there is no real device attached to the system, goes against the driver model
IMO since we would be messing with the refcount.

For instance in the case of USB, if the device get's unplugged, would it make
sense to keep the "struct dev" for the device in kernel in a hope that it would
come back again?

The driver model as I understood is, once the actual physical device gets
removed, the refcount for "struct dev" should be decremented and it should be
destroyed.

- Mani

-- 
மணிவண்ணன் சதாசிவம்

