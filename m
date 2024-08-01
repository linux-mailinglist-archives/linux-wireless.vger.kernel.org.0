Return-Path: <linux-wireless+bounces-10802-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 005C594416B
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 04:50:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6B641B2AFCC
	for <lists+linux-wireless@lfdr.de>; Thu,  1 Aug 2024 02:23:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 073CA1422B4;
	Thu,  1 Aug 2024 02:05:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="k3/L0WDp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F4B5139E
	for <linux-wireless@vger.kernel.org>; Thu,  1 Aug 2024 02:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722477950; cv=none; b=tisNceyv7NNTW4vv6GZeX6SbisxhUGecm7xg87R0tWTJTSEPocunBC+pqSiIRIjoHz6KsLGNadqGrNnByOztnWuxQD2L9RvTtfhIil+OQR9KowNiMkf4zmhS/9nRKLtVI1L/87YF1DMFnN3MogkpYwbMYG+Px36caYcj/7v+CBE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722477950; c=relaxed/simple;
	bh=UBfRJSIjAeqvLQpAUXY2/nYWkv4u/LuEg5/xTeoPsAs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lGplC5pcIpWnhiJnf/QlbvJ5xDd6EJMj7pweedfgj8tmxJDDSIlnt/Gk7oXZR+CaN4ybIX+q+LwIE6eyQEpZoWCPCauJo3kP+Vf7tb29A6m2ZKhZILdB2JNkD6iRbv6c/JP/lS3RQ9DGxuT8tvhWEArG47wFoB4aHcIWDN0y990=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=k3/L0WDp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47125ZgJ43088533, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722477935; bh=UBfRJSIjAeqvLQpAUXY2/nYWkv4u/LuEg5/xTeoPsAs=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=k3/L0WDp1t3MQCTi49ymUGcxvNJGmKl04fN5ZO5Y9qu1flYbVLw2zx3ZVCq9Idpmr
	 JlI0KD2sxlz76cVT4D5iFO+0wjrd0gqiECxrTmS+9TyUu1uEww9lsLPX9UFmjw/gZb
	 voHmJmdJCqNsMv/ZjEaCcofW/BI3XN8ItrjWk+Isc3k4ZAJxBR9x0oojIXrLa5tzTn
	 lka6/3NbmFgBVIeaD/yZrDgEUIte8vbI2MMeOp4pvT9iVSm/6/n/QqloPNkMf5hnrx
	 lw2UkfL79A+Pys6bx9p8AqGIIwp2+puwLhCPinklDLBucF4Al6A2typS0R7+nL9jpl
	 uOseSvbun/3qw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47125ZgJ43088533
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Aug 2024 10:05:35 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 1 Aug 2024 10:05:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 1 Aug 2024 10:05:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Thu, 1 Aug 2024 10:05:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH 1/4] wifi: rtw88: Init RX burst length for 8822cu/8822bu/8821cu
Thread-Topic: [PATCH 1/4] wifi: rtw88: Init RX burst length for
 8822cu/8822bu/8821cu
Thread-Index: AQHa4SXtM9kPnRDVBEWoRbyp7auc17IOpEoAgAHo5YCAAR07EA==
Date: Thu, 1 Aug 2024 02:05:34 +0000
Message-ID: <c9b09d9abf06404a89ebbaebef58c541@realtek.com>
References: <c03390ce-34c2-42dd-9bd6-b231bb1f2fae@gmail.com>
 <4a8ac99c87214b4c92dde42e26006964@realtek.com>
 <152dece9-f328-4ad4-95df-5eeae85f6056@gmail.com>
In-Reply-To: <152dece9-f328-4ad4-95df-5eeae85f6056@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAz
MC8wNy8yMDI0IDA2OjU3LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBJbml0IFJYIGJ1cnN0IGxl
bmd0aCBhY2NvcmRpbmcgdG8gdGhlIFVTQiBzcGVlZC4NCj4gPj4NCj4gPj4gVGhpcyBpcyBuZWVk
ZWQgaW4gb3JkZXIgdG8gbWFrZSBVU0IgUlggYWdncmVnYXRpb24gd29yay4NCj4gPj4NCj4gPj4g
VGVzdGVkIHdpdGggUlRMODgxMUNVLg0KPiA+DQo+ID4gSGF2aW5nIGEgdGhyb3VnaHB1dCBhZnRl
ciB0aGlzIGNoYW5nZSB3b3VsZCBiZSBiZXR0ZXIuDQo+ID4NCj4gPj4NCj4gPj4gU2lnbmVkLW9m
Zi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+ID4+IC0t
LQ0KPiA+PiBJIHdvdWxkIG1lbnRpb24gaW4gdGhlIGNvbW1pdCBtZXNzYWdlIHdoYXQgQklUX0RN
QV9CVVJTVF9DTlQsDQo+ID4+IEJJVF9ETUFfTU9ERSwgYW5kIEJJVF9EUk9QX0RBVEFfRU4gYXJl
IGRvaW5nLCBidXQgSSBkb24ndCBrbm93Lg0KPiA+DQo+ID4gVGhhdCB3aWxsIGJlIGhlbHBmdWwg
dG8gb3RoZXIgZGV2ZWxvcGVycy4gUGxlYXNlIHB1dCB0aGVtIGluIHNlY29uZCBwYXJhZ3JhcGgu
DQo+ID4NCj4gPiBbLi4uXQ0KPiA+DQo+ID4+ICtzdGF0aWMgdm9pZCBydHc4ODIxY3VfaW5pdF9i
dXJzdF9wa3RfbGVuKHN0cnVjdCBydHdfZGV2ICpydHdkZXYpDQo+ID4+ICt7DQo+ID4+ICsgICAg
ICAgdTggcnhkbWEsIGJ1cnN0X3NpemU7DQo+ID4+ICsNCj4gPj4gKyAgICAgICByeGRtYSA9IEJJ
VF9ETUFfQlVSU1RfQ05UIHwgQklUX0RNQV9NT0RFOw0KPiA+PiArDQo+ID4+ICsgICAgICAgaWYg
KHJ0d19yZWFkOChydHdkZXYsIFJFR19TWVNfQ0ZHMiArIDMpID09IDB4MjApDQo+ID4+ICsgICAg
ICAgICAgICAgICBidXJzdF9zaXplID0gQklUX0RNQV9CVVJTVF9TSVpFXzEwMjQ7DQo+ID4+ICsg
ICAgICAgZWxzZSBpZiAoKHJ0d19yZWFkOChydHdkZXYsIFJFR19VU0JfVVNCU1RBVCkgJiAweDMp
ID09IDB4MSkNCj4gPj4gKyAgICAgICAgICAgICAgIGJ1cnN0X3NpemUgPSBCSVRfRE1BX0JVUlNU
X1NJWkVfNTEyOw0KPiA+PiArICAgICAgIGVsc2UNCj4gPj4gKyAgICAgICAgICAgICAgIGJ1cnN0
X3NpemUgPSBCSVRfRE1BX0JVUlNUX1NJWkVfNjQ7DQo+ID4+ICsNCj4gPj4gKyAgICAgICB1OHBf
cmVwbGFjZV9iaXRzKCZyeGRtYSwgYnVyc3Rfc2l6ZSwgQklUX0RNQV9CVVJTVF9TSVpFKTsNCj4g
Pj4gKw0KPiA+PiArICAgICAgIHJ0d193cml0ZTgocnR3ZGV2LCBSRUdfUlhETUFfTU9ERSwgcnhk
bWEpOw0KPiA+PiArICAgICAgIHJ0d193cml0ZTE2X3NldChydHdkZXYsIFJFR19UWERNQV9PRkZT
RVRfQ0hLLCBCSVRfRFJPUF9EQVRBX0VOKTsNCj4gPj4gK30NCj4gPj4gKw0KPiA+DQo+ID4gQWxs
IHVzZSB0aGUgc2FtZSBzZXR1cC4NCj4gPiBDYW4gd2UgbW92ZSBpdCB0byB1c2IuYz8gTWF5YmUg
cnR3X3VzYl9pbnRlcmZhY2VfY2ZnKCkgaXMgYSBnb29kIHBsYWNlPw0KPiA+IChzdGlsbCBleGNs
dWRlIHVudGVzdGVkIGNoaXBzLikNCj4gPg0KPiANCj4gcnR3X3VzYl9pbnRlcmZhY2VfY2ZnKCkg
aXMgYSBnb29kIHBsYWNlLiBJIHdpbGwgbW92ZSBpdCB0aGVyZS4NCj4gVGhlIG90aGVyIGNoaXBz
IHdpbGwgY29tcGxpY2F0ZSBpdCBhIGJpdCwgYnV0IHRoYXQncyBva2F5Lg0KDQpNYXliZSB3ZSBj
YW4gaGF2ZSBpbml0X2J1cnN0X3BrdF9sZW5fe3YxLCB2MiwgdjMsIC4uLn0sIGJ1dC4uLg0KDQo+
IA0KPiBJIGRvbid0IHVuZGVyc3RhbmQgd2h5IHdlIGNhbid0IGp1c3QgY2hlY2sgcnR3dXNiLT51
ZGV2LT5zcGVlZA0KPiBpbnN0ZWFkIG9mIHJlYWRpbmcgdmFyaW91cyByZWdpc3RlcnMuIFRoZW4g
dGhleSBjb3VsZCBhbGwgdXNlDQo+IHRoZSBzYW1lIGNvZGUuDQoNCkl0IHNlZW1zIHRvIGJlIGJl
dHRlciB0byBqdXN0IHVzZSBydHd1c2ItPnVkZXYtPnNwZWVkLiANCkkgYXNrIFVTQiB0ZWFtIGJ1
dCBubyBjbGVhciBhbnN3ZXIsIGJ1dCB0aGV5IHByZWZlciBydHd1c2ItPnVkZXYtPnNwZWVkIGFz
IHdlbGwuDQoNCj4gDQo+IChCeSB0aGUgd2F5LCBSVEw4ODIxQVUvUlRMODgxMkFVIGlzIHJlYWR5
IG5vdy4gSSB3aWxsIHNlbmQNCj4gdGhlIHBhdGNoZXMgYWZ0ZXIgdGhpcyBwYXRjaCBzZXQgaXMg
c29ydGVkIG91dC4gVGhlcmUgYXJlIGFib3V0DQo+IDE2IHNtYWxsZXIgcGF0Y2hlcyB0byBwcmVw
YXJlIHRoaW5ncywgYW5kIHRoZW4gdGhlIG5ldyBkcml2ZXIuKQ0KDQpOaWNlIHdvcmshIA0KDQo=

