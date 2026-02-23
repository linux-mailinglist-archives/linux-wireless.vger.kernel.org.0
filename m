Return-Path: <linux-wireless+bounces-32080-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id SBI1IDGkm2mG4AMAu9opvQ
	(envelope-from <linux-wireless+bounces-32080-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 01:49:53 +0100
X-Original-To: lists+linux-wireless@lfdr.de
Received: from sin.lore.kernel.org (sin.lore.kernel.org [IPv6:2600:3c15:e001:75::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 9372E171047
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 01:49:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sin.lore.kernel.org (Postfix) with ESMTP id 1F19D30074E4
	for <lists+linux-wireless@lfdr.de>; Mon, 23 Feb 2026 00:49:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E4B1822F75E;
	Mon, 23 Feb 2026 00:49:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="PoPqXBZJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA9422F177
	for <linux-wireless@vger.kernel.org>; Mon, 23 Feb 2026 00:49:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771807788; cv=none; b=aCreWAmbTdXsrAdnk23CaE44EqgF5VL+hzFW2BydsJTQIEP5dakVHnrVn3A61Q+hreEvHWflWvCUkU66OObrKsiej3fQxLHIFKINho7WcXrk/oy0Q3BD8cPXb0kkoSZI3CJf3LfQAm8fE7epmhARrM22etIe97GWlXjpp8DB0Vg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771807788; c=relaxed/simple;
	bh=RffBfHxwPos5RCZCCQwWgakbsmP4n9zWyO9UH+v0awc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Nn1kxI7OvIQROsnLzhnWKL0JMvr2GsTtCNdF+tGJhwOfPaPtzS51N+hRYmKpKum7UZQQpM/e/XIb7l49WwEgBi9rRcXsQppfyeH4LJgg9jtXLan7213ixkIK5TmxrlS2RbvcJKPsm/6w+tB5sqLZJuKTX8ibjba48Nclk9anhzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=PoPqXBZJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 61N0nfcA74007085, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1771807781; bh=RffBfHxwPos5RCZCCQwWgakbsmP4n9zWyO9UH+v0awc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=PoPqXBZJQhyIULs1U4vQ8vxj4O9duEq3tFajCQwLz9J9JyfObFIP6bs/1N0NNlsue
	 S9KCEpOgNuG7QtHOuIZcSnuUaXmixksgD5nrbdDbCLEApDPccNAd2VHioRoK0VEWHJ
	 wUetdv/Jn1l/u8mCqovDumUc4d9W2WT5JYBkpW5CjJeTz3H1AR+yJZLmoAdiGlIbYB
	 k0riKI7b5mTdHCnbtAemQRcbiMbh1wkhiH92D/BalOsGGM0V6IiFTbYY3JDd66//Id
	 L2awafIk5Np+oVG0oWCXO5c21hHtaC1Ovyf++mqOBYntyPWRQhgbpRHGTbMzojje4o
	 wfQZTFv0lbcpA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 61N0nfcA74007085
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 23 Feb 2026 08:49:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 23 Feb 2026 08:49:42 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1748.10; Mon, 23 Feb 2026 08:49:41 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::4cbd:6c6c:b92b:3913%10]) with mapi id
 15.02.1748.010; Mon, 23 Feb 2026 08:49:41 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw88: Ignore TX report sequence number
 from the 8051 chips
Thread-Topic: [PATCH rtw-next] wifi: rtw88: Ignore TX report sequence number
 from the 8051 chips
Thread-Index: AQHcmIFUmn8F5SE8tkKhCC9anOXjZ7V6Bk9QgABO9gCAASjwkIAAdF4AgADO8DCABAhwAIAOwJAw
Date: Mon, 23 Feb 2026 00:49:41 +0000
Message-ID: <54260c1e539b41afb9274025b88745a9@realtek.com>
References: <4fc30feb-5616-4e2e-86d8-0d96e4f191c2@gmail.com>
 <04799d469547468abe15eadb2ec74255@realtek.com>
 <a95d43dc-58c7-4c9c-9b42-204f2134f099@gmail.com>
 <442b0555b369487b81ba96dcf410cf7d@realtek.com>
 <9110568d-419b-46a7-b0f0-808f958a6efc@gmail.com>
 <f9652882eeb042f89463e0fa864f1412@realtek.com>
 <f397c14a-1bd5-4e8c-8e34-921ec3695f09@gmail.com>
In-Reply-To: <f397c14a-1bd5-4e8c-8e34-921ec3695f09@gmail.com>
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
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c15:e001:75::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_GOOD(-0.10)[text/plain];
	MIME_BASE64_TEXT(0.10)[];
	HAS_LIST_UNSUB(-0.01)[];
	RCVD_TLS_LAST(0.00)[];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	TAGGED_FROM(0.00)[bounces-32080-lists,linux-wireless=lfdr.de];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	MIME_TRACE(0.00)[0:+];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	DBL_BLOCKED_OPENRESOLVER(0.00)[sin.lore.kernel.org:helo,sin.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-0.997];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c15::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Queue-Id: 9372E171047
X-Rspamd-Action: no action

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAx
MS8wMi8yMDI2IDA0OjAzLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4NCj4gPiBCaXR0ZXJibHVl
IFNtaXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4+IE9uIDEwLzAyLzIw
MjYgMDg6NDQsIFBpbmctS2UgU2hpaCB3cm90ZToNCj4gPj4+IEJpdHRlcmJsdWUgU21pdGggPHJ0
bDg4MjFjZXJmZTJAZ21haWwuY29tPiB3cm90ZToNCj4gPj4+PiBPbiAwOS8wMi8yMDI2IDEwOjE5
LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4+Pj4+IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFj
ZXJmZTJAZ21haWwuY29tPiB3cm90ZToNCj4gPj4+Pj4+IFdoZW4gY29ubmVjdGVkIHRvIGEgbmV0
d29yayBpbiB0aGUgMi40IEdIeiBiYW5kLCB3cGFfc3VwcGxpY2FudCAob3INCj4gPj4+Pj4+IE5l
dHdvcmtNYW5hZ2VyPykgdHJpZ2dlcnMgYSBzY2FuIGV2ZXJ5IGZpdmUgbWludXRlcy4gRHVyaW5n
IHRoZXNlIHNjYW5zDQo+ID4+Pj4+PiBtYWM4MDIxMSB0cmFuc21pdHMgbWFueSBRb1MgTnVsbCBm
cmFtZXMgaW4gcXVpY2sgc3VjY2Vzc2lvbi4gQmVjYXVzZQ0KPiA+Pj4+Pj4gdGhlc2UgZnJhbWVz
IGFyZSBtYXJrZWQgd2l0aCBJRUVFODAyMTFfVFhfQ1RMX1JFUV9UWF9TVEFUVVMsIHJ0dzg4DQo+
ID4+Pj4+PiBhc2tzIHRoZSBmaXJtd2FyZSB0byByZXBvcnQgdGhlIFRYIEFDSyBzdGF0dXMgZm9y
IGVhY2ggb2YgdGhlc2UgZnJhbWVzLg0KPiA+Pj4+Pj4gU29tZXRpbWVzIHRoZSBmaXJtd2FyZSBj
YW4ndCBwcm9jZXNzIHRoZSBUWCBzdGF0dXMgcmVxdWVzdHMgcXVpY2tseQ0KPiA+Pj4+Pj4gZW5v
dWdoLCB0aGV5IGFkZCB1cCwgaXQgb25seSBwcm9jZXNzZXMgc29tZSBvZiB0aGVtLCBhbmQgdGhl
biBtYXJrcw0KPiA+Pj4+Pj4gZXZlcnkgc3Vic2VxdWVudCBUWCBzdGF0dXMgcmVwb3J0IHdpdGgg
dGhlIHdyb25nIG51bWJlci4NCj4gPj4+Pj4NCj4gPj4+Pj4gRG9lcyBpdCBtZWFuIG51bWJlciBv
ZiByZXBvcnRzIGlzIGNvcnJlY3Q/IEJ1dCB3aXRoIGluY29ycmVjdCBzZXF1ZW5jZSBudW1iZXI/
DQo+ID4+Pj4+IFRoZW4sIHlvdSBqdXN0IGlnbm9yZSBjaGVja2luZyAnc24nIGJ1dCBhc3N1bWUg
J3N0JyBpcyBjb3JyZWN0Lg0KPiA+Pj4+Pg0KPiA+Pj4+DQo+ID4+Pj4gVGhlIG51bWJlciBvZiBy
ZXBvcnRzIGlzIGNvcnJlY3QgbW9zdCBvZiB0aGUgdGltZS4gT25seSB3aGVuIHRoZSBmaXJtd2Fy
ZQ0KPiA+Pj4+IGlzIG92ZXJ3aGVsbWVkICg/KSBpdCBkb2Vzbid0IHByb3ZpZGUgZXZlcnkgcmVw
b3J0LCBidXQgbGF0ZXIgaXQgcmVjb3ZlcnMuDQo+ID4+Pj4NCj4gPj4+DQo+ID4+PiBJIHdhcyBu
b3QgYXdhcmUgdGhhdCB0aGlzIGhhcHBlbmVkIHdoaWxlIHNjYW5uaW5nLCBzbyB3ZSBtaWdodCBh
cHBseSB0aGlzIGxvb3NlDQo+ID4+PiBjaGVja2luZyB1bmRlciBzY2FuIGNvbmRpdGlvbiAtLSB0
ZXN0X2JpdChSVFdfRkxBR19TQ0FOTklORywgcnR3ZGV2LT5mbGFncykiPw0KPiA+Pj4gSWYgVFgg
cmVwb3J0IGlzIGJlY2F1c2Ugb2YgcmUta2V5LCBpdCBjYW4gc3RpbGwgdXNlIG9yaWdpbmFsIHJ1
bGUuDQo+ID4+Pg0KPiA+Pj4gWy4uLl0NCj4gPj4+DQo+ID4+DQo+ID4+IFdlIGNhbid0IGRvIHRo
YXQgYmVjYXVzZSB0aGUgc2VxdWVuY2UgbnVtYmVyIGlzIHBlcm1hbmVudGx5IG1lc3NlZCB1cC4N
Cj4gPg0KPiA+IEluZGVlZC4uLg0KPiA+DQo+ID4+DQo+ID4+IEkgdGhvdWdodCBhYm91dCBpZ25v
cmluZyBJRUVFODAyMTFfVFhfQ1RMX1JFUV9UWF9TVEFUVVMgb24gbnVsbCBmcmFtZXMNCj4gPj4g
c2VudCBkdXJpbmcgc2NhbnMsIGJ1dCB1bmZvcnR1bmF0ZWx5IHRoZSBsYXN0IDIgb3IgMyBRT1Mg
TnVsbCBmcmFtZXMNCj4gPj4gYXJlIHNlbnQgYWZ0ZXIgUlRXX0ZMQUdfU0NBTk5JTkcgaXMgdW5z
ZXQsIGFuZCB0aGV5IHN0aWxsIHRyaWdnZXIgdGhlDQo+ID4+IHByb2JsZW0uDQo+ID4+DQo+ID4+
IFdoaWxlIHBva2luZyBhcm91bmQgdG9kYXkgSSBub3RpY2VkIHRoYXQgb25seSBub24tUU9TIG51
bGwgZnJhbWVzIGFyZQ0KPiA+PiB0cmVhdGVkIGxpa2UgbWFuYWdlbWVudCBmcmFtZXMuIFFPUyBu
dWxsIGZyYW1lcyBhcmUgdHJlYXRlZCBsaWtlIGRhdGENCj4gPj4gZnJhbWVzLiBTbyBJIHRyaWVk
IHRoaXMgY2hhbmdlOg0KPiA+Pg0KPiA+PiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OC90eC5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4
OC90eC5jDQo+ID4+IGluZGV4IDc4Mzk3NWFjZGNmZi4uZWE4M2RhYTlkNjBkIDEwMDY0NA0KPiA+
PiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3R4LmMNCj4gPj4gKysr
IGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC90eC5jDQo+ID4+IEBAIC00MjQs
NyArNDI0LDcgQEAgdm9pZCBydHdfdHhfcGt0X2luZm9fdXBkYXRlKHN0cnVjdCBydHdfZGV2ICpy
dHdkZXYsDQo+ID4+ICAgICAgICAgICAgICAgICBwa3RfaW5mby0+bWFjX2lkID0gcnR3dmlmLT5t
YWNfaWQ7DQo+ID4+ICAgICAgICAgfQ0KPiA+Pg0KPiA+PiAtICAgICAgIGlmIChpZWVlODAyMTFf
aXNfbWdtdChmYykgfHwgaWVlZTgwMjExX2lzX251bGxmdW5jKGZjKSkNCj4gPj4gKyAgICAgICBp
ZiAoaWVlZTgwMjExX2lzX21nbXQoZmMpIHx8IGllZWU4MDIxMV9pc19hbnlfbnVsbGZ1bmMoZmMp
KQ0KPiA+PiAgICAgICAgICAgICAgICAgcnR3X3R4X21nbXRfcGt0X2luZm9fdXBkYXRlKHJ0d2Rl
diwgcGt0X2luZm8sIHN0YSwgc2tiKTsNCj4gPj4gICAgICAgICBlbHNlIGlmIChpZWVlODAyMTFf
aXNfZGF0YShmYykpDQo+ID4+ICAgICAgICAgICAgICAgICBydHdfdHhfZGF0YV9wa3RfaW5mb191
cGRhdGUocnR3ZGV2LCBwa3RfaW5mbywgc3RhLCBza2IpOw0KPiA+Pg0KPiA+PiBXaXRoIHRoaXMg
SSBjYW4ndCB0cmlnZ2VyIHRoZSBwcm9ibGVtIGFueW1vcmUuIFRoZSBzZXF1ZW5jZSBudW1iZXJz
DQo+ID4+IGFyZSBub3JtYWwgZXZlcnkgdGltZS4gV2VsbCwgaXQncyB0b28gc29vbiB0byBiZSBz
dXJlLCBzbyBJIHdpbGwga2VlcA0KPiA+PiB0ZXN0aW5nIGZvciBhIGZldyBkYXlzLg0KPiA+DQo+
ID4gR29vZCBmaW5kaW5nLiBQbGVhc2Uga2VlcCB0ZXN0aW5nIGl0Lg0KPiA+DQo+IA0KPiBTdGls
bCBubyBwcm9ibGVtIHR3byBkYXlzIGxhdGVyLg0KDQpUaGVuIGxldCdzIHRha2UgdGhlIHNvbHV0
aW9uIHlvdSBuZXdseSBmb3VuZC4gOikNCg0KPiANCj4gPiBGWUkuIEhhdmluZyB0aGUgbHVuYXIg
TmV3IFllYXIgbmV4dCB3ZWVrLCBJIHdpbGwgbm90IHJlcGx5IHlvdXIgbWFpbCBzb29uLg0KPiA+
DQo+IA0KPiBIYXZlIGEgZ29vZCBob2xpZGF5IQ0KDQpUaGFua3MuIEknbSBnZXR0aW5nIGJhY2su
IA0KDQo+IA0KPiA+Pg0KPiA+Pj4+DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gVGhlIHN5bXB0b20gaXMg
dGhhdCBhZnRlciBhIHdoaWxlIHRoZSB3YXJuaW5nICJmYWlsZWQgdG8gZ2V0IHR4IHJlcG9ydA0K
PiA+Pj4+Pj4gZnJvbSBmaXJtd2FyZSIgYXBwZWFycyBldmVyeSBmaXZlIG1pbnV0ZXMuDQo+ID4+
Pj4+Pg0KPiA+Pj4+Pj4gVGhpcyBwcm9ibGVtIGFwcGFyZW50bHkgaGFwcGVucyBvbmx5IHdpdGgg
dGhlIG9sZGVyIFJUTDg3MjNELCBSVEw4ODIxQSwNCj4gPj4+Pj4+IFJUTDg4MTJBLCBhbmQgcHJv
YmFibHkgUlRMODcwM0IgY2hpcHMuIElnbm9yZSB0aGUgVFggcmVwb3J0IHNlcXVlbmNlDQo+ID4+
Pj4+PiBudW1iZXIgcmVwb3J0ZWQgYnkgdGhlc2UgY2hpcHMgYW5kIG1hdGNoIHRoZSByZXBvcnRz
IHdpdGggdGhlIHJlcXVlc3RzDQo+ID4+Pj4+PiBpbiB0aGUgb3JkZXIgdGhleSBjb21lIGluLg0K
PiA+Pj4+Pj4NCj4gPj4+Pj4+IFRlc3RlZCB3aXRoIFJUTDg4MjFBVSBhbmQgUlRMODcyM0RVLg0K
PiA+Pj4+Pj4NCj4gPj4+Pj4+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4
MjFjZXJmZTJAZ21haWwuY29tPg0KPiA+Pj4+Pj4gLS0tDQo+ID4+Pj4+PiAgZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydHc4OC90eC5jIHwgMiArLQ0KPiA+Pj4+Pj4gIDEgZmlsZSBjaGFu
Z2VkLCAxIGluc2VydGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+Pj4+Pj4NCj4gPj4+Pj4+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3R4LmMgYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3R4LmMNCj4gPj4+Pj4+IGluZGV4IGMwNGZm
MzFkMGYxZS4uOTgyMTVlY2M4ODRhIDEwMDY0NA0KPiA+Pj4+Pj4gLS0tIGEvZHJpdmVycy9uZXQv
d2lyZWxlc3MvcmVhbHRlay9ydHc4OC90eC5jDQo+ID4+Pj4+PiArKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3R4LmMNCj4gPj4+Pj4+IEBAIC0yNDgsNyArMjQ4LDcgQEAg
dm9pZCBydHdfdHhfcmVwb3J0X2hhbmRsZShzdHJ1Y3QgcnR3X2RldiAqcnR3ZGV2LCBzdHJ1Y3Qg
c2tfYnVmZiAqc2tiLCBpbnQgc3JjKQ0KPiA+Pj4+Pj4gICAgICAgICBzcGluX2xvY2tfaXJxc2F2
ZSgmdHhfcmVwb3J0LT5xX2xvY2ssIGZsYWdzKTsNCj4gPj4+Pj4+ICAgICAgICAgc2tiX3F1ZXVl
X3dhbGtfc2FmZSgmdHhfcmVwb3J0LT5xdWV1ZSwgY3VyLCB0bXApIHsNCj4gPj4+Pj4+ICAgICAg
ICAgICAgICAgICBuID0gKHU4ICopSUVFRTgwMjExX1NLQl9DQihjdXIpLT5zdGF0dXMuc3RhdHVz
X2RyaXZlcl9kYXRhOw0KPiA+Pj4+Pj4gLSAgICAgICAgICAgICAgIGlmICgqbiA9PSBzbikgew0K
PiA+Pj4+Pj4gKyAgICAgICAgICAgICAgIGlmICgqbiA9PSBzbiB8fCBydHdfY2hpcF93Y3B1Xzgw
NTEocnR3ZGV2KSkgew0KPiA+Pj4+Pg0KPiA+Pj4+PiBDYW4gd2Ugb25seSBsaW1pdCB0byBVU0Ig
ZGV2aWNlcyAob3Igbm9uLVBDSSBkZXZpY2VzKT8NCj4gPj4+Pj4NCj4gPj4+Pg0KPiA+Pj4+IEkg
ZG9uJ3QgdGhpbmsgc28uIFJUTDg4MjFBRSBhbHNvIGhhcyB0aGlzIHByb2JsZW0uIEkgZGlkbid0
IG1lbnRpb24gaXQNCj4gPj4+PiBpbiB0aGUgY29tbWl0IG1lc3NhZ2UgYmVjYXVzZSBzdXBwb3J0
IGZvciBSVEw4ODIxQUUgaW4gcnR3ODggaXMNCj4gPj4+PiB1bm9mZmljaWFsLiAoSSBtb2RpZmll
ZCBydHc4OF9wY2kgdG8gaGFuZGxlIHRoZSBvbGRlciBnZW5lcmF0aW9uLCBzZWUNCj4gPj4+PiB0
aGUgdXNlX25ld190cnhfZmxvdz1mYWxzZSBjb2RlIHBhdGggaW4gcnRsd2lmaS4pDQo+ID4+Pg0K
PiA+Pj4gSG93IGFib3V0IG9mZmljaWFsIFJUTDg3MjNERT8NCj4gPj4+DQo+ID4+DQo+ID4+IEkg
ZG9uJ3QgaGF2ZSBSVEw4NzIzREUuIEkgY2FuIHRyeSB3aXRoIFJUTDg3MjNEUywgYWx0aG91Z2gg
aXQncyBhbm5veWluZw0KPiA+PiB0byB1c2UuIChUaGUgaG9zdCBpcyBzb21lIGtpbmQgb2Ygc2lu
Z2xlIGJvYXJkIGNvbXB1dGVyLiBJdCBoYXMgb25seSBhDQo+ID4+IHNlcmlhbCBpbnRlcmZhY2Ug
YW5kIHdoZW4gSSBjb25uZWN0IHRoYXQgdG8gbXkgbGFwdG9wIGl0IG1ha2VzIHRoZQ0KPiA+PiB0
b3VjaHBhZCBzbG93IGZvciBzb21lIHJlYXNvbi4pDQo+ID4NCj4gPiBJIGZvdW5kIGEgUlRMODcy
M0RFIGFuZCB0ZXN0ZWQgc2NhbiBkdXJpbmcgY29ubmVjdGlvbiBvdmVyIDEwIHRpbWVzDQo+ID4g
KHdpdGggbG9jYWwgbW9kaWZpY2F0aW9uIHRvIHByaW50IFRYLXNuL1JYLXNuKS4NCj4gPiBJJ2Qg
c2F5IFJUTDg3MjNERSBkb2Vzbid0IGhhdmUgdGhpcyBwcm9ibGVtLg0KPiA+DQo+IA0KPiBJdCBj
YW4gdGFrZSBob3VycywgYWx0aG91Z2ggd2l0aCBSVEw4ODIxQUUgaXQgaGFwcGVucyBpbiBqdXN0
IGEgZmV3DQo+IG1pbnV0ZXMuDQo+IA0KPiA+Pg0KPiA+Pj4+DQo+ID4+Pj4+PiAgICAgICAgICAg
ICAgICAgICAgICAgICBfX3NrYl91bmxpbmsoY3VyLCAmdHhfcmVwb3J0LT5xdWV1ZSk7DQo+ID4+
Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICBydHdfdHhfcmVwb3J0X3R4X3N0YXR1cyhydHdk
ZXYsIGN1ciwgc3QgPT0gMCk7DQo+ID4+Pj4+PiAgICAgICAgICAgICAgICAgICAgICAgICBicmVh
azsNCj4gPj4+Pj4+IC0tDQo+ID4+Pj4+PiAyLjUyLjANCj4gPj4+Pj4NCj4gPj4+DQo+ID4NCg0K

