Return-Path: <linux-wireless+bounces-10654-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9E2BD94061E
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 05:58:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 0D40EB21BFC
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 03:58:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8C81514A4F5;
	Tue, 30 Jul 2024 03:58:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="moxrNReD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA521474BC
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 03:57:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722311881; cv=none; b=GNdgTPWucD9nDse3ecFUq0hcD5lA860/KjTn+Ht8vqlVpeunclF39mLdpEz8Cq1Op5iuyRXrc/H7q+7s5SLJ3JwC7DetLIoeRskolUgtoBCj87RMMmJlJKoWBYQ/1o73FAPaCYDpcl/w3gaA48uq4KofJy3Ae1nbV08QJuAlLOE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722311881; c=relaxed/simple;
	bh=B8NkT2P52B+9MEFn1/6Z31UT5Z+HI0gfxB/lByQ/Xl8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sekj8MLrP1OV1Uv0GDmOElZ+DbaStRmEWAsg91mI8er/Fk9l9Nmy6MCTo/mtnQ9UohLTB0z/KMBpkVfAoK0Pk2iKiSbYLNKjKJbjZKWeLqBHxjL7tu/h62lInP+BV2XoO7fFp+EmsD2ED2c1+wXDTmEYC28C0Zr38S1q1xWaD/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=moxrNReD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46U3vgIK3647847, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722311862; bh=B8NkT2P52B+9MEFn1/6Z31UT5Z+HI0gfxB/lByQ/Xl8=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=moxrNReDIbd5fc7QwdqnHmObZJEe3f5koWRBnZC/J/QbazQ2b4a2t5iMejCvkEqdZ
	 CgNeaCjDXyJfd57CSqysDN8C7MFw1oATZNf3IwOo/6/dANOcCFtkdN0IxJztehyM2G
	 ryYg0mkmloCBCcguffLg5HMz4iNS8y8As8OMKYY8/HMSUjInJVR2N2ik590bviE/gl
	 K/cfrCSbmhJB1Bf8ZFbQPMx0i3lzZFR6+Q1PfmXxI7C288uzM9pbFCI2MKYQUaPHmg
	 Y1GT9wDKtfvIo//LUCiqHX/b4EIz7eij3+dgymuddb8iMGR6n7im3xQsnjg25TY/Iv
	 GwTF2dgn5tguQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46U3vgIK3647847
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 11:57:42 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 11:57:43 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jul 2024 11:57:42 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 30 Jul 2024 11:57:42 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH 1/4] wifi: rtw88: Init RX burst length for 8822cu/8822bu/8821cu
Thread-Topic: [PATCH 1/4] wifi: rtw88: Init RX burst length for
 8822cu/8822bu/8821cu
Thread-Index: AQHa4SXtM9kPnRDVBEWoRbyp7auc17IOpEoA
Date: Tue, 30 Jul 2024 03:57:42 +0000
Message-ID: <4a8ac99c87214b4c92dde42e26006964@realtek.com>
References: <c03390ce-34c2-42dd-9bd6-b231bb1f2fae@gmail.com>
In-Reply-To: <c03390ce-34c2-42dd-9bd6-b231bb1f2fae@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBJbml0
IFJYIGJ1cnN0IGxlbmd0aCBhY2NvcmRpbmcgdG8gdGhlIFVTQiBzcGVlZC4NCj4gDQo+IFRoaXMg
aXMgbmVlZGVkIGluIG9yZGVyIHRvIG1ha2UgVVNCIFJYIGFnZ3JlZ2F0aW9uIHdvcmsuDQo+IA0K
PiBUZXN0ZWQgd2l0aCBSVEw4ODExQ1UuDQoNCkhhdmluZyBhIHRocm91Z2hwdXQgYWZ0ZXIgdGhp
cyBjaGFuZ2Ugd291bGQgYmUgYmV0dGVyLg0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJi
bHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCj4gLS0tDQo+IEkgd291bGQgbWVu
dGlvbiBpbiB0aGUgY29tbWl0IG1lc3NhZ2Ugd2hhdCBCSVRfRE1BX0JVUlNUX0NOVCwNCj4gQklU
X0RNQV9NT0RFLCBhbmQgQklUX0RST1BfREFUQV9FTiBhcmUgZG9pbmcsIGJ1dCBJIGRvbid0IGtu
b3cuDQoNClRoYXQgd2lsbCBiZSBoZWxwZnVsIHRvIG90aGVyIGRldmVsb3BlcnMuIFBsZWFzZSBw
dXQgdGhlbSBpbiBzZWNvbmQgcGFyYWdyYXBoLiANCg0KWy4uLl0NCg0KPiArc3RhdGljIHZvaWQg
cnR3ODgyMWN1X2luaXRfYnVyc3RfcGt0X2xlbihzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2KQ0KPiAr
ew0KPiArICAgICAgIHU4IHJ4ZG1hLCBidXJzdF9zaXplOw0KPiArDQo+ICsgICAgICAgcnhkbWEg
PSBCSVRfRE1BX0JVUlNUX0NOVCB8IEJJVF9ETUFfTU9ERTsNCj4gKw0KPiArICAgICAgIGlmIChy
dHdfcmVhZDgocnR3ZGV2LCBSRUdfU1lTX0NGRzIgKyAzKSA9PSAweDIwKQ0KPiArICAgICAgICAg
ICAgICAgYnVyc3Rfc2l6ZSA9IEJJVF9ETUFfQlVSU1RfU0laRV8xMDI0Ow0KPiArICAgICAgIGVs
c2UgaWYgKChydHdfcmVhZDgocnR3ZGV2LCBSRUdfVVNCX1VTQlNUQVQpICYgMHgzKSA9PSAweDEp
DQo+ICsgICAgICAgICAgICAgICBidXJzdF9zaXplID0gQklUX0RNQV9CVVJTVF9TSVpFXzUxMjsN
Cj4gKyAgICAgICBlbHNlDQo+ICsgICAgICAgICAgICAgICBidXJzdF9zaXplID0gQklUX0RNQV9C
VVJTVF9TSVpFXzY0Ow0KPiArDQo+ICsgICAgICAgdThwX3JlcGxhY2VfYml0cygmcnhkbWEsIGJ1
cnN0X3NpemUsIEJJVF9ETUFfQlVSU1RfU0laRSk7DQo+ICsNCj4gKyAgICAgICBydHdfd3JpdGU4
KHJ0d2RldiwgUkVHX1JYRE1BX01PREUsIHJ4ZG1hKTsNCj4gKyAgICAgICBydHdfd3JpdGUxNl9z
ZXQocnR3ZGV2LCBSRUdfVFhETUFfT0ZGU0VUX0NISywgQklUX0RST1BfREFUQV9FTik7DQo+ICt9
DQo+ICsNCg0KQWxsIHVzZSB0aGUgc2FtZSBzZXR1cC4gDQpDYW4gd2UgbW92ZSBpdCB0byB1c2Iu
Yz8gTWF5YmUgcnR3X3VzYl9pbnRlcmZhY2VfY2ZnKCkgaXMgYSBnb29kIHBsYWNlPw0KKHN0aWxs
IGV4Y2x1ZGUgdW50ZXN0ZWQgY2hpcHMuKQ0KDQo=

