Return-Path: <linux-wireless+bounces-8170-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7500A8D1687
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 10:43:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E8552B23A19
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 08:43:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5EEFD13C90A;
	Tue, 28 May 2024 08:42:40 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 647F513C83C
	for <linux-wireless@vger.kernel.org>; Tue, 28 May 2024 08:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716885760; cv=none; b=PFeSWs/XrfkHYneCBFQsQm/WmuE/ER63g7Zajqk0e7kgTvM0TK1jatqFYCyvRDkZ2YAqXp35TpK5I4h18ZGGeEiI1OKjZZYC3c9cYS2b4PwcsCMmTRUAPrFhYn2N/+SGSpecOxeV9cT9JxEdodudW+qBxhsksGMYOwhpyRBMfW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716885760; c=relaxed/simple;
	bh=O/+OOXfm71aKo1UfQZaNs7tyMcEKpHxUhpA02AcMTZA=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=g6/Uw8iKB2MTtRUZ5TE9ZAxC2sl06dDeXDRJ2x5m8h1YO6lvm2wwxeiry8xqqVZIaSCcY2PSC/yTTuwUk47B33+PCd8kqVbU9DPNlkRvQTM2VZcg2rl+tS4fXNM2esOdOSpFKb/oaE9RrIxYOEfYHgdQDl5K4LUBZHiMaZu8bj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44S8fqnU72203204, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44S8fqnU72203204
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 16:41:52 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 16:41:52 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 28 May 2024 16:41:52 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 28 May 2024 16:41:52 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Johannes Berg <johannes@sipsolutions.net>,
        Bitterblue Smith
	<rtl8821cerfe2@gmail.com>,
        Stefan Lippers-Hollmann <s.l-h@gmx.de>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "Larry
 Finger" <Larry.Finger@lwfinger.net>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v7 12/12] wifi: rtlwifi: Enable the new rtl8192du driver
Thread-Topic: [PATCH v7 12/12] wifi: rtlwifi: Enable the new rtl8192du driver
Thread-Index: AQHarSBdbyWf9lKLLkKgqAnWSxDd/bGquXUA//+V1QCAAOVVgIAAt3Qg///MnoCAAJyegA==
Date: Tue, 28 May 2024 08:41:52 +0000
Message-ID: <cedd13d7691f4692b2a2fa5a24d44a22@realtek.com>
References: <8805826b-60b9-4026-9509-7d92c3a43577@gmail.com>
	 <5f2da7ee-876a-42fc-8fec-ec5386fa8c26@gmail.com>
	 <0002749a3b584bc39fa18b3137153fdf@realtek.com>
	 <20240527112534.4dbcdf75@mir>
	 <29f850c5-4f61-466f-9a7a-437b05bc8251@gmail.com>
	 <ee442840754e4afba8388951f56c5e82@realtek.com>
 <edb8cf11187349003b2d61c8cc71e4bed28c31f2.camel@sipsolutions.net>
In-Reply-To: <edb8cf11187349003b2d61c8cc71e4bed28c31f2.camel@sipsolutions.net>
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

Sm9oYW5uZXMgQmVyZyA8am9oYW5uZXNAc2lwc29sdXRpb25zLm5ldD4gd3JvdGU6DQo+IE9uIFR1
ZSwgMjAyNC0wNS0yOCBhdCAwMjozOSArMDAwMCwgUGluZy1LZSBTaGloIHdyb3RlOg0KPiA+IE9u
ZSB0aGluZyBpcyB0aGF0IHNob3VsZCB3ZSBob25vciB0aGUgdmFsdWVzIHNldCBieSB1c2VyIHNw
YWNlPw0KPiA+DQo+ID4gSWYgdXNlciBzcGFjZSBoYXMgbm90IHNldCwgZHJpdmVyIHdhbnRzIHRv
IGNvbnRyb2wgdGhpcyB2YWx1ZSBieSBpdHNlbGYNCj4gPiBhY2NvcmRpbmcgdG8gQVAvSUJTUy9z
dGF0aW9uIG1vZGVzLg0KPiA+IElmIHVzZXIgc3BhY2UgaGFzIHNldCwgZHJpdmVyIGZ1bGx5IGZv
bGxvd3MgdGhlIHZhbHVlIGZyb20gdXNlciBzcGFjZS4NCj4gPiBJcyBhYm92ZSB0aGUgYmVoYXZp
b3IgeW91IHdhbnQ/DQo+IA0KPiBIb25lc3RseSwgaXMgaXQ/IEkgdGhpbmsgbW9zdCBkcml2ZXJz
IHRoZXNlIGRheXMgcHJvYmFibHkgaWdub3JlIHRoZQ0KPiB2YWx1ZXMgZnJvbSB1c2Vyc3BhY2Ug
Zm9yIGxlc3NlciByZWFzb25zIChlLmcuIGl3bHdpZmkgYWx3YXlzIGhhcyBhDQo+IGZpcm13YXJl
LWludGVybmFsIGxpbWl0IG9mIDE2IElJUkMuKQ0KPiANCj4gVGhpcyBBUEkgYWxzbyBjb21lcyBm
cm9tIHRoZSBkYXduIG9mIHdpcmVsZXNzIGluIExpbnV4LCBhbmQgd2FzIGp1c3QNCj4gcG9ydGVk
IGZyb20gd2lyZWxlc3MgZXh0ZW5zaW9ucyB0byBubDgwMjExLiBTbyBJIHdvdWxkbid0IGZlZWwg
dG9vIGJhZA0KPiBhYm91dCBzaW1wbHkgaWdub3JpbmcgaXQgZWl0aGVyLg0KDQpBZ3JlZS4gTXkg
dGhvdWdodCB3YXMgbGltaXRlZCB0byBoYXZlIHRoZSBzYW1lIGJlaGF2aW9yIGFzIHJ0bHdpZmkg
d2FzLg0KSWdub3JpbmcgaGFuZGxlIG9mIElFRUU4MDIxMV9DT05GX0NIQU5HRV9SRVRSWV9MSU1J
VFMgd291bGQgYmUgc2ltcGxlci4NCg0KUGluZy1LZQ0KDQo=

