Return-Path: <linux-wireless+bounces-27975-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F519BDC041
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 03:44:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9860C4E3D35
	for <lists+linux-wireless@lfdr.de>; Wed, 15 Oct 2025 01:44:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A8FFD2868B2;
	Wed, 15 Oct 2025 01:44:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="Kfmyw1UE"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E3227B4EB;
	Wed, 15 Oct 2025 01:44:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760492652; cv=none; b=ctQm54e4Z8io5UQqZXJr61VDMpFWZLB2a5zMlNlJky4v8OUTwtI6j0laHToBbI7RMx3Dr6M0U3pYdNOIqKA8E4Mep4tyig8trFKVNS5wGyptPPNr7veWGQNanZb/ZqCAMff9SG6O6fcY3hcbWk/IJnZal/1bUK5qlhV0f7ZKQ6s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760492652; c=relaxed/simple;
	bh=Qc6owsAF5LCQX5ytZ9DKHOV6L0ImgwjTLFNb+0mBOFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=d1grbEV28fjzQKpbgEsw8Uowvz29FBgkHYdqwy+RIssu5eRswr0r03gSEb2Ns0rpxyQVcACR7NNnMQQ8z2i4ndJgXQkxPpJxP9tpPqgwRZ/na4ttsswXCNJJdGRLUdhYZoDwHLFekik24K4sKSewZ+/ZKsnpe7zc1FVjHYzWoE0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=Kfmyw1UE; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59F1hiltF141860, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1760492624; bh=Qc6owsAF5LCQX5ytZ9DKHOV6L0ImgwjTLFNb+0mBOFQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Kfmyw1UEvmkOdVOmgVzwiMTZdamsolg0RVHq0pQWT4k0s59VtLo6gUy0VvgBA7Obi
	 Y8TFmTiNNXCVM0p92t51klrnKw5DjTgsbXSsYhW+41XL4EZI1I0SaITofqMZUkwufg
	 3CYVGtZm+wlDW0zxMm4/cpjHNHFOhc6gYihz51KyV1B8IBpY8hL3XF5sdRhSb7+buf
	 aYuoSkVd/dO7Yy1gr/olN55jb29b4dvxKPQ3MVTVYMN645L7ipapqCCQqzoQi30LkD
	 tE2D/LWaNWA2bZrrr+zsUmvZUU5tw9kESV2wce2GaPa8wDbAUehYhzwEh1KhwcByLj
	 QiBe0exeL/KOg==
Received: from mail.realtek.com (mail.realtek.com[172.21.6.42])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59F1hiltF141860
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 15 Oct 2025 09:43:44 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Wed, 15 Oct 2025 09:43:43 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Wed, 15 Oct 2025 09:43:43 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Zong-Zhe Yang
	<kevin_yang@realtek.com>,
        Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>
Subject: RE: [PATCH rtw-next v2 6/7] wifi: rtw89: handle IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Thread-Topic: [PATCH rtw-next v2 6/7] wifi: rtw89: handle
 IEEE80211_TX_CTL_REQ_TX_STATUS frames for USB
Thread-Index: AQHcM9kdfiUOXJLj/0mDvzfuYNV6NLS2Ds4ggAuk6gCAAMoPUA==
Date: Wed, 15 Oct 2025 01:43:43 +0000
Message-ID: <bbaaabd1631d43fdaa24b818b7ac7929@realtek.com>
References: <20251002200857.657747-1-pchelkin@ispras.ru>
 <20251002200857.657747-7-pchelkin@ispras.ru>
 <b1725b36caba476ba9ee4916910d8232@realtek.com>
 <20251014234211-4f763e2dab18fe04fbe4d95c-pchelkin@ispras>
In-Reply-To: <20251014234211-4f763e2dab18fe04fbe4d95c-pchelkin@ispras>
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

PiA+ID4gKw0KPiA+ID4gKyAgICAgICAgICAgICAgIGlmIChzd19kZWZpbmUgIT0gc2tiX2RhdGEt
PnR4X3JwdF9zbikNCj4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiA+
ID4gKyAgICAgICAgICAgICAgIGlmICh0eF9zdGF0dXMgIT0gUlRXODlfVFhfRE9ORSAmJg0KPiA+
ID4gKyAgICAgICAgICAgICAgICAgICBkYXRhX3R4Y250ICE9IHNrYl9kYXRhLT50eF9wa3RfY250
X2xtdCkNCj4gPg0KPiA+IEFzIGNvbW1pdCBtZXNzYWdlIG9mIHByZXZpb3VzIHBhdGNoLCAiV2hl
biB0aGVyZSBpcyBhIGZhaWxlZA0KPiA+IFRYIHN0YXR1cyByZXBvcnRlZCBieSB0aGUgZmlybXdh
cmUsIHRoZSByZXBvcnQgaXMgaWdub3JlZCB1bnRpbCB0aGUgbGltaXQNCj4gPiBpcyByZWFjaGVk
IG9yIHN1Y2Nlc3Mgc3RhdHVzIGFwcGVhcnMuIg0KPiA+DQo+ID4gRG8geW91IHN0aWxsIG5lZWQg
dG8gY2hlY2sgZGF0YV90eGNudCBmb3IgZmFpbGVkIGNhc2VzPw0KPiANCj4gVGhlIHF1ZXN0aW9u
IGFsc28gY29uY2VybnMNCj4gDQo+ICAgdHhfcmVxLT5kZXNjX2luZm8udHhfY250X2xtdCA9IDg7
DQo+IA0KPiBsaW5lIGluIHJ0dzg5X3R4X3JwdF9lbmFibGUoKS4gICd0eF9jbnRfbG10JyBpcyB3
cml0dGVuIHRvIFRYIGRlc2NyaXB0b3INCj4gYW5kIHByb2Nlc3NlZCBieSBmaXJtd2FyZS4gIFRo
ZSB2YWx1ZSBkZWZpbmVzIGhvdyBtYW55IHRpbWVzIHRoZSBmaXJtd2FyZQ0KPiB3aWxsIHJldHJ5
IHRyYW5zbWlzc2lvbiBhdHRlbXB0cywgaXQgd2lsbCBub3QgcmV0cnkgbW9yZSB0aW1lcyB0aGFu
IHRoYXQuDQo+IA0KPiAnZGF0YV90eGNudCcgQzJIIGZpZWxkIGRldGVybWluZXMgdGhlIHJldHJ5
IGF0dGVtcHQgY291bnRlciBmb3IgdGhlIGZyYW1lDQo+IHJldHVybmVkIGJ5IHRoZSBmaXJtd2Fy
ZS4gIElmIGl0IHJlYWNoZXMgdGhlIGxpbWl0LCB0aGlzIG1lYW5zIHdlIGdvdA0KPiB0aGUgbGFz
dCByZXBvcnQgZnJvbSB0aGUgZmlybXdhcmUgYW5kIHRoZXJlIHdvdWxkIGJlIG5vIG90aGVyIGZp
cm13YXJlDQo+IHJlcG9ydHMgZm9yIHRoZSBzZW50IGZyYW1lLiAgU28gYSBmaW5hbCB0eF9zdGF0
dXMgc2hvdWxkIGJlIHRha2VuDQo+IHVuY29uZGlvbmFsbHkgaW4gdGhpcyBjYXNlLg0KPiANCj4g
RS5nLiBpZiAndHhfY250X2xtdCcgaXMgc2V0IHRvIDEsIHRoZSBmaXJtd2FyZSB3aWxsIHRyeSBv
bmx5IG9uY2UsDQo+ICdkYXRhX3R4Y250JyB3aWxsIGJlIDEsIHRvby4gIFRoZSBsaW1pdCBpcyBy
ZWFjaGVkIGFuZCB3ZSBzaG91bGQgdGFrZQ0KPiB0eF9zdGF0dXMgaW1tZWRpYXRlbHkgYXMgaXMu
ICBTbyB0aGVyZSdzIGEgaGlnaGVyIGNoYW5jZSBvZiBnZXR0aW5nIGENCj4gZmFpbGVkIHN0YXR1
cyBldmVudHVhbGx5Lg0KPiANCj4gSSBzZXQgaXQgY3VycmVudGx5IHRvIDggYXMgdGhlIHZlbmRv
ciBkcml2ZXIgZG9lcy4gIEluIGxvY2FsIHRlc3RpbmcgaXQNCj4gbG9va3MgbW9yZSB0aGFuIGVu
b3VnaC4gIEkndmUgc2VlbiBtYXhpbXVtIG9mIDUgcmV0cnkgYXR0ZW1wdHMgZm9yIHRoZQ0KPiBz
YW1lIGZyYW1lICh1c3VhbGx5IHRoZXJlIGFyZSBubyByZXRyaWVzIGF0IGFsbCkgdGhvdWdoIG15
IG5ldHdvcmsgcmFkaW8NCj4gZW52aXJvbm1lbnQgaXMgcXVpdGUgbm9pc3kuDQo+IA0KPiBJJ2xs
IGFkZCB0aGUgdHhfY250X2xtdCByZWxhdGVkIGluZm8gdG8gY29tbWl0IG1lc3NhZ2UgZm9yIGNs
YXJpdHkuDQo+IA0KDQpUaGFua3MgZm9yIHRoZSBkZXRhaWwuIA0KDQogICAgMSAyIDMgNCA1IDYg
NyA4DQooYSkgeCB4IHggeCB4IHggeCB4ICA9PT4gcmV0cnkgOCB0aW1lcywgYnV0IGFsbCBmYWls
dXJlLiBSZXBvcnQgYXQgOHRoIEMySC4NCihiKSB4IHggeCBvICAgICAgICAgID09PiByZXRyeSAz
IHRpbWVzLCBhbmQgNHRoIGRvbmUuIFJlcG9ydCBhdCA0dGggQzJILg0KKGMpIG8gICAgICAgICAg
ICAgICAgPT0+IGp1c3QgZG9uZSBhdCBmaXJzdCBvbmUuIFJlcG9ydCBhdCBmaXJzdCBDMkguDQoN
CkZvciBldmVyeSBhdHRlbXB0LCBmaXJtd2FyZSByZXBvcnRzIGEgQzJIIHdpdGggdHhfc3RhdHVz
LCByaWdodD8NCkNhbiBJIHNheSAoYSkgY2FzZSBpcyB3aHkgd2Ugc2hvdWxkIGNoZWNrIGRhdGFf
dHhjbnQ/IA0KRm9yIGNhc2VzIChiKS8oYyksIHRoZXkgcmVseSBvbiAndHhfc3RhdHVzID09IFJU
Vzg5X1RYX0RPTkUnLg0KDQoNCg==

