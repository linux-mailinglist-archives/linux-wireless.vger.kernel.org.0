Return-Path: <linux-wireless+bounces-12807-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 147E4975EED
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 04:33:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 672E0B235BB
	for <lists+linux-wireless@lfdr.de>; Thu, 12 Sep 2024 02:33:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C5A92CCAA;
	Thu, 12 Sep 2024 02:33:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="I+yM0KMH"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7030C250EC;
	Thu, 12 Sep 2024 02:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726108396; cv=none; b=Ju1sH+uUJfFDEVDTS/NH6Nd0ohGMfAjic/kCMSKdRgvpJ8lS2EThgBesh7QUTP42V966BDg9dtIuGFw6SFSpuyQ6TKuVvkf4PXO6LXk2wpxZMt+lbCXAqH6+mhfw8DncrJ9uEo4GHJiRPldhfILZo5DVBz6OW+ua+ji1/rZRUe0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726108396; c=relaxed/simple;
	bh=RqdZqomXAwCyOm15Ifcp/0ilFc9KF41m0H52KNmV10Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=jTCs6X4i2FobI5Bqa1BPsJXFPbXlP1tFMIb2VC8OtXMTFmHqgjgVbKnsZHGH/K82BJnc4LoAnr0gho8CCFj8N3WLlemkwMpT558U87+9vAERhEiHXiKCChqI9KkLJs35hLxCyfckGRx8QB5K/JG4+A1KChAX7/fXwn3zAyORDjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=I+yM0KMH; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48C2X85A0541259, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726108388; bh=RqdZqomXAwCyOm15Ifcp/0ilFc9KF41m0H52KNmV10Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=I+yM0KMH5jRw/B85Bv+PRWrVrIJsJqB8SS7a0FhoWW+UFGxC8b9tt0xmBczBerC/p
	 ikm9N8mqXNqIJhr6M3t6GHqD7PwxZjKSwiqZQzZpN9Tk9haHBbzcETq23g99NjB5y3
	 l7tPYd1Ep4DmSCQHhngC5RSmsGOPtezL2UwepNudELABFse5X8MjwEp/TmxC1M3zv6
	 0PqspJutBWiXIN1tU13MS2RvD/wjvdkgwHDiwEDFxRcvv/6AoE/w37thTy+8U3Pqq7
	 6/gVe3QIWXdHzR+JOUV74SJpI4cxTJBTdD+vxFfWJlxSG9Get2m8e3tUL+hbBdPwE9
	 DqwP1jgjw/Srg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48C2X85A0541259
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 12 Sep 2024 10:33:08 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 12 Sep 2024 10:33:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 12 Sep 2024 10:33:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 12 Sep 2024 10:33:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Jakub Kicinski <kuba@kernel.org>, Kalle Valo <kvalo@kernel.org>
CC: "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: pull-request: wireless-next-2024-09-11
Thread-Topic: pull-request: wireless-next-2024-09-11
Thread-Index: AQHbBCaF/9K30GyQfUOAvskhRTD9drJSiJ+AgACjYo7//3uwgIAAAHyAgADGoYA=
Date: Thu, 12 Sep 2024 02:33:08 +0000
Message-ID: <0b6a69a39d6b463da41c5a83b747e4cd@realtek.com>
References: <20240911084147.A205DC4AF0F@smtp.kernel.org>
	<20240911134521.7f510329@kernel.org>	<87ikv1bz8e.fsf@kernel.org>
	<20240911153633.7a01a6c7@kernel.org> <20240911153817.0c150bc6@kernel.org>
In-Reply-To: <20240911153817.0c150bc6@kernel.org>
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

Jakub Kicinski <kuba@kernel.org> wrote:
> On Wed, 11 Sep 2024 15:36:33 -0700 Jakub Kicinski wrote:
> > > What's the deadline for these? Do you need the fixes tomorrow or can =
it
> > > wait a week or two?
> >
> > It can wait, half of them are old anyway
>=20
> Oh, that's because they are in staging :) I missed that.
> But anyway, I don't think that a harmless, single compiler,
> W=3D1 warning is a blocker.

I have fixed warnings of "wifi: rtw89" by [1]. For staging code, I use anot=
her
patchset [2] to fix it.

I'm not sure [1] should go wireless or rtw tree. Please guide me. Thanks.=20

[1] https://lore.kernel.org/linux-wireless/20240912021626.10494-1-pkshih@re=
altek.com/T/#u
[2] https://lore.kernel.org/linux-staging/20240912022522.10715-1-pkshih@rea=
ltek.com/T/#t



