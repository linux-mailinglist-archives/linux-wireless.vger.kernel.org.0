Return-Path: <linux-wireless+bounces-7011-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1227D8B670D
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 02:50:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BD58228521F
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Apr 2024 00:50:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 10840161;
	Tue, 30 Apr 2024 00:50:45 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B9B10E4
	for <linux-wireless@vger.kernel.org>; Tue, 30 Apr 2024 00:50:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714438244; cv=none; b=kzARJ4l5xGJj0qBGxNmxxOxEBG+uHJIQ9CSlN6Wvu9Mpe1buMTOVa5Ppetmwr5IuIOqMILijYw3TEtiZJXGTUWuz9adtoUVlVL9gq1qhpsX1RIqNT0iZkGXdy3Q+Z/9nUJubaSOs0I5fkAR8Kr5Ly4kIOg13+0eaSugZzLQoSYY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714438244; c=relaxed/simple;
	bh=xYmN/5nWp4YPAVnNcm2RuzGM0tKa6rf/DOGtMxTJI84=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lTa025WvJCCbtyHH4XkKG3agms5nYomnGKFiCnHxwDKyxEsxdXCAcNj7a6p/bcwDwE2d2jFrrOx2YIth//g9lMBx68dIoTYb9xGS7brcH25CH7InLD9mbxmd2BXQ+MnWayFAVEYMcGZeDFHlxAw/MQwtEibqwexMP5WIiTQL9VA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43U0oLxtD3997785, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43U0oLxtD3997785
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Apr 2024 08:50:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 08:50:08 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Apr 2024 08:50:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 30 Apr 2024 08:50:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>,
        Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
Subject: RE: [PATCH] wifi: rtw88: usb: Fix disconnection after beacon loss
Thread-Topic: [PATCH] wifi: rtw88: usb: Fix disconnection after beacon loss
Thread-Index: AQHaml7G/YGDVzjzSEOy9Pi+H/FoIbF/+Jnw
Date: Tue, 30 Apr 2024 00:50:08 +0000
Message-ID: <5b2e95cdac3d400eb2c9ef2eb20dc221@realtek.com>
References: <ecbf0601-810d-4609-b8fc-8b0e38d2948d@gmail.com>
In-Reply-To: <ecbf0601-810d-4609-b8fc-8b0e38d2948d@gmail.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

K0NjOiBNYXJ0aW4gZm9yIHJ0dzg4IFNESU8gdGhhdCBzZWVtcyBoYXZlIHRoZSBzYW1lIHByb2Js
ZW0gDQoNCkJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPiB3cm90ZToN
Cj4gV2hlbiB0aGVyZSBpcyBiZWFjb24gbG9zcywgZm9yIGV4YW1wbGUgZHVlIHRvIHVucmVsYXRl
ZCBCbHVldG9vdGgNCj4gZGV2aWNlcyB0cmFuc21pdHRpbmcgbXVzaWMgbmVhcmJ5LCB0aGUgd2lm
aSBjb25uZWN0aW9uIGRpZXMgc29vbg0KPiBhZnRlciB0aGUgZmlyc3QgYmVhY29uIGxvc3MgbWVz
c2FnZToNCj4gDQo+IEFwciAyOCAyMDo0NzoxNCBpZGVhcGFkMiB3cGFfc3VwcGxpY2FudFsxMTYx
XTogd2xwM3MwZjN1NDoNCj4gIENUUkwtRVZFTlQtQkVBQ09OLUxPU1MNCj4gQXByIDI4IDIwOjQ3
OjE1IGlkZWFwYWQyIHdwYV9zdXBwbGljYW50WzExNjFdOiB3bHAzczBmM3U0Og0KPiAgQ1RSTC1F
VkVOVC1ESVNDT05ORUNURUQgYnNzaWQ9Li4uIHJlYXNvbj00IGxvY2FsbHlfZ2VuZXJhdGVkPTEN
Cj4gDQo+IEFwciAyOCAyMDo0NzoyNCBpZGVhcGFkMiB3cGFfc3VwcGxpY2FudFsxMTYxXTogd2xw
M3MwZjN1NDoNCj4gIENUUkwtRVZFTlQtQkVBQ09OLUxPU1MNCj4gQXByIDI4IDIwOjQ3OjI1IGlk
ZWFwYWQyIHdwYV9zdXBwbGljYW50WzExNjFdOiB3bHAzczBmM3U0Og0KPiAgQ1RSTC1FVkVOVC1E
SVNDT05ORUNURUQgYnNzaWQ9Li4uIHJlYXNvbj00IGxvY2FsbHlfZ2VuZXJhdGVkPTENCj4gDQo+
IEFwciAyOCAyMDo0NzozNCBpZGVhcGFkMiB3cGFfc3VwcGxpY2FudFsxMTYxXTogd2xwM3MwZjN1
NDoNCj4gIENUUkwtRVZFTlQtQkVBQ09OLUxPU1MNCj4gQXByIDI4IDIwOjQ3OjM1IGlkZWFwYWQy
IHdwYV9zdXBwbGljYW50WzExNjFdOiB3bHAzczBmM3U0Og0KPiAgQ1RSTC1FVkVOVC1ESVNDT05O
RUNURUQgYnNzaWQ9Li4uIHJlYXNvbj00IGxvY2FsbHlfZ2VuZXJhdGVkPTENCj4gDQo+IFdoZW4g
dGhlIGJlYWNvbiBsb3NzIGhhcHBlbnMsIG1hYzgwMjExIG1ha2VzIHJ0dzg4IHRyYW5zbWl0IGEg
UU9TDQo+IE5VTEwgZnJhbWUgYW5kIGFza3MgdG8gY29uZmlybSB0aGUgQUNLIHN0YXR1cy4gRXZl
biB0aG91Z2ggcnR3ODgNCj4gY29uZmlybXMgdG8gbWFjODAyMTEgdGhhdCB0aGUgUU9TIE5VTEwg
d2FzIHRyYW5zbWl0dGVkIHN1Y2Nlc3NmdWxseSwNCj4gdGhlIGNvbm5lY3Rpb24gc3RpbGwgZGll
cy4gVGhpcyBpcyBiZWNhdXNlIHJ0dzg4IGlzIGhhbmRpbmcgdGhlIFFPUw0KPiBOVUxMIGJhY2sg
dG8gbWFjODAyMTEgd2l0aCBza2ItPmRhdGEgcG9pbnRpbmcgdG8gdGhlIGhlYWRyb29tICh0aGUN
Cj4gVFggZGVzY3JpcHRvcikgaW5zdGVhZCBvZiBpZWVlODAyMTFfaGRyLg0KPiANCj4gRml4IHRo
ZSBkaXNjb25uZWN0aW9uIGJ5IG1vdmluZyBza2ItPmRhdGEgdG8gdGhlIGNvcnJlY3QgcG9zaXRp
b24NCj4gYmVmb3JlIGllZWU4MDIxMV90eF9zdGF0dXNfaXJxc2FmZSgpLg0KPiANCj4gVGhlIHBy
b2JsZW0gd2FzIG9ic2VydmVkIHdpdGggUlRMODgxMUFVIChUUC1MaW5rIEFyY2hlciBUMlUgTmFu
bykNCj4gYW5kIHRoZSBwb3RlbnRpYWwgZnV0dXJlIHJ0dzg4Xzg4MjFhdSBkcml2ZXIuIEFsc28g
dGVzdGVkIHdpdGgNCj4gUlRMODgxMUNVIChUZW5kYSBVOSkuDQo+IA0KPiBDYzogc3RhYmxlQHZn
ZXIua2VybmVsLm9yZw0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIx
Y2VyZmUyQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0dzg4L3VzYi5jIHwgMiArKw0KPiAgMSBmaWxlIGNoYW5nZWQsIDIgaW5zZXJ0aW9ucygrKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvdXNi
LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3VzYi5jDQo+IGluZGV4IDNi
YTdiODFjNjA4MC4uMWRmZTdjNmFlNGJhIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJl
bGVzcy9yZWFsdGVrL3J0dzg4L3VzYi5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODgvdXNiLmMNCj4gQEAgLTI3OCw2ICsyNzgsOCBAQCBzdGF0aWMgdm9pZCBydHdf
dXNiX3dyaXRlX3BvcnRfdHhfY29tcGxldGUoc3RydWN0IHVyYiAqdXJiKQ0KPiAgICAgICAgICAg
ICAgICAgaW5mbyA9IElFRUU4MDIxMV9TS0JfQ0Ioc2tiKTsNCj4gICAgICAgICAgICAgICAgIHR4
X2RhdGEgPSBydHdfdXNiX2dldF90eF9kYXRhKHNrYik7DQo+IA0KPiArICAgICAgICAgICAgICAg
c2tiX3B1bGwoc2tiLCBydHdkZXYtPmNoaXAtPnR4X3BrdF9kZXNjX3N6KTsNCj4gKw0KDQpUaGVy
ZSBhcmUgdHdvIGNhc2VzIG9mIGFyZ3VtZW50cyBvZiBza2JfcHVzaCgpIGZvciBVU0I6IA0KMS4g
c2tiX3B1c2goc2tiLCBjaGlwLT50eF9wa3RfZGVzY19zeik7DQoyLiBza2JfcHVzaChza2IsIGhl
YWRzaXplKTsNCiAgIGhlYWRzaXplID0gcGt0X2luZm8tPm9mZnNldCA/IHBrdF9pbmZvLT5vZmZz
ZXQgOiBkZXNjbGVuOw0KICAgICAgcGt0X2luZm8tPm9mZnNldCA9IGNoaXAtPnR4X3BrdF9kZXNj
X3N6Ow0KICAgICAgZGVzY2xlbiA9IGNoaXAtPnR4X3BrdF9kZXNjX3N6Ow0KDQpFdmVudHVhbGx5
IGFsbCBhcmUgY2hpcC0+dHhfcGt0X2Rlc2Nfc3osIGJ1dCBzcGVuZCBhIGxpdHRsZSB0aW1lIHRv
IGVuc3VyZSB0aGlzLg0KQ291bGQgeW91IHRlc3QgYW5kIGhhdmUgYW5vdGhlciBwYXRjaCB0byBj
aGFuZ2UgYWJvdmUgY2FzZSAoMikgdG8gKDEpPw0KDQo+ICAgICAgICAgICAgICAgICAvKiBlbnF1
ZXVlIHRvIHdhaXQgZm9yIHR4IHJlcG9ydCAqLw0KPiAgICAgICAgICAgICAgICAgaWYgKGluZm8t
PmZsYWdzICYgSUVFRTgwMjExX1RYX0NUTF9SRVFfVFhfU1RBVFVTKSB7DQo+ICAgICAgICAgICAg
ICAgICAgICAgICAgIHJ0d190eF9yZXBvcnRfZW5xdWV1ZShydHdkZXYsIHNrYiwgdHhfZGF0YS0+
c24pOw0KPiAtLQ0KPiAyLjQ0LjANCg0K

