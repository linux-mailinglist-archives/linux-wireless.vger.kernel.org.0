Return-Path: <linux-wireless+bounces-5988-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0BA2A89CF53
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 02:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D64DA1C21448
	for <lists+linux-wireless@lfdr.de>; Tue,  9 Apr 2024 00:28:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1CBE9370;
	Tue,  9 Apr 2024 00:28:32 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A066719B
	for <linux-wireless@vger.kernel.org>; Tue,  9 Apr 2024 00:28:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712622512; cv=none; b=HNB0tnV9cQrnip76Al+DHR6YQxY2dM1KJZRpW4Wzh9wNG0Zq8RU6MuQpmUDbdQDEnkCZf83WX241jV2IPwG7xDTkkDGtmPGJyPH0gWpFqZq5la7ot8Zw07QCez1/o5R8EBaTg67zqn62rp80e/Zwh7wl4m9bOe6jcsmIyZ4ieMs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712622512; c=relaxed/simple;
	bh=WEtieh9NJ2PeTiESNx8tBKUtJv49Gix5zRUvEG00lrc=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=VkzI0ekwak9igSuYsOymuK1ooMz0p8ZldlY255eBMCcIbk3EuZSzn6Xt8oPpihqekvGSYoU/THb8NWM5gjVqtzoaa7q78XoRRTb8gxxG8aHWG7SFHgKxnvfnkP4D81Rx5aybMDofmWeFom8vPBPwaB0CEltQ8pKjsynpM2SsK/M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4390RvwA62340276, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4390RvwA62340276
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 9 Apr 2024 08:27:57 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 08:27:58 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 9 Apr 2024 08:27:57 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 9 Apr 2024 08:27:57 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "kvalo@kernel.org"
	<kvalo@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "s.l-h@gmx.de"
	<s.l-h@gmx.de>,
        "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: RE: [PATCH v3 11/12] wifi: rtlwifi: Add rtl8192du/sw.{c,h}
Thread-Topic: [PATCH v3 11/12] wifi: rtlwifi: Add rtl8192du/sw.{c,h}
Thread-Index: AQHaev7lVhGGoQ4nQ0GxbEPAiHfc3rFCwUMAgAhizQCAANTTI///vigAgAAwEwCAAMUwAIABPbAAgAPR/oCAAO0mAIAJogKAgAFx7VD//+2BAIABh96w
Date: Tue, 9 Apr 2024 00:27:57 +0000
Message-ID: <253da7b1650d47b59114c635e7ad8dc3@realtek.com>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
 <2eb79c8c-cf2c-4696-b958-e8d961628e17@gmail.com>
 <f86a40493745a53ff73083f87b3e8fae215eac77.camel@realtek.com>
 <66565618-3638-47e5-afe5-3530214da0c9@gmail.com> <87ttkrzf1m.fsf@kernel.org>
 <5696990a-4450-4d92-bbda-1d9ca3a9a619@gmail.com>
 <4672072ef782ae1200886a190c740e0f3ccec2c8.camel@realtek.com>
 <7873dee1-46a8-48a7-9059-bc300ac98c23@gmail.com>
 <1f8ebed6a04a4fbebf33b0a3edc2f50b@realtek.com>
 <ff3b97d0-118c-42b3-be0b-47cfcf06ab74@gmail.com>
 <7741a59a6ebf4e0f8c55b0f5c3f55a41@realtek.com>
 <321c6855-2e58-48ae-b131-a3f6d7041713@gmail.com>
 <21299940bf9342ae9c82916084ea7d9e@realtek.com>
 <519e6717-3a58-4814-932d-8b246fd39f37@gmail.com>
In-Reply-To: <519e6717-3a58-4814-932d-8b246fd39f37@gmail.com>
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

DQoNCkJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPiB3cm90ZToNCg0K
PiANCj4gT24gMDgvMDQvMjAyNCAwNTo0NSwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+Pg0KPiA+
Pg0KPiA+PiBzdGF0aWMgc3RydWN0IHVzYl9pbnRlcmZhY2UgKnJ0bDkyZHVfZ2V0X290aGVyX2lu
dGYoc3RydWN0IGllZWU4MDIxMV9odyAqaHcpDQo+ID4+IHsNCj4gPj4gICAgICAgICBzdHJ1Y3Qg
dXNiX2ludGVyZmFjZSAqaW50ZjsNCj4gPj4gICAgICAgICBzdHJ1Y3QgdXNiX2RldmljZSAqdWRl
djsNCj4gPj4gICAgICAgICB1OCBvdGhlcl9pbnRlcmZhY2VpbmRleDsNCj4gPj4NCj4gPj4gICAg
ICAgICAvKiBTZWUgU0VUX0lFRUU4MDIxMV9ERVYoaHcsICZpbnRmLT5kZXYpOyBpbiB1c2IuYyAq
Lw0KPiA+PiAgICAgICAgIGludGYgPSBjb250YWluZXJfb2ZfY29uc3Qod2lwaHlfZGV2KGh3LT53
aXBoeSksIHN0cnVjdCB1c2JfaW50ZXJmYWNlLCBkZXYpOw0KPiA+Pg0KPiA+PiAgICAgICAgIG90
aGVyX2ludGVyZmFjZWluZGV4ID0gMSAtIGludGYtPmFsdHNldHRpbmdbMF0uZGVzYy5iSW50ZXJm
YWNlTnVtYmVyOw0KPiA+DQo+ID4gVGhlIHZhbHVlIG9mIGJJbnRlcmZhY2VOdW1iZXIgZm9yIHR3
byBpbnN0YW5jZXMgYXJlIDAgYW5kIDEsIHJpZ2h0PyBUaGVuDQo+ID4gJzEgLSB4JyB0byBnZXQg
ZWFjaCBvdGhlciAtLSB0aGF0IGxvb2tzIGEgbGl0dGxlIHRyaWNreSA7LSkNCj4gPg0KPiANCj4g
VGhlIHZlbmRvciBkcml2ZXIgYXNzdW1lcyBiSW50ZXJmYWNlTnVtYmVyIGNhbiBvbmx5IGJlIDAg
b3IgMS4NCj4gSSBjYW4gbWFrZSBpdCBtb3JlIGV4cGxpY2l0Og0KPiANCj4gICAgICAgICBpZiAo
aW50Zi0+YWx0c2V0dGluZ1swXS5kZXNjLmJJbnRlcmZhY2VOdW1iZXIgPT0gMCkNCj4gICAgICAg
ICAgICAgICAgIG90aGVyX2ludGVyZmFjZWluZGV4ID0gMTsNCj4gICAgICAgICBlbHNlDQo+ICAg
ICAgICAgICAgICAgICBvdGhlcl9pbnRlcmZhY2VpbmRleCA9IDA7DQo+IA0KDQpUaGF0IGxvb2tz
IGVhc2llciB0byB1bmRlcnN0YW5kLiANCg0KPiA+DQo+ID4+DQo+ID4+IHN0YXRpYyB2b2lkIHJ0
bDkyZHVfZGVpbml0X3NoYXJlZF9kYXRhKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3KQ0KPiA+PiB7
DQo+ID4+ICAgICAgICAgc3RydWN0IHVzYl9pbnRlcmZhY2UgKm90aGVyX2ludGYgPSBydGw5MmR1
X2dldF9vdGhlcl9pbnRmKGh3KTsNCj4gPj4gICAgICAgICBzdHJ1Y3QgcnRsX3ByaXYgKnJ0bHBy
aXYgPSBydGxfcHJpdihodyk7DQo+ID4+DQo+ID4+ICAgICAgICAgaWYgKCFvdGhlcl9pbnRmIHx8
IHVzYl9nZXRfaW50ZmRhdGEob3RoZXJfaW50ZikpIHsNCj4gPj4gICAgICAgICAgICAgICAgIC8q
IFRoZSBvdGhlciBpbnRlcmZhY2UgZG9lc24ndCBleGlzdCBvciB3YXMgbm90IGRpc2Nvbm5lY3Rl
ZCB5ZXQuICovDQo+ID4NCj4gPiBGb3IgdGhlIFVTQiBhZGFwdG9yIHdpdGggc2luZ2xlIG9uZSBp
bnRlcmZhY2UsIHlvdSBkb24ndCBoYXZlIG90aGVyX2ludGYuDQo+ID4gVGhlbiwganVzdCBmcmVl
IHRoZW0uDQo+ID4NCj4gPiBJZiB0aGUgVVNCIGFkYXB0b3IgaGFzIHR3byBpbnRlcmZhY2VzLCBp
dCBoYXMgYm90aCBvdGhlcl9pbnRmIGFuZA0KPiA+IHVzYl9nZXRfaW50ZmRhdGEob3RoZXJfaW50
ZiksIHNvIHlvdSB3YW50IHRvIGZyZWUgdGhlbS4gQnV0LCBJIHdvbmRlciBpZiBib3RoDQo+ID4g
aW50ZXJmYWNlcyBjYW4gZW50ZXIgdGhpcyBicmFuY2g/DQo+ID4NCj4gDQo+IFRoZXkgY2FuJ3Qg
Ym90aCBlbnRlciB0aGlzIGJyYW5jaCBiZWNhdXNlIGFmdGVyIHRoZSBmaXJzdA0KPiBkaXNjb25u
ZWN0IHVzYl9nZXRfaW50ZmRhdGEoKSB3aWxsIHJldHVybiBOVUxMLg0KPiANCj4gPiBBbHNvIGFz
IEkgbWVudGlvbmVkIGFib3ZlLCBob3cgY2FuIHlvdSBlbnN1cmUgb3RoZXJfaW50ZiBpc24ndCBz
dGlsbCB1c2luZyB0aGUNCj4gPiBzaGFyZWQgZGF0YT8NCj4gPg0KPiANCj4gSSBjYW4gbWFrZSB0
aGUgc2Vjb25kIGRpc2Nvbm5lY3QgZnJlZSB0aGUgc2hhcmVkIGRhdGEgYnkNCj4gY2hlY2tpbmcg
aWYgdXNiX2dldF9pbnRmZGF0YSgpIHJldHVybnMgTlVMTDoNCj4gDQo+ICAgICAgICAgaWYgKCFv
dGhlcl9pbnRmIHx8ICF1c2JfZ2V0X2ludGZkYXRhKG90aGVyX2ludGYpKSB7DQo+ICAgICAgICAg
ICAgICAgICAvKiBUaGUgb3RoZXIgaW50ZXJmYWNlIGRvZXNuJ3QgZXhpc3Qgb3Igd2FzIGFscmVh
ZHkgZGlzY29ubmVjdGVkLiAqLw0KPiAgICAgICAgICAgICAgICAga2ZyZWUocnRscHJpdi0+Y3Vy
dmVpbmRleF8yZyk7DQoNCldpbGwgdXNiX2dldF9pbnRmZGF0YShvdGhlcl9pbnRmKSByZXR1cm4g
TlVMTCBpZiB0aGUgaW50ZiBkaXNjb25uZWN0ZWQ/IA0KSWYgeWVzLCB0aGF0IGxvb2tzIGdvb2Qg
dG8gbWUuIA0KDQoNCg==

