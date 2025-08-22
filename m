Return-Path: <linux-wireless+bounces-26558-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id C89A2B310D5
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 09:52:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 7E83A7AD466
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 07:51:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50B412EA496;
	Fri, 22 Aug 2025 07:52:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="acvSMRrN"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 004F32765C1;
	Fri, 22 Aug 2025 07:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755849167; cv=none; b=pREEam9PQEglMYTvcqlnUUOFUVkVvNh6MMZceXA/bQzteYaMek6UKzHG7JygrM0rYSgAb5lYTyo0uOrq7C3CTeIAsB7ETUJhZaKqpqevEdxCC3rW6o0j9M8odGFlzlhs9Hg4cl6+nMz1rqdGgIt9ioOSyUR9sQORerEraxcNc5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755849167; c=relaxed/simple;
	bh=HHNlbtXcQn2UGVDP52r2Dmw9QPnO5hV17eKuMqYSDnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rAtAekBX9vHbl8GGmwY46bh9S43HI5pOfxwM4A3emt+hZ+ZM+BTCUdjQhp4OPJ+Yh4KZfetLlsCOMc28lwPchh5UIaeJQi1rRhqGFGRnUKDSfcxOO+/BlXnK6rrCafKYDlFZpjJp2v9ZHFHMNQHjZIurEj4AsrqQc1YXmcaPQ34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=acvSMRrN; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57M7qLbT51335193, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1755849141; bh=HHNlbtXcQn2UGVDP52r2Dmw9QPnO5hV17eKuMqYSDnw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=acvSMRrNsYtVwiUaL5VZlOL0mVbzWZMnikpt6l3A/li2FNnWTOxm3NFnwwEzUidOi
	 NuTEEuvb1jJHcusMcYc8yFpb+8k1icE+g4rX38roLIb3wnZgq19LLFehBWXYYgmTSz
	 iFtflUE0dnka+FdSUS7Y/JYkKQ567pwz1U4zcH8SULZse72mQg8UOqz9X261qN3ghy
	 pAr1U+NxDI9ZoMFD5wCk3i/kBAzxub9EVp5yfhFebJgOOLYz6sTNYCgbK+nnr3RE3u
	 tCpqSqrzlbfu28MKMlq/LleWegUBQFRkDWq5Nd8xIrg14L9J+3KRq8FpAbeOyeDFe4
	 igNrDcMXwURnA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57M7qLbT51335193
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 15:52:21 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 22 Aug 2025 15:52:21 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 22 Aug 2025 15:52:20 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::982b:42ba:82a4:f1d]) by
 RTEXMBS03.realtek.com.tw ([fe80::982b:42ba:82a4:f1d%2]) with mapi id
 15.01.2507.035; Fri, 22 Aug 2025 15:52:20 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>
CC: Ping-Ke Shih <pkshih@realtek.com>, Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw-next 1/2] wifi: rtw89: fix use-after-free in rtw89_core_tx_kick_off_and_wait()
Thread-Topic: [PATCH rtw-next 1/2] wifi: rtw89: fix use-after-free in
 rtw89_core_tx_kick_off_and_wait()
Thread-Index: AQHcEd2TXgTNv1RIp0yyOkAvjkku2rRsb/bQ///dcoCAAeLfsA==
Date: Fri, 22 Aug 2025 07:52:20 +0000
Message-ID: <b534be02ec354e5e9d5808f82b7127b9@realtek.com>
References: <20250820141441.106156-1-pchelkin@ispras.ru>
 <20250820141441.106156-2-pchelkin@ispras.ru>
 <b4ec58864e544b0295ddb02ed408199b@realtek.com>
 <20250821113341-4d93a84ec8bcd73321acd2b7-pchelkin@ispras>
In-Reply-To: <20250821113341-4d93a84ec8bcd73321acd2b7-pchelkin@ispras>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

RmVkb3IgUGNoZWxraW4gPHBjaGVsa2luQGlzcHJhcy5ydT4gd3JvdGU6DQo+IA0KPiBbLi4uXQ0K
PiANCj4gPiA+DQo+ID4gPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9jb3Jl
LmMgfCAxNSArKysrKysrKy0tLQ0KPiA+ID4gZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OS9jb3JlLmggfCAzMg0KPiA+ID4gKysrKysrKysrKysrKystLS0tLS0tLS0gZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9wY2kuYyAgfA0KPiA+ID4gNiArKystLQ0KPiA+ID4g
IDMgZmlsZXMgY2hhbmdlZCwgMzYgaW5zZXJ0aW9ucygrKSwgMTcgZGVsZXRpb25zKC0pDQo+ID4g
Pg0KPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkv
Y29yZS5jDQo+ID4gPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvY29yZS5j
DQo+ID4gPiBpbmRleCA1NzU5MGY1NTc3YTMuLjgyNjU0MDMxOTAyNyAxMDA2NDQNCj4gPiA+IC0t
LSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvY29yZS5jDQo+ID4gPiArKysg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L2NvcmUuYw0KPiA+ID4gQEAgLTEw
ODgsNiArMTA4OCw3IEBAIGludCBydHc4OV9jb3JlX3R4X2tpY2tfb2ZmX2FuZF93YWl0KHN0cnVj
dA0KPiA+ID4gcnR3ODlfZGV2ICpydHdkZXYsIHN0cnVjdCBza19idWZmICpzaw0KPiA+ID4gICAg
ICAgICBzdHJ1Y3QgcnR3ODlfdHhfc2tiX2RhdGEgKnNrYl9kYXRhID0gUlRXODlfVFhfU0tCX0NC
KHNrYik7DQo+ID4gPiAgICAgICAgIHN0cnVjdCBydHc4OV90eF93YWl0X2luZm8gKndhaXQ7DQo+
ID4gPiAgICAgICAgIHVuc2lnbmVkIGxvbmcgdGltZV9sZWZ0Ow0KPiA+ID4gKyAgICAgICBib29s
IGZyZWVfd2FpdCA9IHRydWU7DQo+ID4gPiAgICAgICAgIGludCByZXQgPSAwOw0KPiA+ID4NCj4g
PiA+ICAgICAgICAgd2FpdCA9IGt6YWxsb2Moc2l6ZW9mKCp3YWl0KSwgR0ZQX0tFUk5FTCk7IEBA
IC0xMDk3LDcNCj4gPiA+ICsxMDk4LDggQEAgaW50IHJ0dzg5X2NvcmVfdHhfa2lja19vZmZfYW5k
X3dhaXQoc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LCBzdHJ1Y3QNCj4gc2tfYnVmZiAqc2sNCj4g
PiA+ICAgICAgICAgfQ0KPiA+ID4NCj4gPiA+ICAgICAgICAgaW5pdF9jb21wbGV0aW9uKCZ3YWl0
LT5jb21wbGV0aW9uKTsNCj4gPiA+IC0gICAgICAgcmN1X2Fzc2lnbl9wb2ludGVyKHNrYl9kYXRh
LT53YWl0LCB3YWl0KTsNCj4gPiA+ICsgICAgICAgc3Bpbl9sb2NrX2luaXQoJndhaXQtPm93bmVy
X2xvY2spOw0KPiA+ID4gKyAgICAgICBza2JfZGF0YS0+d2FpdCA9IHdhaXQ7DQo+ID4gPg0KPiA+
ID4gICAgICAgICBydHc4OV9jb3JlX3R4X2tpY2tfb2ZmKHJ0d2RldiwgcXNlbCk7DQo+ID4gPiAg
ICAgICAgIHRpbWVfbGVmdCA9IHdhaXRfZm9yX2NvbXBsZXRpb25fdGltZW91dCgmd2FpdC0+Y29t
cGxldGlvbiwNCj4gPiA+IEBAIC0xMTA3LDggKzExMDksMTUgQEAgaW50IHJ0dzg5X2NvcmVfdHhf
a2lja19vZmZfYW5kX3dhaXQoc3RydWN0DQo+ID4gPiBydHc4OV9kZXYgKnJ0d2Rldiwgc3RydWN0
IHNrX2J1ZmYgKnNrDQo+ID4gPiAgICAgICAgIGVsc2UgaWYgKCF3YWl0LT50eF9kb25lKQ0KPiA+
ID4gICAgICAgICAgICAgICAgIHJldCA9IC1FQUdBSU47DQo+ID4gPg0KPiA+ID4gLSAgICAgICBy
Y3VfYXNzaWduX3BvaW50ZXIoc2tiX2RhdGEtPndhaXQsIE5VTEwpOw0KPiA+ID4gLSAgICAgICBr
ZnJlZV9yY3Uod2FpdCwgcmN1X2hlYWQpOw0KPiA+DQo+ID4gUGxlYXNlIGNvbnNpZGVyIHRoZSBm
b2xsb3dpbmcuDQo+ID4gKG1vdmluZyAicmN1X2Fzc2lnbl9wb2ludGVyKHNrYl9kYXRhLT53YWl0
LCBOVUxMKSIgdG8gYmUgdW5kZXIgImlmDQo+ID4gKHRpbWVfbGVmdCA9PSAwKSIpDQo+ID4NCj4g
DQo+IFRoZXJlIGlzIHN0aWxsIGEgdGlueSByYWNlIHdpbmRvdy4gU3VwcG9zZSB3YWl0X2Zvcl9j
b21wbGV0aW9uX3RpbWVvdXQoKSBleGl0cyB3aXRoIGEgdGltZW91dCwNCj4gc28gdGltZV9sZWZ0
IGlzIDAuIElmIGNvbXBsZXRpbmcgc2lkZSBnb2VzIG9uIGluIHBhcmFsbGVsIGp1c3QgYWZ0ZXIg
dGhhdCwgaXQgaGFzIGEgY2hhbmNlIHRvDQo+IHByb2NlZWQgYW5kIGZyZWUgc2tiX2RhdGEgYmVm
b3JlIHRoZSBiZWxvdyBpZiAodGltZV9sZWZ0ID09IDApIGZyYWdtZW50IGlzIGV4ZWN1dGVkLg0K
DQpPa2F5LCBsb2dpY2FsbHkgaXQgc291bmRzIHJpZ2h0Lg0KDQo+IA0KPiA+ICAgICBpZiAodGlt
ZV9sZWZ0ID09IDApIHsNCj4gPiAgICAgICAgIHJjdV9hc3NpZ25fcG9pbnRlcihza2JfZGF0YS0+
d2FpdCwgTlVMTCk7DQo+ID4gICAgICAgICByZXQgPSAtRVRJTUVET1VUOw0KPiA+ICAgICB9IGVs
c2UgaWYgKCF3YWl0LT50eF9kb25lKSB7DQo+ID4gICAgICAgICByZXQgPSAtRUFHQUlOOw0KPiA+
ICAgICB9DQo+ID4NCj4gPiAgICAga2ZyZWVfcmN1KHdhaXQsIHJjdV9oZWFkKTsNCj4gPg0KPiA+
IElmIGNvbXBsZXRpbmcgc2lkZSBkb2VzIHJ1biBhcyBleHBlY3RlZCAocG90ZW50aWFsIHJhY2lu
ZyBtZW50aW9uZWQgaW4NCj4gPiB0aGlzIHBhdGNoKSwgdGhlcmUgaXMgbm8gcmVhbCBuZWVkIHRv
IGFzc2lnbiBOVUxMIGJhY2suDQo+IA0KPiBBY3R1YWxseSB0aGUgcmFjZSBoYXBwZW5zIHJlZ2Fy
ZGxlc3Mgb2Ygd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCkgZXhpdCBzdGF0dXMsIGl0J3Mg
YnJpZWZseQ0KPiBtZW50aW9uZWQgaW4gdGhlIHJhY2UgZGlhZ3JhbSBpbnNpZGUgY29tbWl0IG1l
c3NhZ2UgKGJ1dCB0aGUgZGlhZ3JhbSBjYW4gc2hvdyBvbmx5IG9uZQ0KPiBwb3NzaWJsZSBjb25j
dXJyZW5jeSBzY2VuYXJpbykuIEkgYWdyZWUgdGhpcyBtYXkgYmUgaW1wcm92ZWQgYW5kIGRlc2Ny
aWJlZCBtb3JlIGV4cGxpY2l0bHkNCj4gdGhvdWdoLg0KDQpXaWxsIGFwcHJlY2lhdGUgdG8gc2Vl
IHRoYXQgaW4gbmV4dCB2ZXJzaW9uLiBUaGFua3MuDQoNCj4gDQo+IEFzIGZvciB0aGUgcGF0Y2gg
aXRzZWxmLCBjdXJyZW50bHkgSSBjYW4ndCBzZWUgYW5vdGhlciB3YXkgb2YgZml4aW5nIHRoYXQg
b3RoZXIgdGhhbiBpbnRyb2R1Y2luZw0KPiBsb2NrcyBvbiBib3RoIHdhaXRpbmcgYW5kIGNvbXBs
ZXRpbmcgc2lkZS4NCg0KSSB0b29rIHNvbWUgdGltZSBvbiB0aGlua2luZyB0aGlzLiBUaGUgZm9s
bG93aW5nIGlzIGFub3RoZXIgaWRlYS4NClRoZSBza2IsIHdoaWNoIGFyZSBzZW50IGJ5IHR4X3dh
aXRfY29tcGxldGUsIGFyZSBvd25lZCBieSBkcml2ZXIuDQpUaGV5IGRvbid0IGNvbWUgZnJvbSBz
dGFjaywgc28gd2UgZG9uJ3QgbmVlZCB0byBkbyBpZWVlODAyMTFfdHhfc3RhdHVzX25pLg0KQmFz
ZWQgb24gYWJvdmUsIHNvbWUgcm91Z2ggcG9pbnRzIG9mIHRoZSBuZXcgaWRlYSBhcmUgbGlzdGVk
IGJlbG93Lg0KDQoxLg0KICAgIExldCBydHc4OV9jb3JlX3R4X3dhaXRfY29tcGxldGUNCiAgICAg
ICAgcmV0dXJuIHRydWUvZmFsc2UgdG8gaW5kaWNhdGUgd2hldGhlciB0eF93YWl0IG9yIG5vdA0K
DQoyLg0KICAgIEFkZCBzb21lIG5ldyBmaWVsZCBpbnRvIHJ0dzg5X3R4X3dhaXRfaW5mbw0KICAg
ICAgICBlLmcuIGxpc3RfaGVhZCwgc2tiLCBmaW5pc2hlZA0KDQozLg0KICAgIEFkZCBhIGxpc3Rf
aGVhZCB0byBydHdkZXYNCiAgICBBZGQgYSB3b3JrIGZ1bmMgZG9pbmcgdGhpbmdzIGFzDQogICAg
ICAgIGZvciBlYWNoIHdhaXQgaW4gcnR3ZGV2LT5YWFhfbGlzdDoNCiAgICAgICAgICAgIGlmICF3
YWl0LT5maW5pc2hlZDoNCiAgICAgICAgICAgICAgICB3YWl0X2Zvcl9jb21wbGV0aW9uKCkNCiAg
ICAgICAgICAgIGZyZWUgd2FpdC0+c2tiDQogICAgICAgICAgICBmcmVlIHdhaXQNCg0KNC4NCiAg
ICAgICAgIFt3YWl0aW5nIHNpZGVdICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtjb21w
bGV0aW5nIHNpZGVdDQogICAgd2FpdF9mb3JfY29tcGxldGlvbl90aW1lb3V0KCkgICAgICAgICAg
ICAgICAgICAgICAgICAgIC4uLg0KICAgICAgICAgICAgIC4uLiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAvKiBtYWtlIGNvbXBsZXRlIHRoZSBsYXN0IHN0ZXAgKi8NCiAgICAgICAgICAg
ICAuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgaWYgKHJ0dzg5X2NvcmVfdHhfd2Fp
dF9jb21wbGV0ZSkNCiAgICAgICAgICAgICAuLi4gICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIHJldHVybjsNCiAgICAgICAgICAgICAuLi4NCiAgICAvLyBub3QgYXNzaWduIE5V
TEwgYmFjayB0byBza2JfZGF0YS0+d2FpdA0KICAgICAgICBpZiB0aW1lX2xlZnQgIT0gMDoNCiAg
ICAgICAgICAgIHdhaXQtPiBmaW5pc2hlZCA9IHRydWUNCiAgICAgICAgd2FpdC0+c2tiID0gc2ti
DQogICAgICAgIGFkZCB3YWl0IHRvIHJ0d2Rldi0+WFhYX2xpc3QNCiAgICAgICAgcXVldWUgYWJv
dmUgd29yaw0KDQpQbGVhc2UgaGVscCBldmFsdWF0ZSB0aGUgbmV3IGlkZWEuDQpUaGFuayB5b3Uu
DQoNCg==

