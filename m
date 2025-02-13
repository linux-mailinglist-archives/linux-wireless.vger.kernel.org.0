Return-Path: <linux-wireless+bounces-18867-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A6680A33414
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 01:38:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B31FB188AAE1
	for <lists+linux-wireless@lfdr.de>; Thu, 13 Feb 2025 00:38:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C350C4D8CB;
	Thu, 13 Feb 2025 00:38:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="PPmZ3Tu+"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A7893232;
	Thu, 13 Feb 2025 00:38:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739407105; cv=none; b=dvfmJN1zD7Zm/o0lbfBBLmQ+Vl3KwzrOkFmofaCUpeVO7pn/8XVUtx3rccEJdBRynG/mkvy1i9jcFgc40pRvvZt13zPUGLBzwqHQtLimGYBSP/hOCOroce3RzMhlZWUDh/27AEw2KynJYAmO7xs9LOHv8rfEVAiLmJkgi5pf6M0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739407105; c=relaxed/simple;
	bh=nz51pfjanhMKGfWKbWXPQINCFlVbW+n//ggERPmdI38=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=sRm5FRwm0m/4fHxa7DqltlFSYAPRBSJezzo5g0KjosFlnnx0t1QvdWsce0UFkEVZXCFf+JNHnXTjHlrzhJPwI/d+bCvQIGImWyvlYD5C0vfWKPc13HDhnSmpFv9n8kzmBoZ80WUaN5LW+9HbZDpuXTxEGPNoTaXCDhT8z9VRq74=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=PPmZ3Tu+; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 51D0bMCl9028317, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1739407042; bh=nz51pfjanhMKGfWKbWXPQINCFlVbW+n//ggERPmdI38=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=PPmZ3Tu+FgUwBST1CmnIcES5KjtwQLr10WiT+7Wo65iwlHA2gt5G9FqgkF/tSV4yg
	 jpfTduTzQzTCwRBT132zuzEra5ka3IiZwFiuSU2//TC7fQ8gwNJew8oVNbmhz1VL0U
	 Zgz2uv6kdJH8p6ft1nxB7YfArwMHFCn2U8u3N3BYGpt66kF5Bzz9GM3+B+JMy5PwdY
	 kjuUAwC7ivwiMom4nPhGTIVPajZNlQogxm7EnruIZ/VsPBvqxPGPLrjgP3zQJVidXW
	 mpYG1jMS7ajvdNks8Yl+K6gb4+A0zlKbMqUiwPhnDCGTr+b28rnNmAMyPgb7cPtwU7
	 oP41QbD12pLlg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 51D0bMCl9028317
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 13 Feb 2025 08:37:22 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 13 Feb 2025 08:37:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 13 Feb 2025 08:37:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553]) by
 RTEXMBS04.realtek.com.tw ([fe80::48ab:b54f:96a1:6553%5]) with mapi id
 15.01.2507.035; Thu, 13 Feb 2025 08:37:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Jeff Johnson <jeff.johnson@oss.qualcomm.com>,
        Ethan Carter Edwards
	<ethan@ethancedwards.com>
CC: Kalle Valo <kvalo@kernel.org>,
        Karthikeyan Periyasamy
	<quic_periyasa@quicinc.com>,
        Jeff Johnson <jjohnson@kernel.org>,
        "Harshitha
 Prem" <quic_hprem@quicinc.com>,
        Kalle Valo <quic_kvalo@quicinc.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>,
        "ath12k@lists.infradead.org" <ath12k@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>
Subject: RE: [PATCH] wifi: ath12k: Fix uninitialized variable and remove goto
Thread-Topic: [PATCH] wifi: ath12k: Fix uninitialized variable and remove goto
Thread-Index: AQHbe3V4G+SZHcbSkEu0HsYEXOLAqrNAxeaAgAAWcwCAAJ8zYIAB6BUAgAEDV0A=
Date: Thu, 13 Feb 2025 00:37:21 +0000
Message-ID: <90be74caf7b94c5ea08553fc9880a424@realtek.com>
References: <20250209-ath12k-uninit-v1-1-afc8005847be@ethancedwards.com>
 <a7ca4e4b-c432-4f2b-81c6-c7b06cd12de1@oss.qualcomm.com>
 <mmutvwbsr3h33hxr364zr6f3whmyxp73od3fihsbynek2pkvjd@6bqaqfkwkf4m>
 <94ddba7eff9f4261bf8fa547f1ba4d7d@realtek.com>
 <f7f9d508-e999-4e5c-b02f-976e7cb700f3@oss.qualcomm.com>
In-Reply-To: <f7f9d508-e999-4e5c-b02f-976e7cb700f3@oss.qualcomm.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS02.realtek.com.tw, 9
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

SmVmZiBKb2huc29uIDxqZWZmLmpvaG5zb25Ab3NzLnF1YWxjb21tLmNvbT4gd3JvdGU6DQo+IE9u
IDIvMTAvMjAyNSA4OjA5IFBNLCBQaW5nLUtlIFNoaWggd3JvdGU6DQo+ID4+Pj4NCj4gPj4+PiBB
ZGRyZXNzZXMtQ292ZXJpdHktSUQ6IDE2NDIzMzcgKCJVbmluaXRpYWxpemVkIHNjYWxhciB2YXJp
YWJsZSIpDQo+ID4+Pg0KPiA+Pj4gSXMgdGhhdCBhbiBvZmZpY2lhbCBrZXJuZWwgdGFnPyBJTU8g
dGhlIHByb3BlciB0YWcgd291bGQgYmUNCj4gPj4gU28sIGl0IGlzbid0ICJvZmZpY2lhbCIgYXMg
ZmFyIGFzIEkgY2FuIHRlbGwsIGJ1dCBpdCBpcyB3aWRlbHkgdXNlZCBpbg0KPiA+PiBvdGhlciBj
b21taXRzLCBlc3BlY2lhbGx5IGJ5IEd1c3Rhdm8gU2lsdmEuDQo+ID4+DQo+ID4+IEFsc286DQo+
ID4+DQo+IGh0dHBzOi8vZ2l0Lmtlcm5lbC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L25l
eHQvbGludXgtbmV4dC5naXQvY29tbWl0Lz9pZD03NzhlMjQ3OGQxOTU3NDUwODg2MWJjYg0KPiA+
PiAxODA2ZDZlMzRkMDk1NTg3Yw0KPiA+Pg0KPiA+PiBDb3Zlcml0eS1JRHM6IGlzIGFub3RoZXIg
b3B0aW9uIEkgaGF2ZSBmb3VuZC4gSSBoYXZlIHNlZW4gQ2xvc2VzOiBhIGZldw0KPiA+PiB0aW1l
cyBhcyB3ZWxsLiBJJ20gbm90IHJlYWxseSBzdXJlIHdoYXQgdGhlIGJlc3Qgb3B0aW9uIGlzLCBo
b25lc3RseS4NCj4gPg0KPiA+IEluIG15IHBhdGNoLCBJIHVzZWQgYW5kIHRyZWF0ZWQgQWRkcmVz
c2VzLUNvdmVyaXR5LUlEIGFzIGEgdW5vZmZpY2lhbCB0YWcsDQo+ID4gc28gYWRkaXRpb25hbCBl
bXB0eSBsaW5lIGlzIGFkZGVkLg0KPiA+DQo+ID4gRGF5cyBhZ28gSSBoYXZlIHJlY2VpdmVkIENv
dmVyaXR5IGlzc3VlcyBzZW50IHRvIG1haWxpbmcgbGlzdCwgc28gSSB1c2VkDQo+ID4gQ2xvc2Vz
IHRhZyBhdCB0aGF0IHRpbWUuIEJ1dCByZWNlbnRseSBJIGhhdmUgbm90IHNlZW4gdGhhdCBraW5k
IG9mIG1haWxzLg0KPiA+IEluc3RlYWQsIEkgdmlzaXQgQ292ZXJpdHkgd2ViIHNpdGUgdG8gY2hl
Y2sgaXNzdWVzIGFuZCB1c2UNCj4gPiBBZGRyZXNzZXMtQ292ZXJpdHktSUQgdGFnLCBzaW5jZSBD
b3Zlcml0eSBsaW5rIGlzIG5vdCB2aXNpYmxlIHRvIGV2ZXJ5b25lLg0KPiA+IFRoYXQgaXMganVz
dCBteSB0aG91Z2h0Lg0KPiANCj4gVGhlIHByb2JsZW0gSSBoYXZlIGlzIHRoYXQgSSBnZXQgQ292
ZXJpdHkgZml4ZXMgYm90aCBmcm9tIHRoZSBsaW51eCBhbmQgdGhlDQo+IGxpbnV4LW5leHQgcHJv
amVjdHM6DQo+IA0KPiBodHRwczovL3NjYW4uY292ZXJpdHkuY29tL3Byb2plY3RzL2xpbnV4P3Rh
Yj1vdmVydmlldw0KPiBodHRwczovL3NjYW4uY292ZXJpdHkuY29tL3Byb2plY3RzL2xpbnV4LW5l
eHQtd2Vla2x5LXNjYW4/dGFiPW92ZXJ2aWV3DQo+IA0KPiBUaGUgQ292ZXJpdHkgSURzIGZyb20g
dGhlc2UgcHJvamVjdHMgYXJlIGFsbG9jYXRlZCBpbmRlcGVuZGVudGx5LCBzbyBhDQo+IENvdmVy
aXR5IElEIGRvZXMgbm90IHVuaXF1ZWx5IGlkZW50aWZ5IGFuIGlzc3VlLg0KPiANCj4gVGhlIFVS
TCB1bmlxdWVseSBpZGVudGlmaWVzIGFuIGlzc3VlLCBhbmQgYWxzbyB1dGlsaXplcyBhbiBvZmZp
Y2lhbCB0YWcuDQo+IA0KPiBUaGF0IGlzIG15IHRob3VnaHQuDQoNClllcywgSSBoYXZlIHRoZSBz
YW1lIHByb2JsZW0gYXMgeW91cnMuIEZvciBtZSwgSSBvbmx5IGFubm90YXRlIENvdmVyaXR5DQpJ
RHMgZnJvbSBsaW51eCBwcm9qZWN0LCBhbmQgdGhlIGxpbnV4LW5leHQgcHJvamVjdCBpcyBhcyBh
IHJlZmVyZW5jZQ0KdG8gY2hlY2sgaWYgaXNzdWVzIGFyZSBzdGlsbCBleGlzdGluZyBpbiAtbmV4
dCB0cmVlLg0KDQoNCg==

