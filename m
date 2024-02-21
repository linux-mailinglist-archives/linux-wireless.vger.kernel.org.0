Return-Path: <linux-wireless+bounces-3843-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8479585D28F
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 09:28:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id B65621C23322
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 08:28:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D8F53C47C;
	Wed, 21 Feb 2024 08:28:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 279203BB36
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 08:28:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708504122; cv=none; b=UXErY7wesSeW7ioPQHki8aKNsBwbqMh+PPDlvgAB+G7gXGPyHRis7c4uhsYdmNfxaukIinbITuV0yhckwStPvzKuvYTUbnw2uZtgJeK/c7kwc6/NgyTpXkrrtnNfftz5iZuu2AtKk+wrnQrfFfXkaQUIs7iOH6Orj0+KxXXAHlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708504122; c=relaxed/simple;
	bh=a1nXAMq3YMJVtx3VAPXg6efAwdBnDv3aVeLE0L0wDKI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sx8/izr96nDRp6rI3ZqOsYhLZ4oFmLHlXN2TXwHbN9PP6wq5O6HF6m3ZqGpAydVBwlawTB6rVHUFy12zmSkovzJVF2eANC6TNux/7F0HqixSpdfbmrXa0i2uameoPbvGj7ydqpIHDsGf/U50qNjc7XspLK76AxKQUX7+7wTXcSk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41L8SHb64911281, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41L8SHb64911281
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 16:28:17 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Wed, 21 Feb 2024 16:28:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 16:28:17 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Wed, 21 Feb 2024 16:28:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Aditya Kumar Singh
	<quic_adisi@quicinc.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>,
        Ilan Peer <ilan.peer@intel.com>, "Jouni
 Malinen" <j@w1.fi>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Arend van Spriel
	<arend.vanspriel@broadcom.com>,
        Felix Fietkau <nbd@openwrt.org>
Subject: RE: [PATCH v8 4/5] wifi: mac80211: start and finalize channel switch on link basis
Thread-Topic: [PATCH v8 4/5] wifi: mac80211: start and finalize channel switch
 on link basis
Thread-Index: AQHaU4YW43ZUC/cFnUyW8JfF3/48hLD//cCAgAAEzoCABc0KgIAACpsAgAB9JYCAAPMbgIAAOXcAgAAazYCAAAqOAIAAHYkAgAACHICADMP6oP//gIoAgACISOD//3rHgIAAh5JA
Date: Wed, 21 Feb 2024 08:28:17 +0000
Message-ID: <9d3bea8152fe49278fe9804167ec8871@realtek.com>
References: <20240130140918.1172387-1-quic_adisi@quicinc.com>
	 <20240130140918.1172387-5-quic_adisi@quicinc.com>
	 <b73dd1f9c23c164179c38e2109aa1550d87e87ed.camel@sipsolutions.net>
	 <646d1e3e404a437f4c99c80996eb4f194ac242b8.camel@sipsolutions.net>
	 <26df9aa6-e497-4040-ad5c-c647454acca6@quicinc.com>
	 <b2cf5c1d-7842-4e59-b25a-904a6879fa9c@quicinc.com>
	 <f7174207668cac149246cafa0e4b4749ee3289f0.camel@sipsolutions.net>
	 <ac5825e8-0cb1-476e-be5c-ad0170122f77@quicinc.com>
	 <fe2100dcfe9ae9b4517f239faf25374c27f473a5.camel@sipsolutions.net>
	 <5c0fd2eb-eb19-4b69-a325-ad9eef633336@quicinc.com>
	 <bc81466177afd0014ccdd9030c5807339bb288db.camel@sipsolutions.net>
	 <18c0d4de-392a-420c-8a05-466a83cd2eb8@quicinc.com>
	 <3c550ae335a9762a9cbd0c8109b6dd99faeb8f6f.camel@sipsolutions.net>
	 <5a89e63fb7644d12be72154c90c96199@realtek.com>
	 <32b5e358f7b54f4921e0a9e44a71f3a791f0d0da.camel@sipsolutions.net>
	 <00094ae0ca73461c88799c070ad9b55a@realtek.com>
 <db8508eddbeb78bb59671b8c453588428e16f27b.camel@sipsolutions.net>
In-Reply-To: <db8508eddbeb78bb59671b8c453588428e16f27b.camel@sipsolutions.net>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9oYW5uZXMgQmVyZyA8
am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAy
MSwgMjAyNCA0OjIwIFBNDQo+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47
IEFkaXR5YSBLdW1hciBTaW5naCA8cXVpY19hZGlzaUBxdWljaW5jLmNvbT4NCj4gQ2M6IGxpbnV4
LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgSmVmZiBKb2huc29uIDxxdWljX2pqb2huc29uQHF1
aWNpbmMuY29tPjsgSWxhbiBQZWVyDQo+IDxpbGFuLnBlZXJAaW50ZWwuY29tPjsgSm91bmkgTWFs
aW5lbiA8akB3MS5maT47IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT47IEFyZW5k
IHZhbiBTcHJpZWwNCj4gPGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20+OyBGZWxpeCBGaWV0
a2F1IDxuYmRAb3BlbndydC5vcmc+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggNC81XSB3aWZp
OiBtYWM4MDIxMTogc3RhcnQgYW5kIGZpbmFsaXplIGNoYW5uZWwgc3dpdGNoIG9uIGxpbmsgYmFz
aXMNCj4gDQo+IE9uIFdlZCwgMjAyNC0wMi0yMSBhdCAwODoxOSArMDAwMCwgUGluZy1LZSBTaGlo
IHdyb3RlOg0KPiA+ID4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPiA+IEZyb206IEpv
aGFubmVzIEJlcmcgPGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+DQo+ID4gPiBTZW50OiBXZWRu
ZXNkYXksIEZlYnJ1YXJ5IDIxLCAyMDI0IDQ6MTAgUE0NCj4gPiA+IFRvOiBQaW5nLUtlIFNoaWgg
PHBrc2hpaEByZWFsdGVrLmNvbT47IEFkaXR5YSBLdW1hciBTaW5naCA8cXVpY19hZGlzaUBxdWlj
aW5jLmNvbT4NCj4gPiA+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IEplZmYg
Sm9obnNvbiA8cXVpY19qam9obnNvbkBxdWljaW5jLmNvbT47IElsYW4gUGVlcg0KPiA+ID4gPGls
YW4ucGVlckBpbnRlbC5jb20+OyBKb3VuaSBNYWxpbmVuIDxqQHcxLmZpPjsgUnlkZXIgTGVlIDxy
eWRlci5sZWVAbWVkaWF0ZWsuY29tPjsgQXJlbmQgdmFuIFNwcmllbA0KPiA+ID4gPGFyZW5kLnZh
bnNwcmllbEBicm9hZGNvbS5jb20+OyBGZWxpeCBGaWV0a2F1IDxuYmRAb3BlbndydC5vcmc+DQo+
ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDQvNV0gd2lmaTogbWFjODAyMTE6IHN0YXJ0IGFu
ZCBmaW5hbGl6ZSBjaGFubmVsIHN3aXRjaCBvbiBsaW5rIGJhc2lzDQo+ID4gPg0KPiA+ID4gSSBn
dWVzcyB0aGF0J2QgYWxzbyBhcHBseSB0byBwcm9iZSByZXNwb25zZXM/IE9yIGRvZXMgaXQgbm90
IHNlbmQgdGhvc2UNCj4gPiA+IGF0IGFsbD8gQnV0IHdlIGRpc2N1c3NlZCBiZWZvcmUgdGhhdCBt
YXliZSB3ZSBkb24ndCBoYXZlIHRvIGJlIHBlcmZlY3QNCj4gPiA+IHRoZXJlLCBzbyBJIGd1ZXNz
IHdlIGNhbiBmaW5kIHNvbWUgc29sdXRpb24gdG8gdGhhdC4NCj4gPg0KPiA+IFVuZm9ydHVuYXRl
bHksIFJlYWx0ZWsgZmlybXdhcmUgZG9lc24ndCBzZW5kIHByb2JlIHJlc3BvbnNlcyBhdCBhbGwu
IFN0aWxsDQo+ID4gbmVlZCBob3N0YXBkIHRvIHJlcGx5IHRob3NlLg0KPiA+DQo+IA0KPiBSaWdo
dCwgYnV0IGZpbGxpbmcgaW4gdGhlIENTQSBjb3VudGVycz8NCj4gDQoNCk5vLCBmaXJtd2FyZSBk
b2Vzbid0IG1vZGlmeSBjb250ZW50IG9mIHByb2JlIHJlc3BvbnNlIGZyYW1lLg0KDQpQaW5nLUtl
DQoNCg==

