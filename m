Return-Path: <linux-wireless+bounces-6296-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 6201F8A468C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 03:30:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D13B71F21D4C
	for <lists+linux-wireless@lfdr.de>; Mon, 15 Apr 2024 01:30:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C46324C81;
	Mon, 15 Apr 2024 01:29:59 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 10D7A4A24
	for <linux-wireless@vger.kernel.org>; Mon, 15 Apr 2024 01:29:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713144599; cv=none; b=X/2h5nuoAKY11VCJUyZ79e2Ge8/H2PBbX79Cq7Q7IKwI4BP+DffX0/ofTVjbIojSrXW0Xp6mTrYIDYznnEURYVVsp/TggoR/8m2ieP6lvM9YBdRa+Dfry0Ay/5bx0TDgAdzT801ucbp1D7MzxAv7cEglrbdpdY02zI+ZRMtkjSg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713144599; c=relaxed/simple;
	bh=FOtXo6pjcpJsDYmerMgzIDZ/90BCAG8OcDwNkzfr+mI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SgeCxHWq3MuiYQKlT0LBl67dc5Pk9OS7LHbj+aAnyXDDju9MxS0ZRXZFLxM8hm2IszGjnzr+8G1TQ3LYUSkdTZJ8DXue2fwEuAE65RmlpCO4p9dK2v6V1c6N1svg50xQyLq9gxBRsnV3GVjuQJsd6E9P4C1Gjj3QiU4lVuiqeLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43F1TW8j8368238, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43F1TW8j8368238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 15 Apr 2024 09:29:32 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 09:29:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 15 Apr 2024 09:29:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 15 Apr 2024 09:29:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v4 03/14] wifi: rtlwifi: Move code from rtl8192de to rtl8192d-common
Thread-Topic: [PATCH v4 03/14] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
Thread-Index: AQHaireXzgCdEBXZYk+tByPyJVjvJrFkMCSQgANskACAAPP+cA==
Date: Mon, 15 Apr 2024 01:29:31 +0000
Message-ID: <b8ac02da49ff472e8eed912bd1cc94ac@realtek.com>
References: <91d932b3-5c72-4416-920e-f2bf4fc9b039@gmail.com>
 <6e18882f-3da3-4c17-8bce-4ebffe022713@gmail.com>
 <c2956068d98142e3b527f1faa94ce2aa@realtek.com>
 <601c4f3c-8069-48ea-aae8-b1e814eba283@gmail.com>
In-Reply-To: <601c4f3c-8069-48ea-aae8-b1e814eba283@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KDQo+IE9u
IDEyLzA0LzIwMjQgMTE6MjIsIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPiBCaXR0ZXJibHVlIFNt
aXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9LY29uZmlnDQo+ID4+IGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL0tjb25maWcNCj4gPj4gaW5kZXgg
OWY2YTRlMzU1NDNjLi4yMzE5ZWFhODg0NWEgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9LY29uZmlnDQo+ID4+ICsrKyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9LY29uZmlnDQo+ID4+IEBAIC0zNyw2ICszNyw3IEBA
IGNvbmZpZyBSVEw4MTkyU0UNCj4gPj4gIGNvbmZpZyBSVEw4MTkyREUNCj4gPj4gICAgICAgICB0
cmlzdGF0ZSAiUmVhbHRlayBSVEw4MTkyREUvUlRMODE4OERFIFBDSWUgV2lyZWxlc3MgTmV0d29y
ayBBZGFwdGVyIg0KPiA+PiAgICAgICAgIGRlcGVuZHMgb24gUENJDQo+ID4+ICsgICAgICAgc2Vs
ZWN0IFJUTDgxOTJEX0NPTU1PTg0KPiA+PiAgICAgICAgIHNlbGVjdCBSVExXSUZJDQo+ID4+ICAg
ICAgICAgc2VsZWN0IFJUTFdJRklfUENJDQo+ID4+ICAgICAgICAgaGVscA0KPiA+PiBAQCAtMTQy
LDYgKzE0MywxMSBAQCBjb25maWcgUlRMODE5MkNfQ09NTU9ODQo+ID4+ICAgICAgICAgZGVwZW5k
cyBvbiBSVEw4MTkyQ0UgfHwgUlRMODE5MkNVDQo+ID4+ICAgICAgICAgZGVmYXVsdCB5DQo+ID4+
DQo+ID4+ICtjb25maWcgUlRMODE5MkRfQ09NTU9ODQo+ID4+ICsgICAgICAgdHJpc3RhdGUNCj4g
Pj4gKyAgICAgICBkZXBlbmRzIG9uIFJUTDgxOTJERQ0KPiA+PiArICAgICAgIGRlZmF1bHQgeQ0K
PiA+PiArDQo+ID4NCj4gPiBFeGlzdGluZyBSVEw4NzIzX0NPTU1PTiBhbHNvIHVzZXMgYm90aCAn
ZGVwZW5kcyBvbicgYW5kICdzZWxlY3QnLCB3aGljaCBhcmUNCj4gPiBtdXR1YWwgcmVmZXJlbmNl
LCBzbyBJIHRoaW5rIGNob29zaW5nIG9ubHkgb25lIG9mIHRoZW0gd291bGQgYmUgYmV0dGVyLg0K
PiA+DQo+ID4+ICBjb25maWcgUlRMODcyM19DT01NT04NCj4gPj4gICAgICAgICB0cmlzdGF0ZQ0K
PiA+PiAgICAgICAgIGRlcGVuZHMgb24gUlRMODcyM0FFIHx8IFJUTDg3MjNCRQ0KPiA+DQo+IA0K
PiBJJ20gbm90IHN1cmUgYWJvdXQgdGhpcy4gSXNuJ3QgdGhlcmUgYSBnb29kIHJlYXNvbiB3aHkg
dGhlDQo+ICJjb21tb24iIGRyaXZlcnMgZG8gaXQgdGhpcyB3YXk/DQo+IA0KPiBbLi4uXQ0KDQpJ
SVJDIHBlb3BsZSBzYWlkIG11dHVhbCByZWZlcmVuY2Ugb2YgJ2RlcGVuZHMgb24nIGFuZCAnc2Vs
ZWN0JyBpc24ndCBnb29kLiANCihJIGNhbid0IGZpbmQgdGhhdCBkaXNjdXNzaW9uLCBzb3JyeS4p
DQoNCkkgdGhpbmsgd2UgY2FuIGFkZCAnc2VsZWN0IFJUTDgxOTJEX0NPTU1PTicgdG8gUlRMODE5
MkRFLCBhbmQNCg0KY29uZmlnIFJUTDgxOTJEX0NPTU1PTg0KCXRyaXN0YXRlDQoJKG5vIG5lZWQg
J2RlcGVuZHMgb24nIGFuZCAnZGVmYXVsdCB5JykNCg0KPiBPa2F5LCBJIGRpZCBhbGwgdGhlIHRo
aW5ncyB5b3UgbWVudGlvbmVkLCBhbmQgYSBiaXQgbW9yZS4NCg0KVGhhbmtzIGZvciBleHRyYSB3
b3Jrcy4gSSBiZWxpZXZlIHRoZXJlIGFyZSBtb3JlIHdvcmtzIHRoYW4gSSBtZW50aW9uZWQuIDop
DQpBbmQsIHRoZXNlIHdvcmtzIHNob3VsZCBiZSB2ZXJpZmllZCBieSByZWFsIGhhcmR3YXJlIGJl
Y2F1c2Ugb2YgbWFueSBjaGFuZ2VzLA0Kc28gSSB0aGluayB0aGlzIGlzIGEgZ29vZCB0aW1lIHRv
IHJlZmluZSB0aGlzIGRyaXZlciwgYmVjYXVzZSB5b3UgYXJlDQp2ZXJpZnlpbmcgbmV3IGhhcmR3
YXJlLg0KDQoNCg==

