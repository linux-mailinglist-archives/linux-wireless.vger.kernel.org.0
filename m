Return-Path: <linux-wireless+bounces-15400-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 2BD519CFD58
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 09:31:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D18E91F24547
	for <lists+linux-wireless@lfdr.de>; Sat, 16 Nov 2024 08:31:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE54314A4E9;
	Sat, 16 Nov 2024 08:31:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Uo/Y8gpD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7867163C
	for <linux-wireless@vger.kernel.org>; Sat, 16 Nov 2024 08:30:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731745861; cv=none; b=U2vHB6ACqQ1GigIup7tJNJ8AnqJ7o8/MolyJu2xohC+R/3L4YDfwkQBLb94F1PzUPZK+neo/ZLq+t8lmuhF8CwV8NKvDZqC+hIIqo9KY63cBVa0gWkzAfwX3rZrGm2yylqzsoqoekr0cNd2U+HgKqvXHFfRkS5ZFYjQV3E+RkYo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731745861; c=relaxed/simple;
	bh=Ri0eg7gKdjHmGK2hWY43/N8F2vmAcQkYsTr75PnHb+4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gfeEF8j6rhV29+ePq7Gpyd7MHgmla2MGEIWGkvNd62FNrxS+qH61dlNN5cxBvN0ccmyPdxNnsCACPUJrqkgxdz7BJWDm/4MDfocNvC7jylHt45lPyNmovv2zNM1eHihc8bypUM2ssUAmBeIKahzQz6Jf2GNragrgraL8w3Qzco0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Uo/Y8gpD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4AG8URnhC1735143, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1731745827; bh=Ri0eg7gKdjHmGK2hWY43/N8F2vmAcQkYsTr75PnHb+4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Uo/Y8gpD8z+IVGQvCuUOmxu11drPDdFSLlcPXk8HH+2W06SAx8xwKPG422+2FJS8J
	 supQQVz33+YmP2/mPsL5DaMDx1e52gGktCwcPePzjeV7iDUAVoZMEoudAly3Rn3xry
	 hrrd8i5Poil+qi0WLIj0A6eCddi1nGI4756DUbTP6rIDTpLMo/ZfkaTzSENc3o/PlX
	 OsOvHkyZ8GXF2hhCnqNZUqF4+ZltJshcZJXfCgWn0sPc2dg75WpcAS9M/YeJKdUbHh
	 oMe9RuXwFcCi5U/7Mi51sDNrV/8RpU4BrAqiSCVHcSn5GlrFxyd1vdweA1sGpBrfV1
	 Q2FkbldMVKK+w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4AG8URnhC1735143
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Sat, 16 Nov 2024 16:30:27 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Sat, 16 Nov 2024 16:30:28 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Sat, 16 Nov 2024 16:30:27 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Sat, 16 Nov 2024 16:30:27 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ivan Bulatovic <combuster@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "wireless-regdb@lists.infradead.org" <wireless-regdb@lists.infradead.org>
Subject: Re: wireless-regdb: Updated regulatory rules for Serbia (RS) fails to load
Thread-Topic: wireless-regdb: Updated regulatory rules for Serbia (RS) fails
 to load
Thread-Index: AQHbN5pK4ua2Zr/+SEyysODfPGm0mLK5k1H5
Date: Sat, 16 Nov 2024 08:30:27 +0000
Message-ID: <2dcd4763853b4645bab7911482209de6@realtek.com>
References: <CAPGdDAmPp80VEZ0TG=cS3QAYKqELHfqChid0wYZ7eLAENFY86Q@mail.gmail.com>
In-Reply-To: <CAPGdDAmPp80VEZ0TG=cS3QAYKqELHfqChid0wYZ7eLAENFY86Q@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: en-US
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Ivan Bulatovic <combuster@gmail.com> wrote:
>=20
> since commit b44edb2eaf3a917fbd7005f05c6faa202c984152 regulatory.db
> fails to load when country is set to RS with message:
>=20
> kernel: cfg80211: Invalid regulatory domain detected: RS.
>=20
> Offending lines are:
>=20
> 1646: (5725 - 5850 @ 80), (24), DFS, AUTO-BW
> 1647: (5850 - 5875 @ 80), (24), AUTO-BW
>=20
> OpenWRT is impacted, but I can reproduce this on Linux also.
>=20

I sent a patch [1] to correct this. Could you please give it a try and ack =
the patch if
it works to you?

Thanks.=20
Ping-Ke

[1] https://lore.kernel.org/linux-wireless/20241116082417.8720-1-pkshih@gma=
il.com/T/#u


