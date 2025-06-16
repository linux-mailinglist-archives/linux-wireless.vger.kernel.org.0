Return-Path: <linux-wireless+bounces-24115-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 911ECADA61F
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 03:52:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 92B327A1A58
	for <lists+linux-wireless@lfdr.de>; Mon, 16 Jun 2025 01:50:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B2AFE19DF6A;
	Mon, 16 Jun 2025 01:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b="p8HWg5hs"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A45253C465
	for <linux-wireless@vger.kernel.org>; Mon, 16 Jun 2025 01:52:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750038724; cv=none; b=arDag9O9LkMeGcmUIF08QMueKOH2SAp/915VCYx4KM9QlvF2wzHi5AuLZqBxUrvIzENDwV7cmA7ZDGcSrcm0RH7gmQZvuSrWATwiQyjlTornkxWEie9xyi0pJsdGOzL/69ROL4kHO5tXx9uK1o2NP4d/TmvSzaAeF/W3S3iR8rM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750038724; c=relaxed/simple;
	bh=cLk0e2x+mDvAnP2VpbEN64htGRznm3My4zZmXoYAi54=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=OZXfp0lhQlOL9ykeIxPvoZRS1+ZcfsOOUGlt8wVb9nBv6g2n54vriq5lFe7/AHSU2+6ssg0kvtM55Rw1D1yJWtCtC4gSRR7GcJA7SsFXHUktB1fjTtBLtbIzoLiTyHORkb+gibYt9y8vrZYHTXsqLpyoxPIN0OJ+2WFPkpG7VWM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=pass (2048-bit key) header.d=realtek.com header.i=@realtek.com header.b=p8HWg5hs; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 55G1pxtaF3847539, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=realtek.com; s=dkim;
	t=1750038719; bh=cLk0e2x+mDvAnP2VpbEN64htGRznm3My4zZmXoYAi54=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=p8HWg5hsAnlUi/Xc3eQczpHgmK6Q8T4uwZkNAM2RFL7wBDSOchm/qWFReZGDkMXVt
	 CMK0b6s9TlHY30MqGJfbsfCJZhXzHWJrMZj3Nq7+cwpeXVuPxu62MaOc3s/rouAU1x
	 +NYUgq+JQMWqXLJlOQ/ft5+8+flXdaTxrvPIKLmWFVTSmxlvsqrOZx8BS4KASHt+L0
	 m3kFMSqaIoSrR7DdJlpX/ymHKd1Zz6Ylzj4FcMTKwhb6Ys40cn3fTKgsHRY0Esptza
	 FH1pSCQDuYfIHue2N6vpBCyDY46qL6HaA/auUYBbY66P+0/YKaddxVRHEkeJus8hiH
	 uTcg93/k6+Jag==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 55G1pxtaF3847539
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 16 Jun 2025 09:51:59 +0800
Received: from RTEXMBS01.realtek.com.tw (172.21.6.94) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Mon, 16 Jun 2025 09:51:57 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS01.realtek.com.tw (172.21.6.94) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Mon, 16 Jun 2025 09:51:56 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Mon, 16 Jun 2025 09:51:56 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v2 09/14] wifi: rtw89: 8851b: Modify rtw8851b_pwr_{on,off}_func() for USB
Thread-Topic: [PATCH rtw-next v2 09/14] wifi: rtw89: 8851b: Modify
 rtw8851b_pwr_{on,off}_func() for USB
Thread-Index: AQHb2XTpAt2ZsNjo3kC1lTPyNktLxrQFDkIQ
Date: Mon, 16 Jun 2025 01:51:56 +0000
Message-ID: <deb6c812cd0e4e00a513f251e62d2f81@realtek.com>
References: <6fc81cc4-a4d1-4db9-ab60-c8976e0b3c27@gmail.com>
 <c1ff2155-ef01-466e-9c34-4437ee57656c@gmail.com>
In-Reply-To: <c1ff2155-ef01-466e-9c34-4437ee57656c@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBUaGVy
ZSBhcmUgYSBmZXcgZGlmZmVyZW5jZXMgaW4gdGhlIHBvd2VyIG9uL29mZiBmdW5jdGlvbnMgYmV0
d2VlbiBQQ0lFDQo+IGFuZCBVU0IuDQo+IA0KPiBXaGlsZSB0aGUgUlRMODg1MUJVIGFwcGVhcnMg
dG8gd29yayB3aXRob3V0IHRoZXNlIGNoYW5nZXMsIGl0J3MNCj4gcHJvYmFibHkgYmVzdCB0byBp
bXBsZW1lbnQgdGhlbSwgaW4gY2FzZSB0aGV5IGFyZSBuZWVkZWQgaW4gc29tZQ0KPiBzaXR1YXRp
b25zLg0KDQpUaGUgZGlmZmVyZW5jZSBiZXR3ZWVuIFJUTDg4NTFCRSBhbmQgUlRMODg1MUJVIGlz
IHZlcnkgc21hbGwsIHNvIGl0IGlzDQpyZWFzb25hYmxlIHRvIGNvbWJpbmUgdGhlbSB3aXRoIGNv
bmRpdGlvbnMgb2YgaGNpLnR5cGUuIElmIG90aGVyIGNoaXBzDQpoYXZlIG11Y2ggZGlmZmVyZW5j
ZSwgcGxlYXNlIGRlZmluZSBhcnJheSBzdWNoIGFzDQogICBwd3Jfb25fZnVuY1tSVFc4OV9IQ0lf
VFlQRV9OVU1dDQoNCkl0IHdvdWxkIG11Y2ggZWFzaWVyIHRvIHVwZGF0ZSB0aGUgY2hhbmdlcyBm
cm9tIHZlbmRvciBkcml2ZXIuIA0KDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNt
aXRoIDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8
cGtzaGloQHJlYWx0ZWsuY29tPg0KDQo=

