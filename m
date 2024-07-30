Return-Path: <linux-wireless+bounces-10655-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 570C1940625
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 05:59:54 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 008D51F220B1
	for <lists+linux-wireless@lfdr.de>; Tue, 30 Jul 2024 03:59:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6CD4715FCED;
	Tue, 30 Jul 2024 03:59:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="GI5Wv87A"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC6A615FA88
	for <linux-wireless@vger.kernel.org>; Tue, 30 Jul 2024 03:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722311971; cv=none; b=qwwBm+g11XEsMYeb1Yx8LJrUcAdZl9uzSBsL19cBadeOfS8JuFBviTdphjbxjodRO6MsN0OD1GwjRZe0CTxyZbG2kxNTkBPHFZBtypUa1env0hPtwiXodIWiKV4sKVEmIobmSW13kdJARIxSOnCxgjJBmEzkKvB6XUAjCQGz+Lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722311971; c=relaxed/simple;
	bh=iBXJgaTUv+AJ1FyvYqaZj7ARbJLxeS9VytOoJamp27k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=GHrFUs1Xq61LnF3egjiL0LcH9dHJWTzZBN3USaF6QOZAaBQlM8R+ZV/VEm8K52mXNyPmPv/HM/pr0yJSKiGsw3GNte1ppgkU+bjZivUUQ9CAwFckkxRR0s/0QY3JgmuF8KrdgKKaQ01s7JlnoIktzWm5R8kIJvFyEy7RLXVnNQ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=GI5Wv87A; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 46U3xKGF1649519, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1722311960; bh=iBXJgaTUv+AJ1FyvYqaZj7ARbJLxeS9VytOoJamp27k=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=GI5Wv87ABkiy/oQGzxk3mYFANwm4eHEdzm0oLT49golSFIrykQoSy9XhNj7a8iOp0
	 KHVY6empszB4B0XYKR23LjkMPCywvQpzn8pShRRylIRohBWAddWqXjyUmbHpS1pGNh
	 PYZbW/A64mjLKAmVlR+JaN/ilO/GgODMiPlvJPlPFcsG9Lw/EAIAmCYKjRoW/2SZCU
	 7RrXVHHFPb16dcxwKj55ZxejmRpzKfE7vi0SXKlUiTaU4mLJvVu7NIEI/LzfvJZTnT
	 /9NAv3l7h5z0v1MwIwTY2dxs79p5RPnJk1wXaI49aMnDsBlnG6mPtcIJxHYef1Tuz2
	 P2h1AqwRTI5Ng==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.02/5.92) with ESMTPS id 46U3xKGF1649519
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 30 Jul 2024 11:59:20 +0800
Received: from RTEXMBS05.realtek.com.tw (172.21.6.98) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 30 Jul 2024 11:59:21 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 30 Jul 2024 11:59:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Tue, 30 Jul 2024 11:59:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Sascha Hauer <sha@pengutronix.de>
Subject: RE: [PATCH 2/4] wifi: rtw88: usb: Update the RX stats after every frame
Thread-Topic: [PATCH 2/4] wifi: rtw88: usb: Update the RX stats after every
 frame
Thread-Index: AQHa4SYffN9GC83jWUuAC9UYuunUi7IOp1EQ
Date: Tue, 30 Jul 2024 03:59:21 +0000
Message-ID: <4f24ea4a32e14830b7d47f29870ad263@realtek.com>
References: <c03390ce-34c2-42dd-9bd6-b231bb1f2fae@gmail.com>
 <47a89cd7-7767-4b41-abf4-7197e977b7c4@gmail.com>
In-Reply-To: <47a89cd7-7767-4b41-abf4-7197e977b7c4@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBVcGRh
dGUgdGhlIG51bWJlciBvZiByZWNlaXZlZCB1bmljYXN0IGRhdGEgZnJhbWVzIGFuZCBieXRlcyBl
dmVyeSB0aW1lDQo+IGEgZnJhbWUgaXMgcmVjZWl2ZWQuIFRoaXMgaXMgd2hhdCB0aGUgUENJIGFu
ZCBTRElPIGRyaXZlcnMgZG8uDQo+IA0KPiBUaGlzIGhhcyBhbiBpbmZsdWVuY2Ugb24gdGhlIHBv
d2VyIHNhdmluZywgYmx1ZXRvb3RoIGNvZXhpc3RlbmNlLCBhbmQNCj4gKGluIGEgZnV0dXJlIHBh
dGNoKSB0aGUgdXNlIG9mIFJYIGFnZ3JlZ2F0aW9uLg0KPiANCj4gVGVzdGVkIHdpdGggUlRMODgx
MUNVIGFuZCBSVEw4NzIzRFUuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRo
IDxydGw4ODIxY2VyZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtz
aGloQHJlYWx0ZWsuY29tPg0KDQoNCg==

