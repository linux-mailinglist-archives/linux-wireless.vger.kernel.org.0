Return-Path: <linux-wireless+bounces-6448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 682578A8351
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 14:45:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1DF4C1F22771
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 12:45:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2ECF45A0E4;
	Wed, 17 Apr 2024 12:45:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="omHp3qU1"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF3AF2747F
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 12:45:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713357907; cv=none; b=oS9xzbGc9dxVdEZLZPhC9dskr8AZ8Lohz3IUnJlHSM+hkNB4033/kQunZ3FWt8z4Q4EFFLf6jfqkyWpUNeQ6gAwX4kp3yIsP5CYiPaeKfLc6rWaXO/bczngc8n1z0uOKH21vORa0K2Sevo9etf15wLYMUgQ3cPzMzA45Q2GjF+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713357907; c=relaxed/simple;
	bh=TIFZgx/UP5ReykFyZF9ue7Do7joElMA0D1t2D0C0UyU=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=YtN1LghOLt4D/YCvWogvGcSG4IZUcVAiC1S4jefaKAEWSymvPH0xGSzWUlf9c4xMCeNr8+Kty1e+fykT0k1Q3ppUi2R5t+Bbh5aUzfGh8Wm8wX89wm1cqUDnop9Zj7mAJzuie6x+Lbzwr80eeXIPQPVoyTXIl7RAOo7ncYTVE1Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=omHp3qU1; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=vpwzE1bpZTDppIPqoYwwmYNQwAclFkUquLNCZZHL2FU=;
	t=1713357905; x=1714567505; b=omHp3qU1Y2JA7bbtT8vNI95vNvpMUEV3CvpGLWOcudTQMYP
	AevvPbe+tcen+JImPJlCsVuiTZ2mijyRiGAmlNnVvstITGhlW3JGjpX6hr1g2hyofdac4Av97isqE
	pTnRSRJMDDVUZJXuECL4kWYmtvyisLnRU+H0g9yHzvg2wFYgE9+R1CaZ1Ya2bMVDuTctWfppJDXlY
	0j4UZj6p0rfe16Sb5CoR6VpMk8QDs0PhzA4wHvF2XwfYZCEjf6JCmjN1O0HtWDk7TEdBWDnSjwk0n
	OYBme1LFrHu7qQ+VbqPYdXC1iA83kdWcDMvfOdE1UlkTk8+JRK9+I6ZKSyYbJ2CA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rx4es-0000000Ax74-1qr9;
	Wed, 17 Apr 2024 14:45:02 +0200
Message-ID: <b712f48a3e35221b7ff7f4c8cb495b5159bdd367.camel@sipsolutions.net>
Subject: Re: putting future iwlwifi firmware into intel/ ?
From: Johannes Berg <johannes@sipsolutions.net>
To: Mario Limonciello <superm1@gmail.com>, linux-firmware@kernel.org
Cc: linux-wireless@vger.kernel.org, miriam.rachel.korenblit@intel.com
Date: Wed, 17 Apr 2024 14:45:01 +0200
In-Reply-To: <b0e70576-a53f-4d03-a503-ddf1f98bbe9d@gmail.com>
References: 
	<fec30176f437d565d4c1dfc4944373f117d75a64.camel@sipsolutions.net>
	 <9aa64d50-cb4d-4118-bc27-86c23410ff8b@gmail.com>
	 <f65765b29ea7503fbbaa5e047c95a82de6fc2083.camel@sipsolutions.net>
	 <b0e70576-a53f-4d03-a503-ddf1f98bbe9d@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.4 (3.50.4-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2024-04-17 at 07:42 -0500, Mario Limonciello wrote:
>=20
> On 4/17/24 07:39, Johannes Berg wrote:
> > On Wed, 2024-04-17 at 07:31 -0500, Mario Limonciello wrote:
> > >=20
> > > On 4/17/24 06:18, Johannes Berg wrote:
> > > > Hi,
> > > >=20
> > > > Since I was just looking at some firmware related thing (files for =
the
> > > > hardware that might be shared between Intel BT and WiFi), I noticed=
 that
> > > > just over 30% of the files/dirs in the top-level firmware tree are
> > > > iwlwifi-* files.
> > > >=20
> > > > While we can't move the files that older drivers might consume, we =
could
> > > > e.g. change the driver to look up future versions/future hardware u=
nder
> > > > intel/ instead? Would that be worth doing?
> > > >=20
> > > > johannes
> > > >=20
> > >=20
> > > How about moving them all now and then creating compat symlinks for
> > > older kernels at linux-firmware 'make install' time?
> > >=20
> >=20
> > Didn't realize there even was a 'make install' time :-)
> >=20
> > But then I guess it'd be simpler in the driver since we could just
> > unconditionally add the intel/ prefix to the request_firmware call.
> >=20
> > johannes
>=20
> Do both.  All the stuff already there add the compat symlinks in linux=
=20
> firmware so that current and older kernels work with older hardware.
>=20
> Any "new firmware" only put in the new path, and add commits to the=20
> kernel to look for "all" firmware in the new path.
>=20
> Should hopefully cover everything without too much pain then.

Yeah, I guess. Though not actually sure, do we need to support new
kernel + old firmware install?

johannes

