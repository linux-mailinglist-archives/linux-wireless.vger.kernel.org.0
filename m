Return-Path: <linux-wireless+bounces-23402-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 4E3FEAC3819
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 04:52:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F0CD93B0588
	for <lists+linux-wireless@lfdr.de>; Mon, 26 May 2025 02:52:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E1B028E3F;
	Mon, 26 May 2025 02:52:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GljWwjOZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3F7A24B26
	for <linux-wireless@vger.kernel.org>; Mon, 26 May 2025 02:52:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748227955; cv=none; b=DkZS+fMd+ISAMGG89aEL4cFMyJNk9+bMON7+mnJvmV7DLDGXuX9b0BnvQNTU5iJ4C4/xrXRTtrRg/hhvGKdupRFDq7pqA0whjkSN6wC2KRQFwr5a32FU0kkb6nz9b0frsnoX5NO73CZtlssnRI6vk4YxysaQiqnyqTX5qyohNeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748227955; c=relaxed/simple;
	bh=oBoPpLyjwtUVN7NbrkRAJteaAZSrHtG9VpnSjAIk0io=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=oqXUhvCCvPkUNNzhaqiMjcbPbAiGNoPuvFU/OaW4uRGy3x1+aHWirH+cs+OcxjtgiWg1YbnS40LMqtATUWNA6HEiL4TYdHD0MCxT2WqfkRJTMIi3gVtWV5KEy76kxE/PBhqxsBeLfn4YaTHQITqJdNeVFK/hdSBAGUhZRNUbZSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GljWwjOZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54Q2qTr453026557, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1748227949; bh=oBoPpLyjwtUVN7NbrkRAJteaAZSrHtG9VpnSjAIk0io=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GljWwjOZdHa6esBkT6A3/+7oEPn7qJEPFSLQy9+hymGUQMgB7c9jPs2Wt/G6grP6Z
	 8/irp4rT8kzRM7CkGdpEmC1VJ3+6mcsTtADqPiMK8dU/2af0F9D3ANM0og5Q2nyNig
	 86MmOG//JurFoplkjTquH8pASlmvtCQWbbFVzxkjQCDSe7kJC+HCzAOwDMJ0DSGVk8
	 ogc9dOU1xdu7ldQpSkHQb4JGoBhj7WVxyP9N4yYiD5sT3BLO4sKRxeJi0uCXCzXR5h
	 ujwcwPULzsrBKQqCR22mmNtUA7V6MsEArMd6pfM/363200l1VPQLpKYeN9+X2Dh4By
	 3ZJA7PIS9jYKg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54Q2qTr453026557
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 May 2025 10:52:29 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 26 May 2025 10:52:29 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 26 May 2025 10:52:28 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Mon, 26 May 2025 10:52:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v1 02/13] wifi: rtw89: Get dle_mem via rtw89_hci_dle_mem()
Thread-Topic: [PATCH rtw-next v1 02/13] wifi: rtw89: Get dle_mem via
 rtw89_hci_dle_mem()
Thread-Index: AQHbvTYOjUg1tNmko0OMin8tnDz9BrPRVXVQgBIsGICAANToEA==
Date: Mon, 26 May 2025 02:52:28 +0000
Message-ID: <102d0c86fee74eba9bcc761df10b935e@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <594d5987-5e6d-405c-b482-d101b43cb65c@gmail.com>
 <e587721eeb7244beaa1f07b88d9b4f59@realtek.com>
 <83a7ade0-2c9a-4148-b998-db52e05587b8@gmail.com>
In-Reply-To: <83a7ade0-2c9a-4148-b998-db52e05587b8@gmail.com>
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
NC8wNS8yMDI1IDAzOjU2LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBEb24ndCBhY2Nlc3MgZGxl
X21lbSBpbiBnZXRfZGxlX21lbV9jZmcoKSBkaXJlY3RseS4gVVNCIDIsIFVTQiAzLCBhbmQNCj4g
Pj4gU0RJTyB3aWxsIG5lZWQgZGlmZmVyZW50IHNldHMgb2YgdmFsdWVzLg0KPiA+Pg0KPiA+PiBS
ZW5hbWUgZGxlX21lbSBpbiBzdHJ1Y3QgcnR3ODlfY2hpcF9pbmZvIHRvIGRsZV9tZW1fcGNpZSBh
bmQgZ2V0IGl0DQo+ID4+IHZpYSBydHc4OV9oY2lfZGxlX21lbSgpIGFuZCBydHc4OV9wY2lfb3Bz
X2RsZV9tZW0oKS4NCj4gPj4NCj4gPj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8
cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+ID4+IC0tLQ0KPiA+PiAgZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydHc4OS9jb3JlLmggICAgICB8IDEwICsrKysrKysrKy0NCj4gPj4gIGRy
aXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMgICAgICAgfCAgMiArLQ0KPiA+
PiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9wY2kuYyAgICAgICB8ICA4ICsr
KysrKysrDQo+ID4+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3J0dzg4NTFi
LmMgIHwgIDIgKy0NCj4gPj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcnR3
ODg1MmEuYyAgfCAgMiArLQ0KPiA+PiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4
OS9ydHc4ODUyYi5jICB8ICAyICstDQo+ID4+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0dzg5L3J0dzg4NTJidC5jIHwgIDIgKy0NCj4gPj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODkvcnR3ODg1MmMuYyAgfCAgMiArLQ0KPiA+PiAgZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OS9ydHc4OTIyYS5jICB8ICAyICstDQo+ID4+ICA5IGZpbGVzIGNoYW5n
ZWQsIDI0IGluc2VydGlvbnMoKyksIDggZGVsZXRpb25zKC0pDQo+ID4+DQo+ID4+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2NvcmUuaCBiL2RyaXZlcnMv
bmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvY29yZS5oDQo+ID4+IGluZGV4IGJlMTI1OWNmYTcx
Mi4uYWZjZjAzNTNhNjI1IDEwMDY0NA0KPiA+PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9y
ZWFsdGVrL3J0dzg5L2NvcmUuaA0KPiA+PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0dzg5L2NvcmUuaA0KPiA+PiBAQCAtMzU3OSw2ICszNTc5LDggQEAgc3RydWN0IHJ0dzg5
X2hjaV9vcHMgew0KPiA+PiAgICAgICAgIHZvaWQgKCpkaXNhYmxlX2ludHIpKHN0cnVjdCBydHc4
OV9kZXYgKnJ0d2Rldik7DQo+ID4+ICAgICAgICAgdm9pZCAoKmVuYWJsZV9pbnRyKShzdHJ1Y3Qg
cnR3ODlfZGV2ICpydHdkZXYpOw0KPiA+PiAgICAgICAgIGludCAoKnJzdF9iZHJhbSkoc3RydWN0
IHJ0dzg5X2RldiAqcnR3ZGV2KTsNCj4gPg0KPiA+IGFuIGVtcHR5IGxpbmUNCj4gPg0KPiA+PiAr
ICAgICAgIGNvbnN0IHN0cnVjdCBydHc4OV9kbGVfbWVtICooKmRsZV9tZW0pKHN0cnVjdCBydHc4
OV9kZXYgKnJ0d2RldiwNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICB1OCBxdGFfbW9kZSk7DQo+ID4+ICB9Ow0KPiA+Pg0KPiA+PiAgc3RydWN0IHJ0
dzg5X2hjaV9pbmZvIHsNCj4gPj4gQEAgLTQyNzEsNyArNDI3Myw3IEBAIHN0cnVjdCBydHc4OV9j
aGlwX2luZm8gew0KPiA+PiAgICAgICAgIGJvb2wgZGlzXzJnXzQwbV91bF9vZmRtYTsNCj4gPj4g
ICAgICAgICB1MzIgcnN2ZF9wbGVfb2ZzdDsNCj4gPj4gICAgICAgICBjb25zdCBzdHJ1Y3QgcnR3
ODlfaGZjX3BhcmFtX2luaSAqaGZjX3BhcmFtX2luaTsNCj4gPj4gLSAgICAgICBjb25zdCBzdHJ1
Y3QgcnR3ODlfZGxlX21lbSAqZGxlX21lbTsNCj4gPj4gKyAgICAgICBjb25zdCBzdHJ1Y3QgcnR3
ODlfZGxlX21lbSAqZGxlX21lbV9wY2llOw0KPiA+DQo+ID4gSSByZWNvbnNpZGVyIGlmIHRoaXMg
Y2FuIGJlIGFuIGFycmF5IHdpdGggYSBuZXcgZW51bSA9IHtQQ0lFLCBVU0IyLCBVU0IzLCBTRElP
fQ0KPiA+IHN0b3JlZCBpbiBoYWwtPmhjaV9kbGVfbWVtX3R5cGUuIFRoZW4sIGNvbnN1bWVycyBj
YW4ganVzdCBhY2Nlc3MgaXQgdmlhDQo+ID4gY2hpcC0+ZGxlX21lbVtoYWwtPmhjaV9kbGVfbWVt
X3R5cGVdW3F1b3RhXS4gQnV0LCBJJ20gbm90IHN1cmUgaWYgVVNCDQo+ID4gc3Vic3lzdGVtIGNh
biBub3RpZnkgZHJpdmVyIHdoZW4gVVNCIHNwZWVkIGlzIGNoYW5nZWQuDQo+ID4NCj4gPiBUaGlz
IGlzIGEgdGhvdWdodCB0byBzaW1wbHkgdGhlIHN0cnVjdCBkZWZpbml0aW9uLg0KPiA+DQo+IA0K
PiBUaGUgaGFyZCBwYXJ0IGlzIG5hbWluZyB0aGUgbmV3IGVudW0uIEl0J3MgYmFzaWNhbGx5IHJ0
dzg5X2hjaV90eXBlDQo+IGJ1dCBtb3JlIGRldGFpbGVkLg0KDQpJZiBpdCBvbmx5IHVzZWQgYnkg
RExFLCBtYXliZSBydHc4OV9oY2lfZGxlX3R5cGUgaXMgZmluZT8NCg0KPiANCj4gSSBkb24ndCBl
eHBlY3QgdGhlIFVTQiBzcGVlZCB0byBjaGFuZ2UgZHVyaW5nIHRoZSBsaWZldGltZSBvZiBzdHJ1
Y3QNCj4gcnR3ODlfZGV2LiBXaGVuIHRoZSBkZXZpY2Ugc3dpdGNoZXMgZnJvbSBVU0IgMiB0byBV
U0IgMyBpdCBkaXNjb25uZWN0cw0KPiBhbmQgcmVhcHBlYXJzIGFzIGEgbmV3IGRldmljZToNCg0K
U28gc2VlbWluZ2x5IGl0IGlzIHdvcmthYmxlIHRvIHN0b3JlIHRoZSBVU0Igc3BlZWQgaW4gYSB2
YXJpYWJsZSBhdCBVU0IgcHJvYmUuDQpQbGVhc2UgdHJ5IGlmIGl0IGxvb2tzIGdvb2QuDQoNCj4g
DQo+IEFwciAyMSAyMjowMjoyMiBpZGVhcGFkMiBrZXJuZWw6IHVzYiAxLTQ6IG5ldyBoaWdoLXNw
ZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDE3IHVzaW5nIHhoY2lfaGNkDQo+IEFwciAyMSAyMjowMjoy
MiBpZGVhcGFkMiBrZXJuZWw6IHVzYiAxLTQ6IE5ldyBVU0IgZGV2aWNlIGZvdW5kLCBpZFZlbmRv
cj0wYmRhLCBpZFByb2R1Y3Q9YzgzMiwgYmNkRGV2aWNlPQ0KPiAwLjAwDQo+IEFwciAyMSAyMjow
MjoyMiBpZGVhcGFkMiBrZXJuZWw6IHVzYiAxLTQ6IE5ldyBVU0IgZGV2aWNlIHN0cmluZ3M6IE1m
cj0xLCBQcm9kdWN0PTIsIFNlcmlhbE51bWJlcj0zDQo+IEFwciAyMSAyMjowMjoyMiBpZGVhcGFk
MiBrZXJuZWw6IHVzYiAxLTQ6IFByb2R1Y3Q6IDgwMi4xMWF4IFdMQU4gQWRhcHRlcg0KPiBBcHIg
MjEgMjI6MDI6MjIgaWRlYXBhZDIga2VybmVsOiB1c2IgMS00OiBNYW51ZmFjdHVyZXI6IFJlYWx0
ZWsNCj4gQXByIDIxIDIyOjAyOjIyIGlkZWFwYWQyIGtlcm5lbDogdXNiIDEtNDogU2VyaWFsTnVt
YmVyOiAwMGUwNGMwMDAwMDENCj4gQXByIDIxIDIyOjAyOjI0IGlkZWFwYWQyIGtlcm5lbDogZXJp
Yy10eCBDQUxMIGFsbG9jX3R4cmluZyAhISEhDQo+IEFwciAyMSAyMjowMjoyNCBpZGVhcGFkMiBr
ZXJuZWw6IHVzYiAxLTQ6IFVTQiBkaXNjb25uZWN0LCBkZXZpY2UgbnVtYmVyIDE3DQo+IEFwciAy
MSAyMjowMjoyNCBpZGVhcGFkMiBrZXJuZWw6IHJ0bDg4NTJjdSAxLTQ6MS4wOiBSdW50aW1lIFBN
IHVzYWdlIGNvdW50IHVuZGVyZmxvdyENCj4gDQo+IEFwciAyMSAyMjowMjoyNyBpZGVhcGFkMiBr
ZXJuZWw6IHVzYiAyLTQ6IG5ldyBTdXBlclNwZWVkIFVTQiBkZXZpY2UgbnVtYmVyIDIgdXNpbmcg
eGhjaV9oY2QNCj4gQXByIDIxIDIyOjAyOjI3IGlkZWFwYWQyIGtlcm5lbDogdXNiIDItNDogTmV3
IFVTQiBkZXZpY2UgZm91bmQsIGlkVmVuZG9yPTBiZGEsIGlkUHJvZHVjdD1jODMyLCBiY2REZXZp
Y2U9DQo+IDAuMDANCj4gQXByIDIxIDIyOjAyOjI4IGlkZWFwYWQyIGtlcm5lbDogdXNiIDItNDog
TmV3IFVTQiBkZXZpY2Ugc3RyaW5nczogTWZyPTEsIFByb2R1Y3Q9MiwgU2VyaWFsTnVtYmVyPTMN
Cj4gQXByIDIxIDIyOjAyOjI4IGlkZWFwYWQyIGtlcm5lbDogdXNiIDItNDogUHJvZHVjdDogODAy
LjExYXggV0xBTiBBZGFwdGVyDQo+IEFwciAyMSAyMjowMjoyOCBpZGVhcGFkMiBrZXJuZWw6IHVz
YiAyLTQ6IE1hbnVmYWN0dXJlcjogUmVhbHRlaw0KPiBBcHIgMjEgMjI6MDI6MjggaWRlYXBhZDIg
a2VybmVsOiB1c2IgMi00OiBTZXJpYWxOdW1iZXI6IDAwZTA0YzAwMDAwMQ0KPiBBcHIgMjEgMjI6
MDI6MjggaWRlYXBhZDIga2VybmVsOiBlcmljLXR4IENBTEwgYWxsb2NfdHhyaW5nICEhISENCj4g
QXByIDIxIDIyOjAyOjI4IGlkZWFwYWQyIGtlcm5lbDogcnRsODg1MmN1IDItNDoxLjAgd2xwM3Mw
ZjN1NDogcmVuYW1lZCBmcm9tIHdsYW4wDQo+IA0KDQo=

