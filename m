Return-Path: <linux-wireless+bounces-22448-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB97EAA8E89
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 10:51:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 65A2D17349C
	for <lists+linux-wireless@lfdr.de>; Mon,  5 May 2025 08:51:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B09A8188734;
	Mon,  5 May 2025 08:51:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="NCwEuJfv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA0431DDA14
	for <linux-wireless@vger.kernel.org>; Mon,  5 May 2025 08:51:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746435102; cv=none; b=H85MUQ6DQTKyvT8JKSd/9xIjvaHNCwGilXFFCx1YR1STgidRArIQKhHQD2Q+VDpa697d/cp6c4FTSksSoJPzdpXXeOOVvYSVh7VCw+sX04f3G0xJH+6c+iRxAs3nvdnyGpsDqzNwALASAopyBjF/7DRNrsO/PiZg5UQPaorQ4Es=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746435102; c=relaxed/simple;
	bh=JMLJVrkM7VoeqJytnimpxtPaHVfe2xpy9sQhx40g+GQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=soqrWxr5jSMhqPgRr93aUjeJ0FkdnNe2IJ4yNlp2fkRHk17CDHGtKYtjrN3SJT6+ZM2Mbc0wqE/l11xlGo3VMweJuc8riZd0Ra3vEdlEOEfaTxLbHArsI85UtEtet4hNTlUi2x2gWCXTV7zHtgext0g2c2nJx6SSsbIlv0a9n5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=NCwEuJfv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 5458pY7v93929224, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1746435094; bh=JMLJVrkM7VoeqJytnimpxtPaHVfe2xpy9sQhx40g+GQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=NCwEuJfv6u0rEsSUA1L7yVTBDPKfObC7YIcJpzFXunpn6I5b5K5XXRdNffR6Aeqrp
	 Fg4q8f9fPhGCQwF9dkdsiQCUnH9dibw2l2y8cGpZFhXplftKAcVqO10rN9ncCr7PYk
	 +ECcaPfvvTPOOgo1j7KQePJT4pDrBskR2FvLDACfxprg7Er0qry7VuH0lf818o340L
	 PqSEJIB9JjjXvSjUh6zLdG2lZcmGS/Ge3Zruv6WZDn3G/ExmUwU5GgypkxhEGdLRzE
	 Y/DxJLdUGizeonVYK+68je0YLx7PnBhEovIB1BRGgLNWGdvW5SbRw30ISzoeF7zBeT
	 TOB0qzehCXqEg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 5458pY7v93929224
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 5 May 2025 16:51:34 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 5 May 2025 16:51:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 5 May 2025 16:51:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 5 May 2025 16:51:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Samuel Reyes <zohrlaffz@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: RTL8922AE driver issues
Thread-Topic: RTL8922AE driver issues
Thread-Index: AQHbvXDofJ7veYm0B0SRgsW1576rS7PDt/FQ
Date: Mon, 5 May 2025 08:51:34 +0000
Message-ID: <0cf9bd4b99864f428175e34a2f2e014b@realtek.com>
References: <CAD+XiyEJo0m8L6PbmBD=NPPa0E_wX3kk4ezn1qZ0d8JGXsS1qQ@mail.gmail.com>
In-Reply-To: <CAD+XiyEJo0m8L6PbmBD=NPPa0E_wX3kk4ezn1qZ0d8JGXsS1qQ@mail.gmail.com>
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

U2FtdWVsIFJleWVzIDx6b2hybGFmZnpAZ21haWwuY29tPiB3cm90ZToNCj4gDQo+IEhlbGxvLA0K
PiANCj4gTXkgV2lGaSBoYXMgaW50ZXJtaXR0ZW50IGNvbm5lY3Rpb24gaXNzdWVzIG9uIEFyY2gu
IE15IG1vdGhlcmJvYXJkIGlzDQo+IGEgR2lnYWJ5dGUgWDg3MCBBT1JVUyBFTElURSBXSUZJNy4N
Cj4gDQo+IEV2ZW4gd2hlbiBpbnN0YWxsaW5nIEFyY2ggbXkgY29ubmVjdGlvbiB3YXMgdW5zdGFi
bGUsIGRtZXNnIC1UIGlzDQo+IGxpdHRlcmVkIHdpdGggZW50cmllcyBsaWtlIHRoaXM6DQo+IHJ0
dzg5Xzg5MjJhZSAwMDAwOjA3OjAwLjA6IGZhaWxlZCB0byB1cGRhdGUgMTYyIFJYQkQgaW5mbzog
LTExDQo+IHJ0dzg5Xzg5MjJhZSAwMDAwOjA3OjAwLjA6IGZhaWxlZCB0byB1cGRhdGUgMTYzIFJY
QkQgaW5mbzogLTExDQo+IHJ0dzg5Xzg5MjJhZSAwMDAwOjA3OjAwLjA6IGZhaWxlZCB0byB1cGRh
dGUgMzIgUlhCRCBpbmZvOiAtMTENCj4gcnR3ODlfODkyMmFlIDAwMDA6MDc6MDAuMDogZmFpbGVk
IHRvIHJlbGVhc2UgVFggc2ticw0KDQpDb3VsZCB5b3UgaGVscCB0byBlbmxhcmdlIHJldHJ5IGNv
dW50PyBvciBldmVuIGxhcmdlci4gDQoNCi0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODkvcGNpLmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkv
cGNpLmMNCkBAIC0yMjgsNyArMjI4LDcgQEAgaW50IHJ0dzg5X3BjaV9zeW5jX3NrYl9mb3JfZGV2
aWNlX2FuZF92YWxpZGF0ZV9yeF9pbmZvKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwNCiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3Qg
c2tfYnVmZiAqc2tiKQ0KIHsNCiAgICAgICAgc3RydWN0IHJ0dzg5X3BjaV9yeF9pbmZvICpyeF9p
bmZvID0gUlRXODlfUENJX1JYX1NLQl9DQihza2IpOw0KLSAgICAgICBpbnQgcnhfdGFnX3JldHJ5
ID0gMTAwOw0KKyAgICAgICBpbnQgcnhfdGFnX3JldHJ5ID0gMTAwMDsNCiAgICAgICAgaW50IHJl
dDsNCg0KICAgICAgICBkbyB7DQoNCg0KU2luY2UgdGhpcyBtb3RoZXJib2FyZCBpcyBBTUQgcGxh
dGZvcm0sIHBsZWFzZSBhbHNvIHRyeSB0byB0dXJuIG9mZiBJT01NVQ0KdmlhIGtlcm5lbCBjb21t
YW5kIGxpbmUgYW1kX2lvbW11PW9mZiB0byBzZWUgaXQgY2FuIGhlbHAuIA0KDQo+IA0KPiBNeSBj
b25uZWN0aW9uIGNhbiByZW1haW4gYWN0aXZlIGZvciBhIGxvbmcgdGltZSBidXQgd2lsbCBvY2Nh
c2lvbmFsbHkNCj4gZGlzY29ubmVjdC4gVG9nZ2xpbmcgQWlycGxhbmUgTW9kZSBmaXhlcyB0aGUg
aXNzdWUuIFByb2xvbmdlZA0KPiBkb3dubG9hZHMsIHN1Y2ggYXMgYSBsYXJnZSB2aWRlbyBnYW1l
LCBjYXVzZXMgdGhlIGNvbm5lY3Rpb24gdG8gZHJvcA0KPiBzZXZlcmFsIHRpbWVzLiBUb2dnbGlu
ZyBBaXJwbGFuZSBNb2RlIGxldHMgdGhlIGdhbWUgYmVnaW4gZG93bmxvYWQNCj4gZWFjaCB0aW1l
Lg0KDQpOb3QgdmVyeSBzdXJlIGlmIGRpc2Nvbm5lY3Rpb24gaXMgcmVsYXRlZCB0byBhYm92ZSBt
ZXNzYWdlcy4gVHJ5IHRvDQpkaXNhYmxlIHBvd2VyIHNhdmUgdG8gc2VlIGlmIGl0IGJlY29tZXMg
c3RhYmxlIGJ5DQoNCiAgICBzdWRvIGl3IHdsYW4wIHNldCBwb3dlcl9zYXZlIG9mZg0KDQoNCg0K

