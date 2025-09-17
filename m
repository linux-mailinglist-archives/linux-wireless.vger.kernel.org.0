Return-Path: <linux-wireless+bounces-27418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 1223EB7C604
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 13:59:59 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 850411B27EC4
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Sep 2025 04:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 888591D7E41;
	Wed, 17 Sep 2025 04:51:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="uZIvwasb"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9729023B60C
	for <linux-wireless@vger.kernel.org>; Wed, 17 Sep 2025 04:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758084691; cv=none; b=l8d6DZ6XMnpLfEolXwGTTypnVAz/Pf81UEnwQcjakwKCTO++MyS4hghrqEMcnlOez/ehKpYCLCVZUKk5f8SA/AQXq8KfPvBqdOshm9aa9xhJblPidUpEJU0ULSDhOR7cp2nm43Nk0d4fyVUuYBGkjofUxudYAOd9NXMIDgkrUu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758084691; c=relaxed/simple;
	bh=6DZDOYuoQC4KoRcvIoqoiYDeyaYI69Yy9/eH38+RUqc=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=R1pQv7cFsn2CuIC0pqZh6u51f2yhTmDjwPgKgB3zMpbF10l+mIRKZJ2ycM4aiyweeVN/ADcRCU6odYkdFYt2EmZ7tmDZSDx5O07JYX4IZAg+HJYT8/Kl84D1ZWIeY3TBjE5sryWFrKU6X8revwts2Mcd+ziLTpjCFzy3IpXKe5Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=uZIvwasb; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=rKlMBkdwksbC3zuNYpMnoJXOUjbbOwYV05iYdAZ4oCo=;
	t=1758084689; x=1759294289; b=uZIvwasb4UP8VS1Pn2FAPuBcawihpqgeSS2RlxC/REV+RWF
	VuO1evvitJGs6/NaxKaQqdBwIIiatR1IzdHFc0ql742NHmKg8JgH/Wg2EG7YP+ktbQEU3mJgJEE4Y
	YbiQbs6cZvg9uOPSOc1cRzKERwFJ4SmyWIyUGjGBMb9W1y+YnCWVyL9sjM1E+inVdOWuzf7EemP+3
	IVCF5XF1rZXbiVxKIa4WDMKTuyRRPBFPkLR8TLR5fXlsyBIDjjMdI5a0xcy7K9E1pvEQM3hZLwbSE
	8+BuVMkrGnb9TVhkOL0zdZTCmZ31vrYrJppo18W+48yv5heDBvs4Jzz6LbzT9TYA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.2)
	(envelope-from <johannes@sipsolutions.net>)
	id 1uyk8W-0000000AK30-0qEU;
	Wed, 17 Sep 2025 06:51:20 +0200
Message-ID: <4d46dfb13927a878f5684e9e8cfc51673e8df4b8.camel@sipsolutions.net>
Subject: Re: [PATCH wireless-next 00/57] wifi: inffmac: introducing a driver
 for Infineon's new generation chipsets
From: Johannes Berg <johannes@sipsolutions.net>
To: Gokul Sivakumar <gokulkumar.sivakumar@infineon.com>, 
	linux-wireless@vger.kernel.org
Cc: wlan-kernel-dev-list@infineon.com, Carter Chen
 <Carter.Chen@infineon.com>,  Owen Huang <Owen.Huang@infineon.com>, Ian Lin
 <Ian.Lin@infineon.com>, JasonHuang	 <Jason.Huang2@infineon.com>, Shelley
 Yang <Shelley.Yang@infineon.com>,  avishad verma
 <avishad.verma@infineon.com>
Date: Wed, 17 Sep 2025 06:51:19 +0200
In-Reply-To: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
References: <20250916221821.4387-1-gokulkumar.sivakumar@infineon.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2 (3.56.2-2.fc42) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-09-17 at 03:47 +0530, Gokul Sivakumar wrote:
>=20
> We have split the driver into smaller commits to make the review easier,

Now I guess you should also split it into a smaller driver that doesn't
try to be the kitchen sink from the get-go ...
=09
>     This driver also introduces a new wdev interface (non netdev) type
>     =E2=80=9CWLAN_SENSE=E2=80=9D in the Linux nl80211/cfg80211 layer to a=
llow 802.11
>     frame transmissions with a specific MAC address, which would be used
>     by the device during solicited WLAN sensing measurement.

And this _really_ isn't how things work.

johannes

