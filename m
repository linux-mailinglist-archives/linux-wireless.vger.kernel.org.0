Return-Path: <linux-wireless+bounces-5139-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DC2E8886668
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 06:48:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 6C9BEB23FCA
	for <lists+linux-wireless@lfdr.de>; Fri, 22 Mar 2024 05:48:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3F4A0DDCD;
	Fri, 22 Mar 2024 05:48:49 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04B6CDDB6
	for <linux-wireless@vger.kernel.org>; Fri, 22 Mar 2024 05:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711086529; cv=none; b=RMhAJp9ewG7UnUKfxtO9VKJgSMHu2DIDO8i0zJJKqiAvL24gWZdOzNmenRo+LIyoVq2/I2UQy7ydPLO5lymb0uB1Xrb8h2tW1rE3CsJBMAVrFa6Nc+vPO/M3XqA5y/MT0SETnT4TrlQZgE44KQD+u4/Xda6LQV4Oe5cGHk16xcs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711086529; c=relaxed/simple;
	bh=26+kUbtsM7i2H8bL3+SRN2e2Weysu4AuZifis2f5qeI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=DCjyXWeLa2eTl7B35EN1X9XoVXYI4VvMCCuo6VU+7nct2GL/4G2RKNEqxjzt/3cLKHOxhEq176vav8JaTXtrWCPQD7C27GaCLi+LaY1Q9kdCjWk00K1IYfsTuLSRSd7Lr1ob1R6E/T16YPrHImYu7Rs8CntJ7tfsT6ZPmiKpGRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 42M5mJnhD1492328, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 42M5mJnhD1492328
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 22 Mar 2024 13:48:19 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 13:48:02 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 22 Mar 2024 13:48:02 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c42:f80:bcc2:d00f%5]) with mapi id
 15.01.2507.035; Fri, 22 Mar 2024 13:48:02 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "rtl8821cerfe2@gmail.com" <rtl8821cerfe2@gmail.com>
CC: "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "s.l-h@gmx.de"
	<s.l-h@gmx.de>,
        "chewitt@libreelec.tv" <chewitt@libreelec.tv>
Subject: Re: [PATCH v3 10/12] wifi: rtlwifi: Add rtl8192du/dm.{c,h}
Thread-Topic: [PATCH v3 10/12] wifi: rtlwifi: Add rtl8192du/dm.{c,h}
Thread-Index: AQHaev6+1Jzyq6jgyUijc1zK39prWrFCvJsA
Date: Fri, 22 Mar 2024 05:48:02 +0000
Message-ID: <2d553b73952db4fd00bc4f190f5773f5454daa7a.camel@realtek.com>
References: <7f4b3309-1580-48f3-9426-29f1eb4052fd@gmail.com>
	 <5af3c18f-b96a-4599-b3a4-328c8f402693@gmail.com>
In-Reply-To: <5af3c18f-b96a-4599-b3a4-328c8f402693@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
Content-Type: text/plain; charset="utf-8"
Content-ID: <9EF46270A613FB4585FAE9F42982C105@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

T24gV2VkLCAyMDI0LTAzLTIwIGF0IDIxOjQyICswMjAwLCBCaXR0ZXJibHVlIFNtaXRoIHdyb3Rl
Og0KPiANCj4gVGhlc2UgY29udGFpbiBmdW5jdGlvbnMgcmVsYXRlZCB0byB0aGUgZHluYW1pYyBt
ZWNoYW5pc20sIHdoaWNoIHJ1bnMNCj4gZXZlcnkgdHdvIHNlY29uZHMgdG8gYWRqdXN0IHRvIGNo
YW5nZXMgaW4gdGhlIGVudmlyb25tZW50Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1
ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IC0tLQ0KPiB2MzoNCj4gIC0gTm8g
Y2hhbmdlLg0KPiANCj4gdjI6DQo+ICAtIFBhdGNoIGlzIG5ldyBpbiB2Miwgc3BsaXQgZnJvbSBw
YXRjaCAzLzMgaW4gdjEuDQo+IC0tLQ0KPiAgLi4uL3dpcmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9y
dGw4MTkyZHUvZG0uYyAgIHwgMTI1ICsrKysrKysrKysrKysrKysrKw0KPiAgLi4uL3dpcmVsZXNz
L3JlYWx0ZWsvcnRsd2lmaS9ydGw4MTkyZHUvZG0uaCAgIHwgIDEwICsrDQo+ICAyIGZpbGVzIGNo
YW5nZWQsIDEzNSBpbnNlcnRpb25zKCspDQo+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS9kbS5jDQo+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS9k
bS5oDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3
aWZpL3J0bDgxOTJkdS9kbS5jDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3
aWZpL3J0bDgxOTJkdS9kbS5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAw
MDAwMDAwMC4uYWE3MDMyZTBmNzFhDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvZHJpdmVycy9u
ZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS9kbS5jDQo+IEBAIC0wLDAgKzEs
MTI1IEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMA0KPiArLyogQ29w
eXJpZ2h0KGMpIDIwMDktMjAxMiAgUmVhbHRlayBDb3Jwb3JhdGlvbi4qLw0KPiArDQo+ICsjaW5j
bHVkZSAiLi4vd2lmaS5oIg0KPiArI2luY2x1ZGUgIi4uL2Jhc2UuaCINCj4gKyNpbmNsdWRlICIu
Li9jb3JlLmgiDQo+ICsjaW5jbHVkZSAiLi4vcnRsODE5MmQvcmVnLmgiDQo+ICsjaW5jbHVkZSAi
Li4vcnRsODE5MmQvZGVmLmgiDQo+ICsjaW5jbHVkZSAiLi4vcnRsODE5MmQvZG1fY29tbW9uLmgi
DQo+ICsjaW5jbHVkZSAiLi4vcnRsODE5MmQvZndfY29tbW9uLmgiDQo+ICsjaW5jbHVkZSAiLi4v
cnRsODE5MmQvcGh5X2NvbW1vbi5oIg0KPiArI2luY2x1ZGUgInBoeS5oIg0KPiArI2luY2x1ZGUg
ImRtLmgiDQo+ICsjaW5jbHVkZSAiZncuaCINCj4gKw0KPiArI2RlZmluZSBVTkRFQ19TTV9QV0RC
ICBlbnRyeV9taW5fdW5kZWNfc21fcHdkYg0KDQpOb3QgdXNlLiBQbGVhc2UgcmVtb3ZlIGl0LiAN
Cg0KSSBkaWQgZ3JlcCwgYW5kIGZvdW5kIHRoZXNlIGFyZSB1bm5lY2Vzc2FyeS4gSSBkb24ndCBr
bm93IHdoeSBwZW9wbGUgdXNlZA0KaXQgdG8gdHlwZSBzaG9ydGVyIG5hbWUuIFdoeSBub3QganVz
dCBtYWtlIGVudHJ5X21pbl91bmRlY19zbV9wd2RiIHNob3J0ZXI/DQoNCmRyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnRsd2lmaSQgZ2l0IGdyZXAgVU5ERUNfU01fUFdEQg0KcnRsODE5MmQv
ZG1fY29tbW9uLmM6I2RlZmluZSBVTkRFQ19TTV9QV0RCICAgICAgZW50cnlfbWluX3VuZGVjX3Nt
X3B3ZGINCnJ0bDgxOTJkL2RtX2NvbW1vbi5jOiAgICAgICBydGxwcml2LT5kbS5VTkRFQ19TTV9Q
V0RCID09IDApIHsNCnJ0bDgxOTJkL2RtX2NvbW1vbi5jOiAgICAgICAgICAgICAgICAgICAgICAg
cnRscHJpdi0+ZG0uVU5ERUNfU01fUFdEQjsNCnJ0bDgxOTJkL2RtX2NvbW1vbi5jOiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBydGxwcml2LT5kbS5VTkRFQ19TTV9QV0RCKTsNCnJ0bDgxOTJk
L2RtX2NvbW1vbi5jOiAgICAgICAgICAgZGVfZGlndGFibGUtPm1pbl91bmRlY19wd2RiX2Zvcl9k
bSA9IHJ0bHByaXYtPmRtLlVOREVDX1NNX1BXREI7DQpydGw4MTkyZGUvZG0uYzojZGVmaW5lIFVO
REVDX1NNX1BXREIgICAgZW50cnlfbWluX3VuZGVjX3NtX3B3ZGINCnJ0bDgxOTJkZS9kbS5jOiAg
ICAgKHJ0bHByaXYtPmRtLlVOREVDX1NNX1BXREIgPT0gMCkpIHsNCnJ0bDgxOTJkZS9kbS5jOiAg
ICAgICAgICAgICAgICAgICAgIHJ0bHByaXYtPmRtLlVOREVDX1NNX1BXREI7DQpydGw4MTkyZGUv
ZG0uYzogICAgICAgICAgICAgcnRscHJpdi0+ZG0uVU5ERUNfU01fUFdEQjsNCnJ0bDgxOTJkdS9k
bS5jOiNkZWZpbmUgVU5ERUNfU01fUFdEQiAgICBlbnRyeV9taW5fdW5kZWNfc21fcHdkYg0KDQpb
Li4uXQ0KDQoNCg0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dGx3aWZpL3J0bDgxOTJkdS9kbS5oDQo+IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dGx3aWZpL3J0bDgxOTJkdS9kbS5oDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAw
MDAwMDAwMDAwMC4uZDAzNmNmNzIyMzg0DQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvZHJpdmVy
cy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZpL3J0bDgxOTJkdS9kbS5oDQo+IEBAIC0wLDAg
KzEsMTAgQEANCj4gKy8qIFNQRFgtTGljZW5zZS1JZGVudGlmaWVyOiBHUEwtMi4wICovDQo+ICsv
KiBDb3B5cmlnaHQoYykgMjAwOS0yMDEyICBSZWFsdGVrIENvcnBvcmF0aW9uLiovDQo+ICsNCj4g
KyNpZm5kZWYgICAgICAgIF9fUlRMOTJDX0RNX0hfXw0KDQpVc2Ugc3BhY2UgaW5zdGVhZCBvZiB0
YWIuIA0KDQo+ICsjZGVmaW5lIF9fUlRMOTJDX0RNX0hfXw0KDQpQbGVhc2UgY29ycmVjdCBpdHMg
bmFtZS4NCg0KPiArDQo+ICt2b2lkIHJ0bDkyZHVfZG1faW5pdChzdHJ1Y3QgaWVlZTgwMjExX2h3
ICpodyk7DQo+ICt2b2lkIHJ0bDkyZHVfZG1fd2F0Y2hkb2coc3RydWN0IGllZWU4MDIxMV9odyAq
aHcpOw0KPiArDQo+ICsjZW5kaWYNCj4gLS0NCj4gMi40My4yDQo=

