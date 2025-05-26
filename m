Return-Path: <linux-wireless+bounces-23401-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id ED796AC3818
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 04:45:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B7E623AD55C
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 02:44:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CFFD717C91;
	Mon, 26 May 2025 02:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="HcqV6O8E"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D801E53BE
	for <linux-wireless@vger.kernel.org>; Mon, 26 May 2025 02:45:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748227515; cv=none; b=j2eNv1RTiIYrKs2ddbfdwf5aob2SMww7+X3/Ke5rqFuOtmxY/R2P6fggE4ZOUjkn6HvTjJNzhsjIVTVjDi7lPaUXrX539eLxVOAVI1ja5l2CI8V+fkp+cwa8FlnBNdv8NWJkqx3B/wSk6Shg4DjVFdXiCpTzw1RVSqBkQVo7xq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748227515; c=relaxed/simple;
	bh=aLokmJT8U7Sz1yBvcZeDIiGLu4SaveTojVGRosdsFfs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=q4FeBB2WN1aJb9FSjepND6kWuoqEXiSIexUnHUbTR1/k2NJea0cNO9FTglgZiyvBqY0tM/AiBCfUXIgxWgTsJidk/kILD0Ssn14NXu8DnylsuoxL+tySxIsySgQtD6aB9d83oMCfXivPND4ixGACK3MRN1PIWT65rd6/PKSU+hU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=HcqV6O8E; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54Q2j9O112934999, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1748227509; bh=aLokmJT8U7Sz1yBvcZeDIiGLu4SaveTojVGRosdsFfs=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=HcqV6O8EqViqEztmeZiDX80CSYPYUyFQrMoz04W65lU1BiJpYxrdS++6Rhwj102lR
	 Gq7M0/0zeo1H1wVEUSnPxrXnMWLPVv/CWpKFtr4J2r1y0LmiZDhQO8si8syyfpnSAt
	 Ei03FNdI1SBJiwqBZBECz1Yvrvk3MYixHdf9MI0l5WbW/8Fd2b/pgxaR9CvswM4FVt
	 WGsmKaJKdnfzcNuDtDO1cZFPLtDFwemdro9ZDI1gE1HmnSLE/Jxde4l4LQVpTTdSGQ
	 hmFrxKB7HGAbxBwt8XKSKDRVnHh8yyKRhG4rEomaz3DO8NyjLDo2xkMMiK3zRodOKD
	 BIckjSIWxAeHg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54Q2j9O112934999
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 10:45:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 May 2025 10:45:09 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 May 2025 10:45:09 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Mon, 26 May 2025 10:45:09 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v1 09/13] wifi: rtw89: Fix rtw89_mac_power_switch() for USB
Thread-Topic: [PATCH rtw-next v1 09/13] wifi: rtw89: Fix
 rtw89_mac_power_switch() for USB
Thread-Index: AQHbvTaHijGDU5ebekWFF2h6IOIwyLPP+F+AgBOHgwCAANR44A==
Date: Mon, 26 May 2025 02:45:08 +0000
Message-ID: <16d3081da058414688043e2a318d2f6a@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <3df912fb-3a56-40d7-940f-c82a23212adc@gmail.com>
 <87a865d6dfc647cd8e14118904cb5d07@realtek.com>
 <2c6d27e3-49bf-4fe8-87ea-4cd9f5b1d4df@gmail.com>
In-Reply-To: <2c6d27e3-49bf-4fe8-87ea-4cd9f5b1d4df@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAx
My8wNS8yMDI1IDA2OjUwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBDbGVhciBzb21lIGJpdHMg
aW4gc29tZSByZWdpc3RlcnMgaW4gb3JkZXIgdG8gYWxsb3cgUlRMODg1MUJVIHRvIHBvd2VyDQo+
ID4+IG9uLiBBbHNvIHRlc3RlZCB3aXRoIFJUTDg4MzJCVSBhbmQgUlRMODgzMkNVLg0KPiA+DQo+
ID4gSSBzZWUgbWFjX3B3cl9vbl9wY2llXzg4NTFiKCkgYW5kIG1hY19wd3Jfb25fdXNiXzg4NTFi
KCkgYXQgbGVhc3QgaW4NCj4gPiB2ZW5kb3IgZHJpdmVyLiBJZiB5b3UgdXNlIHRoZSBwb3dlciBv
bi9vZmYgZnVuY3Rpb25zIGZvciBVU0IgZGV2aWNlcywNCj4gPiB0aGUgcHJvYmxlbSBtYXkgZGlz
YXBwZWFyLg0KPiA+DQo+IA0KPiBJIG1vZGlmaWVkIHJ0dzg4NTFiX3B3cl9vbl9mdW5jKCkgYW5k
IHJ0dzg4NTFiX3B3cl9vZmZfZnVuYygpIHRvIG1hdGNoDQo+IG1hY19wd3Jfb25fdXNiXzg4NTFi
KCkgYW5kIG1hY19wd3Jfb2ZmX3VzYl84ODUxYigpLiBJdCB3YXNuJ3QgZW5vdWdoLg0KDQpUaGUg
dmVuZG9yIGRyaXZlciBkb2VzIGRpZmZlcmVudCB0aGluZ3MgZm9yIFVTQiBhbmQgUENJLCBzbyBw
bGVhc2UgdGFrZQ0KdGhlbSBwbGVhc2UuDQoNCj4gV2l0aG91dCB0aGlzIHBhdGNoIHRoZSBmaXJt
d2FyZSB1cGxvYWQgc3RpbGwgZmFpbHM6DQo+IA0KPiBbIDEyMzguMjk5OTYwXSBydHc4OV84ODUx
YnUgMS0yOjEuMjogRmlybXdhcmUgdmVyc2lvbiAwLjI5LjQxLjMgKDY1Y2VmYjMxKSwgY21kIHZl
cnNpb24gMCwgdHlwZSA1DQo+IFsgMTIzOC4yOTk5NzBdIHJ0dzg5Xzg4NTFidSAxLTI6MS4yOiBG
aXJtd2FyZSB2ZXJzaW9uIDAuMjkuNDEuMyAoNjVjZWZiMzEpLCBjbWQgdmVyc2lvbiAwLCB0eXBl
IDMNCj4gWyAxMjM4LjUyMzE4N10gQmx1ZXRvb3RoOiBoY2kxOiBSVEw6IGZ3IHZlcnNpb24gMHgw
NDhhZDIzMA0KPiBbIDEyMzguNjA3MTEwXSBCbHVldG9vdGg6IGhjaTE6IEFPU1AgZXh0ZW5zaW9u
cyB2ZXJzaW9uIHYxLjAwDQo+IFsgMTIzOC42MjI5ODZdIEJsdWV0b290aDogTUdNVCB2ZXIgMS4y
Mw0KPiBbIDEzODguMTA5MzY0XSBydHc4OV84ODUxYnUgMS0yOjEuMjogW0VSUl1IMkMgcGF0aCBy
ZWFkeQ0KPiBbIDEzODguMTA5NzUxXSBydHc4OV84ODUxYnUgMS0yOjEuMjogW0VSUl1md2RsIDB4
MUUwID0gMHhjMQ0KPiBbIDEzODguMTEwMTE1XSBydHc4OV84ODUxYnUgMS0yOjEuMjogW0VSUl1m
d2RsIDB4ODNGMCA9IDB4MTIwMDkwDQo+IFsgMTM4OC4xMTE2MTVdIHJ0dzg5Xzg4NTFidSAxLTI6
MS4yOiBbRVJSXWZ3IFBDID0gMHhiODkwY2QwNw0KPiBbIDEzODguMTExOTg0XSBydHc4OV84ODUx
YnUgMS0yOjEuMjogW0VSUl1mdyBQQyA9IDB4Yjg5MGNkZTUNCj4gWyAxMzg4LjExMjM1OF0gcnR3
ODlfODg1MWJ1IDEtMjoxLjI6IFtFUlJdZncgUEMgPSAweGI4OTBjZDJiDQo+IFsgMTM4OC4xMTI3
NDBdIHJ0dzg5Xzg4NTFidSAxLTI6MS4yOiBbRVJSXWZ3IFBDID0gMHhiODkwZWYwNQ0KPiBbIDEz
ODguMTEzMTEwXSBydHc4OV84ODUxYnUgMS0yOjEuMjogW0VSUl1mdyBQQyA9IDB4Yjg5MGNkMmIN
Cj4gWyAxMzg4LjExMzUxMF0gcnR3ODlfODg1MWJ1IDEtMjoxLjI6IFtFUlJdZncgUEMgPSAweGI4
OTBjY2UzDQo+IFsgMTM4OC4xMTM4NjhdIHJ0dzg5Xzg4NTFidSAxLTI6MS4yOiBbRVJSXWZ3IFBD
ID0gMHhiODkwY2NlMw0KPiBbIDEzODguMTE0MjM0XSBydHc4OV84ODUxYnUgMS0yOjEuMjogW0VS
Ul1mdyBQQyA9IDB4Yjg5MGNkZWQNCj4gWyAxMzg4LjExNDY5M10gcnR3ODlfODg1MWJ1IDEtMjox
LjI6IFtFUlJdZncgUEMgPSAweGI4OTBjY2UzDQo+IFsgMTM4OC4xMTQ5ODZdIHJ0dzg5Xzg4NTFi
dSAxLTI6MS4yOiBbRVJSXWZ3IFBDID0gMHhiODkwY2NlMw0KPiBbIDEzODguMTE1MzU4XSBydHc4
OV84ODUxYnUgMS0yOjEuMjogW0VSUl1mdyBQQyA9IDB4Yjg5MGNkZTkNCj4gWyAxMzg4LjExNTcz
NV0gcnR3ODlfODg1MWJ1IDEtMjoxLjI6IFtFUlJdZncgUEMgPSAweGI4OTBjY2UzDQo+IFsgMTM4
OC4xMTYxMDldIHJ0dzg5Xzg4NTFidSAxLTI6MS4yOiBbRVJSXWZ3IFBDID0gMHhiODkwY2NlMw0K
PiBbIDEzODguMTE2NDgwXSBydHc4OV84ODUxYnUgMS0yOjEuMjogW0VSUl1mdyBQQyA9IDB4Yjg5
OTU3YjMNCj4gWyAxMzg4LjExNjg2N10gcnR3ODlfODg1MWJ1IDEtMjoxLjI6IFtFUlJdZncgUEMg
PSAweGI4OTBjY2UzDQo+IA0KPiAoQnkgdGhlIHdheSwgMTUwIHNlY29uZHMgaXMgYSBsb25nIHRp
bWUgYW5kIHRoaXMgaXMganVzdCB0aGUgZmlyc3QgYmF0Y2gNCj4gb2YgZXJyb3IgbWVzc2FnZXMu
IFRoZXJlIGFyZSBhdCBsZWFzdCB0d28gbW9yZSBsaWtlIHRoZSBhYm92ZSBhbmQgZWFjaA0KPiB0
YWtlcyBhbm90aGVyIDE1MCBzZWNvbmRzIHRvIGFwcGVhci4gVGhpbmdzIGZyZWV6ZToNCj4gDQo+
IFsgMTQ3NS42OTM0NTRdIElORk86IHRhc2sgc3lzdGVtZC1qb3VybmFsOjI4NCBibG9ja2VkIGZv
ciBtb3JlIHRoYW4gMTIyIHNlY29uZHMuDQo+IFsgMTQ3NS42OTM3NTBdIElORk86IHRhc2sga2Rl
ZDY6ODUzIGJsb2NrZWQgZm9yIG1vcmUgdGhhbiAxMjIgc2Vjb25kcy4NCj4gWyAxNTk4LjU3Mzc3
Ml0gSU5GTzogdGFzayB1cG93ZXJkOjEwMjEgYmxvY2tlZCBmb3IgbW9yZSB0aGFuIDEyMiBzZWNv
bmRzLg0KPiANCj4gSSBoYXZlbid0IGZpZ3VyZWQgb3V0IGhvdyB0byBmaXggdGhpcyBsb25nIGRl
bGF5IHlldC4pDQo+IA0KPiA+Pg0KPiA+PiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRo
IDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCj4gPj4gLS0tDQo+ID4+ICBkcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0dzg5L21hYy5jIHwgOCArKysrKysrKw0KPiA+PiAgZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9yZWcuaCB8IDEgKw0KPiA+PiAgMiBmaWxlcyBjaGFu
Z2VkLCA5IGluc2VydGlvbnMoKykNCj4gPj4NCj4gPj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0dzg5L21hYy5jDQo+ID4+IGluZGV4IDk5ZjAxZmZmOTBmZS4uZDNjZjY3ZGZhYmM5IDEw
MDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L21hYy5j
DQo+ID4+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMNCj4g
Pj4gQEAgLTE0NTgsNiArMTQ1OCwxNCBAQCBzdGF0aWMgaW50IHJ0dzg5X21hY19wb3dlcl9zd2l0
Y2goc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LCBib29sIG9uKQ0KPiA+PiAgICAgICAgIGludCBy
ZXQ7DQo+ID4+ICAgICAgICAgdTggdmFsOw0KPiA+Pg0KPiA+PiArICAgICAgIGlmIChydHdkZXYt
PmhjaS50eXBlID09IFJUVzg5X0hDSV9UWVBFX1VTQiAmJg0KPiA+PiArICAgICAgICAgICBydHc4
OV9yZWFkMzJfbWFzayhydHdkZXYsIFJfQVhfR1BJT19NVVhDRkcsIEJfQVhfQk9PVF9NT0RFKSkg
ew0KPiA+DQo+ID4gTm90IHByZWZlciBjYWxsaW5nIGEgZnVuY3Rpb24gaW4gaWYtc3RhdGVtZW50
LiBTdWdnZXN0IHRvIGFkZCBhIGZ1bmN0aW9uLg0KPiA+DQo+IA0KPiBEbyB5b3UgbWVhbiBhZGQg
YSB2YXJpYWJsZT8NCj4gDQo+ICAgICAgICAgYm9vdF9tb2RlID0gcnR3ODlfcmVhZDMyX21hc2so
cnR3ZGV2LCBSX0FYX0dQSU9fTVVYQ0ZHLCBCX0FYX0JPT1RfTU9ERSk7DQo+IA0KPiAgICAgICAg
IGlmIChydHdkZXYtPmhjaS50eXBlID09IFJUVzg5X0hDSV9UWVBFX1VTQiAmJiBib290X21vZGUp
IHsNCg0KWWVzLiBJIHByZWZlciB0aGlzLiBCdXQgSSBrbmV3IG9yaWdpbmFsbHkgeW91IHdvdWxk
IG5vdCBkbyB0aGUgSU8gYmVmb3JlDQpjaGVja2luZyBIQ0kgdHlwZS4gU28sIEkgc3VnZ2VzdGVk
IHRvIGFkZCBhIGZ1bmN0aW9uIGxpa2UgDQoodGhlIG5hbWluZyBpcyBub3QgZ29vZCB0aG91Z2gp
DQoNCnZvaWQgcnR3ODlfbWFjX3Bvd2VyX3N3aXRjaF9oY2kocnR3ZGV2LCAuLi4pDQp7DQogICAg
aWYgKCFVU0IpDQogICAgICAgIHJldHVybjsNCg0KICAgIHZhbCA9IHJ0dzg5X3JlYWQzMl9tYXNr
KHJ0d2RldiwgUl9BWF9HUElPX01VWENGRywgQl9BWF9CT09UX01PREUpKTsNCiAgICBpZiAoIXZh
bCkNCiAgICAgICAgcmV0dXJuOw0KDQogICAgLy8gZG8gdGhlIElPIHlvdSB3YW50LiANCn0NCg0K
PiANCj4gDQo+ID4+ICsgICAgICAgICAgICAgICBydHc4OV93cml0ZTMyX2NscihydHdkZXYsIFJf
QVhfU1lTX1BXX0NUUkwsIEJfQVhfQVBGTl9PTk1BQyk7DQo+ID4+ICsgICAgICAgICAgICAgICBy
dHc4OV93cml0ZTMyX2NscihydHdkZXYsIFJfQVhfU1lTX1NUQVRVUzEsIEJfQVhfQVVUT19XTFBP
Tik7DQo+ID4+ICsgICAgICAgICAgICAgICBydHc4OV93cml0ZTMyX2NscihydHdkZXYsIFJfQVhf
R1BJT19NVVhDRkcsIEJfQVhfQk9PVF9NT0RFKTsNCj4gPj4gKyAgICAgICAgICAgICAgIHJ0dzg5
X3dyaXRlMzJfY2xyKHJ0d2RldiwgUl9BWF9SU1ZfQ1RSTCwgQl9BWF9SX0RJU19QUlNUKTsNCj4g
Pj4gKyAgICAgICB9DQo+ID4+ICsNCj4gPj4gICAgICAgICBpZiAob24pIHsNCj4gPj4gICAgICAg
ICAgICAgICAgIGNmZ19zZXEgPSBjaGlwLT5wd3Jfb25fc2VxOw0KPiA+PiAgICAgICAgICAgICAg
ICAgY2ZnX2Z1bmMgPSBjaGlwLT5vcHMtPnB3cl9vbl9mdW5jOw0KPiA+DQoNCg==

