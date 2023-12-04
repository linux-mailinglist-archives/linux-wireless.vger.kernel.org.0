Return-Path: <linux-wireless+bounces-405-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C80438040EB
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 22:18:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8335828129E
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Dec 2023 21:18:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6FB1C364C5;
	Mon,  4 Dec 2023 21:17:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="FuzYr1L8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AE990;
	Mon,  4 Dec 2023 13:17:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=QT7k7kPIr5wnFnF5J7GwSeJplbrxHWX0xcDBoBtByho=;
	t=1701724676; x=1702934276; b=FuzYr1L8FSX4+4trriOxugbZ+34dVOrmBOI/C08hx0KDy9b
	/AHSRBy2/kqlYubEFefRYpq/5l5wZw9rrDKe9AIdTcX/C98R5t1UGcPmSYdzlcPmbwkIeOHmoSPJS
	lOfLWSOH27p5BpDw4QhOdLhGC7NEiThC34LvidKWpSaJeCumPtuJKOdwtLsuo9GtZ6sgyNi5ZSPy2
	dVgVgXAPrM9W+fjqtJkp7+90OKmdvA5wF9FmJSnLj/uDPk/VHO4DyugUDiKLqstQzRir9CvrljvK+
	EwDHC+mJR2HIm/dlnyHcTK3op+rKTqx8pbg8HX6WdDhO7yqnmsdrh04eJTZAon+g==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rAGK7-0000000FGSR-0u4f;
	Mon, 04 Dec 2023 22:17:51 +0100
Message-ID: <95265243715c2f7cbb5ef94083d64e1a17d8ee04.camel@sipsolutions.net>
Subject: Re: Thinkpad P17 keep hanging in ipv6_addrconf addrconf_verify_work
 / netlink in 6.4 and 6.6
From: Johannes Berg <johannes@sipsolutions.net>
To: Jakub Kicinski <kuba@kernel.org>
Cc: Marc MERLIN <marc@merlins.org>, netdev@vger.kernel.org, 
	linux-wireless@vger.kernel.org, ilw@linux.intel.com, 
	intel-wired-lan@lists.osuosl.org, Tony Nguyen <anthony.l.nguyen@intel.com>
Date: Mon, 04 Dec 2023 22:17:50 +0100
In-Reply-To: <20231204131615.26b57722@kernel.org>
References: <20231202171326.GB24486@merlins.org>
	 <20231204004003.GB29484@merlins.org> <20231204073515.GA9208@merlins.org>
	 <69717129398d05b18df1c1300bfb41da268c52a0.camel@sipsolutions.net>
	 <20231204131615.26b57722@kernel.org>
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

On Mon, 2023-12-04 at 13:16 -0800, Jakub Kicinski wrote:
> > > > [  363.945511]  __mutex_lock.constprop.0+0x18b/0x291
> > > >=20
> > > > [  363.945531]  igc_resume+0x18b/0x1ca [igc 1a96e277f8878a2a3c95992=
26acd0eeb7de577b7] =20
> >=20
> > this is trying to acquire the RTNL, by looking at the code
> >=20
> > > > [  363.945566]  __rpm_callback+0x7a/0xe7
> > > > [  363.945578]  rpm_callback+0x35/0x64
> > > > [  363.945587]  ? __pfx_pci_pm_runtime_resume+0x40/0x40
> > > > [  363.945592]  rpm_resume+0x342/0x44a
> > > > [  363.945600]  ? __kmem_cache_alloc_node+0x123/0x154
> > > > [  363.945614]  __pm_runtime_resume+0x5a/0x7a
> > > > [  363.945624]  dev_ethtool+0x15a/0x24e7 =20
> >=20
> > but this already holds it
> >=20
> > So looks like bug in the 'igc' driver wrt. runtime PM locking.
> >=20

So actually maybe it shouldn't be a bug there, I posted this:

https://patchwork.kernel.org/project/netdevbpf/patch/20231204200710.40c291e=
60cea.I2deb5804ef1739a2af307283d320ef7d82456494@changeid/

but I don't know this driver at all, and ethtool not that well ...

johannes

