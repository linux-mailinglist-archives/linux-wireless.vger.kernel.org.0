Return-Path: <linux-wireless+bounces-12928-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A4E97B68F
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 03:29:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4A9E21C23378
	for <lists+linux-wireless@lfdr.de>; Wed, 18 Sep 2024 01:29:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ABAFD101E2;
	Wed, 18 Sep 2024 01:28:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="K6VMstkv"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C028B4405
	for <linux-wireless@vger.kernel.org>; Wed, 18 Sep 2024 01:28:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726622929; cv=none; b=fTNPyYeILVk19q2o4q3vp2YzLRwLyX+N3g6yeJy2mjqrAst2/PeAgcJhUOdGZMKCU4CrGbLwHROE+TsVMXRrUNCfPDXcDZ6cYAPFQm+Cnv5GOvvmZaIv5DaaJcW8yLfmnVXQXYdEAuMYLwTxZ42HSDqckEY/lUwefYrNB44lX/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726622929; c=relaxed/simple;
	bh=Fl7HW2sfoqbzQLFV4ImrA3b+9H61fk+YoUT4mVTKfiQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=qUFf/sOBlXZUFO9y2Rn4S7MzY7K3HBp0x8Zao9sZyVy7T8BJqLBGc8pkLbtH7oGkAuQensWsQH4pjccqQk8W9eqgyDjSn+iIq0oATnDyycxY50frL9GBSagXSdshIxm3Ev3xN34T4rheU2eMvT2pRzXFlazigYnRROtbUfR+l5w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=K6VMstkv; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48I1SY3o81371255, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726622914; bh=Fl7HW2sfoqbzQLFV4ImrA3b+9H61fk+YoUT4mVTKfiQ=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=K6VMstkvscYMvE2pCF5peSVHGMoMUNheL0omjWuJEht09RhJRkSKksLGtwWNPkXlo
	 nv8+33G2Qp/ucmHfedZDkBht8F44a71C8t517C2Ru9rRUF0H+mM6w/uKn5hnrKL1DX
	 u3+knvTP59cWQI200NI06dzPDN6pS2/Y9SOmW58dvR/w0ko/oNr5a7kN/ub+m869Ft
	 wKVBVapjcwW5iRI+Xowb0OgmGMJ0uBcx7ib2mJacGLZADFU/prhysl7PXLYkJP2w10
	 MJcT0+yZzxV9MHTal1TGpEs6P7+e4Rs55vaH+Qt9hmUxqiaVvVqTZ35eLR8fjNw8DT
	 gqXQ166kyy9fQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48I1SY3o81371255
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 18 Sep 2024 09:28:34 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 18 Sep 2024 09:28:35 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 18 Sep 2024 09:28:34 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Wed, 18 Sep 2024 09:28:34 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?Q2VtIMOcTkFM?= <cemunal@linuxmail.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: PCIe Bus Error from rtw_8821ce
Thread-Topic: PCIe Bus Error from rtw_8821ce
Thread-Index: AQHbCNiaV91dngQR6EiAODPVjiVajbJcwL+g
Date: Wed, 18 Sep 2024 01:28:34 +0000
Message-ID: <6d0fc72b21794f73a6017b467a102500@realtek.com>
References: <trinity-7a84c76b-e8b0-4da8-8f8c-07ad3485a23d-1726560422197@3c-app-mailcom-lxa11>
In-Reply-To: <trinity-7a84c76b-e8b0-4da8-8f8c-07ad3485a23d-1726560422197@3c-app-mailcom-lxa11>
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

Q2VtIMOcTkFMIDxjZW11bmFsQGxpbnV4bWFpbC5vcmc+IHdyb3RlOg0KPiBJIGFtIHRlc3Rpbmcg
YnVpbGQtaW4ga2VybmVsIGRyaXZlcnMgZm9yIHJ0d184ODIxY2UgYW5kIGdldHRpbmcgc2FtZSBl
cnJvciBsb2dzIG9ubHkuIEhlcmUgaXMgc29tZSBpbmZvOg0KPiANCj4gc3VkbyBsc3BjaSAtdjoN
Cj4gDQo+IDAyOjAwLjAgTmV0d29yayBjb250cm9sbGVyOiBSZWFsdGVrIFNlbWljb25kdWN0b3Ig
Q28uLCBMdGQuIFJUTDg4MjFDRSA4MDIuMTFhYyBQQ0llIFdpcmVsZXNzIE5ldHdvcmsgQWRhcHRl
cg0KPiBTdWJzeXN0ZW06IEF6dXJlV2F2ZSBEZXZpY2UgMzA0MA0KPiBGbGFnczogYnVzIG1hc3Rl
ciwgZmFzdCBkZXZzZWwsIGxhdGVuY3kgMCwgSVJRIDEzMA0KPiBJL08gcG9ydHMgYXQgZTAwMCBb
c2l6ZT0yNTZdDQo+IE1lbW9yeSBhdCBlZjAwMDAwMCAoNjQtYml0LCBub24tcHJlZmV0Y2hhYmxl
KSBbc2l6ZT02NEtdDQo+IENhcGFiaWxpdGllczogWzQwXSBQb3dlciBNYW5hZ2VtZW50IHZlcnNp
b24gMw0KPiBDYXBhYmlsaXRpZXM6IFs1MF0gTVNJOiBFbmFibGUrIENvdW50PTEvMSBNYXNrYWJs
ZS0gNjRiaXQrDQo+IENhcGFiaWxpdGllczogWzcwXSBFeHByZXNzIEVuZHBvaW50LCBJbnRNc2dO
dW0gMA0KPiBDYXBhYmlsaXRpZXM6IFsxMDBdIEFkdmFuY2VkIEVycm9yIFJlcG9ydGluZw0KPiBD
YXBhYmlsaXRpZXM6IFsxNDhdIERldmljZSBTZXJpYWwgTnVtYmVyIDAwLWUwLTRjLWZmLWZlLWM4
LTIxLTAxDQo+IENhcGFiaWxpdGllczogWzE1OF0gTGF0ZW5jeSBUb2xlcmFuY2UgUmVwb3J0aW5n
DQo+IENhcGFiaWxpdGllczogWzE2MF0gTDEgUE0gU3Vic3RhdGVzDQo+IENhcGFiaWxpdGllczog
WzE3MF0gUHJlY2lzaW9uIFRpbWUgTWVhc3VyZW1lbnQNCj4gQ2FwYWJpbGl0aWVzOiBbMTdjXSBW
ZW5kb3IgU3BlY2lmaWMgSW5mb3JtYXRpb246IElEPTAwMDMgUmV2PTEgTGVuPTA1NCA8Pz4NCj4g
S2VybmVsIGRyaXZlciBpbiB1c2U6IHJ0d184ODIxY2UNCj4gS2VybmVsIG1vZHVsZXM6IHJ0dzg4
Xzg4MjFjZQ0KPiBfX19fX19fX19fDQo+IA0KPiB1bmFtZSAtcjoNCj4gDQo+IDYuMTAuOS0yMDAu
ZmM0MC54ODZfNjQNCj4gX19fX19fX19fXw0KPiANCj4gc3VkbyBkbWVzZyB8IGdyZXAgcnR3Og0K
PiANCj4gWyA3Ljc4NTkwM10gcnR3Xzg4MjFjZSAwMDAwOjAyOjAwLjA6IGVuYWJsaW5nIGRldmlj
ZSAoMDAwMCAtPiAwMDAzKQ0KPiBbIDcuNzk5NTQxXSBydHdfODgyMWNlIDAwMDA6MDI6MDAuMDog
RmlybXdhcmUgdmVyc2lvbiAyNC4xMS4wLCBIMkMgdmVyc2lvbiAxMg0KPiBbIDcuODUyNDE4XSBy
dHdfODgyMWNlIDAwMDA6MDI6MDAuMCB3bHAyczA6IHJlbmFtZWQgZnJvbSB3bGFuMA0KPiBbIDE0
My43MjIwMjNdIHJ0d184ODIxY2UgMDAwMDowMjowMC4wOiBQQ0llIEJ1cyBFcnJvcjogc2V2ZXJp
dHk9Q29ycmVjdGFibGUsIHR5cGU9UGh5c2ljYWwgTGF5ZXIsIChSZWNlaXZlcg0KPiBJRCkNCj4g
WyAxNDMuNzIyMDQzXSBydHdfODgyMWNlIDAwMDA6MDI6MDAuMDogZGV2aWNlIFsxMGVjOmM4MjFd
IGVycm9yIHN0YXR1cy9tYXNrPTAwMDAwMDAxLzAwMDBlMDAwDQo+IFsgMTQzLjcyMjA1OF0gcnR3
Xzg4MjFjZSAwMDAwOjAyOjAwLjA6IFsgMF0gUnhFcnIgKEZpcnN0KQ0KPiBbIDE2MS42MjY1NDRd
IHJ0d184ODIxY2UgMDAwMDowMjowMC4wOiBQQ0llIEJ1cyBFcnJvcjogc2V2ZXJpdHk9Q29ycmVj
dGFibGUsIHR5cGU9UGh5c2ljYWwgTGF5ZXIsIChSZWNlaXZlcg0KPiBJRCkNCg0KU3VnZ2VzdCB0
byB0dXJuIG9mIHBvd2VyIHNhdmUgYnkgZWRpdGluZyAvZXRjL21vZHByb2JlLmQvNzAtcnR3ODgu
Y29uZg0Kd2l0aCB0aGVzZSB0d28gb3B0aW9uczoNCg0KICBvcHRpb25zIHJ0dzg4X3BjaSBkaXNh
YmxlX2FzcG09eQ0KICBvcHRpb25zIHJ0dzg4X2NvcmUgZGlzYWJsZV9scHNfZGVlcD15DQoNClRo
ZW4gY29vbCByZWJvb3QgeW91ciBjb21wdXRlci4gDQoNCg0K

