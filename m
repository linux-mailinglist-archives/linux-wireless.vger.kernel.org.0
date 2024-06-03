Return-Path: <linux-wireless+bounces-8384-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C29628D796C
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 02:48:09 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 4159AB2111D
	for <lists+linux-wireless@lfdr.de>; Mon,  3 Jun 2024 00:48:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 899AC1C14;
	Mon,  3 Jun 2024 00:48:03 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A33341862;
	Mon,  3 Jun 2024 00:48:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717375683; cv=none; b=HyyuOMRhHefmMxhjCb7wQ9HR6nyqhyw94S2h1gsMH0md38+sH/u+OiHjCkPZStqNGcIEOGZ9JwzC2smMCr61nfgDJT43PVqSOYQ0MyNXudwUS2sb2Q2eSJuvtOTdugPTHjQ7pAhp75qWsKRttod9SVHh1OmcKe8d89AN1s2x16Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717375683; c=relaxed/simple;
	bh=ANlTvKxcpkB49JzL7646oyH+BkASTf5JJKiHfxgEp4s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TSZ1I322yA5pdEubOm0A9ULTog0ZsKWv3iI0411DcViNrTjvGshT73W8iGBebi7cpILm5Dl3Bgb4hkA96D5+NOV2DhJ05NgauYA3LiR45IQWzh2+0Mx9wNs7GEzVY4WC9HufV6Ji3g3KVPpSwz2NXJrgzBlK8R/PsKW2Fd+WHTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4530lJjnD2054204, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4530lJjnD2054204
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 3 Jun 2024 08:47:19 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 3 Jun 2024 08:47:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 3 Jun 2024 08:47:19 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 3 Jun 2024 08:47:19 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Thorsten Leemhuis <regressions@leemhuis.info>,
        Savyasaachi Vanga
	<savyasaachiv@gmail.com>,
        Christian Heusel <christian@heusel.eu>
CC: Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>,
        Johannes Berg <johannes.berg@intel.com>,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
Subject: RE: [REGRESSION][BISECTED] wifi: RTL8821CE does not work in monitor mode
Thread-Topic: [REGRESSION][BISECTED] wifi: RTL8821CE does not work in monitor
 mode
Thread-Index: AQHasIGBiI2kIPT9xk+a42EavL0uE7GryNkAgASPDICABOUZsA==
Date: Mon, 3 Jun 2024 00:47:19 +0000
Message-ID: <0e65ca6b471b4186a370b9a57de11abe@realtek.com>
References: <chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl>
 <a51f223f-18ac-4d67-9120-8da1c169b7eb@leemhuis.info>
 <809d2332-625e-4a46-a77e-ca2e49b0d651@leemhuis.info>
In-Reply-To: <809d2332-625e-4a46-a77e-ca2e49b0d651@leemhuis.info>
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

VGhvcnN0ZW4gTGVlbWh1aXMgPHJlZ3Jlc3Npb25zQGxlZW1odWlzLmluZm8+IHdyb3RlOg0KPiBP
biAyOC4wNS4yNCAxMDoyMSwgTGludXggcmVncmVzc2lvbiB0cmFja2luZyAoVGhvcnN0ZW4gTGVl
bWh1aXMpIHdyb3RlOg0KPiA+IE9uIDI4LjA1LjI0IDAwOjAxLCBDaHJpc3RpYW4gSGV1c2VsIHdy
b3RlOg0KPiA+Pg0KPiA+PiBTYXZ5YXNhYWNoaSByZXBvcnRzIHRoYXQgc2Nhbm5pbmcgZm9yIG90
aGVyIHN0YXRpb25zIGluIG1vbml0b3IgbW9kZQ0KPiA+PiBkb2VzIG5vdCB3b3JrIGFueW1vcmUg
d2l0aCBoaXMgUlRMODgyMUNFIHdpcmVsZXNzIG5ldHdvcmsgY2FyZCBmb3IgbGludXgNCj4gPj4g
a2VybmVscyBhZnRlciA2LjguOS4NCj4gPj4gWy4uLl0NCj4gDQo+IEhtbSwgdGhlIHdpZmkgZGV2
ZWxvcGVycyBkaWQgbm90IHJlcGx5IHRvIHRoZSBpbnF1aXJ5IHF1b3RlZCBiZWxvdy4gOi0vDQo+
IEd1ZXNzIEknbGwgaGF2ZSB0byB0YWtlIGEgY2xvc2VyIGxvb2sgYSB0aGUgbGlua2VkIGJ1Z3pp
bGxhIHJlcG9ydCB0aGVuLg0KPiANCj4gQW55d2F5OiBDaHJpc3RpYW4sIFNhdnlhc2FhY2hpLCBJ
IG5vdGljZWQgYSBzdWJtaXNzaW9uIG9mIGEgcGF0Y2gNCj4gcmVmZXJlbmNpbmcgdGhlIGN1bHBy
aXQgd2l0aCBhIEZpeGVzOiB0YWc7IGl0IHRhbGtzIGFib3V0IHBhY2thZ2UgbG9zcywNCj4gYnV0
IGl0IHN0aWxsIG1hZGUgbWUgd29uZGVyIGlmIHRoYXQgbWlnaHQgYmUgcmVsYXRlZCBzb21laG93
Og0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9hbGwvMWZhYmI4ZTQtYWRmMy00N2FlLTg0NjIt
OGFlYTk2M2JjMmE1QGdtYWlsLmNvbS8NCj4gDQo+IENpYW8sIFRob3JzdGVuDQo+IA0KPiA+IFNv
IGJhY2sgdG8gdGhlIHJlYWwgcHJvYmxlbToNCj4gPg0KPiA+IEB3aWZpIGRldmVsb3BlcnM6IElz
IHRoZXJlIHNvbWUgYmlnZ2VyIHByb2JsZW0gaW4gNi45LnkgcmVsYXRlZCB0bw0KPiA+IG1vbml0
b3JpbmcgbW9kZSB0aGF0IGlzIGFmZmVjdGluZyBhIGxvdCBvZiBkcml2ZXJzL3VzZXJzPw0KPiA+
DQo+ID4gSSdtIGFza2luZyBiZWNhdXNlIEkgbm90aWNlZCBhbm90aGVyIHJlcG9ydCB0aGF0IHNv
dW5kZWQgcmVsYXRlZC4gVG8NCj4gPiBxdW90ZTogaHR0cHM6Ly9idWd6aWxsYS5rZXJuZWwub3Jn
L3Nob3dfYnVnLmNnaT9pZD0yMTg4ODQNCj4gPg0KPiA+ICIiIg0KPiA+PiAgTWljaGFlbCAyMDI0
LTA1LTI0IDE3OjA0OjUxIFVUQw0KPiA+Pg0KPiA+PiBTb21lIGZlYXR1cmVzIGFyZSBicm9rZW4g
c2luY2Uga2VybmVsIDYuOS4xIHdoZW4gcnVubmluZyBtb25pdG9yIG1vZGUuDQo+ID4+DQo+ID4+
IEZpcnN0IGJ1ZzoNCj4gPj4gU3dpdGNoaW5nIGEgY2hhbm5lbCB2aWEgIk5MODAyMTFfQVRUUl9X
SVBIWV9GUkVRIiBkb2VzIG5vdCBzd2l0Y2ggdGhlIGNoYW5uZWwvZnJlcXVlbmN5Lg0KPiA+Pg0K
PiA+PiBUaGF0IGlzIG5vdCBhIGRldmljZSBkcml2ZXIgcHJvYmxlbSwgYmVjYXVzZSBhbGwgZGV2
aWNlIGRyaXZlcnMgKE1lZGlhdGVrLCBSYWxpbmssIFJlYWx0ZWssIC4uLikgYXJlDQo+IGFmZmVj
dGVkLg0KDQpXZSBoYXZlIGEgZHJhZnQgZml4IG9mIHJ0dzg4IGRyaXZlciBmb3IgUlRMODgyMUNF
LCBidXQgYXMgbWVudGlvbmVkIHNvbWUgZHJpdmVycw0KYXJlIGFmZmVjdGVkLCBzbyBJIGRvbid0
IHBsYW4gdG8gc2VuZCBvdXQgdGhlIHBhdGNoLiBJbnN0ZWFkIHdlIGFyZSBsb29raW5nIGZvcg0K
dGhlIGZpeCBvZiBjZmc4MDIxMS9tYWM4MDIxMS4gDQoNClBpbmctS2UNCg0K

