Return-Path: <linux-wireless+bounces-20982-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8B2AAA75E89
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 07:35:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BB0CE18884BC
	for <lists+linux-wireless@lfdr.de>; Mon, 31 Mar 2025 05:35:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D770829CEB;
	Mon, 31 Mar 2025 05:35:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="X+XsQ74l"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 274BABE67
	for <linux-wireless@vger.kernel.org>; Mon, 31 Mar 2025 05:35:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743399345; cv=none; b=W4spGCy2d5xujNUKugIQYmeiYYfkspLqZqlWB0C3J3ufzmY6eeroGVS7iNWDx6AdjZuyg4M2m7Xxr/4rWzqVl8AGnf8xt6ggoire3T5ycrso09rnwGQzXPKRv7Km/CFCBjI686Z0Tt1PERpkXMIzynr7Bcs86Dj7AvSdgN7MXZg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743399345; c=relaxed/simple;
	bh=XGc5F/qevF0rT4h2uU/qsVaUOyDrE4ow+XFcYs9tTNA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=spzllS//0W7z3n1gZT30CAY5Zvbhpnk9cGhHPs9QczSnKbDRHFdHrAmUVxmEPNGeCOs9ZsbNj+sro3U/HKt3N2KkakEGhTrSKJqnL47VRBr1nMu1PaIFNNyd0riC0XanMSKqEKU7RuacPzM7LQf+Xuqc9DpNaL9LV1VJGnDDCZs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=X+XsQ74l; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52V5ZWBm82840460, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1743399332; bh=XGc5F/qevF0rT4h2uU/qsVaUOyDrE4ow+XFcYs9tTNA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=X+XsQ74lrk2N+Xjs0HHvSqQHJmX7XFI1Mx+SHhXq0n3E0yTx0ceuRogmFKbJvyVFi
	 AJvWgTJduyjoS5TYsgjCHCdDPz/Qq92u2IlkD7GgzqJP3Gg7Rz4CiB9pIptHpoIN1G
	 a7762Nbw4dpNPjarEi64ouUTEpmOTeaguNxAwtlGhd1Ppk5VSBi1AO4LdK2ArkZYR6
	 hVEUFclMN/Ed9oyIvYH61Na8x2AphbqYBUqsxGNF7Cy+U3FX6jFAHcPmKDzqNknCAk
	 o/YtJdPMD4Ox1/N65FUB60PUMaL4FBBK69PB7kcAfQu1HnWb35TQgferdU/EQlNXTi
	 wV4DPy8XGqWtw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52V5ZWBm82840460
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 31 Mar 2025 13:35:32 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 31 Mar 2025 13:35:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 31 Mar 2025 13:35:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 31 Mar 2025 13:35:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 4/4] wifi: rtw88: Don't set SUPPORTS_AMSDU_IN_AMPDU for RTL8814AU
Thread-Topic: [PATCH rtw-next v2 4/4] wifi: rtw88: Don't set
 SUPPORTS_AMSDU_IN_AMPDU for RTL8814AU
Thread-Index: AQHboYQOxlRzI0IMskatNGD0/Ef1PLOMukiA
Date: Mon, 31 Mar 2025 05:35:32 +0000
Message-ID: <3d69613c91344bbda23aea2823e5a6be@realtek.com>
References: <5ccba1b8-d7de-4158-bc9a-0aa465f1b2df@gmail.com>
 <6aee626f-586b-4f71-b79a-cf1446834f5f@gmail.com>
In-Reply-To: <6aee626f-586b-4f71-b79a-cf1446834f5f@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBSVEw4
ODE0QVUgZG9lc24ndCB3b3JrIHdlbGwgd2l0aCBTVVBQT1JUU19BTVNEVV9JTl9BTVBEVS4gVGhl
IFJYIHNwZWVkDQo+IGlzIG5vdGljZWFibHkgbG93ZXIgYW5kIHRoZSBWSFQgUlggc3RhdGlzdGlj
cyBhcmUgc3RyYW5nZS4gVHlwaWNhbA0KPiB2YWx1ZXMgd2l0aCBTVVBQT1JUU19BTVNEVV9JTl9B
TVBEVToNCj4gDQo+IFJldmVyc2UgbW9kZSwgcmVtb3RlIGhvc3QgMTkyLjE2OC4wLjEgaXMgc2Vu
ZGluZw0KPiBbICA1XSBsb2NhbCAxOTIuMTY4LjAuNTAgcG9ydCA2MDcxMCBjb25uZWN0ZWQgdG8g
MTkyLjE2OC4wLjEgcG9ydCA1MjAxDQo+IFsgSURdIEludGVydmFsICAgICAgICAgICBUcmFuc2Zl
ciAgICAgQml0cmF0ZQ0KPiBbICA1XSAgIDAuMDAtMS4wMCAgIHNlYyAgNzQuNiBNQnl0ZXMgICA2
MjYgTWJpdHMvc2VjDQo+IFsgIDVdICAgMS4wMC0yLjAwICAgc2VjICA3OS4yIE1CeXRlcyAgIDY2
NSBNYml0cy9zZWMNCj4gWyAgNV0gICAyLjAwLTMuMDAgICBzZWMgIDg0LjkgTUJ5dGVzICAgNzEy
IE1iaXRzL3NlYw0KPiBbICA1XSAgIDMuMDAtNC4wMCAgIHNlYyAgODMuOCBNQnl0ZXMgICA3MDMg
TWJpdHMvc2VjDQo+IFsgIDVdICAgNC4wMC01LjAwICAgc2VjICA4NS45IE1CeXRlcyAgIDcyMCBN
Yml0cy9zZWMNCj4gWyAgNV0gICA1LjAwLTYuMDAgICBzZWMgIDc4LjkgTUJ5dGVzICAgNjYyIE1i
aXRzL3NlYw0KPiBbICA1XSAgIDYuMDAtNy4wMCAgIHNlYyAgODEuMiBNQnl0ZXMgICA2ODIgTWJp
dHMvc2VjDQo+IFsgIDVdICAgNy4wMC04LjAwICAgc2VjICA4MC41IE1CeXRlcyAgIDY3NSBNYml0
cy9zZWMNCj4gWyAgNV0gICA4LjAwLTkuMDAgICBzZWMgIDc5LjQgTUJ5dGVzICAgNjY2IE1iaXRz
L3NlYw0KPiBbICA1XSAgIDkuMDAtMTAuMDAgIHNlYyAgODIuMiBNQnl0ZXMgICA2ODkgTWJpdHMv
c2VjDQo+IFsgIDVdICAxMC4wMC0xMS4wMCAgc2VjICA4Mi4wIE1CeXRlcyAgIDY4OCBNYml0cy9z
ZWMNCj4gWyAgNV0gIDExLjAwLTEyLjAwICBzZWMgIDg0LjIgTUJ5dGVzICAgNzA3IE1iaXRzL3Nl
Yw0KPiBbICA1XSAgMTIuMDAtMTMuMDAgIHNlYyAgNzEuMCBNQnl0ZXMgICA1OTYgTWJpdHMvc2Vj
DQo+IFsgIDVdICAxMy4wMC0xNC4wMCAgc2VjICA2OS40IE1CeXRlcyAgIDU4MiBNYml0cy9zZWMN
Cj4gWyAgNV0gIDE0LjAwLTE1LjAwICBzZWMgIDgwLjIgTUJ5dGVzICAgNjczIE1iaXRzL3NlYw0K
PiBbICA1XSAgMTUuMDAtMTYuMDAgIHNlYyAgNzQuNSBNQnl0ZXMgICA2MjUgTWJpdHMvc2VjDQo+
IA0KPiBbUnggQ291bnRlcl06DQo+ICAqIENDQSAoQ0NLLCBPRkRNLCBUb3RhbCkgPSAoMCwgMjQ1
NSwgMjQ1NSkNCj4gICogRmFsc2UgQWxhcm0gKENDSywgT0ZETSwgVG90YWwpID0gKDAsIDY5LCA2
OSkNCj4gICogQ0NLIGNudCAob2ssIGVycikgPSAoMCwgMCkNCj4gICogT0ZETSBjbnQgKG9rLCBl
cnIpID0gKDEyMzksIDIpDQo+ICAqIEhUIGNudCAob2ssIGVycikgPSAoMCwgMCkNCj4gICogVkhU
IGNudCAob2ssIGVycikgPSAoMjEsIDEyMTA5KQ0KPiANCj4gVGhlICJWSFQgb2siIG51bWJlciBp
cyBub3QgYmVsaWV2YWJsZS4NCj4gDQo+IEFuZCB3aXRob3V0IFNVUFBPUlRTX0FNU0RVX0lOX0FN
UERVOg0KPiANCj4gUmV2ZXJzZSBtb2RlLCByZW1vdGUgaG9zdCAxOTIuMTY4LjAuMSBpcyBzZW5k
aW5nDQo+IFsgIDVdIGxvY2FsIDE5Mi4xNjguMC41MCBwb3J0IDUwMDMwIGNvbm5lY3RlZCB0byAx
OTIuMTY4LjAuMSBwb3J0IDUyMDENCj4gWyBJRF0gSW50ZXJ2YWwgICAgICAgICAgIFRyYW5zZmVy
ICAgICBCaXRyYXRlDQo+IFsgIDVdICAgMC4wMC0xLjAwICAgc2VjICA3MC41IE1CeXRlcyAgIDU5
MSBNYml0cy9zZWMNCj4gWyAgNV0gICAxLjAwLTIuMDAgICBzZWMgIDg2LjkgTUJ5dGVzICAgNzI5
IE1iaXRzL3NlYw0KPiBbICA1XSAgIDIuMDAtMy4wMCAgIHNlYyAgOTguNiBNQnl0ZXMgICA4Mjcg
TWJpdHMvc2VjDQo+IFsgIDVdICAgMy4wMC00LjAwICAgc2VjICA5Ny40IE1CeXRlcyAgIDgxNyBN
Yml0cy9zZWMNCj4gWyAgNV0gICA0LjAwLTUuMDAgICBzZWMgIDk4LjYgTUJ5dGVzICAgODI3IE1i
aXRzL3NlYw0KPiBbICA1XSAgIDUuMDAtNi4wMCAgIHNlYyAgOTYuOSBNQnl0ZXMgICA4MTMgTWJp
dHMvc2VjDQo+IFsgIDVdICAgNi4wMC03LjAwICAgc2VjICA5OC4yIE1CeXRlcyAgIDgyNCBNYml0
cy9zZWMNCj4gWyAgNV0gICA3LjAwLTguMDAgICBzZWMgIDk4LjAgTUJ5dGVzICAgODIyIE1iaXRz
L3NlYw0KPiBbICA1XSAgIDguMDAtOS4wMCAgIHNlYyAgOTkuOSBNQnl0ZXMgICA4MzggTWJpdHMv
c2VjDQo+IFsgIDVdICAgOS4wMC0xMC4wMCAgc2VjICA5OS4yIE1CeXRlcyAgIDgzMyBNYml0cy9z
ZWMNCj4gWyAgNV0gIDEwLjAwLTExLjAwICBzZWMgIDk4LjAgTUJ5dGVzICAgODIyIE1iaXRzL3Nl
Yw0KPiBbICA1XSAgMTEuMDAtMTIuMDAgIHNlYyAgOTguMSBNQnl0ZXMgICA4MjMgTWJpdHMvc2Vj
DQo+IFsgIDVdICAxMi4wMC0xMy4wMCAgc2VjICA5Ny4wIE1CeXRlcyAgIDgxNCBNYml0cy9zZWMN
Cj4gWyAgNV0gIDEzLjAwLTE0LjAwICBzZWMgIDk4LjIgTUJ5dGVzICAgODI0IE1iaXRzL3NlYw0K
PiBbICA1XSAgMTQuMDAtMTUuMDAgIHNlYyAgOTguNSBNQnl0ZXMgICA4MjYgTWJpdHMvc2VjDQo+
IFsgIDVdICAxNS4wMC0xNi4wMCAgc2VjICA5Ny40IE1CeXRlcyAgIDgxNyBNYml0cy9zZWMNCj4g
DQo+IFtSeCBDb3VudGVyXToNCj4gICogQ0NBIChDQ0ssIE9GRE0sIFRvdGFsKSA9ICgwLCAzODYw
LCAzODYwKQ0KPiAgKiBGYWxzZSBBbGFybSAoQ0NLLCBPRkRNLCBUb3RhbCkgPSAoMCwgMiwgMikN
Cj4gICogQ0NLIGNudCAob2ssIGVycikgPSAoMCwgMCkNCj4gICogT0ZETSBjbnQgKG9rLCBlcnIp
ID0gKDE0ODYsIDApDQo+ICAqIEhUIGNudCAob2ssIGVycikgPSAoMCwgMCkNCj4gICogVkhUIGNu
dCAob2ssIGVycikgPSAoNzM5OSwgOTExOCkNCj4gDQo+IEFkZCBhIG5ldyBtZW1iZXIgImFtc2R1
X2luX2FtcGR1IiBpbiBzdHJ1Y3QgcnR3X2NoaXBfaW5mbyBhbmQgdXNlIGl0DQo+IHRvIHNldCBT
VVBQT1JUU19BTVNEVV9JTl9BTVBEVSBvbmx5IGZvciB0aGUgb3RoZXIgY2hpcHMuDQo+IA0KPiBT
aWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4N
Cg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQoNCg==

