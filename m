Return-Path: <linux-wireless+bounces-28940-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC374C5AD6C
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 01:49:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C2D8E3B7106
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Nov 2025 00:47:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7E94C241695;
	Fri, 14 Nov 2025 00:47:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="cGmfO7Sa"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68CE3E47B
	for <linux-wireless@vger.kernel.org>; Fri, 14 Nov 2025 00:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763081264; cv=none; b=n4h1la9GynWJGFJTx3crvlnnhFnVzakrrmlFb08qOgQ9VJtTD1MnO238ITfqF7oJaB8lkieCdXWWD/zT0IECzcCiUjktyt3jWaTRJwI/i80AWQ2CCz8aDRazWpsjlv00w2liIvsix4VZiwN0vTvaSIhFHQg0fBH1ySDz1ps6Mjs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763081264; c=relaxed/simple;
	bh=LMtSYT6zL7XPNy0zmDdN03SHVwEMDPcFa4UNRnWqNJ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=kV88y3iRDdcHjs5CTJT3qttQ55zQCmzVCtj/HEobWhGcvIUjLPgojZbJtW15KnZ3qpnJ/vToCztxRM5ed9sPH2HiSOYLLaLQIRM1z4Jh63wQ3NRGcG1aKgv9CKnwPz1gjnAkT/r9VDfJZcvbdfoerj83dv83aWUVjpzCmk1ZXMs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=cGmfO7Sa; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AE0lbGD3546089, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763081257; bh=LMtSYT6zL7XPNy0zmDdN03SHVwEMDPcFa4UNRnWqNJ8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=cGmfO7Sa3POgWM2n2TRv1GQ56NgdBF5xNUDIet/63EzvFyWtqsjq+jkThwMprT8FI
	 wCuUdhcz85/RCrtf/MHs9AzO67GBt9l4mCcndgi+n7iRfZYFPw4vYoxWXp9ZtuY4Lq
	 e5WuxFxWhcM0WHE4DvkUuSqm/T+N6veGiVz0+0aqeTJXd9hLxnbuTePRFQcSe6vNdE
	 aQCYgCw4lO7+5fbMTz3QNwgV4I/77wSn+rFuRhc76OBeHKfBv/A4mRi2AFsDmSzwva
	 G7bujrYwTPD/i2+nCfBr3hbxJ3SZ160SPVC+hSVCd1+F6QEmZ6Sx4acDIQT36t/rSg
	 Ddbq0rO+GETHA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AE0lbGD3546089
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Nov 2025 08:47:37 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 08:47:38 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 14 Nov 2025 08:47:37 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Fri, 14 Nov 2025 08:47:37 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Gary Chang <gary.chang@realtek.com>
Subject: RE: [PATCH rtw-next 09/14] wifi: rtw89: fw: print band and port where
 beacon update on
Thread-Topic: [PATCH rtw-next 09/14] wifi: rtw89: fw: print band and port
 where beacon update on
Thread-Index: AQHcVEmDIkYmPx2EPEeE69lufI3rV7TwFUSAgAFCkXA=
Date: Fri, 14 Nov 2025 00:47:37 +0000
Message-ID: <1a45f991e7ff454187ba88d4b5da1f21@realtek.com>
References: <20251113025620.31086-1-pkshih@realtek.com>
 <20251113025620.31086-10-pkshih@realtek.com>
 <e5e2ecf9-ef8f-4eeb-886a-8c8a01ade9f1@gmail.com>
In-Reply-To: <e5e2ecf9-ef8f-4eeb-886a-8c8a01ade9f1@gmail.com>
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
My8xMS8yMDI1IDA0OjU2LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gVGhlIEMySCBldmVudCBv
ZiBCQ05fVVBEX0RPTkUgaXMgdG8gbm90aWZ5IGRyaXZlciB0aGF0IGZpcm13YXJlIGNoYW5nZXMN
Cj4gPiBiZWFjb24gY29udGVudCBvbiBjZXJ0YWluIGJhbmQvcG9ydCBhc2tlZCBieSBkcml2ZXIu
IFByaW50IHRoZQ0KPiA+IG5vdGlmaWNhdGlvbiBmb3IgZGVidWcgcHVycG9zZSBmb3Igbm93Lg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+
DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvZncuaCAg
fCAgOSArKysrKysrKysNCj4gPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9t
YWMuYyB8IDEzICsrKysrKysrKysrKy0NCj4gPiAgMiBmaWxlcyBjaGFuZ2VkLCAyMSBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5oIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRl
ay9ydHc4OS9mdy5oDQo+ID4gaW5kZXggODdjNTVhMWE5ZDk0Li5iYjNlN2JiYjQxZGUgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5oDQo+ID4g
KysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9mdy5oDQo+ID4gQEAgLTM2
NDgsNiArMzY0OCwxNSBAQCBzdHJ1Y3QgcnR3ODlfZndfYzJoX2xvZ19mbXQgew0KPiA+ICAjZGVm
aW5lIFJUVzg5X0MySF9GV19MT0dfU0lHTkFUVVJFIDB4QTVBNQ0KPiA+ICAjZGVmaW5lIFJUVzg5
X0MySF9GV19MT0dfU1RSX0JVRl9TSVpFIDUxMg0KPiA+DQo+ID4gK3N0cnVjdCBydHc4OV9jMmhf
YmNuX3VwZF9kb25lIHsNCj4gPiArICAgICBzdHJ1Y3QgcnR3ODlfYzJoX2hkciBoZHI7DQo+ID4g
KyAgICAgX19sZTMyIHcyOw0KPiA+ICt9IF9fcGFja2VkOw0KPiA+ICsNCj4gPiArI2RlZmluZSBS
VFc4OV9DMkhfQkNOX1VQRF9ET05FX1cyX1BPUlQgR0VOTUFTSygyLCAwKQ0KPiA+ICsjZGVmaW5l
IFJUVzg5X0MySF9CQ05fVVBEX0RPTkVfVzJfTUJTU0lEIEdFTk1BU0soNiwgMykNCj4gPiArI2Rl
ZmluZSBSVFc4OV9DMkhfQkNOX1VQRF9ET05FX1cyX0JBTkRfSURYIEJJVCg3KQ0KPiA+ICsNCj4g
PiAgc3RydWN0IHJ0dzg5X2MyaF9tYWNfYmNuZmx0cl9ycHQgew0KPiA+ICAgICAgIF9fbGUzMiB3
MDsNCj4gPiAgICAgICBfX2xlMzIgdzE7DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0dzg5L21hYy5jDQo+ID4gaW5kZXggMjFmNTAyM2M0ZjY5Li5iMTIwNTA3NzI5YWUgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9tYWMuYw0KPiA+
ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMNCj4gPiBAQCAt
NTMwOSw4ICs1MzA5LDE5IEBAIHJ0dzg5X21hY19jMmhfYmNuX2NudChzdHJ1Y3QgcnR3ODlfZGV2
ICpydHdkZXYsIHN0cnVjdCBza19idWZmICpjMmgsIHUzMiBsZW4pDQo+ID4gIH0NCj4gPg0KPiA+
ICBzdGF0aWMgdm9pZA0KPiA+IC1ydHc4OV9tYWNfYzJoX2Jjbl91cGRfZG9uZShzdHJ1Y3QgcnR3
ODlfZGV2ICpydHdkZXYsIHN0cnVjdCBza19idWZmICpjMmgsIHUzMiBsZW4pDQo+ID4gK3J0dzg5
X21hY19jMmhfYmNuX3VwZF9kb25lKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2Rldiwgc3RydWN0IHNr
X2J1ZmYgKnNrYl9jMmgsIHUzMiBsZW4pDQo+ID4gIHsNCj4gPiArICAgICBjb25zdCBzdHJ1Y3Qg
cnR3ODlfYzJoX2Jjbl91cGRfZG9uZSAqYzJoID0NCj4gPiArICAgICAgICAgICAgIChjb25zdCBz
dHJ1Y3QgcnR3ODlfYzJoX2Jjbl91cGRfZG9uZSAqKXNrYl9jMmgtPmRhdGE7DQo+ID4gKyAgICAg
dTggYmFuZCwgcG9ydCwgbWJzc2lkOw0KPiA+ICsNCj4gPiArICAgICBwb3J0ID0gbGUzMl9nZXRf
Yml0cyhjMmgtPncyLCBSVFc4OV9DMkhfQkNOX1VQRF9ET05FX1cyX1BPUlQpOw0KPiA+ICsgICAg
IG1ic3NpZCA9IGxlMzJfZ2V0X2JpdHMoYzJoLT53MiwgUlRXODlfQzJIX0JDTl9VUERfRE9ORV9X
Ml9NQlNTSUQpOw0KPiA+ICsgICAgIGJhbmQgPSBsZTMyX2dldF9iaXRzKGMyaC0+dzIsIFJUVzg5
X0MySF9CQ05fVVBEX0RPTkVfVzJfQkFORF9JRFgpOw0KPiA+ICsNCj4gPiArICAgICBydHc4OV9k
ZWJ1ZyhydHdkZXYsIFJUVzg5X0RCR19GVywNCj4gPiArICAgICAgICAgICAgICAgICAiQkNOIHVw
ZGF0ZSBkb25lIG9uIHBvcnQ6JWQgbWJzc2lkOiVkIGJhbmQ6JWQiLA0KPiANCj4gXG4gPw0KDQpX
aWxsIGZpeCBpdCBieSB2Mi4gVGhhbmtzIGZvciB0aGUgcmV2aWV3LiANCg0KPiANCj4gPiArICAg
ICAgICAgICAgICAgICBwb3J0LCBtYnNzaWQsIGJhbmQpOw0KPiA+ICB9DQo+ID4NCj4gPiAgc3Rh
dGljIHZvaWQNCg0K

