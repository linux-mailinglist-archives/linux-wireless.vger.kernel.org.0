Return-Path: <linux-wireless+bounces-8236-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C7BAF8D2976
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 02:35:25 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 781BE1F258C6
	for <lists+linux-wireless@lfdr.de>; Wed, 29 May 2024 00:35:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 184A317E8E4;
	Wed, 29 May 2024 00:35:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E92D41598E9
	for <linux-wireless@vger.kernel.org>; Wed, 29 May 2024 00:35:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716942921; cv=none; b=sW8/Mzj4o95lBLuArscuONNpG7dJDVk6DGXDVNkSsmw3G1xQhv+phQFZdcZYX4P3dkEWB8nQYJk/nHR3p/rgnynqJvnkHUSOFEsAL6CLiZa0Agb9RLt5WyoLTCD6CMfkL9vUwJFWP2UciZII9sUe497hTtKTGIXvtAxQrALl5Qo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716942921; c=relaxed/simple;
	bh=0aS4vRmq2pfL1MXF9ffmx4szgM63mh3wQoR0Dhl1Jyw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=s/2KZtruxG5hJ8mhjcCDuKd8zo6oCU6+5t07f2I4PujrXYUR3I22iDeFzllK//yLz1CyUylyFIhvwm5w4s7KmXJ1ky7ikqrwDeqTJbDpOrHHCAywgmVEpNuVq2SDAksI4jjonrve0y5S/ProiNwKnKAbdSEf6uPxDRHX3eWAgJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44T0YwqT62929896, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44T0YwqT62929896
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 29 May 2024 08:34:58 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 29 May 2024 08:34:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 29 May 2024 08:34:58 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Wed, 29 May 2024 08:34:58 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "wens@kernel.org" <wens@kernel.org>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 4/4] wireless-regdb: Update regulatory info for Thailand (TH) on 6GHz
Thread-Topic: [PATCH 4/4] wireless-regdb: Update regulatory info for Thailand
 (TH) on 6GHz
Thread-Index: AQHarBHOhgVkAx4V/0aivjy5oRx09bGsLw6AgAE3VcA=
Date: Wed, 29 May 2024 00:34:58 +0000
Message-ID: <9df191b4b4a848339afc6f9b765f1e6f@realtek.com>
References: <20240522062835.69628-1-pkshih@realtek.com>
 <20240522062946.69832-1-pkshih@realtek.com>
 <CAGb2v65zyPyeE+=hJSPEVLmsSOHimMK2vWVxS5kQ6FzRrWTMYw@mail.gmail.com>
In-Reply-To: <CAGb2v65zyPyeE+=hJSPEVLmsSOHimMK2vWVxS5kQ6FzRrWTMYw@mail.gmail.com>
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

Q2hlbi1ZdSBUc2FpIDx3ZW5zQGtlcm5lbC5vcmc+IHdyb3RlOg0KPiANCj4gT24gV2VkLCBNYXkg
MjIsIDIwMjQgYXQgMjozMOKAr1BNIFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPiB3
cm90ZToNCj4gPg0KPiA+IFRoZSBCcm9hZGNhc3RpbmcgQ29tbWlzc2lvbiBUZWxldmlzaW9uIGJ1
c2luZXNzIGFuZCB0aGUgTmF0aW9uYWwNCj4gPiBUZWxlY29tbXVuaWNhdGlvbnMgQ29tbWlzc2lv
biBhbm5vdW5jZWQgVGVjaG5pY2FsIHN0YW5kYXJkcyBmb3INCj4gPiB0ZWxlY29tbXVuaWNhdGlv
bnMgZXF1aXBtZW50IGFuZCBlcXVpcG1lbnQgZm9yIHJhZGlvY29tbXVuaWNhdGlvbiBlcXVpcG1l
bnQNCj4gPiB0aGF0IHVzZXMgdGhlIGZyZXF1ZW5jeSA1LjkyNSAtIDYuNDI1IEdIeiBbMl0sIHdo
aWNoIHNlY3Rpb24gMi4xIGRlc2NyaWJlcw0KPiA+IGUuaS5yLnAuIChFcXVpdmFsZW50IElzb3Ry
b3BpY2FsbHkgUmFkaWF0ZWQgUG93ZXIpIGlzIDI1MG1XIGFuZCAyNW1XIGZvcg0KPiA+IGluZG9v
ciBhbmQgaW5kb29yL291dGRvb3IgcmVzcGVjdGl2ZWx5Lg0KPiA+DQo+ID4gWzFdIGh0dHBzOi8v
cmF0Y2hha2l0Y2hhLnNvYy5nby50aC9kb2N1bWVudHMvMTQwRDEwMFMwMDAwMDAwMDA0MDAwLnBk
Zg0KPiA+IFsyXSBodHRwczovL3JhdGNoYWtpdGNoYS5zb2MuZ28udGgvZG9jdW1lbnRzLzE0MEQx
MDBTMDAwMDAwMDAwNDIwMC5wZGYNCj4gPiBbM10gaHR0cHM6Ly9yYXRjaGFraXRjaGEuc29jLmdv
LnRoL2RvY3VtZW50cy8xNDBEMTAwUzAwMDAwMDAwMDQzMDAucGRmDQo+ID4NCj4gPiBTaWduZWQt
b2ZmLWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZGIudHh0IHwgNSArKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgNSBpbnNlcnRpb25zKCspDQo+
ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZGIudHh0IGIvZGIudHh0DQo+ID4gaW5kZXggMDIyZWNiMzcx
OWI2Li5jNzAwOGUyM2I3Y2EgMTAwNjQ0DQo+ID4gLS0tIGEvZGIudHh0DQo+ID4gKysrIGIvZGIu
dHh0DQo+ID4gQEAgLTE3MDIsMTIgKzE3MDIsMTcgQEAgY291bnRyeSBURzogREZTLUVUU0kNCj4g
PiAgICAgICAgICg1MjUwIC0gNTMzMCBAIDQwKSwgKDIwKSwgREZTDQo+ID4gICAgICAgICAoNTQ5
MCAtIDU3MTAgQCA0MCksICgyNyksIERGUw0KPiA+DQo+ID4gKyMgU291cmNlOg0KPiA+ICsjIGh0
dHBzOi8vcmF0Y2hha2l0Y2hhLnNvYy5nby50aC9kb2N1bWVudHMvMTQwRDEwMFMwMDAwMDAwMDA0
MDAwLnBkZg0KPiA+ICsjIGh0dHBzOi8vcmF0Y2hha2l0Y2hhLnNvYy5nby50aC9kb2N1bWVudHMv
MTQwRDEwMFMwMDAwMDAwMDA0MjAwLnBkZg0KPiA+ICsjIGh0dHBzOi8vcmF0Y2hha2l0Y2hhLnNv
Yy5nby50aC9kb2N1bWVudHMvMTQwRDEwMFMwMDAwMDAwMDA0MzAwLnBkZg0KPiA+ICBjb3VudHJ5
IFRIOiBERlMtRkNDDQo+ID4gICAgICAgICAoMjQwMiAtIDI0ODIgQCA0MCksICgyMCkNCj4gPiAg
ICAgICAgICg1MTcwIC0gNTI1MCBAIDgwKSwgKDE3KSwgQVVUTy1CVw0KPiA+ICAgICAgICAgKDUy
NTAgLSA1MzMwIEAgODApLCAoMjQpLCBERlMsIEFVVE8tQlcNCj4gPiAgICAgICAgICg1NDkwIC0g
NTczMCBAIDE2MCksICgyNCksIERGUw0KPiA+ICAgICAgICAgKDU3MzUgLSA1ODM1IEAgODApLCAo
MzApDQo+ID4gKyAgICAgICAoNTkyNSAtIDY0MjUgQCAzMjApLCAoMjUgbVcpDQo+IA0KPiBPdGhl
ciBlbnRyaWVzIHdpdGggZGlmZmVyZW50IHBvd2VyIGxpbWl0cyBmb3IgaW5kb29yIGFuZCBvdXRk
b29yIHVzYWdlDQo+IHNlZW0gdG8gZmF2b3IgaGlnaGVyIHBvd2VyIGZvciBpbmRvb3Itb25seSB1
c2FnZS4gQW55IHJlYXNvbiB0byBnbyB0aGUNCj4gb3RoZXIgd2F5Pw0KDQpObyBzdHJvbmcgcmVh
c29uLiBXaWxsIGFkb3B0IGhpZ2hlciBwb3dlciBieSB2Mi4gVGhhbmtzLg0KDQpQaW5nLUtlDQoN
Cg==

