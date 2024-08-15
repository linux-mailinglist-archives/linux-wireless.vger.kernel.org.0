Return-Path: <linux-wireless+bounces-11473-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id C6938952A2E
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 09:55:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4909C1F21A59
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 07:55:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9B46B13B5AD;
	Thu, 15 Aug 2024 07:55:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="Hvf02npp"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48A962BAE5
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 07:55:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708547; cv=none; b=Ah+keLpG7EeKnYIpPDzFYXzr6DRRAo0Dn/0kvifg/kaVhemvqGt6yNBF3zwX5R4djpmihhYDrNKc03Xo2hj1//4LGIMU+hH4tbog0omSotNYeOeu42BgyKv6oyKN4gem5GQsw3Yy71N7GQW5EvjKdvOrAPhZv4UdmTlf3JIp7gY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708547; c=relaxed/simple;
	bh=sCJbE4swSVP4Z+XyRJsDsQ5A9qNSgltsHV14obKL3Eg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=mPB8PZ0S+P5vwnGQsRgj8DiVogTqPk3G9icnhRgvmDk1dVLExyBu7NGLD5vGGSxpzHq89g/n1pPGpWDEweMyzwJvODjnmls3/JCyljjtPp2tZSMqoy2Cca4SlXbwTO2GPZVf4coBpMEA0fQ+7Y+7UuOQyuTXWa3M4DsP4aIKqVU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=Hvf02npp; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47F7teUyB3756398, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723708540; bh=sCJbE4swSVP4Z+XyRJsDsQ5A9qNSgltsHV14obKL3Eg=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=Hvf02nppUBIah+gQflPo5n5gvk6kutwQlTutXqgX46SaaZNWdtaoE6S7FpoNs2KyC
	 YOSkPepwBP9G4JdVzbdV2OnmOhRYlcpHtpOIvsVkrJjL+t4ajzq9uAlAjxNCAIdIbL
	 +4xvobi05bd/Q9357lFqhYLlREpCXMrQ9469x1UXAkpQzCSac2LPOfRH69drpQNSvp
	 A1UGJCBq/2ecBOeacErbR2QFLgoDegUMidguolaJxcpldhMmPcqQiv/kXcDZ2wn1jB
	 dT8IkWKuEUX7PcTx99kLamlqkyd9mW0cfucK1zbqe4/zl/hNRx1Aj15tiT8z4W6rf0
	 4VwKIJaKLRqZg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47F7teUyB3756398
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 15:55:40 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 15:55:40 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Aug 2024 15:55:39 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0]) by
 RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0%5]) with mapi id
 15.01.2507.035; Thu, 15 Aug 2024 15:55:39 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 17/20] wifi: rtw88: Add rtw8821a_table.{c,h}
Thread-Topic: [PATCH 17/20] wifi: rtw88: Add rtw8821a_table.{c,h}
Thread-Index: AQHa7DJjNOoDUn5n9UWpkTTxP3Z0ebIn+ECQ
Date: Thu, 15 Aug 2024 07:55:39 +0000
Message-ID: <c4de3e95f1eb465a8dec8a33aafafb67@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <9a9d72c6-385e-4e21-80f7-eb6c4eb81860@gmail.com>
In-Reply-To: <9a9d72c6-385e-4e21-80f7-eb6c4eb81860@gmail.com>
Accept-Language: en-US, zh-TW
Content-Language: zh-TW
x-kse-serverinfo: RTEXMBS01.realtek.com.tw, 9
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGVz
ZSBjb250YWluIHZhcmlvdXMgYXJyYXlzIGZvciBpbml0aWFsaXNpbmcgUlRMODgyMUFVLiBBbHNv
IFRYIHBvd2VyDQo+IGxpbWl0cy4NCj4gDQo+IFNpZ25lZC1vZmYtYnk6IEJpdHRlcmJsdWUgU21p
dGggPHJ0bDg4MjFjZXJmZTJAZ21haWwuY29tPg0KPiAtLS0NCj4gIC4uLi93aXJlbGVzcy9yZWFs
dGVrL3J0dzg4L3J0dzg4MjFhX3RhYmxlLmMgICB8IDIzNTAgKysrKysrKysrKysrKysrKysNCj4g
IC4uLi93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4MjFhX3RhYmxlLmggICB8ICAgMjEgKw0K
PiAgMiBmaWxlcyBjaGFuZ2VkLCAyMzcxIGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEw
MDY0NCBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4MjFhX3RhYmxlLmMN
Cj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBkcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4
L3J0dzg4MjFhX3RhYmxlLmgNCj4gDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0dzg4L3J0dzg4MjFhX3RhYmxlLmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVz
cy9yZWFsdGVrL3J0dzg4L3J0dzg4MjFhX3RhYmxlLmMNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQN
Cj4gaW5kZXggMDAwMDAwMDAwMDAwLi4zMmRkZDQ2MGU3YmINCj4gLS0tIC9kZXYvbnVsbA0KPiAr
KysgYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4MjFhX3RhYmxlLmMN
Cj4gQEAgLTAsMCArMSwyMzUwIEBADQo+ICsvLyBTUERYLUxpY2Vuc2UtSWRlbnRpZmllcjogR1BM
LTIuMCBPUiBCU0QtMy1DbGF1c2UNCj4gKy8qIENvcHlyaWdodChjKSAyMDE4LTIwMTkgIFJlYWx0
ZWsgQ29ycG9yYXRpb24NCg0KeWVhciAyMDI0DQoNClsuLi5dDQoNCj4gKw0KPiArY29uc3Qgc3Ry
dWN0IHJ0d19wd3Jfc2VxX2NtZCAqY2FyZF9lbmFibGVfZmxvd184ODIxYVtdID0gew0KPiArICAg
ICAgIHRyYW5zX2NhcmRkaXNfdG9fY2FyZGVtdV84ODIxYSwNCj4gKyAgICAgICB0cmFuc19jYXJk
ZW11X3RvX2FjdF84ODIxYSwNCj4gKyAgICAgICBOVUxMDQo+ICt9Ow0KPiArDQo+ICtjb25zdCBz
dHJ1Y3QgcnR3X3B3cl9zZXFfY21kICplbnRlcl9scHNfZmxvd184ODIxYVtdID0gew0KPiArICAg
ICAgIHRyYW5zX2FjdF90b19scHNfODgyMWEsDQo+ICsgICAgICAgTlVMTA0KPiArfTsNCj4gKw0K
PiArY29uc3Qgc3RydWN0IHJ0d19wd3Jfc2VxX2NtZCAqY2FyZF9kaXNhYmxlX2Zsb3dfODgyMWFb
XSA9IHsNCj4gKyAgICAgICB0cmFuc19hY3RfdG9fY2FyZGVtdV84ODIxYSwNCj4gKyAgICAgICB0
cmFuc19jYXJkZW11X3RvX2NhcmRkaXNfODgyMWEsDQo+ICsgICAgICAgTlVMTA0KPiArfTsNCg0K
VGhlIHNhbWUgYXMgODgxMkEuDQoNCiQgb2JqZHVtcCAgLXQgcnR3ODgyMWFfdGFibGUubyB8IGdy
ZXAgIlwuZGF0YSINCjAwMDAwMDAwMDAwMDAwMDAgZyAgICAgTyAuZGF0YSAgMDAwMDAwMDAwMDAw
MDAxOCBjYXJkX2Rpc2FibGVfZmxvd184ODIxYQ0KMDAwMDAwMDAwMDAwMDAyMCBnICAgICBPIC5k
YXRhICAwMDAwMDAwMDAwMDAwMDEwIGVudGVyX2xwc19mbG93Xzg4MjFhDQowMDAwMDAwMDAwMDAw
MDMwIGcgICAgIE8gLmRhdGEgIDAwMDAwMDAwMDAwMDAwMTggY2FyZF9lbmFibGVfZmxvd184ODIx
YQ0KDQpbLi4uXQ0KDQo+IGRpZmYgLS1naXQgYS9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0dzg4L3J0dzg4MjFhX3RhYmxlLmgNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVr
L3J0dzg4L3J0dzg4MjFhX3RhYmxlLmgNCj4gbmV3IGZpbGUgbW9kZSAxMDA2NDQNCj4gaW5kZXgg
MDAwMDAwMDAwMDAwLi4wNzBmZmRiY2QyNzENCj4gLS0tIC9kZXYvbnVsbA0KPiArKysgYi9kcml2
ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4MjFhX3RhYmxlLmgNCj4gQEAgLTAs
MCArMSwyMSBAQA0KPiArLyogU1BEWC1MaWNlbnNlLUlkZW50aWZpZXI6IEdQTC0yLjAgT1IgQlNE
LTMtQ2xhdXNlICovDQo+ICsvKiBDb3B5cmlnaHQoYykgMjAxOC0yMDE5ICBSZWFsdGVrIENvcnBv
cmF0aW9uDQoNCnllYXIgMjAyNA0KDQo+ICsgKi8NCj4gKw0KPiArI2lmbmRlZiBfX1JUVzg4MjFB
X1RBQkxFX0hfXw0KPiArI2RlZmluZSBfX1JUVzg4MjFBX1RBQkxFX0hfXw0KPiArDQo+ICtleHRl
cm4gY29uc3Qgc3RydWN0IHJ0d190YWJsZSBydHc4ODIxYV9tYWNfdGJsOw0KPiArZXh0ZXJuIGNv
bnN0IHN0cnVjdCBydHdfdGFibGUgcnR3ODgyMWFfYWdjX3RibDsNCj4gK2V4dGVybiBjb25zdCBz
dHJ1Y3QgcnR3X3RhYmxlIHJ0dzg4MjFhX2JiX3RibDsNCj4gK2V4dGVybiBjb25zdCBzdHJ1Y3Qg
cnR3X3RhYmxlIHJ0dzg4MjFhX2JiX3BnX3RibDsNCj4gK2V4dGVybiBjb25zdCBzdHJ1Y3QgcnR3
X3RhYmxlIHJ0dzg4MjFhX3JmX2FfdGJsOw0KPiArZXh0ZXJuIGNvbnN0IHN0cnVjdCBydHdfdGFi
bGUgcnR3ODgyMWFfdHhwd3JfbG10X3RibDsNCj4gKw0KPiArZXh0ZXJuIGNvbnN0IHN0cnVjdCBy
dHdfcHdyX3NlcV9jbWQgKmNhcmRfZW5hYmxlX2Zsb3dfODgyMWFbXTsNCj4gK2V4dGVybiBjb25z
dCBzdHJ1Y3QgcnR3X3B3cl9zZXFfY21kICplbnRlcl9scHNfZmxvd184ODIxYVtdOw0KPiArZXh0
ZXJuIGNvbnN0IHN0cnVjdCBydHdfcHdyX3NlcV9jbWQgKmNhcmRfZGlzYWJsZV9mbG93Xzg4MjFh
W107DQo+ICsNCj4gK2V4dGVybiBjb25zdCBzdHJ1Y3QgcnR3X3B3cl90cmFja190YmwgcnR3ODgy
MWFfcnR3X3B3cl90cmFja190Ymw7DQo+ICsNCj4gKyNlbmRpZg0KPiAtLQ0KPiAyLjQ2LjANCg0K

