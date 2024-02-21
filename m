Return-Path: <linux-wireless+bounces-3845-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BA18085D2E6
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 09:58:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6B422283DD0
	for <lists+linux-wireless@lfdr.de>; Wed, 21 Feb 2024 08:58:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ACCDC3A8D8;
	Wed, 21 Feb 2024 08:58:23 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A92613CF72
	for <linux-wireless@vger.kernel.org>; Wed, 21 Feb 2024 08:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708505903; cv=none; b=oTXuyN1t/HQaujfPS9exlZ1qWDRx2xopAAVivIGTjwQm2n780WKm8B5MMTY4LMBHuihrBGLxgS4eW5sjpy5W1LG0Dyy52wk6qaDEOW9F1LiZ8uf76wVS1veKC38ke7RSAY0tbaPfzIbPrDoHtSh5Fw31ZmO9QxXpp+S9yFavC+I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708505903; c=relaxed/simple;
	bh=DiuX5s2OSldCWc4uR6I1TGbQPNFY64pXgehshlnWFNE=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s6zoGiyg75kFTRCZP183Mm5YWOp+iHwA1KSgGyJl8iPl2KKbkrIFlcBBHZXobBk43ijb1EueJExpSE0sQRT0r61BzXteLuJ7q3FOvwRhAMzu2rCUaEK50t7GG7R11KLfit0PnEfbAK0XNB6wNGlpqtqp4adXvnIw8CwEsFpxt04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41L8vnMcB934651, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41L8vnMcB934651
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Feb 2024 16:57:49 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Wed, 21 Feb 2024 16:57:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 21 Feb 2024 16:57:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Wed, 21 Feb 2024 16:57:49 +0800
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
        Felix Fietkau <nbd@nbd.name>
Subject: RE: [PATCH v8 4/5] wifi: mac80211: start and finalize channel switch on link basis
Thread-Topic: [PATCH v8 4/5] wifi: mac80211: start and finalize channel switch
 on link basis
Thread-Index: AQHaU4YW43ZUC/cFnUyW8JfF3/48hLD//cCAgAAEzoCABc0KgIAACpsAgAB9JYCAAPMbgIAAOXcAgAAazYCAAAqOAIAAHYkAgAACHICADMP6oP//gIoAgACISOD//3rHgIAAh5JA//98mIAAERIskA==
Date: Wed, 21 Feb 2024 08:57:49 +0000
Message-ID: <c0f3930196504d2080907c12864493d8@realtek.com>
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
	 <9d3bea8152fe49278fe9804167ec8871@realtek.com>
 <08a989730bbc456df481aee8ae278a5cd9b35f85.camel@sipsolutions.net>
In-Reply-To: <08a989730bbc456df481aee8ae278a5cd9b35f85.camel@sipsolutions.net>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogSm9oYW5uZXMgQmVyZyA8
am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAy
MSwgMjAyNCA0OjM1IFBNDQo+IFRvOiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT47
IEFkaXR5YSBLdW1hciBTaW5naCA8cXVpY19hZGlzaUBxdWljaW5jLmNvbT4NCj4gQ2M6IGxpbnV4
LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgSmVmZiBKb2huc29uIDxxdWljX2pqb2huc29uQHF1
aWNpbmMuY29tPjsgSWxhbiBQZWVyDQo+IDxpbGFuLnBlZXJAaW50ZWwuY29tPjsgSm91bmkgTWFs
aW5lbiA8akB3MS5maT47IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT47IEFyZW5k
IHZhbiBTcHJpZWwNCj4gPGFyZW5kLnZhbnNwcmllbEBicm9hZGNvbS5jb20+OyBGZWxpeCBGaWV0
a2F1IDxuYmRAbmJkLm5hbWU+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggNC81XSB3aWZpOiBt
YWM4MDIxMTogc3RhcnQgYW5kIGZpbmFsaXplIGNoYW5uZWwgc3dpdGNoIG9uIGxpbmsgYmFzaXMN
Cj4gDQo+IE9uIFdlZCwgMjAyNC0wMi0yMSBhdCAwODoyOCArMDAwMCwgUGluZy1LZSBTaGloIHdy
b3RlOg0KPiA+DQo+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gRnJvbTog
Sm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4NCj4gPiA+IFNlbnQ6IFdl
ZG5lc2RheSwgRmVicnVhcnkgMjEsIDIwMjQgNDoyMCBQTQ0KPiA+ID4gVG86IFBpbmctS2UgU2hp
aCA8cGtzaGloQHJlYWx0ZWsuY29tPjsgQWRpdHlhIEt1bWFyIFNpbmdoIDxxdWljX2FkaXNpQHF1
aWNpbmMuY29tPg0KPiA+ID4gQ2M6IGxpbnV4LXdpcmVsZXNzQHZnZXIua2VybmVsLm9yZzsgSmVm
ZiBKb2huc29uIDxxdWljX2pqb2huc29uQHF1aWNpbmMuY29tPjsgSWxhbiBQZWVyDQo+ID4gPiA8
aWxhbi5wZWVyQGludGVsLmNvbT47IEpvdW5pIE1hbGluZW4gPGpAdzEuZmk+OyBSeWRlciBMZWUg
PHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+OyBBcmVuZCB2YW4gU3ByaWVsDQo+ID4gPiA8YXJlbmQu
dmFuc3ByaWVsQGJyb2FkY29tLmNvbT47IEZlbGl4IEZpZXRrYXUgPG5iZEBvcGVud3J0Lm9yZz4N
Cj4gPiA+IFN1YmplY3Q6IFJlOiBbUEFUQ0ggdjggNC81XSB3aWZpOiBtYWM4MDIxMTogc3RhcnQg
YW5kIGZpbmFsaXplIGNoYW5uZWwgc3dpdGNoIG9uIGxpbmsgYmFzaXMNCj4gPiA+DQo+ID4gPiBP
biBXZWQsIDIwMjQtMDItMjEgYXQgMDg6MTkgKzAwMDAsIFBpbmctS2UgU2hpaCB3cm90ZToNCj4g
PiA+ID4gPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiA+ID4gPiA+IEZyb206IEpvaGFu
bmVzIEJlcmcgPGpvaGFubmVzQHNpcHNvbHV0aW9ucy5uZXQ+DQo+ID4gPiA+ID4gU2VudDogV2Vk
bmVzZGF5LCBGZWJydWFyeSAyMSwgMjAyNCA0OjEwIFBNDQo+ID4gPiA+ID4gVG86IFBpbmctS2Ug
U2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPjsgQWRpdHlhIEt1bWFyIFNpbmdoIDxxdWljX2FkaXNp
QHF1aWNpbmMuY29tPg0KPiA+ID4gPiA+IENjOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5v
cmc7IEplZmYgSm9obnNvbiA8cXVpY19qam9obnNvbkBxdWljaW5jLmNvbT47IElsYW4gUGVlcg0K
PiA+ID4gPiA+IDxpbGFuLnBlZXJAaW50ZWwuY29tPjsgSm91bmkgTWFsaW5lbiA8akB3MS5maT47
IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT47IEFyZW5kIHZhbiBTcHJpZWwNCj4g
PiA+ID4gPiA8YXJlbmQudmFuc3ByaWVsQGJyb2FkY29tLmNvbT47IEZlbGl4IEZpZXRrYXUgPG5i
ZEBvcGVud3J0Lm9yZz4NCj4gPiA+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIIHY4IDQvNV0gd2lm
aTogbWFjODAyMTE6IHN0YXJ0IGFuZCBmaW5hbGl6ZSBjaGFubmVsIHN3aXRjaCBvbiBsaW5rIGJh
c2lzDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBJIGd1ZXNzIHRoYXQnZCBhbHNvIGFwcGx5IHRvIHBy
b2JlIHJlc3BvbnNlcz8gT3IgZG9lcyBpdCBub3Qgc2VuZCB0aG9zZQ0KPiA+ID4gPiA+IGF0IGFs
bD8gQnV0IHdlIGRpc2N1c3NlZCBiZWZvcmUgdGhhdCBtYXliZSB3ZSBkb24ndCBoYXZlIHRvIGJl
IHBlcmZlY3QNCj4gPiA+ID4gPiB0aGVyZSwgc28gSSBndWVzcyB3ZSBjYW4gZmluZCBzb21lIHNv
bHV0aW9uIHRvIHRoYXQuDQo+ID4gPiA+DQo+ID4gPiA+IFVuZm9ydHVuYXRlbHksIFJlYWx0ZWsg
ZmlybXdhcmUgZG9lc24ndCBzZW5kIHByb2JlIHJlc3BvbnNlcyBhdCBhbGwuIFN0aWxsDQo+ID4g
PiA+IG5lZWQgaG9zdGFwZCB0byByZXBseSB0aG9zZS4NCj4gPiA+ID4NCj4gPiA+DQo+ID4gPiBS
aWdodCwgYnV0IGZpbGxpbmcgaW4gdGhlIENTQSBjb3VudGVycz8NCj4gPiA+DQo+ID4NCj4gPiBO
bywgZmlybXdhcmUgZG9lc24ndCBtb2RpZnkgY29udGVudCBvZiBwcm9iZSByZXNwb25zZSBmcmFt
ZS4NCj4gPg0KPiANCj4gQ2FuIHlvdSBnZXQgdGhhdCBmaXhlZD8gOy0pDQo+IA0KPiBXaXRoIGRp
ZmZlcmluZyBiZWFjb24gaW50ZXJ2YWxzIGV0Yy4sIEkgZG9uJ3Qga25vdyB0aGVyZSdzIGEgZ29v
ZCB3YXkgdG8NCj4ga2VlcCB0aGUgY291bnRlcnMgZXZlbiB3aXRoIGEgc2VtYmxhbmNlIG9mIGNv
cnJlY3RuZXNzLCBlc3BlY2lhbGx5IGlmIHdlDQo+IGRvbid0IGtub3cgd2hlbiB0aGUgYmVhY29u
IHdhcyB0cmFuc21pdHRlZD8NCj4gDQo+IE9yIG1heWJlIGp1c3QgZmlsbCBpdCBpbiB0aGUgZHJp
dmVyIHNpbmNlIHlvdSBwcm9iYWJseSBoYXZlIHNvbWUgYmVhY29uDQo+IHRpbWluZyBkYXRhIG1v
cmUgZWFzaWx5IGFjY2Vzc2libGU/DQoNCklmIGRyaXZlciBjYW4gZ2V0IENTQSBvciBFQ1NBIG9m
ZnNldCBzaW1wbHksIEkgcHJvYmFibHkgY2FuIGZpbGwgYSByZWFzb25hYmxlDQpDU0EgY291bnRl
ciAobm90IHN1cmUgaWYgSSBjYW4gZ2V0IDEwMCUgYWNjdXJhdGUgY291bnRlciBmb3Igbm93KSwg
YnV0DQpzZWVtaW5nbHkgbmVpdGhlciBpZWVlODAyMTFfdHhfY29udHJvbCBub3IgaWVlZTgwMjEx
X3R4X2luZm8gKFNLQl9DQikgZG9lc24ndA0KaGF2ZSB0aGVzZSBvZmZzZXRzLiBBbnkgc3VnZ2Vz
dGlvbnM/DQoNCkkgd29uZGVyIG91ciBvdXQtb2YtdHJlZSBkcml2ZXIgZ2VuZXJhdGVzIHByb2Jl
IHJlc3BvbnNlIGl0c2VsZi4gTGV0J3MgbWUNCmNoZWNrIGhvdyBpdCBkb2VzLg0KDQpQaW5nLUtl
DQoNCg==

