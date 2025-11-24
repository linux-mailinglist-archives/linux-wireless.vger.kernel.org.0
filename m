Return-Path: <linux-wireless+bounces-29279-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id C3A11C7F5E9
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 09:16:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 6BE804E2772
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 08:16:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AFDB1B983F;
	Mon, 24 Nov 2025 08:16:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="fVe0z++A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02088BE5E;
	Mon, 24 Nov 2025 08:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763972200; cv=none; b=Dzm/MK06+kJoNsoU880t8QgQsL358HP9enu0QcSpmDfn25ma0/6H30VOrxNVuzC7cOYKFOGnDzy8Z3Mp40qeSPAv5ctGOzCFVJamdRy5drN7EMO8AHOAWvD+aKReUPKcafiBXeRphGHurCjjUx4WY7g9qZ0Li61CJH/NpYyiOgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763972200; c=relaxed/simple;
	bh=gFD2MJ6Tbiv/oDeIRZs61P+OFMH3WapwilJzwE0qfDY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=ddVMnmxDraARI5q76oPTzP0B0MXvI57p/8Ype4Yg2G4AeqBwqpIaZyAmiMwX+d5cy3pSRjfsPUQ+ztREFNYns7w0qMJYXfydfQjSg4e8t1CEabe0hbuKntFi5XPsXV2BmRGL/MueGzcCMxVkOpg/+yA81VegJ1Jlfy3DtSxCcQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=fVe0z++A; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AO8GT5p8595945, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763972189; bh=gFD2MJ6Tbiv/oDeIRZs61P+OFMH3WapwilJzwE0qfDY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=fVe0z++AyrEeFt6sfaMfFl44MeF7ePPF6AhXJG4qepKiKdMKvhEdojpW8tuo5zX+r
	 zFimCWtyAGgMz6S6zVwAmlOcDe9uTNzN088mKBfcmDf53hwIUTiz+51OvmIFlEGpoq
	 oUW+g/MCppBrXiBxt98zrOCGlS+lTnCHVi0YK+oakUFt1Apv40d2J2PDiD6O/AzUTQ
	 Ng1Tz4n85OXy7aOu8FDZaY4362Qk4y8Eyxor/rnqaxXrE43T2b16yngw/9IaAXbgxi
	 4xAdKgzIwGdctLodBOrcVxLVyI1gr1lKXWjx1WYW7hfOXZu5LZYiCVGFCwL1jv5+QB
	 BleXvCYOTOpcA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AO8GT5p8595945
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 16:16:29 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 24 Nov 2025 16:16:29 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Mon, 24 Nov 2025 16:16:29 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Andrey Skvortsov <andrej.skvortzov@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "piotr.oniszczuk@gmail.com" <piotr.oniszczuk@gmail.com>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>,
        "stable@vger.kernel.org"
	<stable@vger.kernel.org>,
        "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>,
        Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>
Subject: RE: [PATCH rtw-next] wifi: rtw88: sdio: use indirect IO for device
 registers before power-on
Thread-Topic: [PATCH rtw-next] wifi: rtw88: sdio: use indirect IO for device
 registers before power-on
Thread-Index: AQHb/DS8S6Z9LuNHSkqUfz4BHLn6GLT/I7SAgAL+B7A=
Date: Mon, 24 Nov 2025 08:16:29 +0000
Message-ID: <4562797ed9514344b562f7a8e58e6988@realtek.com>
References: <20250724004815.7043-1-pkshih@realtek.com>
 <aSHrhbt29k6GJB8e@skv.local>
In-Reply-To: <aSHrhbt29k6GJB8e@skv.local>
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

QW5kcmV5IFNrdm9ydHNvdiA8YW5kcmVqLnNrdm9ydHpvdkBnbWFpbC5jb20+IHdyb3RlOg0KPiBI
aSwNCj4gDQo+IFRoaXMgcGF0Y2ggd2FzIHJlY2VudGx5IGJhY2twb3J0ZWQgdG8gc3RhYmxlIGtl
cm5lbHMgKHY2LjEyLjU4KSBhbmQgaXQgYnJva2UNCj4gd2xhbiBvbiBQaW5lUGhvbmUsIHRoYXQg
dXNlcyA4NzIzY3MgU0RJTyBjaGlwLiBUaGUgc2FtZSBwcm9ibGVtDQo+IGFwcGVhcnMgb2YgY291
cnNlIG9uIGxhdGVzdCA2LjE4LXJjNi4gUmV2ZXJ0aW5nIHRoaXMgY2hhbmdlIHJlc29sdmVzDQo+
IHRoZSBwcm9ibGVtLg0KPiANCj4gYGBgDQo+ICQgc3VkbyBkbWVzZyB8IGdyZXAgLWkgcnR3ODgN
Cj4gWyAgIDI0Ljk0MDU1MV0gcnR3ODhfODcyM2NzIG1tYzE6MDAwMToxOiBXT1cgRmlybXdhcmUg
dmVyc2lvbiAxMS4wLjAsIEgyQyB2ZXJzaW9uIDANCj4gWyAgIDI0Ljk1MzA4NV0gcnR3ODhfODcy
M2NzIG1tYzE6MDAwMToxOiBGaXJtd2FyZSB2ZXJzaW9uIDExLjAuMCwgSDJDIHZlcnNpb24gMA0K
PiBbICAgMjQuOTU1ODkyXSBydHc4OF84NzIzY3MgbW1jMTowMDAxOjE6IHNkaW8gcmVhZDMyIGZh
aWxlZCAoMHhmMCk6IC0xMTANCj4gWyAgIDI0Ljk3MzEzNV0gcnR3ODhfODcyM2NzIG1tYzE6MDAw
MToxOiBzZGlvIHdyaXRlOCBmYWlsZWQgKDB4MWMpOiAtMTEwDQo+IFsgICAyNC45ODA2NzNdIHJ0
dzg4Xzg3MjNjcyBtbWMxOjAwMDE6MTogc2RpbyByZWFkMzIgZmFpbGVkICgweGYwKTogLTExMA0K
PiAuLi4NCj4gWyAgIDI1LjQ0NjY5MV0gcnR3ODhfODcyM2NzIG1tYzE6MDAwMToxOiBzZGlvIHJl
YWQ4IGZhaWxlZCAoMHgxMDApOiAtMTEwDQo+IFsgICAyNS40NTM1NjldIHJ0dzg4Xzg3MjNjcyBt
bWMxOjAwMDE6MTogbWFjIHBvd2VyIG9uIGZhaWxlZA0KPiBbICAgMjUuNDU5MDc3XSBydHc4OF84
NzIzY3MgbW1jMTowMDAxOjE6IGZhaWxlZCB0byBwb3dlciBvbiBtYWMNCj4gWyAgIDI1LjQ2NDg0
MV0gcnR3ODhfODcyM2NzIG1tYzE6MDAwMToxOiBmYWlsZWQgdG8gc2V0dXAgY2hpcCBlZnVzZSBp
bmZvDQo+IFsgICAyNS40NjQ4NTZdIHJ0dzg4Xzg3MjNjcyBtbWMxOjAwMDE6MTogZmFpbGVkIHRv
IHNldHVwIGNoaXAgaW5mb3JtYXRpb24NCj4gWyAgIDI1LjQ3ODM0MV0gcnR3ODhfODcyM2NzIG1t
YzE6MDAwMToxOiBwcm9iZSB3aXRoIGRyaXZlciBydHc4OF84NzIzY3MgZmFpbGVkIHdpdGggZXJy
b3IgLTExNA0KPiBgYGANCj4gDQoNCkNoZWNrIG9yaWdpbmFsIGxpbmsgb2YgdGhpcyBwYXRjaCBb
MV0gdGhhdCA4ODIyY3MgcmVhZCBpbmNvcnJlY3QgZnJvbSAweGYwDQpyZXN1bHRpbmcgaW4gInJ0
dzg4Xzg4MjJjcyBtbWMxOjAwMDE6MTogdW5zdXBwb3J0ZWQgcmYgcGF0aCAoMSkiLg0KDQpJIHdv
bmRlciBpZiB3ZSBjYW4gYWRkIGFkZGl0aW9uYWwgY2hlY2tpbmcgcnVsZSBvZiBjaGlwIElELCBs
aWtlOg0KDQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3NkaW8uYw0K
KysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9zZGlvLmMNCkBAIC0xNDQs
OCArMTQ0LDEwIEBAIHN0YXRpYyB1MzIgcnR3X3NkaW9fdG9faW9fYWRkcmVzcyhzdHJ1Y3QgcnR3
X2RldiAqcnR3ZGV2LCB1MzIgYWRkciwNCg0KIHN0YXRpYyBib29sIHJ0d19zZGlvX3VzZV9kaXJl
Y3RfaW8oc3RydWN0IHJ0d19kZXYgKnJ0d2RldiwgdTMyIGFkZHIpDQogew0KKyAgICAgICBib29s
IG1pZ2h0X2luZGlyZWN0X3VuZGVyX3Bvd2VyX29mZiA9IHJ0d2Rldi0+Y2hpcC0+aWQgIT0gUlRX
X0NISVBfVFlQRV84NzAzQjsNCisNCiAgICAgICAgaWYgKCF0ZXN0X2JpdChSVFdfRkxBR19QT1dF
Uk9OLCBydHdkZXYtPmZsYWdzKSAmJg0KLSAgICAgICAgICAgIXJ0d19zZGlvX2lzX2J1c19hZGRy
KGFkZHIpKQ0KKyAgICAgICAgICAgIXJ0d19zZGlvX2lzX2J1c19hZGRyKGFkZHIpICYmIG1pZ2h0
X2luZGlyZWN0X3VuZGVyX3Bvd2VyX29mZikNCiAgICAgICAgICAgICAgICByZXR1cm4gZmFsc2U7
DQoNCiAgICAgICAgcmV0dXJuICFydHdfc2Rpb19pc19zZGlvMzBfc3VwcG9ydGVkKHJ0d2Rldikg
fHwNCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzLzY5OUMyMkI0
LUEzRTMtNDIwNi05N0QwLTIyQUIzMzQ4RUJGNkBnbWFpbC5jb20vVC8jdA0KDQo=

