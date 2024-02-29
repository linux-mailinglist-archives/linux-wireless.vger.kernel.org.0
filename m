Return-Path: <linux-wireless+bounces-4228-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 16EDD86C104
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 07:42:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BF8241F21098
	for <lists+linux-wireless@lfdr.de>; Thu, 29 Feb 2024 06:42:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D58E446AC;
	Thu, 29 Feb 2024 06:41:21 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A41C5446AD;
	Thu, 29 Feb 2024 06:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709188881; cv=none; b=qP6jUAGCyYZuCxOqreevuXCwcdjPwRpYcHxt5UdO2Lhg0THAjG5t25KM2kH4VHMW8vKdotS7Ag4ol4G6IsyPTRbkPQ/rKnLywJEfNr0sDqPuCSiroKkEWdlgFE7X0yuur3HDQ3BGudC0o706jTC0oxCzH7ccw5yNti8I14Vk+Wc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709188881; c=relaxed/simple;
	bh=prKiSSjyhUGOagxC+vKA6DCu75QOgGg4v1JitF2fgN4=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=FeVuzRNBtxdLUNncVXlX2ig5RuOMy+p1OygKJy3O4nxKDAXQ8oWBu77eK5Sr2WsHH7QHA/jlMLkhksl/jgIjHvZgQVR6ZcYBYa+WrOBey2FChQGEUpJOjxyGR1xPlrnQp7ilprYK8CcgR/i/a8bvuo1yNth+x0ZGDL9/D0iwMgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 41T6efJsB1197851, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 41T6efJsB1197851
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 29 Feb 2024 14:40:42 +0800
Received: from RTEXMBS06.realtek.com.tw (172.21.6.99) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.32; Thu, 29 Feb 2024 14:40:41 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS06.realtek.com.tw (172.21.6.99) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 29 Feb 2024 14:40:40 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f]) by
 RTEXMBS04.realtek.com.tw ([fe80::c9b7:82a9:7e98:fa7f%7]) with mapi id
 15.01.2507.035; Thu, 29 Feb 2024 14:40:40 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Fiona Klute <fiona.klute@gmx.de>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "kvalo@kernel.org" <kvalo@kernel.org>,
        "ulf.hansson@linaro.org"
	<ulf.hansson@linaro.org>,
        "linux-mmc@vger.kernel.org"
	<linux-mmc@vger.kernel.org>,
        "pavel@ucw.cz" <pavel@ucw.cz>, "megi@xff.cz"
	<megi@xff.cz>
Subject: RE: [PATCH v2 0/9] rtw88: Add support for RTL8723CS/RTL8703B
Thread-Topic: [PATCH v2 0/9] rtw88: Add support for RTL8723CS/RTL8703B
Thread-Index: AQHaadiBpVQLHkii4E2ByhEDok10+bEg35uw
Date: Thu, 29 Feb 2024 06:40:40 +0000
Message-ID: <61980d74cdb24dd38a2f2e12c79125e2@realtek.com>
References: <20240227235507.781615-1-fiona.klute@gmx.de>
In-Reply-To: <20240227235507.781615-1-fiona.klute@gmx.de>
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
X-KSE-ServerInfo: RTEXH36505.realtek.com.tw, 9
X-KSE-AntiSpam-Interceptor-Info: fallback
X-KSE-Antivirus-Interceptor-Info: fallback
X-KSE-AntiSpam-Interceptor-Info: fallback

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogRmlvbmEgS2x1dGUgPGZp
b25hLmtsdXRlQGdteC5kZT4NCj4gU2VudDogV2VkbmVzZGF5LCBGZWJydWFyeSAyOCwgMjAyNCA3
OjU1IEFNDQo+IFRvOiBsaW51eC13aXJlbGVzc0B2Z2VyLmtlcm5lbC5vcmc7IFBpbmctS2UgU2hp
aCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KPiBDYzogRmlvbmEgS2x1dGUgPGZpb25hLmtsdXRlQGdt
eC5kZT47IGt2YWxvQGtlcm5lbC5vcmc7IHVsZi5oYW5zc29uQGxpbmFyby5vcmc7IGxpbnV4LW1t
Y0B2Z2VyLmtlcm5lbC5vcmc7DQo+IHBhdmVsQHVjdy5jejsgbWVnaUB4ZmYuY3oNCj4gU3ViamVj
dDogW1BBVENIIHYyIDAvOV0gcnR3ODg6IEFkZCBzdXBwb3J0IGZvciBSVEw4NzIzQ1MvUlRMODcw
M0INCj4gDQoNClsuLi5dDQoNCj4gDQo+IHYyOg0KPiAgICogUGFyc2UgUEhZIHN0YXR1cyB1c2lu
ZyBzdHJ1Y3QgaW5zdGVhZCBvZiBtYWNyb3MNCj4gICAqIFByZWZlciBNQUMgZnJvbSBFRlVTRSBp
ZiBhdmFpbGFibGUsIG1vdmUgcmV0cmlldmluZyBNQUMgZnJvbSBEVCB0bw0KPiAgICAgYSBzZXBh
cmF0ZSBmdW5jdGlvbg0KPiAgICogVGlkeSB1cCB3YWl0IGZvciBJUUsgdG8gYmUgZG9uZSwgcmVw
bGFjZSBtZGVsYXkgbG9vcCB3aXRoDQo+ICAgICByZWFkX3BvbGxfdGltZW91dA0KPiAgICogU2V0
IGR1YWwgYXV0aG9yIGZvciBydHc4OF84NzIzeA0KPiAgICogQWRkIG1pc3NpbmcgInN0YXRpYyIg
dG8gcnR3ODcyM3ggZnVuY3Rpb24gZGVjbGFyYXRpb25zLCBmaXhlcw0KPiAgICAgYnVpbGQgZmFp
bHVyZSB3aGVuIG5vdCBidWlsdCBhcyBhIG1vZHVsZQ0KPiAgICogVmFyaW91cyBzdHlsZSBmaXhl
cw0KDQpZb3UgaGF2ZSBzb21lIGNoYW5nZXMgYnkgdjIsIHNvIEkgdGhpbmsgeW91IGRvbid0IG5l
ZWQgdG8gdGFrZSBteSBhY2stYnkgZm9yDQp0aG9zZSBwYXRjaGVzLiBUaGVuLCBpdCB3aWxsIGJl
IGVhc2llciBmb3IgbWUgdG8gcmV2aWV3IHBhdGNoZXMgeW91IGhhdmUNCmNoYW5nZWQuIA0KDQpB
bnl3YXksIGNvdWxkIHlvdSBwb2ludCBvdXQgcGF0Y2hlcyBJIHNob3VsZCBwYXkgYXR0ZW50aW9u
PyBPciBJIHdpbGwgcmV2aWV3DQplbnRpcmUgcGF0Y2hzZXQgb25lLWJ5LW9uZS4gDQoNClBpbmct
S2UNCg0K

