Return-Path: <linux-wireless+bounces-11716-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 726DD9591D0
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 02:32:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 7B5E81C21911
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Aug 2024 00:32:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 30F194A32;
	Wed, 21 Aug 2024 00:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ILkee3WU"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A85C1219FC
	for <linux-wireless@vger.kernel.org>; Wed, 21 Aug 2024 00:31:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724200321; cv=none; b=toSOVEw/GKEMRoXFQ4hOligB/GQZoPAsU7jScW1sjsFaA0r459VmKziNV64NbQFMSkhPvAxrWIvEuA27k+BmrAogF+fHB1ULvATm0rTFcyhxHXczNRQDiOmHmlk8uCjFNo/7cKYqKOLZ1Q+Q0e3zp7cWBnPJgoxe+kNyHETHNxQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724200321; c=relaxed/simple;
	bh=gE2Jm3m5ElyzndhDgvfntNyDc9Z8jvSdIr9V3brdJVI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rYPsZs20uq6QaypTBCWhU4o4Ftk765ymrwwMwPoGc6Y4dx2KbcpNK0Yq6uWpIQUfSw2+NUc4jZ0wJRMC33xdGBbRuGUgUlL9zhanNCUjRYws9G7gJswMTNQc1CvcuUmuxWSF6u085FpKnkMyikHHBAgdlwzdEsadhO3k5FQZMCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ILkee3WU; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47L0VqBZ22067096, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724200312; bh=gE2Jm3m5ElyzndhDgvfntNyDc9Z8jvSdIr9V3brdJVI=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ILkee3WUzuL2T/B49NS6igAufTI87UsSas8HJCQzh7LsmtaB2hFwRABXgizpBrBtR
	 v89WwXhPpxqw+IqWPh51Xdfk5hHTL4sMfi1MGu/xIsbCN8uG4gJ5G6OPP6HQJVJUgK
	 kZXjeDTXqN84JnhR4mKgTcZe77I9261DsOKlufPUV66MVO7djTSbFnQXO5ZK24B+F8
	 WCI4QAFaLTI8R/d/pWmcBOncgAKc+a1O92JH/OBF7d6+itOr6BTSzAtGa+1m1VdvDJ
	 IWeSKSOzjiw1G4/DNews+VIPlFK7qyg8KfiTwnMNfYyty3m+2MxBx3EpcJNt+4ISCr
	 /XEv1SbFZMjDg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47L0VqBZ22067096
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Aug 2024 08:31:52 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 21 Aug 2024 08:31:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Aug 2024 08:31:51 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 21 Aug 2024 08:31:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 03/20] wifi: rtw88: Allow different C2H RA report sizes
Thread-Topic: [PATCH 03/20] wifi: rtw88: Allow different C2H RA report sizes
Thread-Index: AQHa7DDGvlj44vDEDUaIMp+2n642+LIn28NggAaGugCAAPvpQIAA11EAgACyXKA=
Date: Wed, 21 Aug 2024 00:31:51 +0000
Message-ID: <9456919959d94b548750f78a371f204e@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <e0de25fc-8742-4899-854e-7cbd93aaa582@gmail.com>
 <6071028680d14afa8e0eed84821f51c6@realtek.com>
 <4b7181e4-d235-4c02-8b8e-dbafbf38fa93@gmail.com>
 <840cb519e99047a5a8f3ca4a12a3fcee@realtek.com>
 <d06c7a5f-c773-45a6-98f2-30fb1d0dde94@gmail.com>
In-Reply-To: <d06c7a5f-c773-45a6-98f2-30fb1d0dde94@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAy
MC8wOC8yMDI0IDA0OjEwLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBPbiAxNS8wOC8yMDI0IDA5
OjE0LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4+PiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIx
Y2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4+Pj4gVGhlIFJUTDg4MjFBVSBhbmQgUlRMODgx
MkFVIGhhdmUgc21hbGxlciBSQSByZXBvcnQgc2l6ZSwgb25seSA0IGJ5dGVzLg0KPiA+Pj4+IEF2
b2lkIHRoZSAiaW52YWxpZCByYSByZXBvcnQgYzJoIGxlbmd0aCIgZXJyb3IuDQo+ID4+Pj4NCj4g
Pj4+PiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWls
LmNvbT4NCj4gPj4+PiAtLS0NCj4gPj4+PiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OC9mdy5jICAgICAgIHwgOCArKysrKystLQ0KPiA+Pj4+ICBkcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0dzg4L21haW4uaCAgICAgfCAxICsNCj4gPj4+PiAgZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydHc4OC9ydHc4NzAzYi5jIHwgMSArDQo+ID4+Pj4gIGRyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcnR3ODcyM2QuYyB8IDEgKw0KPiA+Pj4+ICBkcml2ZXJz
L25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4MjFjLmMgfCAxICsNCj4gPj4+PiAgZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9ydHc4ODIyYi5jIHwgMSArDQo+ID4+Pj4g
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcnR3ODgyMmMuYyB8IDEgKw0KPiA+
Pj4+ICA3IGZpbGVzIGNoYW5nZWQsIDEyIGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+
ID4+Pj4NCj4gPj4+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OC9mdy5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9mdy5jDQo+ID4+
Pj4gaW5kZXggNzgyZjM3NzZlMGEwLi5hYzUzZTNlMzBhZjAgMTAwNjQ0DQo+ID4+Pj4gLS0tIGEv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9mdy5jDQo+ID4+Pj4gKysrIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9mdy5jDQo+ID4+Pj4gQEAgLTE1Nyw3ICsx
NTcsMTAgQEAgc3RhdGljIHZvaWQgcnR3X2Z3X3JhX3JlcG9ydF9pdGVyKHZvaWQgKmRhdGEsIHN0
cnVjdCBpZWVlODAyMTFfc3RhICpzdGEpDQo+ID4+Pj4NCj4gPj4+PiAgICAgICAgIHJhdGUgPSBH
RVRfUkFfUkVQT1JUX1JBVEUocmFfZGF0YS0+cGF5bG9hZCk7DQo+ID4+Pj4gICAgICAgICBzZ2kg
PSBHRVRfUkFfUkVQT1JUX1NHSShyYV9kYXRhLT5wYXlsb2FkKTsNCj4gPj4+PiAtICAgICAgIGJ3
ID0gR0VUX1JBX1JFUE9SVF9CVyhyYV9kYXRhLT5wYXlsb2FkKTsNCj4gPj4+PiArICAgICAgIGlm
IChzaS0+cnR3ZGV2LT5jaGlwLT5jMmhfcmFfcmVwb3J0X3NpemUgPCA3KQ0KPiA+Pj4NCj4gPj4+
IEV4cGxpY2l0bHkgc3BlY2lmeSAnPT0gNCcgZm9yIHRoZSBjYXNlIG9mIFJUTDg4MjFBVSBhbmQg
UlRMODgxMkFVLg0KPiA+Pj4NCj4gPj4+PiArICAgICAgICAgICAgICAgYncgPSBzaS0+YndfbW9k
ZTsNCj4gPj4+PiArICAgICAgIGVsc2UNCj4gPj4+PiArICAgICAgICAgICAgICAgYncgPSBHRVRf
UkFfUkVQT1JUX0JXKHJhX2RhdGEtPnBheWxvYWQpOw0KPiA+Pj4+DQo+ID4+Pg0KPiA+Pj4NCj4g
Pj4NCj4gPj4gV291bGQgdGhhdCBtYWtlIHNlbnNlPyBJIGNoZWNrIGZvciBsZXNzIHRoYW4gNyBi
ZWNhdXNlIHRoZSBzaXplDQo+ID4+IGhhcyB0byBiZSBhdCBsZWFzdCA3IGluIG9yZGVyIHRvIGFj
Y2VzcyBwYXlsb2FkWzZdIChHRVRfUkFfUkVQT1JUX0JXKS4NCj4gPg0KPiA+IEFzIHlvdSBkaWQg
IldBUk4obGVuZ3RoIDwgcnR3ZGV2LT5jaGlwLT5jMmhfcmFfcmVwb3J0X3NpemUpIiwgSSBhc3N1
bWUgeW91DQo+ID4gZXhwZWN0ICI8IDciIGNhc2VzIGlzIG9ubHkgZm9yIGNvbWluZyBjaGlwcyBS
VEw4ODIxQVUgYW5kIFJUTDg4MTJBVS4NCj4gPg0KPiA+IE1heWJlIGV4cGxpY2l0bHkgc3BlY2lm
eWluZyBjaGlwcyBJRCB3b3VsZCBiZSBlYXNpZXIgdG8gdW5kZXJzdGFuZDoNCj4gPiAgICAgICAg
IGlmIChjaGlwID09IFJUTDg4MjFBIHx8IGNoaXAgPT0gUlRMODgxMkEpDQo+ID4gICAgICAgICAg
ICAgICAgYncgPSBzaS0+YndfbW9kZTsNCj4gPiAgICAgICAgIGVsc2UNCj4gPiAgICAgICAgICAg
ICAgICBidyA9IEdFVF9SQV9SRVBPUlRfQlcocmFfZGF0YS0+cGF5bG9hZCk7DQo+ID4NCj4gPiBU
aGF0J3Mgd2h5IEkgd2FudCAiPT0gNCIuIChidXQgaXQgc2VlbXMgaW1wbGljaXRseSBub3QgZXhw
bGljaXRseSB0aG91Z2guKQ0KPiA+DQo+IA0KPiBJIGp1c3QgY2hlY2tlZCwgdGhlIFJBIHJlcG9y
dCBzaXplIG9mIFJUTDg4MTRBVSBpcyA2Lg0KDQpDb3VsZCB5b3UgYWxzbyBjaGVjayBpZiB0aGUg
cmVwb3J0IGZvcm1hdCBpcyBjb21wYXRpYmxlPw0KSSBtZWFuIGRlZmluaXRpb24gb2YgZmlyc3Qg
NCBieXRlcyBhcmUgdGhlIHNhbWUgZm9yIGFsbCBjaGlwcz8gYW5kDQpkZWZpbml0aW9uIG9mIGZp
cnN0IDYgYnl0ZXMgYXJlIHRoZSBzYW1lIGZvciBSVEw4ODE0QVUgYW5kIGN1cnJlbnQNCmV4aXRp
bmcgY2hpcHM/DQoNCkJ5IHRoZSB3YXksIEkgdGhpbmsgd2Ugc2hvdWxkIHN0cnVjdCB3aXRoIHcw
LCB3MSwgLi4uIGZpZWxkcyBpbnN0ZWFkLg0KICAgIHN0cnVjdCBydHdfcmFfcmVwb3J0IHsNCiAg
ICAgICAgX19sZTMyIHcwOw0KICAgICAgICBfX2xlMzIgdzE7DQogICAgICAgIF9fbGUzMiB3MjsN
CiAgICAgICAgX19sZTMyIHczOw0KICAgICAgICBfX2xlMzIgdzQ7DQogICAgICAgIF9fbGUzMiB3
NTsNCiAgICAgICAgX19sZTMyIHc2Ow0KICAgIH0gX19wYWNrZWQ7DQoNClRoZW4sIHdlIGNhbiBi
ZSBlYXNpZXIgdG8gYXZvaWQgYWNjZXNzaW5nIG91dCBvZiByYW5nZS4gR0VUX1JBX1JFUE9SVF9C
VygpDQpoaWRlcyBzb21ldGhpbmcsIG5vIGhlbHAgdG8gcmVhZCB0aGUgY29kZS4gDQoNCg0K

