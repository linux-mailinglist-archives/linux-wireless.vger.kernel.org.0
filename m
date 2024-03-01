Return-Path: <linux-wireless+bounces-4277-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3836C86D850
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 01:28:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 290661C20C3B
	for <lists+linux-wireless@lfdr.de>; Fri,  1 Mar 2024 00:28:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50E7017E;
	Fri,  1 Mar 2024 00:28:08 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 988C7365
	for <linux-wireless@vger.kernel.org>; Fri,  1 Mar 2024 00:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709252888; cv=none; b=Sm7aRSTPUCIpW/P+C0qPiSUYXoSzykBAKXOEctuirRL+nD7ZPcV2/wl8IU8mra9VSw+2FUXIyajprs/IWnTv5H0ZHqnOr6JsyXmrlaiBepFF+MjsSLWPKqEnxtnhvu9mW6JV8O16AkGlakNWCAXHRjSd+zqaxk3ZK1wMXepSkZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709252888; c=relaxed/simple;
	bh=SiXDUEtWQeKWmSkc0fldX/4bFbexNHxb2rppnkl/69s=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=TxfCpiTNlE9dqbisMZpmI1h8SqUmFXk14KU0VX9dVmlB1mH+kq3jbra3Si9kXtVrIm2NlZbL3Jheqmf3kOZvhlS4Qe9LlVBF0IAVg+6W1CtqYB7Y7CQMRq5L1icWf75540OJoDvrrkX8GVuaelTxRrX+kMxC5CLfFD/1QewXdX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4210RwthE1648710, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 4210RwthE1648710
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 1 Mar 2024 08:27:58 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.17; Fri, 1 Mar 2024 08:27:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 1 Mar 2024 08:27:58 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Fri, 1 Mar 2024 08:27:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH v2 2/4] wifi: rtw88: 8821cu: Fix connection failure
Thread-Topic: [PATCH v2 2/4] wifi: rtw88: 8821cu: Fix connection failure
Thread-Index: AQHaa19v+wWKqB4ac0G7wzzmrVA4CLEiB8tQ
Date: Fri, 1 Mar 2024 00:27:58 +0000
Message-ID: <69efc2a29fdc4ec6a9e40e542d4f2c18@realtek.com>
References: <f12ed39d-28e8-4b8b-8d22-447bcf295afc@gmail.com>
 <aeeefad9-27c8-4506-a510-ef9a9a8731a4@gmail.com>
In-Reply-To: <aeeefad9-27c8-4506-a510-ef9a9a8731a4@gmail.com>
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

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IFNlbnQ6IEZyaWRheSwgTWFyY2ggMSwgMjAy
NCA2OjM0IEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmcNCj4gQ2M6IFBp
bmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPjsgU2FzY2hhIEhhdWVyIDxzaGFAcGVuZ3V0
cm9uaXguZGU+DQo+IFN1YmplY3Q6IFtQQVRDSCB2MiAyLzRdIHdpZmk6IHJ0dzg4OiA4ODIxY3U6
IEZpeCBjb25uZWN0aW9uIGZhaWx1cmUNCj4gDQo+IENsZWFyIGJpdCA4IG9mIFJFR19TWVNfU1RB
VFVTMSBhZnRlciBNQUMgcG93ZXIgb24uDQo+IA0KPiBXaXRob3V0IHRoaXMsIHNvbWUgUlRMODgy
MUNVIGFuZCBSVEw4ODExQ1UgY2Fubm90IGNvbm5lY3QgdG8gYW55DQo+IG5ldHdvcms6DQo+IA0K
PiBGZWIgMTkgMTM6MzM6MTEgaWRlYXBhZDIga2VybmVsOiB3bHAzczBmM3UyOiBzZW5kIGF1dGgg
dG8NCj4gICAgICAgICA5MDo1NTpkZTpfXzpfXzpfXyAodHJ5IDEvMykNCj4gRmViIDE5IDEzOjMz
OjEzIGlkZWFwYWQyIGtlcm5lbDogd2xwM3MwZjN1Mjogc2VuZCBhdXRoIHRvDQo+ICAgICAgICAg
OTA6NTU6ZGU6X186X186X18gKHRyeSAyLzMpDQo+IEZlYiAxOSAxMzozMzoxNCBpZGVhcGFkMiBr
ZXJuZWw6IHdscDNzMGYzdTI6IHNlbmQgYXV0aCB0bw0KPiAgICAgICAgIDkwOjU1OmRlOl9fOl9f
Ol9fICh0cnkgMy8zKQ0KPiBGZWIgMTkgMTM6MzM6MTUgaWRlYXBhZDIga2VybmVsOiB3bHAzczBm
M3UyOiBhdXRoZW50aWNhdGlvbiB3aXRoDQo+ICAgICAgICAgOTA6NTU6ZGU6X186X186X18gdGlt
ZWQgb3V0DQo+IA0KPiBUaGUgUlRMODgyMkNVIGFuZCBSVEw4ODIyQlUgb3V0LW9mLXRyZWUgZHJp
dmVycyBkbyB0aGlzIGFzIHdlbGwsIHNvIGRvDQo+IGl0IGZvciBhbGwgdGhyZWUgdHlwZXMgb2Yg
Y2hpcHMuDQo+IA0KPiBUZXN0ZWQgd2l0aCBSVEw4ODExQ1UgKFRlbmRhIFU5IFYyLjApLg0KPiAN
Cj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5j
b20+DQoNCkFja2VkLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0K

