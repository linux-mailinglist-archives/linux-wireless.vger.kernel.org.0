Return-Path: <linux-wireless+bounces-7575-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DD8198C3B54
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 08:30:14 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 19EAAB2103A
	for <lists+linux-wireless@lfdr.de>; Mon, 13 May 2024 06:30:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E03DF14659C;
	Mon, 13 May 2024 06:29:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D663146A68
	for <linux-wireless@vger.kernel.org>; Mon, 13 May 2024 06:29:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715581782; cv=none; b=taE30aLmBgHVSC4pndhaKjy8t/xPmCXrd1DcZo3E6Dtn1MiAjx6G61sb6w5QcMi6eEiVFoqUaFhxf2v31N7xX90bjA+DxwsOhiRikYdVUc8L+rP5cs+kkm3aBOZh4Le0X1B7+cfGtQaDfeOGXS3Rj3nWpC8jvaBlvGLzwIdqXTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715581782; c=relaxed/simple;
	bh=j0czjOdGh9jRPEGzWoU1jkYZwGkwNC11RpzYbnPW/C0=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DKIuA6EIzpX5BP2npa3PGKKcORh8zwJwDgz4C5uL/LI0ltb0hgHs9KpMojigC6lLWmfQ0Y+Ls+55TXH3bc0tuqvN+GfABrxPo3O83Okm5ivSy2GHqr1/fyNNZcMPXCTnXa+l/Xj9KPVAaUXZjIqbA2jNFiwDaMjQA0x2R3iJk4Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44D6TI9b81274609, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44D6TI9b81274609
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 13 May 2024 14:29:18 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 13 May 2024 14:29:18 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 13 May 2024 14:29:18 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 13 May 2024 14:29:18 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v5 03/11] wifi: rtlwifi: Add rtl8192du/hw.{c,h}
Thread-Topic: [PATCH v5 03/11] wifi: rtlwifi: Add rtl8192du/hw.{c,h}
Thread-Index: AQHaoTVZRe2AKQHe4kKE1cdb+1P5krGPvR6ggANtewCAAUAfYA==
Date: Mon, 13 May 2024 06:29:18 +0000
Message-ID: <687545afc58b4b80ace904e26561b151@realtek.com>
References: <254558da-ea8b-40ea-bd5a-83d13796744f@gmail.com>
 <d5d52f8d-585d-43a6-a5e6-076f24ba8410@gmail.com>
 <31f28650173d40cf85fb57f87949eef7@realtek.com>
 <d104ea7f-5a88-4081-a651-c25a88a2acf7@gmail.com>
In-Reply-To: <d104ea7f-5a88-4081-a651-c25a88a2acf7@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
T24gMTAvMDUvMjAyNCAwNjowNCwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IEJpdHRlcmJsdWUg
U21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPiB3cm90ZToNCj4gPg0KPiA+PiArDQo+ID4+
ICtpbnQgcnRsOTJkdV9od19pbml0KHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3KQ0KPiA+PiArew0K
PiA+PiArICAgICAgIHN0cnVjdCBydGxfdXNiX3ByaXYgKnVzYl9wcml2ID0gcnRsX3VzYnByaXYo
aHcpOw0KPiA+PiArICAgICAgIHN0cnVjdCBydGxfdXNiICpydGx1c2IgPSBydGxfdXNiZGV2KHVz
Yl9wcml2KTsNCj4gPj4gKyAgICAgICBzdHJ1Y3QgcnRsX3ByaXYgKnJ0bHByaXYgPSBydGxfcHJp
dihodyk7DQo+ID4+ICsgICAgICAgc3RydWN0IHJ0bF9wc19jdGwgKnBwc2MgPSBydGxfcHNjKHJ0
bHByaXYpOw0KPiA+PiArICAgICAgIHN0cnVjdCBydGxfaGFsICpydGxoYWwgPSBydGxfaGFsKHJ0
bHByaXYpOw0KPiA+PiArICAgICAgIHN0cnVjdCBydGxfbWFjICptYWMgPSBydGxfbWFjKHJ0bHBy
aXYpOw0KPiA+PiArICAgICAgIHN0cnVjdCBydGxfcGh5ICpydGxwaHkgPSAmcnRscHJpdi0+cGh5
Ow0KPiA+PiArICAgICAgIHU4IHZhbDgsIHR4cGt0YnVmX2JuZHk7DQo+ID4+ICsgICAgICAgdW5z
aWduZWQgbG9uZyBmbGFnczsNCj4gPj4gKyAgICAgICBpbnQgZXJyLCBpOw0KPiA+PiArICAgICAg
IHUzMiB2YWwzMjsNCj4gPj4gKyAgICAgICB1MTYgdmFsMTY7DQo+ID4+ICsNCj4gPj4gKyAgICAg
ICAvKiBBcyB0aGlzIGZ1bmN0aW9uIGNhbiB0YWtlIGEgdmVyeSBsb25nIHRpbWUNCj4gPj4gKyAg
ICAgICAgKiBhbmQgY2FuIGJlIGNhbGxlZCB3aXRoIGlycXMgZGlzYWJsZWQsIHJlZW5hYmxlIHRo
ZSBpcnFzDQo+ID4+ICsgICAgICAgICogdG8gbGV0IHRoZSBvdGhlciBkZXZpY2VzIGNvbnRpbnVl
IGJlaW5nIHNlcnZpY2VkLg0KPiA+PiArICAgICAgICAqDQo+ID4+ICsgICAgICAgICogSXQgaXMg
c2FmZSBkb2luZyBzbyBzaW5jZSBvdXIgb3duIGludGVycnVwdHMgd2lsbCBvbmx5IGJlIGVuYWJs
ZWQNCj4gPj4gKyAgICAgICAgKiBpbiBhIHN1YnNlcXVlbnQgc3RlcC4NCj4gPj4gKyAgICAgICAg
Ki8NCj4gPj4gKyAgICAgICBsb2NhbF9zYXZlX2ZsYWdzKGZsYWdzKTsNCj4gPj4gKyAgICAgICBs
b2NhbF9pcnFfZW5hYmxlKCk7DQo+ID4NCj4gPiBJIHRoaW5rIHlvdSBqdXN0IGNvcHkgYW5kIHBh
c3RlIHRoaXMgY2h1bmsuIEkgd29uZGVyIGlmIFVTQiBoYXMgdGhlIHNhbWUgYmVoYXZpb3I/DQo+
ID4gRHJpdmVyIGZvcmNlIHRvIGVuYWJsZSBJUlEgaXMgd2VpcmQgdG8gbWUuIFBsZWFzZSBjaGVj
ayBJIHRoaXMgaXMgcmVhbGx5IGNhbGxlZA0KPiA+IHdpdGggaXJxIGRpc2FibGVkPyBJZiBub3Qs
IHdlIGNhbiByZW1vdmUgdGhlbS4NCj4gPg0KPiANCj4gWWVzLCBJIGNvcGllZCB0aGF0LiBSZW1v
dmluZyBpdCBmcm9tIHJ0bDgxOTJkdSBtYWtlcyBubw0KPiBkaWZmZXJlbmNlIGZvciBtZS4gSSdt
IG5vdCBzdXJlIGhvdyB0byBjaGVjayBpZiB0aGUgZnVuY3Rpb24NCj4gaXMgY2FsbGVkIHdpdGgg
aXJxIGRpc2FibGVkLiBJcyBpdCByYXdfaXJxc19kaXNhYmxlZCgpID8NCj4gSXQgcmV0dXJucyAw
IGZvciBtZS4NCj4gDQoNCkkgY2FuJ3QgZmluZCBhbiBleGFjdCBkZXNjcmlwdGlvbiBhYm91dCBp
cnFzX2Rpc2FibGVkKCkgdW5kZXIgRG9jdW1lbnRhdGlvbi8uDQpUaGVuIEkgZGlkIGdvb2dsZSBz
ZWFyY2ggYW5kIGZvdW5kIGEgcGFnZSBbMV0gdGhhdCBzYXlzDQoJUmV0dXJucyBub256ZXJvIGlm
IGxvY2FsIGludGVycnVwdCBkZWxpdmVyeSBpcyBkaXNhYmxlZDsgb3RoZXJ3aXNlIHJldHVybnMg
emVybw0KDQpJIGZlZWwgaXQgaXMgZGlzYWxsb3dlZCB0byBjYWxsIG1pZ2h0IHNsZWVwaW5nIEFQ
SSAobGlrZSBtdXRleHQoKSkgd2hlbiBJUlEgaXMNCmRpc2FibGVkLiBIb3dldmVyLCBvcmlnaW5h
bCBjb2RlIGRvZXMuIFRha2UgcnRsOTJzZV9od19pbml0KCkgYXMgYW4gZXhhbXBsZQ0KDQpydGxf
b3Bfc3RhcnQoKQ0KCW11dGV4X2xvY2soJnJ0bHByaXYtPmxvY2tzLmNvbmZfbXV0ZXgpOw0KCS5h
ZGFwdGVyX3N0YXJ0ID0gcnRsX3BjaV9zdGFydCgpDQoJCXJ0bHByaXYtPmNmZy0+b3BzLT5od19p
bml0KGh3KQ0KCQkJLmh3X2luaXQgPSBydGw5MnNlX2h3X2luaXQoKQ0KCQkJCWxvY2FsX2lycV9l
bmFibGUoKTsNCgltdXRleF91bmxvY2soJnJ0bHByaXYtPmxvY2tzLmNvbmZfbXV0ZXgpOw0KDQoN
CmNhbGxlcnMgaG9sZCBscHNfbXV0ZXggb3IgaXBzX211dGV4DQoJcnRsX3BzX3NldF9yZl9zdGF0
ZSgpDQoJCS5zZXRfcmZfcG93ZXJfc3RhdGUgPSBydGw5MnNfcGh5X3NldF9yZl9wb3dlcl9zdGF0
ZSgpDQoJCQlydGxfcHNfZW5hYmxlX25pYygpDQoJCQkJcnRscHJpdi0+Y2ZnLT5vcHMtPmh3X2lu
aXQoaHcpDQoJCQkJCQkuaHdfaW5pdCA9IHJ0bDkyc2VfaHdfaW5pdCgpDQoJCQkJCQkJbG9jYWxf
aXJxX2VuYWJsZSgpOw0KDQpUaGF0IG1lYW5zIHRoaXMgZHJpdmVycyBtaWdodCBubyBuZWVkIGxv
Y2FsX2lycV9lbmFibGUoKSBub3dhZGF5cy4gQ3VycmVudGx5DQp3ZSBjYW4gb25seSByZW1vdmUg
aXQgZnJvbSBVU0IgYWRhcHRlcnMgYXMgZmlyc3Qgc3RlcC4gDQoNCg0KPiA+IFsuLi5dDQo+ID4N
Cj4gPj4gKyAgICAgICBsb2NhbF9pcnFfZGlzYWJsZSgpOw0KPiA+PiArICAgICAgIGxvY2FsX2ly
cV9yZXN0b3JlKGZsYWdzKTsNCj4gPj4gKw0KPiA+PiArICAgICAgIHJldHVybiBlcnI7DQo+ID4+
ICt9DQo+ID4+ICsNCj4gPg0KPiA+DQoNClsxXSBodHRwczovL2xpdHV4Lm5sL21pcnJvci9rZXJu
ZWxkZXZlbG9wbWVudC8wNjcyMzI3MjAxL2NoMDZsZXYxc2VjNy5odG1sDQoNCg==

