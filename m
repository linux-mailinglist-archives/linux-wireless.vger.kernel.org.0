Return-Path: <linux-wireless+bounces-26466-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CAF95B2D0AC
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 02:26:56 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5A89E1895363
	for <lists+linux-wireless@lfdr.de>; Wed, 20 Aug 2025 00:27:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5061F35337B;
	Wed, 20 Aug 2025 00:26:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="gU8C8olQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E11353372
	for <linux-wireless@vger.kernel.org>; Wed, 20 Aug 2025 00:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755649613; cv=none; b=ZRB/YTq31kt1YIGNbftPNWlXkszwfiYYUJXLeYPt27EJKHpq9fvTqcO3AjcnjlBFpRbUPmXkaZbyeyFzFq11aWpslycg4bk/SAqR1CEXC0TLz+36PBkZcWLoEoB2YQifh/xkuh9zFeG5nKvcxvtpUD2laPX4oQ+IDF62ekGkuXM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755649613; c=relaxed/simple;
	bh=xq4xoCPolxoj4HP9Jo5B5dl476eXo0gTQTquCg8jDNg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=YBBVakmUveJlHwvuyVV1SYVHy3PlcXNnuXuSfsgciJaqnAn2VBDJThiR+CIb6TkWMfVeFsdYwKPMNvP8cenoR0yb60FnnYCCkrvLMNjMelND6YgH9+Z1aFHD8Yk0qCVpjXKGXVkOI5a8rzcbodsFjeFqyIMuZkNpMWhq/hp3F+I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=gU8C8olQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 57K0QjBsA3614059, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1755649605; bh=xq4xoCPolxoj4HP9Jo5B5dl476eXo0gTQTquCg8jDNg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=gU8C8olQn5+tOP13fl1yCy4bbag7fSxwWXOnxXi0yFNR8RvG/y19OcPGW7hVor7ek
	 OTzX9C/SfZuOgtz1ogXgzQFLbYig30+NrKiYPkKL9AGeDpzvf/9PBeeUhu8rgU1yF0
	 Ct9ZCFSmt0SoOK1PGTG0Der+WaX7zh95Rx31SQdndbigBlHL62P6pXsyNIZ3A2Nfom
	 vJV4nLc/iQRhjYueGVKUKkeML+/d2ZtEOkwwrOksK1zqcvtUQELzLWxgTwV85nntHq
	 zKdgynlztNHPibjt2Y0yYiWCKaVN+ms77zP92PGUvlRSxMOzocHqW120CiROtv5E4/
	 N+T2aRW58PAXQ==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 57K0QjBsA3614059
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 20 Aug 2025 08:26:45 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Wed, 20 Aug 2025 08:26:45 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc%10]) with mapi id
 15.02.1544.011; Wed, 20 Aug 2025 08:26:45 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next] wifi: rtw88: Use led->brightness_set_blocking for PCI too
Thread-Topic: [PATCH rtw-next] wifi: rtw88: Use led->brightness_set_blocking
 for PCI too
Thread-Index: AQHcETmIv+aZT9I26ke2y0xZfWH+qLRqrHEA
Date: Wed, 20 Aug 2025 00:26:45 +0000
Message-ID: <aba7583da5fc48bca933d4b5d2fae6aa@realtek.com>
References: <ad8a49ef-4f2d-4a61-8292-952db9c4eb65@gmail.com>
In-Reply-To: <ad8a49ef-4f2d-4a61-8292-952db9c4eb65@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBDb21t
aXQgMjZhOGJmOTc4YWU5ICgid2lmaTogcnR3ODg6IExvY2sgcnR3ZGV2LT5tdXRleCBiZWZvcmUg
c2V0dGluZw0KPiB0aGUgTEVEIikgbWFkZSBydHdfbGVkX3NldCgpIHNsZWVwLCBidXQgdGhhdCdz
IG5vdCBhbGxvd2VkLiBGaXggaXQgYnkNCj4gdXNpbmcgdGhlIGJyaWdodG5lc3Nfc2V0X2Jsb2Nr
aW5nIG1lbWJlciBvZiBzdHJ1Y3QgbGVkX2NsYXNzZGV2IGZvcg0KPiBQQ0kgZGV2aWNlcyB0b28u
IFRoaXMgb25lIGlzIGFsbG93ZWQgdG8gc2xlZXAuDQo+IA0KPiBiYWQ6IHNjaGVkdWxpbmcgZnJv
bSB0aGUgaWRsZSB0aHJlYWQhDQo+IG5peCBrZXJuZWw6IENQVTogNyBVSUQ6IDAgUElEOiAwIENv
bW06IHN3YXBwZXIvNyBUYWludGVkOiBHICAgICAgICBXICBPICAgICAgICA2LjE2LjAgIzEtTml4
T1MNCj4gUFJFRU1QVCh2b2x1bnRhcnkpDQo+IG5peCBrZXJuZWw6IFRhaW50ZWQ6IFtXXT1XQVJO
LCBbT109T09UX01PRFVMRQ0KPiBuaXgga2VybmVsOiBIYXJkd2FyZSBuYW1lOiBbUkVEQUNURURd
DQo+IG5peCBrZXJuZWw6IENhbGwgVHJhY2U6DQo+IG5peCBrZXJuZWw6ICA8SVJRPg0KPiBuaXgg
a2VybmVsOiAgZHVtcF9zdGFja19sdmwrMHg2My8weDkwDQo+IG5peCBrZXJuZWw6ICBkZXF1ZXVl
X3Rhc2tfaWRsZSsweDJkLzB4NTANCj4gbml4IGtlcm5lbDogIF9fc2NoZWR1bGUrMHgxOTEvMHgx
MzEwDQo+IG5peCBrZXJuZWw6ICA/IHhhc19sb2FkKzB4MTEvMHhkMA0KPiBuaXgga2VybmVsOiAg
c2NoZWR1bGUrMHgyYi8weGUwDQo+IG5peCBrZXJuZWw6ICBzY2hlZHVsZV9wcmVlbXB0X2Rpc2Fi
bGVkKzB4MTkvMHgzMA0KPiBuaXgga2VybmVsOiAgX19tdXRleF9sb2NrLmNvbnN0cHJvcC4wKzB4
M2ZkLzB4N2QwDQo+IG5peCBrZXJuZWw6ICBydHdfbGVkX3NldCsweDI3LzB4NjAgW3J0d19jb3Jl
XQ0KPiBuaXgga2VybmVsOiAgbGVkX2JsaW5rX3NldF9ub3NsZWVwKzB4NTYvMHhiMA0KPiBuaXgg
a2VybmVsOiAgbGVkX3RyaWdnZXJfYmxpbmsrMHg0OS8weDgwDQo+IG5peCBrZXJuZWw6ICA/IF9f
cGZ4X3RwdF90cmlnX3RpbWVyKzB4MTAvMHgxMCBbbWFjODAyMTFdDQo+IG5peCBrZXJuZWw6ICBj
YWxsX3RpbWVyX2ZuKzB4MmYvMHgxNDANCj4gbml4IGtlcm5lbDogID8gX19wZnhfdHB0X3RyaWdf
dGltZXIrMHgxMC8weDEwIFttYWM4MDIxMV0NCj4gbml4IGtlcm5lbDogIF9fcnVuX3RpbWVycysw
eDIxYS8weDJiMA0KPiBuaXgga2VybmVsOiAgcnVuX3RpbWVyX3NvZnRpcnErMHg4ZS8weDEwMA0K
PiBuaXgga2VybmVsOiAgaGFuZGxlX3NvZnRpcnFzKzB4ZWEvMHgyYzANCj4gbml4IGtlcm5lbDog
ID8gc3Jzb19hbGlhc19yZXR1cm5fdGh1bmsrMHg1LzB4ZmJlZjUNCj4gbml4IGtlcm5lbDogIF9f
aXJxX2V4aXRfcmN1KzB4ZGMvMHgxMDANCj4gbml4IGtlcm5lbDogIHN5c3ZlY19hcGljX3RpbWVy
X2ludGVycnVwdCsweDdjLzB4OTANCj4gbml4IGtlcm5lbDogIDwvSVJRPg0KPiBuaXgga2VybmVs
OiAgPFRBU0s+DQo+IG5peCBrZXJuZWw6ICBhc21fc3lzdmVjX2FwaWNfdGltZXJfaW50ZXJydXB0
KzB4MWEvMHgyMA0KPiBuaXgga2VybmVsOiBSSVA6IDAwMTA6Y3B1aWRsZV9lbnRlcl9zdGF0ZSsw
eGNjLzB4NDUwDQo+IG5peCBrZXJuZWw6IENvZGU6IDAwIGU4IDA4IDdjIDJlIGZmIGU4IGQzIGVl
IGZmIGZmIDQ5IDg5IGM2IDBmIDFmIDQ0IDAwIDAwIDMxIGZmIGU4IGM0IGQxIDJjIGZmIDgwIDdk
IGQ3DQo+IDAwIDBmIDg1IDVkIDAyIDAwIDAwIGZiIDBmIDFmIDQ0IDAwIDAwIDw0NT4gODUgZmYg
MGYgODggYTAgMDEgMDAgMDAgNDkgNjMgZjcgNGMgODkgZjIgNDggOGQgMD4NCj4gbml4IGtlcm5l
bDogUlNQOiAwMDE4OmZmZmZkNTc5ODAxYzdlNjggRUZMQUdTOiAwMDAwMDI0Ng0KPiBuaXgga2Vy
bmVsOiBSQVg6IDAwMDAwMDAwMDAwMDAwMDAgUkJYOiAwMDAwMDAwMDAwMDAwMDAzIFJDWDogMDAw
MDAwMDAwMDAwMDAwMA0KPiBuaXgga2VybmVsOiBSRFg6IDAwMDAwMDAwMDAwMDAwMDAgUlNJOiAw
MDAwMDAwMDAwMDAwMDAwIFJESTogMDAwMDAwMDAwMDAwMDAwMA0KPiBuaXgga2VybmVsOiBSQlA6
IGZmZmZkNTc5ODAxYzdlYTAgUjA4OiAwMDAwMDAwMDAwMDAwMDAwIFIwOTogMDAwMDAwMDAwMDAw
MDAwMA0KPiBuaXgga2VybmVsOiBSMTA6IDAwMDAwMDAwMDAwMDAwMDAgUjExOiAwMDAwMDAwMDAw
MDAwMDAwIFIxMjogZmZmZjhlYWIwNDYyYTQwMA0KPiBuaXgga2VybmVsOiBSMTM6IGZmZmZmZmZm
OWE3ZDdhMjAgUjE0OiAwMDAwMDAwM2FlYmU3NTFkIFIxNTogMDAwMDAwMDAwMDAwMDAwMw0KPiBu
aXgga2VybmVsOiAgPyBjcHVpZGxlX2VudGVyX3N0YXRlKzB4YmMvMHg0NTANCj4gbml4IGtlcm5l
bDogIGNwdWlkbGVfZW50ZXIrMHgzMi8weDUwDQo+IG5peCBrZXJuZWw6ICBkb19pZGxlKzB4MWIx
LzB4MjEwDQo+IG5peCBrZXJuZWw6ICBjcHVfc3RhcnR1cF9lbnRyeSsweDJkLzB4MzANCj4gbml4
IGtlcm5lbDogIHN0YXJ0X3NlY29uZGFyeSsweDExOC8weDE0MA0KPiBuaXgga2VybmVsOiAgY29t
bW9uX3N0YXJ0dXBfNjQrMHgxM2UvMHgxNDENCj4gbml4IGtlcm5lbDogIDwvVEFTSz4NCj4gDQo+
IEZpeGVzOiAyNmE4YmY5NzhhZTkgKCJ3aWZpOiBydHc4ODogTG9jayBydHdkZXYtPm11dGV4IGJl
Zm9yZSBzZXR0aW5nIHRoZSBMRUQiKQ0KDQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KDQo+
IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29t
Pg0KDQpBY2tlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+DQoNCj4gLS0t
DQo+IEknbSBub3Qgc3VyZSBpZiB0aGUgY29tbWl0IGhhc2ggd2lsbCBiZSBjb3JyZWN0IGJ5IHRo
ZSB0aW1lIHRoYXQNCj4gY29tbWl0IG1ha2VzIGl0IGludG8gbWFpbmxpbmU/DQoNCldlIGFsd2F5
cyBnbyB2aWEgd2lyZWxlc3MgLyB3aXJlbGVzcy1uZXh0IHRyZWUsIHNvIHRoZSBjb21taXQgbXVz
dCBiZSB0aGVyZQ0KYWxyZWFkeS4gT25seSBxdWVzdGlvbiBpcyB0aGF0IHlvdSB3YW50IDYuMTcg
KGN1cnJlbnRseSAtcmMyKSBvciA2LjE4IChuZXh0KT8NCkkgdGhpbmsgdGhpcyBzaG91bGQgYmUg
Ni4xNywgc28gdHJlZSBzZWxlY3Rpb24gb2Ygc3ViamVjdCB0YWcgc2hvdWxkIGJlDQoicnR3IiBp
bnN0ZWFkIG9mICJydHctbmV4dCIuIA0KDQoNCg==

