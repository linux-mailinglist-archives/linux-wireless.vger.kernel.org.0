Return-Path: <linux-wireless+bounces-7428-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 34EF98C1DDD
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 07:58:12 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAF541F218DD
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 05:58:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E7861527A5;
	Fri, 10 May 2024 05:58:07 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 117E0152791
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 05:58:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715320687; cv=none; b=f8cGvrjSyOiwuOhIgyuZIHlKlOuu6weiaaaWo+fvHuNwUeNqc8J4dxWV93D7IrMufOq1J297QxbfNvrUQvoPhmj6TH0OgVGi11a3Tk8FEZ9Zceima7+TQRlEYgZABocFz/kPfOqQEBv8MCL1KtcoVwLVtau9l6ImshrXS7PWNDw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715320687; c=relaxed/simple;
	bh=4KmeWYif5eRhri18IlfwMFn0HrL+4Psa7qu1faezW5c=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=n9txyk433Jv8foJLcRrzwvO1+e/tobVHkqNbXo0KJwyRmJcjrYsCsLCIz3cpQSCvM5ku07shGQHPwMaVHGRUNVR0/i9LlaAtyQoz8GKOWA/uhHUx2zsWqZ6NhFm6BcwZTNKkMxQy/DnfoRRk1UTLrAGUg5u8IdMFsbZ1RbHJR9M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44A5vbOsB2423966, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44A5vbOsB2423966
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 13:57:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 13:57:37 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 13:57:37 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 10 May 2024 13:57:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v5 11/11] wifi: rtlwifi: Enable the new rtl8192du driver
Thread-Topic: [PATCH v5 11/11] wifi: rtlwifi: Enable the new rtl8192du driver
Thread-Index: AQHaoTY7ScBxEb5pz0GhTZsRgHsb0rGP+qnw
Date: Fri, 10 May 2024 05:57:37 +0000
Message-ID: <a90b614a55e24150a02ee9f02228958d@realtek.com>
References: <254558da-ea8b-40ea-bd5a-83d13796744f@gmail.com>
 <0fb5c4d9-d43c-4aa2-b483-c0104995fa9e@gmail.com>
In-Reply-To: <0fb5c4d9-d43c-4aa2-b483-c0104995fa9e@gmail.com>
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
UlRMODE5MkRVIGlzIGFuIG9sZGVyIFdpZmkgNCBkdWFsIGJhbmQgY2hpcC4gSXQgY29tZXMgaW4g
dHdvDQo+IGZsYXZvdXJzOiBzaW5nbGUgTUFDIHNpbmdsZSBQSFkgKGxpa2UgbW9zdCBSZWFsdGVr
IFdpZmkgNCBVU0IgZGV2aWNlcyksDQo+IGFuZCBkdWFsIE1BQyBkdWFsIFBIWS4NCj4gDQo+IFRo
ZSBzaW5nbGUgTUFDIHNpbmdsZSBQSFkgdmVyc2lvbiBpcyAyVDJSIGFuZCBjYW4gd29yayBlaXRo
ZXIgaW4gdGhlDQo+IDIuNCBHSHogYmFuZCBvciB0aGUgNSBHSHogYmFuZC4NCj4gDQo+IFRoZSBk
dWFsIE1BQyBkdWFsIFBIWSB2ZXJzaW9uIGhhcyB0d28gVVNCIGludGVyZmFjZXMgYW5kIGFwcGVh
cnMgdG8gdGhlDQo+IHN5c3RlbSBhcyB0d28gc2VwYXJhdGUgMVQxUiBXaWZpIGRldmljZXMsIG9u
ZSB3b3JraW5nIGluIHRoZSAyLjQgR0h6DQo+IGJhbmQsIHRoZSBvdGhlciBpbiB0aGUgNSBHSHog
YmFuZC4NCj4gDQo+IFRoaXMgd2FzIHRlc3RlZCBvbmx5IHdpdGggYSBzaW5nbGUgTUFDIHNpbmds
ZSBQSFkgZGV2aWNlLCBtb3N0bHkgaW4NCj4gc3RhdGlvbiBtb2RlLiBUaGUgc3BlZWRzIGluIHRo
ZSAyLjQgR0h6IGJhbmQgd2l0aCAyMCBNSHogY2hhbm5lbCB3aWR0aA0KPiBhcmUgc2ltaWxhciB0
byB0aGUgb3V0LW9mLXRyZWUgZHJpdmVyOiA4NS81MSBtZWdhYml0cy9zZWNvbmQuDQo+IA0KPiBT
dGVmYW4gTGlwcGVycy1Ib2xsbWFubiB0ZXN0ZWQgdGhlIHNwZWVkIGluIHRoZSA1IEdIeiBiYW5k
IHdpdGggNDAgTUh6DQo+IGNoYW5uZWwgd2lkdGg6IDE3My85OSBtZWdhYml0cy9zZWNvbmQuDQo+
IA0KPiBJdCB3YXMgYWxzbyB0ZXN0ZWQgYnJpZWZseSBpbiBBUCBtb2RlLiBJdCdzIGVtaXR0aW5n
IGJlYWNvbnMgYW5kIG15DQo+IHBob25lIGNhbiBjb25uZWN0IHRvIGl0Lg0KPiANCj4gU2lnbmVk
LW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQoNCkkg
aGF2ZSByZXZpZXdlZCB2NS4gTm8gYmlnIHByb2JsZW1zIGZvciBtZS4NCg0KS2VybmVsIHJvYm90
IHJlcG9ydGVkIG11bHRpcGxlIGRlZmluaXRpb24gYmVjYXVzZSBvZiBzdGF0aWMgbGluayAoSSB0
aGluayksIHNvDQp5b3Ugc2hvdWxkIGNoYW5nZSB0aGUgZnVuY3Rpb24gbmFtZSBwcmVmaXggdG8g
ODE5MmR1IG9yIDgxOTJkIHByb3Blcmx5IHRvDQphdm9pZCB0aGUgZXJyb3JzLg0KDQoNCg==

