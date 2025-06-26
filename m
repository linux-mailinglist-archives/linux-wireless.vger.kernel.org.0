Return-Path: <linux-wireless+bounces-24508-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 01DD6AE9374
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 02:38:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75A6C16FAE0
	for <lists+linux-wireless@lfdr.de>; Thu, 26 Jun 2025 00:38:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BCBF82D98;
	Thu, 26 Jun 2025 00:38:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="s/M0/44i"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CF9E13BC3F
	for <linux-wireless@vger.kernel.org>; Thu, 26 Jun 2025 00:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750898304; cv=none; b=u7IN/lk7nT1gNa7X0euAVBTsZ7Jke6vt/8QOErDNg2IaqL1iAySI94rI1/ILYVYscHaMbvTROZIDLHFnEwIXlalg8iUabfXWtCfEK7LnLmoflEp+pyraLr1zImX2DX1inJslwtVJEYd7bJzCqiU1SIocHuK54o7DPYt6LJZql1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750898304; c=relaxed/simple;
	bh=5pddSicfR+CXNSmPNewqWbqm7AphfNlB8K1Zt4rrZBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Uljb19o7BtSiD+1PhWVjP4eKiwHUaDhFSKfOpRCdIZDMz2cxsxMz+9UQF+UoO5mF5Cum6N1odFcZYfcNuO/nTLeYQQyw4lUisEKtj/tkfBhjl+0CmKuPyYf8YPpFqgXdVyl1Z9tRWi0jS8nIA6nzza0ZX2JFIihU52jjmILlQrA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=s/M0/44i; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55Q0bQ4c92136898, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750898246; bh=5pddSicfR+CXNSmPNewqWbqm7AphfNlB8K1Zt4rrZBs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=s/M0/44iXfkEzm+2FnEI0HgEXC/BdYa1LwAR4dI9Llg9gK6CmmLJlWCwzL/Lv+JBm
	 DDjRxdr3IWyonvP7jiXxX7MCkyQ9p96+PqwdBkmkyTEgQLqOObi42mZXaG7qT5ynG2
	 O2QmJZ5INTYSuZijqLOCla+I3+cbR8wv17Ao0NGPyAJpDp1nGcRgKcogNecAQI1RGi
	 XM1RKrO46LW1bK3ZhtO0z7PhnGpInY2obSo9nZJkR+c1+OjVF9gAlWZOxlUX9Sltq4
	 IbgzRnluW0i3MuCBicUrZuHB5dXKw9FAG7hVRJ4ncMoiHwVVNbWn6Tsmh4knCi6N2S
	 c3mD+c/kpMNfQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55Q0bQ4c92136898
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 26 Jun 2025 08:37:26 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 26 Jun 2025 08:37:42 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 26 Jun 2025 08:37:42 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25]) by
 RTEXDAG02.realtek.com.tw ([fe80::1d65:b3df:d72:eb25%5]) with mapi id
 15.01.2507.035; Thu, 26 Jun 2025 08:37:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Ezra Buehler <ezra@easyb.ch>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: Jes Sorensen <Jes.Sorensen@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Martin Kaistra <martin.kaistra@linutronix.de>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        "Reto
 Schneider" <reto.schneider@husqvarnagroup.com>,
        Ezra Buehler
	<ezra.buehler@husqvarnagroup.com>
Subject: RE: [PATCH v1 0/3] wifi: rtl8xxxu: AP mode fixes (for gen1 devices)
Thread-Topic: [PATCH v1 0/3] wifi: rtl8xxxu: AP mode fixes (for gen1 devices)
Thread-Index: AQHbgvcQwZ4eZXF7iEahMjG01KpwPLQUa/YAgADwwZA=
Date: Thu, 26 Jun 2025 00:37:42 +0000
Message-ID: <5b31bd2ce9274d1380f210cb0b6b79c3@realtek.com>
References: <20250219175228.850583-1-ezra@easyb.ch>
 <8132EC31-A53A-4C49-93D6-70D45600C4B4@easyb.ch>
In-Reply-To: <8132EC31-A53A-4C49-93D6-70D45600C4B4@easyb.ch>
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

RXpyYSBCdWVobGVyIDxlenJhQGVhc3liLmNoPiB3cm90ZToNCj4gPiBPbiAxOSBGZWIgMjAyNSwg
YXQgMTg6NTIsIEV6cmEgQnVlaGxlciA8ZXpyYUBlYXN5Yi5jaD4gd3JvdGU6DQo+ID4NCj4gPiBG
cm9tOiBFenJhIEJ1ZWhsZXIgPGV6cmEuYnVlaGxlckBodXNxdmFybmFncm91cC5jb20+DQo+ID4N
Cj4gPiBBcyBtZW50aW9uZWQgaW4gdGhlIHByZXZpb3VzIHBhdGNoIFsxXSwgZXNwZWNpYWxseSB0
aGUgdHJhbnNtaXQgcmF0ZSBpcw0KPiA+IHJhdGhlciBsb3cgaW4gQVAgbW9kZSB3aXRoIGdlbjEg
ZGV2aWNlcyBsaWtlIHRoZSBSVEw4MTkyQ1UuIFRoZQ0KPiA+IGZvbGxvd2luZyBjaGFuZ2VzIHNl
ZW0gdG8gZml4IHRoZSBpc3N1ZS4NCj4gPg0KPiA+IFdoZW4gbG9va2luZyBhdCB0aGUgcGF0Y2hl
cyBpbnRyb2R1Y2luZyB0aGUgaW5pdGlhbCBBUCBzdXBwb3J0IFsyXSwgSQ0KPiA+IG5vdGljZWQg
dGhhdCBydGw4eHh4dV9nZW4yX3JlcG9ydF9jb25uZWN0KCkgd2FzIGFsdGVyZWQgdG9vLiBTbywg
bm93IEkNCj4gPiBhbSB3b25kZXJpbmcgaWYgd2UgbmVlZCB0byB1c2UgYG1hY2lkYCBhbmQgYHJv
bGVgIGluDQo+ID4gcnRsOHh4eHVfZ2VuMV9yZXBvcnRfY29ubmVjdCgpIGFzIHdlbGwuLi4NCj4g
Pg0KPiA+IFsxXTogaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvYWxsLzIwMjUwMTIyMDcxNTEyLjEw
MTY1LTEtZXpyYUBlYXN5Yi5jaC8NCj4gPiBbMl06IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2Fs
bC8yMDIzMDQyODE1MDgzMy4yMTg2MDUtMS1tYXJ0aW4ua2Fpc3RyYUBsaW51dHJvbml4LmRlLw0K
PiA+DQo+ID4NCj4gPiBFenJhIEJ1ZWhsZXIgKDMpOg0KPiA+ICB3aWZpOiBydGw4eHh4dTogVXNl
IG1hY2lkIGluIHJ0bDh4eHh1X3VwZGF0ZV9yYXRlX21hc2soKQ0KPiA+ICB3aWZpOiBydGw4eHh4
dTogVXNlIG1hY2lkIGluIHJ0bDh4eHh1X2ZpbGxfdHhkZXNjX3YxKCkNCj4gPiAgd2lmaTogcnRs
OHh4eHU6IE1ha2Ugc3VyZSBUWCByYXRlIGlzIHJlcG9ydGVkIGluIEFQIG1vZGUNCj4gPg0KPiA+
IGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvY29yZS5jICB8IDI4ICsrKysr
KysrKysrKysrKysrKy0NCj4gPiAuLi4vbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnRsOHh4eHUvcnRs
OHh4eHUuaCAgfCAgMSArDQo+ID4gMiBmaWxlcyBjaGFuZ2VkLCAyOCBpbnNlcnRpb25zKCspLCAx
IGRlbGV0aW9uKC0pDQo+ID4NCj4gPiDigJQNCj4gPiAyLjQzLjANCj4gDQo+IEkgYXBvbG9naXpl
IGZvciB0aGUgcmFkaW8gc2lsZW5jZS4gSXQgdHVybmVkIG91dCB0aGF0IHRoZXNlIGNoYW5nZXMg
ZG8NCj4gbm90IGltcHJvdmUgdGhpbmdzLiBJIG11c3QgaGF2ZSBtYWRlIGEgbWlzdGFrZSB3aGVu
IG1lYXN1cmluZyB0aHJvdWdocHV0DQo+IGJhY2sgdGhlbi4NCj4gDQo+IFdoZW4gdGVzdGluZyB0
aGUgVFggcmF0ZSAod2l0aCBpcGVyZjMpLCBJIHNlZSB0aGUgdGhyb3VnaHB1dCBjb25zdGFudGVs
eQ0KPiBkcm9wcGluZyB0byAwIGJpdHMvc2VjLiBUaGlzIG1ha2VzIEFQIG1vZGUgdW51c2FibGUg
ZXZlbiBmb3Igb3VyDQo+IG5vbi1kYXRhLWhlYXZ5IHVzZSBjYXNlLg0KPiANCj4gRG8geW91IGhh
dmUgYW55IHN1Z2dlc3Rpb25zIHdoZXJlIHRvIGRpZyBkZWVwZXIgdG8gZ2V0IHRvIHRoZSBib3R0
b20gb2YNCj4gdGhpcz8NCg0KVGVzdGluZyB3aXRoIHNpbmdsZSBvbmUgc3RhdGlvbiBjb25uZWN0
ZWQgd291bGQgYmUgZWFzaWVyIHRvIGFkZHJlc3MgcHJvYmxlbSwNCmFuZCBlbnN1cmUgbWFjX2lk
IGlzIGFsd2F5cyAxIGZvciBBUCBtb2RlIHRyYW5zbWl0dGluZyBwYWNrZXRzIHRvIHRoZQ0Kc3Rh
dGlvbi4gDQoNCkFsc28sIHlvdSBuZWVkIGEgc25pZmZlciB0byBjaGVjayBQSFkgcmF0ZSBpZiBp
dCBjYW4ga2VlcC4gQXMgd2VsbCBhcyB0aGUNCnJhdGUgd2hlbiB0aHJvdWdocHV0IGRyb3BwZWQu
IElmIHJhdGUgaXMgZ29vZCwgY2hlY2sgYW55IG1pc2JlaGF2aW9yIG9mIGFpcg0KcGFja2V0cy4g
DQoNCkJlZm9yZSBhbGwgYWJvdmUsIHBsZWFzZSBlbnN1cmUgdGhlIFBIWSByYXRlIGlzIGdvb2Qg
d2hlbiBpdCBwbGF5cyBhcyBhDQpzdGF0aW9uIG1vZGUuDQoNCg==

