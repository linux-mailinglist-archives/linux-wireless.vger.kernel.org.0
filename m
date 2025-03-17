Return-Path: <linux-wireless+bounces-20417-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A0646A63CA1
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 04:02:29 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8BAD216E1EA
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 03:02:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 112372FB6;
	Mon, 17 Mar 2025 03:02:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="wIgFDrxe"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C558E13B7B3
	for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 03:02:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742180525; cv=none; b=WojzFfwJeJ17w3fORu6+OWmKxLnOlsxwi8UdwAWhap1QB+e+zAaFJOWr31Cad8uMup1vUSJn8XY46YwmolGG3sts5BnPes/05YnsTf0gc+wS8nSqw521OuuADMsiPIARTFYFyQB5eJlaEWGjXWk+6yLLv6RVx6CyKdhxT41Nb0k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742180525; c=relaxed/simple;
	bh=NptYN+4RWd/t2Ec8oIX1r7I5xbSJAJs/h/AGiQ6TkBs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=t66RAeCTsPmDEmPMqpiRMKb7tVxLvZv40j+B2jfRWatK0tKTejGYLVKrxhdprFKHZhKG6392hl5bmf7g1/iTCVa+P2bE8AL6ps1051K9Mi4ZLENNpSV7Lt24XCJpCCu7PfF/8+IhvBFcn1wS5g4L6RjNh/tPrrtLT2kpj3Zaqlc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=wIgFDrxe; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52H31wE323995685, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742180519; bh=NptYN+4RWd/t2Ec8oIX1r7I5xbSJAJs/h/AGiQ6TkBs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=wIgFDrxemDlKWvVoQvJ8CfAGnaRMU0f8vjoQzqLDwO4U3tC+QufJhn6j1wmCUtWGY
	 NwQbyEFnI95fQW4/bSdSOmQjk5oTCOUZhqSIEHdXlan8WYYdFwW+tAAP6ECGOObgE1
	 7o8MJfjt6YDcFrYwsZoShADC/XLHStX7IuQh/3uqT7EKsiDb8/pXxLQfe/0kRqDBez
	 Ktzq+ziGujeWR8Dgk2UTL0nb1bqweq6tTQ8hNGzFyLOvrI/vA867MH+9fSh9EvTXnR
	 jp/4QGwVs8RN1BkbIvERJxDH/4K2sbWOPDtS+NJwUAWFmpHrgcJMGTAcbpI61nvcWs
	 G43AUxWqKCa2g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52H31wE323995685
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 11:01:59 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Mar 2025 11:01:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 17 Mar 2025 11:01:58 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 17 Mar 2025 11:01:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 3/4] wifi: rtw88: Set AMPDU factor to hardware
Thread-Topic: [PATCH rtw-next 3/4] wifi: rtw88: Set AMPDU factor to hardware
Thread-Index: AQHblFUnF3FHtd8BUESRxvtJE6hCX7N2ps5g
Date: Mon, 17 Mar 2025 03:01:58 +0000
Message-ID: <b972a60bb0b04b5f817047027970d896@realtek.com>
References: <c845ff10-08d9-4057-8f54-1579a548788d@gmail.com>
 <289795d5-49ae-4789-8f14-b2d016843a53@gmail.com>
In-Reply-To: <289795d5-49ae-4789-8f14-b2d016843a53@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
VGVsbCB0aGUgY2hpcCB0aGUgbWF4aW11bSBBTVBEVSBzaXplIHN1cHBvcnRlZCBieSB0aGUgQVAu
IFRoaXMgZ3JlYXRseQ0KPiBpbXByb3ZlcyB0aGUgVFggc3BlZWQgb2YgUlRMODgxNEFVIGluIHRo
ZSAyLjQgR0h6IGJhbmQuIEJlZm9yZTogfjkwDQo+IE1icHMuIEFmdGVyOiB+MzAwIE1icHMuDQo+
IA0KPiBBZGQgdGhpcyBjb25maWd1cmF0aW9uIGZvciBhbGwgdGhlIGNoaXBzLCBldmVuIGlmIGl0
IG9ubHkgaGFzIGFuIGVmZmVjdA0KPiBvbiBSVEw4ODE0QVUgaW4gbXkgdGVzdHMuIFN1cmVseSB0
aGV5IGFsbCBuZWVkIHRoaXMuDQoNClRoZSBoYXJkd2FyZSBkZWZhdWx0IHZhbHVlIG9mIFJFR19B
TVBEVV9NQVhfTEVOR1RIIGlzIDB4ZmZmZiAodW5saW1pdGVkKQ0KZm9yIG1vc3QgY2hpcHMuIEl0
IHNlZW1zIGxpa2UgUlRMODgxMkEvUlRMODgyMUEgYXJlIGFsc28gZXhjZXB0aW9ucywgc28NCmF0
IHBvd2VyIG9uIGZ1bmN0aW9uIHRoZXkgZG8NCiAgICBydHdfd3JpdGUzMihydHdkZXYsIFJFR19B
TVBEVV9NQVhfTEVOR1RILCAweGZmZmZmZmZmKTsNCg0KSSBmZWVsIFJUTDg4MTRBIGhhcyBzaW1p
bGFyIHNldHRpbmcsIHNvIG1heWJlIHlvdSBjYW4ganVzdCBhZGQgc2ltaWxhciANCnN0dWZmLiAN
Cg0KQnkgdGhlIHdheSwgdGhlIEFNUERVIGlzIGNvbnRyb2xsZWQgYnkgVFggZGVzY3JpcHRvciBi
YXNpY2FsbHk6IA0KCXBrdF9pbmZvLT5hbXBkdV9mYWN0b3IgPSBhbXBkdV9mYWN0b3I7DQoJcGt0
X2luZm8tPmFtcGR1X2RlbnNpdHkgPSBhbXBkdV9kZW5zaXR5Ow0KCXBrdF9pbmZvLT5hbXBkdV9l
biA9IGFtcGR1X2VuOw0KDQpTaW5jZSB5b3UgZGlkbid0IGNoYW5nZSB0aGlzIHBhcnQgYXQgYWxs
LCBJIHN0aWxsIGZlZWwgc2V0dGluZyANClJFR19BTVBEVV9NQVhfTEVOR1RIIHRvIDB4ZmZmZmZm
ZmYgY2FuIGZpeCBsb3cgdGhyb3VnaHB1dCBwcm9ibGVtLg0KDQo=

