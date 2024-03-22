Return-Path: <linux-wireless+bounces-5144-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id F399988677F
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 08:31:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 324F81C239FD
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 07:31:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 04B7414A93;
	Fri, 22 Mar 2024 07:30:56 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B114B1426C
	for <linux-wireless@vger.kernel.org>; Fri, 22 Mar 2024 07:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711092655; cv=none; b=XoRyY0YLqyfStt6aXZs/UsA/lLAeaT9/iBy8frOLhkW0/UQB7Vso+rUI5EgxyvGfmzJhg/10xQQk/FxegYMoxrOK+ubNtSD2acLQn95iO3ax4WgJNhdOdz0T9Bqsh7W/zElGi/RgroASppXmpvqWjOzWM1GEziWSXKR24tZS1Cc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711092655; c=relaxed/simple;
	bh=NlxFfDHAVXID0Zy86FV5+EfsZVuQyN4Kxo+YbGgG7CA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=rKxfPWN2Bcl31QtZnIK2yWPyCCPnJKb4pkAKMxXcuvtwqFQKXvonkMqjDlccqbWfqD563UzXaKuU998T63w9olYGaq1Ve506uAxVnENH7E3ZioIT7zChTJhEQaacDHmABPmku/HtAK4vZRqJha/ZsMnnuKgV18Wu93vaoRBAXUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42M7UoIjA1546680, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42M7UoIjA1546680
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 15:30:50 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 15:30:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 15:30:49 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Fri, 22 Mar 2024 15:30:49 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?5pa95bCP5LiwKOWMu+eUqOWItuWTgeS6p+S4mumbhuWboi3ljLvnlKjliLY=?=
 =?utf-8?B?5ZOB6ZuG5Zui5pys6YOoKQ==?= <shixiaofeng@weigaogroup.com>,
        linux-wireless <linux-wireless@vger.kernel.org>
Subject: RE: Is RTL8822CE with Kernel 6.1 for imx6
Thread-Topic: Is RTL8822CE with Kernel 6.1 for imx6
Thread-Index: AQHae6GreAtxLBDbLkylo+A0KBQKpbFDXUwg
Date: Fri, 22 Mar 2024 07:30:49 +0000
Message-ID: <a0aa71e3ca0e42f09abf658401070208@realtek.com>
References: <AF*AOABLHt4n7diA--9SIKqg.1.1711026798731.Hmail.shixiaofeng@weigaogroup.com>
In-Reply-To: <AF*AOABLHt4n7diA--9SIKqg.1.1711026798731.Hmail.shixiaofeng@weigaogroup.com>
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

DQoNCkZyb206IOaWveWwj+S4sCjljLvnlKjliLblk4HkuqfkuJrpm4blm6It5Yy755So5Yi25ZOB
6ZuG5Zui5pys6YOoKSA8c2hpeGlhb2ZlbmdAd2VpZ2FvZ3JvdXAuY29tPiANClNlbnQ6IFRodXJz
ZGF5LCBNYXJjaCAyMSwgMjAyNCA5OjEzIFBNDQpUbzogbGludXgtd2lyZWxlc3MgPGxpbnV4LXdp
cmVsZXNzQHZnZXIua2VybmVsLm9yZz4NClN1YmplY3Q6IElzIFJUTDg4MjJDRSB3aXRoIEtlcm5l
bCA2LjEgZm9yIGlteDYNCg0KPiByb290QGlteDZzb2xvc2FicmVzZDp+Lzg4MjJDRSMgLi9pbnNt
b2Quc2gNCj4gWyAgIDYwLjU0MTg0MF0gcnR3Xzg4MjJjZSAwMDAwOjAxOjAwLjA6IGVuYWJsaW5n
IGRldmljZSAoMDAwMCAtPiAwMDAzKQ0KPiBbICAgNjAuNTU4MTQ1XSBydHdfODgyMmNlIDAwMDA6
MDE6MDAuMDogRmlybXdhcmUgdmVyc2lvbiA5LjkuNCwgSDJDIHZlcnNpb24gMTUNCj4gWyAgIDYw
LjU2NzEzNV0gcnR3Xzg4MjJjZSAwMDAwOjAxOjAwLjA6IEZpcm13YXJlIHZlcnNpb24gOS45LjE1
LCBIMkMgdmVyc2lvbiAxNQ0KPiBbICAgNjAuNzA2Njk3XSA4PC0tLSBjdXQgaGVyZSAtLS0NCj4g
WyAgIDYwLjcwOTc3NV0gVW5oYW5kbGVkIGZhdWx0OiBpbXByZWNpc2UgZXh0ZXJuYWwgYWJvcnQg
KDB4MTQwNikgYXQgMHgwMWI3Nzc0MA0KPiBbICAgNjAuNzE2ODMyXSBbMDFiNzc3NDBdICpwZ2Q9
MDAwMDAwMDANCj4gWyAgIDYwLjcyMDQyMV0gSW50ZXJuYWwgZXJyb3I6IDogMTQwNiBbIzFdIFBS
RUVNUFQgU01QIEFSTQ0KPiBbICAgNjAuNzI1NjUzXSBNb2R1bGVzIGxpbmtlZCBpbjogcnR3ODhf
ODgyMmNlKCspIHJ0dzg4Xzg4MjJjIHJ0dzg4X3BjaSBydHc4OF9jb3JlDQo+IFsgICA2MC43MzI5
OTFdIENQVTogMCBQSUQ6IDc5NiBDb21tOiBpbnNtb2QgTm90IHRhaW50ZWQgNi4xLjIyLWc5YzU5
YjE1YTllNzIgIzENCj4gWyAgIDYwLjc0MDA0OV0gSGFyZHdhcmUgbmFtZTogRnJlZXNjYWxlIGku
TVg2IFF1YWQvRHVhbExpdGUgKERldmljZSBUcmVlKQ0KPiBbICAgNjAuNzQ2NTgwXSBQQyBpcyBh
dCBydHdfcGNpX3JlYWQzMisweDE0LzB4MTggW3J0dzg4X3BjaV0NCj4gWyAgIDYwLjc1MjAxNV0g
TFIgaXMgYXQgcnR3X2NoaXBfaW5mb19zZXR1cCsweDQ4LzB4NTg4IFtydHc4OF9jb3JlXQ0KPiBb
ICAgNjAuNzU4MTcwXSBwYyA6IFs8N2YwMjYwNDg+XSAgICBsciA6IFs8N2YwMDAxYzA+XSAgICBw
c3I6IDYwMDEwMDEzDQo+IFsgICA2MC43NjQ0NDJdIHNwIDogYzFkMGRkMjggIGlwIDogMDAwMDAy
MDEgIGZwIDogODkzNDQwNDANCj4gWyAgIDYwLjc2OTY3MF0gcjEwOiA4OGIzOTdhMCAgcjkgOiA4
OGIzZjg5MCAgcjggOiAwMDAwMDIwMA0KPiBbICAgNjAuNzc0ODk3XSByNyA6IDAwMDAwM2RhICBy
NiA6IDAwMDAwM2Q5ICByNSA6IDdmMDNhMmM4ICByNCA6IDg4YjM5N2EwDQo+IFsgICA2MC43ODE0
MjhdIHIzIDogYzA5MjAwZjAgIHIyIDogMDAwMDAwMDAgIHIxIDogMDAwMDAwZjAgIHIwIDogMDAw
MDAwMDANCj4gWyAgIDYwLjc4Nzk1OV0gRmxhZ3M6IG5aQ3YgIElSUXMgb24gIEZJUXMgb24gIE1v
ZGUgU1ZDXzMyICBJU0EgQVJNICBTZWdtZW50IG5vbmUNCj4gWyAgIDYwLjc5NTEwMF0gQ29udHJv
bDogMTBjNTM4N2QgIFRhYmxlOiAxNWQxMDA1OSAgREFDOiAwMDAwMDA1MQ0KPiBbICAgNjAuODAw
ODQ4XSBSZWdpc3RlciByMCBpbmZvcm1hdGlvbjogTlVMTCBwb2ludGVyDQo+IFsgICA2MC44MDU1
NjRdIFJlZ2lzdGVyIHIxIGluZm9ybWF0aW9uOiBub24tcGFnZWQgbWVtb3J5DQo+IFsgICA2MC44
MTA2MjBdIFJlZ2lzdGVyIHIyIGluZm9ybWF0aW9uOiBOVUxMIHBvaW50ZXINCg0KVGhlIHJ0d19w
Y2lfcmVhZDMyKCkgaXMgdmVyeSBzaW1wbGUgdGhhdCBqdXN0IHVzZSAncnR3cGNpLT5tbWFwJyBh
cyBhZGRyZXNzLA0Kc28gSSB3b25kZXIgdGhpcyBleGNlcHRpb24gaXMgY2F1c2VkIGJ5IE5VTEwg
b2YgcnR3cGNpLT5tbWFwLg0KDQpCdXQsIHJ0d19wY2lfaW9fbWFwcGluZygpIGhhcyBoYW5kbGVk
IHRoZSBOVUxMIGNhc2U6DQoNCnN0YXRpYyBpbnQgcnR3X3BjaV9pb19tYXBwaW5nKHN0cnVjdCBy
dHdfZGV2ICpydHdkZXYsDQoJCQkgICAgICBzdHJ1Y3QgcGNpX2RldiAqcGRldikNCnsNCgkuLi4N
Cg0KCXJ0d3BjaS0+bW1hcCA9IHBjaV9pb21hcChwZGV2LCBiYXJfaWQsIGxlbik7DQoJaWYgKCFy
dHdwY2ktPm1tYXApIHsNCgkJcGNpX3JlbGVhc2VfcmVnaW9ucyhwZGV2KTsNCgkJcnR3X2Vycihy
dHdkZXYsICJmYWlsZWQgdG8gbWFwIHBjaSBtZW1vcnlcbiIpOw0KCQlyZXR1cm4gLUVOT01FTTsN
Cgl9DQoJLi4uDQp9DQoNClNvLCBkaWQgeW91IGNoYW5nZSBzb21ldGhpbmcgZm9yIHlvdXIgYm9h
cmQ/IA0KDQpQaW5nLUtlDQoNCg==

