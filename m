Return-Path: <linux-wireless+bounces-11597-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 06BC495614A
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 05:00:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B15E31F2173B
	for <lists+linux-wireless@lfdr.de>; Mon, 19 Aug 2024 03:00:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 03ECD4594D;
	Mon, 19 Aug 2024 02:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="PUlDlIb9"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01AB2947A
	for <linux-wireless@vger.kernel.org>; Mon, 19 Aug 2024 02:59:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724036396; cv=none; b=d5+YZbtKmk+2ndHUTlwPV+OVomuBCosYIZH7+FLteNWFHk0E4ITnERtXgqQ42jI9XkOnGQEcVSy8VgmvNTGVLBRR4trCoYcna82ih3jiLjoIoEbCiOte5YG3RhFYmrg8xPpK0Sl8eaU4e3dcR9CzqhHHjQarb2r7IWRfT0UbqU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724036396; c=relaxed/simple;
	bh=4uMF4RDLI+gpuW82ZyVWygy9dNL6YwRjObVxjU7Il1E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gV5j4pjBU0TiD7aJEVqSvLwnmlYalleiUqSsnAVigMXLGKSK8BijErkMVchN+MyiKENY2kPxU7YVqBkyw2JitESZ+57vtfi73dkmlF1j7Zza9YJ55U3qBz84H3UncVOTOU/iiRjxh0u70hyWwsGqAmen8BixG1t0ro5pQ82WeeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=PUlDlIb9; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47J2xP8413767497, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1724036365; bh=4uMF4RDLI+gpuW82ZyVWygy9dNL6YwRjObVxjU7Il1E=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=PUlDlIb9xZVZZ0DUbwPjqHZW+UEnv5rGtQ0/CVcm247uY49pcklZPdGGUyerQmD1G
	 Xm/isFyuNBzFdtSXVbfOvYelO6VzsRplulWzuWe1bhfxXc3/hJu0OyTRSXiRf4ZOdu
	 PFufHoc0oNT1OnMy/Nq+K/6MYuiR/hBw/DZcvJhY29bFdzH/mADjxZ4Vd+Nu0q2/SX
	 QYz0YGIa6EQTxx/GAn+VR94x9YbtAnYSVnn7UE8/FmUMwX8KBf+JEFc96mO2QaGK+x
	 sH5F/5npEFYqRPTEaIIaVmcKa9esk62Gh7MoJPz6y2H0LC7jlZGKHag4Ycrt3+OS4k
	 Y3u5voe2NDVcg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47J2xP8413767497
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 19 Aug 2024 10:59:25 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 19 Aug 2024 10:59:25 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 19 Aug 2024 10:59:25 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Mon, 19 Aug 2024 10:59:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "Maciej S. Szmigiero" <mail@maciej.szmigiero.name>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>
CC: Sascha Hauer <sha@pengutronix.de>,
        Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 2/2] wifi: rtw88: Avoid using macid 0 in AP mode
Thread-Topic: [PATCH 2/2] wifi: rtw88: Avoid using macid 0 in AP mode
Thread-Index: AQHa4UC4lZ9xsp59ME2YErnRO2fzALIO0JLQ///mdQCAAUpa0IAAPgYAgAxlZgCAEV8d8A==
Date: Mon, 19 Aug 2024 02:59:24 +0000
Message-ID: <e8d3c81a47de44e1ba7df08b9de826ee@realtek.com>
References: <9174a776-4771-4351-85fa-476e240d8ace@gmail.com>
 <e4be0a75-43b2-4ae5-9aab-5c4a88e78097@gmail.com>
 <9356af89520243ccacc0be72b8b03252@realtek.com>
 <4f052989-5fb9-4c5c-950e-a3d34e6499ab@gmail.com>
 <d21bc7a0fac8413b9cc443288924ec7b@realtek.com>
 <91d03fa7-5af0-4ec5-a52c-c2c060e11d4d@gmail.com>
 <6d1667d2-c86f-4b80-bb32-9ba01164480b@maciej.szmigiero.name>
In-Reply-To: <6d1667d2-c86f-4b80-bb32-9ba01164480b@maciej.szmigiero.name>
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

TWFjaWVqIFMuIFN6bWlnaWVybyA8bWFpbEBtYWNpZWouc3ptaWdpZXJvLm5hbWU+IHdyb3RlOg0K
PiBPbiAzMS4wNy4yMDI0IDE0OjIwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3RlOg0KPiA+IE9uIDMx
LzA3LzIwMjQgMDM6NDcsIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPj4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+Pj4gT24gMzAvMDcvMjAyNCAw
OTozMywgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+Pj4+IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4
MjFjZXJmZTJAZ21haWwuY29tPiB3cm90ZToNCj4gPj4+Pj4NCj4gPj4+Pj4gSW4gQVAgbW9kZSwg
dGhlIGZpcm13YXJlIHN0b3BzIHRyYW5zbWl0dGluZyBiZWFjb25zIGlmIGl0IHJlY2VpdmVzDQo+
ID4+Pj4+IEgyQ19DTURfUkFfSU5GTyBmb3IgbWFjaWQgMC4NCj4gPj4+Pj4NCj4gPj4+Pj4gTGVh
dmUgbWFjaWQgMCB1bnVzZWQgaW4gQVAgbW9kZS4gTWFjaWQgMSBpcyBhbHJlYWR5IHJlc2VydmVk
IGZvcg0KPiA+Pj4+PiBicm9hZGNhc3QvbXVsdGljYXN0LiBBc3NpZ24gbWFjaWQgMiB0byB0aGUg
Zmlyc3QgY29ubmVjdGVkIGNsaWVudC4NCj4gPj4+Pg0KPiA+Pj4+IFNlZW1pbmdseSB3ZSBtaXNz
ZWQgdG8gc2V0IG1hY19pZCBpbiBUWCBkZXNjIGZvciBhIGxvbmcgdGltZS4NCj4gPj4+Pg0KPiA+
Pj4+ICsjZGVmaW5lIFJUV19UWF9ERVNDX1cxX01BQ0lEIEdFTk1BU0soNywgMCkNCj4gPj4+PiAg
ICNkZWZpbmUgUlRXX1RYX0RFU0NfVzFfUVNFTCBHRU5NQVNLKDEyLCA4KQ0KPiA+Pj4+ICAgI2Rl
ZmluZSBSVFdfVFhfREVTQ19XMV9SQVRFX0lEIEdFTk1BU0soMjAsIDE2KQ0KPiA+Pj4+DQo+ID4+
Pj4gVGhlIG1hY19pZCBzaG91bGQgYmUgZnJvbSBydHd2aWYtPm1hY19pZCBvciBzaS0+bWFjX2lk
IGFjY29yZGluZyB0bw0KPiA+Pj4+IG9wZXJhdGluZyBtb2RlIGFuZCByb2xlLg0KPiA+Pj4+DQo+
ID4+Pj4gQW5kIEkgc3VwcG9zZSBtYWNfaWQgYXNzaWdubWVudCBmb3IgQVAgaXMgbWFjX2lkIDAg
Zm9yIGJyb2FkY2FzdC9tdWx0aWNhc3QsIGFuZA0KPiA+Pj4+IG90aGVyIG1hY19pZCBjYW4gYmUg
dXNlZCBieSBjb25uZWN0ZWQgc3RhdGlvbnMgcmVndWxhcmx5Lg0KPiA+Pj4+DQo+ID4+Pg0KPiA+
Pj4gV2hhdCBhYm91dCB0aGUgY29uY3VycmVudCBBUCArIHN0YXRpb24gc2NlbmFyaW8/IFdpbGwg
dGhlDQo+ID4+PiBzdGF0aW9uIHZpZiB1c2UgdGhlIG5leHQgYXZhaWxhYmxlIG1hY2lkLCB3aGF0
ZXZlciB0aGF0IGlzPw0KPiA+Pj4gSnVzdCB3b25kZXJpbmcsIEkgZG9uJ3QgdXNlIGNvbmN1cnJl
bnQgbW9kZS4NCj4gPj4NCj4gPj4gTXkgYmFzaWMgaWRlYSBpcyB0byBhc3NpZ24gbWFjX2lkIHRv
IGVhY2ggdmlmIHdoZW4gYWRkaW5nIHZpZi4gRm9yIHN0YXRpb24gbW9kZSwNCj4gPj4gc3RhLT5t
YWNfaWQgd2lsbCByZXVzZSB2aWYtPm1hY19pZC4gRm9yIEFQIG1vZGUsIEkgd2lsbCBkeW5hbWlj
YWxseSBhbGxvY2F0ZSBhbg0KPiA+PiBzdGEtPm1hY19pZCB0byBhIHN0YXRpb24sIGFuZCB2aWYt
Pm1hY19pZCBpcyB0byBzZW5kIGJyb2FkY2FzdC9tdWx0aWNhc3QgcGFja2V0cw0KPiA+PiB0aGF0
IGFyZSBub3QgYmVsb25nIHRvIGEgc3RhLiBGb3IgZXhhbXBsZSwNCj4gPj4NCj4gPj4gICAgICAg
ICAgICAgICAgICAgIHZpZi0+bWFjX2lkICAgICAgc3RhLT5tYWNfaWQNCj4gPj4gdmlmMCAoU1RB
IG1vZGUpICAgICAgICAwICAgICAgICAgICAgICAgMA0KPiA+PiB2aWYxIChBUCBtb2RlKSAgICAg
ICAgIDEgICAgICAgICAgICAgICAyLi4uDQo+ID4+DQo+ID4+DQo+ID4+Pg0KPiA+Pj4gQWxzbywg
ZG8geW91IG1lYW4gdGhhdCB5b3Ugd2lsbCBkbyBhbGwgdGhpcz8gSXQncyBub3QgY2xlYXIgdG8g
bWUuDQo+ID4+DQo+ID4+IEkgY2FuIGRvIGl0LiBPciBhcmUgeW91IGludGVyZXN0ZWQgaW4gdGhp
cz8NCj4gPj4NCj4gPg0KPiA+IE5vLCBubywgaXQncyBhbGwgeW91cnMuIDopDQo+ID4NCj4gDQo+
IEl0IHdvdWxkIGJlIG5pY2UgdG8gaGF2ZSBlaXRoZXIgdGhpcyBzdWJtaXR0ZWQgZml4IG9yIGFs
dGVybmF0aXZlIG9uZSBtZXJnZWQgc29vbg0KPiBzaW5jZSB0aGUgQVAgbW9kZSBpcyBjb21wbGV0
ZWx5IGJyb2tlbiBvdGhlcndpc2UgKGF0IGxlYXN0IG9uIFJUTDg4MjFDVSkuDQoNCkkgaGF2ZSBz
ZW50IGEgcGF0Y2ggWzJdIHRvIHJlcGxhY2UgdGhpcyBvbmUsIGJ1dCBzdGlsbCBuZWVkcw0KcGF0
Y2ggMS8yICJ3aWZpOiBydHc4ODogRml4IFVTQiBkZXZpY2VzIG5vdCB0cmFuc21pdHRpbmcgYmVh
Y29ucyIuIFsxXQ0KDQpJIGhhdmUgdGVzdGVkIFsxXSArIFsyXSBjYW4gd29yayBvbiBQQ0kgZGV2
aWNlcy4NCkNhbiBhbnlvbmUgaGVscCB0byB0ZXN0IGlmIFsxXSArIFsyXSBhbHNvIHdvcmtzIG9u
IFVTQiBkZXZpY2VzPw0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtd2lyZWxl
c3MvOTE3NGE3NzYtNDc3MS00MzUxLTg1ZmEtNDc2ZTI0MGQ4YWNlQGdtYWlsLmNvbS8NClsyXSBo
dHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC13aXJlbGVzcy8yMDI0MDgxOTAyNTI0OC4xNzkz
OS0xLXBrc2hpaEByZWFsdGVrLmNvbS9ULyN1DQoNCg0KDQo=

