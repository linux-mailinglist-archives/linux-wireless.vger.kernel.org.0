Return-Path: <linux-wireless+bounces-11467-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 89D589529B9
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 09:16:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3FB4C283D12
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 07:16:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3C26E15D5D9;
	Thu, 15 Aug 2024 07:16:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="WZPvQS6b"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12E6815CD52
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 07:16:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723706198; cv=none; b=eLazpB0fFKdM0dx3HbtA1tAOiVO156YT7TfTf1E6QjwhytFqp2vGsiuMaLu6ldChO4v8lgTWIymqDX6A03wnys1qztm1a5IGNuYAmw2kA5dKgRzEDkg0bbVHrn+zRs36DV+aF57sLyNlpBiCsXxviidRAItwXJK+U7xEkXoCVkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723706198; c=relaxed/simple;
	bh=V4KSHdNoLXucE7/pHYlP7qA1SYhzxcvVPPzhEl2jO4Q=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Co1POb5yfME1Txe2sckabs2VDCeHshf0szdt+na+NEBreWiI5ABEf8l4M1PP1UBJdvHSUTGsidEpae/nnrVM+rSSmuKZCi5TD9TNS4iB4vvsWeQI+FbTJf/QCuPgI7tFvPejdcZKXA4ukyf1Fd8y9DXH3wNvDBbrChZ0HUDX2vk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=WZPvQS6b; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47F7GUNP03730939, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723706190; bh=V4KSHdNoLXucE7/pHYlP7qA1SYhzxcvVPPzhEl2jO4Q=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=WZPvQS6ba8k7n5CbtUMD1EbdPSdlh8XJ9o/K9pGaRuRkYwhWPwkdeF8MeLhZadov+
	 nRp5abBeiP4dvpScCzBBW6h0w880jzTKzVhRFBOMwKk8kyvjsM13DaNwphtlspwu3u
	 lMm5WjeBOVVlFlxSeRF/xddaktDF20ofaN2yIfPS0BDZR9qa8U0p/WJKCyxiVIVZjn
	 zSPRJBr7tIZaYpHkBeT7/mMpySrmbzB4mr77my5fi8cQoh5Q4X07xxKWhD77lmR9Mq
	 WcrqYAtopQrFNCIdsK+ALEtwE6J7Vuv8iRKtrd7+4atspQclcEAodM9wOwMnWCykfq
	 Avzxs2vu5pm3g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47F7GUNP03730939
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 15:16:30 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 15:16:31 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Aug 2024 15:16:30 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0]) by
 RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0%5]) with mapi id
 15.01.2507.035; Thu, 15 Aug 2024 15:16:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 12/20] wifi: rtw88: Detect beacon loss with chips other than 8822c
Thread-Topic: [PATCH 12/20] wifi: rtw88: Detect beacon loss with chips other
 than 8822c
Thread-Index: AQHa7DHVacOUJql/XkGUtgiShv1sULIn7Kvg
Date: Thu, 15 Aug 2024 07:16:30 +0000
Message-ID: <090fc0eb54494ae28c98af4182010b0f@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <aea73a7a-e791-4475-bde6-500d9f3cb2ae@gmail.com>
In-Reply-To: <aea73a7a-e791-4475-bde6-500d9f3cb2ae@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGUg
ZHJpdmVyIGlzIHN1cHBvc2VkIHRvIGF2b2lkIGVudGVyaW5nIExQUyAocG93ZXIgc2F2aW5nKSB3
aGVuIHRoZXJlDQo+IGlzIGJlYWNvbiBsb3NzLCBidXQgb25seSBSVEw4ODIyQyBkZXRlY3RzIHRo
ZSBiZWFjb24gbG9zcyAoYmVjYXVzZSBpdA0KPiBoYXMgYmVhY29uIGZpbHRlcmluZyBpbiB0aGUg
ZmlybXdhcmUpLg0KPiANCj4gRGV0ZWN0IGJlYWNvbiBsb3NzIHdpdGggdGhlIG90aGVyIGNoaXBz
IGJ5IGNoZWNraW5nIGlmIHdlIHJlY2VpdmVkIGxlc3MNCj4gdGhhbiBoYWxmIHRoZSBleHBlY3Rl
ZCBudW1iZXIgb2YgYmVhY29ucyBpbiB0aGUgbGFzdCAyLXNlY29uZCBpbnRlcnZhbC4NCj4gDQo+
IFRoaXMgZ2V0cyByaWQgb2YgdGhlIG9jY2FzaW9uYWwgImZhaWxlZCB0byBnZXQgdHggcmVwb3J0
IGZyb20gZmlybXdhcmUiDQo+IHdhcm5pbmdzIHdpdGggUlRMODgyMUFVLiBJdCBtYXkgYWxzbyBh
dm9pZCBzb21lIGRpc2Nvbm5lY3Rpb25zLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1
ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydHc4OC9tYWluLmMgfCAxMSArKysrKysrKysrKw0KPiAgMSBmaWxl
IGNoYW5nZWQsIDExIGluc2VydGlvbnMoKykNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21haW4uYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODgvbWFpbi5jDQo+IGluZGV4IDM4MDZlNTc0MDBmYi4uNjJkOWFiYzA0YTM0IDEw
MDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21haW4uYw0K
PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L21haW4uYw0KPiBAQCAt
MjU0LDYgKzI1NCw4IEBAIHN0YXRpYyB2b2lkIHJ0d193YXRjaF9kb2dfd29yayhzdHJ1Y3Qgd29y
a19zdHJ1Y3QgKndvcmspDQo+ICAgICAgICAgaWYgKHRlc3RfYml0KFJUV19GTEFHX1NDQU5OSU5H
LCBydHdkZXYtPmZsYWdzKSkNCj4gICAgICAgICAgICAgICAgIGdvdG8gdW5sb2NrOw0KPiANCj4g
KyAgICAgICBpbnQgcmVjZWl2ZWRfYmVhY29ucyA9IHJ0d2Rldi0+ZG1faW5mby5jdXJfcGt0X2Nv
dW50Lm51bV9iY25fcGt0Ow0KPiArDQoNClRob3VnaCBjdXJyZW50bHkgY29tcGlsZXIgZG9lc24n
dCB3YXJuIGFyYml0cmFyaWx5IGRlY2xhcmUgdmFyaWFibGVzLCB3ZSBzdGlsbA0Kc2hvdWxkIGRl
Y2xhcmUgaXQgb24gdG9wIG9mIGZ1bmN0aW9ucy4NCg0KPiAgICAgICAgIC8qIG1ha2Ugc3VyZSBC
Qi9SRiBpcyB3b3JraW5nIGZvciBkeW5hbWljIG1lY2ggKi8NCj4gICAgICAgICBydHdfbGVhdmVf
bHBzKHJ0d2Rldik7DQo+ICAgICAgICAgcnR3X2NvZXhfd2xfc3RhdHVzX2NoZWNrKHJ0d2Rldik7
DQo+IEBAIC0yNzAsNiArMjcyLDE1IEBAIHN0YXRpYyB2b2lkIHJ0d193YXRjaF9kb2dfd29yayhz
dHJ1Y3Qgd29ya19zdHJ1Y3QgKndvcmspDQo+ICAgICAgICAgICovDQo+ICAgICAgICAgcnR3X2l0
ZXJhdGVfdmlmcyhydHdkZXYsIHJ0d192aWZfd2F0Y2hfZG9nX2l0ZXIsICZkYXRhKTsNCj4gDQo+
ICsgICAgICAgaWYgKCFydHdfZndfZmVhdHVyZV9jaGVjaygmcnR3ZGV2LT5mdywgRldfRkVBVFVS
RV9CQ05fRklMVEVSKSAmJg0KPiArICAgICAgICAgICBkYXRhLnJ0d3ZpZikgew0KPiArICAgICAg
ICAgICAgICAgaW50IGJlYWNvbl9pbnQgPSBydHd2aWZfdG9fdmlmKGRhdGEucnR3dmlmKS0+YnNz
X2NvbmYuYmVhY29uX2ludDsNCj4gKyAgICAgICAgICAgICAgIGludCB3YXRjaGRvZ19kZWxheSA9
IDIwMDAwMDAgLyAxMDI0OyAvKiBUVSAqLw0KPiArICAgICAgICAgICAgICAgaW50IGV4cGVjdGVk
X2JlYWNvbnMgPSBESVZfUk9VTkRfVVAod2F0Y2hkb2dfZGVsYXksIGJlYWNvbl9pbnQpOw0KPiAr
DQo+ICsgICAgICAgICAgICAgICBydHdkZXYtPmJlYWNvbl9sb3NzID0gcmVjZWl2ZWRfYmVhY29u
cyA8IGV4cGVjdGVkX2JlYWNvbnMgLyAyOw0KPiArICAgICAgIH0NCj4gKw0KDQpQbGVhc2UgbW92
ZSB0byBhbiBpbmRpdmlkdWFsIGZ1bmN0aW9uIHN1Y2ggYXMgcnR3X3N3X2JlYWNvbl9sb3NzX2No
ZWNrKCkuDQoNCg0KPiAgICAgICAgIC8qIGZ3IHN1cHBvcnRzIG9ubHkgb25lIHN0YXRpb24gYXNz
b2NpYXRlZCB0byBlbnRlciBscHMsIGlmIHRoZXJlIGFyZQ0KPiAgICAgICAgICAqIG1vcmUgdGhh
biB0d28gc3RhdGlvbnMgYXNzb2NpYXRlZCB0byB0aGUgQVAsIHRoZW4gd2UgY2FuIG5vdCBlbnRl
cg0KPiAgICAgICAgICAqIGxwcywgYmVjYXVzZSBmdyBkb2VzIG5vdCBoYW5kbGUgdGhlIG92ZXJs
YXBwZWQgYmVhY29uIGludGVydmFsDQo+IC0tDQo+IDIuNDYuMA0KDQo=

