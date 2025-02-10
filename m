Return-Path: <linux-wireless+bounces-18678-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44D9FA2E20D
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 02:36:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D43523A6DE1
	for <lists+linux-wireless@lfdr.de>; Mon, 10 Feb 2025 01:35:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 98CCD9461;
	Mon, 10 Feb 2025 01:36:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="wC45CPUg"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C51923CB
	for <linux-wireless@vger.kernel.org>; Mon, 10 Feb 2025 01:35:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739151362; cv=none; b=JZmkgcPOxtxN5Jvu1cxxvR9IHiP3cdZ/qfPHKTHMff+Ke+SdTmER35qKzWdKGIRnB/XLrKR59yeR1MUQ4nqQj4J3TuRA0228FFbAUjY/4O0mr1EYKQ/hLpCtGlM9sqzLFdPeBsCDxOMOxAEzURgueqUfbXMpRfXW+TDNE5o86Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739151362; c=relaxed/simple;
	bh=96OvIIAGjwkK7XAfFrH9GKrU6Cp3wWHJMfWG+NOvKlw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kvoKU6j8HfeckTxqeFg03uJQZAR0EYEsEktk+rnJEcmx+D1edchv6nGk+3DKcrULk1ScesiqvzeaGDAWA6/cY0zKcG/1FAfKQXwB5vw9lpCusz52uyyziHQZI7i2vUMU4KD9m2lQSsQNO/IhQT9a4B5wPGopzaav0UsGLZyl2FA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=wC45CPUg; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51A1ZtLX21407499, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739151356; bh=96OvIIAGjwkK7XAfFrH9GKrU6Cp3wWHJMfWG+NOvKlw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=wC45CPUgAjLY2sq1M60WIdrwwEtJttm2kdtwFkw7mGsEoeaEcugITQIvC1y4+2hSG
	 HNTeMCYcVLfMDEy1J45FWqHJQCYzk5YFBA7lIsMoihirPX5R1hdkel5S6kdejph40j
	 U3hbkqJs4iG6SV/5xv+677DUkyovQVwkcQMksDYjsx/TUGuYlIw65WtEs5+EPy0WmK
	 YF9QbTubG12BLxjg5w+EgE7bJNAgA3L3aaTMXp1hJV9tiqlTyUjWu9Rq7Gd77nKBo0
	 SNbeTranVRdpnydrHv4RWmW2LIEclEuzBmN9+MsrluY6ZTjvSjqrB1w6l56IaTwEA2
	 FUbRC95jBqz4g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51A1ZtLX21407499
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 10 Feb 2025 09:35:56 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 10 Feb 2025 09:35:56 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 10 Feb 2025 09:35:56 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Mon, 10 Feb 2025 09:35:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 6/9] wifi: rtw88: Constify some more structs and arrays
Thread-Topic: [PATCH v2 6/9] wifi: rtw88: Constify some more structs and
 arrays
Thread-Index: AQHbdzRD5gYNlxh59kq6ToHDWBfW4bM/ybsg
Date: Mon, 10 Feb 2025 01:35:56 +0000
Message-ID: <e20978267f0245a1b7446b82fa5e72ff@realtek.com>
References: <9fc518ae-7708-42c6-99ca-56ee307555b6@gmail.com>
 <502f124e-ccf3-4c09-80a4-1e5c5304822b@gmail.com>
In-Reply-To: <502f124e-ccf3-4c09-80a4-1e5c5304822b@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGVz
ZSBzdHJ1Y3RzIGFuZCBhcnJheXMgYXJlIG5ldmVyIG1vZGlmaWVkLCBzbyBtYWtlIHRoZW0gY29u
c3Q6DQo+IA0KPiBydHdfYmFuZF8yZ2h6DQo+IHJ0d19iYW5kXzVnaHoNCj4gcnR3X3BjaV90eF9x
dWV1ZV9pZHhfYWRkcg0KPiBydHdfcGNpX29wcw0KPiBydHdfY2NrX3JhdGVzDQo+IHJ0d19vZmRt
X3JhdGVzDQo+IHJ0d19odF8xc19yYXRlcw0KPiBydHdfaHRfMnNfcmF0ZXMNCj4gcnR3X3ZodF8x
c19yYXRlcw0KPiBydHdfdmh0XzJzX3JhdGVzDQo+IHJ0d19yYXRlX3NlY3Rpb24NCj4gcnR3X3Jh
dGVfc2l6ZQ0KPiBydHdfc2Rpb19vcHMNCj4gcnR3X3VzYl9vcHMNCj4gDQo+IFNpZ25lZC1vZmYt
Ynk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpBY2tlZC1i
eTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCg0K

