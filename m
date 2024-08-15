Return-Path: <linux-wireless+bounces-11461-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id E134A952979
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 08:46:19 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A5708282748
	for <lists+linux-wireless@lfdr.de>; Thu, 15 Aug 2024 06:46:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE2C11448FD;
	Thu, 15 Aug 2024 06:46:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="pB2CTc91"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F825BA53
	for <linux-wireless@vger.kernel.org>; Thu, 15 Aug 2024 06:46:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723704374; cv=none; b=oA4gk6d93wiqScqKSxhBtf+9M4M1etjy+e4UPC5N/S9UmiRs1chRJet24CLZtHC0fNi+8WoO3VZLwlpgFzUzh8m3RGh+Ff5YNSH7H9Rh9IjGHR2+JBl4HCKzWkDxr++dEW0lKR1jjNe2nB4cvEeO/yA5OnhbCR99JIiL9soVfWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723704374; c=relaxed/simple;
	bh=e7WTKUreheHO3MAiwz49YnRxpNpoCYdWiAia6WsJnMo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Eqve1LBUU08I6Zo21eyVk2Kyi1959yUPFibXDlP5uGRaFAAYLdXe4DXaP8L1JlVvMdIkuXcIxspSO8t4dkFyWEE4d2v6KBz8G153CpzDGLU0Gjssiu/z3JOSrevSrHsVc5rhJnypdMbiNpxx8hcwA5Om9YK3SzGbWG9+nlgx+FY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=pB2CTc91; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 47F6k7jF53710314, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1723704367; bh=e7WTKUreheHO3MAiwz49YnRxpNpoCYdWiAia6WsJnMo=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=pB2CTc91BdfZEWPyz0gsgnMX0p+VpXYT5/lAbkbGAcz/QgvrZFuXLFl5g3zY7iYi5
	 YiD1yr9BvJyFCD9yoZYND8P5wc7Z4Ndgd/pRcbj6nO+xuLhJ/5pCvWfoSGKzFDBgUO
	 AyPDJp7XhXf9DbsTSb8ck/MXGmCo4nCl17AD2EOAza1MNaE/lTB00R8iWWm1BIAdQo
	 MSBwBOoSvSNiuu4KPqHlRz10qyDEpke/ato5cm3KKb9eHq3I8wMNrLdIayF0ml3LE/
	 lKB39m0Uc05Z+EoDNG2pCXgNute1v67H2mYbG60XFGeXo+cVIwp/OW7OwQ2L2tIGbz
	 HMLH2LmJ101JA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 47F6k7jF53710314
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 15 Aug 2024 14:46:07 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Thu, 15 Aug 2024 14:46:08 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Thu, 15 Aug 2024 14:46:07 +0800
Received: from RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0]) by
 RTEXDAG02.realtek.com.tw ([fe80::1849:eb4c:c240:1ba0%5]) with mapi id
 15.01.2507.035; Thu, 15 Aug 2024 14:46:07 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH 07/20] wifi: rtw88: Enable data rate fallback for older chips
Thread-Topic: [PATCH 07/20] wifi: rtw88: Enable data rate fallback for older
 chips
Thread-Index: AQHa7DFQmU+XYyLgNkmzgeByN9/v2bIn5COw
Date: Thu, 15 Aug 2024 06:46:07 +0000
Message-ID: <97037e5a8cfb4303a975adbbe2dff76d@realtek.com>
References: <ade57ca1-444f-49e2-b49e-f4b9da65b2cc@gmail.com>
 <7a45d3c5-ada6-41ca-be67-44cce5c28045@gmail.com>
In-Reply-To: <7a45d3c5-ada6-41ca-be67-44cce5c28045@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBSVEw4
ODExQVUgZmFpbHMgdG8gcGVyZm9ybSB0aGUgNC13YXkgaGFuZHNoYWtlIHdoZW4gdGhlIEFQIGlz
IHRvbyBmYXINCj4gYmVjYXVzZSBpdCB0cmFuc21pdHMgdGhlIEVBUE9MIGZyYW1lcyBhdCBNQ1M5
IGFuZCB3aGVuIHRoYXQgZG9lc24ndA0KPiB3b3JrIGl0IHJldHJpZXMgNDggdGltZXMgd2l0aCB0
aGUgc2FtZSByYXRlLCB0byBubyBhdmFpbC4NCj4gDQo+IFJldHJ5aW5nIDQ4IHRpbWVzIHdpdGgg
dGhlIHNhbWUgcmF0ZSBzZWVtcyBwb2ludGxlc3MuIFNldCB0aGUNCj4gYXBwcm9wcmlhdGUgZmll
bGQgaW4gdGhlIFRYIGRlc2NyaXB0b3IgdG8gYWxsb3cgaXQgdG8gdXNlIGxvd2VyIHJhdGVzDQo+
IHdoZW4gcmV0cnlpbmcuDQo+IA0KPiBTZXQgaXQgZm9yIFJUTDg3MjNEIGFuZCBSVEw4NzAzQiBi
ZWNhdXNlIHRoZXkgaW50ZXJwcmV0IHRoaXMgZmllbGQgdGhlDQo+IHNhbWUgd2F5IGFzIFJUTDg4
MTFBLg0KPiANCj4gVGhlIG5ld2VyIFJUTDg4MjJDLCBSVEw4ODIyQiwgUlRMODgyMUMgc2VlbSB0
byBpbnRlcnByZXQgdGhpcyBmaWVsZCBpbg0KPiB0aGUgVFggZGVzY3JpcHRvciBkaWZmZXJlbnRs
eSwgc28gbGVhdmUgaXQgYWxvbmUgZm9yIHRob3NlIGNoaXBzLg0KDQpQbGVhc2UgZmlsbCAnLm9s
ZF9kYXRhcmF0ZV9mYl9saW1pdCA9IGZhbHNlJyBmb3IgdGhlc2UgY2hpcHMuIEl0IHdpbGwgYmUg
ZWFzaWVyDQp0byBrbm93IHRoZXkgYXJlIG5vdCBtaXNzaW5nLg0KDQoNCg==

