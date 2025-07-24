Return-Path: <linux-wireless+bounces-25981-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1772EB10291
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 10:00:29 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A42C43A4754
	for <lists+linux-wireless@lfdr.de>; Thu, 24 Jul 2025 07:59:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id AAA492737E3;
	Thu, 24 Jul 2025 08:00:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="DasnPGRt"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49F0B272800
	for <linux-wireless@vger.kernel.org>; Thu, 24 Jul 2025 08:00:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753344010; cv=none; b=AKYkuhZhIL/HUGX5hRSMrDIi7Dg6qAeGt52x4VVQJHOPqCq9LZVBS2Il2VQuaNG7h2iK+tfArAoP6B93AjPw4F9YkZ4YASgo9URIxpFwqyIudviImEJzOeURoZmyL8ruF1lkxuLIheUA/SZgl9ASbcrFVuuNi07bFbzLhpDmPKA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753344010; c=relaxed/simple;
	bh=1UbXuOph5hV5q+sHtNYUA0bOQLApdqNg7/Y04XQuLSI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Bzq2yXhiIbV91FRhkrM0cKW55gvzlGsWOOUQxLRd9+w7Ft7Ryh+aT6Y+ItQlpR7yXhCJhR4fKYcgiUcNV4GchYSb7xOUHioeIRfMIFny9TRsgnapOVgx/iKY7fv/3FBKjVjwDuMAeBs9KFR8l+QAb853nWHONuPRQhb9C8fdbbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=DasnPGRt; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 56O7xxMfB115703, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1753343999; bh=1UbXuOph5hV5q+sHtNYUA0bOQLApdqNg7/Y04XQuLSI=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=DasnPGRt6IKY2e9gV/Mrm+PkyE+Bvv8YW5s5LbVwCGk4OMDU3hobFcw2lBsJ1KKs/
	 zbRNWrEHsp0oPRV9G/g+fhrrb1K5evW1BgfqoNEFTAdSXW8MNA+xUxl0dLPl1NISnY
	 QSQYal4EHadLxYwk015Dz+2GI6vRR/XnqnzqpQgCi/P/GggobCvRjtAukDWWGwpPKv
	 NcGkIe5JtWV/GDEGaU2JldM2UMIgEzWNlqrIT53jV/gixi5eJHJ+9VPwhgGu14uLRs
	 tVQogaKDMgOf8VoaseTpLlKwmm5N5XkcUw4juI6dWZfemZvvWnbXkWU4Lrb58wpTgN
	 Nh+rpOGDxrjaA==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 56O7xxMfB115703
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 24 Jul 2025 15:59:59 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Thu, 24 Jul 2025 15:59:59 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 24 Jul 2025 15:59:59 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47]) by
 RTEXMBS04.realtek.com.tw ([fe80::81fc:50c6:85d5:cb47%5]) with mapi id
 15.01.2507.035; Thu, 24 Jul 2025 15:59:59 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Piotr Oniszczuk <piotr.oniszczuk@gmail.com>
CC: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "martin.blumenstingl@googlemail.com" <martin.blumenstingl@googlemail.com>
Subject: RE: rtl8822cs, mainline 6.16-rc7: kernel reports ' unsupported rf path'
Thread-Topic: rtl8822cs, mainline 6.16-rc7: kernel reports ' unsupported rf
 path'
Thread-Index: AQHb+wy3xJJYRq7Qhky2ZR9b8r3WqLQ+3/XA///saYCAAIk6oP//fpUAgACIU6D//4PSAAAQ6kAg//+iJYCAAJdrXP//ho8A//60ZiCAAog0AP//eOog
Date: Thu, 24 Jul 2025 07:59:59 +0000
Message-ID: <e34a045492ae454cb255aca78d2b9641@realtek.com>
References: <7407FAA3-F4A4-48AA-91E5-A78DA711447D@gmail.com>
 <ec5d762f3ee64a0188953a1aecbef2cc@realtek.com>
 <AFB036A4-80C6-4880-B798-FB22C7C137FA@gmail.com>
 <b29df36b838049a088d8298220078134@realtek.com>
 <5CA196F3-90B4-479F-9A19-E9C71C8726D4@gmail.com>
 <34d9c169c92540caa294095d2172b4fc@realtek.com>
 <18989932-3578-4E45-BA8B-6C2C76FDE7FE@gmail.com>
 <ed867462c8d945b28b2e913d1cd0c3d5@realtek.com>
 <7dfa0377-538f-464b-b4e4-4c9daa1fb85a@gmail.com>
 <5933c3ef71914cdf83687042488800d2@realtek.com>
 <699C22B4-A3E3-4206-97D0-22AB3348EBF6@gmail.com>
 <3a93f5580be34135a5b7f942d5b6ea44@realtek.com>
 <B89A3F05-FE7E-4AE8-8F75-34DBBC285C0E@gmail.com>
In-Reply-To: <B89A3F05-FE7E-4AE8-8F75-34DBBC285C0E@gmail.com>
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

UGlvdHIgT25pc3pjenVrIDxwaW90ci5vbmlzemN6dWtAZ21haWwuY29tPiB3cm90ZToNCj4gPiBX
aWFkb21vxZvEhyBuYXBpc2FuYSBwcnpleiBQaW5nLUtlIFNoaWggPHBrc2hpaEByZWFsdGVrLmNv
bT4gdyBkbml1IDI0IGxpcCAyMDI1LCBvIGdvZHouIDAyOjUyOg0KPiA+DQo+ID4gSSBzZW50IGEg
cGF0Y2ggWzFdIHdpdGggYSBjaGFuZ2UgdGhhdCBjaGVjayBSVFdfRkxBR19QT1dFUk9OIGZsYWcg
Zmlyc3QsDQo+ID4gc28gdGhpbmdzIHdpbGwgYmUgdGhlIHNhbWUgYXMgdGhpcyBmaW5hbCB0cnku
IFN0aWxsIHdhbnQgeW91IHRlc3QgdGhlIHBhdGNoDQo+ID4gYWdhaW4sIGFuZCBnaXZlIG1lIGEg
VGVzdGVkLWJ5IHRhZyB0aGVyZS4gVGhhbmtzLg0KPiA+DQo+ID4gWzFdIGh0dHBzOi8vbG9yZS5r
ZXJuZWwub3JnL2xpbnV4LXdpcmVsZXNzLzIwMjUwNzI0MDA0ODE1LjcwNDMtMS1wa3NoaWhAcmVh
bHRlay5jb20vVC8jdQ0KPiA+DQo+ID4NCj4gDQo+IEkgZ2l2ZSB0ZXN0IGFuZCB3aXRoIHRoaXMg
cGF0Y2ggaXNzdWUgZGlzYXBwZWFyLg0KPiB0aHggZm9yIGZpeGluZyB0aGlzIQ0KPiANCj4gcGxh
IGFkZA0KPiANCj4gVGVzdGVkLWJ5OiBQaW90ciBPbmlzemN6dWsgPHBpb3RyLm9uaXN6Y3p1a0Bn
bWFpbC5jb20gPG1haWx0bzpwaW90ci5vbmlzemN6dWtAZ21haWwuY29tPj4NCg0KQ291bGQgeW91
IHBsZWFzZSBhZGQgdGhpcyB0YWcgdG8gdGhlIHBhdGNoPyBUaGVuLCB5b3VyIFRlc3RlZC1ieSB3
aWxsIGJlIGFkZGVkDQppbnRvIGNvbW1pdCBtZXNzYWdlIGR1cmluZyBnZXR0aW5nIG1lcmdlZC4g
DQoNCg==

