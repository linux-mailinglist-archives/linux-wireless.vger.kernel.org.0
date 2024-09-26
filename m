Return-Path: <linux-wireless+bounces-13209-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C738986A49
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 02:36:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7DB93B2273C
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Sep 2024 00:36:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8F5416EB53;
	Thu, 26 Sep 2024 00:35:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="KzAux+KY"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 958321E50D;
	Thu, 26 Sep 2024 00:35:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727310957; cv=none; b=nXZRBnRhlf5LlHOm2oaD6aW5wXF8brIz3QdSBsJd0I8LcvS4bSzQNoLJL+CXlXx9nk7+4psPftb1WhAG7vm+cMebT2D6aNsnsqXOLw7sO71fJv1DK9r5QZa4hkLM+Q6Pb1ttTmv261D1Oq2rLhrZ/Z1hJQFvpBLPnYzPKNNTxp0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727310957; c=relaxed/simple;
	bh=OTxepK50gFm+spFuErdfmXjkai3LQKIa8ukM5dhLGy8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=f+IisFQiG7p6kDqwG/qJ0nhKV3mUCE67tBTmr/AOO5OVlryCH6g7j3oHsUJhLcsAfoyXIi8/gUlCWhMfejnrjYxJvm+e7vb/rfmwV+lT0LwOJH6P2QAELbXysOhjROtQsqZJ31oDiX6iP4TYPWyYq0dSp8qx2DXbP5UHCvre5hg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=KzAux+KY; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48Q0Z3TU01155500, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727310903; bh=OTxepK50gFm+spFuErdfmXjkai3LQKIa8ukM5dhLGy8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=KzAux+KYBcI1YwDnFlmOnP+CGxuWE0yCMuMIP7mafhE+2kBGQax0dGiEq095qeoKC
	 V2V0f7ixScnmdQfEVvD+ploJhijxZtSC5rKRNE2OquN7re4/kUs6jYXnEKWFqL8Y29
	 aOSRoLrJQJAJf7scQPRdGi1oE9AeEeoWES/7BDTueCrM7XKLxT/mXEccC/a3yDPeCT
	 o7upY5lp6U5zii9Sn/iJEjQY4k6DbZseg75EABCBtR33c4AOypdJeY/qDGFu50BnFg
	 EZxzOTVEpra7M1GLdlEKcaP2HdCU3GJ0COG3krRuiZK13Xrl1Y9wjowUyq7ab1fLOB
	 0D+GYCfMdfv3A==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48Q0Z3TU01155500
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Sep 2024 08:35:03 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 26 Sep 2024 08:35:04 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 26 Sep 2024 08:35:03 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 26 Sep 2024 08:35:03 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "petter@technux.se" <petter@technux.se>,
        Johannes Berg
	<johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "stable@vger.kernel.org" <stable@vger.kernel.org>,
        Sasha Levin
	<sashal@kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "morrownr@gmail.com" <morrownr@gmail.com>,
        "s.hauer@pengutronix.de"
	<s.hauer@pengutronix.de>
Subject: RE: rtw88: rtw8822cu: Kernel warning in cfg80211: disconnect_work at net/wireless/core.h:231 on CPU 0
Thread-Topic: rtw88: rtw8822cu: Kernel warning in cfg80211: disconnect_work at
 net/wireless/core.h:231 on CPU 0
Thread-Index: AQHbDlBMQrWI+wnn6UWsv+tgTc/yIbJn1a/Q//+tYACAALL3gIABBHTw
Date: Thu, 26 Sep 2024 00:35:02 +0000
Message-ID: <009da7942b8e4b2d9921d53d6592b801@realtek.com>
References: <80de30f72595480a2e061dc462191c9f@technux.se>
 <9d243087654c4f3492d0046b7444c6a6@realtek.com>
 <13c3221f0cf2c5586dc34e8dcf6758c9e4e6cd4c.camel@sipsolutions.net>
 <9e98937d781c990615ef27ee0c858ff9@technux.se>
In-Reply-To: <9e98937d781c990615ef27ee0c858ff9@technux.se>
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

> Thanks! I tried reverting 268f84a82753, then as you guys expected the
> issue is gone. So will continue to run with this commit reverted. But
> would be good if we can decide
> how to handle this for stable releases (such as 6.6) and see if we can
> revert it their also in upcoming 6.6.53.
>=20

I sent a patch [1] to revert it.=20

[1] https://lore.kernel.org/stable/20240926003017.5427-1-pkshih@realtek.com=
/T/#u


