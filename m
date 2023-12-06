Return-Path: <linux-wireless+bounces-487-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A5E74806B0E
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 10:50:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4ECFB1F2115D
	for <lists+linux-wireless@lfdr.de>; Wed,  6 Dec 2023 09:50:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A61F41C684;
	Wed,  6 Dec 2023 09:50:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="ncQF6jLo"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84CC8FA;
	Wed,  6 Dec 2023 01:50:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=h6JN3D/3YeujwHgCvdr5maM8vVQrlsYw0ga5RvmCUHI=;
	t=1701856216; x=1703065816; b=ncQF6jLoNwAoBbMiTRG7qGTeiYtv3Vfx9wxXs01nklhNXRn
	GMjylvJr5zPsmmtCIjw6jLab8HBl3J0NWXjgFCbDyH4rlpHJhTCeR9UouYUT56C+z8s+zziZuZ6An
	AWCeNiTNY18uNkFZcU8CNyrbPydQkqNrwrEHdr5oXKiuB9mUl357yULjxsnqJ2MSTFnAxOMnIkwan
	ZpRuZMzCC6DZx/KWsNebAc68S4s2SyiZUu/DvUIFF+qLXfhChVBiwdD6j+qr/zMsqz/8yDsGS8VVz
	m3R+2FxCTgVwSvq6ElKkqGGoSawt84gPAibkpXYrJwKMaPdDp5bJLM3g51p4gKhw==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rAoXj-0000000HYVR-2XDC;
	Wed, 06 Dec 2023 10:50:11 +0100
Message-ID: <c535e63ccbf1d78dea71fcc7c16a7bb619354b19.camel@sipsolutions.net>
Subject: Re: [RFC PATCH] net: ethtool: do runtime PM outside RTNL
From: Johannes Berg <johannes@sipsolutions.net>
To: Marc MERLIN <marc@merlins.org>
Cc: netdev@vger.kernel.org, Jesse Brandeburg <jesse.brandeburg@intel.com>, 
 Tony Nguyen <anthony.l.nguyen@intel.com>, linux-wireless@vger.kernel.org,
 ilw@linux.intel.com, Heiner Kallweit <hkallweit1@gmail.com>
Date: Wed, 06 Dec 2023 10:50:10 +0100
In-Reply-To: <20231205231509.GA181276@merlins.org>
References: 
	<20231204200710.40c291e60cea.I2deb5804ef1739a2af307283d320ef7d82456494@changeid>
	 <20231204200038.GA9330@merlins.org>
	 <a6ac887f7ce8af0235558752d0c781b817f1795a.camel@sipsolutions.net>
	 <20231204203622.GB9330@merlins.org>
	 <24577c9b8b4d398fe34bd756354c33b80cf67720.camel@sipsolutions.net>
	 <20231204205439.GA32680@merlins.org> <20231204212849.GA25864@merlins.org>
	 <20231205024652.GA12805@merlins.org>
	 <1d986c73c1d39b0cced7d8d2119fba4b2a02418b.camel@sipsolutions.net>
	 <20231205231509.GA181276@merlins.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.1 (3.50.1-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Tue, 2023-12-05 at 15:15 -0800, Marc MERLIN wrote:
> >=20
> > Power est.              Usage       Events/s    Category       Descript=
ion
> >   24.1 W     59.6 pkts/s                Device         Network interfac=
e: wlp9s0 (iwlwifi)

That seems excessive, I'm not sure it's even _possible_ for it to draw
that much power?

> > The battery reports a discharge rate of 36.1 W
>=20
> Obviously unloading iwlwifi fixes it:
> > The battery reports a discharge rate of 26.0 W

That would put it closer to 10W, but even that seems too much... no idea
though.

> Is this something I should persue separately on
> linux-wireless@vger.kernel.org or ilw@linux.intel.com or elsewhere?
>=20

Certainly separately, maybe put a bug on bugzilla per
https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi/debugging

johannes

