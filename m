Return-Path: <linux-wireless+bounces-7414-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 33E8E8C1CBE
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 05:06:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9DA5C1F225B8
	for <lists+linux-wireless@lfdr.de>; Fri, 10 May 2024 03:06:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37073148FE2;
	Fri, 10 May 2024 03:05:05 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EDEA148844
	for <linux-wireless@vger.kernel.org>; Fri, 10 May 2024 03:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715310305; cv=none; b=PNqja/P8czjWeUVifaTq4PRLh0G8kf5TuukYpuJI9oxDD4wd/JJZYr0A9c5z3UribwVtcc4dWLBt0JtYtBsfabY5BIVVhNCNWh7m/xRsTqVOMQsU6Y7Yok+8QyAY2F+t5FZpYWxWcLYTqr/f0BMc6UJtuxmvXRpPYZYjXqTPcaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715310305; c=relaxed/simple;
	bh=LtDvyTWO1VGmxv/4fTTohhpQMZw/jIAZin7RAHpgPkw=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=iCnSe94RzBVT1XH4daLIbksBQJOIpnXB6wZSfVOsAplY8531z3Xyr8nvGrMjPw5f4WvsPZMzn/6UUtboYBdQhaLw0S2O7vtYu7q1i53yk3rbxUvMa0ihwiiMUEnle1QbNqUIcmcZpW6EuWb93EKXIYl6g5Dq1BvxXHdYagxfSZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44A34fJ022284420, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44A34fJ022284420
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 10 May 2024 11:04:41 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 11:04:42 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 10 May 2024 11:04:41 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 10 May 2024 11:04:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v5 03/11] wifi: rtlwifi: Add rtl8192du/hw.{c,h}
Thread-Topic: [PATCH v5 03/11] wifi: rtlwifi: Add rtl8192du/hw.{c,h}
Thread-Index: AQHaoTVZRe2AKQHe4kKE1cdb+1P5krGPvR6g
Date: Fri, 10 May 2024 03:04:41 +0000
Message-ID: <31f28650173d40cf85fb57f87949eef7@realtek.com>
References: <254558da-ea8b-40ea-bd5a-83d13796744f@gmail.com>
 <d5d52f8d-585d-43a6-a5e6-076f24ba8410@gmail.com>
In-Reply-To: <d5d52f8d-585d-43a6-a5e6-076f24ba8410@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGVz
ZSBjb250YWluIG1vc3RseSBoYXJkd2FyZSBpbml0L2RlaW5pdCByb3V0aW5lcyBmb3IgUlRMODE5
MkRVLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZl
MkBnbWFpbC5jb20+DQoNClsuLi5dDQoNCj4gLS0tDQo+ICAuLi4vd2lyZWxlc3MvcmVhbHRlay9y
dGx3aWZpL3J0bDgxOTJkdS9ody5jICAgfCAxMjMyICsrKysrKysrKysrKysrKysrDQo+ICAuLi4v
d2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS9ody5oICAgfCAgIDI0ICsNCj4gIDIg
ZmlsZXMgY2hhbmdlZCwgMTI1NiBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQg
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS9ody5jDQo+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0
bDgxOTJkdS9ody5oDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydGx3aWZpL3J0bDgxOTJkdS9ody5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydGx3aWZpL3J0bDgxOTJkdS9ody5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGlu
ZGV4IDAwMDAwMDAwMDAwMC4uMTRhM2U0Njg1ZGVlDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIv
ZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS9ody5jDQo+IEBA
IC0wLDAgKzEsMTIzMiBAQA0KPiArLy8gU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAN
Cj4gKy8qIENvcHlyaWdodChjKSAyMDA5LTIwMTIgIFJlYWx0ZWsgQ29ycG9yYXRpb24uKi8NCg0K
UGxlYXNlIGNoYW5nZSB5ZWFyIHRvIDIwMjQgYWNyb3NzIHRoaXMgcGF0Y2hzZXQuIA0KDQo+ICsN
Cj4gKyNpbmNsdWRlICIuLi93aWZpLmgiDQo+ICsjaW5jbHVkZSAiLi4vZWZ1c2UuaCINCj4gKyNp
bmNsdWRlICIuLi9iYXNlLmgiDQo+ICsjaW5jbHVkZSAiLi4vcmVnZC5oIg0KPiArI2luY2x1ZGUg
Ii4uL2NhbS5oIg0KPiArI2luY2x1ZGUgIi4uL3BzLmgiDQo+ICsjaW5jbHVkZSAiLi4vcGNpLmgi
DQo+ICsjaW5jbHVkZSAiLi4vdXNiLmgiDQo+ICsjaW5jbHVkZSAiLi4vcnRsODE5MmQvcmVnLmgi
DQo+ICsjaW5jbHVkZSAiLi4vcnRsODE5MmQvZGVmLmgiDQo+ICsjaW5jbHVkZSAiLi4vcnRsODE5
MmQvZG1fY29tbW9uLmgiDQo+ICsjaW5jbHVkZSAiLi4vcnRsODE5MmQvZndfY29tbW9uLmgiDQo+
ICsjaW5jbHVkZSAiLi4vcnRsODE5MmQvaHdfY29tbW9uLmgiDQo+ICsjaW5jbHVkZSAiLi4vcnRs
ODE5MmQvcGh5X2NvbW1vbi5oIg0KPiArI2luY2x1ZGUgInBoeS5oIg0KPiArI2luY2x1ZGUgImRt
LmgiDQo+ICsjaW5jbHVkZSAiZncuaCINCj4gKyNpbmNsdWRlICJsZWQuaCINCj4gKyNpbmNsdWRl
ICJody5oIg0KPiArI2luY2x1ZGUgInRyeC5oIg0KPiArDQo+ICtzdGF0aWMgdm9pZCBfcnRsOTJk
ZV9zZXRfYmNuX2N0cmxfcmVnKHN0cnVjdCBpZWVlODAyMTFfaHcgKmh3LA0KPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHU4IHNldF9iaXRzLCB1OCBjbGVhcl9iaXRzKQ0K
DQpIZXJlIGlzIDgxOTJkdSwgc28gcHJlZml4IHNob3VsZCBub3QgODE5MmRlLiBBbHNvIHJ0bDky
ZF9saW5rZWRfc2V0X3JlZygpIHNob3VsZA0KYmUgdXNlZCBpbiBjb21tb24gZmlsZSwgc28gd2Ug
c2hvdWxkIHVzZSBydGw5MmR1X2xpbmtlZF9zZXRfcmVnKCkgaW5zdGVhZC4NClBsZWFzZSBhcHBs
eSB0aGlzIHJ1bGUgYWNyb3NzIHBhdGNoc2V0LiANCg0KPiArew0KPiArICAgICAgIHN0cnVjdCBy
dGxfdXNiICpydGx1c2IgPSBydGxfdXNiZGV2KHJ0bF91c2Jwcml2KGh3KSk7DQo+ICsgICAgICAg
c3RydWN0IHJ0bF9wcml2ICpydGxwcml2ID0gcnRsX3ByaXYoaHcpOw0KPiArDQo+ICsgICAgICAg
cnRsdXNiLT5yZWdfYmNuX2N0cmxfdmFsIHw9IHNldF9iaXRzOw0KPiArICAgICAgIHJ0bHVzYi0+
cmVnX2Jjbl9jdHJsX3ZhbCAmPSB+Y2xlYXJfYml0czsNCj4gKyAgICAgICBydGxfd3JpdGVfYnl0
ZShydGxwcml2LCBSRUdfQkNOX0NUUkwsICh1OClydGx1c2ItPnJlZ19iY25fY3RybF92YWwpOw0K
PiArfQ0KPiArDQoNClsuLi5dDQoNCj4gKw0KPiArdm9pZCBydGw5MmR1X3NldF9od19yZWcoc3Ry
dWN0IGllZWU4MDIxMV9odyAqaHcsIHU4IHZhcmlhYmxlLCB1OCAqdmFsKQ0KPiArew0KPiArICAg
ICAgIHN0cnVjdCBydGxfcHJpdiAqcnRscHJpdiA9IHJ0bF9wcml2KGh3KTsNCj4gKyAgICAgICBz
dHJ1Y3QgcnRsX21hYyAqbWFjID0gcnRsX21hYyhydGxwcml2KTsNCj4gKw0KPiArICAgICAgIHN3
aXRjaCAodmFyaWFibGUpIHsNCj4gKyAgICAgICBjYXNlIEhXX1ZBUl9BQ19QQVJBTTogew0KPiAr
ICAgICAgICAgICAgICAgcnRsOTJkX2RtX2luaXRfZWRjYV90dXJibyhodyk7DQo+ICsgICAgICAg
ICAgICAgICBicmVhazsNCj4gKyAgICAgICB9DQoNCk5vIG5lZWQgcGFyZW50aGVzaXMgZm9yIHRo
aXMgc2luZ2xlIHN0YXRlbWVudC4gDQoNClsuLi5dDQoNCg0KPiArDQo+ICtzdGF0aWMgYm9vbCBf
cnRsOTJkZV9sbHRfdGFibGVfaW5pdChzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodywgdTggdHhwa3Ri
dWZfYm5keSkNCj4gK3sNCj4gKyAgICAgICBzdHJ1Y3QgcnRsX3ByaXYgKnJ0bHByaXYgPSBydGxf
cHJpdihodyk7DQo+ICsgICAgICAgdW5zaWduZWQgc2hvcnQgaTsNCj4gKyAgICAgICBib29sIHN0
YXR1czsNCj4gKyAgICAgICB1OCBtYXhwYWdlOw0KPiArDQo+ICsgICAgICAgaWYgKHJ0bHByaXYt
PnJ0bGhhbC5tYWNwaHltb2RlID09IFNJTkdMRU1BQ19TSU5HTEVQSFkpDQo+ICsgICAgICAgICAg
ICAgICBtYXhwYWdlID0gMjU1Ow0KPiArICAgICAgIGVsc2UNCj4gKyAgICAgICAgICAgICAgIG1h
eHBhZ2UgPSAxMjc7DQo+ICsNCj4gKyAgICAgICBmb3IgKGkgPSAwOyBpIDwgKHR4cGt0YnVmX2Ju
ZHkgLSAxKTsgaSsrKSB7DQo+ICsgICAgICAgICAgICAgICBzdGF0dXMgPSBydGw5MmRlX2xsdF93
cml0ZShodywgaSwgaSArIDEpOw0KPiArICAgICAgICAgICAgICAgaWYgKCFzdGF0dXMpDQo+ICsg
ICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBzdGF0dXM7DQo+ICsgICAgICAgfQ0KPiArDQo+
ICsgICAgICAgLyogZW5kIG9mIGxpc3QgKi8NCj4gKyAgICAgICBzdGF0dXMgPSBydGw5MmRlX2xs
dF93cml0ZShodywgdHhwa3RidWZfYm5keSAtIDEsIDB4RkYpOw0KPiArICAgICAgIGlmICghc3Rh
dHVzKQ0KPiArICAgICAgICAgICAgICAgcmV0dXJuIHN0YXR1czsNCj4gKw0KPiArICAgICAgIC8q
IE1ha2UgdGhlIG90aGVyIHBhZ2VzIGFzIHJpbmcgYnVmZmVyICovDQo+ICsgICAgICAgLyogVGhp
cyByaW5nIGJ1ZmZlciBpcyB1c2VkIGFzIGJlYWNvbiBidWZmZXIgaWYgd2UgKi8NCj4gKyAgICAg
ICAvKiBjb25maWcgdGhpcyBNQUMgYXMgdHdvIE1BQyB0cmFuc2Zlci4gKi8NCj4gKyAgICAgICAv
KiBPdGhlcndpc2UgdXNlZCBhcyBsb2NhbCBsb29wYmFjayBidWZmZXIuICAqLw0KDQpCZSBzaW5n
bGUgb25lIGJsb2NrIGNvbW1lbnQuIA0KDQoiLi4uIGxvb3BiYWNrIGJ1ZmZlci4gICIgY29udGFp
bnMgdHdvIHRyYWlsaW5nIHNwYWNlcy4gDQoNClsuLi5dDQoNCj4gKw0KPiAraW50IHJ0bDkyZHVf
aHdfaW5pdChzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodykNCj4gK3sNCj4gKyAgICAgICBzdHJ1Y3Qg
cnRsX3VzYl9wcml2ICp1c2JfcHJpdiA9IHJ0bF91c2Jwcml2KGh3KTsNCj4gKyAgICAgICBzdHJ1
Y3QgcnRsX3VzYiAqcnRsdXNiID0gcnRsX3VzYmRldih1c2JfcHJpdik7DQo+ICsgICAgICAgc3Ry
dWN0IHJ0bF9wcml2ICpydGxwcml2ID0gcnRsX3ByaXYoaHcpOw0KPiArICAgICAgIHN0cnVjdCBy
dGxfcHNfY3RsICpwcHNjID0gcnRsX3BzYyhydGxwcml2KTsNCj4gKyAgICAgICBzdHJ1Y3QgcnRs
X2hhbCAqcnRsaGFsID0gcnRsX2hhbChydGxwcml2KTsNCj4gKyAgICAgICBzdHJ1Y3QgcnRsX21h
YyAqbWFjID0gcnRsX21hYyhydGxwcml2KTsNCj4gKyAgICAgICBzdHJ1Y3QgcnRsX3BoeSAqcnRs
cGh5ID0gJnJ0bHByaXYtPnBoeTsNCj4gKyAgICAgICB1OCB2YWw4LCB0eHBrdGJ1Zl9ibmR5Ow0K
PiArICAgICAgIHVuc2lnbmVkIGxvbmcgZmxhZ3M7DQo+ICsgICAgICAgaW50IGVyciwgaTsNCj4g
KyAgICAgICB1MzIgdmFsMzI7DQo+ICsgICAgICAgdTE2IHZhbDE2Ow0KPiArDQo+ICsgICAgICAg
LyogQXMgdGhpcyBmdW5jdGlvbiBjYW4gdGFrZSBhIHZlcnkgbG9uZyB0aW1lDQo+ICsgICAgICAg
ICogYW5kIGNhbiBiZSBjYWxsZWQgd2l0aCBpcnFzIGRpc2FibGVkLCByZWVuYWJsZSB0aGUgaXJx
cw0KPiArICAgICAgICAqIHRvIGxldCB0aGUgb3RoZXIgZGV2aWNlcyBjb250aW51ZSBiZWluZyBz
ZXJ2aWNlZC4NCj4gKyAgICAgICAgKg0KPiArICAgICAgICAqIEl0IGlzIHNhZmUgZG9pbmcgc28g
c2luY2Ugb3VyIG93biBpbnRlcnJ1cHRzIHdpbGwgb25seSBiZSBlbmFibGVkDQo+ICsgICAgICAg
ICogaW4gYSBzdWJzZXF1ZW50IHN0ZXAuDQo+ICsgICAgICAgICovDQo+ICsgICAgICAgbG9jYWxf
c2F2ZV9mbGFncyhmbGFncyk7DQo+ICsgICAgICAgbG9jYWxfaXJxX2VuYWJsZSgpOw0KDQpJIHRo
aW5rIHlvdSBqdXN0IGNvcHkgYW5kIHBhc3RlIHRoaXMgY2h1bmsuIEkgd29uZGVyIGlmIFVTQiBo
YXMgdGhlIHNhbWUgYmVoYXZpb3I/DQpEcml2ZXIgZm9yY2UgdG8gZW5hYmxlIElSUSBpcyB3ZWly
ZCB0byBtZS4gUGxlYXNlIGNoZWNrIEkgdGhpcyBpcyByZWFsbHkgY2FsbGVkDQp3aXRoIGlycSBk
aXNhYmxlZD8gSWYgbm90LCB3ZSBjYW4gcmVtb3ZlIHRoZW0uDQoNClsuLi5dDQoNCj4gKyAgICAg
ICBsb2NhbF9pcnFfZGlzYWJsZSgpOw0KPiArICAgICAgIGxvY2FsX2lycV9yZXN0b3JlKGZsYWdz
KTsNCj4gKw0KPiArICAgICAgIHJldHVybiBlcnI7DQo+ICt9DQo+ICsNCg0KDQo=

