Return-Path: <linux-wireless+bounces-22900-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A0FE4AB4C74
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 09:07:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 467DA188B131
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 07:07:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B48FE1E491B;
	Tue, 13 May 2025 07:07:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="D4fn1vti"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083C71EB19F
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 07:07:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747120047; cv=none; b=uLpUMLKVvHEats2hZdmqVKSOq2jcA6/uwr/d4CGOQV4B1WK25ecvAJj5qWjQo6iYZRbrztEsSopFeyjZotPrhiOCsPP6gtPKWAlR/0FakR+KXu/WpcaPsszi6N8vUVqnCasI9Ru1DW8NQKzi1J7jD6Gmmq4MmVK+ENhrh9JAmsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747120047; c=relaxed/simple;
	bh=XxFFIXtwzs18qdX4JopEJiBn9Hqoq7IrnBP+StvhNK4=;
	h=From:To:Subject:Date:Message-ID:References:Content-Type:
	 MIME-Version; b=MTvD0BnTKX7JNUGhS1ep/CxjjztrrPbzw2zO3VUWPRdDK78RFIhFZz6xnphV48UeK+lERC9cca0eEJmqiSapKdLZllSSufFSwfQQBEO8AMapUjLueSX0KUdHs1pYQQW4gN9FqrD2z8mem3e9CKGlNk/fWBwpv1UdyOqeVwZqrDk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=D4fn1vti; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54D77KJ103915907, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747120040; bh=XxFFIXtwzs18qdX4JopEJiBn9Hqoq7IrnBP+StvhNK4=;
	h=From:To:Subject:Date:Message-ID:References:Content-Type:
	 Content-Transfer-Encoding:MIME-Version;
	b=D4fn1vtiFA3Yf+eHy1sGku3uV3Rq2MCBEhg0WN3hYpaD+OqR1yVutIof4UY8HgKjr
	 OmniCOrKibEqR4+3pgzUwzZQVPzXXNw7026jUjoumAd5d/LvOE9OJzs1sW/D+xM4eG
	 PjiSb68dyc3XZukX9ZNnNhZaQ3ZpBRwXP2fFum63ef4y1wmeuB1lWM2F/+ti+Sgrdl
	 eXSiFsJuzPKQU42uTWKR5kP/95FJGusc/by+elgVAP5iEDFPttFfCW0k1nnPwfyQEo
	 w/nB8ENEEI+qwjGCENnjL+X0PAY1Aq44YfV71P9KFccBf37fKmXDkec0WPwiUNSvA4
	 ljug+Q81Xn2Bg==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54D77KJ103915907
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 15:07:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 May 2025 15:07:20 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS04.realtek.com.tw (172.21.6.97) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 May 2025 15:07:20 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 13 May 2025 15:07:20 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v1 00/13] wifi: rtw89: Add support for USB devices
Thread-Topic: [PATCH rtw-next v1 00/13] wifi: rtw89: Add support for USB
 devices
Thread-Index: AQHbvTXQPM5g3Ac8D0CEfnCEvmiFA7PQI+gwgAAMg5A=
Date: Tue, 13 May 2025 07:07:20 +0000
Message-ID: <d947c391577d46a4b110cb30cfa89ad0@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com> 
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

UGluZy1LZSBTaGloIHdyb3RlOg0KPiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2VyZmUyQGdt
YWlsLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBBZGQgc3VwcG9ydCBmb3IgVVNCIGRldmljZXMsIHN0
YXJ0aW5nIHdpdGgganVzdCBSVEw4ODUxQlUuDQo+IA0KPiBUaGFua3MgZm9yIHlvdXIgd29yayEh
DQoNCkhhdmUgeW91IGFsc28gdGVzdGVkIEFQIG1vZGU/IElmIG5vdCwgcGxlYXNlIGFkZCBhIHBh
dGNoIHRvIGRpc2FibGUgaXQNCnRlbXBvcmFyaWx5IGFzIGEgdHJhbnNpdGlvbiBzb2x1dGlvbiwg
bGlrZSBydHc4OC4gDQoNCj4gDQo+ID4gUlRMODgzMkJVL1JUTDg4NTJCVSBjYW4gYmUgc3VwcG9y
dGVkIGVhc2lseSBsYXRlci4gUlRMODgzMkNVL1JUTDg4NTJDVQ0KPiA+IGNhbiBiZSBzdXBwb3J0
ZWQgYXMgd2VsbCwgYnV0IGl0IGtlZXBzIGxvc2luZyB0aGUgY29ubmVjdGlvbi4NCj4gPg0KPiA+
IFRoaXMgaXMgYmFzZWQgb24gcnR3ODhfdXNiIGFuZCB0aGUgb2ZmaWNpYWwgcnRsODg1MWJ1IGRy
aXZlcg0KPiA+IHYxLjE5LjEwLTcwLWc4NGUzNWMyOGQuMjAyMzEwMTkgZnJvbSBoZXJlOg0KPiA+
IGh0dHBzOi8vZ2l0aHViLmNvbS9mb2ZhamFyZG8vcnRsODg1MWJ1DQo+ID4NCj4gPiBJIGRpZG4n
dCB0ZXN0IHdpdGggYW55IFBDSSBkZXZpY2VzLg0KPiANCj4gSSB0ZXN0ZWQgUlRMODg1MUJFLiBJ
dCB3b3JrcyBhcyB1c3VhbC4NCg0K

