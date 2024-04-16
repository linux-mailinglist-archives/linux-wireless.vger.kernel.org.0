Return-Path: <linux-wireless+bounces-6360-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B19AC8A61F0
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 06:01:28 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id E2D6F1C22541
	for <lists+linux-wireless@lfdr.de>; Tue, 16 Apr 2024 04:01:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 16C981BDD0;
	Tue, 16 Apr 2024 04:01:24 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53CF5D512
	for <linux-wireless@vger.kernel.org>; Tue, 16 Apr 2024 04:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713240084; cv=none; b=G2TqEFFVr9vHzusl3AFAYYTyk8mRWTwyvPZm2F6DfD9FuLUbZk9s6NphC4H5dE12mWY5Ir0hqOYYBwehK7ZAgFC+n/kevt3PPTZKsqSInjI21frd6fAkEoWIYcKdGYSGwqm20G0qcARr87AdAbzbC+beYqIj0SGBnS6kuPtnU2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713240084; c=relaxed/simple;
	bh=nuTRcFb9kGWlJy0k9jupVHSyXnbZbyS7nL1FTMKpO+A=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=owZsRHS5gMFtOqSQFz6fMb+vsM3L0EeLQ7b/CpIRT/HEI2mh9akpRQjV+NHIbxj4f1aRIR4yOSVlLQXmS4KYKwApT8/SLW8AY5ib3xhlP3kuAs3gBmnNwrU3rvDAvac5ZQ9MXrS1FZew4YxE3CWkzYO5COTScqz5/PBg8T+UPMg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43G41FvJ41807715, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43G41FvJ41807715
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 16 Apr 2024 12:01:15 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 12:01:16 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 16 Apr 2024 12:01:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 16 Apr 2024 12:01:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>
Subject: RE: [PATCH] wifi: rtl8xxxu: Fix gen1 rate mask command
Thread-Topic: [PATCH] wifi: rtl8xxxu: Fix gen1 rate mask command
Thread-Index: AQHaj3lQqSSsCbEgqUqV5MlvDObuZ7FqQsCQ
Date: Tue, 16 Apr 2024 04:01:15 +0000
Message-ID: <12bae50933084d9f8646a33daad036a7@realtek.com>
References: <3068a7f8-0178-4ea7-bd18-4e377db07e76@gmail.com>
In-Reply-To: <3068a7f8-0178-4ea7-bd18-4e377db07e76@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
VGhlIEgyQyAoaG9zdCB0byBjYXJkKSBjb21tYW5kIHdoaWNoIHRlbGxzIHRoZSBmaXJtd2FyZSB3
aGljaCBUWCByYXRlcw0KPiBpdCBjYW4gdXNlIGlzIHNsaWdodGx5IHdyb25nLiBGaXggdGhlIG9y
ZGVyIG9mIHRoZSBieXRlcy4NCj4gDQo+IEFsc28gcHV0IHRoZSBtYWNpZCBpbiB0aGUgY29tbWFu
ZCAocmVsZXZhbnQgZm9yIEFQIG1vZGUpLg0KPiANCj4gVGhpcyB3YXMgdGVzdGVkIHdpdGggUlRM
ODE5MkNVLiBJdCBhbHNvIGFmZmVjdHMgdGhlIFJUTDg3MjNBVS4NCg0KQ2FuIHlvdSBhZGQgdGVz
dCByZXN1bHRzIGJlZm9yZS9hZnRlciB0aGlzIHBhdGNoPw0KDQpJIHdvbmRlciBpZiBSVEw4MTky
Q1UgYW5kIFJUTDg3MjNBVSB1c2UgZGlmZmVyZW50IGNvbW1hbmQgZm9ybWF0LCBiZWNhdXNlDQp2
ZW5kb3IgZHJpdmVyIG9mIFJUTDgxOTJDVSBzZWVtcyB1c2UgZGlmZmVyZW50IGNvbW1hbmQgSUQg
KHcvbyBCSVQoNykpLCBzZWUgYmVsb3cuDQoNCj4gDQo+IENjOiBzdGFibGVAdmdlci5rZXJuZWwu
b3JnDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21h
aWwuY29tPg0KPiAtLS0NCj4gIC4uLi9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4
eHh4dS5oICAgfCAxMCArKysrKysrLS0tDQo+ICAuLi4vd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4
dS9ydGw4eHh4dV9jb3JlLmMgIHwgMTggKysrKysrKysrKystLS0tLS0tDQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDE4IGluc2VydGlvbnMoKyksIDEwIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdp
dCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHUuaA0KPiBi
L2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHUuaA0KPiBpbmRl
eCBmZDkyZDIzYzQzZDkuLmNhNDRkODJjYjVhYSAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4dS5oDQo+ICsrKyBiL2RyaXZlcnMvbmV0
L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRsOHh4eHUuaA0KPiBAQCAtMTQzMCwxMCArMTQz
MCwxNCBAQCBzdHJ1Y3QgaDJjX2NtZCB7DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHU4IGRh
dGE7DQo+ICAgICAgICAgICAgICAgICB9IF9fcGFja2VkIGpvaW5ic3M7DQo+ICAgICAgICAgICAg
ICAgICBzdHJ1Y3Qgew0KPiArI2RlZmluZSBSQUlEX01BU0sgICAgICAgICAgICAgIEdFTk1BU0so
MzEsIDI4KQ0KPiArI2RlZmluZSBSQVRFX01BU0tfTUFTSyAgICAgICAgIEdFTk1BU0soMjcsIDAp
DQo+ICsjZGVmaW5lIE1BQ0lEX01BU0sgICAgICAgICAgICAgR0VOTUFTSyg0LCAwKQ0KPiArI2Rl
ZmluZSBTSE9SVF9HSV9NQVNLICAgICAgICAgIEJJVCg1KQ0KPiArDQo+ICAgICAgICAgICAgICAg
ICAgICAgICAgIHU4IGNtZDsNCj4gLSAgICAgICAgICAgICAgICAgICAgICAgX19sZTE2IG1hc2tf
aGk7DQo+IC0gICAgICAgICAgICAgICAgICAgICAgIHU4IGFyZzsNCj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgX19sZTE2IG1hc2tfbG87DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIF9fbGUz
MiByYXRlX21hc2tfYW5kX3JhaWQ7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHU4IG1hY2lk
X2FuZF9zaG9ydF9naTsNCj4gICAgICAgICAgICAgICAgIH0gX19wYWNrZWQgcmFtYXNrOw0KPiAg
ICAgICAgICAgICAgICAgc3RydWN0IHsNCj4gICAgICAgICAgICAgICAgICAgICAgICAgdTggY21k
Ow0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9y
dGw4eHh4dV9jb3JlLmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bDh4eHh1
L3J0bDh4eHh1X2NvcmUuYw0KPiBpbmRleCBmYWM3ODI0YWU3MjcuLmFjYmFmYzI1YzZlMCAxMDA2
NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9ydGw4eHh4
dV9jb3JlLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGw4eHh4dS9y
dGw4eHh4dV9jb3JlLmMNCj4gQEAgLTQ2NDEsMTUgKzQ2NDEsMTkgQEAgdm9pZCBydGw4eHh4dV91
cGRhdGVfcmF0ZV9tYXNrKHN0cnVjdCBydGw4eHh4dV9wcml2ICpwcml2LA0KPiAgICAgICAgIG1l
bXNldCgmaDJjLCAwLCBzaXplb2Yoc3RydWN0IGgyY19jbWQpKTsNCj4gDQo+ICAgICAgICAgaDJj
LnJhbWFzay5jbWQgPSBIMkNfU0VUX1JBVEVfTUFTSzsNCg0KcnRsOHh4eHU6IEgyQ19TRVRfUkFU
RV9NQVNLID0gKDYgfCBIMkNfRVhUKQ0KdmVuZG9yIGRyaXZlciBvZiA4MTkyY3U6IE1BQ0lEX0NP
TkZJR19FSUQ9Ng0KDQpDYW4geW91IGNvbmZpcm0gaWYgY29tbWFuZCAiKDYgfCBCSVQoNykpIiB3
b3JrcyBvbiA4MTkyY3U/DQpNYXliZSwgaXQgb25seSB3b3JrcyBvbiA4NzIzYXU/ICh0aGlzIGNo
aXAgaXMgdG9vIG9sZCwgSSBkb24ndCBoYXZlIG1vcmUgaW5mbyBhYm91dCBpdCkNCg0KDQo+IC0g
ICAgICAgaDJjLnJhbWFzay5tYXNrX2xvID0gY3B1X3RvX2xlMTYocmFtYXNrICYgMHhmZmZmKTsN
Cj4gLSAgICAgICBoMmMucmFtYXNrLm1hc2tfaGkgPSBjcHVfdG9fbGUxNihyYW1hc2sgPj4gMTYp
Ow0KPiANCj4gLSAgICAgICBoMmMucmFtYXNrLmFyZyA9IDB4ODA7DQo+IC0gICAgICAgaWYgKHNn
aSkNCj4gLSAgICAgICAgICAgICAgIGgyYy5yYW1hc2suYXJnIHw9IDB4MjA7DQo+ICsgICAgICAg
bGUzMnBfcmVwbGFjZV9iaXRzKCZoMmMucmFtYXNrLnJhdGVfbWFza19hbmRfcmFpZCwgcmF0ZWlk
LCBSQUlEX01BU0spOw0KPiArICAgICAgIGxlMzJwX3JlcGxhY2VfYml0cygmaDJjLnJhbWFzay5y
YXRlX21hc2tfYW5kX3JhaWQsIHJhbWFzaywgUkFURV9NQVNLX01BU0spOw0KPiArDQo+ICsgICAg
ICAgdThwX3JlcGxhY2VfYml0cygmaDJjLnJhbWFzay5tYWNpZF9hbmRfc2hvcnRfZ2ksIG1hY2lk
LCBNQUNJRF9NQVNLKTsNCj4gKyAgICAgICB1OHBfcmVwbGFjZV9iaXRzKCZoMmMucmFtYXNrLm1h
Y2lkX2FuZF9zaG9ydF9naSwgc2dpLCBTSE9SVF9HSV9NQVNLKTsNCj4gKyAgICAgICB1OHBfcmVw
bGFjZV9iaXRzKCZoMmMucmFtYXNrLm1hY2lkX2FuZF9zaG9ydF9naSwgMSwgQklUKDcpKTsNCj4g
Kw0KPiArICAgICAgIGRldl9kYmcoJnByaXYtPnVkZXYtPmRldiwNCj4gKyAgICAgICAgICAgICAg
ICIlczogcmF0ZSBtYXNrICUwOHgsIHJhdGUgaWQgJTAyeCwgYXJnICUwMngsIHNpemUgJXppXG4i
LA0KPiArICAgICAgICAgICAgICAgX19mdW5jX18sIHJhbWFzaywgcmF0ZWlkLCBoMmMucmFtYXNr
Lm1hY2lkX2FuZF9zaG9ydF9naSwNCj4gKyAgICAgICAgICAgICAgIHNpemVvZihoMmMucmFtYXNr
KSk7DQo+IA0KPiAtICAgICAgIGRldl9kYmcoJnByaXYtPnVkZXYtPmRldiwgIiVzOiByYXRlIG1h
c2sgJTA4eCwgYXJnICUwMngsIHNpemUgJXppXG4iLA0KPiAtICAgICAgICAgICAgICAgX19mdW5j
X18sIHJhbWFzaywgaDJjLnJhbWFzay5hcmcsIHNpemVvZihoMmMucmFtYXNrKSk7DQo+ICAgICAg
ICAgcnRsOHh4eHVfZ2VuMV9oMmNfY21kKHByaXYsICZoMmMsIHNpemVvZihoMmMucmFtYXNrKSk7
DQo+ICB9DQo+IA0KPiAtLQ0KPiAyLjQ0LjANCg0K

