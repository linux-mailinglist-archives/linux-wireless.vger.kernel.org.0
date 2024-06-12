Return-Path: <linux-wireless+bounces-8823-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 4F0BA904820
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 02:56:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B882F1F233BC
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 00:56:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1498715BB;
	Wed, 12 Jun 2024 00:56:52 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015B610FA;
	Wed, 12 Jun 2024 00:56:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718153812; cv=none; b=Un5SeJ4QOV7rpjJDhE8HzI7bkdPWNeMDrNT6OKLgilr61XQys9yz3g1329hHJISkPkEUGkYyS7ebMlKPRkMLxv448Cwuup8muJhgnNxcDYXbVDO0ZDW+vZP6/TlZnRYnZ9R4OSJ+ZY3onFYsALwPXJTmktFrNcf7G1fxTbp6qQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718153812; c=relaxed/simple;
	bh=WQEDdfIS01MttyVRpOjGsxOxeNT975E9YgMc/ccKkCo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Klf2UsqOYQ5kZ5tx2W29NHAHNzIH7wNQ6sJKyzMWXc4pyywx2v84o0T1Ts5zDKh213eidRRKyyFJ5zWlTi8dbg89jJRLpBJ5Gu2ju4tNCVNyaQlB4e/lmumt4dMQPOia8SJH3BMej0XbtMSJxxGbhNBlfectdNhRroP5jM8yIJI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45C0uKsI5643612, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45C0uKsI5643612
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 08:56:20 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 08:56:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 12 Jun 2024 08:56:20 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 12 Jun 2024 08:56:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Thorsten Leemhuis
	<regressions@leemhuis.info>,
        Savyasaachi Vanga <savyasaachiv@gmail.com>,
        Christian Heusel <christian@heusel.eu>
CC: Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        "regressions@lists.linux.dev"
	<regressions@lists.linux.dev>
Subject: RE: [REGRESSION][BISECTED] wifi: RTL8821CE does not work in monitor mode
Thread-Topic: [REGRESSION][BISECTED] wifi: RTL8821CE does not work in monitor
 mode
Thread-Index: AQHasIGBiI2kIPT9xk+a42EavL0uE7GryNkAgASPDICABOUZsIANAvMAgAEhOEA=
Date: Wed, 12 Jun 2024 00:56:20 +0000
Message-ID: <5318640d6eb74301b1fbf6d9385ba69e@realtek.com>
References: <chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl>
	 <a51f223f-18ac-4d67-9120-8da1c169b7eb@leemhuis.info>
	 <809d2332-625e-4a46-a77e-ca2e49b0d651@leemhuis.info>
	 <0e65ca6b471b4186a370b9a57de11abe@realtek.com>
 <36c1f49acfcc2cc16c7e54ffeb76f1e93cb96e91.camel@sipsolutions.net>
In-Reply-To: <36c1f49acfcc2cc16c7e54ffeb76f1e93cb96e91.camel@sipsolutions.net>
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

Sm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4gd3JvdGU6DQo+IA0KPiBP
biBNb24sIDIwMjQtMDYtMDMgYXQgMDA6NDcgKzAwMDAsIFBpbmctS2UgU2hpaCB3cm90ZToNCj4g
Pg0KPiA+DQo+ID4gV2UgaGF2ZSBhIGRyYWZ0IGZpeCBvZiBydHc4OCBkcml2ZXIgZm9yIFJUTDg4
MjFDRSwgYnV0IGFzIG1lbnRpb25lZCBzb21lIGRyaXZlcnMNCj4gPiBhcmUgYWZmZWN0ZWQsIHNv
IEkgZG9uJ3QgcGxhbiB0byBzZW5kIG91dCB0aGUgcGF0Y2guIEluc3RlYWQgd2UgYXJlIGxvb2tp
bmcgZm9yDQo+ID4gdGhlIGZpeCBvZiBjZmc4MDIxMS9tYWM4MDIxMS4NCj4gPg0KPiANCj4gR3Vl
c3MgeW91IGRpZG4ndCBmaW5kIGl0IDopDQoNCllvdSBhcmUgcmlnaHQuIFRoYXQgaXMgbm90IGVh
c3kgdG8gbWUuIDopDQoNCj4gDQo+IEp1c3QgZ290IHBpbmdlZCAoc3A/KSBhYm91dCB0aGlzLCBj
YW4geW91IHNoYXJlIHRoZSBkcml2ZXIgZml4IHNvIEkgY2FuDQo+IHRha2UgYSBsb29rIHdoYXQg
dGhlIGlzc3VlIGlzIGFib3V0Pw0KPiANCg0KUGxlYXNlIHJlZmVyZW5jZSBwYXRjaCBiZWxvdy4g
SSBjb3B5IHRoaXMgaWRlYSBmcm9tIHJ0dzg5IFsxXSwgd2hpY2ggdGhlIG1haW4NCnN0dWZmIGlz
IHRvIGFkZCBXQU5UX01PTklUT1JfVklGIGFuZCBjYXNlIE5MODAyMTFfSUZUWVBFX01PTklUT1Ig
aW4gYWRkX2ludGVyZmFjZSgpLiANCkFkZGl0aW9uYWxseSBjaGVjayB3aGV0aGVyIGJzc2lkIGlz
IE5VTEwuDQoNCk1hbnkgb3RoZXIgZHJpdmVycyBsaWtlIHJ0bHdpZmksIHJ0bDh4eHh1ZSAuLi4g
ZG9uJ3QgZGVjbGFyZSBXQU5UX01PTklUT1JfVklGLCBzbw0KSSB0aGluayBpdCB3b3VsZCBiZSBi
ZXR0ZXIgdG8gZml4IHRoaXMgYnkgbWFjODAyMTEgaW5zdGVhZCBvZiBmaXhpbmcgdGhlc2UgZHJp
dmVycw0Kb25lIGJ5IG9uZS4gDQoNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3JlYWx0ZWsvcnR3ODgvbWFjODAyMTEuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnR3ODgvbWFjODAyMTEuYw0KaW5kZXggMGFjZWJiZmExM2M0Li5iOTBkMDI2NTE5ZTIgMTAwNjQ0
DQotLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21hYzgwMjExLmMNCisr
KyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFjODAyMTEuYw0KQEAgLTE5
MSw2ICsxOTEsNyBAQCBzdGF0aWMgaW50IHJ0d19vcHNfYWRkX2ludGVyZmFjZShzdHJ1Y3QgaWVl
ZTgwMjExX2h3ICpodywNCiAgICAgICAgICAgICAgICBiY25fY3RybCA9IEJJVF9FTl9CQ05fRlVO
Q1RJT04gfCBCSVRfRElTX1RTRl9VRFQ7DQogICAgICAgICAgICAgICAgYnJlYWs7DQogICAgICAg
IGNhc2UgTkw4MDIxMV9JRlRZUEVfU1RBVElPTjoNCisgICAgICAgY2FzZSBOTDgwMjExX0lGVFlQ
RV9NT05JVE9SOg0KICAgICAgICAgICAgICAgIHJ0d19hZGRfcnN2ZF9wYWdlX3N0YShydHdkZXYs
IHJ0d3ZpZik7DQogICAgICAgICAgICAgICAgbmV0X3R5cGUgPSBSVFdfTkVUX05PX0xJTks7DQog
ICAgICAgICAgICAgICAgYmNuX2N0cmwgPSBCSVRfRU5fQkNOX0ZVTkNUSU9OOw0KZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFpbi5jIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWluLmMNCmluZGV4IDdhYjdhOTg4YjEyMy4uZDUx
YzdjYWQ3OWRhIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4
OC9tYWluLmMNCisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvbWFpbi5j
DQpAQCAtMjIzMSw2ICsyMjMxLDcgQEAgaW50IHJ0d19yZWdpc3Rlcl9odyhzdHJ1Y3QgcnR3X2Rl
diAqcnR3ZGV2LCBzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodykNCiAgICAgICAgaWVlZTgwMjExX2h3
X3NldChodywgSEFTX1JBVEVfQ09OVFJPTCk7DQogICAgICAgIGllZWU4MDIxMV9od19zZXQoaHcs
IFRYX0FNU0RVKTsNCiAgICAgICAgaWVlZTgwMjExX2h3X3NldChodywgU0lOR0xFX1NDQU5fT05f
QUxMX0JBTkRTKTsNCisgICAgICAgaWVlZTgwMjExX2h3X3NldChodywgV0FOVF9NT05JVE9SX1ZJ
Rik7DQoNCiAgICAgICAgaWYgKHN0YV9tb2RlX29ubHkpDQogICAgICAgICAgICAgICAgaHctPndp
cGh5LT5pbnRlcmZhY2VfbW9kZXMgPSBCSVQoTkw4MDIxMV9JRlRZUEVfU1RBVElPTik7DQpkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9waHkuYyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcGh5LmMNCmluZGV4IDM3ZWY4MGM5MDkxZC4u
YjFiNzg5MjI2NmYwIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OC9waHkuYw0KKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9waHku
Yw0KQEAgLTYyNyw2ICs2MjcsOSBAQCBzdGF0aWMgdm9pZCBydHdfcGh5X3BhcnNpbmdfY2ZvX2l0
ZXIodm9pZCAqZGF0YSwgdTggKm1hYywNCiAgICAgICAgdTggKmJzc2lkID0gaXRlcl9kYXRhLT5i
c3NpZDsNCiAgICAgICAgdTggaTsNCg0KKyAgICAgICBpZiAoIXZpZi0+YnNzX2NvbmYuYnNzaWQp
DQorICAgICAgICAgICAgICAgcmV0dXJuOw0KKw0KICAgICAgICBpZiAoIWV0aGVyX2FkZHJfZXF1
YWwodmlmLT5ic3NfY29uZi5ic3NpZCwgYnNzaWQpKQ0KICAgICAgICAgICAgICAgIHJldHVybjsN
CmRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J4LmMgYi9k
cml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J4LmMNCmluZGV4IDg0YWVkYWJkZjI4
NS4uNDNhYTVkZDZmMmNjIDEwMDY0NA0KLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRl
ay9ydHc4OC9yeC5jDQorKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J4
LmMNCkBAIC0xMDQsNiArMTA0LDkgQEAgc3RhdGljIHZvaWQgcnR3X3J4X2FkZHJfbWF0Y2hfaXRl
cih2b2lkICpkYXRhLCB1OCAqbWFjLA0KICAgICAgICBzdHJ1Y3QgcnR3X3J4X3BrdF9zdGF0ICpw
a3Rfc3RhdCA9IGl0ZXJfZGF0YS0+cGt0X3N0YXQ7DQogICAgICAgIHU4ICpic3NpZCA9IGl0ZXJf
ZGF0YS0+YnNzaWQ7DQoNCisgICAgICAgaWYgKCF2aWYtPmJzc19jb25mLmJzc2lkKQ0KKyAgICAg
ICAgICAgICAgIHJldHVybjsNCisNCiAgICAgICAgaWYgKCFldGhlcl9hZGRyX2VxdWFsKHZpZi0+
YnNzX2NvbmYuYnNzaWQsIGJzc2lkKSkNCiAgICAgICAgICAgICAgICByZXR1cm47DQoNCg0KWzFd
IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3dpcmVsZXNz
L3dpcmVsZXNzLW5leHQuZ2l0L2NvbW1pdC9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
dzg5P2lkPWNkOWI2YjNiYWY1Mjc4YzczYzkxZTI0MmQ0MTM4NzY4NGZjN2Y4ZDgNCg0KDQoNCg==

