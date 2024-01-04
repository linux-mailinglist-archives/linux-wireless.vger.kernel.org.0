Return-Path: <linux-wireless+bounces-1478-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7AD823EBD
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 10:35:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7703C281ACC
	for <lists+linux-wireless@lfdr.de>; Thu,  4 Jan 2024 09:35:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F0797208AD;
	Thu,  4 Jan 2024 09:35:27 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 612D2208A5
	for <linux-wireless@vger.kernel.org>; Thu,  4 Jan 2024 09:35:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4049ZLzkC1596284, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4049ZLzkC1596284
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 4 Jan 2024 17:35:21 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.17; Thu, 4 Jan 2024 17:35:21 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.7; Thu, 4 Jan 2024 17:35:21 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8]) by
 RTEXDAG02.realtek.com.tw ([fe80::5d58:7838:d352:d6b8%5]) with mapi id
 15.01.2375.007; Thu, 4 Jan 2024 17:35:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Nicola Mingotti <nico020978@gmail.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: RTL8822bu as AP rejects Tapo devices
Thread-Topic: RTL8822bu as AP rejects Tapo devices
Thread-Index: AQHaPu42gxpRLfS9QUG5qti2XzCwFbDJY6iw
Date: Thu, 4 Jan 2024 09:35:20 +0000
Message-ID: <d5219b204fce48e1aa458ac669e2bbd3@realtek.com>
References: <CAL7TOjnP72fV4en6i3hsd3qgsjas+a9O2rgp2CuCdKMLOh+VEg@mail.gmail.com>
In-Reply-To: <CAL7TOjnP72fV4en6i3hsd3qgsjas+a9O2rgp2CuCdKMLOh+VEg@mail.gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXDAG01.realtek.com.tw, 9
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogTmljb2xhIE1pbmdvdHRp
IDxuaWNvMDIwOTc4QGdtYWlsLmNvbT4NCj4gU2VudDogVGh1cnNkYXksIEphbnVhcnkgNCwgMjAy
NCA1OjEzIFBNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gU3ViamVj
dDogUlRMODgyMmJ1IGFzIEFQIHJlamVjdHMgVGFwbyBkZXZpY2VzDQo+IA0KPiANCj4gSW4gdGhl
IEFQIHdoaWNoIHJ1bnMgbm93IERlYmlhbiBUZXN0aW5nIGl0IGlzIHRydWUgaSBjYW4gcGx1ZyBp
biB0d28NCj4gQnJvc3RyZW5kIGRvbmdsZXMuIEl0IHdvcmtzIGFzIEFQIDIuNEdoeiwgaW4gdGhl
IHNlbnNlIHRoYXQgaSBjYW4NCj4gY29ubmVjdCB0byBpdCB3aXRoIG15IFNhbXN1bmcgcGhvbmUu
IEJVVCwgaGVyZSBjb21lcyB0aGUgcHJvYmxlbSwgTk8NCj4gT05FIG9mIHRoZSA+MTAgVGFwbyBk
ZXZpY2VzICgyIGNhbWVyYXMgQzIyNSBhbmQgc2V2ZXJhbCBwbHVncyBQMTEwKQ0KPiB3YW50IHRv
IGNvbm5lY3RzIHRvIHRoZSBBUCB3aXRoIHRoZSBkcml2ZXIgcHJvdmlkZWQgYnkgdGhlIGtlcm5l
bC4NCj4gDQoNCkNhcHR1cmluZyBhaXIgc25pZmZlciB3b3VsZCBoZWxwIHRvIGRpYWdub3NlIHRo
ZSBwcm9ibGVtLiANCkFzc3VtaW5nIHdsYW4wIGlzIHlvdXIgUlRMODgyMmJ1LCBhZGQgYSBtb25p
dG9yIGludGVyZmFjZSBieSANCiAgJCBzdWRvIGl3IGRldiB3bGFuMCBpbnRlcmZhY2UgYWRkIG1v
bjAgdHlwZSBtb25pdG9yDQoNClVzZSB3aXJlc2hhcmsgdG8gcmVjb3JkcyBwYWNrZXRzIG9mIG1v
bjAgZHVyaW5nIFRhcG8gZGV2aWNlIGlzIHRyeWluZyB0bw0KY29ubmVjdC4gDQoNCkRvIHlvdSB0
cnkgdG8gdXNlIG5vbi1zZWN1cmUgY29ubmVjdGlvbj8gSXQgY2FuIGhlbHAgdG8gYmlzZWN0IHBy
b2JsZW0gdG9vLg0KDQpQaW5nLUtlDQoNCg==

