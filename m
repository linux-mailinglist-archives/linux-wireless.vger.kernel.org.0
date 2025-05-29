Return-Path: <linux-wireless+bounces-23481-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B192AC7564
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 03:33:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0D1FB4E5B4D
	for <lists+linux-wireless@lfdr.de>; Thu, 29 May 2025 01:33:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A2B23BBF2;
	Thu, 29 May 2025 01:33:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="pEWOUscQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA2E31E4AE
	for <linux-wireless@vger.kernel.org>; Thu, 29 May 2025 01:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748482380; cv=none; b=oS7hlv9VFxRvXwdWhB07gIttf4w0gDfpByJHiN4IlWeTeG+Ce+K5jZJ/pheb+W7fsiCJBWz5t4YMTkd1vRMEXydHn4ZC8pLH3fPg3wLLPIVOMCmqxXwDf8Sd55hCPstKd/FaANYySSm5wbWGumqsLR4kYfK9w0BdN3p3m/303jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748482380; c=relaxed/simple;
	bh=pY9Qx6rqcekrpDgu1zj0OrIfT0wTWwWVZqikQZIpivM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=SN/qYbFh9iBywh+Nz5YaQeMvwP7j6qPjbhFCKipl7nVAjBpWeBy97TEzn6BQ6KDg51PqmD0DUIOfJ+F8kDcTNCk5rZNKIDSKYWqMwdm/AfPR46w8T6KI7GTUN1DYIuuNXl89AoR0RqZjchrHKnG1Y11YW62OVksk/uABs0N/vPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=pEWOUscQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54T1WjqP6550991, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1748482365; bh=pY9Qx6rqcekrpDgu1zj0OrIfT0wTWwWVZqikQZIpivM=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=pEWOUscQVXyCXFtlN1/JCcOPcimjp69CwbKQSlA0KpexCx5GgxWEbzDOFxHBh41jr
	 c+zWESGI4Q9/00F5DNDqT0yIRpwsGvfznrmdFqZBUVkkFCfKXDhUZSfTZwXUy0xOlx
	 UO8cyRBRGvMWbI567JczUUBBuuocE4gdvJ+4BWhYxeAWbi0ti3zAOIcGb1M0LI0WDz
	 5wlEtbiaZN1TTHpUhERK62pBR94Olwm6aFwn7mRRix7uPDwchUkd5FqtgqiNY0K76g
	 vhZ8PtFhwNIKOlYHoWDJtCKAFpj+X2CpuTvaYWySA1lGdLSPqAsRm0grHAXXOaJOQV
	 v5L5bQD7tmqyQ==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54T1WjqP6550991
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 May 2025 09:32:45 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 29 May 2025 09:32:45 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 May 2025 09:32:45 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Thu, 29 May 2025 09:32:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Dominique Martinet <asmadeus@codewreck.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: rtw89: array-index-out-of-bounds in rtw89_pci_release_rpp()
Thread-Topic: rtw89: array-index-out-of-bounds in rtw89_pci_release_rpp()
Thread-Index: AQHbz96TF6hj8g4RikiyypN3tA6bF7Poza8Q
Date: Thu, 29 May 2025 01:32:44 +0000
Message-ID: <931eb77003ff469a835848cd462dae35@realtek.com>
References: <aDcgcjNp3fRT9PZf@codewreck.org>
In-Reply-To: <aDcgcjNp3fRT9PZf@codewreck.org>
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

RG9taW5pcXVlIE1hcnRpbmV0IDxhc21hZGV1c0Bjb2Rld3JlY2sub3JnPiB3cm90ZToNCj4gT24g
bXkgbWFjaGluZSBJIHNvbWV0aW1lcyBnZXQgYSBrZXJuZWwgcGFuaWMgd2hlbiB0aGUgd2lyZWxl
c3MgZHJpdmVyDQo+IGNyYXNoZXMgKGZ3IGR1bXApDQoNCkJ5IHRoZSBsb2csIGZpcm13YXJlIGRp
ZCBkZXRlY3QgaGFyZHdhcmUgYWJub3JtYWwgYW5kIHJlc2V0IGl0LCBidXQgc29tZWhvdw0KaGFy
ZHdhcmUgc3RpbGwgY2FuJ3Qgd29yayBwcm9wZXJseS4gRHJpdmVyIGdvdCB3cm9uZyBkYXRhIGFu
ZCB0aHJldyANCiJDYW5ub3QgbWFwIHFzZWwgdG8gZG1hOiAzMSIgYmVmb3JlIFVCU0FOIHdhcm5p
bmcuDQoNCkkgZ3Vlc3MgYXQgdGhhdCBtb21lbnQsIGRyaXZlciBnb3Qgd3JvbmcgYW5kIHVuZXhw
ZWN0ZWQgdmFsdWUgMHhmZmZmZmZmZi4gDQoNCk15IHN1Z2dlc3Rpb25zIGFyZToNCg0KKDEpIFRo
ZSBsYXRlc3QgZmlybXdhcmUgb2YgUlRMODg1MkJURSBpcyAwLjI5LjEyMi4wLiBQbGVhc2UgdHJ5
IGl0Lg0KDQooMikgVG8gZGlzYWJsZSBQQ0kgQVNQTSBpcyBhbHNvIHdvcnRoIHRvIHRyeToNCg0K
ICAgL2V0Yy9tb2Rwcm9iZS5kLzcwLXJ0dzg5LmNvbmYgDQogICBvcHRpb25zIHJ0dzg5X3BjaSBk
aXNhYmxlX2FzcG1fbDFzcz15IGRpc2FibGVfYXNwbV9sMT15IGRpc2FibGVfY2xrcmVxPXkNCiAg
IG9wdGlvbnMgcnR3ODlfY29yZSBkaXNhYmxlX3BzX21vZGU9eQ0KDQogICBBZnRlciBzZXR1cCB0
aGVzZSBvcHRpb25zLCB5b3UgbmVlZCB0byBjb2xkIHJlYm9vdCB5b3VyIG1hY2hpbmUgdG8NCiAg
IG1ha2Ugc3VyZSBBU1BNIGlzbid0IGVuYWJsZWQuIEFsc28sIHBsZWFzZSBjaGVjayB0aGUgc2V0
dGluZyB2aWENCiAgIC9zeXMvbW9kdWxlL3J0dzg5X3BjaS9wYXJhbWV0ZXJzLyBhZnRlciByZWJv
b3RpbmcuIA0KDQooMykgQW5vdGhlciBpcyB0byBkaXNhYmxlIHBvd2VyIHNhdmUgbW9kZSB2aWEN
CiAgIHN1ZG8gaXcgd2xhbjAgc2V0IHBvd2VyX3NhdmUgb2ZmDQoNCiAgIElmIHRoaXMgY2FuIHdv
cmsgdG8geW91LCB5b3UgY2FuIGFkZCBvcHRpb24gdG8gY29uZmlndXJhdGlvbiBmaWxlIG9mDQog
ICBuZXR3b3JrIG1hbmFnZXIgdG8gZGlzYWJsZSBpdC4gDQoNCj4gDQo+IFRoZSBsaW5lIGluIHF1
ZXN0aW9uIHdvdWxkIGJlIHRoaXMgbGluZToNCj4gPiAgICAgICAgdHh3ZCA9ICZ3ZF9yaW5nLT5w
YWdlc1tzZXFdOw0KPiAod2hpY2ggbWF0Y2hlcyBhcyBwYWdlcyBpcyBhbiBhcnJheSBvZiA1MTIg
cnR3ODlfcGNpX3R4X3dkIHN0cnVjdHMpDQo+IA0KPiANCj4gQ2hlY2tpbmcgc2VxIDwgUlRXODlf
UENJX1RYV0RfTlVNX01BWCBpcyB0cml2aWFsIGFuZCBJIGNvdWxkIHNlbmQgYQ0KPiBwYXRjaCwg
YnV0IGlmIHRoYXQgZGF0YSBpcyByZWFsbHkgYm9ndXMgSSBhc3N1bWUgYW55IGxvY2FsIGNoZWNr
IGNvdWxkDQo+IGJlIGZvb2xlZCBlLmcuIHRoZSBkYXRhIGNvdWxkIGJlIDwgNTEyIGFuZCBzdGls
bCBpbmNvcnJlY3QuDQoNCllvdSdyZSByaWdodC4gDQoNCg0K

