Return-Path: <linux-wireless+bounces-11173-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A73F194CCAF
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 10:50:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D98FB1C21044
	for <lists+linux-wireless@lfdr.de>; Fri,  9 Aug 2024 08:50:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3518318F2F8;
	Fri,  9 Aug 2024 08:50:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="nOpdApk3"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 007BB4431;
	Fri,  9 Aug 2024 08:50:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723193447; cv=none; b=G8jDeg0yf9NmG4Ql+5rRK7nU1SNheAVw6hT4wYz1h6F+7B5S13MVE2yw4SBXTYWF8VhdYPBZuQpw1LpeXgrWvUyk4te538utCXBNY6qccsfqZiLUMt8Lngfjrg3eh7uevQmz3KHs5Ph2HGnfsKgM85DVCVtlcKNGhIBgJ3roVgQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723193447; c=relaxed/simple;
	bh=qaDG7zboSJyGxTR0mQvPfaD2Ys4GkNK0yXQZsnFbJP4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D3wLQADT+j4Z8ebWnBLfscI2DxH25K1rg5y4aSjRurafQuY5GgBWyR3L2eXX5N1S+NzaJ36+2lrCeKlGlTqcvQ36Fxm+SuSCvXDld9JA3Mgm4o2otXkJU14P5oFHZKqVYVMIDMsexG2R+knJEr7Sk2rpedqwKugJ8BiC8W7sAJs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=nOpdApk3; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4798nWJN1597209, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723193372; bh=qaDG7zboSJyGxTR0mQvPfaD2Ys4GkNK0yXQZsnFbJP4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=nOpdApk3W0mIVGTGx8lDDLemkDXb1ikHaEb54/iNYEwoijh6Qc+r9DKF3j5ZZGGHD
	 1v7CXIE0+cowGjtwDM2u33EwyAUDoKUUlZsDV1zk0qVsjatMHG1Qgxv9qTmQqRfh+H
	 eGTDOtTrLmNbluwNwbWiGi0JtDBeCoSOb1/fzIpzSiCxiw76FbznvLDPm+3Bbd7WYi
	 LiRmhq9CukB6QiHXHUD2KFEs0p8rN0Pw8jW/5pdcVn91+m6JSvGFIU5ZbEKKE5cyg0
	 ReIw927RLQ/crzo+8VfOOoDVXcoRumv2oqQ3vEwe0p25+knGG2pfjg5FL4ygwqQpzp
	 tml2ffGXktWWg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4798nWJN1597209
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 9 Aug 2024 16:49:32 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 9 Aug 2024 16:49:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 9 Aug 2024 16:49:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 9 Aug 2024 16:49:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Sascha Hauer <s.hauer@pengutronix.de>,
        Brian Norris
	<briannorris@chromium.org>,
        Francesco Dolcini <francesco@dolcini.it>,
        "Kalle
 Valo" <kvalo@kernel.org>,
        Yogesh Ashok Powar <yogeshp@marvell.com>,
        Bing Zhao
	<bzhao@marvell.com>,
        "John W. Linville" <linville@tuxdriver.com>,
        "Amitkumar
 Karwar" <akarwar@marvell.com>,
        Avinash Patil <patila@marvell.com>
CC: Kiran Divekar <dkiran@marvell.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "kernel@pengutronix.de"
	<kernel@pengutronix.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] mwifiex: duplicate static structs used in driver instances
Thread-Topic: [PATCH] mwifiex: duplicate static structs used in driver
 instances
Thread-Index: AQHa6jPW1qXxj1kE10+gt4nIKUPfkrIenWTw
Date: Fri, 9 Aug 2024 08:49:32 +0000
Message-ID: <4021e822699b44939f6a4731290e2627@realtek.com>
References: <20240809-mwifiex-duplicate-static-structs-v1-1-6837b903b1a4@pengutronix.de>
In-Reply-To: <20240809-mwifiex-duplicate-static-structs-v1-1-6837b903b1a4@pengutronix.de>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

U2FzY2hhIEhhdWVyIDxzLmhhdWVyQHBlbmd1dHJvbml4LmRlPiB3cm90ZToNCj4gKyAgICAgICB3
aXBoeS0+YmFuZHNbTkw4MDIxMV9CQU5EXzJHSFpdID0gZGV2bV9rbWVtZHVwKGFkYXB0ZXItPmRl
diwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICZtd2lmaWV4X2JhbmRfMmdoeiwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHNpemVvZihtd2lmaWV4X2JhbmRfMmdoeiksDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBHRlBf
S0VSTkVMKTsNCg0KSXQgc2VlbXMgbGlrZSB5b3UgZm9yZ2V0IHRvIGZyZWUgdGhlIGR1cGxpY2F0
ZSBtZW1vcnkgc29tZXdoZXJlPw0KDQoNCg==

