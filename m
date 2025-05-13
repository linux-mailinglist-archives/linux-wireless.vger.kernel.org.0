Return-Path: <linux-wireless+bounces-22886-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 4BCF3AB49ED
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 05:12:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CC78D19E1012
	for <lists+linux-wireless@lfdr.de>; Tue, 13 May 2025 03:12:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E1D2429CE8;
	Tue, 13 May 2025 03:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="bDAeKqty"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC3131C7015
	for <linux-wireless@vger.kernel.org>; Tue, 13 May 2025 03:12:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747105948; cv=none; b=CeX4B0NIxt4jXYT9iuvMqLdtwZ6iuQc8GzXue+rvAlt+gL8J/mRN+Xs7kTw/E970RQsFGS0I2rJBvYm/QZ92lXjj10SHHQa7jugaKvhDt5prBUOe5yl2WSflw3cnx80VOfx0RbxONOZQR0Fa/KKDSxysqaCfQ9CtGB83ZSlkHW8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747105948; c=relaxed/simple;
	bh=YXKovZVBE2P9eb6EMO90WK1gAdDht+yeYr1fgUA4nwU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=D+rCHESbJDYHpnE8PEgx4We184pUiObRPu8bdTO4v+bfQJczbHl2+SGwoOGAG43Dp0GcCOEEhLuUcyJ6qv1gZp6ZOEBRAmYcaVmVNV/G6LBpB2slET+H1e4RvH3xiJyscljK7zkzxFqqUeOFu1lWKeiij4LaGfFy9sF+XBmGbCU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=bDAeKqty; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.80 with qID 54D3CMkI43574399, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1747105943; bh=YXKovZVBE2P9eb6EMO90WK1gAdDht+yeYr1fgUA4nwU=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=bDAeKqty5lTYVjUy0pjyeowZtBLI6kaFza9X10DRFlOIts1W7rwhGZeeNb3d1dW/k
	 NtORQtQX3VDDmqqYX7RtFQom6bIvmsvMIwSmG39uXymaoujaqy8uAk3eug5BlQRv/J
	 qcpSYw0vtpm3YgEzNnEAoRz9mm8RFq+C7dKMyjjijm+UU5e1xtaQRSueeYEzMcNzS4
	 eBeAZvF9RptCg6sFtzIWvzEtk79Et09uEJTtMmVjy0MvQDNQs9YtC1E16tT8WTZCwk
	 AWhYSXt7ZmGUyXFxnRpSL4ZWYc/N+T40/Ru/tRDyCxAVG0eletQZgmaFu9tQkmqv30
	 8a7V9km3xbvAA==
Received: from mail.realtek.com (rtexh36505.realtek.com.tw[172.21.6.25])
	by rtits2.realtek.com.tw (8.15.2/3.13/5.93) with ESMTPS id 54D3CMkI43574399
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 May 2025 11:12:23 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36505.realtek.com.tw (172.21.6.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Tue, 13 May 2025 11:12:22 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Tue, 13 May 2025 11:12:21 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622]) by
 RTEXMBS04.realtek.com.tw ([fe80::4c19:b586:6e71:3622%5]) with mapi id
 15.01.2507.035; Tue, 13 May 2025 11:12:21 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH rtw-next v1 05/13] wifi: rtw89: Add hfc_param_ini_usb
Thread-Topic: [PATCH rtw-next v1 05/13] wifi: rtw89: Add hfc_param_ini_usb
Thread-Index: AQHbvTZDNKnS9J5ShUCIArSJPri3ObPP7fyg
Date: Tue, 13 May 2025 03:12:21 +0000
Message-ID: <54b050dc237e46fcb96576e19451ae97@realtek.com>
References: <b146b670-d91c-41a7-96f0-c37945040aea@gmail.com>
 <348b0c94-2db6-4ae9-819c-6fa7f9c3ac56@gmail.com>
In-Reply-To: <348b0c94-2db6-4ae9-819c-6fa7f9c3ac56@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBBZGQg
aGZjX3BhcmFtX2luaV91c2IgdG8gc3RydWN0IHJ0dzg5X2NoaXBfaW5mby4gRm9yIG5vdyBpbml0
aWFsaXNlIGl0DQo+IG9ubHkgZm9yIFJUTDg4NTFCLg0KPiANCj4gU2lnbmVkLW9mZi1ieTogQml0
dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+DQo+IC0tLQ0KDQpbLi4uXQ0K
DQoNCj4gKw0KPiArc3RhdGljIGNvbnN0IHN0cnVjdCBydHc4OV9oZmNfcGFyYW1faW5pIHJ0dzg4
NTFiX2hmY19wYXJhbV9pbmlfdXNiW10gPSB7DQo+ICsgICAgICAgW1JUVzg5X1FUQV9TQ0NdID0g
e3J0dzg4NTFiX2hmY19jaGNmZ191c2IsICZydHc4ODUxYl9oZmNfcHViY2ZnX3VzYiwNCj4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgJnJ0dzg4NTFiX2hmY19wcmVjY2ZnX3VzYiwgUlRXODlf
SENJRkNfU1RGfSwNCg0KW1JUVzg5X1FUQV9XT1ddIGlzIG1pc3NpbmcuIEknbSBub3Qgc3VyZSBp
ZiBjdXJyZW50IGNhbiBoYW5kbGUgdGhpcyBjb3JyZWN0bHkuDQpDb3VsZCB5b3UgdHJ5IHRvIGRv
IFdvV0xBTiB3aXRoIFVTQj8gQXQgbGVhc3QsIGl0IHNob3VsZG4ndCBjcmFzaC4gDQoNCg0KPiAr
ICAgICAgIFtSVFc4OV9RVEFfRExGV10gPSB7TlVMTCwgTlVMTCwNCj4gKyAgICAgICAgICAgICAg
ICAgICAgICAgICAgJnJ0dzg4NTFiX2hmY19wcmVjY2ZnX3VzYiwgUlRXODlfSENJRkNfU1RGfSwN
Cj4gKyAgICAgICBbUlRXODlfUVRBX0lOVkFMSURdID0ge05VTEx9LA0KPiArfTsNCj4gKw0KPiAg
c3RhdGljIGNvbnN0IHN0cnVjdCBydHc4OV9kbGVfbWVtIHJ0dzg4NTFiX2RsZV9tZW1fcGNpZVtd
ID0gew0KPiAgICAgICAgIFtSVFc4OV9RVEFfU0NDXSA9IHtSVFc4OV9RVEFfU0NDLCAmcnR3ODlf
bWFjX3NpemUud2RlX3NpemU2LA0KPiAgICAgICAgICAgICAgICAgICAgICAgICAgICAmcnR3ODlf
bWFjX3NpemUucGxlX3NpemU2LCAmcnR3ODlfbWFjX3NpemUud2RlX3F0NiwNCg0KWy4uLl0NCg0K

