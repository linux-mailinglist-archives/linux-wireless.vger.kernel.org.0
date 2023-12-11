Return-Path: <linux-wireless+bounces-655-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E868F80C839
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 12:42:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 923061F217F6
	for <lists+linux-wireless@lfdr.de>; Mon, 11 Dec 2023 11:42:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 90E61374EB;
	Mon, 11 Dec 2023 11:41:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=sipsolutions.net header.i=@sipsolutions.net header.b="i5tuCdIm"
X-Original-To: linux-wireless@vger.kernel.org
Received: from sipsolutions.net (s3.sipsolutions.net [IPv6:2a01:4f8:242:246e::2])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4EDCBA;
	Mon, 11 Dec 2023 03:41:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=sipsolutions.net; s=mail; h=MIME-Version:Content-Transfer-Encoding:
	Content-Type:References:In-Reply-To:Date:Cc:To:From:Subject:Message-ID:Sender
	:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-To:
	Resent-Cc:Resent-Message-ID; bh=tWsLt7SLpCw5MQDNBJrqaEYgF2X1wOT/u6YZ+/q7Ies=;
	t=1702294907; x=1703504507; b=i5tuCdIm6caTjA+3FrEVs97JRxEf2b3dLcjITdbYxmNEoMV
	pzDLLtCueWcQsNsAOA51cPzl9a4EFpDQe6ZwOHAQUZQJ9t9k2IOB6AItnk8jpdLVzVGA7bvdM2W3F
	bZLRS1cgRMbWSTP71LRYV1cKpcmxvuRHbVcWIlZiCQlDAMr/S6tMeWzeTL+2X9AdbuL+gaLHxL1lp
	s6nuMg5WrMYV63O8SjGKxvaRpjnOAYIBv4/2bVEKlIpt014IcRlNOzaCUG26kwhm+eic7x5ZPZRwB
	hYUMbpmsihv7dUEv+OA4lBaYe1t5x40mrbuDAI5iU+E7m4Rk+h2mTlkN8B3Oqi/w==;
Received: by sipsolutions.net with esmtpsa (TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256)
	(Exim 4.97)
	(envelope-from <johannes@sipsolutions.net>)
	id 1rCefQ-00000006k4P-0UCC;
	Mon, 11 Dec 2023 12:41:44 +0100
Message-ID: <5e14be1fc61d9d7027cd50f4148eea52e40fb9d3.camel@sipsolutions.net>
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
Date: Mon, 11 Dec 2023 12:41:42 +0100
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

Hi,

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

I've been fine with the wifi bits since around v3 of the patchset ;-)

So the idea is that I'll pull this into wireless-next and then apply the
two wireless patches on top, right?

AFAICT, since the other patches don't depend on wireless for
compilation, this is the only thing I need to do, i.e. no need to have
another separate branch to send it further on, right?

johannes


