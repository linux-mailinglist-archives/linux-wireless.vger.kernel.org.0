Return-Path: <linux-wireless+bounces-11474-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 04487952A39
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 09:58:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A0BAA1F21A70
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 07:58:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9010B1EB31;
	Thu, 15 Aug 2024 07:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="irNU5AZZ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 29801199393
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 07:58:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723708694; cv=none; b=qzzMMi2X35I+/LTzv+a2cDCSS8wYDCEPLhQCKlogLp/ghKXqKrfuDEnNSGXr82f3SREmiPwZtLVMnI/x3OgferBmt7PCk7IboUc7jgq26Wd9XfeIbhyuxv5v2Zg3+f7KZhjIJTNwUkojhW8ADy9ZIXCsISfd2pHDNzt1PrCEnGE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723708694; c=relaxed/simple;
	bh=hbzQTTcarndG7KUOERq2qRlgMq0QxNWwwCI+LCvW4U8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=BMuuzBvWl5HkhS8nfsAs3VruawrpiccMYICttciO6t5ELIQsObT+pysOFC5nOsKU5To9PJDUZ+UwpkfMfwOc/29HpPqA0VDAfU1Dx7BPj2V3lV/5mENSVp7VIXCCljOm4ipY4VMV5/ZsoATrIZGYBegVg3ev3D6vHeSkttbaFeA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=irNU5AZZ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47F7w8cdD3757144, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723708688; bh=hbzQTTcarndG7KUOERq2qRlgMq0QxNWwwCI+LCvW4U8=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=irNU5AZZrPCOY+w5+32KynCKvKqMDUJd8xTCI3N+csJXZiSQ55WbgE/qR4C37oY1Y
	 LnK1VaWc+ABGi6nbzjNfbTiK2GCgvrdGmcwV3kKTLPP+8YkX6ihP2T41srqsEJt3S6
	 FiIt4OxJTjw8/N26WeOhvsZytzRXHt0n7zn/embdFahYb+IMn0YwVWXomxXPrss8Wp
	 9wmKNkXgP/AYGxVnXHmLkk3c06HY1GGqICKcd8i/d1DhbANhdcWm0YpyS8HI7QCmGm
	 svzdMkenu9ahmjPJtCZeS2IimBoRn7E9d8C2isLkhZF/NAkPf1jb1L/3a8JmqSkRru
	 q/kGcGmygOuxQ==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47F7w8cdD3757144
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 15:58:08 +0800
Received: from RTEXMBS02.realtek.com.tw (172.21.6.95) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 15:58:08 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS02.realtek.com.tw (172.21.6.95) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Aug 2024 15:58:08 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0]) by
 RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0%5]) with mapi id
 15.01.2507.035; Thu, 15 Aug 2024 15:58:08 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 19/20] wifi: rtw88: Add rtw8821au.c and rtw8812au.c
Thread-Topic: [PATCH 19/20] wifi: rtw88: Add rtw8821au.c and rtw8812au.c
Thread-Index: AQHa7DKor9+CDio0mEG1rYYp0FCavrIn+OvA
Date: Thu, 15 Aug 2024 07:58:08 +0000
Message-ID: <a44e5c8d4da7493d879348bffdb7c953@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <8ad0d339-bded-410c-9fee-4b5730651bbc@gmail.com>
In-Reply-To: <8ad0d339-bded-410c-9fee-4b5730651bbc@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
VGhlc2UgYXJlIHRoZSBlbnRyeSBwb2ludHMgZm9yIHRoZSBuZXcgbW9kdWxlcyBydHc4OF84ODIx
YXUNCj4gKFJUTDg4MjFBVS9SVEw4ODExQVUpIGFuZCBydHc4OF84ODEyYXUgKFJUTDg4MTJBVSku
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdt
YWlsLmNvbT4NCj4gLS0tDQo+ICAuLi4vbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgvcnR3ODgx
MmF1LmMgICAgfCAyOCArKysrKysrKysrKysrKysrKysrDQo+ICAuLi4vbmV0L3dpcmVsZXNzL3Jl
YWx0ZWsvcnR3ODgvcnR3ODgyMWF1LmMgICAgfCAyOCArKysrKysrKysrKysrKysrKysrDQo+ICAy
IGZpbGVzIGNoYW5nZWQsIDU2IGluc2VydGlvbnMoKykNCj4gIGNyZWF0ZSBtb2RlIDEwMDY0NCBk
cml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4MTJhdS5jDQo+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9uZXQvd2lyZWxlc3MvcmVhbHRlay9ydHc4OC9ydHc4ODIxYXUu
Yw0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL3JlYWx0ZWsvcnR3ODgv
cnR3ODgxMmF1LmMNCj4gYi9kcml2ZXJzL25ldC93aXJlbGVzcy9yZWFsdGVrL3J0dzg4L3J0dzg4
MTJhdS5jDQo+IG5ldyBmaWxlIG1vZGUgMTAwNjQ0DQo+IGluZGV4IDAwMDAwMDAwMDAwMC4uOTk5
N2VkZDM4NmFhDQo+IC0tLSAvZGV2L251bGwNCj4gKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
cmVhbHRlay9ydHc4OC9ydHc4ODEyYXUuYw0KPiBAQCAtMCwwICsxLDI4IEBADQo+ICsvLyBTUERY
LUxpY2Vuc2UtSWRlbnRpZmllcjogR1BMLTIuMCBPUiBCU0QtMy1DbGF1c2UNCj4gKy8qIENvcHly
aWdodChjKSAyMDE4LTIwMTkgIFJlYWx0ZWsgQ29ycG9yYXRpb24NCg0KWWVhciAyMDI0Lg0KDQpQ
bGVhc2UgdXBkYXRlIHllYXIgYWNyb3NzIHdob2xlIHBhdGNoc2V0LiANCg0K

