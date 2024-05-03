Return-Path: <linux-wireless+bounces-7127-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 386AD8BA494
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 02:35:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B648E1F221BE
	for <lists+linux-wireless@lfdr.de>; Fri,  3 May 2024 00:35:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACB787494;
	Fri,  3 May 2024 00:35:22 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DC5D36B
	for <linux-wireless@vger.kernel.org>; Fri,  3 May 2024 00:35:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714696522; cv=none; b=JW6N5v5EhbeCZspo+4Da+GTzQSmFZDzH+U4ri2uTtzMq+FV7hz7HaWavLTPu8Ow1amRwxi32zmr2PQADapowHi2rl62YoBwl30wMcOCWbp6pBHEpmwvGkXUj9hBFFYw5oL4/Wz8AHKbtJOCIMU6xP787Kqw5sAmDrvntMQpvkaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714696522; c=relaxed/simple;
	bh=3gI/oouvs0aYDU/54S4yfOdUqKqMtJ3OXn2nkxNvmok=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=IvIs3LDMn/A6RijRu8dhz1vDNhA0KZ1g2JAdyhB1kPJsS+b5zNhSX0jZ+Ow2vHzC8V0p+OTP88MtMlhNheG/U4tem0zVsIcZpXQrGT7++ZGVVDi61duWp/OAZkq0kcVX1OpzeYhIgp0haVjD9fEHxzYWOeRWWokq41TrcDmfpFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4430Z2e443003649, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4430Z2e443003649
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 3 May 2024 08:35:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 08:35:03 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 3 May 2024 08:35:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 3 May 2024 08:35:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH] wifi: rtw88: usb: Simplify rtw_usb_write_data
Thread-Topic: [PATCH] wifi: rtw88: usb: Simplify rtw_usb_write_data
Thread-Index: AQHanNb1VkiF4IiuNkOiHUQ2TvchpbGEqUKg
Date: Fri, 3 May 2024 00:35:02 +0000
Message-ID: <c90907baf8554581bbdb51e65dcd943e@realtek.com>
References: <681e03c1-d19e-44de-bc45-e71ce14c5ed2@gmail.com>
In-Reply-To: <681e03c1-d19e-44de-bc45-e71ce14c5ed2@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGUg
c2tiIGNyZWF0ZWQgaW4gdGhpcyBmdW5jdGlvbiBhbHdheXMgaGFzIHRoZSBzYW1lIGhlYWRyb29t
LA0KPiB0aGUgY2hpcCdzIFRYIGRlc2NyaXB0b3Igc2l6ZS4gVXNlIGNoaXAtPnR4X3BrdF9kZXNj
X3N6IGRpcmVjdGx5Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRs
ODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IC0tLQ0KPiBUaGlzIGlzIHRoZSBwYXRjaCBJIHByb21p
c2VkIGVhcmxpZXI6DQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzL2Nh
ZTJkMzMwLWE0ZmItNDU3MC05ZGRlLTA5Njg0YWYyM2ZmZEBnbWFpbC5jb20vDQo+IC0tLQ0KPiAg
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC91c2IuYyB8IDE0ICsrKysrLS0tLS0t
LS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspLCA5IGRlbGV0aW9ucygtKQ0K
PiANCj4gZGlmZiAtLWdpdCBhL3VzYi5jIGIvdXNiLmMNCj4gaW5kZXggMWRmZTdjNmFlNGJhLi5m
ZjU3OTc2YjlkM2IgMTAwNjQ0DQo+IC0tLSBhL3VzYi5jDQo+ICsrKyBiL3VzYi5jDQo+IEBAIC00
NDAsMjMgKzQ0MCwyMSBAQCBzdGF0aWMgaW50IHJ0d191c2Jfd3JpdGVfZGF0YShzdHJ1Y3QgcnR3
X2RldiAqcnR3ZGV2LA0KPiAgew0KPiAgICAgICAgIGNvbnN0IHN0cnVjdCBydHdfY2hpcF9pbmZv
ICpjaGlwID0gcnR3ZGV2LT5jaGlwOw0KPiAgICAgICAgIHN0cnVjdCBza19idWZmICpza2I7DQo+
IC0gICAgICAgdW5zaWduZWQgaW50IGRlc2NsZW4sIGhlYWRzaXplLCBzaXplOw0KPiArICAgICAg
IHVuc2lnbmVkIGludCBzaXplOw0KPiAgICAgICAgIHU4IHFzZWw7DQo+ICAgICAgICAgaW50IHJl
dCA9IDA7DQo+IA0KPiAgICAgICAgIHNpemUgPSBwa3RfaW5mby0+dHhfcGt0X3NpemU7DQo+ICAg
ICAgICAgcXNlbCA9IHBrdF9pbmZvLT5xc2VsOw0KPiAtICAgICAgIGRlc2NsZW4gPSBjaGlwLT50
eF9wa3RfZGVzY19zejsNCj4gLSAgICAgICBoZWFkc2l6ZSA9IHBrdF9pbmZvLT5vZmZzZXQgPyBw
a3RfaW5mby0+b2Zmc2V0IDogZGVzY2xlbjsNCj4gDQo+IC0gICAgICAgc2tiID0gZGV2X2FsbG9j
X3NrYihoZWFkc2l6ZSArIHNpemUpOw0KPiArICAgICAgIHNrYiA9IGRldl9hbGxvY19za2IoY2hp
cC0+dHhfcGt0X2Rlc2Nfc3ogKyBzaXplKTsNCj4gICAgICAgICBpZiAodW5saWtlbHkoIXNrYikp
DQo+ICAgICAgICAgICAgICAgICByZXR1cm4gLUVOT01FTTsNCj4gDQo+IC0gICAgICAgc2tiX3Jl
c2VydmUoc2tiLCBoZWFkc2l6ZSk7DQo+ICsgICAgICAgc2tiX3Jlc2VydmUoc2tiLCBjaGlwLT50
eF9wa3RfZGVzY19zeik7DQo+ICAgICAgICAgc2tiX3B1dF9kYXRhKHNrYiwgYnVmLCBzaXplKTsN
Cj4gLSAgICAgICBza2JfcHVzaChza2IsIGhlYWRzaXplKTsNCj4gLSAgICAgICBtZW1zZXQoc2ti
LT5kYXRhLCAwLCBoZWFkc2l6ZSk7DQo+ICsgICAgICAgc2tiX3B1c2goc2tiLCBjaGlwLT50eF9w
a3RfZGVzY19zeik7DQo+ICsgICAgICAgbWVtc2V0KHNrYi0+ZGF0YSwgMCwgY2hpcC0+dHhfcGt0
X2Rlc2Nfc3opOw0KPiAgICAgICAgIHJ0d190eF9maWxsX3R4X2Rlc2MocGt0X2luZm8sIHNrYik7
DQo+ICAgICAgICAgcnR3X3R4X2ZpbGxfdHhkZXNjX2NoZWNrc3VtKHJ0d2RldiwgcGt0X2luZm8s
IHNrYi0+ZGF0YSk7DQo+IA0KPiBAQCAtNDcxLDEyICs0NjksMTAgQEAgc3RhdGljIGludCBydHdf
dXNiX3dyaXRlX2RhdGEoc3RydWN0IHJ0d19kZXYgKnJ0d2RldiwNCj4gIHN0YXRpYyBpbnQgcnR3
X3VzYl93cml0ZV9kYXRhX3JzdmRfcGFnZShzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LCB1OCAqYnVm
LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgdTMyIHNpemUpDQo+
ICB7DQo+IC0gICAgICAgY29uc3Qgc3RydWN0IHJ0d19jaGlwX2luZm8gKmNoaXAgPSBydHdkZXYt
PmNoaXA7DQo+ICAgICAgICAgc3RydWN0IHJ0d190eF9wa3RfaW5mbyBwa3RfaW5mbyA9IHswfTsN
Cj4gDQo+ICAgICAgICAgcGt0X2luZm8udHhfcGt0X3NpemUgPSBzaXplOw0KPiAgICAgICAgIHBr
dF9pbmZvLnFzZWwgPSBUWF9ERVNDX1FTRUxfQkVBQ09OOw0KPiAtICAgICAgIHBrdF9pbmZvLm9m
ZnNldCA9IGNoaXAtPnR4X3BrdF9kZXNjX3N6Ow0KDQpwa3RfaW5mby5vZmZzZXQgaXMgc3RpbGwg
dXNlZCBieSBydHdfdHhfZmlsbF90eF9kZXNjKCksIHNvIHlvdSBjYW4ndCByZW1vdmUNCnRoaXMg
bGluZS4gSSB0aGluayB0aGlzIGlzIGJlY2F1c2UgTGFycnkgTkFLZWQgdGhpcyBwYXRjaC4gDQoN
Cg0K

