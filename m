Return-Path: <linux-wireless+bounces-8842-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A19C6904E58
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 10:43:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1BBF9281EF2
	for <lists+linux-wireless@lfdr.de>; Wed, 12 Jun 2024 08:43:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 48D8216D33A;
	Wed, 12 Jun 2024 08:43:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E603216D322;
	Wed, 12 Jun 2024 08:43:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718181822; cv=none; b=CVChq6y98OknmSH4yr2nP/UGfmYoloi6VCtdUlpYiSGtfHWVigjDDhFc7SJ5i/2abyLX2nLfId5BvrSrIUerpkdUv+BpK/Z1XMiJSmjNIAlV3qDd2rTytwCGcYoFcWeJ08lfFhpxA1wU8WLMA+ThD5Nh31M4aHxSRQ05BIdefGk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718181822; c=relaxed/simple;
	bh=51hF7gqnM1Vv4XosBmqukncv+n34sJQIiomN4CWm7Kk=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=JWTWMIHadUHI2icfqQgJD/GoPghSJxKxDFSo29TMkA8Y2YXopDOIWN9GqJD7/cWUzmJXuFZEgvBnHHV/9gLJmqvqKulg/ZlW/zFIma9IXfssZYMh4oxGkkG1zRic27joUm8M0OEccZzh+Mox+w6l0KMe6K34R+aL/AjyVcNgbPQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45C8h9WM11116969, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45C8h9WM11116969
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 12 Jun 2024 16:43:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 12 Jun 2024 16:43:09 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 12 Jun 2024 16:43:09 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 12 Jun 2024 16:43:09 +0800
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
Thread-Index: AQHasIGBiI2kIPT9xk+a42EavL0uE7GryNkAgASPDICABOUZsIANAvMAgAEhOED//+X0AIAADk4AgACRnyA=
Date: Wed, 12 Jun 2024 08:43:09 +0000
Message-ID: <3dd46abad6f8485fa74d36278dda46ac@realtek.com>
References: <chwoymvpzwtbmzryrlitpwmta5j6mtndocxsyqvdyikqu63lon@gfds653hkknl>
	 <a51f223f-18ac-4d67-9120-8da1c169b7eb@leemhuis.info>
	 <809d2332-625e-4a46-a77e-ca2e49b0d651@leemhuis.info>
	 <0e65ca6b471b4186a370b9a57de11abe@realtek.com>
	 <36c1f49acfcc2cc16c7e54ffeb76f1e93cb96e91.camel@sipsolutions.net>
	 <5318640d6eb74301b1fbf6d9385ba69e@realtek.com>
	 <6a88e0d3e47ebbd1f0f383094e4804a627c41870.camel@sipsolutions.net>
 <7869b9b29b6796c95fd5af649e4bd6696e56dcaf.camel@sipsolutions.net>
In-Reply-To: <7869b9b29b6796c95fd5af649e4bd6696e56dcaf.camel@sipsolutions.net>
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

Sm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4NCj4gT24gV2VkLCAyMDI0
LTA2LTEyIGF0IDA5OjA3ICswMjAwLCBKb2hhbm5lcyBCZXJnIHdyb3RlOg0KPiA+IE9uIFdlZCwg
MjAyNC0wNi0xMiBhdCAwMDo1NiArMDAwMCwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+DQo+ID4N
Cj4gPiA+ID4gSnVzdCBnb3QgcGluZ2VkIChzcD8pIGFib3V0IHRoaXMsIGNhbiB5b3Ugc2hhcmUg
dGhlIGRyaXZlciBmaXggc28gSSBjYW4NCj4gPiA+ID4gdGFrZSBhIGxvb2sgd2hhdCB0aGUgaXNz
dWUgaXMgYWJvdXQ/DQo+ID4gPiA+DQo+ID4gPg0KPiA+ID4gUGxlYXNlIHJlZmVyZW5jZSBwYXRj
aCBiZWxvdy4gSSBjb3B5IHRoaXMgaWRlYSBmcm9tIHJ0dzg5IFsxXSwgd2hpY2ggdGhlIG1haW4N
Cj4gPiA+IHN0dWZmIGlzIHRvIGFkZCBXQU5UX01PTklUT1JfVklGIGFuZCBjYXNlIE5MODAyMTFf
SUZUWVBFX01PTklUT1IgaW4gYWRkX2ludGVyZmFjZSgpLg0KPiA+DQo+ID4gQWgsIE9LLCBidXQg
dGhhdCBnaXZlcyBtZSBhIGhpbnQuIFllcywgSSBzZWUgdGhlIGlzc3VlIG5vdy4NCj4gPg0KPiA+
IE9LIGl0J3Mgbm90IHRyaXZpYWwgYW5kIGl0IG1pZ2h0IGxlYXZlIGF0aDEyayBzdGlsbCBub3Qg
d29ya2luZyAodGhvdWdoDQo+ID4gbm90IHN1cmUgaXQgZXZlciBkaWQgYmVmb3JlPyBvciBtYXli
ZSBJJ20gbWlzc2luZyBzb21ldGhpbmcuLi4pLCBidXQgSQ0KPiA+IHRoaW5rIEkgY2FuIGZpeCB0
aGlzLiBMZXQncyBzZWUuDQo+ID4NCj4gDQo+IEkgZG9uJ3QgaGF2ZSBhbnkgb2YgdGhlIGFmZmVj
dGVkIGhhcmR3YXJlLCBjb3VsZCBzb21lb25lIHRlc3QgdGhpcz8NCj4gDQo+IGh0dHBzOi8vcC5z
aXBzb2x1dGlvbnMubmV0LzYxOWE0Y2U0YTE5N2IyYjQudHh0DQo+IA0KDQpUZXN0ZWQgb24gNi45
LjIgd2l0aCBSVEw4ODIyQ0UuDQoNCkJlZm9yZSB0aGlzIHBhdGNoLCBpdCBjYW4gY2FwdHVyZSBw
YWNrZXRzIGJ1dCBhbHdheXMgc3RheXMgb24gY2hhbm5lbCAxLg0KV2l0aCB0aGlzIHBhdGNoLCBJ
IHN3aXRjaCBjaGFubmVsIDEgLS0+IDM2IC0tPiAxNDkgLS0+IDExLg0KQWxsIGFyZSBleHBlY3Rl
ZC4gDQoNClRoYW5rcyBmb3IgdGhlIHF1aWNrIGZpeCENClBpbmctS2UgDQoNCg==

