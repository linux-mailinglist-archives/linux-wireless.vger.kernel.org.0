Return-Path: <linux-wireless+bounces-20418-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C3C1A63D35
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 04:31:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 751A43AC5BC
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Mar 2025 03:31:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB4AA20E716;
	Mon, 17 Mar 2025 03:31:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="KrKiEtGM"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6F920E330
	for <linux-wireless@vger.kernel.org>; Mon, 17 Mar 2025 03:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742182280; cv=none; b=f/EvkVf/8SX+SU9AeIpdik7xCA1yLsEqhHEedD5XxC0zx8Beuc5Q5owfX+NLCjEpTlDv8idA0N4pYCwoQNC4mQ4uR6+G5IfJYxU6BlpS3k5Kt8rY6mrXuWgX4eoVSEPxhh40tLdW8J2gJYaPrdBvlDJzPbW3tFvGIIcRvjBt3q0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742182280; c=relaxed/simple;
	bh=mkfBSgXJ7bD38Rdv01L3+LV3+g8OiauvkQOQZq+owKE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DwANcuoLZtbeFIRUozN23OokrItoXFjd9bpDo4isFxI5ANwCjnoG6hwlExg4FY+zcmYeGHWhR+tNFcVmM824xmBHdBgWjzRR8PLw/FIoqUbcWHWi1JOJnyxiZB15gJ2d5t9UnSe1DmEEV7OwTDBAgZDfsjz+rWrp7qAIIRJVlRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=KrKiEtGM; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52H3VCkM44038693, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742182272; bh=mkfBSgXJ7bD38Rdv01L3+LV3+g8OiauvkQOQZq+owKE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=KrKiEtGM7n0KJmnGOla1TqYVIMOWXqK5gdvHLaCPMJ0m7N8zYdeKhnSBi4f8O2YFc
	 khRoNTAPV5WRL/AM+VwrRDtuc7z8qRdadgZnxUxFKqP4g2eMHvO54csKmm1vX/1TYr
	 6fXbu2o8skRRVwgAQr0S7gNCA4agPb2h+7SMI5j4n7Ha5DUcpVncz4rAiHO04ei75q
	 7eCM1/blqvb1wzSQOSro+NPPXX+w5Et4s4TIP9Q1SOyBOr92l75sKRh0knV0LeWjFf
	 M/jj5tvFQEHBmGOLnaIdrnoySft3fu1VtEDzrOA7w+25nqpAQ6A+3Lih8qF2G1lFrA
	 pIxfYbjujFNig==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52H3VCkM44038693
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Mar 2025 11:31:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 17 Mar 2025 11:31:12 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 17 Mar 2025 11:31:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 17 Mar 2025 11:31:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 4/4] wifi: rtw88: Don't set SUPPORTS_AMSDU_IN_AMPDU for RTL8814AU
Thread-Topic: [PATCH rtw-next 4/4] wifi: rtw88: Don't set
 SUPPORTS_AMSDU_IN_AMPDU for RTL8814AU
Thread-Index: AQHblFVTsY1ZPYlUGke6ihisvz+yqrN2qZZg
Date: Mon, 17 Mar 2025 03:31:11 +0000
Message-ID: <003857401c0245d7aa9a29c8806cb558@realtek.com>
References: <c845ff10-08d9-4057-8f54-1579a548788d@gmail.com>
 <9f9a16a3-d326-4f48-9853-134751b63864@gmail.com>
In-Reply-To: <9f9a16a3-d326-4f48-9853-134751b63864@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBTZW50
OiBGcmlkYXksIE1hcmNoIDE0LCAyMDI1IDQ6MjAgQU0NCj4gUlRMODgxNEFVIGRvZXNuJ3Qgd29y
ayB3ZWxsIHdpdGggU1VQUE9SVFNfQU1TRFVfSU5fQU1QRFUuIFRoZSBSWCBzcGVlZA0KPiBpcyBu
b3RpY2VhYmx5IGxvd2VyIGFuZCB0aGUgVkhUIFJYIHN0YXRpc3RpY3MgYXJlIHN0cmFuZ2UuIFR5
cGljYWwNCj4gdmFsdWVzIHdpdGggU1VQUE9SVFNfQU1TRFVfSU5fQU1QRFU6DQo+IA0KPiBSZXZl
cnNlIG1vZGUsIHJlbW90ZSBob3N0IDE5Mi4xNjguMC4xIGlzIHNlbmRpbmcNCj4gWyAgNV0gbG9j
YWwgMTkyLjE2OC4wLjUwIHBvcnQgNjA3MTAgY29ubmVjdGVkIHRvIDE5Mi4xNjguMC4xIHBvcnQg
NTIwMQ0KPiBbIElEXSBJbnRlcnZhbCAgICAgICAgICAgVHJhbnNmZXIgICAgIEJpdHJhdGUNCj4g
WyAgNV0gICAwLjAwLTEuMDAgICBzZWMgIDc0LjYgTUJ5dGVzICAgNjI2IE1iaXRzL3NlYw0KPiBb
ICA1XSAgIDEuMDAtMi4wMCAgIHNlYyAgNzkuMiBNQnl0ZXMgICA2NjUgTWJpdHMvc2VjDQo+IFsg
IDVdICAgMi4wMC0zLjAwICAgc2VjICA4NC45IE1CeXRlcyAgIDcxMiBNYml0cy9zZWMNCj4gWyAg
NV0gICAzLjAwLTQuMDAgICBzZWMgIDgzLjggTUJ5dGVzICAgNzAzIE1iaXRzL3NlYw0KPiBbICA1
XSAgIDQuMDAtNS4wMCAgIHNlYyAgODUuOSBNQnl0ZXMgICA3MjAgTWJpdHMvc2VjDQo+IFsgIDVd
ICAgNS4wMC02LjAwICAgc2VjICA3OC45IE1CeXRlcyAgIDY2MiBNYml0cy9zZWMNCj4gWyAgNV0g
ICA2LjAwLTcuMDAgICBzZWMgIDgxLjIgTUJ5dGVzICAgNjgyIE1iaXRzL3NlYw0KPiBbICA1XSAg
IDcuMDAtOC4wMCAgIHNlYyAgODAuNSBNQnl0ZXMgICA2NzUgTWJpdHMvc2VjDQo+IFsgIDVdICAg
OC4wMC05LjAwICAgc2VjICA3OS40IE1CeXRlcyAgIDY2NiBNYml0cy9zZWMNCj4gWyAgNV0gICA5
LjAwLTEwLjAwICBzZWMgIDgyLjIgTUJ5dGVzICAgNjg5IE1iaXRzL3NlYw0KPiBbICA1XSAgMTAu
MDAtMTEuMDAgIHNlYyAgODIuMCBNQnl0ZXMgICA2ODggTWJpdHMvc2VjDQo+IFsgIDVdICAxMS4w
MC0xMi4wMCAgc2VjICA4NC4yIE1CeXRlcyAgIDcwNyBNYml0cy9zZWMNCj4gWyAgNV0gIDEyLjAw
LTEzLjAwICBzZWMgIDcxLjAgTUJ5dGVzICAgNTk2IE1iaXRzL3NlYw0KPiBbICA1XSAgMTMuMDAt
MTQuMDAgIHNlYyAgNjkuNCBNQnl0ZXMgICA1ODIgTWJpdHMvc2VjDQo+IFsgIDVdICAxNC4wMC0x
NS4wMCAgc2VjICA4MC4yIE1CeXRlcyAgIDY3MyBNYml0cy9zZWMNCj4gWyAgNV0gIDE1LjAwLTE2
LjAwICBzZWMgIDc0LjUgTUJ5dGVzICAgNjI1IE1iaXRzL3NlYw0KPiANCj4gW1J4IENvdW50ZXJd
Og0KPiAgKiBDQ0EgKENDSywgT0ZETSwgVG90YWwpID0gKDAsIDI0NTUsIDI0NTUpDQo+ICAqIEZh
bHNlIEFsYXJtIChDQ0ssIE9GRE0sIFRvdGFsKSA9ICgwLCA2OSwgNjkpDQo+ICAqIENDSyBjbnQg
KG9rLCBlcnIpID0gKDAsIDApDQo+ICAqIE9GRE0gY250IChvaywgZXJyKSA9ICgxMjM5LCAyKQ0K
PiAgKiBIVCBjbnQgKG9rLCBlcnIpID0gKDAsIDApDQo+ICAqIFZIVCBjbnQgKG9rLCBlcnIpID0g
KDIxLCAxMjEwOSkNCj4gDQo+IFRoZSAiVkhUIG9rIiBudW1iZXIgaXMgbm90IGJlbGlldmFibGUu
DQoNClNpbmNlIHRoZXNlIGNvdW50ZXJzIGFyZSBmcm9tIEJCLCBJIGRvbid0IGRvdWJ0IHRoaXMg
aXMgVVNCIHNwZWNpZmljIHByb2JsZW0uDQpCdXQgcmVhbGx5IG5vdCBzdXJlIHdoYXQgQkIgaGFw
cGVucyBvbiByZWNlaXZpbmcgbG9uZyBwYWNrZXRzLg0KU28sIGxldCdzIHRha2UgdGhpcyB3b3Jr
YXJvdW5kIHRoYXQgaW1wcm92ZXMgb3ZlciAxMDBNYml0cy9zZWMuDQoNCj4gDQo+IEFuZCB3aXRo
b3V0IFNVUFBPUlRTX0FNU0RVX0lOX0FNUERVOg0KPiANCj4gUmV2ZXJzZSBtb2RlLCByZW1vdGUg
aG9zdCAxOTIuMTY4LjAuMSBpcyBzZW5kaW5nDQo+IFsgIDVdIGxvY2FsIDE5Mi4xNjguMC41MCBw
b3J0IDUwMDMwIGNvbm5lY3RlZCB0byAxOTIuMTY4LjAuMSBwb3J0IDUyMDENCj4gWyBJRF0gSW50
ZXJ2YWwgICAgICAgICAgIFRyYW5zZmVyICAgICBCaXRyYXRlDQo+IFsgIDVdICAgMC4wMC0xLjAw
ICAgc2VjICA3MC41IE1CeXRlcyAgIDU5MSBNYml0cy9zZWMNCj4gWyAgNV0gICAxLjAwLTIuMDAg
ICBzZWMgIDg2LjkgTUJ5dGVzICAgNzI5IE1iaXRzL3NlYw0KPiBbICA1XSAgIDIuMDAtMy4wMCAg
IHNlYyAgOTguNiBNQnl0ZXMgICA4MjcgTWJpdHMvc2VjDQo+IFsgIDVdICAgMy4wMC00LjAwICAg
c2VjICA5Ny40IE1CeXRlcyAgIDgxNyBNYml0cy9zZWMNCj4gWyAgNV0gICA0LjAwLTUuMDAgICBz
ZWMgIDk4LjYgTUJ5dGVzICAgODI3IE1iaXRzL3NlYw0KPiBbICA1XSAgIDUuMDAtNi4wMCAgIHNl
YyAgOTYuOSBNQnl0ZXMgICA4MTMgTWJpdHMvc2VjDQo+IFsgIDVdICAgNi4wMC03LjAwICAgc2Vj
ICA5OC4yIE1CeXRlcyAgIDgyNCBNYml0cy9zZWMNCj4gWyAgNV0gICA3LjAwLTguMDAgICBzZWMg
IDk4LjAgTUJ5dGVzICAgODIyIE1iaXRzL3NlYw0KPiBbICA1XSAgIDguMDAtOS4wMCAgIHNlYyAg
OTkuOSBNQnl0ZXMgICA4MzggTWJpdHMvc2VjDQo+IFsgIDVdICAgOS4wMC0xMC4wMCAgc2VjICA5
OS4yIE1CeXRlcyAgIDgzMyBNYml0cy9zZWMNCj4gWyAgNV0gIDEwLjAwLTExLjAwICBzZWMgIDk4
LjAgTUJ5dGVzICAgODIyIE1iaXRzL3NlYw0KPiBbICA1XSAgMTEuMDAtMTIuMDAgIHNlYyAgOTgu
MSBNQnl0ZXMgICA4MjMgTWJpdHMvc2VjDQo+IFsgIDVdICAxMi4wMC0xMy4wMCAgc2VjICA5Ny4w
IE1CeXRlcyAgIDgxNCBNYml0cy9zZWMNCj4gWyAgNV0gIDEzLjAwLTE0LjAwICBzZWMgIDk4LjIg
TUJ5dGVzICAgODI0IE1iaXRzL3NlYw0KPiBbICA1XSAgMTQuMDAtMTUuMDAgIHNlYyAgOTguNSBN
Qnl0ZXMgICA4MjYgTWJpdHMvc2VjDQo+IFsgIDVdICAxNS4wMC0xNi4wMCAgc2VjICA5Ny40IE1C
eXRlcyAgIDgxNyBNYml0cy9zZWMNCj4gDQo+IFtSeCBDb3VudGVyXToNCj4gICogQ0NBIChDQ0ss
IE9GRE0sIFRvdGFsKSA9ICgwLCAzODYwLCAzODYwKQ0KPiAgKiBGYWxzZSBBbGFybSAoQ0NLLCBP
RkRNLCBUb3RhbCkgPSAoMCwgMiwgMikNCj4gICogQ0NLIGNudCAob2ssIGVycikgPSAoMCwgMCkN
Cj4gICogT0ZETSBjbnQgKG9rLCBlcnIpID0gKDE0ODYsIDApDQo+ICAqIEhUIGNudCAob2ssIGVy
cikgPSAoMCwgMCkNCj4gICogVkhUIGNudCAob2ssIGVycikgPSAoNzM5OSwgOTExOCkNCj4gDQo+
IEFkZCBhIG5ldyBtZW1iZXIgImFtc2R1X2luX2FtcGR1IiBpbiBzdHJ1Y3QgcnR3X2NoaXBfaW5m
byBhbmQgdXNlIGl0DQo+IHRvIHNldCBTVVBQT1JUU19BTVNEVV9JTl9BTVBEVSBvbmx5IGZvciB0
aGUgb3RoZXIgY2hpcHMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxy
dGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGlo
QHJlYWx0ZWsuY29tPg0KDQoNCg==

