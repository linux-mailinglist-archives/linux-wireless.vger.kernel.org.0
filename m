Return-Path: <linux-wireless+bounces-6911-lists+linux-wireless=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-wireless@lfdr.de
Delivered-To: lists+linux-wireless@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3C0E8B2E8E
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 04:09:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id F3E081C2227A
	for <lists+linux-wireless@lfdr.de>; Fri, 26 Apr 2024 02:09:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7DD1C17CD;
	Fri, 26 Apr 2024 02:09:42 +0000 (UTC)
X-Original-To: linux-wireless@vger.kernel.org
Received: from rtits2.realtek.com.tw (rtits2.realtek.com [211.75.126.72])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 828DF17C2
	for <linux-wireless@vger.kernel.org>; Fri, 26 Apr 2024 02:09:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=211.75.126.72
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714097382; cv=none; b=AqvEsjfh4c5eHbhl+JsCXjL2wqW5602CTOyRtSPbv/CAVaTsNTpJ7waVYFingDPVjUAvlrq9Am7UXW81GevPilxhZjSYLYhKFE69qEttTNuVKMP+SIbTxHncqZvRM1jyrwdsWffX1TqkGPlnPlnKx5UzMjUwQ4HZPv/IGJ2Mh9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714097382; c=relaxed/simple;
	bh=btrUhAg1B2KFCUJ4FNkwOesJVtl1r5hLLyud6HJDj+I=;
	h=From:To:CC:Subject:Date:Message-ID:References:In-Reply-To:
	 Content-Type:MIME-Version; b=Mpdwbt5f45ccJVTscOnxWc3PDfrOZ2dnsnw81NKbizr8Ly3g1XaVChBRbQb9SnD1jOtQ4MIV+mG+ekgsWm7BPdKUP4RJSFLrEOFarEVUvuBU8gZwDoJKjIT5IMF2mU0+fPdnPyvoC52mIWxCNytHMs4ULUwbUPeASWBkVb1yP3M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com; spf=pass smtp.mailfrom=realtek.com; arc=none smtp.client-ip=211.75.126.72
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=realtek.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=realtek.com
X-SpamFilter-By: ArmorX SpamTrap 5.78 with qID 43Q29HXr84166682, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexh36506.realtek.com.tw[172.21.6.27])
	by rtits2.realtek.com.tw (8.15.2/2.95/5.92) with ESMTPS id 43Q29HXr84166682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 26 Apr 2024 10:09:17 +0800
Received: from RTEXMBS03.realtek.com.tw (172.21.6.96) by
 RTEXH36506.realtek.com.tw (172.21.6.27) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 10:09:17 +0800
Received: from RTEXMBS04.realtek.com.tw (172.21.6.97) by
 RTEXMBS03.realtek.com.tw (172.21.6.96) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2507.35; Fri, 26 Apr 2024 10:09:17 +0800
Received: from RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7]) by
 RTEXMBS04.realtek.com.tw ([fe80::1a1:9ae3:e313:52e7%5]) with mapi id
 15.01.2507.035; Fri, 26 Apr 2024 10:09:17 +0800
From: Ping-Ke Shih <pkshih@realtek.com>
To: Bitterblue Smith <rtl8821cerfe2@gmail.com>,
        "linux-wireless@vger.kernel.org" <linux-wireless@vger.kernel.org>
CC: Larry Finger <Larry.Finger@lwfinger.net>,
        Stefan Lippers-Hollmann
	<s.l-h@gmx.de>,
        Christian Hewitt <chewitt@libreelec.tv>
Subject: RE: [PATCH v7 6/6] wifi: rtlwifi: Adjust rtl8192d-common for USB
Thread-Topic: [PATCH v7 6/6] wifi: rtlwifi: Adjust rtl8192d-common for USB
Thread-Index: AQHalzyMlNEj9FbEd02TPt/Yza9eorF5zTsQ
Date: Fri, 26 Apr 2024 02:09:17 +0000
Message-ID: <a30de42d9bd44354a25b9c029d486d84@realtek.com>
References: <72231f87-60fd-4d87-8cf4-ee2967f22dd2@gmail.com>
 <28100330-f421-4b85-b41b-f1045380cef2@gmail.com>
In-Reply-To: <28100330-f421-4b85-b41b-f1045380cef2@gmail.com>
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

Qml0dGVyYmx1ZSBTbWl0aCA8cnRsODgyMWNlcmZlMkBnbWFpbC5jb20+IHdyb3RlOg0KPiANCj4g
QSBmZXcgb2YgdGhlIHNoYXJlZCBmdW5jdGlvbnMgbmVlZCBzbWFsbCBjaGFuZ2VzIGZvciB0aGUg
VVNCIGRyaXZlcjoNCj4gIC0gZmlybXdhcmUgbG9hZGluZw0KPiAgLSBlZnVzZSByZWFkaW5nDQo+
ICAtIHJhdGUgbWFzayB1cGRhdGluZw0KPiAgLSByZiByZWdpc3RlciByZWFkaW5nDQo+ICAtIGlu
aXRpYWwgZ2FpbiBmb3Igc2Nhbm5pbmcNCj4gDQo+IEFsc28sIGFkZCBhIGZldyBtYWNyb3MgdG8g
d2lmaS5oIGFuZCBpbml0aWFsaXNlIHJ0bGhhbC5pbnRlcmZhY2VpbmRleA0KPiBmb3IgVVNCIGRl
dmljZXMuDQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBCaXR0ZXJibHVlIFNtaXRoIDxydGw4ODIxY2Vy
ZmUyQGdtYWlsLmNvbT4NCg0KQWNrZWQtYnk6IFBpbmctS2UgU2hpaCA8cGtzaGloQHJlYWx0ZWsu
Y29tPg0KDQpTaW5jZSBJIGRvbid0IGhhdmUgYSBoYXJkd2FyZSwgcGxlYXNlIGhlbHAgdG8gdGVz
dCB0aGVzZSBwYXRjaGVzLiBJIHdpbGwgd2FpdA0KZm9yIGEgY291cGxlIGRheXMgdG8gc2VlIGlm
IHNvbWVvbmUgaGFzIGNvbW1lbnRzIG9uIHRoaXMgcGF0Y2hzZXQuIElmIG5vdCwgSQ0Kd2lsbCBw
aWNrIHRoZW0gdG8gbXkgdHJlZS4NCg0KDQo=

