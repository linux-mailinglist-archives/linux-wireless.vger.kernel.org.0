Return-Path: <linux-wireless+bounces-9995-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id E6DE3927FD6
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 03:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 8BAF11F231AA
	for <lists+linux-wireless@lfdr.de>; Fri,  5 Jul 2024 01:46:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F0AF79D3;
	Fri,  5 Jul 2024 01:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="OuohWKXA"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83AE97F;
	Fri,  5 Jul 2024 01:46:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720143974; cv=none; b=YLWGQdUENqQs2kwObl2WFMKKkZ69LmHXLT6LZvckG27G/oi48XkEjHKOqrMyZObBmyb4UWUywHHTBuYNDBPslaHeG76cR0kqfrJkCT+wjOJZq81mFj2XJc+/8lKJ0Fcn1KQ3pcmIJOSSWWoxPTHc7nCfLdCMzvfVHsd9PmqO98o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720143974; c=relaxed/simple;
	bh=ld8o8FaaAiwbAi0R3l/MkFRMfIc/UxNHZGvhFpzf54U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=LrayYYfFk/6zb3dGxkJa4kePSejLAWg7aqMjOKNG1n0tZj+794+AZj3fSYpLTxcUF1TXh/KYKPUq4PAVRZKJ9g291X38oBPccpyUAC7r5qIHZJkpIcbvOrdK5vHbJlsa4A2gPEu8s6z/7+bgfl8Fj3OHkwWUQmnVcZ8VFZ31ltY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=fail (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=OuohWKXA reason="key not found in DNS"; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 4651jmcP74086069, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1720143948; bh=ld8o8FaaAiwbAi0R3l/MkFRMfIc/UxNHZGvhFpzf54U=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-ID:Content-Transfer-Encoding:MIME-Version;
	b=OuohWKXAR0uR5LjRgJT7881DQ1V2B3MXscEoV0BJS5Xqc+CVeF2aqsJW9Y0+g7mE3
	 lue4ubZKxwaIjHrrwmh2HIwYnal5jUs7enjZwXkkUkOm55RuEDm+u5u5ZcFmjJ4fO7
	 BEerM75yZd5/KGlvVQcHeWgieCRhr32GvAfP1AeFgfxY9n9Jlp+wfHutCYyW+dlRLq
	 YhGuepifBdumwIYQGqRxDV0hVM0yDX8CUT0b6WlI3jc+cYDj4ti7B9QnhfxeqZOwLU
	 /2QOzK80PFxwyoG3RQIk/APn+gh8p5gZxPmnbpcoqge8xl+E083weXQ+GfQteFyh7O
	 X9ibwPELXtz4g==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 4651jmcP74086069
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 5 Jul 2024 09:45:48 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 5 Jul 2024 09:45:48 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 5 Jul 2024 09:45:47 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 5 Jul 2024 09:45:47 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "marcin.slusarz@gmail.com" <marcin.slusarz@gmail.com>
CC: "tpkuester@gmail.com" <tpkuester@gmail.com>,
        "kvalo@kernel.org"
	<kvalo@kernel.org>,
        "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mslusarz@renau.com" <mslusarz@renau.com>
Subject: Re: [PATCH] wifi: rtw88: schedule rx work after everything is set up
Thread-Topic: [PATCH] wifi: rtw88: schedule rx work after everything is set up
Thread-Index: AQHasFekMjDEF5R7/k+0650S2/2b8bGrUuCQgACfb4CAAAQJAIA7HOaA
Date: Fri, 5 Jul 2024 01:45:47 +0000
Message-ID: <96a46df7c4c49b2b033bc7cd8d5cad3306db8ca6.camel@realtek.com>
References: <13e848c1544245e6aef4b89c3f38daf0@realtek.com>
	 <20240528110246.477321-1-marcin.slusarz@gmail.com>
In-Reply-To: <20240528110246.477321-1-marcin.slusarz@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
user-agent: Evolution 3.36.1-2 
x-kse-serverinfo: RTEXMBS03.realtek.com.tw, 9
x-kse-antispam-interceptor-info: fallback
x-kse-antivirus-interceptor-info: fallback
Content-Type: text/plain; charset="utf-8"
Content-ID: <FB1B320DBC41034B9F67D7044D7B3289@realtek.com>
Content-Transfer-Encoding: base64
Precedence: bulk
X-Mailing-List: linux-wireless@vger.kernel.org
List-Id: <linux-wireless.vger.kernel.org>
List-Subscribe: <mailto:linux-wireless+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-wireless+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-KSE-AntiSpam-Interceptor-Info: fallback

T24gVHVlLCAyMDI0LTA1LTI4IGF0IDEzOjAyICswMjAwLCBNYXJjaW4gxZpsdXNhcnogd3JvdGU6
DQo+IA0KPiBGcm9tOiBNYXJjaW4gxZpsdXNhcnogPG1zbHVzYXJ6QHJlbmF1LmNvbT4NCj4gDQo+
IFJpZ2h0IG5vdyBpdCdzIHBvc3NpYmxlIHRvIGhpdCBOVUxMIHBvaW50ZXIgZGVyZWZlcmVuY2Ug
aW4NCj4gcnR3X3J4X2ZpbGxfcnhfc3RhdHVzIG9uIGh3IG9iamVjdCBhbmQvb3IgaXRzIGZpZWxk
cyBiZWNhdXNlDQo+IGluaXRpYWxpemF0aW9uIHJvdXRpbmUgY2FuIHN0YXJ0IGdldHRpbmcgVVNC
IHJlcGxpZXMgYmVmb3JlDQo+IHJ0d19kZXYgaXMgZnVsbHkgc2V0dXAuDQo+IA0KPiBUaGUgc3Rh
Y2sgdHJhY2UgbG9va3MgbGlrZSB0aGlzOg0KPiANCj4gcnR3X3J4X2ZpbGxfcnhfc3RhdHVzDQo+
IHJ0dzg4MjFjX3F1ZXJ5X3J4X2Rlc2MNCj4gcnR3X3VzYl9yeF9oYW5kbGVyDQo+IC4uLg0KPiBx
dWV1ZV93b3JrDQo+IHJ0d191c2JfcmVhZF9wb3J0X2NvbXBsZXRlDQo+IC4uLg0KPiB1c2Jfc3Vi
bWl0X3VyYg0KPiBydHdfdXNiX3J4X3Jlc3VibWl0DQo+IHJ0d191c2JfaW5pdF9yeA0KPiBydHdf
dXNiX3Byb2JlDQo+IA0KPiBTbyB3aGlsZSB3ZSBkbyB0aGUgYXN5bmMgc3R1ZmYgcnR3X3VzYl9w
cm9iZSBjb250aW51ZXMgYW5kIGNhbGxzDQo+IHJ0d19yZWdpc3Rlcl9odywgd2hpY2ggZG9lcyBh
bGwga2luZHMgb2YgaW5pdGlhbGl6YXRpb24gKGUuZy4NCj4gdmlhIGllZWU4MDIxMV9yZWdpc3Rl
cl9odykgdGhhdCBydHdfcnhfZmlsbF9yeF9zdGF0dXMgcmVsaWVzIG9uLg0KPiANCj4gRml4IHRo
aXMgYnkgbW92aW5nIHRoZSBmaXJzdCB1c2Jfc3VibWl0X3VyYiBhZnRlciBldmVyeXRoaW5nDQo+
IGlzIHNldCB1cC4NCj4gDQo+IEZvciBtZSwgdGhpcyBidWcgbWFuaWZlc3RlZCBhczoNCj4gWyAg
ICA4Ljg5MzE3N10gcnR3Xzg4MjFjdSAxLTE6MS4yOiBiYW5kIHdyb25nLCBwYWNrZXQgZHJvcHBl
ZA0KPiBbICAgIDguOTEwOTA0XSBydHdfODgyMWN1IDEtMToxLjI6IGh3LT5jb25mLmNoYW5kZWYu
Y2hhbiBOVUxMIGluIHJ0d19yeF9maWxsX3J4X3N0YXR1cw0KPiBiZWNhdXNlIEknbSB1c2luZyBM
YXJyeSdzIGJhY2twb3J0IG9mIHJ0dzg4IGRyaXZlciB3aXRoIHRoZSBOVUxMDQo+IGNoZWNrcyBp
biBydHdfcnhfZmlsbF9yeF9zdGF0dXMuDQo+IA0KPiBSZXBvcnRlZC1ieTogVGltIEsgPHRwa3Vl
c3RlckBnbWFpbC5jb20+DQo+IENsb3NlczogDQo+IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xp
bnV4LXdpcmVsZXNzL0NBK3Nob1dRN1A0OWpoUWFzb2ZEY1RkUWhpdWFyUFRqWUVEYS0tTmlWVng0
OTRXY3VRd0BtYWlsLmdtYWlsLmNvbS8NCg0KQ2hhbmdlIENsb3NlcyB0byBMaW5rIGR1cmluZyBj
b21taXR0aW5nIGJlY2F1c2Ugb2Ygbm8gQUNLIGZyb20gVGltLg0KDQo+IFNpZ25lZC1vZmYtYnk6
IE1hcmNpbiDFmmx1c2FyeiA8bXNsdXNhcnpAcmVuYXUuY29tPg0KPiBDYzogUGluZy1LZSBTaGlo
IDxwa3NoaWhAcmVhbHRlay5jb20+DQo+IENjOiBMYXJyeSBGaW5nZXIgPExhcnJ5LkZpbmdlckBs
d2Zpbmdlci5uZXQ+DQo+IENjOiBLYWxsZSBWYWxvIDxrdmFsb0BrZXJuZWwub3JnPg0KPiBDYzog
bGludXgtd2lyZWxlc3NAdmdlci5rZXJuZWwub3JnDQo+IENjOiBsaW51eC1rZXJuZWxAdmdlci5r
ZXJuZWwub3JnDQo+IA0KDQoxIHBhdGNoKGVzKSBhcHBsaWVkIHRvIHJ0dy1uZXh0IGJyYW5jaCBv
ZiBydHcuZ2l0LCB0aGFua3MuDQoNCmFkYzUzOTc4NGM5OCB3aWZpOiBydHc4ODogdXNiOiBzY2hl
ZHVsZSByeCB3b3JrIGFmdGVyIGV2ZXJ5dGhpbmcgaXMgc2V0IHVwDQoNCi0tLQ0KaHR0cHM6Ly9n
aXRodWIuY29tL3Brc2hpaC9ydHcuZ2l0DQoNCg==

