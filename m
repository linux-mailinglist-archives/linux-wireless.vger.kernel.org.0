Return-Path: <linux-wireless+bounces-22927-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7D16CAB604D
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 02:56:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B84613B22BB
	for <lists+linux-wireless@lfdr.de>; Wed, 14 May 2025 00:56:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 923844438B;
	Wed, 14 May 2025 00:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="rnfLARQQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4C069478
	for <linux-wireless@vger.kernel.org>; Wed, 14 May 2025 00:56:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747184177; cv=none; b=E2DiuTBpVadDe3pr1rsA8bSwU/4t1l46GcPe/+tvCOkcIsw25JFY2MIcqrrIvppvpFkCW4W+4DCuU7fhQ3qlFTswPcgxGWzAJdQ1ZvvOJpgTriQYGZpWogHcxJOeDcZ8tyWzm878oY7Qg/E2dO02us3j//RR50JQrNKzxYFrP/g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747184177; c=relaxed/simple;
	bh=1plLAu/sZj3oxCcHNpbypoAZPo1GHR5DPwOw246JvDw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kbKiSJ3VoYYJ2N42QdSwG3e/woJLrJKeISbtAQvA0OEvX91wRSzZOdmf3I1RDmuupeVjcXFC/+2XOqn6vEPkqf3sJ3dq4pwTXNd0y0kJrJu5p0xy66pS+Uyvrvvt+bHYBa+4KmJOaj1PmCZ3yv8xDehu5ujLBSpazhZTH9u4uTM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=rnfLARQQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54E0u8cX5912861, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747184168; bh=1plLAu/sZj3oxCcHNpbypoAZPo1GHR5DPwOw246JvDw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=rnfLARQQ1IdIUjkDE9YAvlKKio+5JQ5U9V2MIOcsTdij1GtgLICEtGiLcH0CAcDrL
	 D7wLg9wphMG8oMQd2u86W95y5UafS+Q6nm7/zlbzT/H7yviVW5g5HGiS/DA4Yts1hw
	 WgYi2jq+EqtCt9gcSA/lNgErjqemu5od65he3L2ru1u8bzb2G7fq3GmFcPauE8LTmp
	 t1gWuiULMXdc4gsZfjuLo69OngPKtzlhoIP+MPGKHMIEelDaZo2N9IZ2etfDiLR0FD
	 f/3jH0VChJsyO1uVRx7993jX1k09H4A9RA8COyn5zgC/4OCb66Te6wIQwWO5qrLer2
	 B0q4QwMDdBZAA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54E0u8cX5912861
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 14 May 2025 08:56:08 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 14 May 2025 08:56:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 14 May 2025 08:56:08 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 14 May 2025 08:56:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v1 02/13] wifi: rtw89: Get dle_mem via rtw89_hci_dle_mem()
Thread-Topic: [PATCH rtw-next v1 02/13] wifi: rtw89: Get dle_mem via
 rtw89_hci_dle_mem()
Thread-Index: AQHbvTYOjUg1tNmko0OMin8tnDz9BrPRVXVQ
Date: Wed, 14 May 2025 00:56:08 +0000
Message-ID: <e587721eeb7244beaa1f07b88d9b4f59@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <594d5987-5e6d-405c-b482-d101b43cb65c@gmail.com>
In-Reply-To: <594d5987-5e6d-405c-b482-d101b43cb65c@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBEb24n
dCBhY2Nlc3MgZGxlX21lbSBpbiBnZXRfZGxlX21lbV9jZmcoKSBkaXJlY3RseS4gVVNCIDIsIFVT
QiAzLCBhbmQNCj4gU0RJTyB3aWxsIG5lZWQgZGlmZmVyZW50IHNldHMgb2YgdmFsdWVzLg0KPiAN
Cj4gUmVuYW1lIGRsZV9tZW0gaW4gc3RydWN0IHJ0dzg5X2NoaXBfaW5mbyB0byBkbGVfbWVtX3Bj
aWUgYW5kIGdldCBpdA0KPiB2aWEgcnR3ODlfaGNpX2RsZV9tZW0oKSBhbmQgcnR3ODlfcGNpX29w
c19kbGVfbWVtKCkuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4
ODIxY2VyZmUyQGdtYWlsLmNvbT4NCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0dzg5L2NvcmUuaCAgICAgIHwgMTAgKysrKysrKysrLQ0KPiAgZHJpdmVycy9uZXQvd2ly
ZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuYyAgICAgICB8ICAyICstDQo+ICBkcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3BjaS5jICAgICAgIHwgIDggKysrKysrKysNCj4gIGRyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcnR3ODg1MWIuYyAgfCAgMiArLQ0KPiAgZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9ydHc4ODUyYS5jICB8ICAyICstDQo+ICBk
cml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3J0dzg4NTJiLmMgIHwgIDIgKy0NCj4g
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvcnR3ODg1MmJ0LmMgfCAgMiArLQ0K
PiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9ydHc4ODUyYy5jICB8ICAyICst
DQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3J0dzg5MjJhLmMgIHwgIDIg
Ky0NCj4gIDkgZmlsZXMgY2hhbmdlZCwgMjQgaW5zZXJ0aW9ucygrKSwgOCBkZWxldGlvbnMoLSkN
Cj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2Nv
cmUuaCBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvY29yZS5oDQo+IGluZGV4
IGJlMTI1OWNmYTcxMi4uYWZjZjAzNTNhNjI1IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2NvcmUuaA0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0dzg5L2NvcmUuaA0KPiBAQCAtMzU3OSw2ICszNTc5LDggQEAgc3RydWN0IHJ0
dzg5X2hjaV9vcHMgew0KPiAgICAgICAgIHZvaWQgKCpkaXNhYmxlX2ludHIpKHN0cnVjdCBydHc4
OV9kZXYgKnJ0d2Rldik7DQo+ICAgICAgICAgdm9pZCAoKmVuYWJsZV9pbnRyKShzdHJ1Y3QgcnR3
ODlfZGV2ICpydHdkZXYpOw0KPiAgICAgICAgIGludCAoKnJzdF9iZHJhbSkoc3RydWN0IHJ0dzg5
X2RldiAqcnR3ZGV2KTsNCg0KYW4gZW1wdHkgbGluZQ0KDQo+ICsgICAgICAgY29uc3Qgc3RydWN0
IHJ0dzg5X2RsZV9tZW0gKigqZGxlX21lbSkoc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LA0KPiAr
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHU4IHF0YV9tb2Rl
KTsNCj4gIH07DQo+IA0KPiAgc3RydWN0IHJ0dzg5X2hjaV9pbmZvIHsNCj4gQEAgLTQyNzEsNyAr
NDI3Myw3IEBAIHN0cnVjdCBydHc4OV9jaGlwX2luZm8gew0KPiAgICAgICAgIGJvb2wgZGlzXzJn
XzQwbV91bF9vZmRtYTsNCj4gICAgICAgICB1MzIgcnN2ZF9wbGVfb2ZzdDsNCj4gICAgICAgICBj
b25zdCBzdHJ1Y3QgcnR3ODlfaGZjX3BhcmFtX2luaSAqaGZjX3BhcmFtX2luaTsNCj4gLSAgICAg
ICBjb25zdCBzdHJ1Y3QgcnR3ODlfZGxlX21lbSAqZGxlX21lbTsNCj4gKyAgICAgICBjb25zdCBz
dHJ1Y3QgcnR3ODlfZGxlX21lbSAqZGxlX21lbV9wY2llOw0KDQpJIHJlY29uc2lkZXIgaWYgdGhp
cyBjYW4gYmUgYW4gYXJyYXkgd2l0aCBhIG5ldyBlbnVtID0ge1BDSUUsIFVTQjIsIFVTQjMsIFNE
SU99DQpzdG9yZWQgaW4gaGFsLT5oY2lfZGxlX21lbV90eXBlLiBUaGVuLCBjb25zdW1lcnMgY2Fu
IGp1c3QgYWNjZXNzIGl0IHZpYQ0KY2hpcC0+ZGxlX21lbVtoYWwtPmhjaV9kbGVfbWVtX3R5cGVd
W3F1b3RhXS4gQnV0LCBJJ20gbm90IHN1cmUgaWYgVVNCDQpzdWJzeXN0ZW0gY2FuIG5vdGlmeSBk
cml2ZXIgd2hlbiBVU0Igc3BlZWQgaXMgY2hhbmdlZC4gDQoNClRoaXMgaXMgYSB0aG91Z2h0IHRv
IHNpbXBseSB0aGUgc3RydWN0IGRlZmluaXRpb24uIA0KDQo+ICAgICAgICAgdTggd2RlX3FlbXB0
eV9hY3FfZ3JwbnVtOw0KPiAgICAgICAgIHU4IHdkZV9xZW1wdHlfbWdxX2dycHNlbDsNCj4gICAg
ICAgICB1MzIgcmZfYmFzZV9hZGRyWzJdOw0KPiBAQCAtNjE0Niw2ICs2MTQ4LDEyIEBAIHN0YXRp
YyBpbmxpbmUgdm9pZCBydHc4OV9oY2lfY2xlYXIoc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LCBz
dHJ1Y3QgcGNpX2RldiAqcGRlDQo+ICAgICAgICAgICAgICAgICBydHdkZXYtPmhjaS5vcHMtPmNs
ZWFyKHJ0d2RldiwgcGRldik7DQo+ICB9DQo+IA0KPiArc3RhdGljIGlubGluZSBjb25zdA0KPiAr
c3RydWN0IHJ0dzg5X2RsZV9tZW0gKnJ0dzg5X2hjaV9kbGVfbWVtKHN0cnVjdCBydHc4OV9kZXYg
KnJ0d2RldiwgdTggcXRhX21vZGUpDQo+ICt7DQo+ICsgICAgICAgcmV0dXJuIHJ0d2Rldi0+aGNp
Lm9wcy0+ZGxlX21lbShydHdkZXYsIHF0YV9tb2RlKTsNCj4gK30NCj4gKw0KPiAgc3RhdGljIGlu
bGluZQ0KPiAgc3RydWN0IHJ0dzg5X3R4X3NrYl9kYXRhICpSVFc4OV9UWF9TS0JfQ0Ioc3RydWN0
IHNrX2J1ZmYgKnNrYikNCj4gIHsNCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3JlYWx0ZWsvcnR3ODkvbWFjLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5
L21hYy5jDQo+IGluZGV4IDU5MmZiYjZkMjcyOC4uNzdkMzVkYjNlMTMzIDEwMDY0NA0KPiAtLS0g
YS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L21hYy5jDQo+ICsrKyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMNCj4gQEAgLTE3MTksNyArMTcxOSw3
IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcnR3ODlfZGxlX21lbSAqZ2V0X2RsZV9tZW1fY2ZnKHN0
cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwNCj4gICAgICAgICBzdHJ1Y3QgcnR3ODlfbWFjX2luZm8g
Km1hYyA9ICZydHdkZXYtPm1hYzsNCj4gICAgICAgICBjb25zdCBzdHJ1Y3QgcnR3ODlfZGxlX21l
bSAqY2ZnOw0KPiANCj4gLSAgICAgICBjZmcgPSAmcnR3ZGV2LT5jaGlwLT5kbGVfbWVtW21vZGVd
Ow0KPiArICAgICAgIGNmZyA9IHJ0dzg5X2hjaV9kbGVfbWVtKHJ0d2RldiwgbW9kZSk7DQo+ICAg
ICAgICAgaWYgKCFjZmcpDQo+ICAgICAgICAgICAgICAgICByZXR1cm4gTlVMTDsNCj4gDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3BjaS5jIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9wY2kuYw0KPiBpbmRleCBjMmZlNWE4OThk
YzcuLjFkZWM2MDMwMTJiYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydHc4OS9wY2kuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
dzg5L3BjaS5jDQo+IEBAIC00MzQxLDYgKzQzNDEsMTMgQEAgc3RhdGljIGludCBfX21heWJlX3Vu
dXNlZCBydHc4OV9wY2lfcmVzdW1lKHN0cnVjdCBkZXZpY2UgKmRldikNCj4gIFNJTVBMRV9ERVZf
UE1fT1BTKHJ0dzg5X3BtX29wcywgcnR3ODlfcGNpX3N1c3BlbmQsIHJ0dzg5X3BjaV9yZXN1bWUp
Ow0KPiAgRVhQT1JUX1NZTUJPTChydHc4OV9wbV9vcHMpOw0KPiANCj4gK3N0YXRpYyBjb25zdA0K
PiArc3RydWN0IHJ0dzg5X2RsZV9tZW0gKnJ0dzg5X3BjaV9vcHNfZGxlX21lbShzdHJ1Y3QgcnR3
ODlfZGV2ICpydHdkZXYsDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgdTggcXRhX21vZGUpDQo+ICt7DQo+ICsgICAgICAgcmV0dXJuICZydHdkZXYtPmNoaXAt
PmRsZV9tZW1fcGNpZVtxdGFfbW9kZV07DQo+ICt9DQo+ICsNCj4gIGNvbnN0IHN0cnVjdCBydHc4
OV9wY2lfZ2VuX2RlZiBydHc4OV9wY2lfZ2VuX2F4ID0gew0KPiAgICAgICAgIC5pc3JfcmR1ID0g
Ql9BWF9SRFVfSU5ULA0KPiAgICAgICAgIC5pc3JfaGFsdF9jMmggPSBCX0FYX0hBTFRfQzJIX0lO
VF9FTiwNCj4gQEAgLTQ0MTMsNiArNDQyMCw3IEBAIHN0YXRpYyBjb25zdCBzdHJ1Y3QgcnR3ODlf
aGNpX29wcyBydHc4OV9wY2lfb3BzID0gew0KPiAgICAgICAgIC5kaXNhYmxlX2ludHIgICA9IHJ0
dzg5X3BjaV9kaXNhYmxlX2ludHJfbG9jaywNCj4gICAgICAgICAuZW5hYmxlX2ludHIgICAgPSBy
dHc4OV9wY2lfZW5hYmxlX2ludHJfbG9jaywNCj4gICAgICAgICAucnN0X2JkcmFtICAgICAgPSBy
dHc4OV9wY2lfcmVzZXRfYmRyYW0sDQoNCmFuIGVtcHR5IGxpbmUNCg0KPiArICAgICAgIC5kbGVf
bWVtICAgICAgICA9IHJ0dzg5X3BjaV9vcHNfZGxlX21lbSwNCj4gIH07DQo+IA0KDQpbLi4uXQ0K
DQoNCg==

