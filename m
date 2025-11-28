Return-Path: <linux-wireless+bounces-29397-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [142.0.200.124])
	by mail.lfdr.de (Postfix) with ESMTPS id 769C2C9064B
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 01:22:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 52BD14E1051
	for <lists+linux-wireless@lfdr.de>; Fri, 28 Nov 2025 00:22:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE9EC149C7B;
	Fri, 28 Nov 2025 00:22:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="MhffCCAJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE7931E3DDE
	for <linux-wireless@vger.kernel.org>; Fri, 28 Nov 2025 00:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764289355; cv=none; b=fgXvtodc1K3YLIZYS4btvrb/2EMAYjbzME2V9EA/b2Q8Mj5sjrr6dlgsQiUukC6c7YiC3S/13SnijQ+7kLEDP3/m85+Zk8jIKI/9I8GejnmsHbaeyymK/cT3WxQJLLlp0UipeKjnmmX29JOEbiFGVyrCJa1LuPjJvHcenxPK3L4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764289355; c=relaxed/simple;
	bh=WBLXsoPzr/NlT/dN6dn+Bh7OxXuyRJDGJsYGAbEznII=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=PtKQVuRUrd7QNXGLa7gOxQxm4pCDlADOV8DPcHm181fwRjBpxEMrzfAvN43LRbTjhSCrVjz0vXJFiVY/cCS2wuE/wkQlXxGa2VbMsnAfKIfV60OlK88CC1eSOOSkNhVy9aqOp7MEPnowbtCBtPaWWGupW4byRUFUuHGKfoha3EM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=MhffCCAJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AS0MCDS03836677, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1764289332; bh=WBLXsoPzr/NlT/dN6dn+Bh7OxXuyRJDGJsYGAbEznII=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=MhffCCAJ4Hli2z00f5zvNOxls+IfvYfuDhVgQ1zC85bb+zEI3FB6S1XDSB5B/DwZq
	 oSGUTaFJeg8BVmbm77lEJpTR303TWNj1gEVgUYYsfj/CU/c63auCz4/+BkFaYZVAuh
	 pwgljEGH1U79tD/0YZ6MBuaS+PMoZhHkMIBBxxQENEjGvK4AlFTccGiHPioIDMAXWJ
	 zzXuYgu+XOyUnvzSWdG5GVzuCne6a9FfLllpX+WFsixaOy429oUwXzPLGJ1lcja+M9
	 mLowSh6ocUgz7GsNbJrKrAhXRY1aj8xybi8ZLfit49FrRMFsQp+/hslLfY+o0mW8JT
	 2zlwjfaEaGprQ==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AS0MCDS03836677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 28 Nov 2025 08:22:12 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Fri, 28 Nov 2025 08:22:12 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Fri, 28 Nov 2025 08:22:12 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Orel Lazri <hi@orellazri.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: Bug Report: System slow down and hang with rtw89 driver under
 load
Thread-Topic: Bug Report: System slow down and hang with rtw89 driver under
 load
Thread-Index: AQHcX8HlIEuXB6oQwE6RUwoYRLsI7bUHN14A
Date: Fri, 28 Nov 2025 00:22:12 +0000
Message-ID: <84497c2d6b2941b4b664ae122a7be48a@realtek.com>
References: <8c32f4e8-b5fb-4c3e-ba2f-06c03d826fe8@orellazri.com>
In-Reply-To: <8c32f4e8-b5fb-4c3e-ba2f-06c03d826fe8@orellazri.com>
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

T3JlbCBMYXpyaSA8aGlAb3JlbGxhenJpLmNvbT4gd3JvdGU6DQo+IERlYXIgUGluZy1LZSBTaGlo
LA0KPiANCj4gSSBhbSBlbmNvdW50ZXJpbmcgYW4gdW5wcmVkaWN0YWJsZSBidWcgd2l0aCB0aGUg
UmVhbHRlayBydHc4OSB3aXJlbGVzcw0KPiBkcml2ZXIgKHJ0dzg5Xzg5MjJhZSkgb24gbXkgc3lz
dGVtLiBTb21ldGltZXMsIGVzcGVjaWFsbHkgd2hlbg0KPiBkb3dubG9hZGluZyBmaWxlcyBvciB1
bmRlciBoZWF2aWVyIG5ldHdvcmsgbG9hZCwgbXkgc3lzdGVtIHNsb3dzIGRvd24NCj4gc2lnbmlm
aWNhbnRseSBhbmQgZXZlbnR1YWxseSBoYW5ncy4NCg0KSG93IGhlYXZ5IGlzIHRoZSBuZXR3b3Jr
IGxvYWQ/DQoNCiJzeXN0ZW0gc2xvd3MgZG93biIgbWVhbnMgd2hvbGUgc3lzdGVtIGJlY29tZSBs
YWc/IE9yIG5ldHdvcmsgc2xvd3M/DQoiaGFuZ3MiIHJlZmVycyB0byBuZXR3b3JrIChXaUZpKT8g
b3Igc3lzdGVtPw0KDQo+IA0KPiBJbiB0aGUga2VybmVsIGxvZyAoZG1lc2cpLCBJIG9ic2VydmUg
cmVwZWF0ZWQgbGluZXMgbGlrZSB0aGVzZSBsb29waW5nDQo+IGNvbnRpbnVvdXNseToNCj4gDQo+
IE5vdiAyNyAxODowNjoyMiBkZXNrdG9wIGtlcm5lbDogcnR3ODlfODkyMmFlIDAwMDA6MDc6MDAu
MDogbm8gdHggZndjbWQNCj4gcmVzb3VyY2UNCj4gTm92IDI3IDE4OjA2OjIyIGRlc2t0b3Aga2Vy
bmVsOiBydHc4OV84OTIyYWUgMDAwMDowNzowMC4wOiBmYWlsZWQgdG8NCj4gc2VuZCBoMmMNCg0K
Tm9ybWFsbHksIHRoaXMgaXMgYmVjYXVzZSBvZiBmaXJtd2FyZSBzdG9wcGVkLiANCg0KPiANCj4g
SSBoYXZlIGF0dGFjaGVkIGEgc25pcHBldCBvZiB0aGUgZG1lc2cgbG9nIHRoYXQgaW5jbHVkZXMg
dGhlc2UgYW5kIG90aGVyDQo+IHJlbGV2YW50IGxpbmVzIGZvciB5b3VyIHJlZmVyZW5jZSwgYWxv
bmcgd2l0aCB0aGUgb3V0cHV0IG9mIHRoZQ0KPiB2ZXJfbGludXggc2NyaXB0IGFuZCBzb21lIG1v
cmUgcG90ZW50aWFsbHkgdXNlZnVsIGluZm9ybWF0aW9uLg0KPiANCj4gSSdtIHJ1bm5pbmcgb24g
a2VybmVsIHJlbGVhc2UgIjYuMTcuOC1hcmNoMS0xIiwgYW5kIHRoaXMgaXMgdGhlIHdpcmVsZXNz
DQo+IE5JQyBpbiBteSBtb3RoZXJib2FyZDoNCj4gDQo+IDA3OjAwLjAgTmV0d29yayBjb250cm9s
bGVyIFswMjgwXTogUmVhbHRlayBTZW1pY29uZHVjdG9yIENvLiwgTHRkLg0KPiBSVEw4OTIyQUUg
ODAyLjExYmUgUENJZSBXaXJlbGVzcyBOZXR3b3JrIEFkYXB0ZXIgWzEwZWM6ODkyMl0gKHJldiAw
MSkNCj4gICAgICAgICAgU3Vic3lzdGVtOiBSZWFsdGVrIFNlbWljb25kdWN0b3IgQ28uLCBMdGQu
IFJUTDg5MjJBRSA4MDIuMTFiZQ0KPiBQQ0llIFdpcmVsZXNzIE5ldHdvcmsgQWRhcHRlciBbMTBl
Yzo4OTIyXQ0KPiAgICAgICAgICBLZXJuZWwgZHJpdmVyIGluIHVzZTogcnR3ODlfODkyMmFlDQo+
ICAgICAgICAgIEtlcm5lbCBtb2R1bGVzOiBydHc4OV84OTIyYQ0KPiANCj4gUGxlYXNlIGxldCBt
ZSBrbm93IGlmIHlvdSBuZWVkIGFueSBhZGRpdGlvbmFsIGluZm9ybWF0aW9uIG9yIGlmIEkgY2Fu
DQo+IGhlbHAgdGVzdCBwb3RlbnRpYWwgZml4ZXMuDQoNClNvbWUgcXVlc3Rpb25zIGFuZCBhY3Rp
b25zOg0KMS4gV2hhdCdzIHRoZSBmaXJtd2FyZSB2ZXJzaW9uIHlvdSBhcmUgdXNpbmc/IA0KICAg
KHNlZSBrZXJuZWwgbG9nIHdoZW4gaXQgcHJvYmVzIFJUTDg5MjJBRSkNCjIuIFRoZSBhdHRhY2ht
ZW50IHNob3dzIHRoYXQgU0VSIGhhcHBlbmVkLiBUaGF0IG1lYW5zIGhhcmR3YXJlIG9yIGZpcm13
YXJlDQogICBnZXRzIGFibm9ybWFsLiBQbGVhc2UgY29sbGVjdCBtb3JlIGluc3RhbnRzIGZvciB1
cy4NCjMuIFR1cm5pbmcgb2ZmIFdpRmkgcG93ZXIgc2F2ZSBjb3VsZCBoZWxwPyANCiAgIHN1ZG8g
aXcgd2xhbjAgc2V0IHBvd2VyX3NhdmUgb2ZmDQo0LiBUdXJuaW5nIG9mZiBBU1BNIGZvbGxvd3Mg
TGFycnkncyBSRUFETUUgWzFdLg0KDQpbMV0gaHR0cHM6Ly9naXRodWIuY29tL2x3ZmluZ2VyL3J0
dzg5ICBmaWxlOiA3MC1ydHc4OS5jb25mDQoNCg0KDQoNCg0K

