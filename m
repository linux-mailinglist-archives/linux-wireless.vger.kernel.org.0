Return-Path: <linux-wireless+bounces-29272-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [IPv6:2a01:60a::1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 12061C7F18D
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 07:37:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id B33FD34762C
	for <lists+linux-wireless@lfdr.de>; Mon, 24 Nov 2025 06:37:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D3D922D97A4;
	Mon, 24 Nov 2025 06:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="sTKQJ2OS"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69F0A2D8792;
	Mon, 24 Nov 2025 06:37:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763966255; cv=none; b=iG8i4Y0d81HoOxJFCNsWwRxwaINrULPSsE996Rye3R3tXO1qedPstmIsAk2iII9hUP3oEfTBSSKQTi/j3I9KuEJdYBaG1DHbd0Jrmc8+az4mW1j3njFs7U6d4NHUnn0kqP4uw85apCXCwuSiFlxpTdyU0LdFWznBswZpMH9EFCw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763966255; c=relaxed/simple;
	bh=6FuPcvgNfsMMJi/137goBH87EKAAbtpVXTVcFYHSgyQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Rfvzes4AxfiSBafGxG9iYC/rxm8kTCYbdsjQ2BUR/xKz0JeVXyo/qHhQIPOUVZprjuRr/6Ez7yFphKHErZ32XB4I5cvhGE0T3qtqQr2y0OuEkXmbiQc7OKXFkLB5uOOcyKaUODfhJcQtljor71/Onz6I78aG8N8wxMo3wNitzUk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=sTKQJ2OS; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AO6b7Hj9444415, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763966227; bh=6FuPcvgNfsMMJi/137goBH87EKAAbtpVXTVcFYHSgyQ=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=sTKQJ2OShKtzAo8KiFGXfNQaqUD0aKXMHGrhfrwdU/Gxz2U4+JLdp0icvjZF8r39v
	 sjwlTIiXgGXUsnuhNcNWprJRNe2wS4syJDQ+3B+XdBbUHrZuFqYvi3jbFqmHlqF8K5
	 D6ND/G7PuQiX9PcUuxWElUNMgBtWUaiQxkT0kXIdAQhYZCSaDG3IZNhyRXyb0JzvuA
	 ZVqO2x0U9KFClTglHpkywFVWQ5u+yw1qy7nmLKuyaeqc46P8aXtDAFbpQJXPdeh2II
	 rfsQsF1fxRFKvGddrL7jQjkP6LkSBjxpWsc80PMjWNkHAr7w5tRjOUn0hdu0pp0fAt
	 WvoK6ik7+3xEw==
Received: from mail.realtek.com (rtkexhmbs02.realtek.com.tw[172.21.6.41])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AO6b7Hj9444415
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 24 Nov 2025 14:37:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS02.realtek.com.tw (172.21.6.41) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 24 Nov 2025 14:37:08 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS06.realtek.com.tw (10.21.1.56) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 24 Nov 2025 14:37:07 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Mon, 24 Nov 2025 14:37:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        Zenm Chen
	<zenmchen@gmail.com>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>
CC: "Jes.Sorensen@gmail.com" <Jes.Sorensen@gmail.com>,
        "gustavoars@kernel.org"
	<gustavoars@kernel.org>,
        "linux-hardening@vger.kernel.org"
	<linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
Subject: RE: [PATCH][next] wifi: rtl8xxxu: Avoid
 -Wflex-array-member-not-at-end warnings
Thread-Topic: [PATCH][next] wifi: rtl8xxxu: Avoid
 -Wflex-array-member-not-at-end warnings
Thread-Index: AQHcWTQWm+ekto8gdkOtuZTX88y/HbT8ZJsAgAADogCAAA5sgIADwJWAgAEjHUA=
Date: Mon, 24 Nov 2025 06:37:07 +0000
Message-ID: <2823a19f73ef45a0919e48ef42ce636f@realtek.com>
References: <ff184c0e-17f2-445f-9339-f4db9943db86@embeddedor.com>
 <20251121111132.4435-1-zenmchen@gmail.com>
 <475b4336-eed0-4fae-848f-aae26f109606@gmail.com>
In-Reply-To: <475b4336-eed0-4fae-848f-aae26f109606@gmail.com>
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

SGkgQml0dGVyYmx1ZSBhbmQgWmVubSwNCg0KQml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZl
MkBnbWFpbC5jb20+IHdyb3RlOg0KPiBPbiAyMS8xMS8yMDI1IDEzOjExLCBaZW5tIENoZW4gd3Jv
dGU6DQo+ID4gR3VzdGF2byBBLiBSLiBTaWx2YSA8Z3VzdGF2b0BlbWJlZGRlZG9yLmNvbT4g5pa8
IDIwMjXlubQxMeaciDIx5pelIOmAseS6lCDkuIvljYg2OjIw5a+r6YGT77yaDQo+ID4+DQo+ID4+
IEhpLA0KPiA+Pg0KPiA+PiBPbiAxMS8yMS8yNSAxOTowNiwgWmVubSBDaGVuIHdyb3RlOg0KPiA+
Pj4gRGVhciBtYWludGFpbmVycywNCj4gPj4+DQo+ID4+PiBXaXRoIHRoaXMgcGF0Y2ggYXBwbGll
ZCwgbXkgc3lzdGVtIGFsd2F5cyBmcmVlemVzIHJpZ2h0IGFmdGVyIHRoZSBydGw4eHh4dQ0KPiA+
Pj4gZHJpdmVyIGlzIGxvYWRlZC4gaXMgaXQgbm9ybWFsPw0KPiA+Pg0KPiA+PiBJIGRvbid0IHRo
aW5rIHNvLi4uIEl0IHByb2JhYmx5IG1lYW5zIHRoYXQgc3RydWN0IHVyYiB1cmI7IGNhbm5vdCBy
ZWFsbHkgYmUNCj4gPj4gbW92ZWQgdG8gdGhlIGVuZCBvZiBzdHJ1Y3QgcnRsOHh4eHVfcnhfdXJi
IG9yIHN0cnVjdCBydGw4eHh4dV90eF91cmI/DQo+ID4+DQo+ID4+IEl0J2QgYmUgZ3JlYXQgaWYg
eW91IGNvdWxkIHNoYXJlIGEgbG9nLg0KPiA+Pg0KPiA+DQo+ID4gSGksDQo+ID4NCj4gPiBOb3Ro
aW5nIGhlbHBmdWwgZm91bmQgZnJvbSB0aGUga2VybmVsIGxvZy4gTWF5YmUgUmVhbHRlayBkcml2
ZXJzIG1haW50YWluZXINCj4gPiBQaW5nLUtlIGNvdWxkIHRha2UgYSBsb29rIHdoYXQgaXMgd3Jv
bmcgbmV4dCBNb25kYXkuDQo+ID4NCj4gWy4uLl0NCj4gDQo+IEkgZ290IHNvbWV0aGluZy4gSW4g
bXkgY2FzZSBldmVyeXRoaW5nIHNlZW1lZCBmaW5lIHVudGlsIEkgdW5wbHVnZ2VkIHRoZQ0KPiB3
aWZpIGFkYXB0ZXIuIEFuZCB0aGVuIHRoZSBzeXN0ZW0gc3RpbGwgd29ya2VkIGZvciBhIGZldyBt
aW51dGVzIGJlZm9yZQ0KPiBpdCBmcm96ZS4NCg0KQWZ0ZXIgcmV2aWV3aW5nIHVzZXMgb2YgcnRs
OHh4eHVfcnhfdXJiIGFuZCBydGw4eHh4dV90eF91cmIgYWdhaW4sIEkgY2FuJ3QNCmZpbmQgb2J2
aW91cyBwcm9ibGVtIHdoeSBpdCBnZXRzIHdyb25nLiANCg0KQ291bGQgeW91IHBsZWFzZSB0cnkg
b25lIGFwcGx5IHBhcnRpYWwgY2hhbmdlIG9mIHRoaXMgcGF0Y2g/IA0KSSBtZWFuIG9ubHkgYXBw
bHkgY2hhbmdlcyBvZiBydGw4eHh4dV9yeF91cmIgb3IgcnRsOHh4eHVfdHhfdXJiIHRvIHNlZQ0K
d2hpY2ggcGFydCBpcyB0aGUgY2F1c2UuIFRoZW4sIHdlIGNhbiBmb2N1cyBvbiB0aGUgcGFydCBk
ZWVwZXIuIA0KDQoNCg==

