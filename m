Return-Path: <linux-wireless+bounces-26695-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 535A6B3805E
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 12:55:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0EE835E7ADF
	for <lists+linux-wireless@lfdr.de>; Wed, 27 Aug 2025 10:55:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A5E4301014;
	Wed, 27 Aug 2025 10:55:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="LDPObG5E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C09634AAFF
	for <linux-wireless@vger.kernel.org>; Wed, 27 Aug 2025 10:55:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756292124; cv=none; b=an5Pzx49AC2QlUeseRAP4FQ1bJ8BXlf36Kmt/clBcxcjKjEpzGXcRPc9nDiyeBpEp8qa9aUvznfrtjSNBsi3oZqLnU0W0mS2paYmcSZT8x3TYw8wrapeaTqHkg4991iVDz+YHvGKa50fTHQhUFECD9+VrHGBghZeWlbs+zwjnX8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756292124; c=relaxed/simple;
	bh=QTo1/mVPm+Zihnmk5+PtXRkwzqT27Mgwm+SpBFN9hZo=;
	h=Message-ID:Subject:From:To:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=XtfrBPM0wAgAO/r03kU4l7tL9oaReSPIT02Zd3iEglTnaSS+u4U79MJqLdk7iY+7V+TOA1b26xPrBJds6oJ4F4MOmvZnknIkWS3fQMDlTqzx8JIf2h7+o9JnmsDQGaqGbnlAanfa1gDjMFZeW6WM0i0yGSXSxJ+ezUHsY+3SqUY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=LDPObG5E; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:To:From:Subject:Message-ID:Sender:
	Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=SR2ipSUrndMI+cYMrpTCqz2KHSJ+LgIZXJ6346+NbOo=;
	t=1756292122; x=1757501722; b=LDPObG5Eyj2tWgB5OIxiSZu5SOJVdgA/e1MVV7kXOjKF/HJ
	2sFH2lWM55fEjLdJIX46i2+W4Unp/Wzp+6UlBkLqAf3hmRoc090xDpOd2saS9ZxMZTBR88DNs3lTB
	bVg+wlZkZg4biP5DGFogSiu1o5vnKcPcrYO1SRfXuOzcF6PS4qrT6UWdq88BAsvn3jxMSPuHCvbri
	hXCfKkwMMSJhg0D3BSJjxFk/MTqDFgJYV/YRPewdBanG5mJPuT+whn0m+mYxyQhkc0xbUouQ2o2yj
	MrS35VDDTFItMwcPBQ0Wp3/k99JGD5EW+OsamOKn7aZsVmPUGFe+3yg0YCL0qWww==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1urDoF-00000005QsG-47UE;
	Wed, 27 Aug 2025 12:55:20 +0200
Message-ID: <1fc3e3505501e5107f47507e84c69093e79c7aad.camel@sipsolutions.net>
Subject: Re: Recent versions broke Wireless-N 1030 BGN
From: Johannes Berg <johannes@sipsolutions.net>
To: Ingolf Gehrhardt <gehingo@freenet.de>, linux-wireless@vger.kernel.org
Date: Wed, 27 Aug 2025 12:55:19 +0200
In-Reply-To: <c9c43ed6bda02ead41773cadb41d9bb303db9444.camel@sipsolutions.net>
References: <c086f53df499061f069bf4c49ab7232b8e75d9a8.camel@freenet.de>
	 <c9c43ed6bda02ead41773cadb41d9bb303db9444.camel@sipsolutions.net>
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

On Mon, 2025-08-25 at 12:03 +0200, Johannes Berg wrote:
> On Sat, 2025-08-23 at 09:23 +0200, Ingolf Gehrhardt wrote:
> >=20
> > I think this might be because of:
> >=20
> > [   31.404357] iwlwifi 0000:05:00.0: Detected Intel(R) Centrino(R)
> > Wireless-N 1030 BGN
> > [   31.506140] iwlwifi 0000:05:00.0: loaded firmware version 18.168.6.1
> > 6000g2b-6.ucode op_mode iwldvm
> > [   32.002851] iwlwifi 0000:05:00.0: CONFIG_IWLWIFI_DEBUG enabled
> > [   32.002925] iwlwifi 0000:05:00.0: CONFIG_IWLWIFI_DEBUGFS enabled
> > [   32.002937] iwlwifi 0000:05:00.0: CONFIG_IWLWIFI_DEVICE_TRACING
> > enabled
> > [   32.002949] iwlwifi 0000:05:00.0: Detected Intel(R) Centrino(R)
> > Wireless-N 1030 BGN, REV=3D0xB0
> > [   32.093060] iwlwifi 0000:05:00.0: Failing on timeout while stopping
> > DMA channel 8 [0xa5a5a5a2]
> > [   32.111342] WARNING: CPU: 1 PID: 467 at
> > drivers/net/wireless/intel/iwlwifi/dvm/eeprom.c:212
> > iwl_parse_eeprom_data+0x5ba/0xe20 [iwldvm]
>=20
> Probably, assuming you didn't see that WARN_ON before? Just making sure.
>=20
> It's almost certainly with the config rework, and the only thing I can
> imagine is that the EEPROM size is now wrong, but I don't see why that
> would be the case.
>=20
> Could you change it to print the offset, address and eeprom_size when
> this happens? Or maybe even print them both with the older kernel too
> when it succeeds.
>=20
> Or maybe you can even bisect it?
>=20
> There's a somewhat related bug
> https://bugzilla.kernel.org/show_bug.cgi?id=3D220477
> but that just misses the entries which was easy to fix. That doesn't
> seem to be the case here since the firmware is loaded.

Actually there's a ticket [1] with precisely this issue too, so it may
be better to handle everything there.

[1] https://bugzilla.kernel.org/show_bug.cgi?id=3D220472

johannes

