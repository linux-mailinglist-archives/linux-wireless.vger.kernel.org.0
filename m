Return-Path: <linux-wireless+bounces-27506-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F928B8777F
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 02:28:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 062A05635BC
	for <lists+linux-wireless@lfdr.de>; Fri, 19 Sep 2025 00:28:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 22F7522B8B5;
	Fri, 19 Sep 2025 00:28:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="BD5hhems"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB262227EA8;
	Fri, 19 Sep 2025 00:27:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758241680; cv=none; b=OR0oayK2ezY5C8Q6fZAQ4CH6iYAaigQJqci4DKK6IglqdzysvapKbbPtMLqgEYubhKMjKJYdeNmCs9xfjDRMnKB8+2vAodP5qtevGI5B94sivSdkdRsHYZkRGuOIphM8w+F3+sQyEFFgSiSBunv6M9flErh7rtsU3el79h0vINU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758241680; c=relaxed/simple;
	bh=WW+/egz9vF68C4v2j/ZgH4I4aDqVJ7b2Dy0xwN5debo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fJFT1OlqyUoaVJuplZc78dchyyTDTZVdQQpbVHOXfI5k0YSn+XXce2W68wKH/YgLaL3Iu3vIQWHrSM2anBJan0FZmjSBsWb6iXUJkjePhjHdJ0hSlCc9On6+sg8z9Nm4ua8xdQBr9SkzTIx5cHtebYIGwf5ScZlI6GYpIPcgbqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=BD5hhems; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 58J0RXK202829389, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1758241653; bh=WW+/egz9vF68C4v2j/ZgH4I4aDqVJ7b2Dy0xwN5debo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=BD5hhemsna9cjKhD5bKSPbi4yDcJe0y3RiA7r2Y3poKQhwGTCfwc70yv0+l4hGZxL
	 p3IyNJGiNPvFuUKAmD5s3oPI6UvxauIM/if0CPPhYabZHnZsY5WcI8G7ZxqnW+yPDB
	 cDAox54mDTYuorRJaoFyQ0BJh85YIOqZvU6U1qGY5WCtpGmtwk5K6Mrvao711HSc+e
	 +0A/3tnyY9x1qSyqWsCWgUtTCHml3XFmK+FeFXQd8its0s3KzIXSmTfDp/TujuCLKI
	 s87e+3w6+Dj9Dvwv6fbQ1JYl8hS3aswGEHPzsaV51A/HAPAGSquDj/e5MrzLL4Evdh
	 BMcO1I8DxiZJA==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 58J0RXK202829389
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 19 Sep 2025 08:27:33 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 19 Sep 2025 08:27:33 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::c39a:c87d:b10b:d090%10]) with mapi id
 15.02.1544.027; Fri, 19 Sep 2025 08:27:33 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fedor Pchelkin <pchelkin@ispras.ru>
CC: Zong-Zhe Yang <kevin_yang@realtek.com>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>,
        Bernie Huang <phhuang@realtek.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "lvc-project@linuxtesting.org" <lvc-project@linuxtesting.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH rtw v4 1/4] wifi: rtw89: fix use-after-free in rtw89_core_tx_kick_off_and_wait()
Thread-Topic: [PATCH rtw v4 1/4] wifi: rtw89: fix use-after-free in
 rtw89_core_tx_kick_off_and_wait()
Thread-Index: AQHcJ7j9ihvmCigyUEi4g4qppzNcU7SYSUhg//+OAICAAJEK0IAABBcAgAE8YFA=
Date: Fri, 19 Sep 2025 00:27:33 +0000
Message-ID: <e4153922734d4c8f8b394b3542b9cf58@realtek.com>
References: <20250917095302.2908617-1-pchelkin@ispras.ru>
 <20250917095302.2908617-2-pchelkin@ispras.ru>
 <391e7cc762a549b7826e72090b61ebb2@realtek.com>
 <5d1be8c759c243f9a331c672cc301bbc@realtek.com>
 <8aa1fe0b49dd49408dc26ad48ba9a605@realtek.com>
 <20250918160829-9fbf03ca95d5c4a93143afef-pchelkin@ispras>
In-Reply-To: <20250918160829-9fbf03ca95d5c4a93143afef-pchelkin@ispras>
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

RmVkb3IgUGNoZWxraW4gPHBjaGVsa2luQGlzcHJhcy5ydT4gd3JvdGU6DQo+IE9uIFRodSwgMTgu
IFNlcCAwNToyMywgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IFpvbmctWmhlIFlhbmcgPGtldmlu
X3lhbmdAcmVhbHRlay5jb20+IHdyb3RlOg0KPiA+ID4gUGluZy1LZSBTaGloIDxwa3NoaWhAcmVh
bHRlay5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBGZWRvciBQY2hlbGtpbiA8cGNoZWxr
aW5AaXNwcmFzLnJ1PiB3cm90ZToNCj4gPiA+ID4NCj4gPiA+ID4gWy4uLl0NCj4gPiA+ID4NCj4g
PiA+ID4gPiBAQCAtNjE4MSw2ICs2MTg3LDI3IEBAIHJ0dzg5X2Fzc29jX2xpbmtfcmN1X2RlcmVm
ZXJlbmNlKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldiwNCj4gPiA+ID4gdTggbWFjaWQpDQo+ID4g
PiA+ID4gICAgICAgICBsaXN0X2ZpcnN0X2VudHJ5X29yX251bGwoJnAtPmRsaW5rX3Bvb2wsDQo+
ID4gPiA+ID4gdHlwZW9mKCpwLT5saW5rc19pbnN0KSwgZGxpbmtfc2NoZCk7IFwNCj4gPiA+ID4g
PiAgfSkNCj4gPiA+ID4gPg0KPiA+ID4gPiA+ICtzdGF0aWMgaW5saW5lIHZvaWQgcnR3ODlfdHhf
d2FpdF9yZWxlYXNlKHN0cnVjdCBydHc4OV90eF93YWl0X2luZm8NCj4gPiA+ID4gPiArKndhaXQp
IHsNCj4gPiA+ID4gPiArICAgICAgIGRldl9rZnJlZV9za2JfYW55KHdhaXQtPnNrYik7DQo+ID4g
PiA+ID4gKyAgICAgICBrZnJlZV9yY3Uod2FpdCwgcmN1X2hlYWQpOw0KPiA+ID4gPiA+ICt9DQo+
ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICtzdGF0aWMgaW5saW5lIHZvaWQgcnR3ODlfdHhfd2FpdF9s
aXN0X2NsZWFyKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2RldikNCj4gPiA+ID4gPiArew0KPiA+ID4g
PiA+ICsgICAgICAgc3RydWN0IHJ0dzg5X3R4X3dhaXRfaW5mbyAqd2FpdCwgKnRtcDsNCj4gPiA+
ID4gPiArDQo+ID4gPiA+ID4gKyAgICAgICBsb2NrZGVwX2Fzc2VydF93aXBoeShydHdkZXYtPmh3
LT53aXBoeSk7DQo+ID4gPiA+ID4gKw0KPiA+ID4gPiA+ICsgICAgICAgbGlzdF9mb3JfZWFjaF9l
bnRyeV9zYWZlKHdhaXQsIHRtcCwgJnJ0d2Rldi0+dHhfd2FpdHMsIGxpc3QpIHsNCj4gPiA+ID4g
PiArICAgICAgICAgICAgICAgaWYgKCF3YWl0X2Zvcl9jb21wbGV0aW9uX3RpbWVvdXQoJndhaXQt
PmNvbXBsZXRpb24sDQo+ID4gPiA+ID4gKw0KPiA+ID4gPiBSVFc4OV9UWF9XQUlUX0RFRkFVTFRf
VElNRU9VVCkpDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAgY29udGludWU7DQo+
ID4gPiA+DQo+ID4gPiA+DQo+ID4gPiA+IFdoeSBzaG91bGQgd2Ugd2FpdCAxMG1zPyBKdXN0IHRy
eV93YWl0X2Zvcl9jb21wbGV0aW9uKCk/DQo+ID4gPiA+DQo+ID4gPiA+IFNpbmNlIFRYIGNvbXBs
ZXRpb24gbWlnaHQgYmUgbWlzc2luZyAocnR3ODlfY29yZV9zdG9wKCksIGZvciBleGFtcGxlKSwg
c2hvdWxkbid0IHdlDQo+ID4gPiA+IHVuY29uZGl0aW9uYWxseSBmcmVlIGFsbCBpbiB3YWl0IGxp
c3QgZm9yIHRoYXQgY2FzZT8NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBJbiBoY2kgcmVzZXQgKHdo
ZW4gd2UgcmVsZWFzZSBwZW5kaW5nIHNrYiksIHRoZSBjb25kaXRpb24gd2lsbCBiZWNvbWUgdHJ1
ZS4NCj4gPiA+IFNvLCBhbGwgbGVmdCB3aWxsIGJlIGZyZWVkIGF0IHRoYXQgdGltZS4gQmVmb3Jl
IHRoYXQsIHRoZXJlIGlzIG5vIGxvZ2ljIHRvIGVuc3VyZSBubw0KPiA+ID4gbW9yZSBjb21wbGV0
aW5nIHNpZGUsIHNvIGl0IGNhbm5vdCBiZSB1bmNvbmRpdGlvbmFsbHkgZnJlZWQgdW5sZXNzIHdl
IGRvbid0DQo+ID4gPiB3YW50IHRvIGRvdWJsZSBjaGVjayBpZiB0aG9zZSwgd2hpY2ggdGltZWQg
b3V0LCBhcmUgZG9uZSBhdCBzb21lIG1vbWVudC4NCj4gPiA+DQo+ID4gPiAoZS5nLiBjb3JlIHN0
b3Agd2lsbCBkbyBoY2kgcmVzZXQpDQo+ID4NCj4gPiBUaGFua3MgZm9yIHRoZSBleHBsYW5hdGlv
bi4NCj4gPg0KPiA+IEp1c3QgY29uc2lkZXIgdHJ5X3dhaXRfZm9yX2NvbXBsZXRpb24oKSB0aGVu
Lg0KPiANCj4gT0suICBjb21wbGV0aW9uX2RvbmUoKSBsb29rcyBhcHByb3ByaWF0ZSBoZXJlIGFz
IHdlbGwuDQo+IA0KPiA+DQo+ID4gQnkgdGhlIHdheSwgaWYgd2FudCBhIGRlbGF5IGZvciB0aW1l
b3V0IGNhc2UsIHVzZSBkZWxheWVkIHdvcmsgZm9yIHR4X3dhaXRfd29yaw0KPiA+IGluc3RlYWQu
DQo+IA0KPiBUaGF0IG1ha2VzIHNlbnNlLCB0aGFua3MuICBTbyB0aGUgbmV4dCB0aW1lIEknbGwg
Z28gd2l0aCBkZWxheWVkDQo+IHR4X3dhaXRfd29yayBwZXJmb3JtaW5nIGNvbXBsZXRpb25fZG9u
ZSgpOiB3b3JrIGRlbGF5IDUwMCBtcywgbG9va3MNCj4gbmVpdGhlciB0b28gc21hbGwgbm9yIHRv
byBiaWcgZm9yIGZyZWVpbmcgcG90ZW50aWFsbHkgdGltZWQgb3V0IGl0ZW1zLg0KDQpCb3RoIGxv
b2sgcmVhc29uYWJsZSB0byBtZS4gDQoNCg==

