Return-Path: <linux-wireless+bounces-11176-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 19C1B94CD47
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 11:27:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C4B72281802
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 09:27:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4CF0719149A;
	Fri,  9 Aug 2024 09:27:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ZocnFN+p"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAF5718FDBC;
	Fri,  9 Aug 2024 09:27:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723195663; cv=none; b=P47dWNe5K+lVVj5KE2RZEhKTkErqxmSlu5K2g1F6z/fqrfTzot/k6GX2E10AVyWhgiY11CR/9qLAKsHQhxyFOH1Odp0micPUmb+3aYKUtiBTsqSv2SrU97eZoHo8pgveZr9/lZdGtq84WDCI6rrw2ov1WDH8r3XVmhIAAeOvvec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723195663; c=relaxed/simple;
	bh=n3NhaaEDX80/2TzfeEQq8Sqn7B7+AA/mO1GNp1zKs5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=InCX4unFuXre+3cP9OROcCWlp9XWJsDi1A2hIcMe4fs36tfbGIHbuIDg/8S8YhLamtgwCJszOL+XN3rjsQs3nWulwG1f+aOD7qQg0iMPyrO4R/pwUIFP6UUznYBBSMX+TEh9DXuAK1kdmTaJhAiFnpskvUVThjBOGozWIefiyQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ZocnFN+p; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4799Qm1gA631844, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723195608; bh=n3NhaaEDX80/2TzfeEQq8Sqn7B7+AA/mO1GNp1zKs5g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ZocnFN+pA1Gb/ZoBrHmRad/UhssL0zRzWAzYYw7sXIiKWaVaQNX3RwjC8O7AVs3k3
	 3eUFIAEKFkSKpbHlrPAaYOu+u99XLIqv2Xgkd9mBXm6DF+TvkrZDdzGnPt9NmvygLO
	 KsXz2D0RLIIW8Mt1cgPUEMDuGE9F3On3rnn0DUPv6Wr/Pr4BSaLxWmW8Pm1bkFQH9Y
	 wZUb1pjcedIgHD0EVdPBlSgAOwpyj35pp/aQbncyPkHy5VbV6tqDDse/aGP2FpmRSW
	 7xrmTwsi4y0+t9Fd9QnyQk9xD9maAFoh3Qxq9ktTrnFnmVjq0T3Q2jo2afT+0vw9sx
	 yhhroR9HWM1qQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4799Qm1gA631844
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Aug 2024 17:26:48 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 17:26:49 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Aug 2024 17:26:48 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 9 Aug 2024 17:26:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Sascha Hauer <s.hauer@pengutronix.de>
CC: Brian Norris <briannorris@chromium.org>,
        Francesco Dolcini
	<francesco@dolcini.it>,
        Kalle Valo <kvalo@kernel.org>,
        Yogesh Ashok Powar
	<yogeshp@marvell.com>,
        Bing Zhao <bzhao@marvell.com>,
        "John W. Linville"
	<linville@tuxdriver.com>,
        Amitkumar Karwar <akarwar@marvell.com>,
        "Avinash
 Patil" <patila@marvell.com>,
        Kiran Divekar <dkiran@marvell.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>
Subject: RE: [PATCH] mwifiex: duplicate static structs used in driver instances
Thread-Topic: [PATCH] mwifiex: duplicate static structs used in driver
 instances
Thread-Index: AQHa6jPW1qXxj1kE10+gt4nIKUPfkrIenWTw//+AnwCAAIns8A==
Date: Fri, 9 Aug 2024 09:26:48 +0000
Message-ID: <33fa77bdf10b48a48105f25ebed50fe0@realtek.com>
References: <20240809-mwifiex-duplicate-static-structs-v1-1-6837b903b1a4@pengutronix.de>
 <4021e822699b44939f6a4731290e2627@realtek.com>
 <ZrXdgIJe6U4sJJwU@pengutronix.de>
In-Reply-To: <ZrXdgIJe6U4sJJwU@pengutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Sascha Hauer <s.hauer@pengutronix.de> wrote:
> On Fri, Aug 09, 2024 at 08:49:32AM +0000, Ping-Ke Shih wrote:
> > Sascha Hauer <s.hauer@pengutronix.de> wrote:
> > > +       wiphy->bands[NL80211_BAND_2GHZ] =3D devm_kmemdup(adapter->dev=
,
> > > +                                                      &mwifiex_band_=
2ghz,
> > > +                                                      sizeof(mwifiex=
_band_2ghz),
> > > +                                                      GFP_KERNEL);
> >
> > It seems like you forget to free the duplicate memory somewhere?
>=20
> It's freed automatically when adapter->dev is released, see the various
> devm_* functions
>=20

Cool. Thanks for the info.=20


