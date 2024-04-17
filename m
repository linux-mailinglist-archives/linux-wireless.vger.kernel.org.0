Return-Path: <linux-wireless+bounces-6419-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 28ACA8A7D18
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 09:33:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D461F28128E
	for <lists+linux-wireless@lfdr.de>; Wed, 17 Apr 2024 07:33:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E40FA40850;
	Wed, 17 Apr 2024 07:33:44 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EB97F516
	for <linux-wireless@vger.kernel.org>; Wed, 17 Apr 2024 07:33:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713339224; cv=none; b=IF1mZDuB1oQcq1fiR+4li/7hXUphBoSjNWrIUqeewLSTMehTPTY0Tgqup8IXpK/IyFR9SHxi6v0I+Ush4TCSEpXQ6GsFSE0Xvw59xkCfA/exvdNU/E5863G1l9G0xfWJDOEvugteqZ6XqTDaQE0DXQPXNdpUcuchdUH9+SxXIFs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713339224; c=relaxed/simple;
	bh=y1KDkwBrJHlP5Dz6PvSUVWR3RVyYyLE6vGhxSH1CraY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=itaYSy+IQ6CqgIGtD2HyvlnXNDl1C3R05fMkFCbT/l+VvgUkTg8bSImkP5H3jdNTMsW98mXNaqIRvoOeR4sX3S6Zv0KNmdBeNaEv5Pm87ZYltW0R/0/DvfyxKl43hQV1RVVvVH40s6W+DO1B5Z4WR81gc4MRLXuDkHK7UJhkfXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43H7XLMv83135822, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43H7XLMv83135822
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 17 Apr 2024 15:33:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 15:33:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 17 Apr 2024 15:33:20 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 17 Apr 2024 15:33:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v5 6/6] wifi: rtlwifi: Adjust rtl8192d-common for USB
Thread-Topic: [PATCH v5 6/6] wifi: rtlwifi: Adjust rtl8192d-common for USB
Thread-Index: AQHaj3Oso5k/f8KufEeMDnCsopM7MbFsEbgQ
Date: Wed, 17 Apr 2024 07:33:20 +0000
Message-ID: <44aae72b9e2c441f9d667d98d0e779f6@realtek.com>
References: <561cc9e4-3ddc-40cd-a076-2c14c44eea87@gmail.com>
 <2d0d22e1-c4c5-46cb-8d54-63a4a16d22c6@gmail.com>
In-Reply-To: <2d0d22e1-c4c5-46cb-8d54-63a4a16d22c6@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KDQo+IEEg
ZmV3IG9mIHRoZSBzaGFyZWQgZnVuY3Rpb25zIG5lZWQgc21hbGwgY2hhbmdlcyBmb3IgdGhlIFVT
QiBkcml2ZXI6DQo+ICAtIGZpcm13YXJlIGxvYWRpbmcNCj4gIC0gZWZ1c2UgcmVhZGluZw0KPiAg
LSByYXRlIG1hc2sgdXBkYXRpbmcNCj4gIC0gcmYgcmVnaXN0ZXIgcmVhZGluZw0KPiAgLSBpbml0
aWFsIGdhaW4gZm9yIHNjYW5uaW5nDQo+IA0KPiBBbHNvLCBhZGQgYSBmZXcgbWFjcm9zIHRvIHdp
ZmkuaCwgYWRkIHNvbWUgbmV3IG1lbWJlcnMgdG8gc3RydWN0DQo+IHJ0bF9wcml2LCBhbmQgaW5p
dGlhbGlzZSBydGxoYWwuaW50ZXJmYWNlaW5kZXggZm9yIFVTQiBkZXZpY2VzLg0KPiANCj4gU2ln
bmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+
IC0tLQ0KPiB2NToNCj4gIC0gTm8gY2hhbmdlLg0KPiANCj4gdjQ6DQo+ICAtIFVwZGF0ZSB0aGUg
Y29tbWl0IG1lc3NhZ2UuDQo+ICAtIE1vdmUgX3J0bDkyZF9wY2lfbG9jayBhbmQgX3J0bDkyZF9w
Y2lfdW5sb2NrIHRvIHBoeV9jb21tb24uaCB0bw0KPiAgICBzaWxlbmNlIGEgY2hlY2twYXRjaCB3
YXJuaW5nLg0KPiAgLSBNb3ZlIHJhdGVfbWFzayBkZWNsYXJhdGlvbiBoaWdoZXIgKHNvcnRlZCBi
eSBsZW5ndGgpLg0KPiAgLSBBZGQgc29tZSBiaXQgZGVmaW5pdGlvbnMgdG8gcmVnLmguDQo+ICAt
IEFkZCB0byBzdHJ1Y3QgcnRsX3ByaXYgdGhlIHRoaW5ncyBzaGFyZWQgYnkgdGhlIHR3byBVU0Ig
aW50ZXJmYWNlcw0KPiAgICBvZiBhIGR1YWwgTUFDIFJUTDgxOTJEVToNCj4gICAgICAgICB1MzIg
KmN1cnZlaW5kZXhfMmc7DQo+ICAgICAgICAgdTMyICpjdXJ2ZWluZGV4XzVnOw0KPiAgICAgICAg
IHN0cnVjdCBtdXRleCAqbXV0ZXhfZm9yX3Bvd2VyX29uX29mZjsNCj4gICAgICAgICBzdHJ1Y3Qg
bXV0ZXggKm11dGV4X2Zvcl9od19pbml0Ow0KPiANCj4gdjM6DQo+ICAtIFNpbGVuY2Ugc3BhcnNl
IHdhcm5pbmdzIGFib3V0IGxvY2tzIGluIHBoeV9jb21tb24uYyBieSB1c2luZyBoZWxwZXINCj4g
ICAgZnVuY3Rpb25zIF9ydGw5MmRfcGNpX2xvY2soKSBhbmQgX3J0bDkyZF9wY2lfdW5sb2NrKCku
DQo+IA0KPiB2MjoNCj4gIC0gRGVsZXRlIHRoZSBtYWNybyBJU19OT1JNQUxfQ0hJUC4gSXQgd2Fz
bid0IGFjdHVhbGx5IHVzZWQuDQo+ICAtIEFkZCBSVExfVVNCX0RFTEFZX0ZBQ1RPUiBtYWNyby4N
Cj4gIC0gVXNlIEZFTl9DUFVFTiBtYWNyby4NCj4gIC0gTWFrZSBwYXJhbXNfcGNpIGFuZCBwYXJh
bXNfdXNiIGFycmF5cyBzdGF0aWMgY29uc3QsIGFuZCBtYWtlDQo+ICAgIHJ0bF9nZXRfaHdpbmZv
KCkgdGFrZSBhIGNvbnN0IHBvaW50ZXIuDQo+ICAtIFB1dCB0aGUgcmF0ZSBtYXNrLCBtYWNpZCwg
ZXRjLiBpbiBhIHN0cnVjdCBpbg0KPiAgICBydGw5MmRlX3VwZGF0ZV9oYWxfcmF0ZV9tYXNrKCku
DQo+ICAtIFVzZSBzaXplb2YocnRscHJpdi0+cmF0ZV9tYXNrKSBpbiBtZW1jcHkgaW5zdGVhZCBv
ZiBoYXJkY29kZWQgNS4NCj4gIC0gUmVuYW1lIHRlbXAgdmFyaWFibGUgdG8gcGh5X2N0cmwuDQo+
ICAtIERlZmluZSBfVFhETUFfKl9NQVAgYW5kIF9IUFEsIF9MUFEsIF9QVUJRIG1hY3JvcyB1c2lu
ZyBHRU5NQVNLIGFuZA0KPiAgICByZW1vdmUgdGhlIGxlYWRpbmcgdW5kZXJzY29yZS4NCj4gIC0g
RGVsZXRlIF9OUFEgbWFjcm8gYmVjYXVzZSBpdCdzIG5vdCB2ZXJ5IHVzZWZ1bC4NCg0KWy4uLl0N
Cg0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkv
cnRsODE5MmQvZndfY29tbW9uLmgNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
bHdpZmkvcnRsODE5MmQvZndfY29tbW9uLmgNCj4gaW5kZXggMzNiOGJhMzYzY2EyLi4zZDk5NDIz
ODk4NWYgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lm
aS9ydGw4MTkyZC9md19jb21tb24uaA0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0bHdpZmkvcnRsODE5MmQvZndfY29tbW9uLmgNCj4gQEAgLTI1LDYgKzI1LDE2IEBADQo+
ICAjZGVmaW5lIEdFVF9GSVJNV0FSRV9IRFJfU1VCX1ZFUihfX2Z3aGRyKSAgICAgICAgICAgICAg
XA0KPiAgICAgICAgIGxlMzJfZ2V0X2JpdHMoKihfX2xlMzIgKikoKF9fZndoZHIpICsgNCksIEdF
Tk1BU0soMjMsIDE2KSkNCj4gDQo+ICsjZGVmaW5lIFJBSURfTUFTSyAgICAgICAgICAgICAgIEdF
Tk1BU0soMzEsIDI4KQ0KPiArI2RlZmluZSBSQVRFX01BU0tfTUFTSyAgICAgICAgICBHRU5NQVNL
KDI3LCAwKQ0KPiArI2RlZmluZSBTSE9SVF9HSV9NQVNLICAgICAgICAgICBCSVQoNSkNCj4gKyNk
ZWZpbmUgTUFDSURfTUFTSyAgICAgICAgICAgICAgR0VOTUFTSyg0LCAwKQ0KPiArDQo+ICtzdHJ1
Y3QgcnRsOTJkX3JhdGVfbWFza19oMmMgew0KPiArICAgICAgIF9fbGUzMiByYXRlX21hc2tfYW5k
X3JhaWQ7DQo+ICsgICAgICAgdTggbWFjaWRfYW5kX3Nob3J0X2dpOw0KPiArfSBfX3BhY2tlZDsN
Cj4gKw0KDQpZb3UgYXNrZWQgbWUgdG8gZHJvcCBhIHBhdGNoIHRoYXQgbG9va3MgdmVyeSBsaWtl
IHRoaXMuIElzIHRoaXMgcGFydCBjb3JyZWN0Pw0KDQpbLi4uXQ0KDQo+IEBAIC0yNzY4LDYgKzI3
NzMsMTIgQEAgc3RydWN0IHJ0bF9wcml2IHsNCj4gICAgICAgICAgKi8NCj4gICAgICAgICBib29s
IHVzZV9uZXdfdHJ4X2Zsb3c7DQo+IA0KPiArICAgICAgIC8qIEZvciBkdWFsIE1BQyBSVEw4MTky
RFUsIHRoaW5ncyBzaGFyZWQgYnkgdGhlIDIgVVNCIGludGVyZmFjZXMgKi8NCj4gKyAgICAgICB1
MzIgKmN1cnZlaW5kZXhfMmc7DQo+ICsgICAgICAgdTMyICpjdXJ2ZWluZGV4XzVnOw0KPiArICAg
ICAgIHN0cnVjdCBtdXRleCAqbXV0ZXhfZm9yX3Bvd2VyX29uX29mZjsgLyogZm9yIHBvd2VyIG9u
L29mZiAqLw0KPiArICAgICAgIHN0cnVjdCBtdXRleCAqbXV0ZXhfZm9yX2h3X2luaXQ7IC8qIGZv
ciBoYXJkd2FyZSBpbml0ICovDQoNCkl0IHdvdWxkIGJlIGJldHRlciB0byBpbnRyb2R1Y2UgdGhl
c2UgbG9ja3MgYWxvbmcgd2l0aCBjb25zdW1lcnMuIFRoZW4sIEkgd2lsbA0Kbm90IG1pc3MgdG8g
cmV2aWV3IHRoZW0gY2FyZWZ1bGx5Lg0KDQpCeSB0aGUgd2F5LCBJIGRvbid0IHJldmlldyByZW1h
aW5pbmcgcGF0Y2hlcyBvZiB2NCB1bnRpbCB0aGlzIG5ldyAoc21hbGxlcikNCnBhdGNoc2V0IGdl
dHMgbWVyZ2VkLiANCg0KDQo=

