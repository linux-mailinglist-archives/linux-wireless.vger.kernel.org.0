Return-Path: <linux-wireless+bounces-29011-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ams.mirrors.kernel.org (ams.mirrors.kernel.org [213.196.21.55])
	by mail.lfdr.de (Postfix) with ESMTPS id 3334EC61F84
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 01:54:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.mirrors.kernel.org (Postfix) with ESMTPS id 8C5BD3596F3
	for <lists+linux-wireless@lfdr.de>; Mon, 17 Nov 2025 00:53:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 57F5B1D63E4;
	Mon, 17 Nov 2025 00:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="YwxVh+8G"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C12BF1DE3DB;
	Mon, 17 Nov 2025 00:53:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763340811; cv=none; b=n9rISN3W1+Oy44VkM1ZuXse47j/iQAU3aAwmIGwtGNbv4Y1z/Ll7uRoV/R9lu88otIbYLTCVYmD6K06hiisZqMXQV12bb9LfpZX9KbZKtY2KUYUrQ8PIepaYToAhW+IH/kZKPBuhS+sNhRyS5MAYJc6b2Lto2EopV0Wtbs9F4Qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763340811; c=relaxed/simple;
	bh=VuUHLoiMPFk3ycvoJLhWVfUEo+kiwHAbm9DEofKveDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=uCpj2rMyvkMzBeD3oyZfQlR1jdkHN+/C3bEBHIm33fFqdIy0rQecEOj37RYb2jjrjultd/s882IlhfDME25fYaTHoMBFyxXguyAovFvEJypyw8fWu2rh1Vvl6cZaUipgx0apFfMrmq8Hm9WZZzb63XdDFt4WJClsVIn7UInM36I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=YwxVh+8G; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 5AH0qpDP32504206, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1763340771; bh=VuUHLoiMPFk3ycvoJLhWVfUEo+kiwHAbm9DEofKveDg=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=YwxVh+8G+Vx/qv/nQmo/lA+uka3TFCNKsxX8m0E37SYOosHbdsABUTaq7F5tUDMOg
	 XJwamWwbMtAWmef9D4f7GlxIA1D2gnojwpi1OdrObfapYnhWzM+YaPznElZq2bTCbC
	 1sdA4FUeWVaEhFC9I6B7krtQW7Q/XaCre1NyXHMxiHPgUgk63f14fdBDhxovAlt2Ui
	 klOjscGiskdGUbse65DDrQ8arrYZpeX3AOqcO7IdUnwOH/2UMz+U1uknYWcV0fxDet
	 UCQ3j/YIqhenaDcD+071OmeHZ3SaS6dehQBlTgK98AB79c7TmXU3wI+X/3GsaHd9wP
	 On7tPUgIazPbw==
Received: from mail.realtek.com (rtkexhmbs03.realtek.com.tw[10.21.1.53])
	by rtits2.realtek.com.tw (8.15.2/3.21/5.94) with ESMTPS id 5AH0qpDP32504206
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 17 Nov 2025 08:52:51 +0800
Received: from RTKEXHMBS01.realtek.com.tw (172.21.6.40) by
 RTKEXHMBS03.realtek.com.tw (10.21.1.53) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 17 Nov 2025 08:52:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw (10.21.1.56) by
 RTKEXHMBS01.realtek.com.tw (172.21.6.40) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.27; Mon, 17 Nov 2025 08:52:51 +0800
Received: from RTKEXHMBS06.realtek.com.tw ([::1]) by
 RTKEXHMBS06.realtek.com.tw ([fe80::744:4bc9:832c:9b7e%10]) with mapi id
 15.02.1544.027; Mon, 17 Nov 2025 08:52:51 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Marco Crivellari <marco.crivellari@suse.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Tejun Heo <tj@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
        Frederic Weisbecker <frederic@kernel.org>,
        Sebastian Andrzej Siewior
	<bigeasy@linutronix.de>,
        Michal Hocko <mhocko@suse.com>
Subject: RE: [PATCH 1/2] wifi: rtlwifi: add WQ_PERCPU to alloc_workqueue users
Thread-Topic: [PATCH 1/2] wifi: rtlwifi: add WQ_PERCPU to alloc_workqueue
 users
Thread-Index: AQHcVLg3fv6vNQNwBUaSMGB10wpgubT2DYLQ
Date: Mon, 17 Nov 2025 00:52:51 +0000
Message-ID: <e3b57536924b4573ac61de3f24af8a9f@realtek.com>
References: <20251113160605.381777-1-marco.crivellari@suse.com>
 <20251113160605.381777-2-marco.crivellari@suse.com>
In-Reply-To: <20251113160605.381777-2-marco.crivellari@suse.com>
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

TWFyY28gQ3JpdmVsbGFyaSA8bWFyY28uY3JpdmVsbGFyaUBzdXNlLmNvbT4gd3JvdGU6DQo+IEN1
cnJlbnRseSBpZiBhIHVzZXIgZW5xdWV1ZXMgYSB3b3JrIGl0ZW0gdXNpbmcgc2NoZWR1bGVfZGVs
YXllZF93b3JrKCkgdGhlDQo+IHVzZWQgd3EgaXMgInN5c3RlbV93cSIgKHBlci1jcHUgd3EpIHdo
aWxlIHF1ZXVlX2RlbGF5ZWRfd29yaygpIHVzZQ0KPiBXT1JLX0NQVV9VTkJPVU5EICh1c2VkIHdo
ZW4gYSBjcHUgaXMgbm90IHNwZWNpZmllZCkuIFRoZSBzYW1lIGFwcGxpZXMgdG8NCj4gc2NoZWR1
bGVfd29yaygpIHRoYXQgaXMgdXNpbmcgc3lzdGVtX3dxIGFuZCBxdWV1ZV93b3JrKCksIHRoYXQg
bWFrZXMgdXNlDQo+IGFnYWluIG9mIFdPUktfQ1BVX1VOQk9VTkQuDQo+IA0KPiBUaGlzIGxhY2sg
b2YgY29uc2lzdGVuY3kgY2Fubm90IGJlIGFkZHJlc3NlZCB3aXRob3V0IHJlZmFjdG9yaW5nIHRo
ZSBBUEkuDQo+IEZvciBtb3JlIGRldGFpbHMgc2VlIHRoZSBMaW5rIHRhZyBiZWxvdy4NCj4gDQo+
IGFsbG9jX3dvcmtxdWV1ZSgpIHRyZWF0cyBhbGwgcXVldWVzIGFzIHBlci1DUFUgYnkgZGVmYXVs
dCwgd2hpbGUgdW5ib3VuZA0KPiB3b3JrcXVldWVzIG11c3Qgb3B0LWluIHZpYSBXUV9VTkJPVU5E
Lg0KPiANCj4gVGhpcyBkZWZhdWx0IGlzIHN1Ym9wdGltYWw6IG1vc3Qgd29ya2xvYWRzIGJlbmVm
aXQgZnJvbSB1bmJvdW5kIHF1ZXVlcywNCj4gYWxsb3dpbmcgdGhlIHNjaGVkdWxlciB0byBwbGFj
ZSB3b3JrZXIgdGhyZWFkcyB3aGVyZSB0aGV54oCZcmUgbmVlZGVkIGFuZA0KPiByZWR1Y2luZyBu
b2lzZSB3aGVuIENQVXMgYXJlIGlzb2xhdGVkLg0KPiANCj4gVGhpcyBjb250aW51ZXMgdGhlIGVm
Zm9ydCB0byByZWZhY3RvciB3b3JrcXVldWUgQVBJcywgd2hpY2ggYmVnYW4gd2l0aA0KPiB0aGUg
aW50cm9kdWN0aW9uIG9mIG5ldyB3b3JrcXVldWVzIGFuZCBhIG5ldyBhbGxvY193b3JrcXVldWUg
ZmxhZyBpbjoNCj4gDQo+IGNvbW1pdCAxMjhlYTlmNmNjZmIgKCJ3b3JrcXVldWU6IEFkZCBzeXN0
ZW1fcGVyY3B1X3dxIGFuZCBzeXN0ZW1fZGZsX3dxIikNCj4gY29tbWl0IDkzMGMyZWE1NjZhZiAo
IndvcmtxdWV1ZTogQWRkIG5ldyBXUV9QRVJDUFUgZmxhZyIpDQo+IA0KPiBUaGlzIGNoYW5nZSBh
ZGRzIGEgbmV3IFdRX1BFUkNQVSBmbGFnIHRvIGV4cGxpY2l0bHkgcmVxdWVzdA0KPiBhbGxvY193
b3JrcXVldWUoKSB0byBiZSBwZXItY3B1IHdoZW4gV1FfVU5CT1VORCBoYXMgbm90IGJlZW4gc3Bl
Y2lmaWVkLg0KPiANCj4gV2l0aCB0aGUgaW50cm9kdWN0aW9uIG9mIHRoZSBXUV9QRVJDUFUgZmxh
ZyAoZXF1aXZhbGVudCB0byAhV1FfVU5CT1VORCksDQo+IGFueSBhbGxvY193b3JrcXVldWUoKSBj
YWxsZXIgdGhhdCBkb2VzbuKAmXQgZXhwbGljaXRseSBzcGVjaWZ5IFdRX1VOQk9VTkQNCj4gbXVz
dCBub3cgdXNlIFdRX1BFUkNQVS4NCj4gDQo+IE9uY2UgbWlncmF0aW9uIGlzIGNvbXBsZXRlLCBX
UV9VTkJPVU5EIGNhbiBiZSByZW1vdmVkIGFuZCB1bmJvdW5kIHdpbGwNCj4gYmVjb21lIHRoZSBp
bXBsaWNpdCBkZWZhdWx0Lg0KPiANCj4gU3VnZ2VzdGVkLWJ5OiBUZWp1biBIZW8gPHRqQGtlcm5l
bC5vcmc+DQo+IFNpZ25lZC1vZmYtYnk6IE1hcmNvIENyaXZlbGxhcmkgPG1hcmNvLmNyaXZlbGxh
cmlAc3VzZS5jb20+DQo+IExpbms6IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2FsbC8yMDI1MDIy
MTExMjAwMy4xZFN1b0d5Y0BsaW51dHJvbml4LmRlLw0KPiAtLS0NCj4gIGRyaXZlcnMvbmV0L3dp
cmVsZXNzL3JlYWx0ZWsvcnRsd2lmaS9iYXNlLmMgfCAyICstDQo+ICAxIGZpbGUgY2hhbmdlZCwg
MSBpbnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJz
L25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvYmFzZS5jIGIvZHJpdmVycy9uZXQvd2lyZWxl
c3MvcmVhbHRlay9ydGx3aWZpL2Jhc2UuYw0KPiBpbmRleCBlMjZmZWI4ZGU2NTguLjI3ODZlNGVl
NjdlYiAxMDA2NDQNCj4gLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydGx3aWZp
L2Jhc2UuYw0KPiArKysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0bHdpZmkvYmFz
ZS5jDQo+IEBAIC00NDUsNyArNDQ1LDcgQEAgc3RhdGljIGludCBfcnRsX2luaXRfZGVmZXJyZWRf
d29yayhzdHJ1Y3QgaWVlZTgwMjExX2h3ICpodykNCj4gICAgICAgICBzdHJ1Y3QgcnRsX3ByaXYg
KnJ0bHByaXYgPSBydGxfcHJpdihodyk7DQo+ICAgICAgICAgc3RydWN0IHdvcmtxdWV1ZV9zdHJ1
Y3QgKndxOw0KPiANCj4gLSAgICAgICB3cSA9IGFsbG9jX3dvcmtxdWV1ZSgiJXMiLCAwLCAwLCBy
dGxwcml2LT5jZmctPm5hbWUpOw0KPiArICAgICAgIHdxID0gYWxsb2Nfd29ya3F1ZXVlKCIlcyIs
IFdRX1BFUkNQVSwgMCwgcnRscHJpdi0+Y2ZnLT5uYW1lKTsNCg0KSSB0aGluayB0aGlzIGRyaXZl
ciBzaG91bGQgdXNlIFdRX1VOQk9VTkQgYXMgd2VsbCBhcyBhbm90aGVyIHBhdGNoIGluIHRoaXMN
CnBhdGNoc2V0LiANCg0KDQpJIGZlZWwgbW9zdCB1c2VyIHNjZW5hcmlvcyBzaG91bGQgYmUgV1Ff
VU5CT1VORC4gQ291bGQgeW91IHNoYXJlIHdoaWNoIGNhc2UNCnVzZXMgV1FfUEVSQ1BVPw0KDQoN
Cj4gICAgICAgICBpZiAoIXdxKQ0KPiAgICAgICAgICAgICAgICAgcmV0dXJuIC1FTk9NRU07DQo+
IA0KPiAtLQ0KPiAyLjUxLjENCg0K

