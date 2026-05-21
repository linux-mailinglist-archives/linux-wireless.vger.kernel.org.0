Return-Path: <linux-wireless+bounces-36748-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id +JYbN0q7DmrBBgYAu9opvQ
	(envelope-from <linux-wireless+bounces-36748-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 09:59:06 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [172.105.105.114])
	by mail.lfdr.de (Postfix) with ESMTPS id 572B45A0889
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 09:59:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id CF13A30F41AF
	for <lists+linux-wireless@lfdr.de>; Thu, 21 May 2026 07:53:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5D50E345CA1;
	Thu, 21 May 2026 07:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="szw6ceQy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 615AD36F8F3
	for <linux-wireless@vger.kernel.org>; Thu, 21 May 2026 07:53:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779350013; cv=none; b=WXNS3MDrCWkI2e7erV4JEgyq5SZj1Mk+f5r/NEyTKazPz7lUohnY1B9UrOlJyoOSoFlAcaXoL37s8ySA1N+4bEnh3rE/oOPY9cv8dJuyxx4QwZib/a2l9Z+xIb1CLJ51shbMYonvIokB60LJ20ztF8iNV7psBrSohZYw1M7XLKs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779350013; c=relaxed/simple;
	bh=a3lI1uBhY+65s4W+EKo7UFoC+eRLo9+l5Pk+KkHJfDU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Xai5YS3WpnSExeeGQFwIFMeVWvOe9oh5y9mmPemzjhmg8OfKTOYlIYNJ/Iq7pUdjOtg4UJFVWaEii+gAbPSaErxfwMnDHVp3D0unKxWaoLB2CUvHmBM2IFUXq5tc8jhExz6xSid5nAfIXjODypLrwko+EQUXOetfvEH6t5COO+8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=szw6ceQy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64L7rMKA11132630, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779350002; bh=a3lI1uBhY+65s4W+EKo7UFoC+eRLo9+l5Pk+KkHJfDU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=szw6ceQy0O/3cX+TBV1oWoy+Wcst+FMfQ9Co7t7keUdxq7VURIIktplxyVHzst4W1
	 WrJNzjMDBs/nlKBb9+0nfN4Jm9bjIkK60shKE/77Cyp0k/tVCEVls4HL68DikReToh
	 UdQT7RNBn1o+YJrqrIzFu1HXeTPkSMak8b8B0sl29KVwf65/ucCH6NXX56zw8VwdEc
	 HSyZ+ptf2R94PMtT3CdG3T9fPUuQb+qA7v90H6/ZL4Pc0x/3YWs5SvKWoQRABCEmGS
	 a5+TVGeFOLQ7gKrYgjBN6c06baiQORylvNIMotjEZEMS+ew+ii5llMb1b7mi+TbdpV
	 B7ko2nXvLntPA==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64L7rMKA11132630
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 21 May 2026 15:53:22 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 May 2026 15:53:22 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Thu, 21 May 2026 15:53:22 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Thu, 21 May 2026 15:53:22 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Masashi Honma
	<masashi.honma@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v6 1/6] wifi: mac80211: Use struct instead of macro for
 PREQ frame
Thread-Topic: [PATCH v6 1/6] wifi: mac80211: Use struct instead of macro for
 PREQ frame
Thread-Index: AQHc5MP/zOngxkWbM0ai666I8zXda7YWRAMAgAFlUeCAAGI1LYAADEAQ//+DOoCAAIiyQA==
Date: Thu, 21 May 2026 07:53:22 +0000
Message-ID: <9996dcdc12774caf835205040e18eaeb@realtek.com>
References: <20260515233839.86829-1-masashi.honma@gmail.com>
		 <965eff7ec3b928f093f7891e4307ec4e4a080ac4.camel@sipsolutions.net>
		 <d2c051127e384a918ff014da02e37e1e@realtek.com>
		 (sfid-20260521_024301_935117_BC310192)
 <93ab81b4fb7130a4d4e1048581d886568086fe24.camel@sipsolutions.net>
	 <7e1aac3afd714d448e5bfba4a9a113b0@realtek.com>
 <bf2081a986eccd28378b4019b2968c15e6659b7f.camel@sipsolutions.net>
In-Reply-To: <bf2081a986eccd28378b4019b2968c15e6659b7f.camel@sipsolutions.net>
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
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip4:172.105.105.114:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	TAGGED_FROM(0.00)[bounces-36748-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[sipsolutions.net,gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:rdns,tor.lore.kernel.org:helo,sipsolutions.net:email];
	RCPT_COUNT_THREE(0.00)[3];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-1.000];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:172.105.96.0/20, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 572B45A0889
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Sm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4gd3JvdGU6DQo+ID4gSW4g
bXkgdGVzdHMgd2l0aCBhcm0tZ2NjIGNvbXBpbGVyLCBJIGRpZCBhIHNwZWNpYWwgY2FzZToNCj4g
Pg0KPiA+IHN0cnVjdCBmb28gew0KPiA+ICAgICAgIGludCBhOw0KPiA+ICAgICAgIGNoYXIgYjsN
Cj4gPiB9IF9fcGFja2VkOw0KPiA+DQo+ID4gaW50IGJhcihzdHJ1Y3QgZm9vICpmb28pDQo+ID4g
ew0KPiA+ICAgICAgIHJldHVybiBmb28tPmE7DQo+ID4gfQ0KPiA+DQo+ID4gSXQgaXMgb2J2aW91
c2x5IGFsaWduZWQgKG9mZnNldCA9IDApLCBzbyBJIGd1ZXNzZWQgYXJtLWdjYyBjYW4gZ2VuZXJh
dGUNCj4gPiBhIHNpbmdsZSBsb2FkIGluc3RydWN0aW9uLCBidXQgYWN0dWFsbHkgaXQgZG9lc24n
dCAoZXZlbiB3aXRoIC1PMykuDQo+IA0KPiBObywgaXQgY2Fubm90LCBiZWNhdXNlIGluIGFkZGl0
aW9uIGl0IGhhcyB0byBhc3N1bWUgdGhlIHBvaW50ZXIgJ2ZvbycNCj4gaXRzZWxmIGhhcyBubyBh
bGlnbm1lbnQuIFdlIHVzZSB0aGlzIGEgbG90IHRvbywgc2luY2UgYSBzdHJ1Y3QgbGlrZSB5b3Vy
DQo+ICdzdHJ1Y3QgZm9vJyBjb3VsZCBiZSBpbiBhIGZyYW1lIGVsZW1lbnQgd2hlcmUgd2UgZG9u
J3Qga25vdyB3aGF0IGNhbWUNCj4gYmVmb3JlIGl0IHdoaWxlIHBhcnNpbmcgdGhlIGVsZW1lbnRz
LCBzbyB3ZSBkb24ndCBrbm93IHRoYXQgJ2ZvbycgaGFzDQo+IGFueSBhbGlnbm1lbnQuDQo+IA0K
PiBUaGUgcmVhc29ucyBhcmUgcmVsYXRlZCB0byB3aGF0IGhhcHBlbnMgd2hlbiB5b3UgaGF2ZSBh
DQo+IA0KPiAgICAgICAgIHN0cnVjdCBmb28gYXJyYXlbTl07DQo+IA0KPiBJIHRoaW5rLCBiZWNh
dXNlIHRoZW4gX19wYWNrZWQgbWVhbnMgdGhlcmUncyBubyBwYWRkaW5nIGF0IHRoZSBlbmQgb2YN
Cj4gJ3N0cnVjdCBmb28nIGVpdGhlciwgYW5kIGFycmF5WzFdIGlzIGEgY29tcGxldGVseSB1bmFs
aWduZWQgcG9pbnRlci4NCj4gDQo+IFNvIG5vLCB0aGUgY29tcGlsZXIgY291bGRuJ3QgYXNzdW1l
IGFsaWdubWVudCBldmVuIGZvciBmaWVsZHMgdGhhdCBsb29rDQo+IGFsaWduZWQgd2l0aGluICdz
dHJ1Y3QgZm9vJy4NCg0KSSBsZWFybmVkIG1vcmUuIFN1cGVyIHRoYW5rIHlvdS4gOikNCg0KUGlu
Zy1LZQ0KDQo=

