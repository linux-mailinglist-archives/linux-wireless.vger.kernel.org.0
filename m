Return-Path: <linux-wireless+bounces-10420-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 870589387BF
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 05:39:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 305061F2151A
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Jul 2024 03:39:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D49713D6D;
	Mon, 22 Jul 2024 03:39:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="mJwT0rBX"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 406BC1370
	for <linux-wireless@vger.kernel.org>; Mon, 22 Jul 2024 03:39:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721619590; cv=none; b=nqhPeJ5fOKom+bmLyKb0e6YczvlduUiC9+V7ZxJkIj9WGjzkakq6zszpYAdLpUaiwfVVBkStUwAymtiIvKh9fxqXGbDcQVbTPwqQnLXN82gNZayOutq1ch4cJuFpFesSRSr0iTz0BIBUFMXwNTMNU2zoWmRTGWDj+9gKEXgt2O8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721619590; c=relaxed/simple;
	bh=0yNv1k/9vWgzLNn/uulLeR7DKQcV8xiS835aOSSK5qc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=V0E//BzLm8ohGjWFsmYz9xJdvd/zbCZ4MW7c9A/XVE6kCgMfQkcXHvzxHhxNSn8K0Bgo5+qkgyQo7eSd0lbfcUSOpYiyn1gIxHWMyVfp40SKGmJoOjvn5CKZ0XAUVRddn3BZAF1NcBEGnUEP0B1hu3TQ3wFV43E3ZatjYUhJT60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=mJwT0rBX; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46M3db4zB3190724, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1721619577; bh=0yNv1k/9vWgzLNn/uulLeR7DKQcV8xiS835aOSSK5qc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=mJwT0rBXwFMD25eBJRXksqhZp0/5uKsM+oODy7GWHAbCTHWaCVbDwmB422+wI5CQw
	 Xt0icQzFyfc2H8CtiBX0fZUCzujDDXrs7WlcIPkiE1fBYHEEDzMG2P7QkgyV7oz57F
	 Vc2M63SFo99fcjHEcF0kT1Qcad9Ed2x+lJvXkTHJoWoLQtJM8yugwrUD47ab75Npn/
	 itJIx6dugUVWvzdyqwSKclc3dR1ncgwtr9OoLo0hV1dq79E1IVXtDKY3zAHWozwOQA
	 3EGsHpeUQA7/vzkKoCHwhZL8MJH8pljejdNt0UYZ1ySWGAlN0P9tijJMrTl/uL6VlB
	 wHQ5e8HLy0mZQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46M3db4zB3190724
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Jul 2024 11:39:37 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 22 Jul 2024 11:39:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Jul 2024 11:39:37 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 22 Jul 2024 11:39:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Fiona Klute <fiona.klute@gmx.de>
Subject: RE: [PATCH 2/2] wifi: rtw88: 8703b: Fix reported RX band width
Thread-Topic: [PATCH 2/2] wifi: rtw88: 8703b: Fix reported RX band width
Thread-Index: AQHa28ETJnl9hjuhWUS8/RxWhlNz+rICGbEA
Date: Mon, 22 Jul 2024 03:39:37 +0000
Message-ID: <aac7a0fa33fc4593bc291b2c9c800519@realtek.com>
References: <2fbacb83-3e47-4f37-a70a-fb9f4719eb26@gmail.com>
 <712d08e3-fc90-48ad-bb61-bb601b2cf953@gmail.com>
In-Reply-To: <712d08e3-fc90-48ad-bb61-bb601b2cf953@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGUg
ZGVmaW5pdGlvbiBvZiBHRVRfUlhfREVTQ19CVyBpcyBpbmNvcnJlY3QuIEZpeCBpdCBhY2NvcmRp
bmcgdG8gdGhlDQo+IEdFVF9SWF9TVEFUVVNfREVTQ19CV184NzAzQiBtYWNybyBmcm9tIHRoZSBv
ZmZpY2lhbCBkcml2ZXIuDQo+IA0KPiBUZXN0ZWQgb25seSB3aXRoIFJUTDg4MTJBVSwgd2hpY2gg
dXNlcyB0aGUgc2FtZSBiaXRzLg0KPiANCj4gQ2M6IHN0YWJsZUB2Z2VyLmtlcm5lbC5vcmcNCg0K
QWRkIGEgRml4ZXMgdGFnPyBhcyB3ZWxsIGFzIHBhdGNoIDEvMi4gDQpPdGhlcndpc2UgbG9va3Mg
Z29vZCB0byBtZS4gDQoNCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgy
MWNlcmZlMkBnbWFpbC5jb20+DQoNCg0K

