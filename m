Return-Path: <linux-wireless+bounces-6611-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D96B78AC2DD
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 04:55:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1696B1C20CB0
	for <lists+linux-wireless@lfdr.de>; Mon, 22 Apr 2024 02:55:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E444ECA40;
	Mon, 22 Apr 2024 02:55:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB3894C6F
	for <linux-wireless@vger.kernel.org>; Mon, 22 Apr 2024 02:55:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713754540; cv=none; b=uYAqQeiwjmrPi7khAg7/8gFOVCkLCH4W8b0Dysa2QHkDt2/XiLLGYcFlyuUkG8iCAbKhRf2QpdIcS2QEgSIHCbAberZ8ETvgCxUpOJMEaS3V7Pl+vJk/fXeKJ3cXTRgRRNL4C43fHYmMI68eJksoA9Rs0bQn6pc5c1rjRXxfD+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713754540; c=relaxed/simple;
	bh=4X8hqL9DkRieNuUnqvJU8oqA8cosdJqoFajD2uDNA+o=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=MTTQI7rlz1SJsRns4kVqLoRm3l4uOeMAwhxdDdQ9GdYOA86mZYvCpxIKWZAeWFMsgr/wbhdpYQvqQODWt65obYNKs+cfzKH8SgXVHP2R+8FmBlTa8mDlglyn4ANfchlcxa0QEPBmfZqJVshpMQTeILsOUxKXHOal1UI6oWdxBao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43M2tBjP53783427, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43M2tBjP53783427
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 22 Apr 2024 10:55:11 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 10:55:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 22 Apr 2024 10:55:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Mon, 22 Apr 2024 10:55:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v6 4/6] wifi: rtlwifi: Move code from rtl8192de to rtl8192d-common
Thread-Topic: [PATCH v6 4/6] wifi: rtlwifi: Move code from rtl8192de to
 rtl8192d-common
Thread-Index: AQHakl7Lfjbq0AGUE0Omzg/aC716wbFzmqEg
Date: Mon, 22 Apr 2024 02:55:11 +0000
Message-ID: <4e7bb78f7dad4383bc98f4a94a2c9b48@realtek.com>
References: <9d54a192-d389-4a56-9286-2e7721cbbc27@gmail.com>
 <459a193c-ce2e-4b89-827c-ff6721c470e0@gmail.com>
In-Reply-To: <459a193c-ce2e-4b89-827c-ff6721c470e0@gmail.com>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBDcmVh
dGUgdGhlIG5ldyBtb2R1bGUgcnRsODE5MmQtY29tbW9uIGFuZCBtb3ZlIHNvbWUgY29kZSBpbnRv
IGl0IGZyb20NCj4gcnRsODE5MmRlLiBOb3cgdGhlIHJ0bDgxOTJkZSBkcml2ZXIgKFBDSSkgYW5k
IHRoZSBuZXcgcnRsODE5MmR1IGRyaXZlcg0KPiAoVVNCKSBjYW4gc2hhcmUgc29tZSBvZiB0aGUg
Y29kZS4NCj4gDQo+IFRoaXMgaXMgbW9zdGx5IHRoZSBjb2RlIHRoYXQgcmVxdWlyZWQgbGl0dGxl
IGVmZm9ydCB0byBtYWtlIGl0DQo+IHNoYXJlYWJsZS4gVGhlcmUgYXJlIGEgZmV3IG1vcmUgZnVu
Y3Rpb25zIHdoaWNoIHRoZXkgY291bGQgc2hhcmUsIHdpdGgNCj4gbW9yZSBjaGFuZ2VzLg0KPiAN
Cj4gQWRkIHBoeV9pcV9jYWxpYnJhdGUgbWVtYmVyIHRvIHN0cnVjdCBydGxfaGFsX29wcyB0byBh
bGxvdyBtb3ZpbmcgdGhlDQo+IFRYIHBvd2VyIHRyYWNraW5nIGNvZGUgZnJvbSBkbS5jLg0KPiAN
Cj4gVGhlIG90aGVyIGNoYW5nZXMgaW4gdGhpcyBwYXRjaCBhcmUgYWRqdXN0aW5nIHdoaXRlc3Bh
Y2UsIHJlbmFtaW5nIHNvbWUNCj4gZnVuY3Rpb25zLCBtYWtpbmcgc29tZSBhcnJheXMgY29uc3Qs
IGFuZCBtYWtpbmcgY2hlY2twYXRjaC5wbCBsZXNzDQo+IHVuaGFwcHkuDQo+IA0KPiBydGw4MTky
ZGUgaXMgY29tcGlsZS10ZXN0ZWQgb25seS4gcnRsODE5MmQtY29tbW9uIGlzIHRlc3RlZCB3aXRo
IHRoZQ0KPiBuZXcgcnRsODE5MmR1IGRyaXZlci4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRl
cmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KDQpbLi5dDQoNCj4gKysrIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkL21haW4uYw0KPiBA
QCAtMCwwICsxLDkgQEANCj4gKy8vIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wDQo+
ICsvKiBDb3B5cmlnaHQoYykgMjAwOS0yMDEyICBSZWFsdGVrIENvcnBvcmF0aW9uLiovDQo+ICsN
Cj4gKyNpbmNsdWRlICIuLi93aWZpLmgiDQo+ICsjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+
ICsNCj4gK01PRFVMRV9BVVRIT1IoIlJlYWx0ZWsgV2xhbkZBRSA8d2xhbmZhZUByZWFsdGVrLmNv
bT4iKTsNCj4gK01PRFVMRV9MSUNFTlNFKCJHUEwiKTsNCj4gK01PRFVMRV9ERVNDUklQVElPTigi
UmVhbHRlayA4MTkyRCA4MDIuMTFhbiBjb21tb24gcm91dGluZXMiKTsNCg0KTm90IHN1cmUgd2h5
IHlvdSBlbXBoYXNpemUgJzgwMi4xMWFuJyBpbnN0ZWFkIG9mIGp1c3QgJzgwMi4xMW4nLg0KDQoN
Cg==

