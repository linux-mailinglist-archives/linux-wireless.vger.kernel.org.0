Return-Path: <linux-wireless+bounces-20476-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 756F6A665F8
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 03:07:00 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ABBEF18953E0
	for <lists+linux-wireless@lfdr.de>; Tue, 18 Mar 2025 02:07:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E54C01547FF;
	Tue, 18 Mar 2025 02:06:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="VEAb6ySl"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C537681749
	for <linux-wireless@vger.kernel.org>; Tue, 18 Mar 2025 02:06:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742263615; cv=none; b=EqGvy6ygpzgABJaefZis/wO1RLEEZ/fit8FAKpRp0VEdqlshqU9/xvaQilJrUY6TtMt0VMF3nt0omYAD2cnQEqRXi2xfRTwQ16ReCHZXqYzpnGBMx/EUZT1GRKZqxmTewQ8fFcZ9J+UxOTrY1OE1t9Gc3EbefxN+yLpjDs/Grb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742263615; c=relaxed/simple;
	bh=jxEYUWJMclvbthC9jbDBKezur/DYgZAiKL+Nv2CJFWg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=gmYfTNKQEyURK2B8YykwbNUIjha+lIhhuzxF4K64oTDxEU3KDCv/xTgEHPhhSbzoJsZ63miGPxn6/bsQY+r+jze8Rps1MJQSsz/x4CMDU7gBf9faGUVb+E/wt2Z3jR6KHb7jzlbeHxQk5s4yi3E9GQR/F93LYEW/bQVDqUxXPKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=VEAb6ySl; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 52I26nlB62077899, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1742263609; bh=jxEYUWJMclvbthC9jbDBKezur/DYgZAiKL+Nv2CJFWg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=VEAb6ySlVe+IAymXHJYbpr/094gz1Yy7IOVsLDU7GG1iQ5fQ9JLeJAU7ck6Ub1LZ1
	 nuYQQJfmYTOOtPy/dXtSuUmVnrGv+Y0SWEtiWTSv0GUPJdF0UGixs9hfudrZjFVHTM
	 4iRjSOoheFVpb46syHKESjMYlEhX3KWkI7H1ckltYc1EZ2S8EC7yuYUucRjUQcEilJ
	 F2D4LeZWwkWDd5XZ4OxPTlCvcotq17IczjQ+6Ecf03KOor5CmQVF5rUV/VsSIH0g5m
	 gE22wDooY0vE5I2Y9I1IkT4zBOIXW8xGlqKmuuVgcqTzyw2cHBh7T9wB3CPwqdPtLO
	 sMdcEHefVOtPw==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 52I26nlB62077899
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Mar 2025 10:06:49 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 18 Mar 2025 10:06:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 18 Mar 2025 10:06:48 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 18 Mar 2025 10:06:48 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next 3/4] wifi: rtw88: Set AMPDU factor to hardware
Thread-Topic: [PATCH rtw-next 3/4] wifi: rtw88: Set AMPDU factor to hardware
Thread-Index: AQHblFUnF3FHtd8BUESRxvtJE6hCX7N2ps5ggAAqRgCAAVhLgA==
Date: Tue, 18 Mar 2025 02:06:48 +0000
Message-ID: <095328518444426887e039202fa8c609@realtek.com>
References: <c845ff10-08d9-4057-8f54-1579a548788d@gmail.com>
 <289795d5-49ae-4789-8f14-b2d016843a53@gmail.com>
 <b972a60bb0b04b5f817047027970d896@realtek.com>
 <0ac48cfe-dc7a-442f-b893-41416cd3017d@gmail.com>
In-Reply-To: <0ac48cfe-dc7a-442f-b893-41416cd3017d@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAx
Ny8wMy8yMDI1IDA1OjAxLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4gQml0dGVyYmx1ZSBTbWl0
aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiA+Pg0KPiA+PiBUZWxsIHRoZSBj
aGlwIHRoZSBtYXhpbXVtIEFNUERVIHNpemUgc3VwcG9ydGVkIGJ5IHRoZSBBUC4gVGhpcyBncmVh
dGx5DQo+ID4+IGltcHJvdmVzIHRoZSBUWCBzcGVlZCBvZiBSVEw4ODE0QVUgaW4gdGhlIDIuNCBH
SHogYmFuZC4gQmVmb3JlOiB+OTANCj4gPj4gTWJwcy4gQWZ0ZXI6IH4zMDAgTWJwcy4NCj4gPj4N
Cj4gPj4gQWRkIHRoaXMgY29uZmlndXJhdGlvbiBmb3IgYWxsIHRoZSBjaGlwcywgZXZlbiBpZiBp
dCBvbmx5IGhhcyBhbiBlZmZlY3QNCj4gPj4gb24gUlRMODgxNEFVIGluIG15IHRlc3RzLiBTdXJl
bHkgdGhleSBhbGwgbmVlZCB0aGlzLg0KPiA+DQo+ID4gVGhlIGhhcmR3YXJlIGRlZmF1bHQgdmFs
dWUgb2YgUkVHX0FNUERVX01BWF9MRU5HVEggaXMgMHhmZmZmICh1bmxpbWl0ZWQpDQo+ID4gZm9y
IG1vc3QgY2hpcHMuIEl0IHNlZW1zIGxpa2UgUlRMODgxMkEvUlRMODgyMUEgYXJlIGFsc28gZXhj
ZXB0aW9ucywgc28NCj4gPiBhdCBwb3dlciBvbiBmdW5jdGlvbiB0aGV5IGRvDQo+ID4gICAgIHJ0
d193cml0ZTMyKHJ0d2RldiwgUkVHX0FNUERVX01BWF9MRU5HVEgsIDB4ZmZmZmZmZmYpOw0KPiA+
DQo+ID4gSSBmZWVsIFJUTDg4MTRBIGhhcyBzaW1pbGFyIHNldHRpbmcsIHNvIG1heWJlIHlvdSBj
YW4ganVzdCBhZGQgc2ltaWxhcg0KPiA+IHN0dWZmLg0KPiA+DQo+ID4gQnkgdGhlIHdheSwgdGhl
IEFNUERVIGlzIGNvbnRyb2xsZWQgYnkgVFggZGVzY3JpcHRvciBiYXNpY2FsbHk6DQo+ID4gICAg
ICAgcGt0X2luZm8tPmFtcGR1X2ZhY3RvciA9IGFtcGR1X2ZhY3RvcjsNCj4gPiAgICAgICBwa3Rf
aW5mby0+YW1wZHVfZGVuc2l0eSA9IGFtcGR1X2RlbnNpdHk7DQo+ID4gICAgICAgcGt0X2luZm8t
PmFtcGR1X2VuID0gYW1wZHVfZW47DQo+ID4NCj4gPiBTaW5jZSB5b3UgZGlkbid0IGNoYW5nZSB0
aGlzIHBhcnQgYXQgYWxsLCBJIHN0aWxsIGZlZWwgc2V0dGluZw0KPiA+IFJFR19BTVBEVV9NQVhf
TEVOR1RIIHRvIDB4ZmZmZmZmZmYgY2FuIGZpeCBsb3cgdGhyb3VnaHB1dCBwcm9ibGVtLg0KPiA+
DQo+IA0KPiBJIHRyaWVkIDB4ZmZmZmZmZmYganVzdCBub3cgYW5kIGl0IGRvZXNuJ3Qgd29yay4g
SXQncyB0aGUgc2FtZSB3aXRoDQo+IGJvdGggb2YgbXkgcm91dGVycy4gVGhleSBhZHZlcnRpc2Ug
YSBtYXhpbXVtIEFNUERVIHNpemUgb2YgNjQgSy4NCj4gSSBjYW4ndCBqdXN0IHNldCBpdCB0byAw
eGZmZmYgZWl0aGVyLCBiZWNhdXNlIHRoZW4gdGhlIHVwbG9hZCBzcGVlZA0KPiBpbiB0aGUgNSBH
SHogYmFuZCBzdWZmZXJzIGEgbG90LiBUaGUgZHVhbCBiYW5kIHJvdXRlciBhZHZlcnRpc2VzIGEN
Cj4gbWF4aW11bSBBTVBEVSBzaXplIG9mIDI1NiBLIGluIHRoZSA1IEdIeiBiYW5kIHNvIGl0IGdl
dHMgYSB2YWx1ZSBvZg0KPiAweDNmZmZmLg0KDQpOb3Qgc3VyZSBpZiAweGZmZmZmZmZmIGlzIGEg
c3BlY2lhbCB2YWx1ZS4gU2luY2UgdGhpcyBpcyBhIGxpbWl0IG9mDQpBTVBEVSBsZW5ndGgsIHlv
dSBjYW4gc2V0IGEgY29uc3RhbnQgbGFyZ2UgdmFsdWUgc3VjaCBhcyAweDNmZmZmIHlvdSANCmhh
dmUgdGVzdGVkLiBJcyB0aGVyZSBzcGVjaWFsIGNhc2UgaXQgY2FuJ3QgaGFuZGxlPw0KDQoNCg==

