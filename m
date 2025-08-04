Return-Path: <linux-wireless+bounces-26112-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 32CE7B199DE
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 03:33:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C5F83188B5C5
	for <lists+linux-wireless@lfdr.de>; Mon,  4 Aug 2025 01:33:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A950A2F29;
	Mon,  4 Aug 2025 01:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="U3fTBmDJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC1042E36EB;
	Mon,  4 Aug 2025 01:33:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754271208; cv=none; b=mXYdBzYvjCV0CNNuoHnE1cTBYiwUoHOBDb4Lq7Sx99HVIkOtsWEdZmwdun959nS2nMKR0PsJytv2Ziv/VYHOAOA1oi6Vz1Z4Z4Pfz1lG7mzfKKoPEVaa5A8JZ8XpoJCQuzfWxWeNdSe/+gR9ggPpb5WHPX8ocGpqnwVhxBSJb4M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754271208; c=relaxed/simple;
	bh=HjhgTL+cqDD9tM5N1b6zFlkKphw8vKNhJE432zm0/xg=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=CKhDu+NpTVACfLQtJvLLY7qNPUe99k4E4AKAYEd3PNy3H0cIDzx/gFn7MPi1/zr4MYSdutePAo5asPn+hbobBPDrAptdbvwj8KHO654a8v7BGXMEgx3lO/0ydNmGFV7wtYGpRCTWD3rKJkbSbSYjP8wXqCN7T9m7CCC89BJHc2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=U3fTBmDJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5741XAuyC3197906, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1754271190; bh=HjhgTL+cqDD9tM5N1b6zFlkKphw8vKNhJE432zm0/xg=;
	h=From:To:CC:Subject:Date:Message-ID:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	b=U3fTBmDJVMgKEO9UJsnjwFzalEaioNTLnHtPgkHsR7GcfkIdcwWPpdDgStJGBjEUw
	 Of5QpaK28wcHw3eXKHNsTTYdXfuKFAFRQT+6qDVeaefTJ6XQ38Np7iAdXt6UAAZoXj
	 B1jFo/L/JG/iEviIJcCx/Tfka50fH5cGAsCYnMXnxPPbZGcQtF0ZGKZXRix6zn2Pzo
	 aKIEpUe65oW86PFXnjpXug8eFLWGRxX8of0ZHnkCjCMGtGDrGRCd/BM+T6LtcHBXKY
	 IW8ZRtmHDMIxOrLoryZZzRtcR6Dz3+ce29nPvV266wUwM/hj6sVqzVR51XetlUwSdC
	 Vo9en5JfhJGVQ==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 5741XAuyC3197906
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 4 Aug 2025 09:33:10 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Aug 2025 09:33:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 4 Aug 2025 09:33:11 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::9617:3fd6:3830:25cc%10]) with mapi id
 15.02.1544.011; Mon, 4 Aug 2025 09:33:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Sean Anderson
	<sean.anderson@linux.dev>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw89: Print only once for unsupported c2h classes
Thread-Topic: [PATCH] wifi: rtw89: Print only once for unsupported c2h classes
Thread-Index: AQHcALaJzXGJOyfKPkG20PFKd07euLRI+tuAgADXwyCAB+sIcA==
Date: Mon, 4 Aug 2025 01:33:11 +0000
Message-ID: <203676cda07147a2aab7d6fee3733943@realtek.com>
References: <20250729182743.114733-1-sean.anderson@linux.dev>
 <d2d62793-046c-4b55-93ed-1d1f43cff7f2@gmail.com> 
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

UGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5jb20+IHdyb3RlOg0KPiBCaXR0ZXJibHVlIFNt
aXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4gd3JvdGU6DQo+ID4gT24gMjkvMDcvMjAyNSAy
MToyNywgU2VhbiBBbmRlcnNvbiB3cm90ZToNCj4gPiA+IFRoZXJlIGFyZSBtb3JlIHVuc3VwcG9y
dGVkIGZ1bmN0aW9ucyB0aGFuIGp1c3QgTE9XUlRfUlRZLiBJbXByb3ZlIG9uDQo+ID4gPiBjb21t
aXQgM2I2NjUxOWIwMjNiICgid2lmaTogcnR3ODk6IHBoeTogYWRkIGR1bW15IGMyaCBoYW5kbGVy
IHRvIGF2b2lkDQo+ID4gPiB3YXJuaW5nIG1lc3NhZ2UiKSBieSBwcmludGluZyBhIG1lc3NhZ2Ug
anVzdCBvbmNlIHdoZW4gd2UgZmlyc3QNCj4gPiA+IGVuY291bnRlciBhbiB1bnN1cHBvcnRlZCBj
bGFzcy4gVGhpcyBwcmV2ZW50cyBtZXNzYWdlcyBsaWtlDQo+ID4gPg0KPiA+ID4gcnR3ODlfODky
MmFlIDAwMDA6ODE6MDAuMDogUEhZIGMyaCBjbGFzcyAyIG5vdCBzdXBwb3J0DQo+ID4gPg0KPiA+
ID4gZnJvbSBmaWxsaW5nIHVwIGRtZXNnLg0KPiA+ID4NCj4gPg0KPiA+IEkgYWxzbyBnZXQgIk1B
QyBjMmggY2xhc3MgMSBmdW5jIDMgbm90IHN1cHBvcnQiIGFuZCAiTUFDIGMyaCBjbGFzcw0KPiA+
IDAgZnVuYyA2IG5vdCBzdXBwb3J0IiB3aXRoIFJUTDg4MzJDVS4NCj4gDQo+IFRoZXNlIHR3byBD
MkggZXZlbnRzIHdlcmUgZGVmaW5lZCBhczoNCj4gDQo+IC8vIENMQVNTIDEgLSBGV19PRkxEDQo+
ICNkZWZpbmUgRldDTURfQzJIX0ZVTkNfQkVBQ09OX1JFU0VORCAweDMNCj4gDQo+IC8vIENMQVNT
IDAgLSBGV19JTkZPDQo+ICNkZWZpbmUgRldDTURfQzJIX0ZVTkNfQkNOX1VQRF9ET05FIDB4MDYN
Cj4gDQo+IFRoZSBpbXBsZW1lbnRhdGlvbiBvZiBoYW5kbGVycyBpbiB2ZW5kb3IgZHJpdmVyIGxv
b2tzIGxpa2UgZG9lcyBub3RoaW5nDQo+IG5lZWRlZCB0byBiZSByZXdyaXR0ZW4uIEp1c3QgYWRk
IGEgZHVtbXkgdG8gcmVwcmVzZW50IHRoYXQgd2UgaGF2ZSByZXZpZXdlZA0KPiB0aGUgQzJIIGV2
ZW50cy4NCj4gDQoNCkkgYWRkZWQgdHdvIGR1bW15IGZ1bmN0aW9ucyBmb3IgdGhlc2UgdG8gQzJI
IGV2ZW50cyBieSBbMV0uDQpQbGVhc2UgaGVscCB0byB0ZXN0IGlmIHRoaXMgY2FuIHJlc29sdmUg
dGhlIG1lc3NhZ2VzIGluIHlvdXIgc2lkZS4NCg0KWzFdIGh0dHBzOi8vbG9yZS5rZXJuZWwub3Jn
L2xpbnV4LXdpcmVsZXNzLzIwMjUwODA0MDEyMjM0Ljg5MTMtMS1wa3NoaWhAcmVhbHRlay5jb20v
VC8jdA0KDQo=

