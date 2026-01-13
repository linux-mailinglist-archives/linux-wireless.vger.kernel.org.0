Return-Path: <linux-wireless+bounces-30715-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sto.lore.kernel.org (sto.lore.kernel.org [IPv6:2600:3c09:e001:a7::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id A53C3D16053
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 01:33:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sto.lore.kernel.org (Postfix) with ESMTP id 9FD3630259DE
	for <lists+linux-wireless@lfdr.de>; Tue, 13 Jan 2026 00:32:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4029E267386;
	Tue, 13 Jan 2026 00:32:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="c4LLaagf"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D94F262808;
	Tue, 13 Jan 2026 00:32:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768264325; cv=none; b=kXspPyxk9SLcNwEpXH4ZsE3ffdWay451Zu0getT10YkRWocuv6XRI5C8iTbSoBiYAZLqS/NsFv86B/MBJTz4hEuY9/os8XVsJA/FSf+4FyK7yzhjehP033hwXGzpM25A4/Vfp3v96WztlhDbd6aF1rtvrDBs8GPgh+VxEQt05Rw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768264325; c=relaxed/simple;
	bh=r3SC90hJJ1X8+TKF0Dz+DVyi18IYWKfVpwH7hwOEfTU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qOFYgZuZpMhlMGTk6delxsCt99l+2UalUzRVtPvDLvOx09Oi3+ZGYsvYpGqE5cVCCKnzmyBft1GzQsRW7NXnYMdjrn6bnUpLOfTCmd5uogifYpjl1dlilmUYGRiM7M8boouDrTpeqKE8+WgJrCp/+HCX5g0qaciFKG8PuS2kzrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=c4LLaagf; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 60D0Vn8621915520, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1768264309; bh=r3SC90hJJ1X8+TKF0Dz+DVyi18IYWKfVpwH7hwOEfTU=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=c4LLaagfqdzuWRhrgZfir/tfe4CfNKNO8d+McPjQzdCUxCn0ASJakOg2bdMr9Qd/h
	 5MJdmZQ60rzPdqbPFOlDB6LGYbXjmRAkttVGrxiFEhtP6eL1F5CiCgSFolSoVI7WuU
	 6mYKrS2I2I7mbJaWuWLRDH5XzwX6diJj6EnM4eIsiMQV5T/cQNOc629RnDqC5y9C4F
	 ox3M9alUFI6gsuM+lftKCbcmE+ph7cUlnRzFvkhwJtA+bzaKQ7GLN7iGgzz2+X3KTO
	 EW4epw6OD8a+nL2IhH3cpv7fwWVL5jWpV1Qix80drOMziqJgcF51sME31Dqw/7Jwn1
	 3fiicFgnaEnrQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 60D0Vn8621915520
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Jan 2026 08:31:49 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 13 Jan 2026 08:31:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Tue, 13 Jan 2026 08:31:50 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Tue, 13 Jan 2026 08:31:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        =?utf-8?B?VXdlIEtsZWluZS1Lw7ZuaWc=?= <u.kleine-koenig@baylibre.com>,
        "Ulf
 Hansson" <ulf.hansson@linaro.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-mmc@vger.kernel.org" <linux-mmc@vger.kernel.org>
Subject: RE: [PATCH v2 0/3] sdio: Use bus type function for shutdown
Thread-Topic: [PATCH v2 0/3] sdio: Use bus type function for shutdown
Thread-Index: AQHcg9q8Z99/jlpXQUWuVez96n59WLVOrvf6gACQ7VA=
Date: Tue, 13 Jan 2026 00:31:49 +0000
Message-ID: <c33e54f94ffc459eab8c6857c2d78b51@realtek.com>
References: <cover.1768232321.git.u.kleine-koenig@baylibre.com>
	 (sfid-20260112_164712_157423_ABC1CD8C)
 <dc096cdc77d42bd90f3e3e3f420912bf365793ad.camel@sipsolutions.net>
In-Reply-To: <dc096cdc77d42bd90f3e3e3f420912bf365793ad.camel@sipsolutions.net>
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

Sm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4gd3JvdGU6DQo+IE9uIE1v
biwgMjAyNi0wMS0xMiBhdCAxNjo0NiArMDEwMCwgVXdlIEtsZWluZS1Lw7ZuaWcgd3JvdGU6DQo+
ID4gSGVsbG8sDQo+ID4NCj4gPiB0aGlzIHNlcmllcyBpcyBwYXJ0IG9mIGFuIGVmZm9ydCB0byBn
ZXQgcmlkIG9mIHRoZSAuc2h1dGRvd24oKSBjYWxsYmFjaw0KPiA+IChhbmQgLnByb2JlKCkgYW5k
IC5yZW1vdmUoKSkgaW4gc3RydWN0IGRldmljZV9kcml2ZXIuIFByZXBhcmluZyB0aGF0LA0KPiA+
IGFsbCBzZGlvIGRyaXZlcnMgdGhhdCB1cCB0byBub3cgdXNlIHRoaXMgY2FsbGJhY2sgYXJlIGNv
bnZlcnRlZCB0byBhIG5ldw0KPiA+IHNkaW8gc3BlY2lmaWMgc2h1dGRvd24gY2FsbGJhY2suDQo+
ID4NCj4gPiB2MSBpcyBhdmFpbGFibGUgYXQgaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsL2Nv
dmVyLjE3NjU5Njg4NDEuZ2l0LnVrbGVpbmVrQGtlcm5lbC5vcmcuDQo+ID4NCj4gPiBDaGFuZ2Vz
IHNpbmNlIHYxOg0KPiA+ICAtIERyb3AgcGF0Y2ggMi80IHdoaWNoIHJlc3VsdGVkIGluIGEgYnVp
bGQgZmFpbHVyZSB3aXRoIENPTkZJR19QTT1uDQo+ID4NCj4gPiBQYXRjaGVzICMyIGFuZCAjMyBk
ZXBlbmQgb24gdGhlIGZpcnN0IHBhdGNoLCBhbmQgd2l0aCBqdXN0IHRoZSBmaXJzdA0KPiA+IHBh
dGNoIGFwcGxpZWQgdGhlcmUgaXMgYSBydW50aW1lIHdhcm5pbmcgKGVtaXR0ZWQgYnkgdGhlIGRy
aXZlciBjb3JlIGluDQo+ID4gZHJpdmVyX3JlZ2lzdGVyKCkpIGZvciBlYWNoIHVuY29udmVydGVk
IGRyaXZlci4gU28gaXQgd291bGQgYmUgbmljZSB0bw0KPiA+IGdldCB0aGUgd2hvbGUgc2VyaWVz
IGluIGR1cmluZyBhIHNpbmdsZSBtZXJnZSB3aW5kb3cgdG8gbm90IGxldCB1c2Vycw0KPiA+IGZh
Y2UgdGhlIHdhcm5pbmcuDQo+ID4NCj4gPiBHaXZlbiB0aGF0IGFsbCBkcml2ZXJzIGFyZSBpbiBk
cml2ZXJzL25ldC93aXJlbGVzcyBJIHN1Z2dlc3QgdG8gYXBwbHkNCj4gPiB0aGUgd2hvbGUgc2Vy
aWVzIHZpYSB0aGUgd2lyZWxlc3MgdHJlZS4NCj4gPg0KPiANCj4gU291bmRzIGdvb2QsIHRoYW5r
cyBmb3IgdGhlIGhlYWRzLXVwLg0KPiANCj4gSSBndWVzcyBJIHNob3VsZCBnZXQgVWxmJ3MgYWNr
IGZvciB0aGUgTU1DIHBhcnQsIGFuZCBQaW5nLUtlJ3MgZm9yIHRoZQ0KPiBydHcgcGFydCwgYW5k
IG5vYm9keSBjYXJlcyBhYm91dCByc2kgOikNCg0KQWNrZWQuIEFuZCBhc3NpZ25lZCB0aGlzIHBh
dGNoIHRvIHlvdSBpbiBwYXRjaHdvcmsuIFRoYW5rcy4gDQoNCg0K

