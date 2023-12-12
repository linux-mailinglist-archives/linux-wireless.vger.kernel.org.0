Return-Path: <linux-wireless+bounces-693-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C67180E810
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 10:47:04 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2663A1F20DD2
	for <lists+linux-wireless@lfdr.de>; Tue, 12 Dec 2023 09:47:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F32858AD0;
	Tue, 12 Dec 2023 09:47:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="W9CG72uG"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C330D2;
	Tue, 12 Dec 2023 01:46:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=sVUr0dBPvE4hjj2hRHA9dzust08BK20shWiG7p98Mdo=;
	t=1702374416; x=1703584016; b=W9CG72uGRZb0/h6Whij0HnNzpV5ckaTzglZF+9VWakYGTA9
	mkmDL35hPAMnJwR0zFpp8FK6pY8r4UPDStv3NYvoisI4apISBr2GUvPgP+NooTltvUQ0hC33VZ0P4
	td1LNtQdJg4vIrqbs3eF8Gajse6NAr70RvlksBHyUggkUxGeUk3+8yGt6tL8xw/auDGbZYp6j9/ks
	QMmJ7OrZ77gy2wQugi7ZFgw4MzyB/HKHjL+sVOAk97MPmpaptRbsOgxpK4C+5CNyNBBDc1Oi+UADd
	lqGF8Q31S/a+bXS/UhauvjcIRRQjpS3IRLHLGdM6Lqid7bRAbNqECjywDG/5CAKQ==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rCzLp-000000084TA-2X0d;
	Tue, 12 Dec 2023 10:46:53 +0100
Message-ID: <3a06ae67808800386117c90714637ef9a0267b37.camel@sipsolutions.net>
Subject: Re: [GIT PULL] mmutable branch between pdx86 amd wbrf branch and
 wifi / amdgpu due for the v6.8 merge window
From: Johannes Berg <johannes@sipsolutions.net>
To: Hans de Goede <hdegoede@redhat.com>, Alex Deucher
	 <alexander.deucher@amd.com>, Christian =?ISO-8859-1?Q?K=F6nig?=
	 <christian.koenig@amd.com>, Ma Jun <Jun.Ma2@amd.com>, "Limonciello, Mario"
	 <Mario.Limonciello@amd.com>, "platform-driver-x86@vger.kernel.org"
	 <platform-driver-x86@vger.kernel.org>
Cc: linux-wireless <linux-wireless@vger.kernel.org>, amd-gfx list
	 <amd-gfx@lists.freedesktop.org>, Ilpo =?ISO-8859-1?Q?J=E4rvinen?=
	 <ilpo.jarvinen@linux.intel.com>
Date: Tue, 12 Dec 2023 10:46:52 +0100
In-Reply-To: <6395b87b-7cb6-4412-b6e5-e6075353fb6d@redhat.com>
References: <6395b87b-7cb6-4412-b6e5-e6075353fb6d@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-malware-bazaar: not-scanned

On Mon, 2023-12-11 at 12:02 +0100, Hans de Goede wrote:
> Hi Wifi and AMDGPU maintainers,
>=20
> Here is a pull-request for the platform-drivers-x86 parts of:
>=20
> https://lore.kernel.org/platform-driver-x86/20231211100630.2170152-1-Jun.=
Ma2@amd.com/
>=20
> From my pov the pdx86 bits are ready and the platform-drivers-x86-amd-wbr=
f-v6.8-1 tag can be merged by you to merge the wifi-subsys resp. the amdgpu=
 driver changes on top.
>=20
> This only adds kernel internal API, so if in the future the API needs wor=
k that can be done.

OK, thanks! I've pulled this into wireless-next, and applied the two
wireless related patches on top.

I guess if AMDGPU does the same, it will combine nicely in 6.8.

johannes

