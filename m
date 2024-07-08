Return-Path: <linux-wireless+bounces-10067-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60953929EEB
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 11:19:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9184E1C22970
	for <lists+linux-wireless@lfdr.de>; Mon,  8 Jul 2024 09:19:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56325466B;
	Mon,  8 Jul 2024 09:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GK/+TdM4"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4363455E53
	for <linux-wireless@vger.kernel.org>; Mon,  8 Jul 2024 09:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720430365; cv=none; b=DOOEdyaRzMQZiTP11lDB74OnFY4FCdgeFe2n/YevNkWOZ8cELtN4DTzp5FgGVnF2rCrxe+p3FpS3sHTruD37Xh7Ux9Dw5As+I+yLSoIMynguLA2Y8L6QCmKvI9/alW4jhHixYkQBEOH6JP7yGIxu8Fut4eqz5NvoSBL4V78kHuo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720430365; c=relaxed/simple;
	bh=EY4urxilvNPYvYL63C0Zt+V6zuEk6pq9k9gTcU3gkPQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LsiJdlROG/XDXPNOryVhFwFnAUYkycXX/VNppkpsRFzlffePEnDl+XOUEgkOJxZgGaYBeOESTSomfyBo+5RGayJ14B3GmXPcxWnFnWsKrofHDKLhgQo59cX4faaX+UBQI2sQtX/YTMfr/qpXHO2YT53ZUsHs2CfZgy3w+RtN5qc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GK/+TdM4; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4689J56Y03507554, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720430345; bh=EY4urxilvNPYvYL63C0Zt+V6zuEk6pq9k9gTcU3gkPQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GK/+TdM4xm6hjZ1AMOWVa69+YLsD7LnQjxrfzF33D8wav6A7PxVkoPccmeZUTzM0Q
	 WWFy5e0yvGqjzSKXBaVR8AinFx+kYll8W2hKQgZuxTTX6nN59g6F7ogHtUXE4mrrL3
	 Zo6tE/dajweTOzUIDFYI8ou9iq8rqx2JBxOY/j00VsdBv5XjVCFKaxr9mprLUO9DB2
	 KGRI5cELaaBZLfe44bnDCY0TDdSM3nlX0SE3bknU/cbcktShRUY6Otx/h0kMjCUqnC
	 RgfyfsBmKVuHWupyr8CVlDuNq+wpSuXY8jmc2qk4/SzLwZG2bzV6RoSNNZYGUub1un
	 3dQao9cQ/H40w==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4689J56Y03507554
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 8 Jul 2024 17:19:05 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 8 Jul 2024 17:19:06 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 8 Jul 2024 17:19:05 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 8 Jul 2024 17:19:05 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Kalle Valo <kvalo@kernel.org>
Subject: RE: [PATCH] wifi: rtw88: usb: Support USB 3 with RTL8822CU/RTL8822BU
Thread-Topic: [PATCH] wifi: rtw88: usb: Support USB 3 with RTL8822CU/RTL8822BU
Thread-Index: AQHazyw5zmbg866JN0qvS/PnzliO+bHsjRUA
Date: Mon, 8 Jul 2024 09:19:05 +0000
Message-ID: <a60a7a6d0ab04b3ab1690a2c473b8e69@realtek.com>
References: <2378105e-041a-4973-937f-e3efdc9ce0e8@gmail.com>
In-Reply-To: <2378105e-041a-4973-937f-e3efdc9ce0e8@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGUg
UmVhbHRlayB3aWZpIDUgZGV2aWNlcyB3aGljaCBzdXBwb3J0IFVTQiAzIGFyZSB3ZWlyZDogd2hl
biBmaXJzdA0KPiBwbHVnZ2VkIGluLCB0aGV5IHByZXRlbmQgdG8gYmUgVVNCIDIuIFRoZSBkcml2
ZXIgbmVlZHMgdG8gc2VuZCBzb21lDQo+IGNvbW1hbmRzIHRvIHRoZSBkZXZpY2UsIHdoaWNoIG1h
a2UgaXQgZGlzYXBwZWFyIGFuZCBjb21lIGJhY2sgYXMgYQ0KPiBVU0IgMyBkZXZpY2UuDQo+IA0K
PiBJbXBsZW1lbnQgdGhlIHJlcXVpcmVkIGNvbW1hbmRzIGluIHJ0dzg4Lg0KPiANCj4gV2hlbiBh
IFVTQiAzIGRldmljZSBpcyBwbHVnZ2VkIGludG8gYSBVU0IgMiBwb3J0LCBydHc4OCB3aWxsIHRy
eSB0bw0KPiBzd2l0Y2ggaXQgdG8gVVNCIDMgbW9kZSBvbmx5IG9uY2UuIFRoZSBkZXZpY2Ugd2ls
bCBkaXNhcHBlYXIgYW5kIGNvbWUNCj4gYmFjayBzdGlsbCBpbiBVU0IgMiBtb2RlLCBvZiBjb3Vy
c2UuDQo+IA0KPiBTb21lIHBlb3BsZSBleHBlcmllbmNlIGhlYXZ5IGludGVyZmVyZW5jZSBpbiB0
aGUgMi40IEdIeiBiYW5kIGluDQo+IFVTQiAzIG1vZGUsIHNvIGFkZCBhIG1vZHVsZSBwYXJhbWV0
ZXIgc3dpdGNoX3VzYl9tb2RlIHdpdGggdGhlDQo+IGRlZmF1bHQgdmFsdWUgMSB0byBsZXQgcGVv
cGxlIGRpc2FibGUgdGhlIHN3aXRjaGluZy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJs
dWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiAtLS0NCj4gQSBsYXRlciBwYXRj
aCB3aWxsIGFkZCB0aGUgZnVuY3Rpb24gcnR3X3VzYl9zd2l0Y2hfbW9kZV9vbGQoKSBmb3IgdGhl
DQo+IG9sZGVyIGNoaXBzIFJUTDg4MTJBVSBhbmQgUlRMODgxNEFVLg0KDQpbLi4uXQ0KDQo+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3VzYi5jIGIvZHJp
dmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC91c2IuYw0KPiBpbmRleCBhNTVjYTVhMjQy
MjcuLmE1OWU1MmEwZGExMCAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydHc4OC91c2IuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0
dzg4L3VzYi5jDQo+IEBAIC0xNCw2ICsxNCwxMSBAQA0KPiAgI2luY2x1ZGUgInBzLmgiDQo+ICAj
aW5jbHVkZSAidXNiLmgiDQo+IA0KPiArc3RhdGljIGJvb2wgcnR3X3N3aXRjaF91c2JfbW9kZSA9
IHRydWU7DQo+ICttb2R1bGVfcGFyYW1fbmFtZWQoc3dpdGNoX3VzYl9tb2RlLCBydHdfc3dpdGNo
X3VzYl9tb2RlLCBib29sLCAwNjQ0KTsNCj4gK01PRFVMRV9QQVJNX0RFU0Moc3dpdGNoX3VzYl9t
b2RlLA0KPiArICAgICAgICAgICAgICAgICJTZXQgdG8gWSB0byBzd2l0Y2ggdG8gVVNCIDMgbW9k
ZSAoZGVmYXVsdDogWSkiKTsNCj4gKw0KDQpJIGZlZWwgd2Ugc2hvdWxkIHNheSAiU2V0IHRvIE4g
dG8gZGlzYWJsZSBzd2l0Y2hpbmcgVVNCIDMgbW9kZSB0byBhdm9pZA0KcG90ZW50aWFsIGludGVy
ZmVyZW5jZSBpbiB0aGUgMi40IEdIeiIgbGlrZSB5b3VyIGNvbW1pdCBtZXNzYWdlLiBUaGF0IGNv
dWxkDQpiZSBoZWxwZnVsIHRvIHVzZXJzLg0KDQo+ICAjZGVmaW5lIFJUV19VU0JfTUFYX1JYUV9M
RU4gICAgNTEyDQo+IA0KPiAgc3RydWN0IHJ0d191c2JfdHhjYiB7DQoNClsuLi5dDQoNCj4gQEAg
LTg5Niw2ICs5NzIsMTQgQEAgaW50IHJ0d191c2JfcHJvYmUoc3RydWN0IHVzYl9pbnRlcmZhY2Ug
KmludGYsIGNvbnN0IHN0cnVjdCB1c2JfZGV2aWNlX2lkICppZCkNCj4gICAgICAgICAgICAgICAg
IGdvdG8gZXJyX2Rlc3Ryb3lfcnh3cTsNCj4gICAgICAgICB9DQo+IA0KPiArICAgICAgIHJldCA9
IHJ0d191c2Jfc3dpdGNoX21vZGUocnR3ZGV2KTsNCj4gKyAgICAgICBpZiAocmV0KSB7DQo+ICsg
ICAgICAgICAgICAgICAvKiBOb3QgYSBmYWlsLCBidXQgd2UgZG8gbmVlZCB0byBza2lwIHJ0d19y
ZWdpc3Rlcl9ody4gKi8NCj4gKyAgICAgICAgICAgICAgIHJ0d19pbmZvKHJ0d2RldiwgInN3aXRj
aGluZyB0byBVU0IgMyBtb2RlXG4iKTsNCg0KQWxsIGxvZ3MgaW4gdGhpcyBwYXRjaGVzIHNob3Vs
ZCBiZSBydHdfZGJnKCksIGJlY2F1c2UgdGhlc2UgbWVzc2FnZXMgYXJlIG5vdA0KaW1wb3J0YW50
IHRvIHVzZXJzLg0KDQoNCj4gKyAgICAgICAgICAgICAgIHJldCA9IDA7DQo+ICsgICAgICAgICAg
ICAgICBnb3RvIGVycl9kZXN0cm95X3J4d3E7DQo+ICsgICAgICAgfQ0KPiArDQo+ICAgICAgICAg
cmV0ID0gcnR3X3JlZ2lzdGVyX2h3KHJ0d2RldiwgcnR3ZGV2LT5odyk7DQo+ICAgICAgICAgaWYg
KHJldCkgew0KPiAgICAgICAgICAgICAgICAgcnR3X2VycihydHdkZXYsICJmYWlsZWQgdG8gcmVn
aXN0ZXIgaHdcbiIpOw0KPiAtLQ0KPiAyLjQ1LjENCg0K

