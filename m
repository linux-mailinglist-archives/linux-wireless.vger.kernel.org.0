Return-Path: <linux-wireless+bounces-21923-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8DFCCA99171
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 17:30:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 013A77AF38C
	for <lists+linux-wireless@lfdr.de>; Wed, 23 Apr 2025 15:29:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B6C58280CC8;
	Wed, 23 Apr 2025 15:21:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="aTPbpDWr"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [168.119.38.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BDEB28468D;
	Wed, 23 Apr 2025 15:20:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=168.119.38.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745421660; cv=none; b=Hc2oTCtC72YTpjFXWY+oRAb1TfXVrNY7sxLhhF5/wzTAPov04/nR3GZGfNl3Xr9Ryyp2bn4WztyiGWhfJ1ck4izYCUybX9JrdP/uTDouFak9vg8r4S0e4KZ956h6kuCN9JJgJjHEIOS+e4HDZTBU0G8bBTKM/6dkhffhHoSFKg4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745421660; c=relaxed/simple;
	bh=/Qxmcd/ZApK6y+6OkZB/fKn43GaZQGZkmr4I67tpeO4=;
	h=Message-ID:Subject:From:To:Cc:Date:In-Reply-To:References:
	 Content-Type:MIME-Version; b=UPjxKVVHKtIJwX8lwRoNX/Qu/eqCsTOdPUfXCGUu4yFeLYPD4INuVgA0SJziJptWk48uyqvFi0+N/veT2fDfIuslEbn+laLTWSJistcrN9DuvsnjP2nC8TITcgEkRND9BF3uq8aZgbpYh2x8ne11pC3MXRjhnGcmvbsamuIGbDc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net; spf=pass smtp.mailfrom=sipsolutions.net; dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b=aTPbpDWr; arc=none smtp.client-ip=168.119.38.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=sipsolutions.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=sipsolutions.net
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=/Qxmcd/ZApK6y+6OkZB/fKn43GaZQGZkmr4I67tpeO4=;
	t=1745421659; x=1746631259; b=aTPbpDWrffp7/u6BdTvhvqHwhPQ0K8vTYFFpXJ3hJZxWueu
	Lh//GY20788MmiSyfBMRu5ObKWCn9et5w4IJFu3QHHQzz8wUkh7gblZDqr86FFUDL88FsC1ioSsFX
	yQROlix57YfJC8KfJazxg3TzUUOVqYGCscPR3QCavSVo3P/4UiOOPwccHmKT2SmAgNUl3foXmnWHt
	46iPN2HqFVt30N5nwL/6bdsOeszUX7bK03IukLyBP6ESam4V3ngFB5O4DFdkQywX0Zvzeg2eodZgP
	KbnjCNuHj5vvxyBgooCEDYpjAYDWVQ5WFVyodsD4ymX6RsDqMPlEYhAR7aimOnCA==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.98.1)
	(envelope-from <johannes@sipsolutions.net>)
	id 1u7buA-0000000Emku-3iKQ;
	Wed, 23 Apr 2025 17:20:55 +0200
Message-ID: <a7de36ea786bd6661b54f4167952af5a0e4393a4.camel@sipsolutions.net>
Subject: Re: [REGRESSION] iwlwifi: probe with driver iwlwifi failed with
 error -22
From: Johannes Berg <johannes@sipsolutions.net>
To: Chris Bainbridge <chris.bainbridge@gmail.com>, "Korenblit, Miriam
 Rachel"	 <miriam.rachel.korenblit@intel.com>
Cc: "Grumbach, Emmanuel" <emmanuel.grumbach@intel.com>, 
 "linux-wireless@vger.kernel.org"
	 <linux-wireless@vger.kernel.org>, "kvalo@kernel.org" <kvalo@kernel.org>, 
 "benjamin@sipsolutions.net"
	 <benjamin@sipsolutions.net>, "regressions@lists.linux.dev"
	 <regressions@lists.linux.dev>
Date: Wed, 23 Apr 2025 17:20:53 +0200
In-Reply-To: <CAP-bSRbDm_-_uqTX817zaP4HXkW3L3q0j15k2hkGxKERAK=_gQ@mail.gmail.com>
References: <Z-XvFvGigpY7JYFn@debian.local>
	 <MW5PR11MB5810B066CB7824714FF25D0CA3A22@MW5PR11MB5810.namprd11.prod.outlook.com>
	 <CAP-bSRbDm_-_uqTX817zaP4HXkW3L3q0j15k2hkGxKERAK=_gQ@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.54.3 (3.54.3-1.fc41) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Wed, 2025-04-23 at 16:06 +0100, Chris Bainbridge wrote:
> On Sun, 30 Mar 2025 at 05:12, Korenblit, Miriam Rachel
> <miriam.rachel.korenblit@intel.com> wrote:
> >=20
> > Hi Chris, thanks for the report.
> > We have a fix for that which will be sent soon.
> >=20
> > Thanks,
> > Miri
>=20
> Hi, did this get fixed? v6.15-rc3 appears to still be broken.
>=20

I just merged a couple of reverts into wireless. I guess if I hurry it
could get into -rc4.

johannes

