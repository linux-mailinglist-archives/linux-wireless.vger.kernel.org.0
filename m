Return-Path: <linux-wireless+bounces-14198-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5E5609A3535
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 08:16:21 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 03A611F214A2
	for <lists+linux-wireless@lfdr.de>; Fri, 18 Oct 2024 06:16:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F7F5161320;
	Fri, 18 Oct 2024 06:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b="gf4s+vwy"
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D9C15C144
	for <linux-wireless@vger.kernel.org>; Fri, 18 Oct 2024 06:16:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729232177; cv=none; b=nKp0mp6nd9fOEpuv/Ymn+BXD+JXwiGXJpDiGKuqbVpZtJwYDXS9+jqYlGy2ozZngi8u9V81HYXtlgWt90eXFg0HuJNspbLakGATd3OJxVfKK7VpgU0DOTnRJIesLipoh0xtcXGmOkdw3/3r/uqwcHzMvBKLWb4zdQFA1CltNjRI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729232177; c=relaxed/simple;
	bh=g9Z+Ib8xZYvuiH30n7DJzDP8obIPo4ipid4pv17jVYc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=r71bvYOrlw2LjdSrmQL/FgLPGv3ndKeiX3xYjTg0HN5EpKgYbKUMVfDIRLpRZlykc91pAO3wBGrfTK+3n0yp9spxuMkRZk9oTkyvMsXrb4RotFCqi9VeJdCIYKfJoRcDgZOFoWHNLHLmLK5NosARkasZf6yZsTcdTeZxN3hd9Ss=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; dkim=temperror (0-bit key) header.d=realtek.com header.i=@realtek.com header.b=gf4s+vwy; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 49I6GALB01609910, This message is accepted by code: ctloc85258
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=realtek.com; s=dkim;
	t=1729232170; bh=g9Z+Ib8xZYvuiH30n7DJzDP8obIPo4ipid4pv17jVYc=;
	h=From:To:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:Content-Transfer-Encoding:MIME-Version;
	b=gf4s+vwyOJlISY/6E6+LXDof1hKshuipEKG+hE0RFY3ljhLRaLg0o2Gf4b4c12hqX
	 y/w0pm6P0V9prvCxTj1vZwSQjt1+2Mkfxic1Qon0fIohdEaBOWgclgAsvSLuKDUdhA
	 PJFupB6+jnhDab3hBMNdUy6Za2w0+7as3T8zfwG+HtGcmtGCCWNuB13ApioHGt047m
	 b+KS+lRYSuWQ0gJfEEzXuWdpS3apv6qkrd7Em8TvmjN0F3+9bdICzusavMCDG9Vbb9
	 yupYRmc5uoXYgutFvUp//BS/212cqctFe54+o3e4ZTpdOsnlg49XeY8ag552NUJRRT
	 5eqh5uI9+0PXg==
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/3.06/5.92) with ESMTPS id 49I6GALB01609910
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Oct 2024 14:16:10 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.39; Fri, 18 Oct 2024 14:16:11 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 18 Oct 2024 14:16:11 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f]) by
 RTEXMBS04.realtek.com.tw ([fe80::2882:4142:db9:db1f%11]) with mapi id
 15.01.2507.035; Fri, 18 Oct 2024 14:16:11 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
Subject: RE: [PATCH v2 04/22] wifi: rtw88: Extend the init table parsing for RTL8812AU
Thread-Topic: [PATCH v2 04/22] wifi: rtw88: Extend the init table parsing for
 RTL8812AU
Thread-Index: AQHbHB7ejKucJ2Rm5kGaYkrurTJcPrKMEabg
Date: Fri, 18 Oct 2024 06:16:10 +0000
Message-ID: <67d7b9415d5642ba8a37b4bd46881de2@realtek.com>
References: <d2870a44-9b91-4090-9a25-873eb62997f5@gmail.com>
 <25058b20-8001-4ebd-bd9b-932dff9710d0@gmail.com>
In-Reply-To: <25058b20-8001-4ebd-bd9b-932dff9710d0@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiBAQCAt
MTA4MCw4ICsxMTAzLDI4IEBAIHN0YXRpYyBib29sIGNoZWNrX3Bvc2l0aXZlKHN0cnVjdCBydHdf
ZGV2ICpydHdkZXYsIHN0cnVjdCBydHdfcGh5X2NvbmQgY29uZCkNCj4gICAgICAgICBpZiAoY29u
ZC5pbnRmICYmIGNvbmQuaW50ZiAhPSBkcnZfY29uZC5pbnRmKQ0KPiAgICAgICAgICAgICAgICAg
cmV0dXJuIGZhbHNlOw0KPiANCj4gLSAgICAgICBpZiAoY29uZC5yZmUgIT0gZHJ2X2NvbmQucmZl
KQ0KPiAtICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiArICAgICAgIGlmIChydHdkZXYt
PmNoaXAtPmlkID09IFJUV19DSElQX1RZUEVfODgxMkEgfHwNCj4gKyAgICAgICAgICAgcnR3ZGV2
LT5jaGlwLT5pZCA9PSBSVFdfQ0hJUF9UWVBFXzg4MjFBKSB7DQo+ICsgICAgICAgICAgICAgICBp
ZiAoY29uZC5yZmUgJiAweDBmKSB7DQoNCmlmICghKGNvbmQucmZlICYgMHgwZikpDQogICAgcmV0
dXJuIHRydWU7DQoNClRoZW4gd2UgY2FuIHJlZHVjZSBvbmUgaW5kZW50YXRpb24gbGV2ZWwuICAN
Cg0KPiArICAgICAgICAgICAgICAgICAgICAgICBpZiAoKGNvbmQucmZlICYgZHJ2X2NvbmQucmZl
KSAhPSBjb25kLnJmZSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICByZXR1cm4g
ZmFsc2U7DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKChjb25kLnJmZSAmIEJJ
VCgwKSkgJiYgY29uZDIudHlwZV9nbG5hICE9IGRydl9jb25kMi50eXBlX2dsbmEpDQo+ICsgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiArDQo+ICsgICAgICAg
ICAgICAgICAgICAgICAgIGlmICgoY29uZC5yZmUgJiBCSVQoMSkpICYmIGNvbmQyLnR5cGVfZ3Bh
ICE9IGRydl9jb25kMi50eXBlX2dwYSkNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICByZXR1cm4gZmFsc2U7DQo+ICsNCj4gKyAgICAgICAgICAgICAgICAgICAgICAgaWYgKChjb25k
LnJmZSAmIEJJVCgyKSkgJiYgY29uZDIudHlwZV9hbG5hICE9IGRydl9jb25kMi50eXBlX2FsbmEp
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgcmV0dXJuIGZhbHNlOw0KPiArDQo+
ICsgICAgICAgICAgICAgICAgICAgICAgIGlmICgoY29uZC5yZmUgJiBCSVQoMykpICYmIGNvbmQy
LnR5cGVfYXBhICE9IGRydl9jb25kMi50eXBlX2FwYSkNCj4gKyAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICByZXR1cm4gZmFsc2U7DQo+ICsgICAgICAgICAgICAgICB9DQo+ICsgICAgICAg
fSBlbHNlIHsNCj4gKyAgICAgICAgICAgICAgIGlmIChjb25kLnJmZSAhPSBkcnZfY29uZC5yZmUp
DQo+ICsgICAgICAgICAgICAgICAgICAgICAgIHJldHVybiBmYWxzZTsNCj4gKyAgICAgICB9DQo+
IA0KPiAgICAgICAgIHJldHVybiB0cnVlOw0KPiAgfQ0KDQoNCg0K

