Return-Path: <linux-wireless+bounces-25556-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 26FE3B07EFE
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 22:34:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1F84A3AF280
	for <lists+linux-wireless@lfdr.de>; Wed, 16 Jul 2025 20:34:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F24C2D1;
	Wed, 16 Jul 2025 20:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="tMyM3cS+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7102C2641E7;
	Wed, 16 Jul 2025 20:34:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752698082; cv=none; b=HWZ2PPAVAU55fBnW2rpph/NtMgrqCDmXLq69JOMkySLQGgzx4Uh7DZjxklZiEzU8euiKsV8pJ/YhYivJB1MDkK2dHH0GBxHPnlEoPOHogO107c290djfCMeBfafn4oZfHraeWT6dJFcBhdayXBR7zF9k7LascNIfRmcAK+L6K4c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752698082; c=relaxed/simple;
	bh=oo8T2cYrBKx9rgy8ohBi0I3AkkxDaufyY0d6O5mhSIA=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=Zm/3ehTw6VoIUEl6VVKkwqNV1japVNOIAjf9MaiWYA0D7zS8zBYLhcxJEVLzkq3rrbWPNHOTk/NB9wuELrFEKPNqOAOvkEYoznHRgF/BfBrWXK0xLIkaMeetBJ5ua+SEYLOiVny8HuFZB0Dwmu/kOn6USXm3reFa0LcJb670U5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=tMyM3cS+; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=RtWoiGvdEq/pdKNPWoj9fYGr2I9VDyHYeS7oB2+nuao=;
	t=1752698080; x=1753907680; b=tMyM3cS+/tHRKvBw24N7q+PmGRT7MUlDBqAtle0oKteHpxz
	NLhr1xOvRbsHuNDbWvSRgFbzn3yQVg3RLcZXmcTiDE8rd8MapaGWuQnp7EBcjWfdhaHHJVT/8kH8j
	xw4gdkYeLkL0nEjSmqfLedPO3lyVsf9GutXSacT7b8idZPtUaGxnhXoNpP4X6sEPe0fKiKTT7DDM8
	d6u6OZ8hXAQFfffQ4aUgiMxkNiimaNvaFRCbIYmwTK4HCxp26i/9tWZ3zk9oDYUk8HEx7tnZ8zFf/
	AS2lBHIlssy8lZq2cMEXizTxf+yBkFSI+guaBrk7LKz2zZ34iKfNGaUwsWAwVHWA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uc8ph-00000008rc7-3QrX;
	Wed, 16 Jul 2025 22:34:30 +0200
Message-ID: <1dc3bd17827527fbdb2c972dcb5c9f90d8f4d1ff.camel@sipsolutions.net>
Subject: Re: [REGRESSION] iwlwifi: probe with driver iwlwifi failed with
 error -22
From: Johannes Berg <johannes@sipsolutions.net>
To: Bjorn Helgaas <helgaas@kernel.org>, Chris Bainbridge
	 <chris.bainbridge@gmail.com>
Cc: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>, 
 "linux-wireless@vger.kernel.org"	 <linux-wireless@vger.kernel.org>,
 "kvalo@kernel.org" <kvalo@kernel.org>,  "Korenblit, Miriam Rachel"
 <miriam.rachel.korenblit@intel.com>, "benjamin@sipsolutions.net"
 <benjamin@sipsolutions.net>,  "regressions@lists.linux.dev"	
 <regressions@lists.linux.dev>
Date: Wed, 16 Jul 2025 22:34:29 +0200
In-Reply-To: <20250716184226.GA2547862@bhelgaas>
References: <20250716184226.GA2547862@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-1.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-07-16 at 13:42 -0500, Bjorn Helgaas wrote:
> On Fri, Mar 28, 2025 at 12:36:38AM +0000, Chris Bainbridge wrote:
> > Hi,
> >=20
> > Laptop: Lenovo Legion 7 16ACHg6.
> > Wifi: Killer(R) Wi-Fi 6 AX1650x 160MHz Wireless Network Adapter (200NGW=
)
> > 04:00.0 Network controller [0280]: Intel Corporation Wi-Fi 6 AX200 [808=
6:2723] (rev 1a)
> >=20
> > Wifi stopped working in recent kernel builds:
> >=20
> > [   20.907824] Intel(R) Wireless WiFi driver for Linux
> > [   20.907955] iwlwifi 0000:04:00.0: enabling device (0000 -> 0002)
> > [   20.912024] ee1004 2-0050: 512 byte EE1004-compliant SPD EEPROM, rea=
d-only
> > [   20.913666] NET: Registered PF_BLUETOOTH protocol family
> > [   20.913670] Bluetooth: HCI device and connection manager initialized
> > [   20.913806] Bluetooth: HCI socket layer initialized
> > [   20.913810] Bluetooth: L2CAP socket layer initialized
> > [   20.913828] Bluetooth: SCO socket layer initialized
> > [   20.917455] iwlwifi 0000:04:00.0: Detected crf-id 0x3617, cnv-id 0x1=
00530 wfpm id 0x80000000
> > [   20.917674] iwlwifi 0000:04:00.0: PCI dev 2723/1654, rev=3D0x340, rf=
id=3D0x10a100
> > [   20.917679] iwlwifi: No config found for PCI dev 2723/1654, rev=3D0x=
340, rfid=3D0x10a100
> > [   20.920126] iwlwifi 0000:04:00.0: probe with driver iwlwifi failed w=
ith error -22
> >=20
> > Bisect led to:
> >=20
> > commit 75a3313f52b7e08e7e73746f69a68c2b7c28bb2b (HEAD)
> > Author: Emmanuel Grumbach <emmanuel.grumbach@intel.com>
> > Date:   Wed Feb 5 14:55:42 2025 +0200
> >=20
> >     wifi: iwlwifi: make no_160 more generic
>=20
> https://git.kernel.org/linus/64dc5d5e341d ("Revert "wifi: iwlwifi:
> make no_160 more generic"") appeared in v6.15-rc5 and reverts
> 75a3313f52b7 ("wifi: iwlwifi: make no_160 more generic"), so it
> *looks* like this regression should be fixed, but it still appears in
> the tracker at https://linux-regtracking.leemhuis.info/regzbot/mainline/
>=20

And for 6.16 it was completely reworked. But I don't really know if
there might still be related issues.

johannes

