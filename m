Return-Path: <linux-wireless+bounces-8152-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D58E38D124D
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 04:51:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 8F4272847CE
	for <lists+linux-wireless@lfdr.de>; Tue, 28 May 2024 02:51:14 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 51528EADB;
	Tue, 28 May 2024 02:51:11 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E7B48825;
	Tue, 28 May 2024 02:51:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716864671; cv=none; b=CBPZ3erd2ms9qeUdwIekKqsW3Y0dVhwlSfONtx2GtjI2SHbAXhqulvYP3nkKVO2DgiPED0fP90239zAEFR6We4cpL+ak7NiQa5pOg1rgae34eH23orqymp+DAOi44742l5lMdOcAySZIwVt+4BwdSqdMAroQyf/ryv+nxE/xK0A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716864671; c=relaxed/simple;
	bh=IG4LlUQk3BqZutMRGuu6k4e439xf0BpYB3q39UfN75Q=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=fYs1KJzmvHPYH8HNew3RF0zJwT2qVgFx96GEcMXErrwQGPpIrI0Uq7hyx2c+vxy6KXlDjHRb5gkU/+fA+nuM7XVcyh5IwhYk/NHYNwNzojPufCwDt5jz5xLBckpfgRGe/LCzrZ+CcgqwssFNOnFJKyb8sdbVObw12P6OqyPIqRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 44S2ooVZ31869090, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 44S2ooVZ31869090
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 28 May 2024 10:50:50 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 28 May 2024 10:50:50 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 28 May 2024 10:50:50 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 28 May 2024 10:50:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>,
        "marcin.slusarz@gmail.com"
	<marcin.slusarz@gmail.com>
CC: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        =?utf-8?B?TWFyY2luIMWabHVzYXJ6?= <mslusarz@renau.com>,
        Larry Finger
	<Larry.Finger@lwfinger.net>,
        "linux-kernel@vger.kernel.org"
	<linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] wifi: rtw88: schedule rx work after everything is set up
Thread-Topic: [PATCH] wifi: rtw88: schedule rx work after everything is set up
Thread-Index: AQHasFekMjDEF5R7/k+0650S2/2b8bGrUuCQgACfb4A=
Date: Tue, 28 May 2024 02:50:50 +0000
Message-ID: <13e848c1544245e6aef4b89c3f38daf0@realtek.com>
References: <20240527170137.455671-1-marcin.slusarz@gmail.com>
 <87jzjf8990.fsf@kernel.org>
In-Reply-To: <87jzjf8990.fsf@kernel.org>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
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

S2FsbGUgVmFsbyA8a3ZhbG9Aa2VybmVsLm9yZz4gd3JvdGU6DQo+IG1hcmNpbi5zbHVzYXJ6QGdt
YWlsLmNvbSB3cml0ZXM6DQo+IA0KPiA+IEZyb206IE1hcmNpbiDFmmx1c2FyeiA8bXNsdXNhcnpA
cmVuYXUuY29tPg0KPiA+DQo+ID4gUmlnaHQgbm93IGl0J3MgcG9zc2libGUgdG8gaGl0IE5VTEwg
cG9pbnRlciBkZXJlZmVyZW5jZSBpbg0KPiA+IHJ0d19yeF9maWxsX3J4X3N0YXR1cyBvbiBodyBv
YmplY3QgYW5kL29yIGl0cyBmaWVsZHMgYmVjYXVzZQ0KPiA+IGluaXRpYWxpemF0aW9uIHJvdXRp
bmUgY2FuIHN0YXJ0IGdldHRpbmcgVVNCIHJlcGxpZXMgYmVmb3JlDQo+ID4gcnR3X2RldiBpcyBm
dWxseSBzZXR1cC4NCj4gPg0KPiA+IFRoZSBzdGFjayB0cmFjZSBsb29rcyBsaWtlIHRoaXM6DQo+
ID4NCj4gPiBydHdfcnhfZmlsbF9yeF9zdGF0dXMNCj4gPiBydHc4ODIxY19xdWVyeV9yeF9kZXNj
DQo+ID4gcnR3X3VzYl9yeF9oYW5kbGVyDQo+ID4gLi4uDQo+ID4gcXVldWVfd29yaw0KPiA+IHJ0
d191c2JfcmVhZF9wb3J0X2NvbXBsZXRlDQo+ID4gLi4uDQo+ID4gdXNiX3N1Ym1pdF91cmINCj4g
PiBydHdfdXNiX3J4X3Jlc3VibWl0DQo+ID4gcnR3X3VzYl9pbml0X3J4DQo+ID4gcnR3X3VzYl9w
cm9iZQ0KPiA+DQo+ID4gU28gd2hpbGUgd2UgZG8gdGhlIGFzeW5jIHN0dWZmIHJ0d191c2JfcHJv
YmUgY29udGludWVzIGFuZCBjYWxscw0KPiA+IHJ0d19yZWdpc3Rlcl9odywgd2hpY2ggZG9lcyBh
bGwga2luZHMgb2YgaW5pdGlhbGl6YXRpb24gKGUuZy4NCj4gPiB2aWEgaWVlZTgwMjExX3JlZ2lz
dGVyX2h3KSB0aGF0IHJ0d19yeF9maWxsX3J4X3N0YXR1cyByZWxpZXMgb24uDQo+ID4NCj4gPiBG
aXggdGhpcyBieSBtb3ZpbmcgdGhlIGZpcnN0IHVzYl9zdWJtaXRfdXJiIGFmdGVyIGV2ZXJ5dGhp
bmcNCj4gPiBpcyBzZXQgdXAuDQo+ID4NCj4gPiBGb3IgbWUsIHRoaXMgYnVnIG1hbmlmZXN0ZWQg
YXM6DQo+ID4gWyAgICA4Ljg5MzE3N10gcnR3Xzg4MjFjdSAxLTE6MS4yOiBiYW5kIHdyb25nLCBw
YWNrZXQgZHJvcHBlZA0KPiA+IFsgICAgOC45MTA5MDRdIHJ0d184ODIxY3UgMS0xOjEuMjogaHct
PmNvbmYuY2hhbmRlZi5jaGFuIE5VTEwgaW4gcnR3X3J4X2ZpbGxfcnhfc3RhdHVzDQo+ID4gYmVj
YXVzZSBJJ20gdXNpbmcgTGFycnkncyBiYWNrcG9ydCBvZiBydHc4OCBkcml2ZXIgd2l0aCB0aGUg
TlVMTA0KPiA+IGNoZWNrcyBpbiBydHdfcnhfZmlsbF9yeF9zdGF0dXMuDQo+ID4NCj4gPiBUaGlz
IHNob3VsZCBmaXg6DQo+ID4gaHR0cHM6Ly9tYXJjLmluZm8vP2w9bGludXgtd2lyZWxlc3MmbT0x
Njc5MDc2ODgzMTE5NDMmdz0yDQo+IA0KPiBQbGVhc2UgdXNlIHBlcm1hbGlua3MgZnJvbSBsb3Jl
Lmtlcm5lbC5vcmcsIG1hcmMgbGlua3MgZG9uJ3QgY29udGFpbiB0aGUNCj4gTWVzc2FnZS1JZCBh
bmQgYXJlIGhlbmNlIHVucmVsaWFibGUuDQo+IA0KDQpVc2UgdGFncyBiZWxvdzogDQoNClJlcG9y
dGVkLWJ5OiBUaW0gSyA8dHBrdWVzdGVyQGdtYWlsLmNvbT4NCkNsb3NlczogaHR0cHM6Ly9sb3Jl
Lmtlcm5lbC5vcmcvbGludXgtd2lyZWxlc3MvQ0Erc2hvV1E3UDQ5amhRYXNvZkRjVGRRaGl1YXJQ
VGpZRURhLS1OaVZWeDQ5NFdjdVF3QG1haWwuZ21haWwuY29tLw0KDQoNCg0K

