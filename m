Return-Path: <linux-wireless+bounces-11452-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id D8FE6952933
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 08:10:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E0D51C208FC
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 06:10:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0879D17625E;
	Thu, 15 Aug 2024 06:10:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="ty/U6ijC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09A7138DC8
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 06:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723702209; cv=none; b=UPO5U8pHsKEneXDiddjjHxv0vieruwu/O3x7NEaTxEVR5+Tzy1L/zBmFMAVW7+q0PU6csMmKSp8LUQqdLnPCATvAYIThRpTylQEXKMVvrdmprju5na6nY6plcGlpraC19oCXz7b/FIpTV06UHMPswfTyf03tEMe2iEznakCgUW0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723702209; c=relaxed/simple;
	bh=gIuy3GOnPADV0QVQoXxgKh0plRhcuDlGe1X7pyjrNIk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Gg4+5oz+9kb+beIn8epoI/8e7rbAMmwq2Bz0ylFo1oKGm1eKp5c72B8UR8d9VygkGS1Sz6bTl0w8Drj8ApHhyblLnTIXbr4gyCxPyTWcPj0+4cRvbkwNNJcEUOEyD0TU7qx60UEVD8H7vDY3iclyE4Rp4lCmF+Xm0bYo15xvMXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=ty/U6ijC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47F6A2Ww83687378, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723702202; bh=gIuy3GOnPADV0QVQoXxgKh0plRhcuDlGe1X7pyjrNIk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=ty/U6ijClRsBrsH0pGc894LFDhN1TFfvLwhtTyiYqWrZVwEc83clZ7gV3sUCyB6W0
	 MikJFdM7rbApqjvC/7IE37fWwNXAiDZNYPFx6flLstCaVRqBNuYVu9eyyKNet4Sdu9
	 /T6ffp3n/TJ1FLjN4U1y5KS9SNZ9qIUk+6KP1wYXnbBTY7HvcgKGhEj+AookesWGPC
	 RbTiit5Y3oB2UUM8ro5KAFbgTXk9USc8HZckoeDom4h0jDhW049wHg0LLiwn1ND116
	 x+eh1Hn3Bv/BQIPAzwi+OiatQLTatJnXa3bI5+LttB06ANksnNpU4NuvtSs2kRzbpP
	 /QVMNhBYTubMw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47F6A2Ww83687378
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 14:10:02 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 14:10:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Aug 2024 14:10:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 15 Aug 2024 14:10:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 02/20] wifi: rtw88: Dump the HW features only for some chips
Thread-Topic: [PATCH 02/20] wifi: rtw88: Dump the HW features only for some
 chips
Thread-Index: AQHa7DC0mcVwn26DWUiI/ybGM5dmjrIn2SXA
Date: Thu, 15 Aug 2024 06:10:02 +0000
Message-ID: <25cc8b40a3754e5c8e444aedaae5e8aa@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <32cce43e-8495-4f82-8ab4-527e1606fee3@gmail.com>
In-Reply-To: <32cce43e-8495-4f82-8ab4-527e1606fee3@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBSVEw4
ODIxQVUgYW5kIFJUTDg4MTJBVSBkb24ndCBzdXBwb3J0IHRoaXMuIFRoZXkgaGl0IHRoZSAiZmFp
bGVkIHRvIHJlYWQNCj4gaHcgZmVhdHVyZSByZXBvcnQiIGVycm9yLg0KPiANCj4gU2lnbmVkLW9m
Zi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IC0tLQ0K
PiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWluLmMgICAgIHwgNCArKysr
DQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21haW4uaCAgICAgfCAxICsN
Cj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcnR3ODcwM2IuYyB8IDEgKw0K
PiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9ydHc4NzIzZC5jIHwgMSArDQo+
ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4MjFjLmMgfCAxICsNCj4g
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcnR3ODgyMmIuYyB8IDEgKw0KPiAg
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9ydHc4ODIyYy5jIHwgMSArDQo+ICA3
IGZpbGVzIGNoYW5nZWQsIDEwIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21haW4uYyBiL2RyaXZlcnMvbmV0L3dpcmVs
ZXNzL3JlYWx0ZWsvcnR3ODgvbWFpbi5jDQo+IGluZGV4IGZmMDQ1ZGZkY2E0YS4uYWViMjFhYzI1
ZTJlIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21h
aW4uYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21haW4uYw0K
PiBAQCAtMTkyMyw2ICsxOTIzLDkgQEAgc3RhdGljIGludCBydHdfZHVtcF9od19mZWF0dXJlKHN0
cnVjdCBydHdfZGV2ICpydHdkZXYpDQo+ICAgICAgICAgdTggYnc7DQo+ICAgICAgICAgaW50IGk7
DQo+IA0KPiArICAgICAgIGlmICghcnR3ZGV2LT5jaGlwLT5od19mZWF0dXJlX3JlcG9ydCkNCj4g
KyAgICAgICAgICAgICAgIGdvdG8gcHJpbnRfaHdfY2FwOw0KDQpTaW5jZSBjaGlwcyBkb24ndCBz
dXBwb3J0IG9mIGh3X2ZlYXR1cmVfcmVwb3J0LCBwcmludGluZyBodyBjYXBhYmlsaXRpZXMgc2Vl
bXMNCnVzZWxlc3MuIEp1c3QgJ3JldHVybic/DQoNCj4gKw0KPiAgICAgICAgIGlkID0gcnR3X3Jl
YWQ4KHJ0d2RldiwgUkVHX0MySEVWVCk7DQo+ICAgICAgICAgaWYgKGlkICE9IEMySF9IV19GRUFU
VVJFX1JFUE9SVCkgew0KPiAgICAgICAgICAgICAgICAgcnR3X2VycihydHdkZXYsICJmYWlsZWQg
dG8gcmVhZCBodyBmZWF0dXJlIHJlcG9ydFxuIik7DQo+IEBAIC0xOTQ3LDYgKzE5NTAsNyBAQCBz
dGF0aWMgaW50IHJ0d19kdW1wX2h3X2ZlYXR1cmUoc3RydWN0IHJ0d19kZXYgKnJ0d2RldikNCj4g
ICAgICAgICAgICAgZWZ1c2UtPmh3X2NhcC5uc3MgPiBydHdkZXYtPmhhbC5yZl9wYXRoX251bSkN
Cj4gICAgICAgICAgICAgICAgIGVmdXNlLT5od19jYXAubnNzID0gcnR3ZGV2LT5oYWwucmZfcGF0
aF9udW07DQo+IA0KPiArcHJpbnRfaHdfY2FwOg0KPiAgICAgICAgIHJ0d19kYmcocnR3ZGV2LCBS
VFdfREJHX0VGVVNFLA0KPiAgICAgICAgICAgICAgICAgImh3IGNhcDogaGNpPTB4JTAyeCwgYnc9
MHglMDJ4LCBwdGNsPTB4JTAyeCwgYW50X251bT0lZCwgbnNzPSVkXG4iLA0KPiAgICAgICAgICAg
ICAgICAgZWZ1c2UtPmh3X2NhcC5oY2ksIGVmdXNlLT5od19jYXAuYncsIGVmdXNlLT5od19jYXAu
cHRjbCwNCg0KWy4uLl0NCg0K

