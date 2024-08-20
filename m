Return-Path: <linux-wireless+bounces-11649-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11D97957B01
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 03:33:34 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92F8CB20DDE
	for <lists+linux-wireless@lfdr.de>; Tue, 20 Aug 2024 01:33:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BAEE017BD3;
	Tue, 20 Aug 2024 01:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="E0FMvG5r"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530F01B813
	for <linux-wireless@vger.kernel.org>; Tue, 20 Aug 2024 01:33:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724117607; cv=none; b=j+7H8AvEEf5BcOnEQ8w0jZBvH8u4bHX098/0o0cCFzOm5vS8lMAtjbn25ZJellHytmsdcY/1Ln7MeeSevXqS+jWqveL3zpvuHkSXxtasEL56Doyj1DbJsuzT5K2bMeBhxOBpQZnfZdyy/KQ0lDpa3NiE6eKRlPcRjtrEPhfR//U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724117607; c=relaxed/simple;
	bh=OIXvzpq4shGPCpxd3VCEKF2he7EVc7lT49VtGVRG774=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=UthCqqWuAXO/6kW+5waF9aey5rDCYIOjAm0axT92Oj3+hjsImWIYNr0K+E7QqpK8agJEIu7bpVYW8WWuyvLnsSJIvhOvoR4yX9hgucdAd7/osqcn7CnZKifrXyyt6es9GT6d5gYPbWiJIlu8vwD06EME4jkT3fw7IlJs8d0Dvzg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=E0FMvG5r; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47K1XBhmC820312, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724117591; bh=OIXvzpq4shGPCpxd3VCEKF2he7EVc7lT49VtGVRG774=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=E0FMvG5rJAmM250irDHbUhat1WPe1Ep8KA6eYU1m9gstH2lqbkF++V1vhozHvMwLC
	 G4eKnjSuBagtolurIwt0bJKuL8BpzHTRQ9DsKzXNAh0HJ8BkP7Sxwy6P4ZQN6afmCa
	 uZ/KbLiGq+XPaVhAKYc68nQD77rfZSbB2SU5lGDxEdnWM3MFRABYmIYf44tOWX9gqr
	 z7uN+iNFbh8VOcdhH+vfy6kWcE4YXFtTZZ4gC5boNHGlIL12fln56BOAsSELLfla02
	 /bwQ5C/78ORfoMQBcVXHEBNC/nUWzBBGp94iXxHrpJQ4xpADAOyEl8h4WGzBCGS05k
	 1ZxdROVRBin9w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47K1XBhmC820312
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 20 Aug 2024 09:33:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 20 Aug 2024 09:33:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 20 Aug 2024 09:33:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Tue, 20 Aug 2024 09:33:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: "pbrobinson@gmail.com" <pbrobinson@gmail.com>
Subject: RE: [PATCH 1/2] wifi: mac80211: export ieee80211_purge_tx_queue() for drivers
Thread-Topic: [PATCH 1/2] wifi: mac80211: export ieee80211_purge_tx_queue()
 for drivers
Thread-Index: AQHa8gVfni8UYhlrUEejFq+acMri8rItqPMAgACnBiA=
Date: Tue, 20 Aug 2024 01:33:10 +0000
Message-ID: <5c03af1717a54f0a9f76dbac45d8066a@realtek.com>
References: <20240819065855.25678-1-pkshih@realtek.com>
 <554fce82a0c10e0718b9066cbc1e37c67395741b.camel@sipsolutions.net>
In-Reply-To: <554fce82a0c10e0718b9066cbc1e37c67395741b.camel@sipsolutions.net>
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

Sm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4gd3JvdGU6DQo+ID4gKy8q
Kg0KPiA+ICsgKiBpZWVlODAyMTFfcHVyZ2VfdHhfcXVldWUgLSBwdXJnZSBUWCBza2IgcXVldWUN
Cj4gPiArICogQGh3OiB0aGUgaGFyZHdhcmUNCj4gPiArICogQHNrYnM6IHRoZSBza2JzDQo+ID4g
KyAqDQo+ID4gKyAqIEZyZWUgYSBzZXQgb2YgdHJhbnNtaXQgc2ticy4gVXNlIHRoaXMgZnVuY3Rp
b24gd2hlbiBkZXZpY2UgaXMgZ29pbmcgdG8gc3RvcA0KPiA+ICsgKiBidXQgc29tZSB0cmFuc21p
dCBza2JzIHdpdGhvdXQgVFggc3RhdHVzIGFyZSBzdGlsbCBxdWV1ZWQuDQo+ID4gKyAqLw0KPiA+
ICt2b2lkIGllZWU4MDIxMV9wdXJnZV90eF9xdWV1ZShzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywN
Cj4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHNrX2J1ZmZfaGVhZCAqc2ti
cyk7DQo+IA0KPiBVbmxpa2Ugc2tiX3F1ZXVlX3B1cmdlKCkvc2tiX3F1ZXVlX3B1cmdlX3JlYXNv
bigpLCB0aGlzIGRvZXNuJ3QgdGFrZSB0aGUNCj4gbG9jaywgdGhhdCBzZWVtcyBpbXBvcnRhbnQg
dG8gbm90ZSBoZXJlPw0KDQpUaGFua3MuIEkgd2Fzbid0IGF3YXJlIG9mIGxvY2ssIGFuZCBydHc4
OCBuZWVkcyBhIGxvY2sgdmVyc2lvbiBiZWNhdXNlDQppdHMgVFggd29yayBpc24ndCBzdG9wcGVk
IHlldCB3aGlsZSBjYWxsaW5nIGllZWU4MDIxMV9wdXJnZV90eF9xdWV1ZSgpLg0KDQpJIGhhdmUg
dGhyZWUgY2FuZGlkYXRlIG9wdGlvbnM6DQoNCjEuIGFkZCBzcGluX2xvY2sgYnkgZHJpdmVyIGJl
Zm9yZSBjYWxsaW5nIGllZWU4MDIxMV9wdXJnZV90eF9xdWV1ZSgpLg0KDQoyLiBtb3ZlIG9yaWdp
bmFsIGllZWU4MDIxMV9wdXJnZV90eF9xdWV1ZSgpIHRvIF9faWVlZTgwMjExX3B1cmdlX3R4X3F1
ZXVlKCksDQogICBhbmQgYWRkIGFuIG5ldyBsb2NrIHZlcnNpb24gb2YgaWVlZTgwMjExX3B1cmdl
X3R4X3F1ZXVlKCkuDQoNCjMuIGNoYW5nZSBydHc4OCBkZWluaXQgZmxvdyB0byBlbnN1cmUgc3Rv
cHBpbmcgVFggd29yayBiZWZvcmUgY2FsbGluZw0KICAgaWVlZTgwMjExX3B1cmdlX3R4X3F1ZXVl
KCkNCg0KSSBwcmVmZXIgb3B0aW9uIDMuIEJ1dCB3YW50IHlvdXIgb3BpbmlvbiBpZiBvcHRpb24g
MiBpcyB3b3J0aCB0byBkbz8NCg0KUGluZy1LZQ0KDQo=

