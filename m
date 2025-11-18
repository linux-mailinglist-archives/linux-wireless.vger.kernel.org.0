Return-Path: <linux-wireless+bounces-29068-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id B623CC66FF9
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 03:18:16 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id F334A4E10E8
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Nov 2025 02:17:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D9CF1946C;
	Tue, 18 Nov 2025 02:17:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="kPEGFe8V"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9710F9E8
	for <linux-wireless@vger.kernel.org>; Tue, 18 Nov 2025 02:17:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763432271; cv=none; b=RPwIFA82CZXVGMI3NpVKdep2INjtaQ/M0dj2RjN4e3nB/j/5quSQt3QsSCcOVG3QrrRPQUgcuKNwR34rarvHu1YkraLGUC0zOW+GILBpAEGw+fGv/jj/fOQF5r5W5Xt97z+IoiEcSz0SGE2/jTgJM7KlBBwX/FppWuLENi1dvu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763432271; c=relaxed/simple;
	bh=cFS3rYKQ3FSm4wwB4u0tnIqW4zB4GAksV2EiACXQqLE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qgBy2+8mPheuFdyVS/8I2SLYdJGWMJWBUM1eHc7s8IIzqOexmPj+7pDBkpiPGwcHv3TqOyU3//ANbXDGv+yIjffWCr6/RO6RBx+VXe3ZWmK73RUENlbR3ObiWJBJ1KC5Wfsy/0Up2yK68JDpZ63jdOwdwBLgZ2PvBVmtZT6IgPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=kPEGFe8V; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AI2HjdR6629313, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763432265; bh=cFS3rYKQ3FSm4wwB4u0tnIqW4zB4GAksV2EiACXQqLE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=kPEGFe8VQNbHRFDhFNz1MvIsUWZPaJ7IOk25BLODOcr1gn/7EjqSPAgIGqCiT2+Uy
	 GrDax0TPtAY/Gh14AjsDh8ij+6WogiLkPWMy4kh52pNbvqMJvz4ZKHS3pAMqJAv7yC
	 DhjRBXFoEL7cSbbEHkl/+R/eONuzT+QVRQOmhTP0zZSne9eOjqldAFywdnVw7nOcR6
	 2UhCe+2hcpS2kJ7srt+kE8aE+TO7z7dKBQfYw9lghyvKZ6adJDmJd7tJHNnIAgyEsj
	 fp/yk6uwoHJedPgNkzV+gzhsQJzbmpmG9chJKNE0jsMW9QehOZA5BX4nGWBUCGPUme
	 0wWnQ/m9k9pqw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AI2HjdR6629313
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Nov 2025 10:17:45 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 18 Nov 2025 10:17:45 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Tue, 18 Nov 2025 10:17:44 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Tue, 18 Nov 2025 10:17:44 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw] wifi: rtw89: hw_scan: Don't let the operating channel
 be last
Thread-Topic: [PATCH rtw] wifi: rtw89: hw_scan: Don't let the operating
 channel be last
Thread-Index: AQHcVPCJR7vyR3KM2kO33b+/uTOxg7T3tzBQ
Date: Tue, 18 Nov 2025 02:17:44 +0000
Message-ID: <5b0834f55d91469282a0f42c651d5441@realtek.com>
References: <c1e61744-8db4-4646-867f-241b47d30386@gmail.com>
In-Reply-To: <c1e61744-8db4-4646-867f-241b47d30386@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBTY2Fu
bmluZyBjYW4gYmUgb2ZmbG9hZGVkIHRvIHRoZSBmaXJtd2FyZS4gVG8gdGhhdCBlbmQsIHRoZSBk
cml2ZXINCj4gcHJlcGFyZXMgYSBsaXN0IG9mIGNoYW5uZWxzIHRvIHNjYW4sIGluY2x1ZGluZyBw
ZXJpb2RpYyB2aXNpdHMgYmFjayB0bw0KPiB0aGUgb3BlcmF0aW5nIGNoYW5uZWwsIGFuZCBzZW5k
cyB0aGUgbGlzdCB0byB0aGUgZmlybXdhcmUuDQo+IA0KPiBXaGVuIHRoZSBjaGFubmVsIGxpc3Qg
aXMgdG9vIGxvbmcgdG8gZml0IGluIGEgc2luZ2xlIEgyQyBtZXNzYWdlLCB0aGUNCj4gZHJpdmVy
IHNwbGl0cyB0aGUgbGlzdCwgc2VuZHMgdGhlIGZpcnN0IHBhcnQsIGFuZCB0ZWxscyB0aGUgZmly
bXdhcmUgdG8NCj4gc2Nhbi4gV2hlbiB0aGUgc2NhbiBpcyBjb21wbGV0ZSwgdGhlIGRyaXZlciBz
ZW5kcyB0aGUgbmV4dCBwYXJ0IG9mIHRoZQ0KPiBsaXN0IGFuZCB0ZWxscyB0aGUgZmlybXdhcmUg
dG8gc2Nhbi4NCj4gDQo+IFdoZW4gdGhlIGxhc3QgY2hhbm5lbCB0aGF0IGZpdCBpbiB0aGUgSDJD
IG1lc3NhZ2UgaXMgdGhlIG9wZXJhdGluZw0KPiBjaGFubmVsIHNvbWV0aGluZyBzZWVtcyB0byBn
byB3cm9uZyBpbiB0aGUgZmlybXdhcmUuIEl0IHdpbGwNCj4gYWNrbm93bGVkZ2UgcmVjZWl2aW5n
IHRoZSBsaXN0IG9mIGNoYW5uZWxzIGJ1dCBhcHBhcmVudGx5IGl0IHdpbGwgbm90DQo+IGRvIGFu
eXRoaW5nIG1vcmUuIFRoZSBBUCBjYW4ndCBiZSBwaW5nZWQgYW55bW9yZS4gVGhlIGRyaXZlciBz
dGlsbA0KPiByZWNlaXZlcyBiZWFjb25zLCB0aG91Z2guDQo+IA0KPiBPbmUgd2F5IHRvIGF2b2lk
IHRoaXMgaXMgdG8gc3BsaXQgdGhlIGxpc3Qgb2YgY2hhbm5lbHMgYmVmb3JlIHRoZQ0KPiBvcGVy
YXRpbmcgY2hhbm5lbC4NCj4gDQo+IEFmZmVjdGVkIGRldmljZXM6DQo+IA0KPiAqIFJUTDg4NTFC
VSB3aXRoIGZpcm13YXJlIDAuMjkuNDEuMw0KPiAqIFJUTDg4MzJCVSB3aXRoIGZpcm13YXJlIDAu
MjkuMjkuOA0KPiAqIFJUTDg4NTJCVSB3aXRoIGZpcm13YXJlIDAuMjkuMjkuOA0KDQpXZSBkb24n
dCBzZWUgdGhpcyBwcm9ibGVtIHdpdGggdGhlIHNhbWUgZmlybXdhcmUgb24gUlRMODg1MkJFIGFu
ZCBSVEw4ODUyQ0UsDQphbmQgSSdkIHNwZW5kIHNvbWUgdGltZSB0byBjaGVjayBpZiB0aGlzIGlt
cGFjdCBzY2FuIHRpbWUuIE9yIGNvdWxkIHlvdSBzaGFyZT8NCg0KT3RoZXJ3aXNlLCBpdCBsb29r
cyBnb29kIHRvIG1lLCBzbyBnaXZlIG15IEFDSyBpbiBhZHZhbmNlDQoNCkFja2VkLWJ5OiBQaW5n
LUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KDQo+IA0KPiBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC13aXJlbGVzcy8wYWJiZGE5MS1jNWMyLTQwMDctODRjOC0yMTU2NzllNjUy
ZTFAZ21haWwuY29tLw0KPiBDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2Zm
LWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCj4gLS0tDQo+
IEkgZGlkbid0IHRoaW5rIGEgd29ya2Fyb3VuZCB3b3VsZCBiZSBuZWVkZWQgaW4gdGhlIGtlcm5l
bCBidXQgNi4xOA0KPiB3aWxsIGJlIG91dCBzb29uIGFuZCBwZW9wbGUgc3RpbGwgaGF2ZSB0aGlz
IHByb2JsZW0uDQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9m
dy5jIHwgNyArKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgNyBpbnNlcnRpb25zKCspDQo+IA0K
PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5jIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5jDQo+IGluZGV4IDk2ZjA0NjNl
NjZkNi4uYzM1MzE3YWJjN2Y1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0dzg5L2Z3LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OS9mdy5jDQo+IEBAIC03NzA5LDYgKzc3MDksMTMgQEAgaW50IHJ0dzg5X2h3X3NjYW5fYWRk
X2NoYW5fbGlzdF9heChzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYsDQo+ICAgICAgICAgSU5JVF9M
SVNUX0hFQUQoJmxpc3QpOw0KPiANCj4gICAgICAgICBsaXN0X2Zvcl9lYWNoX2VudHJ5X3NhZmUo
Y2hfaW5mbywgdG1wLCAmc2Nhbl9pbmZvLT5jaGFuX2xpc3QsIGxpc3QpIHsNCj4gKyAgICAgICAg
ICAgICAgIC8qIFRoZSBvcGVyYXRpbmcgY2hhbm5lbCAodHhfbnVsbCA9PSB0cnVlKSBzaG91bGQN
Cj4gKyAgICAgICAgICAgICAgICAqIG5vdCBiZSBsYXN0IGluIHRoZSBsaXN0LCB0byBhdm9pZCBi
cmVha2luZw0KPiArICAgICAgICAgICAgICAgICogUlRMODg1MUJVIGFuZCBSVEw4ODMyQlUuDQo+
ICsgICAgICAgICAgICAgICAgKi8NCj4gKyAgICAgICAgICAgICAgIGlmIChsaXN0X2xlbiArIDEg
PT0gUlRXODlfU0NBTl9MSVNUX0xJTUlUX0FYICYmIGNoX2luZm8tPnR4X251bGwpDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIGJyZWFrOw0KPiArDQo+ICAgICAgICAgICAgICAgICBsaXN0X21v
dmVfdGFpbCgmY2hfaW5mby0+bGlzdCwgJmxpc3QpOw0KPiANCj4gICAgICAgICAgICAgICAgIGxp
c3RfbGVuKys7DQo+IC0tDQo+IDIuNTEuMQ0KDQo=

