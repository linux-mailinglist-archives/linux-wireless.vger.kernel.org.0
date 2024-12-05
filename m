Return-Path: <linux-wireless+bounces-15919-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C1099E4FE8
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 09:39:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12CF3285090
	for <lists+linux-wireless@lfdr.de>; Thu,  5 Dec 2024 08:38:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 569F61D433C;
	Thu,  5 Dec 2024 08:38:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="VlJoL1q8"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 238F21D4339;
	Thu,  5 Dec 2024 08:38:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733387934; cv=none; b=OZxz8N1EPWj/tIofsnZN8RQ06DhcuQYbvr+/sZNJXk9FIYHMBhcI55FRD0+WzcTBdqH4H/WyFaMW/ctbf3TulJYjxvhOAngkav3jIVtKjtidJfKsyFK8wXWiscQZPEmMOso7zvm0zgrxNPAZeWAUGvRqcU3U007idIXvtFclH0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733387934; c=relaxed/simple;
	bh=PAObXDiXmDWj70ESEgFGl1tLxCTLl4RM/SgAzyfuJbE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=cA7aO0Pd+2AZkQXJBTFc8BiXxjL2eVig4+1rPFaB+wJLpdKtZLbage9TdsBODs3Z13C3BohlY5WPxKMTyR2v3psfI2OHrydC9a0Cw+oi0eEItaCV9iDMLxZcRmzp2ikgN9VMuIRdDWXLu9eLbLl4OZIYZjnmGpI1pnOmOzkYj8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=VlJoL1q8; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4B58cbNxB2684906, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1733387917; bh=PAObXDiXmDWj70ESEgFGl1tLxCTLl4RM/SgAzyfuJbE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=VlJoL1q8ZTk6O9d5R6UjmtoV+NB/XXTiRt+mT3xvPjfoKDyuZkGIYMirOtqKI6Jnp
	 GIM1CZtJs/izmbEV4t5YdCS6JFTiB0ZbnY4KpbWf1NAbLn7EMPba3n6/PWocEzjgnh
	 C9wG3H4RzeaK4MU3KrHh3vn+fhFbxAsJNv1FlmjIQ69kkJQPsd0/rvf8bt+JrCH3pq
	 EvTCWRSII6Qvw6CV/hPQ1LuAbR2Kau8l+r2yYw5HVrYf5VkwMtWcI3sxd2v4+6nSAt
	 fUVicuWYI0rXKE8Cb9zt3P739cFgMWBTSDO15dhdgK47ew6yOyaVgNj/QJlQGhbgLe
	 OjZTMHhI4fVCA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4B58cbNxB2684906
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 5 Dec 2024 16:38:37 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 5 Dec 2024 16:38:37 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 5 Dec 2024 16:38:37 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::80c2:f580:de40:3a4f]) by
 RTEXMBS03.realtek.com.tw ([fe80::80c2:f580:de40:3a4f%2]) with mapi id
 15.01.2507.035; Thu, 5 Dec 2024 16:38:37 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Aditya Kumar Singh <quic_adisi@quicinc.com>,
        Johannes Berg
	<johannes@sipsolutions.net>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: mac80211: re-order unassigning channel in activate links
Thread-Topic: [PATCH] wifi: mac80211: re-order unassigning channel in activate
 links
Thread-Index: AQHbRuNSBxvPvyW8HE26pTx5nrDmYLLXTWQA
Date: Thu, 5 Dec 2024 08:38:37 +0000
Message-ID: <65d22960ca6e47e19cf7c1c6a60dd72a@realtek.com>
References: <20241205-unassign_activate_links-v1-1-84097a1abdeb@quicinc.com>
In-Reply-To: <20241205-unassign_activate_links-v1-1-84097a1abdeb@quicinc.com>
Accept-Language: zh-TW, en-US
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

QWRpdHlhIEt1bWFyIFNpbmdoIDxxdWljX2FkaXNpQHF1aWNpbmMuY29tPiB3cm90ZToNCj4gDQo+
IFsuLi5dDQo+IA0KPiAgbmV0L21hYzgwMjExL2xpbmsuYyB8IDQ0ICsrKysrKysrKysrKysrKysr
KysrKystLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ICAxIGZpbGUgY2hhbmdlZCwgMjIgaW5zZXJ0
aW9ucygrKSwgMjIgZGVsZXRpb25zKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvbmV0L21hYzgwMjEx
L2xpbmsuYyBiL25ldC9tYWM4MDIxMS9saW5rLmMgaW5kZXgNCj4gNThhNzZiY2Q2YWU2ODY3MGZi
YmU3ZmE3ZDA3NTQwYzA0ZmY5OTZmOC4uM2M0NmQyYjJlZTI1NGZhYjMyNGQ1N2Y0ZDBmYmU5NGFj
ZTc2ZDgNCj4gOWQgMTAwNjQ0DQo+IC0tLSBhL25ldC9tYWM4MDIxMS9saW5rLmMNCj4gKysrIGIv
bmV0L21hYzgwMjExL2xpbmsuYw0KPiBAQCAtMzY3LDI4ICszNjcsNiBAQCBzdGF0aWMgaW50IF9p
ZWVlODAyMTFfc2V0X2FjdGl2ZV9saW5rcyhzdHJ1Y3QgaWVlZTgwMjExX3N1Yl9pZl9kYXRhDQo+
ICpzZGF0YSwNCj4gICAgICAgICAgICAgICAgIH0NCj4gICAgICAgICB9DQo+IA0KPiAtICAgICAg
IGZvcl9lYWNoX3NldF9iaXQobGlua19pZCwgJnJlbSwgSUVFRTgwMjExX01MRF9NQVhfTlVNX0xJ
TktTKSB7DQo+IC0gICAgICAgICAgICAgICBzdHJ1Y3QgaWVlZTgwMjExX2xpbmtfZGF0YSAqbGlu
azsNCj4gLQ0KPiAtICAgICAgICAgICAgICAgbGluayA9IHNkYXRhX2RlcmVmZXJlbmNlKHNkYXRh
LT5saW5rW2xpbmtfaWRdLCBzZGF0YSk7DQo+IC0NCj4gLSAgICAgICAgICAgICAgIGllZWU4MDIx
MV90ZWFyZG93bl90ZGxzX3BlZXJzKGxpbmspOw0KPiAtDQo+IC0gICAgICAgICAgICAgICBfX2ll
ZWU4MDIxMV9saW5rX3JlbGVhc2VfY2hhbm5lbChsaW5rLCB0cnVlKTsNCj4gLQ0KPiAtICAgICAg
ICAgICAgICAgLyoNCj4gLSAgICAgICAgICAgICAgICAqIElmIENTQSBpcyAoc3RpbGwpIGFjdGl2
ZSB3aGlsZSB0aGUgbGluayBpcyBkZWFjdGl2YXRlZCwNCj4gLSAgICAgICAgICAgICAgICAqIGp1
c3Qgc2NoZWR1bGUgdGhlIGNoYW5uZWwgc3dpdGNoIHdvcmsgZm9yIHRoZSB0aW1lIHdlDQo+IC0g
ICAgICAgICAgICAgICAgKiBoYWQgcHJldmlvdXNseSBjYWxjdWxhdGVkLCBhbmQgd2UnbGwgdGFr
ZSB0aGUgcHJvY2Vzcw0KPiAtICAgICAgICAgICAgICAgICogZnJvbSB0aGVyZS4NCj4gLSAgICAg
ICAgICAgICAgICAqLw0KPiAtICAgICAgICAgICAgICAgaWYgKGxpbmstPmNvbmYtPmNzYV9hY3Rp
dmUpDQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHdpcGh5X2RlbGF5ZWRfd29ya19xdWV1ZShs
b2NhbC0+aHcud2lwaHksDQo+IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAmbGluay0+dS5tZ2QuY3NhLnN3aXRjaF93b3JrLA0KPiAtICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbGluay0+dS5tZ2QuY3NhLnRpbWUg
LQ0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgamlm
Zmllcyk7DQo+IC0gICAgICAgfQ0KPiAtDQo+ICAgICAgICAgZm9yX2VhY2hfc2V0X2JpdChsaW5r
X2lkLCAmYWRkLCBJRUVFODAyMTFfTUxEX01BWF9OVU1fTElOS1MpIHsNCj4gICAgICAgICAgICAg
ICAgIHN0cnVjdCBpZWVlODAyMTFfbGlua19kYXRhICpsaW5rOw0KPiANCj4gQEAgLTQ1OCw2ICs0
MzYsMjggQEAgc3RhdGljIGludCBfaWVlZTgwMjExX3NldF9hY3RpdmVfbGlua3Moc3RydWN0IGll
ZWU4MDIxMV9zdWJfaWZfZGF0YQ0KPiAqc2RhdGEsDQo+ICAgICAgICAgICAgICAgICBfX2llZWU4
MDIxMV9zdGFfcmVjYWxjX2FnZ3JlZ2F0ZXMoc3RhLCBhY3RpdmVfbGlua3MpOw0KPiAgICAgICAg
IH0NCj4gDQo+ICsgICAgICAgZm9yX2VhY2hfc2V0X2JpdChsaW5rX2lkLCAmcmVtLCBJRUVFODAy
MTFfTUxEX01BWF9OVU1fTElOS1MpIHsNCj4gKyAgICAgICAgICAgICAgIHN0cnVjdCBpZWVlODAy
MTFfbGlua19kYXRhICpsaW5rOw0KPiArDQo+ICsgICAgICAgICAgICAgICBsaW5rID0gc2RhdGFf
ZGVyZWZlcmVuY2Uoc2RhdGEtPmxpbmtbbGlua19pZF0sIHNkYXRhKTsNCj4gKw0KPiArICAgICAg
ICAgICAgICAgaWVlZTgwMjExX3RlYXJkb3duX3RkbHNfcGVlcnMobGluayk7DQo+ICsNCj4gKyAg
ICAgICAgICAgICAgIF9faWVlZTgwMjExX2xpbmtfcmVsZWFzZV9jaGFubmVsKGxpbmssIHRydWUp
Ow0KPiArDQo+ICsgICAgICAgICAgICAgICAvKg0KPiArICAgICAgICAgICAgICAgICogSWYgQ1NB
IGlzIChzdGlsbCkgYWN0aXZlIHdoaWxlIHRoZSBsaW5rIGlzIGRlYWN0aXZhdGVkLA0KPiArICAg
ICAgICAgICAgICAgICoganVzdCBzY2hlZHVsZSB0aGUgY2hhbm5lbCBzd2l0Y2ggd29yayBmb3Ig
dGhlIHRpbWUgd2UNCj4gKyAgICAgICAgICAgICAgICAqIGhhZCBwcmV2aW91c2x5IGNhbGN1bGF0
ZWQsIGFuZCB3ZSdsbCB0YWtlIHRoZSBwcm9jZXNzDQo+ICsgICAgICAgICAgICAgICAgKiBmcm9t
IHRoZXJlLg0KPiArICAgICAgICAgICAgICAgICovDQo+ICsgICAgICAgICAgICAgICBpZiAobGlu
ay0+Y29uZi0+Y3NhX2FjdGl2ZSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgd2lwaHlfZGVs
YXllZF93b3JrX3F1ZXVlKGxvY2FsLT5ody53aXBoeSwNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICZsaW5rLT51Lm1nZC5jc2Euc3dpdGNoX3dvcmss
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBsaW5r
LT51Lm1nZC5jc2EudGltZSAtDQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICBqaWZmaWVzKTsNCj4gKyAgICAgICB9DQo+ICsNCj4gICAgICAgICBmb3Jf
ZWFjaF9zZXRfYml0KGxpbmtfaWQsICZhZGQsIElFRUU4MDIxMV9NTERfTUFYX05VTV9MSU5LUykg
ew0KPiAgICAgICAgICAgICAgICAgc3RydWN0IGllZWU4MDIxMV9saW5rX2RhdGEgKmxpbms7DQo+
IA0KDQpDb3VsZCB5b3UgYWxzbyB1cGRhdGUgdGhlIGRlc2NyaXB0aW9uIG9mIGllZWU4MDIxMV9z
ZXRfYWN0aXZlX2xpbmtzKCkgKGluY2x1ZGUvbmV0L21hYzgwMjExLmgpIHRvIGFsaWduIHRoZSBj
aGFuZ2VzPw0KSSB0aGluayBpdCB3b3VsZCBiZSBsaWtlOg0KDQogIGNoYW5nZV92aWZfbGlua3Mo
MHgxMSkNCiAgYXNzaWduX3ZpZl9jaGFuY3R4KGxpbmtfaWQ9NCkNCiAgY2hhbmdlX3N0YV9saW5r
cygweDExKSBmb3IgZWFjaCBhZmZlY3RlZCBTVEEgKHRoZSBBUCkNCiAgWy4uLl0NCiAgY2hhbmdl
X3N0YV9saW5rcygweDEwKSBmb3IgZWFjaCBhZmZlY3RlZCBTVEEgKHRoZSBBUCkNCiAgdW5hc3Np
Z25fdmlmX2NoYW5jdHgobGlua19pZD0wKQ0KICBjaGFuZ2VfdmlmX2xpbmtzKDB4MTApDQoNCg==

