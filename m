Return-Path: <linux-wireless+bounces-4222-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C1B0286BF8D
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 04:42:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 620641F23DD6
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 03:42:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED5BD286A7;
	Thu, 29 Feb 2024 03:42:38 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58E7A1F95F
	for <linux-wireless@vger.kernel.org>; Thu, 29 Feb 2024 03:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709178158; cv=none; b=Qzi/B10sNMiD+OzN2NNQLbxw60wvMIx5+XSdJgUWZ98KcXEir8Fe7aq6dI3oiVwe4RWQ+/R2UayMg/zFDpq4p25CFH610oaAg2bjjSKrlabun5YlMGIJdbVJCw/KIzL2DgAoLE1p0QCyI2vudnJ+UEzur0xanrzhMje6SDeyOJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709178158; c=relaxed/simple;
	bh=PQQUK+36gHZACJfokh7fHXIRd8objcnQi++ZnvlK18g=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=pq20Kj9Uz7HVHPCF1snCbDXHxo3O75QbkY0H2gjRdjPYU2JJ5VmEJ5Df+1qn1aHJU8P+oKBkBVBz2FRDLiZ0S6H/4Mck6uYWRgvezkDOhGXrLS6OvnZ4KiW31+NKbn6ysYRfIlFX6MsESbA3Ofq/eDzh/0bJQisCeaVwtCWCoIg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41T3gM4g91094023, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41T3gM4g91094023
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 11:42:23 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Thu, 29 Feb 2024 11:42:23 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 11:42:23 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Thu, 29 Feb 2024 11:42:23 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH 2/4] wifi: rtw88: 8821cu: Fix connection failure
Thread-Topic: [PATCH 2/4] wifi: rtw88: 8821cu: Fix connection failure
Thread-Index: AQHaaXcy89NpCuAWo0WHaaccD3jEYLEgrvlA
Date: Thu, 29 Feb 2024 03:42:22 +0000
Message-ID: <e0444bf3c74f443fa4cf64b076a22914@realtek.com>
References: <909d9f75-44cd-4710-9d3f-56691fd58090@gmail.com>
 <8770f25c-1dcb-48c6-9279-cd6de158dfec@gmail.com>
In-Reply-To: <8770f25c-1dcb-48c6-9279-cd6de158dfec@gmail.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IFR1ZXNkYXksIEZlYnJ1YXJ5IDI3
LCAyMDI0IDg6MTkgUE0NCj4gVG86IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZw0KPiBD
YzogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+OyBTYXNjaGEgSGF1ZXIgPHNoYUBw
ZW5ndXRyb25peC5kZT4NCj4gU3ViamVjdDogW1BBVENIIDIvNF0gd2lmaTogcnR3ODg6IDg4MjFj
dTogRml4IGNvbm5lY3Rpb24gZmFpbHVyZQ0KPiANCj4gQ2xlYXIgYml0IDggb2YgUkVHX1NZU19T
VEFUVVMxIGFmdGVyIE1BQyBwb3dlciBvbi4NCj4gDQo+IFdpdGhvdXQgdGhpcywgc29tZSBSVEw4
ODIxQ1UgYW5kIFJUTDg4MTFDVSBjYW5ub3QgY29ubmVjdCB0byBhbnkNCj4gbmV0d29yazoNCj4g
DQo+IEZlYiAxOSAxMzozMzoxMSBpZGVhcGFkMiBrZXJuZWw6IHdscDNzMGYzdTI6IHNlbmQgYXV0
aCB0bw0KPiAgICAgICAgIDkwOjU1OmRlOl9fOl9fOl9fICh0cnkgMS8zKQ0KPiBGZWIgMTkgMTM6
MzM6MTMgaWRlYXBhZDIga2VybmVsOiB3bHAzczBmM3UyOiBzZW5kIGF1dGggdG8NCj4gICAgICAg
ICA5MDo1NTpkZTpfXzpfXzpfXyAodHJ5IDIvMykNCj4gRmViIDE5IDEzOjMzOjE0IGlkZWFwYWQy
IGtlcm5lbDogd2xwM3MwZjN1Mjogc2VuZCBhdXRoIHRvDQo+ICAgICAgICAgOTA6NTU6ZGU6X186
X186X18gKHRyeSAzLzMpDQo+IEZlYiAxOSAxMzozMzoxNSBpZGVhcGFkMiBrZXJuZWw6IHdscDNz
MGYzdTI6IGF1dGhlbnRpY2F0aW9uIHdpdGgNCj4gICAgICAgICA5MDo1NTpkZTpfXzpfXzpfXyB0
aW1lZCBvdXQNCj4gDQo+IFRoZSBSVEw4ODIyQ1UgYW5kIFJUTDg4MjJCVSBvdXQtb2YtdHJlZSBk
cml2ZXJzIGRvIHRoaXMgYXMgd2VsbCwgc28gZG8NCj4gaXQgZm9yIGFsbCB0aHJlZSB0eXBlcyBv
ZiBjaGlwcy4NCj4gDQo+IFRlc3RlZCB3aXRoIFJUTDg4MTFDVSAoVGVuZGEgVTkgVjIuMCkuDQo+
IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWls
LmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21hYy5j
IHwgOCArKysrKysrKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiANCj4g
ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFjLmMgYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21hYy5jDQo+IGluZGV4IDI5ODY2M2Iw
MzU4MC4uYTNiMmM1N2M1NTAzIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0dzg4L21hYy5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODgvbWFjLmMNCj4gQEAgLTMwOSw2ICszMDksMTQgQEAgc3RhdGljIGludCBydHdfbWFjX3Bv
d2VyX3N3aXRjaChzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LCBib29sIHB3cl9vbikNCj4gICAgICAg
ICBwd3Jfc2VxID0gcHdyX29uID8gY2hpcC0+cHdyX29uX3NlcSA6IGNoaXAtPnB3cl9vZmZfc2Vx
Ow0KPiAgICAgICAgIHJldCA9IHJ0d19wd3Jfc2VxX3BhcnNlcihydHdkZXYsIHB3cl9zZXEpOw0K
PiANCj4gKyAgICAgICBpZiAocHdyX3NlcSA9PSBjaGlwLT5wd3Jfb25fc2VxICYmDQoNCndlIGNh
biBqdXN0IGNoZWNrIHRoaXMgYnkgJ3B3cl9vbicuDQoNCj4gKyAgICAgICAgICAgcnR3X2hjaV90
eXBlKHJ0d2RldikgPT0gUlRXX0hDSV9UWVBFX1VTQikgew0KPiArICAgICAgICAgICAgICAgaWYg
KGNoaXAtPmlkID09IFJUV19DSElQX1RZUEVfODgyMkMgfHwNCj4gKyAgICAgICAgICAgICAgICAg
ICBjaGlwLT5pZCA9PSBSVFdfQ0hJUF9UWVBFXzg4MjJCIHx8DQo+ICsgICAgICAgICAgICAgICAg
ICAgY2hpcC0+aWQgPT0gUlRXX0NISVBfVFlQRV84ODIxQykNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgcnR3X3dyaXRlOF9jbHIocnR3ZGV2LCBSRUdfU1lTX1NUQVRVUzEgKyAxLCBCSVQoMCkp
Ow0KPiArICAgICAgIH0NCj4gKw0KPiAgICAgICAgIGlmIChydHdfaGNpX3R5cGUocnR3ZGV2KSA9
PSBSVFdfSENJX1RZUEVfU0RJTykNCj4gICAgICAgICAgICAgICAgIHJ0d193cml0ZTMyKHJ0d2Rl
diwgUkVHX1NESU9fSElNUiwgaW1yKTsNCj4gDQo+IC0tDQo+IDIuNDMuMg0K

