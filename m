Return-Path: <linux-wireless+bounces-22887-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9CFC3AB4A1F
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 05:28:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 40CD919E58EC
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 03:28:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 24226153BF0;
	Tue, 13 May 2025 03:27:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="DtE8oONC"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA47EAF9
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 03:27:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747106878; cv=none; b=qI+5eptZql3z42fYV9L8Xbr+dT02TxwZ+HNveydIPsWP1OT7eoDRjpXlxKCcaQFwsGxGLtm5xWWzEPAIJ9zfUn6TNKsfE1JFejMKU3B9zYo4DTBMz/0Rt4LWgRbTpk87m7kDgqe6Csi2JgOqQKsGPJgzAOtoePRgIEE1bjFVoGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747106878; c=relaxed/simple;
	bh=+lNwQeThBD5DrVdKG9Kxgby9THDB/emrHAnWhGxE28w=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OGiytROKfIHzPBM0vDFybJmmgiBvcCBb71vDqVF8NC7CKrEjev6WsE7mEyxSRhxAC3WuvolYjCyn+ewbONZ6FhDEiLE/I3rwhggIBfJ5IkBAIoYi5uvroj6KJHoELAwnspu7wwSVN6Nt2lUacis8ehdWaAh+LbNSYesayMoolKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=DtE8oONC; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54D3Ro0qA3604980, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747106870; bh=+lNwQeThBD5DrVdKG9Kxgby9THDB/emrHAnWhGxE28w=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=DtE8oONCA1wHLbcOxwNyScv+1ZGTjo3TQid06mkV14ujBa76Rraxt2K7EQGppa4P2
	 AXy3KKK4QumeAuiX5iVAVVDc01XYdZVD3FHYBu2rPj+FhX8alvSQ2bkmmYhE/j0F1j
	 TMQ8iIxJfUGcEq01UYAyrUue4sqJzMpsN9SPXCgrz4WUzM09npbiBX55kBTCmVw7KV
	 prNg98BNsk47Fq34ZvMJnueYKjfgf2o243V/oSkXnDQTMYNq6syKqJtL9uSozSHIRm
	 XFvksQF6YXe5IHGjZU548EfdT+7xVfWEhIrGmslS7jWcVyKwqDdkzKSC6ZYAQ/rZo9
	 lheLvEzDG+Z6g==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54D3Ro0qA3604980
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 11:27:50 +0800
Received: from RTEXDAG01.realtek.com.tw (172.21.6.100) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 May 2025 11:27:51 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG01.realtek.com.tw (172.21.6.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 May 2025 11:27:50 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 13 May 2025 11:27:50 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v1 06/13] wifi: rtw89: Disable some power saving for USB
Thread-Topic: [PATCH rtw-next v1 06/13] wifi: rtw89: Disable some power saving
 for USB
Thread-Index: AQHbvTZTFcnEUmzdn0qPTEqBcRqq37PP8Fiw
Date: Tue, 13 May 2025 03:27:50 +0000
Message-ID: <8350f850345248b4bcef32204c944168@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <c64fe6a4-b48c-4a80-9d6c-5c90fb7f7bbd@gmail.com>
In-Reply-To: <c64fe6a4-b48c-4a80-9d6c-5c90fb7f7bbd@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBEaXNh
YmxlIHJ0dzg5X3BzX3Bvd2VyX21vZGVfY2hhbmdlKCkgYW5kIHJ0dzg5X21hY19zZW5kX3Jwd20o
KSBmb3INCj4gVVNCIGJlY2F1c2UgdGhleSBhcmUgY2FsbGVkIGluIGF0b21pYyBjb250ZXh0IGFu
ZCBhY2Nlc3NpbmcgaGFyZHdhcmUNCj4gcmVnaXN0ZXJzIHJlc3VsdHMgaW4gInNjaGVkdWxpbmcg
d2hpbGUgYXRvbWljIiBlcnJvcnMuDQoNCkkgZmVlbCBydHc4OV9wc19wb3dlcl9tb2RlX2NoYW5n
ZSgpIHNob3VsZCBiZSBub3QgaW4gYXRvbWljIGNvbnRleHQuDQpQbGVhc2UgY2hlY2sgdGhpcy4g
DQoNCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21pdGggPHJ0bDg4MjFjZXJmZTJA
Z21haWwuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkv
bWFjLmMgfCAzICsrKw0KPiAgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9wcy5j
ICB8IDMgKysrDQo+ICAyIGZpbGVzIGNoYW5nZWQsIDYgaW5zZXJ0aW9ucygrKQ0KPiANCj4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODkvbWFjLmMgYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L21hYy5jDQo+IGluZGV4IGEzMTY4NjRhZDEz
Ny4uMWEwMzM1NWIzNDBmIDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFs
dGVrL3J0dzg5L21hYy5jDQo+ICsrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3
ODkvbWFjLmMNCj4gQEAgLTEzMzgsNiArMTMzOCw5IEBAIHN0YXRpYyB2b2lkIHJ0dzg5X21hY19z
ZW5kX3Jwd20oc3RydWN0IHJ0dzg5X2RldiAqcnR3ZGV2LA0KPiAgew0KPiAgICAgICAgIHUxNiBy
ZXF1ZXN0Ow0KPiANCj4gKyAgICAgICBpZiAocnR3ZGV2LT5oY2kudHlwZSA9PSBSVFc4OV9IQ0lf
VFlQRV9VU0IpDQoNCkkgdGhpbmsgU0RJTyBkZXZpY2VzIGhhdmUgdGhlIHNhbWUgcHJvYmxlbXMg
YXMgVVNCLCBzbyBJIHByZWZlciB0byByZXR1cm4NCmlmICIhPSBQQ0lFIi4NCg0KPiArICAgICAg
ICAgICAgICAgcmV0dXJuOw0KPiArDQo+ICAgICAgICAgc3Bpbl9sb2NrX2JoKCZydHdkZXYtPnJw
d21fbG9jayk7DQo+IA0KPiAgICAgICAgIHJlcXVlc3QgPSBydHc4OV9yZWFkMTYocnR3ZGV2LCBS
X0FYX1JQV00pOw0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9y
dHc4OS9wcy5jIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OS9wcy5jDQo+IGlu
ZGV4IGFjNDZhN2JhYTAwZC4uZWRmZjlmOGUxMDE2IDEwMDY0NA0KPiAtLS0gYS9kcml2ZXJzL25l
dC93aXJlbGVzcy9yZWFsdGVrL3J0dzg5L3BzLmMNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydHc4OS9wcy5jDQo+IEBAIC01Niw2ICs1Niw5IEBAIHN0YXRpYyB2b2lkIHJ0
dzg5X3BzX3Bvd2VyX21vZGVfY2hhbmdlX3dpdGhfaGNpKHN0cnVjdCBydHc4OV9kZXYgKnJ0d2Rl
diwNCj4gDQo+ICBzdGF0aWMgdm9pZCBydHc4OV9wc19wb3dlcl9tb2RlX2NoYW5nZShzdHJ1Y3Qg
cnR3ODlfZGV2ICpydHdkZXYsIGJvb2wgZW50ZXIpDQo+ICB7DQo+ICsgICAgICAgaWYgKHJ0d2Rl
di0+aGNpLnR5cGUgPT0gUlRXODlfSENJX1RZUEVfVVNCKQ0KPiArICAgICAgICAgICAgICAgcmV0
dXJuOw0KPiArDQo+ICAgICAgICAgaWYgKHJ0d2Rldi0+Y2hpcC0+bG93X3Bvd2VyX2hjaV9tb2Rl
cyAmIEJJVChydHdkZXYtPnBzX21vZGUpICYmDQo+ICAgICAgICAgICAgICF0ZXN0X2JpdChSVFc4
OV9GTEFHX1dPV0xBTiwgcnR3ZGV2LT5mbGFncykpDQo+ICAgICAgICAgICAgICAgICBydHc4OV9w
c19wb3dlcl9tb2RlX2NoYW5nZV93aXRoX2hjaShydHdkZXYsIGVudGVyKTsNCj4gLS0NCj4gMi40
OS4wDQoNCg==

