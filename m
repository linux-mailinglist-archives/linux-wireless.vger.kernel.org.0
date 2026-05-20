Return-Path: <linux-wireless+bounces-36680-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id gDOFOlESDWoOtAUAu9opvQ
	(envelope-from <linux-wireless+bounces-36680-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 03:45:53 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [IPv6:2600:3c0a:e001:db::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 4CC0A5869EA
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 03:45:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 7385830207CC
	for <lists+linux-wireless@lfdr.de>; Wed, 20 May 2026 01:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D35FB1624D5;
	Wed, 20 May 2026 01:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="f4zx3Hil"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9423178F2F
	for <linux-wireless@vger.kernel.org>; Wed, 20 May 2026 01:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779241550; cv=none; b=iTlbfiEeh3E90MkjkyEx1X2tjeb01TaPjll4teQZdRUdhWNiLew2ccrNRzcop03H51Wg7vWF734ea+4NN87D4MsgvfcPuuX+/uQSUZ2fZBiCBd3w+LslF11OuJ80u5tsO+U6QHwJzC+36oP8uyQy2ELA19BIJXdk2Sxwid0DMHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779241550; c=relaxed/simple;
	bh=AyERA7TuytECdCPqGhT76pTu8RZNDwdn0n2OXcXURqo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LWmd45xJsyxaoAMrx7bbQp7G7vgKm3+a+oGfx1LXr4LelcdKfl0VqmYsAtxvGDq6+H/UB5Nhb933heI8AMFkvuN0SluorlL0hbLghffw2f4dFDGwiuUMMlrHXmU0/v3lcJwc2whPLF2rF+7RE99pyXGhGHpQtDZtdZNkMiKtVvw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=f4zx3Hil; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64K1jVWA13823731, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779241531; bh=AyERA7TuytECdCPqGhT76pTu8RZNDwdn0n2OXcXURqo=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=f4zx3HilpRITNue7thmsfw7JMHEvmUErq2WcAqanwDgw3EDR0RYPgx9hLr8LGZrp+
	 cTuMZ9ybfyMfO9SPOp1/N1oyWliHzKDQvgVoo6w6P34ID4Ke0KwYhe95xxwElM1M03
	 3LwH/kr4rjj/a/TcP5yBfgYvkfPHAIpIJAQPTQxqaBDfoebFx/Q8jDVaw+lZa4zwFE
	 vPZaJ5qZnVF2ICfjLyHZQ2NrGKMMQK33d4ZVt+S2VoAxyHbqA8I1epmVD+3+sFVWbP
	 XDmEP7QZH171fGRJU6XGLe0Psd0ohG+fUqKJmXjzPaOnsw0u8nYQma2SJ4SbVNgvde
	 wRByPnIy7Wq8Q==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.28/5.94) with ESMTPS id 64K1jVWA13823731
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 May 2026 09:45:31 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Wed, 20 May 2026 09:45:30 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Wed, 20 May 2026 09:45:30 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: LB F <goainwo@gmail.com>,
        Martin Blumenstingl
	<martin.blumenstingl@googlemail.com>,
        Fiona Klute <fiona.klute@gmx.de>,
        "andrej.skvortzov@gmail.com" <andrej.skvortzov@gmail.com>,
        "anarsoul@gmail.com" <anarsoul@gmail.com>,
        Zhen XIN
	<zhen.xin@nokia-sbell.com>
Subject: RE: [PATCH rtw-next] wifi: rtw88: Add more validation for the RX
 descriptor
Thread-Topic: [PATCH rtw-next] wifi: rtw88: Add more validation for the RX
 descriptor
Thread-Index: AQHc5UJ+mQkQD4L530GtpNHFNKt6ebYTbXVwgAG0hICAAQP2cA==
Date: Wed, 20 May 2026 01:45:30 +0000
Message-ID: <3f8dfea6647c4ba4af01ee9f23f90c3e@realtek.com>
References: <a237ba9e-9f05-451f-9dfc-9aa8b11b7bc4@gmail.com>
 <1d0efa51a4214ee8b65d7f3ff9d52097@realtek.com>
 <cc24a412-40d7-4eb6-896e-0840ff0db067@gmail.com>
In-Reply-To: <cc24a412-40d7-4eb6-896e-0840ff0db067@gmail.com>
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
X-Spamd-Result: default: False [0.44 / 15.00];
	SUSPICIOUS_RECIPS(1.50)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c0a:e001:db::/64];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_SOME(0.00)[];
	FREEMAIL_CC(0.00)[gmail.com,googlemail.com,gmx.de,nokia-sbell.com];
	TAGGED_FROM(0.00)[bounces-36680-lists,linux-wireless=lfdr.de];
	RCVD_TLS_LAST(0.00)[];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	RCVD_COUNT_FIVE(0.00)[6];
	NEURAL_HAM(-0.00)[-1.000];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	DKIM_TRACE(0.00)[realtek.com:+];
	MID_RHS_MATCH_FROM(0.00)[];
	TAGGED_RCPT(0.00)[linux-wireless];
	RCPT_COUNT_SEVEN(0.00)[8];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c0a::/32, country:SG];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sea.lore.kernel.org:rdns,sea.lore.kernel.org:helo,realtek.com:email,realtek.com:mid,realtek.com:dkim]
X-Rspamd-Queue-Id: 4CC0A5869EA
X-Rspamd-Action: no action
X-Rspamd-Server: lfdr

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAx
OC8wNS8yMDI2IDExOjE0LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBTb21lIFJUTDg4MjFDRSBj
YXJkcyBjYW4gcmV0dXJuIGZyYW1lcyB3aXRoIGNvcnJ1cHRlZCBSWCBkZXNjcmlwdG9yLA0KPiA+
PiBjYXVzaW5nIHdhcm5pbmdzIGFuZCBjcmFzaGVzIGlmIHRoZXkgYXJlIHBhc3NlZCB0byB0aGUg
dXBwZXIgbGF5ZXJzLg0KPiA+DQo+ID4gTm90IHN1cmUgaWYgdGhpcyBpcyB0aGUgcmVhc29uIExh
cnJ5IHVwbG9hZGVkIGEgY29weSBvZiB2ZW5kb3IgZHJpdmVyDQo+ID4gdG8gaGlzIHJlcG9zaXRv
cnkgWzFdLg0KPiA+DQo+IA0KPiBIZSBhZGRlZCBpdCBmb3Igc29tZW9uZSB3aG9zZSB3aWZpIGNh
cmQgc29tZXRpbWVzIHdhc24ndCBwb3dlcmluZyBvbjoNCj4gDQo+IGh0dHBzOi8vZ2l0aHViLmNv
bS9sd2Zpbmdlci9ydHc4OC9pc3N1ZXMvOTgjaXNzdWVjb21tZW50LTEyNjM5NjI5NDMNCj4gDQo+
ID4gUmVjZW50bHksIHdlIHJlY2VpdmVkIHZ1bG5lcmFiaWxpdHkgcmVwb3J0IG9mIHJ0d19tcF9l
ZnVzZV9zZXQoKSBpbg0KPiA+IHZlbmRvciBkcml2ZXIuIEknZCBsaWtlIHRvIGtub3cgaWYgcGVv
cGxlIGFyZSBzdGlsbCB1c2luZyB0aGUgdmVuZG9yDQo+ID4gZHJpdmVyIFsxXS4gSWYgbm90LCBp
cyBpdCBwb3NzaWJsZSB0byByZW1vdmUgaXQ/IElmIHBlb3BsZSBzdGlsbCBuZWVkIGl0LA0KPiA+
IEkgd2lsbCBzaGFyZSB0aGUgZml4IG1hZGUgYnkgb3VyIGludGVybmFsIGxhdGVyLg0KPiA+DQo+
ID4gWzFdIGh0dHBzOi8vZ2l0aHViLmNvbS9sd2Zpbmdlci9ydHc4OC90cmVlL21hc3Rlci9hbHRf
cnRsODgyMWNlDQo+ID4NCj4gDQo+IFdlIGhhdmVuJ3QgYmVlbiB1cGRhdGluZyBpdCBmb3IgdGhl
IGtlcm5lbCBBUEkgY2hhbmdlcywgc28gSSB0aGluayB3ZQ0KPiBjYW4gcmVtb3ZlIGl0Lg0KDQpB
Z3JlZS4gQXMgY3VycmVudCB1c2VycyBkb24ndCByZXBvcnQgcG93ZXItb24gaXNzdWUgb24gcnR3
ODguDQpJZiB0aGUgcHJvYmxlbSBwcmVzZW50cyBhZ2Fpbiwgd2UgY2FuIHNwZW5kIHRpbWUgdG8g
ZGlnIHRoZSBkaWZmZXJlbmNlDQpvZiBwb3dlci1vbiBzZXF1ZW5jZSBiZXR3ZWVuIHZlbmRvciBk
cml2ZXIgYW5kIHJ0dzg4Lg0KDQo+IA0KPiA+Pg0KPiA+PiBUaGUgUEhZIHN0YXR1cyBzaXplIGZp
ZWxkIGlzIDQgYml0cyB3aWRlLCBidXQgaW4gcnR3ODggaXRzIHZhbHVlIHNob3VsZA0KPiA+PiBv
bmx5IGJlIDAgb3IgNC4gQ2hlY2tpbmcgdGhpcyBjYXRjaGVzIG1vc3Qgb2YgdGhlIGNvcnJ1cHQg
ZnJhbWVzLg0KPiA+Pg0KPiA+PiBJZiBhIFBIWSBzdGF0dXMgaXMgcHJlc2VudCwgdGhlIFBIWSBz
dGF0dXMgc2l6ZSBzaG91bGQgbm90IGJlIDAuDQo+ID4+DQo+ID4+IFRoZSBmcmFtZSBzaXplIHNo
b3VsZCBub3QgYmUgbGVzcyB0aGFuIG9yIGVxdWFsIHRvIDQgYW5kIHNob3VsZCBub3QNCj4gPj4g
ZXhjZWVkIDExNDU0Lg0KPiA+Pg0KPiA+PiBEaXNjYXJkIHRoZSBmcmFtZSBpZiBhbnkgb2YgdGhl
c2UgY2hlY2tzIGZhaWwuDQo+ID4+DQo+ID4+IENsb3NlczogaHR0cHM6Ly9idWd6aWxsYS5rZXJu
ZWwub3JnL3Nob3dfYnVnLmNnaT9pZD0yMjEyODYNCj4gPj4gU2lnbmVkLW9mZi1ieTogQml0dGVy
Ymx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+ID4NCj4gPiBBY2tlZC1ieTog
UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQo+ID4NCj4gPiBbLi4uXQ0KPiA+DQo+
ID4+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J4LmMg
Yi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J4LmMNCj4gPj4gaW5kZXggZDll
MTEzNDNkNDk4Li42NWY2ZGIzZDdmY2IgMTAwNjQ0DQo+ID4+IC0tLSBhL2RyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnR3ODgvcnguYw0KPiA+PiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0dzg4L3J4LmMNCj4gPj4gQEAgLTMsNiArMyw3IEBADQo+ID4+ICAgKi8NCj4g
Pj4NCj4gPj4gICNpbmNsdWRlICJtYWluLmgiDQo+ID4+ICsjaW5jbHVkZSAibWFjLmgiDQo+ID4+
ICAjaW5jbHVkZSAicnguaCINCj4gPj4gICNpbmNsdWRlICJwcy5oIg0KPiA+PiAgI2luY2x1ZGUg
ImRlYnVnLmgiDQo+ID4+IEBAIC0yNjEsOSArMjYyLDkgQEAgc3RhdGljIHZvaWQgcnR3X3J4X2Zp
bGxfcnhfc3RhdHVzKHN0cnVjdCBydHdfZGV2ICpydHdkZXYsDQo+ID4+ICAgICAgICAgfQ0KPiA+
PiAgfQ0KPiA+Pg0KPiA+PiAtdm9pZCBydHdfcnhfcXVlcnlfcnhfZGVzYyhzdHJ1Y3QgcnR3X2Rl
diAqcnR3ZGV2LCB2b2lkICpyeF9kZXNjOCwNCj4gPj4gLSAgICAgICAgICAgICAgICAgICAgICAg
ICBzdHJ1Y3QgcnR3X3J4X3BrdF9zdGF0ICpwa3Rfc3RhdCwNCj4gPj4gLSAgICAgICAgICAgICAg
ICAgICAgICAgICBzdHJ1Y3QgaWVlZTgwMjExX3J4X3N0YXR1cyAqcnhfc3RhdHVzKQ0KPiA+PiAr
aW50IHJ0d19yeF9xdWVyeV9yeF9kZXNjKHN0cnVjdCBydHdfZGV2ICpydHdkZXYsIHZvaWQgKnJ4
X2Rlc2M4LA0KPiA+PiArICAgICAgICAgICAgICAgICAgICAgICAgc3RydWN0IHJ0d19yeF9wa3Rf
c3RhdCAqcGt0X3N0YXQsDQo+ID4+ICsgICAgICAgICAgICAgICAgICAgICAgICBzdHJ1Y3QgaWVl
ZTgwMjExX3J4X3N0YXR1cyAqcnhfc3RhdHVzKQ0KPiA+PiAgew0KPiA+PiAgICAgICAgIHUzMiBk
ZXNjX3N6ID0gcnR3ZGV2LT5jaGlwLT5yeF9wa3RfZGVzY19zejsNCj4gPj4gICAgICAgICBzdHJ1
Y3QgcnR3X3J4X2Rlc2MgKnJ4X2Rlc2MgPSByeF9kZXNjODsNCj4gPj4gQEAgLTMwMywxMiArMzA0
LDI1IEBAIHZvaWQgcnR3X3J4X3F1ZXJ5X3J4X2Rlc2Moc3RydWN0IHJ0d19kZXYgKnJ0d2Rldiwg
dm9pZCAqcnhfZGVzYzgsDQo+ID4+ICAgICAgICAgICAgICAgICBwa3Rfc3RhdC0+YncgPSBSVFdf
Q0hBTk5FTF9XSURUSF8yMDsNCj4gPg0KPiA+IERvIHlvdSB0aGluayBpZiB3ZSBzaG91bGQgcmV0
dXJuIC1FSU5WQUwgZm9yIHRoaXMgY2FzZSB0b28/DQo+ID4NCj4gDQo+IFllcy4gV2hhdCBkbyB3
ZSBkbyB3aXRoIHRoZSBkZWJ1ZyBtZXNzYWdlPyBTaG91bGQgdGhlIG90aGVyDQo+IGNvbmRpdGlv
bnMgYWxzbyBoYXZlIGEgZGVidWcgbWVzc2FnZT8NCg0KUGVyc29uYWxseSBJJ2QgcmVtb3ZlIHRo
ZSBkZWJ1ZyBtZXNzYWdlLiBJZiB5b3UgdGhpbmsgdGhleSBhcmUgaGVscGZ1bCB0bw0KZGlnIHBy
b2JsZW1zIChmb3IgdW5jb25zaWRlcmVkIGNvcm5lciBjYXNlcyksIGl0IGlzIGZpbmUgdG8gbWUg
dG8gYWRkDQphIG1lc3NhZ2UgZm9yIGVhY2ggY29uZGl0aW9uLg0KDQpJIHN1cHBvc2UgeW91IHdp
bGwgc2VuZCBhIG5ldyBwYXRjaCwgYW5kIEknbGwgd2FpdCBmb3IgdjIuDQoNCj4gDQo+ID4+ICAg
ICAgICAgfQ0KPiA+Pg0KPiA+PiArICAgICAgIGlmICh1bmxpa2VseShwa3Rfc3RhdC0+ZHJ2X2lu
Zm9fc3ogJiYNCj4gPj4gKyAgICAgICAgICAgICAgICAgICAgcGt0X3N0YXQtPmRydl9pbmZvX3N6
ICE9IFBIWV9TVEFUVVNfU0laRSkpDQo+ID4+ICsgICAgICAgICAgICAgICByZXR1cm4gLUVJTlZB
TDsNCj4gPj4gKw0KPiA+PiArICAgICAgIGlmICh1bmxpa2VseShwa3Rfc3RhdC0+cGh5X3N0YXR1
cyAmJiAhcGt0X3N0YXQtPmRydl9pbmZvX3N6KSkNCj4gPj4gKyAgICAgICAgICAgICAgIHJldHVy
biAtRUlOVkFMOw0KPiA+PiArDQo+ID4+ICsgICAgICAgaWYgKHVubGlrZWx5KHBrdF9zdGF0LT5w
a3RfbGVuID4gSUVFRTgwMjExX01BWF9NUERVX0xFTl9WSFRfMTE0NTQpKQ0KPiA+PiArICAgICAg
ICAgICAgICAgcmV0dXJuIC1FSU5WQUw7DQo+ID4+ICsNCj4gPj4gICAgICAgICAvKiBkcnZfaW5m
b19zeiBpcyBpbiB1bml0IG9mIDgtYnl0ZXMgKi8NCj4gPj4gICAgICAgICBwa3Rfc3RhdC0+ZHJ2
X2luZm9fc3ogKj0gODsNCj4gPj4NCj4gPj4gICAgICAgICAvKiBjMmggY21kIHBrdCdzIHJ4L3Bo
eSBzdGF0dXMgaXMgbm90IGludGVyZXN0ZWQgKi8NCj4gPj4gICAgICAgICBpZiAocGt0X3N0YXQt
PmlzX2MyaCkNCj4gPj4gLSAgICAgICAgICAgICAgIHJldHVybjsNCj4gPj4gKyAgICAgICAgICAg
ICAgIHJldHVybiAwOw0KPiA+PiArDQo+ID4+ICsgICAgICAgaWYgKHVubGlrZWx5KHBrdF9zdGF0
LT5wa3RfbGVuIDw9IEZDU19MRU4pKQ0KPiA+PiArICAgICAgICAgICAgICAgcmV0dXJuIC1FSU5W
QUw7DQo+ID4+DQo+ID4+ICAgICAgICAgcGh5X3N0YXR1cyA9IHJ4X2Rlc2M4ICsgZGVzY19zeiAr
IHBrdF9zdGF0LT5zaGlmdDsNCj4gPj4gICAgICAgICBoZHIgPSBwaHlfc3RhdHVzICsgcGt0X3N0
YXQtPmRydl9pbmZvX3N6Ow0KPiA+DQo+ID4gWy4uLl0NCj4gPg0KDQo=

