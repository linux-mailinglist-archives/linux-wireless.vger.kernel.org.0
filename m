Return-Path: <linux-wireless+bounces-15024-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0574C9BFAEB
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 01:51:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 371C81C21AB9
	for <lists+linux-wireless@lfdr.de>; Thu,  7 Nov 2024 00:51:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF0994C96;
	Thu,  7 Nov 2024 00:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="tL5w9RZD"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4F72F43;
	Thu,  7 Nov 2024 00:51:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730940704; cv=none; b=U1cPi/AdwFLj4ZcXllVWL/ErcVSeyV+u7my0x2J6xHaFZhM2uII+Jc1pvqyL/mfWzpbc4rb1TCAXpe3X2K5b9x1bSIj3NomCWPHmkJbTJOeljJqllp+rlqHSKUd6HzIAOO+TgpNy9SvD4xOy8EmiXg7eZSGcTlZGprcu7Ux/QcU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730940704; c=relaxed/simple;
	bh=Wvy2wDlUkblN0oqr9mTEbTAnKuA3vbKbf4LmvZ5IQqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=nkPjOIR1AfibkaQhujtzD4sDQp8lGjUqjNR84zAUKTtKzt1HF6rvwsMu277012Xrn0UlQ/dJZEy6TdTZ5LCaj1gWjW6OsKW4fmNZl108Dc+6yb0xgCrkUkvTUTdf08NMSS69G+sRRWUohpUN5wCk2u9vM3/gVRjf2VeKc73qMKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=tL5w9RZD; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4A70pPigD3605158, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1730940685; bh=Wvy2wDlUkblN0oqr9mTEbTAnKuA3vbKbf4LmvZ5IQqY=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=tL5w9RZDnsEbebe9GF3/RvYN+xi6Yzggbah3K7fR0jcrPqongbn7Z+4Uz9krCww1V
	 SuhD813QtYRvN5Fn7Yn8kdv8gsxsXNwOJ9jjninrbzUY1vvUtNL2KP2+TSzjmWNMDr
	 mGxK1FlUCqcGktnTleZ6dJd8U06iJuHQw6BDPbNhouMwiu8fi0/xqNi+/oL7UWL+FS
	 SqAQb1C9ayAPYOkq1/d8DOBabRErIFPqUcQmzwWc9ZEp8Bf6TvnZ2Ve6qoH1ulIIQb
	 qnecrO8ardvsFNYWQi7r7Yx3pyoNM3ELLFFfQjw0U+KPKCQN1G0By+gjEtPr+H+hlK
	 2Ggw1AS7mrGqA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 4A70pPigD3605158
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 7 Nov 2024 08:51:25 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 7 Nov 2024 08:51:26 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 7 Nov 2024 08:51:25 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 7 Nov 2024 08:51:25 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Colin Ian King <colin.i.king@gmail.com>, Kalle Valo <kvalo@kernel.org>,
        Su
 Hui <suhui@nfschina.com>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtlwifi: rtl8821ae: phy: restore removed code to fix infinite loop
Thread-Topic: [PATCH] wifi: rtlwifi: rtl8821ae: phy: restore removed code to
 fix infinite loop
Thread-Index: AQHbMGMXfuZ/iKxCEEO3RYMeZbQJPLKq/I0w
Date: Thu, 7 Nov 2024 00:51:25 +0000
Message-ID: <c39feb8063924701b99965e6b650c993@realtek.com>
References: <20241106154642.1627886-1-colin.i.king@gmail.com>
In-Reply-To: <20241106154642.1627886-1-colin.i.king@gmail.com>
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

Q29saW4gSWFuIEtpbmcgPGNvbGluLmkua2luZ0BnbWFpbC5jb20+IHdyb3RlOg0KPiBBIHByZXZp
b3VzIGNsZWFuLXVwIGZpeCByZW1vdmVkIHRoZSBhc3NpZ25tZW50IG9mIHYyIGluc2lkZSBhIHdo
aWxlIGxvb3ANCj4gdGhhdCB0dXJuZWQgaXQgaW50byBhbiBpbmZpbml0ZSBsb29wLiBGaXggdGhp
cyBieSByZXN0b3JpbmcgdGhlIGFzc2lnbm1lbnQNCj4gb2YgdjIgZnJvbSBhcnJheVtdIHNvIHRo
YXQgdjIgaXMgdXBkYXRlZCBpbnNpZGUgdGhlIGxvb3AuDQo+IA0KPiBGaXhlczogY2RhMzc0NDU3
MThkICgid2lmaTogcnRsd2lmaTogcnRsODgyMWFlOiBwaHk6IHJlbW92ZSBzb21lIHVzZWxlc3Mg
Y29kZSIpDQo+IFNpZ25lZC1vZmYtYnk6IENvbGluIElhbiBLaW5nIDxjb2xpbi5pLmtpbmdAZ21h
aWwuY29tPg0KDQpJIHRlc3RlZCBSVEw4ODEyQUUvODgyMUFFLiBMdWNraWx5LCBwYXJzaW5nIGN1
cnJlbnQgUEhZIHJlZ2lzdGVyIHBhcmFtZXRlcnMNCm5ldmVyIGZhbGxzIGludG8gdGhlIGNoZWNr
IGNvbmRpdGlvbi4gDQoNClRlc3RlZC1ieTogUGluZy1LZSBTaGloIDxwa3NoaWhAcmVhbHRlay5j
b20+DQoNCj4gLS0tDQo+ICBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvcnRs
ODgyMWFlL3BoeS5jIHwgNCArKystDQo+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCsp
LCAxIGRlbGV0aW9uKC0pDQo+IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydGx3aWZpL3J0bDg4MjFhZS9waHkuYw0KPiBiL2RyaXZlcnMvbmV0L3dpcmVsZXNz
L3JlYWx0ZWsvcnRsd2lmaS9ydGw4ODIxYWUvcGh5LmMNCj4gaW5kZXggMWJlNTFlYTNmM2M4Li4w
ZDRkNzg3ZThiZTUgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsv
cnRsd2lmaS9ydGw4ODIxYWUvcGh5LmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVh
bHRlay9ydGx3aWZpL3J0bDg4MjFhZS9waHkuYw0KPiBAQCAtMjAzMyw4ICsyMDMzLDEwIEBAIHN0
YXRpYyBib29sIF9ydGw4ODIxYWVfcGh5X2NvbmZpZ19iYl93aXRoX3BnaGVhZGVyZmlsZShzdHJ1
Y3QgaWVlZTgwMjExX2h3ICpodywNCj4gICAgICAgICAgICAgICAgICAgICAgICAgaWYgKCFfcnRs
ODgyMWFlX2NoZWNrX2NvbmRpdGlvbihodywgdjEpKSB7DQo+ICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgaSArPSAyOyAvKiBza2lwIHRoZSBwYWlyIG9mIGV4cHJlc3Npb24qLw0KPiAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHYyID0gYXJyYXlbaSsxXTsNCj4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICB3aGlsZSAodjIgIT0gMHhERUFEKQ0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIHdoaWxlICh2MiAhPSAweERFQUQpIHsNCj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIGkgKz0gMzsNCj4gKyAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIHYyID0gYXJyYXlbaSArIDFdOw0KPiArICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgIH0NCj4gICAgICAgICAgICAgICAgICAgICAgICAgfQ0K
PiAgICAgICAgICAgICAgICAgfQ0KPiAgICAgICAgIH0NCj4gLS0NCj4gMi4zOS41DQoNCg==

