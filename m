Return-Path: <linux-wireless+bounces-20720-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 6F0F1A6D296
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 01:39:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7A5D18920F5
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Mar 2025 00:39:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 592FE8460;
	Mon, 24 Mar 2025 00:39:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Qt8EnsID"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02FE5746E
	for <linux-wireless@vger.kernel.org>; Mon, 24 Mar 2025 00:39:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742776763; cv=none; b=e4rO2E7QD/iSPQ9mdg5hBmZD4bAnQkSWgjM9F3FeBSKSOBEIOMKkgAM6BusYQiOMhouNuPsdr/yGnxTf8Yzr4J38QEwwofk0ARoEzoMA4Mw15EUCXXqsn7Er11A9gt+n3eynZ7Z2l/CFPIw38esUOgy05OpahUT9nzsuEGQEWb4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742776763; c=relaxed/simple;
	bh=bXX8h3ze84iPFjA9k811tSC7msPS11T206RTOhnnpAc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RhmECh4n/gN66gl7RdEf8Ypy82a8tAuBqRZbWbFKLuelJOGFR/1LKKI8a0mKHETTZYWmTnGlE3V94ltr+1ZV0ZYJ4/xIpaGaaxrMsvwj5u3yYaKbZMoZIXAy03rl7HhGWkSMaoCf7vvXq+2o2c9ZOTXE7J8AuqJtLC/gOicEf0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Qt8EnsID; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52O0dFeT5858841, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742776755; bh=bXX8h3ze84iPFjA9k811tSC7msPS11T206RTOhnnpAc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Qt8EnsIDZho/h+DDzTvB6I4wYkAJIpAJAyHDH5xTSTRmhWh2b7RQy8GJ5CA5hmnhd
	 s70edqN+k1YO1ezlKEtuIy2e5LJeLKzLIDEmKkIfeCruOuJ0xCxCytPOTcN3MYcUsc
	 QztgnTrIL+n8vcJxKMjzZtPn6N8OScS5SAakEFqCQO7PGEA3o+GKxyjrmKPvWR5nxw
	 lhOOZ+OrdD2s92s8d8WOZE+jV3YBqc90hpojHNAvgUKLwtFoWYbsGnW9veUa/qJ0l2
	 LmXhISjbGsr9aiE/OrFoAdS4ltf/YDX13IwRdgQvsGQ9nQxEDZ2wRqBOgAKNs2Ou1U
	 tlTyEsXZ6w38g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52O0dFeT5858841
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Mar 2025 08:39:15 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 24 Mar 2025 08:39:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 24 Mar 2025 08:39:15 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 24 Mar 2025 08:39:15 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 3/4] wifi: rtw88: Set AMPDU factor to hardware
Thread-Topic: [PATCH rtw-next 3/4] wifi: rtw88: Set AMPDU factor to hardware
Thread-Index: AQHblFUnF3FHtd8BUESRxvtJE6hCX7N2ps5ggAAqRgCAAVhLgIAAknmAgADkWLCAAOZegIAArwiwgAIrMgCABB4IkA==
Date: Mon, 24 Mar 2025 00:39:15 +0000
Message-ID: <bd2bb20aebde49009cc02077f6324833@realtek.com>
References: <c845ff10-08d9-4057-8f54-1579a548788d@gmail.com>
 <289795d5-49ae-4789-8f14-b2d016843a53@gmail.com>
 <b972a60bb0b04b5f817047027970d896@realtek.com>
 <0ac48cfe-dc7a-442f-b893-41416cd3017d@gmail.com>
 <095328518444426887e039202fa8c609@realtek.com>
 <aa278922-5fac-4f47-acc2-25cc2c133365@gmail.com>
 <95da11e5ec6f43babaedc6dfc25c3cbf@realtek.com>
 <b76818b3-e711-4721-a902-99c557e00a73@gmail.com>
 <38f4ebc6a4864686a9f1b8dc8c30aaef@realtek.com>
 <b1b76ad7-d85f-4b40-8a9f-3cd1fb16460a@gmail.com>
In-Reply-To: <b1b76ad7-d85f-4b40-8a9f-3cd1fb16460a@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAy
MC8wMy8yMDI1IDAyOjM4LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+PiBPbiAxOS8wMy8yMDI1IDAy
OjI4LCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4+PiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIx
Y2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4+Pj4gT24gMTgvMDMvMjAyNSAwNDowNiwgUGlu
Zy1LZSBTaGloIHdyb3RlOg0KPiA+Pj4+PiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUy
QGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4+Pj4+PiBPbiAxNy8wMy8yMDI1IDA1OjAxLCBQaW5nLUtl
IFNoaWggd3JvdGU6DQo+ID4+Pj4+Pj4gQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBn
bWFpbC5jb20+IHdyb3RlOg0KPiA+Pj4+Pj4+Pg0KPiA+Pj4+Pj4+PiBUZWxsIHRoZSBjaGlwIHRo
ZSBtYXhpbXVtIEFNUERVIHNpemUgc3VwcG9ydGVkIGJ5IHRoZSBBUC4gVGhpcyBncmVhdGx5DQo+
ID4+Pj4+Pj4+IGltcHJvdmVzIHRoZSBUWCBzcGVlZCBvZiBSVEw4ODE0QVUgaW4gdGhlIDIuNCBH
SHogYmFuZC4gQmVmb3JlOiB+OTANCj4gPj4+Pj4+Pj4gTWJwcy4gQWZ0ZXI6IH4zMDAgTWJwcy4N
Cj4gPj4+Pj4+Pj4NCj4gPj4+Pj4+Pj4gQWRkIHRoaXMgY29uZmlndXJhdGlvbiBmb3IgYWxsIHRo
ZSBjaGlwcywgZXZlbiBpZiBpdCBvbmx5IGhhcyBhbiBlZmZlY3QNCj4gPj4+Pj4+Pj4gb24gUlRM
ODgxNEFVIGluIG15IHRlc3RzLiBTdXJlbHkgdGhleSBhbGwgbmVlZCB0aGlzLg0KPiA+Pj4+Pj4+
DQo+ID4+Pj4+Pj4gVGhlIGhhcmR3YXJlIGRlZmF1bHQgdmFsdWUgb2YgUkVHX0FNUERVX01BWF9M
RU5HVEggaXMgMHhmZmZmICh1bmxpbWl0ZWQpDQo+ID4+Pj4+Pj4gZm9yIG1vc3QgY2hpcHMuIEl0
IHNlZW1zIGxpa2UgUlRMODgxMkEvUlRMODgyMUEgYXJlIGFsc28gZXhjZXB0aW9ucywgc28NCj4g
Pj4+Pj4+PiBhdCBwb3dlciBvbiBmdW5jdGlvbiB0aGV5IGRvDQo+ID4+Pj4+Pj4gICAgIHJ0d193
cml0ZTMyKHJ0d2RldiwgUkVHX0FNUERVX01BWF9MRU5HVEgsIDB4ZmZmZmZmZmYpOw0KPiA+Pj4+
Pj4+DQo+ID4+Pj4+Pj4gSSBmZWVsIFJUTDg4MTRBIGhhcyBzaW1pbGFyIHNldHRpbmcsIHNvIG1h
eWJlIHlvdSBjYW4ganVzdCBhZGQgc2ltaWxhcg0KPiA+Pj4+Pj4+IHN0dWZmLg0KPiA+Pj4+Pj4+
DQo+ID4+Pj4+Pj4gQnkgdGhlIHdheSwgdGhlIEFNUERVIGlzIGNvbnRyb2xsZWQgYnkgVFggZGVz
Y3JpcHRvciBiYXNpY2FsbHk6DQo+ID4+Pj4+Pj4gICAgICAgcGt0X2luZm8tPmFtcGR1X2ZhY3Rv
ciA9IGFtcGR1X2ZhY3RvcjsNCj4gPj4+Pj4+PiAgICAgICBwa3RfaW5mby0+YW1wZHVfZGVuc2l0
eSA9IGFtcGR1X2RlbnNpdHk7DQo+ID4+Pj4+Pj4gICAgICAgcGt0X2luZm8tPmFtcGR1X2VuID0g
YW1wZHVfZW47DQo+ID4+Pj4+Pj4NCj4gPj4+Pj4+PiBTaW5jZSB5b3UgZGlkbid0IGNoYW5nZSB0
aGlzIHBhcnQgYXQgYWxsLCBJIHN0aWxsIGZlZWwgc2V0dGluZw0KPiA+Pj4+Pj4+IFJFR19BTVBE
VV9NQVhfTEVOR1RIIHRvIDB4ZmZmZmZmZmYgY2FuIGZpeCBsb3cgdGhyb3VnaHB1dCBwcm9ibGVt
Lg0KPiA+Pj4+Pj4+DQo+ID4+Pj4+Pg0KPiA+Pj4+Pj4gSSB0cmllZCAweGZmZmZmZmZmIGp1c3Qg
bm93IGFuZCBpdCBkb2Vzbid0IHdvcmsuIEl0J3MgdGhlIHNhbWUgd2l0aA0KPiA+Pj4+Pj4gYm90
aCBvZiBteSByb3V0ZXJzLiBUaGV5IGFkdmVydGlzZSBhIG1heGltdW0gQU1QRFUgc2l6ZSBvZiA2
NCBLLg0KPiA+Pj4+Pj4gSSBjYW4ndCBqdXN0IHNldCBpdCB0byAweGZmZmYgZWl0aGVyLCBiZWNh
dXNlIHRoZW4gdGhlIHVwbG9hZCBzcGVlZA0KPiA+Pj4+Pj4gaW4gdGhlIDUgR0h6IGJhbmQgc3Vm
ZmVycyBhIGxvdC4gVGhlIGR1YWwgYmFuZCByb3V0ZXIgYWR2ZXJ0aXNlcyBhDQo+ID4+Pj4+PiBt
YXhpbXVtIEFNUERVIHNpemUgb2YgMjU2IEsgaW4gdGhlIDUgR0h6IGJhbmQgc28gaXQgZ2V0cyBh
IHZhbHVlIG9mDQo+ID4+Pj4+PiAweDNmZmZmLg0KPiA+Pj4+Pg0KPiA+Pj4+PiBOb3Qgc3VyZSBp
ZiAweGZmZmZmZmZmIGlzIGEgc3BlY2lhbCB2YWx1ZS4gU2luY2UgdGhpcyBpcyBhIGxpbWl0IG9m
DQo+ID4+Pj4+IEFNUERVIGxlbmd0aCwgeW91IGNhbiBzZXQgYSBjb25zdGFudCBsYXJnZSB2YWx1
ZSBzdWNoIGFzIDB4M2ZmZmYgeW91DQo+ID4+Pj4+IGhhdmUgdGVzdGVkLiBJcyB0aGVyZSBzcGVj
aWFsIGNhc2UgaXQgY2FuJ3QgaGFuZGxlPw0KPiA+Pj4+Pg0KPiA+Pj4+Pg0KPiA+Pj4+DQo+ID4+
Pj4gMHgzZmZmZiBpcyBub3QgZ29vZCBmb3IgdGhlIDIuNCBHSHogYmFuZC4gVGhlIHVwbG9hZCBp
cyBvbmx5IH45MCBNYnBzDQo+ID4+Pj4gd2l0aCBib3RoIG9mIHRoZSByb3V0ZXJzIEkgdGVzdGVk
LiBTYW1lIHdpdGggMHgxZmZmZi4gT25seSAweGZmZmYNCj4gPj4+PiB3b3JrcyB3ZWxsIGZvciB0
aGVtLg0KPiA+Pj4NCj4gPj4+IEhhdmUgeW91IGNoZWNrZWQgdGhlIHBhY2tldHMgaW4gdGhlIGFp
cj8gSG93IGFib3V0IHRoZWlyIGRpZmZlcmVuY2U/DQo+ID4+PiBJbnR1aXRpdmVseSBsYXJnZXIg
UkVHX0FNUERVX01BWF9MRU5HVEggd291bGQgYmUgYmV0dGVyLg0KPiA+Pj4NCj4gPj4NCj4gPj4g
SSBjaGVja2VkIHRvZGF5LiBXaXRoIDB4ZmZmZmZmZmYgSSBzZWUgMjklIHJldHJhbnNtaXNzaW9u
IHJhdGUuIFdpdGgNCj4gPj4gMHhmZmZmIHRoZSByZXRyYW5zbWlzc2lvbiByYXRlIGlzIG9ubHkg
OC42JS4NCj4gPg0KPiA+IENhbiB5b3UgaGVscCB0byBjb25maXJtIGlmIHJldHJhbnNtaXNzaW9u
IGlzIGJlY2F1c2UgQVAgY2FuJ3QgcmVjZWl2ZSB0aGUgbG9uZw0KPiA+IHBhY2tldHM/IEkgc3Vw
cG9zZSB0aGUgQkEgYml0bWFwIGZyb20gQVAgYXJlbid0IGFsbCBvbmUncy4NCj4gPg0KPiANCj4g
SW4gYSAzMCBzZWNvbmQgY2FwdHVyZSBpbiB0aGUgbWlkZGxlIG9mIHJ1bm5pbmcgaXBlcmYzIHdp
dGggMHg0NTggPQ0KPiAweGZmZmYgdGhlcmUgd2VyZSAxMTQ0MCBibG9jayBhY2sgZnJvbSB0aGUg
cm91dGVyIHRvIHRoZSBSVEw4ODE0QVUuDQo+IE9mIHRob3NlLCAxMzggKDEuMiUpIHdlcmUgYmxv
Y2sgYWNrIHdpdGggdGhlIGJpdG1hcCBub3QgYWxsIDFzLg0KPiANCj4gSW4gYW5vdGhlciAzMCBz
ZWNvbmQgY2FwdHVyZSBpbiB0aGUgbWlkZGxlIG9mIHJ1bm5pbmcgaXBlcmYzIHdpdGgNCj4gMHg0
NTggPSAweGZmZmZmZmZmIHRoZXJlIHdlcmUgODExMiBibG9jayBhY2sgZnJvbSB0aGUgcm91dGVy
IHRvIHRoZQ0KPiBSVEw4ODE0QVUuIE9mIHRob3NlLCAzMDUgKDMuNzYlKSB3ZXJlIGJsb2NrIGFj
ayB3aXRoIGJpdG1hcCBub3QgYWxsDQo+IDFzLg0KPiANCj4gU2VlIHRoZSBhdHRhY2htZW50cy4N
Cg0KVGhhbmtzIGZvciB0aGUgcmVzdWx0cywgd2hpY2ggc2hvd3MgfjkwTSAoMy43NiUpIHZzIH4z
MDBNICgxLjIlKS4gDQpUaG91Z2ggd2UgY2FuJ3QgdW5kZXJzdGFuZCB0aGUgcmF0ZSBvZiBub3Qg
YWxsIDFzIGNhbiBhZmZlY3Qgc28gbXVjaC4gDQpBbnl3YXksIGxldCdzIG1vdmUgb24uIA0KDQo=

