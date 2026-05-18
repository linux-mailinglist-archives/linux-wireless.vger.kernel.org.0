Return-Path: <linux-wireless+bounces-36593-lists+linux-wireless=lfdr.de@vger.kernel.org>
Delivered-To: lists+linux-wireless@lfdr.de
Received: from mail.lfdr.de
	by lfdr with LMTP
	id EG13BsnGCmqf8AQAu9opvQ
	(envelope-from <linux-wireless+bounces-36593-lists+linux-wireless=lfdr.de@vger.kernel.org>)
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 09:59:05 +0200
X-Original-To: lists+linux-wireless@lfdr.de
Received: from tor.lore.kernel.org (tor.lore.kernel.org [IPv6:2600:3c04:e001:36c::12fc:5321])
	by mail.lfdr.de (Postfix) with ESMTPS id 8A6D4568458
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 09:59:04 +0200 (CEST)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by tor.lore.kernel.org (Postfix) with ESMTP id E395D306B071
	for <lists+linux-wireless@lfdr.de>; Mon, 18 May 2026 07:52:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EE2E1346770;
	Mon, 18 May 2026 07:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="BiGj1mQI"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B71773CF02A
	for <linux-wireless@vger.kernel.org>; Mon, 18 May 2026 07:51:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779090685; cv=none; b=aNTouKr+zsH0GhnHTbx7bC0DxMRFBi3xSguv9Ccwrw3ea+BOABFZg5cYBVnLBWAbYAOry1ZDt7ZqaaH4xaKZMpkmaSYInZY2jQhr0Ak0YDm0T/sFodIYa5Gec7iNjfEzpXyHk2sXUBbCQGCsu4SAyPHE5t5k41blw4EvQ3mI6AA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779090685; c=relaxed/simple;
	bh=ypEK4ubSd043pZtiYplVv/GYP+icWPTczIBKR93xU4c=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I6278t3tGUVzTcf9por2m5fzsfFonzgssr4HNA0jnziX+brGE5ZBIuJ7OW00UwH5eLaa1ngkegQEO29kS6VlT8Dsb5zScffrB8GXtu40AWK31HQSJG7+JCd8LU8wGVJr5X7Mm9OOGsQyS/uO1omSvR8Hl9mNj+NqKWP7m2ipQNM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=BiGj1mQI; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 64I7pIRz91628965, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1779090678; bh=ypEK4ubSd043pZtiYplVv/GYP+icWPTczIBKR93xU4c=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=BiGj1mQIKhWgJKfP7ONAKAftmEVdK4m2/axDLKnbSCGGjqx6RvQ6OwIW4t+W/LkwF
	 xHWoSN9BHQ+QsKoqN8VoeoRXz/z6RFBONJM9L7a1KcTxGJBLlcZgtC/Ys/HaOWi5rv
	 3VL4yPHlEjKPDqwxyAyMtSzgWLBCntxvf6ojx1eEtzUtss/K3YkhOvxG4RDNzUoajm
	 xbKSR3xnCnFa3b92pc7TuhZ2eFzrODHkXOD/vDdgoOp1DB1O9xlL5A7+wbUZhD0Zr1
	 nnps+trwaTxzhwUvu30i7JO82l4QqCmxCvQHojYbAZM4IMYnOo7ywEcEBcPpelWeN2
	 V65dOHXaASV9w==
Received: from mail.realtek.com (rtkexhmbs04.realtek.com.tw[10.21.1.54])
	by rtits2.realtek.com.tw (8.15.2/3.27/5.94) with ESMTPS id 64I7pIRz91628965
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 18 May 2026 15:51:18 +0800
Received: from RTKEXHMBS05.realtek.com.tw (10.21.1.55) by
 RTKEXHMBS04.realtek.com.tw (10.21.1.54) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 May 2026 15:51:18 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS05.realtek.com.tw (10.21.1.55) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.17; Mon, 18 May 2026 15:51:17 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::e6fd:5a3f:8946:92c4%10]) with mapi id
 15.02.2562.017; Mon, 18 May 2026 15:51:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v3] wifi: rtw89: usb: Support switching to USB 3
 mode
Thread-Topic: [PATCH rtw-next v3] wifi: rtw89: usb: Support switching to USB 3
 mode
Thread-Index: AQHc5TJ2jt4wT7BMb0ihQX+ES4ddkbYTaOAw
Date: Mon, 18 May 2026 07:51:17 +0000
Message-ID: <5fc263787831471f87585fb90a9b0fcb@realtek.com>
References: <fcdde81a-97ec-458f-8e70-ac024938f1d7@gmail.com>
In-Reply-To: <fcdde81a-97ec-458f-8e70-ac024938f1d7@gmail.com>
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
X-Rspamd-Queue-Id: 8A6D4568458
X-Rspamd-Server: lfdr
X-Spamd-Result: default: False [-1.06 / 15.00];
	MIME_BASE64_TEXT_BOGUS(1.00)[];
	ARC_ALLOW(-1.00)[subspace.kernel.org:s=arc-20240116:i=1];
	DMARC_POLICY_ALLOW(-0.50)[realtek.com,none];
	R_DKIM_ALLOW(-0.20)[realtek.com:s=dkim];
	R_SPF_ALLOW(-0.20)[+ip6:2600:3c04:e001:36c::/64:c];
	MAILLIST(-0.15)[generic];
	MIME_BASE64_TEXT(0.10)[];
	MIME_GOOD(-0.10)[text/plain];
	HAS_LIST_UNSUB(-0.01)[];
	TO_DN_EQ_ADDR_SOME(0.00)[];
	RCVD_TLS_LAST(0.00)[];
	TO_DN_SOME(0.00)[];
	RCPT_COUNT_TWO(0.00)[2];
	TAGGED_FROM(0.00)[bounces-36593-lists,linux-wireless=lfdr.de];
	MIME_TRACE(0.00)[0:+];
	FREEMAIL_TO(0.00)[gmail.com,vger.kernel.org];
	DBL_BLOCKED_OPENRESOLVER(0.00)[tor.lore.kernel.org:helo,tor.lore.kernel.org:rdns];
	FORGED_RECIPIENTS_MAILLIST(0.00)[];
	FORGED_SENDER_MAILLIST(0.00)[];
	PRECEDENCE_BULK(0.00)[];
	FROM_NEQ_ENVFROM(0.00)[pkshih@realtek.com,linux-wireless@vger.kernel.org];
	FROM_HAS_DN(0.00)[];
	DKIM_TRACE(0.00)[realtek.com:+];
	NEURAL_HAM(-0.00)[-0.999];
	TAGGED_RCPT(0.00)[linux-wireless];
	MID_RHS_MATCH_FROM(0.00)[];
	MISSING_XM_UA(0.00)[];
	ASN(0.00)[asn:63949, ipnet:2600:3c04::/32, country:SG];
	RCVD_COUNT_SEVEN(0.00)[7]
X-Rspamd-Action: no action

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGUg
UmVhbHRlayB3aWZpIDYvNyBkZXZpY2VzIHdoaWNoIHN1cHBvcnQgVVNCIDMgYXJlIHdlaXJkOiB3
aGVuIGZpcnN0DQo+IHBsdWdnZWQgaW4sIHRoZXkgcHJldGVuZCB0byBiZSBVU0IgMi4gVGhlIGRy
aXZlciBuZWVkcyB0byBzZW5kIHNvbWUNCj4gY29tbWFuZHMgdG8gdGhlIGRldmljZSwgd2hpY2gg
bWFrZSBpdCBkaXNhcHBlYXIgYW5kIGNvbWUgYmFjayBhcyBhDQo+IFVTQiAzIGRldmljZS4NCj4g
DQo+IEltcGxlbWVudCB0aGUgcmVxdWlyZWQgY29tbWFuZHMgaW4gcnR3ODkuDQo+IA0KPiBBZGQg
YSBuZXcgZnVuY3Rpb24gcnR3ODlfdXNiX3dyaXRlMzJfcXVpZXQoKSB0byBhdm9pZCB0aGUgd2Fy
bmluZ3MNCj4gd2hlbiB3cml0aW5nIHRvIFJfe0FYLEJFfV9QQURfQ1RSTDIuIEV2ZW4gdGhvdWdo
IHRoZSB3cml0ZSBzdWNjZWVkcywNCj4gdXNiX2NvbnRyb2xfbXNnKCkgcmV0dXJucyAtRVBST1RP
LCBwcm9iYWJseSBiZWNhdXNlIHRoZSBVU0IgZGV2aWNlDQo+IGRpc2FwcGVhcnMgaW1tZWRpYXRl
bHkuIFRoaXMgcmVzdWx0cyBpbiBzb21lIGNvbmZ1c2luZyB3YXJuaW5ncyBpbg0KPiB0aGUga2Vy
bmVsIGxvZy4NCj4gDQo+IFdoZW4gYSBVU0IgMyBkZXZpY2UgaXMgcGx1Z2dlZCBpbnRvIGEgVVNC
IDIgcG9ydCwgcnR3ODkgd2lsbCB0cnkgdG8NCj4gc3dpdGNoIGl0IHRvIFVTQiAzIG1vZGUgb25s
eSBvbmNlLiBUaGUgZGV2aWNlIHdpbGwgZGlzYXBwZWFyIGFuZCBjb21lDQo+IGJhY2sgc3RpbGwg
aW4gVVNCIDIgbW9kZSwgb2YgY291cnNlLg0KDQpBcyB3ZSBhbHdheXMgdHJ5IHRvIHN3aXRjaCBV
U0IgMywgaXMgaXQgbmVlZGVkIHRvIGFkZCBhIGhpbnQgdG8gdXNlcnMNCnRvIHBsdWcgVVNCIDIg
cG9ydCBpZiBoZSBoYXMgYSBiYWQgcGVyZm9ybWFuY2Ugb24gMkdIeiBiYW5kPw0KDQo+IA0KPiBU
ZXN0ZWQgd2l0aCBSVEw4ODMyQVUsIFJUTDg4MzJCVSwgUlRMODgzMkNVLCBhbmQgUlRMODkxMkFV
Lg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBn
bWFpbC5jb20+DQoNClNvbWUgbWlub3Igc3VnZ2VzdGlvbnMuIE90aGVyd2lzZSwgDQoNCkFja2Vk
LWJ5OiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNvbT4NCg0KWy4uLl0NCg0KPiBkaWZm
IC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS91c2IuYyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvdXNiLmMNCj4gaW5kZXggYzZkNTVlNjY5Nzc2
Li5iZmUwMDRhNDljY2MgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0
ZWsvcnR3ODkvdXNiLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4
OS91c2IuYw0KPiBAQCAtMTIsNyArMTIsNyBAQA0KPiAgc3RhdGljIHZvaWQgcnR3ODlfdXNiX3Jl
YWRfcG9ydF9jb21wbGV0ZShzdHJ1Y3QgdXJiICp1cmIpOw0KPiANCj4gIHN0YXRpYyB2b2lkIHJ0
dzg5X3VzYl92ZW5kb3JyZXEoc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LCB1MzIgYWRkciwNCj4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB2b2lkICpkYXRhLCB1MTYgbGVuLCB1OCBy
ZXF0eXBlKQ0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHZvaWQgKmRhdGEsIHUx
NiBsZW4sIHU4IHJlcXR5cGUsIGJvb2wgd2FybikNCj4gIHsNCj4gICAgICAgICBzdHJ1Y3QgcnR3
ODlfdXNiICpydHd1c2IgPSBydHc4OV91c2JfcHJpdihydHdkZXYpOw0KPiAgICAgICAgIHN0cnVj
dCB1c2JfZGV2aWNlICp1ZGV2ID0gcnR3dXNiLT51ZGV2Ow0KPiBAQCAtNTIsNyArNTIsNyBAQCBz
dGF0aWMgdm9pZCBydHc4OV91c2JfdmVuZG9ycmVxKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2Rldiwg
dTMyIGFkZHIsDQo+IA0KPiAgICAgICAgICAgICAgICAgaWYgKHJldCA9PSAtRVNIVVRET1dOIHx8
IHJldCA9PSAtRU5PREVWKQ0KPiAgICAgICAgICAgICAgICAgICAgICAgICBzZXRfYml0KFJUVzg5
X0ZMQUdfVU5QTFVHR0VELCBydHdkZXYtPmZsYWdzKTsNCj4gLSAgICAgICAgICAgICAgIGVsc2Ug
aWYgKHJldCA8IDApDQo+ICsgICAgICAgICAgICAgICBlbHNlIGlmIChyZXQgPCAwICYmIHdhcm4p
DQo+ICAgICAgICAgICAgICAgICAgICAgICAgIHJ0dzg5X3dhcm4ocnR3ZGV2LA0KPiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICJ1c2IgJXMldSAweCV4IGZhaWwgcmV0PSVkIHZh
bHVlPTB4JXggYXR0ZW1wdD0lZFxuIiwNCj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBzdHJfcmVhZF93cml0ZShyZXF0eXBlID09IFJUVzg5X1VTQl9WRU5RVF9SRUFEKSwNCj4g
QEAgLTgwLDcgKzgwLDcgQEAgc3RhdGljIHUzMiBydHc4OV91c2JfcmVhZF9jbWFjKHN0cnVjdCBy
dHc4OV9kZXYgKnJ0d2RldiwgdTMyIGFkZHIpDQo+IA0KPiAgICAgICAgIGZvciAoY291bnQgPSAw
OyA7IGNvdW50KyspIHsNCj4gICAgICAgICAgICAgICAgIHJ0dzg5X3VzYl92ZW5kb3JyZXEocnR3
ZGV2LCBhZGRyMzIsICZkYXRhLCA0LA0KPiAtICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBSVFc4OV9VU0JfVkVOUVRfUkVBRCk7DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgIFJUVzg5X1VTQl9WRU5RVF9SRUFELCB0cnVlKTsNCg0KTm90IHN1cmUgaWYgeW91
IGxpa2UgdG8gaW1wbGVtZW50IGEgX19ydHc4OV91c2JfdmVuZG9ycmVxKCksIGFuZCANCnByZXNl
cnZlIHJ0dzg5X3VzYl92ZW5kb3JyZXEoKSBhcyBhIHdyYXBwZXIgd2l0aCBvcmlnaW5hbCBwcm90
b3R5cGUuDQpUaGVuLCBubyBuZWVkIHRvIHN0aXIgaGVyZS4gDQoNCkkgbWVhbjoNCg0KX19ydHc4
OV91c2JfdmVuZG9ycmVxKC4uLiwgYm9vbCB3YXJuKTsNCg0Kc3RhdGljIHZvaWQgcnR3ODlfdXNi
X3ZlbmRvcnJlcShzdHJ1Y3QgcnR3ODlfZGV2ICpydHdkZXYsIHUzMiBhZGRyLA0KCQkJCXZvaWQg
KmRhdGEsIHUxNiBsZW4sIHU4IHJlcXR5cGUpDQp7DQoJX19ydHc4OV91c2JfdmVuZG9ycmVxKHJ0
d2RldiwgYWRkciwgZGF0YSwgbGVuLCByZXF0eXBlLCB0cnVlKTsNCn0NCg0KKGp1c3QgYSBzb2Z0
IHN1Z2dlc3Rpb24pDQoNCj4gDQo+ICAgICAgICAgICAgICAgICB2YWwzMiA9IGxlMzJfdG9fY3B1
KGRhdGEpOw0KPiAgICAgICAgICAgICAgICAgaWYgKHZhbDMyICE9IFJUVzg5X1IzMl9ERUFEKQ0K
DQpbLi4uXQ0KDQo=

