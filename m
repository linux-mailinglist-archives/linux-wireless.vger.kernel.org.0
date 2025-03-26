Return-Path: <linux-wireless+bounces-20824-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A2256A70E8F
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 02:45:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 33E0E16B7F5
	for <lists+linux-wireless@lfdr.de>; Wed, 26 Mar 2025 01:45:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9554A56B81;
	Wed, 26 Mar 2025 01:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="WxRA5DAp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1665A323D
	for <linux-wireless@vger.kernel.org>; Wed, 26 Mar 2025 01:44:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742953495; cv=none; b=HwkpykFEP+XB0jCiDk218KfLvgUFcYKiIzw8kkNKvnmXJqdr6GQZBP/QVmGCoT+RJ5LTcpuw8LZBdX7Nhu7YFWzOZ7rVv3XhSi9YFqnBqtc5DFlRvHQxg0a4eMaJ0jUv1cukxuQgSifQa8OwKR77YRruiFJGH/YDSsrKawBr3UY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742953495; c=relaxed/simple;
	bh=sf1sv4pz4XiAySeHvYC2OWEqfvAQoDCTG2ljzYtp48k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=lQTYxLIliK8oM5Q1Tgt31KfGSv4fQb68aoJVPpE3ukDgMYz+2mG0+UeaSeWh9F1chVo88hC+4veF6fi6ij6SdmKOtVFPKdbpWnGblF2yTIZWxQ7i7Mz6wFElBd2gAhyVB/lLm1efK3ky3rynMBZ2ZsWIwC8VGf6fBHY0dog5nqg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=WxRA5DAp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52Q1ilHpB1360233, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742953487; bh=sf1sv4pz4XiAySeHvYC2OWEqfvAQoDCTG2ljzYtp48k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=WxRA5DApBdECa4w5pWc37k3AOlAXwbs++gkNOu1b5SaLDbDmiTmIPY76G7dXmLjBe
	 +lz+ofUI4Ck7Z0AI4J4aCBb5A/YfxEUsuPfY4rIG0IesKTYlrY+6QkIFlAY6v0CyR6
	 S7YuVDXa5rkjsxZtk3BalJojvzNc2fsGFW7gjdu9qqr3MBbXfYoSVWYUp8zOka9+LK
	 k/iwmp7L0hdp0ioYVygviyCuWi2ph6tAtDUluEa1RtvZBCHK/A8Fk88X15LhERrswE
	 mPHzEGOF1cLDv7aP8k/yRhvPPbFfGxJrY/26R5XOOksFS+KGm8ogw3nHd5sbmVBAJ8
	 go86dYXG5/jow==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52Q1ilHpB1360233
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 26 Mar 2025 09:44:47 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Wed, 26 Mar 2025 09:44:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Wed, 26 Mar 2025 09:44:48 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Wed, 26 Mar 2025 09:44:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: rtw88: RTL8812BU TX FIFO corruption (?) in USB 3 mode
Thread-Topic: rtw88: RTL8812BU TX FIFO corruption (?) in USB 3 mode
Thread-Index: AQHbmp3Tvo7LWSk4Bk2+2P9d012B2LOEqqCg
Date: Wed, 26 Mar 2025 01:44:48 +0000
Message-ID: <91456392399d4bb5b7b96cbe35a6b17c@realtek.com>
References: <b69f6496-dc12-4662-84ac-aa62d0ceac3f@gmail.com>
In-Reply-To: <b69f6496-dc12-4662-84ac-aa62d0ceac3f@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBIaSwN
Cj4gDQo+IEkgcmFuIGludG8gYSBwcm9ibGVtIHdpdGggdGhlIFJUTDg4MTJCVS4gSWYgSSBsb2Fk
IGl0IGEgYml0IGluIFVTQiAzDQo+IG1vZGUsIGxpa2Ugd2l0aCAiaXBlcmYzIC1jIDE5Mi4xNjgu
MC4xIC1SIC10IDYwIiB0aGUgY29ubmVjdGlvbiBvZnRlbg0KPiBzdG9wcyB3b3JraW5nLiBJdCBt
YXkgdGFrZSBhIGZldyB0cmllcy4gSXQgc3RpbGwgcmVjZWl2ZXMgYmVhY29ucyBidXQNCj4gdGhl
IEFQIGNhbid0IGJlIHBpbmdlZCBhbnltb3JlLg0KPiANCj4gTG9va2luZyBhdCB0aGUgcmVnaXN0
ZXJzIHdpdGgNCj4gIndhdGNoIGNhdCAvc3lzL2tlcm5lbC9kZWJ1Zy9pZWVlODAyMTEvcGh5Ki9y
dHc4OC9tYWNfMiIsIEkgbm90aWNlZA0KPiB0aGUgaGlnaCBoYWxmIG9mIHJlZ2lzdGVyIDB4MjQw
IHdhcyBzdGVhZGlseSBpbmNyZWFzaW5nLg0KPiANCj4gUmVnaXN0ZXIgMHgyNDAgaXMgY2FsbGVk
IFJFR19GSUZPUEFHRV9JTkZPXzUuIFRoZSBkcml2ZXIgd3JpdGVzIHRoZQ0KPiBudW1iZXIgb2Yg
cGFnZXMgYWxsb2NhdGVkIHRvIHRoZSBwdWJsaWMgcXVldWUgaW50byB0aGUgbG93IGhhbGYuDQo+
IFRoZSBoaWdoIGhhbGYgaW5kaWNhdGVzIHRoZSBudW1iZXIgb2YgcGFnZXMgY3VycmVudGx5IGF2
YWlsYWJsZS4NCj4gVGhlIG51bWJlciBvZiBhdmFpbGFibGUgcGFnZXMgd2FzIHN0ZWFkaWx5IGlu
Y3JlYXNpbmcsIGJleW9uZCB0aGUNCj4gdG90YWwgbnVtYmVyIG9mIHBhZ2VzOg0KPiANCj4gMDAw
MDAyNDAgIDA3MmIwNzBiICAgIDAwMDNmYTAwICAgIDAwMDNmZTAwICAgIDAwMDNmYTYwDQo+IDAw
MDAwMjQwICAwNzM3MDcwYiAgICAwMDAzZmEwMCAgICAwMDAzZmUwMCAgICAwMDAzZmE2MA0KPiAw
MDAwMDI0MCAgMDczYjA3MGIgICAgMDAwM2ZhMDAgICAgMDAwM2ZlMDAgICAgMDAwM2ZhNjANCj4g
MDAwMDAyNDAgIDA3NDEwNzBiICAgIDAwMDNmYTAwICAgIDAwMDNmZTAwICAgIDAwMDNmYTYwDQo+
IDAwMDAwMjQwICAwNzQxMDcwYiAgICAwMDAzZmEwMCAgICAwMDAzZmUwMCAgICAwMDAzZmE2MA0K
PiAwMDAwMDI0MCAgMDc0ZjA3MGIgICAgMDAwM2ZhMDAgICAgMDAwM2ZlMDAgICAgMDAwM2ZhNjAN
Cj4gMDAwMDAyNDAgIDA3NWQwNzBiICAgIDAwMDNmYTAwICAgIDAwMDNmZTAwICAgIDAwMDNmYTYw
DQo+IA0KPiBOb3JtYWwgdmFsdWVzIHdoZW4gdGhlIGRldmljZSBpcyBmdW5jdGlvbmFsIChhbmQg
aWRsZSk6DQo+IA0KPiAwMDAwMDI0MCAgMDcwYjA3MGIgICAgMDAwM2ZhMDAgICAgMDAwM2ZlMDAg
ICAgMDAwM2ZhNjANCj4gDQo+IFdoZW4gcmVnaXN0ZXIgMHgyNDAgaGFzIHN0cmFuZ2UgdmFsdWVz
LCByZWdpc3RlciAweDIxMA0KPiAoUkVHX1RYRE1BX1NUQVRVUykgaGFzIHRoZSB2YWx1ZSA1LiBO
b3JtYWxseSByZWdpc3RlciAweDIxMCBpcyAwLg0KPiANCj4gQWxsIHRoaXMgb25seSBoYXBwZW5z
IGluIFVTQiAzIG1vZGUuIEV2ZXJ5dGhpbmcgaXMgZmluZSBpbiBVU0IgMiBtb2RlLg0KDQpJIGNo
ZWNrZWQgd2l0aCBpbnRlcm5hbCBVU0IgdGVhbS4gVGhlIFVTQiAzIG1vZGUgY2FuIG9ubHkgd29y
ayBvbiA1R0h6LA0KYmVjYXVzZSBlbGVjdHJpY2FsIGludGVyZmVyZW5jZSBiZXR3ZWVuIFVTQiAz
IGNsb2NrIGFuZCBXaUZpIDIuNCBHSHoNCmJhbmQuIENvdWxkIHlvdSBjaGVjayBpZiBpdCB3b3Jr
cyBvbiA1R0h6Pw0KDQo+IA0KPiBJIHRyaWVkIHRvIGRpc2FibGUgVVNCIFJYIGFuZCBUWCBhZ2dy
ZWdhdGlvbiwgU1VQUE9SVFNfQU1TRFVfSU5fQU1QRFUsDQo+IGFuZCBUWF9BTVNEVS4gTm9uZSBv
ZiB0aGF0IGhlbHBlZC4NCj4gDQo+IFRoaXMgcHJvYmxlbSBoYXBwZW5zIGFsc28gd2l0aCB0aGlz
IGRyaXZlcjoNCj4gaHR0cHM6Ly9naXRodWIuY29tL21vcnJvd25yLzg4eDJidS0yMDIxMDcwMg0K
PiBhbmQgd2l0aCB2NS4xMy4xLjEtMS1nNmYyNTQxZWYyLjIwMjQwNTA3X0NPRVgyMDIyMDgxMi0x
ODMxN2I3Yi4NCg0KQnkgZGVmYXVsdCwgaXQgb25seSBzdXBwb3J0cyBVU0IgMiBtb2RlLiBIYXZl
IHlvdSBjaGFuZ2VkIHRoZSBkcml2ZXI/DQoNCj4gSSBzZWUNCj4gdGhlIHNhbWUgc3RyYW5nZSB2
YWx1ZXMgaW4gcmVnaXN0ZXIgMHgyNDAgaW4NCj4gL3Byb2MvbmV0L3J0bDg4eDJidS93bHAzczBm
M3U0L21hY19yZWdfZHVtcC4NCj4gDQo+IE15IHRlc3QgZGV2aWNlIGlzIFRQLUxpbmsgQXJjaGVy
IFQzVSBQbHVzLCB3aXRoIFVTQiBJRCAyMzU3OjAxMzguDQo+IE15IHN5c3RlbSBpcyBMZW5vdm8g
SWRlYXBhZCAzIDE1QURBNiB3aXRoIEFNRCBBdGhsb24gR29sZCAzMTUwVSBDUFUuDQo+IA0KPiBD
YW4gdGhpcyBiZSBmaXhlZCBzb21laG93PyBJIHNhdyB0aGUgb3RoZXIgZHJpdmVycyBoYXZlIHNv
bWUgY29kZSBpbg0KPiBydHdfc3Jlc2V0LmMgdG8gcG93ZXIgb2ZmIGFuZCBvbiB0aGUgZGV2aWNl
IHdoZW4gcmVnaXN0ZXIgMHgyMTAgaXMNCj4gbm9uLXplcm8sIGJ1dCB0aGF0IHNlZW1zIHN1Ym9w
dGltYWwuDQo=

