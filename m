Return-Path: <linux-wireless+bounces-26546-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 04F34B30A46
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 02:26:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CB71E7B66FD
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Aug 2025 00:24:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3B1224A3E;
	Fri, 22 Aug 2025 00:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="LKQetfVC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E9B5EC2
	for <linux-wireless@vger.kernel.org>; Fri, 22 Aug 2025 00:25:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755822358; cv=none; b=HZtp64+klGprxg1EIbFx22Go7zuqwV8XXJpfKUDNfQS86Kgl+nLPkDuRCWNzL6BG3aE1ololof28Sxq2DfoOcULTS0dJmOn21n5EXQIVXVCeIAzJnhwH/WlqYp+sddK1QQVhiqINVdP3saQy7dwFqum3FfLpoghphjas/yyDqWA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755822358; c=relaxed/simple;
	bh=xhcPMpl4/GcVD4V6yL0Qgro9d9dW4c0eblUFf5XOpdM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H4iHjo6/ykUpkodGYN4CI2z3EhvcFjFuANMahg7j4GVEJkoaCt4X3U+VPdzqRANCxaaiy72Z6UMCefcg9a1JhJzNJa0oDBHoMTcQUKj/+3x3s+j0c2Rw51vqU+jWwLKqeLb6pI1FUcIl9AOi76Gu2+ufMzeHE+aNCHxgIZaNfKc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=LKQetfVC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57M0PnQA2756622, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1755822349; bh=xhcPMpl4/GcVD4V6yL0Qgro9d9dW4c0eblUFf5XOpdM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=LKQetfVCwtOOom0iRSKX4xjyg/A8WtAeZiE3L+foZEwu5JV3C579aQoBOGE6qHQzc
	 z193QVvfPnr588e/U4EO4VjIlHBQ5B2KRJvJsdwl5Kx1aHJmaWMtmebNtC0thjvyaf
	 Ljg5pz3WNpUJxp7nvqZfeTO7HN8oHHKS4fSwLPht44TOUuvn9+MeM85M+bBi/30EHB
	 w7UdGgIKyReeQX7ovssKKBdNvlJdJ3Swt+sfNmJ6HaAk8EeL/3bDKaDo0T7/VyX+py
	 HOVDuIHXKxTo+HCsinPCjuDDPqoDsIskxYGHySexMFIVmx9RS0CnmRYnfar6fZugp9
	 TSZ8uQm8LbjaQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57M0PnQA2756622
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Aug 2025 08:25:49 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 22 Aug 2025 08:25:49 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 22 Aug 2025 08:25:49 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Fri, 22 Aug 2025 08:25:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw88: Use led->brightness_set_blocking for PCI too
Thread-Topic: [PATCH rtw-next] wifi: rtw88: Use led->brightness_set_blocking
 for PCI too
Thread-Index: AQHcETmIv+aZT9I26ke2y0xZfWH+qLRqrHEAgAH1GYCAATG0oA==
Date: Fri, 22 Aug 2025 00:25:49 +0000
Message-ID: <e7b62ef6609b46c9b2eea1320f036881@realtek.com>
References: <ad8a49ef-4f2d-4a61-8292-952db9c4eb65@gmail.com>
 <aba7583da5fc48bca933d4b5d2fae6aa@realtek.com>
 <c4b1d9c4-59c1-4508-ad3d-3a3e0d3f7ee7@gmail.com>
In-Reply-To: <c4b1d9c4-59c1-4508-ad3d-3a3e0d3f7ee7@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAy
MC8wOC8yMDI1IDAzOjI2LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBDb21taXQgMjZhOGJmOTc4
YWU5ICgid2lmaTogcnR3ODg6IExvY2sgcnR3ZGV2LT5tdXRleCBiZWZvcmUgc2V0dGluZw0KPiA+
PiB0aGUgTEVEIikgbWFkZSBydHdfbGVkX3NldCgpIHNsZWVwLCBidXQgdGhhdCdzIG5vdCBhbGxv
d2VkLiBGaXggaXQgYnkNCj4gPj4gdXNpbmcgdGhlIGJyaWdodG5lc3Nfc2V0X2Jsb2NraW5nIG1l
bWJlciBvZiBzdHJ1Y3QgbGVkX2NsYXNzZGV2IGZvcg0KPiA+PiBQQ0kgZGV2aWNlcyB0b28uIFRo
aXMgb25lIGlzIGFsbG93ZWQgdG8gc2xlZXAuDQo+ID4+DQo+ID4+IGJhZDogc2NoZWR1bGluZyBm
cm9tIHRoZSBpZGxlIHRocmVhZCENCj4gPj4gbml4IGtlcm5lbDogQ1BVOiA3IFVJRDogMCBQSUQ6
IDAgQ29tbTogc3dhcHBlci83IFRhaW50ZWQ6IEcgICAgICAgIFcgIE8gICAgICAgIDYuMTYuMCAj
MS1OaXhPUw0KPiA+PiBQUkVFTVBUKHZvbHVudGFyeSkNCj4gPj4gbml4IGtlcm5lbDogVGFpbnRl
ZDogW1ddPVdBUk4sIFtPXT1PT1RfTU9EVUxFDQo+ID4+IG5peCBrZXJuZWw6IEhhcmR3YXJlIG5h
bWU6IFtSRURBQ1RFRF0NCj4gPj4gbml4IGtlcm5lbDogQ2FsbCBUcmFjZToNCj4gPj4gbml4IGtl
cm5lbDogIDxJUlE+DQo+ID4+IG5peCBrZXJuZWw6ICBkdW1wX3N0YWNrX2x2bCsweDYzLzB4OTAN
Cj4gPj4gbml4IGtlcm5lbDogIGRlcXVldWVfdGFza19pZGxlKzB4MmQvMHg1MA0KPiA+PiBuaXgg
a2VybmVsOiAgX19zY2hlZHVsZSsweDE5MS8weDEzMTANCj4gPj4gbml4IGtlcm5lbDogID8geGFz
X2xvYWQrMHgxMS8weGQwDQo+ID4+IG5peCBrZXJuZWw6ICBzY2hlZHVsZSsweDJiLzB4ZTANCj4g
Pj4gbml4IGtlcm5lbDogIHNjaGVkdWxlX3ByZWVtcHRfZGlzYWJsZWQrMHgxOS8weDMwDQo+ID4+
IG5peCBrZXJuZWw6ICBfX211dGV4X2xvY2suY29uc3Rwcm9wLjArMHgzZmQvMHg3ZDANCj4gPj4g
bml4IGtlcm5lbDogIHJ0d19sZWRfc2V0KzB4MjcvMHg2MCBbcnR3X2NvcmVdDQo+ID4+IG5peCBr
ZXJuZWw6ICBsZWRfYmxpbmtfc2V0X25vc2xlZXArMHg1Ni8weGIwDQo+ID4+IG5peCBrZXJuZWw6
ICBsZWRfdHJpZ2dlcl9ibGluaysweDQ5LzB4ODANCj4gPj4gbml4IGtlcm5lbDogID8gX19wZnhf
dHB0X3RyaWdfdGltZXIrMHgxMC8weDEwIFttYWM4MDIxMV0NCj4gPj4gbml4IGtlcm5lbDogIGNh
bGxfdGltZXJfZm4rMHgyZi8weDE0MA0KPiA+PiBuaXgga2VybmVsOiAgPyBfX3BmeF90cHRfdHJp
Z190aW1lcisweDEwLzB4MTAgW21hYzgwMjExXQ0KPiA+PiBuaXgga2VybmVsOiAgX19ydW5fdGlt
ZXJzKzB4MjFhLzB4MmIwDQo+ID4+IG5peCBrZXJuZWw6ICBydW5fdGltZXJfc29mdGlycSsweDhl
LzB4MTAwDQo+ID4+IG5peCBrZXJuZWw6ICBoYW5kbGVfc29mdGlycXMrMHhlYS8weDJjMA0KPiA+
PiBuaXgga2VybmVsOiAgPyBzcnNvX2FsaWFzX3JldHVybl90aHVuaysweDUvMHhmYmVmNQ0KPiA+
PiBuaXgga2VybmVsOiAgX19pcnFfZXhpdF9yY3UrMHhkYy8weDEwMA0KPiA+PiBuaXgga2VybmVs
OiAgc3lzdmVjX2FwaWNfdGltZXJfaW50ZXJydXB0KzB4N2MvMHg5MA0KPiA+PiBuaXgga2VybmVs
OiAgPC9JUlE+DQo+ID4+IG5peCBrZXJuZWw6ICA8VEFTSz4NCj4gPj4gbml4IGtlcm5lbDogIGFz
bV9zeXN2ZWNfYXBpY190aW1lcl9pbnRlcnJ1cHQrMHgxYS8weDIwDQo+ID4+IG5peCBrZXJuZWw6
IFJJUDogMDAxMDpjcHVpZGxlX2VudGVyX3N0YXRlKzB4Y2MvMHg0NTANCj4gPj4gbml4IGtlcm5l
bDogQ29kZTogMDAgZTggMDggN2MgMmUgZmYgZTggZDMgZWUgZmYgZmYgNDkgODkgYzYgMGYgMWYg
NDQgMDAgMDAgMzEgZmYgZTggYzQgZDEgMmMgZmYgODAgN2QNCj4gZDcNCj4gPj4gMDAgMGYgODUg
NWQgMDIgMDAgMDAgZmIgMGYgMWYgNDQgMDAgMDAgPDQ1PiA4NSBmZiAwZiA4OCBhMCAwMSAwMCAw
MCA0OSA2MyBmNyA0YyA4OSBmMiA0OCA4ZCAwPg0KPiA+PiBuaXgga2VybmVsOiBSU1A6IDAwMTg6
ZmZmZmQ1Nzk4MDFjN2U2OCBFRkxBR1M6IDAwMDAwMjQ2DQo+ID4+IG5peCBrZXJuZWw6IFJBWDog
MDAwMDAwMDAwMDAwMDAwMCBSQlg6IDAwMDAwMDAwMDAwMDAwMDMgUkNYOiAwMDAwMDAwMDAwMDAw
MDAwDQo+ID4+IG5peCBrZXJuZWw6IFJEWDogMDAwMDAwMDAwMDAwMDAwMCBSU0k6IDAwMDAwMDAw
MDAwMDAwMDAgUkRJOiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4+IG5peCBrZXJuZWw6IFJCUDogZmZm
ZmQ1Nzk4MDFjN2VhMCBSMDg6IDAwMDAwMDAwMDAwMDAwMDAgUjA5OiAwMDAwMDAwMDAwMDAwMDAw
DQo+ID4+IG5peCBrZXJuZWw6IFIxMDogMDAwMDAwMDAwMDAwMDAwMCBSMTE6IDAwMDAwMDAwMDAw
MDAwMDAgUjEyOiBmZmZmOGVhYjA0NjJhNDAwDQo+ID4+IG5peCBrZXJuZWw6IFIxMzogZmZmZmZm
ZmY5YTdkN2EyMCBSMTQ6IDAwMDAwMDAzYWViZTc1MWQgUjE1OiAwMDAwMDAwMDAwMDAwMDAzDQo+
ID4+IG5peCBrZXJuZWw6ICA/IGNwdWlkbGVfZW50ZXJfc3RhdGUrMHhiYy8weDQ1MA0KPiA+PiBu
aXgga2VybmVsOiAgY3B1aWRsZV9lbnRlcisweDMyLzB4NTANCj4gPj4gbml4IGtlcm5lbDogIGRv
X2lkbGUrMHgxYjEvMHgyMTANCj4gPj4gbml4IGtlcm5lbDogIGNwdV9zdGFydHVwX2VudHJ5KzB4
MmQvMHgzMA0KPiA+PiBuaXgga2VybmVsOiAgc3RhcnRfc2Vjb25kYXJ5KzB4MTE4LzB4MTQwDQo+
ID4+IG5peCBrZXJuZWw6ICBjb21tb25fc3RhcnR1cF82NCsweDEzZS8weDE0MQ0KPiA+PiBuaXgg
a2VybmVsOiAgPC9UQVNLPg0KPiA+Pg0KPiA+PiBGaXhlczogMjZhOGJmOTc4YWU5ICgid2lmaTog
cnR3ODg6IExvY2sgcnR3ZGV2LT5tdXRleCBiZWZvcmUgc2V0dGluZyB0aGUgTEVEIikNCj4gPg0K
PiA+IENjOiBzdGFibGVAdmdlci5rZXJuZWwub3JnDQo+ID4NCj4gPj4gU2lnbmVkLW9mZi1ieTog
Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+ID4NCj4gPiBBY2tl
ZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+ID4NCj4gPj4gLS0tDQo+
ID4+IEknbSBub3Qgc3VyZSBpZiB0aGUgY29tbWl0IGhhc2ggd2lsbCBiZSBjb3JyZWN0IGJ5IHRo
ZSB0aW1lIHRoYXQNCj4gPj4gY29tbWl0IG1ha2VzIGl0IGludG8gbWFpbmxpbmU/DQo+ID4NCj4g
PiBXZSBhbHdheXMgZ28gdmlhIHdpcmVsZXNzIC8gd2lyZWxlc3MtbmV4dCB0cmVlLCBzbyB0aGUg
Y29tbWl0IG11c3QgYmUgdGhlcmUNCj4gPiBhbHJlYWR5LiBPbmx5IHF1ZXN0aW9uIGlzIHRoYXQg
eW91IHdhbnQgNi4xNyAoY3VycmVudGx5IC1yYzIpIG9yIDYuMTggKG5leHQpPw0KPiA+IEkgdGhp
bmsgdGhpcyBzaG91bGQgYmUgNi4xNywgc28gdHJlZSBzZWxlY3Rpb24gb2Ygc3ViamVjdCB0YWcg
c2hvdWxkIGJlDQo+ID4gInJ0dyIgaW5zdGVhZCBvZiAicnR3LW5leHQiLg0KPiANCj4gQ29tbWl0
IDI2YThiZjk3OGFlOSBpcyBub3QgaW4gd2lyZWxlc3MtbmV4dCB5ZXQsIG9ubHkgaW4gcnR3LW5l
eHQuDQoNCkFoLiBJIG1pc3NlZCB0aGlzLiBUaGVuLCBqdXN0IG1lcmdlIHRoaXMgaW50byBydHct
bmV4dCB3aXRob3V0IENjIHN0YWJsZS4NCg0KDQo=

