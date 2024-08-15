Return-Path: <linux-wireless+bounces-11471-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CF1E952A2C
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 09:53:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 067AD1F22C76
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 07:53:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B15F3B1AC;
	Thu, 15 Aug 2024 07:53:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="NEa+X0BQ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AA542BAE5
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 07:53:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708423; cv=none; b=auc2f0j+rFhcjpPNR2gdO3FbCLlLKiLSB2//XqW0sn2o9hFjWnGNeD1FHq1WmQ+ixKUmMto4iWUuR/wvZ4Oa8ddVfKOUh60F4fNKrXak+/6rmoo2f614uGOO+DgC0Zp2sJcnMFQk9cTwTLPxUEtvS3A3bGsSBYqJV0WVWDi6lKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708423; c=relaxed/simple;
	bh=u/7kvYnhWm1b0tDRZnu4HuypnSPYxPt1kiuVyuWW4qg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=RdiSeyYXjBnLcIAzwe4PwTZNufbB6n+A7XhmKc54xAvzLk3xlcAvAUBxkFAZF7yUNpJPNbhE77+fpa9BOWoL1VH2ih0hdJ7kXp+B3TTOTFS7I7GPdstZ1GrSvc5Gia8BX4NqNM5VVvS/qgcwz0PLneH5ax5egPbPvZ0xpHIztn0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=NEa+X0BQ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47F7raiH73754060, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723708416; bh=u/7kvYnhWm1b0tDRZnu4HuypnSPYxPt1kiuVyuWW4qg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=NEa+X0BQGaBsHPyxcZK/hlYYuUKuA3uo+NAfaiYYeWgPgfxpQCi2qLvq7UJdXiKQv
	 TvzVRx3Iqb3wO1yd6eOA/m1fbx37/ytN3BWcExkEG2o0jUT8jGCPGkYP7QfMr/wXHf
	 qTjLYzyPQbaQBG/kSGA+5BglfxQANADrR6ZkPiGA6kOhFPvMWDXLMkgTF1DEIqP1by
	 MZm9ZVgEccGlgkjTjrl7KP5URCB0MAgZA7brJUAOswWGxw9Re5QP4yU4Rv403thRpJ
	 tgxGUOlsRuP3oPmqHYyd1ARueaGibOJopTM1MvSTCErJ9tgHsav/6xZXZHnzALHF79
	 Syup67Xits4bw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47F7raiH73754060
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 15:53:36 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 15:53:36 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Aug 2024 15:53:36 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0]) by
 RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0%5]) with mapi id
 15.01.2507.035; Thu, 15 Aug 2024 15:53:36 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 16/20] wifi: rtw88: Add rtw8812a_table.{c,h}
Thread-Topic: [PATCH 16/20] wifi: rtw88: Add rtw8812a_table.{c,h}
Thread-Index: AQHa7DJLjT3E6wqwR0qhx7joU+N4ObIn9yAQ
Date: Thu, 15 Aug 2024 07:53:36 +0000
Message-ID: <6499c9c2c6db41e9ba8c26c880ea42b4@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <e1ee4325-0878-46d5-bd51-8c994fa104a9@gmail.com>
In-Reply-To: <e1ee4325-0878-46d5-bd51-8c994fa104a9@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGVz
ZSBjb250YWluIHZhcmlvdXMgYXJyYXlzIGZvciBpbml0aWFsaXNpbmcgUlRMODgxMkFVLiBBbHNv
IFRYIHBvd2VyDQo+IGxpbWl0cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21p
dGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiAtLS0NCj4gIC4uLi93aXJlbGVzcy9yZWFs
dGVrL3J0dzg4L3J0dzg4MTJhX3RhYmxlLmMgICB8IDI4MTIgKysrKysrKysrKysrKysrKysNCj4g
IC4uLi93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4MTJhX3RhYmxlLmggICB8ICAgMjYgKw0K
PiAgMiBmaWxlcyBjaGFuZ2VkLCAyODM4IGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4MTJhX3RhYmxlLmMN
Cj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4
L3J0dzg4MTJhX3RhYmxlLmgNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0dzg4L3J0dzg4MTJhX3RhYmxlLmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0dzg4L3J0dzg4MTJhX3RhYmxlLmMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4gaW5kZXggMDAwMDAwMDAwMDAwLi4wZDAwNWQ4OGIwYTQNCj4gLS0tIC9kZXYvbnVsbA0KPiAr
KysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4MTJhX3RhYmxlLmMN
Cj4gQEAgLTAsMCArMSwyODEyIEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMCBPUiBCU0QtMy1DbGF1c2UNCj4gKy8qIENvcHlyaWdodChjKSAyMDE4LTIwMTkgIFJlYWx0
ZWsgQ29ycG9yYXRpb24NCg0KeWVhciAyMDI0DQoNClsuLi5dDQoNCj4gKw0KPiArY29uc3Qgc3Ry
dWN0IHJ0d19wd3Jfc2VxX2NtZCAqY2FyZF9lbmFibGVfZmxvd184ODEyYVtdID0gew0KPiArICAg
ICAgIHRyYW5zX2NhcmRkaXNfdG9fY2FyZGVtdV84ODEyYSwNCj4gKyAgICAgICB0cmFuc19jYXJk
ZW11X3RvX2FjdF84ODEyYSwNCj4gKyAgICAgICBOVUxMDQo+ICt9Ow0KPiArDQo+ICtjb25zdCBz
dHJ1Y3QgcnR3X3B3cl9zZXFfY21kICplbnRlcl9scHNfZmxvd184ODEyYVtdID0gew0KPiArICAg
ICAgIHRyYW5zX2FjdF90b19scHNfODgxMmEsDQo+ICsgICAgICAgTlVMTA0KPiArfTsNCj4gKw0K
PiArY29uc3Qgc3RydWN0IHJ0d19wd3Jfc2VxX2NtZCAqY2FyZF9kaXNhYmxlX2Zsb3dfODgxMmFb
XSA9IHsNCj4gKyAgICAgICB0cmFuc19hY3RfdG9fY2FyZGVtdV84ODEyYSwNCj4gKyAgICAgICB0
cmFuc19jYXJkZW11X3RvX2NhcmRkaXNfODgxMmEsDQo+ICsgICAgICAgTlVMTA0KPiArfTsNCj4g
Kw0KDQpUaGVzZSB0aHJlZSBhcnJheSBzaG91bGQgYmUgJ2NvbnN0IHN0cnVjdCBydHdfcHdyX3Nl
cV9jbWQgKiBjb25zdCAuLi4nLg0KDQpJIGRvbid0IGV4cGVjdCB0aGluZ3MgaW4gIi5kYXRhIiBz
ZWN0aW9uLg0KDQokIG9iamR1bXAgIC10IHJ0dzg4MTJhX3RhYmxlLm8gfCBncmVwICJcLmRhdGEi
DQowMDAwMDAwMDAwMDAwMDAwIGcgICAgIE8gLmRhdGEgIDAwMDAwMDAwMDAwMDAwMTggY2FyZF9k
aXNhYmxlX2Zsb3dfODgxMmENCjAwMDAwMDAwMDAwMDAwMjAgZyAgICAgTyAuZGF0YSAgMDAwMDAw
MDAwMDAwMDAxMCBlbnRlcl9scHNfZmxvd184ODEyYQ0KMDAwMDAwMDAwMDAwMDAzMCBnICAgICBP
IC5kYXRhICAwMDAwMDAwMDAwMDAwMDE4IGNhcmRfZW5hYmxlX2Zsb3dfODgxMmENCg0KDQpbLi4u
XQ0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0
dzg4MTJhX3RhYmxlLmgNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0
dzg4MTJhX3RhYmxlLmgNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXggMDAwMDAwMDAw
MDAwLi4xNWVjYzcyYjE3NWENCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9kcml2ZXJzL25ldC93
aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4MTJhX3RhYmxlLmgNCj4gQEAgLTAsMCArMSwyNiBA
QA0KPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgT1IgQlNELTMtQ2xhdXNl
ICovDQo+ICsvKiBDb3B5cmlnaHQoYykgMjAxOC0yMDE5ICBSZWFsdGVrIENvcnBvcmF0aW9uDQoN
CnllYXIgMjAyNA0KDQo+ICsgKi8NCj4gKw0KPiArI2lmbmRlZiBfX1JUVzg4MTJBX1RBQkxFX0hf
Xw0KPiArI2RlZmluZSBfX1JUVzg4MTJBX1RBQkxFX0hfXw0KPiArDQo+ICtleHRlcm4gY29uc3Qg
c3RydWN0IHJ0d190YWJsZSBydHc4ODEyYV9tYWNfdGJsOw0KPiArZXh0ZXJuIGNvbnN0IHN0cnVj
dCBydHdfdGFibGUgcnR3ODgxMmFfYWdjX3RibDsNCj4gK2V4dGVybiBjb25zdCBzdHJ1Y3QgcnR3
X3RhYmxlIHJ0dzg4MTJhX2FnY19kaWZmX2xiX3RibDsNCj4gK2V4dGVybiBjb25zdCBzdHJ1Y3Qg
cnR3X3RhYmxlIHJ0dzg4MTJhX2FnY19kaWZmX2hiX3RibDsNCj4gK2V4dGVybiBjb25zdCBzdHJ1
Y3QgcnR3X3RhYmxlIHJ0dzg4MTJhX2JiX3RibDsNCj4gK2V4dGVybiBjb25zdCBzdHJ1Y3QgcnR3
X3RhYmxlIHJ0dzg4MTJhX2JiX3BnX3RibDsNCj4gK2V4dGVybiBjb25zdCBzdHJ1Y3QgcnR3X3Rh
YmxlIHJ0dzg4MTJhX2JiX3BnX3JmZTNfdGJsOw0KPiArZXh0ZXJuIGNvbnN0IHN0cnVjdCBydHdf
dGFibGUgcnR3ODgxMmFfcmZfYV90Ymw7DQo+ICtleHRlcm4gY29uc3Qgc3RydWN0IHJ0d190YWJs
ZSBydHc4ODEyYV9yZl9iX3RibDsNCj4gK2V4dGVybiBjb25zdCBzdHJ1Y3QgcnR3X3RhYmxlIHJ0
dzg4MTJhX3R4cHdyX2xtdF90Ymw7DQo+ICsNCj4gK2V4dGVybiBjb25zdCBzdHJ1Y3QgcnR3X3B3
cl9zZXFfY21kICpjYXJkX2VuYWJsZV9mbG93Xzg4MTJhW107DQo+ICtleHRlcm4gY29uc3Qgc3Ry
dWN0IHJ0d19wd3Jfc2VxX2NtZCAqZW50ZXJfbHBzX2Zsb3dfODgxMmFbXTsNCj4gK2V4dGVybiBj
b25zdCBzdHJ1Y3QgcnR3X3B3cl9zZXFfY21kICpjYXJkX2Rpc2FibGVfZmxvd184ODEyYVtdOw0K
PiArDQo+ICtleHRlcm4gY29uc3Qgc3RydWN0IHJ0d19wd3JfdHJhY2tfdGJsIHJ0dzg4MTJhX3J0
d19wd3JfdHJhY2tfdGJsOw0KPiArZXh0ZXJuIGNvbnN0IHN0cnVjdCBydHdfcHdyX3RyYWNrX3Ri
bCBydHc4ODEyYV9ydHdfcHdyX3RyYWNrX3JmZTNfdGJsOw0KPiArDQo+ICsjZW5kaWYNCj4gLS0N
Cj4gMi40Ni4wDQoNCg==

