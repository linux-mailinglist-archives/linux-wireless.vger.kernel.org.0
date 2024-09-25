Return-Path: <linux-wireless+bounces-13129-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 885FE98509F
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 03:25:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2E65AB211DD
	for <lists+linux-wireless@lfdr.de>; Wed, 25 Sep 2024 01:25:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49C66132122;
	Wed, 25 Sep 2024 01:25:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="hI7Iz0O/"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1E91EEA5
	for <linux-wireless@vger.kernel.org>; Wed, 25 Sep 2024 01:25:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727227542; cv=none; b=merf4K87A4EncVuWvfiTyRY0ir8gc9yKLCA3kcQ+omwXDQlpOD2er4AXTJcxNlccgGiTOVgWdvHUl/sVM/L6JS4GCecK/BUt5T84lElYxL/TT9BgGTbxoaXytLhn3APzeXAwirjygZFSvg9FSOKx6MegafqoV7ufVfPUsRAp1U4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727227542; c=relaxed/simple;
	bh=oRMCsq4FBxo+G65UREc/4VLmL/VhCacpIz3rMjEg7Aw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=H2aHVHM3ywFe7UVXtwGxdFJFR3TZ04ed0mcTBg6UUJcW2Vs3UboqNLzE0tgIMOLY2H1dCViS94A9I1WH9tSILV+IE33qwA8qm2yHQ+GYio/M+4Gl2GFGMFQk6JGchROXmNiF2d7yuBAMQyVrAx0+ruIMl5lAotii2H35g7A/cKg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=hI7Iz0O/; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48P1PTeV43810291, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727227529; bh=oRMCsq4FBxo+G65UREc/4VLmL/VhCacpIz3rMjEg7Aw=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=hI7Iz0O/XZ1b9D4DIro0DgKdL26kAjnSMHFfqdXEfyrQ5Og4N/K3vSzWF9TjkaUvK
	 QIbPPqcQ6dzooAXm9PAAqRFnvXzziwXU+WYx1Ldcj92dkMQ9IPdABmhyFdJ8VDLEJu
	 UJY4H5axkXpOEHkTXomWIiANSndEyKLHeWBf4JIYupUVQYKkRkOaSeZPpdgKNyrpj0
	 TwOAYmxSQCsPU0/n1c5DwjBrcx2javwhKn7CWMjIh3taR+fWxSnemZr3QBTgxg0TwP
	 2mbo/Cwxlg4cmbdImct9jSM6K0Yt3bt/ms17jvi5Ua4kyiPgcne3Y6GV7zDfat3QAa
	 636Hh7AGsIsaQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48P1PTeV43810291
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 25 Sep 2024 09:25:29 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 25 Sep 2024 09:25:29 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 25 Sep 2024 09:25:28 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 25 Sep 2024 09:25:28 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 18/20] wifi: rtw88: Add rtw8821a.{c,h}
Thread-Topic: [PATCH 18/20] wifi: rtw88: Add rtw8821a.{c,h}
Thread-Index: AQHa7DKP0miyRAHIW0qWSqezSXaH97IpJM5AgBHQWoCAFW7yIIADltQAgAEjSvCADXPMAIACikGAgAIUIQCAAMkHgA==
Date: Wed, 25 Sep 2024 01:25:28 +0000
Message-ID: <9c991498a48043d0b0b06dc05356cbae@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <f25d00ab-4481-4540-956b-bc1028a501e1@gmail.com>
 <e365c61d730d4f49915b543dcb0063d5@realtek.com>
 <dafaac0c-fb55-4406-b8ff-69aa66d3fd06@gmail.com>
 <1aca96c68f914f90b6d1baf8780e6ce4@realtek.com>
 <bebaa40a-1c7a-4b1e-99cd-7c7aac7c76f4@gmail.com>
 <f583e9470ca84234ad2e00f3a0371664@realtek.com>
 <38553e79-6747-4ab3-9bf4-fa7f2af852cd@gmail.com>
 <73de8e7135554ae9a0f7968780644515@realtek.com>
 <b4c9ff5c-a8ca-401f-aa79-3798239ffd57@gmail.com>
In-Reply-To: <b4c9ff5c-a8ca-401f-aa79-3798239ffd57@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAy
My8wOS8yMDI0IDA4OjQ3LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+Pj4+Pj4+PiArDQo+ID4+Pj4+
Pj4+ICtjb25zdCBzdHJ1Y3QgcnR3X2NoaXBfaW5mbyBydHc4ODEyYV9od19zcGVjID0gew0KPiA+
Pj4+Pj4+DQo+ID4+Pj4+Pj4gSXMgaXQgcG9zc2libGUgbW92aW5nIDg4MTJhIHRvIGluZGl2aWR1
YWwgZmlsZT8NCj4gPj4+Pj4+PiBTaW5jZSB5b3UgaGF2ZSBydHc4ODEyYXUuYyBhbmQgcnR3ODgy
MWF1LmMuDQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+DQo+ID4+Pj4+PiBJIHRoaW5rIGl0IGlzIHBvc3Np
YmxlLiBCdXQgbW9zdCBvZiB0aGUgY29kZSBpcyBjb21tb24gdG8gYm90aCBjaGlwcy4NCj4gPj4+
Pj4+IE9ubHkgdGhlIElRIGNhbGlicmF0aW9uIGNvdWxkIGJlIG1vdmVkLg0KPiA+Pj4+Pg0KPiA+
Pj4+PiBZZXAsIGRlcGVuZCBvbiBob3cgbXVjaCBJUUsgY29kZSBlY2hvIGNoaXAgaGFzLg0KPiA+
Pj4+Pg0KPiA+Pj4+DQo+ID4+Pj4gVGhlIElRIGNhbGlicmF0aW9uIGZvciBSVEw4ODEyQVUgaXMg
YWJvdXQgNzAwIGxpbmVzLg0KPiA+Pj4NCj4gPj4+IHJ0dzg4MTJhdSAgLS0tLS0+IChhKSBydHc4
ODEyYQ0KPiA+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiA+Pj4gICAgICAgICAgICAg
ICAgICAgICAgICAgdg0KPiA+Pj4gICAgICAgICAgICAgICAgICAgKGIpIHJ0dzg4MjFhX2NvbW1v
biAgKGhhcmQgdG8gZ2l2ZSBhIG5hbWUpDQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICBe
DQo+ID4+PiAgICAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4+PiBydHc4ODIxYXUgIC0tLS0t
PiAoYykgcnR3ODgyMWENCj4gPj4+DQo+ID4+PiBQdXQgYWxsIGNvbW1vbiBjb2RlIHRvIChiKS4g
SVFLIGNvZGUgaW4gKGEpIG9yIChjKS4NCj4gPj4+DQo+ID4+PiBJIGZlZWwgeW91IGhhdmUgdGhv
dWdodCBhYm92ZSBwaWN0dXJlIGFscmVhZHkuIFdoYXQgYXJlIHByb2JsZW1zIHdlIHdpbGwgZW5j
b3VudGVyPw0KPiA+Pj4gTWFueSBleHBvcnQgc3ltYm9scz8gSWYgc28sIGhvdyBhYm91dCBiZWxv
dz8NCj4gPj4+DQo+ID4+PiBydHc4ODEyYXUgIC0tLS0tPiAoMSkgcnR3ODgxMmENCj4gPj4+ICAg
ICArLS0tLS0tLS0tKw0KPiA+Pj4gICAgICAgICAgICAgICArLT4gKDIpIHJ0dzg4MjFhX2NvbW1v
biAgKGhhcmQgdG8gZ2l2ZSBhIG5hbWUpDQo+ID4+PiAgICAgKy0tLS0tLS0tLSsNCj4gPj4+IHJ0
dzg4MjFhdSAgLS0tLS0+ICgzKSBydHc4ODIxYQ0KPiA+Pj4NCj4gPj4+IFB1dCBydHc4ODEyYV9o
d19zcGVjIGFuZCBydHc4ODIxYV9od19zcGVjIGluICgyKS4gT25seSBJUUsgY29kZSBpbiAoMSkg
YW5kICgzKQ0KPiA+Pj4gcmVzcGVjdGl2ZWx5LCBhbmQgZXhwb3J0IElRSyBlbnRyeSBvbmx5LiBE
b2VzIGl0IHdvcms/DQo+ID4+Pg0KPiA+Pj4NCj4gPj4gRm9yIHRoZSBuYW1lIG9mIHRoZSBjb21t
b24gbW9kdWxlLCBJIHdhcyB0aGlua2luZyBydHc4OF84OHh4YS5rby4NCj4gPj4NCj4gPj4gSSB3
b25kZXIsIHdoYXQgaXMgdGhlIGdvYWw/IFRvIHB1dCB0aGUgY29kZSBpbiBzZXBhcmF0ZSBrZXJu
ZWwNCj4gPj4gbW9kdWxlcywgb3IganVzdCBzZXBhcmF0ZSBmaWxlcz8NCj4gPg0KPiA+IEkgd291
bGQgbGlrZSB0byByZWR1Y2UgcnVudGltZSBtZW1vcnkuIEFzIEkgYXNrZWQsIGhvdyBtYW55IElR
SyBjb2RlIGFyZSBkaWZmZXJlbnQNCj4gPiBmcm9tIHRoZW0/IElmIHlvdSBoYXZlIHNlcGFyYXRl
ZCBhbmQgY29tcGlsZWQgdGhlbSwgY2FuIHlvdSBzaGFyZSBzaXplIGJ5IHRoZQ0KPiA+IG91dHB1
dCBvZiAnc2l6ZScgY29tbWFuZD8NCj4gPg0KPiANCj4gSSBzZXBhcmF0ZWQgdGhlIElRSyBjb2Rl
IGludG8gdHdvIGZpbGVzIChzdGlsbCBqdXN0IG9uZSBtb2R1bGUpLg0KPiBzaXplIHNheXM6DQo+
IA0KPiAgICB0ZXh0ICAgIGRhdGEgICAgIGJzcyAgICAgZGVjICAgICBoZXggZmlsZW5hbWUNCj4g
ICAgNzE5MiAgICAgIDMyICAgICAgIDAgICAgNzIyNCAgICAxYzM4IHJ0dzg4MjFhLWlxay5vDQo+
ICAgMTIzMTkgICAgICA0MCAgICAgICAwICAgMTIzNTkgICAgMzA0NyBydHc4ODEyYS1pcWsubw0K
PiANCj4gVGhpcyBpcyB4ODZfNjQuDQo+IA0KPiA+Pg0KPiA+PiBJIHRoaW5rIHdlIGNhbiBoYXZl
IHJ0dzg4eHhhLmMgKGNvbW1vbiBjb2RlKSwgcnR3ODgyMWEuYyAoSVFLIGNvZGUsDQo+ID4+IHJ0
dzg4MjFhX2h3X3NwZWMsIGJsdWV0b290aCBzdHVmZiksIGFuZCBydHc4ODEyYS5jIChJUUsgY29k
ZSwNCj4gPj4gcnR3ODgxMmFfaHdfc3BlYywgc29tZSBlZnVzZSBzdHVmZiwgY2hhbm5lbCBzd2l0
Y2hpbmcpLi4uIGlmIHRoZXNlDQo+ID4+IHRocmVlIGZpbGVzIGNvbXBpbGUgaW50byBhIHNpbmds
ZSBtb2R1bGUsIHJ0dzg4Xzg4eHhhLmtvLg0KPiA+Pg0KPiA+PiBJZiBlYWNoIGZpbGUgY29tcGls
ZXMgaW50byBhIG1vZHVsZSBvZiBpdHMgb3duLCB3ZSBoYXZlIGNpcmN1bGFyDQo+ID4+IGRlcGVu
ZGVuY2llczogcnR3ODgyMWFfaHdfc3BlYyAtPiBjb21tb24gY29kZSAtPiBJUUsgY29kZS4NCj4g
Pj4gSWYgKl9od19zcGVjIGdvIGluIHRoZSBjb21tb24gbW9kdWxlLCBpdCBzdGlsbCBkZXBlbmRz
IG9uIGJvdGggb2YNCj4gPj4gdGhlIG90aGVyIHR3byBtb2R1bGVzLCBzbyB3aGF0IHVzZSBpcyBp
dD8NCj4gPg0KPiA+IElmIHdlIGhhdmUgZGVwZW5kZW5jeSBvZiBjb21tb24gY29kZSAtPiBJUUsg
Y29kZSwgd2UgY2FuJ3Qgc2F2ZSBydW50aW1lDQo+ID4gbWVtb3J5LCBiZWNhdXNlIGNvbW1vbiBj
b2RlIHJlZmVyZW5jZSB0byBib3RoIElRSyBjb2RlLiBTbyBJIGZlbHQNCj4gPiBkZXBlbmRlbmN5
IG9mIElRSyBjb2RlIHdvdWxkIGJlIHJ0dzg4MTJhdSAtLT4gSVFLIGNvZGUgYXMgYWJvdmUgc2Vj
b25kDQo+ID4gZGlhZ3JhbS4NCj4gPg0KPiA+IEJ1dCBpZiB0aGUgd29yayBpcyBjb21wbGljYXRl
ZCBhbmQgc2F2ZSBub3QgZmV3IHJ1bnRpbWUgbWVtb3J5LCB3ZSBjYW4NCj4gPiB1c2Ugc2ltcGxl
IGRlc2lnbiBhcyBjdXJyZW50IGRpZC4NCj4gPg0KPiA+DQo+IA0KPiBUaGUgSVFLIGNvZGUgY2Fu
IGJlIHNlcGFyYXRlZCBpbnRvIGRpZmZlcmVudCBtb2R1bGVzIGlmIEkgZHVwbGljYXRlDQo+IHJ0
dzg4MjFhX29wcyBhbmQgcnR3ODgyMWFfcHdyX3RyYWNrLCBhbmQgcnR3ODgyMWFfcGh5X3B3cnRy
YWNrIHRha2VzDQo+IGEgcG9pbnRlciB0byB0aGUgSVFLIGZ1bmN0aW9uLiBUaGVuIHlvdXIgZmly
c3QgZGlhZ3JhbSBhYm92ZSBjYW4gd29yay4NCg0KTm90IHN1cmUgdGhlICJkdXBsaWNhdGUiIHlv
dSBtZWFudC4gSWYgaXQgb25seSBhIHN0cnVjdCwgdGhhdCB3b3VsZCBiZSBmaW5lLg0KTm90IHBy
ZWZlciBkdXBsaWNhdGUgb2YgdGFibGVzLg0KDQo+IA0KPiBUaGUgdGFibGVzIGFsc28gdGFrZSB1
cCBhIGJpdCBvZiBzcGFjZToNCj4gDQo+ICAgdGV4dCAgICBkYXRhICAgICBic3MgICAgIGRlYyAg
ICAgaGV4IGZpbGVuYW1lDQo+ICAgMTY4MzIgICAgICAgMCAgICAgICAwICAgMTY4MzIgICAgNDFj
MCBydHc4ODIxYV90YWJsZS5vDQo+ICAgMjE1NTIgICAgICAgMCAgICAgICAwICAgMjE1NTIgICAg
NTQzMCBydHc4ODEyYV90YWJsZS5vDQoNCkdvb2QgcG9pbnQuIA0KDQo+IA0KPiBJIGRvbid0IGtu
b3cgaG93IG1hbnkga2lsb2J5dGVzIGlzIGVub3VnaCB0byBtYWtlIGl0IHdvcnRoDQo+IGNyZWF0
aW5nIHR3byBtb3JlIG1vZHVsZXMuDQoNCkkgdGhpbmsgd2UgY2FuIGxpc3QgYWxsICoubyByZWxh
dGVkIHRvIHJ0dzg4MjFhLzg4MTJhLCBhbmQgY2hlY2sgdGhlDQpwZXJjZW50YWdlIHRvIG1ha2Ug
ZGVjaXNpb25zLiBJIG1lYW4gaWYgaXQgb2NjdXBpZXMgNTAlLCBJIHdpbGwgcHJlZmVyDQp0byBo
YXZlIHNlcGFyYXRlZCBtb2R1bGUuIEJ1dCBJIGRvbid0IGhhdmUgYW4gZXhhY3QgbnVtYmVyIG5v
dy4gDQoNCg==

