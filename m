Return-Path: <linux-wireless+bounces-13246-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01CAC987C9B
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2024 03:34:49 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 78C0CB21991
	for <lists+linux-wireless@lfdr.de>; Fri, 27 Sep 2024 01:34:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46C093BBF6;
	Fri, 27 Sep 2024 01:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="aWq9lvtJ"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16EFA79C8
	for <linux-wireless@vger.kernel.org>; Fri, 27 Sep 2024 01:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727400882; cv=none; b=Ty+T8UvNoLLcGe6wOEYkKQEA+SzORWGSsxEdNokBxVQq4moQS6OHFflwm3IGC6wWUwaHBmppRz8O+N5JyUeQEOXWRjGK3MK/yq7u3yQTb7fiwhZmmV/NEfw/ljJgeMnj7k/pXAph/WhS7V2ahJ4Kxs5t3rEFM0wNq/LKlGko4qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727400882; c=relaxed/simple;
	bh=F6p19++SBk7jeFc/eRg3i9TQrjg9vTfqIHxQQLmIGho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=EESdQVDjtcUGWzvFPMTQg/zJVf/lF8AMt3sPM13grfx+YE7K1vE+kkRkUPF3MTCGt4iu6f4FoLUUxgVa5gGx0+uwTtt5KkWzMfLE8DCSmxzr69XZPuxySo5hcAl2S1JFNXu1tx623E2k/sw/58+uRUz2HpD1XaoT+vdHVdNJZB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=aWq9lvtJ; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 48R1YFFK02825075, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1727400855; bh=F6p19++SBk7jeFc/eRg3i9TQrjg9vTfqIHxQQLmIGho=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=aWq9lvtJifgmEWWQAXX1E1fWmtNDVIf8MZEkfbBKcWGSM/1OzPlhFf+H3W2Mp54LF
	 3efuNFouMpPF9Wy7cx4nwNivXPVGapikRJjxdRz2LsrXuUFp5dlo2LCxPdzNtACpR6
	 Umb+fQFdzbB5MMlB8yyhsnUCbeFFE2X3TjpTrPjTkkDvDJbDhT5XJPyM1wEcR4V92q
	 4u7Yf/mX5ECWIloZV7cs6GjH7A3MS7whsNFv7E5Obh9ZF9GN4wgLEdUX5/ZnC1cUCb
	 L8AjjyT7atFjLnLU9x0iv8wuCZkuUROLiMf5mPYE/Ffvxvvr+7L4OlSDe8iMk9WS8g
	 mF0r1ssC5uPUw==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.05/5.92) with ESMTPS id 48R1YFFK02825075
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 27 Sep 2024 09:34:15 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 27 Sep 2024 09:34:15 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 27 Sep 2024 09:34:14 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 27 Sep 2024 09:34:14 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Kalle Valo <kvalo@kernel.org>,
        "linux-wireless@vger.kernel.org"
	<linux-wireless@vger.kernel.org>
CC: "mweissenbach@ignaz.org" <mweissenbach@ignaz.org>
Subject: RE: [PATCH] wifi: rtw89: pci: early chips only enable 36-bit DMA on specific PCI hosts
Thread-Topic: [PATCH] wifi: rtw89: pci: early chips only enable 36-bit DMA on
 specific PCI hosts
Thread-Index: AQHbDifmtwTutU2lF0yize/uYuRPerJq26Og
Date: Fri, 27 Sep 2024 01:34:14 +0000
Message-ID: <4f8451a8dfe043d08a208e52f8754283@realtek.com>
References: <20240924021633.19861-1-pkshih@realtek.com>
In-Reply-To: <20240924021633.19861-1-pkshih@realtek.com>
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

SGkgS2FsbGUsDQoNClBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPiB3cm90ZToNCj4g
DQo+IFRoZSBlYXJseSBjaGlwcyBpbmNsdWRpbmcgUlRMODg1MkEsIFJUTDg4NTFCLCBSVEw4ODUy
QiBhbmQgUlRMODg1MkJUIGhhdmUNCj4gaW50ZXJvcGVyYWJpbGl0eSBwcm9ibGVtcyBvZiAzNi1i
aXQgRE1BIHdpdGggc29tZSBQQ0kgaG9zdHMuIFJvbGxiYWNrDQo+IHRvIDMyLWJpdCBETUEgYnkg
ZGVmYXVsdCwgYW5kIG9ubHkgZW5hYmxlIDM2LWJpdCBETUEgZm9yIHRlc3RlZCBwbGF0Zm9ybXMu
DQo+IA0KPiBTaW5jZSBhbGwgSW50ZWwgcGxhdGZvcm1zIHdlIGhhdmUgY2FuIHdvcmsgY29ycmVj
dGx5LCBhZGQgdGhlIHZlbmRvciBJRCB0bw0KPiB3aGl0ZSBsaXN0LiBPdGhlcndpc2UsIGxpc3Qg
dmVuZG9yL2RldmljZSBJRCBvZiBicmlkZ2Ugd2UgaGF2ZSB0ZXN0ZWQuDQo+IA0KPiBGaXhlczog
MWZkNGIzZmU1MmVmICgid2lmaTogcnR3ODk6IHBjaTogc3VwcG9ydCAzNi1iaXQgUENJIERNQSBh
ZGRyZXNzIikNCj4gUmVwb3J0ZWQtYnk6IE1hcmNlbCBXZWnDn2VuYmFjaCA8bXdlaXNzZW5iYWNo
QGlnbmF6Lm9yZz4NCj4gQ2xvc2VzOg0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC13
aXJlbGVzcy8yMDI0MDkxODA3MzIzNy5Ib3JkZS5WTHVlaDBfS2FpRHctOWFzRUVjZE04NEBpZ25h
ei5vcmcvVC8jbTA3YzUNCj4gNjk0ZGYxYWNiMTczYTQyZTFhMGJhYjdhYzIyYmQyMzFhMmI4DQo+
IFNpZ25lZC1vZmYtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsuY29tPg0KDQpDb3Vs
ZCB5b3UgcGxlYXNlIHF1ZXVlIHRoaXMgcGF0Y2ggdG8gd2lyZWxlc3MgdHJlZT8gQmVjYXVzZSBS
VEw4ODUyQkUgYmVjb21lcw0KdW51c2FibGUgZm9yIHNvbWUgdXNlcnMuIEkgYXNzaWduZWQgdGhp
cyBwYXRjaCB0byB5b3UgaW4gcGF0Y2h3b3JrLCBpZiB5b3UNCmRvbid0IHRoaW5rIHNvIGFuZCBo
YXZlIG90aGVyIHN1Z2dlc3Rpb25zLCBwbGVhc2UgbGV0IG1lIGtub3cuIFRoYW5rcy4gDQoNClRo
ZSB1c2VyIGhhcyByZXBvcnRlZCB0aGlzIHBhdGNoIHdvcmtzIGFzIGV4cGVjdGVkIFsxXSwgc28g
YWRkIGhpcyB0ZXN0ZWQtYnk6DQpUZXN0ZWQtYnk6IE1hcmNlbCBXZWnDn2VuYmFjaCA8bXdlaXNz
ZW5iYWNoQGlnbmF6Lm9yZz4NCg0KQWxzbywgSSB0aGluayB0aGlzIHNob3VsZCBDYyBzdGFibGUs
IHNvDQpDYzogc3RhYmxlQHZnZXIua2VybmVsLm9yZw0KDQpbMV0gaHR0cHM6Ly9sb3JlLmtlcm5l
bC5vcmcvbGludXgtd2lyZWxlc3MvMjAyNDA5MjcwMTIwMDEuSG9yZGUudkpOVGJUNTc2bHp5RkdX
cHJ0R3g3UjBASWduYXpTZXJ2ZXIvVC8jbTAxNDcwYWQ5YmJhMTNlNDZjZTlhMGRkNmVmYWZmZTFl
MTc2YWQwNWUNCg0K

