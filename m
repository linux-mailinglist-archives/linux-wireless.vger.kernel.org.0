Return-Path: <linux-wireless+bounces-20584-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3264DA69D57
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 01:39:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5F07218963D5
	for <lists+linux-wireless@lfdr.de>; Thu, 20 Mar 2025 00:39:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E57601624C0;
	Thu, 20 Mar 2025 00:39:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="qYNORbNO"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17879154457
	for <linux-wireless@vger.kernel.org>; Thu, 20 Mar 2025 00:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742431142; cv=none; b=ea8oUCfQ+wUSHlbgyvEAa5j8CWnqPQMbD+mr/pIfCRZDmyxIRq5faBFOISdmmIu9+CCyMNQdDmy+gFMnWAnEmc7DRmjA55WxzydxZdDiakExJt3TXaQfxtlPTDY3gOtQveR1GSWNYSXHHPgeOERlCFCbzy5pAl72IlmUHyXhbPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742431142; c=relaxed/simple;
	bh=N7A1qQccx0x5bF0HWLpVMOzR9ftvag3P4cers/RIpMA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=I1tvYqADK0m/KSbPw0BqR4THN0YOEAJnbqJRXVNDgqhgd3dpSm/w9Ue8Jey6Uxu5ZbV2UjGjnA52RYUB4wpBsGG8iRsh2si+HlzQHB0aAr8NYe93zpRc/X4ocQuD8LCWtsfRWycYrBv/JCD/sUYI89fTpABYJh5hGS26upTED6Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=qYNORbNO; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52K0ctjlF1507029, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742431135; bh=N7A1qQccx0x5bF0HWLpVMOzR9ftvag3P4cers/RIpMA=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=qYNORbNOTVnsiy/vYvRmYdN3ow1uHvwIrlpTSMDSUCkKFK09ZtVGTEYEj8rX7/JYM
	 tAnTzgvBX/sdLIXa+1QBYeW1Jj3frVy4tJfqOsfor4bThqV4hYi3UeXUQKvFn+ay22
	 83rPkfgA8Vhp9ZuFD2kvPsnJswxubrEiYSYiPX9XQWyBDIJqzEFeYCLMq9dR2wOQS4
	 XkE1jSjY/0iOek4J+A/jbnAxB+8ZJdCpf7xYjRaNC5ouZTDx16qpQWQ2ziBwjvk4Dv
	 cEeNgvo5cClB/QHiq2uInz+kFIICsR3RDjrJTQ8HC+CfyoYkQhAKnkK8QplyPng6ne
	 csnCVCBT1ADtA==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52K0ctjlF1507029
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 20 Mar 2025 08:38:55 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 20 Mar 2025 08:38:55 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 20 Mar 2025 08:38:55 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Thu, 20 Mar 2025 08:38:55 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 3/4] wifi: rtw88: Set AMPDU factor to hardware
Thread-Topic: [PATCH rtw-next 3/4] wifi: rtw88: Set AMPDU factor to hardware
Thread-Index: AQHblFUnF3FHtd8BUESRxvtJE6hCX7N2ps5ggAAqRgCAAVhLgIAAknmAgADkWLCAAOZegIAArwiw
Date: Thu, 20 Mar 2025 00:38:55 +0000
Message-ID: <38f4ebc6a4864686a9f1b8dc8c30aaef@realtek.com>
References: <c845ff10-08d9-4057-8f54-1579a548788d@gmail.com>
 <289795d5-49ae-4789-8f14-b2d016843a53@gmail.com>
 <b972a60bb0b04b5f817047027970d896@realtek.com>
 <0ac48cfe-dc7a-442f-b893-41416cd3017d@gmail.com>
 <095328518444426887e039202fa8c609@realtek.com>
 <aa278922-5fac-4f47-acc2-25cc2c133365@gmail.com>
 <95da11e5ec6f43babaedc6dfc25c3cbf@realtek.com>
 <b76818b3-e711-4721-a902-99c557e00a73@gmail.com>
In-Reply-To: <b76818b3-e711-4721-a902-99c557e00a73@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAx
OS8wMy8yMDI1IDAyOjI4LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBPbiAxOC8wMy8yMDI1IDA0
OjA2LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4+PiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIx
Y2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4+Pj4gT24gMTcvMDMvMjAyNSAwNTowMSwgUGlu
Zy1LZSBTaGloIHdyb3RlOg0KPiA+Pj4+PiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUy
QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gVGVsbCB0aGUgY2hpcCB0aGUg
bWF4aW11bSBBTVBEVSBzaXplIHN1cHBvcnRlZCBieSB0aGUgQVAuIFRoaXMgZ3JlYXRseQ0KPiA+
Pj4+Pj4gaW1wcm92ZXMgdGhlIFRYIHNwZWVkIG9mIFJUTDg4MTRBVSBpbiB0aGUgMi40IEdIeiBi
YW5kLiBCZWZvcmU6IH45MA0KPiA+Pj4+Pj4gTWJwcy4gQWZ0ZXI6IH4zMDAgTWJwcy4NCj4gPj4+
Pj4+DQo+ID4+Pj4+PiBBZGQgdGhpcyBjb25maWd1cmF0aW9uIGZvciBhbGwgdGhlIGNoaXBzLCBl
dmVuIGlmIGl0IG9ubHkgaGFzIGFuIGVmZmVjdA0KPiA+Pj4+Pj4gb24gUlRMODgxNEFVIGluIG15
IHRlc3RzLiBTdXJlbHkgdGhleSBhbGwgbmVlZCB0aGlzLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBUaGUg
aGFyZHdhcmUgZGVmYXVsdCB2YWx1ZSBvZiBSRUdfQU1QRFVfTUFYX0xFTkdUSCBpcyAweGZmZmYg
KHVubGltaXRlZCkNCj4gPj4+Pj4gZm9yIG1vc3QgY2hpcHMuIEl0IHNlZW1zIGxpa2UgUlRMODgx
MkEvUlRMODgyMUEgYXJlIGFsc28gZXhjZXB0aW9ucywgc28NCj4gPj4+Pj4gYXQgcG93ZXIgb24g
ZnVuY3Rpb24gdGhleSBkbw0KPiA+Pj4+PiAgICAgcnR3X3dyaXRlMzIocnR3ZGV2LCBSRUdfQU1Q
RFVfTUFYX0xFTkdUSCwgMHhmZmZmZmZmZik7DQo+ID4+Pj4+DQo+ID4+Pj4+IEkgZmVlbCBSVEw4
ODE0QSBoYXMgc2ltaWxhciBzZXR0aW5nLCBzbyBtYXliZSB5b3UgY2FuIGp1c3QgYWRkIHNpbWls
YXINCj4gPj4+Pj4gc3R1ZmYuDQo+ID4+Pj4+DQo+ID4+Pj4+IEJ5IHRoZSB3YXksIHRoZSBBTVBE
VSBpcyBjb250cm9sbGVkIGJ5IFRYIGRlc2NyaXB0b3IgYmFzaWNhbGx5Og0KPiA+Pj4+PiAgICAg
ICBwa3RfaW5mby0+YW1wZHVfZmFjdG9yID0gYW1wZHVfZmFjdG9yOw0KPiA+Pj4+PiAgICAgICBw
a3RfaW5mby0+YW1wZHVfZGVuc2l0eSA9IGFtcGR1X2RlbnNpdHk7DQo+ID4+Pj4+ICAgICAgIHBr
dF9pbmZvLT5hbXBkdV9lbiA9IGFtcGR1X2VuOw0KPiA+Pj4+Pg0KPiA+Pj4+PiBTaW5jZSB5b3Ug
ZGlkbid0IGNoYW5nZSB0aGlzIHBhcnQgYXQgYWxsLCBJIHN0aWxsIGZlZWwgc2V0dGluZw0KPiA+
Pj4+PiBSRUdfQU1QRFVfTUFYX0xFTkdUSCB0byAweGZmZmZmZmZmIGNhbiBmaXggbG93IHRocm91
Z2hwdXQgcHJvYmxlbS4NCj4gPj4+Pj4NCj4gPj4+Pg0KPiA+Pj4+IEkgdHJpZWQgMHhmZmZmZmZm
ZiBqdXN0IG5vdyBhbmQgaXQgZG9lc24ndCB3b3JrLiBJdCdzIHRoZSBzYW1lIHdpdGgNCj4gPj4+
PiBib3RoIG9mIG15IHJvdXRlcnMuIFRoZXkgYWR2ZXJ0aXNlIGEgbWF4aW11bSBBTVBEVSBzaXpl
IG9mIDY0IEsuDQo+ID4+Pj4gSSBjYW4ndCBqdXN0IHNldCBpdCB0byAweGZmZmYgZWl0aGVyLCBi
ZWNhdXNlIHRoZW4gdGhlIHVwbG9hZCBzcGVlZA0KPiA+Pj4+IGluIHRoZSA1IEdIeiBiYW5kIHN1
ZmZlcnMgYSBsb3QuIFRoZSBkdWFsIGJhbmQgcm91dGVyIGFkdmVydGlzZXMgYQ0KPiA+Pj4+IG1h
eGltdW0gQU1QRFUgc2l6ZSBvZiAyNTYgSyBpbiB0aGUgNSBHSHogYmFuZCBzbyBpdCBnZXRzIGEg
dmFsdWUgb2YNCj4gPj4+PiAweDNmZmZmLg0KPiA+Pj4NCj4gPj4+IE5vdCBzdXJlIGlmIDB4ZmZm
ZmZmZmYgaXMgYSBzcGVjaWFsIHZhbHVlLiBTaW5jZSB0aGlzIGlzIGEgbGltaXQgb2YNCj4gPj4+
IEFNUERVIGxlbmd0aCwgeW91IGNhbiBzZXQgYSBjb25zdGFudCBsYXJnZSB2YWx1ZSBzdWNoIGFz
IDB4M2ZmZmYgeW91DQo+ID4+PiBoYXZlIHRlc3RlZC4gSXMgdGhlcmUgc3BlY2lhbCBjYXNlIGl0
IGNhbid0IGhhbmRsZT8NCj4gPj4+DQo+ID4+Pg0KPiA+Pg0KPiA+PiAweDNmZmZmIGlzIG5vdCBn
b29kIGZvciB0aGUgMi40IEdIeiBiYW5kLiBUaGUgdXBsb2FkIGlzIG9ubHkgfjkwIE1icHMNCj4g
Pj4gd2l0aCBib3RoIG9mIHRoZSByb3V0ZXJzIEkgdGVzdGVkLiBTYW1lIHdpdGggMHgxZmZmZi4g
T25seSAweGZmZmYNCj4gPj4gd29ya3Mgd2VsbCBmb3IgdGhlbS4NCj4gPg0KPiA+IEhhdmUgeW91
IGNoZWNrZWQgdGhlIHBhY2tldHMgaW4gdGhlIGFpcj8gSG93IGFib3V0IHRoZWlyIGRpZmZlcmVu
Y2U/DQo+ID4gSW50dWl0aXZlbHkgbGFyZ2VyIFJFR19BTVBEVV9NQVhfTEVOR1RIIHdvdWxkIGJl
IGJldHRlci4NCj4gPg0KPiANCj4gSSBjaGVja2VkIHRvZGF5LiBXaXRoIDB4ZmZmZmZmZmYgSSBz
ZWUgMjklIHJldHJhbnNtaXNzaW9uIHJhdGUuIFdpdGgNCj4gMHhmZmZmIHRoZSByZXRyYW5zbWlz
c2lvbiByYXRlIGlzIG9ubHkgOC42JS4NCg0KQ2FuIHlvdSBoZWxwIHRvIGNvbmZpcm0gaWYgcmV0
cmFuc21pc3Npb24gaXMgYmVjYXVzZSBBUCBjYW4ndCByZWNlaXZlIHRoZSBsb25nDQpwYWNrZXRz
PyBJIHN1cHBvc2UgdGhlIEJBIGJpdG1hcCBmcm9tIEFQIGFyZW4ndCBhbGwgb25lJ3MuIA0KDQpM
aWtlIHBhdGNoIDQvNCwgeW91IGRvbid0IGRlY2xhcmUgQU1TRFUgaW4gQU1QRFUgZm9yIFJUTDg4
MTRBLCB0aGF0IGF2b2lkDQpBUCBzZW5kaW5nIGxvbmcgcGFja2V0cy4gSSBmZWVsIHRoZSBQSFkg
cGVyZm9ybWFuY2UgaXNuJ3QgdmVyeSBnb29kLiBTbw0KSSB0aGluayB3ZSBuZWVkIHRvIGFkZCBz
b21lIGNvbW1lbnRzIGluIGNvZGUgdG8gbm90ZSBwZW9wbGUgd2h5IHdlIGFkZA0KdGhlc2UgbGlt
aXRzLiANCg0KPiANCj4gPj4NCj4gPj4gMHhmZmZmIGlzIHRvbyBsaXR0bGUgZm9yIHRoZSA1IEdI
eiBiYW5kLiBUaGUgdXBsb2FkIHNwZWVkIGlzIH4yMDAgTWJwcw0KPiA+PiBsZXNzIHRoYW4gd2l0
aCAweDNmZmZmLg0KPiA+Pg0KPiA+PiBJIGd1ZXNzIGlmIHlvdSByZWFsbHkgZG9uJ3Qgd2FudCB0
aGlzIHBhdGNoIEkgY2FuIGhhcmRjb2RlIDB4ZmZmZiBhbmQNCj4gPj4gMHgzZmZmZiBpbiBydHc4
ODE0YV9zd2l0Y2hfYmFuZCgpLiBJIGp1c3QgZG9uJ3Qga25vdyBpZiBhbGwgYWNjZXNzDQo+ID4+
IHBvaW50cyB3aWxsIGJlIGhhcHB5IHdpdGggdGhhdC4NCj4gPg0KPiA+IEluaXRpYWxseSBJIHdh
bnRlZCB0byBzaW1wbHkgdGhpcyBwYXRjaCwgYmVjYXVzZSBjaGFuZ2luZyBSRUdfQU1QRFVfTUFY
X0xFTkdUSA0KPiA+IGZvciBvdGhlciBjaGlwcyB3aXRob3V0IHRlc3RpbmcgaXMgcmlza3kuIFdp
dGggeW91ciB0ZXN0cywgdGhlIGJlaGF2aW9yIG9mDQo+ID4gUkVHX0FNUERVX01BWF9MRU5HVEgg
d29ya3Mgbm90IGZ1bGx5IGV4cGVjdGVkLCBzbyBJIHN1c3BlY3QgdGhlIHJpc2sNCj4gPiBpcyBl
dmVuIGhpZ2hlci4NCj4gPg0KPiA+IFRoZXJlZm9yZSwgSSB3b3VsZCBsaWtlIGxpbWl0IHRoaXMg
Y2hhbmdlIHRvIFJUTDg4MTRBLiBUaG91Z2ggaGFyZGNvZGUgcHJvcG9zYWwNCj4gPiBpcyBub3Qg
c3VyZSB3b3JrYWJsZSBmb3IgYWxsIEFQLCB3ZSBhbHNvIGRvbid0IGtub3cgdGhpcyBwYXRjaCB3
b3JrcyBmb3IgYWxsDQo+ID4gQVAuIEFueXdheSB0aGlzIHByb3Bvc2FsIGlzIGZpbmUgdG8gbWUg
aWYgd2UgZG9uJ3QgaGF2ZSBvdGhlciBpZGVhcy4NCj4gPg0KPiA+DQo+IEFsbCByaWdodCwgSSB3
aWxsIGxpbWl0IHRoaXMgb25seSB0byBSVEw4ODE0QS4NCg==

