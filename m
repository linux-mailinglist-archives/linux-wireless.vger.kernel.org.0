Return-Path: <linux-wireless+bounces-9001-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id EBC5490855E
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 09:54:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 77CE3B21E9B
	for <lists+linux-wireless@lfdr.de>; Fri, 14 Jun 2024 07:54:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3685714C5AA;
	Fri, 14 Jun 2024 07:54:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A447A13B5B2
	for <linux-wireless@vger.kernel.org>; Fri, 14 Jun 2024 07:54:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718351651; cv=none; b=dCZm9sI3Z6hWWDvEzvX/n+Baokfsq8zcJ4hOnWKpG+nMnubjFI0uEbFpxmGRuGsBiYVlLOfBTMpRmKFUrueTvfEcpShhLzkEq2vNsEPW3I74NuHCl8XZDsWVw/JX3FbB10D3A4IkLgbn7PdvIyn8QYiHQya4uIRhuB1RtyUva40=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718351651; c=relaxed/simple;
	bh=YNpNlePu7ctpgS/YTvxbU0cr+O8WxVVY40Iyxtoyspk=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UEw0IZ+zMGSvuy30Oshdxf0X4T99fgm2eASX0aTNMuMsB6MUkmZlttznBj6db48EObYO3YcaxGeoOb7cwQkBLfiBcv4nbBlXGxz3liLrwOr+GbpNhfL3dKkctpWYna5AoQvAw8Gw5h7IvGXiPltZ1xItsHgppjkztxwPjyeYbZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 45E7rt1zB3500430, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 45E7rt1zB3500430
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 14 Jun 2024 15:53:55 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 14 Jun 2024 15:53:55 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 14 Jun 2024 15:53:54 +0800
Received: from RTEXMBS03.realtek.com.tw ([fe80::b9ff:7c04:a2d:c266]) by
 RTEXMBS03.realtek.com.tw ([fe80::b9ff:7c04:a2d:c266%2]) with mapi id
 15.01.2507.035; Fri, 14 Jun 2024 15:53:54 +0800
From: Zong-Zhe Yang <kevin_yang@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH] wifi: mac80211: fix NULL dereference at band check in starting tx ba session
Thread-Topic: [PATCH] wifi: mac80211: fix NULL dereference at band check in
 starting tx ba session
Thread-Index: AQHarOpgkYVLW/TkN0STRQVqWrvRWLGttqwAgAIG0bCADGJAgIAK0wNg
Date: Fri, 14 Jun 2024 07:53:54 +0000
Message-ID: <2f22d58d3f7b4da9a7887fc0bfa3d264@realtek.com>
References: <20240523082200.15544-1-kevin_yang@realtek.com>
	 <173a8af7e9b544c496f2aee2bb47fca99279873c.camel@sipsolutions.net>
	 <639f8c2b59eb42beb56b28e53307886a@realtek.com>
 <c3ce5ca1cb434c2ff4b9ee3a1be9d81bf5ae01b2.camel@sipsolutions.net>
In-Reply-To: <c3ce5ca1cb434c2ff4b9ee3a1be9d81bf5ae01b2.camel@sipsolutions.net>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

Sm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4gd3JvdGU6DQoNCj4gT24g
VGh1LCAyMDI0LTA1LTMwIGF0IDEzOjQ5ICswMDAwLCBab25nLVpoZSBZYW5nIHdyb3RlOg0KPiA+
DQo+ID4gSSB0aGluayB0aGVyZSBhcmUgdHdvIHBvaW50cyBoZXJlLg0KPiA+DQo+ID4gMS4gdGhl
IHdheSB0byBhdm9pZCB0aGlzIE5VTEwgZGVyZWZlcmVuY2UgKEN1cnJlbnQgcGF0Y2gganVzdCBm
b2xsb3dlZA0KPiA+IG9yaWdpbmFsIGxvZ2ljIGFuZCBtYWRlIGl0IHJ1bm5hYmxlIG9uIGJvdGgg
TUxEIGFuZCBub24tTUxELikNCj4gPg0KPiA+IEFjY29yZGluZyB0byBjb21tZW50cywgSSB3aWxs
IGNoYW5nZSB0byBjaGVjaw0KPiBodF9zdXBwb3J0ZWQvdmh0X3N1cHBvcnRlZC9oYXNfaGUvaGFz
X2VodC4NCj4gPiBUaGVuLCBpdCBkb2Vzbid0IG5lZWQgdG8gcmVmZXJlbmNlIGNoYW5yZXEub3Bl
ci5jaGFuIGhlcmUuIFNvLCB0aGVyZSB3b24ndCBiZSBOVUxMDQo+IGRlcmVmZXJlbmNlLg0KPiA+
DQo+ID4gMi4gdGhlIGNoZWNrIGxvZ2ljIHdoZW4gTUxEDQo+ID4gKEN1cnJlbnQgcGF0Y2ggZGlk
bid0IGNvbnNpZGVyIHRoaXMgcHJvcGVybHkuKQ0KPiA+DQo+ID4gQWNjb3JkaW5nIHRvIHNwZWMu
LCBCQSBhZ3JlZW1lbnQgZG9lcyBvbmNlIHBlciBUSUQgYW5kIGFwcGx5IHRvIGFsbCBjb3JyZXNw
b25kaW5nIGxpbmtzLg0KPiA+IFNvLCBJIGFtIHRoaW5raW5nIG1heWJlIEkgY2hlY2sgdGhlIGNv
bmRpdGlvbnMgb24gYWxsIHZhbGlkX2xpbmtzIHdoZW4gTUxELg0KPiA+IEFuZCwgb25seSBjaGVj
ayBkZWZsaW5rIHdoZW4gbm9uLU1MRC4NCj4gDQo+IFdlbGwsIHNwZWMgYWxzbyByZXF1aXJlcyB0
aGF0IHlvdSBoYXZlIEVIVCAob24gYWxsIGxpbmtzKSB0byBiZSBhYmxlIHRvIGRvIE1MTyBpbiB0
aGUgZmlyc3QgcGxhY2UsDQo+IHNvIHlvdSBzaG91bGRuJ3QgYmUgY29ubmVjdGVkLiBJT1csIGNo
ZWNraW5nIG9uZSBsaW5rIHNob3VsZCBiZSBzdWZmaWNpZW50PyBBbmQgdGhhdCBjYW4gZXZlbg0K
PiBiZSBkZWZsaW5rLCBiZWNhdXNlIGZvciBhIFNUQSB0aGF0J3MgYWx3YXlzIHVzZWQgYXMgdGhl
IGFzc29jIGxpbmsgKHVubGlrZSBmb3IgdmlmKQ0KPiANCg0KVGhlbiBJIGFtIHRoaW5raW5nIHRv
IGp1c3QgY2hlY2sgaHRfc3VwcG9ydGVkL3ZodF9zdXBwb3J0ZWQvaGFzX2hlL2hhc19laHQgb24g
c3RhIGRlZmxpbmssDQp3aGV0aGVyIG5vbi1NTEQgY29ubmVjdGlvbiBvciBNTEQgY29ubmVjdGlv
bi4NCkFueSBmdXJ0aGVyIHN1Z2dlc3Rpb25zPw0KDQo=

