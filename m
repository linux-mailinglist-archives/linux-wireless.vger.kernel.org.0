Return-Path: <linux-wireless+bounces-7416-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8914F8C1D28
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 05:44:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id F408E1F21835
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 03:44:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17C5B149C78;
	Fri, 10 May 2024 03:43:58 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E0AA149005
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 03:43:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715312638; cv=none; b=ZRQNvuh+sfEmuHe1IJvqg2q64iLa7DP5u8cwrqGVJ96Lju3SJhVKAAGQxdOWP+WyD97OVsPadwPQFQhNSLmZ96bvIQjtQgJiNjvxdrJYt1DcnagIq6VZSIg4W6d2Jp6UE2uxMlMYI+ecjXYPwa763pRJSY4U5YfFLevmpeGvPXQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715312638; c=relaxed/simple;
	bh=Pg4tUUAz3R2FR5PD2PoBiot0N6PiqWfS6Cvak72c+mU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Kvntl/a8r0McyFqVdD0g0B3XdnSWe6hJwwq24bXaWbaNFMEB/FvboATC0HqazS5BjKCZ+JR7F7yNQtF9MAWrKjaqD1GQ8OVyE2bcGgay2971VhU8oS57WsizDy91b2R6vf+9yPHx6vfevdyu3+/qjjvOctr4mv5YDRMxWIdNZdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44A3hSU712309554, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44A3hSU712309554
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 11:43:28 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 11:43:29 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 11:43:28 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::c892:ed3a:bac3:bda7]) by
 RTEXDAG02.realtek.com.tw ([fe80::c892:ed3a:bac3:bda7%5]) with mapi id
 15.01.2507.035; Fri, 10 May 2024 11:43:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v5 04/11] wifi: rtlwifi: Add rtl8192du/phy.{c,h}
Thread-Topic: [PATCH v5 04/11] wifi: rtlwifi: Add rtl8192du/phy.{c,h}
Thread-Index: AQHaoTVxRbzA9SzQcUu579WUwCAwWbGPy1Cw
Date: Fri, 10 May 2024 03:43:28 +0000
Message-ID: <4ab7446ccf754f45a9c1f85a22b57fdf@realtek.com>
References: <254558da-ea8b-40ea-bd5a-83d13796744f@gmail.com>
 <f62149e8-a980-40d2-a3b2-97b5886938fa@gmail.com>
In-Reply-To: <f62149e8-a980-40d2-a3b2-97b5886938fa@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGVz
ZSBjb250YWluIG1vc3RseSB0aGUgY2FsaWJyYXRpb24gYW5kIGNoYW5uZWwgc3dpdGNoaW5nIHJv
dXRpbmVzDQo+IGZvciBSVEw4MTkyRFUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVl
IFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICAuLi4vd2lyZWxlc3Mv
cmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS9waHkuYyAgfCAzMTgxICsrKysrKysrKysrKysrKysr
DQo+ICAuLi4vd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS9waHkuaCAgfCAgIDMy
ICsNCj4gIDIgZmlsZXMgY2hhbmdlZCwgMzIxMyBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS9w
aHkuYw0KPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnRsd2lmaS9ydGw4MTkyZHUvcGh5LmgNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcnRsODE5MmR1L3BoeS5jDQo+IGIvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS9waHkuYw0KPiBuZXcgZmlsZSBtb2Rl
IDEwMDY0NA0KPiBpbmRleCAwMDAwMDAwMDAwMDAuLjU5OTk5OTdmNGVmOQ0KPiAtLS0gL2Rldi9u
dWxsDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9ydGw4MTky
ZHUvcGh5LmMNCg0KWy4uLl0NCg0KPiArDQo+ICsvKiBbbW9kZV1bcGF0aGErYl1bcmVnXSAqLw0K
DQpUaGVyZSBpcyBvbmx5IG9uZSBtb2RlLiBIb3cgYWJvdXQgc2hyaW5raW5nIGRpbWVuc2lvbiBm
cm9tIDMgdG8gMj8NCg0KPiArc3RhdGljIGNvbnN0IHUzMiByZl9pbXJfcGFyYW1fbm9ybWFsWzFd
WzNdW01BWF9SRl9JTVJfSU5ERVhfTk9STUFMXSA9IHsNCj4gKyAgICAgICB7DQo+ICsgICAgICAg
ICAgICAgICAvKiBjaGFubmVsIDEtMTQuICovDQo+ICsgICAgICAgICAgICAgICB7DQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIDB4NzAwMDAsIDB4MDBmZjAsIDB4NDQwMGYsIDB4MDBmZjAsIDB4
MCwgMHgwLCAweDAsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgIDB4MCwgMHgwLCAweDY0ODg4
LCAweGUyNjZjLCAweDAwMDkwLCAweDIyZmZmDQo+ICsgICAgICAgICAgICAgICB9LA0KPiArICAg
ICAgICAgICAgICAgLyogcGF0aCAzNi02NCAqLw0KPiArICAgICAgICAgICAgICAgew0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAweDcwMDAwLCAweDIyODgwLCAweDQ0NzBmLCAweDU1ODgwLCAw
eDAwMDcwLCAweDg4MDAwLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAweDAsIDB4ODgwODAs
IDB4NzAwMDAsIDB4NjRhODIsIDB4ZTQ2NmMsIDB4MDAwOTAsDQo+ICsgICAgICAgICAgICAgICAg
ICAgICAgIDB4MzJjOWENCj4gKyAgICAgICAgICAgICAgIH0sDQo+ICsgICAgICAgICAgICAgICAv
KiAxMDAgLTE2NSAqLw0KPiArICAgICAgICAgICAgICAgew0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAweDcwMDAwLCAweDQ0ODgwLCAweDQ0NzdmLCAweDc3ODgwLCAweDAwMDcwLCAweDg4MDAw
LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAweDAsIDB4ODgwYjAsIDB4MCwgMHg2NGI4Miwg
MHhlNDY2YywgMHgwMDA5MCwgMHgzMmM5YQ0KPiArICAgICAgICAgICAgICAgfQ0KPiArICAgICAg
IH0NCj4gK307DQo+ICsNCg0KWy4uLl0NCg0KDQo+ICtzdGF0aWMgYm9vbCBfcnRsOTJkX3BoeV9j
b25maWdfYmJfd2l0aF9oZWFkZXJmaWxlKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LA0KPiArICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHU4IGNvbmZpZ3R5
cGUpDQo+ICt7DQoNClsuLi5dDQoNCj4gKyAgICAgICB9IGVsc2UgaWYgKGNvbmZpZ3R5cGUgPT0g
QkFTRUJBTkRfQ09ORklHX0FHQ19UQUIpIHsNCj4gKyAgICAgICAgICAgICAgIGlmIChydGxoYWwt
PmludGVyZmFjZWluZGV4ID09IDApIHsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgZm9yIChp
ID0gMDsgaSA8IGFnY3RhYl9hcnJheWxlbjsgaSA9IGkgKyAyKSB7DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgcnRsX3NldF9iYnJlZyhodywgYWdjdGFiX2FycmF5X3RhYmxlW2ld
LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUFTS0RX
T1JELA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWdj
dGFiX2FycmF5X3RhYmxlW2kgKyAxXSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgLyogQWRkIDF1cyBkZWxheSBiZXR3ZWVuIEJCL1JGIHJlZ2lzdGVyDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICogc2V0dGluZy4NCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgKi8NCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1ZGVsYXko
MSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcnRsX2RiZyhydGxwcml2LCBD
T01QX0lOSVQsIERCR19UUkFDRSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICJUaGUgUnRsODE5WEFHQ1RBQl9BcnJheV9UYWJsZVswXSBpcyAldSBSdGw4MTlYUEhZ
X1JFR0FycmF5WzFdDQo+IGlzICV1XG4iLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgYWdjdGFiX2FycmF5X3RhYmxlW2ldLA0KPiArICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgYWdjdGFiX2FycmF5X3RhYmxlW2kgKyAxXSk7DQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAgICAgICAgICAgICAgcnRsX2RiZyhy
dGxwcml2LCBDT01QX0lOSVQsIERCR19MT1VELA0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICJOb3JtYWwgQ2hpcCwgTUFDMCwgbG9hZCBSdGw4MTlYQUdDVEFCX0FycmF5XG4iKTsN
Cj4gKyAgICAgICAgICAgICAgIH0gZWxzZSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIGlm
IChydGxoYWwtPmN1cnJlbnRfYmFuZHR5cGUgPT0gQkFORF9PTl8yXzRHKSB7DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgZm9yIChpID0gMDsgaSA8IGFnY3RhYl9hcnJheWxlbjsg
aSA9IGkgKyAyKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBy
dGxfc2V0X2JicmVnKGh3LCBhZ2N0YWJfYXJyYXlfdGFibGVbaV0sDQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIE1BU0tEV09SRCwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWdjdGFi
X2FycmF5X3RhYmxlW2kgKyAxXSk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAvKiBBZGQgMXVzIGRlbGF5IGJldHdlZW4gQkIvUkYgcmVnaXN0ZXINCj4gKyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAqIHNldHRpbmcuDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKi8NCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgIHVkZWxheSgxKTsNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHJ0bF9kYmcocnRscHJpdiwgQ09NUF9JTklULCBEQkdfVFJBQ0Us
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICJUaGUg
UnRsODE5WEFHQ1RBQl9BcnJheV9UYWJsZVswXSBpcyAldQ0KPiBSdGw4MTlYUEhZX1JFR0FycmF5
WzFdIGlzICV1XG4iLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBhZ2N0YWJfYXJyYXlfdGFibGVbaV0sDQo+ICsgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGFnY3RhYl9hcnJheV90YWJsZVtpICsgMV0pOw0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBydGxfZGJnKHJ0bHByaXYsIENPTVBfSU5JVCwgREJHX0xPVUQsDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAiTG9hZCBSdGw4MTlYQUdDVEFCXzJH
QXJyYXlcbiIpOw0KPiArICAgICAgICAgICAgICAgICAgICAgICB9IGVsc2Ugew0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIGZvciAoaSA9IDA7IGkgPCBhZ2N0YWJfNWdhcnJheWxl
bjsgaSA9IGkgKyAyKSB7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBydGxfc2V0X2JicmVnKGh3LA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBhZ2N0YWJfNWdhcnJheV90YWJsZVtpXSwNCj4gKyAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTUFTS0RXT1JELA0K
PiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBh
Z2N0YWJfNWdhcnJheV90YWJsZVtpICsgMV0pOw0KPiArICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgLyogQWRkIDF1cyBkZWxheSBiZXR3ZWVuIEJCL1JGIHJlZ2lzdGVyDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKiBzZXR0aW5nLg0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICovDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICB1ZGVsYXkoMSk7DQo+ICsgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICBydGxfZGJnKHJ0bHByaXYsIENPTVBfSU5JVCwgREJH
X1RSQUNFLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAiVGhlIFJ0bDgxOVhBR0NUQUJfNUdBcnJheV9UYWJsZVswXSBpcyAldQ0KPiBSdGw4MTlYUEhZ
X1JFR0FycmF5WzFdIGlzICV1XG4iLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICBhZ2N0YWJfNWdhcnJheV90YWJsZVtpXSwNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYWdjdGFiXzVnYXJyYXlfdGFibGVb
aSArIDFdKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB9DQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgcnRsX2RiZyhydGxwcml2LCBDT01QX0lOSVQsIERCR19M
T1VELA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIkxvYWQgUnRs
ODE5WEFHQ1RBQl81R0FycmF5XG4iKTsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgfQ0KDQpU
aHJlZSBibG9ja3MgYXJlIHZlcnkgc2ltaWxhciwgb25seSBhcnJheXMgYXJlIGRpZmZlcmVudC4g
Q2FuIHlvdSBjaGFuZ2UgdGhlbQ0KdG8NCiAgICBpZiAoaW5mID09IDApIHsNCiAgICAgICAgYXJy
YXkgPSB4eHg7DQogICAgICAgIGFycmF5X3NpemUgPSB4eHhfbGVuOw0KICAgIH0gZWxzZSB7DQog
ICAgICAgIGlmICgyZ2h6KSB7DQogICAgICAgICAgICBhcnJheSA9IHl5eV8yZ2h6Ow0KICAgICAg
ICAgICAgYXJyYXlfc2l6ZSA9IHl5eV8yZ2h6X2xlbjsNCiAgICAgICAgfSBlbHNlIHsNCiAgICAg
ICAgICAgIGFycmF5ID0geXl5XzVnaHo7DQogICAgICAgICAgICBhcnJheV9zaXplID0geXl5XzVn
aHpfbGVuOw0KICAgICAgICB9DQogICAgfQ0KDQogICAgZm9yIChpID0gMDsgaSA8IGFycmF5X3Np
emU7IGkgKz0gMikgew0KICAgICAgICBydGxfc2V0X2JicmVnKC4uLikNCiAgICAgICAgdWRlbGF5
KDEpOw0KICAgIH0NCg0KPiArICAgICAgICAgICAgICAgfQ0KPiArICAgICAgIH0NCj4gKyAgICAg
ICByZXR1cm4gdHJ1ZTsNCj4gK30NCg0KWy4uLl0NCg0KPiArdm9pZCBydGw5MmRfcGh5X3NldF9i
d19tb2RlKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LA0KPiArICAgICAgICAgICAgICAgICAgICAg
ICAgICAgZW51bSBubDgwMjExX2NoYW5uZWxfdHlwZSBjaF90eXBlKQ0KPiArew0KPiArICAgICAg
IHN0cnVjdCBydGxfcHJpdiAqcnRscHJpdiA9IHJ0bF9wcml2KGh3KTsNCj4gKyAgICAgICBzdHJ1
Y3QgcnRsX2hhbCAqcnRsaGFsID0gcnRsX2hhbChydGxwcml2KTsNCj4gKyAgICAgICBzdHJ1Y3Qg
cnRsX3BoeSAqcnRscGh5ID0gJnJ0bHByaXYtPnBoeTsNCj4gKyAgICAgICBzdHJ1Y3QgcnRsX21h
YyAqbWFjID0gcnRsX21hYyhydGxwcml2KTsNCj4gKyAgICAgICB1OCByZWdfYndfb3Btb2RlOw0K
PiArICAgICAgIHU4IHJlZ19wcnNyX3JzYzsNCj4gKw0KPiArICAgICAgIGlmIChydGxwaHktPnNl
dF9id21vZGVfaW5wcm9ncmVzcykNCj4gKyAgICAgICAgICAgICAgIHJldHVybjsNCj4gKyAgICAg
ICBpZiAoKGlzX2hhbF9zdG9wKHJ0bGhhbCkpIHx8IChSVF9DQU5OT1RfSU8oaHcpKSkgew0KPiAr
ICAgICAgICAgICAgICAgcnRsX2RiZyhydGxwcml2LCBDT01QX0VSUiwgREJHX1dBUk5JTkcsDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgICJGQUxTRSBkcml2ZXIgc2xlZXAgb3IgdW5sb2FkXG4i
KTsNCj4gKyAgICAgICAgICAgICAgIHJldHVybjsNCj4gKyAgICAgICB9DQo+ICsNCj4gKyAgICAg
ICBydGxwaHktPnNldF9id21vZGVfaW5wcm9ncmVzcyA9IHRydWU7DQo+ICsNCj4gKyAgICAgICBy
dGxfZGJnKHJ0bHByaXYsIENPTVBfU0NBTiwgREJHX1RSQUNFLCAiU3dpdGNoIHRvICVzIGJhbmR3
aWR0aFxuIiwNCj4gKyAgICAgICAgICAgICAgIHJ0bHBoeS0+Y3VycmVudF9jaGFuX2J3ID09IEhU
X0NIQU5ORUxfV0lEVEhfMjAgPw0KPiArICAgICAgICAgICAgICAgIjIwTUh6IiA6ICI0ME1IeiIp
Ow0KPiArDQo+ICsgICAgICAgcmVnX2J3X29wbW9kZSA9IHJ0bF9yZWFkX2J5dGUocnRscHJpdiwg
UkVHX0JXT1BNT0RFKTsNCj4gKyAgICAgICByZWdfcHJzcl9yc2MgPSBydGxfcmVhZF9ieXRlKHJ0
bHByaXYsIFJFR19SUlNSICsgMik7DQo+ICsNCj4gKyAgICAgICBzd2l0Y2ggKHJ0bHBoeS0+Y3Vy
cmVudF9jaGFuX2J3KSB7DQo+ICsgICAgICAgY2FzZSBIVF9DSEFOTkVMX1dJRFRIXzIwOg0KPiAr
ICAgICAgICAgICAgICAgcmVnX2J3X29wbW9kZSB8PSBCV19PUE1PREVfMjBNSFo7DQo+ICsgICAg
ICAgICAgICAgICBydGxfd3JpdGVfYnl0ZShydGxwcml2LCBSRUdfQldPUE1PREUsIHJlZ19id19v
cG1vZGUpOw0KPiArICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgY2FzZSBIVF9DSEFO
TkVMX1dJRFRIXzIwXzQwOg0KPiArICAgICAgICAgICAgICAgcmVnX2J3X29wbW9kZSAmPSB+Qldf
T1BNT0RFXzIwTUhaOw0KPiArICAgICAgICAgICAgICAgcnRsX3dyaXRlX2J5dGUocnRscHJpdiwg
UkVHX0JXT1BNT0RFLCByZWdfYndfb3Btb2RlKTsNCj4gKw0KPiArICAgICAgICAgICAgICAgcmVn
X3Byc3JfcnNjID0gKHJlZ19wcnNyX3JzYyAmIDB4OTApIHwNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgKG1hYy0+Y3VyXzQwX3ByaW1lX3NjIDw8IDUpOw0KDQpuaXQ6DQoNCnJlZ19wcnNyX3Jz
YyA9IChyZWdfcHJzcl9yc2MgJiAweDkwKSB8DQogICAgICAgICAgICAgICAobWFjLT5jdXJfNDBf
cHJpbWVfc2MgPDwgNSk7DQoNCj4gKyAgICAgICAgICAgICAgIHJ0bF93cml0ZV9ieXRlKHJ0bHBy
aXYsIFJFR19SUlNSICsgMiwgcmVnX3Byc3JfcnNjKTsNCj4gKyAgICAgICAgICAgICAgIGJyZWFr
Ow0KPiArICAgICAgIGRlZmF1bHQ6DQo+ICsgICAgICAgICAgICAgICBwcl9lcnIoInVua25vd24g
YmFuZHdpZHRoOiAlI1hcbiIsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgcnRscGh5LT5jdXJy
ZW50X2NoYW5fYncpOw0KPiArICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgfQ0KPiAr
DQo+ICsgICAgICAgc3dpdGNoIChydGxwaHktPmN1cnJlbnRfY2hhbl9idykgew0KPiArICAgICAg
IGNhc2UgSFRfQ0hBTk5FTF9XSURUSF8yMDoNCj4gKyAgICAgICAgICAgICAgIHJ0bDkyZF9waHlf
c2V0X2JiX3JlZ18xYnl0ZShodywgUkZQR0EwX1JGTU9ELCBCUkZNT0QsIDB4MCk7DQo+ICsgICAg
ICAgICAgICAgICBydGxfc2V0X2JicmVnKGh3LCBSRlBHQTFfUkZNT0QsIEJSRk1PRCwgMHgwKTsN
Cj4gKyAgICAgICAgICAgICAgIC8qIFNFVCBCSVQxMCBCSVQxMSAgZm9yIHJlY2VpdmUgY2NrICov
DQo+ICsgICAgICAgICAgICAgICBydGxfc2V0X2JicmVnKGh3LCBSRlBHQTBfQU5BTE9HUEFSQU1F
VEVSMiwgQklUKDEwKSB8DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEJJVCgxMSks
IDMpOw0KDQpCcmVha2luZyBtYXNrIGFyZ3VtZW50IGlzIG5vdCBnb29kLiBTdWdnZXN0DQoNCgkJ
cnRsX3NldF9iYnJlZyhodywgUkZQR0EwX0FOQUxPR1BBUkFNRVRFUjIsIEJJVCgxMCkgfCBCSVQo
MTEpLCAzKTsNCg0KPiArICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgY2FzZSBIVF9D
SEFOTkVMX1dJRFRIXzIwXzQwOg0KPiArICAgICAgICAgICAgICAgcnRsOTJkX3BoeV9zZXRfYmJf
cmVnXzFieXRlKGh3LCBSRlBHQTBfUkZNT0QsIEJSRk1PRCwgMHgxKTsNCj4gKyAgICAgICAgICAg
ICAgIHJ0bF9zZXRfYmJyZWcoaHcsIFJGUEdBMV9SRk1PRCwgQlJGTU9ELCAweDEpOw0KPiArICAg
ICAgICAgICAgICAgLyogU2V0IENvbnRyb2wgY2hhbm5lbCB0byB1cHBlciBvciBsb3dlci4NCj4g
KyAgICAgICAgICAgICAgICAqIFRoZXNlIHNldHRpbmdzIGFyZSByZXF1aXJlZCBvbmx5IGZvciA0
ME1Ieg0KPiArICAgICAgICAgICAgICAgICovDQo+ICsgICAgICAgICAgICAgICBpZiAocnRsaGFs
LT5jdXJyZW50X2JhbmR0eXBlID09IEJBTkRfT05fMl80RykNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgcnRsX3NldF9iYnJlZyhodywgUkNDSzBfU1lTVEVNLCBCQ0NLU0lERUJBTkQsDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbWFjLT5jdXJfNDBfcHJpbWVfc2Mg
Pj4gMSk7DQo+ICsgICAgICAgICAgICAgICBydGxfc2V0X2JicmVnKGh3LCBST0ZETTFfTFNURiwg
MHhDMDAsIG1hYy0+Y3VyXzQwX3ByaW1lX3NjKTsNCj4gKyAgICAgICAgICAgICAgIC8qIFNFVCBC
SVQxMCBCSVQxMSAgZm9yIHJlY2VpdmUgY2NrICovDQo+ICsgICAgICAgICAgICAgICBydGxfc2V0
X2JicmVnKGh3LCBSRlBHQTBfQU5BTE9HUEFSQU1FVEVSMiwNCj4gKyAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgQklUKDEwKSB8IEJJVCgxMSksIDApOw0KPiArICAgICAgICAgICAgICAgcnRs
X3NldF9iYnJlZyhodywgMHg4MTgsIChCSVQoMjYpIHwgQklUKDI3KSksDQo+ICsgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIChtYWMtPmN1cl80MF9wcmltZV9zYyA9PQ0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBIQUxfUFJJTUVfQ0hOTF9PRkZTRVRfTE9XRVIpID8gMiA6IDEp
Ow0KDQpOZWVkIG9uZSBzcGFjZSBpbiBmcm9udCBvZiBIQUxfUFJJTUVfQ0hOTF9PRkZTRVRfTE9X
RVIsIGJ1dCBwYXJlbnRoZXNpcw0KaXMgdW5uZWNlc3NhcnksIHNvDQoNCnJ0bF9zZXRfYmJyZWco
aHcsIDB4ODE4LCAoQklUKDI2KSB8IEJJVCgyNykpLA0KICAgICAgICAgICAgICBtYWMtPmN1cl80
MF9wcmltZV9zYyA9PQ0KICAgICAgICAgICAgICBIQUxfUFJJTUVfQ0hOTF9PRkZTRVRfTE9XRVIg
PyAyIDogMSk7DQoNCg0KPiArICAgICAgICAgICAgICAgYnJlYWs7DQo+ICsgICAgICAgZGVmYXVs
dDoNCj4gKyAgICAgICAgICAgICAgIHByX2VycigidW5rbm93biBiYW5kd2lkdGg6ICUjWFxuIiwN
Cj4gKyAgICAgICAgICAgICAgICAgICAgICBydGxwaHktPmN1cnJlbnRfY2hhbl9idyk7DQo+ICsg
ICAgICAgICAgICAgICBicmVhazsNCj4gKyAgICAgICB9DQo+ICsNCj4gKyAgICAgICBydGw5MmRf
cGh5X3JmNjA1Ml9zZXRfYmFuZHdpZHRoKGh3LCBydGxwaHktPmN1cnJlbnRfY2hhbl9idyk7DQo+
ICsNCj4gKyAgICAgICBydGxwaHktPnNldF9id21vZGVfaW5wcm9ncmVzcyA9IGZhbHNlOw0KPiAr
ICAgICAgIHJ0bF9kYmcocnRscHJpdiwgQ09NUF9TQ0FOLCBEQkdfVFJBQ0UsICI8PT1cbiIpOw0K
PiArfQ0KPiArDQoNClsuLi5dDQoNCj4gK3N0YXRpYyB2b2lkIF9ydGw5MmRfcGh5X3N3aXRjaF9y
Zl9zZXR0aW5nKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LCB1OCBjaGFubmVsKQ0KPiArew0KPiAr
ICAgICAgIHN0cnVjdCBydGxfdXNiICpydGx1c2IgPSBydGxfdXNiZGV2KHJ0bF91c2Jwcml2KGh3
KSk7DQo+ICsgICAgICAgc3RydWN0IHJ0bF9wcml2ICpydGxwcml2ID0gcnRsX3ByaXYoaHcpOw0K
PiArICAgICAgIHN0cnVjdCBydGxfaGFsICpydGxoYWwgPSAmcnRscHJpdi0+cnRsaGFsOw0KPiAr
ICAgICAgIHN0cnVjdCBydGxfcGh5ICpydGxwaHkgPSAmcnRscHJpdi0+cGh5Ow0KPiArICAgICAg
IHU4IHBhdGggPSBydGxoYWwtPmN1cnJlbnRfYmFuZHR5cGUgPT0gQkFORF9PTl81RyA/IFJGOTBf
UEFUSF9BDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIDogUkY5MF9QQVRIX0I7DQo+ICsgICAgICAgdTMyIHU0cmVndmFsdWUsIG1hc2sg
PSAweDFDMDAwLCB2YWx1ZSA9IDAsIHU0dG1wLCB1NHRtcDI7DQo+ICsgICAgICAgYm9vbCBuZWVk
X3B3cl9kb3duID0gZmFsc2UsIGludGVybmFsX3BhID0gZmFsc2U7DQo+ICsgICAgICAgdTMyIHJl
Z2IzMCA9IHJ0bF9nZXRfYmJyZWcoaHcsIDB4YjMwLCBCSVQoMjcpKTsNCj4gKyAgICAgICB1OCBp
bmRleCA9IDAsIGkgPSAwLCByZnBhdGggPSBSRjkwX1BBVEhfQTsNCg0KaW5pdGlhbGl6ZXJzIG9m
IGkgYW5kIHJmcGF0aCBhcmUgdW5uZWNlc3NhcnkuIA0KDQpbLi4uXQ0KDQo+ICtzdGF0aWMgdm9p
ZCBfcnRsOTJkX3BoeV9wYXRoYV9maWxsX2lxa19tYXRyaXgoc3RydWN0IGllZWU4MDIxMV9odyAq
aHcsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBib29s
IGlxa19vaywgbG9uZyByZXN1bHRbXVs4XSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgIHU4IGZpbmFsX2NhbmRpZGF0ZSwgYm9vbCB0eG9ubHkpDQo+ICt7
DQo+ICsgICAgICAgc3RydWN0IHJ0bF9wcml2ICpydGxwcml2ID0gcnRsX3ByaXYoaHcpOw0KPiAr
ICAgICAgIHN0cnVjdCBydGxfaGFsICpydGxoYWwgPSAmcnRscHJpdi0+cnRsaGFsOw0KPiArICAg
ICAgIHUzMiBvbGR2YWxfMCwgdmFsX3gsIHR4MF9hLCByZWc7DQo+ICsgICAgICAgbG9uZyB2YWxf
eSwgdHgwX2M7DQo+ICsgICAgICAgYm9vbCBpczJ0ID0gSVNfOTJEX1NJTkdMRVBIWShydGxoYWwt
PnZlcnNpb24pIHx8DQo+ICsgICAgICAgICAgICAgICAgICAgcnRsaGFsLT5tYWNwaHltb2RlID09
IERVQUxNQUNfRFVBTFBIWTsNCj4gKw0KPiArICAgICAgIGlmIChydGxoYWwtPmN1cnJlbnRfYmFu
ZHR5cGUgPT0gQkFORF9PTl81Rykgew0KPiArICAgICAgICAgICAgICAgX3J0bDkyZF9waHlfcGF0
aGFfZmlsbF9pcWtfbWF0cml4XzVnX25vcm1hbChodywgaXFrX29rLCByZXN1bHQsDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGZp
bmFsX2NhbmRpZGF0ZSwNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgdHhvbmx5KTsNCj4gKyAgICAgICAgICAgICAgIHJldHVybjsN
Cj4gKyAgICAgICB9DQo+ICsNCj4gKyAgICAgICBSVFBSSU5UKHJ0bHByaXYsIEZJTklULCBJTklU
X0lRSywNCj4gKyAgICAgICAgICAgICAgICJQYXRoIEEgSVEgQ2FsaWJyYXRpb24gJXMgIVxuIiwg
aXFrX29rID8gIlN1Y2Nlc3MiIDogIkZhaWxlZCIpOw0KPiArICAgICAgIGlmIChmaW5hbF9jYW5k
aWRhdGUgPT0gMHhGRikgew0KPiArICAgICAgICAgICAgICAgcmV0dXJuOw0KPiArICAgICAgIH0g
ZWxzZSBpZiAoaXFrX29rKSB7DQoNCmlmIChmaW5hbF9jYW5kaWRhdGUgPT0gMHhGRiB8fCAhaXFr
X29rKQ0KICAgIHJldHVybjsNCg0KUmVkdWNlIG9uZSBsZXZlbCBpbmRlbnQgZm9yIGZvbGxvd2lu
ZyBzdGF0ZW1lbnRzLg0KDQooc2ltaWxhciBwYXR0ZXJuIHRvIF9ydGw5MmRfcGh5X3BhdGhiX2Zp
bGxfaXFrX21hdHJpeCkNCg0KWy4uLl0NCg0KDQo+ICt2b2lkIHJ0bDkyZF9waHlfc2V0X3Bvd2Vy
b24oc3RydWN0IGllZWU4MDIxMV9odyAqaHcpDQo+ICt7DQo+ICsgICAgICAgc3RydWN0IHJ0bF9w
cml2ICpydGxwcml2ID0gcnRsX3ByaXYoaHcpOw0KPiArICAgICAgIHN0cnVjdCBydGxfaGFsICpy
dGxoYWwgPSBydGxfaGFsKHJ0bF9wcml2KGh3KSk7DQo+ICsgICAgICAgdTMyIG1hY19yZWcgPSAo
cnRsaGFsLT5pbnRlcmZhY2VpbmRleCA9PSAwID8gUkVHX01BQzAgOiBSRUdfTUFDMSk7DQo+ICsg
ICAgICAgdTggdmFsdWU4Ow0KPiArICAgICAgIHUxNiBpOw0KPiArDQo+ICsgICAgICAgLyogbm90
aWNlIGZ3IGtub3cgYmFuZCBzdGF0dXMgIDB4ODFbMV0vMHg1M1sxXSA9IDA6IDVHLCAxOiAyRyAq
Lw0KPiArICAgICAgIGlmIChydGxoYWwtPmN1cnJlbnRfYmFuZHR5cGUgPT0gQkFORF9PTl8yXzRH
KSB7DQo+ICsgICAgICAgICAgICAgICB2YWx1ZTggPSBydGxfcmVhZF9ieXRlKHJ0bHByaXYsIG1h
Y19yZWcpOw0KPiArICAgICAgICAgICAgICAgdmFsdWU4IHw9IEJJVCgxKTsNCj4gKyAgICAgICAg
ICAgICAgIHJ0bF93cml0ZV9ieXRlKHJ0bHByaXYsIG1hY19yZWcsIHZhbHVlOCk7DQo+ICsgICAg
ICAgfSBlbHNlIHsNCj4gKyAgICAgICAgICAgICAgIHZhbHVlOCA9IHJ0bF9yZWFkX2J5dGUocnRs
cHJpdiwgbWFjX3JlZyk7DQo+ICsgICAgICAgICAgICAgICB2YWx1ZTggJj0gKH5CSVQoMSkpOw0K
DQpubyBuZWVkIHBhcmVudGhlc2lzIGFyb3VuZCB+QklUKDEpLg0KDQpbLi4uXQ0KDQo=

