Return-Path: <linux-wireless+bounces-12994-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C0E8D97C253
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 02:21:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 6CC741F21368
	for <lists+linux-wireless@lfdr.de>; Thu, 19 Sep 2024 00:21:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 42E393C2F;
	Thu, 19 Sep 2024 00:21:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="gAPO72jZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06C214C6D;
	Thu, 19 Sep 2024 00:21:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726705303; cv=none; b=i9yJ1senkj4ztS/INxoY+hBoV412tR5dJVe8KdqdvhCChQ818kl3CU/nC8pvlsRxMO9q7sGi8vPfxpt4HnwcpR9sDbUokUrmuoogJbtnT7LJPvNc6fldN9aXJ3OQOgp2WmmasmXreo+O7g/R0UWxnPyGb4yjieVJ7/FQTuIu4Kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726705303; c=relaxed/simple;
	bh=vAzsZy/aeWmSds6WWiyXTHlHBVDsJdZPcWK8gvCwvaM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=U+vL9/8gaTtGmjCXGHTQht4zTHNaLvwt8vWuR1hBfrPp+wq18vUXg4KTlQgZ2s/72nFuSc+X7cfScFUwCecAPMuq4UFzWhzdh0Ai5QNnLAmrxrpi0PM9q4Ft22naB2r0Mf0hwSNTwAMLFflPoCO+uqg2pjtw61IC6KMKcvh2w9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=gAPO72jZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48J0LWXe82907218, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1726705292; bh=vAzsZy/aeWmSds6WWiyXTHlHBVDsJdZPcWK8gvCwvaM=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=gAPO72jZy/Ch4fP2O6DXQjHQNNl8MH4MPkcNP1R767oe0fX4tvxqcLOVyAs/fe0Jo
	 2cXA+8lWbvg+3lt6kcsreuMZUIvBHyp039LFo7kk7w8ygmDq2aVJ2hoWUGDpkpZ12e
	 5JC20HnFqbu7aQ/oUgXtiSHqT9OieSD0BeUEl0lGZ3Uzw9OabD0xldDw4UYo+w6Ew7
	 HkzRnR9Es7VnTZye6n4j7Cb3l4N1sK4JBf5lPp3p1Go1C9hWQEudBfsZVKlSJ+l0vt
	 6jJSxVa5yQ+6cxw2w1ulcXckFmwhxD23W9qztc15yIIGK6iFZBQMeTR2N5NPZmOZYx
	 f1pe/VYsF6dvg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48J0LWXe82907218
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 19 Sep 2024 08:21:32 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 19 Sep 2024 08:21:33 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 19 Sep 2024 08:21:32 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Thu, 19 Sep 2024 08:21:32 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: =?utf-8?B?TWFyY2VsIFdlacOfZW5iYWNo?= <mweissenbach@ignaz.org>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
CC: "regressions@lists.linux.dev" <regressions@lists.linux.dev>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: RTL8852BE wifi no longer working after 6.11 upgrade
Thread-Topic: RTL8852BE wifi no longer working after 6.11 upgrade
Thread-Index: AQHbCMemb6H6HxFviUGmiPt2/8qxPLJdDI+A//+Vo4CAAJ3wIP//qTkAgAFYScA=
Date: Thu, 19 Sep 2024 00:21:32 +0000
Message-ID: <72a320c056364e98b2fa338766fc11f2@realtek.com>
References: <63a3ef5acd70454e9f8db114204e2e2d@realtek.com>
 <20240918114718.Horde.TpiB1MVH0uadLCQXUbR5WtB@ignaz.org>
In-Reply-To: <20240918114718.Horde.TpiB1MVH0uadLCQXUbR5WtB@ignaz.org>
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

TWFyY2VsIFdlacOfZW5iYWNoIDxtd2Vpc3NlbmJhY2hAaWduYXoub3JnPiB3cm90ZToNCj4gRmly
c3Qgb2YgYWxsLCB0aGFuayB5b3Ugc28gbXVjaCBmb3IgeW91ciB0aW1lIGFuZCB3b3JrIQ0KPiAN
Cj4gSSBob3BlIGkgZG9uJ3QgY2F1c2UgYW55IGNvbmZ1c2lvbiBhbmQgdGhpcyBxdWVzdGlvbiBt
YXkgYmUgYmFzZWQgb24gbXkgbGFjayBvZiAgdW5kZXJzdGFuZGluZyB0aGUgcGF0Y2gsDQo+IGkg
YWxtb3N0IGRvbid0IGRhcmUgdG8gYXNrLCBidXQgZG9lcyB0aGlzIHF1aXJrIG9ubHkgZ2V0cyBp
bnRvIGFmZmVjdCwgd2hlbiBzb21lb25lIHVzZXMgdGhlIHNhbWUgbWFpbmJvYXJkDQo+IGkgdXNl
PyBJcyB0aGlzIGFuIHJhdGhlciByYXJlIGNhc2UgdGhhdCBwcm9iYWJseSB3b24ndCBlZmZlY3Qg
b3RoZXIgcGVvcGxlPw0KPiANCj4gSSBjYW4ndCBqdWRnZSB0aGF0IHNvIHBsZWFzZSBkb24ndCBn
ZXQgbWUgd3JvbmcsIGJ1dCBpIGZlZWwgYSBiaXQgdW5lYXN5IGFib3V0IHRoaXMuIEkgYXNzdW1l
IHRoYXQgbW9zdA0KPiBmaXN0IHRpbWUgTGludXggdXNlcnMgdGhhdCBoYXZlIHNpbWlsYXIgKGJ1
dCBub3QgdGhlIHNhbWUpIHBsYXRmb3JtLCB3aGVyZSB0aGlzIHF1aXJrIHdpbGwgbm90IGdldCBh
cHBsaWVkDQo+IGFuZCB0aGV5IGVuZCB1cCB3aXRoIG5vbi13b3JraW5nIHdpZmksIGp1c3Qgbm90
aWNlIHRoYXQgd2lmaSBkb2Vzbid0IHdvcmsgYW5kIGdpdmUgdXAgb24gTGludXggYW5kIHJlbWVt
YmVyDQo+IGl0IGFzICJNeSBXaWZpIGV2ZW4gZGlkbid0IHdvcmsgdGhlcmUiLg0KPiANCj4gQXMg
YSBsb25nIHRpbWUgR2VudG9vIHVzZXIsIGkgaGF2ZSB0aGUgY2FwYWJpbGl0eSB0byBidWlsZCBt
eSBvd24ga2VybmVsIGFuZCBwcm92aWRlIGZlZWRiYWNrIHRoYXQgY2FuIGhlbHANCj4gZml4IHRo
aXMgaXNzdWUsIGJ1dCBpIGFzc3VtZSBtb3N0IHVzZXJzIGRvbid0LiBJIHdvdWxkIGFzc3VtZSBh
biBVYnVudHUgdXNlcnMgd2lsbCBqdXN0IHJlbW92ZSB0aGUgVWJ1bnR1DQo+IHBhcnRpdGlvbiBh
bmQgY2FsbHMgaXQgYSBkYXkgY29udGludWluZyB1c2luZyBXaW5kb3dzLiBJIGFtIGEgYml0IHdv
cnJpZWQgYW5kIHdvbmRlciwgaWYgdGhlcmUgbWF5YmUgYSB3YXkNCj4gdG8gZml4IHRoYXQsIHRo
YXQgaXMgaW5kZXBlbmRlbnQgb24gbXkgc3BlY2lmaWMgaGFyZHdhcmUvbWFpbmJvYXJkLg0KPiAN
Cj4gT2YgY291cnNlLCBmZWVsIGZyZWUgdG8gY29ycmVjdCBtZSBpZiBpIGFtIGdldHRpbmcgc29t
ZXRoaW5nIHdyb25nIGhlcmUsIGltIG5laXRoZXIgYW4gS2VybmVsIG5vciBDIGV4cGVydA0KPiBh
bmQgdGhhbmsgeW91IGZvciB5b3VyIHRpbWUgYWdhaW4uDQo+IA0KDQpZb3UgYXJlIHJpZ2h0LiBJ
IHdhcyBub3QgYXdhcmUgb2YgdGhhdC4gSSB3aWxsIGRpc2N1c3MgcGVvcGxlIGludGVybmFsbHkg
YW5kIHJlY29uc2lkZXIgdGhlIHNvbHV0aW9uLiANCg0K

