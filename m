Return-Path: <linux-wireless+bounces-27993-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 44C6ABE1248
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Oct 2025 02:54:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id F339F3BCB6E
	for <lists+linux-wireless@lfdr.de>; Thu, 16 Oct 2025 00:54:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 47E291C7012;
	Thu, 16 Oct 2025 00:54:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="HncOOCvO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E34F81311AC;
	Thu, 16 Oct 2025 00:54:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760576080; cv=none; b=Umk3AZcO89btW3r09Wfw139Np2lmVnq8jL0nmLXXp6dOTd7XEYUHhuuxrGo15ARCs7dnClimQMXmAYVYs65RX207ZU+OI9HT5XJ61KjXfMF/Dj9b3wmABlBRcc5QK8gkMn7LopCWSdV7707m9YkGAw158UgOtjeuke5p/voVCdQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760576080; c=relaxed/simple;
	bh=S8v4Y8Pc7brp923e59wokMQk/3V9RcozT8lbAAA4+tw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uApzHhgi7ZmZ4BaxoafF68XrXWqN5rH6RL3jwPweDvJOHOlazRBj7vork+x98lYZikyKAYdxqZkfuWig5I22UTyz/OmIy5WMir7hYJKVMPtAMOnIcWRiepAPKrg86Jd7PJCBI0MV77SAjkO/LziFywtIC6dIUOTow1ZgLwsAkXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=HncOOCvO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 59G0sB3Q11839849, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1760576051; bh=S8v4Y8Pc7brp923e59wokMQk/3V9RcozT8lbAAA4+tw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=HncOOCvOQRmw7EK4x1wESrFbxIpRKy9NWwqw0jtNwPhhVpvav+35+vYilHXb1k9t+
	 Y1/JG0a9peAHIc6r2NFJXKwaVztfCEIsoxpVDq4VTyzs62DROJU/8xleo9jdgfs9Ny
	 /8tcnUYFDmrqOlvBIY0jtwh9GiU6hxMYbcElO4iz+xy3Y3He/o57AccYsvpnd0uQB7
	 HKJxjWwJyJ7fneNJrgFhYY01ekFpBCVg+4Utnp2S6o4rXcCiWXx+iLvsKrs6dgq5eJ
	 ftp1jD5iISOoqzoBxOO0m3lDJiQK2aYVSdh8SJXIEspntEWSw5m3JpWwy8y0FFm69k
	 3Dsp4ycAnUnrw==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 59G0sB3Q11839849
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 16 Oct 2025 08:54:11 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 16 Oct 2025 08:54:12 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Thu, 16 Oct 2025 08:54:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Thu, 16 Oct 2025 08:54:11 +0800
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
Thread-Index: AQHcM9kdfiUOXJLj/0mDvzfuYNV6NLS2Ds4ggAuk6gCAAMoPUP//5WiAgAGi3dA=
Date: Thu, 16 Oct 2025 00:54:11 +0000
Message-ID: <164d3319d29e4a9aa3658726ee098092@realtek.com>
References: <20251002200857.657747-1-pchelkin@ispras.ru>
 <20251002200857.657747-7-pchelkin@ispras.ru>
 <b1725b36caba476ba9ee4916910d8232@realtek.com>
 <20251014234211-4f763e2dab18fe04fbe4d95c-pchelkin@ispras>
 <bbaaabd1631d43fdaa24b818b7ac7929@realtek.com>
 <20251015103403-08f19f981c70546d56ebd07a-pchelkin@ispras>
In-Reply-To: <20251015103403-08f19f981c70546d56ebd07a-pchelkin@ispras>
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

RmVkb3IgUGNoZWxraW4gPHBjaGVsa2luQGlzcHJhcy5ydT4gd3JvdGU6DQo+IE9uIFdlZCwgMTUu
IE9jdCAwMTo0MywgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiAr
ICAgICAgICAgICAgICAgaWYgKHN3X2RlZmluZSAhPSBza2JfZGF0YS0+dHhfcnB0X3NuKQ0KPiA+
ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICAgIGNvbnRpbnVlOw0KPiA+ID4gPiA+ICsgICAg
ICAgICAgICAgICBpZiAodHhfc3RhdHVzICE9IFJUVzg5X1RYX0RPTkUgJiYNCj4gPiA+ID4gPiAr
ICAgICAgICAgICAgICAgICAgIGRhdGFfdHhjbnQgIT0gc2tiX2RhdGEtPnR4X3BrdF9jbnRfbG10
KQ0KPiA+ID4gPg0KPiA+ID4gPiBBcyBjb21taXQgbWVzc2FnZSBvZiBwcmV2aW91cyBwYXRjaCwg
IldoZW4gdGhlcmUgaXMgYSBmYWlsZWQNCj4gPiA+ID4gVFggc3RhdHVzIHJlcG9ydGVkIGJ5IHRo
ZSBmaXJtd2FyZSwgdGhlIHJlcG9ydCBpcyBpZ25vcmVkIHVudGlsIHRoZSBsaW1pdA0KPiA+ID4g
PiBpcyByZWFjaGVkIG9yIHN1Y2Nlc3Mgc3RhdHVzIGFwcGVhcnMuIg0KPiA+ID4gPg0KPiA+ID4g
PiBEbyB5b3Ugc3RpbGwgbmVlZCB0byBjaGVjayBkYXRhX3R4Y250IGZvciBmYWlsZWQgY2FzZXM/
DQo+ID4gPg0KPiA+ID4gVGhlIHF1ZXN0aW9uIGFsc28gY29uY2VybnMNCj4gPiA+DQo+ID4gPiAg
IHR4X3JlcS0+ZGVzY19pbmZvLnR4X2NudF9sbXQgPSA4Ow0KPiA+ID4NCj4gPiA+IGxpbmUgaW4g
cnR3ODlfdHhfcnB0X2VuYWJsZSgpLiAgJ3R4X2NudF9sbXQnIGlzIHdyaXR0ZW4gdG8gVFggZGVz
Y3JpcHRvcg0KPiA+ID4gYW5kIHByb2Nlc3NlZCBieSBmaXJtd2FyZS4gIFRoZSB2YWx1ZSBkZWZp
bmVzIGhvdyBtYW55IHRpbWVzIHRoZSBmaXJtd2FyZQ0KPiA+ID4gd2lsbCByZXRyeSB0cmFuc21p
c3Npb24gYXR0ZW1wdHMsIGl0IHdpbGwgbm90IHJldHJ5IG1vcmUgdGltZXMgdGhhbiB0aGF0Lg0K
PiA+ID4NCj4gPiA+ICdkYXRhX3R4Y250JyBDMkggZmllbGQgZGV0ZXJtaW5lcyB0aGUgcmV0cnkg
YXR0ZW1wdCBjb3VudGVyIGZvciB0aGUgZnJhbWUNCj4gPiA+IHJldHVybmVkIGJ5IHRoZSBmaXJt
d2FyZS4gIElmIGl0IHJlYWNoZXMgdGhlIGxpbWl0LCB0aGlzIG1lYW5zIHdlIGdvdA0KPiA+ID4g
dGhlIGxhc3QgcmVwb3J0IGZyb20gdGhlIGZpcm13YXJlIGFuZCB0aGVyZSB3b3VsZCBiZSBubyBv
dGhlciBmaXJtd2FyZQ0KPiA+ID4gcmVwb3J0cyBmb3IgdGhlIHNlbnQgZnJhbWUuICBTbyBhIGZp
bmFsIHR4X3N0YXR1cyBzaG91bGQgYmUgdGFrZW4NCj4gPiA+IHVuY29uZGlvbmFsbHkgaW4gdGhp
cyBjYXNlLg0KPiA+ID4NCj4gPiA+IEUuZy4gaWYgJ3R4X2NudF9sbXQnIGlzIHNldCB0byAxLCB0
aGUgZmlybXdhcmUgd2lsbCB0cnkgb25seSBvbmNlLA0KPiA+ID4gJ2RhdGFfdHhjbnQnIHdpbGwg
YmUgMSwgdG9vLiAgVGhlIGxpbWl0IGlzIHJlYWNoZWQgYW5kIHdlIHNob3VsZCB0YWtlDQo+ID4g
PiB0eF9zdGF0dXMgaW1tZWRpYXRlbHkgYXMgaXMuICBTbyB0aGVyZSdzIGEgaGlnaGVyIGNoYW5j
ZSBvZiBnZXR0aW5nIGENCj4gPiA+IGZhaWxlZCBzdGF0dXMgZXZlbnR1YWxseS4NCj4gPiA+DQo+
ID4gPiBJIHNldCBpdCBjdXJyZW50bHkgdG8gOCBhcyB0aGUgdmVuZG9yIGRyaXZlciBkb2VzLiAg
SW4gbG9jYWwgdGVzdGluZyBpdA0KPiA+ID4gbG9va3MgbW9yZSB0aGFuIGVub3VnaC4gIEkndmUg
c2VlbiBtYXhpbXVtIG9mIDUgcmV0cnkgYXR0ZW1wdHMgZm9yIHRoZQ0KPiA+ID4gc2FtZSBmcmFt
ZSAodXN1YWxseSB0aGVyZSBhcmUgbm8gcmV0cmllcyBhdCBhbGwpIHRob3VnaCBteSBuZXR3b3Jr
IHJhZGlvDQo+ID4gPiBlbnZpcm9ubWVudCBpcyBxdWl0ZSBub2lzeS4NCj4gPiA+DQo+ID4gPiBJ
J2xsIGFkZCB0aGUgdHhfY250X2xtdCByZWxhdGVkIGluZm8gdG8gY29tbWl0IG1lc3NhZ2UgZm9y
IGNsYXJpdHkuDQo+ID4gPg0KPiA+DQo+ID4gVGhhbmtzIGZvciB0aGUgZGV0YWlsLg0KPiA+DQo+
ID4gICAgIDEgMiAzIDQgNSA2IDcgOA0KPiA+IChhKSB4IHggeCB4IHggeCB4IHggID09PiByZXRy
eSA4IHRpbWVzLCBidXQgYWxsIGZhaWx1cmUuIFJlcG9ydCBhdCA4dGggQzJILg0KPiA+IChiKSB4
IHggeCBvICAgICAgICAgID09PiByZXRyeSAzIHRpbWVzLCBhbmQgNHRoIGRvbmUuIFJlcG9ydCBh
dCA0dGggQzJILg0KPiA+IChjKSBvICAgICAgICAgICAgICAgID09PiBqdXN0IGRvbmUgYXQgZmly
c3Qgb25lLiBSZXBvcnQgYXQgZmlyc3QgQzJILg0KPiA+DQo+ID4gRm9yIGV2ZXJ5IGF0dGVtcHQs
IGZpcm13YXJlIHJlcG9ydHMgYSBDMkggd2l0aCB0eF9zdGF0dXMsIHJpZ2h0Pw0KPiANCj4gWWVz
Lg0KPiANCj4gPiBDYW4gSSBzYXkgKGEpIGNhc2UgaXMgd2h5IHdlIHNob3VsZCBjaGVjayBkYXRh
X3R4Y250Pw0KPiA+IEZvciBjYXNlcyAoYikvKGMpLCB0aGV5IHJlbHkgb24gJ3R4X3N0YXR1cyA9
PSBSVFc4OV9UWF9ET05FJy4NCj4gDQo+IFdlIHNob3VsZCBzb21laG93IGRldGVybWluZSBpbiBj
YXNlIChhKSB3aGVuIHRob3NlIDggYXR0ZW1wdHMgZm9yIHRoZQ0KPiBmcmFtZSBoYXZlIHBhc3Nl
ZCBhbmQgdGhlbiBwcm9tcHRseSBnaXZlIHRoZSByZXBvcnQgd2l0aCBhIGZhaWxlZCBzdGF0dXMN
Cj4gdXAgdG8gdGhlIHdpcmVsZXNzIHN0YWNrLiAgVG8gbXkgbWluZCwgd2l0aG91dCBjaGVja2lu
ZyBkYXRhX3R4Y250DQo+IHJ0dzg5X21hY19jMmhfdHhfcnB0KCkgY2FuJ3QgZGV0ZXJtaW5lIHRo
ZSB0aW1lIHdoZW4gdG8gZG8gYW4gYWN0dWFsDQo+IHJlcG9ydCBpZiBldmVyeSByZXRyeSBhdHRl
bXB0IGhhcyBmYWlsZWQuDQo+IA0KPiBPdGhlcndpc2Ugc2tiIHdvdWxkIHJlbWFpbiBpbiB0aGUg
cXVldWUgYmVpbmcgdW5yZXBvcnRlZCB1bnRpbCBIQ0kgcmVzZXQNCj4gdGFrZXMgcGxhY2UsIHRo
b3VnaCB3ZSBhbHJlYWR5IGhhZCBhIGNoYW5jZSB0byByZXBvcnQgaXQgYXMgZmFpbGVkLg0KDQpH
b3QgaXQuDQoNCkJ5IHRoZSB3YXksIEknZCBsaXN0IGNhc2UgKGQpIHdoaWNoIFRYIGRvbmUgYXQg
OHRoIHJldHJ5IGFuZCBjYW4gYmUgaGFuZGxlZA0KcHJvcGVybHkgYXMgd2VsbC4gDQoNCiAgICAx
IDIgMyA0IDUgNiA3IDgNCihkKSB4IHggeCB4IHggeCB4IG8gID09PiByZXRyeSA4IHRpbWVzLCBh
bmQgZmluYWxseSBkb25lLiBSZXBvcnQgYXQgOHRoIEMySC4NCg0K

