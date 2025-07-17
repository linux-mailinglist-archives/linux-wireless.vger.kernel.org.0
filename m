Return-Path: <linux-wireless+bounces-25559-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4D8FFB08158
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 02:20:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 468104A5F39
	for <lists+linux-wireless@lfdr.de>; Thu, 17 Jul 2025 00:20:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 02E6C645;
	Thu, 17 Jul 2025 00:20:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="luSlqWy9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92FA02E3701
	for <linux-wireless@vger.kernel.org>; Thu, 17 Jul 2025 00:20:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752711639; cv=none; b=FHv/5wmKjZDz/TdsMntMn3Opq0ep5+ovVPnzt4wRz8DVJe+MbxtWvqzXYSXd20JMJXYgq6bZePSN9rBhvBEv7yMFIbvo/DK/S3yP+zGTBl4V7uLvulb3eRuz7BneVXhJlSEBVAZ3287FKJTTzELE9ZZ++D6HzmqzON8zJlIsjbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752711639; c=relaxed/simple;
	bh=ZGMECaGitI7q1F+AownTONHb2OP6Oa867UcQnE8AZGE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qHIaatFVFy3Dm0gQDxciEZUfKmBT60ume8jMPruUb++9/76A/v5U8aXIUkIo2j6iI+wqcjcYQ2staY/vwc8aSI/ilgsUyXtTTfBjojicSRaAETt7n6GfkLdylT/rV5wPTOa8SlE8wEawu7+8UYRFcVHnYUCn0OV/XjAkm6eOM5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=luSlqWy9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56H0KWjnC3135333, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1752711632; bh=ZGMECaGitI7q1F+AownTONHb2OP6Oa867UcQnE8AZGE=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=luSlqWy9MsPKhEDK1BRou4pbP6zrLunv9tjP5ofp2Skyq0mIlFcLc30rUJHPfzO0v
	 aFtDF9DnYtRNpkFJIzhexbAOvN/5D7gKEh43oIaIxfegAanpomsmURYd2GBGQ0BXap
	 mzKt/hjL0Rl7wvqxOaKznHATSb+LVCzGLBf0LqEBP7Aqe1WWHIxmOjX6APl4q48OCx
	 QEaVsioAAxoyT8Te49X7uB+2PT+s6Hzjtcncdp/ue+IjfLPf0r98k3Aa6x/AzGtagA
	 NO12MEitjY7FaeLXA10mB4L/n5pZbM1a6qAUrud7NCKCuy8+wDqTiWixIrV1bE/TkV
	 SE7TH4h9ig7sw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56H0KWjnC3135333
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 17 Jul 2025 08:20:32 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 17 Jul 2025 08:20:32 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 17 Jul 2025 08:20:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Thu, 17 Jul 2025 08:20:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 1/2] wifi: rtw89: Lower the timeout in rtw89_fw_read_c2h_reg() for USB
Thread-Topic: [PATCH rtw-next v2 1/2] wifi: rtw89: Lower the timeout in
 rtw89_fw_read_c2h_reg() for USB
Thread-Index: AQHb9cDvTeQ1hJc5tUKW4VZya+p+RbQz4dmwgADepACAALSAwA==
Date: Thu, 17 Jul 2025 00:20:31 +0000
Message-ID: <03c5ab84de5e459b87c9c529818ec4e2@realtek.com>
References: <09313da6-c865-4e91-b758-4cb38a878796@gmail.com>
 <e3db33c50a7b4729947816551c5eba17@realtek.com>
 <0dab5755-4801-46c4-b78d-d8d3f0cf042b@gmail.com>
In-Reply-To: <0dab5755-4801-46c4-b78d-d8d3f0cf042b@gmail.com>
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
Ni8wNy8yMDI1IDAzOjE3LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBUaGlzIHJlYWRfcG9sbF90
aW1lb3V0X2F0b21pYygpIHdpdGggYSBkZWxheSBvZiAxIMK1cyBhbmQgYSB0aW1lb3V0IG9mDQo+
ID4+IDEwMDAwMDAgwrVzIGNhbiB0YWtlIH4yNTAgc2Vjb25kcyBpbiB0aGUgd29yc3QgY2FzZSBi
ZWNhdXNlIHNlbmRpbmcgYQ0KPiA+PiBVU0IgY29udHJvbCBtZXNzYWdlIHRha2VzIH4yNTAgwrVz
Lg0KPiA+Pg0KPiA+PiBMb3dlciB0aGUgdGltZW91dCB0byA0MDAwIGZvciBVU0IgaW4gb3JkZXIg
dG8gcmVkdWNlIHRoZSBtYXhpbXVtIHBvbGxpbmcNCj4gPj4gdGltZSB0byB+MSBzZWNvbmQuDQo+
ID4+DQo+ID4+IFRoaXMgcHJvYmxlbSB3YXMgb2JzZXJ2ZWQgd2l0aCBSVEw4ODUxQlUgd2hpbGUg
c3VzcGVuZGluZyB0byBSQU0gd2l0aA0KPiA+PiBXT1dMQU4gZW5hYmxlZC4gVGhlIGNvbXB1dGVy
IHNhdCBmb3IgNCBtaW51dGVzIHdpdGggYSBibGFjayBzY3JlZW4NCj4gPj4gYmVmb3JlIHN1c3Bl
bmRpbmcuDQo+ID4+DQo+ID4+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4
MjFjZXJmZTJAZ21haWwuY29tPg0KPiA+PiAtLS0NCj4gPj4gdjI6DQo+ID4+ICAtIExvd2VyIHRo
ZSB0aW1lb3V0IGZvciBVU0IgaW5zdGVhZCBvZiBpbmNyZWFzaW5nIHRoZSBkZWxheS4NCj4gPj4g
LS0tDQo+ID4+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2Z3LmMgfCA5ICsr
KysrKystLQ0KPiA+PiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5oIHwg
MiArKw0KPiA+PiAgMiBmaWxlcyBjaGFuZ2VkLCA5IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25z
KC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0dzg5L2Z3LmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2Z3LmMNCj4g
Pj4gaW5kZXggNzNhNGVjOTg4ZDE2Li5iNzc0YTMyOWU3YzcgMTAwNjQ0DQo+ID4+IC0tLSBhL2Ry
aXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvZncuYw0KPiA+PiArKysgYi9kcml2ZXJz
L25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2Z3LmMNCj4gPj4gQEAgLTY3NTUsMTMgKzY3NTUs
MTggQEAgc3RhdGljIGludCBydHc4OV9md19yZWFkX2MyaF9yZWcoc3RydWN0IHJ0dzg5X2RldiAq
cnR3ZGV2LA0KPiA+PiAgICAgICAgIGNvbnN0IHN0cnVjdCBydHc4OV9jaGlwX2luZm8gKmNoaXAg
PSBydHdkZXYtPmNoaXA7DQo+ID4+ICAgICAgICAgc3RydWN0IHJ0dzg5X2Z3X2luZm8gKmZ3X2lu
Zm8gPSAmcnR3ZGV2LT5mdzsNCj4gPj4gICAgICAgICBjb25zdCB1MzIgKmMyaF9yZWcgPSBjaGlw
LT5jMmhfcmVnczsNCj4gPj4gLSAgICAgICB1MzIgcmV0Ow0KPiA+PiArICAgICAgIHUzMiByZXQs
IHRpbWVvdXQ7DQo+ID4+ICAgICAgICAgdTggaSwgdmFsOw0KPiA+Pg0KPiA+PiAgICAgICAgIGlu
Zm8tPmlkID0gUlRXODlfRldDTURfQzJIUkVHX0ZVTkNfTlVMTDsNCj4gPj4NCj4gPj4gKyAgICAg
ICBpZiAocnR3ZGV2LT5oY2kudHlwZSA9PSBSVFc4OV9IQ0lfVFlQRV9VU0IpDQo+ID4+ICsgICAg
ICAgICAgICAgICB0aW1lb3V0ID0gUlRXODlfQzJIX1RJTUVPVVRfVVNCOw0KPiA+DQo+ID4gU2hv
dWxkIHdlIGhhdmUgZGlmZmVyZW50IHRpbWVvdXQgdGltZXMgZm9yIFVTQjIgYW5kIFVTQjM/DQo+
ID4gVGhlIHNhbWUgcXVlc3Rpb24gZm9yIHBhdGNoIDIvMi4NCj4gPg0KPiANCj4gSSBtZWFzdXJl
ZCB0aGUgdGltZSBpdCB0YWtlcyB0byByZWFkIFJfQVhfV0NQVV9GV19DVFJMIChwYXRjaCAyLzIp
Og0KPiANCj4gICAgICAgICAgICAgICAgIFVTQiAyICAgICAgICAgICBVU0IgMw0KPiBSVEw4ODUx
QlUgICAgICAgMTI1IMK1cyAgICAgICAgICBub3Qgc3VwcG9ydGVkDQo+IFJUTDg4NTJCVSAgICAg
ICAyNTAgwrVzICAgICAgICAgIDQwIMK1cw0KPiBSVEw4ODUyQ1UgICAgICAgMzc1IMK1cyAgICAg
ICAgICA0MCDCtXMNCj4gDQo+IEluIG15IHNldHVwIHRoZSBzYW1lIHRpbWVvdXQgd29ya3MgZm9y
IGJvdGguIEV2ZW4gd2l0aCB0aGUgZmFzdGVyIHJlYWRzDQo+IGl0IHN0aWxsIHdhaXRzIGxvbmcg
ZW5vdWdoLg0KDQpUaGFua3MgZm9yIHRoZSBpbmZvLiANCg0KDQo=

