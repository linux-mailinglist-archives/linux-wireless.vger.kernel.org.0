Return-Path: <linux-wireless+bounces-3484-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A3744851E3C
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 20:59:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CAC551C21A45
	for <lists+linux-wireless@lfdr.de>; Mon, 12 Feb 2024 19:59:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3D6947F58;
	Mon, 12 Feb 2024 19:59:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="nbYS1mTJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6A7647A6F;
	Mon, 12 Feb 2024 19:59:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707767944; cv=none; b=N7IDWVK/GZ8eSqcMI429H+Av+MtopuCiCE9Vs9430RMoFXz7Zk4wzPjRtBnaQQq/oefjjk5dAcbBNZmUHz7pkkQAHTznIii/m4Mxz4mvpdxGGgjm0h4Uowh23FShhxUYW7pnN56T6Ziz1+fLuxQRYJCmecDFV9+tL8Ybq+i0xK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707767944; c=relaxed/simple;
	bh=LAd7kAB0YVu3prmd6cMGizOB97wDW8LoD6QWTyinZjM=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=gOh2v1H1Wbhx4DsGSLyXfpBeQCslDg0taWRJEPakXQSaJCAmopGNz9MleLGo+lYScAuljiy9P8q1SeHKjYmvycdSXS5MofNjvhKY2tSJgpUjy6mMAEwX0w/YqGRaTTKzoUHRpvg5Wu8rOQ0xCOeCi2II6DpQjp0p7NjcUvrliHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=nbYS1mTJ; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=Lt5QOdxwmKP5wi+YgAc+nSKUxYGem+ulR+qGLgEENJ4=;
	t=1707767941; x=1708977541; b=nbYS1mTJpuUZVVaAPrJ6hEoYhHw3wN+m5nsGwHEReM7zRvf
	I2kTARgwoStJkCr0zHZLotlBFFQ19ziV8zrJqVedsd47KBJh96Ieynd9BP0rqDxxtv2Z5OGNTa7id
	+8r+F7NgYdm8kO+QFASQXXmBs0glyZfcAEns13i4A3VQOl65YEHApnl2A5r0k8DMBN4TG2cfV1oJU
	g6twKQvNYoUooqbO0ShIHFlWZV5NNHpJzBNt6w0sEv8Q6/wirt1e1FR2hWM1VXl5FGwmax4CrQzwD
	pMx99UpuGJ1ksya4PmnbS64G4JM531Vz8wXBaMjnGXZxloe7En/LhAlOnshza1Eg==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rZcS5-00000006Taf-0gjr;
	Mon, 12 Feb 2024 20:58:53 +0100
Message-ID: <2c38eaed47808a076b6986412f92bb955b0599c3.camel@sipsolutions.net>
Subject: Re: [PATCH 1/1] wifi: nl80211: Add support for plumbing SAE groups
 to driver
From: Johannes Berg <johannes@sipsolutions.net>
To: Kalle Valo <kvalo@kernel.org>, Vinayak Yadawad
	 <vinayak.yadawad@broadcom.com>
Cc: linux-wireless@vger.kernel.org, jithu.jance@broadcom.com, Arend van
 Spriel <arend.vanspriel@broadcom.com>, netdev@vger.kernel.org, Jakub
 Kicinski <kuba@kernel.org>
Date: Mon, 12 Feb 2024 20:58:51 +0100
In-Reply-To: <87mss6f8jh.fsf@kernel.org>
References: 
	<309965e8ef4d220053ca7e6bd34393f892ea1bb8.1707486287.git.vinayak.yadawad@broadcom.com>
	 <87mss6f8jh.fsf@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.3 (3.50.3-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2024-02-12 at 09:25 +0200, Kalle Valo wrote:

> What driver is going to use these new crypto settings? Or is this for an
> out-of-tree driver?
>=20

I'm sure it's for an out-of-tree driver.

This is the _entirety_ of "@broadcom"'s wireless contributions with
"--since=3D2020" (somewhat arbitrarily chosen, though going a bit further
back has some "real" work in brcmfmac), as far as I can tell:

Arend Van Spriel (1):
      cfg80211: adapt to new channelization of the 6GHz band

Arend van Spriel (23):
      cfg80211: add VHT rate entries for MCS-10 and MCS-11
      brcmfmac: use different error value for invalid ram base address
      brcmfmac: increase core revision column aligning core list
      brcmfmac: add xtlv support to firmware interface layer
      brcmfmac: support chipsets with different core enumeration space
      wifi: cfg80211: fix memory leak in query_regdb_file()
      wifi: brcmfmac: add function to unbind device to bus layer api
      wifi: brcmfmac: add firmware vendor info in driver info
      wifi: brcmfmac: add support for vendor-specific firmware api
      wifi: brcmfmac: add support for Cypress firmware api
      wifi: brcmfmac: add support Broadcom BCA firmware api
      wifi: brcmfmac: add vendor name in revinfo debugfs file
      wifi: brcmfmac: introduce BRCMFMAC exported symbols namespace
      wifi: brcmfmac: avoid handling disabled channels for survey dump
      wifi: brcmfmac: avoid NULL-deref in survey dump for 2G only device
      wifi: brcmfmac: fix regression for Broadcom PCIe wifi devices
      wifi: brcmfmac: change cfg80211_set_channel() name and signature
      wifi: brcmfmac: export firmware interface functions
      wifi: brcmfmac: add per-vendor feature detection callback
      wifi: brcmfmac: move feature overrides before feature_disable
      wifi: brcmfmac: avoid invalid list operation when vendor attach fails
      wifi: brcmfmac: allow per-vendor event handling
      wifi: brcmfmac: add linefeed at end of file

Vinayak Yadawad (4):
      wifi: cfg80211: Allow P2P client interface to indicate port authoriza=
tion
      cfg80211: Update Transition Disable policy during port authorization
      wifi: cfg80211: Allow AP/P2PGO to indicate port authorization to peer=
 STA/P2PClient
      wifi: nl80211: Extend del pmksa support for SAE and OWE security


So looks to me like Broadcom doesn't want its (real) drivers to work in
upstream, so I guess we really ought to just stop accommodating for them
in the wireless stack... This only works if we collaborate, and I've
said this before: I can't maintain something well that I cannot see (and
possibly change) the user(s) of.

I guess if Broadcom's plans change they can start by submitting drivers
that actually use the relevant infrastructure.

And note that I've said this to Qualcomm before: I don't really want to
and can't (well) maintain a lot of stuff in the tree that exists there
solely to make out-of-tree drivers happy.

And @Broadcom: we really _want_ you to contribute upstream. But that
shouldn't be dumping APIs over the wall when you need them and letting
us sort out everything else ...

johannes

